"""Snapshot structure check (T012, contracts/exports.md "Snapshot").

The Spec Kit headings, subheadings and header lines are read at run time from
the pinned `.specify/templates/spec-template.md`; only vibebiz's own business
sections are named here.
"""

import re
import sys
import unittest
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path.insert(0, str(HERE))

TEMPLATE = ROOT / ".specify" / "templates" / "spec-template.md"
FIXTURES = HERE / "fixtures" / "snapshot"

# vibebiz's own sections, in order, before the Spec Kit sections: (heading, required).
BUSINESS_SECTIONS = [
    ("Problem & Why", True),
    ("Outcome", True),
    ("Alternatives", True),
    ("AI-fit", False),  # only when AI is involved
    ("Cost & Risk", True),
]
CLARIFICATIONS = "Clarifications"  # optional, after business sections, before Spec Kit's

_ID_RE = re.compile(r"\b(FR|SC)-([A-Za-z0-9]+)\b")
_ID_DEF_RE = re.compile(r"^\s*[-*]\s+\*\*((?:FR|SC)-[A-Za-z0-9]+)\*\*")
_PLACEHOLDER_RE = re.compile(r"\[[^\]]*\]|\d+")
_ANNOTATION_RE = re.compile(r"\s*\*\([^)]*\)\*\s*$")


def _visible_lines(text):
    """Yield (line_no, line) outside HTML comments and fenced code blocks."""
    in_comment = in_fence = False
    for no, line in enumerate(text.split("\n"), 1):
        stripped = line.strip()
        if in_fence:
            if stripped.startswith("```"):
                in_fence = False
            continue
        if in_comment:
            if "-->" in line:
                in_comment = False
                line = line.split("-->", 1)[1]
            else:
                continue
        if stripped.startswith("```"):
            in_fence = True
            continue
        while "<!--" in line:
            before, after = line.split("<!--", 1)
            if "-->" in after:
                line = before + after.split("-->", 1)[1]
            else:
                line = before
                in_comment = True
                break
        yield no, line


def _pattern(heading):
    """Turn a template heading into a regex: [placeholders] and numbers vary."""
    parts, pos = [], 0
    for m in _PLACEHOLDER_RE.finditer(heading):
        parts.append(re.escape(heading[pos : m.start()]))
        parts.append(r"\d+" if m.group(0)[0].isdigit() else r".+")
        pos = m.end()
    parts.append(re.escape(heading[pos:]))
    return "".join(parts)


def load_template(path=TEMPLATE):
    """Return the pinned template's structure."""
    title = None
    header_labels = []
    sections = []  # [{"heading": str, "subs": [{"text", "regex", "optional"}]}]
    for _, line in _visible_lines(Path(path).read_text(encoding="utf-8")):
        if line.startswith("# ") and title is None:
            title = _pattern(line[2:].strip())
        elif line.startswith("## "):
            sections.append({"heading": line[3:].strip(), "subs": []})
        elif line.startswith("### ") and sections:
            text = line[4:].strip()
            regex = _pattern(text)
            subs = sections[-1]["subs"]
            if any(s["regex"] == regex for s in subs):
                continue  # User Story 1, 2, 3 collapse into one pattern
            subs.append({
                "text": text,
                "regex": regex,
                "optional": "*(include if" in text,
            })
        elif not sections:
            m = re.match(r"^\*\*([^*]+)\*\*:", line)
            if m:
                header_labels.append(m.group(1))
    if title is None or not sections:
        raise ValueError(f"{path}: cannot read the Spec Kit structure")
    return {"title": title, "header_labels": header_labels, "sections": sections}


def _sub_matches(sub, text):
    if re.fullmatch(sub["regex"], text):
        return True
    # The italic template annotation (e.g. "*(include if ...)*") may be dropped.
    bare = _ANNOTATION_RE.sub("", sub["text"])
    return bare != sub["text"] and text == bare


def check_snapshot(path, template=None):
    """Return the problems in a snapshot or idea spec.md (empty list = pass)."""
    template = template or load_template()
    path = Path(path)
    try:
        text = path.read_text(encoding="utf-8")
    except (OSError, UnicodeDecodeError) as exc:
        return [f"{path}: cannot read: {exc}"]
    lines = list(_visible_lines(text))
    problems = []

    titles = [(no, l[2:].strip()) for no, l in lines if l.startswith("# ")]
    if not titles:
        problems.append("missing title line '# Feature Specification: <title>'")
    elif not re.fullmatch(template["title"], titles[0][1]):
        problems.append(f"line {titles[0][0]}: title does not match the template: {titles[0][1]!r}")

    h2 = [(no, l[3:].strip()) for no, l in lines if l.startswith("## ")]
    first_h2 = h2[0][0] if h2 else len(text.split("\n")) + 1
    header_text = "\n".join(l for no, l in lines if no < first_h2)
    for label in template["header_labels"]:
        if not re.search(r"^\*\*" + re.escape(label) + r"\*\*:", header_text, re.M):
            problems.append(f"missing header line '**{label}**:' before the first section")

    business = [name for name, _ in BUSINESS_SECTIONS]
    speckit = [s["heading"] for s in template["sections"]]
    order = business + [CLARIFICATIONS] + speckit
    seen = {}
    last_rank = -1
    for no, heading in h2:
        if heading not in order:
            near = [s for s in speckit if _ANNOTATION_RE.sub("", s) == _ANNOTATION_RE.sub("", heading)]
            if near:
                problems.append(f"line {no}: Spec Kit heading changed: {heading!r} must be {near[0]!r}")
            else:
                problems.append(f"line {no}: unexpected section {heading!r}")
            continue
        if heading in seen:
            problems.append(f"line {no}: section {heading!r} appears twice")
            continue
        seen[heading] = no
        rank = order.index(heading)
        if rank < last_rank:
            if heading in business:
                problems.append(f"line {no}: business section {heading!r} must come before the Spec Kit sections")
            else:
                problems.append(f"line {no}: section {heading!r} is out of order")
        last_rank = max(last_rank, rank)

    for name, required in BUSINESS_SECTIONS:
        if required and name not in seen:
            problems.append(f"missing business section '## {name}'")
    for heading in speckit:
        if heading not in seen:
            problems.append(f"missing Spec Kit section '## {heading}'")

    # Subheadings inside each Spec Kit section.
    by_heading = {s["heading"]: s for s in template["sections"]}
    current = None
    found = {}
    for no, line in lines:
        if line.startswith("## "):
            current = line[3:].strip() if line[3:].strip() in by_heading else None
            continue
        if current and line.startswith("### "):
            text_h3 = line[4:].strip()
            subs = by_heading[current]["subs"]
            idx = next((i for i, s in enumerate(subs) if _sub_matches(s, text_h3)), None)
            if idx is None:
                expected = ", ".join(repr(s["text"]) for s in subs) or "no subheadings"
                problems.append(f"line {no}: subheading {text_h3!r} under {current!r} does not match the template ({expected})")
                continue
            prev = found.get(current, [])
            if prev and idx < prev[-1]:
                problems.append(f"line {no}: subheading {text_h3!r} is out of template order")
            found.setdefault(current, []).append(idx)
    for heading, section in by_heading.items():
        if heading not in seen:
            continue
        for i, sub in enumerate(section["subs"]):
            if not sub["optional"] and i not in found.get(heading, []):
                problems.append(f"missing subheading '### {sub['text']}' under {heading!r}")

    # Requirement and success-criterion ids.
    defined = {}
    for no, line in lines:
        for m in _ID_RE.finditer(line):
            if not re.fullmatch(r"\d{3}", m.group(2)):
                problems.append(f"line {no}: id {m.group(0)!r} must be {m.group(1)}-### (three digits)")
        d = _ID_DEF_RE.match(line)
        if d and re.fullmatch(r"(FR|SC)-\d{3}", d.group(1)):
            if d.group(1) in defined:
                problems.append(f"line {no}: id {d.group(1)} defined twice (first at line {defined[d.group(1)]})")
            else:
                defined[d.group(1)] = no
    for kind in ("FR", "SC"):
        if not any(k.startswith(kind + "-") for k in defined):
            problems.append(f"no {kind}-### entry defined")
    return problems


class TemplateIsReadAtRunTime(unittest.TestCase):
    def test_template_structure(self):
        tpl = load_template()
        self.assertTrue(tpl["sections"], "no ## headings read from the template")
        self.assertTrue(tpl["header_labels"], "no **Label**: header lines read from the template")
        self.assertTrue(any(s["subs"] for s in tpl["sections"]))


class Fixtures(unittest.TestCase):
    EXPECTED = {
        "invalid_business_after_speckit.md": "business section 'Cost & Risk' must come before the Spec Kit sections",
        "invalid_heading_changed.md": "Spec Kit heading changed: 'Requirements' must be 'Requirements *(mandatory)*'",
        "invalid_missing_mandatory.md": "missing Spec Kit section '## Success Criteria *(mandatory)*'",
        "invalid_missing_business.md": "missing business section '## Outcome'",
        "invalid_bad_ids.md": "id 'FR-1' must be FR-### (three digits)",
        "invalid_duplicate_id.md": "id SC-001 defined twice",
        "invalid_user_story.md": "subheading 'User Story 1 - Nhắc khách cũ' under 'User Scenarios & Testing *(mandatory)*' does not match the template",
        "invalid_missing_subheading.md": "missing subheading '### Edge Cases'",
        "invalid_header.md": "missing header line '**Created**:'",
        "invalid_unexpected_section.md": "unexpected section 'Budget'",
    }

    def test_valid_fixtures_pass(self):
        valid = sorted(FIXTURES.glob("valid_*.md"))
        self.assertTrue(valid)
        for path in valid:
            with self.subTest(path.name):
                self.assertEqual(check_snapshot(path), [])

    def test_every_invalid_fixture_is_covered(self):
        self.assertEqual(sorted(p.name for p in FIXTURES.glob("invalid_*.md")), sorted(self.EXPECTED))

    def test_invalid_fixtures_report_the_problem(self):
        for name, fragment in self.EXPECTED.items():
            with self.subTest(name):
                problems = check_snapshot(FIXTURES / name)
                self.assertTrue(any(fragment in p for p in problems), problems)


class RepositoryContent(unittest.TestCase):
    def test_idea_template(self):
        path = ROOT / "templates" / "idea" / "spec.md"
        if not path.exists():
            self.skipTest("templates/idea/spec.md does not exist yet")
        self.assertEqual(check_snapshot(path), [])

    def test_examples(self):
        paths = sorted((ROOT / "examples").glob("000-*/spec.md")) + sorted(
            (ROOT / "examples").glob("000-*/exports/spec.md")
        )
        if not paths:
            self.skipTest("no example spec.md exists yet")
        for path in paths:
            with self.subTest(str(path.relative_to(ROOT))):
                self.assertEqual(check_snapshot(path), [])


if __name__ == "__main__":
    unittest.main()
