# Contributing to vibebiz

Thank you for helping. vibebiz is source-available (PolyForm Noncommercial 1.0.0 plus a commercial license), not open source. These rules keep the product coherent; the governing law is `.specify/memory/constitution.md`.

## Before you start

1. **Sign the CLA.** Every contribution is covered by `CLA.md`. Opening a pull request means you agree to it.
2. **Open an issue first** for anything larger than a typo, so the change can be matched to a spec in `specs/`. Features start from a spec (Spec Kit 1.4.0 is the development tool); the repository-wide rules are in `CLAUDE.md`.

## Rules for a change

- **Eval first.** A change to skill behavior starts from an eval case or fixture that fails for the reason the change addresses, and ends with that case passing. Structural properties (question counts, sections, cross-view numbers, index integrity, docs coverage) are checked in code.
- **Docs in the same change.** Update every description of what you changed: `README.md` and `README.vi.md`, `docs/`, affected diagram briefs, `help`'s situation map and the fictional example. Every entry skill appears in `help` and `docs/commands.md`, and nothing else does.
- **Exactly six entry skills** (`idea`, `continue`, `status`, `package`, `constitution`, `help`). Anything else is a module in `core/`, never a skill.
- **Own words.** Framework cards and packs describe third-party frameworks in vibebiz's own words and credit their origin in `THIRD_PARTY_LICENSES.md`. Never copy their text, layout or artwork.
- **No internal data.** No real people, companies, customers or figures; examples and fixtures are fictional or built from public knowledge. No secrets or env files.
- **Independence.** Do not reference or reuse `finolabs-vibecode` skills in the plugin. Do not copy `diagram-design` into the repository.
- **Dependencies.** Development tooling is Python 3.10+ standard library only. Pin anything you add and commit lockfiles.
- **Language.** Repository structure, file names and instruction prompts are English. Text for users is Vietnamese by default, plain and non-technical; edit it for natural wording.

## Set up and test

You need Python 3.10 or later and nothing else. From the repository root:

- `python3 scripts/build_plugin.py` builds `dist/vibebiz/` and `dist/vibebiz.plugin` (the build copies `core/`, `templates/` and `packs/` into each skill's `references/`).
- `python3 -m unittest scripts.checks.test_build` runs one check module; run the modules that cover the files you changed, for example `test_cards` for framework cards or `test_docs_map` for docs and help.
- `claude plugin validate dist/vibebiz` checks the built plugin when Claude Code is installed.
- Behavior evals live in `evals/`; `evals/README.md` lists the suites, their thresholds and how they run.

## Commits and pull requests

- Small, atomic, verb-led commits ("Add the pre-mortem card").
- Describe what changed, which spec or task it serves, and the checks you ran.
- Every pull request gets a review before merge. Findings are resolved or answered in the pull request.

## Releases

Maintainers cut versions with SemVer and a `CHANGELOG.md` entry. Before a release, everything that describes the product is reviewed against what ships.

## Conduct

See `CODE_OF_CONDUCT.md`. Security problems go through `SECURITY.md`, not public issues.
