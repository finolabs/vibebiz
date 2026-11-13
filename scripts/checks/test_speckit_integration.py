"""Tests for speckit_integration.py (T063). No model is started."""

import contextlib
import io
import json
import shutil
import sys
import tempfile
import unittest
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path.insert(0, str(HERE))

import speckit_integration as si  # noqa: E402

FIXTURES = HERE / "fixtures" / "snapshot"


def run(*argv):
    out, err = io.StringIO(), io.StringIO()
    with contextlib.redirect_stdout(out), contextlib.redirect_stderr(err):
        code = si.main(list(argv))
    return code, out.getvalue(), err.getvalue()


def listing():
    return sorted(p.relative_to(ROOT).as_posix() for p in (ROOT / ".specify").rglob("*"))


class Integration(unittest.TestCase):
    def setUp(self):
        self.parent = Path(tempfile.mkdtemp(prefix="vibebiz-test-"))
        self.addCleanup(shutil.rmtree, self.parent, ignore_errors=True)
        self.before = listing()

    def test_valid_snapshot_builds_scratch_project(self):
        snap = FIXTURES / "valid_full.md"
        code, out, _ = run(str(snap), "--parent", str(self.parent))
        self.assertEqual(code, 0, out)
        projects = list(self.parent.glob("vibebiz-speckit-*"))
        self.assertEqual(len(projects), 1)
        project = projects[0]
        copied = next((project / "specs").glob("001-*/spec.md"))
        self.assertEqual(copied.read_bytes(), snap.read_bytes())
        self.assertEqual(copied.parent.name, "001-nhac-khach-cu-quay-lai-mua-hang")
        feature = json.loads((project / ".specify" / "feature.json").read_text())
        self.assertEqual(feature["feature_directory"], "specs/" + copied.parent.name)
        self.assertTrue((project / ".specify" / "templates" / "plan-template.md").is_file())
        self.assertTrue((project / ".claude" / "skills" / "speckit-plan" / "SKILL.md").is_file())
        constitution = (project / ".specify" / "memory" / "constitution.md").read_text()
        self.assertNotIn("vibebiz", constitution.lower())
        self.assertIn("/speckit-plan", out)
        self.assertIn(str(project), out)

    def test_invalid_snapshot_creates_nothing(self):
        code, out, _ = run(str(FIXTURES / "invalid_heading_changed.md"), "--parent", str(self.parent))
        self.assertEqual(code, 1)
        self.assertIn("Spec Kit heading changed", out)
        self.assertEqual(list(self.parent.iterdir()), [])

    def test_missing_file(self):
        code, _, err = run(str(self.parent / "nope.md"))
        self.assertEqual(code, 2)
        self.assertIn("not a file", err)

    def test_refuses_scratch_inside_repository(self):
        target = ROOT / "scratch-must-not-exist"
        self.addCleanup(shutil.rmtree, target, ignore_errors=True)
        code, _, err = run(str(FIXTURES / "valid_full.md"), "--parent", str(target))
        self.assertEqual(code, 2)
        self.assertIn("outside this repository", err)
        self.assertFalse(target.exists())

    def test_repository_specify_untouched(self):
        run(str(FIXTURES / "valid_full.md"), "--parent", str(self.parent))
        self.assertEqual(self.before, listing())
        self.assertFalse((ROOT / ".specify" / "feature.json").exists())

    def test_slugify(self):
        self.assertEqual(si.slugify("Nhắc khách cũ quay lại"), "nhac-khach-cu-quay-lai")
        self.assertEqual(si.slugify("Đổi trả"), "doi-tra")


if __name__ == "__main__":
    unittest.main()
