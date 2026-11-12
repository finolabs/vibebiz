# Tasks: Idea to PRD

**Input**: Design documents from `/specs/001-idea-to-prd/`
**Prerequisites**: plan.md, spec.md (appendices A–I), research.md, data-model.md, contracts/, quickstart.md

**Tests**: Included. Constitution Principle V requires every behavior change to start from a failing eval case or check, so each story's tests come first and must fail before any behavior module or skill of that story is written. Phase 2 holds only templates and checks, no behavior.

**Docs**: Constitution Principle VII requires every change to a skill, template or output to update its descriptions in the same change, so each story ends with a docs task for what it ships; User Story 5 completes the docs, diagrams and example.

**Review**: Each story is built on its own branch and merged through a pull request with a code review, plus a security and privacy review when it touches licensing, privacy or user data handling (constitution, Development Workflow).

**Organization**: Tasks are grouped by user story so each story can be built, tested and demonstrated on its own.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: can run in parallel (different files, no dependency on an incomplete task)
- **[Story]**: US1–US6 map to the spec's user stories
- Paths are relative to the repository root; "module" files live in `core/` and are copied into skills by the build

---

## Phase 1: Setup (Shared Infrastructure)

**Purpose**: Repository skeleton, manifest, build and the repository documents FR-033 requires.

- [ ] T001 Create the source tree from plan.md "Source Code": `.claude-plugin/`, `skills/{new,continue,status,package,constitution,help}/`, `core/lenses/`, `templates/{workspace,idea,exports}/`, `packs/{frameworks,retail-fashion,ai-patterns-retail}/`, `docs/diagrams/`, `examples/`, `evals/`, `scripts/checks/`, each with a `.gitkeep` until it holds a file
- [ ] T002 Write `.claude-plugin/plugin.json` with `name` "vibebiz", `version` "0.1.0", `description`, `author` Fioenix, `license` "PolyForm-Noncommercial-1.0.0", `repository`, `keywords`
- [ ] T003 Write `scripts/build_plugin.py` (Python 3.10+ stdlib): assemble `dist/vibebiz/` with the manifest, the six skills, a copy of `core/` inside each skill's `references/core/`, `templates/`, `packs/`, `docs/`, `examples/`; exclude `.specify/`, `.claude/`, `specs/`, `evals/`, `scripts/`; zip `dist/vibebiz.plugin` (research R2, R12)
- [ ] T004 [P] Write `scripts/checks/test_build.py`: after a build, every path a `SKILL.md` references resolves inside its own skill folder, no development folder is present, and exactly six skills exist
- [ ] T005 [P] Write `LICENSE` (PolyForm Noncommercial 1.0.0, copyright Fioenix), `COMMERCIAL-LICENSE.md` (free and paid grants: business, term, scope, update rights; pricing left out), `CLA.md`
- [ ] T006 [P] Write `PRIVACY.md` (data stays in the user's workspace and Google Drive; nothing sent elsewhere; no evaluator at runtime), `SECURITY.md`, `TERMS.md`, `CODE_OF_CONDUCT.md`, `CONTRIBUTING.md` (CLA required, eval-first changes, docs in the same change, own-words content, review before merge)
- [ ] T007 [P] Write `THIRD_PARTY_LICENSES.md` with the MIT notices of Spec Kit (github/spec-kit 1.4.0) and `grilling` (mattpocock/skills), and credits for framework origins
- [ ] T008 [P] Write `UPSTREAM.md`: pinned Spec Kit 1.4.0, a table of every ported section (spec template headings, `clarify` taxonomy and Deferred rule, writing rules, checklist and analyze passes) and every vibebiz-only section
- [ ] T009 [P] Write `CHANGELOG.md` with an Unreleased section per SemVer
- [ ] T010 [P] Write the skeletons of `README.md` (English) and `README.vi.md` (Vietnamese) with identical sections: what vibebiz is, who it is for, install by upload, "What ships" (empty until a story ships a skill), source-available license table (who uses it free, who needs a commercial license), privacy summary, diagram-design as companion

**Checkpoint**: `python3 scripts/build_plugin.py` produces `dist/vibebiz.plugin`; `test_build.py` passes on the empty skills.

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Templates and checks every story depends on. No behavior modules here (Principle V).

**⚠️ CRITICAL**: No user story work begins until this phase is complete.

- [ ] T011 [P] Write `scripts/checks/frontmatter.py` (stdlib YAML-subset parser for the frontmatter shapes in data-model.md) and `scripts/checks/test_frontmatter.py`
- [ ] T012 [P] Write `scripts/checks/test_snapshot.py`: a spec file's mandatory headings and subheading patterns match `.specify/templates/spec-template.md` exactly and appear after the business sections, per contracts/exports.md "Snapshot"; ids follow `FR-###` and `SC-###`
- [ ] T013 [P] Write `scripts/checks/test_workspace.py`: a workspace matches contracts/workspace-files.md (fixed English names, slug lowercase hyphenated without diacritics, `NNN` numbering, examples excluded from numbering)
- [ ] T014 [P] Write `scripts/checks/test_index.py`: the JSON block in `index.html` lists exactly the idea folders present, with fields from data-model.md "Table of contents data"
- [ ] T015 [P] Write `scripts/checks/test_docs_map.py`: the skills present in `skills/` are exactly those listed in `skills/help/situation-map.md`, `docs/commands.md` and the "What ships" sections of `README.md` and `README.vi.md`; the two READMEs have matching section structure; every image a doc embeds exists; every diagram brief names its subject and render version (passes trivially while no skill exists)
- [ ] T016 Write `templates/idea/spec.md`: Spec Kit 1.4.0 `spec-template.md` with Problem & Why, Outcome, Alternatives, AI-fit, Cost & Risk inserted before "User Scenarios & Testing"; mandatory headings unchanged (research R5)
- [ ] T017 [P] Write `templates/idea/coverage.md` with frontmatter per data-model.md "Idea" (`status` one of `clarifying | ready | packaged | presented | approved | rejected | needs-changes`; `cynefin` one of `clear | complicated | complex | chaotic`; `estimate_status` one of `not-tech-reviewed | tech-reviewed`; categories A–O each with `status` one of `clear | partial | missing | deferred` and `reason` required when deferred) and a human table body
- [ ] T018 [P] Write `templates/idea/decisions.md`, `assumptions.md`, `open-questions.md`, `glossary.md`, `plan.md` with the entry formats in data-model.md (`D-###` types `answer | dismissed-risk | board-outcome | tech-review | ground-rule-conflict | supersede`; `A-###` with `tested`, `riskiest`, `source`; `Q-###` with `owner`, `unblocks`, `blocking`, `category`, `status`)
- [ ] T019 [P] Write `templates/workspace/constitution.md` with frontmatter per data-model.md "Ground rules" (`status` `set | deferred`, `priorities`, `approval_ceiling {amount, currency}`, `vertical`, `mandatory_approvals`, optional `strategy_map`, `okrs`)
- [ ] T020 Write `templates/workspace/index.html`: fixed layout, one `<script type="application/json" id="vibebiz-data">` block, an inline renderer for status, coverage bar, next step, output links, examples section; works when opened from disk; colors as CSS tokens with dark mode (research R4)
- [ ] T021 Set up `evals/` per the plugin-evals documentation (case folders, graders, a README stating answers are embedded in prompts, `evals/RESULTS.md`) and confirm the exact `claude plugin eval` invocation; record it in quickstart.md
- [ ] T022 [P] Create fictional fixtures in `evals/fixtures/`: three fashion ideas and two other retail ideas (one-line intake, hidden key facts, the answers a user would give), all invented

**Checkpoint**: templates and checks exist; T011–T015 run (failing where no content exists yet is expected).

---

## Phase 3: User Story 1 - Turn a vague idea into a clarified requirement (Priority: P1) 🎯 MVP

**Goal**: From one sentence to a workspace, an idea folder, a draft requirement and coverage updated round by round.

**Independent Test**: In an empty folder, start with a one-sentence idea, answer three rounds; the workspace exists, the draft matches the answers, coverage shows clear/partial/missing.

### Tests for User Story 1 ⚠️ (write first, must fail)

- [ ] T023 [P] [US1] Eval suite 1 (routing) in `evals/routing/`: fixed coverage records; grader checks the next round holds only categories whose prerequisites (spec Appendix A) are clear or deferred, ordered by the impact and uncertainty scale; cases for a contradiction of an earlier decision (earlier decision shown, user asked which stands, `supersede` recorded) and for an idea that is really two ideas (split proposed)
- [ ] T024 [P] [US1] Eval suite 2 (question protocol) in `evals/ask-protocol/` with a code grader `scripts/checks/round_rules.py`: at most four questions, two to four options, recommended first, no "None"/"Other", skipped question leaves status unchanged, all-skipped round offers pause or draft, write-back present after each round
- [ ] T025 [P] [US1] Eval suite 4 (vague terms) in `evals/vague-terms/`: answers containing unquantified terms; grader checks a quantifying question or an open question was recorded
- [ ] T026 [P] [US1] Eval cases in `evals/workspace/`: empty folder, partial workspace (missing pieces restored and listed), deleted `index.html` restored, folder with unrelated files (subfolder recommended), chat without a folder (stop message, nothing written), no-answer run (assumptions recorded as open, nothing invented), English-speaking user (outputs in English)

### Implementation for User Story 1

- [ ] T027 [US1] Write `core/workspace.md`: detect a working folder (stop with the "open Cowork with a folder" message when absent), the four folder states from spec Appendix H, scaffold from `templates/`, repair only missing files and report them, never overwrite, rebuild the index JSON from frontmatter after every write
- [ ] T028 [P] [US1] Write `core/writing-rules.md`: plain language, explain a term on first use, the vague-term list that must be quantified ("real-time", "smart", "fast", "convenient", "nhanh", "thông minh", "tiện"), output language from the idea's `language`, Vietnamese style rules
- [ ] T029 [US1] Write `core/ask-protocol.md`: spec Appendix B rules (frontier only, at most four questions, two to four exclusive options, recommended first, no "None"/"Other", self-contained wording, multiSelect and previews, open questions in text, write-back after each round, budget of three rounds by default then continue/pause/draft, Skip leaves status unchanged, no-answer mode records assumptions as open)
- [ ] T030 [US1] Write `core/specify.md`: one open intake question about the situation behind the idea; create `specs/NNN-<slug>/` from `templates/idea/`; record the idea in the user's words; set `language` (research R10); draft the spec with gaps marked; initial category statuses; show a short clear/missing table
- [ ] T031 [US1] Write `core/router.md`: compute the frontier from coverage and Appendix A prerequisites; rank by impact (1 low, 2 medium, 3 high: how much the answer changes scope, cost or the board decision) times uncertainty (1 likely known, 2 partly known, 3 unknown); choose the module for each category; track `budget_rounds_used`; offer continue, pause or draft at the budget; offer package at readiness (FR-020 thresholds); look facts up before asking; on a contradiction show the earlier decision, ask which stands and record `supersede`; propose splitting an idea that holds two independent problems into two idea folders
- [ ] T032 [US1] Write `core/clarify.md`: fill G, H, N and leftover partial categories with Spec Kit `clarify`'s question style adapted to the protocol; write answers into the spec's Clarifications section by session date and apply them to the right section
- [ ] T033 [US1] Write `skills/new/SKILL.md`: description with triggers ("I have an idea", "brainstorm", "lên ý tưởng", "I want an app / AI / automation") and the boundary with `help`; steps: workspace module, ground-rules offer (deferred allowed), example offer, specify, router loop; references only its own folder
- [ ] T034 [US1] Write `skills/continue/SKILL.md` (resume path): pick the idea (ask when several), three-line summary of settled, stopped, next question (FR-029), re-read files and respect hand edits, resume the router loop
- [ ] T035 [US1] Write `skills/status/SKILL.md` (minimal): list ideas with status, coverage and next step from frontmatter, excluding examples; rebuild the index
- [ ] T036 [US1] Describe what US1 ships in the same change: entries for `new`, `continue` and `status` in `docs/commands.md` (Vietnamese draft) and `skills/help/situation-map.md`, and in the "What ships" sections of `README.md` and `README.vi.md`; `test_docs_map.py` passes
- [ ] T037 [US1] Run suites 1, 2, 4 and the workspace cases against a build; fix modules until thresholds in spec Appendix I hold; record results in `evals/RESULTS.md`
- [ ] T038 [US1] Open the US1 pull request and pass code review before merge

**Checkpoint**: US1 works alone in Claude Code with a local build.

---

## Phase 4: User Story 2 - Challenge the idea and define its outcome (Priority: P2)

**Goal**: Four lenses, anti-sycophancy, framework cards and the fashion pack turn a clarified idea into a challenged, measurable one.

**Independent Test**: A deliberately weak idea yields concrete risks, serious do-nothing and fix-the-process options, and recorded dismissed risks.

### Tests for User Story 2 ⚠️ (write first, must fail)

- [ ] T039 [P] [US2] Eval suite 3 (anti-sycophancy) in `evals/anti-sycophancy/`: at least ten weak ideas (for example "replace all customer service staff with an AI chatbot next week") and ten sound controls; grader (Jev optional, rubric fallback) checks concrete risks, no praise, do-nothing and fix-the-process weighed; thresholds 90% caught, at most 20% false alarms
- [ ] T040 [P] [US2] Eval suite 10 (frameworks) in `evals/frameworks/`: coverage records with one open gap each; grader checks the chosen card's `fills` includes the gap and no lens applies more than two cards; a by-name request that does not fit is explained
- [ ] T041 [P] [US2] Eval cases in `evals/lenses/`: outcome without baseline produces a measurement plan; AI idea records rule/automation/AI fit, data, error cost, approval points; first journey stands alone; Cynefin classification sets depth
- [ ] T042 [P] [US2] Write `scripts/checks/test_cards.py`: every card in `packs/frameworks/` has frontmatter `id`, `name`, `lens`, `fills`, `core`, `diagram_type`, `origin` and the body sections When to use, When not to use, Inputs, Questions, Writes to, Common misuse, Fashion example; exactly fifteen cards have `core: true`

### Implementation for User Story 2

- [ ] T043 [P] [US2] Write `core/anti-sycophancy.md`: constitution Principle III rules, banned praise patterns, at least one failure reason per round, dismissed risks to `decisions.md` as `dismissed-risk`
- [ ] T044 [P] [US2] Write `core/lenses/problem-framing.md` (A, B): last real occurrence, 5 Whys, JTBD, current cost estimate, one-sentence problem statement
- [ ] T045 [P] [US2] Write `core/lenses/outcome.md` (C, O): output-to-outcome rewrite, driver tree, leading and lagging indicators, measurement plan when no baseline, kill criteria, mapping to recorded OKRs or BSC perspectives
- [ ] T046 [P] [US2] Write `core/lenses/challenge.md` (D, K, part of M): pre-mortem, assumption map, test-and-control pilot design, alternatives before build, cost of inaction
- [ ] T047 [P] [US2] Write `core/lenses/solution-sketch.md` (E, F, I, J, L): current and future journey with a diagram brief, three alternatives, AI-fit decision tree, independently valuable first journey, edge cases, people whose work changes
- [ ] T048 [US2] Add the Cynefin rule to `core/router.md` (research R9): classify after intake, set depth, revisit on changed answers, record in `cynefin`
- [ ] T049 [US2] Add framework selection to `core/router.md`: pick a card only for an open category in its `fills`, at most two per lens per idea, honor by-name requests or explain the mismatch, record applied cards in the category's `frameworks`
- [ ] T050 [P] [US2] Write cards `packs/frameworks/five-whys.md`, `fishbone.md`, `jobs-to-be-done.md` in vibebiz's own words with fictional fashion examples
- [ ] T051 [P] [US2] Write cards `packs/frameworks/driver-tree.md`, `balanced-scorecard.md`
- [ ] T052 [P] [US2] Write cards `packs/frameworks/swot.md`, `pre-mortem.md`, `assumption-map.md`, `test-and-control-pilot.md`
- [ ] T053 [P] [US2] Write card `packs/frameworks/journey-map-service-blueprint.md`
- [ ] T054 [P] [US2] Write cards `packs/frameworks/marketing-mix-4p-7p.md`, `build-buy-partner-roi.md`, `moscow.md`, `adkar.md`
- [ ] T055 [P] [US2] Write card `packs/frameworks/cynefin.md` (used by the router)
- [ ] T056 [P] [US2] Write `packs/retail-fashion/` (drivers, metric definitions, diagnostic traps, promotion patterns, example questions per lens; spec Appendix G)
- [ ] T057 [P] [US2] Write `packs/ai-patterns-retail/` (nine patterns with `data_needed`, `rough_cost`, `risks`, `prior_art`, `fit`)
- [ ] T058 [US2] Describe what US2 changes in the same change: a Vietnamese draft of the lenses, frameworks (including asking for one by name) and Cynefin depth in `docs/workflow.md`, and the matching situations in `skills/help/situation-map.md`
- [ ] T059 [US2] Run suites 3, 10 and the lens cases; fix until thresholds hold; update `evals/RESULTS.md`
- [ ] T060 [US2] Open the US2 pull request and pass code review before merge

**Checkpoint**: US1 and US2 work together; a weak idea is challenged and a sound one is not blocked.

---

## Phase 5: User Story 3 - Package for the board and the tech team (Priority: P3)

**Goal**: Board and tech views, the Spec Kit snapshot, diagrams, history, from one `data.json`.

**Independent Test**: A ready idea packages with full traceability, matching numbers, labelled gaps, and a snapshot `speckit-plan` accepts unedited.

### Tests for User Story 3 ⚠️ (write first, must fail)

- [ ] T061 [P] [US3] Write `scripts/checks/package_check.py` and `test_package_check.py` per contracts/exports.md "Package check"; seeded fixtures with omissions, mismatched figures, unsourced charts, missing "not tech-reviewed" labels must all be caught (SC-007)
- [ ] T062 [P] [US3] Eval suite 6 (package) in `evals/package/`: below-readiness request offers draft; ready idea yields `data.json` that passes `package_check.py`; re-package moves the previous set to `exports/history/YYYY-MM-DD/`; Google connector unavailable offers the Artifact format; no output is shared or made public
- [ ] T063 [P] [US3] Eval suite 5 (Spec Kit compatibility) in `evals/speckit-compat/`: snapshot passes `test_snapshot.py`; an integration script copies it into a scratch Spec Kit 1.4.0 project and runs `speckit-plan` (quickstart §5)

### Implementation for User Story 3

- [ ] T064 [P] [US3] Write `core/plan.md`: business plan (approach, build/buy/fix, pilot and rollout, S/M/L cost, change management), ground-rule checks, `estimate_status` handling
- [ ] T065 [P] [US3] Write `core/checklist.md`: Definition of Ready checklists `checklists/board.md` and `checklists/tech.md`, adapted from Spec Kit `checklist` ("unit tests for English")
- [ ] T066 [P] [US3] Write `core/analyze.md`: consistency passes across spec, plan, outcome and numbers adapted from Spec Kit `analyze`; findings return to the router
- [ ] T067 [P] [US3] Write `core/export-guidelines.md`: spec Appendix D (answer-first, one message per slide, slide map 1–9 plus appendix, tech sections, aesthetics, chart rules, word limits)
- [ ] T068 [US3] Write `templates/exports/board-deck.html` and `tech-prd.html`: fixed layouts with the `vibebiz-data` JSON block and inline renderer, slots for embedded SVG or the "no diagram" table, gap and estimate labels, dark mode
- [ ] T069 [P] [US3] Write `templates/exports/links.md`
- [ ] T070 [US3] Write `core/package.md`: readiness check and draft path; run plan, checklist, analyze; one round for formats; write diagram briefs (Appendix E) and ask diagram-design to render SVG; build `data.json` with figures by id and the name of each framework applied on the slide its category feeds (FR-039); fill the HTML templates; publish private Artifacts and update in place; write Slides and Docs through the connectors with private images or table plus link, and offer the Artifact format when a connector is unavailable; move the previous set to history; write `links.md`; run the package check
- [ ] T071 [US3] Write `skills/package/SKILL.md`: triggers ("make the slides", "write the PRD", "package"), preconditions, steps via `core/package.md`, privacy refusals (no sharing, no public files)
- [ ] T072 [US3] Describe what US3 ships in the same change: `package` in `docs/commands.md`, `skills/help/situation-map.md` and the README "What ships" sections; a Vietnamese draft of `docs/reading-outputs.md`
- [ ] T073 [US3] Run suites 5 and 6; fix until thresholds hold; update `evals/RESULTS.md`
- [ ] T074 [US3] Open the US3 pull request and pass code review plus a security and privacy review (publishing, sharing and Google files) before merge

**Checkpoint**: an idea goes from intake to packaged outputs.

---

## Phase 6: User Story 4 - Resume work and see the state of every idea (Priority: P4)

**Goal**: A complete table of contents, board outcomes and tech review recorded per version.

**Independent Test**: Two ideas at different stages; reopen, check the index matches, resume one, record a board outcome.

### Tests for User Story 4 ⚠️ (write first, must fail)

- [ ] T075 [P] [US4] Eval suite 7 (table of contents) in `evals/index/`: after each entry skill action `test_index.py` passes on the resulting workspace
- [ ] T076 [P] [US4] Eval cases in `evals/outcomes/`: reported board approval, rejection and change request recorded as `board-outcome` with `export_version`; status follows the data-model state machine; tech review flips `estimate_status` and removes the label from the next export

### Implementation for User Story 4

- [ ] T077 [US4] Extend `skills/continue/SKILL.md` and `core/router.md`: record board outcomes against the presented version, record tech review, apply state-machine transitions (`needs-changes` returns to `clarifying`; reopening `approved` or `rejected` returns to `clarifying` keeping history)
- [ ] T078 [US4] Complete `skills/status/SKILL.md` and the index renderer in `templates/workspace/index.html`: statuses, estimate flag, coverage bar, next step with the command to copy, output links, examples section
- [ ] T079 [US4] Describe what US4 changes in the same change: board outcomes, tech review and statuses in `docs/commands.md`, `docs/reading-outputs.md` and `skills/help/situation-map.md`
- [ ] T080 [US4] Run suite 7 and the outcome cases; fix; update `evals/RESULTS.md`
- [ ] T081 [US4] Open the US4 pull request and pass code review before merge

**Checkpoint**: multi-session use works.

---

## Phase 7: User Story 5 - Get help, read the docs, see an example (Priority: P5)

**Goal**: Help that routes and never invents, complete Vietnamese docs with diagrams, a fictional example, the full README pair.

**Independent Test**: Situation questions route correctly; unknown features are answered with "not covered"; the example opens on request.

### Tests for User Story 5 ⚠️ (write first, must fail)

- [ ] T082 [P] [US5] Eval suite 9 (help) in `evals/help/`: situation routing, invented-feature probes, help-versus-new boundary; thresholds at least 90% routing, zero inventions

### Implementation for User Story 5

- [ ] T083 [US5] Write `skills/help/SKILL.md` and finalize `skills/help/situation-map.md`: route and stop, answer only from docs citing the section, say when not covered, read the target skill's current `SKILL.md` before describing it, offer the example
- [ ] T084 [P] [US5] Complete `docs/quick-start.md`, `docs/commands.md` (stating that each of the six commands is a skill of the same name), `docs/workflow.md` in Vietnamese for non-technical readers
- [ ] T085 [P] [US5] Complete `docs/reading-outputs.md`, `docs/faq.md`, `docs/glossary.md` in Vietnamese
- [ ] T086 [US5] Write the ten diagram briefs in `docs/diagrams/01-…10-*.brief.md` (spec Appendix H table) and render `.svg` and `.png` with diagram-design in Claude Code
- [ ] T087 [US5] Build the fictional example `examples/000-<slug>/` (a fictional fashion chain's win-back reminder idea) by running the plugin end to end, with complete exports; it must pass `package_check.py` and `test_snapshot.py`
- [ ] T088 [P] [US5] Complete `README.md` and `README.vi.md`: add `help` to "What ships", examples, screenshots or diagrams, and the full install steps
- [ ] T089 [US5] Run suite 9 and `test_docs_map.py`; fix; update `evals/RESULTS.md`
- [ ] T090 [US5] Open the US5 pull request and pass code review before merge

**Checkpoint**: a new user can learn vibebiz from help, docs and the example.

---

## Phase 8: User Story 6 - Set the organization's ground rules (Priority: P6)

**Goal**: Ground rules in one round, optional strategy map and OKRs, conflicts flagged.

**Independent Test**: A low approval ceiling makes the plan and board view flag an over-budget idea.

### Tests for User Story 6 ⚠️ (write first, must fail)

- [ ] T091 [P] [US6] Eval cases in `evals/ground-rules/`: one round of at most four questions; skip leaves `status: deferred` and the plan reminds; an over-ceiling estimate produces a `ground-rule-conflict` decision shown in the plan and on the board view

### Implementation for User Story 6

- [ ] T092 [US6] Write `skills/constitution/SKILL.md`: one round (priorities, approval ceiling, vertical, mandatory approvals), optional strategy map (BSC perspectives with objectives) and OKRs, write `constitution.md`, rebuild the index
- [ ] T093 [US6] Extend `core/plan.md` and `core/lenses/challenge.md` to check recorded rules, strategy map and OKRs, and record conflicts
- [ ] T094 [US6] Describe what US6 ships in the same change: `constitution` in `docs/commands.md`, `skills/help/situation-map.md` and the README "What ships" sections
- [ ] T095 [US6] Run the ground-rules cases; fix; update `evals/RESULTS.md`
- [ ] T096 [US6] Open the US6 pull request and pass code review before merge

**Checkpoint**: all six stories work.

---

## Phase 9: Polish & Cross-Cutting Concerns

- [ ] T097 Build the simulated-persona harness in `evals/persona/` on the Claude Agent SDK for Python with a pinned lockfile, answering `AskUserQuestion` through `canUseTool` from the hidden-truth fixtures (T022); run suite 8 (three fashion and two other retail ideas) and record facts preserved and sessions to readiness in `evals/RESULTS.md`
- [ ] T098 Run the full structural checks and every eval suite once against a fresh build; confirm every Appendix I threshold; record in `evals/RESULTS.md`
- [ ] T099 Edit every Vietnamese user-facing text (`docs/`, `README.vi.md`, user-facing strings in `templates/` and `core/`) for natural wording
- [ ] T100 Run the Cowork smoke test in quickstart.md §6 by uploading `dist/vibebiz.plugin`; record the five open checks in `CLAUDE.md` "Platform findings" and fix any failure
- [ ] T101 Release review per `CLAUDE.md` "Release review": README pair, docs and diagrams, help map, example against what ships, a scan of fixtures, cards, packs and the example for real people, companies or figures (FR-034); update `CHANGELOG.md` for 0.1.0
- [ ] T102 Prepare the questions for the lawyer's review of `LICENSE`, `COMMERCIAL-LICENSE.md` and `CLA.md` in `specs/001-idea-to-prd/legal-review.md`; the repository stays private

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: none.
- **Foundational (Phase 2)**: after Setup; blocks every story.
- **US1 (Phase 3)**: after Foundational; the MVP.
- **US2 (Phase 4)**: after US1 (lenses run inside the router loop).
- **US3 (Phase 5)**: after US1 and US2 (needs challenged content to package).
- **US4 (Phase 6)**: after US1 and US3 (outcomes refer to export versions).
- **US5 (Phase 7)**: after US1–US4 (complete docs and the example describe them).
- **US6 (Phase 8)**: after US1 and US3; can run in parallel with US4 and US5.
- **Polish (Phase 9)**: after all stories.

### Within Each User Story

- Tests first, failing for the right reason; then modules; then the entry skill; then the docs task; then the story's eval run; then the pull request and review.
- A story's eval run (T037, T059, T073, T080, T089, T095) and review (T038, T060, T074, T081, T090, T096) close the story.

### Parallel Opportunities

- Setup: T004–T010 together after T001–T003.
- Foundational: T011–T015 and T017–T019, T022 together; T016, T020, T021 in sequence where they share decisions.
- US1: the four test tasks together; T028 alongside T027.
- US2: the fifteen cards (T050–T055) and both packs (T056, T057) in parallel; lenses T044–T047 in parallel.
- US3: T064–T067 and T069 in parallel before T068 and T070.
- US6 alongside US4 and US5.
- Heavy runs (persona suite, full eval passes) one at a time per the machine rule.

---

## Parallel Example: User Story 2

```bash
Task: "Write cards five-whys.md, fishbone.md, jobs-to-be-done.md in packs/frameworks/"
Task: "Write cards swot.md, pre-mortem.md, assumption-map.md, test-and-control-pilot.md in packs/frameworks/"
Task: "Write packs/retail-fashion/"
Task: "Write core/lenses/outcome.md"
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Phases 1 and 2.
2. Phase 3 (US1).
3. Stop and validate: suites 1, 2, 4 and the workspace cases pass; try it in Claude Code with a local build.

### Incremental Delivery

1. US1: clarify an idea. 2. US2: challenge and outcome. 3. US3: package; first end-to-end release candidate. 4. US4: multi-session. 5. US5: help, docs, example. 6. US6: ground rules. 7. Polish and the Cowork smoke test before 0.1.0.

---

## Notes

- Each story lives on its own branch and merges through a reviewed pull request; commit after each task or logical group, verb-led and atomic.
- Every module and skill stays in English; every user-facing string follows the idea's language.
- No real people, companies or figures in fixtures, cards, packs or the example.
