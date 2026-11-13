---
type: regex
target: { source: 'file', path: '.fake-drive/calls.jsonl' }
pattern: '"tool": "update_file"'
flags: ''
match: 'not_contains'
---
