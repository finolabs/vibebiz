"""Tests for the question-round rules check (T024, scripts/checks/round_rules.py)."""

import json
import subprocess
import sys
import unittest
from pathlib import Path

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE))

import round_rules  # noqa: E402

FIX = HERE / "fixtures" / "round_rules"
VALID = FIX / "valid"


def run(case, workspace=None):
    """Check a fixture: rounds from `case`, workspace from `workspace` (default: the case itself)."""
    base = FIX / (workspace or case)
    rounds = round_rules.load_rounds(FIX / case / "rounds.json")
    return round_rules.check(base / "workspace", rounds)


class ValidTests(unittest.TestCase):
    def test_valid_round_set_has_no_problems(self):
        self.assertEqual(run("valid"), [])

    def test_trace_builds_rounds_and_passes_structure_and_write_back(self):
        lines = (VALID / "trace.jsonl").read_text(encoding="utf-8").splitlines()
        rounds = round_rules.rounds_from_trace(lines, "2026-11-12")
        self.assertEqual([len(r["questions"]) for r in rounds], [4, 2])
        self.assertEqual(round_rules.check(VALID / "workspace", rounds), [])

    def test_cli_exit_codes(self):
        script = str(HERE / "round_rules.py")
        ok = subprocess.run([sys.executable, script, str(VALID / "workspace"), "--rounds",
                             str(VALID / "rounds.json")], capture_output=True, text=True)
        self.assertEqual(ok.returncode, 0, ok.stdout + ok.stderr)
        bad = FIX / "invalid_other_option"
        fail = subprocess.run([sys.executable, script, str(VALID / "workspace"), "--rounds",
                               str(bad / "rounds.json")], capture_output=True, text=True)
        self.assertEqual(fail.returncode, 1)
        self.assertIn("forbidden option", fail.stdout)


class StructureTests(unittest.TestCase):
    def expect(self, case, text):
        problems = run(case, "valid")
        self.assertTrue(any(text in p for p in problems), f"{case}: {problems}")

    def test_five_questions(self):
        self.expect("invalid_five_questions", "5 questions (at most 4)")

    def test_one_option(self):
        self.expect("invalid_one_option", "1 options (two to four)")

    def test_five_options(self):
        self.expect("invalid_five_options", "5 options (two to four)")

    def test_recommended_not_first(self):
        self.expect("invalid_not_recommended_first", "first option is not marked as recommended")
        self.expect("invalid_not_recommended_first", "recommended marker on a later option")

    def test_no_recommended(self):
        self.expect("invalid_no_recommended", "first option is not marked as recommended")

    def test_other_option(self):
        self.expect("invalid_other_option", "forbidden option 'Khác'")

    def test_none_option(self):
        self.expect("invalid_none_option", "forbidden option 'None'")

    def test_legit_yes_no_labels_are_not_flagged(self):
        rounds = [{"date": "2026-11-12", "questions": [
            {"question": "Q?", "options": ["Có (Khuyến nghị)", "Không"]}]}]
        self.assertEqual(round_rules.check_structure(rounds), [])


class SkipTests(unittest.TestCase):
    def test_skipped_category_changed(self):
        problems = run("invalid_skip_changed")
        self.assertTrue(any("category D changed from missing to partial" in p for p in problems), problems)

    def test_skipped_written_as_answer(self):
        problems = run("invalid_skip_as_answer")
        self.assertTrue(any("skipped question is written as an answer" in p for p in problems), problems)

    def test_all_skipped_round_without_offer(self):
        problems = run("invalid_all_skipped_no_offer", "valid")
        self.assertTrue(any("does not offer pause and draft" in p for p in problems), problems)


class WriteBackTests(unittest.TestCase):
    def test_nothing_written(self):
        problems = run("invalid_no_write_back")
        self.assertTrue(any("no '### Session 2026-11-12'" in p for p in problems), problems)

    def test_missing_answer(self):
        problems = run("invalid_answer_missing")
        self.assertTrue(any("answer not written" in p for p in problems), problems)

    def test_empty_next_step(self):
        problems = run("invalid_no_next_step")
        self.assertTrue(any("next_step is empty" in p for p in problems), problems)

    def test_budget_counter_not_updated(self):
        problems = run("invalid_budget_not_updated")
        self.assertTrue(any("budget_rounds_used" in p for p in problems), problems)

    def test_example_comment_in_template_is_ignored(self):
        text = (VALID / "workspace/specs/001-nhac-khach-quay-lai/spec.md").read_text(encoding="utf-8")
        self.assertNotIn("not a real one", json.dumps(round_rules.clarification_sessions(text)))


if __name__ == "__main__":
    unittest.main()
