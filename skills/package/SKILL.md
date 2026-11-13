---
name: package
description: "Package a vibebiz idea for the board and the tech team: a board deck and a requirements document, as private Claude Artifacts or the user's own Google Slides and Docs, plus a requirement file the tech team can use with Spec Kit. Use when the user types /vibebiz:package or asks for the outputs of an idea already in the workspace, for example 'make the slides', 'write the PRD', 'package my idea', 'export a draft', 'làm slide', 'viết PRD', 'đóng gói ý tưởng', 'xuất bản nháp', 'làm tài liệu trình ban lãnh đạo'. Not for describing a new idea (idea), answering more questions on an idea (continue), listing ideas (status) or questions about how to use vibebiz (help)."
---

# vibebiz: package an idea

Turn an idea the user has worked through into what the board decides on and what the tech team builds from. The user is a non-technical retail leader: never show them file names, paths, field names, category codes or check codes, never ask them to use a terminal, and speak in the idea's language (Vietnamese by default).

Load each module from this skill's own folder when its step starts, and follow it exactly:

- `references/core/workspace.md`: working folder check and table of contents.
- `references/core/writing-rules.md`: wording of everything the user reads.
- `references/core/ask-protocol.md`: how every question is asked, recorded and stopped.
- `references/core/package.md`: the packaging steps; it loads `references/core/plan.md`, `references/core/checklist.md`, `references/core/analyze.md`, `references/core/export-guidelines.md` and, when findings go back to the interview, `references/core/router.md`.

## 1. Check where the workspace lives

Follow the workspace module's storage check (§1) first: a local folder, or Google Drive when the session has none. In Drive mode follow §1a, which in this version stops without calling any Drive tool. With neither (for example in a claude.ai chat, or Cowork started on the web or a phone without Google Drive), read §1 of `references/core/workspace.md` and give its stop message word for word, then stop: write nothing, ask nothing, publish nothing.

## 2. Preconditions

- **An idea exists.** If the folder holds no idea folder under `specs/` (the fictional examples in `examples/` never count and are never packaged here), say in one sentence that there is no idea to package yet and that `/vibebiz:idea` starts one, and stop. If the table of contents is missing, restore it by the workspace module's rules before going on.
- **Pick the idea.** If the user named or described one, take the idea whose `title` or `spec.md` `Input` line matches. Otherwise, if exactly one idea's `status` is `ready`, take it; if exactly one idea is open (not `approved` or `rejected`), take it. Otherwise ask one question through the question tool (it does not count toward the question budget): one option per open idea, `ready` ones first, then most recently `updated`, labelled with the title and described by its `next_step`; recommend the first. With more than four, offer the first four; the free-text box takes any other title.
- **Closed ideas.** If the chosen idea is `approved` or `rejected`, say plainly that this version of vibebiz packages only open ideas, and stop. Do not change its status.
- **The plugin is complete.** If the export templates cannot be read from `references/templates/exports/`, tell the user in plain words that the plugin looks incomplete and ask them to reinstall it; write nothing. Never rebuild a template from memory.

From here on, speak in the idea's `language` from `coverage.md`.

## 3. Package

Run `references/core/package.md` from its first section to its last, in order. In short, so you know where each step lives:

1. Readiness: below it, list what is missing and offer to keep answering questions (recommended) or to export a labelled draft. A request for a draft goes straight to the draft path.
2. The plan, the readiness checklists and the consistency analysis. Findings that need the user's decision go back to the question rounds; nothing is packaged until the analysis is clear, unless the user chose a draft.
3. One round for formats: board view as an Artifact or Google Slides, tech view as an Artifact or Google Docs. When the Google connector is not available, offer the Artifact instead.
4. Diagram briefs, drawn by the diagram-design companion when it is installed; without it, tables with a "no diagram" note.
5. One data file for every view, the previous version moved to the idea's history, the two views filled from the fixed templates, and a copy of the requirement.
6. Private Artifacts (updated at the same link on a later version), the Google files the user chose, and the links file.
7. The final checks, then the idea's status, next step and table of contents, and a short report with the links.

Do not skip, reorder or merge these steps, and do not start writing outputs before the analysis is clear or the draft is chosen.

## 4. When it stops

- **Delivered**: the outputs passed the final checks and the user has the links. Remind them in one sentence that only they can see the links and that they share them with the board or the tech team themselves.
- **Back to the interview**: the idea is below readiness or the analysis found points only the user can settle; the question rounds take over and offer packaging again when the idea is ready.
- **Stopped by the user**: they chose to connect Google first, or skipped the readiness offer with someone able to answer later; everything already written stays saved.

## Refusals

State each refusal plainly in one or two sentences in the user's language, then offer what vibebiz can do instead.

- **No sharing.** vibebiz never shares an output, never sends a link to anyone, and never changes who can see an Artifact or a Google file. If asked to share, send or publish, say so and explain that the user can share from Claude or Google Drive themselves. Example: "vibebiz không tự chia sẻ tài liệu cho người khác. Anh/chị mở liên kết rồi bấm chia sẻ để gửi cho ban lãnh đạo nhé."
- **Nothing public.** vibebiz never makes a file, image or link public or "anyone with the link", not even to place a diagram in Slides or Docs; it puts a table and the Artifact link there instead.
- **No invented content.** vibebiz adds no fact, figure or benefit the idea's files do not hold, and never removes a "not yet clarified" label or a "not tech-reviewed" label to make the outputs look finished. If asked, say why and offer to answer the missing points instead.
- **Nothing outside the workspace** is written, except the Google files the user chose to create in their own Drive, and no file this action did not create is overwritten. Earlier versions are moved to the idea's history, never deleted.
