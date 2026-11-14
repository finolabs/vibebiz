# Feature Specification: First-class vibebiz on Claude Code, Codex and Antigravity

**Feature Branch**: `003-multi-host`

**Created**: 2026-11-14

**Status**: Draft

**Input**: User description: "Next version (T061 in `specs/002-drive-workspace/tasks.md`): list vibebiz in the `finolabs/plugins` catalog and support Codex and Antigravity. A catalog installs the repository at a tag, but the skills only work from the build (`scripts/build_plugin.py` copies `core/`, `templates/` and `packs/` into each skill's `references/`), so first make a tagged tree installable on all three hosts and prove it with a real install." Then (Fio, 14/11/2026): "This version supports Codex and Antigravity officially", at parity with Cowork.

## Settled Decisions

- **Hosts** (Fio, 14/11/2026): this version supports Codex and Antigravity officially, besides Cowork and Claude Code, and vibebiz is listed in the `finolabs/plugins` catalog once it does. v0.1.4 stayed out of the catalog because an install from the repository would break (PR #16).
- **Parity with Cowork** (Fio, 14/11/2026, replacing the earlier "local folder only" default): on Codex and Antigravity vibebiz offers what it offers in Cowork, through each host's own tools: the local folder workspace, the Google Drive workspace, the board and tech views shown in the host's preview, and Google Slides and Docs. Where a host truly lacks a feature (a private Claude Artifact has no equivalent on Codex or Antigravity), vibebiz uses that host's nearest equivalent and says what differs (research R7).
- **Decide by tools, not by host name**: each run looks at the tools and skills the session actually has (a question tool, Google Drive, Slides and Docs, a preview) and picks the matching path. The same rule covers Claude Code, whose desktop app may expose the Artifact tool and Google connectors.
- **Order** (Fio, 14/11/2026): Antigravity is finished first; Codex follows. Both still ship together in v0.1.5.
- **Install layout** (Fio, 14/11/2026): as vietnamizer does. The built skills are tracked in `.plugin-skills/`, every host manifest points there, and the source skills move out of `skills/`. Every install also copies the development folders, which stay inert (research R2, R3). Probe T001 confirmed Claude Code loads exactly the six skills from `.plugin-skills/`.
- **Release**: ships as **v0.1.5**, staying on 0.1.x as Fio decided for 0.1.2. The workspace layout and file names do not change, so the change is compatible.
- **Constitution** (Fio approved, 14/11/2026): amended on this branch, first to 1.3.0 (local folder mode on other hosts), then to 1.4.0 for parity. The matching `CLAUDE.md` lines change with the implementation (tasks T028).

## Open Decisions

- **The catalog side** (owner: Fio): the `list-vibebiz` branch of `finolabs/plugins` (commit `c549f7d`, not reviewed after its last fix) is superseded once vibebiz ships all three manifests; the catalog change becomes a plain new entry in both catalogs. Whether to delete that branch is Fio's call. Unblocked when this feature is released.
- **Unattended tests on Codex and Antigravity** (owner: plan, by measurement): neither host answers its question tool in headless mode (`codex exec` refuses `request_user_input`; `agy -p` skips `ask_question`). Whether an app-server (Codex) or ACP (Antigravity) harness can answer questions decides how much of the eval suite can run there. Unblocked by tasks T003 and T006.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Install from the catalog and start an idea on Claude Code (Priority: P1)

A user of Claude Code adds the FINOLABS catalog, installs vibebiz by name, opens a folder and types `/vibebiz:idea` with a one-line idea. vibebiz sets up the workspace in that folder and runs the interview exactly as in Cowork desktop with a folder.

**Why this priority**: it is the install path the catalog promises, and the first proof that a tag installs as is.

**Independent Test**: On a machine without vibebiz, run the catalog's two Claude Code install commands, open an empty folder, run `/vibebiz:idea` with a fictional idea, answer one round, and check that the workspace and the idea folder exist with the answers recorded.

**Acceptance Scenarios**:

1. **Given** the catalog is added, **When** the user installs `vibebiz@finolabs`, **Then** the install succeeds from the pinned tag with no build step, and the six entry skills are available.
2. **Given** vibebiz is installed this way, **When** any entry skill runs, **Then** every instruction, template and pack it refers to is present in the installed copy.
3. **Given** an installed copy, **When** the host lists the plugin's skills, **Then** it shows exactly the six entry skills, never an unbuilt copy or a Spec Kit development skill.

---

### User Story 2 - The whole journey in Codex, in a folder (Priority: P1)

A user who works in Codex installs vibebiz from the same catalog, opens a folder, and takes an idea from `idea` through `continue` to `package`. Questions arrive through Codex's question tool when the session offers it, otherwise as short plain-text questions with numbered choices. The board and tech views are written in the idea's `exports/` folder and shown in Codex's preview.

**Why this priority**: Codex is half of the new reach, and the folder journey is what every other Codex story builds on.

**Independent Test**: In Codex, install vibebiz from the catalog, run the fictional example idea from `idea` to `package` in a scratch folder, check the workspace with the package check and the Spec Kit compatibility check, and see the board view in Codex's preview.

**Acceptance Scenarios**:

1. **Given** the catalog is added in Codex, **When** the user installs vibebiz, **Then** the install succeeds from the pinned tag and the six entry skills are available.
2. **Given** an interview round, **When** vibebiz asks its questions, **Then** it respects the host tool's limits (Codex: at most three questions and three options per call) by splitting the round, never by dropping a question, and keeps the protocol's rules.
3. **Given** an idea ready to package, **When** `package` runs, **Then** it writes `data.json`, `spec.md`, `links.md`, `board-deck.html` and `tech-prd.html` in `exports/`, offers to show the views in the host's preview, and the workspace passes the package check.

---

### User Story 3 - The whole journey in Antigravity, in a folder (Priority: P1)

A user of Antigravity installs vibebiz from its repository and does the same as in Story 2, with Antigravity's question tool and preview.

**Why this priority**: the second new host, at the same level as Codex.

**Independent Test**: As Story 2, with Antigravity's install command, question tool and preview.

**Acceptance Scenarios**:

1. **Given** Antigravity, **When** the user installs vibebiz from its repository at a release tag, **Then** the install succeeds with no build step and the six entry skills are available (as `/idea` and so on, without a plugin prefix; `help` and the docs say so).
2. **Given** an interview or a package run, **When** it completes, **Then** the workspace is the same as one made in Cowork desktop from the same answers, apart from the date and time stamps.

---

### User Story 4 - Keep ideas in Google Drive from Codex or Antigravity (Priority: P2)

A user whose Codex session has OpenAI's Google Drive plugin connected, or whose Antigravity has the official Google Drive plugin signed in, runs `/vibebiz:idea` without a folder open. vibebiz keeps the workspace in a Drive folder the user chooses, exactly as Cowork's Drive mode does, and the same workspace opens later from Cowork, Codex or Antigravity.

**Why this priority**: Drive mode is how ideas follow the user across devices; parity means it works on every host that can reach Drive.

**Independent Test**: In each host with its Google Drive integration connected and no folder open, start an idea, answer one round, then continue the same idea from Cowork on the web, and check the Drive folder against `specs/002-drive-workspace/contracts/drive-workspace.md`.

**Acceptance Scenarios**:

1. **Given** a host session with Google Drive tools and no folder open, **When** an entry skill starts, **Then** it uses Drive mode with the same rules as in Cowork: the user picks the folder, a shared folder is named and confirmed before the first write, files change only by replacement, and nothing is shared or made public.
2. **Given** a workspace made in Drive from one host, **When** the user continues on another host with Drive, **Then** vibebiz finds the same folder without asking where it is.
3. **Given** a host with neither a folder nor Drive tools, **When** an entry skill starts, **Then** it writes nothing and names that host's own ways forward (open a folder; connect its Google Drive integration).

---

### User Story 5 - Package to Google Slides and Docs from Codex or Antigravity (Priority: P2)

On Codex or Antigravity with Google Slides and Docs available, the user asks `package` for a deck in Google Slides and a PRD in Google Docs. vibebiz creates them in the user's own Drive, private, with the same content rules as in Cowork.

**Why this priority**: the board deck in Slides is what many directors present; parity covers it.

**Independent Test**: Package the example idea on each host with Slides and Docs available; open both files and check that every number matches `data.json`, that nothing is shared, and that no image was made public.

**Acceptance Scenarios**:

1. **Given** Slides and Docs available, **When** `package` writes them, **Then** they are created in the user's Drive, private, from `exports/data.json`, with gaps shown as "not yet clarified" and estimates labelled "not tech-reviewed".
2. **Given** a host whose Google integration cannot insert a private image, **When** a slide would need one, **Then** vibebiz uses a table plus a link, as in Cowork, and never makes a file public.
3. **Given** Slides or Docs are not available, **When** the user asks for them, **Then** vibebiz says how to connect that host's Google integration and offers the HTML views.

---

### User Story 6 - See the views where you work (Priority: P2)

After `package`, the user sees the board and tech views inside their host: a private Artifact in Cowork (and in Claude Code where the Artifact tool exists), Codex's preview or in-app browser, Antigravity's preview or built-in browser, or else the file path to open.

**Why this priority**: Artifacts are how Cowork users see the result; the other hosts need their nearest equivalent.

**Independent Test**: Package the example idea on each host and check that the views appear in that host's preview, or that the user is told exactly where the files are.

**Acceptance Scenarios**:

1. **Given** a host with a preview, **When** `package` finishes, **Then** the views are shown there from the files in `exports/`, and nothing is published or shared.
2. **Given** a host without a preview, **When** `package` finishes, **Then** vibebiz gives the paths of `board-deck.html` and `tech-prd.html` and says how to open them.

---

### User Story 7 - Every release stays installable (Priority: P1)

The maintainer changes a module in `core/` and opens a pull request. A check fails until the installable copy matches the sources, so a tag can never point at a tree that installs broken.

**Why this priority**: the v0.1.4 review found that a tag of this repository installs a broken plugin; the fix must stay fixed.

**Independent Test**: Change one line in a `core/` module without refreshing the installable copy and check that the repository's checks fail and name the stale file; refresh it and check that they pass.

**Acceptance Scenarios**:

1. **Given** a source change that is not reflected in the installable copy, **When** the checks run, **Then** they fail and name each out-of-date file.
2. **Given** the three plugin manifests, **When** the checks run, **Then** they fail unless name, version, description and keywords agree across them, and the description is 120 to 160 characters.
3. **Given** a release tag, **When** each host installs from it, **Then** the install works, and the result is recorded in `evals/RESULTS.md` before the catalog lists the tag.

### Edge Cases

- A user already has vibebiz from a synced upload in Claude Code and installs it from the catalog too: the docs say which copy to keep and how to remove the other.
- Antigravity imported an old vibebiz copy from Claude Code by itself (0.1.2, seen on the development machine): a repository install must replace it, or the docs must say how to remove it.
- Antigravity's built-in `/help` and vibebiz's `help` skill share a name: the user must still reach vibebiz's help.
- Codex offers its question tool only in some modes: without it, questions go as plain text with numbered choices, one round at a time, and the answers are recorded the same way.
- A host adds its own "Other" choice to every question: vibebiz still never adds one itself, and treats a free-text answer as in Cowork.
- Antigravity's Google plugins run their own command-line tool and need a shell, network and a Google sign-in: if any is missing, vibebiz says what is missing and offers the folder workspace or the HTML views; vibebiz itself still runs no script.
- Cowork users keep installing from the release's `vibebiz.plugin`; that archive is unchanged in content.
- The user opens a folder that already holds a vibebiz workspace made on another host: it continues as is, with no migration.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: A release tag of the repository MUST install as a working plugin on Claude Code, Codex and Antigravity with no build step on the user's side.
- **FR-002**: An installed copy MUST contain every file the six entry skills refer to, and the host MUST load exactly those six skills; development folders that land in the install folder MUST be inert (no skills, hooks or servers loaded from them).
- **FR-003**: The repository MUST ship a plugin manifest for each of the three hosts, with the same name, version, description and keywords; the description MUST be 120 to 160 characters.
- **FR-004**: The repository's checks MUST fail when the installable copy differs from its sources, and when the three manifests disagree.
- **FR-005**: On every supported host, all six entry skills MUST work in local folder mode with the same workspace layout and file names as Cowork desktop.
- **FR-006**: Questions MUST go through the host's question tool when the session has one, within that tool's limits and the interview protocol's rules (vibebiz adds no "None" or "Other", a skip leaves the category unchanged); a round larger than the tool allows is split; without a tool, questions go as plain text with numbered choices.
- **FR-007**: Drive mode MUST work on every host whose session has Google Drive tools, with the rules of `specs/002-drive-workspace/contracts/drive-workspace.md`, and a Drive workspace made on one host MUST open on the others.
- **FR-008**: `package` MUST create Google Slides and Docs on every host whose session can, private and from `exports/data.json`, under the same rules as in Cowork.
- **FR-009**: `package` MUST show the views in the host's preview where one exists (Artifact, Codex preview or in-app browser, Antigravity preview or browser), and otherwise give the file paths; nothing is published or shared.
- **FR-010**: vibebiz MUST choose each path by the tools and skills present in the session, not by the host's name, and when a feature is unavailable MUST say how to enable it on that host and offer the alternative, writing nothing the user did not agree to.
- **FR-011**: vibebiz MUST NOT require a shell or script itself; a host integration that runs its own tools (Antigravity's Google plugins) is the user's connector, used through that host's skills or tools.
- **FR-012**: The release archive `vibebiz.plugin` for Cowork MUST keep working as today.
- **FR-013**: The README pair, `docs/` and `help` MUST give, for each host, the install command, the skill name form, how to connect Google, and what differs from Cowork.
- **FR-014**: The constitution and the matching `CLAUDE.md` lines MUST allow parity on every supported host before implementation (Settled Decisions).
- **FR-015**: Each host's install from the release tag, and one run of the example idea in folder mode, Drive mode and Slides and Docs, MUST be done for real and recorded in `evals/RESULTS.md` before the catalog entry is proposed.

### Key Entities

- **Installable copy**: the tree a host installs from a tag; generated from the sources, never edited by hand.
- **Host manifest**: one per host, holding the shared name, version, description and keywords.
- **Capability map**: for each capability (question tool, Drive, Slides and Docs, preview), the tools or skills that provide it on each host and how vibebiz detects them (contracts/host-capabilities.md).
- **Catalog entry**: vibebiz's entry in `finolabs/plugins`, pinned to a release tag, proposed only after FR-015.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: On each of the three hosts, a new user goes from no vibebiz to the first interview question with at most the catalog's two install commands (one for Antigravity) and opening a folder.
- **SC-002**: The fictional example idea, run from `idea` to `package` on each host, passes the package check and the Spec Kit compatibility check, in folder mode and in Drive mode.
- **SC-003**: A Drive workspace started on any one host continues on each of the other two without the user saying where it is.
- **SC-004**: On each host with Slides and Docs, every number in the created deck and document matches `exports/data.json`, and no created file is shared or public.
- **SC-005**: The workspace and package eval cases pass on Claude Code at the same score as in 0.1.4; on Codex and Antigravity each case that the measured harness can run is run once and recorded, and no case fails because a referenced file is missing.
- **SC-006**: A deliberately stale installable copy fails the repository's checks in 100% of the test cases.
- **SC-007**: The `finolabs/plugins` checker, including its remote manifest check, passes with vibebiz pinned to the new tag.

## Assumptions

- Codex reaches Google Drive, Docs and Slides through OpenAI's Google Drive plugin (a ChatGPT connector); Antigravity through its official `gdrive`, `gdocs` and `gslides` plugins. Their exact tools and limits are measured in the plan (research R7).
- Codex's question tool is `request_user_input` (one to three questions, two or three options, offered only in some modes); Antigravity's is `ask_question` (multi-select, write-in, skip; maximums unknown). Both are measured at the first run.
- Neither host answers questions in headless mode; unattended tests there depend on the harness measured in T003 and T006.
- Cowork desktop and web keep working exactly as in 0.1.4.
