---
type: regex
target: { source: 'file', path: 'specs/001-skip-rice-ice/coverage.md' }
match: 'not_contains'
pattern: '\n[ \t]+rice-ice:|frameworks:[ \t]*\[[^\]]*\brice-ice\b'
---

The `rice-ice` card is not handed over: no reason line and no `frameworks` entry for it.
