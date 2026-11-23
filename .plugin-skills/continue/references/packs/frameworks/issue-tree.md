---
id: issue-tree
name: Issue tree (MECE)
lens: problem-framing
fills: [A]
core: false
diagram_type: tree
origin: Issue trees from management-consulting problem solving; the MECE rule (mutually exclusive, collectively exhaustive) is commonly credited to Barbara Minto's work on structured reasoning
needs: []
feeds:
  - to: driver-tree
    passes: the branch to move
instead_of: []
revisit_when: [A]
---

# Issue tree (MECE)

Splits one broad question about the business into smaller questions that do not overlap and together cover the whole, two or three levels deep, so the team checks the branches with evidence instead of guessing a cause. The branch the evidence points to becomes the problem statement.

## When to use

- The problem is a broad question about a figure or a result ("vì sao lợi nhuận kênh online giảm", "vì sao cửa hàng mới chưa hòa vốn"), and nobody knows yet which part of it moved.
- The figure splits by arithmetic or by clear non-overlapping groups: revenue minus costs, channel by channel, new versus returning customers.
- The user wants to know where to look first before naming a cause.

## When not to use

- One recurring defect with a recent real case, where one chain of causes explains it: use `five-whys`.
- An operational problem whose candidate causes come in kinds (people, process, stock, system) and must be listed before choosing: use `fishbone`.
- The idea has no activity yet and the question is where along the company's activities, from design to after-sales, to put it: use `value-chain`.

## Inputs

- The broad question in the user's words, with the figure, its period and its source.
- The figures for each branch the user or the files can give, with source and period; a branch without one becomes a check to run.

## Questions

Build the first level from the figure's own arithmetic or groups, then ask one round at most. Offer the branches as options.

1. "Câu hỏi lớn nhất cần trả lời là gì, nói trong một câu? Ví dụ: vì sao lợi nhuận kênh online quý 3 giảm dù doanh thu tăng."
2. "Con số đó tách được thành những phần nào không trùng nhau? Ví dụ: doanh thu, giá vốn, chi phí quảng cáo, phí giao hàng, chi phí đổi trả." (Offer the split as options; the user adds or removes parts.)
3. "Phần nào đã có số liệu so sánh giữa hai kỳ, lấy từ báo cáo nào?" (a fact to look up first; ask only if no file has it)
4. "Trong các phần đó, phần nào anh/chị nghĩ thay đổi nhiều nhất, và dựa vào đâu?"

Check the split with the user: each part counted once, and nothing in the figure left outside every part.

## Writes to

- Problem & Why (A): the broad question, the tree to two levels, and the branch the evidence points to as the problem statement.
- Open questions: each branch without a figure, as a check with who can run it.
- Assumptions: a branch picked by belief rather than by a figure, labelled as such.
- Diagram brief: a tree with the question at the top, the parts below, and the branch the evidence points to marked.

## Common misuse

- Branches that overlap ("chi phí marketing" and "chi phí quảng cáo"); the same money counted twice hides the real change.
- Stopping at the first level; the useful branch usually sits one level down.
- Writing a cause as a fact when no figure supports it; it stays a branch to check.
- Inventing a figure for a branch. Record only figures the user or the files give, with source and period.

## Fashion example (fictional)

The fictional chain "Gió Nam" sees online revenue up in Q3 2026 while online profit falls. The tree splits online profit into revenue, cost of goods, advertising, delivery fees and returns. The finance report gives figures for revenue, cost of goods and advertising; delivery and returns have none yet and become checks. The user believes free delivery promotions drove the fall; that stays an assumption until the delivery figure arrives.
