---
type: regex
target: { source: 'file', path: 'specs/001-skip-value-effort/coverage.md' }
match: 'not_contains'
pattern: '\n[ \t]+value-effort:|frameworks:[ \t]*\[[^\]]*\bvalue-effort\b'
---

The `value-effort` card is not handed over: no reason line and no `frameworks` entry for it.
