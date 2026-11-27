"""Tests for run.py's can_use_tool decisions, with the persona model stubbed (spec 001 T097).

Needs the harness environment (claude-agent-sdk); skipped without it:
cd evals/persona && uv run --frozen python -m unittest test_run -v
"""

import argparse
import asyncio
import json
import shutil
import sys
import tempfile
import unittest
from pathlib import Path

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE))

try:
    import run
    from claude_agent_sdk import AssistantMessage, PermissionResultAllow, PermissionResultDeny, ResultMessage, TextBlock
except ImportError:  # plain python3 without the harness environment
    run = None

FIXTURE = json.loads((HERE.parents[1] / "evals" / "fixtures" / "fashion-1-loyalty.json").read_text(encoding="utf-8"))
OFFER = {"question": "Làm tiếp?", "header": "Tiếp", "multiSelect": False,
         "options": [{"label": "Hỏi tiếp (Đề xuất)"}, {"label": "Tạm dừng"}, {"label": "Xuất bản nháp"}]}


def q(text):
    return {"question": text, "header": "H", "multiSelect": False, "options": [{"label": "A (Đề xuất)"}, {"label": "B"}]}


@unittest.skipIf(run is None, "needs the harness environment (uv run)")
class CanUseTool(unittest.TestCase):
    def setUp(self):
        self.ws = Path(tempfile.mkdtemp())
        self.addCleanup(shutil.rmtree, self.ws, True)
        args = argparse.Namespace(plugin=self.ws / "plugin", max_cost=10.0, persona_model="x", model="x",
                                  session_cost=3.0, max_turns=5, max_plain_turns=6)
        self.run_ = run.Run(fixture=FIXTURE, workspace=self.ws, args=args)
        self.replies = []
        self.calls = 0
        self.budgets = []

        async def fake_ask(prompt, system, model, budget):
            self.calls += 1
            self.budgets.append(budget)
            if self.replies and isinstance(self.replies[0], Exception):
                raise self.replies.pop(0)
            return (self.replies.pop(0) if self.replies else None), 0.01

        original, run._ask_model = run._ask_model, fake_ask
        self.addCleanup(setattr, run, "_ask_model", original)
        self.decide = run.make_can_use_tool(self.run_)

    def call(self, name, tool_input):
        return asyncio.run(self.decide(name, tool_input, None))

    def test_shell_is_denied_and_workspace_write_allowed(self):
        self.assertIsInstance(self.call("Bash", {"command": "ls"}), PermissionResultDeny)
        self.assertIsInstance(self.call("Write", {"file_path": str(self.ws / "a.md")}), PermissionResultAllow)

    def test_budget_offer_follows_the_recommendation_without_the_persona(self):
        res = self.call("AskUserQuestion", {"questions": [OFFER]})
        self.assertEqual(res.updated_input["answers"], {"Làm tiếp?": "Hỏi tiếp (Đề xuất)"})
        self.assertEqual((self.run_.budget_hits, self.run_.paused, self.calls), (1, False, 0))

    def test_answers_the_persona_left_out_are_skips(self):
        self.replies = [{"answers": [{"choice": "A (Đề xuất)", "text": None}]}]
        res = self.call("AskUserQuestion", {"questions": [q("Một?"), q("Hai?")]})
        self.assertEqual(res.updated_input["answers"], {"Một?": "A (Đề xuất)"})
        self.assertEqual((self.run_.questions_answered, self.run_.questions_skipped), (1, 1))

    def test_malformed_persona_reply_skips_the_round(self):
        self.replies = [None]
        res = self.call("AskUserQuestion", {"questions": [q("Một?"), q("Hai?")]})
        self.assertEqual(res.updated_input["answers"], {})
        self.assertEqual((self.run_.questions_skipped, self.run_.persona_errors), (2, 1))
        self.assertAlmostEqual(self.run_.cost_persona, 0.01)  # the failed call still counts

    def test_cost_cap_inside_a_turn_ends_the_session(self):
        self.run_.cost_agent, self.run_.live_session_cost = 7.0, 3.0
        res = self.call("AskUserQuestion", {"questions": [q("Một?")]})
        self.assertIsInstance(res, PermissionResultDeny)
        self.assertTrue(res.interrupt)
        self.assertEqual(self.calls, 0)

    def test_confine_hook_denies_outside_paths_and_lets_the_rest_through(self):
        confine = run.make_confine(self.run_)

        def hook(name, tool_input):
            return asyncio.run(confine({"tool_name": name, "tool_input": tool_input}, "t", None))

        denied = hook("Read", {"file_path": "/etc/hosts"})
        self.assertEqual(denied["hookSpecificOutput"]["permissionDecision"], "deny")
        for pattern in ("/etc/*", "/*", "/[e]tc/hosts"):
            self.assertEqual(hook("Glob", {"pattern": pattern})["hookSpecificOutput"]["permissionDecision"], "deny")
        self.assertEqual(hook("Glob", {"pattern": "specs/**/*.md"}), {})
        self.assertEqual(hook("Bash", {"command": "ls"})["hookSpecificOutput"]["permissionDecision"], "deny")
        self.assertEqual(hook("Read", {"file_path": str(self.ws / "a.md")}), {})
        self.assertEqual(hook("AskUserQuestion", {"questions": []}), {})

    def test_persona_is_funded_only_from_what_the_agent_allowance_leaves(self):
        self.run_.cost_agent, self.run_.session_allowance, self.run_.live_session_cost = 6.0, 3.0, 0.4
        self.replies = [{"answers": [{"choice": "A (Đề xuất)", "text": None}]}]
        self.call("AskUserQuestion", {"questions": [q("Một?")]})
        self.assertEqual(self.budgets, [1.0])
        self.run_.cost_agent = 7.0  # the allowance takes the rest: no persona call
        self.assertIsInstance(self.call("AskUserQuestion", {"questions": [q("Hai?")]}), PermissionResultDeny)
        self.assertEqual(self.calls, 1)

    def test_session_error_keeps_the_cost_already_reported(self):
        result = ResultMessage(subtype="success", duration_ms=1, duration_api_ms=1, is_error=False,
                               num_turns=1, session_id="s", total_cost_usd=0.8)
        test = self

        class FakeClient:
            def __init__(self, options):
                test.options = options

            async def __aenter__(self):
                return self

            async def __aexit__(self, *exc):
                return False

            async def query(self, prompt):
                pass

            async def receive_response(self):
                yield AssistantMessage(content=[TextBlock(text="Anh/chị muốn gì?")], model="x")
                yield result

        original, run.ClaudeSDKClient = run.ClaudeSDKClient, FakeClient
        self.addCleanup(setattr, run, "ClaudeSDKClient", original)
        self.replies = [RuntimeError("persona down")]
        with self.assertRaises(RuntimeError):
            asyncio.run(run.run_session(self.run_, 1))
        self.assertAlmostEqual(self.run_.cost_agent, 0.8)
        self.assertEqual((self.run_.live_session_cost, self.run_.session_allowance), (0.0, 0.0))
        self.assertEqual(self.run_.sessions[0]["cost_usd"], 0.8)
        self.assertIn("persona down", self.run_.sessions[0]["error"])
        self.assertEqual(self.options.tools, run.AGENT_TOOLS + ["AskUserQuestion"])
        self.assertIn("PreToolUse", self.options.hooks)
        self.assertEqual(self.options.max_budget_usd, 3.0)

    def test_ready_idea_ends_the_session(self):
        shutil.copytree(HERE / "canned" / "ready" / "specs", self.ws / "specs")
        res = self.call("AskUserQuestion", {"questions": [q("Một?")]})
        self.assertIsInstance(res, PermissionResultDeny)
        self.assertTrue(self.run_.stopped_ready)


if __name__ == "__main__":
    unittest.main()
