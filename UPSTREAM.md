# Upstream: Spec Kit

vibebiz is pinned to **Spec Kit 1.4.0** (<https://github.com/github/spec-kit>, MIT; see `THIRD_PARTY_LICENSES.md`). Upgrade only with Fio's decision.

## Two roles

- **Development tool.** This repository is developed with Spec Kit 1.4.0 (`.specify/`, `.claude/skills/speckit-*`). Those files are development tooling and never ship in the plugin.
- **Upstream for the port.** The plugin ports Spec Kit *content* to Cowork. It does **not** port the mechanics: bash scripts, git branches, hooks, `feature.json`, extensions.

vibebiz says "compatible with Spec Kit" and never uses Spec Kit as branding.

## Ported from upstream 1.4.0

| vibebiz location | Upstream source | How it is used |
|---|---|---|
| `templates/idea/spec.md`: User Scenarios & Testing, Requirements, Success Criteria, Assumptions, Key Entities, Edge Cases | spec template headings and structure | Kept unchanged in every language so `speckit-plan` runs on the exported snapshot |
| `templates/idea/spec.md`: header lines (Feature Branch, Created, Status, Input) and the Clarifications session format | spec template and `clarify` | Same shape; the branch line is informational only |
| `templates/idea/plan.md` | plan template | Section structure ported; filled by the plan module with business content |
| `templates/idea/checklists/*` | checklist template | Definition-of-Ready checklists for board and tech |
| `templates/workspace/constitution.md` | constitution template | Organization ground rules in the same placeholder style |
| `core/clarify.md`: coverage taxonomy | `clarify` coverage categories: scope, data, UX flow, non-functional, integration, edge cases, constraints, terminology, completion signals | Extended into categories A–O (spec Appendix A) |
| `core/clarify.md`: Deferred rule | `clarify` 1.4.0 Deferred rule (the only `clarify` change since 1.0.5) | A category may be Deferred only with a stated reason |
| `core/writing-rules.md`: specification writing rules | specification writing guidance (what, not how; testable, unambiguous requirements; limit of clarification markers) | Adapted to plain language and Vietnamese style |
| `core/checklist.md` | `checklist` pass | Requirement-quality checks, adapted for the board and tech views |
| `core/analyze.md` | `analyze` pass | Cross-file consistency checks, read-only, findings returned to the router |

## vibebiz-only (not from upstream)

| vibebiz location | What it is |
|---|---|
| Business sections of `spec.md`: Problem & Why, Outcome, Alternatives, AI-fit, Cost & Risk | Placed before the Spec Kit sections, never in their place |
| `core/router.md`, `core/ask-protocol.md`, `core/anti-sycophancy.md` | Interview router, question protocol, evidence-over-agreement rules |
| `core/lenses/*` (problem-framing, outcome, challenge, solution-sketch) | Thinking lenses |
| Coverage categories A, B, C, D, F, K, L, M, O wording and dependency tree | Business extension of the taxonomy |
| `core/package.md`, `core/export-guidelines.md`, `exports/data.json` and its templates | Board deck and tech PRD exports |
| `core/workspace.md`, the workspace layout and index | User workspace contract |
| `packs/retail-fashion`, `packs/ai-patterns-retail`, `packs/frameworks/*` | Content packs and the fifteen framework cards |
| Six entry skills, `help`, `docs/` | Product surface |

Keep this table in step with the code: a section moves between tables only when its source changes.
