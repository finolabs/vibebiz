# Quickstart: Validating Idea to PRD

How to prove the feature works. Details of files and outputs are in `data-model.md` and `contracts/`; this guide only lists the runs and what each must show.

## Prerequisites

- Claude Code (development and evals), Claude Cowork desktop (smoke test), Python 3 standard library.
- Optional: the companion `diagram-design` plugin; a TypeSafe key for semantic graders (skipped without one); the Claude Agent SDK for Python, pinned in the eval harness's lockfile, for the simulated-persona suite.
- Heavy runs follow the machine's one-heavy-job rule; structural checks are light.

## 1. Structural checks (every change)

```bash
python3 -m unittest discover -s scripts/checks -p 'test_*.py'
```

Must pass: snapshot headings match Spec Kit 1.4.0 (`contracts/exports.md` "Snapshot"); every template and the fictional example satisfy `contracts/workspace-files.md`; `data.json` of the example passes the package check; framework cards carry every field; every entry skill appears in help's situation map and `docs/commands.md` and nothing else does; README pair has matching sections.

## 2. Build the plugin

```bash
python3 scripts/build_plugin.py
```

Produces `dist/vibebiz/` with six skills, each holding a copy of `core/` in `references/`, and `dist/vibebiz.plugin`. Check: no file under `dist/` references a path outside its own skill folder.

## 3. Plugin evals (Claude Code, headless)

Requires Claude Code 2.1.269 or later and Git 2.31 or later ([plugin evals documentation](https://code.claude.com/docs/en/plugin-evals.md), "Requirements"). From the repository root, after `python3 scripts/build_plugin.py`:

```bash
claude plugin eval . --ablation none --runs 3 --model <pinned-model> --max-cost-usd <ceiling> --trust-plugin --output-dir evals/results/<label>
```

Add `--case '<glob>'` or `--tag <tag>` for one suite, `--allow-tools "Bash(python3 scripts/checks/*)"` only for cases that need it, and `--json <path>.json` for a result document. Each case's `prompt.md` sets `plugins: ["../../dist/vibebiz"]` so the built plugin, not the source tree, is the one loaded (documented `plugins` field; add `--ablation with-without` to measure the no-plugin baseline). Cases live in `evals/<case>/` with `prompt.md` and `graders/*.md`; answers are embedded in each prompt. Thresholds are those in Appendix I; record results in `evals/RESULTS.md`.

Status: command and flags taken from the documentation on 12/11/2026; not yet run (a run starts model calls). Confirm at the first run that `.` resolves with the repository root as the target and the `plugins` override loads `dist/vibebiz/`; if not, use the case path as the target.

## 4. Simulated sessions (suite 8)

Run the persona harness in `evals/persona/` against three fashion ideas and two other retail ideas. Expected: readiness within four sessions; at least 85% of the hidden key facts present in `data.json`.

## 5. Spec Kit integration

Copy a snapshot into a scratch Spec Kit 1.4.0 project as a feature spec and run `/speckit-plan`. Expected: the plan generates without editing the snapshot.

```bash
python3 scripts/checks/speckit_integration.py examples/000-*/exports/spec.md
```

The script checks the snapshot structure first (exit 1, nothing created, when it fails), builds the scratch project under a temporary folder from read-only copies of this repository's `.specify/` templates and `.claude/skills/speckit-*` (the repository's own `.specify/` is never written), copies the snapshot to `specs/001-<slug>/spec.md`, points `.specify/feature.json` at it and prints the command to run, `cd <scratch> && claude -p '/speckit-plan'`, then the pass checks (`cmp` shows the snapshot unedited, `plan.md` exists and is not empty) and the cleanup. It starts no model itself; running the printed command is a model run, so run it as a heavy job and record it in `evals/RESULTS.md`. The same script serves the `evals/speckit-compat/` cases on the workspace they produce.

## 6. Cowork smoke test (before each release, by hand)

Upload `dist/vibebiz.plugin` in Cowork, open an empty folder, then:

| Step | Expected |
|---|---|
| `/vibebiz:idea` with a one-line fashion idea | workspace scaffolded; intake question in plain text; first round via the question tool with Skip shown |
| Skip one question, answer the rest | skipped category unchanged in `coverage.md` |
| Answer until the budget | offer to continue, pause or export a draft |
| `/vibebiz:status` | `index.html` lists the idea with coverage |
| `/vibebiz:package` on the example idea | private Artifact published; Slides and Docs written through the connectors; images inserted privately or replaced by table plus link |
| Package again | previous set moved to `exports/history/<date>/`; Artifact updated at the same link |
| `/vibebiz:help` "what can it do?" | answer cites the docs; unknown feature answered with "not covered" |
| Invoke a skill in claude.ai chat | message to open Cowork with a folder; nothing written |

Record the results of the two open checks in `CLAUDE.md` "Platform findings": the question tool's limits in Cowork, and private image insertion in Slides and Docs.
