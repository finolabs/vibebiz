# Data model: wider framework library (spec 004)

Changes to spec 001 `data-model.md` only. Everything not named here is unchanged.

## Category (in `coverage.md`)

| Field | Change |
|---|---|
| `frameworks` | Still a list of applied card ids. The note "at most two per lens" is replaced by "a card is added only while the category is open and the card is not already listed" (spec 004 research R3). |
| `framework_reasons` | **New, optional.** A map from card id to one English line saying why the router chose it. It is written by the router when it hands a card over. It is absent in older workspaces and valid without it. |

## Framework card (`packs/frameworks/<id>.md`)

The frontmatter and body sections are unchanged (spec 001 FR-036). `core: true` stays on exactly the 15 first-release cards. New cards carry `core: false`. The library holds 41 cards. "Three scenarios" stays built into the plan module (Fio, 18/11/2026, research R6).

## New cards

Lens and `fills` follow research R7. "Neighbours" are the cards whose "When not to use" must point to each other (research R8).

| # | id | name | lens | fills | diagram_type | neighbours | batch |
|---|---|---|---|---|---|---|---|
| 1 | `sipoc` | SIPOC (with a Requirements column) | solution-sketch | E, J | none | journey-map-service-blueprint, lean-dmaic | US1 (this session) |
| 2 | `issue-tree` | Issue tree (MECE) | problem-framing | A | tree | five-whys, fishbone | 1 |
| 3 | `value-chain` | Porter value chain | problem-framing | A, B | none | sipoc | 1 |
| 4 | `north-star-metric` | North Star metric | outcome | C | tree | driver-tree | 1 |
| 5 | `okr` | OKR | outcome | C, O | tree | balanced-scorecard, smart | 1 |
| 6 | `smart` | SMART goals | outcome | C, O | none | okr | 1 |
| 7 | `leading-lagging` | Leading and lagging indicators | outcome | C | line | driver-tree, north-star-metric | 1 |
| 8 | `five-forces` | Porter Five Forces | challenge | D, K | radar | pestel, swot | 2 |
| 9 | `pestel` | PESTEL | challenge | K | none | five-forces, swot | 2 |
| 10 | `cost-of-inaction` | Cost of inaction | challenge | D, M | bar | build-buy-partner-roi | 2 |
| 11 | `six-thinking-hats` | Six Thinking Hats | challenge | D, K | none | pre-mortem, swot | 2 |
| 12 | `theory-of-constraints` | Theory of Constraints | challenge | D | flowchart | lean-dmaic, fishbone | 2 |
| 13 | `value-proposition-canvas` | Value Proposition Canvas | solution-sketch | E | none | jobs-to-be-done, kano | 2 |
| 14 | `kano` | Kano model | solution-sketch | E | quadrant | moscow, value-proposition-canvas | 2 |
| 15 | `lean-dmaic` | Lean and DMAIC | solution-sketch | E, J | timeline | sipoc, theory-of-constraints | 2 |
| 16 | `stp` | Segmentation, targeting and positioning (STP) | plan | B, E | none | marketing-mix-4p-7p | 3 |
| 17 | `ansoff` | Ansoff matrix | plan | D | quadrant | bcg-matrix | 3 |
| 18 | `bcg-matrix` | BCG growth-share matrix | plan | D, M | quadrant | ansoff | 3 |
| 19 | `rice-ice` | RICE and ICE scoring | plan | E | none | value-effort, moscow | 3 |
| 20 | `value-effort` | Value-effort matrix | plan | E | quadrant | rice-ice, moscow | 3 |
| 21 | `tco` | Total cost of ownership | plan | M | bar | build-buy-partner-roi, npv | 3 |
| 22 | `npv` | NPV and payback | plan | M | bar | tco, build-buy-partner-roi | 3 |
| 23 | `stage-gate` | Stage-gate rollout | plan | M, L | timeline | test-and-control-pilot | 3 |
| 24 | `raci` | RACI | plan | B, L | none | adkar | 3 |
| 25 | `kotter` | Kotter's eight steps | plan | L | timeline | adkar, mckinsey-7s | 3 |
| 26 | `mckinsey-7s` | McKinsey 7S | plan | L | none | adkar, kotter | 3 |

Diagram types are those in spec 001 Appendix E. `radar` and `flowchart` are listed there ("quadrant or radar", "decision flowchart"). `timeline` covers "timeline or Gantt".

## Validation

- `id` equals the file name without `.md`, and `fills` uses codes A to O (unchanged checks).
- `lens` is one of `problem-framing`, `outcome`, `challenge`, `solution-sketch`, `plan`, `router` (new check).
- Exactly 15 cards have `core: true`, and the total is 41 (new count check).
- Cards that handle money (`cost-of-inaction`, `tco`, `npv`, `bcg-matrix`) follow ask-protocol rules 5 and 10: no invented current figure, and estimates are labelled "not tech-reviewed".
