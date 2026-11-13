# Ask protocol

Rules for every question vibebiz puts to the user. Every module that asks follows this file; it decides nothing about *which* questions to ask (the router and the modules do that), only *how* a round is asked, recorded and stopped.

- **Used by**: router, clarify, specify, the four lenses, plan, package, constitution.
- **Reads**: `coverage.md` (category statuses, `budget_rounds_used`, `language`).
- **Writes**: `spec.md` (Clarifications and the sections the answers belong to), `decisions.md`, `open-questions.md`, `assumptions.md`, `glossary.md` when a term is settled, `coverage.md` (category statuses).
- **Fills**: nothing by itself.

Why these rules exist: the user is a sales director who is not technical and has little patience. A long, jargon-heavy or confusing round makes them abandon the idea, and an answer vibebiz invents misleads the board. Every rule below protects one of those two things.

## 1. Before asking: look facts up

- Ask the user only for **decisions** and for things only they know (their judgment, their priorities, what happened to them). Find **facts** yourself first: in the idea's files, in `constitution.md`, in the vertical pack, and in documents the user has connected to Cowork.
- When you found a fact, state it in the question as a fact with its source in plain words ("Theo báo cáo doanh số quý 3 trong Drive của anh/chị, …") and ask only for the decision it leads to.
- Never ask again what the idea's files already answer. Re-read the files before every round: the user may have edited them by hand, and their edits win.

## 2. What a round is

- A **round** is one set of questions asked together: the current frontier the router hands you, meaning only questions whose prerequisite categories (the router's frontier table) are `clear` or `deferred`. Never add a question whose answer depends on another question that is still open; hold it for a later round.
- A round has **one to four questions in total**: at most four tool questions sent in **one** `AskUserQuestion` call, plus at most one open question in plain text (section 5), and the total of both never exceeds four.
- Order the questions as the router ranked them (highest impact times uncertainty first).
- The intake question (`references/core/specify.md`), the ground-rules round (`constitution`), the format round (`package`) and the budget offer (section 8) are asked with these rules but are not counted against the question budget.

## 3. How to write a tool question

Each entry in the `AskUserQuestion` call's `questions` list follows all of these rules:

1. **Self-contained.** The `question` text is one full question ending with "?" that a person can answer without reading anything else: name the idea's subject in it ("ý tưởng nhắc khách quay lại mua"), never "như trên", "câu trước" or "phương án đã nói". Never use a category code (A–O), a requirement id (FR-###, SC-###, D-###), a file name, a path or a technical term the user has not been taught; follow `references/core/writing-rules.md`.
2. **Short header.** `header` is a two- or three-word topic tag of at most 12 characters ("Lý do", "Khách mục tiêu"). It labels the question; it never replaces it.
3. **Two to four options.** `options` has at least two and at most four entries. Each has a `label` of one to five words (not counting the recommendation marker) and a `description` of one sentence saying what choosing it means for the idea (cost, scope, who is affected). No two options may say the same thing in different words.
4. **Mutually exclusive.** With `multiSelect: false`, options must not overlap: choosing one must rule out the others. If they can be true together, either rewrite them so they exclude each other or use `multiSelect` (rule 6).
5. **Recommended option first and labelled.** Put the option you recommend first and end its `label` with the marker in the idea's language: `(Đề xuất)` in Vietnamese, `(Recommended)` in English, the natural equivalent in any other language. Exactly one option per question carries the marker. Start its `description` with the reason in half a sentence (the ground rules, the vertical pack, an earlier answer, or common retail practice). Recommend honestly: if the evidence favors none, recommend the option that is cheapest to reverse and say so.
6. **`multiSelect` only when options are not exclusive** (for example "which channels do you use today", where several can be true). The options must still be distinct and the recommended option still comes first with its marker. Never use `multiSelect` to dodge a choice the user must make between alternatives.
7. **Previews for drafts.** When the options are draft texts the user should compare (an outcome statement, a user story, a step-by-step flow, a slide message), put each draft in the option's `preview` field as short Markdown and keep the `label` a short name for it. Use previews only on single-select questions.
8. **Never add a "None", "Other", "Không có", "Khác", "Không biết" or "Bỏ qua" option**, in any language or wording. The tool already gives the user a Skip button and a free-text box; an extra escape option hides a real gap behind a fake answer.
9. **Ask for a decision, not a quiz.** Each question must change scope, cost, the success measure or the board's decision depending on the answer. If every answer leads to the same next step, do not ask it.
10. **Numbers in ranges.** When the decision is a number (a target, a time window, a budget), offer two to four ranges or values built from the vertical pack or the user's own figures, label any figure you supply as an estimate, and let the free-text box take an exact value.

## 4. Language

Write questions, options and previews in the idea's `language` (Vietnamese by default). Address the user in the form `references/core/writing-rules.md` sets for the idea; the Vietnamese examples here use its default, "anh/chị". Keep field names in the files in English, as the templates show.

## 5. Open questions in plain text

Some questions have no sensible options: "Lần gần nhất chuyện này xảy ra là khi nào, kể ngắn giúp em?", "Anh/chị gọi nhóm khách này là gì trong cửa hàng?". Ask these as a plain chat message, never through the tool and never with invented options.

- At most one open question per round, sent after the tool call has returned, and counted in the round's limit of four.
- Ask about something real that already happened, not a hypothetical.
- If the user does not reply to it and moves on, treat it as skipped.

## 6. Reading the answers

For each question the tool returns one of: an option, several options (`multiSelect`), the user's own text, or nothing (skipped).

- **Option chosen**: record the option's label without the recommendation marker, plus anything the user typed with it.
- **Own text**: record the user's words faithfully. If they match an option, record that option. If they are ambiguous or use an unquantified quality term from `references/core/writing-rules.md` ("nhanh", "thông minh", "real-time"…), record what is clear, do not write the vague part as a requirement, and put a follow-up question that asks for a measurable value into the next round, or record it as an open question (Q-###) if nobody present can answer.
- **Skipped**: the point stays unanswered. A skip is never an acceptance of the recommendation. The category's status stays exactly as it was (same `status`, same `updated` date) unless another answered question in the same round changes it.

## 7. Write back after every round

Before asking anything else, write the round to the idea's files, so a session abandoned at any moment loses nothing. Re-read each file just before writing it and append rather than rewrite records.

1. **Clarifications** in `spec.md`: under `## Clarifications`, use the heading `### Session YYYY-MM-DD` for today's date; create it if it is not there yet, reuse it if an earlier round today created it. Append one line per question in round order:
   - answered: `- Q: <the question as asked> → A: <the answer>`
   - skipped: `- Skipped: <the question as asked>`
   Never write a skipped question as an answer and never write the same question twice in one session.
2. **The right section of `spec.md`**: apply each answer where it belongs (the asking module says where; each module's "apply the answers" table lists the section for each of its categories). Replace the "not yet clarified" placeholder or the earlier ambiguous sentence the answer settles; leave no contradictory text behind. Keep every heading unchanged.
3. **`decisions.md`**: append one `## D-### — <short title>` entry of type `answer` for each answer that settles a choice, with `date`, `text`, `reason` (the user's reason, or the recommendation's reason when they accepted it). Facts the user reported (a story, a figure) go only to `spec.md`. A contradiction of an earlier decision is handled by the router, which records a `supersede` entry.
4. **`open-questions.md` and `assumptions.md`**: append a Q-### for every point the user said someone else must answer (fill `owner`, `unblocks`, `blocking`, `category`), and an A-### with `source: stated` for every assumption the user stated.
5. **`glossary.md`**: add or correct the term line when an answer settles what a word means.
6. **`coverage.md`**: for each category the round touched, set `status` from what the files now hold (`clear`, `partial`, `missing`; `deferred` only with a `reason`), set its `updated` to today, rebuild the human table and the "Clear: n of 15" line from the frontmatter, and set the idea's `updated`. Skipped questions change nothing (section 6). The router writes `next_step` and counts the round in `budget_rounds_used`; do not change those two fields here.
7. **Table of contents**: rebuild it as `references/core/workspace.md` says.

Then tell the user in one or two plain sentences what was recorded and what comes next. Do not show file names or paths.

## 8. Question budget

- The budget is **three counted rounds per session** by default (`budget_rounds_used` in `coverage.md`, reset to `0` when a session starts). The router counts the rounds and decides when the budget is reached; this section fixes how the offer is asked.
- When a round's write-back brings the count to the budget (or to its next multiple) and the idea is not ready, stop asking lens questions and offer, in one `AskUserQuestion` question with exactly these three choices in the idea's language:
  - continue with more questions now ("Hỏi tiếp"),
  - pause and keep everything saved for later ("Tạm dừng"),
  - export a draft with every gap labelled ("Xuất bản nháp").
  Recommend "Hỏi tiếp" when the frontier still holds a category scoring 6 or more on the router's impact × uncertainty ranking, otherwise "Tạm dừng". If the user skips this question, or nobody can answer, pause.
- On "Hỏi tiếp", grant another budget of the same size in this session; the counter keeps counting and the offer returns at the next multiple (after six rounds, then nine). On "Tạm dừng", say in one sentence where the idea stopped and that `/vibebiz:continue` resumes it. On "Xuất bản nháp", hand over to the `package` entry skill's draft path.

## 9. A round where everything was skipped

When the user skips every question in a round (tool questions and the open question):

- Write the round back anyway: each question as a `- Skipped:` line, no decisions, no status changes.
- Do not ask the same questions again in this session.
- Offer, in one `AskUserQuestion` question, to pause ("Tạm dừng", recommended) or to export a draft with the gaps labelled ("Xuất bản nháp"). If that is skipped too, pause.

## 10. Nobody to answer

When nobody can answer (an unattended or evaluation run, the question tool fails or is unavailable, or the user said to proceed without them):

- If the prompt already carries answers for these questions, use them exactly as the user's answers; that is not inventing.
- Otherwise never pick an option on the user's behalf and never write an invented answer as decided. For each question, proceed on the option you would recommend as an **assumption**: append an A-### to `assumptions.md` with `tested: no`, `evidence: none yet`, `source: no-answer-run`, and a Q-### to `open-questions.md` with `status: open` and the owner who must confirm it.
- Write the question in Clarifications as `- Skipped: <question>`, write the assumption into the spec's `## Assumptions` section marked as not confirmed with its A-### id, leave the category status unchanged, and add no D-### entry.
- Do not ask a question again in the same run once it is recorded as an assumption; stop at the budget as usual and end by listing the assumptions that need a person.

## 11. Worked example (Vietnamese)

Fictional idea: chuỗi thời trang "Áo Mây" (fictional) muốn "dùng AI nhắc khách cũ quay lại mua". Intake is done; categories A (problem) and N (terminology) have no prerequisites, so they form the first frontier. The router hands over two A questions, one N question and one open A question.

The `AskUserQuestion` call:

```json
{
  "questions": [
    {
      "header": "Lý do",
      "question": "Lý do chính khiến anh/chị muốn nhắc khách cũ quay lại mua ngay trong năm nay là gì?",
      "multiSelect": false,
      "options": [
        {"label": "Doanh thu khách cũ giảm (Đề xuất)", "description": "Hợp với điều anh/chị kể lúc đầu; mục tiêu sẽ đo bằng doanh thu từ khách đã từng mua."},
        {"label": "Tìm khách mới quá tốn", "description": "Mục tiêu sẽ đo bằng chi phí để có một đơn hàng, so giữa khách mới và khách cũ."},
        {"label": "Đối thủ đã làm", "description": "Cần xem đối thủ làm gì và kết quả ra sao trước khi đặt mục tiêu."}
      ]
    },
    {
      "header": "Dấu hiệu",
      "question": "Những dấu hiệu nào đang cho anh/chị thấy khách cũ của Áo Mây mua ít đi?",
      "multiSelect": true,
      "options": [
        {"label": "Ít khách mua lần hai (Đề xuất)", "description": "Dấu hiệu đo được ngay từ lịch sử mua hàng, nên dùng làm điểm xuất phát."},
        {"label": "Chỉ mua khi giảm giá", "description": "Gợi ý vấn đề nằm ở giá hoặc khuyến mãi, không chỉ ở việc nhắc."},
        {"label": "Cửa hàng phản ánh", "description": "Cần thêm số liệu để biết mức độ thật."}
      ]
    },
    {
      "header": "Định nghĩa",
      "question": "Với ý tưởng nhắc khách cũ, một khách được tính là \"quay lại\" khi mua lần nữa trong bao lâu kể từ lần mua trước?",
      "multiSelect": false,
      "options": [
        {"label": "Trong 60 ngày (Đề xuất)", "description": "Gần độ dài một đợt hàng thời trang; đây là ước tính, chưa đo trên số liệu của Áo Mây."},
        {"label": "Trong 30 ngày", "description": "Khắt khe hơn, hợp với hàng mua thường xuyên như đồ lót, tất."},
        {"label": "Trong 90 ngày", "description": "Dễ đạt hơn nhưng khó thấy tác dụng của việc nhắc."}
      ]
    }
  ]
}
```

Then the open question, in plain text: "Lần gần nhất anh/chị thấy rõ một nhóm khách quen không quay lại là khi nào? Kể ngắn chuyện đã xảy ra giúp em."

The user chooses "Doanh thu khách cũ giảm" and both "Ít khách mua lần hai" and "Chỉ mua khi giảm giá", skips the "quay lại" question, and answers the open question: "Sau đợt sale tháng 7, khách thẻ thành viên ở 3 cửa hàng gần như không quay lại tới tháng 9."

Write-back in `spec.md`:

```markdown
## Clarifications

### Session 2026-11-12

- Q: Lý do chính khiến anh/chị muốn nhắc khách cũ quay lại mua ngay trong năm nay là gì? → A: Doanh thu khách cũ giảm
- Q: Những dấu hiệu nào đang cho anh/chị thấy khách cũ của Áo Mây mua ít đi? → A: Ít khách mua lần hai; Chỉ mua khi giảm giá
- Skipped: Với ý tưởng nhắc khách cũ, một khách được tính là "quay lại" khi mua lần nữa trong bao lâu kể từ lần mua trước?
- Q: Lần gần nhất anh/chị thấy rõ một nhóm khách quen không quay lại là khi nào? Kể ngắn chuyện đã xảy ra giúp em. → A: Sau đợt sale tháng 7, khách thẻ thành viên ở 3 cửa hàng gần như không quay lại tới tháng 9.
```

The answers also go into `## Problem & Why` (why now, the signs, the most recent occurrence); `decisions.md` gets D-001 (lý do chính) and D-002 (dấu hiệu dùng để theo dõi). In `coverage.md`, A moves from `missing` to `partial` because of the three answered questions (frequency and current cost are still open). N stays `missing` with its old `updated` date, because its only question was skipped, and nothing is added to `glossary.md`. The router then counts the round and writes `next_step`, and the table of contents is rebuilt.
