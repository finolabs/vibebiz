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

- Not every eval suite in `evals/` has been run against this build; `evals/RESULTS.md` records which ran.
- The Cowork smoke test (upload `vibebiz.plugin` in Cowork and run one idea end to end) has not been run for this version.
- The ten documentation diagrams are not included yet.
