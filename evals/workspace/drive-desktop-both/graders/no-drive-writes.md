---
type: regex
path: '.fake-drive/calls.jsonl'
pattern: '"tool": "(create_file|copy_file|trash_file|update_file|share_file)"'
match: not_contains
---
