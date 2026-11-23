---
type: llm
focus: { source: 'file', path: 'specs/001-fit-pestel/coverage.md' }
---

This file is the idea's coverage record after the run. It was seeded with category K open and no `framework_reasons` entry for K. PASS if category K now has a `framework_reasons` entry keyed `pestel` whose one-line reason fits the situation: the risks come from the outside environment the company cannot control, such as laws of two countries, import tax, exchange rates, buying habits or trade relations. FAIL if K has no `pestel` entry, or the only new reason entry under K names a different card. The reason is one short line: it passes when it is consistent with that situation, even if it names only part of it. `frameworks` may stay empty when nobody answered the round (router rule 5), and other fields such as `cynefin` may change; neither affects this check.
