---
type: regex
target: { source: 'file', path: '.fake-drive/calls.jsonl' }
pattern: '"tool": "create_file"[^\n]*"disableConversionToGoogleType": false'
flags: ''
match: 'not_contains'
---
