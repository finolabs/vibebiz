# Feature Specification: Workspace on Google Drive

**Feature Branch**: `002-drive-workspace`

**Created**: 2026-11-13

**Status**: Draft

**Input**: User description: "Let vibebiz run in Claude Cowork on the web and on mobile, where a session runs on Anthropic's servers and cannot reach a folder on the user's computer. The workspace lives in a folder in the user's own Google Drive, reached through Cowork's Google Drive connector, so ideas persist across sessions and devices. Desktop with a local folder keeps working as today. Everything stays private in the user's Drive. If the Drive connector is not connected, the skill says how to connect it or to use the desktop app, and writes nothing. Workspace layout and file names stay the same public contract."

## Settled Decisions

Fio settled these on 13/11/2026:

- **Release**: this feature ships as **v0.1.2**, not 0.2.0. SemVer would call a new storage mode MINOR; Fio chose to stay on 0.1.x while the product is pre-1.0.
- **Where the Drive workspace lives**: the user chooses the Drive folder the first time. Later sessions find it again without asking the user to remember where it is.
- **Desktop with a local folder open**: the local folder wins, exactly as in 0.1.x. Drive is used only when the session has no local folder (web, phone). The two workspaces are separate and are never synced.
- **Board deck and tech PRD views in Drive mode**: they are produced only as private Artifacts (or as Google Slides and Docs, as `package` already offers). The two large HTML views are not saved into Drive, because a connector that takes file content as a parameter cannot carry a 150–190 KB fixed template faithfully.
- **Table of contents in Drive mode** (FR-010): the table-of-contents data stays in Drive and the rendered table of contents is a private Artifact; `index.html` (about 20 KB of fixed template) is not written into Drive, for the same reason.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Start an idea from the web or a phone (Priority: P1)

A sales director opens Cowork in a browser or on a phone, with the Google Drive connector already connected, and types `/vibebiz:new` with a one-line idea. vibebiz asks which Drive folder to keep ideas in, sets up the workspace there, and runs the interview exactly as on desktop. The answers are saved in that Drive folder as they go.

**Why this priority**: today every entry skill stops on the web and on mobile. Without this story nothing else in the feature works.

**Independent Test**: In a Cowork web session with Drive connected and no local folder, run `/vibebiz:new` with a fictional idea, answer the first round of questions, end the session, and check that the chosen Drive folder holds the workspace and the idea folder with the answers recorded.

**Acceptance Scenarios**:

1. **Given** a web or phone session with Drive connected and no vibebiz workspace in Drive, **When** the user runs `new`, **Then** vibebiz asks the user to choose or name a Drive folder, creates the workspace there, and creates the idea folder with the same names as on desktop.
2. **Given** the user picks a folder that already holds files that are not vibebiz's own, **When** the workspace is set up, **Then** vibebiz creates only the missing pieces, overwrites nothing, and reports what it created.
3. **Given** the interview is under way, **When** the user answers a question, **Then** the answer is in the Drive files before the next question is asked, so closing the session loses nothing already answered.

---

### User Story 2 - Continue the same idea on another device (Priority: P1)

The director started an idea on a phone during a store visit and opens Cowork on the web at the office the next day. `/vibebiz:continue` and `/vibebiz:status` find the same Drive workspace without asking where it is, and pick up where the last session stopped.

**Why this priority**: persistence across sessions and devices is the reason to move the workspace to Drive.

**Independent Test**: After Story 1, start a new web session (a different device if available), run `status`, then `continue`, and check that both read the idea started earlier and that `continue` asks the next open question rather than starting over.

**Acceptance Scenarios**:

1. **Given** exactly one vibebiz workspace exists in the user's Drive, **When** any entry skill starts in a session without a local folder, **Then** it uses that workspace and names it in one line, without asking.
2. **Given** two or more vibebiz workspaces exist in the user's Drive, **When** an entry skill starts, **Then** vibebiz lists them by folder name and last update and asks which one to use.
3. **Given** the user moved or renamed the workspace folder in Drive, **When** an entry skill starts, **Then** vibebiz still finds it by its contents, not by its old name or path.

---

### User Story 3 - Package from the web (Priority: P2)

On the web, `/vibebiz:package` produces the board deck and the tech PRD as private Artifacts (or private Google Slides and Docs, if the user chooses), and saves the data, the Spec Kit snapshot and the links file in the idea's `exports/` folder in Drive.

**Why this priority**: packaging is the product's output, but a director can get value from Stories 1 and 2 (a clarified, saved idea) before packaging works on the web.

**Independent Test**: Package the idea from Story 1 in a web session and check that the Artifacts open privately, that `exports/` in Drive holds `data.json`, `spec.md` and `links.md`, and that every number in the Artifacts matches `data.json`.

**Acceptance Scenarios**:

1. **Given** an idea ready to package in a Drive workspace, **When** `package` runs, **Then** the board and tech views are published as private Artifacts, and `links.md` records their addresses.
2. **Given** a previous export set exists in Drive, **When** the idea is packaged again, **Then** the previous set is kept under `exports/history/<date>/` and nothing presented earlier is overwritten.
3. **Given** the user asks for Google Slides or Docs, **When** `package` writes them, **Then** they are created in the user's own Drive, private, exactly as in 0.1.x.

---

### User Story 4 - Clear message when Drive is not connected (Priority: P2)

A director opens Cowork on a phone without the Google Drive connector and types `/vibebiz:new`. vibebiz writes nothing and says, in plain words, the two ways forward: connect Google Drive in Cowork's connector settings, or use the Claude desktop app with a folder.

**Why this priority**: it replaces the 0.1.1 message for web and phone sessions and prevents the user from losing answers in a session that cannot save them.

**Independent Test**: In a web session with no Drive connector, run each entry skill that needs a workspace and check that each writes nothing, asks nothing else, and gives both ways forward.

**Acceptance Scenarios**:

1. **Given** no local folder and no Drive connector, **When** an entry skill that needs a workspace starts, **Then** it stops, writes nothing, and names both ways forward in the user's language.
2. **Given** the Drive connector is connected but cannot create or change files (read-only access), **When** an entry skill needs to write, **Then** it says so, writes nothing, and does not continue partway.
3. **Given** `help` is asked a documentation question in any session, **When** it answers, **Then** it needs neither a folder nor Drive, as today.

---

### User Story 5 - Desktop stays as it is (Priority: P1)

A director who uses the desktop app with a local folder sees no change: the workspace stays on their computer, nothing is written to Drive except the Google Slides and Docs they ask `package` to create.

**Why this priority**: existing 0.1.x users must not lose or split their workspace.

**Independent Test**: Run the 0.1.x workspace eval suite on desktop with Drive connected and check that every case still passes and nothing new appears in Drive.

**Acceptance Scenarios**:

1. **Given** a desktop session with a local folder and Drive connected, **When** any entry skill runs, **Then** it uses the local folder and does not look for a Drive workspace.
2. **Given** a desktop session with no local folder but Drive connected, **When** an entry skill starts, **Then** it uses the Drive workspace, as on the web.

### Edge Cases

- The chosen Drive folder, or a folder above it, is shared with other people: vibebiz says who else may see the ideas, does not change any sharing, and continues only if the user confirms. It never offers to share or unshare.
- The chosen folder is in a shared drive the organization owns: same warning and confirmation as a shared folder.
- The user edits a file in Drive by hand between sessions: hand edits stay authoritative, as on desktop; vibebiz re-reads before writing and appends rather than rewrites records.
- Two sessions write the same idea at the same time (phone and web open together): the later write must not silently discard the earlier one; vibebiz re-reads before each write and, when the file changed since it read it, tells the user and asks before replacing anything.
- Drive turns a saved file into a Google Doc, or saves a second copy with the same name: vibebiz keeps one file per contract name, as plain text, and reports a duplicate instead of guessing which one is current.
- A connector call fails partway through setting up a workspace: the next run repairs only the missing pieces, as `new` does on a partial local workspace.
- The user's Drive is full: vibebiz says so plainly and stops writing; answers given in that session are shown to the user so they are not lost.
- The Drive workspace was created by a newer vibebiz version: vibebiz reads it and does not downgrade any file.
- The table of contents (`index.html`, about 20 KB of fixed template) cannot be written faithfully through the connector: see FR-010.

## Requirements *(mandatory)*

### Functional Requirements

**Choosing where the workspace lives**

- **FR-001**: Every entry skill that needs a workspace MUST use the local working folder when the session has one, exactly as in 0.1.x, and MUST NOT look for or write a Drive workspace in that case (Google files `package` creates at the user's request excepted).
- **FR-002**: When the session has no local working folder and the Google Drive connector can read and write the user's files, the entry skill MUST use a Drive workspace.
- **FR-003**: When the session has no local folder and no usable Drive connector, the entry skill MUST stop, write nothing, ask nothing else, and tell the user both ways forward: connect Google Drive in Cowork, or use the Claude desktop app with a folder. This replaces the 0.1.1 message for those sessions.
- **FR-004**: vibebiz MUST recognize a Drive workspace by its contents (the same markers it uses for a local workspace), so it is found again after the folder is moved or renamed.
- **FR-005**: With no workspace in Drive, vibebiz MUST ask the user which Drive folder to use (an existing folder, or a new one it creates with the name the user gives) before writing anything. With exactly one, it MUST use it and name it. With several, it MUST ask which one.

**Same contract, different storage**

- **FR-006**: The Drive workspace MUST use the same folder layout, fixed English file names and slug rules as the local workspace (`contracts/workspace-files.md` in spec 001), except the files FR-009 and FR-010 name.
- **FR-007**: Every file vibebiz keeps in Drive MUST stay a plain file with its contract name and extension, never converted into a Google Doc or Sheet, so a tech team can download the idea folder and use it as Spec Kit files.
- **FR-008**: The workspace rules of 0.1.x MUST hold in Drive: `new` never overwrites and repairs only missing pieces; hand edits are authoritative; records are appended; each answer is saved before the next question.
- **FR-009**: In a Drive workspace, `package` MUST save `data.json`, `spec.md` and `links.md` in the idea's `exports/` folder and MUST produce the board deck and the tech PRD only as private Artifacts or, at the user's choice, private Google Slides and Docs. It MUST NOT save `board-deck.html` or `tech-prd.html` into Drive.
- **FR-010**: In a Drive workspace, the table of contents MUST still be rebuilt after every write. The workspace MUST keep the table-of-contents data in Drive and MUST show the rendered table of contents as a private Artifact; it MUST NOT write a hand-retyped copy of the `index.html` template.
- **FR-011**: Numbers, sources and the "not tech-reviewed" labels MUST match across `data.json`, the Artifacts and any Google file, exactly as in 0.1.x.

**Privacy**

- **FR-012**: vibebiz MUST NOT change who can see any Drive file or folder, MUST NOT create a public or "anyone with the link" address, and MUST NOT move files out of the user's chosen folder. Sharing stays the user's own action.
- **FR-013**: Before creating or using a Drive workspace, vibebiz MUST check whether the folder is visible to anyone other than the user; when it is, it MUST tell the user and continue only on the user's confirmation.
- **FR-014**: vibebiz MUST NOT read, list or change Drive files outside the chosen workspace folder, except the search that finds vibebiz workspaces (FR-004), which reads no file content beyond the workspace markers.
- **FR-015**: `PRIVACY.md` and the in-product help MUST state that, without a local folder, ideas are stored in a folder of the user's Google Drive that the user chose, and nowhere else.

**Product description**

- **FR-016**: README pair, `docs/` (quick start, FAQ 12, commands, admin setup), `help`'s situation map and `PRIVACY.md` MUST describe both storage modes and when each is used, before v0.1.2 is cut.
- **FR-017**: The eval suites MUST gain cases for the Drive mode: workspace found, none found, several found, no connector, read-only connector, shared folder, desktop with both available. Existing workspace cases MUST keep passing.

### Key Entities

- **Workspace location**: where an idea workspace is kept for a session: a local folder (desktop) or a Drive folder (any session without a local folder). Chosen per session by FR-001 to FR-003; never both.
- **Drive workspace**: a folder in the user's Drive with the contract layout, recognized by its markers; holds every workspace file except the two large HTML export views and the rendered table of contents.
- **Table-of-contents data**: the list of ideas with status, coverage, next step, output links and last update; kept in the workspace and rendered for the user.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: In a Cowork web or phone session with Drive connected, a director can run `new`, answer the first round of questions and find every answer saved in Drive, with no step that requires the desktop app.
- **SC-002**: An idea started on one device is continued on another with zero questions about where the workspace is, when only one workspace exists.
- **SC-003**: 100% of entry-skill runs without a local folder and without a usable Drive connector write nothing and name both ways forward.
- **SC-004**: Every 0.1.x workspace eval case still passes on desktop, and a desktop session with a local folder writes nothing new to Drive.
- **SC-005**: No vibebiz run changes the sharing of any Drive file or folder; every Artifact it publishes is private.
- **SC-006**: A tech team member can download a Drive idea folder and pass the Spec Kit compatibility check on its `exports/spec.md` without changing any file.

## Assumptions

- Cowork's Google Drive connector, in sessions started on the web and on the phone, can search the user's Drive, read file content, create folders and plain files, copy and trash files, and read a file's sharing. It cannot edit a file's content in place, so vibebiz replaces a file to change it (plan research R2). The design rests on the connector's published tool schemas; Fio decided on 13/11/2026 not to run a separate gate first. The release smoke test verifies the connector in a real Cowork web session; if it is read-only or cannot keep plain files, v0.1.2 is not cut and the result returns to Fio.
- Cowork web and phone sessions offer the same question tool (`AskUserQuestion`) as desktop, and can publish private Artifacts.
- A Cowork web session may have a shell in its server-side environment; Drive mode MUST NOT depend on it, because files written there are not the user's and do not persist.
- The user signs in to Google with the account whose Drive should hold the ideas; choosing between several Google accounts is the connector's job, not vibebiz's.
- Local and Drive workspaces are never synced or merged in this release; a user who wants one workspace everywhere uses Drive from every device and opens no local folder.
- Drive revision history is the user's undo; vibebiz adds no backup of its own.
- Business data still goes nowhere but the user's own workspace and Drive (constitution, Runtime and Distribution Constraints); no new service is called at runtime.
