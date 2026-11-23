---
type: regex
target: { source: 'file', path: 'specs/001-skip-bcg-matrix/coverage.md' }
match: 'not_contains'
pattern: '\n[ \t]+bcg-matrix:|frameworks:[ \t]*\[[^\]]*\bbcg-matrix\b'
---

The `bcg-matrix` card is not handed over: no reason line and no `frameworks` entry for it.
