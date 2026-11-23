---
type: regex
target: { source: 'file', path: 'specs/001-may-quet-ma-kiem-kho/coverage.md' }
match: 'not_contains'
pattern: '\n[ \t]+raci:|frameworks:[ \t]*\[[^\]]*\braci\b'
---

The `raci` card is not handed over: no reason line and no `frameworks` entry for it.
