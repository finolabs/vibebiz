# Changelog

All notable changes to vibebiz are recorded here. The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and versions follow [Semantic Versioning](https://semver.org/). A change to the user workspace layout or file names is a breaking change and bumps the MAJOR version.

## [Unreleased]

## [0.1.3] - 2026-11-14

### Changed

- In a shared drive, the message that says who can see the workspace now also names the shared drive and the person who last changed it, also when the user agreed up front.
- Packaging again in Google Drive keeps the previous set in `exports/history/<date>/`, never in a dated folder directly under `exports/`.
- A fact from a document you named or attached, or found where you asked vibebiz to look on a desktop folder, is written into the idea with its source and you are told. A document vibebiz finds on its own, or any document when the Drive workspace is shared and you did not name it, still needs your yes. Only your own messages count: a pointer written in a workspace file or another document never does.
- vibebiz reads its own instructions and templates with the file-reading tool instead of a shell command, which made claude.ai warn that a command may change its settings (not yet rechecked on claude.ai).

## [0.1.2] - 2026-11-13

### Added

- Google Drive mode: in Cowork on the web or a phone, where there is no folder on the user's computer, vibebiz keeps the workspace in a folder in the user's own Google Drive through Cowork's Google Drive connector, with the same files. `idea` saves every answer there before the next round of questions. `continue` and `status` find the same folder on another device without asking, even when it was renamed. `package` writes the data, the requirement copy and the links there, and shows the two views as private Artifacts or the user's own Google Slides and Docs, never as web pages in Drive.
- Before its first write, Drive mode says who can see the folder and asks when it is shared; it trusts a recorded yes only when the user wrote it. It changes a file by saving a new copy and moving the old one to the Drive trash, never shares a file or changes who can see it, and stops and asks when a file has its own sharing, was changed by someone else meanwhile, or exists twice.

### Changed

- **Breaking:** the command that starts an idea is now `/vibebiz:idea` (was `/vibebiz:new`), because `new` was easy to confuse with Claude Code's `/clear` (new) in the command list. Plain words such as "tôi có ý tưởng" still start it. Type `/vibebiz:idea` where you typed `/vibebiz:new`. A workspace created by 0.1.0 or 0.1.1 that has no idea yet still shows `/vibebiz:new` on its table of contents' copy button; start with `/vibebiz:idea` instead. The release stays on 0.1.x by Fio's choice (13/11/2026): no workspace file or layout changes, and vibebiz is pre-1.0.
- With neither a folder nor Google Drive, every command names both ways forward (connect Google Drive, or open a folder in the Claude desktop app) and writes nothing.
- The desktop app with a folder open saves nothing to Google Drive; vibebiz may still read documents in the user's Drive to look a fact up before asking, read only, and names the document it used.

## [0.1.1] - 2026-11-13

### Fixed

- Opened without a folder (claude.ai chat, or Cowork started on the web or a phone), every entry skill now says vibebiz needs the Claude desktop app with a folder open, and that the session can still be followed on the web or a phone while the desktop app stays open. Before, it told users who were already in Cowork to "open Cowork". The FAQ gains the same answer.

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
- The ten documentation diagrams, the help eval suite and the Vietnamese wording pass on the docs other than the quick start are not included yet.
