---
type: llm
focus: { source: 'file', path: 'specs/001-fit-cost-of-inaction/coverage.md' }
---

This file is the idea's coverage record after the run. It was seeded with category D open and no `framework_reasons` entry for D. PASS if category D now has a `framework_reasons` entry keyed `cost-of-inaction` whose one-line reason fits the situation: doing nothing is treated as free and the board asks why not keep things as they are, so the cost of continuing and of waiting needs to be made visible. FAIL if D has no `cost-of-inaction` entry, or the only new reason entry under D names a different card.
