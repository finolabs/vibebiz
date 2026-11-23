---
id: kano
name: Kano model
lens: solution-sketch
fills: [E]
core: false
diagram_type: quadrant
origin: Noriaki Kano and colleagues, "Attractive quality and must-be quality" (1984)
needs: []
feeds:
  - to: moscow
    passes: the must-haves
instead_of: []
revisit_when: [E]
---

# Kano model

Customers do not value every feature the same way. Some they take for granted and only notice when missing; some please them more the better they work; some delight them because nobody expected them; some they ignore. Sorting a feature list this way shows what the first release cannot ship without and what can wait.

## When to use

- The idea is a customer-facing product or service with a list of candidate features already tied to customer pains.
- Scope (E) is open, and the question is which features the first release must carry, which add value step by step, and which would surprise.

## When not to use

- The features are not yet tied to the customer's job, pains and gains: use `value-proposition-canvas` first; it can feed this card.
- The question is what to cut to meet a fixed date or budget, with the customers' view already known: `moscow` fits better, and this card's must-haves feed it.
- The idea is an internal process with no customer choosing features.

## Inputs

- The candidate features and the pain each one addresses.
- Any customer evidence the user has: surveys, reviews, complaints, store staff feedback.

## Questions

Ask about customers' reactions the user has seen or heard, never the team's taste. Plain words, one round at most.

1. "Tính năng nào mà nếu thiếu, khách sẽ phàn nàn ngay hoặc bỏ đi, dù có nó thì họ cũng chẳng khen?" (Offer the features as options, multi-select.)
2. "Tính năng nào làm càng tốt thì khách càng hài lòng, ví dụ càng nhanh càng thích?" (Same options.)
3. "Tính năng nào khách không đòi, nhưng nếu có sẽ bất ngờ thích thú và kể cho người khác?" (Same options.)
4. "Tính năng nào khách gần như không để ý, có hay không cũng vậy?" (Same options.)
5. "Những nhận định trên dựa vào đâu: khảo sát, đánh giá của khách, phản hồi của nhân viên cửa hàng, hay cảm nhận của nhóm?"

## Writes to

- User Stories and Functional Requirements (E): taken-for-granted features first (the first release cannot ship without them), then the features that add value step by step, then at most one or two surprises.
- Out of scope (E): the features customers ignore, with that reason.
- Assumptions: every placement that rests on the team's view rather than customer evidence (question 5), marked unconfirmed.
- Diagram brief (quadrant): features placed by how customers react when the feature is missing and when it works well.

## Common misuse

- Placing features from the team's taste; placements without customer evidence are assumptions.
- Treating a surprise as permanent; today's surprise becomes tomorrow's expectation, so note when it was judged.
- Shipping surprises before the taken-for-granted features work.
- Inventing survey results or percentages. Record only figures the user gives, with their source.

## Fashion example (fictional)

The fictional chain "Lụa Xanh" lists seven features for its shopping app. From a survey of its customers: order tracking and one-tap payment are taken for granted (complaints when missing); faster delivery pleases more the faster it is; photo try-on surprises; points-for-gifts is mostly ignored. The first release carries tracking and one-tap payment, adds one surprise, and moves points-for-gifts out of scope.
