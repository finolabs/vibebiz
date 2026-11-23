# Framework card index

Generated from the frontmatter of the cards in `frameworks/` by `scripts/checks/framework_map.py render`; do not edit by hand. Look a category up here to find every card whose `fills` includes it, then read those cards' files. "Fed by" lists every card that feeds this one and what it passes; when one of them is applied to the idea, name it in the hand-off and start the reason line with `fed by <card> (<passes>);`. The card file stays the authority for "When to use", "When not to use", `feeds` and `revisit_when`.

## By category

| Code | Lens | Cards |
|---|---|---|
| A | problem-framing | fishbone, five-whys, issue-tree, jobs-to-be-done, value-chain |
| B | problem-framing | jobs-to-be-done, value-chain |
| C | outcome | balanced-scorecard, driver-tree, leading-lagging, north-star-metric, okr, smart |
| D | challenge | assumption-map, cost-of-inaction, five-forces, six-thinking-hats, swot, theory-of-constraints |
| D | plan | build-buy-partner-roi |
| E | plan | marketing-mix-4p-7p, moscow |
| E | solution-sketch | journey-map-service-blueprint, kano, lean-dmaic, sipoc, value-proposition-canvas |
| J | solution-sketch | journey-map-service-blueprint, lean-dmaic, sipoc |
| K | challenge | assumption-map, five-forces, pestel, pre-mortem, six-thinking-hats, swot, test-and-control-pilot |
| L | plan | adkar |
| L | solution-sketch | journey-map-service-blueprint |
| M | challenge | cost-of-inaction, test-and-control-pilot |
| M | plan | build-buy-partner-roi, marketing-mix-4p-7p |
| O | outcome | okr, smart |

## Cards

| Card | Lens | Fills | Needs | Instead of | Feeds | Fed by (passes) |
|---|---|---|---|---|---|---|
| adkar | plan | L | — | — | — | build-buy-partner-roi (the chosen route and whose work it changes); journey-map-service-blueprint (the staff whose work changes); moscow (what ships first and who uses it) |
| assumption-map | challenge | K, D | — | — | test-and-control-pilot | driver-tree (the drivers that rest on beliefs); pre-mortem (the failure causes as beliefs) |
| balanced-scorecard | outcome | C | — | — | driver-tree, okr | — |
| build-buy-partner-roi | plan | D, M | — | — | adkar | cost-of-inaction (doing nothing as a route, with its yearly cost); pre-mortem (the risks each route must cover); test-and-control-pilot (the pilot result) |
| cost-of-inaction | challenge | D, M | — | — | build-buy-partner-roi | — |
| cynefin | router | — | — | — | — | — |
| driver-tree | outcome | C | — | — | assumption-map, pre-mortem, test-and-control-pilot, north-star-metric, leading-lagging | balanced-scorecard (the perspective the idea moves); five-whys (the cause the target must move); issue-tree (the branch to move); jobs-to-be-done (the outcome the customer wants); sipoc (the step whose delay to measure); swot (the opportunity to measure) |
| fishbone | problem-framing | A | — | five-whys | pre-mortem, issue-tree | — |
| five-forces | challenge | D, K | — | — | swot | value-chain (where margin is made) |
| five-whys | problem-framing | A | — | fishbone | driver-tree, issue-tree | — |
| issue-tree | problem-framing | A | — | — | driver-tree | fishbone (the grouped causes); five-whys (the root cause) |
| jobs-to-be-done | problem-framing | A, B | — | — | journey-map-service-blueprint, driver-tree, value-proposition-canvas | — |
| journey-map-service-blueprint | solution-sketch | E, J, L | — | — | moscow, adkar, kano | jobs-to-be-done (the steps of the job); sipoc (the hand-offs that reach the customer) |
| kano | solution-sketch | E | — | — | moscow | journey-map-service-blueprint (the features at each step); value-proposition-canvas (the gain creators to classify) |
| leading-lagging | outcome | C | — | — | test-and-control-pilot | driver-tree (the drivers); north-star-metric (the inputs to the star) |
| lean-dmaic | solution-sketch | E, J | sipoc | — | test-and-control-pilot | sipoc (the process map for Define); theory-of-constraints (the bottleneck to improve) |
| marketing-mix-4p-7p | plan | E, M | — | — | — | — |
| moscow | plan | E | — | — | adkar | journey-map-service-blueprint (the journeys to cut); kano (the must-haves); pre-mortem (what to leave out of the first release); value-proposition-canvas (the pain relievers to keep) |
| north-star-metric | outcome | C | — | — | okr, leading-lagging | driver-tree (the top of the tree) |
| okr | outcome | C, O | — | — | smart | balanced-scorecard (the perspective the idea moves); north-star-metric (the objective) |
| pestel | challenge | K | — | — | swot | — |
| pre-mortem | challenge | K | — | — | assumption-map, build-buy-partner-roi, moscow | driver-tree (the target that could be missed); fishbone (the operational causes); six-thinking-hats (the caution view); swot (the weaknesses and threats) |
| sipoc | solution-sketch | E, J | — | — | journey-map-service-blueprint, driver-tree, lean-dmaic | value-chain (the activity the idea touches) |
| six-thinking-hats | challenge | D, K | — | swot | pre-mortem | — |
| smart | outcome | C, O | — | — | — | okr (the key results to sharpen) |
| swot | challenge | D, K | — | six-thinking-hats | pre-mortem, driver-tree | five-forces (the threats from rivals, suppliers, buyers, substitutes and new entrants); pestel (the external opportunities and threats) |
| test-and-control-pilot | challenge | M, K | assumption-map, driver-tree | — | build-buy-partner-roi | assumption-map (the riskiest belief); driver-tree (the metric to test); leading-lagging (the early signal); lean-dmaic (the improvement to prove) |
| theory-of-constraints | challenge | D | — | — | lean-dmaic | — |
| value-chain | problem-framing | A, B | — | — | sipoc, five-forces | — |
| value-proposition-canvas | solution-sketch | E | — | — | kano, moscow | jobs-to-be-done (the jobs, pains and gains) |
