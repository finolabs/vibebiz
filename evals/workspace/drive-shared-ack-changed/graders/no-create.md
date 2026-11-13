---
type: regex
target: { source: 'file', path: '.fake-drive/calls.jsonl' }
pattern: '"tool": "(create_file|trash_file)"[^\n]*"ok": true'
flags: ''
match: 'not_contains'
---
