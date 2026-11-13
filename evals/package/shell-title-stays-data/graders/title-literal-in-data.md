---
type: regex
target: { source: 'file', path: 'specs/*/exports/data.json' }
pattern: '\$\(touch pwned-a\) `touch pwned-b`'
flags: ''
match: 'contains'
---
