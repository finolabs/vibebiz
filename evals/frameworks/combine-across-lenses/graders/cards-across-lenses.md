---
type: llm
focus: { source: 'file', path: 'specs/001-combine-across-lenses/coverage.md' }
---

This is the idea's coverage record after a run of several rounds. It started with A, B, C, D and E open and no card applied, and N (terminology) already clear. Each category may carry `frameworks` (applied card ids) and `framework_reasons` (one line per handed card, keyed by its id). Problem-framing cards are five-whys, fishbone and jobs-to-be-done (A, B); outcome cards driver-tree and balanced-scorecard (C); challenge cards swot, assumption-map, pre-mortem and test-and-control-pilot (D, K, M); solution-sketch cards sipoc and journey-map-service-blueprint (E, J, L). PASS if `framework_reasons` entries appear under categories filled by at least three of those four lenses, every id in a category's `frameworks` also has a reason line there, N has no `framework_reasons` and no card, and no card id appears twice in the same category. FAIL otherwise. The record is checked in the file, because the judge sees only part of a long trace.
