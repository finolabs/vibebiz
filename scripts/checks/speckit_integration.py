#!/usr/bin/env python3
"""Spec Kit integration setup (T063, quickstart.md section 5).

Copies a packaged snapshot (`exports/spec.md`) into a scratch Spec Kit 1.4.0
project under a temporary folder and prints the command that runs
`/speckit-plan` there. It never starts a model itself and never writes inside
this repository: the scratch project is built from read-only copies of this
repository's `.specify/` templates and `.claude/skills/speckit-*`.

Usage:
    python3 scripts/checks/speckit_integration.py <snapshot-spec.md> [--parent <folder>]

Exit codes: 0 scratch project ready, 1 the snapshot fails the structure check
(nothing is created), 2 bad arguments or an unusable setup.

Standard library only.
"""

import argparse
import json
import re
import shutil
import subprocess
import sys
import tempfile
import unicodedata
from pathlib import Path

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[1]
sys.path.insert(0, str(HERE))

PINNED_VERSION = "1.4.0"
CONSTITUTION = """# Scratch project constitution

This folder is a throwaway project that only checks whether a packaged snapshot
can be planned with Spec Kit. It has no principles of its own; the plan's
constitution check passes trivially.
"""


def slugify(title):
    text = unicodedata.normalize("NFD", title.replace("đ", "d").replace("Đ", "D"))
    text = "".join(c for c in text if unicodedata.category(c) != "Mn")
    return re.sub(r"[^a-z0-9]+", "-", text.lower()).strip("-") or "feature"


def snapshot_title(text):
    m = re.search(r"^# Feature Specification:\s*(.+)$", text, re.M)
    return m.group(1).strip() if m else "feature"


def inside(path, folder):
    try:
        Path(path).resolve().relative_to(Path(folder).resolve())
        return True
    except ValueError:
        return False


def check_pinned_source(root):
    options = root / ".specify" / "init-options.json"
    try:
        version = json.loads(options.read_text(encoding="utf-8")).get("speckit_version")
    except (OSError, ValueError):
        version = None
    if version != PINNED_VERSION:
        raise SystemExit(f"error: {options} does not pin Spec Kit {PINNED_VERSION} (found {version!r})")


def build_scratch(snapshot, parent=None, root=ROOT):
    """Create the scratch project and return (project folder, feature folder)."""
    check_pinned_source(root)
    parent_dir = Path(parent).resolve() if parent else None
    if parent_dir is not None and inside(parent_dir, root):
        raise SystemExit("error: the scratch folder must be outside this repository")
    if parent_dir is not None:
        parent_dir.mkdir(parents=True, exist_ok=True)
    project = Path(tempfile.mkdtemp(prefix="vibebiz-speckit-", dir=parent_dir))
    if inside(project, root):
        shutil.rmtree(project)
        raise SystemExit("error: the scratch folder must be outside this repository")

    ignore = shutil.ignore_patterns("feature.json", "extensions.yml")
    shutil.copytree(root / ".specify", project / ".specify", ignore=ignore)
    (project / ".specify" / "memory" / "constitution.md").write_text(CONSTITUTION, encoding="utf-8")
    skills = project / ".claude" / "skills"
    skills.mkdir(parents=True)
    for skill in sorted((root / ".claude" / "skills").glob("speckit-*")):
        shutil.copytree(skill, skills / skill.name)

    text = Path(snapshot).read_text(encoding="utf-8")
    feature = project / "specs" / ("001-" + slugify(snapshot_title(text)))
    feature.mkdir(parents=True)
    shutil.copyfile(snapshot, feature / "spec.md")
    relative = feature.relative_to(project).as_posix()
    (project / ".specify" / "feature.json").write_text(
        json.dumps({"feature_directory": relative}, indent=2) + "\n", encoding="utf-8"
    )
    try:  # Spec Kit scripts look for a repository root; a plain git init satisfies them.
        subprocess.run(["git", "init", "-q", str(project)], check=True, capture_output=True)
    except (OSError, subprocess.CalledProcessError):
        pass
    return project, feature


def main(argv=None):
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("snapshot", help="path to the packaged snapshot (exports/spec.md)")
    ap.add_argument("--parent", help="folder to create the scratch project in (default: the system temp folder)")
    args = ap.parse_args(argv)

    snapshot = Path(args.snapshot)
    if not snapshot.is_file():
        print(f"error: {snapshot} is not a file", file=sys.stderr)
        return 2

    from test_snapshot import check_snapshot

    problems = check_snapshot(snapshot)
    if problems:
        print(f"The snapshot fails the Spec Kit structure check ({len(problems)} problems); nothing was created:")
        for p in problems:
            print(f"  - {p}")
        return 1

    try:
        project, feature = build_scratch(snapshot, args.parent)
    except SystemExit as exc:
        print(exc, file=sys.stderr)
        return 2

    print(f"Scratch Spec Kit {PINNED_VERSION} project: {project}")
    print(f"Feature folder: {feature.relative_to(project)} (spec.md is an unedited copy of the snapshot)")
    print()
    print("Run the plan step there (this starts a model run; it is not started here):")
    print(f"  cd '{project}' && claude -p '/speckit-plan'")
    print()
    print("Pass when plan.md is generated without editing spec.md:")
    print(f"  cmp '{snapshot}' '{feature / 'spec.md'}'")
    print(f"  test -s '{feature / 'plan.md'}'")
    print()
    print("Remove the scratch project afterwards:")
    print(f"  rm -rf '{project}'")
    return 0


if __name__ == "__main__":
    sys.exit(main())
