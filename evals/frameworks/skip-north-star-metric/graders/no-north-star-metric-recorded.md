---
type: regex
target: { source: 'file', path: 'specs/001-skip-north-star-metric/coverage.md' }
match: 'not_contains'
pattern: '\n\s+["'']?north-star-metric["'']?:|frameworks:\s*\[[^\]]*north-star-metric'
---

`north-star-metric` is neither given a `framework_reasons` line nor listed in `frameworks`: the top result (store revenue) is already agreed by the board; breaking it into the drivers the idea moves (`driver-tree`) fits better than choosing one company-wide number.
