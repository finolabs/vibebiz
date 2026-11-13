#!/usr/bin/env python3
"""Build the distributable plugin: dist/vibebiz/ and dist/vibebiz.plugin.

With --fake-drive, also dist/vibebiz-fakedrive/: an eval-only copy that declares the fake Google
Drive MCP server from evals/fake-drive/ (evals/README.md "Fake Drive"). It is never shipped.

Python 3.10+ standard library only. See research R2 and R12.
"""
import argparse
import json
import shutil
import sys
import zipfile
from pathlib import Path

ROOT = Path(__file__).resolve().parent.parent
SKILLS = ["new", "continue", "status", "package", "constitution", "help"]
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
    shutil.copy2(manifest, plugin / ".claude-plugin" / "plugin.json")

    for skill in SKILLS:
        _copy_tree(root / "skills" / skill, plugin / "skills" / skill)
        _copy_tree(root / "core", plugin / "skills" / skill / "references" / "core")
        # Templates too: a skill may only rely on files inside its own folder in Cowork.
        for shared in ("templates", "packs"):
            _copy_tree(root / shared, plugin / "skills" / skill / "references" / shared)
    # help answers only from the shipped docs and shows the example, so it carries its own copy of both.
    for shared in ("docs", "examples"):
        _copy_tree(root / shared, plugin / "skills" / "help" / "references" / shared)

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
    args = parser.parse_args(argv)
    out = args.out.resolve()
    archive = build(out, fake_drive=args.fake_drive)
    print(f"built {out / 'vibebiz'} and {archive}")
    if args.fake_drive:
        print(f"built {out / 'vibebiz-fakedrive'} (evals only, never ship)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
