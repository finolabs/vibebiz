"""Table-of-contents data check (T014, data-model.md "Table of contents data"), and the Drive-mode
index.json (spec 002 T006)."""

import json
import re
import sys
import unittest
from datetime import date
from html.parser import HTMLParser
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path.insert(0, str(HERE))

FIXTURES = HERE / "fixtures" / "index"
WORKSPACE = HERE / "fixtures" / "workspace" / "valid"

BLOCK_ID = "vibebiz-data"
TOP_KEYS = ("workspace", "ideas", "examples")
WORKSPACE_KEYS = ("updated", "ground_rules_status")
IDEA_KEYS = ("id", "title", "status", "estimate_status", "coverage", "next_step", "outputs", "updated")
GROUND_RULES_STATUS = ("set", "deferred")
IDEA_STATUS = ("clarifying", "ready", "packaged", "presented", "approved", "rejected", "needs-changes")
ESTIMATE_STATUS = ("not-tech-reviewed", "tech-reviewed")
FOLDER_RE = re.compile(r"^(\d{3})-.+$")


class _Blocks(HTMLParser):
    def __init__(self):
        super().__init__(convert_charrefs=False)
        self.blocks = []  # (attrs, text)
        self._current = None

    def handle_starttag(self, tag, attrs):
        if tag == "script":
            attrs = dict(attrs)
            if attrs.get("id") == BLOCK_ID:
                self._current = [attrs, []]

    def handle_endtag(self, tag):
        if tag == "script" and self._current is not None:
            self.blocks.append((self._current[0], "".join(self._current[1])))
            self._current = None

    def handle_data(self, data):
        if self._current is not None:
            self._current[1].append(data)


def read_block(path):
    """Return (data, problems) for the vibebiz-data JSON block of an HTML file."""
    path = Path(path)
    try:
        text = path.read_text(encoding="utf-8")
    except (OSError, UnicodeDecodeError) as exc:
        return None, [f"{path}: cannot read: {exc}"]
    parser = _Blocks()
    parser.feed(text)
    parser.close()
    if not parser.blocks:
        return None, [f'no <script type="application/json" id="{BLOCK_ID}"> block']
    if len(parser.blocks) > 1:
        return None, [f"{len(parser.blocks)} blocks with id {BLOCK_ID}; expected exactly one"]
    attrs, body = parser.blocks[0]
    problems = []
    if attrs.get("type") != "application/json":
        problems.append(f'the {BLOCK_ID} block must have type="application/json"')
    try:
        data = json.loads(body)
    except json.JSONDecodeError as exc:
        return None, problems + [f"the {BLOCK_ID} block is not valid JSON: {exc}"]
    return data, problems


def _is_date(value):
    if not isinstance(value, str):
        return False
    try:
        date.fromisoformat(value)
    except ValueError:
        return False
    return bool(re.fullmatch(r"\d{4}-\d{2}-\d{2}", value))


def _check_keys(obj, keys, where):
    problems = [f"{where}: missing field {k!r}" for k in keys if k not in obj]
    problems += [f"{where}: unexpected field {k!r}" for k in obj if k not in keys]
    return problems


def _check_entry(item, where, example):
    if not isinstance(item, dict):
        return [f"{where}: must be an object"]
    problems = _check_keys(item, IDEA_KEYS, where)
    ident = item.get("id")
    if "id" in item:
        if not (isinstance(ident, str) and re.fullmatch(r"\d{3}", ident)):
            problems.append(f"{where}: id {ident!r} must be a three-digit string")
        elif example and ident != "000":
            problems.append(f"{where}: example id {ident!r} must be '000'")
        elif not example and ident == "000":
            problems.append(f"{where}: id '000' is reserved for examples")
    if "title" in item and not (isinstance(item["title"], str) and item["title"].strip()):
        problems.append(f"{where}: title must be non-empty text")
    if "status" in item and item["status"] not in IDEA_STATUS:
        problems.append(f"{where}: status {item['status']!r} is not one of {', '.join(IDEA_STATUS)}")
    if "estimate_status" in item and item["estimate_status"] not in ESTIMATE_STATUS:
        problems.append(f"{where}: estimate_status {item['estimate_status']!r} is not one of {', '.join(ESTIMATE_STATUS)}")
    if "coverage" in item:
        cov = item["coverage"]
        if not isinstance(cov, dict):
            problems.append(f"{where}: coverage must be an object {{clear, total}}")
        else:
            problems += _check_keys(cov, ("clear", "total"), f"{where}.coverage")
            clear, total = cov.get("clear"), cov.get("total")
            ints = all(isinstance(v, int) and not isinstance(v, bool) for v in (clear, total))
            if "clear" in cov and "total" in cov and (not ints or not 0 <= clear <= total):
                problems.append(f"{where}.coverage: clear and total must be integers with 0 <= clear <= total")
    if "next_step" in item and not isinstance(item["next_step"], str):
        problems.append(f"{where}: next_step must be text")
    if "outputs" in item and not isinstance(item["outputs"], list):
        problems.append(f"{where}: outputs must be a list")
    if "updated" in item and not _is_date(item["updated"]):
        problems.append(f"{where}: updated {item['updated']!r} must be a YYYY-MM-DD date")
    return problems


def _folders(root, sub):
    folder = Path(root) / sub
    if not folder.is_dir():
        return []
    return [p.name for p in sorted(folder.iterdir()) if p.is_dir() and not p.name.startswith(".")]


def check_data(data, workspace=None):
    """Return the problems of parsed table-of-contents data."""
    if not isinstance(data, dict):
        return ["the data block must be a JSON object"]
    problems = _check_keys(data, TOP_KEYS, "data")
    ws = data.get("workspace")
    if "workspace" in data:
        if not isinstance(ws, dict):
            problems.append("workspace: must be an object")
        else:
            problems += _check_keys(ws, WORKSPACE_KEYS, "workspace")
            if "updated" in ws and not _is_date(ws["updated"]):
                problems.append(f"workspace: updated {ws['updated']!r} must be a YYYY-MM-DD date")
            if "ground_rules_status" in ws and ws["ground_rules_status"] not in GROUND_RULES_STATUS:
                problems.append(
                    f"workspace: ground_rules_status {ws['ground_rules_status']!r} is not one of "
                    f"{', '.join(GROUND_RULES_STATUS)}"
                )
    for key in ("ideas", "examples"):
        if key in data and not isinstance(data[key], list):
            problems.append(f"{key}: must be a list")
    ideas = data.get("ideas") if isinstance(data.get("ideas"), list) else []
    examples = data.get("examples") if isinstance(data.get("examples"), list) else []
    for i, item in enumerate(ideas):
        problems += _check_entry(item, f"ideas[{i}]", example=False)
    for i, item in enumerate(examples):
        problems += _check_entry(item, f"examples[{i}]", example=True)

    listed = [item.get("id") for item in ideas if isinstance(item, dict)]
    for ident in sorted({x for x in listed if listed.count(x) > 1}, key=str):
        problems.append(f"ideas: id {ident!r} is listed more than once")

    if workspace is not None:
        present = {}
        for name in _folders(workspace, "specs"):
            m = FOLDER_RE.match(name)
            if m:
                present[m.group(1)] = name
        for ident, name in sorted(present.items()):
            if ident not in listed:
                problems.append(f"ideas: folder specs/{name} is not listed")
        for ident in listed:
            if isinstance(ident, str) and ident not in present:
                problems.append(f"ideas: id {ident!r} is listed but no specs/{ident}-<slug> folder exists")
        example_folders = [n for n in _folders(workspace, "examples") if FOLDER_RE.match(n)]
        if len(examples) != len(example_folders):
            problems.append(
                f"examples: lists {len(examples)} entries but examples/ holds {len(example_folders)} folders"
            )
    return problems


def check_index(path, workspace=None):
    """Return the problems of an index.html (empty list = pass).

    With ``workspace`` (default: the folder holding ``path``), the block must
    list exactly the idea and example folders present.
    """
    path = Path(path)
    data, problems = read_block(path)
    if data is None:
        return problems
    return problems + check_data(data, path.parent if workspace is None else workspace)


DRIVE_KEYS = ("vibebiz", "storage", "toc_artifact", "plugin_version", "shared_ack")
SHARED_ACK_KEYS = ("date", "who", "ids")
HTML_VIEWS = ("board-deck.html", "tech-prd.html")
VERSION_RE = re.compile(r"^\d+\.\d+\.\d+(?:-[0-9A-Za-z.-]+)?$")


def check_index_json(path, workspace=None):
    """Return the problems of a Drive-mode index.json (empty list = pass).

    Same table-of-contents rules as the index.html block, plus the Drive fields of
    specs/002-drive-workspace/data-model.md "index.json".
    """
    path = Path(path)
    try:
        data = json.loads(path.read_text(encoding="utf-8"))
    except (OSError, UnicodeDecodeError) as exc:
        return [f"{path}: cannot read: {exc}"]
    except json.JSONDecodeError as exc:
        return [f"{path.name} is not valid JSON: {exc}"]
    if not isinstance(data, dict):
        return ["index.json must be a JSON object"]
    problems = [f"data: missing field {k!r}" for k in DRIVE_KEYS if k not in data]
    if "vibebiz" in data and data["vibebiz"] != "workspace":
        problems.append("vibebiz: must be 'workspace' (the marker discovery looks for)")
    if "storage" in data and data["storage"] != "drive":
        problems.append("storage: must be 'drive'")
    toc = data.get("toc_artifact")
    if "toc_artifact" in data and toc is not None and not (isinstance(toc, str) and toc.startswith("https://")):
        problems.append("toc_artifact: must be a link or null")
    version = data.get("plugin_version")
    if "plugin_version" in data and not (isinstance(version, str) and VERSION_RE.match(version)):
        problems.append(f"plugin_version {version!r} must be a version such as 0.1.2")
    ack = data.get("shared_ack")
    if ack is not None:
        if not isinstance(ack, dict):
            problems.append("shared_ack: must be an object or null")
        else:
            problems += _check_keys(ack, SHARED_ACK_KEYS, "shared_ack")
            if "date" in ack and not _is_date(ack["date"]):
                problems.append(f"shared_ack: date {ack['date']!r} must be a YYYY-MM-DD date")
            for key in ("who", "ids"):
                value = ack.get(key)
                if key in ack and not (isinstance(value, list) and value
                                       and all(isinstance(v, str) and v.strip() for v in value)):
                    problems.append(f"shared_ack.{key}: must be a non-empty list of text")
            for key in ("who", "ids"):
                if isinstance(ack.get(key), list) and any("@" in str(v) for v in ack[key]):
                    problems.append(f"shared_ack.{key}: must not hold an email address (show names, compare ids)")
    toc_data = {k: v for k, v in data.items() if k not in DRIVE_KEYS}
    problems += check_data(toc_data, path.parent if workspace is None else workspace)
    for key in ("ideas", "examples"):
        items = data.get(key) if isinstance(data.get(key), list) else []
        for i, item in enumerate(items):
            outputs = item.get("outputs") if isinstance(item, dict) else None
            for out in outputs if isinstance(outputs, list) else []:
                # Outputs are {label, href} objects (core/workspace.md) or plain strings.
                href = out.get("href") if isinstance(out, dict) else out
                name = href.rsplit("/", 1)[-1] if isinstance(href, str) else None
                if name in HTML_VIEWS:
                    problems.append(f"{key}[{i}].outputs: Drive mode never stores {name} (spec 002 FR-009)")
    return problems


class Fixtures(unittest.TestCase):
    EXPECTED = {
        "invalid_no_block.html": f'no <script type="application/json" id="{BLOCK_ID}"> block',
        "invalid_json.html": "is not valid JSON",
        "invalid_type.html": 'must have type="application/json"',
        "invalid_missing_idea.html": "folder specs/002-bao-cao-ban-hang-tuan is not listed",
        "invalid_extra_idea.html": "id '003' is listed but no specs/003-<slug> folder exists",
        "invalid_duplicate_idea.html": "id '001' is listed more than once",
        "invalid_missing_field.html": "ideas[1]: missing field 'next_step'",
        "invalid_status.html": "ideas[0]: status 'done' is not one of",
        "invalid_estimate_status.html": "estimate_status 'reviewed' is not one of",
        "invalid_coverage.html": "ideas[1].coverage: clear and total must be integers with 0 <= clear <= total",
        "invalid_ground_rules.html": "ground_rules_status 'unknown' is not one of",
        "invalid_examples.html": "examples: lists 0 entries but examples/ holds 1 folders",
        "invalid_date.html": "workspace: updated '12/11/2026' must be a YYYY-MM-DD date",
    }

    def test_valid_workspace_index_passes(self):
        self.assertEqual(check_index(WORKSPACE / "index.html"), [])

    def test_every_invalid_fixture_is_covered(self):
        self.assertEqual(sorted(p.name for p in FIXTURES.glob("invalid_*.html")), sorted(self.EXPECTED))

    def test_invalid_fixtures_report_the_problem(self):
        for name, fragment in self.EXPECTED.items():
            with self.subTest(name):
                problems = check_index(FIXTURES / name, workspace=WORKSPACE)
                self.assertTrue(any(fragment in p for p in problems), problems)


class RepositoryContent(unittest.TestCase):
    def test_workspace_template_block_parses(self):
        path = ROOT / "templates" / "workspace" / "index.html"
        if not path.exists():
            self.skipTest("templates/workspace/index.html does not exist yet")
        data, problems = read_block(path)
        self.assertEqual(problems, [])
        self.assertIsNotNone(data)


class DriveIndex(unittest.TestCase):
    """index.json, the Drive-mode table-of-contents data (spec 002 data-model "index.json")."""

    EXPECTED = {
        "invalid_index_json.json": "is not valid JSON",
        "invalid_index_marker.json": "vibebiz: must be 'workspace'",
        "invalid_index_storage.json": "storage: must be 'drive'",
        "invalid_index_missing_field.json": "data: missing field 'plugin_version'",
        "invalid_index_version.json": "plugin_version 'latest' must be a version",
        "invalid_index_toc.json": "toc_artifact: must be a link or null",
        "invalid_index_shared_ack_email.json": "shared_ack.who: must not hold an email address",
        "invalid_index_shared_ack_shape.json": "shared_ack: missing field 'ids'",
        "invalid_index_shared_ack_id_email.json": "shared_ack.ids: must not hold an email address",
        "invalid_index_html_output.json": "ideas[0].outputs: Drive mode never stores board-deck.html",
        "invalid_index_html_path.json": "ideas[0].outputs: Drive mode never stores tech-prd.html",
        "invalid_index_missing_idea.json": "folder specs/002-bao-cao-ban-hang-tuan is not listed",
    }

    def test_valid_index_json_passes(self):
        for name in ("valid_index.json", "valid_index_shared.json"):
            with self.subTest(name):
                self.assertEqual(check_index_json(FIXTURES / name, workspace=WORKSPACE), [])

    def test_every_invalid_fixture_is_covered(self):
        self.assertEqual(sorted(p.name for p in FIXTURES.glob("invalid_index_*.json")), sorted(self.EXPECTED))

    def test_invalid_fixtures_report_the_problem(self):
        for name, fragment in self.EXPECTED.items():
            with self.subTest(name):
                problems = check_index_json(FIXTURES / name, workspace=WORKSPACE)
                self.assertTrue(any(fragment in p for p in problems), problems)

    def test_template_passes_on_an_empty_workspace(self):
        path = ROOT / "templates" / "workspace" / "index.json"
        self.assertTrue(path.is_file(), "templates/workspace/index.json is missing")
        self.assertEqual(check_index_json(path, workspace=HERE / "fixtures" / "index"), [])
        data = json.loads(path.read_text(encoding="utf-8"))
        self.assertEqual((data["ideas"], data["examples"], data["toc_artifact"], data["shared_ack"]),
                         ([], [], None, None))


if __name__ == "__main__":
    unittest.main()
