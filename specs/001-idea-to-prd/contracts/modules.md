# Contract: Modules

Modules are reference files under `core/`, copied into each entry skill's `references/` at build time (research R1, R2). Each module states its inputs, the files it reads and writes, and the categories it fills. Entry skills load only the modules a step needs.

| Module | File | Used by | Reads | Writes | Fills |
|---|---|---|---|---|---|
| router | `core/router.md` | new, continue | coverage, ground rules | coverage (cynefin, `next_step`) | chooses frontier, lens, framework, depth |
| ask protocol | `core/ask-protocol.md` | every module that asks | coverage | spec Clarifications, decisions, open questions | rules only (spec Appendix B) |
| clarify | `core/clarify.md` | router | spec, coverage | spec, coverage, glossary | G, H, N, leftovers |
| specify | `core/specify.md` | new | user's intake answer | spec draft, coverage | initial statuses |
| problem-framing | `core/lenses/problem-framing.md` | router | spec, pack | spec Problem & Why | A, B |
| outcome | `core/lenses/outcome.md` | router | spec, ground rules | spec Outcome, Success Criteria, Acceptance | C, O |
| challenge | `core/lenses/challenge.md` | router | spec, ground rules | spec Alternatives, Cost & Risk, decisions, assumptions | D, K, part of M |
| solution-sketch | `core/lenses/solution-sketch.md` | router | spec, pack | spec stories, FR, AI-fit, edge cases, diagram brief | E, F, I, J, L |
| plan | `core/plan.md` | package | spec, ground rules | plan | M, ground-rule conflicts |
| checklist | `core/checklist.md` | package | spec, plan | checklists/board.md, checklists/tech.md | readiness |
| analyze | `core/analyze.md` | package | all idea files | findings returned to the router | consistency |
| package | `core/package.md` | package | idea files, diagrams | data.json, exports, links, history | outputs |
| workspace | `core/workspace.md` | every entry skill | folder | scaffold, table of contents | layout, index |
| export guidelines | `core/export-guidelines.md` | package | | | Appendix D rules, aesthetics |
| writing rules | `core/writing-rules.md` | every module | | | plain language, vague-term list, Vietnamese style |
| anti-sycophancy | `core/anti-sycophancy.md` | challenge, router | | | Principle III rules |

**Framework cards** follow data-model "Framework card"; the router picks a card only for an open category in its `fills`, at most two per lens per idea.

**Diagram briefs** follow data-model "Diagram brief"; package asks diagram-design to render each brief and records `rendered_with`.

**Templates** under `templates/`: `workspace/` (index.html, constitution.md), `idea/` (spec.md with business sections before the Spec Kit sections, coverage.md, plan.md, decisions.md, assumptions.md, open-questions.md, glossary.md, checklists), `exports/` (board-deck.html, tech-prd.html, links.md).
