---
type: llm
focus: 'trace'
---

Earlier decision D-001 in decisions.md: raise 90-day repeat purchase from 18% to 25% in 6 months. The user now states 40% in 3 months.
PASS if the assistant shows the earlier decision (the 25% in 6 months target, or D-001) to the user and asks which one stands (a question, or a statement that it needs the user's choice), before replacing it.
FAIL if it silently adopts 40% or silently keeps 25%, without showing the earlier decision.
