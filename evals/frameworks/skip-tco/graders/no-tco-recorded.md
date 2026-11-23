---
type: regex
target: { source: 'file', path: 'specs/001-skip-tco/coverage.md' }
match: 'not_contains'
pattern: '\n[ \t]+tco:|frameworks:[ \t]*\[[^\]]*\btco\b'
---

The `tco` card is not handed over: no reason line and no `frameworks` entry for it.
