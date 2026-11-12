"""Structural checks on the built plugin (T004). Run:
python3 -m unittest discover -s scripts/checks -p 'test_build.py' -v
"""
import re
import sys
import tempfile
import unittest
import zipfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))
import build_plugin  # noqa: E402

SKILLS = {"new", "continue", "status", "package", "constitution", "help"}
DEV_DIRS = {".specify", ".claude", "specs", "evals", "scripts"}
JUNK = {".DS_Store", ".gitkeep", "__pycache__"}
MD_LINK = re.compile(r"\[[^\]]*\]\(([^)\s]+)(?:\s+\"[^\"]*\")?\)")
TICK_PATH = re.compile(r"`(references/[^`\s]+)`")


class BuildTest(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls._tmp = tempfile.TemporaryDirectory()
        cls.out = Path(cls._tmp.name) / "dist"
        cls.archive = build_plugin.build(cls.out)
        cls.plugin = cls.out / "vibebiz"

    @classmethod
    def tearDownClass(cls):
        cls._tmp.cleanup()

    def test_exactly_six_skills(self):
        names = {p.name for p in (self.plugin / "skills").iterdir() if p.is_dir()}
        self.assertEqual(names, SKILLS)

    def test_manifest_present(self):
        self.assertTrue((self.plugin / ".claude-plugin" / "plugin.json").is_file())

    def test_no_excluded_paths(self):
        top = {p.name for p in self.plugin.iterdir()}
        self.assertFalse(top & DEV_DIRS, f"development folder shipped: {top & DEV_DIRS}")
        for p in self.plugin.rglob("*"):
            rel = p.relative_to(self.plugin)
            bad = [part for part in rel.parts if part in JUNK or part.startswith(".git")]
            self.assertFalse(bad, f"excluded path shipped: {rel}")

    def test_nested_specs_folder_ships(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp) / "repo"
            (root / ".claude-plugin").mkdir(parents=True)
            (root / ".claude-plugin" / "plugin.json").write_text("{}")
            idea = root / "examples" / "000-sample" / "specs"
            idea.mkdir(parents=True)
            (idea / "note.md").write_text("x")
            (root / "specs").mkdir()
            (root / "specs" / "dev.md").write_text("x")
            build_plugin.build(Path(tmp) / "dist", root)
            plugin = Path(tmp) / "dist" / "vibebiz"
            self.assertTrue((plugin / "examples" / "000-sample" / "specs" / "note.md").is_file())
            self.assertFalse((plugin / "specs").exists())

    def test_refuses_to_delete_foreign_output(self):
        with tempfile.TemporaryDirectory() as tmp:
            out = Path(tmp) / "out"
            out.mkdir()
            (out / "keep.txt").write_text("x")
            with self.assertRaises(SystemExit):
                build_plugin.build(out)
            self.assertTrue((out / "keep.txt").is_file())
            with self.assertRaises(SystemExit):
                build_plugin.build(build_plugin.ROOT)

    def test_skill_references_resolve_inside_skill(self):
        for skill in sorted(SKILLS):
            folder = (self.plugin / "skills" / skill).resolve()
            doc = folder / "SKILL.md"
            if not doc.is_file():
                continue  # skeleton: skills are written by later tasks
            text = doc.read_text(encoding="utf-8")
            targets = list(TICK_PATH.findall(text))
            for link in MD_LINK.findall(text):
                if re.match(r"^([a-z][a-z0-9+.-]*:|#|/)", link, re.I):
                    continue
                targets.append(link)
            for target in targets:
                target = target.split("#", 1)[0]
                if not target:
                    continue
                resolved = (folder / target).resolve()
                self.assertTrue(resolved.is_relative_to(folder), f"{skill}: {target} leaves the skill folder")
                self.assertTrue(resolved.exists(), f"{skill}: {target} does not exist")

    def test_zip_matches_folder(self):
        with zipfile.ZipFile(self.archive) as zf:
            in_zip = {n for n in zf.namelist() if not n.endswith("/")}
        on_disk = {p.relative_to(self.plugin).as_posix() for p in self.plugin.rglob("*") if p.is_file()}
        self.assertEqual(in_zip, on_disk)

    def test_rebuild_replaces_output(self):
        stray = self.plugin / "stray.txt"
        stray.write_text("x")
        build_plugin.build(self.out)
        self.assertFalse(stray.exists())


if __name__ == "__main__":
    unittest.main()
