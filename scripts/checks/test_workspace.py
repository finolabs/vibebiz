"""Workspace layout and naming check (T013, contracts/workspace-files.md)."""

import re
import shutil
import sys
import tempfile
import unicodedata
import unittest
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path.insert(0, str(HERE))

from frontmatter import FrontmatterError, load  # noqa: E402

VALID = HERE / "fixtures" / "workspace" / "valid"

WORKSPACE_FILES = ("index.html", "constitution.md")
IDEA_FILES = (
    "spec.md", "coverage.md", "plan.md", "decisions.md", "assumptions.md",
    "open-questions.md", "glossary.md", "checklists/board.md", "checklists/tech.md",
)
IDEA_DIRS = ("checklists", "diagrams", "exports")
CHECKLISTS = ("board.md", "tech.md")
EXPORT_FILES = ("board-deck.html", "tech-prd.html", "spec.md", "data.json", "links.md")
SLUG_RE = re.compile(r"^[a-z0-9]+(?:-[a-z0-9]+)*$")
FOLDER_RE = re.compile(r"^(\d+)-(.*)$")
DIAGRAM_RE = re.compile(r"^(\d{2})-(.+)\.(brief\.md|html|svg)$")
HISTORY_RE = re.compile(r"^(\d{4})-(\d{2})-(\d{2})(?:-([2-9]|[1-9]\d+))?$")


def _ignored(name):
    return name.startswith(".")


def slug_problems(slug, where):
    """Return the naming problems of a slug (empty list = valid)."""
    if not slug:
        return [f"{where}: slug is empty"]
    problems = []
    if any(ord(ch) > 127 for ch in slug):
        stripped = unicodedata.normalize("NFD", slug)
        if any(unicodedata.category(ch) == "Mn" for ch in stripped) or "đ" in slug.lower():
            problems.append(f"{where}: slug {slug!r} contains diacritics")
        else:
            problems.append(f"{where}: slug {slug!r} contains non-ASCII characters")
    if slug != slug.lower():
        problems.append(f"{where}: slug {slug!r} must be lowercase")
    if re.search(r"[\s_]", slug):
        problems.append(f"{where}: slug {slug!r} must be hyphenated (no spaces or underscores)")
    if not problems and not SLUG_RE.match(slug):
        problems.append(f"{where}: slug {slug!r} must be lowercase letters and digits joined by single hyphens")
    return problems


def _check_diagrams(folder, rel):
    problems = []
    for entry in sorted(folder.iterdir()):
        if _ignored(entry.name):
            continue
        where = f"{rel}/{entry.name}"
        m = DIAGRAM_RE.match(entry.name)
        if entry.is_dir() or not m:
            problems.append(f"{where}: diagram files must be named NN-<name>.brief.md, .html or .svg")
            continue
        problems += slug_problems(m.group(2), where)
    return problems


def _check_export_set(folder, rel):
    problems = []
    for entry in sorted(folder.iterdir()):
        if _ignored(entry.name) or (entry.name == "history" and entry.is_dir() and rel.endswith("exports")):
            continue
        if entry.is_dir() or entry.name not in EXPORT_FILES:
            problems.append(f"{rel}/{entry.name}: unexpected export file (allowed: {', '.join(EXPORT_FILES)})")
    return problems


def _check_exports(folder, rel):
    problems = _check_export_set(folder, rel)
    history = folder / "history"
    if history.is_dir():
        for entry in sorted(history.iterdir()):
            if _ignored(entry.name):
                continue
            where = f"{rel}/history/{entry.name}"
            m = HISTORY_RE.match(entry.name)
            valid_date = bool(m) and 1 <= int(m.group(2)) <= 12 and 1 <= int(m.group(3)) <= 31
            if not entry.is_dir() or not valid_date:
                problems.append(f"{where}: history folders must be named YYYY-MM-DD or YYYY-MM-DD-N")
                continue
            problems += _check_export_set(entry, where)
    return problems


def check_idea_folder(path, example=False, rel=None):
    """Return the problems of one idea (or example) folder."""
    path = Path(path)
    rel = rel or path.name
    problems = []
    m = FOLDER_RE.match(path.name)
    if not m or len(m.group(1)) != 3:
        problems.append(f"{rel}: folder must be named NNN-<slug> with a three-digit number")
        return problems
    number, slug = m.group(1), m.group(2)
    if example and number != "000":
        problems.append(f"{rel}: example folders must be numbered 000 (examples are excluded from numbering)")
    if not example and number == "000":
        problems.append(f"{rel}: 000 is reserved for examples; ideas start at 001")
    problems += slug_problems(slug, rel)

    for name in IDEA_FILES:
        if not (path / name).is_file():
            problems.append(f"{rel}: missing {name}")
    for entry in sorted(path.iterdir()):
        if _ignored(entry.name):
            continue
        where = f"{rel}/{entry.name}"
        if entry.is_dir():
            if entry.name not in IDEA_DIRS:
                problems.append(f"{where}: unexpected folder")
            elif entry.name == "checklists":
                for sub in sorted(entry.iterdir()):
                    if not _ignored(sub.name) and sub.name not in CHECKLISTS:
                        problems.append(f"{where}/{sub.name}: unexpected checklist (allowed: {', '.join(CHECKLISTS)})")
            elif entry.name == "diagrams":
                problems += _check_diagrams(entry, where)
            else:
                problems += _check_exports(entry, where)
        elif entry.name not in IDEA_FILES:
            problems.append(f"{where}: unexpected file")

    cov = path / "coverage.md"
    if cov.is_file():
        try:
            data, _ = load(cov)
        except FrontmatterError as exc:
            problems.append(f"{rel}/coverage.md: {exc}")
        else:
            if str(data.get("id")) != number:
                problems.append(f"{rel}/coverage.md: id {data.get('id')!r} does not match the folder number {number}")
            if data.get("slug") != slug:
                problems.append(f"{rel}/coverage.md: slug {data.get('slug')!r} does not match the folder slug {slug!r}")
    return problems


def check_workspace(path):
    """Return the problems of a vibebiz workspace (empty list = pass)."""
    root = Path(path)
    if not root.is_dir():
        return [f"{root}: workspace folder does not exist"]
    problems = []
    for name in WORKSPACE_FILES:
        if not (root / name).is_file():
            problems.append(f"missing {name}")

    specs = root / "specs"
    if specs.is_dir():
        numbers = {}
        for entry in sorted(specs.iterdir()):
            if _ignored(entry.name):
                continue
            rel = f"specs/{entry.name}"
            if not entry.is_dir():
                problems.append(f"{rel}: unexpected file; specs/ holds only idea folders")
                continue
            problems += check_idea_folder(entry, rel=rel)
            m = FOLDER_RE.match(entry.name)
            if m and len(m.group(1)) == 3:
                if m.group(1) in numbers:
                    problems.append(f"{rel}: number {m.group(1)} is already used by specs/{numbers[m.group(1)]}")
                else:
                    numbers[m.group(1)] = entry.name
    elif specs.exists():
        problems.append("specs: must be a folder")

    examples = root / "examples"
    if examples.is_dir():
        for entry in sorted(examples.iterdir()):
            if _ignored(entry.name):
                continue
            rel = f"examples/{entry.name}"
            if not entry.is_dir():
                problems.append(f"{rel}: unexpected file; examples/ holds only example folders")
                continue
            problems += check_idea_folder(entry, example=True, rel=rel)
    return problems


def _rename(rel_from, rel_to):
    def apply(ws):
        (ws / rel_to).parent.mkdir(parents=True, exist_ok=True)
        (ws / rel_from).rename(ws / rel_to)
    return apply


def _add(rel, text="x\n"):
    def apply(ws):
        (ws / rel).parent.mkdir(parents=True, exist_ok=True)
        (ws / rel).write_text(text, encoding="utf-8")
    return apply


def _remove(rel):
    return lambda ws: (ws / rel).unlink()


IDEA1 = "specs/001-nhac-khach-cu-quay-lai"

# Invalid fixtures: one change to a copy of fixtures/workspace/valid, and the problem it must raise.
INVALID = {
    "missing index": (_remove("index.html"), "missing index.html"),
    "missing record": (_remove(f"{IDEA1}/plan.md"), f"{IDEA1}: missing plan.md"),
    "uppercase slug": (
        _rename(IDEA1, "specs/001-Nhac-Khach-Cu-Quay-Lai"),
        "slug 'Nhac-Khach-Cu-Quay-Lai' must be lowercase",
    ),
    "diacritics": (_rename(IDEA1, "specs/001-nhắc-khách-cũ"), "slug 'nhắc-khách-cũ' contains diacritics"),
    "underscores": (_rename(IDEA1, "specs/001-nhac_khach"), "slug 'nhac_khach' must be hyphenated"),
    "two-digit number": (_rename(IDEA1, "specs/01-nhac-khach-cu-quay-lai"), "folder must be named NNN-<slug>"),
    "duplicate number": (
        _rename("specs/002-bao-cao-ban-hang-tuan", "specs/001-bao-cao-ban-hang-tuan"),
        "number 001 is already used",
    ),
    "idea numbered 000": (
        _rename("specs/002-bao-cao-ban-hang-tuan", "specs/000-bao-cao-ban-hang-tuan"),
        "000 is reserved for examples",
    ),
    "numbered example": (
        _rename("examples/000-xep-ca-nhan-vien", "examples/003-xep-ca-nhan-vien"),
        "example folders must be numbered 000",
    ),
    "non-English file name": (_rename(f"{IDEA1}/plan.md", f"{IDEA1}/ke-hoach.md"), f"{IDEA1}/ke-hoach.md: unexpected file"),
    "unexpected export": (_add(f"{IDEA1}/exports/deck.pdf"), "exports/deck.pdf: unexpected export file"),
    "bad history folder": (
        _rename(f"{IDEA1}/exports/history/2026-11-10", f"{IDEA1}/exports/history/12-11-2026"),
        "history folders must be named YYYY-MM-DD",
    ),
    "bad diagram name": (
        _rename(f"{IDEA1}/diagrams/01-customer-journey.svg", f"{IDEA1}/diagrams/journey.svg"),
        "diagram files must be named NN-<name>",
    ),
    "coverage id mismatch": (
        _rename("specs/002-bao-cao-ban-hang-tuan", "specs/003-bao-cao-ban-hang-tuan"),
        "id '002' does not match the folder number 003",
    ),
    "stray file in specs": (_add("specs/notes.md"), "specs/notes.md: unexpected file"),
}


class Slugs(unittest.TestCase):
    def test_valid(self):
        for slug in ("win-back", "nhac-khach-cu-quay-lai", "a1-b2"):
            self.assertEqual(slug_problems(slug, "x"), [], slug)

    def test_invalid(self):
        cases = {
            "Win-Back": "must be lowercase",
            "đặt-hàng": "contains diacritics",
            "win back": "must be hyphenated",
            "win--back": "single hyphens",
            "-win": "single hyphens",
            "": "slug is empty",
        }
        for slug, fragment in cases.items():
            with self.subTest(slug):
                self.assertTrue(any(fragment in p for p in slug_problems(slug, "x")), slug_problems(slug, "x"))


class Fixtures(unittest.TestCase):
    def test_valid_workspace_passes(self):
        self.assertEqual(check_workspace(VALID), [])

    def test_invalid_workspaces_report_the_problem(self):
        for name, (mutate, fragment) in INVALID.items():
            with self.subTest(name), tempfile.TemporaryDirectory() as tmp:
                ws = Path(tmp) / "ws"
                shutil.copytree(VALID, ws)
                mutate(ws)
                problems = check_workspace(ws)
                self.assertTrue(any(fragment in p for p in problems), problems)


class RepositoryContent(unittest.TestCase):
    def test_examples(self):
        folders = [p for p in sorted((ROOT / "examples").glob("*")) if p.is_dir() and not _ignored(p.name)]
        if not folders:
            self.skipTest("examples/ has no idea yet")
        for folder in folders:
            with self.subTest(folder.name):
                self.assertEqual(check_idea_folder(folder, example=True, rel=f"examples/{folder.name}"), [])


if __name__ == "__main__":
    unittest.main()
