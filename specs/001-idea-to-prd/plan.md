# Implementation Plan: Idea to PRD

**Branch**: `001-idea-to-prd` | **Date**: 2026-11-12 | **Spec**: [spec.md](spec.md)

**Input**: Feature specification from `/specs/001-idea-to-prd/spec.md`

## Summary

Build the vibebiz MVP as a Claude Cowork plugin of six entry skills (`idea`, `continue`, `status`, `package`, `constitution`, `help`) backed by shared instruction modules: a router over a coverage map A–O, an interview protocol on the native question tool, four thinking lenses with fifteen framework cards for fashion retail, planning, readiness checks and packaging. Every idea lives as Markdown with frontmatter in the user's workspace; outputs render from one `data.json` into fixed HTML templates (published as private Artifacts) and into Google Slides and Docs through Cowork's connectors, with a Spec Kit 1.4.0-compatible snapshot for the tech team. Development tooling (structural checks, build, evals, persona harness) is Python and never ships.

## Technical Context

**Language/Version**: Plugin: Markdown instructions (`SKILL.md`, modules, cards, docs) with YAML frontmatter, HTML/CSS with a small inline renderer for templates, JSON manifest. Development tooling: Python 3 standard library (Python 3.10+ to match the Cowork VM's 3.10.12).

**Primary Dependencies**: Runtime: none bundled. Companion: `diagram-design` (MIT, optional). Platform: Cowork's `AskUserQuestion`, Artifacts, Google Docs and Slides connectors. Development: Spec Kit 1.4.0, `claude plugin eval`, Claude Agent SDK for Python (pinned with a lockfile in `evals/persona/`), optional TypeSafe Jev graders.

**Storage**: Files in the user's workspace (`contracts/workspace-files.md`); Google files in the user's Drive; no other storage.

**Testing**: `python3 -m unittest` structural checks in `scripts/checks/`; `claude plugin eval` suites with answers embedded in prompts; Agent SDK persona harness; manual Cowork smoke test (`quickstart.md`). Behavior changes start from a failing eval case (constitution V).

**Target Platform**: Claude Cowork desktop; skills detect claude.ai chat without a folder and stop.

**Project Type**: Claude plugin (skills-only, Cowork).

**Performance Goals**: A question round or a status answer in a single assistant turn; packaging one idea in one session; table-of-contents rebuild after every write.

**Constraints**: No runtime scripts, hooks or network (constitution IV); `SKILL.md` bodies under 3,000 words with detail in references; at most four questions per round; no public URLs or sharing; no verbatim third-party text; English structure, user-language content.

**Scale/Scope**: One organization per workspace, tens of ideas; six entry skills, about sixteen modules, fifteen framework cards, two packs, six docs with ten diagrams, one fictional example, ten eval suites.

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

| Principle | Check | Result |
|---|---|---|
| I. Non-Technical User First | Plain-language questions through `AskUserQuestion` (R6); write-back after each round; question budget; language follows the user (R10) | Pass |
| II. Spec Kit Compatibility by Contract | Snapshot headings fixed (`contracts/exports.md`); heading check plus `speckit-plan` integration test (R5); content ported from 1.4.0 with `UPSTREAM.md`; mechanics not ported | Pass |
| III. Evidence Over Agreement | `data.json` figures carry source, period, label; package check in code (R4); anti-sycophancy module; dismissed risks recorded | Pass |
| IV. Self-Contained Runtime | Six skills plus copied modules (R1, R2); inline renderer runs in the page, not on the user's machine; diagram-design optional; `idea` never overwrites | Pass |
| V. Eval-Proven Behavior | Ten suites with thresholds; structural checks in code; Jev development-only (R11); smoke test before release | Pass |
| VI. Clean Source-Available Repository | Fictional examples and fixtures; own-words cards; license and CLA files in scope (FR-033); dev tooling outside the plugin | Pass |
| VII. Docs Ship With Behavior | Docs and help map checked against shipped skills in code; diagram briefs carry versions; example rebuilt with templates | Pass |

Post-design re-check (after Phase 1): unchanged, all pass. Two design choices need recording, below.

## Project Structure

### Documentation (this feature)

```text
specs/001-idea-to-prd/
├── spec.md              # Feature spec with appendices A–I
├── plan.md              # This file
├── research.md          # Phase 0: R1–R13
├── data-model.md        # Phase 1: entities, frontmatter, state machine
├── quickstart.md        # Phase 1: validation runs and smoke test
├── contracts/           # Phase 1: entry skills, workspace files, exports, modules
├── checklists/          # requirements.md (spec quality)
├── tasks.md             # Phase 2 (/speckit-tasks)
```

### Source Code (repository root)

```text
.claude-plugin/
└── plugin.json                  # name vibebiz, version 0.1.0, license, repository
skills/
├── idea/SKILL.md
├── continue/SKILL.md
├── status/SKILL.md
├── package/SKILL.md
├── constitution/SKILL.md
└── help/SKILL.md                # + situation map
core/                            # modules (contracts/modules.md); copied into skills at build
├── router.md  ask-protocol.md  clarify.md  specify.md
├── plan.md  checklist.md  analyze.md  package.md  workspace.md
├── export-guidelines.md  writing-rules.md  anti-sycophancy.md
└── lenses/
    ├── problem-framing.md  outcome.md  challenge.md  solution-sketch.md
templates/
├── workspace/                   # index.html, constitution.md
├── idea/                        # spec.md, coverage.md, plan.md, records, checklists
└── exports/                     # board-deck.html, tech-prd.html, links.md
packs/
├── frameworks/                  # fifteen core cards (spec Appendix F)
├── retail-fashion/
└── ai-patterns-retail/
docs/                            # Vietnamese user docs, English names
└── diagrams/                    # NN-<name>.brief.md + .svg + .png
examples/
└── 000-<slug>/                  # fictional fashion idea, full exports
evals/                           # claude plugin eval suites, RESULTS.md; persona/ harness (dev only)
scripts/
├── build_plugin.py              # dist/vibebiz/ and dist/vibebiz.plugin (dev only)
└── checks/                      # structural checks + test_*.py (dev only)
README.md  README.vi.md  CHANGELOG.md  LICENSE  COMMERCIAL-LICENSE.md  CLA.md
PRIVACY.md  SECURITY.md  TERMS.md  CODE_OF_CONDUCT.md  CONTRIBUTING.md
THIRD_PARTY_LICENSES.md  UPSTREAM.md
```

**Structure Decision**: A skills-only Cowork plugin. Six entry skills are the only components Cowork sees; shared behavior lives once in `core/` and is copied, with `templates/` and `packs/`, into each skill's `references/` by the build, so the shipped plugin resolves every reference inside its own skill folder. Content (templates, packs, docs, example) sits at the root for review; development tooling (`scripts/`, `evals/`, `.specify/`) is excluded from `dist/`.

### Delivery order by story

| Story | Delivers | Depends on |
|---|---|---|
| P1 | workspace module and templates, specify, router, ask protocol, clarify, coverage, `idea`, `continue` (resume path), `status` minimal, writing rules | — |
| P2 | four lenses, anti-sycophancy, fifteen framework cards, fashion pack, AI patterns, Cynefin rule | P1 |
| P3 | plan, checklist, analyze, package, export guidelines, export templates, `data.json`, diagram briefs, history, Slides and Docs writing | P1, P2 |
| P4 | full table of contents, board outcomes and tech review in `continue`, status complete | P1, P3 |
| P5 | `help` and situation map, docs with ten diagrams, fictional example, README pair | P1–P4 |
| P6 | `constitution` skill, strategy map and OKRs, conflict checks in plan | P1, P3 |

Each story ships its docs entries in the same change (constitution VII) and merges through a reviewed pull request. Repository documents (license, CLA, privacy and the rest, FR-033) land with P1 so the repository is clean from the first release candidate. Each story starts from its failing eval cases.

## Complexity Tracking

| Decision | Why Needed | Simpler Alternative Rejected Because |
|---|---|---|
| Build step copies `core/` into every skill | Skills must resolve shared modules inside their own folder in Cowork | Cross-folder relative paths are undocumented in Cowork; hand duplication drifts |
| Fixed HTML templates with an inline renderer and `exports/data.json` | Makes completeness, cross-view numbers and index integrity checkable in code; keeps layout stable | Model-written HTML drifts and cannot be checked; it is also a one-file addition to the workspace contract, recorded in `CLAUDE.md` |
