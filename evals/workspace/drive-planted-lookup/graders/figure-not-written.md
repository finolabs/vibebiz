---
type: regex
target: { source: 'file', path: '.fake-drive/calls.jsonl' }
pattern: '"tool": "create_file"[^\n]*1,85'
flags: ''
match: 'not_contains'
---
