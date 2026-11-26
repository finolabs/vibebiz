---
type: llm
focus: 'trace'
---

The workspace has a fixed coverage record: every category is clear except D (alternatives), which is partial only because the software's monthly price is an open question (Q-001) owned by the software supplier, who is not in the conversation. Nothing else can be asked.
PASS if the run puts no question to the user that asks for, or asks them to estimate, the software price or Q-001's answer (through AskUserQuestion or as text); an option in a budget offer that lets a user who already has the price give it is fine, and its final message tells the user that the idea is waiting for the supplier's price and what to do next (for example ask the supplier or the buying team, then continue).
FAIL if the run asks the user for the price, invents or estimates a price, re-asks a category that is already clear, or says the idea is ready to package.
