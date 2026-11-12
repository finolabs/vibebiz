---
name: continue
description: "Resume work on an idea already started with vibebiz: summarize what is settled, where the work stopped and the next question, then carry on the question rounds. Use when the user types /vibebiz:continue or asks to pick an idea back up, for example 'continue my idea', 'let's carry on', 'resume the win-back idea', 'làm tiếp ý tưởng', 'tiếp tục ý tưởng hôm trước', 'quay lại ý tưởng nhắc khách'. Not for a brand-new idea (that goes to new), a list of all ideas (status) or questions about how to use vibebiz (help)."
---

# vibebiz: continue an idea

Bring the user back into an idea they started earlier, in their idea's language, without making them remember anything. The user is a non-technical retail leader: never show them file names, paths, field names or category codes.

Load each module from this skill's own folder when its step starts, and follow it exactly:

- `references/core/workspace.md`: working folder check and table of contents.
- `references/core/writing-rules.md`: wording of everything the user reads.
- `references/core/ask-protocol.md`: how every question is asked, recorded and stopped.
- `references/core/router.md`: the question rounds, budget, readiness and next step.
- `references/core/clarify.md`: loaded by the router when it hands a category to clarify.

## 1. Check for a working folder

Follow the workspace module's working-folder check first. Without a working folder, give its message telling the user to open Cowork with a folder, and stop: write nothing, ask nothing.

If the folder holds no idea folder under `specs/` (the fictional examples in `examples/` never count), say in one sentence that there is no idea to continue yet and that `/vibebiz:new` starts one, and stop. If the table of contents is missing, restore it by the workspace module's rules before going on.

## 2. Pick the idea

Read the frontmatter of every `specs/NNN-<slug>/coverage.md`. An idea is open unless its `status` is `approved` or `rejected`.

- If the user named or described an idea, take the one whose `title` or `spec.md` `Input` line matches it.
- Otherwise, if exactly one idea is open, take it without asking.
- Otherwise ask one question through the question tool (ask protocol; it does not count toward the question budget): one option per open idea, most recently `updated` first, labelled with its title and described by its `next_step`. Recommend the most recently updated one. With more than four open ideas, offer the four most recent; the free-text box takes any other title.
- If no idea is open, say so in one sentence and stop.

If the user picks an idea whose `status` is `approved` or `rejected`, or asks to record a board decision or a tech team's review of the estimate, say plainly that this version of vibebiz cannot do that yet, and stop. Do not change the idea's status yourself.

From here on, speak in the idea's `language` from `coverage.md`.

## 3. Re-read the idea as it is now

Read the idea's current files: `coverage.md`, `spec.md`, `decisions.md`, `assumptions.md`, `open-questions.md`, `glossary.md`, and the workspace's `constitution.md`. The user may have edited any of them by hand since the last session. Their edits are authoritative:

- Work from what the files say now. Never restore an earlier version, re-add text the user removed, or rewrite a section they changed.
- Where a hand edit answers a point the coverage record still shows as open, treat the point as answered by the user; the router sets the category's status from the files when it closes the next round.
- Append to records (decisions, assumptions, open questions, Clarifications); never reword or delete an entry.
- If `coverage.md` frontmatter cannot be read, do not rewrite it silently. Ask through the question tool whether to rebuild the idea's progress record from what the requirement already says (recommended, because nothing the user wrote is lost) or to stop so they can fix it themselves.

## 4. Summarize in three lines

Before asking anything, tell the user, in exactly three lines in the idea's language:

1. **What is settled**: the categories now clear, by their plain names, and the most important decisions in a few words each.
2. **Where it stopped**: the date of the last session in the requirement's Clarifications, and what that session was working on; mention points still waiting on someone else (open questions owned by another person).
3. **The next question**: the topic the router will ask about first, taken from `next_step`; when the files changed since `next_step` was written, from the router's frontier on the current files instead.

Example:

> **Đã rõ:** vấn đề (khách mua một lần rồi không quay lại) và cách đo (tỷ lệ mua lần hai trong 60 ngày); đã chọn thử ở 3 cửa hàng.
> **Dừng ở:** buổi ngày 05/11, đang so sánh các phương án; còn chờ bộ phận chăm sóc khách hàng gửi số khách cũ mỗi tháng.
> **Câu hỏi tiếp theo:** nên tự làm, mua phần mềm có sẵn hay sửa quy trình nhắc khách hiện tại.

Use only what the files say; never fill a line with a guess. When nothing is settled yet, say so on the first line.

## 5. Resume the router loop

Hand the idea to the router and run its loop from the start of a session: it resets `budget_rounds_used` to `0`, re-reads the files, handles any contradiction with an earlier decision first, computes and ranks the frontier, looks facts up before asking, asks each round through the ask protocol, writes back, updates `next_step` and rebuilds the table of contents after every round. Do not reorder, merge or skip its steps here.

Stop when the router stops: at the budget (continue, pause or draft), at readiness (offer to package), or, with nobody to answer, at the budget with the list of assumptions a person must confirm.

## Refusals

Never share an output, make a file public, write outside the working folder, or overwrite a file this action did not create. Never record an answer the user did not give.
