---
name: status
description: "Show where every vibebiz idea in the workspace stands: status, how many points are clear and the next step. Use when the user types /vibebiz:status or asks for an overview, for example 'where are my ideas', 'show my ideas', 'what is the status of my ideas', 'các ý tưởng của tôi đến đâu rồi', 'xem danh sách ý tưởng', 'tình hình các ý tưởng'. Only lists; it never asks questions. Not for working on one idea (continue), starting one (new) or questions about how to use vibebiz (help)."
---

# vibebiz: status

List every idea in the workspace with its state, read from the files, and stop. Never ask the user anything in this skill, not even to pick an idea: the user asked to look, not to be interviewed. Speak in the language of the user's message, Vietnamese by default. The user is non-technical: never show file names, paths, field names or category codes.

Load these modules from this skill's own folder when their step starts:

- `references/core/workspace.md`: working folder check and table of contents.
- `references/core/writing-rules.md`: wording of everything the user reads.

## 1. Check for a working folder

Follow the workspace module's working-folder check first. Without a working folder, give its message telling the user to open Cowork with a folder, and stop.

If the folder holds no vibebiz workspace (no table of contents, no ground rules file and no `specs/` folder), say in one sentence that there is no idea yet and that `/vibebiz:new` starts one, and stop. Do not create a workspace here.

## 2. Read every idea

For each folder `specs/NNN-<slug>/`, read the frontmatter of its `coverage.md`: `title`, `status`, `categories` (count those whose `status` is `clear`, out of 15), `next_step` and `updated`. Skip `examples/` entirely; the fictional example is never an idea of the user's.

Read only; change nothing in an idea's files. If a `coverage.md` is missing or its frontmatter cannot be read, still list the idea by its folder's title words and say its progress could not be read; do not repair it here.

## 3. Rebuild the table of contents

Rebuild the table of contents by the workspace module's rules, restoring it if it was deleted. This is the only file this skill writes.

## 4. Show the list

Show one table, ideas ordered by number, with these columns in the user's language:

| Vietnamese column | Content |
|---|---|
| Ý tưởng | `title` |
| Trạng thái | the status word below |
| Mức rõ | clear categories, as "9/15" |
| Bước tiếp theo | `next_step`, as written |
| Cập nhật | `updated`, as DD/MM/YYYY |

Status words: `clarifying` → "Đang làm rõ", `ready` → "Sẵn sàng đóng gói", `packaged` → "Đã đóng gói", `presented` → "Đã trình bày", `approved` → "Được duyệt", `rejected` → "Không được duyệt", `needs-changes` → "Cần sửa lại". In English: clarifying, ready to package, packaged, presented, approved, rejected, needs changes.

After the table, add one sentence: to work on an idea, type `/vibebiz:continue` and name it. Then stop.
