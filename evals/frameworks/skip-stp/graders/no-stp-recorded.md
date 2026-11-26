---
type: regex
target: { source: 'file', path: 'specs/001-skip-stp/coverage.md' }
match: 'not_contains'
pattern: '\n[ \t]+stp:|frameworks:[ \t]*\[[^\]]*\bstp\b'
---

The `stp` card is not handed over: no reason line and no `frameworks` entry for it.
