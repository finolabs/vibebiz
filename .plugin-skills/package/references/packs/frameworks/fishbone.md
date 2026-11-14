---
id: fishbone
name: Fishbone (Ishikawa diagram)
lens: problem-framing
fills: [A]
core: true
diagram_type: none
origin: Kaoru Ishikawa
---

# Fishbone (Ishikawa diagram)

## When to use
- An operational problem has many possible causes and the user's first answer is only one of them (stockouts, high return rate, slow fitting-room turnover, long checkout queues).
- Several people in the business disagree about the cause.
- Use it to list candidate causes by group before choosing which to dig into.

## When not to use
- One clear chain of events explains the problem: use `five-whys`.
- The problem is about customer or staff motivation: use `jobs-to-be-done`.
- There is no real problem yet, only an idea for something new.

## Inputs
- A one-sentence problem ("tỷ lệ trả hàng 22%"), ideally with a number and a period.
- The people involved in the process, to know which groups to cover.

## Questions
Group causes under a few headings that fit the business: people, process, product and stock, systems and tools, customers, suppliers and logistics. Use the user's words for the headings.
1. "Khi hàng bị trả lại, nhân viên thường nghe khách nói lý do gì nhiều nhất?" (open question, a real recent example)
2. Ask which groups have causes the user has actually seen: a multi-select with the groups as options.
3. For each chosen group: "Trong nhóm này, điều nào đã xảy ra trong tháng vừa rồi?"
4. "Nguyên nhân nào trong số này, nếu sửa được, sẽ giảm vấn đề nhiều nhất?" Offer the top candidates; recommend the one with the most evidence.
Then hand the chosen cause to `five-whys` if one more level is needed.

## Writes to
- The problem section of the spec: the candidate causes and the chosen one.
- Assumptions: causes believed but not yet checked.
- Open questions: causes nobody can confirm.

## Common misuse
- Listing causes without checking any against data, then treating the longest branch as the main cause.
- Filling every group out of habit; an empty group is a valid result.
- Mixing symptoms and causes in the same branch.
- Mistaking a cause for a solution ("thiếu nhân viên" is a cause only if it explains the case).

## Fashion example (fictional)
Chuỗi Lụa Xanh sees a 22% return rate online. Groups: product (size charts differ between suppliers), process (no fit check before shipping), customers (ordering two sizes on purpose), systems (photos do not show real colour), logistics (late delivery cancels the need). Checking two months of return reasons shows 60% mention fit. The chosen cause is size-chart inconsistency, so the idea moves from "chatbot for returns" to "size guidance".
