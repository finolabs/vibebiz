---
id: value-effort
name: Value-effort matrix
lens: plan
fills: [E]
core: false
diagram_type: quadrant
origin: Common product and operations practice, also called the impact-effort or action priority matrix; no single author
needs: []
feeds:
  - to: moscow
    passes: the quick wins and big bets
instead_of: [rice-ice]
revisit_when: [E, board-changes]
---

# Value-effort matrix

A quick way to sort a short list of candidate items on two rough axes: how much each helps the outcome, and how much work it takes. The four corners name what to do: quick wins (high value, low effort) go first, big bets (high value, high effort) get planned, fill-ins (low value, low effort) wait for spare time, and money pits (low value, high effort) are dropped. No counts are needed; the team places each item by agreement.

## When to use

- The scope (E) is a short list of candidate items (about ten or fewer) competing for one team's time in the next quarter.
- Nobody can count how many customers or staff each item reaches, or the counts would cost more than the decision is worth.
- The team wants to see at a glance what to do now and what to plan, rather than an exact order.

## When not to use

- The list is long (more than about ten items), the items reach very different numbers of people, and a report counts that reach: `rice-ice` fits better, because a score built on counts separates items the matrix would lump together.
- The question is what a first release with a fixed date or budget must hold to work at all: `moscow` fits better, because it sorts by necessity, not by value for effort.
- The outcome is not set (C is not clear): value has nothing to be judged against.

## Inputs

- The candidate items, in the user's own words, and who asked for each.
- The outcome and its baseline from the outcome lens; value is judged against it.
- The team that does the work and its rough sense of effort per item.

## Questions

Ask about the items already listed, one round at most; never ask the user to draw or fill a grid.

1. "Trong danh sách này, việc nào giúp nhiều nhất cho mục tiêu đã đặt, việc nào giúp ít?"
2. "Đội làm thấy việc nào làm xong trong vài ngày, việc nào phải mất nhiều tuần?"
3. "Có việc nào tốn công nhiều mà giúp ít, nên bỏ hẳn không?"

Effort is the doing team's rough view, labelled "not tech-reviewed". When nobody present can say how much an item helps, record it as an assumption to check, not a guess (ask protocol rules 5 and 10).

## Writes to

- Scope and behavior (E): each item with its value (high or low), its effort (high or low), its corner, and the resulting order: quick wins in this quarter, big bets planned with a date, fill-ins later, money pits out of scope.
- Assumptions: each value placement that rests on a feeling rather than a measure.
- Diagram brief: `quadrant`, value on the vertical axis and effort on the horizontal, one dot per item labelled in the user's words.

## Common misuse

- Placing every item in the quick-win corner; push the team to name at least one big bet and one item to drop.
- Letting the person who wants an item judge its effort instead of the team that does it.
- Using the matrix on a long list with reach data, where it hides real differences between items.
- Reading a corner as a commitment; it is an order for the next quarter, revisited when the board asks for changes.

## Fashion example (fictional)

The fictional menswear chain "Gió Nam" has seven store ideas and a three-person operations team for the first quarter. Efforts are the team's rough estimates, "not tech-reviewed".

| Item | Value for the fitting-room conversion goal | Effort | Corner |
|---|---|---|---|
| New size chart in fitting rooms | High | Low (days) | Quick win |
| Extra hooks in fitting rooms | Low | Low (days) | Fill-in |
| Text when a size is back in stock | High | High (weeks) | Big bet |
| New lighting in the coat area | Low | High (weeks) | Money pit |

The size chart goes first; the back-in-stock text is planned for the second quarter; the lighting is dropped.
