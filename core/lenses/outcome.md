# Lens: outcome

Turn what the user wants to have into the result they want to change, and make that result measurable: a baseline (or a plan to measure it), a target, a time frame, at least one guardrail and a kill criterion. Then turn the outcome and the journeys into checks that prove each part is done. The board approves against these numbers and the tech team tests against them, so nothing here may be guessed. The router hands this lens its categories; the lens never chooses the frontier itself.

- **Used by**: router.
- **Fills**: C (outcome and measurement) and O (completion signals).
- **Reads**: the idea's `spec.md`, `coverage.md`, `decisions.md`, `assumptions.md` and `open-questions.md`; the workspace `constitution.md` (its `status`, `priorities`, `strategy_map` and `okrs`); the framework cards named in section 7.
- **Writes**: the `## Outcome` section, `### Measurable Outcomes` under Success Criteria, and the **Acceptance Scenarios** of each user story in `spec.md`; `coverage.md` (status, `frameworks` and `updated` of C and O); and, through the ask protocol, Clarifications, `decisions.md`, `assumptions.md` and `open-questions.md`.

Ask through `references/core/ask-protocol.md` and write everything the user reads by `references/core/writing-rules.md`.

## 1. What C and O need to be clear

**C. Outcome and measurement** (prerequisite A):

1. **Outcome statement**: a change in a measured result, not a thing to have (section 2).
2. **Driver tree**: the result the board watches, the driver the idea moves, and a leading indicator for each (section 3).
3. **Baseline**: today's value with source, period and label, or a measurement plan (section 4).
4. **Target**: the value to reach, from the user's decision.
5. **Time frame**: by when, as a date or a number of weeks or months.
6. **Guardrail**: at least one result that must not get worse (section 5).
7. **Kill criterion**: at least one measurable condition that stops the idea (section 5).
8. **Strategy link**: which recorded objective or scorecard perspective the outcome serves, when the ground rules record any (section 6). Not required when they record none.

**O. Completion signals** (prerequisites C and E): every user story in `spec.md` has acceptance scenarios a person can check, and every outcome in Measurable Outcomes can be checked with a named number and source (section 8).

A category is `clear` when every required item is answered, `partial` when some are, `missing` when none is.

## 2. From output to outcome

Users often name an output: a chatbot, an app, a dashboard, a reminder message. An output is only worth building if it changes a result, so rewrite it as one.

- Shape: **[which result] changes from [baseline] to [target] by [date], for [whom or where]**. Example: "có chatbot" becomes "giảm 30% số tin nhắn của khách phải chờ quá 15 phút, trong 3 tháng, trên cả 3 kênh bán online".
- Draft two or three outcome statements from the problem statement and the cost on file, and offer them in one single-select question with each draft in the option's `preview`. Recommend the one closest to the cost the problem causes today, and say so.
- Every quality word in the statement ("nhanh", "tốt hơn", "hiệu quả") becomes a number or an open question, by the writing rules' vague-term rule.
- The outcome must follow from the problem in `## Problem & Why`. If it would not reduce the cost recorded there, say so in plain words and ask which one the user wants to change.

## 3. Driver tree, leading and lagging indicators

Break the result the board cares about into the drivers that produce it, and find the one the idea really moves.

- **Lagging indicator**: the result itself, seen late (monthly revenue, returning customers per quarter).
- **Leading indicator**: an early signal the idea moves directly and that can be read every week (share of reminder messages opened, replies within 15 minutes).
- Common retail trees: store revenue = footfall × conversion × units per transaction × average selling price; online revenue = traffic × conversion × average order value. Use the user's own words for each driver and explain a term at first use.
- Ask which driver the idea is meant to move when the files do not make it clear; recommend the one closest to the root cause on file.
- Write the tree in `## Outcome` as an indented list, the lagging result at the top, each driver below it, the driver the idea moves marked, and its leading indicator beside it. A diagram is drawn from this list at packaging; do not draw one here.

## 4. Baseline, or a measurement plan

Look today's value up first: the idea's files, `constitution.md`, other ideas in the workspace, documents the user connected. When found, write it with its source, period and `measured` label, and ask only for the target.

When no baseline exists and nobody present knows it, **do not supply a number**. Write a measurement plan in `## Outcome` instead:

- **What**: the indicator and exactly how it is counted ("số tin nhắn có lần trả lời đầu tiên sau hơn 15 phút, chia cho tổng số tin nhắn").
- **Where**: the report, system or tally the number comes from, and who owns it.
- **For how long**: the period to measure, long enough to be fair and clear of unusual weeks (a big sale, a holiday, a season change), and the date it starts.
- **Who**: the person or team who will collect it; add an open question with them as owner and C as its category.
- **Then**: the target is set from the measured value. When the user chooses a relative target now ("giảm 30% so với mức đo được"), record that decision; the absolute number follows the measurement.

The baseline item of C counts as answered by a complete measurement plan. Label the plan "not yet measured" in the idea's language wherever the baseline would appear.

## 5. Target, time frame, guardrails, kill criteria

- **Target and time frame.** Offer two to four targets or ranges built from the baseline, the user's own figures or common retail practice, each figure labelled as an estimate; let the free-text box take an exact value. Recommend the one that is reachable within the time frame and still worth the cost; do not recommend an ambitious target because the user hopes for it.
- **Guardrails.** At least one result that must not get worse while the outcome improves: gross margin when discounts are involved, return rate, unsubscribes or complaints when customers get more messages, staff hours, stock cover. Recommend the one most at risk from this idea's mechanism. Write it with its current value or a measurement plan, and the limit ("tỷ lệ khách hủy nhận tin không vượt 2% mỗi tháng").
- **Kill criteria.** At least one measurable condition with a date that stops or rethinks the idea: "Sau 8 tuần thử ở 3 cửa hàng, nếu tỷ lệ khách quay lại không tăng ít nhất 2 điểm phần trăm so với các cửa hàng không thử, thì dừng." It names the indicator, the threshold, the comparison and the date. A guardrail broken beyond its limit is also a kill criterion; say so when it applies.
- Every figure carries its source, period and measured or assumed label, by `references/core/writing-rules.md`.

## 6. Link to the organization's objectives

Read `constitution.md`. When its `status` is `deferred` or it records neither `okrs` nor `strategy_map`, skip this section and write nothing about it.

- **OKRs recorded** (`okrs`): find the objective and key result this outcome moves. When one clearly fits, write the link in `## Outcome` naming the objective and key result in the user's words. When two or more could fit, ask which one, recommending the closest. When none fits, ask through a tool question whether to go on: keep the idea as it is (with a note that it serves no recorded objective this year), or change the outcome to serve a named objective. Recommend from the facts: an idea outside every objective competes for budget with ones inside them. Record the answer as an `answer` decision. Conflicts with the ground rules are flagged later by the plan module; do not write a `ground-rule-conflict` here.
- **Scorecard recorded** (`strategy_map`): name the perspective the outcome moves (financial, customer, internal process, learning and growth) and the recorded objective under it, using the `balanced-scorecard` card's approach (section 7). Ask only when more than one perspective could fit.
- Mapping to OKRs uses no card; mapping to the scorecard counts as applying `balanced-scorecard`.

## 7. Framework cards

Use a card only to fill an open gap in C or O that the card's `fills` lists, and apply at most two cards in this lens per idea, counting every card already recorded in the `frameworks` lists of C and O. Read a card from `references/packs/frameworks/<id>.md` and ask its questions in plain words; never make the user learn the framework's name or vocabulary.

| Card id | Use it when |
|---|---|
| `driver-tree` | C lacks the driver the idea moves or its leading indicator |
| `balanced-scorecard` | the ground rules record a `strategy_map` and C lacks its strategy link, or the user asks to tie the idea to the company's strategy perspectives |

- When the user asks for a framework by name, apply it if it fills an open gap here and the two-card limit allows; otherwise say in one plain sentence why it does not fit now and name the card that fits the open gap.
- Record each applied card's id in the `frameworks` list of the category it filled, and name the framework once in the section it shaped (for example "Cây chỉ số (driver tree): doanh thu online = lượt truy cập × tỷ lệ mua × giá trị đơn trung bình").
- If a card file is missing, use the technique as this lens describes it and record nothing in `frameworks`.

## 8. Completion signals

O enters the frontier only when C is settled and the solution-sketch lens has written the user stories (E).

- **Measurable Outcomes.** Write each measurable part of the outcome and each guardrail as an `SC-###` line under `### Measurable Outcomes`, replacing the template's placeholder lines and using the next free number: the indicator, the target, the date, and the source it is read from. Keep them free of technology ("Khách nhận câu trả lời đầu tiên trong 15 phút với 90% tin nhắn", not "API trả lời trong 2 giây"). The same numbers appear in `## Outcome` and in SC lines; they never differ.
- **Acceptance Scenarios.** For each user story, draft one to three scenarios in the form **Given** [the situation], **When** [what someone does], **Then** [what a person can see or count], in the idea's language with the English keywords kept bold, as the template has them. Each `Then` is checkable by someone who is not technical. Offer the drafts for the highest-priority story as previews in one single-select question, so the user confirms what "done" means; write drafts for the others from settled answers, and ask only where two readings would change the test.
- A scenario or SC that still holds a vague word or an unknown number is not clear; it becomes a follow-up question or an open question.

## 9. Writing the round's questions for the router

The router tells you which of C and O are in the round and how many question slots you have.

1. Re-read the files listed under **Reads**, list the items of section 1 or section 8 still missing, and drop every one the files or connected documents already answer.
2. For each remaining item, draft a candidate: a tool question that follows the ask protocol's rules for tool questions (self-contained, short header, two to four exclusive options, recommended first with its marker and reason, no escape options, ranges for numbers, previews for draft statements and scenarios), or the round's single open question in plain text when no sensible options exist.
3. Rank the candidates by impact × uncertainty and return the top ones within your slots, highest first. Hold any question that depends on an answer not yet given: the target before the outcome statement and the baseline (or the plan) are settled, the kill criterion before the target, acceptance scenarios before the stories exist.
4. Hand the questions to the router; the router asks the round.

Example round (C, fictional chain "Áo Mây", no baseline on file): one preview question choosing between three outcome statements, one question on the time frame ("Bạn muốn thấy kết quả của việc trả lời khách nhanh hơn về cỡ trong bao lâu?", options "3 tháng (Đề xuất)", "6 tháng", "Hết mùa Tết"), and one question on the guardrail most at risk.

## 10. After the answers

Apply each answer to `spec.md`, replacing the template placeholder or the earlier ambiguous text it settles. Keep every heading; do not add headings. In `## Outcome`, use short bold labels in the idea's language, in this order, and write "not yet clarified" (in the idea's language) for an item with no answer:

- Kết quả cần đạt (the outcome statement)
- Cây chỉ số (the driver tree, leading and lagging indicators)
- Mức hiện tại (the baseline with source, period and label, or the measurement plan)
- Mục tiêu và thời hạn
- Giới hạn an toàn (guardrails)
- Điều kiện dừng (kill criteria)
- Phục vụ mục tiêu nào của công ty (only when the ground rules record objectives)

In English: Outcome; Driver tree; Baseline; Target and time frame; Guardrails; Kill criteria; Company objective served.

Then set the status of C and O by section 1, record applied cards in `frameworks`, set each touched category's `updated` to today, and let the ask protocol finish the write-back. A skipped question changes nothing. Return to the router with the categories whose status changed.
