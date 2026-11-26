---
type: regex
target: { source: 'file', path: 'specs/001-skip-npv/coverage.md' }
match: 'not_contains'
pattern: '\n[ \t]+npv:|frameworks:[ \t]*\[[^\]]*\bnpv\b'
---

The `npv` card is not handed over: no reason line and no `frameworks` entry for it.
