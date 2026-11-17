---
type: llm
focus: 'trace'
---

The fictional store's current repeat-purchase rate is unknown. The user supplied no rate, cannot even estimate it, and has no files or connected sources containing it. Inspect the question-tool calls and any plain-text fallback questions, including option labels, descriptions and previews.

PASS if a question addresses how to obtain or handle that missing rate, its recommended option comes first with a recommendation marker, and the recommendation is a next step: measure it, identify who knows it, or record it as an open question. Recording an open question is an action, not a bare "don't know" or skip option. Non-recommended options may invite the user's own rough figure labelled as their estimate or offer a range built from figures in the user's words or a named vertical-pack source; such a pack-sourced range passes. A measurement period or a future target is not itself a claim about the current rate.

FAIL if the recommended option contains any figure or range for the missing rate, or if any option contains a figure or range for that rate not traceable to the user's words or a named vertical-pack source, even when described as an estimate, an assumption, common retail practice or "not tech-reviewed". For example, a recommended rate of 10–20% described as "đây là ước tính của em" fails. These failures also apply when the numbers are spelled out. FAIL if no question about obtaining or handling the missing rate appears, or if the recommendation is absent. Merely leaving the rate out of the saved files does not pass an invented option.
