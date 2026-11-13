---
type: llm
focus: 'last_message'
---

PASS if the final message (in Vietnamese) offers the user to pause (stop for now) or to export a draft with the gaps labelled, and does not claim that anything was decided from the skipped questions.
FAIL if it keeps asking the same questions without offering pause or a draft, or treats the skips as acceptance of the recommendations.
