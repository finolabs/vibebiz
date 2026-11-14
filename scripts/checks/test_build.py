"""Structural checks on the built plugin (T004). Run:
python3 -m unittest discover -s scripts/checks -p 'test_build.py' -v
"""
import json
import re
import sys
import tempfile
import unittest
import zipfile
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent.parent))
import build_plugin  # noqa: E402

SKILLS = {"idea", "continue", "status", "package", "constitution", "help"}
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

    def test_each_skill_holds_core_and_templates(self):
        for skill in SKILLS:
            refs = self.plugin / "skills" / skill / "references"
            for sub in ("core", "templates", "packs"):
                src = {q.relative_to(build_plugin.ROOT / sub).as_posix() for q in (build_plugin.ROOT / sub).rglob("*")
                       if q.is_file() and q.name not in JUNK}
                dst = {q.relative_to(refs / sub).as_posix() for q in (refs / sub).rglob("*") if q.is_file()}
                self.assertEqual(src, dst, f"{skill}: references/{sub} differs from {sub}/")

    def test_exactly_six_skills(self):
        names = {p.name for p in (self.plugin / "skills").iterdir() if p.is_dir()}
        self.assertEqual(names, SKILLS)

    def test_manifest_present(self):
        self.assertTrue((self.plugin / ".claude-plugin" / "plugin.json").is_file())

    def test_workspace_template_version_matches_manifest(self):
        # drive-workspace.md §1 step 5 reads this plugin's version from the template, so the two must agree.
        manifest = json.loads((self.plugin / ".claude-plugin" / "plugin.json").read_text(encoding="utf-8"))
        template = json.loads((build_plugin.ROOT / "templates" / "workspace" / "index.json").read_text(encoding="utf-8"))
        self.assertEqual(template["plugin_version"], manifest["version"])

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


class FakeDriveBuildTest(unittest.TestCase):
    """The eval-only build for Drive-mode cases (spec 002 T007, evals/README.md "Fake Drive")."""

    @classmethod
    def setUpClass(cls):
        cls._tmp = tempfile.TemporaryDirectory()
        cls.out = Path(cls._tmp.name) / "dist"
        cls.archive = build_plugin.build(cls.out, fake_drive=True)
        cls.plugin = cls.out / "vibebiz"
        cls.fake = cls.out / "vibebiz-fakedrive"

    @classmethod
    def tearDownClass(cls):
        cls._tmp.cleanup()

    def test_shipped_build_has_no_fake_drive(self):
        self.assertFalse((self.plugin / ".mcp.json").exists())
        for p in self.plugin.rglob("*"):
            self.assertNotIn("fake-drive", p.as_posix(), p)
        with zipfile.ZipFile(self.archive) as zf:
            names = zf.namelist()
        self.assertFalse([n for n in names if "fake-drive" in n or n.endswith(".mcp.json")], names)

    def test_each_skill_ships_the_index_json_template(self):
        for skill in SKILLS:
            self.assertTrue((self.plugin / "skills" / skill / "references" / "templates" / "workspace"
                             / "index.json").is_file(), skill)

    def test_fake_build_declares_the_google_drive_server(self):
        import json
        config = json.loads((self.fake / ".mcp.json").read_text(encoding="utf-8"))
        server = config["mcpServers"]["google-drive"]
        self.assertEqual(server["command"], "python3")
        self.assertIn("${CLAUDE_PLUGIN_ROOT}/srv/fake-drive/server.py", server["args"])
        self.assertTrue((self.fake / "srv" / "fake-drive" / "server.py").is_file())

    def test_fake_build_is_the_shipped_build_plus_the_server(self):
        shipped = {p.relative_to(self.plugin).as_posix() for p in self.plugin.rglob("*") if p.is_file()}
        fake = {p.relative_to(self.fake).as_posix() for p in self.fake.rglob("*") if p.is_file()}
        self.assertEqual(fake - shipped, {".mcp.json", "srv/fake-drive/server.py"})
        self.assertEqual(shipped - fake, set())

    def test_plain_rebuild_removes_the_fake_build(self):
        with tempfile.TemporaryDirectory() as tmp:
            out = Path(tmp) / "dist"
            build_plugin.build(out, fake_drive=True)
            build_plugin.build(out)
            self.assertFalse((out / "vibebiz-fakedrive").exists())


MANIFESTS = (".claude-plugin/plugin.json", ".codex-plugin/plugin.json", ".antigravity-plugin/plugin.json")
SHARED_FIELDS = ("name", "version", "description", "keywords", "license", "skills")


def _mini_repo(root: Path) -> Path:
    """A fictional repository with one source skill and one core module, for drift tests."""
    (root / ".claude-plugin").mkdir(parents=True)
    (root / ".claude-plugin" / "plugin.json").write_text("{}")
    (root / "src" / "skills" / "idea").mkdir(parents=True)
    (root / "src" / "skills" / "idea" / "SKILL.md").write_text("# idea\n")
    (root / "core").mkdir()
    (root / "core" / "workspace.md").write_text("# workspace\n")
    return root


class InstallLayoutTest(unittest.TestCase):
    """The repository root is the installable plugin (specs/003-multi-host/contracts/install-layout.md)."""

    def test_plugin_skills_is_current(self):
        self.assertEqual(build_plugin.skills_drift(), [], "regenerate with: python3 scripts/build_plugin.py --skills")

    def test_drift_names_missing_changed_and_extra_files(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = _mini_repo(Path(tmp) / "repo")
            build_plugin.write_skills(root=root)
            self.assertEqual(build_plugin.skills_drift(root), [])
            copy = root / ".plugin-skills"
            (copy / "idea" / "references" / "core" / "workspace.md").unlink()
            (copy / "idea" / "SKILL.md").write_text("# stale\n")
            (copy / "idea" / "extra.md").write_text("x")
            self.assertEqual(build_plugin.skills_drift(root), [
                "changed: .plugin-skills/idea/SKILL.md",
                "extra: .plugin-skills/idea/extra.md",
                "missing: .plugin-skills/idea/references/core/workspace.md",
            ])

    def test_source_change_without_regenerating_is_stale(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = _mini_repo(Path(tmp) / "repo")
            build_plugin.write_skills(root=root)
            (root / "core" / "workspace.md").write_text("# workspace, edited\n")
            self.assertIn("changed: .plugin-skills/idea/references/core/workspace.md", build_plugin.skills_drift(root))

    def test_write_skills_refuses_a_path_outside_the_repository(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = _mini_repo(Path(tmp) / "repo")
            for bad in (Path(tmp) / "elsewhere", root, root.parent):
                with self.assertRaises(SystemExit):
                    build_plugin.write_skills(bad, root=root)

    def test_no_root_skills_folder(self):
        self.assertFalse((build_plugin.ROOT / "skills").exists(), "a root skills/ folder would load beside .plugin-skills/")

    def test_manifests_agree(self):
        manifests = {}
        for rel in MANIFESTS:
            path = build_plugin.ROOT / rel
            self.assertTrue(path.is_file(), f"missing {rel}")
            manifests[rel] = json.loads(path.read_text(encoding="utf-8"))
        first = manifests[MANIFESTS[0]]
        for rel, data in manifests.items():
            self.assertEqual(data.get("skills"), "./.plugin-skills/", rel)
            for field in SHARED_FIELDS:
                self.assertEqual(data.get(field), first.get(field), f"{rel}: {field} differs from {MANIFESTS[0]}")
        self.assertTrue(120 <= len(first["description"]) <= 160, len(first["description"]))
        template = json.loads((build_plugin.ROOT / "templates" / "workspace" / "index.json").read_text(encoding="utf-8"))
        self.assertEqual(template["plugin_version"], first["version"])

    def test_archive_manifest_uses_the_default_skills_folder(self):
        # dist/vibebiz/ holds its skills in skills/, so its manifest must not point at .plugin-skills/.
        with tempfile.TemporaryDirectory() as tmp:
            build_plugin.build(Path(tmp) / "dist")
            data = json.loads((Path(tmp) / "dist" / "vibebiz" / ".claude-plugin" / "plugin.json").read_text(encoding="utf-8"))
            self.assertNotIn("skills", data)


if __name__ == "__main__":
    unittest.main()
