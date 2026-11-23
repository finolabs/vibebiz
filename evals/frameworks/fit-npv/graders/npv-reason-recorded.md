---
type: regex
target: { source: 'file', path: 'specs/001-fit-npv/coverage.md' }
match: 'contains'
pattern: 'framework_reasons:\s*\n(?:[ \t]+[\w-]+:[^\n]*\n)*?[ \t]+npv:[ \t]*\S'
---

The `npv` card is handed over and its reason line is written under the category's `framework_reasons`.
