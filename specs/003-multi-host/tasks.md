# Tasks: Install from the catalog on Claude Code, Codex and Antigravity

**Input**: Design documents from `/specs/003-multi-host/`

**Prerequisites**: [plan.md](plan.md), [spec.md](spec.md), [research.md](research.md), [data-model.md](data-model.md), [contracts/install-layout.md](contracts/install-layout.md), [contracts/host-capabilities.md](contracts/host-capabilities.md), [quickstart.md](quickstart.md)

**Tests**: required (constitution V). The layout check starts from a failing test; each instruction change starts from an eval case that fails on Claude Code for the reason the change addresses. Codex and Antigravity have no headless eval harness, so their stories end in a recorded run (research R6).

**Docs**: constitution VII. Each phase's pull request carries the docs for the behavior it changes; Phase 7 reviews them all against what ships.

**Organization**: by user story, in delivery order: US5 (every tag installable) is foundational and blocks the rest, then US1 (Claude Code), US4 (Cowork-only features), US2 (Codex), US3 (Antigravity). v0.1.5 is cut in Phase 8 only after the three host rows are recorded.

**Heavy jobs**: eval runs go one at a time, with the one-minute load average at or below 25 (Fio's machine rule); targeted modules only, never more than two per command.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: can run in parallel (different files, no dependency on an unfinished task)
- **[Story]**: the user story from spec.md

## Path Conventions

After Phase 2 the source skills live in `src/skills/`; the built skills are tracked in `.plugin-skills/` and every host manifest points there (contracts/install-layout.md). `dist/vibebiz/` and `dist/vibebiz.plugin` are still built for the Cowork release archive and for `claude plugin eval` (`evals/README.md`). Instruction files are written with the `writing-for-agents` skill; Vietnamese user text is edited with vietnamizer before its phase's pull request.

---

## Phase 1: Setup

**Purpose**: confirm the one host behavior the layout depends on before moving files.

- [x] T001 In a scratch copy of the repository (outside the worktree), add `"skills": "./.plugin-skills/"` to `.claude-plugin/plugin.json`, copy `dist/vibebiz/skills/` to `.plugin-skills/`, delete the root `skills/`, and run `claude plugin validate <copy>` and a headless `claude -p` with `--plugin-dir <copy>` that lists the plugin's skills. Record in `research.md` R2 that exactly the six skills load, with their `references/`. **If they do not load, stop** and take the result to Fio before Phase 2.

**Checkpoint**: Claude Code loads skills from `.plugin-skills/` with no root `skills/` folder.

---

## Phase 2: Foundational (US5, Priority: P1) — every tag installs as is

**Goal**: the repository root at any commit on `main` is a working plugin for all three hosts, and a stale copy fails the checks.

**Independent Test**: change one line in a `core/` module without regenerating; `scripts/checks/test_build.py` fails and names the stale files; regenerate; it passes.

### Tests (red first)

- [ ] T002 [US5] Add tests to `scripts/checks/test_build.py` (contracts/install-layout.md "Check"): `.plugin-skills/` equals the generator's output (missing, changed and extra files each fail, named); the three manifests agree on name, version, description, keywords, license and `skills`; the description is 120–160 characters; no root `skills/` folder; the manifests' version equals `templates/workspace/index.json`. Run it and record the red result in the pull request.

### Implementation

- [ ] T003 [US5] Refactor `scripts/build_plugin.py` so one function lays out a skill tree from `src/skills/`, `core/`, `templates/`, `packs/`, `docs/` and `examples/`; add `--skills` to write `.plugin-skills/` in the repository (replacing it whole, refusing a path outside the repository), keep `dist/vibebiz/` and `vibebiz.plugin` for Cowork with the same tree under `skills/`, and keep `--fake-drive`.
- [ ] T004 [US5] Move the source skills with `git mv skills src/skills`; update every consumer found by `git grep -n 'skills/'`: `scripts/build_plugin.py`, `scripts/checks/test_docs_map.py` (the six skills and `src/skills/help/situation-map.md`), `scripts/checks/test_build.py`, and `src/skills/help/SKILL.md` line 51 (read a sibling skill as `../<name>/SKILL.md`, which holds in both `.plugin-skills/` and the archive's `skills/`).
- [ ] T005 [US5] Run `python3 -I scripts/build_plugin.py --skills`, commit `.plugin-skills/` as generated output in its own commit, and add `.plugin-skills/** linguist-generated=true` to `.gitattributes`.
- [ ] T006 [P] [US5] Add `"skills": "./.plugin-skills/"` to `.claude-plugin/plugin.json`.
- [ ] T007 [P] [US5] Create `.codex-plugin/plugin.json` with the shared fields, `"skills": "./.plugin-skills/"` and an `interface` block (display name "vibebiz", category, website, support, privacy and terms URLs), modeled on finolabs-vibecode's.
- [ ] T008 [P] [US5] Create `.antigravity-plugin/plugin.json` with `$schema` `https://antigravity.google/schemas/v1/plugin.json`, the shared fields, `displayName` and `"skills": "./.plugin-skills/"`.
- [ ] T009 [US5] Run `test_build.py` (green), `test_docs_map.py`, and `claude plugin validate .`; then the stale-copy demonstration in quickstart.md step 1.

**Checkpoint**: the repository root validates as a plugin; the checks guard the copy and the manifests.

---

## Phase 3: User Story 1 - Install and start an idea on Claude Code (Priority: P1) 🎯 MVP

**Goal**: an install of the repository root works on Claude Code exactly like the built plugin.

**Independent Test**: a headless eval case that loads the plugin from the repository root passes.

- [ ] T010 [US1] Add eval case `evals/workspace/root-install-idea/` whose `prompt.md` sets `plugins: ["../../.."]` (the repository root, not `dist/`), runs `/vibebiz:idea` on a fictional idea in an empty folder, and grades: the workspace scaffold and idea folder exist, the skill read its `references/core/workspace.md` (trace), and no file under `.plugin-skills/` or the repository changed. Run it on `main` before Phase 2 is merged to record the red (the root has no `references/`), and after Phase 2 for the green.
- [ ] T011 [US1] Run the existing local workspace suite once against the repository root (cases with `plugins` overridden on the command line if `claude plugin eval` allows it; otherwise the new case only) and record the scores beside 0.1.4's in `evals/RESULTS.md` (SC-003).
- [ ] T012 [US1] Write the duplicate-install note for `docs/` (spec Edge Cases): a user with `vibebiz@synced` from a Cowork upload who also installs `vibebiz@finolabs` keeps one; say which and how to remove the other.

**Checkpoint**: Claude Code works from the repository root; MVP for the catalog.

---

## Phase 4: User Story 4 - Cowork-only features on another host (Priority: P2)

**Goal**: on a host without Drive, Artifacts or Slides and Docs, vibebiz names Cowork, offers the local alternative and writes nothing unasked (contracts/host-capabilities.md).

**Independent Test**: the three eval cases below pass on Claude Code with no Drive or Google Workspace tools.

### Tests (red first)

- [ ] T013 [P] [US4] Eval case `evals/package/no-slides-tool/`: a session with a local folder and no Google Workspace tools asks `package` for Google Slides; graders: the answer names Cowork, offers the HTML views, and no Slides or Docs call is attempted (llm judge plus trace).
- [ ] T014 [P] [US4] Eval case `evals/workspace/no-folder-other-host/`: a Claude Code session with no working folder chosen and no Drive tool runs `/vibebiz:idea`; graders: nothing written, the message asks to open a folder and names Cowork for Drive mode, and does not tell a Claude Code user to open Cowork's Connectors.
- [ ] T015 [P] [US4] Eval case `evals/ask-protocol/host-question-tool/`: the system prompt says the host's question tool takes at most two questions per call; graders: a four-question round is sent in two calls and nothing is dropped. Record the red runs of T013–T015.

### Implementation

- [ ] T016 [US4] `core/ask-protocol.md`: name the tool by role ("the host's question tool: `AskUserQuestion` in Cowork and Claude Code, `request_user_input` in Codex, `ask_question` in Antigravity"), keep vibebiz's limits, split a round when the host allows fewer, plain text with numbered options when there is no tool. Replace bare `AskUserQuestion` mentions in `core/` and `src/skills/` with the role where the rule is host-neutral.
- [ ] T017 [US4] `core/workspace.md` §1: "the folder the user opened" instead of "opened in Cowork"; a "Neither" message for hosts that are not Cowork (open a folder; Drive mode works in Claude Cowork), keeping the Cowork message as written; decide by the tools present, not the host's name.
- [ ] T018 [US4] `core/package.md`: when Artifacts or Google Slides and Docs tools are absent, say they are Cowork features and offer the HTML views (contracts/host-capabilities.md "Behavior").
- [ ] T019 [US4] Rerun T013–T015 and the cases that cover the changed modules (`evals/ask-protocol/*`, `evals/workspace/no-folder-chat`, `evals/workspace/drive-no-connector-*`, `evals/package/*`), one at a time; record in `evals/RESULTS.md`.

**Checkpoint**: Cowork behavior unchanged; other hosts get clear, honest limits.

---

## Phase 5: User Story 2 - Codex (Priority: P1)

**Goal**: vibebiz installs and runs from `idea` to `package` in Codex.

**Independent Test**: quickstart.md step 3 against the branch, then again against the tag in Phase 8.

- [ ] T020 [US2] Install from a scratch Codex marketplace whose entry is a `local` source pointing at a clean checkout of this branch; record the skill name form Codex shows and that exactly six vibebiz skills load.
- [ ] T021 [US2] Run the fictional example idea from `idea` through `continue` to `package` in a scratch folder (`codex exec` with answers in the prompt, or interactively); run `scripts/checks/package_check.py` and the Spec Kit compatibility check on the result. Record the limits `request_user_input` showed and copy them into contracts/host-capabilities.md. Remove the scratch marketplace and plugin afterwards.
- [ ] T022 [US2] Fix what the run shows in `core/` or `src/skills/` with a failing Claude Code eval case first where the fault is host-neutral; host-specific faults are recorded and taken to Fio if no host-neutral wording fixes them.

---

## Phase 6: User Story 3 - Antigravity (Priority: P2)

**Goal**: vibebiz installs and runs in Antigravity.

**Independent Test**: quickstart.md step 4.

- [ ] T023 [US3] `agy plugin install <clean checkout of this branch>`; record the skill name form and that exactly six vibebiz skills load. Note the 0.1.2 copy already installed from `dist/vibebiz` and remove it first (`agy plugin uninstall vibebiz`), with Fio's yes.
- [ ] T024 [US3] Same run as T021 in Antigravity; record `ask_question`'s limits in contracts/host-capabilities.md. Fix as T022.

---

## Phase 7: Docs and instructions (constitution VII)

- [ ] T025 [P] `README.md` and `README.vi.md`: install per host (Cowork archive, Claude Code and Codex catalog, Antigravity repository URL) and the capability table in plain words; same sections in both.
- [ ] T026 [P] `docs/quick-start.md`, `docs/commands.md`, `docs/faq.md`, `docs/admin-setup.md`: per-host install and skill name forms, what works where, the duplicate-install note (T012).
- [ ] T027 [P] `src/skills/help/situation-map.md` and `help`'s answers: "which app can I use" and "why can't I make Slides here" situations, from the shipped docs only.
- [ ] T028 `CLAUDE.md` "Plugin shape": `src/skills/*/SKILL.md`, `.plugin-skills/` generated and never edited by hand (Fio approved the layout 14/11/2026); `evals/README.md` and `specs/002-drive-workspace/tasks.md` Path Conventions follow the new paths.
- [ ] T029 Edit the new Vietnamese text with vietnamizer, keeping the original voice, for readers who are not technical.
- [ ] T030 Regenerate `.plugin-skills/` (T005) and run `test_build.py`, `test_docs_map.py`.

---

## Phase 8: Release 0.1.5 and the catalog

- [ ] T031 Bump the three manifests and `templates/workspace/index.json` to 0.1.5, regenerate `.plugin-skills/`, add `CHANGELOG.md` `[0.1.5]`; release review per `CLAUDE.md` "Release review"; open the pull request with code and security reviews; merge on `MERGE OK`.
- [ ] T032 Tag `v0.1.5` on the merge commit; build `vibebiz.plugin` from a fresh clone at the tag, validate, `test_build`, package check on the example; publish the GitHub Release with the archive and its sha256.
- [ ] T033 From the tag, per quickstart.md steps 2–4: Claude Code (scratch marketplace `github` source at the tag), Codex (scratch marketplace `url` source at the tag), Antigravity (`agy plugin install https://github.com/finolabs/vibebiz`; if the URL form fails, a clone at the tag, and record that). One row per host in `evals/RESULTS.md` (FR-011), committed by a follow-up pull request.
- [ ] T034 Cowork smoke test with the release archive (quickstart.md step 5); Fio runs it (the T049 checklist of spec 002 still applies).
- [ ] T035 In `finolabs/plugins`: a new branch from `main` adding vibebiz to `.claude-plugin/marketplace.json` (pinned `ref` `v0.1.5`), `.agents/plugins/marketplace.json` and the README table; `scripts/check-catalogs.py --remote` passes; pull request with code and security reviews; merge with Fio's go. Ask Fio whether to delete the superseded `list-vibebiz` branch.
- [ ] T036 After the catalog merge, install `vibebiz@finolabs` on Claude Code and Codex from the catalog itself and record the result beside T033's rows; update the catalog README's note on which pins were checked against an install.

---

## Dependencies & Execution Order

- Phase 1 → Phase 2 (stop rule in T001).
- Phase 2 blocks every later phase: nothing installs without it.
- Phase 3 (US1) and Phase 4 (US4) can run in parallel after Phase 2; they touch different files (eval cases and `core/` modules vs. a new eval case and docs note).
- Phase 5 (US2) and Phase 6 (US3) need Phase 4's instruction changes, so a failure there is not a known gap; they are manual or scripted runs and go one at a time.
- Phase 7 needs Phases 3–6 (the docs describe what the runs proved).
- Phase 8 needs everything; T035 needs T033's three rows; T036 needs T035 merged.

### Parallel opportunities

- T006, T007, T008 (three manifest files).
- T013, T014, T015 (three new eval cases), then their red runs one at a time.
- T025, T026, T027 (different docs).

## Implementation Strategy

MVP is Phases 1–3: Claude Code installs from the repository root, which is what the catalog needs first. Phases 4–6 extend to the other hosts; nothing ships until Phase 8, since the version and the catalog entry describe all three hosts together.

## Notes

- `.plugin-skills/` is generated: never edit it by hand; regenerate in the same commit as the source change, and keep the generated update in its own commit where the change is large.
- Moving `skills/` to `src/skills/` changes many paths in one commit; do it with `git mv` so history follows.
- The two constitution exceptions in plan.md "Complexity Tracking" stay visible in the release pull request.
