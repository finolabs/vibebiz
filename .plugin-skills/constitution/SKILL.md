---
name: constitution
description: "Record or update the organization's ground rules that vibebiz checks every idea against: this year's priorities, the budget the user approves alone, the retail business they are in, and the steps that always need a person to approve; optionally the company's strategy objectives and OKRs. Use when the user types /vibebiz:constitution or says, for example, 'set our ground rules', 'record our priorities', 'change my approval limit', 'add our OKRs', 'ghi luật chung', 'đặt luật chung cho công ty', 'đổi mức chi tôi tự duyệt', 'thêm OKR của công ty', 'ưu tiên năm nay của công ty là...'. Not for working on one idea (idea, continue), packaging (package) or questions about how to use vibebiz (help)."
---

# vibebiz: ground rules

Record the organization's ground rules in one short round, or update rules already recorded. vibebiz checks every idea against them when it challenges the idea and drafts its plan, and flags an idea that breaks one. The user is a non-technical retail leader: never show them file names, paths, field names or codes, never ask them to use a terminal, and speak in the language they write in (Vietnamese by default).

Load each module from this skill's own folder when its step starts, and follow it exactly:

- `references/core/workspace.md`: working folder, workspace states, scaffold, repair, table of contents.
- `references/core/writing-rules.md`: wording of everything the user reads, including how to address the user. The ground rules belong to no idea, so use the default address form unless the user's own messages in this session use another pair.
- `references/core/ask-protocol.md`: how every question is written and how answers are read.

The template is `references/templates/workspace/constitution.md`. Its frontmatter is the source of truth; the body below it is a human view rebuilt from the frontmatter.

## 1. Check where the workspace lives

Follow the workspace module's storage check (§1) before anything else: a local folder, or Google Drive when the session has none. In Drive mode follow §1a, which hands every file step to `references/core/drive-workspace.md`. With neither (for example in a claude.ai chat, or Cowork started on the web or a phone without Google Drive), read §1 of `references/core/workspace.md` and give its stop message word for word, then stop: write nothing, ask nothing.

## 2. Set up or repair the workspace

Ground rules can be recorded before the first idea, so this skill may meet any folder state. Apply the workspace module's states exactly as `idea` does: scaffold an empty folder; restore only the missing pieces of a partial workspace and name them in one plain sentence; change nothing in a complete one; for a folder with unrelated files, ask whether to use this folder or a new `vibebiz` subfolder, recommending the subfolder. Create no idea folder.

If a file named `constitution.md` exists but does not carry the workspace's marker (frontmatter with `status` `set` or `deferred`), it is the user's own file: do not touch it, tell the user in one sentence that a file of theirs already uses the name vibebiz needs for the ground rules, and stop.

## 3. Read what is recorded

Re-read `constitution.md` now; the user may have edited it by hand, and hand edits win. Note for each field whether it holds a value the user gave:

- `priorities`, `mandatory_approvals`: given when the list is not empty.
- `approval_ceiling`: given when `amount` is a number.
- `vertical`: given only when `status` is `set` (while deferred it holds the template's default, `fashion`, which nobody chose).
- `strategy_map`, `okrs`: given when present with at least one objective.

Then look facts up before asking (ask protocol, section 1): the user's message, documents they pointed to or attached, and the ideas already in `specs/` (their `vertical`, the business they describe). A priority list, an approval limit or company objectives the user already stated or attached are facts to propose, not questions to ask from scratch. Read only; send nothing anywhere.

Decide the mode:

- **First recording**: `status` is `deferred`. Ask the round in section 4.
- **Update**: `status` is `set`. When the user named what to change ("đổi mức tự duyệt thành 300 triệu"), ask only about that field, or nothing when their words already give the new value. When they did not say, ask the round in section 4 with each question showing the current value and keeping it as the recommended option.

## 4. The round: at most four questions

One round, at most four questions in total, asked under the ask protocol's rules: self-contained questions naming what the rule is for, a short header, two to four exclusive options with the recommended one first and marked, no "None" or "Other" option (the tool has Skip and a free-text box). The round is not counted against any idea's question budget. Send the tool questions in one question-tool call (split as the ask protocol says when the tool takes fewer) and the open question after it. Drop a question whose answer is already on file or in the user's message; ask only what is left.

1. **Business** (`vertical`), single select: two to four kinds of retail built from the user's words and the ideas on file, for example thời trang, điện máy và điện tử, đồ gia dụng, mỹ phẩm. Recommend the one their words point to, or fashion when nothing does, saying why in the description: vibebiz's question pack in this version is written for fashion, and other businesses get general retail questions. On update, the current value is the recommended option.
2. **Budget the user approves alone** (`approval_ceiling`), single select: two to four example amounts in the user's currency (Vietnamese đồng by default), each said to be an example and not a figure about their business; the free-text box takes their exact amount. Offer amounts rather than ranges, because a check needs one figure. With nothing to go on, recommend the lowest amount, because a low limit flags more ideas for someone above the user to approve, which is the safer mistake. On update, the current amount is the recommended option.
3. **Steps that always need a person** (`mandatory_approvals`), `multiSelect`: steps an automation or an AI could otherwise do alone, for example đổi giá bán, gửi tin cho khách, hoàn tiền cho khách, dùng dữ liệu cá nhân của khách. Put first, with the marker, the use of customers' personal data, because the personal-data protection law makes a person accountable for it. On update, the options are the current steps plus the most likely additions.
4. **This year's priorities** (`priorities`): the round's one open question, in plain text, because only the user knows them. Ask for two or three in their own words. On update, quote the current priorities and ask what changes.

Example in Vietnamese (first recording):

> "Doanh nghiệp của anh/chị bán nhóm hàng nào, để em hỏi các ý tưởng sau cho sát ngành?"
> - "Thời trang (Đề xuất)": "Anh/chị nhắc tới cửa hàng quần áo; bộ câu hỏi chuyên sâu của vibebiz hiện viết cho ngành thời trang."
> - "Điện máy, điện tử": "Câu hỏi dùng kiến thức bán lẻ chung, chưa có bộ câu hỏi riêng cho ngành này."
>
> "Khoản chi tối đa anh/chị được tự duyệt cho một dự án là bao nhiêu? Các mức dưới đây chỉ là ví dụ."
> - "50 triệu đồng (Đề xuất)": "Mức thấp an toàn hơn: ý tưởng vượt mức sẽ được ghi rõ là cần cấp trên duyệt."
> - "200 triệu đồng": "Ví dụ mức trung bình; anh/chị gõ con số đúng nếu khác."
> - "1 tỷ đồng": "Ví dụ mức cao."
>
> Open question: "Năm nay công ty ưu tiên hai, ba việc gì nhất? Anh/chị viết ngắn theo cách mọi người trong công ty vẫn gọi."

**Reading the answers.** Follow the ask protocol's section 6. Record a chosen option without the marker. A vertical chosen as fashion is written `fashion`; any other business is written in the user's words. An amount typed as text ("300 triệu") is written as the number with its currency code (`amount: 300000000`, `currency: VND`); when you cannot tell the amount or the currency for certain, do not write it, and say in one sentence what was unclear. A skipped question leaves its field exactly as it was.

## 5. Strategy map and OKRs (optional)

These are optional and never become questions of their own: the round stays at four questions.

- After the round, add one sentence offering them, for example: "Nếu công ty đã có mục tiêu chiến lược theo bốn góc nhìn (tài chính, khách hàng, quy trình nội bộ, học hỏi và phát triển) hoặc OKR năm nay, anh/chị dán vào đây hoặc chỉ em tài liệu, em ghi lại để đối chiếu với từng ý tưởng." Skip the sentence when they are already recorded and the user did not ask to change them.
- When the user gives them, in a message or a document they point to, write only what they wrote:
  - `strategy_map`: the balanced scorecard's four perspectives (`financial`, `customer`, `internal_process`, `learning_and_growth`), each with the list of objectives the user placed under it. Place an objective under a perspective only when the user or the document did; an objective without a perspective is a question for the user, not a guess. Omit a perspective with no objective.
  - `okrs`: one entry per objective, `{objective, key_results}`, with the key results exactly as given, figures and dates unchanged.
- Never draft objectives or key results for the user and never fill a perspective to make the map look complete. The balanced scorecard comes from Robert Kaplan and David Norton; OKRs from Andy Grove's practice at Intel, later spread by John Doerr. Name the method only if the user did.

## 6. Show the change and confirm before writing

Never overwrite a value the user gave earlier without their yes.

- **First recording** (every field was deferred or empty): no confirmation; go to section 7.
- **Update**: when at least one given value would change or be removed, show the changes as "before → after" lines in plain words, then ask one confirmation through the question tool with two options, "Lưu thay đổi" and "Giữ như cũ", neutral, with neither marked recommended, because the user is choosing between their own two values. On "Lưu thay đổi", write. On "Giữ như cũ" or Skip, write nothing, and say in one sentence that the rules are unchanged. Adding to an empty field needs no confirmation.

Example: "Mức chi anh/chị tự duyệt: 50 triệu đồng → 300 triệu đồng. Việc luôn cần người duyệt: thêm 'Hoàn tiền cho khách'."

## 7. Write `constitution.md`

Re-read the file just before writing; a hand edit since section 3 wins over your copy.

1. **Frontmatter**: keep the template's keys and their order; change only the fields that were answered or confirmed. Add `strategy_map` and `okrs` only when recorded, where the template's comments place them. Keep the comment lines.
2. **Status**: set `status: set` when at least one field now holds a value the user gave. When every question was skipped, or nobody answered, leave `status` exactly as it was: a deferred file stays `deferred`, and nothing in it changes.
3. **Updated**: set `updated` to today's date only when something changed.
4. **Body**: rebuild the human view from the frontmatter, in the user's language, keeping the heading `# Ground rules` and the HTML comment. One line per field, "chưa đặt" ("not yet set") for an empty one, the amount written with its currency in the user's style (for example "50.000.000 đồng"). Add a line for the strategy map, one sub-line per perspective, and one for OKRs, one sub-line per objective with its key results, only when they are recorded. Vietnamese labels: "Trạng thái" (đã đặt, để sau), "Ưu tiên năm nay", "Mức chi tôi tự duyệt", "Ngành hàng", "Việc luôn cần người duyệt", "Mục tiêu chiến lược", "OKR".
5. **Table of contents**: rebuild it by the workspace module's rules; its ground-rules status follows the file's `status`.

## 8. Nobody to answer

When nobody can answer (an unattended or evaluation run; a missing or failing question tool is not this case, since the ask protocol then asks in plain text): if the prompt already carries the answers, use them exactly. Otherwise ask nothing further, leave `constitution.md` unchanged (a deferred file stays deferred), invent no rule, and end with one sentence saying the ground rules still need a person to set them. Ground rules are the user's own decisions; a guessed approval limit would mislead every plan checked against it.

## 9. Tell the user

In two or three plain sentences: what was recorded or changed, what stays unset, and what the rules do now, for example: "Đã ghi luật chung: ngành thời trang, mức chi anh/chị tự duyệt 50 triệu đồng, ba việc luôn cần người duyệt và hai ưu tiên năm nay. Từ giờ, khi phản biện và lập kế hoạch cho từng ý tưởng, em sẽ đối chiếu với các luật này và ghi rõ chỗ nào vượt." No file names, field names or paths, and no praise. Ideas already packaged are not re-checked until they are packaged again; say so in one sentence when the workspace holds packaged ideas.

## Refusals

Never write outside the working folder, never change an idea's files from this skill, never overwrite a recorded rule without the confirmation in section 6, and never record a rule the user did not give.
