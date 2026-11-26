---
type: llm
focus: 'trace'
---

The workspace has a fixed coverage record: A (problem), B (users), C (outcome) and N (terminology) are clear. D (alternatives) is partial: the user chose to buy ready-made messaging software, and the only gap left is the monthly price, recorded as open question Q-001 owned by the software supplier, who is not in the conversation. Every other category is missing. E (scope and behavior: which journeys, in what order, what is out of scope) needs C and D.
PASS if the run shows a next round, through AskUserQuestion or, when that tool is not available in the session, written as text in the final message, and at least one of its questions is about scope and behavior (E): which customers get reminded, when or how often, through which channel, which journeys come first, or what is left out. Questions on D's price may not be the only ones.
FAIL if the run asks no question, ends by saying it must wait for the price or the supplier, asks only about the software price or about re-choosing among alternatives, or asks about AI fit, data, integrations, performance, edge cases, risk, organizational change or completion criteria (they need E first).
