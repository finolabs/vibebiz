"""Checks for the routing map between framework cards (spec 004 FR-017).

Run: python3 scripts/checks/test_framework_map.py -v
"""

from __future__ import annotations

import shutil
import sys
import tempfile
import unittest
from pathlib import Path

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE))

import framework_map as fm  # noqa: E402


def card(cid: str, needs="[]", feeds="[]", instead="[]", revisit="[]") -> str:
    return (f"---\nid: {cid}\nname: {cid.title()}\nlens: outcome\nfills: [C]\ncore: false\n"
            f"diagram_type: none\norigin: test\nneeds: {needs}\nfeeds: {feeds}\ninstead_of: {instead}\nrevisit_when: {revisit}\n---\n\n# x\n")


class MapFixtures(unittest.TestCase):
    def folder(self, files: dict[str, str]) -> Path:
        tmp = Path(tempfile.mkdtemp())
        self.addCleanup(shutil.rmtree, tmp, ignore_errors=True)
        for cid, text in files.items():
            (tmp / f"{cid}.md").write_text(text, encoding="utf-8")
        return tmp

    def test_valid_set_passes(self):
        d = self.folder({
            "a": card("a", feeds="\n  - to: b\n    passes: the root cause", instead="[c]", revisit="[C, board-changes]"),
            "b": card("b", needs="[a]"),
            "c": card("c", instead="[a]"),
        })
        self.assertEqual(fm.check(d), [])

    def test_missing_target(self):
        d = self.folder({"a": card("a", needs="[ghost]")})
        self.assertTrue(any("'ghost'" in p for p in fm.check(d)))

    def test_one_sided_instead_of(self):
        d = self.folder({"a": card("a", instead="[b]"), "b": card("b")})
        self.assertTrue(any("both sides" in p for p in fm.check(d)))

    def test_needs_cycle(self):
        d = self.folder({"a": card("a", needs="[b]"), "b": card("b", needs="[a]")})
        self.assertTrue(any("needs cycle" in p for p in fm.check(d)))

    def test_bad_revisit_value(self):
        d = self.folder({"a": card("a", revisit="[Z]")})
        self.assertTrue(any("revisit_when 'Z'" in p for p in fm.check(d)))

    def test_missing_link_key(self):
        d = self.folder({"a": card("a").replace("revisit_when: []\n", "")})
        self.assertTrue(any("missing link key 'revisit_when'" in p for p in fm.check(d)))


class Repository(unittest.TestCase):
    def test_shipped_map_is_valid(self):
        self.assertEqual(fm.check(), [])

    def test_doc_is_current(self):
        self.assertTrue(fm.DOC.is_file(), "run framework_map.py render")
        self.assertEqual(fm.DOC.read_text(encoding="utf-8"), fm.render(), "stale docs/framework-map.md; run framework_map.py render")


if __name__ == "__main__":
    unittest.main()
