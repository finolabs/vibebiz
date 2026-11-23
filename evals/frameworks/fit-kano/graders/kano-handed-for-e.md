---
type: llm
focus: { source: 'file', path: 'specs/001-fit-kano/coverage.md' }
---

This file is the idea's coverage record after the run. It was seeded with category E open and no `framework_reasons` entry for E. PASS if category E now has a `framework_reasons` entry keyed `kano` whose one-line reason fits the situation: the features are already tied to customer pains and the open question is how customers would react to each one: expected as basic, more is better, a pleasant surprise, or indifferent. FAIL if E has no `kano` entry, or the only new reason entry under E names a different card. The reason is one short line: it passes when it is consistent with that situation, even if it names only part of it. `frameworks` may stay empty when nobody answered the round (router rule 5), and other fields such as `cynefin` may change; neither affects this check.
