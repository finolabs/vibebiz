---
id: value-chain
name: Porter value chain
lens: problem-framing
fills: [A, B]
core: false
diagram_type: none
origin: The value chain described by Michael Porter in Competitive Advantage (1985); primary and support activities, adapted here to a fashion retailer's own activities
needs: []
feeds:
  - to: sipoc
    passes: the activity the idea touches
  - to: five-forces
    passes: where margin is made
instead_of: []
revisit_when: [A]
---

# Porter value chain

Lays the company's activities out in order, from design and buying through making, storing, selling and after-sales, with the support work beside them (people, systems, purchasing). For each activity it asks where margin is made or lost and which team does the work, so an idea without a home finds the activity it should touch and the people who stand there.

## When to use

- The idea has no activity yet ("dùng AI để tăng biên lợi nhuận", "số hóa công ty"), and the question is where along the company's activities to put it.
- Margin or cost is the concern and nobody has compared the activities with each other.
- Several teams each propose their own project, and the board needs one view of all activities to choose among them (B: who works at each activity).

## When not to use

- The idea already sits in one named internal process with hand-offs (returns from stores to the warehouse, replenishment): map that process at scope with `sipoc`.
- The activity is known and the question is why one figure moved: split the figure with `issue-tree`.
- One recurring defect with a recent case: use `five-whys`.

## Inputs

- The company's activities as the user names them, in order; the fashion pack's terms where the user has none.
- Any figure the files or the user give per activity (cost, margin, delay, return rate), with source and period.
- The team or partner that does each activity.

## Questions

One round at most. Offer the activities already named as options.

1. "Từ lúc thiết kế đến lúc khách nhận hàng và đổi trả, công ty mình đi qua những khâu nào? Ví dụ: thiết kế, mua vải, gia công, kho, bán tại cửa hàng, bán online, chăm sóc sau bán."
2. "Ở khâu nào anh/chị thấy tiền hoặc biên lợi nhuận bị hao nhiều nhất, và dựa vào báo cáo nào?" (a fact to look up first; a hunch stays an assumption)
3. "Khâu nào làm khách chọn mình thay vì nơi khác?"
4. "Mỗi khâu do bộ phận hay đối tác nào làm, và ai quyết định ở khâu đó?" (fills B)

## Writes to

- Problem & Why (A): the activity the idea should touch, with the evidence for choosing it; activities without evidence stay checks.
- Users and stakeholders (B): the team, partner and decision-maker at the chosen activity.
- Assumptions and Open questions: an activity picked by belief, and each figure still missing, with who can give it.
- Diagram brief: none. Show the chain as a table with the columns Activity, Who does it, Margin made or lost, Evidence.

## Common misuse

- Listing every activity in detail; the chain is for choosing one, and the detail belongs to the process map of the chosen one.
- Ranking activities by opinion and writing the ranking as fact; without a figure it is an assumption.
- Leaving out support activities (systems, people, purchasing) when the idea is about them.
- Inventing cost or margin shares per activity. Record only what the user or the files give, with source and period.

## Fashion example (fictional)

The fictional brand "Mây Ngàn" wants AI "to raise margin" and has five proposals from five teams. The chain lists design, fabric buying, contract sewing, central warehouse, stores, online and returns. The finance report shows markdowns at the end of each season as the largest loss; the other activities have no figure yet. The idea moves to the activity "buying and allocation", with the buying team and the merchandising head as stakeholders; the claim that sewing delays also cost margin stays an assumption.
