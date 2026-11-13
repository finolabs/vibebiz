# Tasks: Workspace on Google Drive

**Input**: Design documents from `/specs/002-drive-workspace/`

**Prerequisites**: [plan.md](plan.md), [spec.md](spec.md), [research.md](research.md), [data-model.md](data-model.md), [contracts/drive-workspace.md](contracts/drive-workspace.md), [quickstart.md](quickstart.md)

**Tests**: required. Under constitution V, every behavior change starts from an eval case that fails for the reason the change addresses. The eval case comes first in each story, and so does the structural check where one applies.

**Organization**: tasks are grouped by user story, in the plan's delivery order: US4 + US5 → US1 → US2 → US3. Cut v0.1.2 only after the release smoke test passes, including its connector checks.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: can run in parallel (different files, no dependency on an unfinished task)
- **[Story]**: the user story from spec.md

## Path Conventions

The repository root is the plugin source. The shipped plugin is `dist/vibebiz/`, built by `scripts/build_plugin.py`. `evals/` and `scripts/` never ship. Instruction files (`SKILL.md`, `core/`) are written with the `writing-for-agents` skill (CLAUDE.md).

---

## Phase 1: Setup

**Purpose**: the eval tooling that runs without a real Drive (research R9)

- [ ] T001 Check whether a `claude plugin eval` case can load a stdio MCP server, through the case frontmatter or the plugin's `.mcp.json` in a test copy. Use `claude plugin eval --help` and the docs. Record the method, or its absence, in `evals/README.md` under a new "Fake Drive" heading. If no method exists, record that the Drive cases run through the Agent SDK harness in `evals/persona/` instead, and change every later `evals/workspace/drive-*` task to that harness.
- [ ] T002 Create the fake Drive server in `evals/fake-drive/server.py`. Use the Python standard library only, run it as a stdio MCP server, and store data in a folder given by `--root`. Expose `search_files`, `read_file_content`, `download_file_content`, `create_file`, `copy_file`, `trash_file`, `get_file_metadata` and `get_file_permissions`, with the names and parameters recorded in research R1. Behavior:
  - `create_file` turns `text/*` content into a Google Doc stub unless `disableConversionToGoogleType` is true.
  - The server has no content-update tool.
  - Every file carries `modifiedTime`.
  - The file header states the date of the schema read (13/11/2026).
- [ ] T003 [P] Add fixture modes to `evals/fake-drive/fixtures/`. Each mode is a folder plus a `permissions.json`, all fictional:
  - `empty`
  - `one-workspace` (built from `evals/fixtures/fashion-1-loyalty.json`)
  - `two-workspaces`
  - `read-only` (`create_file` returns a permission error)
  - `shared-folder` (one other reader)
  - `converted-file` (`coverage.md` stored as a Google Doc)
- [ ] T004 [P] Add `evals/fake-drive/test_server.py`. It covers create with and without conversion, search by exact title and `trashed = false`, copy, trash, the permissions listing, and the read-only mode. Run `python3 evals/fake-drive/test_server.py`.

**Checkpoint**: the fake Drive answers every tool that the Drive module will call.

---

## Phase 2: Foundational

**Purpose**: the `index.json` contract and the storage-mode choice that every story uses

- [ ] T005 Add `templates/workspace/index.json`: the same object as the `vibebiz-data` block in `templates/workspace/index.html`, plus the top-level fields from data-model "index.json":
  - `"vibebiz": "workspace"`
  - `"storage": "drive"`
  - `"toc_artifact": null`
  - `"shared_ack": null`, or, once confirmed, `{ "date": "YYYY-MM-DD", "who": [...] }`
- [ ] T006 Extend `scripts/checks/test_index.py` so it validates an `index.json` against the same schema as the local block plus the four fields above, including the rule that "`ideas[]` lists exactly the idea folders present". Add one failing fixture and one passing fixture under `scripts/checks/fixtures/`. Run `python3 scripts/checks/test_index.py`.
- [ ] T007 Extend `scripts/checks/test_build.py` to assert that `dist/vibebiz/` ships `references/templates/workspace/index.json` in each entry skill, and that it ships nothing from `evals/fake-drive/`. Run `python3 scripts/checks/test_build.py`.
- [ ] T008 Amendment drafts for Fio's yes. Change nothing on `main` without it. Write `specs/002-drive-workspace/amendments.md` with the proposed text for:
  - the constitution's Runtime and Distribution Constraints. The MAJOR-bump rule covers the local workspace layout, and Drive mode is a declared variant listed in `contracts/drive-workspace.md`. This is a PATCH-level amendment with a Sync Impact Report.
  - `CLAUDE.md:27`. Entry skills use a local folder, then Drive, and otherwise give the two-way message.
  - `CLAUDE.md` "Workspace and outputs". Add a pointer to the Drive contract.

  Ask Fio through `AskUserQuestion`. Apply the drafts in the same PR only after his yes.

**Checkpoint**: `index.json` is checkable in code, and the amendment is either approved or recorded as open.

---

## Phase 3: User Story 4 and User Story 5: clear stop, desktop unchanged (P2 + P1)

**Goal**: §1 of `core/workspace.md` picks the storage mode: local, then Drive, then the two-way message. Local mode is unchanged.

**Independent Test**: with the fake Drive absent, each entry skill writes nothing and gives the two-way message. With a local folder and the fake Drive both present, `new` writes only locally.

### Tests

- [ ] T009 [P] [US4] Add the eval case `evals/workspace/drive-no-connector/`: the prompt plus graders for `nothing-written`, `no-questions`, a `two-way-message` naming both Google Drive and the desktop app, and `skill-fired`. Copy the shape of `evals/workspace/no-folder-chat/`, with tags `[workspace, drive, us4]`.
- [ ] T010 [P] [US4] Add the eval case `evals/workspace/drive-read-only/`. It uses the fake Drive in `read-only` mode. vibebiz writes nothing, says that Drive is read-only, and does not continue partway.
- [ ] T011 [P] [US5] Add the eval case `evals/workspace/drive-desktop-both/`. It has a local folder plus the fake Drive in `empty` mode. The workspace is created locally, and the fake Drive's root holds no new file afterwards.
- [ ] T012 [US4] Update `evals/workspace/no-folder-chat/graders/stop-message.md:6` to expect the two-way message: name Google Drive and the Claude desktop app with a folder. This is the stale grader from PR finolabs/vibebiz#4's review. Run T009, T010 and T011 plus `no-folder-chat` with `--tag drive` and `--case 'no-folder-chat'`, and confirm T009 and T010 fail before T013.

### Implementation

- [ ] T013 [US4] [US5] Rewrite §1 of `core/workspace.md` into the storage-mode choice from research R6:
  - Step 1: a local working folder, as in 0.1.1.
  - Step 2: otherwise, a Google Drive connector that can search and create, which gives Drive mode and leads to §1a.
  - Step 3: otherwise, the two-way message (research R10, Vietnamese and English).
  - A read-only connector gets its own sentence.

  Keep the `help` exception. Keep the 0.1.1 sentence about web and phone sessions, but only for the case without a connector.
- [ ] T014 [P] [US4] Update step 1 in `skills/new/SKILL.md`, `skills/continue/SKILL.md`, `skills/status/SKILL.md`, `skills/package/SKILL.md` and `skills/constitution/SKILL.md`. Each now says "a local folder, or Google Drive when the session has none (see `references/core/workspace.md` §1)" and still stops with nothing written in the `none` case.
- [ ] T015 [US4] Run `python3 scripts/build_plugin.py`, then the T009–T012 cases and the full `--tag workspace` suite, so the 0.1.x cases still pass (SC-004). Record the outcomes in `evals/RESULTS.md`.

**Checkpoint**: web or phone sessions without Drive stop cleanly, and desktop behaves as in 0.1.1.

---

## Phase 4: User Story 1: start an idea from the web or a phone (P1) 🎯 MVP

**Goal**: find or choose the Drive workspace, check its privacy, scaffold it, and write by replacement. Show the table of contents as a private Artifact.

**Independent Test**: on the fake Drive in `empty` mode, `new` with a fictional idea and answers in the prompt creates the contract layout as plain files, and `index.json` passes `test_index.py`.

### Tests

- [ ] T016 [P] [US1] Add the eval case `evals/workspace/drive-empty/`. The fake Drive starts `empty`, and the user's folder choice is given in the prompt. Graders:
  - every contract file from `contracts/drive-workspace.md` exists, created with conversion off;
  - no `index.html`, `board-deck.html` or `tech-prd.html` is in the fake Drive;
  - `index.json` passes `scripts/checks/test_index.py`;
  - the answers from the prompt appear in `coverage.md` and `spec.md`.
- [ ] T017 [P] [US1] Add the eval case `evals/workspace/drive-unrelated-files/`. The chosen folder already holds a user's own `constitution.md` without the marker. Grader: it is not overwritten, only missing pieces are created, and the report lists them.
- [ ] T018 [P] [US1] Add the eval case `evals/workspace/drive-shared-folder/`. The fake Drive is in `shared-folder` mode. Graders:
  - vibebiz names who can see the folder and asks before writing;
  - when the prompt confirms, `shared_ack` is set with a date;
  - no sharing tool is called (FR-012).
- [ ] T019 [P] [US1] Add the eval case `evals/workspace/drive-replace-changed/`. The fake Drive changes a file's `modifiedTime` between the read and the write. Grader: vibebiz stops and asks, and the old file is not trashed.
- [ ] T020 [P] [US1] Extend `scripts/checks/test_workspace.py` with a Drive-layout check that runs on a fake-Drive root folder. It checks the contract names, reports duplicate titles in one folder, and reports files stored as Google types.

### Implementation

- [ ] T021 [US1] Add §1a "Find or choose the Drive workspace" to `core/workspace.md` (research R3, FR-005):
  - Search for `title = 'index.json' and trashed = false and owner = 'me'`, then read each candidate's marker.
  - With one workspace, use it and name it.
  - With several, ask through `AskUserQuestion`, listing folder name and last update.
  - With none, ask for an existing folder or a new name. Recommend a new folder called "vibebiz".
  - Read no other file content (FR-014).
- [ ] T022 [US1] Add §1b "Privacy check" to `core/workspace.md` (research R5, FR-012, FR-013):
  - Read the permissions of the folder and of each folder above it, and check whether it sits in a shared drive.
  - When it is shared, name who can see it and ask before writing. Record `shared_ack`, and ask again when the sharing set changes.
  - Never call the sharing tool, never change visibility, never move a file outside the workspace.
- [ ] T023 [US1] Add §2a "Writing in Drive" to `core/workspace.md` (research R2 and R4, data-model "File replacement"):
  - Create every file with conversion off. `.md` files are `text/markdown`; `.json` files are `application/json`, or `text/plain` per R4.
  - Change content by replacement: read `modifiedTime`, create the new file, read it back, trash the old one.
  - When `modifiedTime` changed, stop and ask.
  - Interrupted duplicates are repaired on the next run.
  - Never delete permanently.
  - State the boundary with `core/package.md`'s rule never to overwrite a Google file: that rule covers presented Slides and Docs, not workspace records.
- [ ] T024 [US1] Update §3–§5 of `core/workspace.md` (folder state, scaffold, table of contents) so that in Drive mode:
  - the markers are read through the connector;
  - `index.json` takes the place of `index.html` in the marker table;
  - the scaffold copies `references/templates/workspace/index.json`;
  - the table-of-contents rebuild writes `index.json` by replacement, then publishes or updates the private table-of-contents Artifact from `references/templates/workspace/index.html` with the JSON block spliced in (a one-off shell command when the session has a shell), recording its link in `toc_artifact`;
  - without a shell or without Artifacts, it shows a short Markdown table in the chat (research R7, FR-010).
- [ ] T025 [US1] Run `python3 scripts/build_plugin.py`, then the cases T016–T019 with `--tag drive`, then `python3 scripts/checks/test_workspace.py` and `python3 scripts/checks/test_index.py`. Record the outcomes in `evals/RESULTS.md`.

**Checkpoint**: a director on the web can start an idea and keep every answer in Drive (SC-001).

---

## Phase 5: User Story 2: continue on another device (P1)

**Goal**: `continue` and `status` find the same Drive workspace without asking, also when there are several workspaces or the folder was renamed.

**Independent Test**: on the fake Drive in `one-workspace` mode, `status` and then `continue` ask no location question, and `continue` asks the next open question.

### Tests

- [ ] T026 [P] [US2] Add the eval case `evals/workspace/drive-resume/`. It uses `one-workspace` mode with the folder renamed in the fixture. Grader: no location question, the workspace is named in one line, and `continue` resumes at the first open category in `coverage.md`.
- [ ] T027 [P] [US2] Add the eval case `evals/workspace/drive-two-workspaces/`. It uses `two-workspaces` mode. Grader: the user is asked which one to use, with the folder name and last update. The workspace chosen in the prompt is used, and the other stays unchanged.
- [ ] T028 [P] [US2] Add the eval case `evals/index/drive-status/`. It uses `one-workspace` mode. Grader: `status` answers from `index.json` and `coverage.md` and writes nothing except the table-of-contents Artifact.

### Implementation

- [ ] T029 [US2] Update the resume path in `skills/continue/SKILL.md` and `skills/status/SKILL.md`. They refer to the storage mode from `references/core/workspace.md` §1, and they never read `index.html` in Drive mode. Keep each `SKILL.md` under 3,000 words.
- [ ] T030 [US2] Run `python3 scripts/build_plugin.py` and then the cases T026–T028. Record the outcomes in `evals/RESULTS.md`.

**Checkpoint**: an idea started on one device continues on another with zero location questions (SC-002).

---

## Phase 6: User Story 3: package from the web (P2)

**Goal**: in Drive mode, `package` writes `data.json`, `spec.md` and `links.md` into `exports/` and publishes the board and tech views as private Artifacts. History is kept by copying.

**Independent Test**: on the fake Drive in `one-workspace` mode with a ready idea, `package` leaves `exports/` holding exactly `data.json`, `spec.md`, `links.md` and `history/`. `package_check.py` passes on the result.

### Tests

- [ ] T031 [P] [US3] Add the eval case `evals/package/drive-package/`. It uses `one-workspace` mode with a ready idea. Graders:
  - the export files are present and no HTML is in Drive;
  - `links.md` records both Artifact links;
  - `python3 scripts/checks/package_check.py` passes on the fake-Drive idea folder;
  - the Artifacts are private.
- [ ] T032 [P] [US3] Add the eval case `evals/package/drive-repackage/`, an idea that has an earlier export set. Grader: `exports/history/<date>/` holds copies made with `copy_file`, the earlier `links.md` is among them, and no earlier file is trashed.
- [ ] T033 [P] [US3] Add the eval case `evals/speckit-compat/drive-snapshot/`. Grader: `scripts/checks/speckit_integration.py` passes on the downloaded `exports/spec.md` from the fake Drive (SC-006).

### Implementation

- [ ] T034 [US3] Add a "Drive mode" section to `core/package.md` (research R7, R8, FR-009, FR-011):
  - Write `data.json`, `spec.md` and `links.md` to `exports/` through §2a of the workspace module.
  - Publish the board and tech views as private Artifacts, splicing the template in the session shell as step 4 already says. Without a shell, copy the template text exactly.
  - Never save `board-deck.html` or `tech-prd.html` to Drive.
  - Copy the previous set into `exports/history/<date>/` with `copy_file` before a re-package.
  - The Slides and Docs rules stay unchanged.
  - Update the **Writes** line.
- [ ] T035 [US3] Update `skills/package/SKILL.md` so it points to the Drive-mode section and still publishes nothing when the mode is `none`.
- [ ] T036 [US3] Run `python3 scripts/build_plugin.py`, the cases T031–T033, and `python3 scripts/checks/test_package_check.py`. Record the outcomes in `evals/RESULTS.md`.

**Checkpoint**: a director can package an idea from the web, with numbers that match across views.

---

## Phase 7: Polish, docs and release

**Purpose**: docs ship with the behavior (constitution VII). Then version 0.1.2 and the smoke test.

- [ ] T037 [P] Update `PRIVACY.md` (FR-015). Without a local folder, ideas are kept in a Google Drive folder the user chose, and nowhere else. vibebiz never changes sharing.
- [ ] T038 [P] Update `docs/faq.md` question 12 so it says the web and phone are supported through Google Drive, and how to connect Drive. Also update `docs/quick-start.md`, `docs/commands.md` and `docs/admin-setup.md` to describe both storage modes, when each one is used, and the "Always allow" note (research R2). Then run vietnamizer on every changed Vietnamese passage.
- [ ] T039 [P] Update `README.md` and `README.vi.md` with the same sections. Say that the app works on the desktop with a folder, and on the web and phone with Google Drive.
- [ ] T040 [P] Update the help situation map in `skills/help/` with a row for "dùng trên web hoặc điện thoại", which points to FAQ 12. Run `python3 scripts/checks/test_docs_map.py`.
- [ ] T041 [P] Add a Drive-mode row and a pointer to `specs/002-drive-workspace/contracts/drive-workspace.md` in `specs/001-idea-to-prd/contracts/workspace-files.md`.
- [ ] T042 Set the version to `0.1.2` in `.claude-plugin/plugin.json`. Add `## [0.1.2] - <date>` to `CHANGELOG.md` with an Added entry for Drive mode and a Changed entry for the two-way message, following the `versioning` skill.
- [ ] T043 Release review (CLAUDE.md "Release review"):
  - every description of the product matches what ships;
  - `examples/000-giu-chan-khach-cu/` still passes `package_check.py` and the Spec Kit check;
  - `python3 scripts/build_plugin.py`, then `claude plugin validate dist/vibebiz` on a fresh clone.
- [ ] T044 Release smoke test in real Cowork ([quickstart.md](quickstart.md)): first the connector checks 1–9, then smoke steps 1–6, with a test Google account and fictional ideas. Record the results in `evals/RESULTS.md` with no IDs, accounts or emails. This needs Fio or a person with a Cowork web session. If a required connector check fails, stop: do not tag, and report to Fio.
- [ ] T045 After T044 passes and the PR is merged with code and security reviews, tag `v0.1.2` on the merge commit and create the GitHub Release with `dist/vibebiz.plugin`, built from a fresh clone.

---

## Dependencies & Execution Order

### Phase dependencies

- Setup (T001–T004) comes first. T001 decides how every Drive eval case runs.
- Foundational (T005–T008) depends on Setup only for T006's fixtures. T008 runs in parallel with everything and gates only the CLAUDE.md and constitution edits.
- US4 + US5 (T009–T015) depends on Foundational.
- US1 (T016–T025) depends on US4 + US5, because §1 must pick Drive mode first.
- US2 (T026–T030) and US3 (T031–T036) both depend on US1 and are independent of each other.
- Polish (T037–T045) depends on every story. T044 and T045 come last.

### Within each story

The eval cases come first and must fail before the implementation. Then the module, then the `SKILL.md` wording, then the build and the case run.

### Parallel opportunities

- T003 and T004 after T002.
- T009, T010 and T011, all different case folders.
- T016–T020.
- After US1: US2 and US3 in parallel. They touch different files, except that both rebuild `dist/`, so run the builds one at a time.
- T037–T041 in parallel.

Eval runs are heavy jobs. Run one at a time, check `uptime` first, and keep to no more than two modules per command.

## Parallel Example: User Story 1

```text
T016 evals/workspace/drive-empty/
T017 evals/workspace/drive-unrelated-files/
T018 evals/workspace/drive-shared-folder/
T019 evals/workspace/drive-replace-changed/
T020 scripts/checks/test_workspace.py (Drive layout)
```

## Implementation Strategy

### MVP

Setup, Foundational, US4 + US5 and US1 make the MVP. A web user can start an idea and keep it in Drive, and desktop is unchanged. US2 makes it worth shipping, because ideas carry across devices. US3 completes the web flow.

### Incremental delivery

One pull request per phase from Phase 3 on. Each gets code and security reviews and its eval outcomes in `evals/RESULTS.md`. Version 0.1.2 is cut once, after Phase 7.

## Notes

- Fio decided on 13/11/2026 not to run a connector gate before building. The design relies on the schemas in research R1, and T044 verifies the connector before the tag.
- Every fixture and smoke-test idea is fictional. No real account, file ID or email goes into the repository.
