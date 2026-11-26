---
type: llm
focus: 'trace'
---

The fixed coverage record has category A partial with two problem-framing cards already applied (five-whys and fishbone), and category B partial with no card; B waits for A, so A is the category the router asks next. Framework cards live in the plugin under references/packs/frameworks/<id>.md; jobs-to-be-done is a problem-framing card whose `fills` include A and B. There is no limit on how many cards a lens may use: a card is handed over only while its category is open and the card is not already applied there. PASS if the round hands jobs-to-be-done to the problem-framing lens for A or B (for example a reason for it is written under `framework_reasons` in coverage.md, or its questions about what shoppers or staff are trying to get done are asked) and nothing says a two-card limit stops a third card. FAIL if the assistant says two cards are the limit, or refuses a third card for that reason.
