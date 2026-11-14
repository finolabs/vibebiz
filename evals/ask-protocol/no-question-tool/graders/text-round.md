---
type: llm
focus: 'last_message'
---

The host has no question tool and the user is present. PASS if the final message asks the user a round of questions in plain Vietnamese text: one to four questions; each multiple-choice question lists its choices numbered (1., 2., …), at most four, with the recommended choice first and marked as recommended; no choice like "Khác", "Không có", "Other" or "None"; and it waits for the user's reply.
FAIL if it asks no question, asks more than four, gives choices without numbers, or treats the run as unattended (says nobody can answer, or records its own guesses in place of asking).
