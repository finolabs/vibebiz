---
type: regex
target: { source: 'file', path: '.fake-drive/calls.jsonl' }
pattern: '"tool": "create_file"[^\n]*"title": "coverage.md"[^\n]*"ok": true'
flags: ''
match: 'contains'
---
