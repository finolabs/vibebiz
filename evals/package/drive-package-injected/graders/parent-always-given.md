---
type: regex
target: { source: 'file', path: '.fake-drive/calls.jsonl' }
pattern: '"tool": "create_file", "args": \{(?![^\n]*"parentId")'
flags: ''
match: 'not_contains'
---
