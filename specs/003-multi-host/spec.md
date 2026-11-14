# Feature Specification: Install from the catalog on Claude Code, Codex and Antigravity

**Feature Branch**: `003-multi-host`

**Created**: 2026-11-14

**Status**: Draft

**Input**: User description: "Next version (T061 in `specs/002-drive-workspace/tasks.md`): list vibebiz in the `finolabs/plugins` catalog and support Codex and Antigravity. A catalog installs the repository at a tag, but the skills only work from the build (`scripts/build_plugin.py` copies `core/`, `templates/` and `packs/` into each skill's `references/`), so first make a tagged tree installable on all three hosts and prove it with a real install."

## Settled Decisions

- **Hosts** (Fio, 14/11/2026): the next version supports Codex and Antigravity besides Claude, and vibebiz is listed in the `finolabs/plugins` catalog once it does. v0.1.4 deliberately stayed out of the catalog because an install from the repository would break (PR #16).
- **What "support" means outside Cowork** (14/11/2026; Fio stated no preference, so the recommended option was taken and Fio may still revise it): on Claude Code, Codex and Antigravity vibebiz runs in **local folder mode only**. All six entry skills work against a folder on the user's computer; the board and tech views are the local HTML files that folder mode already writes. Google Drive mode, Claude Artifacts and Google Slides and Docs stay Cowork features.
- **Release**: a compatible change, so it ships as **v0.1.5**, staying on 0.1.x as Fio decided for 0.1.2. The workspace layout and file names do not change.
- **Constitution** (Fio approved, 14/11/2026): amended to 1.3.0 on this branch. Cowork stays the primary runtime, and Claude Code, Codex and Antigravity are supported in local folder mode (Principles I, IV, V and "Runtime and Distribution Constraints"). The matching `CLAUDE.md` lines were updated in the same change.

- **Install layout** (Fio, 14/11/2026): as vietnamizer does. The built skills are tracked in `.plugin-skills/`, every host manifest points there, and the source skills move out of `skills/`. Every install also copies the development folders, which stay inert (`research.md` R2, R3).

## Open Decisions

- **The catalog side** (owner: Fio): the `list-vibebiz` branch of `finolabs/plugins` (commit `c549f7d`, not reviewed after its last fix) lists vibebiz for Claude only through a `CLAUDE_ONLY` set. Once vibebiz ships all three manifests, that set is no longer needed, and the catalog change becomes a plain new entry in both catalogs. Unblocked when this feature is released.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Install from the catalog and start an idea on Claude Code (Priority: P1)

A sales director's analyst who uses Claude Code adds the FINOLABS catalog, installs vibebiz by name, opens a folder and types `/vibebiz:idea` with a one-line idea. vibebiz sets up the workspace in that folder and runs the interview exactly as in Cowork desktop with a folder.

**Why this priority**: it is the install path the catalog promises. Today the only working Claude Code install is a synced upload or a local build.

**Independent Test**: On a machine without vibebiz, run the catalog's two Claude Code install commands, open an empty folder, run `/vibebiz:idea` with a fictional idea, answer one round, and check that the workspace and the idea folder exist with the answers recorded.

**Acceptance Scenarios**:

1. **Given** the catalog is added, **When** the user installs `vibebiz@finolabs`, **Then** the install succeeds from the pinned tag with no build step, and the six entry skills are available.
2. **Given** vibebiz is installed this way, **When** any entry skill runs, **Then** every instruction, template and pack it refers to is present in the installed copy.
3. **Given** an installed copy, **When** the host lists the plugin's skills, **Then** it shows exactly the six entry skills, never an unbuilt copy or a Spec Kit development skill.

---

### User Story 2 - Use vibebiz from Codex (Priority: P1)

A user who works in Codex installs vibebiz from the same catalog, opens a folder, and takes an idea from `idea` through `continue` to `package`. Questions arrive through Codex's own question tool; the board and tech views are written as HTML files in the idea's `exports/` folder.

**Why this priority**: Fio asked for Codex support; it is half of the new reach.

**Independent Test**: In Codex, install vibebiz from the catalog, run the fictional example idea from `idea` to `package` in a scratch folder, and check the workspace with the package check and the Spec Kit compatibility check.

**Acceptance Scenarios**:

1. **Given** the catalog is added in Codex, **When** the user installs vibebiz, **Then** the install succeeds from the pinned tag and the six entry skills are available under their usual names.
2. **Given** an interview round, **When** vibebiz asks its questions, **Then** it uses the host's question tool with the same limits and the same Skip behavior as in Cowork, or asks in plain text when the host offers no such tool.
3. **Given** an idea ready to package, **When** `package` runs, **Then** it writes `data.json`, `spec.md`, `links.md`, `board-deck.html` and `tech-prd.html` in the idea's `exports/`, and the workspace passes the package check.

---

### User Story 3 - Use vibebiz from Antigravity (Priority: P2)

A user of Antigravity installs vibebiz from its repository, as Antigravity installs every FINOLABS plugin, and uses it in a folder exactly as in Story 2.

**Why this priority**: Antigravity installs per repository rather than from the catalog, so it needs the same installable tree but no catalog entry.

**Independent Test**: As Story 2, with Antigravity's install command and question tool.

**Acceptance Scenarios**:

1. **Given** Antigravity, **When** the user installs vibebiz from its repository at a release tag, **Then** the install succeeds with no build step and the six entry skills are available.
2. **Given** an interview or a package run, **When** it completes, **Then** the workspace is the same as one made in Cowork desktop from the same answers, apart from the date and time stamps.

---

### User Story 4 - Ask for a Cowork-only feature on another host (Priority: P2)

On Codex, a user asks vibebiz to make Google Slides, to publish an Artifact, or to keep the workspace in Google Drive. vibebiz says that this works in Claude Cowork, offers what this host can do (the local HTML views), and changes nothing it was not asked to change.

**Why this priority**: without it the user meets a failed tool call or an invented substitute.

**Independent Test**: On each non-Cowork host, ask for each Cowork-only feature and check that the answer names Cowork, offers the local alternative, and writes nothing unrequested.

**Acceptance Scenarios**:

1. **Given** a host without a Google Drive connector, **When** an entry skill starts with no folder open, **Then** it writes nothing and tells the user to open a folder, or to use Cowork for Drive mode.
2. **Given** a host without Artifacts or Google Slides and Docs, **When** the user asks `package` for them, **Then** it explains they are Cowork features and writes the HTML views instead only if the user agrees.

---

### User Story 5 - Every release stays installable (Priority: P1)

The maintainer changes a module in `core/` and opens a pull request. A check fails until the installable copy matches the sources, so a tag can never point at a tree that installs broken.

**Why this priority**: the v0.1.4 review found that a tag of this repository installs a broken plugin; the fix must stay fixed.

**Independent Test**: Change one line in a `core/` module without refreshing the installable copy and check that the repository's checks fail and name the stale file; refresh it and check that they pass.

**Acceptance Scenarios**:

1. **Given** a source change that is not reflected in the installable copy, **When** the checks run, **Then** they fail and name each out-of-date file.
2. **Given** the three plugin manifests, **When** the checks run, **Then** they fail unless name, version, description and keywords agree across them, and the description is 120 to 160 characters.
3. **Given** a release tag, **When** each host installs from it, **Then** the install works, and the result is recorded in `evals/RESULTS.md` before the catalog lists the tag.

### Edge Cases

- A user already has vibebiz from a synced upload in Claude Code and installs it from the catalog too: the two copies must not both answer `/vibebiz:*`; the docs say which one to remove.
- Cowork users keep installing from the release's `vibebiz.plugin`; that archive is unchanged in content.
- A host has a shell and Python: vibebiz still must not require them (constitution Principle IV).
- A host's question tool has smaller limits than Cowork's (fewer questions or options per call): the interview splits the round instead of dropping questions.
- The user opens a folder that already holds a vibebiz workspace made in Cowork desktop: it continues as is, with no migration.
- Antigravity or Codex shows skill names with a different prefix than `/vibebiz:`: `help` and the docs explain each host's form.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: A release tag of the repository MUST install as a working plugin on Claude Code, Codex and Antigravity with no build step on the user's side.
- **FR-002**: An installed copy MUST contain every file the six entry skills refer to, and the host MUST load exactly those six skills; development folders that land in the install folder MUST be inert (no skills, hooks or servers loaded from them).
- **FR-003**: The repository MUST ship a plugin manifest for each of the three hosts, with the same name, version, description and keywords; the description MUST be 120 to 160 characters (the `finolabs/plugins` listing standard).
- **FR-004**: The repository's checks MUST fail when the installable copy differs from its sources, and when the three manifests disagree.
- **FR-005**: On Claude Code, Codex and Antigravity, all six entry skills MUST work in local folder mode with the same workspace layout and file names as Cowork desktop.
- **FR-006**: Questions MUST go through the host's own question tool where it has one, with the interview protocol's rules (no "None" or "Other", a skip leaves the category unchanged), and fall back to plain-text questions where it has none.
- **FR-007**: On a host without Google Drive, Artifacts or Google Slides and Docs, vibebiz MUST say these are Cowork features, offer the local alternative, and write nothing the user did not agree to.
- **FR-008**: The release archive `vibebiz.plugin` for Cowork MUST keep working as today.
- **FR-009**: The README pair, `docs/` and `help` MUST give the install command for each host and say what each host supports.
- **FR-010**: The constitution and the matching `CLAUDE.md` lines MUST be amended before implementation so that it allows Claude Code, Codex and Antigravity in local folder mode (see Settled Decisions).
- **FR-011**: Each host's install from the release tag MUST be run for real and recorded in `evals/RESULTS.md` before the catalog entry is proposed.

### Key Entities

- **Installable copy**: the tree a host installs from a tag; generated from the sources, never edited by hand.
- **Host manifest**: one per host (Claude Code, Codex, Antigravity), holding the shared name, version, description and keywords.
- **Catalog entry**: vibebiz's entry in `finolabs/plugins`, pinned to a release tag, proposed only after FR-011.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: On each of the three hosts, a new user goes from no vibebiz to the first interview question with at most the catalog's two install commands (one for Antigravity) and opening a folder.
- **SC-002**: The fictional example idea, run from `idea` to `package` on each host, passes the package check and the Spec Kit compatibility check.
- **SC-003**: The workspace eval cases for local folder mode pass on Claude Code at the same score as in 0.1.4; on Codex and Antigravity, each case is run once and its result recorded, and no case fails because a referenced file is missing.
- **SC-004**: A deliberately stale installable copy fails the repository's checks in 100% of the test cases.
- **SC-005**: The `finolabs/plugins` checker, including its remote manifest check, passes with vibebiz pinned to the new tag.

## Assumptions

- Codex and Antigravity can install a plugin from a GitHub repository at a tag, as they do for the other FINOLABS plugins; whether either can install from a sub-folder is unknown and is research for the plan.
- Codex's question tool is `request_user_input` and Antigravity's is `ask_question`; their limits are checked in the plan.
- The headless eval harness used for Claude (`claude plugin eval`) has no equivalent on Codex and Antigravity; their runs are scripted or manual and recorded by hand.
- Cowork desktop and web keep working exactly as in 0.1.4; Drive mode is unchanged.
