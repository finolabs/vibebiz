---
type: regex
target: { source: 'file', path: 'specs/001-map-needs-gate/coverage.md' }
match: 'not_contains'
pattern: 'test-and-control-pilot'
---

test-and-control-pilot needs assumption-map or driver-tree applied, or C clear; C is deferred and neither card is applied, so the pilot card is not handed over for K or M (router "Frameworks" rule 8, `needs`).
