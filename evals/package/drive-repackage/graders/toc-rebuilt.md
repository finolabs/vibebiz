---
type: regex
target: { source: 'file', path: '.fake-drive/calls.jsonl' }
pattern: '"tool": "create_file"[^\n]*"title": "index.json"[^\n]*"ok": true'
flags: ''
match: 'contains'
---
