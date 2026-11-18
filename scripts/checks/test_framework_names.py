"""Checks for the framework-name grader (spec 004 FR-001, SC-001).

Every framework eval case carries graders/no-framework-name.md, generated from
the shipped cards, so adding a card updates what no question may show.

Run: python3 scripts/checks/test_framework_names.py -v
"""

from __future__ import annotations

import re
import sys
import unittest
from pathlib import Path

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE))

import framework_names as fn  # noqa: E402


class Pattern(unittest.TestCase):
    def setUp(self):
        self.rx = re.compile(fn.pattern())

    def test_names_a_framework_in_any_case(self):
        for text in ("Mình làm SWOT nhé", "dùng phương pháp moscow", "5 whys", "Driver tree", "ishikawa diagram",
                     "Customer journey map and service blueprint", "balanced-scorecard"):
            with self.subTest(text):
                self.assertIsNotNone(self.rx.search(text))

    def test_plain_vietnamese_question_passes(self):
        for text in ("Lần gần nhất khách quay lại mua là khi nào?", "Ai duyệt ngân sách cho thí điểm này?",
                     "Mục tiêu OKR quý này của công ty là gì?"):
            with self.subTest(text):
                self.assertIsNone(self.rx.search(text))

    def test_exempt_cards_are_left_out(self):
        self.assertFalse(any(n.lower() == "okr" for n in fn.names()))


class Graders(unittest.TestCase):
    def test_every_framework_case_has_the_current_grader(self):
        expected = fn.grader_text(fn.pattern())
        cases = fn.case_dirs()
        self.assertTrue(cases)
        for case in cases:
            with self.subTest(case.name):
                grader = case / "graders" / fn.GRADER_NAME
                self.assertTrue(grader.is_file(), f"missing {grader.relative_to(fn.REPO)}; run framework_names.py --write")
                self.assertEqual(grader.read_text(encoding="utf-8"), expected, "stale grader; run framework_names.py --write")
                text = case / "graders" / fn.TEXT_GRADER_NAME
                self.assertTrue(text.is_file(), f"missing {text.relative_to(fn.REPO)}; run framework_names.py --write")
                self.assertEqual(text.read_text(encoding="utf-8"), fn.text_grader_text(fn.pattern()), "stale grader; run framework_names.py --write")


    def test_by_name_cases_carry_no_name_grader(self):
        for case in sorted(fn.CASES_DIR.glob(fn.BY_NAME_PREFIX + "*")):
            with self.subTest(case.name):
                self.assertFalse((case / "graders" / fn.GRADER_NAME).exists())
                self.assertFalse((case / "graders" / fn.TEXT_GRADER_NAME).exists())


if __name__ == "__main__":
    unittest.main()
