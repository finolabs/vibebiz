# Framework card index

Generated from the frontmatter of the cards in `frameworks/` by `scripts/checks/framework_map.py render`; do not edit by hand. Look a category up here to find every card whose `fills` includes it, then read those cards' files. "Fed by" lists every card that feeds this one and what it passes; when one of them is applied to the idea, name it in the hand-off and start the reason line with `fed by <card> (<passes>);`. The card file stays the authority for "When to use", "When not to use", `feeds` and `revisit_when`.

## By category

| Code | Lens | Cards |
|---|---|---|
| A | problem-framing | fishbone, five-whys, jobs-to-be-done |
| B | problem-framing | jobs-to-be-done |
| C | outcome | balanced-scorecard, driver-tree |
| D | challenge | assumption-map, five-forces, swot |
| D | plan | build-buy-partner-roi |
| E | plan | marketing-mix-4p-7p, moscow |
| E | solution-sketch | journey-map-service-blueprint, sipoc |
| J | solution-sketch | journey-map-service-blueprint, sipoc |
| K | challenge | assumption-map, five-forces, pestel, pre-mortem, swot, test-and-control-pilot |
| L | plan | adkar |
| L | solution-sketch | journey-map-service-blueprint |
| M | challenge | test-and-control-pilot |
| M | plan | build-buy-partner-roi, marketing-mix-4p-7p |

## Cards

| Card | Lens | Fills | Needs | Instead of | Feeds | Fed by (passes) |
|---|---|---|---|---|---|---|
| adkar | plan | L | — | — | — | build-buy-partner-roi (the chosen route and whose work it changes); journey-map-service-blueprint (the staff whose work changes); moscow (what ships first and who uses it) |
| assumption-map | challenge | K, D | — | — | test-and-control-pilot | driver-tree (the drivers that rest on beliefs); pre-mortem (the failure causes as beliefs) |
| balanced-scorecard | outcome | C | — | — | driver-tree | — |
| build-buy-partner-roi | plan | D, M | — | — | adkar | pre-mortem (the risks each route must cover); test-and-control-pilot (the pilot result) |
| cynefin | router | — | — | — | — | — |
| driver-tree | outcome | C | — | — | assumption-map, pre-mortem, test-and-control-pilot | balanced-scorecard (the perspective the idea moves); five-whys (the cause the target must move); jobs-to-be-done (the outcome the customer wants); sipoc (the step whose delay to measure); swot (the opportunity to measure) |
| fishbone | problem-framing | A | — | five-whys | pre-mortem | — |
| five-forces | challenge | D, K | — | — | swot | — |
| five-whys | problem-framing | A | — | fishbone | driver-tree | — |
| jobs-to-be-done | problem-framing | A, B | — | — | journey-map-service-blueprint, driver-tree | — |
| journey-map-service-blueprint | solution-sketch | E, J, L | — | — | moscow, adkar | jobs-to-be-done (the steps of the job); sipoc (the hand-offs that reach the customer) |
| marketing-mix-4p-7p | plan | E, M | — | — | — | — |
| moscow | plan | E | — | — | adkar | journey-map-service-blueprint (the journeys to cut); pre-mortem (what to leave out of the first release) |
| pestel | challenge | K | — | — | swot | — |
| pre-mortem | challenge | K | — | — | assumption-map, build-buy-partner-roi, moscow | driver-tree (the target that could be missed); fishbone (the operational causes); swot (the weaknesses and threats) |
| sipoc | solution-sketch | E, J | — | — | journey-map-service-blueprint, driver-tree | — |
| swot | challenge | D, K | — | — | pre-mortem, driver-tree | five-forces (the threats from rivals, suppliers, buyers, substitutes and new entrants); pestel (the external opportunities and threats) |
| test-and-control-pilot | challenge | M, K | assumption-map, driver-tree | — | build-buy-partner-roi | assumption-map (the riskiest belief); driver-tree (the metric to test) |
