---
type: regex
target: { source: 'file', path: '.fake-drive/calls.jsonl' }
pattern: '"tool": "(create_file|trash_file|copy_file)"[^\n]*"(parentId|fileId)": "(s0002|s0003|s0004|s0005|s0006|s0007|s0008|s0009|s0010|s0011|s0012|s0013|s0014|s0015|s0016|s0017|s0018|s0019|s0020)"[^\n]*"ok": true'
flags: ''
match: 'not_contains'
---
