---
type: regex
target: { source: 'file', path: 'specs/001-fit-bcg-matrix/coverage.md' }
match: 'contains'
pattern: 'framework_reasons:\s*\n(?:[ \t]+[\w-]+:[^\n]*\n)*?[ \t]+bcg-matrix:[ \t]*\S'
---

The `bcg-matrix` card is handed over and its reason line is written under the category's `framework_reasons`.
