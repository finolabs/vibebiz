---
type: regex
target: { source: 'file', path: 'specs/001-fit-smart/coverage.md' }
match: 'contains'
pattern: 'framework_reasons:\s*(\n\s+|\{\s*)["'']?smart["'']?:'
---

The router hands `smart` over for C and writes its one-line reason under `framework_reasons` in coverage.md (router rule 3). Checked on the written file, since an `llm` grader on the trace sees only its first 100 KB.
