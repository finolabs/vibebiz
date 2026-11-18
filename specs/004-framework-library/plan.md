# Implementation Plan: A wider framework library that vibebiz chooses from on its own

**Branch**: `004-framework-library` | **Date**: 2026-11-18 | **Spec**: [spec.md](spec.md)

**Input**: Feature specification from `specs/004-framework-library/spec.md`

## Summary

The work adds SIPOC and the catalog cards from spec 001 Appendix F, which takes the library from 15 to 41 cards. It also replaces the two-cards-per-lens limit with a gap-driven rule, and makes "the user never chooses a framework" a rule that evals check. Today's router design already chooses cards by coverage gap and asks their questions in plain words (research R2). So the change is:
- one rule in the router and three modules;
- an optional `framework_reasons` field in `coverage.md`;
- new card files;
- their eval cases;
- the docs that describe the library.

## Settled Decisions

- **Three scenarios is built in, not a card** (Fio, 18/11/2026, research R6). It stays the plan module's way of writing category M, like pyramid / SCQA in the export guidelines, so there are 26 new cards. `core/plan.md` names it "three scenarios" where it writes M, so the outputs can name it.

## Technical Context

**Language/Version**:
- Markdown instructions: `core/` modules and `packs/frameworks/` cards.
- Python 3.10+ standard library for the checks (unchanged).

**Primary Dependencies**: none at runtime (constitution Principle IV).

**Storage**: the idea's `coverage.md` in the user's workspace. One optional field is added (research R4), so existing workspaces stay valid.

**Testing**:
- `scripts/checks/test_cards.py` gets new counts and a lens check.
- `scripts/checks/test_build.py`.
- `scripts/checks/test_docs_map.py`.
- `claude plugin eval` cases under `evals/frameworks/`, plus a code grader for framework names in questions.

**Target Platform**: unchanged. Cowork, Claude Code, Codex and Antigravity.

**Project Type**: skills-only agent plugin.

**Performance Goals**: the interview's round budget does not grow (spec SC-005).

**Constraints**:
- The workspace contract stays compatible (0.1.x).
- Cards are written in vibebiz's own words and credit their origin.
- No real data appears in examples.
- `SKILL.md` bodies are unchanged.

**Scale/Scope**:
- 26 new cards.
- About 52 new eval cases.
- Edits to 5 modules, 1 template, the data model, the docs and the evals README.

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

| Principle | Check | Result |
|---|---|---|
| I. Non-technical user first | Users never choose or learn a framework; cards' questions are plain Vietnamese, edited with `vietnamizer` (R10) | Pass |
| II. Spec Kit compatibility | Snapshot sections untouched; no Spec Kit mechanics ported | Pass |
| III. Evidence over agreement | Money cards follow ask-protocol rules 5 and 10; challenge cards keep "do nothing" and "fix the process" | Pass |
| IV. Self-contained runtime | Cards are Markdown; no script at runtime | Pass |
| V. Eval-proven behavior | Red cases first: `gap-driven-no-stacking` and each `fit-`/`skip-` case fail before their change; structure checked in code | Pass, release still needs the suites and a Cowork smoke test |
| VI. Clean source-available repository | Own words, credited origins (Strategyzer canvases CC BY-SA described, not copied); fictional examples | Pass |
| VII. Docs ship with behavior | `docs/workflow.md` ("15 phương pháp"), glossary, help map and README pair updated in the same change | Pass |

No violations, so Complexity Tracking stays empty. Re-checked after Phase 1: the design adds no runtime script and no breaking workspace change, so the result is the same.

## Project Structure

### Documentation (this feature)

```text
specs/004-framework-library/
├── spec.md
├── plan.md
├── research.md
├── data-model.md
├── quickstart.md
├── contracts/framework-selection.md
├── checklists/requirements.md
└── tasks.md              # next: /speckit-tasks
```

### Source Code (repository root)

```text
core/
├── router.md                      # "Frameworks" rule 2 and the by-name branch (R1, R3); framework_reasons (R4)
├── plan.md                        # §6 planning-card limit (R1); name "three scenarios" for M (R6)
├── export-guidelines.md           # name "pyramid principle / SCQA" (R6)
└── lenses/{challenge,solution-sketch}.md   # drop "at most two" lines (R1)
packs/frameworks/                  # 26 new cards, core: false (data-model)
templates/idea/coverage.md         # comment line, framework_reasons
scripts/checks/test_cards.py       # TOTAL_COUNT, lens check (R5)
evals/frameworks/                  # gap-driven-no-stacking (replaces cap-two-per-lens), fit-/skip- cases, name grader (R9)
evals/README.md                    # suite 10 rows
docs/workflow.md, docs/glossary.md, src/skills/help/situation-map.md, README.md, README.vi.md   # library as shipped (FR-010)
specs/001-idea-to-prd/{spec.md,data-model.md}   # one-line pointers to spec 004 (R1)
CLAUDE.md                          # line 30 (with Fio's yes on this spec)
.plugin-skills/                    # regenerated
```

**Structure Decision**: there is no new folder or module. Cards stay one file each and the build copies them as today.

## Delivery

The depth gate does not allow direct implementation:
- the work is more than one implementation pass;
- the cards split into parallel batches;
- the foundation must land before them.

So `/speckit-tasks` comes next. It orders the work in four phases:

1. **Foundation** (this session, one seam):
   - the red case `gap-driven-no-stacking` and the no-framework-name grader;
   - the router, plan, lens, template and data-model edits;
   - the `test_cards.py` counts and lens check;
   - the build.
2. **Cards**, in three parallel delegated runs by batch (data-model "batch"). Each run covers its cards with `fit-`/`skip-` cases written red first. The reviews come from another family.
   - batch 1: SIPOC, problem-framing and outcome, 7 cards;
   - batch 2: challenge and solution-sketch, 8 cards;
   - batch 3: plan, 11 cards.
3. **Language**: one `vietnamizer` pass over every new card's questions and example.
4. **Docs and release review**: FR-010; the CLAUDE.md line; the spec 001 pointers; the whole framework suite once; the simulated sessions; the Cowork smoke test.

## Complexity Tracking

None.
