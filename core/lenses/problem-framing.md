# Lens: problem-framing

Find the real problem behind the idea before anyone talks about a solution: who suffers, in which situation, how often, what it costs today, what causes it and why it matters now, and who will use, feel, approve or resist the change. The output is a one-sentence problem statement the user recognizes as theirs. The router hands this lens its categories; the lens never chooses the frontier itself.

- **Used by**: router.
- **Fills**: A (problem and why) and B (users and stakeholders).
- **Reads**: the idea's `spec.md`, `coverage.md`, `decisions.md`, `assumptions.md`, `open-questions.md` and `glossary.md`; the workspace `constitution.md` (its `vertical`, `mandatory_approvals` and `approval_ceiling`); the fashion pack in `references/packs/retail-fashion/` when the idea's `vertical` is fashion; the framework cards named in section 6.
- **Writes**: the `## Problem & Why` section of `spec.md`; `coverage.md` (status, `frameworks` and `updated` of A and B); and, through the ask protocol, Clarifications, `decisions.md`, `assumptions.md` and `open-questions.md`.

Ask through `references/core/ask-protocol.md` and write everything the user reads by `references/core/writing-rules.md`.

## 1. What A and B need to be clear

**A. Problem and why** (no prerequisite):

1. **Who suffers**: the customers, staff or teams who feel the problem, in the user's words.
2. **The situation**: the most recent real occurrence: what happened, where (which store, channel or team), when.
3. **Frequency**: how often it happens, as a number per day, week, month or season.
4. **Current cost**: what it costs today in time, money or lost sales (section 4), or a plan to measure it.
5. **Root cause**: the cause separated from the symptom (section 3).
6. **Why now**: what makes it worth deciding this year rather than later.
7. **Problem statement**: one sentence the user has confirmed (section 5).

**B. Users and stakeholders** (prerequisite A):

1. **Who uses it**: the people who will work with the change every day.
2. **Who is affected**: people whose work, pay or customers change without using it themselves.
3. **Who approves**: the person or body who decides; check the ground rules' approval ceiling and mandatory approvals first.
4. **Who may resist**: people who lose time, authority, income or habits, and why.

A is `clear` when all seven items are answered; B is `clear` when all four are. Otherwise `partial` when any item is answered, `missing` when none is.

## 2. Start from what really happened

Ask about the most recent real occurrence, never a hypothetical. People describe what usually happens or what might happen in a way that hides the cost and the cause; a real event has a date, a place and a number.

- If the intake answer already tells a real occurrence, use it and do not ask again.
- Otherwise the round's open question (plain text, at most one per round) asks for it. Example: "Lần gần nhất chuyện này xảy ra là khi nào? Bạn kể ngắn giúp mình: ở cửa hàng hay kênh nào, ai bị ảnh hưởng và mất những gì."
- If the user answers with a generality ("thường thì…", "khách hay…"), record what is useful and ask once more for one specific time.
- If the user describes a solution instead of a problem ("chúng tôi thiếu chatbot", "cần một ứng dụng"), record it as the user's proposed solution and ask what goes wrong today without it. The problem statement never contains the solution.

## 3. Root cause: 5 Whys, or a fishbone for many causes

Separate the symptom the user sees ("doanh số giảm") from a cause the business can act on ("thiếu cỡ M và L ở 6 cửa hàng sau tuần đầu mỗi đợt hàng").

- **One "why" per round.** Each step depends on the previous answer, so a round holds at most one step of the chain. Build the options from the user's story, the facts on file and, for fashion, the pack's diagnostic traps (for example missing sizes read as weak demand, a promotion's effect confused with the season or the weather, a shift between channels read as growth). Recommend the cause the evidence on file supports best and say which evidence.
- Stop when the cause is something the business can change, when the user cannot say why (record an open question with the person who can), or after five steps.
- When the user names several causes at once that all feed the same symptom (stockouts, slow fitting rooms, many returns), use the fishbone approach instead: group the causes by area (people, process, product, place, data, suppliers) and ask which group drives most of the problem.
- A cause the user believes but has no data for is an assumption: append it to `assumptions.md` with `source: stated`, `tested: no`, so the challenge lens can test it later. Write it in the spec as the user's judgment, not as a fact.

Example question for one step: "Doanh số áo khoác ở 6 cửa hàng giảm trong tháng 10. Theo bạn, lý do trực tiếp nhất là gì?" with options such as "Thiếu cỡ phổ biến (Đề xuất)" (the description cites the stock report on file), "Mẫu không hợp thời tiết", "Giá cao hơn đối thủ gần đó".

## 4. Current cost

State what the problem costs today in a figure the board can compare with the cost of a fix.

- Use the simplest formula that fits, and show it with its inputs:
  - time: hours lost per person per period × number of people × hourly wage;
  - lost orders: orders lost per period × average order value;
  - lost customers: customers lost per period × what one customer buys in a year.
- Look the inputs up first (the idea's files, `constitution.md`, other ideas in the workspace, documents the user connected). Ask only for what is missing, with ranges as options (ask protocol, numbers in ranges).
- Do the arithmetic yourself and write the result with each input's source and period, labelled measured or assumed. A figure the user estimates is `assumed`, with the source "ước tính của bạn" and the date. Never round a result into a different claim.
- When nobody can estimate it, do not supply a number. Write a short measurement plan instead (what to count, where the number comes from, for how long, who counts it) and add an open question with that person as owner. The cost item then counts as answered by the plan.

## 5. Jobs to be done and the problem statement

- **Jobs to be done.** For the customer and, when staff are involved, for store staff, find what they are trying to get done in that situation: "Khi [tình huống], [người đó] muốn [việc cần làm], để [kết quả họ cần]." Offer two or three candidate jobs as options built from the occurrence the user told, recommended first. The job describes their goal, not a feature.
- **Problem statement.** When who, situation, frequency, cost and cause are on file, draft two or three one-sentence statements and offer them in one single-select question with each draft in the option's `preview`. Shape: who suffers, what happens, how often, what it costs, because of what. No solution, no vague quality word. Example preview: "Khách mua online ở Hà Nội chờ trung bình 4 giờ mới được trả lời về cỡ (đo trong tuần 03–09/11), khoảng 120 đơn mỗi tháng bị bỏ dở, vì chỉ có 2 nhân viên trực tin nhắn cho cả 3 kênh." The statement is clear only when the user picks or edits one.

## 6. Framework cards

Use a card only to fill an open gap in A or B that the card's `fills` lists, and apply at most two cards in this lens per idea, counting every card already recorded in the `frameworks` lists of A and B. Read a card from `references/packs/frameworks/<id>.md` and ask its questions in plain words; never make the user learn the framework's name or vocabulary.

| Card id | Use it when |
|---|---|
| `five-whys` | the root cause is missing and one chain of causes is likely |
| `fishbone` | the root cause is missing and the user names several causes at once (use it instead of `five-whys`, not as well) |
| `jobs-to-be-done` | who suffers is known but what they are trying to get done is not, or B lacks what users and staff need |

- When the user asks for a framework by name, apply it if it fills an open gap here and the two-card limit allows; otherwise say in one plain sentence why it does not fit now and name the card that fits the open gap.
- Record each applied card's id in the `frameworks` list of the category it filled, and name the framework once in the section it shaped (for example "Phân tích nguyên nhân theo cách hỏi 5 lần Tại sao (5 Whys)").
- If a card file is missing, use the technique as this lens describes it and record nothing in `frameworks`.

## 7. Writing the round's questions for the router

The router tells you which of A and B are in the round and how many question slots you have. B is in the frontier only when A is `clear` or `deferred`, so a round rarely holds both.

1. Re-read the files listed under **Reads**, list the items of section 1 still missing, and drop every one the files or connected documents already answer.
2. For each remaining item, draft a candidate: a tool question that follows the ask protocol's rules for tool questions (self-contained, short header, two to four exclusive options, recommended first with its marker and reason, no escape options), or the round's single open question in plain text (the real occurrence, a story, a term the user uses).
3. Rank the candidates by impact × uncertainty and return the top ones within your slots, highest first. Hold any question that depends on an answer not yet given (the next "why", the problem statement before the cause is known, the cost before the frequency).
4. Hand the questions to the router; the router asks the round.

Example round (A, fictional chain "Áo Mây"): one tool question on frequency ("Trong một tháng bình thường, Áo Mây có khoảng bao nhiêu đơn online bị bỏ dở vì khách chờ trả lời về cỡ?", options as ranges built from the user's figures), one tool question on why now ("Vì sao bạn muốn giải quyết chuyện khách chờ trả lời về cỡ ngay trong năm nay?"), and the open question about the last real occurrence.

## 8. After the answers

Apply each answer to `## Problem & Why` in `spec.md`, replacing the template placeholder or the earlier ambiguous text the answer settles. Keep the heading; do not add headings. Use short bold labels in the idea's language, in this order, and write "not yet clarified" (in the idea's language) for an item with no answer:

- Vấn đề (the confirmed problem statement)
- Lần gần nhất xảy ra
- Ai bị ảnh hưởng và tần suất
- Chi phí hiện tại (each figure with source, period and label, or the measurement plan)
- Nguyên nhân gốc (the chain, marked as the user's judgment when untested)
- Việc khách và nhân viên cần làm được (jobs to be done, when applied)
- Vì sao làm bây giờ
- Người liên quan: ai dùng, ai bị ảnh hưởng, ai duyệt, ai có thể phản đối và vì sao

In English: Problem; Most recent occurrence; Who suffers and how often; Current cost; Root cause; Jobs to be done; Why now; Stakeholders: who uses it, who is affected, who approves, who may resist and why.

Then set the status of A and B by section 1, record applied cards in `frameworks`, set each touched category's `updated` to today, and let the ask protocol finish the write-back. A skipped question changes nothing. Return to the router with the categories whose status changed.
