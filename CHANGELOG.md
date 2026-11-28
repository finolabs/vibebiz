# Changelog

All notable changes to vibebiz are recorded here. The format follows [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) and versions follow [Semantic Versioning](https://semver.org/). A change to the user workspace layout or file names is a breaking change and bumps the MAJOR version.

## [Unreleased]

## [0.1.10] - 2026-11-28

### Added

- At your first package, when diagrams cannot be drawn yet or Google Slides and Docs are not connected, vibebiz asks once whether to set that up ("Cài giúp tôi", "Để sau", "Không cần"); on a yes it installs the diagram plugin in Claude Code, Codex and Antigravity and the Google plugin in Codex and Antigravity, only from the official source, and elsewhere walks you through the steps. You always sign in to Google yourself. Your answer is kept in the workspace, so you are asked only once; "Để sau" brings one reminder line at the next package.
- Asking "what is set up?" tells you which of these are present in this session.

### Changed

- Missing information no longer holds an idea back from packaging: once you have answered what you can, gaps only someone else can fill go into the board deck and tech document as open questions with their owner, and `continue` fills them in later.
- A session keeps asking until its rounds are used instead of stopping after one round and telling you to come back.
- Asking what vibebiz is now opens with a short invitation: for anyone with a business or operations idea who is not sure they can write it up as a professional document.
- Once you choose which direction to try first (fix the process, buy, build), vibebiz goes on to scope, cost and the rest, even while figures behind that choice are still open questions; before, the interview stalled there and recommended pausing.
- When an answer someone else owed arrives, a point you chose to set aside stays set aside: vibebiz asks whether the answer changes it and reopens it only on your yes.
- The English README shows English versions of the six example decks and documents; the Vietnamese README keeps the Vietnamese originals.
- The privacy notice names the one exception to its network rule: after your yes, the app's own plugin install of a companion from its official source.

### Fixed

- In the tech document, a question left for you to confirm after a run nobody answered names the idea's owner ("chủ ý tưởng") instead of the bare field value `user`.

## [0.1.9] - 2026-11-27

### Added

- The framework library grows from 15 to 41 management methods (for example a driver tree, Kano, RACI, NPV and payback, a stage-gate rollout), written in vibebiz's own words. vibebiz still asks their questions in everyday words and names a method only in the board deck and the tech document.
- Planning methods (for example RACI, a build-buy-or-partner comparison, NPV) are chosen when the plan is built at packaging; asking for one by name during the interview records the request for packaging.
- A map in the docs shows which method feeds which, and when a method is applied again after an answer changes, the board asks for changes or the tech team reviews the estimates.

### Changed

- There is no longer a limit of two methods for each angle vibebiz looks at an idea from: a method is used only while that point is still open and no other method has covered it.
- The interview keeps going past a point that only someone outside the conversation can answer (for example a supplier's price): the points that depend on it are asked now and asked again when the answer arrives. When nothing else can be asked, vibebiz says who to ask and recommends pausing.

### Fixed

- Short progress notes while vibebiz works are now in your language too.
- In a Google Drive workspace, when the old copy of a replaced file cannot be moved to the trash, vibebiz says which file to trash yourself and keeps writing to the new copy; if you declined the trash, the run stops there.

## [0.1.8] - 2026-11-18

### Fixed

- When you do not know a figure about today or the past (for example how many customers come back), vibebiz no longer offers a guess of its own as an answer. It recommends a way to get the figure: measure it, ask the person who knows, or note it as an open question. Ranges appear only when they come from your own figures or the industry pack, never as the recommended choice.
- A slide or section of the package with nothing on file yet now names where it will be filled from, so the package check no longer rejects it.

## [0.1.7] - 2026-11-17

### Fixed

- When vibebiz asks whether to write a figure it found in one of your documents outside the idea folder, it records only the document's name and your decision, never the figure or the document's text, so a figure you declined does not reach a shared folder through the record of the question.

## [0.1.6] - 2026-11-15

### Fixed

- Before it hands over a package, vibebiz now searches every slide, the appendix and every section of the tech document for estimates, down to each line of a list, so no estimate goes out without the "not tech-reviewed" label. Checking how a view looks no longer counts as the check.
- Messages shown while vibebiz works no longer mention file names, file sizes or checks on files.
- vibebiz reads files from Google Drive as UTF-8 and reads a file again when its Vietnamese letters come out garbled, before quoting it in a question.
- The privacy notice and the question rules name the agent and documents of every supported app, not only Claude and Cowork.
- The privacy notice now names the one exception to writing only in your folders: the Google Slides and Docs vibebiz creates in the root of your My Drive when you ask for them.

### Added

- The FAQ explains why Cowork may ask before each "Trash file" when ideas are kept in Google Drive, and advises approving each one, because "Always allow" also covers files outside the idea folder.

## [0.1.5] - 2026-11-15

### Added

- vibebiz now runs in Claude Code, Codex and Antigravity as well as Cowork, with the same six commands, the same questions and the same workspace files. Each app is reached through its own tools: its question buttons, its folder or Google Drive, its Google Slides and Docs, and its way of showing pages. An idea started in one app continues in another that opens the same folder or the same Drive folder.
- Commands are named the way each app shows them: `/vibebiz:idea` in Cowork and Claude Code, `$idea` in Codex, `/idea` in Antigravity, where vibebiz's help is asked for in words because `/help` opens Antigravity's own help.
- Before it reports a package as done, vibebiz reads the files it wrote back and checks its closing message: commands in the app's form, no file names or `file://` links, terms in your language.
- The vibebiz icon, shown in the apps that display one.

### Changed

- vibebiz is described as a product owner for founders and business leaders who are not technical; retail stays the first supported industry.
- Questions use the app's own question tool. When the tool takes fewer questions at a time (Codex takes three), a round comes in two parts and no question is dropped; with no question tool, the round is asked in plain text with numbered choices.
- Where ideas are kept is chosen by what the app can reach: the open folder first, then Google Drive through the app's own Google integration (the Claude connector, OpenAI's Google Drive plugin in Codex, Antigravity's official Google plugins). With neither, vibebiz writes nothing and says how to open a folder or connect Google in that app.
- The board deck and the PRD are private Artifacts where the app has them, your own Google Slides and Docs when those are connected, and otherwise web pages in the idea folder; the closing message says where they are and how to open them. On Codex the Google paths follow OpenAI's documentation and were not tried with a real Google account.
- Requests such as "make the slides" or "put it in Google Docs" now go through `package` first, so the Google tools are used only from its steps.
- `idea` and `continue` always end with the round and then the table of contents, with every file named by its plain title.
- The README pair now opens with install-at-a-glance commands, first steps for a person, steps for an AI agent asked to install vibebiz, and the supported platforms, then the full install per app.
- The installed skills live in `.plugin-skills/`, built from `src/skills/`, and all three manifests point there; the Cowork archive holds the same tree. The FAQ explains what to do when Claude Code shows each command twice (a synced copy and a catalog copy), or when Antigravity already holds an older vibebiz copied from Claude Code.

### Fixed

- On Antigravity, when a Google plugin's setup fails to download its helper, vibebiz tries the Google command anyway and stops with a plain message if it is missing, instead of searching folders for it.

## [0.1.4] - 2026-11-14

### Changed

- The plugin description is shorter (137 characters), within the 120-160 characters the `finolabs/plugins` catalog takes. vibebiz is not in that catalog yet; install it from the latest release.

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
