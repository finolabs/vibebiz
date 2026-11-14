---
id: cynefin
name: Cynefin
lens: router
fills: []
core: true
diagram_type: none
origin: "Dave Snowden (Cognitive Edge, now The Cynefin Company); summarized for managers in D. J. Snowden and M. E. Boone, \"A Leader's Framework for Decision Making\", Harvard Business Review, November 2007. Described here in vibebiz's own words."
---

# Cynefin

Sort a situation by how well cause and effect can be known in advance, then match the way of working to it. vibebiz uses it as the router's depth rule: it decides how deep the interview goes, not which gap a question fills, so it fills no category (`fills` is empty) and never counts toward a lens's two cards.

The four kinds, in vibebiz's words:

- **Clear**: cause and effect are obvious to anyone who knows the business; the right fix is already known. Work: see what is happening, apply the known fix, check it worked.
- **Complicated**: there is a right answer, but finding it takes analysis or someone with expertise; several good answers may exist. Work: gather facts, analyze or ask an expert, then decide.
- **Complex**: the result depends on how people will react, so it can only be understood after trying; experts disagree and past data does not settle it. Work: run small, safe-to-fail tests, watch what happens, scale what works and stop what does not.
- **Chaotic**: something is breaking now and there is no time to analyze. Work: act to stop the damage first, then move the situation into one of the other kinds before planning anything new.

When it is unclear which kind applies, the situation is not yet understood; treat it as the deeper of the candidate kinds until the answers show otherwise.

## When to use

- Right after intake, before the first question round, for every idea.
- Again whenever an answer or a hand edit changes what the classification rests on: who will react, whether the fix is known, whether a crisis is under way.

## When not to use

- Not as a question to the user: a sales director should never be asked to pick a Cynefin domain or learn its names.
- Not to judge whether the idea is good. A clear idea can still be the wrong priority, and a complex one can be worth testing; the challenge lens judges merit.
- Not to label a whole business or department. Classify this one idea in its current situation; parts of a large idea can sit in different kinds, so classify by the part with the most uncertainty.
- Not to call an idea chaotic because the user is impatient or the deadline is close. Chaotic means harm happening now.

## Inputs

- The intake answer: the real, recent case the user described.
- The spec draft: Problem & Why, Outcome, Alternatives, AI-fit, as far as they are filled.
- The ground rules: approval limits and what always needs a person's sign-off (they show how costly a mistake would be).
- The latest round's answers and any hand edits.

## Questions

The router answers these for itself from the inputs above; none of them is put to the user.

1. Is something hurting the business right now that the user is busy containing? If yes: chaotic.
2. Does the business, or a common product, already have a fix that works for this exact situation, and is it cheap and easy to undo? If yes: clear.
3. Could someone with the right data or expertise work out the answer before building anything? If yes: complicated.
4. Does the result depend mainly on how customers or staff will behave, with no reliable way to know before trying? If yes: complex.
5. Did the latest answers change any of the above? If yes: reclassify and say so.

## Writes to

- `cynefin` in the idea's `coverage.md`: `clear`, `complicated`, `complex` or `chaotic`.
- The depth the router applies from then on: the shortest path for clear, full lenses for complicated, a pilot with kill criteria for complex, stabilize first and no packaging for chaotic.
- One plain sentence to the user, in their language, when the depth is first set or changes; never the framework's name.

## Common misuse

- Defaulting every idea to complicated so nothing changes. The point of the rule is that depth changes.
- Treating a complex idea as complicated because a vendor promises a result. A promise is not evidence of how the business's own customers will react.
- Treating a clear idea as complex to look thorough, which spends the user's patience on questions that change nothing.
- Classifying once and never revisiting after answers change.
- Planning a large rollout for a complex idea instead of a small test with a stop rule.

## Fashion example (fictional)

A fictional chain, Mây Fashion, has 30 stores and an online shop.

- **Clear**: the sales director wants the daily sales report to show sell-through by size. The data already exists and other teams already read reports like it; it is cheap and easy to undo. The router asks only what is missing and moves quickly toward packaging.
- **Complicated**: the director wants to choose a tool to reconcile cash-on-delivery payments from three delivery partners. Comparing tools and checking the data is analysis work; the router runs the full lenses.
- **Complex**: the director wants an AI size advisor on product pages to cut returns. Nobody knows whether shoppers will trust it; the router steers toward testing it on one product line online against a comparable line without it for six weeks, outside the year-end sale, with a stop rule written in advance.
- **Chaotic**: in the middle of the conversation the director says that, since this morning, stores cannot take card payments. The router says the payment problem needs handling first, records the idea as it stands and does not offer packaging until the situation is stable.
