"""Tests for score.py on canned workspaces (spec 001 T097).

python3 -m unittest discover -s evals/persona -p 'test_score.py' -v
"""

import json
import re
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


class ReadinessWaiting(unittest.TestCase):
    """Plan with what you have: a category waiting only on someone else's answer is settled."""

    def workspace(self, idea_status, d_status, owner):
        import shutil, tempfile
        tmp = Path(tempfile.mkdtemp())
        self.addCleanup(shutil.rmtree, tmp)
        src = CANNED / "ready" / "specs" / "001-tich-diem-khach-quen"
        dst = tmp / "001"
        shutil.copytree(src, dst)
        cov = dst / "coverage.md"
        text = cov.read_text(encoding="utf-8")
        text = re.sub(r"(?m)^status: \S+", f"status: {idea_status}", text, count=1)
        text = re.sub(r"(?m)^(  D: \{status: )\w+", rf"\g<1>{d_status}", text, count=1)
        text = re.sub(r"(?m)^(  H: \{status: )\w+", r"\g<1>partial", text, count=1)
        cov.write_text(text, encoding="utf-8")
        (dst / "open-questions.md").write_text(
            "# Open questions\n\n## Q-001\n\n- text: Giá?\n- owner: " + owner + "\n- category: D\n- status: open\n\n"
            "## Q-002\n\n- text: Cổng nối?\n- owner: Bộ phận IT\n- category: H\n- status: open\n", encoding="utf-8")
        return cov

    def test_waiting_on_someone_else_is_settled(self):
        self.assertEqual(score.readiness(self.workspace("ready", "partial", "nhà cung cấp")), (True, []))

    def test_a_required_category_needs_the_idea_marked_ready(self):
        self.assertEqual(score.readiness(self.workspace("clarifying", "partial", "nhà cung cấp")), (False, ["D:partial"]))

    def test_a_question_the_user_owns_is_not_waiting(self):
        self.assertEqual(score.readiness(self.workspace("ready", "partial", "user")), (False, ["D:partial"]))


class ReadinessEdges(unittest.TestCase):
    def cov(self, case):
        return CANNED / case / "specs" / "001-tich-diem-khach-quen" / "coverage.md"

    def test_chaotic_is_never_ready(self):
        self.assertEqual(score.readiness(self.cov("chaotic")), (False, ["cynefin:chaotic"]))

    def test_f_must_be_clear_when_the_idea_involves_ai(self):
        self.assertEqual(score.readiness(self.cov("f-deferred")), (True, []))
        self.assertEqual(score.readiness(self.cov("f-deferred"), involves_ai=True), (False, ["F:deferred"]))

    def test_malformed_coverage_is_not_ready_and_names_the_error(self):
        ready, unmet = score.readiness(self.cov("malformed"))
        self.assertFalse(ready)
        self.assertTrue(unmet[0].startswith("coverage.md unreadable:"), unmet)
        result = score.score_workspace(CANNED / "malformed", FIXTURE)  # scoring still runs
        self.assertFalse(result["ready"])
        self.assertEqual(result["facts"]["preserved"], 8)

    def test_fixtures_say_whether_the_idea_involves_ai(self):
        for path in sorted((HERE.parents[1] / "evals" / "fixtures").glob("*.json")):
            self.assertIsInstance(json.loads(path.read_text(encoding="utf-8")).get("involves_ai"), bool, path.name)


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


class QuantityEdges(unittest.TestCase):
    def test_vnd_with_d_bar(self):
        self.assertIn(("money", 6e6), score.quantities("6.000.000 VNĐ mỗi tháng"))

    def test_dates_and_record_ids_are_not_quantities(self):
        text = "D-019, Q-004 và SC-001 ngày 2026-11-27, 27/11/2026, khoảng 5/2027"
        self.assertEqual(score.quantities(text), set())

    def test_values_are_rounded_before_comparing(self):
        self.assertTrue(score.fact_numbers_present("ngân sách 0,3 tỷ", "300 triệu đồng"))

    def test_a_count_matches_only_a_count(self):
        self.assertTrue(score.fact_numbers_present("34 cửa hàng", "ở 34 cửa hàng"))
        self.assertFalse(score.fact_numbers_present("34 cửa hàng", "34% khách quay lại"))
        self.assertFalse(score.fact_numbers_present("40 tuổi", "trong 40 giờ"))

    def test_a_range_shares_its_closing_unit(self):
        self.assertTrue(score.fact_numbers_present("từ 11 xuống 7 ngày", "từ 11 ngày xuống 7 ngày"))
        self.assertTrue(score.fact_numbers_present("từ 26% xuống 12%", "26% xuống còn 12%"))
        self.assertFalse(score.fact_numbers_present("từ 11 xuống 7 ngày", "11 cửa hàng, 7 ngày"))

    def test_number_words_count_only_with_a_unit(self):
        q = score.quantities
        self.assertEqual(q("Cần hai mươi bảy giờ."), {("hours", 27.0)})
        self.assertEqual(q("mười một giờ"), {("hours", 11.0)})
        self.assertEqual(q("Tỷ lệ lỗi bảy phần trăm."), {("pct", 7.0)})
        self.assertEqual(q("Ngân sách hai trăm năm mươi triệu đồng"), {("money", 250e6)})
        self.assertEqual(q("ba trăm linh năm ngày"), {("days", 305.0)})
        self.assertEqual(q("hai năm"), {("days", 730.0)})
        self.assertEqual(q("Chờ hai ba ngày"), {("days", 2.0), ("days", 3.0)})
        self.assertTrue(score.fact_numbers_present("5 giờ mỗi ngày", "năm tiếng một ngày"))
        self.assertFalse(score.fact_numbers_present("4 giờ mỗi ngày", "hai mươi bốn giờ mỗi ngày"))
        self.assertFalse(score.fact_numbers_present("5 ngày", "Chờ hai ba ngày"))
        self.assertEqual(q("tháng Bảy năm nay"), set())
        self.assertEqual(q("mỗi tháng hai ngày"), {("days", 2.0)})
        self.assertEqual(q("Chạy thử trong một năm sáu tháng."), {("days", 365.0), ("days", 180.0)})
        self.assertFalse(score.fact_numbers_present("Phải chạy được trong 5 tháng tới.", "trong một năm sáu tháng"))

    def test_bare_number_words_are_not_counts(self):
        for text in ("bảy nhân viên", "đồng bộ hai chiều", "Hai bên dùng chung mã", "mua lần hai",
                     "thứ bảy hằng tuần", "tháng Sáu tới", "hai, ba cửa hàng", "kế hoạch đã chín muồi"):
            self.assertEqual(score.quantities(text), set(), text)

    def test_fixture_facts_against_ordinary_spec_prose(self):
        def fact(fixture, fid):
            data = json.loads((HERE.parents[1] / "evals" / "fixtures" / f"{fixture}.json").read_text(encoding="utf-8"))
            return next(f["fact"] for f in data["key_facts"] if f["id"] == fid)
        self.assertTrue(score.fact_numbers_present(fact("fashion-1-loyalty", "problem"),
            "Chỉ 18% mua lại trong 90 ngày, khách mua một lần rồi bỏ đi."))
        self.assertTrue(score.fact_numbers_present(fact("fashion-2-size-returns", "cost-today"),
            "Mỗi đơn trả tốn trung bình 52.000 đồng vận chuyển khứ hồi và xử lý; khoảng 1.900 đơn trả mỗi tháng."))
        self.assertTrue(score.fact_numbers_present(fact("fashion-3-seasonal-stock", "cost-today"),
            "Chia hàng bằng Excel, mỗi đợt hai ngày công của cả 3 người; xả hàng tồn giảm giá trung bình 45%."))
        self.assertFalse(score.fact_numbers_present(fact("fashion-3-seasonal-stock", "goal"),
            "Giảm tồn cuối mùa từ 22% xuống 15%. Đồng bộ dữ liệu hai chiều giữa kho và cửa hàng."))

    def test_long_tokens_stay_fast(self):
        import time
        start = time.monotonic()
        score.quantities("x" * 200_000 + " bảy nhân viên")
        self.assertLess(time.monotonic() - start, 1.0)


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

    def test_judge_reply_that_is_not_a_boolean_stays_unscored(self):
        result = score.score_workspace(CANNED / "ready", FIXTURE, judge=lambda *_: {"risk": "true"})
        self.assertEqual(result["facts"]["facts"]["risk"], {"method": "unscored", "preserved": None})
        result = score.score_workspace(CANNED / "ready", FIXTURE, judge=lambda *_: ["risk"])
        self.assertEqual(result["facts"]["unscored"], 1)

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
