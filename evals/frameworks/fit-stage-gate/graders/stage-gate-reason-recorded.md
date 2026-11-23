---
type: regex
target: { source: 'file', path: 'specs/001-fit-stage-gate/coverage.md' }
match: 'contains'
pattern: 'framework_reasons:\s*\n(?:[ \t]+[\w-]+:[^\n]*\n)*?[ \t]+stage-gate:[ \t]*\S'
---

The `stage-gate` card is handed over and its reason line is written under the category's `framework_reasons`.
