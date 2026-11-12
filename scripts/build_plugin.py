#!/usr/bin/env python3
"""Build the distributable plugin: dist/vibebiz/ and dist/vibebiz.plugin.

Python 3.10+ standard library only. See research R2 and R12.
"""
import argparse
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
BUILD_OUTPUTS = {"vibebiz", "vibebiz.plugin"}


def _ignore(_dir, names):
    return [n for n in names if n in EXCLUDED_NAMES or n.startswith(".git")]


def _copy_tree(src: Path, dst: Path) -> None:
    if src.is_dir():
        shutil.copytree(src, dst, ignore=_ignore, dirs_exist_ok=True)
    else:
        dst.mkdir(parents=True, exist_ok=True)


def build(out: Path, root: Path = ROOT) -> Path:
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

    for name in CONTENT_DIRS:
        _copy_tree(root / name, plugin / name)

    archive = out / "vibebiz.plugin"
    with zipfile.ZipFile(archive, "w", zipfile.ZIP_DEFLATED) as zf:
        for path in sorted(plugin.rglob("*")):
            if path.is_file():
                zf.write(path, path.relative_to(plugin).as_posix())
    return archive


def main(argv=None) -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--out", type=Path, default=ROOT / "dist", help="output directory (default: dist/)")
    args = parser.parse_args(argv)
    out = args.out.resolve()
    archive = build(out)
    print(f"built {out / 'vibebiz'} and {archive}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
