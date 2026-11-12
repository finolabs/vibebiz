# Changelog

All notable changes to vibebiz are recorded here. The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and versions follow [Semantic Versioning](https://semver.org/). A change to the user workspace layout or file names is a breaking change and bumps the MAJOR version.

## [Unreleased]

## [0.1.0] - 2026-11-13

First public release. vibebiz is a Claude Cowork plugin that acts as a product owner for retail sales directors: it turns a vague idea about a system, an AI use or an automation into a clear, challenged and measurable PRD for the board and the tech team.

### Added

- Six entry skills: `new` (start an idea and clarify it in short rounds of questions), `continue` (pick up an idea, record board outcomes and the tech team's review), `status` (where every idea stands), `package` (board deck, tech PRD and links), `constitution` (ground rules for every idea in the workspace) and `help` (find the right command and explain the outputs).
- Shared modules: question protocol, clarify, specify, plan, analyze, checklist, anti-sycophancy challenge, router, workspace, writing rules, package and export guidelines, and the business lenses.
- Fifteen framework cards described in vibebiz's own words, with their origins credited, a retail-fashion pack (drivers, metrics, promotions, questions, traps) and a retail AI patterns pack.
- Board deck and tech PRD templates: self-contained HTML drawn from one `data.json`, with fixed infographic blocks, a source line on every slide, labels for estimates the tech team has not reviewed, and print layouts.
- A workspace table of contents (`index.html`) and a Spec Kit 1.4.0 compatible snapshot of each idea.
- Structural checks in code (`scripts/checks/`) and eval suites in `evals/`.
- Repository documents: license, commercial license, contributor agreement, privacy, security, terms, code of conduct, contribution guide, issue and pull request templates, third-party notices, upstream mapping, and the English and Vietnamese READMEs.

### Known gaps

- Eval coverage is partial. The trigger suite passed 7/7. One valid rerun covered six representative cases: two passed, and two scored 0.8 and 0.89. In the 0.8 case, a contradicting answer superseded an earlier decision without asking first. In the 0.89 case, the Spec Kit snapshot was not a byte-for-byte copy. The other suites have not been rerun after the grader fixes. `evals/RESULTS.md` records every run.
- In the headless eval, `package` wrote `data.json`, the links and the snapshot, but not the two HTML views. Without a shell, retyping the 100 KB templates is not feasible; with a shell, as in Cowork's VM, the skill now splices the data with a one-off command. This has not been run in Cowork yet.
- The Cowork smoke test (upload `vibebiz.plugin` in Cowork and run one idea end to end) has not been run for this version.
- The fictional example in `examples/000-giu-chan-khach-cu/` was assembled from an eval fixture and the board deck sample data, with the exports rendered from the templates; it is not the record of a live run.
- The ten documentation diagrams, the help eval suite and the Vietnamese wording pass on the docs are not included yet.
