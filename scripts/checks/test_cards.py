"""Checks for the framework cards in packs/frameworks/ (T042).

A card is valid when it has the frontmatter keys id, name, lens, fills, core,
diagram_type and origin (data-model "Framework card") and the seven body
sections below. The shipped set must hold exactly fifteen cards with
``core: true`` (the first-release library). Python 3.10+ standard library only.

Run: python3 scripts/checks/test_cards.py -v
"""

from __future__ import annotations

import re
import shutil
import sys
import tempfile
import unittest
from pathlib import Path

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE))

from frontmatter import FrontmatterError, load  # noqa: E402

REPO = HERE.parent.parent
CARDS_DIR = REPO / "packs" / "frameworks"
FIXTURES = HERE / "fixtures" / "cards"

REQUIRED_KEYS = ("id", "name", "lens", "fills", "core", "diagram_type", "origin")
REQUIRED_SECTIONS = (
    "When to use",
    "When not to use",
    "Inputs",
    "Questions",
    "Writes to",
    "Common misuse",
    "Fashion example",
)
CATEGORY_CODES = set("ABCDEFGHIJKLMNO")
CORE_COUNT = 15

_HEADING_RE = re.compile(r"^#{2,6}\s+(.+?)\s*#*\s*$", re.MULTILINE)


def check_card(path) -> list[str]:
    """Return the problems of one card file; an empty list means valid."""
    path = Path(path)
    name = path.name
    try:
        data, body = load(path)
    except FrontmatterError as exc:
        return [str(exc)]
    except OSError as exc:
        return [f"{name}: cannot read file ({exc})"]

    problems: list[str] = []
    if not data:
        return [f"{name}: no frontmatter"]
    for key in REQUIRED_KEYS:
        if key not in data:
            problems.append(f"{name}: missing frontmatter key '{key}'")
        elif key == "fills" and data[key] == [] and data.get("lens") == "router":
            continue  # the router's own card (Cynefin) sets depth and fills no category
        elif data[key] is None or data[key] == "" or data[key] == []:
            problems.append(f"{name}: frontmatter key '{key}' is empty")

    card_id = data.get("id")
    if isinstance(card_id, str) and card_id and card_id != path.stem:
        problems.append(f"{name}: id '{card_id}' does not match the file name '{path.stem}'")

    if data.get("fills") not in (None, "", []):
        fills = data["fills"]
        if not isinstance(fills, list) or any(not isinstance(c, str) or c not in CATEGORY_CODES for c in fills):
            problems.append(f"{name}: 'fills' must be a list of category codes A to O")

    if "core" in data and data["core"] is not None and not isinstance(data["core"], bool):
        problems.append(f"{name}: 'core' must be true or false")

    headings = {m.group(1).strip().lower() for m in _HEADING_RE.finditer(body)}
    for section in REQUIRED_SECTIONS:
        # A heading may add a qualifier, as in "Fashion example (fictional)".
        if not any(h == section.lower() or h.startswith(section.lower() + " (") for h in headings):
            problems.append(f"{name}: missing section '{section}'")
    return problems


def check_cards(directory) -> list[str]:
    """Check every card in a folder and the number of core cards."""
    directory = Path(directory)
    problems: list[str] = []
    cards = sorted(directory.glob("*.md"))
    core = 0
    for card in cards:
        problems.extend(check_card(card))
        try:
            data, _ = load(card)
        except (FrontmatterError, OSError):
            continue
        if data.get("core") is True:
            core += 1
    if core != CORE_COUNT:
        problems.append(f"{directory.name}: {core} cards have core: true, expected exactly {CORE_COUNT}")
    return problems


class CardFixtures(unittest.TestCase):
    def test_valid_cards_have_no_problems(self):
        for path in sorted(FIXTURES.glob("valid-*.md")):
            with self.subTest(path.name):
                self.assertEqual(check_card(path), [])

    EXPECTED = {
        "invalid-missing-origin.md": "missing frontmatter key 'origin'",
        "invalid-missing-section.md": "missing section 'Common misuse'",
        "invalid-core-not-boolean.md": "'core' must be true or false",
        "invalid-fills-empty.md": "frontmatter key 'fills' is empty",
        "invalid-fills-code.md": "'fills' must be a list of category codes A to O",
        "invalid-id-mismatch.md": "does not match the file name",
        "invalid-no-frontmatter.md": "does not start with a '---'",
        "invalid-empty-value.md": "frontmatter key 'name' is empty",
    }

    def test_every_invalid_fixture_is_covered(self):
        self.assertEqual(sorted(p.name for p in FIXTURES.glob("invalid-*.md")), sorted(self.EXPECTED))

    def test_invalid_cards_report_the_problem(self):
        for name, fragment in self.EXPECTED.items():
            with self.subTest(name):
                problems = check_card(FIXTURES / name)
                self.assertEqual(len(problems), 1, problems)
                self.assertIn(fragment, problems[0])

    def test_section_headings_are_exact(self):
        # "When not to use" must not satisfy "When to use" and vice versa.
        with tempfile.TemporaryDirectory() as tmp:
            src = (FIXTURES / "valid-core.md").read_text(encoding="utf-8")
            card = Path(tmp) / "valid-core.md"
            card.write_text(src.replace("## When to use\n", "## When to use it\n"), encoding="utf-8")
            problems = check_card(card)
            self.assertEqual(len(problems), 1)
            self.assertIn("missing section 'When to use'", problems[0])


class CoreCount(unittest.TestCase):
    """The folder check counts cards with core: true against a temp folder."""

    def _folder(self, core: int, optional: int = 1) -> Path:
        tmp = Path(tempfile.mkdtemp())
        self.addCleanup(shutil.rmtree, tmp, ignore_errors=True)
        template = (FIXTURES / "valid-core.md").read_text(encoding="utf-8")
        for i in range(core):
            card_id = f"core-{i:02d}"
            (tmp / f"{card_id}.md").write_text(template.replace("id: valid-core", f"id: {card_id}"), encoding="utf-8")
        for i in range(optional):
            card_id = f"extra-{i:02d}"
            text = template.replace("id: valid-core", f"id: {card_id}").replace("core: true", "core: false")
            (tmp / f"{card_id}.md").write_text(text, encoding="utf-8")
        return tmp

    def test_exactly_fifteen_core_passes(self):
        self.assertEqual(check_cards(self._folder(15)), [])

    def test_fourteen_core_fails(self):
        problems = check_cards(self._folder(14))
        self.assertEqual(len(problems), 1)
        self.assertIn("14 cards have core: true, expected exactly 15", problems[0])

    def test_sixteen_core_fails(self):
        problems = check_cards(self._folder(16))
        self.assertIn("16 cards have core: true, expected exactly 15", problems[-1])

    def test_a_broken_card_is_reported_with_the_count(self):
        folder = self._folder(15)
        shutil.copy(FIXTURES / "invalid-missing-origin.md", folder / "invalid-missing-origin.md")
        problems = check_cards(folder)
        self.assertEqual(len(problems), 2)  # the missing key, and 16 cards with core: true
        self.assertTrue(any("missing frontmatter key 'origin'" in p for p in problems))


class RepositoryCards(unittest.TestCase):
    def test_shipped_cards_are_valid_and_fifteen_are_core(self):
        cards = sorted(CARDS_DIR.glob("*.md")) if CARDS_DIR.is_dir() else []
        if not cards:
            self.skipTest("packs/frameworks/ has no cards yet; this check applies once they exist")
        self.assertEqual(check_cards(CARDS_DIR), [])


if __name__ == "__main__":
    unittest.main()
