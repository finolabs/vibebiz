---
type: llm
focus: 'trace'
---

The fixed coverage record: A clear, C clear, D deferred (reason recorded: the director will decide alternatives after the pilot budget is approved), B partial, E missing, N missing, all others missing. A deferred prerequisite counts as settled, so E (scope and behavior) is askable; F, G, I, J need E clear so they are not; H, K, L, M, O need E (and others) so they are not.
Ordering: impact (how much the answer changes scope, cost or the board decision, 1 to 3) times uncertainty (1 to 3). Scope and behavior (E) is high on both and must come before users (B) and terminology (N).
PASS if the round asked (the AskUserQuestion call in the trace) includes a question about scope/behavior (what the first version must do for the customer or staff) and it comes first, and no question is about AI fit, data sources, integrations, performance needs, edge cases, risk and compliance, organizational change, cost or completion criteria.
FAIL if scope is missing or not first, or any category whose prerequisites are unsettled is asked.
