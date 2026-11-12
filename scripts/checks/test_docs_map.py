"""Docs and help map check (T015).

- The skills present in `skills/` (folders holding a `SKILL.md`) are exactly
  the skills listed in `skills/help/situation-map.md`, `docs/commands.md` and
  the "What ships" sections of `README.md` and `README.vi.md`. A document
  lists a skill by naming its command, `/vibebiz:<name>`.
- `README.md` and `README.vi.md` have the same section structure (heading
  levels in order); the Vietnamese "What ships" section is the one at the same
  position as the English one.
- Every image a doc embeds (Markdown `![..](..)` or `<img src>`) exists.
- Every diagram brief in `docs/diagrams/*.brief.md` names its subject
  (frontmatter `message`) and the versions it was rendered with (frontmatter
  `rendered_with`, naming both the vibebiz and diagram-design versions), as in data-model.md
  "Diagram brief".

Passes trivially while no skill and no doc exist.
"""

import re
import shutil
import sys
import tempfile
import unittest
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path.insert(0, str(HERE))

from frontmatter import FrontmatterError, load  # noqa: E402

FIXTURES = HERE / "fixtures" / "docs_map"

SITUATION_MAP = "skills/help/situation-map.md"
COMMANDS = "docs/commands.md"
README_EN = "README.md"
README_VI = "README.vi.md"
WHAT_SHIPS = "what ships"
COMMAND_RE = re.compile(r"/vibebiz:([a-z][a-z0-9-]*)")
HEADING_RE = re.compile(r"^(#{1,6})\s+(.*?)\s*#*\s*$")
MD_IMAGE_RE = re.compile(r"!\[[^\]]*\]\(\s*<?([^)\s>]+)>?(?:\s+[\"'][^)]*[\"'])?\s*\)")
HTML_IMAGE_RE = re.compile(r"<img\b[^>]*?\bsrc\s*=\s*[\"']([^\"']+)[\"']", re.I)


def _lines_outside_fences(text):
    fence = False
    for line in text.split("\n"):
        if line.strip().startswith("```"):
            fence = not fence
            continue
        if not fence:
            yield line


def headings(text):
    """Return [(level, text, line index among non-fenced lines)]."""
    out = []
    for i, line in enumerate(_lines_outside_fences(text)):
        m = HEADING_RE.match(line)
        if m:
            out.append((len(m.group(1)), m.group(2), i))
    return out


def section(text, index):
    """Return the text of the section whose heading is headings(text)[index]."""
    lines = list(_lines_outside_fences(text))
    hs = headings(text)
    level, _, start = hs[index]
    end = len(lines)
    for lvl, _, pos in hs[index + 1 :]:
        if lvl <= level:
            end = pos
            break
    return "\n".join(lines[start + 1 : end])


def listed(text):
    """Commands named outside fenced code blocks."""
    return set(COMMAND_RE.findall("\n".join(_lines_outside_fences(text))))


def shipped_skills(root):
    folder = Path(root) / "skills"
    if not folder.is_dir():
        return set()
    return {p.name for p in folder.iterdir() if p.is_dir() and (p / "SKILL.md").is_file()}


def _compare(where, names, skills):
    problems = []
    for name in sorted(names - skills):
        problems.append(f"{where} lists /vibebiz:{name}, which is not a shipped skill")
    for name in sorted(skills - names):
        problems.append(f"{where} does not list /vibebiz:{name}")
    return problems


def _read(path):
    return path.read_text(encoding="utf-8") if path.is_file() else None


def _check_listings(root, skills):
    problems = []
    for rel in (SITUATION_MAP, COMMANDS):
        text = _read(root / rel)
        if text is None:
            if skills:
                problems.append(f"{rel} is missing")
            continue
        problems += _compare(rel, listed(text), skills)

    en, vi = _read(root / README_EN), _read(root / README_VI)
    if en is None and vi is None:
        if skills:
            problems.append(f"{README_EN} and {README_VI} are missing")
        return problems
    if en is None or vi is None:
        missing, present = (README_EN, README_VI) if en is None else (README_VI, README_EN)
        problems.append(f"{missing} is missing while {present} exists")
        return problems

    hs_en, hs_vi = headings(en), headings(vi)
    levels_en, levels_vi = [h[0] for h in hs_en], [h[0] for h in hs_vi]
    if levels_en != levels_vi:
        problems.append(
            f"{README_EN} and {README_VI} have different section structure: heading levels "
            f"{levels_en} vs {levels_vi}"
        )
    idx = next((i for i, h in enumerate(hs_en) if h[1].strip().lower() == WHAT_SHIPS), None)
    if idx is None:
        problems.append(f"{README_EN} has no \"What ships\" section")
        return problems
    problems += _compare(f'{README_EN} "What ships"', listed(section(en, idx)), skills)
    if levels_en == levels_vi:
        problems += _compare(f'{README_VI} "What ships" (section {idx + 1})', listed(section(vi, idx)), skills)
    return problems


def _doc_files(root):
    files = [root / README_EN, root / README_VI, root / SITUATION_MAP]
    docs = root / "docs"
    if docs.is_dir():
        files += sorted(docs.rglob("*.md"))
    return [f for f in files if f.is_file()]


def _check_images(root):
    problems = []
    for doc in _doc_files(root):
        text = "\n".join(_lines_outside_fences(doc.read_text(encoding="utf-8")))
        for target in MD_IMAGE_RE.findall(text) + HTML_IMAGE_RE.findall(text):
            if re.match(r"^(?:[a-z][a-z0-9+.-]*:|//|#)", target, re.I):
                continue
            clean = target.split("#", 1)[0].split("?", 1)[0]
            resolved = (root / clean.lstrip("/")) if clean.startswith("/") else (doc.parent / clean)
            if not resolved.is_file():
                problems.append(f"{doc.relative_to(root)} embeds {target}, which does not exist")
    return problems


def _check_briefs(root):
    problems = []
    folder = root / "docs" / "diagrams"
    if not folder.is_dir():
        return problems
    for brief in sorted(folder.glob("*.brief.md")):
        rel = brief.relative_to(root)
        try:
            data, _ = load(brief)
        except FrontmatterError as exc:
            problems.append(f"{rel}: {exc}")
            continue
        message = data.get("message")
        if not (isinstance(message, str) and message.strip()):
            problems.append(f"{rel}: brief does not name its subject (frontmatter 'message')")
        rendered = data.get("rendered_with")
        if not (isinstance(rendered, str) and all(
                re.search(rf"\b{name}\s+v?\d+\.\d+", rendered) for name in ("vibebiz", "diagram-design"))):
            problems.append(f"{rel}: brief does not name the vibebiz and diagram-design versions it was rendered with (frontmatter 'rendered_with')")
    return problems


def check_docs_map(path):
    """Return the docs-map problems of a repository root (empty list = pass)."""
    root = Path(path)
    skills = shipped_skills(root)
    return _check_listings(root, skills) + _check_images(root) + _check_briefs(root)


def _edit(rel, old, new):
    def apply(root):
        p = root / rel
        text = p.read_text(encoding="utf-8")
        assert old in text, (rel, old)
        p.write_text(text.replace(old, new), encoding="utf-8")
    return apply


def _remove(rel):
    return lambda root: (root / rel).unlink()


# Invalid fixtures: one change to a copy of fixtures/docs_map/valid_two_skills and the problem it must raise.
INVALID = {
    "map lists an unshipped skill": (
        _edit(SITUATION_MAP, "/vibebiz:continue", "/vibebiz:continue hoặc /vibebiz:package"),
        f"{SITUATION_MAP} lists /vibebiz:package, which is not a shipped skill",
    ),
    "commands misses a skill": (
        _edit(COMMANDS, "## /vibebiz:continue", "## Tiếp tục"),
        f"{COMMANDS} does not list /vibebiz:continue",
    ),
    "help SKILL.md ships but is not listed": (
        lambda root: (root / "skills" / "help" / "SKILL.md").write_text("# help\n", encoding="utf-8"),
        f"{SITUATION_MAP} does not list /vibebiz:help",
    ),
    "Vietnamese What ships misses a skill": (
        _edit(README_VI, "- `/vibebiz:continue`: làm tiếp một ý tưởng.\n", ""),
        f'{README_VI} "What ships" (section 5) does not list /vibebiz:continue',
    ),
    "English What ships lists outside the section": (
        _edit(README_EN, "- `/vibebiz:new`: start a new idea.\n", ""),
        f'{README_EN} "What ships" does not list /vibebiz:new',
    ),
    "README structures differ": (
        _edit(README_VI, "## Quyền riêng tư", "### Quyền riêng tư"),
        "have different section structure",
    ),
    "Vietnamese README missing": (_remove(README_VI), f"{README_VI} is missing while {README_EN} exists"),
    "no What ships section": (_edit(README_EN, "## What ships", "## Contents"), f'{README_EN} has no "What ships" section'),
    "missing image": (_remove("docs/diagrams/01-big-picture.svg"), "docs/quick-start.md embeds diagrams/01-big-picture.svg, which does not exist"),
    "missing html image": (
        _edit("docs/commands.md", "02-idea-journey.svg", "02-missing.svg"),
        "docs/commands.md embeds diagrams/02-missing.svg, which does not exist",
    ),
    "brief without subject": (
        _edit("docs/diagrams/01-big-picture.brief.md", "message: Ý tưởng mơ hồ thành hai đầu ra\n", ""),
        "01-big-picture.brief.md: brief does not name its subject",
    ),
    "brief without render version": (
        _edit("docs/diagrams/01-big-picture.brief.md", "rendered_with: vibebiz 0.1.0, diagram-design 1.0.0", "rendered_with: none"),
        "01-big-picture.brief.md: brief does not name the vibebiz and diagram-design versions",
    ),
    "brief with only the renderer version": (
        _edit("docs/diagrams/01-big-picture.brief.md", "rendered_with: vibebiz 0.1.0, diagram-design 1.0.0", "rendered_with: diagram-design 1.0.0"),
        "01-big-picture.brief.md: brief does not name the vibebiz and diagram-design versions",
    ),
}


class Fixtures(unittest.TestCase):
    def test_valid_fixtures_pass(self):
        for name in ("valid_empty", "valid_two_skills"):
            with self.subTest(name):
                self.assertEqual(check_docs_map(FIXTURES / name), [])

    def test_nothing_exists(self):
        with tempfile.TemporaryDirectory() as tmp:
            self.assertEqual(check_docs_map(tmp), [])

    def test_empty_repo_must_not_list_skills(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp) / "repo"
            shutil.copytree(FIXTURES / "valid_empty", root)
            _edit(README_EN, "Nothing ships yet.", "Try /vibebiz:new.")(root)
            problems = check_docs_map(root)
            self.assertIn(f'{README_EN} "What ships" lists /vibebiz:new, which is not a shipped skill', problems)

    def test_skills_without_docs(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            (root / "skills" / "new").mkdir(parents=True)
            (root / "skills" / "new" / "SKILL.md").write_text("# new\n", encoding="utf-8")
            problems = check_docs_map(root)
            self.assertIn(f"{SITUATION_MAP} is missing", problems)
            self.assertIn(f"{COMMANDS} is missing", problems)
            self.assertIn(f"{README_EN} and {README_VI} are missing", problems)

    def test_invalid_variants_report_the_problem(self):
        for name, (mutate, fragment) in INVALID.items():
            with self.subTest(name), tempfile.TemporaryDirectory() as tmp:
                root = Path(tmp) / "repo"
                shutil.copytree(FIXTURES / "valid_two_skills", root)
                mutate(root)
                problems = check_docs_map(root)
                self.assertTrue(any(fragment in p for p in problems), problems)


class RepositoryContent(unittest.TestCase):
    def test_repository(self):
        self.assertEqual(check_docs_map(ROOT), [])


if __name__ == "__main__":
    unittest.main()
