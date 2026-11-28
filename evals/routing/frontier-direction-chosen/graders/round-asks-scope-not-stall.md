---
type: llm
focus: 'trace'
---

The workspace has a fixed coverage record: A (problem), B (users), C (outcome) and N (terminology) are clear. D (alternatives) is partial: the user chose to fix the process first (decision D-001), and the only gap left is how many percentage points of repeat purchases the process fix would add, recorded as open question Q-001 that the user will answer after a trial in two stores. Every other category is missing. E (scope and behavior: which journeys, in what order, what is out of scope) needs C and D.
PASS if the run shows a next round, through AskUserQuestion or, when that tool is not available in the session, written as text in the final message, and at least one of its questions is about scope and behavior (E): which customers get reminded, when or how often, through which channel, which journeys come first, or what is left out.
FAIL if the run asks no question, asks the user how much the process fix raises repeat purchases or for Q-001's answer, ends by saying it must wait for the trial or that figure, asks only about that figure or about re-choosing among alternatives, or asks about AI fit, data, integrations, performance, edge cases, risk, organizational change, cost and return or completion criteria (they need E first).
