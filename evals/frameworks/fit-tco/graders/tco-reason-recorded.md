---
type: regex
target: { source: 'file', path: 'specs/001-fit-tco/coverage.md' }
match: 'contains'
pattern: 'framework_reasons:\s*\n(?:[ \t]+[\w-]+:[^\n]*\n)*?[ \t]+tco:[ \t]*\S'
---

The `tco` card is handed over and its reason line is written under the category's `framework_reasons`.
