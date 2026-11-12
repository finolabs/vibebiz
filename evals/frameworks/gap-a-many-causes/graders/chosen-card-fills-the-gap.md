---
type: llm
focus: 'trace'
---

The fixed coverage record has exactly one open gap that the router would ask next: category A. Framework cards live in the plugin under references/packs/frameworks/<id>.md with a `fills` list of category codes. PASS if the assistant read or applied at least one framework card whose frontmatter `fills` includes A (expected candidates: fishbone, five-whys; any other card passes only if its own `fills` includes A), and its questions follow that card. FAIL if it applied a card whose `fills` does not include the gap, or applied no card when one fits.
