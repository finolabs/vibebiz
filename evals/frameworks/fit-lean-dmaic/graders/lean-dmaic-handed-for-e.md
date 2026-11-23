---
type: llm
focus: { source: 'file', path: 'specs/001-fit-lean-dmaic/coverage.md' }
---

This file is the idea's coverage record after the run. It was seeded with category E open and no `framework_reasons` entry for E other than the seeded `sipoc` entry. PASS if category E now has a `framework_reasons` entry keyed `lean-dmaic` whose one-line reason fits the situation: the process is already outlined (the seeded sipoc entry) and the open question is which measured improvement to make first and how to hold the result. FAIL if E has no `lean-dmaic` entry, or the only new reason entry under E names a different card. The reason is one short line: it passes when it is consistent with that situation, even if it names only part of it. `frameworks` may stay empty when nobody answered the round (router rule 5), and other fields such as `cynefin` may change; neither affects this check.
