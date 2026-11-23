---
type: regex
target: { source: 'file', path: 'specs/001-fit-leading-lagging/coverage.md' }
match: 'contains'
pattern: 'framework_reasons:\s*(\n\s+|\{\s*)["'']?leading-lagging["'']?:'
---

The router hands `leading-lagging` over for C and writes its one-line reason under `framework_reasons` in coverage.md (router rule 3). Checked on the written file, since an `llm` grader on the trace sees only its first 100 KB.
