---
name: status
description: "Show where every vibebiz idea in the workspace stands: status, how many points are clear and the next step. Use when the user types /vibebiz:status or asks for an overview, for example 'where are my ideas', 'show my ideas', 'what is the status of my ideas', 'các ý tưởng của tôi đến đâu rồi', 'xem danh sách ý tưởng', 'tình hình các ý tưởng'. Only lists; it never asks questions. Not for working on one idea (continue), starting one (new) or questions about how to use vibebiz (help)."
---

# vibebiz: status

List every idea in the workspace with its state, read from the files, and stop. Never ask the user anything in this skill, not even to pick an idea: the user asked to look, not to be interviewed. Speak in the language of the user's message, Vietnamese by default. The user is non-technical: never show file names, paths, field names or category codes.

Load these modules from this skill's own folder when their step starts:

- `references/core/workspace.md`: working folder check and table of contents.
- `references/core/writing-rules.md`: wording of everything the user reads.

## 1. Check where the workspace lives

Follow the workspace module's storage check (§1) first: a local folder, or Google Drive when the session has none. With neither, read §1 of `references/core/workspace.md` and give its stop message word for word, then stop.

If the folder holds no vibebiz workspace (no table of contents, no ground rules file and no `specs/` folder), say in one sentence that there is no idea yet and that `/vibebiz:new` starts one, and stop. Do not create a workspace here.

## 2. Read every idea

For each folder `specs/NNN-<slug>/`, read the frontmatter of its `coverage.md`: `title`, `language`, `status`, `estimate_status`, `categories` (count those whose `status` is `clear`, out of 15), `next_step` and `updated`. Then read the idea's `exports/links.md` when it exists and keep every line whose address starts with `https://`, with the label before the colon. Skip `examples/` entirely: the fictional example is never an idea of the user's and never appears in this list.

Read only; change nothing in an idea's files. If a `coverage.md` is missing or its frontmatter cannot be read, still list the idea by its folder's title words and say its progress could not be read; do not repair it here.

## 3. Rebuild the table of contents

Rebuild the table of contents by the workspace module's rules, restoring it if it was deleted. This is the only file this skill writes.

## 4. Show the list

Show one table, ideas ordered by number, with these columns in the user's language:

| Vietnamese column | Content |
|---|---|
| Ý tưởng | `title` |
| Trạng thái | the status word below |
| Ước tính | the estimate word below |
| Mức rõ | clear categories, as "9/15" |
| Bước tiếp theo | `next_step`, as written, then the command to type for it in code style (below) |
| Tài liệu | each kept link as a Markdown link named by its label; "Chưa có" when there is none |
| Cập nhật | `updated`, as DD/MM/YYYY |

Status words (use the same words as the table of contents page, so the user sees one name for one state): `clarifying` → "Đang làm rõ", `ready` → "Sẵn sàng đóng gói", `packaged` → "Đã đóng gói", `presented` → "Đã trình ban lãnh đạo", `approved` → "Được duyệt", `rejected` → "Không được duyệt", `needs-changes` → "Cần chỉnh sửa". In English: clarifying, ready to package, packaged, presented to the board, approved, rejected, needs changes.

Estimate words: `not-tech-reviewed` → "Chưa qua kỹ thuật thẩm định", `tech-reviewed` → "Đã qua kỹ thuật thẩm định". In English: not tech-reviewed, tech-reviewed.

The command for the next step: when `next_step` already names a `/vibebiz:` command, that one; otherwise `/vibebiz:package` for `ready`, and `/vibebiz:continue` for every other status (it resumes the interview, records the board's decision or the tech team's review, and reopens an approved or rejected idea).

Show only `https://` links: the documents inside the working folder are reached from the table of contents page, and a file path means nothing to the user.

After the table, add two short sentences: to work on an idea, type `/vibebiz:continue` and name it; to report what the board decided or what the tech team concluded, say it in plain words, for example "ban lãnh đạo đã duyệt ý tưởng nhắc khách quay lại". Then say that the table of contents page in the working folder ("Mục lục ý tưởng") shows the same list with buttons to copy each command and links to every document. Then stop.
