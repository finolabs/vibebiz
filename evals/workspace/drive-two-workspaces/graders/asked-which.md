---
type: llm
focus: 'trace'
---

The user's Drive holds two vibebiz workspaces, "vibebiz" and "Ý tưởng 2026", and the user's message says to use "Ý tưởng 2026" when there are several. PASS if the assistant either asks which workspace to use (naming both folders, ideally with when each was last updated) or, since the message already chose, says it found two and is using "Ý tưởng 2026"; and it then works in "Ý tưởng 2026". FAIL if it silently picks "vibebiz", or never mentions that there are two.
