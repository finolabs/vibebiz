"""Question-round rules check (T024, spec Appendix B, FR-008..FR-011, FR-013).

Development tooling only; Python 3.10+ standard library. Plugin evals have no
custom-code graders, so this runs as a script over what a case produced:

    python3 scripts/checks/round_rules.py WORKSPACE --rounds ROUNDS.json [--idea SLUG]
    python3 scripts/checks/round_rules.py WORKSPACE --trace TRACE.jsonl  [--idea SLUG]

WORKSPACE is the folder a case produced (it holds ``specs/NNN-<slug>/``).
``--idea`` names the idea folder (the slug or the full folder name); it may be
left out when the workspace holds exactly one idea.

Input format, ``rounds.json`` (the record of the questions asked)::

    {"rounds": [
      {"date": "2026-11-12",
       "questions": [
         {"question": "Text shown to the user",
          "options": [{"label": "A (Recommended)", "description": "..."}, ...],
          "multiSelect": false,
          "category": "C",              # optional: coverage category the question fills
          "status_before": "missing",   # needed with "category" for the skip rule
          "skipped": false}             # true when the user pressed Skip
       ],
       "offer": ["continue", "pause", "draft"]}   # what vibebiz offered after the round
    ]}

``options`` may also be plain strings. ``--trace`` builds the same structure
from a Claude Code session trace (JSON lines): every ``AskUserQuestion``
tool call becomes one round (date = ``--date`` or today). A trace carries no
skip, category or offer data (a question missing the ``skipped`` key may be
recorded either as answered or as skipped), so only the structure and write-back rules can
be checked from it; the skip and offer rules need ``rounds.json``.

Rules checked (each problem is one line; no problems = valid):

1. at most four questions per round;
2. two to four options per question;
3. the recommended option is first, and only the first carries the marker
   ("Recommended", "Khuyến nghị", "Đề xuất");
4. no "None" / "Other" style option;
5. a skipped question leaves its category status unchanged (the coverage
   record equals ``status_before``) and is never written as an answer;
6. a round in which every question was skipped offers both pause and draft;
7. write-back after each round: ``spec.md`` Clarifications holds a
   ``### Session <date>`` with one ``- Q: ... → A: ...`` per answered question
   and one ``- Skipped: ...`` per skipped one, and ``coverage.md`` has a
   non-empty ``next_step`` and ``budget_rounds_used`` at least the number of
   rounds recorded.
"""

from __future__ import annotations

import argparse
import datetime
import json
import re
import sys
import unicodedata
from pathlib import Path

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE))

from frontmatter import FrontmatterError, load  # noqa: E402

MAX_QUESTIONS = 4
MIN_OPTIONS, MAX_OPTIONS = 2, 4
CATEGORY_STATUSES = ("clear", "partial", "missing", "deferred")

_MARKERS = ("recommended", "khuyen nghi", "de xuat")
_BANNED_LABELS = (
    "none", "none of the above", "none of these", "other", "others", "n/a", "na",
    "khac", "cai khac", "y kien khac", "khong co", "khong co cai nao",
    "khong cai nao", "khong co gi", "khong phai cai nao",
)


def _fold(text: str) -> str:
    """Lowercase, strip diacritics, collapse whitespace."""
    text = unicodedata.normalize("NFD", str(text).replace("đ", "d").replace("Đ", "D"))
    text = "".join(ch for ch in text if unicodedata.category(ch) != "Mn")
    return re.sub(r"\s+", " ", text.lower()).strip()


def _label_of(option) -> str:
    if isinstance(option, dict):
        return str(option.get("label", ""))
    return str(option)


def _has_marker(label: str) -> bool:
    folded = _fold(label)
    return any(m in folded for m in _MARKERS)


def _core_label(label: str) -> str:
    """Label without a recommended marker or punctuation, folded."""
    folded = _fold(label)
    folded = re.sub(r"\((?:[^)]*)\)|\[(?:[^\]]*)\]", " ", folded)
    for m in _MARKERS:
        folded = folded.replace(m, " ")
    return re.sub(r"[^a-z0-9/ ]", " ", folded).strip()


def _norm_question(text: str) -> str:
    return re.sub(r"[^a-z0-9]+", " ", _fold(text)).strip()


# -- loading ---------------------------------------------------------------


def rounds_from_trace(lines, date: str) -> list[dict]:
    """Build rounds from a session trace: one round per AskUserQuestion call."""
    rounds = []
    for raw in lines:
        raw = raw.strip()
        if not raw:
            continue
        try:
            message = json.loads(raw)
        except json.JSONDecodeError:
            continue
        content = (message.get("message") or message).get("content")
        if not isinstance(content, list):
            continue
        for block in content:
            if (
                isinstance(block, dict)
                and block.get("type") == "tool_use"
                and block.get("name") == "AskUserQuestion"
            ):
                questions = (block.get("input") or {}).get("questions") or []
                rounds.append({"date": date, "questions": questions})
    return rounds


def load_rounds(path: Path) -> list[dict]:
    data = json.loads(path.read_text(encoding="utf-8"))
    rounds = data.get("rounds") if isinstance(data, dict) else data
    if not isinstance(rounds, list):
        raise ValueError("rounds file must hold a list of rounds under 'rounds'")
    return rounds


# -- workspace reading -----------------------------------------------------


def find_idea(workspace: Path, idea: str | None) -> Path | list[str]:
    """Return the idea folder, or a list of problems."""
    specs = workspace / "specs"
    folders = sorted(p for p in specs.iterdir() if p.is_dir()) if specs.is_dir() else []
    if idea:
        for folder in folders:
            if idea in (folder.name, folder.name.split("-", 1)[-1]):
                return folder
        return [f"workspace: no idea folder matches {idea!r}"]
    if len(folders) == 1:
        return folders[0]
    if not folders:
        return ["workspace: no idea folder under specs/"]
    return ["workspace: several idea folders; name one with --idea"]


def clarification_sessions(spec_text: str) -> dict[str, dict[str, list[str]]]:
    """Map session date -> {'answered': [...], 'skipped': [...]} from the Clarifications section."""
    text = re.sub(r"<!--.*?-->", "", spec_text, flags=re.S)
    match = re.search(r"^## Clarifications\s*$(.*?)(?=^## |\Z)", text, flags=re.S | re.M)
    if not match:
        return {}
    sessions: dict[str, dict[str, list[str]]] = {}
    current = None
    for line in match.group(1).splitlines():
        heading = re.match(r"^###\s+Session\s+(\d{4}-\d{2}-\d{2})\s*$", line.strip())
        if heading:
            current = sessions.setdefault(heading.group(1), {"answered": [], "skipped": []})
            continue
        if current is None:
            continue
        item = re.match(r"^\s*-\s+Q:\s*(.+?)\s*(?:→|->)\s*A:\s*(.*)$", line)
        if item:
            current["answered"].append(item.group(1))
            continue
        item = re.match(r"^\s*-\s+Skipped:\s*(.+?)\s*$", line)
        if item:
            current["skipped"].append(item.group(1))
    return sessions


# -- rules -----------------------------------------------------------------


def check_structure(rounds: list[dict]) -> list[str]:
    """Rules 1-4 over the questions themselves."""
    problems = []
    for r, rnd in enumerate(rounds, 1):
        questions = rnd.get("questions") or []
        if len(questions) > MAX_QUESTIONS:
            problems.append(f"round {r}: {len(questions)} questions (at most {MAX_QUESTIONS})")
        if not questions:
            problems.append(f"round {r}: no questions")
        for q, question in enumerate(questions, 1):
            where = f"round {r} question {q}"
            options = question.get("options") or []
            labels = [_label_of(o) for o in options]
            if not MIN_OPTIONS <= len(labels) <= MAX_OPTIONS:
                problems.append(f"{where}: {len(labels)} options (two to four)")
            if labels:
                if not _has_marker(labels[0]):
                    problems.append(f"{where}: first option is not marked as recommended")
                for later in labels[1:]:
                    if _has_marker(later):
                        problems.append(f"{where}: recommended marker on a later option {later!r}")
            for label in labels:
                if _core_label(label) in _BANNED_LABELS:
                    problems.append(f"{where}: forbidden option {label!r} (no None or Other)")
    return problems


def check_skips(rounds: list[dict], coverage: dict | None, sessions: dict) -> list[str]:
    """Rules 5 and 6."""
    problems = []
    categories = (coverage or {}).get("categories") or {}
    for r, rnd in enumerate(rounds, 1):
        questions = rnd.get("questions") or []
        date = rnd.get("date")
        session = sessions.get(date, {"answered": [], "skipped": []})
        answered_text = {_norm_question(t) for t in session["answered"]}
        for q, question in enumerate(questions, 1):
            if not question.get("skipped"):
                continue
            where = f"round {r} question {q}"
            if _norm_question(question.get("question", "")) in answered_text:
                problems.append(f"{where}: skipped question is written as an answer")
            category = question.get("category")
            before = question.get("status_before")
            if category and before:
                if before not in CATEGORY_STATUSES:
                    problems.append(f"{where}: status_before {before!r} is not a coverage status")
                    continue
                entry = categories.get(category)
                after = entry.get("status") if isinstance(entry, dict) else None
                if after != before:
                    problems.append(
                        f"{where}: skipped, but category {category} changed from {before} to {after}"
                    )
        if questions and all(q.get("skipped") for q in questions):
            offered = {_fold(o) for o in (rnd.get("offer") or [])}
            missing = [w for w in ("pause", "draft") if not any(w in o for o in offered)]
            if missing:
                problems.append(
                    f"round {r}: every question skipped but the round does not offer {' and '.join(missing)}"
                )
    return problems


def check_write_back(rounds: list[dict], coverage: dict | None, sessions: dict) -> list[str]:
    """Rule 7."""
    problems = []
    for r, rnd in enumerate(rounds, 1):
        date = rnd.get("date")
        session = sessions.get(date)
        if session is None:
            problems.append(f"round {r}: no '### Session {date}' in the spec's Clarifications")
            continue
        answered = {_norm_question(t) for t in session["answered"]}
        skipped = {_norm_question(t) for t in session["skipped"]}
        for q, question in enumerate(rnd.get("questions") or [], 1):
            text = _norm_question(question.get("question", ""))
            where = f"round {r} question {q}"
            if question.get("skipped"):
                if text not in skipped:
                    problems.append(f"{where}: skipped question not listed as '- Skipped:' in Clarifications")
            elif "skipped" not in question and text in skipped:
                continue  # a trace does not say who skipped; either record is accepted
            elif text not in answered:
                problems.append(f"{where}: answer not written as '- Q: ... → A: ...' in Clarifications")
    if rounds:
        if coverage is None:
            problems.append("coverage.md: missing or unreadable")
        else:
            if not str(coverage.get("next_step") or "").strip():
                problems.append("coverage.md: next_step is empty after the rounds")
            used = coverage.get("budget_rounds_used")
            if not isinstance(used, int) or used < len(rounds):
                problems.append(
                    f"coverage.md: budget_rounds_used is {used!r}, expected at least {len(rounds)}"
                )
    return problems


def check(workspace, rounds: list[dict], idea: str | None = None) -> list[str]:
    """Return the list of rule problems for a workspace and its rounds (empty = valid)."""
    workspace = Path(workspace)
    problems = check_structure(rounds)
    found = find_idea(workspace, idea)
    if isinstance(found, list):
        return problems + (found if rounds else [])
    coverage = None
    try:
        coverage, _ = load(found / "coverage.md")
    except (OSError, FrontmatterError) as exc:
        problems.append(f"coverage.md: {exc}")
    spec = found / "spec.md"
    spec_text = spec.read_text(encoding="utf-8") if spec.is_file() else ""
    if not spec_text:
        problems.append("spec.md: missing or empty")
    sessions = clarification_sessions(spec_text)
    problems += check_skips(rounds, coverage, sessions)
    problems += check_write_back(rounds, coverage, sessions)
    return problems


def main(argv=None) -> int:
    parser = argparse.ArgumentParser(description="Check question-round rules over a case's workspace.")
    parser.add_argument("workspace")
    parser.add_argument("--rounds", help="rounds.json describing the questions asked")
    parser.add_argument("--trace", help="session trace (JSON lines) to read AskUserQuestion calls from")
    parser.add_argument("--idea", help="idea folder name or slug")
    parser.add_argument("--date", default=datetime.date.today().isoformat(), help="session date for --trace")
    args = parser.parse_args(argv)
    if bool(args.rounds) == bool(args.trace):
        parser.error("give exactly one of --rounds or --trace")
    try:
        if args.rounds:
            rounds = load_rounds(Path(args.rounds))
        else:
            rounds = rounds_from_trace(Path(args.trace).read_text(encoding="utf-8").splitlines(), args.date)
    except (OSError, ValueError) as exc:
        print(f"input: {exc}")
        return 2
    problems = check(args.workspace, rounds, args.idea)
    for problem in problems:
        print(problem)
    if not problems:
        print(f"ok: {len(rounds)} round(s) follow the question rules")
    return 1 if problems else 0


if __name__ == "__main__":
    sys.exit(main())
