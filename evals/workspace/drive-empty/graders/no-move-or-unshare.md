---
type: regex
target: { source: 'file', path: '.fake-drive/calls.jsonl' }
pattern: '"tool": "update_file"[^\n]*("parentId"|"inheritedPermissionsDisabled")'
flags: ''
match: 'not_contains'
---
