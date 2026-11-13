---
type: regex
target: { source: 'file', path: '.fake-drive/calls.jsonl' }
pattern: '"tool": "trash_file"[^\n]*"s0011"'
flags: ''
match: 'not_contains'
---
