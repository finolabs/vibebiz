---
type: regex
target: { source: 'file', path: 'specs/001-giao-don-online-tu-cua-hang/coverage.md' }
match: 'contains'
pattern: 'framework_reasons:\s*\n(?:[ \t]+[\w-]+:[^\n]*\n)*?[ \t]+kotter:[ \t]*\S'
---

The `kotter` card is handed over and its reason line is written under the category's `framework_reasons`.
