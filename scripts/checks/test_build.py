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
EXCLUDED = {".specify", ".claude", "specs", "evals", "scripts", ".DS_Store", ".gitkeep"}
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
        for p in self.plugin.rglob("*"):
            rel = p.relative_to(self.plugin)
            bad = [part for part in rel.parts if part in EXCLUDED or part.startswith(".git")]
            self.assertFalse(bad, f"excluded path shipped: {rel}")

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
