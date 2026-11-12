# Module: checklist

Check, before anything is packaged, whether the idea's files say enough, clearly enough, for the board to decide and for the tech team to start. Write the result as two Definition of Ready checklists, one for the board view and one for the tech view, and hand the result to the package module, which decides between packaging, a labelled draft and a return to the interview.

- **Used by**: package, after the plan module and before the analyze module.
- **Reads**: the idea's `spec.md`, `plan.md`, `coverage.md` (category statuses and reasons, `language`, `estimate_status`), `decisions.md`, `assumptions.md`, `open-questions.md`, `glossary.md`; the workspace `constitution.md` (only its `status`, for the ground-rules item); the templates `references/templates/idea/checklists/board.md` and `references/templates/idea/checklists/tech.md`; the requirement template `references/templates/idea/spec.md` (for its fixed headings).
- **Writes**: the idea's `checklists/board.md` and `checklists/tech.md`. Nothing else: this module asks no questions and changes no other file.
- **Fills**: the readiness result.

Follow `references/core/writing-rules.md` for the notes and for every word the user reads, including how to address the user.

## 1. What a checklist item tests

The idea comes from Spec Kit's `checklist` command (GitHub, MIT license), which treats a checklist as unit tests for requirements written in plain language: each item tests whether something is **written** completely, clearly, consistently and measurably, not whether a system will work. vibebiz keeps that idea and changes two things: the item list is fixed by the two templates, so packaging can read results by id, and vibebiz checks the items itself against the files, because a sales director is not a reviewer of requirements writing and packaging needs a result.

Every item is a test of the idea's files:

- It passes when the files **state** the thing the item names, in a form the reader can use: a number with unit, period, source and label; a named owner; a decision with its D-###; a scenario with Given, When and Then.
- It never tests the future system, a process in the stores or whether a claim is true. "The outcome has a target and a time frame" passes when the spec writes "giảm 30% số tin nhắn chờ quá 15 phút trong 3 tháng"; whether that will happen is not the checklist's question.
- A section that holds only `chưa làm rõ`, a `[NEEDS CLARIFICATION]` marker, a bracketed template placeholder or a vague quality word with no number (the list in the writing rules: "nhanh", "thông minh", "tối ưu"…) does not pass, except where the item itself only asks for the gap to be listed.
- A coverage status is a claim, not proof. A category marked `clear` whose section still has a gap fails the item, with a note saying so.

## 2. Write the two files

1. Start each run from the template (`references/templates/idea/checklists/board.md`, then `tech.md`) and overwrite the idea's previous checklist: the result describes the files as they are now, and every packaging run rebuilds it.
2. Replace `{{Idea title}}` with the idea's title and `{{YYYY-MM-DD}}` with today's date. Keep the headings, item ids and item text in English and unchanged, in the template's order; do not add, drop, merge or reword items. The package and analyze modules read the results by id.
3. Mark an item `[x]` only when the files satisfy it (section 3). Otherwise leave `[ ]` and add one indented note line under it, in the idea's language, naming the section by its heading (never a path) and what is missing, for example:

   ```markdown
   - [ ] CHK010 Slide 3: the outcome has a baseline or measurement plan, a target, a time frame and guardrails (spec.md Outcome)
     - Ghi chú: Outcome có mục tiêu và thời hạn nhưng chưa có mức hiện tại hay cách đo; chưa có giới hạn an toàn.
   ```

4. A checked item may carry a note too, when it passes for a reason the reader should see: "Ghi chú: hoãn, lý do: …" for a deferred category, "Ghi chú: ý tưởng không dùng AI" for an AI item that does not apply.
5. Keep the template's Notes section.

## 3. How to judge the items

Read the file or section each item names. Judge from what is written, the same way on every run.

**Readiness items** (both files). Check each category against `coverage.md` and against its section:

- Problem (A), outcome (C), alternatives (D) and scope (E) pass only when `clear` and their sections hold no gap for a required element.
- AI fit (F) passes when `clear`, or when the AI-fit section and the user stories show the idea uses no AI (rules or plain automation only); note which.
- Cost (M) passes when a small, medium or large size is written in `## Cost & Risk`, even if the scenarios are still open.
- "Every other category" passes when each is `clear`, or `deferred` with a reason in `coverage.md`. List the ones that fail in the note by plain name ("nhóm người dùng", "kết nối hệ thống"), not by code.

**Content items** (slides, tech sections). Check the named section for each element the item lists. An element whose category is `deferred` with a reason passes, with a note, because the output shows the gap openly. Some items need judgment:

- **One takeaway per slide** (board): for each slide's source section, can one sentence state its point as a title? It fails when a section mixes two decisions or two messages, or has no point at all; name the slide in the note.
- **Testable stories and requirements** (tech): each story has its priority and at least one Given/When/Then scenario; each requirement has an `FR-###` id and says what must happen in a way someone could check; a requirement with a vague quality word and no number fails.
- **Success criteria match the outcome** (tech): the `SC-###` items measure the same metric, target and time frame as `## Outcome`; a different number or metric fails.
- **Glossary** (tech): every business term the tech sections use and the user might read differently has a line in `glossary.md`.
- **Open questions** (tech): each Q-### has `owner` and `blocking` filled.
- **Spec Kit headings** (tech): compare the requirement's headings with the requirement template's; every mandatory heading and subheading pattern is present and unchanged, the business sections come before "User Scenarios & Testing", and none replaces a Spec Kit section. A changed heading fails even when the content is good.

**Evidence items** (both files):

- **Numbers**: scan every figure in `spec.md` and `plan.md`. Each needs unit, source, period and the measured or assumed label; the same figure must be identical wherever it appears. Name the first few that fail in the note.
- **No missing facts**: a slide or section that could only be written by adding a fact the files do not hold fails (for example a decision requested with no amount on file).
- **Tech-review label**: while `estimate_status` is `not-tech-reviewed`, every estimate in `spec.md` and `plan.md` carries the "not tech-reviewed" label in the idea's language; once it is `tech-reviewed`, a `tech-review` entry exists in `decisions.md` and no estimate still carries the label. A mismatch between `coverage.md` and `decisions.md` fails.
- **Gaps listed**: every element still `chưa làm rõ` is written as such in its section, not left blank or dropped.
- **Dismissed risks** (board): each `dismissed-risk` entry in `decisions.md` also appears in `## Cost & Risk`.
- **Ground rules** (board): passes when the plan's ground-rules section cites each current `ground-rule-conflict` D-###, or says the plan fits, or, when `constitution.md` has `status: deferred`, says the ground rules are not set. A conflict found in the files that has no decision entry fails.

## 4. Hand the result to packaging

Return to the package module, for each file:

- whether every item passed;
- each failed item: its id, the note, and the coverage categories to reopen, from the table below.

Which failures mean what, so packaging can decide:

- A failed **readiness** item means the idea is below the readiness threshold: packaging offers to continue the interview or to export a labelled draft.
- A failed **content** or **evidence** item is a gap: it goes back to the interview through the router, or, in a labelled draft, shows as "not yet clarified".
- A failed **Spec Kit headings** item is a repair of the requirement file, not a question for the user.

| File | Items | Categories to reopen |
|---|---|---|
| board | CHK001–CHK006 | A, C, D, E, F, M in order |
| board | CHK007 | each category named in the note |
| board | CHK008, CHK014, CHK016 | M (the plan); CHK016 also the pilot design behind D or M |
| board | CHK009 | A |
| board | CHK010 | C |
| board | CHK011 | D |
| board | CHK012, CHK013 | E |
| board | CHK015 | K, and C for the kill criteria |
| board | CHK017–CHK023 | the category of the section the note names |
| board | CHK024 | the plan's ground-rules check |
| tech | CHK001–CHK004 | A, C, D, E; F; M; each category named in the note |
| tech | CHK005 | A, C, D |
| tech | CHK006–CHK008 | E, and O for the scenarios |
| tech | CHK009 | G |
| tech | CHK010 | H |
| tech | CHK011 | C, O |
| tech | CHK012 | F |
| tech | CHK013 | I |
| tech | CHK014 | J |
| tech | CHK015 | N |
| tech | CHK016 | the category of each open question named |
| tech | CHK017–CHK019 | none: repair the requirement file's structure |
| tech | CHK020–CHK023 | the category of the section the note names |

Leave the idea's `status` and every coverage status as they are; the package module and the router act on the result.

Tell the user in one or two plain sentences what is ready and what is missing, by what it means for the board or the tech team, without item ids, file names or paths, for example: "Phần trình ban lãnh đạo còn thiếu hai điểm: mức hiện tại của chỉ số cần cải thiện và thời hạn cần quyết. Phần cho đội kỹ thuật đã đủ."
