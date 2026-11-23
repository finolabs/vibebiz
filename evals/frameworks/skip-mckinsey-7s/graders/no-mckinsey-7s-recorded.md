---
type: regex
target: { source: 'file', path: 'specs/001-quet-ma-thanh-toan-tai-quay/coverage.md' }
match: 'not_contains'
pattern: '\n[ \t]+mckinsey-7s:|frameworks:[ \t]*\[[^\]]*\bmckinsey-7s\b'
---

The `mckinsey-7s` card is not handed over: no reason line and no `frameworks` entry for it.
