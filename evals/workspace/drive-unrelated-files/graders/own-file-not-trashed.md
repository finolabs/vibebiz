---
type: regex
target: { source: 'file', path: '.fake-drive/calls.jsonl' }
pattern: '"tool": "trash_file"[^\n]*"u0002"'
flags: ''
match: 'not_contains'
---
