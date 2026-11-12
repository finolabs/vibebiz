"""Package check (T061, contracts/exports.md "Package check").

Checks an idea's `exports/data.json` before any output is shown, and is also
used by the development tests and the packaging evals. Standard library only.

    python3 scripts/checks/package_check.py <idea-folder | data.json>

Exit 0 when no problem is found, 1 when there are problems (printed one per
line as `code: detail`), 2 when the input cannot be read.

Conventions this check relies on (the data contract leaves them open):

These match the export templates; contracts/exports.md "data.json
conventions" lists them.

* Required board slides: `n` = 1..9 and "appendix". Required tech sections:
  the ids in TECH_SECTIONS. A required slide or section that is not present
  must be listed in `gaps` as `{field, slide}` or `{field, section}`. A gap
  entry never switches off the other checks on an element that is present.
* A figure is referenced by id through a `{{<id>}}` token in any text, or
  through a `ref` field or a field ending in `_ref` (`to_ref`, `max_ref`,
  `threshold_ref`, `span_ref`, `ref_high` is read as well) anywhere inside a
  block (items, sides, lanes, children, target), or a `figure_id`, or the
  strings of a `refs` or `figure_ids` list. An entry with a `ref` may also
  repeat a `value`; it must equal the figures table entry.
* The infographic block types and forms carry required fields: `ratio`
  (ref; total 2 to 10), `tree` (root, children with labels), `journey`
  (steps, lanes with labels and one cell per step), a `gantt` timeline
  (lanes with labels and bars from <= to, positions from 1), a `gauge` meter
  (threshold_ref), a `donut` meter (ref), `controls` (items with text),
  `callout` (text), `deadline` (a valid YYYY-MM-DD date and a label), a chart
  `target` (ref). A missing one is `bad-block`.
* An estimate is a figure with `estimate: true` (the label `assumed` alone
  is not an estimate). While `idea.estimate_status` is `not-tech-reviewed`,
  every slide, section or block that references one carries
  `estimate_label: "not tech-reviewed"` (on the element itself or on its
  slide or section). Once `tech-reviewed`, that label must be gone.
* A chart is a block with `type: "chart"` and must name a non-empty `source`
  and a non-empty `period`.
* `frameworks[]` entries are non-empty names or objects with a non-empty
  `name`; a block with `type: "framework"` names its framework in `name`.
* A tech section holds its blocks in `content` (an array of blocks or a plain
  string); a board slide holds them in `blocks`.
* `links` keys: board_artifact, tech_artifact, slides, docs.
"""

import datetime
import json
import re
import sys
from pathlib import Path

SLIDES = [str(n) for n in range(1, 10)] + ["appendix"]
TECH_SECTIONS = [
    "business-context",
    "user-stories",
    "requirements",
    "key-entities",
    "success-criteria",
    "ai-fit",
    "non-functional",
    "glossary",
    "open-questions",  # one section holding blocking and non-blocking questions
]
TOP_KEYS = ["idea", "board", "tech", "numbers", "gaps", "links"]
IDEA_KEYS = ["id", "title", "language", "version", "draft", "estimate_status"]
STATUSES = ("not-tech-reviewed", "tech-reviewed")
LABELS = ("measured", "assumed")
ESTIMATE_LABEL = "not tech-reviewed"
LINK_KEYS = ["board_artifact", "tech_artifact", "slides", "docs"]

_FIG_TOKEN = re.compile(r"\{\{([A-Za-z0-9._-]+)\}\}")
_SPEC_ID = re.compile(r"\b(?:FR|SC)-[A-Za-z0-9]+\b")
_URL = re.compile(r"https?://[^\s)>\]\"']+")
_PUBLIC_FLAGS = {"public", "is_public", "shared", "publicly_shared", "share_public", "public_url"}
_PUBLIC_VALUES = {"public", "anyone", "anyone-with-link", "anyone_with_link", "link", "everyone"}
_SHARING_KEYS = {"visibility", "sharing", "access", "share", "permission", "permissions"}


def _blank(value):
    return not (isinstance(value, str) and value.strip())


def _gap_refs(data):
    """Slides and sections named by a `{field, slide}` / `{field, section}` gap."""
    refs = set()
    for gap in data.get("gaps") or []:
        if not isinstance(gap, dict):
            continue  # a plain string is a field name, not a slide or section
        if gap.get("slide") is not None:
            refs.add(f"slide:{str(gap['slide']).lower()}")
        if isinstance(gap.get("section"), str):
            refs.add(f"section:{gap['section']}")
    return refs


def _blocks_of(element):
    """The blocks of a slide (`blocks`) or tech section (`content` array)."""
    for key in ("blocks", "content"):
        if isinstance(element.get(key), list):
            return element[key]
    return []


_REF_KEY = re.compile(r"^(?:ref|figure_id|ref_high|[a-z]+(?:_[a-z]+)*_ref)$")
_REF_LIST_KEYS = ("refs", "figure_ids")
# Blocks whose `items` may be bare figure ids (the templates read them as {ref: id}).
_STRING_ITEM_TYPES = ("figures", "chart")


def _item_refs(node):
    """(figure_id, value_or_MISSING) named by the fields of one dict: `ref`,
    `*_ref`, `ref_high`, `figure_id`, and the strings of `refs` / `figure_ids`.
    Only an entry's own `ref` can carry a repeated `value`."""
    if not isinstance(node, dict):
        return
    for key, value in node.items():
        if isinstance(value, str) and _REF_KEY.match(key):
            yield value, (node.get("value", _MISSING) if key == "ref" else _MISSING)
        elif key in _REF_LIST_KEYS and isinstance(value, list) or (
                key == "items" and node.get("type") in _STRING_ITEM_TYPES and isinstance(value, list)):
            for fid in value:
                if isinstance(fid, str):
                    yield fid, _MISSING


_MISSING = object()


def _refs_in(node):
    """Figure ids referenced anywhere inside `node`, with any repeated value."""
    if isinstance(node, dict):
        yield from _item_refs(node)
        for value in node.values():
            yield from _refs_in(value)
    elif isinstance(node, list):
        for item in node:
            yield from _refs_in(item)
    elif isinstance(node, str):
        for fig in _FIG_TOKEN.findall(node):
            yield fig, _MISSING


def _own_refs(element):
    """Figure ids an element references directly, not through its blocks."""
    shallow = {k: v for k, v in element.items() if k not in ("blocks", "content") or not isinstance(v, list)}
    return {fig for fig, _ in _refs_in(shallow)}


def _pos(value):
    """A position on a Gantt axis: a whole number from 1."""
    return isinstance(value, int) and not isinstance(value, bool) and value >= 1


def _valid_date(value):
    if not (isinstance(value, str) and re.fullmatch(r"\d{4}-\d{2}-\d{2}", value)):
        return False
    try:
        datetime.date.fromisoformat(value)
    except ValueError:
        return False
    return True


def _labelled(entries):
    return isinstance(entries, list) and entries and all(
        isinstance(e, dict) and not _blank(e.get("label")) for e in entries)


def _block_problems(block):
    """Missing required fields of the infographic block types and forms."""
    btype, form = block.get("type"), block.get("form")
    out = []
    if btype == "ratio":
        if _blank(block.get("ref")):
            out.append("ratio needs ref")
        total = block.get("total")
        if total is not None and not (isinstance(total, int) and not isinstance(total, bool) and 2 <= total <= 10):
            out.append("ratio total must be a whole number from 2 to 10")
    elif btype == "tree":
        if _blank(block.get("root")):
            out.append("tree needs root")
        if not _labelled(block.get("children")):
            out.append("tree needs children, each with a label")
    elif btype == "journey":
        steps, lanes = block.get("steps"), block.get("lanes")
        if not (isinstance(steps, list) and steps and all(not _blank(s) for s in steps)):
            out.append("journey needs steps, each named")
        if not _labelled(lanes):
            out.append("journey needs lanes, each with a label")
        elif isinstance(steps, list) and any(
                not isinstance(lane.get("cells"), list) or len(lane["cells"]) != len(steps) for lane in lanes):
            out.append("journey needs one cell per step in every lane")
    elif btype == "timeline" and form == "gantt":
        lanes = block.get("lanes")
        if not _labelled(lanes):
            out.append("gantt timeline needs lanes, each with a label")
        else:
            bars = [b for lane in lanes for b in (lane.get("bars") if isinstance(lane.get("bars"), list) else [None])]
            if not bars or any(not isinstance(b, dict) or not _pos(b.get("from")) or not _pos(b.get("to"))
                               or b["from"] > b["to"] for b in bars):
                out.append("gantt timeline needs bars with from <= to, positions from 1")
        if any(isinstance(i, dict) and "at" in i and not _pos(i.get("at")) for i in block.get("items") or []):
            out.append("gantt decision point needs at, a position from 1")
    elif btype == "meter" and form == "gauge":
        if _blank(block.get("threshold_ref")):
            out.append("gauge meter needs threshold_ref")
    elif btype == "meter" and form == "donut":
        if _blank(block.get("ref")):
            out.append("donut meter needs ref")
    elif btype == "controls":
        items = block.get("items")
        if not (isinstance(items, list) and items and all(
                not _blank(i.get("text") if isinstance(i, dict) else i) for i in items)):
            out.append("controls needs items, each with text")
    elif btype == "callout":
        if _blank(block.get("text")):
            out.append("callout needs text")
    elif btype == "deadline":
        if not _valid_date(block.get("date")):
            out.append("deadline needs date as YYYY-MM-DD")
        if _blank(block.get("label")):
            out.append("deadline needs a label")
    elif btype == "chart" and "target" in block:
        target = block.get("target")
        if not isinstance(target, dict) or _blank(target.get("ref")):
            out.append("chart target needs ref")
    return out


def _walk(node, path=""):
    yield path, node
    if isinstance(node, dict):
        for key, value in node.items():
            yield from _walk(value, f"{path}.{key}" if path else key)
    elif isinstance(node, list):
        for i, value in enumerate(node):
            yield from _walk(value, f"{path}[{i}]")


def _is_estimate(figure):
    return figure.get("estimate") is True


def _has_estimate_label(element):
    label = element.get("estimate_label")
    return isinstance(label, str) and label.strip().lower() == ESTIMATE_LABEL


def check_data(data, spec_text=None, links_md=None):
    """Return the list of problems in a parsed data.json (empty when valid).

    `spec_text` (the idea's spec.md) enables the spec id lookup; `links_md`
    (the text of exports/links.md) enables the links comparison.
    """
    problems = []
    add = problems.append
    if not isinstance(data, dict):
        return ["bad-structure: data.json must be a JSON object"]
    for key in TOP_KEYS:
        if key not in data:
            add(f"bad-structure: missing top-level key {key}")
    idea = data.get("idea") if isinstance(data.get("idea"), dict) else {}
    for key in IDEA_KEYS:
        if key not in idea:
            add(f"bad-structure: missing idea.{key}")
    status = idea.get("estimate_status")
    if "estimate_status" in idea and status not in STATUSES:
        add(f"bad-estimate-status: {status!r} is not one of {', '.join(STATUSES)}")
    not_reviewed = status == "not-tech-reviewed"

    gaps = _gap_refs(data)
    board = data.get("board") if isinstance(data.get("board"), dict) else {}
    tech = data.get("tech") if isinstance(data.get("tech"), dict) else {}
    slides = [s for s in board.get("slides") or [] if isinstance(s, dict)]
    sections = [s for s in tech.get("sections") or [] if isinstance(s, dict)]

    # Figures table: required fields, duplicates.
    figures = {}
    for i, fig in enumerate(data.get("numbers") or []):
        if not isinstance(fig, dict) or _blank(fig.get("id")):
            add(f"bad-figure: numbers[{i}] has no id")
            continue
        fid = fig["id"]
        if fid in figures:
            if figures[fid].get("value") != fig.get("value"):
                add(f"figure-mismatch: {fid} is defined twice with different values "
                    f"({figures[fid].get('value')!r} and {fig.get('value')!r})")
            else:
                add(f"figure-duplicate: {fid} is defined twice in numbers")
            continue
        figures[fid] = fig
        if "value" not in fig or fig["value"] is None or fig["value"] == "":
            add(f"figure-incomplete: {fid} has no value")
        for field in ("source", "period"):
            if _blank(fig.get(field)):
                add(f"figure-incomplete: {fid} has no {field}")
        if fig.get("label") not in LABELS:
            add(f"figure-incomplete: {fid} label must be measured or assumed, "
                f"not {fig.get('label')!r}")

    # Required slides and sections: present or listed in gaps.
    seen_slides = {str(s.get("n")).lower(): s for s in slides}
    for n in SLIDES:
        if n not in seen_slides and f"slide:{n}" not in gaps:
            add(f"missing-slide: slide {n} is neither present nor listed in gaps")
    seen_sections = {s.get("id"): s for s in sections}
    for sid in TECH_SECTIONS:
        if sid not in seen_sections and f"section:{sid}" not in gaps:
            add(f"missing-section: section {sid} is neither present nor listed in gaps")

    spec_ids = set(_SPEC_ID.findall(spec_text)) if spec_text is not None else None

    def check_element(kind, name, element, is_slide):
        where = f"{kind} {name}"
        if is_slide:
            if _blank(element.get("title")):
                add(f"empty-title: {where} has no title")
            message = element.get("message")
            if _blank(message):
                add(f"no-message: {where} has no message")
            elif "messages" in element or "\n" in message.strip():
                add(f"many-messages: {where} carries more than one message")
        elif _blank(element.get("heading")):
            add(f"empty-title: {where} has no heading")
        sources = element.get("source_fields")
        if not isinstance(sources, list) or not [s for s in sources if not _blank(s)]:
            add(f"untraceable: {where} has no source_fields")
        elif spec_ids is not None:
            for src in sources:
                for cited in _SPEC_ID.findall(str(src)):
                    if cited not in spec_ids:
                        add(f"untraceable: {where} cites {cited}, which spec.md does not define")
        # Slides and tech sections both name their frameworks.
        frameworks = element.get("frameworks")
        if frameworks is not None and (
            not isinstance(frameworks, list)
            or any(_blank(f.get("name") if isinstance(f, dict) else f) for f in frameworks)
        ):
            add(f"unnamed-framework: {where} lists a framework without a name")
        blocks = _blocks_of(element)
        for j, block in enumerate(blocks):
            if not isinstance(block, dict):
                continue
            bwhere = f"{where} block {j + 1}"
            btype = block.get("type")
            if btype == "chart" and _blank(block.get("source")):
                add(f"unsourced-chart: {bwhere} is a chart without a source")
            if btype == "chart" and _blank(block.get("period")):
                add(f"chart-no-period: {bwhere} is a chart without a period")
            for problem in _block_problems(block):
                add(f"bad-block: {bwhere} {problem}")
            if (btype == "framework" or "framework" in block) and _blank(
                block.get("name") if btype == "framework" else block.get("framework")
            ):
                add(f"unnamed-framework: {bwhere} applies a framework without naming it")
        # Figure references and estimate labels.
        units = [(where, element, element)] + [
            (f"{where} block {j + 1}", b, element) for j, b in enumerate(blocks) if isinstance(b, dict)
        ]
        for uwhere, unit, parent in units:
            own = _own_refs(unit)
            for fid in sorted(own):
                if fid not in figures:
                    add(f"unknown-figure: {uwhere} references {fid}, which is not in numbers")
            estimates = [f for f in own if f in figures and _is_estimate(figures[f])]
            labelled = _has_estimate_label(unit) or _has_estimate_label(parent)
            if estimates and not_reviewed and not labelled:
                add(f"missing-estimate-label: {uwhere} shows estimate {', '.join(sorted(estimates))} "
                    f'without the "{ESTIMATE_LABEL}" label')
        # Repeated values must match the table.
        for fid, value in _refs_in_with_values(element):
            if fid in figures and value is not _MISSING and figures[fid].get("value") != value:
                add(f"figure-mismatch: {where} shows {fid} as {value!r}, numbers says "
                    f"{figures[fid].get('value')!r}")
        if status == "tech-reviewed":
            for _, node in _walk(element):
                if isinstance(node, dict) and _has_estimate_label(node):
                    add(f'stale-estimate-label: {where} still carries "{ESTIMATE_LABEL}" '
                        "although estimates are tech-reviewed")
                    break

    for slide in slides:
        check_element("slide", str(slide.get("n")).lower(), slide, True)
    for section in sections:
        check_element("section", section.get("id"), section, False)

    # Public sharing flags anywhere in the data.
    for path, node in _walk(data):
        if not isinstance(node, dict):
            continue
        for key, value in node.items():
            lowered = key.lower()
            if lowered in _PUBLIC_FLAGS and value not in (False, None, "", 0, "false"):
                add(f"public-sharing: {path or 'root'}.{key} is set; outputs are never public")
            elif lowered in _SHARING_KEYS and (value is True or (
                    isinstance(value, str) and value.strip().lower() in _PUBLIC_VALUES)):
                add(f"public-sharing: {path or 'root'}.{key} is {value!r}; outputs stay private")

    # links.md matches links.
    if links_md is not None:
        links = data.get("links") if isinstance(data.get("links"), dict) else {}
        wanted = {v.strip() for v in links.values() if isinstance(v, str) and v.strip()}
        found = {u.rstrip(".,;") for u in _URL.findall(links_md)}
        for url in sorted(wanted - found):
            add(f"links-mismatch: {url} is in data.json links but not in links.md")
        for url in sorted(found - wanted):
            add(f"links-mismatch: {url} is in links.md but not in data.json links")
    return problems


def _refs_in_with_values(node):
    """(figure_id, value) pairs where an items entry repeats a value."""
    if isinstance(node, dict):
        for fid, value in _item_refs(node):
            if value is not _MISSING:
                yield fid, value
        for value in node.values():
            yield from _refs_in_with_values(value)
    elif isinstance(node, list):
        for item in node:
            yield from _refs_in_with_values(item)


def check_path(path):
    """Check an idea folder or a data.json file; return the problem list."""
    path = Path(path)
    if path.is_dir():
        data_path = path / "exports" / "data.json"
        if not data_path.exists() and (path / "data.json").exists():
            data_path = path / "data.json"
    else:
        data_path = path
    try:
        data = json.loads(data_path.read_text(encoding="utf-8"))
    except FileNotFoundError:
        return [f"unreadable: {data_path} does not exist"]
    except (OSError, ValueError) as err:
        return [f"unreadable: {data_path} is not valid JSON ({err})"]
    spec_text = links_md = None
    exports = data_path.parent
    if path.is_dir():
        spec = path / "spec.md"
        if spec.exists():
            spec_text = spec.read_text(encoding="utf-8")
        links_file = exports / "links.md"
        if links_file.exists():
            links_md = links_file.read_text(encoding="utf-8")
        else:
            return check_data(data, spec_text, None) + ["links-mismatch: exports/links.md is missing"]
    return check_data(data, spec_text, links_md)


def main(argv=None):
    argv = sys.argv[1:] if argv is None else argv
    if len(argv) != 1:
        print("usage: package_check.py <idea-folder | data.json>", file=sys.stderr)
        return 2
    problems = check_path(argv[0])
    for problem in problems:
        print(problem)
    if problems and all(p.startswith("unreadable:") for p in problems):
        return 2
    return 1 if problems else 0


if __name__ == "__main__":
    sys.exit(main())
