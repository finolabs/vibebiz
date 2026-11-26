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
    from claude_agent_sdk import PermissionResultAllow, PermissionResultDeny
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
        args = argparse.Namespace(plugin=self.ws / "plugin", max_cost=10.0, persona_model="x")
        self.run_ = run.Run(fixture=FIXTURE, workspace=self.ws, args=args)
        self.replies = []
        self.calls = 0

        async def fake_ask(prompt, system, model):
            self.calls += 1
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

    def test_ready_idea_ends_the_session(self):
        shutil.copytree(HERE / "canned" / "ready" / "specs", self.ws / "specs")
        res = self.call("AskUserQuestion", {"questions": [q("Một?")]})
        self.assertIsInstance(res, PermissionResultDeny)
        self.assertTrue(self.run_.stopped_ready)


if __name__ == "__main__":
    unittest.main()
