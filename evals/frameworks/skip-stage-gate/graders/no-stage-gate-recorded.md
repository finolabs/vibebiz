---
type: regex
target: { source: 'file', path: 'specs/001-tu-van-phoi-do-video/coverage.md' }
match: 'not_contains'
pattern: '\n[ \t]+stage-gate:|frameworks:[ \t]*\[[^\]]*\bstage-gate\b'
---

The `stage-gate` card is not handed over: no reason line and no `frameworks` entry for it.
