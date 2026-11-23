---
type: regex
target: { source: 'file', path: 'specs/001-fit-rice-ice/coverage.md' }
match: 'contains'
pattern: 'framework_reasons:\s*\n(?:[ \t]+[\w-]+:[^\n]*\n)*?[ \t]+rice-ice:[ \t]*\S'
---

The `rice-ice` card is handed over and its reason line is written under the category's `framework_reasons`.
