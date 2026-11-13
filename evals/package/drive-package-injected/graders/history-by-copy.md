---
type: regex
target: { source: 'file', path: '.fake-drive/calls.jsonl' }
pattern: '"tool": "copy_file"[^\n]*"ok": true'
flags: ''
match: 'contains'
---
