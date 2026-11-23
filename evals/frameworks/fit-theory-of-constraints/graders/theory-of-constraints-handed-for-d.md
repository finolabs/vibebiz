---
type: llm
focus: { source: 'file', path: 'specs/001-fit-theory-of-constraints/coverage.md' }
---

This file is the idea's coverage record after the run. It was seeded with category D open and no `framework_reasons` entry for D. PASS if category D now has a `framework_reasons` entry keyed `theory-of-constraints` whose one-line reason fits the situation: orders move through a chain of steps and one step (checking) holds the whole flow back, while the idea adds capacity at another step. FAIL if D has no `theory-of-constraints` entry, or the only new reason entry under D names a different card. The reason is one short line: it passes when it is consistent with that situation, even if it names only part of it. `frameworks` may stay empty when nobody answered the round (router rule 5), and other fields such as `cynefin` may change; neither affects this check.
