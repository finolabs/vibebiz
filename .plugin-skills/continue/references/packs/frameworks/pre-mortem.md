---
id: pre-mortem
name: Pre-mortem
lens: challenge
fills: [K]
core: true
diagram_type: quadrant
origin: Gary Klein
---

# Pre-mortem

## When to use
- The idea is shaped enough to name a first release and the user is confident.
- A rollout depends on stores, staff or customers behaving in a new way.
- Risk and compliance are still open and the user lists only technical risks.

## When not to use
- The idea is still vague; shape the problem and outcome first.
- You need to compare the whole company's position: use `swot`.
- The user wants a single belief to test: use `assumption-map`.

## Inputs
- The proposed solution and first release in plain words.
- The outcome, target and time frame already recorded.

## Questions
Ask as if the failure has happened, never as a hypothetical "what could go wrong".
1. "Hãy tưởng tượng 6 tháng sau, ý tưởng này thất bại. Lý do nhiều khả năng nhất là gì?" (open question; record the answer as it is said)
2. Offer a few plausible failure reasons from the fashion pack as options if the user is stuck: "Nhân viên cửa hàng không dùng (Đề xuất)", "Khách không phản hồi", "Dữ liệu sai nên gợi ý sai", "Chi phí vượt dự kiến".
3. For each reason: "Khả năng xảy ra cao, vừa hay thấp, và nếu xảy ra thì thiệt hại lớn hay nhỏ?"
4. "Dấu hiệu sớm nào cho thấy việc này đang xảy ra?" and "Ai sẽ nhìn thấy dấu hiệu đó đầu tiên?"
5. For the top failure: "Cần làm gì trước khi bắt đầu để giảm khả năng này?"
Ask at least one failure reason every round. Record a dismissed risk with the user's reason.

## Writes to
- The cost and risk section: each failure reason with likelihood, impact, early sign and prevention.
- The risk and compliance category in the coverage file.
- Decisions, for dismissed risks. Kill criteria go to the outcome section.
- A diagram brief (quadrant, impact against likelihood) for the board risk slide.

## Common misuse
- Asking "what are the risks" instead of declaring the failure; people then list only polite risks.
- Collecting only technical risks and skipping store staff, customers and suppliers.
- Rating every risk "medium" to avoid a hard discussion.
- Treating the exercise as done without a prevention or early sign for the top risk.

## Fashion example (fictional)
Chuỗi Lụa Xanh plans restock reminders on a chat app in 8 pilot stores. Failure story, 6 months on: store staff never update customer phone numbers, so reminders reach only 20% of the list. Likelihood high, impact high. Early sign: fewer than 30% of new customers have a phone number after 4 weeks. Prevention: make the number a required step at checkout and review the figure weekly.
