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

## Card links (routing map)

**New frontmatter keys on every card** (spec FR-012). Each may be an empty list.

```yaml
needs: [tco, build-buy-partner-roi]        # any one applied, or every category that card fills is clear
feeds:
  - to: npv
    passes: yearly cost of the chosen route   # a named result in the idea's files
instead_of: [value-effort]                    # same gap, choose one; declared on both sides
revisit_when: [M, board-changes, tech-review] # codes A–O, or the two events
```

**Draft map.** Each card task finalizes its own row. The rows of the 15 existing cards are added in tasks Phase 5.

| Card | needs | feeds → (passes) | instead_of | revisit_when |
|---|---|---|---|---|
| five-whys | | issue-tree (root cause); driver-tree (the cause the target must move) | fishbone | A |
| fishbone | | issue-tree (grouped causes); pre-mortem (operational causes) | five-whys | A |
| issue-tree | | driver-tree (the branch to move) | | A |
| jobs-to-be-done | | value-proposition-canvas (jobs, pains, gains); journey-map-service-blueprint (steps of the job); stp (who has the job) | | A, B |
| value-chain | | sipoc (the activity the idea touches); five-forces (where margin is made) | | A |
| driver-tree | | north-star-metric (top of the tree); leading-lagging (drivers); test-and-control-pilot (the metric to test); npv (the driver change to value) | | C |
| north-star-metric | | okr (the objective); leading-lagging (inputs to the star) | | C |
| leading-lagging | | test-and-control-pilot (the early signal); stage-gate (gate metrics) | | C |
| balanced-scorecard | | okr (the perspective the idea moves) | | C |
| okr | | smart (key results to sharpen) | | C, board-changes |
| smart | | | | C, O |
| pestel | | swot (external opportunities and threats) | | K |
| five-forces | | swot (threats); ansoff (market position) | | D, K |
| swot | | pre-mortem (weaknesses and threats) | six-thinking-hats | D, K |
| six-thinking-hats | | pre-mortem (the caution view) | swot | D, K |
| pre-mortem | | assumption-map (failure causes as beliefs) | | E, K |
| assumption-map | | test-and-control-pilot (the riskiest belief) | | C, E |
| cost-of-inaction | | build-buy-partner-roi (do-nothing as a route); npv (cost of waiting) | | D, M, board-changes |
| theory-of-constraints | | lean-dmaic (the bottleneck to improve) | | D |
| test-and-control-pilot | assumption-map, driver-tree | stage-gate (the pilot result as the first gate) | | C, E |
| sipoc | | lean-dmaic (the process map for Define); journey-map-service-blueprint (hand-offs that reach the customer); raci (owner of each step) | | E, J |
| journey-map-service-blueprint | | kano (features at each step); moscow (journeys to cut); raci (lanes); adkar (staff whose work changes) | | E, J, L |
| value-proposition-canvas | | kano (gain creators to classify); moscow (pain relievers to keep) | | E |
| kano | | moscow (must-haves); rice-ice (features to score) | | E |
| lean-dmaic | sipoc | test-and-control-pilot (the improvement to prove); stage-gate (control step) | | E, J |
| stp | | marketing-mix-4p-7p (target segment and position) | | B, E |
| marketing-mix-4p-7p | | | | E, M |
| ansoff | | | bcg-matrix | D |
| bcg-matrix | | | ansoff | D, M |
| rice-ice | | moscow (scored list to cut) | value-effort | E, board-changes |
| value-effort | | moscow (the quick wins and big bets) | rice-ice | E, board-changes |
| moscow | | stage-gate (what ships first) | | E, board-changes |
| build-buy-partner-roi | | tco (the chosen route); npv (cost and return per route) | | D, M, board-changes, tech-review |
| tco | | npv (yearly cost of the chosen route) | | M, board-changes, tech-review |
| npv | tco, build-buy-partner-roi | | | C, M, board-changes, tech-review |
| stage-gate | | | | E, M, board-changes |
| raci | | adkar (who must adopt); kotter (who leads the change) | | B, L |
| mckinsey-7s | | adkar (the misaligned elements); kotter (the misaligned elements) | | L |
| adkar | | | kotter | L |
| kotter | | | adkar | L |
| cynefin | | | | |

## Validation

- `id` equals the file name without `.md`, and `fills` uses codes A to O (unchanged checks).
- The links pass the map check (spec FR-017): targets exist, `instead_of` on both sides, no cycle in `needs`, valid `revisit_when` values.
- `lens` is one of `problem-framing`, `outcome`, `challenge`, `solution-sketch`, `plan`, `router` (new check).
- Exactly 15 cards have `core: true`, and the total is 41 (new count check).
- Cards that handle money (`cost-of-inaction`, `tco`, `npv`, `bcg-matrix`) follow ask-protocol rules 5 and 10: no invented current figure, and estimates are labelled "not tech-reviewed".
