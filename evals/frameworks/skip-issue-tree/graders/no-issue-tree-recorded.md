---
type: regex
target: { source: 'file', path: 'specs/001-skip-issue-tree/coverage.md' }
match: 'not_contains'
pattern: '\n\s+["'']?issue-tree["'']?:|frameworks:\s*\[[^\]]*issue-tree'
---

`issue-tree` is neither given a `framework_reasons` line nor listed in `frameworks`: the problem is one recurring defect with a recent real case, where following one chain of causes (`five-whys`) fits better than splitting a broad question.
