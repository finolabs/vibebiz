---
type: regex
target: { source: 'file', path: 'specs/001-skip-leading-lagging/coverage.md' }
match: 'not_contains'
pattern: '\n\s+["'']?leading-lagging["'']?:|frameworks:\s*\[[^\]]*leading-lagging'
---

`leading-lagging` is neither given a `framework_reasons` line nor listed in `frameworks`: no company-wide number is chosen yet and teams follow different ones; choosing the one number that shows members get value (`north-star-metric`) comes before splitting early and late signals.
