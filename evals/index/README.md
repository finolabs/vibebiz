# Table-of-contents cases (suite 7, user story 4)

Each case runs one entry skill (`idea`, `continue`, `status`, `package`, `constitution`, `help`) on a seeded fictional workspace and checks that `index.html` matches the folders afterwards. Seeded cases need `--scaffold`. Threshold: 100%.

Headless runs cannot run code, so the structure check runs after each case on the workspace it produced (`test_index.py` holds `check_index`, which also compares the list with the `specs/` and `examples/` folders):

```bash
python3 -c "import sys; sys.path.insert(0, 'scripts/checks'); from test_index import check_index; p = check_index('<workspace>/index.html'); print('\n'.join(p) or 'ok'); sys.exit(1 if p else 0)"
```

It prints the problems and exits 1, or prints `ok` and exits 0. A case passes only when its graders pass and this command prints `ok`.

| Case | Entry skill | What it checks |
|---|---|---|
| `idea-second-idea-listed` | idea | A second idea is created and listed beside the first. |
| `continue-round-rebuilds-index` | continue | After answers, idea 002's clear count in the index equals its `coverage.md`. |
| `status-excludes-example` | status | Real ideas listed with coverage and next step; the example is under `examples`, never an idea. |
| `package-sets-status-and-outputs` | package | Status `packaged` and links to the two exports. |
| `constitution-sets-ground-rules-status` | constitution | `ground_rules_status` flips from `deferred` to `set`. |
| `stale-index-rebuilt` | status | An index missing idea 002 with old counts and dates is rebuilt from the frontmatter (the seeded index fails the check on purpose). |
| `hand-edit-kept-and-listed` | continue | A hand edit survives and the index follows the edited files. |
| `help-writes-nothing` | help | No write; the seeded index is untouched and still valid. |
