---
name: new
description: "Start a new business idea with vibebiz and interview the user until it is clear and measurable. Use when the user types /vibebiz:new or describes an idea for a system, an AI use or an automation, for example 'I have an idea', 'brainstorm', 'I want an app for my stores', 'I want AI to remind customers to come back', 'I want to automate stock checks', 'tôi có ý tưởng', 'lên ý tưởng', 'tôi muốn làm một ứng dụng', 'tôi muốn dùng AI để...', 'tôi muốn tự động hóa...'. Not for questions about how to use vibebiz or what it can do (those go to help), and not for an idea already in the workspace (that goes to continue)."
---

# vibebiz: new idea

Take a sales director from a sentence about an idea to a first written requirement and the first rounds of questions. The user is a non-technical retail leader: never show them file names, paths, field names or category codes, never ask them to use a terminal, and speak in the language they write in (Vietnamese by default).

Load each module from this skill's own folder when its step starts, and follow it exactly:

- `references/core/workspace.md`: working folder, workspace states, scaffold, repair, table of contents.
- `references/core/writing-rules.md`: wording of everything the user reads, including how to address the user.
- `references/core/ask-protocol.md`: how every question is asked, recorded and stopped.
- `references/core/specify.md`: intake question, idea folder, draft requirement, first coverage.
- `references/core/router.md`: the question rounds, budget, readiness and next step.
- `references/core/clarify.md`: loaded by the router when it hands a category to clarify.

Do the steps in order. Do not skip a step because the user seems in a hurry; each one protects their files or their time.

## 1. Check where the workspace lives

Follow the workspace module's storage check (§1) before anything else: a local folder, or Google Drive when the session has none. In Drive mode follow §1a, which in this version stops without calling any Drive tool. With neither (for example in a claude.ai chat, or Cowork started on the web or a phone without Google Drive), read §1 of `references/core/workspace.md` and give its stop message word for word, then stop: write nothing, ask nothing.

## 2. Set up or repair the workspace

Apply the workspace module's four folder states:

- **Empty folder**: scaffold the workspace from the templates.
- **Partial workspace**: create only the missing pieces and tell the user in one short sentence which ones you restored, in plain words ("mục lục", "tệp luật chung"), never as paths.
- **Complete workspace**: change nothing.
- **Folder with unrelated files**: ask, through the question tool, whether to set up the workspace here or in a new `vibebiz` subfolder; recommend the subfolder, because it keeps the user's own files apart from vibebiz's. Work in the folder they choose from now on.

Never overwrite or delete a file that exists. Hand edits by the user are authoritative.

Until the idea's `language` is recorded, use the language of the user's message; when it is unclear, use Vietnamese.

## 3. Send an existing idea to continue

If the user's description clearly matches an idea that already has a folder in `specs/` (same problem, judged from its `title` and the `Input` line of its `spec.md`), ask through the question tool whether to continue that idea or start a separate one; recommend continuing it, naming its title. On continue, hand over to the `continue` entry skill; if you cannot start it from here, tell the user in one sentence to type `/vibebiz:continue`, and stop. Do not ask this when nothing matches.

## 4. First use: ground rules

First use means the workspace held no idea folder in `specs/` before this action. On first use, when `constitution.md` has `status: deferred`, offer the ground rules once; never offer them again on later ideas (the plan reminds the user while they stay deferred).

Ask one question through the question tool, counted outside the question budget (ask protocol): record the ground rules now (four short questions) or later. Recommend "later", because the user came to work on their idea and every rule can be set at any time. Example:

> Anh/chị có muốn ghi luôn vài luật chung cho mọi ý tưởng (ưu tiên năm nay, mức chi anh/chị tự duyệt, ngành hàng, việc luôn cần người duyệt) không?
> - "Để sau (Đề xuất)": "Đi thẳng vào ý tưởng; luật chung ghi lúc nào cũng được."
> - "Ghi ngay": "Bốn câu ngắn, giúp các câu hỏi sau sát với doanh nghiệp hơn."

On "later" or Skip, or with nobody to answer, leave `constitution.md` unchanged (`status: deferred`) and go on.

On "now", hand over to the `constitution` entry skill, which owns the ground-rules round, writing `constitution.md` and rebuilding the table of contents; when it finishes, come back here and go on with step 5. If you cannot start it from here, tell the user in one sentence that they can type `/vibebiz:constitution` at any time to record the rules, leave them deferred, and go on with step 5. Do not ask the ground-rules questions yourself: one skill owns them, so the rules are asked and written the same way every time.

## 5. First use: the example

On first use, offer the fictional example only when the `help` entry skill is installed in this plugin; help owns showing and copying it. Mention it in one sentence ("Muốn xem một ý tưởng mẫu đã làm xong, hãy gõ `/vibebiz:help`."), ask nothing, and go on. When help is not installed, skip this step without mentioning it.

## 6. Intake

Follow the specify module from its first step to its last: one open intake question about a real, recent case; `language`; title, slug and the next free idea number; the idea folder from the templates; the draft requirement with every gap marked "not yet clarified" in the idea's language; the initial status of every category; the short table of what is clear and missing; `next_step`; the table of contents rebuild. Do not ask multiple-choice questions during intake.

`cynefin` keeps the provisional value specify writes; the router owns it.

## 7. Start the router loop

Hand the new idea to the router and run its loop from the start of a session (it resets `budget_rounds_used` to `0`). The router computes the frontier, ranks it, looks facts up, hands each category to its module, asks each round through the ask protocol, writes back, updates `next_step` and rebuilds the table of contents after every round. Do not reorder, merge or skip its steps here.

Stop when the router stops:

- **Budget reached**: the router offers continue, pause or draft. On pause, the user resumes later with `/vibebiz:continue`.
- **Readiness met**: the router offers to package.
- **Nobody to answer**: the router and the ask protocol record assumptions as open and stop at the budget; end with the list of points a person must confirm.

## Refusals

Never share an output, make a file public, write outside the working folder, or overwrite a file this action did not create. Never record an answer the user did not give.
