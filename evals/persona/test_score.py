"""Tests for score.py on canned workspaces (spec 001 T097).

python3 -m unittest discover -s evals/persona -p 'test_score.py' -v
"""

import json
import sys
import unittest
from pathlib import Path

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE))

import score  # noqa: E402

FIXTURE = json.loads((HERE.parents[1] / "evals" / "fixtures" / "fashion-1-loyalty.json").read_text(encoding="utf-8"))
CANNED = HERE / "canned"


class Readiness(unittest.TestCase):
    def test_ready_with_sized_m_and_deferred_with_reason(self):
        ready, unmet = score.readiness(CANNED / "ready" / "specs" / "001-tich-diem-khach-quen" / "coverage.md")
        self.assertTrue(ready, unmet)

    def test_not_ready_names_each_gap(self):
        ready, unmet = score.readiness(CANNED / "not-ready" / "specs" / "001-tich-diem-khach-quen" / "coverage.md")
        self.assertFalse(ready)
        # D must be clear, H is deferred without a reason, M is not sized
        self.assertEqual(unmet, ["D:partial", "H:deferred", "M:missing"])


class Quantities(unittest.TestCase):
    def test_units_normalize(self):
        q = score.quantities("18% trong ba tháng, 6.000.000 đ, 0,4 tỷ đồng, 40 giờ, khách 25-40 tuổi")
        for item in [("pct", 18.0), ("days", 90.0), ("money", 6e6), ("money", 4e8),
                     ("hours", 40.0), ("count", 25.0), ("count", 40.0)]:
            self.assertIn(item, q)

    def test_paraphrased_duration_matches(self):
        self.assertTrue(score.fact_numbers_present("trong 90 ngày", "trong ba tháng"))
        self.assertFalse(score.fact_numbers_present("trong 90 ngày", "trong 9 tuần"))

    def test_words_that_are_not_units_are_ignored(self):
        self.assertEqual(score.quantities("6 trong số khách"), {("count", 6.0)})
        self.assertEqual(score.quantities("năm đầu"), set())


class Facts(unittest.TestCase):
    def test_numbers_deterministic_and_unscored_without_judge(self):
        result = score.score_workspace(CANNED / "ready", FIXTURE)
        facts = result["facts"]["facts"]
        self.assertTrue(result["ready"])
        for fid in ("problem", "users", "cost-today", "goal", "budget", "deadline", "first-buyers", "regular-spend"):
            self.assertEqual(facts[fid], {"method": "numbers", "preserved": True}, fid)
        self.assertEqual(facts["data"], {"method": "numbers", "preserved": False})
        self.assertEqual(facts["risk"], {"method": "unscored", "preserved": None})
        self.assertEqual((result["facts"]["preserved"], result["facts"]["scored"]), (8, 9))

    def test_judge_handles_only_facts_without_numbers(self):
        seen = []

        def judge(spec_text, facts):
            seen.extend(f["id"] for f in facts)
            return {f["id"]: True for f in facts}

        result = score.score_workspace(CANNED / "ready", FIXTURE, judge=judge)
        self.assertEqual(seen, ["risk"])
        self.assertEqual(result["facts"]["facts"]["risk"], {"method": "judge", "preserved": True})
        self.assertEqual(result["facts"]["share"], 0.9)

    def test_dropped_budget_is_caught(self):
        result = score.score_workspace(CANNED / "not-ready", FIXTURE)
        self.assertFalse(result["facts"]["facts"]["budget"]["preserved"])
        self.assertFalse(result["ready"])

    def test_empty_workspace(self):
        result = score.score_workspace(CANNED / "missing", FIXTURE)
        self.assertIsNone(result["idea"])
        self.assertEqual(result["facts"]["preserved"], 0)


if __name__ == "__main__":
    unittest.main()
