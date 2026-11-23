---
type: regex
target: { source: 'file', path: 'specs/001-skip-smart/coverage.md' }
match: 'not_contains'
pattern: '\n\s+["'']?smart["'']?:|frameworks:\s*\[[^\]]*smart'
---

`smart` is neither given a `framework_reasons` line nor listed in `frameworks`: four teams need one shared quarter objective with several key results and owners (`okr`), not one goal sharpened for one team.
