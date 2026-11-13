---
type: regex
target: { source: 'file', path: '.fake-drive/calls.jsonl' }
pattern: '"tool": "copy_file"[^\n]*"fileId": "s0001"'
flags: ''
match: 'not_contains'
---
