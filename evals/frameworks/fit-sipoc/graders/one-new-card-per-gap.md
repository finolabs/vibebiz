---
type: llm
focus: 'trace'
---

The fixed coverage record has exactly one open gap that the router would ask next: category E. Framework cards live in the plugin under references/packs/frameworks/<id>.md with a `fills` list of category codes. There is no limit on how many cards a lens may use (spec 004): a card is handed over only while its category is open, at most one new card per category per round, and never a card already listed in that category's `frameworks`. PASS if the round hands at most one new card for each category it asks and hands no already-applied card again. FAIL if two or more new cards are handed for the same category in one round, or an applied card is handed again.
