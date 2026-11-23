---
type: regex
target: { source: 'file', path: 'specs/001-combine-across-lenses/coverage.md' }
match: 'contains'
pattern: 'framework_reasons:\s*\n\s+[a-z0-9-]+:[\s\S]*framework_reasons:\s*\n\s+[a-z0-9-]+:[\s\S]*framework_reasons:\s*\n\s+[a-z0-9-]+:'
---

At least three categories carry a `framework_reasons` line keyed by a card id (spec 004 FR-007).
