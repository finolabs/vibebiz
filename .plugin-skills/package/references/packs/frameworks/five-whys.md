---
id: five-whys
name: 5 Whys
lens: problem-framing
fills: [A]
core: true
diagram_type: none
origin: Sakichi Toyoda, developed in the Toyota Production System
---

# 5 Whys

## When to use
- The user states a symptom ("doanh số giảm", "khách phàn nàn nhiều") and the cause is still open in the problem category.
- One chain of events explains the problem, and the user can point to a recent real case.
- The user jumps to a solution ("cần một chatbot") and you need to know what it would fix.

## When not to use
- Several independent causes feed the problem at once (stockouts, returns, slow fitting rooms): use `fishbone`.
- The user cannot name any recent case: ask for the most recent occurrence first, then come back.
- The question is about what customers or staff want to achieve rather than why something broke: use `jobs-to-be-done`.

## Inputs
- One concrete, recent occurrence of the problem (date, store or channel, what happened).
- Any figures already on file for that occurrence (sales, stock, complaints).

## Questions
Start from the real case, then ask "why" about each answer in turn. Stop when the answer is something the business can change, or when the user does not know. Usually three to five steps; the count is not a rule.
1. Tell the most recent case in a few sentences. "Lần gần nhất doanh số một cửa hàng tụt bất thường là khi nào, chuyện gì đã xảy ra?" (open question)
2. Why did that happen? Offer the user's own earlier hints as options, for example "Hết size bán chạy (Đề xuất)", "Hàng về trễ", "Nhân viên thiếu".
3. Why did that cause it? Repeat with the chosen answer written into the question.
4. Check the chain backwards: "Nếu sửa nguyên nhân cuối cùng, vấn đề lần đó có biến mất không?"
Ask for evidence at each step: a number, a report or a person who saw it.

## Writes to
- The problem section of the spec (root cause) and the problem category in the coverage file.
- The decisions file when the user picks between two plausible causes.
- Assumptions, for any step the user believes but has not seen evidence for.
- The one-sentence problem statement, rewritten from the root cause.

## Common misuse
- Stopping at the first answer, which is usually a symptom.
- Forcing exactly five steps, or accepting "nhân viên chưa cố gắng" as a cause instead of asking what made the task hard.
- Following only one branch when two causes are real; record the second as a separate chain.
- Inventing a "why" the user did not say. Mark unanswered steps as not yet clarified.

## Fashion example (fictional)
Chuỗi Lụa Xanh (fictional, 12 stores) sees sales fall 15% in the last week of October at one store. Why? Weekend shoppers left without buying. Why? The best-selling blazer was out of sizes M and L. Why? The store received only S and XL from the last shipment. Why? Allocation followed last year's average by store, not this season's size sales. Why? Nobody reviews size-level sales before allocating. The root cause is a missing weekly size review, not weak demand, so a "demand forecasting" idea is reframed as "size-level allocation check".
