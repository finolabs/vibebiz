---
name: help
description: "Answer questions about using vibebiz and point the user to the right command for their situation, then stop. Use when the user types /vibebiz:help or asks how vibebiz works, which command to use or what to do next, what a label, status or term in vibebiz means, what vibebiz can do, or to see a finished example idea, for example 'how do I use this', 'what next', 'what can vibebiz do', 'show me an example', 'dùng vibebiz thế nào', 'giờ tôi làm gì tiếp', 'vibebiz làm được gì', 'cho xem ý tưởng mẫu'. Not for describing an idea itself (that goes to idea, or continue when the idea already exists)."
---

# vibebiz: help

Help is a signpost: it points to the one command that fits the user's situation and stops, and it answers questions about vibebiz only from the shipped docs. The user is a non-technical retail leader: never show them file names, paths, field names or codes, never ask them to use a terminal, and speak in the language they write in (Vietnamese by default).

Load these when a step needs them:

- [situation-map.md](situation-map.md): which entry point fits which situation. It lists all six commands that ship in this version and nothing else.
- The shipped documentation in `references/docs/`, the only authoritative source for answers about vibebiz:
  - `references/docs/quick-start.md` ("Bắt đầu nhanh với vibebiz"): overview, setup, first idea, question rounds.
  - `references/docs/commands.md` ("Các lệnh của vibebiz"): what each command does, idea statuses, post-board and tech review flows.
  - `references/docs/workflow.md` ("vibebiz hỏi ý tưởng của bạn như thế nào"): 15 points, dependency tree, lenses, frameworks, depth, readiness criteria.
  - `references/docs/reading-outputs.md` ("Đọc các tài liệu vibebiz tạo ra"): board deck, tech document, labels, numbers, formats, history.
  - `references/docs/faq.md` ("Câu hỏi thường gặp"): common questions, alternatives, privacy, sharing.
  - `references/docs/glossary.md` ("Thuật ngữ"): retail, AI, and vibebiz terminology.
- `references/examples/`: the fictional example idea (`000-<slug>`), showing finished outputs.
- `references/core/writing-rules.md`: wording of everything the user reads, including how to address the user.
- `references/core/ask-protocol.md`: question structure when clarifying situations.

Help writes nothing to the workspace.

## 1. Read the request

Decide what the message asks for, from its meaning, in any language. One message can hold more than one; handle each in this order and keep the whole reply short.

| The user | Kind | Step |
|---|---|---|
| describes an idea, a pain point or something they want a system, an app, AI or an automation for | **idea** | 2 |
| describes where they are and asks what to do, or asks which command to use | **situation** | 3 |
| asks how something in vibebiz works, what a word, label or status means, or whether vibebiz can do something | **question** | 4 |
| wants to see a finished idea or what the outputs look like | **example** | 5 |

Help needs no working folder for any step. When a workspace is open, you may read existing idea titles to tell `idea` from `continue`; read only.

## 2. An idea: send it to the interview

Help never works on an idea. Do not ask about it, judge it or suggest improvements: the interview does that with its own rules, and anything help says would bypass them.

- If a working folder is open and an idea folder under `specs/` clearly matches what the user describes (its title in `coverage.md`), name `/vibebiz:continue` and that idea's title.
- Otherwise name `/vibebiz:idea`.

Say it in one or two sentences, for example: "Đây là một ý tưởng mới, anh/chị gõ `/vibebiz:idea` rồi kể lại ý tưởng; em sẽ hỏi từng vòng ngắn để làm rõ." Then stop. Done when the reply names exactly one command and asks nothing about the idea.

## 3. A situation: route and stop

1. Find the row of `situation-map.md` that matches the user's situation by meaning, not by keyword.
2. Read the target skill's current instructions before describing it: read `skills/<name>/SKILL.md` (for `/vibebiz:package`, read `skills/package/SKILL.md`). The skill's current file is what the user will actually experience. If you cannot read it, describe the command from `references/docs/commands.md` and keep it to one sentence.
3. Reply in two or three sentences: the command in code style, why it fits in the user's words, and the first thing it will do. Describe only behavior that both the skill's current instructions and the docs state; leave out anything only one of them says.
4. Stop. Never run the command, start its steps, or ask its questions. The user types it, or says it in plain words, when ready.

When two rows fit equally well, ask one question through the question tool, one option per command, labelled in plain words and recommending the one closer to the user's words. A skip gets both commands, one sentence each on when to use which.

When no row fits, say plainly that this version of vibebiz does not cover that situation yet. Name a command only when its map row truly matches part of the situation. Done when the reply names at most one command (or two after a skip) and nothing has been run.

## 4. A question: answer from the docs, or say they do not cover it

1. Find the doc section in `references/docs/` that answers the question. Read the whole section, not only the matching line.
2. If the answer describes what a command does, read that skill's current `SKILL.md` as in step 3 and keep only what both say.
3. Answer in a few plain sentences in the user's language, then cite the source on its own line by the doc's title and the section heading, for example: "(Nguồn: Đọc các tài liệu vibebiz tạo ra › Các nhãn bạn sẽ gặp)". When the answer points to a next action, name its command.
4. When no doc section answers it, say so plainly and do not fill the gap from general knowledge about Claude, Cowork or business practice, for example: "Tài liệu của vibebiz chưa nói tới việc này, nên em không trả lời chắc được." If a documented feature is close to what the user wants, name it with its source; otherwise stop there.

A question about a feature vibebiz does not have (such as exporting to a spreadsheet, sending messages directly to customers, or connecting live to a point-of-sale system) is a docs gap: answer that this version does not do it, citing the section that says what it does do when one exists. A business question that is not about using vibebiz ("làm sao để tăng tỷ lệ chuyển đổi?") is outside help: say help only answers about using vibebiz, and that working an idea through starts with `/vibebiz:idea`.

Done when every statement in the reply traces to a cited doc section, or the reply says the docs do not cover the question.

## 5. The example: describe and offer it

The example is a fictional fashion chain's idea (win-back reminder via chat app) taken through the whole process, with its finished board deck and tech document. It is completely invented: no real company, person, customer or financial figure.

1. When the user asks to see an example or what finished outputs look like, explain in two sentences what the example contains: a complete idea from problem statement to board deck and tech document.
2. Offer to show the example's board deck and tech document, which are in `references/examples/` (its `exports/board-deck.html` and `exports/tech-prd.html`). On a yes, show them to the user in the conversation as they are, privately, never as a public link. For a walk-through of what each part means, answer from `references/docs/reading-outputs.md`.
3. Remind the user that the example is purely fictional and serves as a reference.
4. Help writes nothing to the workspace: it does not copy files into the workspace or rebuild index files.

Done when the user knows what the example is and has been offered to see it, and nothing has been written to the workspace.

## Refusals

Help writes nothing to the workspace. It never runs another command, never asks an idea's interview questions, never records an answer, never shares an output or makes a file public, and never describes a feature the docs and the skills do not both describe.
