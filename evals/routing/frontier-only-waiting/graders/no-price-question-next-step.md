---
type: llm
focus: 'trace'
---

The workspace has a fixed coverage record: A, B, C, E and N are clear; F, G, H, I, J, K, L and O are deferred by the user; M (cost) is partial with a small size recorded and the monthly fee waiting on Q-001; D (alternatives) is partial only because the software's monthly price is an open question (Q-001) owned by the software supplier, who is not in the conversation. Nothing else can be asked.
PASS if the run puts no question to the user that asks for, or asks them to estimate, the software price or Q-001's answer (through AskUserQuestion or as text), and it treats the idea as ready to package because missing information alone never holds an idea back: it offers to package (or says the idea is ready to package) and says the software price stays an open question for the supplier that will show as not yet clarified and can be filled in later through continue.
FAIL if the run asks the user for the price, invents or estimates a price, asks about any category that is already clear or deferred, recommends pausing until the supplier answers instead of offering to package, or says the idea cannot be packaged until the price arrives.
