# Data Model: Idea to PRD

All data lives in the user's workspace as Markdown with YAML frontmatter, plus `exports/data.json` and the JSON block inside `index.html` (research R3, R4). Ids are stable and never reused. Dates are ISO `YYYY-MM-DD`.

## Workspace

Path: the folder open in Cowork (or its `vibebiz/` subfolder).

| Field | Source | Rule |
|---|---|---|
| layout | fixed tree in `contracts/workspace-files.md` | `idea` restores missing pieces, never overwrites |
| ideas | `specs/NNN-<slug>/` | `NNN` is the next free three-digit number |
| examples | `examples/000-<slug>/` | optional, excluded from status and numbering |

## Ground rules (`constitution.md` frontmatter)

| Field | Type | Rule |
|---|---|---|
| status | `set` \| `deferred` | `deferred` until recorded; plan reminds when deferred |
| priorities | list of text | this year's priorities |
| approval_ceiling | `{amount, currency}` | budget the user approves alone |
| vertical | `fashion` \| other text | selects the fashion pack when `fashion` |
| mandatory_approvals | list of text | steps that always need a person |
| strategy_map | optional, BSC perspectives with objectives | used by challenge and plan |
| okrs | optional list `{objective, key_results[]}` | outcome lens maps ideas to them |
| updated | date | |

## Idea (`coverage.md` frontmatter)

| Field | Type | Rule |
|---|---|---|
| id | `NNN` | matches the folder number |
| slug, title | text | slug from title without diacritics |
| language | `vi` \| `en` \| other code | set at intake (R10) |
| vertical | text | defaults to the ground rules' vertical |
| cynefin | `clear` \| `complicated` \| `complex` \| `chaotic` | set by the router, revisable (R9) |
| status | see state machine | derived, never hand-set by vibebiz outside transitions |
| estimate_status | `not-tech-reviewed` \| `tech-reviewed` | flips only on a recorded tech review |
| budget_rounds_used | integer | per session counter, reset at session start |
| latest_export | date or null | folder name under `exports/` history |
| next_step | text | short next action in the user's language, written by the router after every round; the table of contents copies it |
| created, updated | date | |
| categories | map A–O → category | see below |

**Category**: `status` (`clear` \| `partial` \| `missing` \| `deferred`), `reason` (required when deferred), `prerequisites` (fixed, spec Appendix A), `filled_by` (module), `frameworks` (applied card ids, at most two per lens), `updated`.

**Validation**: a category is asked only when every prerequisite is `clear` or `deferred`; readiness is A, C, D, E `clear`, F `clear` when the idea involves AI, M at least sized, every other category `clear` or `deferred`.

### Idea status state machine

```
clarifying ──(readiness met)──▶ ready ──(package)──▶ packaged ──(user reports presented)──▶ presented
     ▲                            │                                                           │
     └──(answers reopen a gap)────┘                     ┌─────────────────────────────────────┤
                                                        ▼                ▼                    ▼
                                                    approved          rejected          needs-changes ──▶ clarifying
```

A labelled draft export does not change status. `approved` and `rejected` are terminal until the user reopens the idea, which returns it to `clarifying` and keeps the history.

## Round (in `spec.md` Clarifications)

`### Session YYYY-MM-DD` then one bullet per answered question: `- Q: <question> → A: <answer>`. Skipped questions are not written as answers; they are listed under the session as `- Skipped: <question>`.

## Decision (`decisions.md`)

Append-only entries `## D-### — <short title>` with fields: `date`, `type` (`answer` \| `dismissed-risk` \| `board-outcome` \| `tech-review` \| `ground-rule-conflict` \| `supersede`), `text`, `reason`, `supersedes` (decision id, optional), `export_version` (for board outcomes), `outcome` (`approved` \| `rejected` \| `needs-changes`, board outcomes only), `notes`.

## Assumption (`assumptions.md`)

`## A-###` with `text`, `tested` (`yes` \| `no`), `evidence`, `riskiest` (boolean, from the assumption map), `source` (`stated` \| `no-answer-run`). Entries are never deleted or reworded; only `tested` and `evidence` are filled in when a test result arrives.

## Open question (`open-questions.md`)

`## Q-###` with `text`, `owner`, `unblocks`, `blocking` (boolean), `category` (A–O), `status` (`open` \| `resolved` with decision id).

## Export version

| Field | Rule |
|---|---|
| folder | `exports/` holds the latest; previous sets move to `exports/history/YYYY-MM-DD/` (same-day repeat: `YYYY-MM-DD-2`) |
| files | `board-deck.html`, `tech-prd.html`, `spec.md`, `data.json`, `links.md` |
| links | Artifact, Slides, Docs URLs; Artifacts updated in place |
| draft | boolean; true when packaged below readiness, every gap labelled |

## Diagram brief (`diagrams/NN-<name>.brief.md`)

`message`, `type` (spec Appendix E), `source_fields` (spec sections or data paths), `placement` (slide number or tech section), `rendered` (file name or `none`), `rendered_with` (the vibebiz and diagram-design versions, for example `vibebiz 0.1.0, diagram-design 1.0.0`, or `none`).

## Framework card (`packs/frameworks/<id>.md`)

Frontmatter: `id`, `name`, `lens`, `fills` (category codes), `core` (boolean), `diagram_type`, `origin` (author and source for credit). Body sections: When to use, When not to use, Inputs, Questions, Writes to, Common misuse, Fashion example (fictional).

## Vertical pack (`packs/retail-fashion/`, `packs/ai-patterns-retail/`)

Fashion: drivers, metrics with definitions, diagnostic traps, promotion patterns, example questions per lens. AI patterns: per pattern `name`, `data_needed`, `rough_cost`, `risks`, `prior_art`, `fit` (rule, automation or AI).

## Table of contents data (`index.html` JSON block)

`workspace` (`updated`, `ground_rules_status`), `ideas[]` (`id`, `title`, `status`, `estimate_status`, `coverage` `{clear, total}`, `next_step`, `outputs[]`, `updated`), `examples[]`. Rebuilt from the frontmatter after every write; integrity means it lists exactly the folders present.
