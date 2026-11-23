---
type: llm
focus: { source: 'file', path: 'specs/001-fit-value-proposition-canvas/coverage.md' }
---

This file is the idea's coverage record after the run. It was seeded with category E open and no `framework_reasons` entry for E. PASS if category E now has a `framework_reasons` entry keyed `value-proposition-canvas` whose one-line reason fits the situation: a long list of candidate features must be matched to the customer's job, pains and gains already recorded, to keep only what relieves a real pain or creates a real gain. FAIL if E has no `value-proposition-canvas` entry, or the only new reason entry under E names a different card. The reason is one short line: it passes when it is consistent with that situation, even if it names only part of it. `frameworks` may stay empty when nobody answered the round (router rule 5), and other fields such as `cynefin` may change; neither affects this check.
