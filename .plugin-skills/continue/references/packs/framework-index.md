# Framework card index

Generated from the frontmatter of the cards in `frameworks/` by `scripts/checks/framework_map.py render`; do not edit by hand. Look a category up here to find every card whose `fills` includes it, then read those cards' files. The card file stays the authority for "When to use", "When not to use", `feeds` and `revisit_when`.

## By category

| Code | Lens | Cards |
|---|---|---|
| A | problem-framing | fishbone, five-whys, jobs-to-be-done |
| B | problem-framing | jobs-to-be-done |
| C | outcome | balanced-scorecard, driver-tree |
| D | challenge | assumption-map, swot |
| D | plan | build-buy-partner-roi |
| E | plan | marketing-mix-4p-7p, moscow |
| E | solution-sketch | journey-map-service-blueprint, sipoc |
| J | solution-sketch | journey-map-service-blueprint, sipoc |
| K | challenge | assumption-map, pre-mortem, swot, test-and-control-pilot |
| L | plan | adkar |
| L | solution-sketch | journey-map-service-blueprint |
| M | challenge | test-and-control-pilot |
| M | plan | build-buy-partner-roi, marketing-mix-4p-7p |

## Cards

| Card | Lens | Fills | Needs | Instead of | Feeds |
|---|---|---|---|---|---|
| adkar | plan | L | — | — | — |
| assumption-map | challenge | K, D | — | — | test-and-control-pilot |
| balanced-scorecard | outcome | C | — | — | driver-tree |
| build-buy-partner-roi | plan | D, M | — | — | adkar |
| cynefin | router | — | — | — | — |
| driver-tree | outcome | C | — | — | assumption-map, pre-mortem, test-and-control-pilot |
| fishbone | problem-framing | A | — | five-whys | pre-mortem |
| five-whys | problem-framing | A | — | fishbone | driver-tree |
| jobs-to-be-done | problem-framing | A, B | — | — | journey-map-service-blueprint, driver-tree |
| journey-map-service-blueprint | solution-sketch | E, J, L | — | — | moscow, adkar |
| marketing-mix-4p-7p | plan | E, M | — | — | — |
| moscow | plan | E | — | — | adkar |
| pre-mortem | challenge | K | — | — | assumption-map, build-buy-partner-roi, moscow |
| sipoc | solution-sketch | E, J | — | — | journey-map-service-blueprint, driver-tree |
| swot | challenge | D, K | — | — | pre-mortem, driver-tree |
| test-and-control-pilot | challenge | M, K | assumption-map, driver-tree | — | build-buy-partner-roi |
