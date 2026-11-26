"""Tests for turns.py, replaying turn endings from the 2026-11-26 calibration (spec 001 T097).

python3 -m unittest discover -s evals/persona -p 'test_turns.py' -v
"""

import sys
import unittest
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))

import turns  # noqa: E402

# Tails of real turn endings from the fashion-1-loyalty calibration run.
STOPPED_FOR_FIGURES = ("Chưa có hai số này thì chưa đặt được mục tiêu mua lại, cũng chưa so được các phương án.\n\n"
                       "Luật chung của công ty chưa ghi. Khi nào cần, mày gõ `/vibebiz:constitution`.")
ASKS_TO_GO_ON = "Mày muốn hỏi tiếp luôn hay dừng ở đây? Gõ `/vibebiz:continue` để quay lại sau."
PAUSED = "Tạm dừng. Mọi thứ đã lưu. Muốn làm tiếp thì gõ `/vibebiz:continue`."


def decide(text, **kw):
    base = dict(error=False, ready=False, paused=False, finished=True, replies=0, nudges=0, max_replies=6)
    base.update(kw)
    return turns.next_turn(text, **base)


class NextTurn(unittest.TestCase):
    def test_stop_without_question_gets_one_nudge(self):
        # session 1 ended here before the fix, two rounds into its three-round budget
        self.assertEqual(decide(STOPPED_FOR_FIGURES), "nudge")
        self.assertEqual(decide(STOPPED_FOR_FIGURES, nudges=1), "end")

    def test_question_gets_a_reply_up_to_the_cap(self):
        self.assertEqual(decide(ASKS_TO_GO_ON), "reply")
        self.assertEqual(decide(ASKS_TO_GO_ON, replies=6), "end")

    def test_pause_ready_error_and_unfinished_end_the_session(self):
        self.assertEqual(decide(PAUSED, paused=True), "end")
        self.assertEqual(decide(ASKS_TO_GO_ON, ready=True), "end")
        self.assertEqual(decide(ASKS_TO_GO_ON, error=True), "end")
        self.assertEqual(decide(ASKS_TO_GO_ON, finished=False), "end")


class BudgetOffer(unittest.TestCase):
    def test_follows_the_recommended_continue(self):
        # the offer from the 2026-11-26 run, where vibebiz recommended going on
        self.assertEqual(turns.budget_offer_choice(["Hỏi tiếp (Đề xuất)", "Tạm dừng", "Xuất bản nháp"]),
                         ("Hỏi tiếp (Đề xuất)", False))

    def test_follows_the_recommended_pause(self):
        # the offer from the 2026-11-27 run, session 4
        self.assertEqual(turns.budget_offer_choice(["Tạm dừng (Đề xuất)", "Hỏi tiếp", "Xuất bản nháp"]),
                         ("Tạm dừng (Đề xuất)", True))

    def test_unmarked_offer_takes_the_first_option(self):
        self.assertEqual(turns.budget_offer_choice(["Hỏi tiếp", "Tạm dừng", "Xuất bản nháp"]), ("Hỏi tiếp", False))

    def test_recommended_draft_becomes_the_pause(self):
        self.assertEqual(turns.budget_offer_choice(["Xuất bản nháp (Đề xuất)", "Tạm dừng", "Hỏi tiếp"]),
                         ("Tạm dừng", True))

    def test_ordinary_question_is_not_the_offer(self):
        self.assertIsNone(turns.budget_offer_choice(["Đi tiếp, chờ số sau (Đề xuất)", "Dừng chờ số"]))


if __name__ == "__main__":
    unittest.main()
