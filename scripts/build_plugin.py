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
EXCLUDED_NAMES = {".DS_Store", ".gitkeep", ".specify", ".claude", "specs", "evals", "scripts", "__pycache__"}


def _ignore(_dir, names):
    return [n for n in names if n in EXCLUDED_NAMES or n.startswith(".git")]


def _copy_tree(src: Path, dst: Path) -> None:
    if src.is_dir():
        shutil.copytree(src, dst, ignore=_ignore, dirs_exist_ok=True)
    else:
        dst.mkdir(parents=True, exist_ok=True)


def build(out: Path, root: Path = ROOT) -> Path:
    """Replace `out` with a fresh build and return the plugin zip path."""
    if out.exists():
        shutil.rmtree(out)
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
