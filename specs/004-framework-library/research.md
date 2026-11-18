# Research: wider framework library (spec 004)

Each item gives the decision, why it was chosen, and the alternatives considered. Sources are this repository at main efb0e99.

## R1. Where the two-card limit lives

**Decision**: the gap-driven rule replaces the two-card limit in eight places. The router and modules:
- `core/router.md` "Frameworks" rule 2 and the by-name "does not fit" branch;
- `core/lenses/challenge.md:169` and `core/lenses/solution-sketch.md:170`;
- `core/plan.md` §6 ("fewer than two planning cards").

The record and the docs:
- `specs/001-idea-to-prd/data-model.md` ("at most two per lens");
- the comment in `templates/idea/coverage.md`;
- `CLAUDE.md` line 30.

Spec 001 FR-037, SC-011, Appendix F and the Appendix I row 10 get a one-line pointer to spec 004 rather than a rewrite, so the history stays readable.

**Rationale**: this is every hit for "at most two" and "two cards" outside the slide-layout rule (`core/export-guidelines.md:53`, which is about slide blocks and stays as it is).

**Alternatives**: rewriting spec 001 in place. Rejected because spec 001 is a closed record, and a pointer keeps the reason for the change in one place.

## R2. Rules that already hold and stay

**Decision**: keep router rules 1 (only for an open gap), 3 (one new card per category per round), 4 (plain words, never name the framework in questions), 5 (record), 6 (plan cards at packaging, Cynefin for depth only) and 7 (no card, no framework). The by-name path (FR-038) also stays. Spec 004 FR-001 and FR-002 are rule 4 made testable: this spec adds a grader, not a new rule.

**Rationale**: Fio's principle on 18/11 is already the design. What was missing is eval coverage for "no framework name in a question or option".

## R3. "No applied card has filled it" in practice

**Decision**: the router may hand a new card to a lens only when all of these hold:
- the category is on the frontier with `missing` or `partial` status;
- the card's `fills` includes the category;
- the card is not already in that category's `frameworks`;
- no other card was handed for that category this round.

There is no count per lens. The interview's round budget (`budget_rounds_used`) is what bounds the total. A category that becomes `clear` takes no more cards.

**Rationale**: this matches Fio's answer (Q2) and needs no new counter. The round budget already stops a long interview.

**Alternatives**:
- a per-idea total cap: rejected, because it is a second budget beside the rounds;
- a cap of three per lens: rejected by Fio.

## R4. Recording why a card was chosen (FR-007)

**Decision**: add an optional per-category field `framework_reasons` to `coverage.md`. It maps a card id to one line in English, for example `sipoc: process change with hand-offs between warehouse and stores`. The field is additive: workspaces without it stay valid, and `frameworks` keeps its shape (a list of ids). The body table does not show the reasons.

**Rationale**: it keeps the public workspace contract compatible, so the release stays 0.1.x. The reasons are a working note for `continue` and for evals, not user text. They are in English like the other frontmatter values.

**Alternatives**:
- changing `frameworks` to `{id, reason}` objects: rejected, because it breaks existing workspaces and the package step that reads ids;
- writing the reasons to `decisions.md`: rejected, because that file holds the user's decisions, not vibebiz's.

## R5. The `core` flag and the card checker

**Decision**: the 27 new cards carry `core: false`. `scripts/checks/test_cards.py` keeps `CORE_COUNT = 15` (the first-release set) and adds `TOTAL_COUNT = 42`, so a missing or extra card fails. The checker also rejects a `lens` outside the six used today (`problem-framing`, `outcome`, `challenge`, `solution-sketch`, `plan`, `router`).

**Rationale**: `core` already means "first-release fashion set" in spec 001 Appendix F. The build copies every card in `packs/frameworks/`, so no build change is needed. This needs confirming in the build test.

## R6. Three items in the catalog are already built in

**Decision**:
- **Pyramid principle / SCQA**: already a rule in `core/export-guidelines.md:24`, which says to lead with the answer and use situation, complication, question and answer inside a slide. FR-011 is met. The release only adds the name "pyramid principle / SCQA" to that line, so the help docs can describe it truthfully.
- **Three scenarios**: already how category M is written: "S/M/L size, three scenarios" in spec 001 Appendix A, plus the plan module's cost table and the build-buy-partner card's low, base and high. A separate card would fill M with a duplicate of what the plan module writes anyway.
- **OKR**: spec 001 says organization OKRs live in the ground rules, not in a card. The new OKR card is for drafting the idea's own objective and key results when the ground rules hold none (spec 004 Edge Cases).

**Open for Fio**: ship "three scenarios" as a card or fold it into the plan module like SCQA. The recommendation is to fold it, which makes 26 new cards instead of 27, because a card that never changes what is asked or written is a no-op that still costs two eval cases. Recorded in `plan.md` "Open Decisions".

## R7. Lens and categories for each new card

**Decision**: the mapping in `data-model.md`. Rules used:
- the lens follows spec 001 Appendix F;
- `fills` names only categories that the card's lens or the plan module fills, because router rule 1 hands a card only to the module that fills the category;
- a card may still write results into other sections through its "Writes to" list, as the journey-map card already does for Cost & Risk.

**SIPOC**: lens `solution-sketch`, fills `[E, J]`. Its suppliers and inputs go to Key Entities and Assumptions through "Writes to", and they do not fill G or H, which the clarify module owns.

**Rationale**: no router or module change is needed beyond R1 (spec FR-009).

## R8. Overlapping cards

**Decision**: these groups of cards overlap:
- RICE / ICE and the value-effort matrix, both for E;
- TCO, NPV and build-buy-partner-roi, all for M;
- Kotter, ADKAR and McKinsey 7S, all for L;
- issue tree, 5 Whys and fishbone, all for A.

Each card's "When not to use" names its neighbours and says when the neighbour fits better. Router rule 3 already stops two cards on one category in one round. R3's "not already applied, category still open" stops stacking after that, because the first card usually makes the category `clear` or `partial`.

**Rationale**: choosing by context is the router's job (spec 004 FR-007). The cards supply the context it needs.

## R9. Evals

**Decision**:
- **Replace one case:** `evals/frameworks/cap-two-per-lens` becomes `gap-driven-no-stacking`, where a category already filled by a card gets no second card while another open category does.
- **Add two cases per new card under `evals/frameworks/`:** `fit-<id>` where the card fits and `skip-<id>` where a neighbour fits better or no card fits. They share fixtures by lens.
- **Add one grader to every framework case:** no question, option or preview names a framework or asks the user to pick one (SC-001). This grader runs in code over the run log, not as a model judgment.
- **Cost:** about 54 new cases at roughly $0.15 to $0.30 a run on `sonnet` with `--runs 1`, so $10 to $16 for the whole suite. Per the plugin-packaging rule, run per changed card during work and the whole suite once before the release.

**Rationale**: constitution Principle V requires a red case first and code checks for structure.

## R10. Vietnamese text in the cards

**Decision**: each card's "Questions" and "Fashion example" are Vietnamese text a user reads. After the cards are drafted, they get one `vietnamizer` pass, as `CLAUDE.md` asks for user text before release.

## R11. Delegation shape

**Decision**: the foundation (R1, R3, R4, R5, the grader and the replaced case) is done first in this session. It is one seam and every other task depends on it. The 26 or 27 cards then go to three parallel delegated runs, one per batch in `plan.md`. Each run gets a complete brief: the card template from an existing card, the mapping row, the two eval cases and `test_cards.py`. Reviews go to another family. Docs and the release review come last.

**Rationale**: the cards are independent files with clear acceptance tests, so `delegate` "Keep or hand off" fits.
