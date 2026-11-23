---
id: value-proposition-canvas
name: Value Proposition Canvas
lens: solution-sketch
fills: [E]
core: false
diagram_type: none
origin: Alexander Osterwalder, Yves Pigneur and others, "Value Proposition Design" (Strategyzer, 2014); the canvas is CC BY-SA, described here in vibebiz's own words
needs: []
feeds:
  - to: kano
    passes: the gain creators to classify
  - to: moscow
    passes: the pain relievers to keep
instead_of: []
revisit_when: [E]
---

# Value Proposition Canvas

A fit check between what an offer does and what a customer needs. One side holds the customer's job, pains and hoped-for gains; the other holds the features, what each one relieves and what each one creates. A feature that matches no pain or gain is a candidate to cut from the first release.

## When to use

- The idea is a customer-facing offer, feature set or service, and the list of candidate features is longer than the first release can hold.
- Scope (E) is open, and the features are not yet tied to the customer's job, pains and gains that the problem section records.

## When not to use

- The customer's job itself is still unclear (A or B is not clear): find the job first with `jobs-to-be-done`.
- Each feature is already tied to a pain, and the open question is how customers would react to each one (taken for granted, more is better, a pleasant surprise, or not cared about): use `kano`, which this card can feed.
- The idea is an internal process with no customer offer: another solution-sketch card fits.

## Inputs

- The customer group, their job, pains and gains from the problem section (A, B).
- The candidate features the user lists.

## Questions

Use the customer's own words from the files; ask only what they leave open. Plain words, one round at most.

1. "Với nhóm khách này, việc họ đang cố làm là gì, và điều gì làm họ khó chịu nhất khi làm việc đó?" (Skip when the files already say.)
2. "Nếu mọi thứ suôn sẻ, khách mong có thêm được điều gì?"
3. "Với mỗi tính năng trong danh sách, nó làm bớt nỗi khó chịu nào hoặc mang lại điều khách mong nào?" (Offer the features as options, multi-select, one pain or gain per question.)
4. "Nỗi khó chịu nào của khách chưa có tính năng nào giải quyết?"

## Writes to

- User Stories and Functional Requirements (E): the features that relieve a named pain or create a named gain, in the order of the pain's weight to the customer.
- Out of scope (E): the features that match no pain or gain, with that reason.
- Open questions: pains with no feature, and any pain the files do not support.
- Diagram brief: none. Show a two-column table, customer side (job, pains, gains) against offer side (features, pain relievers, gain creators), with lines matched row by row.

## Common misuse

- Writing pains the team imagines; use the customer's words from interviews or the user, and mark the rest as an assumption.
- Matching every feature to some pain to keep it in scope.
- Copying the canvas layout as a picture; the table is enough.
- Inventing usage or satisfaction figures. Record only figures the user gives, with their source.

## Fashion example (fictional)

The fictional chain "Mây Hồng" plans a members' app for office workers aged 25 to 35. Interviews say their job is a neat work outfit every morning without losing time; pains are trying on clothes at lunch, not knowing how to match pieces, and sizes running out. Of ten candidate features, "hold my size" and "outfit suggestions" each relieve a pain; points and new-arrival alerts match none. The first release keeps the two, and the other features move to out of scope with that reason.
