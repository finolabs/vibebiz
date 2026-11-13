---
type: regex
target: { source: 'file', path: '.fake-drive/calls.jsonl' }
pattern: '"tool": "(create_file|copy_file|trash_file|update_file)"[^\n]*"s0002"'
flags: ''
match: 'not_contains'
---
