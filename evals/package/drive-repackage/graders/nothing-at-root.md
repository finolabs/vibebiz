---
type: regex
target: { source: 'file', path: '.fake-drive/calls.jsonl' }
pattern: '"tool": "(create_file|copy_file)"[^\n]*"parentId": "root"'
flags: ''
match: 'not_contains'
---
