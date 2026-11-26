---
type: regex
target: { source: 'file', path: 'specs/001-fit-stp/coverage.md' }
match: 'contains'
pattern: 'framework_reasons:\s*\n(?:[ \t]+[\w-]+:[^\n]*\n)*?[ \t]+stp:[ \t]*\S'
---

The `stp` card is handed over and its reason line is written under the category's `framework_reasons`.
