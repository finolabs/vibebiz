---
type: regex
target: { source: 'file', path: 'specs/001-skip-okr/coverage.md' }
match: 'not_contains'
pattern: '\n\s+["'']?okr["'']?:|frameworks:\s*\[[^\]]*okr'
---

`okr` is neither given a `framework_reasons` line nor listed in `frameworks`: the ground rules record a strategy map and the board asks which perspective and objective the idea serves, so the scorecard card (`balanced-scorecard`) fits better than setting a new quarter objective.
