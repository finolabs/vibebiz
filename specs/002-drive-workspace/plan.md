# Implementation Plan: Workspace on Google Drive

**Branch**: `002-drive-workspace` | **Date**: 2026-11-13 | **Spec**: [spec.md](spec.md)

**Input**: Feature specification from `/specs/002-drive-workspace/spec.md`

## Summary

This change adds a second storage mode to vibebiz 0.1.2. When a Cowork session has no local folder (web or phone), the workspace lives in a Google Drive folder the user chooses, reached through Cowork's Google Drive connector. The mode is decided at the start of `core/workspace.md`: a local folder first (as in 0.1.1), then Drive, then a stop message that names both ways forward.

The Drive workspace keeps the contract layout as plain files, with three differences:
- `index.json` replaces `index.html` and doubles as the marker used to find the workspace.
- The table of contents is shown as a private Artifact.
- The board deck and tech PRD are private Artifacts only.

The connector cannot edit a file's content (research R1). Every write is therefore a replacement: create the new file, read it back, then trash the old one, guarded by the file's `modifiedTime`. Desktop with a local folder does not change.

The first task is a gate. It checks the connector in a real Cowork web session before anything else is built.

## Technical Context

**Language/Version**:
- Plugin: Markdown instructions (`SKILL.md`, `core/` modules, docs) and JSON.
- Development tooling: Python 3 standard library (3.10+).

**Primary Dependencies**:
- Runtime: Cowork's Google Drive connector, `AskUserQuestion`, Artifacts.
- Development: `claude plugin eval`, plus a fake Drive MCP server in `evals/fake-drive/` (research R9). Development only.

**Storage**:
- Local mode: unchanged.
- Drive mode: plain files in the user's chosen Drive folder (contracts/drive-workspace.md).
- No other storage.

**Testing**:
- `scripts/checks/test_*.py` structural checks, extended to `index.json`.
- `claude plugin eval` Drive cases against the fake Drive.
- The gate run (T001).
- The release smoke test ([quickstart.md](quickstart.md)).

**Target Platform**: Claude Cowork on desktop, web and the mobile app.

**Project Type**: Claude plugin (skills-only).

**Performance Goals**:
- One question round writes at most about four Drive files, each replacement being two connector calls plus a read-back.
- Finding the workspace takes one search and one read per candidate.

**Constraints**:
- The connector has no in-place content edit (R1, schema).
- Drive mode must not depend on the session shell to keep data (spec Assumptions).
- No sharing calls.
- No reads outside the workspace except the `index.json` search.
- Constitution IV: no runtime scripts.

**Scale/Scope**:
- One workspace per user per Drive, normally. Several are handled (FR-005).
- Six entry skills: five change their folder check, and `help` changes only its docs.
- Changed modules: `workspace.md`, `package.md` and `writing-rules.md` (the message forms only if needed).

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

| Principle | Check | Result |
|---|---|---|
| I. Non-Technical User First | Choosing the folder and confirming a shared folder go through `AskUserQuestion`. Answers are saved before the next question. The two-way message is plain Vietnamese (R10). | Pass |
| II. Spec Kit Compatibility by Contract | Files stay plain Markdown (R4). A downloaded idea folder passes the compatibility check (SC-006). | Pass |
| III. Evidence Over Agreement | Packaging rules are unchanged. Numbers come from `data.json` in Drive. | Pass |
| IV. Self-Contained Runtime | Runtime is instructions plus connector calls. A shell is optional (splicing the table-of-contents Artifact), with a chat fallback. The fake Drive is dev-only. | Pass |
| V. Eval-Proven Behavior | Each behavior starts from a failing Drive eval case on the fake Drive. The gate run and smoke test run before release. | Pass |
| VI. Clean Source-Available Repository | Fixtures are fictional. The gate run records no IDs, accounts or emails. | Pass |
| VII. Docs Ship With Behavior | README pair, docs, help map and PRIVACY.md are updated with the behavior (FR-015, FR-016). | Pass |
| Runtime and Distribution Constraints: "a change to the layout … MUST bump MAJOR" | Drive mode adds `index.json` and leaves out three HTML files, but only in a new mode. The local layout is unchanged, so no existing user breaks. Fio set the version to 0.1.2. | **Tension**: see Complexity Tracking; amendment T002 |

Post-design re-check (after Phase 1): unchanged. The tension stays open until Fio answers T002.

## Project Structure

### Documentation (this feature)

```text
specs/002-drive-workspace/
├── spec.md              # Feature spec
├── plan.md              # This file
├── research.md          # R1–R11
├── data-model.md        # storage mode, index.json, file replacement
├── quickstart.md        # gate run, checks, evals, smoke test
├── contracts/
│   └── drive-workspace.md
├── checklists/requirements.md
├── gate-run.md          # written by T001
└── tasks.md             # Phase 2 (/speckit-tasks)
```

### Source Code (repository root)

```text
core/
├── workspace.md          # §1 storage mode; Drive discovery, privacy check, replacement; index.json
├── package.md            # Drive mode: data/spec/links to Drive, views as Artifacts, history by copy
└── writing-rules.md      # only if the two-way message needs a new form
skills/{new,continue,status,package,constitution}/SKILL.md   # step 1 wording: folder or Drive
templates/workspace/      # index.json template (marker + empty ideas)
scripts/checks/
├── test_index.py         # index.json schema
└── test_workspace.py     # Drive layout on a fake-Drive folder
evals/
├── fake-drive/server.py  # dev-only stdio MCP server (R9)
└── workspace/drive-*/    # Drive cases
docs/  README.md  README.vi.md  PRIVACY.md  help situation map   # both storage modes
CLAUDE.md  .specify/memory/constitution.md                       # amendments, Fio's yes
specs/001-idea-to-prd/contracts/workspace-files.md               # pointer to the Drive contract
CHANGELOG.md  .claude-plugin/plugin.json                         # 0.1.2
```

**Structure Decision**: no new skill and no new module. Drive mode is a branch inside `core/workspace.md`, which every entry skill already loads first, plus a Drive section in `core/package.md`. That keeps the six-skill shape (CLAUDE.md) and puts each rule in one place.

### Delivery order

| Step | Delivers | Depends on |
|---|---|---|
| T001 Gate | `gate-run.md` from a real Cowork web session ([quickstart.md](quickstart.md)); confirms or corrects research R1, R4 and R7 | — |
| T002 Amendments | Proposed text for the constitution (layout rule scoped to the local workspace; Drive mode as a declared variant) and for `CLAUDE.md:27`, plus the eval grader line from PR finolabs/vibebiz#4's review. Written for Fio's yes; nothing is merged without it | T001 |
| US4 + US5 (P2, P1) | §1 storage-mode choice and the two-way message; local mode untouched; Drive cases for "no connector", "read-only" and "desktop with both" | T001 |
| US1 (P1) | Drive discovery and folder choice, privacy check, scaffold, file replacement, `index.json` and the table-of-contents Artifact; fake Drive server | US4 + US5 |
| US2 (P1) | Resume and status on Drive; several workspaces; renamed folder | US1 |
| US3 (P2) | `package` in Drive mode: exports, private Artifacts, history by copy | US1 |
| Docs and release | README pair, docs, help map, PRIVACY.md, CHANGELOG, version 0.1.2, smoke test | all |

Each step merges through a reviewed pull request with code and security reviews; this change touches user data handling (constitution, Development Workflow). Each step starts from its failing eval case.

## Complexity Tracking

| Decision | Why Needed | Simpler Alternative Rejected Because |
|---|---|---|
| Write by replacement (create, read back, trash old) | The connector cannot edit a file's content (R1) | Google Docs as storage breaks plain Spec Kit files; one file per record breaks the fixed names |
| `index.json` in Drive mode only | A marker that search can find exactly, across devices and after renames; and no 20 KB template has to be retyped | A remembered folder ID has nowhere to live across devices; searching for `constitution.md` is ambiguous |
| Fake Drive MCP server in `evals/` | Headless evals cannot reach the real connector | Testing only by hand in Cowork leaves the behavior unguarded (constitution V) |
| Version 0.1.2 despite the MAJOR-bump rule | Fio's decision on 13/11/2026; the local layout, the only one existing users have, is unchanged | Bumping to 0.2.0 or 1.0.0 contradicts Fio; amending the constitution needs his yes (T002) |
