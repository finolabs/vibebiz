"""Suite 8 harness: simulated-persona sessions against the built plugin (spec 001 T097).

Development tooling, never shipped. Runs `/vibebiz:idea` with a fixture's intake in a
fresh temporary workspace, answers every `AskUserQuestion` through `can_use_tool` with
a persona model that knows only the fixture's hidden facts and answers, and gives a
plain-text question the same treatment as the next user turn. Sessions run back to back
(`/vibebiz:continue` from the second) until `coverage.md` meets the readiness rule or the
session limit passes, then scores the workspace (score.py), writes JSON under
`evals/results/` and prints one summary line.

    cd evals/persona && uv run python run.py ../fixtures/fashion-1-loyalty.json

Heavy job: run it through the machine's heavy-job lock, one at a time.
"""

from __future__ import annotations

import argparse
import asyncio
import json
import re
import shutil
import subprocess
import sys
import tempfile
import time
from dataclasses import dataclass, field
from pathlib import Path

from claude_agent_sdk import (
    AssistantMessage,
    ClaudeAgentOptions,
    ClaudeSDKClient,
    HookMatcher,
    PermissionResultAllow,
    PermissionResultDeny,
    ResultMessage,
    TextBlock,
    query,
)

import score
import turns

HERE = Path(__file__).resolve().parent
REPO = HERE.parents[1]
DIST = REPO / "dist" / "vibebiz"
RESULTS = REPO / "evals" / "results"
SKILLS = [f"vibebiz:{n}" for n in ("idea", "continue", "status", "package", "constitution", "help")]
AGENT_TOOLS = ["Read", "Write", "Edit", "Glob", "Grep", "Skill"]  # no Bash: suite 8 never packages
MIN_SESSION_USD = 0.05  # below this much budget left, no new session starts
MIN_CALL_USD = 0.01  # below this much budget left, no persona or judge call starts
PERSONA_RESERVE_USD = 0.5  # held back from each session's agent allowance for the persona's calls

PERSONA_SYSTEM = """You play one user of a business-idea interviewer, in a test. Stay in character.

Character: {persona}. Company (fictional): {company}. You are impatient and not technical: short answers, everyday Vietnamese, no jargon. You say "tao" for yourself and "mày" for the interviewer, as in your answers below.

You know ONLY these facts and these prepared answers. Never invent a number, a name or a fact beyond them.
- When a question touches a topic your facts or prepared answers cover, give that answer. Pick an option only when it says the same thing; otherwise answer in your own words with the prepared answer (with its number, deadline or name). Never pick an option that defers to someone else, to a later measurement or to a guess when your facts already answer it.
- A question about a figure (how many, how often, how much, what share), today or in the past, gets your figure when your facts hold it. Never pick an option that hands it to someone else, to a measurement or to a report when you already know the figure.
- A question about money you would spend (a budget, a fee, a price ceiling, per month or per year) is your budget topic: answer with your budget, converted to the question's period only if your facts allow it.
- When a question asks for something not covered, use the "default" answer, or pick the option that the interviewer marks as recommended (usually the first).

Hidden facts:
{facts}

Prepared answers by topic:
{answers}

Reply with JSON only, no prose around it."""

ROUND_TASK = """The interviewer asks this round of questions (JSON):
{questions}

For each question, in order, return one entry: {{"choice": "<an option label copied exactly, or several joined with ', ' when multiSelect>", "text": null}} when an option says what your facts say, or when your facts do not cover the question; {{"choice": null, "text": "<your own short words>"}} when your facts answer the question and no option says the same (for example an exact number, a deadline or who decides); {{"choice": null, "text": null}} to skip. Output: {{"answers": [ ... ]}}"""

PLAIN_TASK = """The interviewer wrote this message:
---
{message}
---
Reply in character, briefly. If it asks you something, answer from your facts. If it stops without a question while your idea is not finished, you want to get it done: tell it to go on, and add any fact you know that it says is missing. Output: {{"text": "<your reply>"}}"""

JUDGE_PROMPT = """You check whether a requirement document preserves each fact. A fact is preserved when the document states the same thing, in any wording or language; it is not preserved when it is missing, contradicted or only vaguely hinted at.

Document:
---
{spec}
---
Facts (JSON): {facts}

Output JSON only: {{"<fact id>": true|false, ...}}"""


@dataclass
class Run:
    fixture: dict
    workspace: Path
    args: argparse.Namespace
    cost_agent: float = 0.0
    cost_persona: float = 0.0
    cost_judge: float = 0.0
    budget_hits: int = 0
    questions_answered: int = 0
    questions_skipped: int = 0
    plain_replies: int = 0
    persona_errors: int = 0
    judge_error: str | None = None
    live_session_cost: float = 0.0  # running total of the session in progress
    session_allowance: float = 0.0  # the agent budget of the session in progress, committed until it ends
    paused: bool = False
    stopped_ready: bool = False
    sessions: list = field(default_factory=list)
    transcript: list = field(default_factory=list)

    @property
    def cost(self) -> float:
        return self.cost_agent + self.cost_persona + self.cost_judge

    def spent(self) -> float:
        """Everything spent so far, the session in progress and persona calls inside it included."""
        return self.cost + self.live_session_cost

    def call_budget(self) -> float:
        """What a persona or judge call may spend: the cap minus everything spent and the agent's allowance."""
        return self.args.max_cost - self.cost - max(self.live_session_cost, self.session_allowance)

    def ready(self) -> bool:
        idea = score.find_idea(self.workspace)
        return bool(idea and (idea / "coverage.md").exists()
                    and score.readiness(idea / "coverage.md", bool(self.fixture.get("involves_ai")))[0])


def _json_from(text: str) -> dict | None:
    """The JSON object in a model reply, or None when there is none or it does not parse."""
    start, end = text.find("{"), text.rfind("}")
    if start < 0 or end < start:
        return None
    try:
        value = json.loads(text[start : end + 1])
    except ValueError:
        return None
    return value if isinstance(value, dict) else None


async def _ask_model(prompt: str, system: str | None, model: str, budget: float) -> tuple[dict | None, float]:
    """One tool-less, settings-free turn capped at `budget` USD; returns its JSON object (None when malformed) and its cost."""
    opts = ClaudeAgentOptions(model=model, system_prompt=system, tools=[], max_turns=1, setting_sources=[],
                              max_budget_usd=budget)
    text, cost = "", 0.0
    async for msg in query(prompt=prompt, options=opts):
        if isinstance(msg, AssistantMessage):
            text += "".join(b.text for b in msg.content if isinstance(b, TextBlock))
        elif isinstance(msg, ResultMessage):
            cost = msg.total_cost_usd or 0.0
    return _json_from(text), cost


def _persona_system(fx: dict) -> str:
    return PERSONA_SYSTEM.format(
        persona=fx["persona"],
        company=fx["fictional_company"],
        facts="\n".join(f"- {f['fact']}" for f in fx["key_facts"]),
        answers="\n".join(f"- {a['topic']}: {a['answer_vi']}" for a in fx["answers"]),
    )


def make_confine(run: Run):
    """PreToolUse hook: every tool call the agent makes passes the workspace rule, auto-approved ones included."""
    async def confine(input_data, _tool_use_id, _ctx):
        name, tool_input = input_data.get("tool_name", ""), input_data.get("tool_input") or {}
        if name == "AskUserQuestion" or turns.tool_allowed(name, tool_input, run.workspace, run.args.plugin or DIST):
            return {}  # no decision: the normal permission flow (and can_use_tool) goes on
        return {"hookSpecificOutput": {"hookEventName": "PreToolUse", "permissionDecision": "deny",
                                       "permissionDecisionReason": f"{name} on that path is not available in this test."}}

    return confine


def make_can_use_tool(run: Run):
    async def can_use_tool(name: str, tool_input: dict, _ctx):
        if name != "AskUserQuestion":
            if turns.tool_allowed(name, tool_input, run.workspace, run.args.plugin or DIST):
                return PermissionResultAllow(updated_input=tool_input)
            return PermissionResultDeny(message=f"{name} on that path is not available in this test.")
        if run.ready():
            run.stopped_ready = True
            return PermissionResultDeny(message="Test ended: the idea is ready.", interrupt=True)
        if run.call_budget() < MIN_CALL_USD:
            return PermissionResultDeny(message="Test ended: the run's cost cap is reached.", interrupt=True)
        questions = tool_input.get("questions") or []
        answers: dict[str, str] = {}
        to_persona = []
        for q in questions:
            labels = [o.get("label", "") for o in q.get("options") or []]
            offer = turns.budget_offer_choice(labels)
            if offer:  # deterministic: follow vibebiz's recommendation (Fio, 27/11/2026)
                run.budget_hits += 1
                run.paused = run.paused or offer[1]
                answers[q["question"]] = offer[0]
            else:
                to_persona.append(q)
        if to_persona:
            reply, cost = await _ask_model(
                ROUND_TASK.format(questions=json.dumps(to_persona, ensure_ascii=False)),
                _persona_system(run.fixture), run.args.persona_model, run.call_budget())
            run.cost_persona += cost
            if reply is None:
                run.persona_errors += 1
            given = reply.get("answers") if reply and isinstance(reply.get("answers"), list) else []
            for i, q in enumerate(to_persona):  # a missing or malformed entry is a skip
                a = given[i] if i < len(given) and isinstance(given[i], dict) else {}
                value = a.get("choice") or a.get("text")
                if isinstance(value, str) and value.strip():
                    answers[q["question"]] = value
                    run.questions_answered += 1
                else:
                    run.questions_skipped += 1
        run.transcript.append({"questions": questions, "answers": answers})
        return PermissionResultAllow(updated_input={**tool_input, "answers": answers})

    return can_use_tool


async def run_session(run: Run, number: int) -> dict:
    prompt = f"/vibebiz:idea {run.fixture['intake_vi']}" if number == 1 else "/vibebiz:continue"
    run.paused = False
    left = run.args.max_cost - run.cost
    run.session_allowance = min(run.args.session_cost, left - min(PERSONA_RESERVE_USD, left / 4))
    opts = ClaudeAgentOptions(
        cwd=str(run.workspace),
        plugins=[{"type": "local", "path": str(run.args.plugin or DIST)}],
        setting_sources=[],
        skills=SKILLS,
        tools=AGENT_TOOLS + ["AskUserQuestion"],  # the only tools the agent sees
        allowed_tools=[],
        disallowed_tools=["WebFetch", "WebSearch", "Agent", "Task"],
        hooks={"PreToolUse": [HookMatcher(matcher=None, hooks=[make_confine(run)])]},
        model=run.args.model,
        max_turns=run.args.max_turns,
        max_budget_usd=run.session_allowance,
        can_use_tool=make_can_use_tool(run),
    )
    session_cost, plain, nudges, last_result, error, capped = 0.0, 0, 0, None, None, None
    try:
        async with ClaudeSDKClient(options=opts) as client:
            await client.query(prompt)
            while True:
                text = ""
                async for msg in client.receive_response():
                    if isinstance(msg, AssistantMessage):
                        text = "".join(b.text for b in msg.content if isinstance(b, TextBlock)) or text
                    elif isinstance(msg, ResultMessage):
                        session_cost = msg.total_cost_usd or session_cost  # running total for the session
                        run.live_session_cost = session_cost
                        last_result = msg.subtype
                        if msg.subtype in turns.SESSION_CAPS:
                            capped = msg.subtype  # the session cap ends this session, not the run
                        elif msg.is_error:
                            error = (msg.result or text or msg.subtype)[:300]
                run.transcript.append({"session": number, "assistant": text[-2000:]})
                action = turns.next_turn(
                    text, error=bool(error) or run.call_budget() < MIN_CALL_USD,
                    ready=run.stopped_ready or run.ready(), paused=run.paused,
                    finished=last_result == "success", replies=plain, nudges=nudges,
                    max_replies=run.args.max_plain_turns)
                if action == "end":
                    break
                if action == "nudge":
                    nudges += 1
                else:
                    plain += 1
                reply, cost = await _ask_model(PLAIN_TASK.format(message=text[-3000:]),
                                               _persona_system(run.fixture), run.args.persona_model,
                                               run.call_budget())
                run.cost_persona += cost
                text_reply = reply.get("text") if reply else None
                if not (isinstance(text_reply, str) and text_reply.strip()):
                    run.persona_errors += reply is None
                    run.questions_skipped += 1  # the persona did not answer: the session ends here
                    break
                run.plain_replies += 1
                run.transcript.append({"session": number, "user": text_reply})
                if run.spent() >= run.args.max_cost:  # the persona's reply used the last of the budget
                    break
                await client.query(text_reply)
    except Exception as exc:  # keep what the session spent, then let the run report the error
        error = f"{type(exc).__name__}: {exc}"[:300]
        raise
    finally:
        run.cost_agent += session_cost  # the last reported running total: a turn cut off mid-way is not counted
        run.live_session_cost = run.session_allowance = 0.0
        info = {"session": number, "prompt": prompt, "cost_usd": round(session_cost, 4),
                "result": last_result, "error": error, "capped": capped, "plain_replies": plain, "nudges": nudges,
                "paused_at_budget": run.paused, "ready_after": run.ready()}
        run.sessions.append(info)
    return info


async def judge(run: Run, spec_text: str, facts: list[dict]) -> dict:
    verdicts, cost = await _ask_model(
        JUDGE_PROMPT.format(spec=spec_text, facts=json.dumps(facts, ensure_ascii=False)),
        None, run.args.judge_model, run.call_budget())
    run.cost_judge += cost
    if verdicts is None:
        run.judge_error = "judge reply was not a JSON object"
    return verdicts or {}


async def main_async(args) -> int:
    fixture_path = Path(args.fixture).resolve()
    fixture = json.loads(fixture_path.read_text(encoding="utf-8"))
    if not re.fullmatch(r"[a-z0-9-]+", str(fixture.get("id", ""))):
        raise SystemExit("fixture id must match [a-z0-9-]+")
    if not args.no_build and not args.plugin:  # a plugin given by path is built where it lives
        subprocess.run([sys.executable, str(REPO / "scripts" / "build_plugin.py")], check=True, cwd=REPO)
    workspace = Path(tempfile.mkdtemp(prefix=f"vibebiz-persona-{fixture['id']}-"))
    run = Run(fixture=fixture, workspace=workspace, args=args)
    started = time.time()
    stop_reason, crash, verdicts = "session limit", None, {}
    RESULTS.mkdir(parents=True, exist_ok=True)
    path = RESULTS / f"persona-{fixture['id']}-{time.strftime('%Y%m%d-%H%M%S')}.json"
    try:
        for n in range(1, args.max_sessions + 1):
            if args.max_cost - run.cost < MIN_SESSION_USD:
                stop_reason = "cost cap"
                break
            info = await run_session(run, n)
            print(f"session {n}: {info}", file=sys.stderr)
            if run.ready():
                stop_reason = "ready"
                break
            if info["error"] or (info["cost_usd"] == 0 and n == 1):
                stop_reason = f"agent error: {info['error'] or 'no model call in session 1'}"
                break
            if run.cost >= args.max_cost:
                stop_reason = "cost cap"
                break
        idea = score.find_idea(workspace)
        spec_path = idea / "spec.md" if idea else None
        semantic = [f for f in fixture["key_facts"] if not score.quantities(f["fact"])]
        if args.no_judge or run.call_budget() < MIN_CALL_USD:
            run.judge_error = None if args.no_judge else "skipped: cost cap reached"
        elif semantic and spec_path and spec_path.exists():
            verdicts = await judge(run, spec_path.read_text(encoding="utf-8"), semantic)
    except Exception as exc:  # a harness error still writes what the run has
        crash = f"{type(exc).__name__}: {exc}"[:300]
        stop_reason = f"harness error: {crash}"
    finally:
        result = score.score_workspace(workspace, fixture, judge=(lambda *_: verdicts) if verdicts else None)
        ready_session = next((s["session"] for s in run.sessions if s["ready_after"]), None)
        facts = result["facts"]
        out = {
            "suite": 8, "fixture": fixture["id"], "date": time.strftime("%Y-%m-%d"),
            "plugin": str(args.plugin or DIST), "model": args.model, "persona_model": args.persona_model,
            "judge_model": None if args.no_judge else args.judge_model,
            "stop_reason": stop_reason, "sessions_run": len(run.sessions),
            "sessions_to_readiness": ready_session, "budget_hits": run.budget_hits,
            "questions_answered": run.questions_answered, "questions_skipped": run.questions_skipped,
            "plain_replies": run.plain_replies, "persona_errors": run.persona_errors,
            "judge_error": run.judge_error, "idea": result["idea"], "ready": result["ready"],
            "unmet": result["unmet"], "facts": facts,
            "cost_usd": {"agent": round(run.cost_agent, 4), "persona": round(run.cost_persona, 4),
                         "judge": round(run.cost_judge, 4), "total": round(run.cost, 4)},
            "seconds": round(time.time() - started), "sessions": run.sessions,
            "pass": bool(ready_session and ready_session <= 4 and facts["unscored"] == 0
                         and (facts["share"] or 0) >= 0.85),
            "transcript": run.transcript,
        }
        path.write_text(json.dumps(out, ensure_ascii=False, indent=2), encoding="utf-8")
        if (workspace / "specs").exists():  # keep the idea folder beside the JSON (git-ignored)
            shutil.copytree(workspace / "specs", path.with_suffix(""), dirs_exist_ok=True)
        if args.keep_workspace:
            print(f"workspace kept: {workspace}", file=sys.stderr)
        else:
            shutil.rmtree(workspace, ignore_errors=True)
        share = "n/a" if facts["share"] is None else f"{facts['share']:.0%}"
        print(f"suite8 {fixture['id']}: {'PASS' if out['pass'] else 'FAIL'} "
              f"ready_session={ready_session} sessions={len(run.sessions)} budget_hits={run.budget_hits} "
              f"facts={facts['preserved']}/{facts['scored']} ({share}, {facts['unscored']} unscored) "
              f"cost=${run.cost:.2f} stop={stop_reason} -> {path.relative_to(REPO)}")
    return 1 if crash else 0


def main() -> int:
    p = argparse.ArgumentParser(description=__doc__.split("\n\n")[0])
    p.add_argument("fixture", help="evals/fixtures/<id>.json")
    p.add_argument("--model", default="sonnet", help="agent under test")
    p.add_argument("--persona-model", default="sonnet")
    p.add_argument("--judge-model", default="sonnet")
    p.add_argument("--max-sessions", type=int, default=4)
    p.add_argument("--max-turns", type=int, default=80, help="agent turns per session")
    p.add_argument("--max-plain-turns", type=int, default=6, help="plain-text replies per session")
    p.add_argument("--session-cost", type=float, default=3.0, help="USD cap per agent session")
    p.add_argument("--max-cost", type=float, default=10.0, help="USD cap for the whole run")
    p.add_argument("--no-judge", action="store_true", help="leave facts without numbers unscored")
    p.add_argument("--no-build", action="store_true")
    p.add_argument("--plugin", type=Path, help="built plugin folder to test instead of this repository's dist/vibebiz")
    p.add_argument("--keep-workspace", action="store_true")
    return asyncio.run(main_async(p.parse_args()))


if __name__ == "__main__":
    sys.exit(main())
