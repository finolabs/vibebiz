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

Run `claude plugin eval` against `dist/vibebiz/` (exact flags per the [plugin evals documentation](https://code.claude.com/docs/en/plugin-evals.md); confirm when the harness is set up). Suites in `evals/` (spec Appendix I, suites 1–7, 9, 10) with answers embedded in each prompt. Thresholds are those in Appendix I.

## 4. Simulated sessions (suite 8)

Run the persona harness in `evals/persona/` against three fashion ideas and two other retail ideas. Expected: readiness within four sessions; at least 85% of the hidden key facts present in `data.json`.

## 5. Spec Kit integration

Copy `examples/000-*/exports/spec.md` into a scratch Spec Kit 1.4.0 project as a feature spec and run `/speckit-plan`. Expected: the plan generates without editing the snapshot.

## 6. Cowork smoke test (before each release, by hand)

Upload `dist/vibebiz.plugin` in Cowork, open an empty folder, then:

| Step | Expected |
|---|---|
| `/vibebiz:new` with a one-line fashion idea | workspace scaffolded; intake question in plain text; first round via the question tool with Skip shown |
| Skip one question, answer the rest | skipped category unchanged in `coverage.md` |
| Answer until the budget | offer to continue, pause or export a draft |
| `/vibebiz:status` | `index.html` lists the idea with coverage |
| `/vibebiz:package` on the example idea | private Artifact published; Slides and Docs written through the connectors; images inserted privately or replaced by table plus link |
| Package again | previous set moved to `exports/history/<date>/`; Artifact updated at the same link |
| `/vibebiz:help` "what can it do?" | answer cites the docs; unknown feature answered with "not covered" |
| Invoke a skill in claude.ai chat | message to open Cowork with a folder; nothing written |

Record the results of the two open checks in `CLAUDE.md` "Platform findings": the question tool's limits in Cowork, and private image insertion in Slides and Docs.
