---
type: llm
focus: { source: 'file', path: 'specs/001-fit-five-forces/coverage.md' }
---

This file is the idea's coverage record after the run. It was seeded with category D open and no `framework_reasons` entry for D. PASS if category D now has a `framework_reasons` entry keyed `five-forces` whose one-line reason fits the situation: the idea's result depends on outside market players such as rival shops, fabric suppliers with bargaining power, price-sensitive buyers or new brands entering. FAIL if D has no `five-forces` entry, or the only new reason entry under D names a different card. The reason is one short line: it passes when it is consistent with that situation, even if it names only part of it. `frameworks` may stay empty when nobody answered the round (router rule 5), and other fields such as `cynefin` may change; neither affects this check.
