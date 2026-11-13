---
type: regex
target: { source: 'file', path: '.fake-drive/calls.jsonl' }
pattern: '"tool": "(create_file|trash_file)"[^\n]*("s0016"|"title": "spec.md")'
flags: ''
match: 'not_contains'
---
