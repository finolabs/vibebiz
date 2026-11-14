#!/usr/bin/env python3
"""Build the distributable plugin: dist/vibebiz/ and dist/vibebiz.plugin.

With --skills, write the tracked .plugin-skills/ instead: the built skills every host manifest points at, so
the repository root installs as is (specs/003-multi-host/contracts/install-layout.md). test_build.py fails
when .plugin-skills/ differs from what this script would write.

With --fake-drive, also dist/vibebiz-fakedrive/: an eval-only copy that declares the fake Google
Drive MCP server from evals/fake-drive/ (evals/README.md "Fake Drive"). It is never shipped.

Python 3.10+ standard library only. See research R2 and R12.
"""
import argparse
import json
import shutil
import sys
import tempfile
import zipfile
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SKILLS_SRC = Path("src") / "skills"
PLUGIN_SKILLS = ".plugin-skills"
SKILLS = ["idea", "continue", "status", "package", "constitution", "help"]
CONTENT_DIRS = ["templates", "packs", "docs", "examples"]
# Development folders (.specify, .claude, specs, evals, scripts) sit at the repository root and are never
# copied; only these junk names are dropped at any depth, so nested content such as an example's specs/ ships.
EXCLUDED_NAMES = {".DS_Store", ".gitkeep", "__pycache__"}
BUILD_OUTPUTS = {"vibebiz", "vibebiz.plugin", "vibebiz-fakedrive"}
FAKE_DRIVE_SERVER = Path("evals") / "fake-drive" / "server.py"


def _ignore(_dir, names):
    return [n for n in names if n in EXCLUDED_NAMES or n.startswith(".git")]


def _copy_tree(src: Path, dst: Path) -> None:
    if src.is_dir():
        shutil.copytree(src, dst, ignore=_ignore, dirs_exist_ok=True)
    else:
        dst.mkdir(parents=True, exist_ok=True)


def lay_out_skills(dst: Path, root: Path = ROOT) -> None:
    """Write the six built skills into `dst`: each SKILL.md with its own copy of what it reads."""
    for skill in SKILLS:
        _copy_tree(root / SKILLS_SRC / skill, dst / skill)
        _copy_tree(root / "core", dst / skill / "references" / "core")
        # Templates too: a skill may only rely on files inside its own folder in Cowork.
        for shared in ("templates", "packs"):
            _copy_tree(root / shared, dst / skill / "references" / shared)
    # help answers only from the shipped docs and shows the example, so it carries its own copy of both.
    for shared in ("docs", "examples"):
        _copy_tree(root / shared, dst / "help" / "references" / shared)


def write_skills(dst: Path = None, root: Path = ROOT) -> Path:
    """Replace `dst` (default: <root>/.plugin-skills) whole with a fresh layout; refuse a path outside the repository."""
    root = root.resolve()
    dst = (dst or root / PLUGIN_SKILLS).resolve()
    if dst == root or not dst.is_relative_to(root):
        raise SystemExit(f"refused: {dst} is not a folder inside {root}")
    if dst.is_symlink() or (dst.exists() and not dst.is_dir()):
        raise SystemExit(f"refused: {dst} is not a folder")
    if dst.exists():
        shutil.rmtree(dst)
    dst.mkdir(parents=True)
    lay_out_skills(dst, root)
    return dst


def _files(folder: Path) -> dict:
    if not folder.is_dir():
        return {}
    return {p.relative_to(folder).as_posix(): p for p in folder.rglob("*")
            if p.is_file() and not any(part in EXCLUDED_NAMES for part in p.relative_to(folder).parts)}


def skills_drift(root: Path = ROOT) -> list:
    """Name every file under <root>/.plugin-skills that is missing, changed or extra against a fresh layout."""
    root = root.resolve()
    with tempfile.TemporaryDirectory() as tmp:
        fresh = Path(tmp) / "skills"
        fresh.mkdir()
        lay_out_skills(fresh, root)
        want, have = _files(fresh), _files(root / PLUGIN_SKILLS)
        problems = [f"missing: {PLUGIN_SKILLS}/{rel}" for rel in want.keys() - have.keys()]
        problems += [f"extra: {PLUGIN_SKILLS}/{rel}" for rel in have.keys() - want.keys()]
        problems += [f"changed: {PLUGIN_SKILLS}/{rel}" for rel in want.keys() & have.keys()
                     if want[rel].read_bytes() != have[rel].read_bytes()]
    return sorted(problems, key=lambda p: (p.split(": ", 1)[1], p))


def build(out: Path, root: Path = ROOT, fake_drive: bool = False) -> Path:
    """Replace `out` with a fresh build and return the plugin zip path."""
    out, root = out.resolve(), root.resolve()
    if out == root or out in root.parents:
        raise SystemExit(f"refused: output {out} contains the source tree")
    if out.exists() and not out.is_dir():
        raise SystemExit(f"refused: output {out} is not a folder")
    if out.exists():
        foreign = sorted(p.name for p in out.iterdir() if p.name not in BUILD_OUTPUTS)
        if foreign:
            raise SystemExit(f"refused: output {out} holds files that are not a previous build: {foreign}")
        for name in BUILD_OUTPUTS:
            target = out / name
            if target.is_dir() and not target.is_symlink():
                shutil.rmtree(target)
            elif target.exists() or target.is_symlink():
                target.unlink()
    plugin = out / "vibebiz"
    plugin.mkdir(parents=True)

    manifest = root / ".claude-plugin" / "plugin.json"
    if not manifest.is_file():
        raise SystemExit(f"missing manifest: {manifest}")
    (plugin / ".claude-plugin").mkdir()
    # The archive keeps its skills in the default skills/ folder, so its manifest drops the repository's
    # "skills" path (which points at .plugin-skills/).
    data = json.loads(manifest.read_text(encoding="utf-8"))
    data.pop("skills", None)
    (plugin / ".claude-plugin" / "plugin.json").write_text(json.dumps(data, indent=2, ensure_ascii=False) + "\n", encoding="utf-8")

    lay_out_skills(plugin / "skills", root)

    for name in CONTENT_DIRS:
        _copy_tree(root / name, plugin / name)
    # The README pair and the license ship with the plugin so an installed copy says what it is and its terms.
    for name in ("README.md", "README.vi.md", "LICENSE", "COMMERCIAL-LICENSE.md", "PRIVACY.md", "TERMS.md", "THIRD_PARTY_LICENSES.md"):
        if (root / name).is_file():
            shutil.copy2(root / name, plugin / name)

    archive = out / "vibebiz.plugin"
    with zipfile.ZipFile(archive, "w", zipfile.ZIP_DEFLATED) as zf:
        for path in sorted(plugin.rglob("*")):
            if path.is_file():
                zf.write(path, path.relative_to(plugin).as_posix())
    if fake_drive:
        _fake_drive_build(plugin, out / "vibebiz-fakedrive", root)
    return archive


def _fake_drive_build(plugin: Path, fake: Path, root: Path) -> None:
    """Copy the built plugin and add the fake Drive server for Drive-mode evals only."""
    server = root / FAKE_DRIVE_SERVER
    if not server.is_file():
        raise SystemExit(f"missing fake Drive server: {server}")
    shutil.copytree(plugin, fake)
    (fake / "srv" / "fake-drive").mkdir(parents=True)
    shutil.copy2(server, fake / "srv" / "fake-drive" / "server.py")
    config = {"mcpServers": {"google-drive": {
        "command": "python3", "args": ["-I", "${CLAUDE_PLUGIN_ROOT}/srv/fake-drive/server.py"]}}}
    (fake / ".mcp.json").write_text(json.dumps(config, indent=2) + "\n", encoding="utf-8")


def main(argv=None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--out", type=Path, default=ROOT / "dist", help="output directory (default: dist/)")
    parser.add_argument("--fake-drive", action="store_true",
                        help="also write the eval-only build with the fake Google Drive server")
    parser.add_argument("--skills", action="store_true",
                        help="write the tracked .plugin-skills/ in the repository instead of dist/")
    args = parser.parse_args(argv)
    if args.skills:
        print(f"wrote {write_skills()}")
        return 0
    out = args.out.resolve()
    archive = build(out, fake_drive=args.fake_drive)
    print(f"built {out / 'vibebiz'} and {archive}")
    if args.fake_drive:
        print(f"built {out / 'vibebiz-fakedrive'} (evals only, never ship)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
