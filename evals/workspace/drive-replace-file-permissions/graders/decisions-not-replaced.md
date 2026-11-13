---
type: regex
target: { source: 'file', path: '.fake-drive/calls.jsonl' }
pattern: '"tool": "(create_file|trash_file)"[^\n]*("s0012"|"title": "decisions.md")'
flags: ''
match: 'not_contains'
---
