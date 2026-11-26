---
type: regex
target: { source: 'file', path: 'specs/001-skip-sipoc/coverage.md' }
match: 'not_contains'
pattern: '\n\s+sipoc:|frameworks:\s*\[[^\]]*sipoc'
---
