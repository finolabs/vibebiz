# Tasks: A wider framework library that vibebiz chooses from on its own

**Input**: Design documents from `specs/004-framework-library/`

**Prerequisites**: [plan.md](plan.md), [spec.md](spec.md), [research.md](research.md), [data-model.md](data-model.md), [contracts/framework-selection.md](contracts/framework-selection.md), [quickstart.md](quickstart.md)

**Tests**: required by constitution V. Every instruction change starts from an eval case or a check that fails for the reason the change addresses, and ends with it passing. Structure is checked in code (`scripts/checks/`).

**Docs**: required by constitution VII. Phase 8 updates everything that describes the library, in the same pull request as the behavior.

**Heavy jobs**: eval runs go one at a time, at a one-minute load of 25 or less. Run targeted modules only, never more than two per command.

**Delegation**: Phases 1 to 5 stay in this session, because they form the seam that every card depends on. In Phase 6 the three batches go to parallel delegated runs, following `delegate`. Reviews go to another family.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: can run in parallel: a different file, with no dependency on an unfinished task.
- **[Story]**: the user story in spec.md.

---

## Phase 1: Setup

**Purpose**: a baseline to compare against, and shared fixtures.

- [x] T001 Run the existing framework suite (`evals/frameworks/`, 12 cases) on main efb0e99. Record the scores in `evals/RESULTS.md` as the spec 004 baseline (SC-002 regression reference).
- [x] T002 [P] ~~Add one fictional coverage record per lens to `evals/fixtures/frameworks/`: problem-framing, outcome, challenge, solution-sketch and plan. Each has one open category and one category already filled by a card, so the fit and skip cases can share them.~~ Dropped 19/11/2026: every case seeds its own record in `scaffold.sh`, so a shared fixture would add a second copy to keep in step.

---

## Phase 2: Foundational (blocking)

**Purpose**: the gap-driven rule and the checks every card relies on.

**⚠️ CRITICAL**: no card work starts before this phase passes.

- [x] T003 Add `scripts/checks/framework_names.py` and its test `scripts/checks/test_framework_names.py`. It reads an eval run's question-tool calls and fails when a question, option, description or preview contains a card's `name` or `id`, or asks the user to choose a method (SC-001). The test runs fixtures that pass and fail, red first. Done as generated graders instead of a log reader: `framework_names.py --write` puts `no-framework-name.md` (`tool_used` on `AskUserQuestion`, `max: 0`) and `no-framework-name-in-text.md` (the final message, since headless runs show the round as text) in every framework case, and `test_framework_names.py` fails when one is missing or stale.
- [x] T004 [US2] Replace `evals/frameworks/cap-two-per-lens/` with `evals/frameworks/gap-driven-no-stacking/`. Two problem-framing cards are applied and A is still `partial`, so a third fitting card is handed over; a category already `clear` gets none. Run it on the current build: it must fail, because the current router stops at two.
- [x] T005 [US2] In `core/router.md` "Frameworks", replace rule 2 with the gap-driven rule (contract "When a card is handed over"). Add the `framework_reasons` line to rule 3, and edit the by-name "does not fit" reason (contract "By name").
- [x] T006 [P] [US2] In `core/lenses/challenge.md` and `core/lenses/solution-sketch.md`, replace "At most two cards per lens per idea" with the gap-driven rule's one line, pointing to the router.
- [x] T007 [P] [US2] In `core/plan.md` §6, replace "fewer than two planning cards" with the gap-driven conditions, and name "three scenarios" where the module writes M (research R6).
- [x] T008 [P] [US2] In `templates/idea/coverage.md`, update the comment and document the optional `framework_reasons`. Update `specs/001-idea-to-prd/data-model.md` "Category" to match data-model.md. Run `python3 -m unittest scripts/checks/test_workspace.py` to confirm a workspace with and without the field is valid.
- [x] T009 [P] In `scripts/checks/test_cards.py`, add the lens check (data-model "Validation"), with a fixture card whose lens is wrong, red first.
- [x] T010 Rebuild with `python3 scripts/build_plugin.py --skills`. T004 now passes. Rerun `by-name-fits-swot` and `by-name-mismatch-bsc` and the nine `gap-*` cases, which must still pass. Run T003's check over these runs.

**Checkpoint**: the router hands cards by gap with no per-lens count, and the name check runs.

---

## Phase 3: User Story 1 - SIPOC without the word (Priority: P1) 🎯 MVP

**Goal**: a process-automation idea is framed with SIPOC through plain questions, and its result shows in the outputs.

**Independent Test**: `fit-sipoc` and `skip-sipoc` pass, and T003's check passes on both.

- [x] T011 [US1] Write `evals/frameworks/fit-sipoc/` and `evals/frameworks/skip-sipoc/`, red first:
  - `fit-sipoc`: a warehouse-to-store replenishment idea with E open. SIPOC's questions are asked without its name.
  - `skip-sipoc`: a customer journey idea with no internal hand-off. The journey-map card is chosen instead.
- [x] T012 [US1] Write `packs/frameworks/sipoc.md` (data-model row 1, `core: false`). Use the seven sections and the Requirements column, describe both forms in `origin`, and name journey-map-service-blueprint and lean-dmaic in "When not to use". Write it in vibebiz's own words with a fictional fashion example. Follow the `writing-for-agents` skill.
- [ ] T013 [US1] Rebuild, then run T011's two cases and T003's check. Run `python3 -m unittest scripts/checks/test_cards.py`. **Open (19/11/2026):** fit-sipoc unstable at 0.50 to 0.67; `one-new-card-per-gap` fails in every run (see `evals/RESULTS.md`). Next: check whether a lens draws on a second card in one round now that the per-lens limit is gone, and seed the gap-* fixtures with the sections their `clear` categories claim.

**Checkpoint**: SIPOC works on its own and the MVP can be shown.

---

## Phase 4: User Story 2 - Several frameworks for one idea (Priority: P1)

**Goal**: cards are combined across lenses, with a reason for each, and all of them are named in the package.

**Independent Test**: `combine-across-lenses` passes, and the package check flags a missing framework name.

- [x] T014 [US2] Write `evals/frameworks/combine-across-lenses/`, red first. It is a fixed coverage record with A, C, D and E open over several rounds. The expected cards are handed over, each with one line in `framework_reasons`, and no card goes to a `clear` category. **Accepted at 2/3 (Fio, 23/11/2026):** after the card index and the C confirmation answer, combine-9 scored 0.60, 1.00, 1.00; the red run skipped router step 8's lookup for D and E in later rounds. A stable 3/3 is left to the Cowork smoke test, where each round is answered; no Agent SDK harness for now (`evals/RESULTS.md`).
- [x] T015 [P] [US2] Add a `scripts/checks/fixtures/package/` case with four applied cards, one of them missing from `frameworks[]` of its slide. `python3 -m unittest scripts/checks/test_package_check.py` must flag it (SC-004). Add a passing twin.
- [x] T016 [US2] In `core/export-guidelines.md`, name "pyramid principle / SCQA" in the board rule at line 24, and add the rule that a framework result which does not fit the slide's fixed layout goes to the appendix (FR-008).
- [x] T017 [US2] Rebuild, then run T014, T015 and T003's check. Done 23/11/2026: `--skills` rebuild left nothing to regenerate; T014 is combine-9 on this build (2/3, accepted above); `test_package_check.py` 42 OK; T003's graders `no-framework-name` and `no-framework-name-in-text` passed in all three combine-9 runs and `test_framework_names.py` 5 OK.

**Checkpoint**: the gap-driven rule and multi-framework packages are proven before the library grows.

---

## Phase 5: User Story 3 - Each framework builds on the last (Priority: P1)

**Goal**: the cards form a routing map. The router uses it to order cards, pass context to the next card and redo work when facts change (spec FR-012 to FR-017).

**Independent Test**: the five map cases pass, `framework_map.py check` passes on every shipped card, and `docs/framework-map.md` matches the cards.

- [x] T018 [US3] Write `scripts/checks/framework_map.py` with `check` and `render` (research R15), and its test `scripts/checks/test_framework_map.py` with fixture cards, red first:
  - a link to a missing card;
  - `instead_of` declared on one side only;
  - a `needs` cycle;
  - a bad `revisit_when` value;
  - a passing set.
- [x] T019 [US3] Extend `scripts/checks/test_cards.py` to require the four link keys on every card (lists may be empty). Done 23/11/2026 with the fixture `invalid-missing-link-key.md`, red first.
- [x] T020 [P] [US3] Write the five map cases under `evals/frameworks/`, red first:
  - `map-feeds-preferred`: two cards fit E equally, and an applied card feeds one;
  - `map-context-carryover`: the fed card's questions do not re-ask the passed result;
  - `map-needs-gate`: `npv` is not handed over before `tco` or `build-buy-partner-roi`, or before M is clear;
  - `map-instead-of`: `swot` is applied, so `six-thinking-hats` is not added for D;
  - `map-revisit`: a superseded baseline in C sends `driver-tree` back, then `test-and-control-pilot`, which it feeds, and every question is about the change.
  - Done 23/11/2026. Until `npv` and `tco` ship, `map-needs-gate` checks `test-and-control-pilot` (needs `assumption-map` or `driver-tree`) with C deferred. The last three cases were written after the router rules, so they were not red first.
- [x] T021 [US3] In `core/router.md` "Frameworks", add rule 6 (`needs`), rule 7 (`instead_of`), the feeds preference in rule 3 and the context hand-off. Add the revisit triggers under "Frameworks" and in the round-planning steps (contract "Context passed on" and "Revisits").
- [x] T022 [P] [US3] In the four lens files under `core/lenses/` and in `core/plan.md` §6, add the line "read the passed results named in the hand-off before asking, and drop the questions they answer" (FR-015).
- [x] T023 [P] [US3] In `src/skills/continue/SKILL.md`, after recording a board decision "changes" or a tech review, tell the router which event to fire (`board-changes`, `tech-review`), so FR-016 can redo the cards. Keep the body under 3,000 words.
- [x] T024 [US3] Add the four link keys to the 15 existing cards and to `packs/frameworks/sipoc.md`, from the data-model draft map. Fix any row the map check rejects. The route diagrams in `assets/diagrams/src/route-start.*.html` and `route-next.*.html` (README "How it works", Fio 19/11/2026) are the canonical entry routes and branches: make the draft map's `feeds` and "When to use" match them (for example value-proposition-canvas, theory-of-constraints and swot each lead to driver-tree; driver-tree to assumption-map or pre-mortem by whether the result depends on how people react), or change the diagrams in the same pull request.
- [x] T025 [US3] Run `framework_map.py render` to write `docs/framework-map.md` in plain Vietnamese. Add a test that fails when it is stale.
- [x] T026 [US3] Rebuild, then run T018, T019, T025's test, the five T020 cases and T003's check. Rerun `gap-driven-no-stacking` and `combine-across-lenses`, which must still pass. **Open (23/11/2026):** the tests pass; map-revisit, map-feeds-preferred, map-needs-gate and combine-across-lenses pass; map-context-carryover 1/2 (the `fed by` prefix), gap-driven-no-stacking 2/3 and map-instead-of 0.80, each red run skipping a card read or rule after reading the index (`evals/RESULTS.md`). **Accepted as is (Fio, 23/11/2026)**; the skipped card read is left open for a later design change (the index carrying what the router needs, or step 8 recording each card it read).

**Checkpoint**: the 16 cards on file are linked, and the router follows the map before the library grows.

---

## Phase 6: User Story 4 - The library grows by cards (Priority: P2)

**Goal**: the 25 catalog cards ship with no router change (FR-009).

**Independent Test**: every `fit-<id>` and `skip-<id>` case passes, `test_cards.py` counts 41 cards, and T003's check passes on all of them.

- [x] T027 [US4] In `scripts/checks/test_cards.py`, set `TOTAL_COUNT = 41` and keep `CORE_COUNT = 15`. The check stays red until T030 to T054 land.
- [x] T028 [US4] Dispatch the three batches below as parallel runs through `delegate`, one per run, each in its own worktree. Each brief carries:
  - an existing card as the template;
  - the data-model rows of its batch;
  - its lens fixture from T002;
  - the map rules: each card's links from the data-model draft map, and edits to other cards' `feeds` or `instead_of` lines where its links require both sides;
  - the red-first rule;
  - `writing-for-agents`;
  - "own words, fictional example, no invented figures (ask-protocol rules 5 and 10)";
  - the tests to run: `test_cards.py` and the batch's eval cases one at a time.
- [x] T029 [US4] Accept each batch through `checks`. Merge it into the feature branch, rebuild, and get a code and a security review from another family. Done (25/11/2026): batches 1–3 accepted and merged; Codex security review of 440bf16..f94d155 found nothing; Codex code review found four P2s, fixed in 352ba1f, 698e4bf, c61f11a, d08597c and 0e11601 after two re-reviews (rework limit 2).

### Batch 1: problem-framing and outcome (6 cards)

- [x] T030 [P] [US4] `issue-tree` (problem-framing, fills A): red `evals/frameworks/fit-issue-tree/` and `evals/frameworks/skip-issue-tree/` first, then `packs/frameworks/issue-tree.md` (`core: false`, data-model row), neighbours named in "When not to use", the four link keys from the data-model draft map; both cases pass, and so does `framework_map.py check`. Done in batch 1 (69237b8): fit red 0.75, fit and skip 1.0 after the card (23/11/2026).
- [x] T031 [P] [US4] `value-chain` (problem-framing, fills A, B): red `evals/frameworks/fit-value-chain/` and `evals/frameworks/skip-value-chain/` first, then `packs/frameworks/value-chain.md` (`core: false`, data-model row), neighbours named in "When not to use", the four link keys from the data-model draft map; both cases pass, and so does `framework_map.py check`. Done in batch 1 (69237b8): fit red 0.75, fit and skip 1.0 after the card (23/11/2026).
- [x] T032 [P] [US4] `north-star-metric` (outcome, fills C): red `evals/frameworks/fit-north-star-metric/` and `evals/frameworks/skip-north-star-metric/` first, then `packs/frameworks/north-star-metric.md` (`core: false`, data-model row), neighbours named in "When not to use", the four link keys from the data-model draft map; both cases pass, and so does `framework_map.py check`. Done in batch 1 (69237b8): fit red 0.75, fit and skip 1.0 after the card (23/11/2026).
- [x] T033 [P] [US4] `okr` (outcome, fills C, O): red `evals/frameworks/fit-okr/` and `evals/frameworks/skip-okr/` first, then `packs/frameworks/okr.md` (`core: false`, data-model row), neighbours named in "When not to use", the four link keys from the data-model draft map; both cases pass, and so does `framework_map.py check`. Done in batch 1 (69237b8): fit red 0.75, fit and skip 1.0 after the card (23/11/2026).
- [x] T034 [P] [US4] `smart` (outcome, fills C, O): red `evals/frameworks/fit-smart/` and `evals/frameworks/skip-smart/` first, then `packs/frameworks/smart.md` (`core: false`, data-model row), neighbours named in "When not to use", the four link keys from the data-model draft map; both cases pass, and so does `framework_map.py check`. Done in batch 1 (69237b8): fit red 0.75, fit and skip 1.0 after the card (23/11/2026).
- [x] T035 [P] [US4] `leading-lagging` (outcome, fills C): red `evals/frameworks/fit-leading-lagging/` and `evals/frameworks/skip-leading-lagging/` first, then `packs/frameworks/leading-lagging.md` (`core: false`, data-model row), neighbours named in "When not to use", the four link keys from the data-model draft map; both cases pass, and so does `framework_map.py check`. Done in batch 1 (69237b8): fit red 0.75, fit and skip 1.0 after the card (23/11/2026).

### Batch 2: challenge and solution-sketch (8 cards)

- [x] T036 [P] [US4] `five-forces` (challenge, fills D, K): red `evals/frameworks/fit-five-forces/` and `evals/frameworks/skip-five-forces/` first, then `packs/frameworks/five-forces.md` (`core: false`, data-model row), neighbours named in "When not to use", the four link keys from the data-model draft map; both cases pass, and so does `framework_map.py check`. Done in batch 2 (94c6971): fit red 0.60, fit and skip 1.0 after the card, some on a second run (23/11/2026).
- [x] T037 [P] [US4] `pestel` (challenge, fills K): red `evals/frameworks/fit-pestel/` and `evals/frameworks/skip-pestel/` first, then `packs/frameworks/pestel.md` (`core: false`, data-model row), neighbours named in "When not to use", the four link keys from the data-model draft map; both cases pass, and so does `framework_map.py check`. Done in batch 2 (94c6971): fit red 0.60, fit and skip 1.0 after the card, some on a second run (23/11/2026).
- [x] T038 [P] [US4] `cost-of-inaction` (challenge, fills D, M): red `evals/frameworks/fit-cost-of-inaction/` and `evals/frameworks/skip-cost-of-inaction/` first, then `packs/frameworks/cost-of-inaction.md` (`core: false`, data-model row), neighbours named in "When not to use", the four link keys from the data-model draft map; both cases pass, and so does `framework_map.py check`. Done in batch 2 (94c6971): fit red 0.60, fit and skip 1.0 after the card, some on a second run (23/11/2026).
- [x] T039 [P] [US4] `six-thinking-hats` (challenge, fills D, K): red `evals/frameworks/fit-six-thinking-hats/` and `evals/frameworks/skip-six-thinking-hats/` first, then `packs/frameworks/six-thinking-hats.md` (`core: false`, data-model row), neighbours named in "When not to use", the four link keys from the data-model draft map; both cases pass, and so does `framework_map.py check`. Done in batch 2 (94c6971): fit red 0.60, fit and skip 1.0 after the card, some on a second run (23/11/2026).
- [x] T040 [P] [US4] `theory-of-constraints` (challenge, fills D): red `evals/frameworks/fit-theory-of-constraints/` and `evals/frameworks/skip-theory-of-constraints/` first, then `packs/frameworks/theory-of-constraints.md` (`core: false`, data-model row), neighbours named in "When not to use", the four link keys from the data-model draft map; both cases pass, and so does `framework_map.py check`. Done in batch 2 (94c6971): fit red 0.60, fit and skip 1.0 after the card, some on a second run (23/11/2026).
- [x] T041 [P] [US4] `value-proposition-canvas` (solution-sketch, fills E): red `evals/frameworks/fit-value-proposition-canvas/` and `evals/frameworks/skip-value-proposition-canvas/` first, then `packs/frameworks/value-proposition-canvas.md` (`core: false`, data-model row), neighbours named in "When not to use", the four link keys from the data-model draft map; both cases pass, and so does `framework_map.py check`. Done in batch 2 (94c6971): fit red 0.60, fit and skip 1.0 after the card, some on a second run (23/11/2026).
- [x] T042 [P] [US4] `kano` (solution-sketch, fills E): red `evals/frameworks/fit-kano/` and `evals/frameworks/skip-kano/` first, then `packs/frameworks/kano.md` (`core: false`, data-model row), neighbours named in "When not to use", the four link keys from the data-model draft map; both cases pass, and so does `framework_map.py check`. Done in batch 2 (94c6971): fit red 0.60, fit and skip 1.0 after the card, some on a second run (23/11/2026).
- [x] T043 [P] [US4] `lean-dmaic` (solution-sketch, fills E, J): red `evals/frameworks/fit-lean-dmaic/` and `evals/frameworks/skip-lean-dmaic/` first, then `packs/frameworks/lean-dmaic.md` (`core: false`, data-model row), neighbours named in "When not to use", the four link keys from the data-model draft map; both cases pass, and so does `framework_map.py check`. Done in batch 2 (94c6971): fit red 0.60, fit and skip 1.0 after the card, some on a second run (23/11/2026).

### Batch 3: plan (11 cards)

- [x] T044 [P] [US4] `stp` (plan, fills B, E): red `evals/frameworks/fit-stp/` and `evals/frameworks/skip-stp/` first, then `packs/frameworks/stp.md` (`core: false`, data-model row), neighbours named in "When not to use", the four link keys from the data-model draft map; both cases pass, and so does `framework_map.py check` Done: fit red 0.75–0.60 before the card; after the card-selection step (75a7bad) fit 1.0 on 5986723, skip 1.0 (24/11/2026).
- [x] T045 [P] [US4] `ansoff` (plan, fills D): red `evals/frameworks/fit-ansoff/` and `evals/frameworks/skip-ansoff/` first, then `packs/frameworks/ansoff.md` (`core: false`, data-model row), neighbours named in "When not to use", the four link keys from the data-model draft map; both cases pass, and so does `framework_map.py check` Done: fit red 0.75–0.60 before the card; after the card-selection step (75a7bad) fit 1.0 on 810c669, skip 1.0 (24/11/2026).
- [ ] T046 [P] [US4] `bcg-matrix` (plan, fills D, M): red `evals/frameworks/fit-bcg-matrix/` and `evals/frameworks/skip-bcg-matrix/` first, then `packs/frameworks/bcg-matrix.md` (`core: false`, data-model row), neighbours named in "When not to use", the four link keys from the data-model draft map; both cases pass, and so does `framework_map.py check` Open (24/11/2026): fit 1.0 on 5986723; skip-bcg-matrix open: the closing message names the neighbour card (ansoff) on 5986723 and 810c669. On 2980684 (25/11/2026): skip 1.0, fit 0.75 (no reason line; the run stopped on open questions).
- [x] T047 [P] [US4] `rice-ice` (plan, fills E): red `evals/frameworks/fit-rice-ice/` and `evals/frameworks/skip-rice-ice/` first, then `packs/frameworks/rice-ice.md` (`core: false`, data-model row), neighbours named in "When not to use", the four link keys from the data-model draft map; both cases pass, and so does `framework_map.py check` Done: fit red 0.75–0.60 before the card; after the card-selection step (75a7bad) fit 1.0 on 812bbf1, skip 1.0 (24/11/2026).
- [x] T048 [P] [US4] `value-effort` (plan, fills E): red `evals/frameworks/fit-value-effort/` and `evals/frameworks/skip-value-effort/` first, then `packs/frameworks/value-effort.md` (`core: false`, data-model row), neighbours named in "When not to use", the four link keys from the data-model draft map; both cases pass, and so does `framework_map.py check` Done: fit red 0.75–0.60 before the card; after the card-selection step (75a7bad) fit 1.0 on 812bbf1, skip 1.0 (24/11/2026).
- [x] T049 [P] [US4] `tco` (plan, fills M): red `evals/frameworks/fit-tco/` and `evals/frameworks/skip-tco/` first, then `packs/frameworks/tco.md` (`core: false`, data-model row), neighbours named in "When not to use", the four link keys from the data-model draft map; both cases pass, and so does `framework_map.py check` Done: fit red 0.75–0.60 before the card; after the card-selection step (75a7bad) fit 1.0 on 812bbf1, skip 1.0 (24/11/2026).
- [x] T050 [P] [US4] `npv` (plan, fills M): red `evals/frameworks/fit-npv/` and `evals/frameworks/skip-npv/` first, then `packs/frameworks/npv.md` (`core: false`, data-model row), neighbours named in "When not to use", the four link keys from the data-model draft map; both cases pass, and so does `framework_map.py check` Done: fit red 0.75–0.60 before the card; after the card-selection step (75a7bad) fit 1.0 on 5986723, skip 1.0 (24/11/2026).
- [x] T051 [P] [US4] `stage-gate` (plan, fills M, L): red `evals/frameworks/fit-stage-gate/` and `evals/frameworks/skip-stage-gate/` first, then `packs/frameworks/stage-gate.md` (`core: false`, data-model row), neighbours named in "When not to use", the four link keys from the data-model draft map; both cases pass, and so does `framework_map.py check` Done: fit red 0.75–0.60 before the card; after the card-selection step (75a7bad) fit 1.0 on 810c669, skip 1.0 (24/11/2026).
- [x] T052 [P] [US4] `raci` (plan, fills B, L): red `evals/frameworks/fit-raci/` and `evals/frameworks/skip-raci/` first, then `packs/frameworks/raci.md` (`core: false`, data-model row), neighbours named in "When not to use", the four link keys from the data-model draft map; both cases pass, and so does `framework_map.py check` Done: fit red 0.75–0.60 before the card; after the card-selection step (75a7bad) fit 1.0 on 812bbf1, skip 1.0 (24/11/2026).
- [ ] T053 [P] [US4] `kotter` (plan, fills L): red `evals/frameworks/fit-kotter/` and `evals/frameworks/skip-kotter/` first, then `packs/frameworks/kotter.md` (`core: false`, data-model row), neighbours named in "When not to use", the four link keys from the data-model draft map; both cases pass, and so does `framework_map.py check` Open (24/11/2026): skip 1.0; fit-kotter open: the reason is recorded but the closing message names the card on 5986723 and 810c669. On 2980684 (25/11/2026): fit and skip both 0.75 on a card name in a message.
- [x] T054 [P] [US4] `mckinsey-7s` (plan, fills L): red `evals/frameworks/fit-mckinsey-7s/` and `evals/frameworks/skip-mckinsey-7s/` first, then `packs/frameworks/mckinsey-7s.md` (`core: false`, data-model row), neighbours named in "When not to use", the four link keys from the data-model draft map; both cases pass, and so does `framework_map.py check` Open (24/11/2026): skip 1.0; fit-mckinsey-7s open: the package card-selection step skips the card in 3 runs, with no cause in the traces. Done (25/11/2026): fit and skip 1.0 on 2980684.

- [ ] T055 [US4] With every batch merged, rebuild. `test_cards.py` passes at 41 cards, `framework_map.py check` passes, and `docs/framework-map.md` is rendered again. Run T003's check over all `fit-` and `skip-` runs. Partial (24/11/2026): 41 cards, `test_cards.py`, `test_framework_map.py` and `framework_map.py check` pass; the plan fit and skip runs are in `evals/RESULTS.md`, with fit-kotter, fit-mckinsey-7s and skip-bcg-matrix open. On 2980684 (25/11/2026): 16/22; open are a card name in a message (fit-kotter, fit-npv, skip-ansoff, skip-kotter, skip-value-effort) and a missing reason line (fit-ansoff, fit-bcg-matrix).

**Checkpoint**: 41 cards and every new card proven where it fits and where it does not.

---

## Phase 7: Language

- [ ] T056 Run one `vietnamizer` pass over the "Questions" and "Fashion example" sections of the 26 new cards (research R10). Change only wording, never meaning. Rerun `test_cards.py`.

---

## Phase 8: Docs, records and release review

- [ ] T057 [P] Update `docs/workflow.md` ("15 phương pháp" → the library as shipped, chosen by vibebiz), `docs/glossary.md`, `src/skills/help/situation-map.md` (pointing to `docs/framework-map.md` for how the methods connect) and the README pair (FR-010). Edit the Vietnamese with `vietnamizer`.
- [ ] T058 Run `python3 -m unittest scripts/checks/test_docs_map.py`.
- [ ] T059 [P] Update the suite 10 rows in `evals/README.md`: `gap-driven-no-stacking`, the `fit-`/`skip-` cases, `combine-across-lenses` and the name check.
- [ ] T060 [P] Update `CLAUDE.md` line 30 to "the framework library in `packs/frameworks/` (spec 004); a card is applied only while its category is open and not already filled by a card", with Fio's yes on this spec.
- [ ] T061 [P] Add one-line pointers to spec 004 in `specs/001-idea-to-prd/spec.md`: FR-037, SC-011, Appendix F, and the Appendix I row 10 (research R1).
- [ ] T062 Run the whole framework suite once on the final build, and record it in `evals/RESULTS.md`. SC-001 must be 100%, SC-002 at least 90%, and SC-003 met for every new card.
- [ ] T063 Run the simulated-session suite (SC-005): rounds to readiness at four sessions or fewer, key facts at 85% or more. Record the result.
- [ ] T064 Fio runs the Cowork smoke test (`specs/001-idea-to-prd/quickstart.md`) on the release candidate, as constitution §V requires.
- [ ] T065 Open the pull request with the `fnl-router` line (depth NORMAL, trigger consumers) and get the two posted reviews. Merge on Fio's go. Release 0.1.9 follows `versioning`, with tag, GitHub Release and catalog pin, each on Fio's go.

---

## Dependencies

- Phase 1 → Phase 2 → Phases 3 and 4. Phases 3 and 4 can run in either order; both need T010.
- Phase 5 (the map) needs Phases 2 to 4.
- Phase 6 needs Phase 5. T030 to T054 run in parallel inside their batch, and the three batches run in parallel.
- Phase 7 needs T055. Phase 8 needs Phase 7, except T059 to T061, which can start after Phase 5.

## Implementation strategy

- **MVP**: Phases 1 to 3 (SIPOC on the gap-driven rule).
- **Next**: Phase 4 proves that combining frameworks works. Phase 5 links the cards into the routing map, before the library triples.
- **Then**: Phase 6 adds the cards, links included, in three parallel batches.
- **Last**: Phases 7 and 8 finish the language and the docs, and cut the release.
