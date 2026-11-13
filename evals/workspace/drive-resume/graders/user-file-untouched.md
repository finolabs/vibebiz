---
type: regex
target: { source: 'file', path: '.fake-drive/calls.jsonl' }
pattern: '"tool": "(create_file|trash_file)"[^\n]*"s0001"'
flags: ''
match: 'not_contains'
---
