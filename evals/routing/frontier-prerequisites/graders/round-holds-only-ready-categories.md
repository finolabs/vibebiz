---
type: llm
focus: 'trace'
---

The workspace has a fixed coverage record: A (problem) is clear; C (outcome) is partial; B (users), N (terminology) are missing; every other category is missing. By the prerequisite rules, only B (needs A), C (needs A) and N (none) may be asked. D needs C clear, E needs C and D, F-L, M, O need E or C and E.
PASS if every question in the next round (the AskUserQuestion call in the trace) is about users/stakeholders (B), the outcome and its measurement (C) or the meaning of terms (N), and none is about alternatives (do nothing, fix the process, buy, build), scope or journeys, AI fit, data, integrations, performance needs, edge cases, risk, organizational change, cost, or completion criteria.
FAIL if any question belongs to a category whose prerequisites are not clear or deferred.
