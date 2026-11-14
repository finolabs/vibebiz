# Tasks: First-class vibebiz on Claude Code, Codex and Antigravity

**Input**: Design documents from `/specs/003-multi-host/`

**Prerequisites**: [plan.md](plan.md), [spec.md](spec.md), [research.md](research.md), [data-model.md](data-model.md), [contracts/install-layout.md](contracts/install-layout.md), [contracts/host-capabilities.md](contracts/host-capabilities.md), [quickstart.md](quickstart.md)

**Tests**: required (constitution V). The layout check starts from a failing test; each instruction change starts from an eval case that fails on Claude Code for the reason the change addresses. Behavior that only a real Codex or Antigravity session shows ends in a recorded run, or in an automated one if the harness probes (T003, T006) succeed.

**Docs**: constitution VII. Each phase's pull request carries the docs for the behavior it changes; Phase 10 reviews them all against what ships.

**Priority** (Fio, 14/11/2026): finish Antigravity first, Codex after. Order: Phase 2 → Phase 3 → Phase 4 → Phase 6 → the Antigravity parts of Phases 7–9 → Codex (Phase 5, T002–T004, and the Codex parts of Phases 7–9) once its usage limit resets (17/11/2026 10:16).

**Organization**: Phase 1 measures what research R7 left unverified, because the Drive and Slides design depends on it. Then US7 (every tag installable, foundational), US1 (Claude Code), the host-neutral instruction changes, US2 and US3 (folder journeys on Codex and Antigravity), US4 (Drive), US5 (Slides and Docs), US6 (views). v0.1.5 is cut in Phase 11 after every host row is recorded.

**Heavy jobs**: eval runs and host sessions go one at a time, with the one-minute load average at or below 25 (Fio's machine rule); targeted modules only, never more than two per command.

**Installs on Fio's machine**: probes install into scratch locations where the host allows it, and remove what they installed. Removing or replacing an existing install (the synced `vibebiz` in Claude Code, the imported `vibebiz` 0.1.2 in Antigravity) or connecting an account needs Fio's yes first.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: can run in parallel (different files, no dependency on an unfinished task)
- **[Story]**: the user story from spec.md

## Path Conventions

After Phase 2 the source skills live in `src/skills/`; the built skills are tracked in `.plugin-skills/` and every host manifest points there (contracts/install-layout.md). `dist/vibebiz/` and `dist/vibebiz.plugin` are still built for the Cowork release archive and for `claude plugin eval`. Instruction files are written with the `writing-for-agents` skill; Vietnamese user text is edited with vietnamizer before its phase's pull request.

---

## Phase 1: Setup and measurement

**Purpose**: confirm what each host really offers before the modules depend on it. Each task records its result in research.md R7 and, where it changes a cell, in contracts/host-capabilities.md.

- [x] T001 Claude Code loads skills from `.plugin-skills/` with no root `skills/` folder (research R2 probe, 14/11/2026).
- [ ] T002 [P] Codex: in a scratch copy with `.plugin-skills/` and a `.codex-plugin/plugin.json`, add a scratch `local` marketplace, install, and with `codex exec --ephemeral` check that exactly six vibebiz skills load and that a skill can read its own `references/core/workspace.md` without an approval prompt in Auto mode. Remove the scratch marketplace and plugin.
  - 14/11/2026: partial. Six skills load from `.plugin-skills/` (app-server `skills/list`); the reference-read check waits for Codex's usage limit to reset (17/11/2026 10:16).
- [ ] T003 [P] Codex harness: drive one turn through `codex app-server` and find out whether a client can answer `request_user_input`; record whether the tool is offered in Default and Plan modes. If a harness works, sketch how the eval cases would run through it.
  - 14/11/2026: protocol confirmed (Plan mode at turn start; questions answered by id); a live run waits for the usage limit.
- [ ] T004 Codex Google: with Fio's yes and his connector already connected in Codex, list the `mcp__codex_apps__google_drive_*` tools with their parameters (read only, no file created) and map each Drive operation of `contracts/host-capabilities.md` "Choosing a path" step 2 (search by title and parent, read, download, create with a parent, copy, trash, read permissions) and the Slides and Docs creation paths.
  - 14/11/2026: waived by Fio ("Codex và Antigravity chắc chắn chạy được Google Drive, Docs & Slides nên không cần kiểm"): no real Google run on Codex. The Codex install-and-run stays at T053 (constitution V).
- [x] T005 [P] Antigravity: `agy plugin install <scratch copy>` with `.antigravity-plugin/plugin.json`; check the six skills load as `/idea` and so on, what `/help` opens, and that reading `references/` needs no approval in the Default preset. Record the imported 0.1.2 copy's effect. Uninstall the scratch install.
- [x] T006 [P] Antigravity harness: find out whether `agy -p --input-format stream-json` or `agy acp` lets a client answer `ask_question`; record its real limits (questions per call, options per question).
  - 14/11/2026: done. stream-json has no answer input; `ask_question` is skipped. Unattended runs put answers in the prompt, as Claude Code evals do.
- [x] T007 Antigravity Google: read the official `gdrive`, `gdocs` and `gslides` plugins' skills in the local cache (`~/.gemini/config/plugins/` or the marketplace cache) and map the same operations as T004; record what needs a shell, network and sign-in.
- [x] T008 Claude Code desktop: check whether a plugin skill sees the `Artifact` tool and the Google Drive and Docs connector tools (a scratch skill that lists the tools it can call), so Claude Code follows the same tool-based paths.
  - 14/11/2026: Fio confirmed in the Claude desktop app that a plugin skill sees the `Artifact` tool and the Google Drive connector tools.
- [ ] T009 Previews: Fio opens one `board-deck.html` in Codex's desktop app (`visualize`, in-app browser) and in Antigravity's app (preview, built-in browser); record what works and the exact way a skill asks for it.

**Stop rule**: if a host cannot do a Drive operation that `specs/002-drive-workspace/contracts/drive-workspace.md` requires (for example reading permissions before the first write, or replacing a file), parity in Drive mode on that host is not possible as specified: record it and take it to Fio before Phase 7.

**Checkpoint**: every "measure" cell in contracts/host-capabilities.md is filled or marked impossible with its evidence.

---

## Phase 2: Foundational (US7, Priority: P1) — every tag installs as is

**Goal**: the repository root at any commit on `main` is a working plugin for all three hosts, and a stale copy fails the checks.

**Independent Test**: change one line in a `core/` module without regenerating; `scripts/checks/test_build.py` fails and names the stale files; regenerate; it passes.

- [x] T010 [US7] Add tests to `scripts/checks/test_build.py` (contracts/install-layout.md "Check"): `.plugin-skills/` equals the generator's output (missing, changed and extra files each fail, named); the three manifests agree on name, version, description, keywords, license and `skills`; the description is 120–160 characters; no root `skills/` folder; the manifests' version equals `templates/workspace/index.json`. Run it and record the red result in the pull request.
- [x] T011 [US7] Refactor `scripts/build_plugin.py` so one function lays out a skill tree from `src/skills/`, `core/`, `templates/`, `packs/`, `docs/` and `examples/`; add `--skills` to write `.plugin-skills/` (replacing it whole, refusing a path outside the repository); keep `dist/vibebiz/`, `vibebiz.plugin` and `--fake-drive`.
- [x] T012 [US7] `git mv skills src/skills`; update every consumer found by `git grep -n 'skills/'`: `scripts/build_plugin.py`, `scripts/checks/test_docs_map.py`, `scripts/checks/test_build.py`, and `src/skills/help/SKILL.md` line 51 (read a sibling skill as `../<name>/SKILL.md`).
- [x] T013 [US7] Generate `.plugin-skills/` and commit it in its own commit; add `.plugin-skills/** linguist-generated=true` to `.gitattributes`.
- [x] T014 [P] [US7] Add `"skills": "./.plugin-skills/"` to `.claude-plugin/plugin.json`.
- [x] T015 [P] [US7] Create `.codex-plugin/plugin.json`: shared fields, `"skills": "./.plugin-skills/"`, an `interface` block (`displayName` and `shortDescription` within 30 characters, `longDescription`, category, website, support, privacy and terms URLs, `defaultPrompt`), modeled on finolabs-vibecode's.
- [x] T016 [P] [US7] Create `.antigravity-plugin/plugin.json`: `$schema`, shared fields, `displayName`, `logo`, `author`, `suggestedPrompts` (at most 3), `"skills": "./.plugin-skills/"`; run `agy plugin validate --strict .`.
  - 14/11/2026: no `logo` yet: the repository has no icon. Both validators note it; the icon waits for Fio (before the catalog, T055).
- [x] T017 [US7] Run `test_build.py` (green), `test_docs_map.py`, `claude plugin validate .`, and the stale-copy demonstration in quickstart.md step 1.

**Checkpoint**: the repository root validates on all three hosts; the checks guard the copy and the manifests.

---

## Phase 3: User Story 1 - Install and start an idea on Claude Code (Priority: P1) 🎯 MVP

- [x] T018 [US1] Eval case `evals/workspace/root-install-idea/` with `plugins: ["../../.."]` (the repository root): `/vibebiz:idea` on a fictional idea in an empty folder; graders: scaffold and idea folder exist, the skill read `references/core/workspace.md` (trace), nothing under `.plugin-skills/` changed. Red on `main` before Phase 2 merges, green after.
- [x] T019 [US1] Run the local workspace suite once against the repository root and record the scores beside 0.1.4's in `evals/RESULTS.md` (SC-005).
- [x] T020 [US1] Duplicate-install note for `docs/`: a user with `vibebiz@synced` who also installs `vibebiz@finolabs` keeps one; which and how to remove the other.

---

## Phase 4: Host-neutral instructions (FR-006, FR-010)

**Goal**: the modules choose by the tools present and respect each host's question limits.

### Tests (red first)

- [x] T021 [P] Eval case `evals/ask-protocol/host-limit-three/`: the system prompt says the question tool takes at most three questions and three options per call; graders: a four-question round goes in two calls, nothing is dropped, a four-option question becomes plain text, no "Other" option added.
  - 14/11/2026: not runnable in `claude plugin eval`: the session has no `AskUserQuestion` (Claude Code 2.1.325, also with `--allow-tools AskUserQuestion`), so the case was dropped. The split rule is checked in the Codex run (T030), where `request_user_input` takes at most three questions and three options.
- [x] T022 [P] Eval case `evals/ask-protocol/no-question-tool/`: no question tool allowed; graders: plain-text questions with numbered choices, at most four, answers recorded as usual.
  - 14/11/2026: continues a seeded idea, since `idea` writes `spec.md` only after the intake answer.
- [x] T023 [P] Eval case `evals/workspace/no-folder-other-host/`: a session that is not Cowork, no working folder, no Drive tools; graders: nothing written, the message names that host's ways forward (open a folder; connect its Google integration) and not Cowork's Connectors.
- [x] T024 [P] Eval case `evals/package/no-slides-tool/`: local folder, no Slides or Docs tools, the user asks for Google Slides; graders: no Slides call, says how to connect Slides on this host, offers the HTML views.
- [x] T025 Record the red runs of T021–T024, one at a time.

### Implementation

- [x] T026 `core/ask-protocol.md`: the host's question tool by role (`AskUserQuestion`, `request_user_input`, `ask_question`), vibebiz's limits kept, rounds split to the tool's limits, plain text with numbered choices without a tool; replace bare `AskUserQuestion` mentions in `core/` and `src/skills/` where the rule is host-neutral.
- [x] T027 `core/workspace.md` §1: storage by the tools present; "the folder the user opened"; a "Neither" message per host family (Cowork keeps its message; others: open a folder, or connect the host's Google integration).
- [x] T028 `core/package.md`: Artifacts, Slides and Docs by the tools present; when missing, how to connect them on this host and the HTML views as the alternative.
- [x] T029 Rerun T021–T024 and the cases covering the changed modules (`evals/ask-protocol/*`, `evals/workspace/no-folder-chat`, `evals/workspace/drive-no-connector-*`, `evals/package/*`) one at a time; record in `evals/RESULTS.md`.

---

## Phase 5: User Story 2 - The folder journey in Codex (Priority: P1)

- [ ] T030 [US2] Install from a scratch `local` marketplace pointing at a clean checkout of this branch; run the fictional example idea from `idea` through `continue` to `package` in a scratch folder (through the T003 harness if it works, else interactively with Fio); run the package check and the Spec Kit compatibility check; record the row.
- [ ] T031 [US2] Fix what the run shows: host-neutral faults from a failing Claude Code eval case first; host-specific faults recorded and taken to Fio if no host-neutral wording fixes them.

---

## Phase 6: User Story 3 - The folder journey in Antigravity (Priority: P1)

- [x] T032 [US3] With Fio's yes, remove the imported 0.1.2 copy (`agy plugin uninstall vibebiz`); `agy plugin install <clean checkout>`; same run as T030 (through the T006 harness if it works); record the row.
  - 14/11/2026: Fio's yes (relayed by the coordinator session): `agy plugin uninstall vibebiz` removed the 0.1.2 copy imported from Claude Code (source `claude-code`); `agy plugin list` no longer lists vibebiz, the folder under `~/.gemini/config/plugins/` is gone and `import_manifest.json` no longer names it. Watch whether Antigravity imports it again from Claude Code's synced copy.
- [x] T033 [US3] Fix as T031, including the `/help` clash if T005 found one (for example a clearer description so the user reaches vibebiz's help).
  - 14/11/2026: commands named in the host's form, and vibebiz's help reached in words on Antigravity (`core/writing-rules.md` §2; eval `routing/command-form-antigravity`, red then green).
  - 14/11/2026, open for Fio: in the T032 run Gemini still wrote `/vibebiz:continue`, showed `file://` links, used English jargon and left 4 estimates unlabelled in the tech view (`package_check.py` fails). The modules already state each rule and Claude follows them, so no host-neutral wording is known to fix it.
  - 14/11/2026: Fio chose a self-check (`core/package.md` sections 11 and 12: check from the files as written, then the closing message against `writing-rules.md`). Antigravity repackage: `package_check.py` passes, closing message clean.

---

## Phase 7: User Story 4 - Drive workspace on Codex and Antigravity (Priority: P2)

**Goal**: Drive mode with the same rules on every host with Google Drive.

- [ ] T034 [US4] Fake Drive: add tool-name profiles to `evals/fake-drive/server.py` so the same fixture can expose Cowork's tool names or Codex's `google_drive_*` names (from T004), with tests in `evals/fake-drive/test_server.py`. Antigravity's Drive goes through skills that run a CLI and cannot be faked this way; it is covered by real runs.
- [ ] T035 [US4] Eval cases (red first): `evals/workspace/drive-codex-names-empty/` and `evals/workspace/drive-codex-names-resume/` run the existing empty and resume scenarios with the Codex tool profile.
- [ ] T036 [US4] `core/drive-workspace.md`: each Drive operation named by role and mapped to the tools or skills present (contracts/host-capabilities.md "Choosing a path" step 2), every rule unchanged; for Antigravity, the steps to use the `gdrive` skill.
- [ ] T037 [US4] Rerun T035 and all `evals/workspace/drive-*` cases (Cowork names) one at a time; record.
- [ ] T038 [US4] Real runs: start an idea in Drive mode on Codex, continue it on Antigravity, then in Cowork on the web, and the other way round; check the Drive folder against `specs/002-drive-workspace/contracts/drive-workspace.md`; record the rows (SC-003).
  - 14/11/2026: Antigravity leg done: idea started in Drive mode in `vibebiz-uat-agy`, all files private and Fio's own (`evals/RESULTS.md`, 9458e54). Codex leg and the cross-host continuation waived by Fio, 14/11/2026 (no more real Google runs on either host).

---

## Phase 8: User Story 5 - Slides and Docs on Codex and Antigravity (Priority: P2)

- [ ] T039 [US5] `core/package.md` §13 and its Slides and Docs steps: the creation path per host by the tools or skills present (T004, T007), the same content rules, a table plus a link instead of any image that would need to be public.
- [ ] T040 [US5] Eval case with the Codex tool profile of the fake (if T004 found tools a fake can mimic) for a Docs creation; red first, then green.
- [ ] T041 [US5] Real runs: package the example idea to Slides and Docs on Codex and on Antigravity; check every number against `data.json` and that nothing is shared or public; record (SC-004).
  - 14/11/2026: Antigravity leg waived by Fio, not verified headless (`evals/RESULTS.md`, T041 rows); setup-fallback rule kept (a0bb2a6). Codex leg waived by Fio, 14/11/2026.

---

## Phase 9: User Story 6 - Views in the host (Priority: P2)

- [ ] T042 [US6] `core/package.md`: after writing the views, show them by the tools present (Artifact; Codex `visualize` or in-app browser; Antigravity preview or browser, as measured in T009); else give the paths.
- [ ] T043 [US6] Eval case `evals/package/views-no-artifact/` (red first): no Artifact tool; graders: the paths are given, nothing published.
- [ ] T044 [US6] Real runs on Codex and Antigravity apps: the views appear; record.

---

## Phase 10: Docs and instructions (constitution VII)

- [x] T045 [P] `README.md` and `README.vi.md`: install per host, skill name forms, how to connect Google on each host, the capability table in plain words.
- [x] T046 [P] `docs/quick-start.md`, `docs/commands.md`, `docs/faq.md`, `docs/admin-setup.md`: the same per host, the duplicate-install note (T020), Antigravity's imported copy, privacy wording for Codex's and Antigravity's Google integrations.
- [x] T047 [P] `src/skills/help/situation-map.md` and `help`'s answers: "which app can I use", "how do I connect Google here", "where do I see the deck here".
- [x] T048 `CLAUDE.md` "Plugin shape" (`src/skills/`, `.plugin-skills/` generated) and "Workspace and outputs" (views and Drive per host); `PRIVACY.md` (data stays in the user's workspace and Google Drive on every host); `evals/README.md` and spec 002 Path Conventions follow the new paths.
- [x] T049 Edit the new Vietnamese text with vietnamizer, keeping the original voice, for readers who are not technical.
- [x] T050 Regenerate `.plugin-skills/`; run `test_build.py`, `test_docs_map.py`.

---

## Phase 11: Release 0.1.5 and the catalog

- [ ] T051 Bump the three manifests and `templates/workspace/index.json` to 0.1.5, regenerate `.plugin-skills/`, `CHANGELOG.md` `[0.1.5]`; release review per `CLAUDE.md`; pull request with code and security reviews (Drive and Google integrations trigger the security gate); merge on `MERGE OK`.
- [ ] T052 Tag `v0.1.5` on the merge commit; build `vibebiz.plugin` from a fresh clone; validate, `test_build`, package check on the example; publish the GitHub Release with the archive and its sha256.
- [ ] T053 From the tag, per quickstart.md: install on Claude Code (scratch `github` marketplace at the tag), Codex (scratch marketplace at the tag), Antigravity (`agy plugin install https://github.com/finolabs/vibebiz`, with `--ref` if supported; else a clone at the tag, recorded); one row per host in `evals/RESULTS.md` (FR-015), committed by a follow-up pull request.
- [ ] T054 Cowork smoke test with the release archive; Fio runs it (spec 002's T049 checklist still applies).
- [ ] T055 In `finolabs/plugins`: a new branch from `main` adding vibebiz to both catalogs (Claude Code pinned to `v0.1.5`) and the README table; `scripts/check-catalogs.py --remote` passes; pull request with code and security reviews; merge with Fio's go. Ask Fio whether to delete the superseded `list-vibebiz` branch.
- [ ] T056 After the catalog merge, install `vibebiz@finolabs` on Claude Code and Codex from the catalog itself and record; update the catalog README's note on which pins were checked against an install.

---

## Dependencies & Execution Order

- Phase 1 first; its stop rule gates Phase 7. T002, T003, T005, T006 can run in parallel as read-only probes, but host sessions still go one at a time on this machine. T004 and T009 need Fio.
- Phase 2 blocks every later phase.
- Phase 3 and Phase 4 can run in parallel after Phase 2.
- Phases 5 and 6 need Phase 4. Phase 7 needs Phase 4 and T004/T007. Phase 8 needs Phase 7's mapping. Phase 9 needs T009.
- Phase 10 needs Phases 3–9. Phase 11 needs everything; T055 needs T053's rows; T056 needs T055 merged.

### Parallel opportunities

- T014, T015, T016 (three manifest files).
- T021–T024 (four new eval cases), then their red runs one at a time.
- T045, T046, T047 (different docs).

## Implementation Strategy

MVP is Phases 1–3: Claude Code installs from the repository root, which the catalog needs first. Phases 4–6 give the folder journey on every host; Phases 7–9 bring Drive, Slides and Docs, and the views to parity. Nothing ships until Phase 11, since the version and the catalog entry describe all hosts together.

## Notes

- `.plugin-skills/` is generated: never edit it by hand; regenerate in the same commit as the source change, and keep large generated updates in their own commit.
- The constitution exceptions in plan.md "Complexity Tracking" stay visible in the release pull request.
- Phase 1 results can change this list; update it before Phase 7 if a stop rule fires.
