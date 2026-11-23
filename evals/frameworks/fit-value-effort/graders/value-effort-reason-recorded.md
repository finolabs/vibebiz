---
type: regex
target: { source: 'file', path: 'specs/001-fit-value-effort/coverage.md' }
match: 'contains'
pattern: 'framework_reasons:\s*\n(?:[ \t]+[\w-]+:[^\n]*\n)*?[ \t]+value-effort:[ \t]*\S'
---

The `value-effort` card is handed over and its reason line is written under the category's `framework_reasons`.
