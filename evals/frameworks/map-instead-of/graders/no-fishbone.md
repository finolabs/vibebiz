---
type: llm
focus: 'trace'
---

Category A is partial and already lists five-whys in its `frameworks`. Framework cards live in the plugin under references/packs/frameworks/<id>.md; five-whys and fishbone declare each other under `instead_of`, so only one of them is used for the same category. PASS if the round does not hand the fishbone card over for A (it may hand another fitting card, or none, and ask the lens's own questions). FAIL if fishbone is handed over for A or its cause-category questions are asked as a newly handed card.
