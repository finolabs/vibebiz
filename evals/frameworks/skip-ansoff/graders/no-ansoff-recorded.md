---
type: regex
target: { source: 'file', path: 'specs/001-skip-ansoff/coverage.md' }
match: 'not_contains'
pattern: '\n[ \t]+ansoff:|frameworks:[ \t]*\[[^\]]*\bansoff\b'
---

The `ansoff` card is not handed over: no reason line and no `frameworks` entry for it.
