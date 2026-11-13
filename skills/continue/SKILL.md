---
name: continue
description: "Resume work on an idea already started with vibebiz: summarize what is settled, where the work stopped and the next question, then carry on the question rounds. Also records what happened to a packaged idea: the board approved, rejected or asked for changes, or the tech team reviewed the estimates. Use when the user types /vibebiz:continue, asks to pick an idea back up ('continue my idea', 'resume the win-back idea', 'làm tiếp ý tưởng', 'quay lại ý tưởng nhắc khách'), reports a board decision ('the board approved it', 'the board wants changes', 'sếp duyệt rồi', 'ban lãnh đạo không duyệt', 'ban giám đốc yêu cầu sửa') or a tech review ('tech reviewed the estimates', 'đội kỹ thuật đã thẩm định chi phí'). Not for a brand-new idea (that goes to new), a list of all ideas (status) or questions about how to use vibebiz (help)."
---

# vibebiz: continue an idea

Bring the user back into an idea they started earlier, in their idea's language, without making them remember anything. The user is a non-technical retail leader: never show them file names, paths, field names or category codes.

Load each module from this skill's own folder when its step starts, and follow it exactly:

- `references/core/workspace.md`: working folder check and table of contents.
- `references/core/writing-rules.md`: wording of everything the user reads.
- `references/core/ask-protocol.md`: how every question is asked, recorded and stopped.
- `references/core/router.md`: the question rounds, budget, readiness and next step.
- `references/core/clarify.md`: loaded by the router when it hands a category to clarify.
- `references/core/package.md`: only to read how export versions are named and moved to history (section 3.2).

## 1. Check where the workspace lives

Follow the workspace module's storage check (§1) first: a local folder, or Google Drive when the session has none. In Drive mode follow §1a, which in this version stops without calling any Drive tool. With neither, read §1 of `references/core/workspace.md` and give its stop message word for word, then stop: write nothing, ask nothing.

If the folder holds no idea folder under `specs/` (the fictional examples in `examples/` never count), say in one sentence that there is no idea to continue yet and that `/vibebiz:new` starts one, and stop. If the table of contents is missing, restore it by the workspace module's rules before going on.

## 2. Pick the idea and what the user wants

Read the frontmatter of every `specs/NNN-<slug>/coverage.md`. An idea is open unless its `status` is `approved` or `rejected`.

First decide which of these the user's message asks for, from its meaning, in any language:

| The user says | Intent | Examples |
|---|---|---|
| the board decided on a presented version | **board outcome** (approved, rejected or needs changes) | "sếp duyệt rồi", "ban giám đốc không duyệt", "hội đồng bảo sửa lại phần chi phí", "the board approved it", "the board wants changes" |
| the idea was presented, no decision yet | **presented** | "đã trình rồi, đang chờ ban lãnh đạo trả lời", "we presented it yesterday, waiting for an answer" |
| the tech team checked the estimates | **tech review** | "đội kỹ thuật đã thẩm định chi phí", "bên IT xem lại ước tính rồi", "tech reviewed the estimates" |
| work on an idea that was approved or rejected | **reopen** | "mở lại ý tưởng đã bị từ chối", "làm lại ý tưởng này", "reopen the loyalty idea" |
| anything else about an existing idea | **resume** | "làm tiếp ý tưởng hôm trước" |

When one message reports two events (for example a board outcome and a tech review), handle them one after the other, board outcome first.

Then pick the idea:

- If the user named or described an idea, take the one whose `title` or `spec.md` `Input` line matches it, whatever its status.
- Otherwise take the only idea the intent can apply to: for a board outcome or presented, an idea whose `status` is `packaged` or `presented`; for a tech review, any idea; for resume, an open idea. If exactly one idea qualifies, take it without asking.
- Otherwise ask one question through the question tool (ask protocol; it does not count toward the question budget): one option per qualifying idea, most recently `updated` first, labelled with its title and described by its `next_step`. Recommend the most recently updated one. With more than four, offer the four most recent; the free-text box takes any other title.
- If no idea qualifies, say so in one sentence and stop. For a board outcome with no packaged idea, add that vibebiz records the board's decision only for a version it packaged, and that `/vibebiz:package` makes one.

From here on, speak in the idea's `language` from `coverage.md`. A resume of an `approved` or `rejected` idea is a reopen (section 3.4). For a board outcome, presented, tech review or reopen, run section 3 and go on where it says. For resume, go to section 4.

## 3. Record what happened outside vibebiz

The board's decision and the tech team's review happen in meetings vibebiz does not attend; the user reports them. Record exactly what the user reports, nothing more. Ask through the question tool only for what the message leaves out, in one round of at most three questions that does not count toward the question budget, and never ask for something the message already says.

With nobody to answer, record what the message holds and never guess the rest: without a version or a date, change no `status` or `estimate_status`, record nothing in `decisions.md`, and add an open question owned by the user saying what is needed to record the event.

Every write here re-reads the file just before writing and appends rather than rewrites. Record the reported event in the requirement's Clarifications under today's session as one `- Q: … → A: …` line, as the ask protocol's write-back does. After the writes, set `updated` to today in `coverage.md`, write `next_step`, and rebuild the table of contents by the workspace module's rules.

### 3.1 Status changes allowed here

The idea's `status` moves only along these steps; never set it any other way:

| From | Event the user reports | To |
|---|---|---|
| `packaged` | presented, no decision yet | `presented` |
| `packaged` or `presented` | the board approved / rejected / asked for changes | `approved` / `rejected` / `needs-changes` (a `packaged` idea passes through `presented` in the same step) |
| `needs-changes` | the user starts on the board's changes | `clarifying` |
| `approved` or `rejected` | the user reopens the idea | `clarifying` |

A tech review never changes `status`. If the user reports a board outcome for an idea in any other status, change nothing: say in one or two sentences why (for example the idea was reopened and not packaged since) and name the step that leads there (`/vibebiz:package`, or reopening). A labelled draft never counts as a presented version.

### 3.2 Board outcome

1. **Which version.** The presented version is an export set that was not a draft. The current set lives in the idea's `exports/`; each earlier set lives in its own folder under `exports/history/`. Name each set by the folder it has or will have in history: an earlier set by its folder name; the current set by the name the package module will move it to, which is its `idea.version` date in `exports/data.json` (or `latest_export` when that file cannot be read), followed by `-2`, `-3` and so on when a history folder of that name already exists. Draft sets (`draft: true`) are never candidates. If one set qualifies, or the user's words name a date that matches one, take it. Otherwise ask, one option per set, newest first, labelled by its date as DD/MM/YYYY; recommend the newest, since the board usually sees the latest.
2. **The date.** The date the board decided. Take it from the message ("hôm qua", "thứ Hai vừa rồi", converted against today). Otherwise ask, offering today and yesterday as DD/MM/YYYY; the free-text box takes any other date.
3. **The notes.** What the board said: conditions on an approval, reasons for a rejection, the changes requested. If the message does not say, ask once, as the round's open question in plain text, for example "Ban lãnh đạo có kèm điều kiện hay góp ý gì không?" or, for changes, "Ban lãnh đạo yêu cầu sửa những điểm nào?". A skip leaves the notes empty; never write notes the user did not give.
4. **Record.** Append to `decisions.md` one entry `## D-### — <short title>` (for example "Ban lãnh đạo yêu cầu sửa bản 10/11/2026") with `date` (the board's decision date), `type: board-outcome`, `text` (the decision in one plain sentence), `reason` (the board's reason as the user reported it, or "Người dùng báo lại" when none was given), `export_version` (the folder name from step 1), `outcome` (`approved`, `rejected` or `needs-changes`) and `notes` (the user's words). Then set `status` by the table in 3.1. Earlier board outcomes stay as they are: each version keeps its own history.
5. **Correcting an outcome.** If the user says the outcome just recorded was wrong (for example the board in fact approved), append a new `board-outcome` entry for the same `export_version` with the corrected `outcome` and the earlier id in `supersedes`, and set `status` from the corrected outcome. Never edit the earlier entry.
6. **Tell the user and go on**, in one or two plain sentences, by outcome:
   - `approved`: say what was recorded. Write a `next_step` such as "Gửi tài liệu cho đội kỹ thuật và báo lại khi đội kỹ thuật thẩm định chi phí" while the estimates are not tech-reviewed, otherwise "Gửi tài liệu cho đội kỹ thuật để bắt đầu". Stop.
   - `rejected`: say what was recorded, that the idea and its history stay in the folder, and that `/vibebiz:continue` can reopen it later. Write a `next_step` such as "Ban lãnh đạo chưa duyệt; mở lại nếu muốn làm lại". Stop.
   - `needs-changes`: ask whether to start on the changes now (recommended, while the meeting is fresh) or later. Now: set `status` to `clarifying` and go to section 4, handing the board's notes to the router as the changes to work on first. Later or skipped: keep `needs-changes`, write a `next_step` naming the changes in plain words (for example "Sửa phần chi phí theo góp ý của ban lãnh đạo"), and stop.

### 3.3 Presented, no decision yet

On a `packaged` idea, set `status` to `presented`, record the presentation and its date in Clarifications (ask the date as in 3.2 step 2 when the message gives none), and write a `next_step` such as "Báo lại quyết định của ban lãnh đạo". Append no decision: nothing was decided yet. Stop.

### 3.4 Reopen an approved or rejected idea

Ask one confirmation through the question tool before changing anything, showing the board's latest decision with its date so the question stands on its own: reopen to work on it again (recommended, since the user asked to work on it; the history stays) or leave it as it is. On reopen:

- set `status` to `clarifying`;
- append an `answer` decision titled "Mở lại ý tưởng" with the date, the user's reason in `reason` ("Người dùng muốn làm tiếp" when none was given) and the board decision it follows, by its id, in `notes`;
- keep every earlier decision, board outcome, export set and history folder exactly as it is; `latest_export` stays.

Then go to section 4. When the board's latest outcome had notes, hand them to the router as the changes to work on first. If the user chooses to leave it, or skips, change nothing and stop.

### 3.5 Tech review

1. **What was reviewed.** From the message, or one question if it does not say: did the tech team confirm the estimates as they are, or change some figures? Recommend the option the user's words lean to, otherwise "changed some figures", since a missed change is worse than an extra question. When figures changed, ask once, as the round's open question, which figures, their new values and what the tech team based them on.
2. **The date.** As in 3.2 step 2.
3. **Record.** Append a `tech-review` decision with `date`, `text` (what the tech team reviewed and concluded, in one plain sentence), `reason` (their basis, or "Người dùng báo lại"), and `notes` (who reviewed, as a role such as "trưởng nhóm kỹ thuật" unless the user named a person, and each changed figure as "trước: …, sau: …").
4. **Changed figures.** Write each new value into the requirement's cost section in place of the estimate it replaces, with the tech team's review and its date as the source, and update the business plan's figure the same way when the plan exists. The old value stays only in the decision's notes. When a new figure changes whether the idea fits the ground rules (for example it now exceeds the amount the user approves alone), say so in one sentence; the plan records the conflict at the next packaging.
5. **Flip the flag.** When the tech team reviewed every estimate on file, set `estimate_status` to `tech-reviewed` in `coverage.md`, and in the plan's frontmatter when the plan exists (it mirrors the coverage record). When they reviewed only some, keep `not-tech-reviewed`, list what remains in the decision's notes, and say that the label stays until every estimate is reviewed. Never set `tech-reviewed` without a recorded review.
6. **Tell the user and go on.** Say what was recorded. When an export exists (`latest_export` is set), say that the documents already made still carry the "chưa qua kỹ thuật thẩm định" label and the next packaging drops it, and offer through the question tool to package again now (recommended) or later. Now: hand over to the `package` entry skill, or tell the user to type `/vibebiz:package` if you cannot start it from here. Later: write a `next_step` such as "Đóng gói lại để bỏ nhãn chưa qua kỹ thuật thẩm định". Without an export, leave `next_step` as it is. Stop unless the message also asked to resume.

## 4. Re-read the idea as it is now

Read the idea's current files: `coverage.md`, `spec.md`, `decisions.md`, `assumptions.md`, `open-questions.md`, `glossary.md`, and the workspace's `constitution.md`. The user may have edited any of them by hand since the last session. Their edits are authoritative:

- Work from what the files say now. Never restore an earlier version, re-add text the user removed, or rewrite a section they changed.
- Where a hand edit answers a point the coverage record still shows as open, treat the point as answered by the user; the router sets the category's status from the files when it closes the next round.
- Append to records (decisions, assumptions, open questions, Clarifications); never reword or delete an entry.
- If `coverage.md` frontmatter cannot be read, do not rewrite it silently. Ask through the question tool whether to rebuild the idea's progress record from what the requirement already says (recommended, because nothing the user wrote is lost) or to stop so they can fix it themselves.

## 5. Summarize in three lines

Before asking anything, tell the user, in exactly three lines in the idea's language:

1. **What is settled**: the categories now clear, by their plain names, and the most important decisions in a few words each.
2. **Where it stopped**: the date of the last session in the requirement's Clarifications, and what that session was working on; mention points still waiting on someone else (open questions owned by another person). After a board outcome, name it with its date and the changes the board asked for.
3. **The next question**: the topic the router will ask about first, taken from `next_step`; when the files changed since `next_step` was written, from the router's frontier on the current files instead.

Example:

> **Đã rõ:** vấn đề (khách mua một lần rồi không quay lại) và cách đo (tỷ lệ mua lần hai trong 60 ngày); đã chọn thử ở 3 cửa hàng.
> **Dừng ở:** buổi ngày 05/11, đang so sánh các phương án; còn chờ bộ phận chăm sóc khách hàng gửi số khách cũ mỗi tháng.
> **Câu hỏi tiếp theo:** nên tự làm, mua phần mềm có sẵn hay sửa quy trình nhắc khách hiện tại.

Use only what the files say; never fill a line with a guess. When nothing is settled yet, say so on the first line.

## 6. Resume the router loop

If the idea's `status` is `needs-changes` (the user chose to work on the board's changes later and has now come back), set it to `clarifying` first, as section 3.1 allows, and hand the notes of the latest `board-outcome` entry to the router as the changes to work on first.

Hand the idea to the router and run its loop from the start of a session: it resets `budget_rounds_used` to `0`, re-reads the files, handles any contradiction with an earlier decision first, computes and ranks the frontier, looks facts up before asking, asks each round through the ask protocol, writes back, updates `next_step` and rebuilds the table of contents after every round. Do not reorder, merge or skip its steps here.

Stop when the router stops: at the budget (continue, pause or draft), at readiness (offer to package), or, with nobody to answer, at the budget with the list of assumptions a person must confirm.

## Refusals

Never share an output, make a file public, write outside the working folder, or overwrite a file this action did not create. Never record an answer, a board decision or a tech review the user did not report, and never change an idea's status except by the steps in section 3.1 and the router's own steps between `clarifying` and `ready`.
