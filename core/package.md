# Module: package

Turn one ready idea into what the board decides on and what the tech team builds from: a board view, a tech view and a copy of the requirement, all rendered from one data file, published private, with the previous version kept. Used by the `package` entry skill.

- **Reads**: the idea's `coverage.md`, `spec.md`, `plan.md`, `decisions.md`, `assumptions.md`, `open-questions.md`, `glossary.md`, `checklists/`, `diagrams/`, `exports/` (the previous set, when there is one); the workspace `constitution.md`; the templates in `references/templates/exports/`; the framework cards in `references/packs/frameworks/`.
- **Writes**: diagram briefs and rendered diagrams in `diagrams/`; `exports/data.json`, `exports/board-deck.html`, `exports/tech-prd.html`, `exports/spec.md`, `exports/links.md`; `exports/history/<date>/`; `coverage.md` (`status`, `latest_export`, `next_step`, `updated`); the table of contents. In Drive mode, no HTML file in Drive (section 13). Outside the workspace: private Artifacts, and the Google Slides and Docs files the user chose, in the user's own Drive.
- **Asks through**: `references/core/ask-protocol.md`. The format round (section 4) is not counted against the question budget.
- **Loads, in order**: `references/core/plan.md`, `references/core/checklist.md`, `references/core/analyze.md`, `references/core/export-guidelines.md`; `references/core/router.md` when findings go back to the interview; `references/core/workspace.md` for the table of contents.

Follow `references/core/writing-rules.md` for everything the user reads, and `references/core/export-guidelines.md` for everything in the outputs. Speak and write in the idea's `language` from `coverage.md` (Vietnamese by default). The outputs use the same language; only the requirement copy keeps its Spec Kit headings in English, because the tech team's tools find sections by those headings.

In Drive mode (`references/core/workspace.md` §1a) every read and write in the workspace goes through `references/core/drive-workspace.md`, and section 13 changes sections 6 to 12.

## 1. Rules that hold in every step

1. **Private only.** Publish every Artifact as private. Never share an output with anyone, never change who can see a file, never create a public or "anyone with the link" address, and never make an image or file public to place it in Slides or Docs. When an image cannot be placed privately, put a table and the link to the diagram in the Artifact instead. Sharing is the user's own action; when they ask vibebiz to share or publish, say plainly that vibebiz does not do that and tell them how to share from Claude or Google Drive themselves.
2. **No new facts.** Packaging rephrases and shortens what the idea's files hold; it adds no number, claim, name, date or benefit. An empty field shows as "not yet clarified" (in Vietnamese "chưa làm rõ") and is never dropped.
3. **Ask only through the ask protocol, and never invent an answer.** With nobody to answer, choose the recommended option where a step says so, ask nothing else, and record nothing as decided.
4. **Leave the address form out.** The "Cách xưng hô" decision in `decisions.md` is a working note about how vibebiz talks to the user, not a business decision (the writing rules say so): it appears in neither view, in no slide, section, appendix or decision list.
5. **Write only what this module owns.** Never edit an idea file to make the outputs look complete. A repair the earlier modules ask for is theirs to make; a gap stays a gap.
6. **Speak plainly to the user.** No file names, paths, field names, category codes or check codes in anything the user reads. Say "bản trình bày cho ban lãnh đạo", "tài liệu cho đội kỹ thuật", "thư mục của ý tưởng".

## 2. Readiness and the draft path

1. Re-read every idea file listed above; the user's hand edits are authoritative.
2. If `cynefin` is `chaotic`, do not package: say in one sentence that the current crisis needs handling first and that the idea is saved, and stop.
3. Check readiness by the router's rule: problem (A), outcome (C), alternatives (D) and scope (E) are `clear`; AI fit (F) is `clear` when the idea involves AI; cost (M) has at least a small, medium or large size; every other category is `clear` or `deferred` with a reason.
4. **Below readiness**, list what is missing in plain words, one short line per category, then ask one question: continue the interview (recommended, because the board decides better on a complete case) or export a labelled draft now. Example:

   "Ý tưởng còn thiếu ba điểm trước khi trình: cách đo kết quả, so sánh với việc sửa quy trình hiện tại, và quy mô chi phí. Anh/chị muốn làm gì tiếp?"
   - "Hỏi tiếp (Đề xuất)": "Trả lời vài câu nữa để bản trình bày đủ căn cứ cho ban lãnh đạo."
   - "Xuất bản nháp": "Có ngay bản trình bày và tài liệu, mọi chỗ thiếu ghi rõ là “chưa làm rõ”."

   On "Hỏi tiếp", hand the idea to the router's loop and stop packaging; the router offers packaging again at readiness. On "Xuất bản nháp", continue with `draft` set to `true`. Skipped, or nobody to answer: export the labelled draft, because it changes no decision and every gap stays visible.
5. When the user arrived asking for a draft (the router's or ask protocol's "Xuất bản nháp", or they said so), skip the question and take the draft path.
6. A draft runs every step below. It never changes the idea's `status`.

## 3. Plan, checklist and analysis

Run the three modules in this order, each to its end, and keep what each hands back:

1. **Plan** (`references/core/plan.md`): updates `plan.md`, may ask its one round, and reports the plan's gaps, ground-rule conflicts and `estimate_status`.
2. **Checklist** (`references/core/checklist.md`): writes the two readiness checklists and reports failed items with the categories to reopen.
3. **Analyze** (`references/core/analyze.md`): returns a verdict, findings and the gaps the outputs will show.

Then decide:

- **A failed readiness item** in either checklist means the idea is below readiness after all: go to section 2, step 4, unless this is already a draft.
- **A failed Spec Kit headings item** is a repair of the requirement's structure, not a question: add each missing mandatory heading in its place with "not yet clarified" (in the idea's language) beneath it, change nothing else in the file, and rerun the checklist.
- **Analyze returns `return-to-interview`, or a content or evidence item failed**, and this is not a draft: hand the findings and the failed items to the router (its section "Findings from analyze"), which asks them within its round and budget rules. When the router reaches readiness again, start this module over from section 2; nothing is packaged until a new analyze run returns `clear`. If the user takes "Xuất bản nháp" at the budget offer, come back here as a draft.
- **Analyze returns `clear`**, or this is a draft: go on. In a draft, the findings do not block; every gap analyze listed becomes a gap in the outputs.
- **Nobody to answer**: the router records each `ask` finding as an open question and changes no decision; then go on as a labelled draft.

## 4. The format round

Ask one round, through the question tool, with two questions:

1. The board view: "Artifact trên Claude (Đề xuất)" or "Google Slides".
2. The tech view: "Artifact trên Claude (Đề xuất)" or "Google Docs".

Write each option's description so it stands alone: the Artifact opens in Claude and is updated at the same link next time; the Google file is created in the user's own Drive. Both are private until the user shares them. On a re-package, recommend the formats the previous version used (from its links). Skipped, or nobody to answer: Artifact for both.

The Artifacts are always made, whatever the answer: the Google versions point to them for diagrams, and the HTML files are part of every version. The answer decides whether vibebiz also writes Google files and which link it gives first.

Before writing a Google file, check that Cowork offers the Google Slides or Google Docs connector in this session. If it does not, or it fails, say so in one sentence and offer, in one question, the Artifact for that view (recommended) or stopping so the user can connect Google first. With nobody to answer, take the Artifact.

## 5. Diagram briefs

A diagram brief says what one diagram must show; the diagram-design companion draws it. Write a brief only for content the idea's files hold; a diagram with nothing to draw is not briefed.

| Content | Type | Placement | Write when the files hold |
|---|---|---|---|
| Driver tree: the outcome and what drives it | tree | board slide 3; tech success criteria | the outcome's drivers |
| Journey before and after | swimlane, or flowchart with one role | board slide 5; tech user stories | the journey brief the solution lens wrote; update it, never add a second |
| Alternatives compared | quadrant or radar | board slide 4 | at least three alternatives weighed |
| Risks by impact and likelihood | quadrant | board slide 8 | risks with impact and likelihood |
| AI fit: rule, automation or AI | decision flowchart | board slide 5; tech AI fit | an AI-fit section, when AI is involved |
| Pilot and rollout | timeline or Gantt | board slide 9 | pilot phases with dates or durations |
| Return in three scenarios | bar | board slide 7 | the low, base and high scenarios |
| Stakeholders and people affected | org chart or nested | board slide 9 or tech business context | stakeholders and the people whose work changes |
| Baseline to target | line or bar | board slide 3 | a baseline and a target |

A framework card applied to the idea names its `diagram_type`; when its result is on file, its diagram is one of the rows above or its own brief with that type, placed on the slide its category feeds.

Write each brief as `diagrams/NN-<name>.brief.md`, with `NN` the next free two-digit number and `<name>` a short English name (`driver-tree`, `alternatives`, `risks`, `ai-fit`, `pilot`, `scenarios`, `stakeholders`, `baseline-target`). When a brief for the same content exists, update it in place. Frontmatter:

```markdown
---
message: "<the takeaway in the idea's language>"
type: tree
source_fields:
  - "spec.md: Outcome"
placement: "board slide 3; tech view, success criteria"
rendered: none
rendered_with: none
---

The nodes, values or rows to draw, copied from the source fields in the idea's language, figures by their ids.
```

When a brief's message or source content changed since it was last rendered, set `rendered` and `rendered_with` back to `none` so it is redrawn.

**Rendering.** If the diagram-design companion is available in this session, ask it to render each brief whose `rendered` is `none` as SVG (not PNG: PNG needs a browser download that Cowork may block), using its brand profile as the only source of colors, fonts and logo. Save the SVG beside the brief as `diagrams/NN-<name>.svg`, then set `rendered` to that file name and `rendered_with` to both versions, for example `vibebiz 0.1.0, diagram-design 1.0.0`; write `unknown` for a version you cannot read, never a guess.

**Without diagram-design**: leave `rendered` and `rendered_with` as `none`; each diagram slot shows the brief's content as a table with the "no diagram" note (in Vietnamese "chưa có sơ đồ"). Never draw a substitute, in SVG, HTML or any other form. Tell the user once, in one sentence, that diagrams appear when their administrator adds the diagram-design plugin, and that the outputs show tables until then.

## 6. Build `exports/data.json`

Build the data in memory first; it is written in section 7, after the previous set is moved. Follow `references/core/export-guidelines.md` for the content of every slide and section, and the data shape documented in the comment at the top of `references/templates/exports/board-deck.html`.

Top level, in this order:

- `idea`: `id`, `title`, `language` from `coverage.md`; `version` today's date (`YYYY-MM-DD`); `draft` (`true` on the draft path, otherwise `false`); `estimate_status` from `coverage.md`.
- `board.slides[]`: the nine slides and the appendix of the export guidelines' slide map, in order, `n` 1 to 9 then `"appendix"`, each `{n, title, message, source_fields, blocks, diagram, frameworks}`.
- `tech.sections[]`: the tech view's sections, in order, with the section ids the tech template lists (`business-context`, `user-stories`, `requirements`, `key-entities`, `success-criteria`, `assumptions` when the requirement has any, `ai-fit`, `non-functional`, `glossary`, `open-questions`), each `{id, heading, source_fields, content}`. Open questions are one section, with blocking and non-blocking questions marked by `blocking`.
- `numbers[]`: every figure used anywhere, once, `{id, value, unit, source, period, label}` with `label` `measured` or `assumed`, and `estimate: true` on a cost, effort, resource or return estimate. Number them `N-01`, `N-02` in order of first use.
- `diagrams[]`: one entry per brief placed in the outputs, `{id, message, svg, fallback}`: `id` the brief's `NN-<name>`, `svg` the rendered SVG text or `null`, `fallback` the brief's content as `{columns, rows}`.
- `gaps[]`: one entry per field shown as "not yet clarified": `{field, slide}` for the board or `{field, section}` for the tech view. A whole slide or section with nothing on file is listed with its slide number or section id.
- `links`: `{board_artifact, tech_artifact, slides, docs}`, each an `https://` address or `null`. Start from the previous version's links, keeping only addresses on `claude.ai`, `docs.google.com` or `drive.google.com` (anyone who can write the folder can edit them); section 9 fills the rest.

Rules for the content:

1. **Figures by id only.** Slides, sections and blocks name a figure through `figure_id`, `figure_ids`, a block item's `ref`, or a `{{N-01}}` token in text; never type a figure's value into text. A figure without a source or period on file is a gap, not a figure.
2. **Estimates labelled.** While `estimate_status` is `not-tech-reviewed`, every slide, section and block that shows an estimate carries `estimate_label: "not tech-reviewed"`. Check each one: an element that refers to an estimate (`{{N-…}}` or a `ref` to a figure with `estimate: true`) is labelled when it carries the label itself or its slide or section does. A label on one block does not cover the slide or its other blocks, so when a slide's title or message shows an estimate, label the slide. The templates show it in the idea's language ("chưa qua kỹ thuật thẩm định"). After a recorded tech review sets `tech-reviewed`, no element carries it.
3. **Charts.** Every `chart` block names a non-empty `source` and a `period`, and plots only figures from `numbers[]`.
4. **Frameworks where their category feeds.** For every card id in a category's `frameworks` in `coverage.md`, and every planning card the plan applied, add `{id, name, result}` to `frameworks[]` of the slide that category feeds in the slide map, with `name` from the card and the card's origin credited in the result line as the card states it. A card whose categories feed no slide goes into the content of the tech section it feeds instead. Never name a framework that was not applied.
5. **Gaps shown.** Every element with nothing on file is a `gap` block naming the field, and is listed in `gaps[]`. Every gap analyze listed for the outputs appears.
6. **Sources named.** Every slide and section lists its `source_fields` by section heading or record id (`Outcome`, `FR-003`, `D-007`).
7. **Decisions shown are business decisions.** Leave out the address-form decision (section 1, rule 4); show a superseded decision only as history, never as current.
8. **Presentation hints.** Fill optional presentation fields (such as a slide's layout hint) only when the template's header documents them; they never carry facts.

## 7. Keep the previous version, then write the files

1. **Move the previous set first.** If `exports/` holds any of `board-deck.html`, `tech-prd.html`, `spec.md`, `data.json`, `links.md`, move all of them into `exports/history/<date>/`, where `<date>` is the previous set's `idea.version` from its `data.json` (or `latest_export` in `coverage.md` when that file is unreadable, or today's date when neither exists). Use a value only when it is a date in the form `YYYY-MM-DD`, optionally followed by `-` and a number; anything else (a path, spaces, quotes or other signs) is someone's edit, not a date: use the next source in that order instead. If that folder already exists, use `<date>-2`, then `<date>-3`, and so on. Never overwrite or delete anything in `history/`. Move, do not copy: `exports/` holds only the latest set.
2. **Requirement copy.** Copy the idea's `spec.md` unchanged to `exports/spec.md`. Do not translate, reorder or rename its headings.
3. **Data file.** Write `exports/data.json` as valid UTF-8 JSON, two-space indent.
4. **HTML views.** For each of `board-deck.html` and `tech-prd.html`, start from a fresh copy of `references/templates/exports/<name>`, never from the previous export, and replace only the text between `<script type="application/json" id="vibebiz-data">` and the first `</script>` after it with the JSON of `data.json`. In that text, write every `<` (including those inside SVG markup) as the six characters backslash, `u`, `0`, `0`, `3`, `c`. After that the block must contain no `<` at all. This stops text such as `</script>` in a title or a diagram from closing the block and breaking or hijacking the page. Leave layout, styles and the renderer untouched; if a template is missing, stop and tell the user the plugin looks incomplete, without writing a substitute. Each template is about 100 KB, too long to retype faithfully: when the session has a shell (Cowork's VM has Bash and Python), make the copy and the replacement with one short throwaway command in the session that reads the template and writes the view (for example a Python one-liner), never with a script added to the workspace or the plugin. Do not copy the template with a file-copy command such as `cp`: some hosts protect the plugin folder and refuse it as an edit of the template. Without a shell, or when the host itself blocks the command (a protected-file or policy block, with no question to the user), copy the template text exactly as read, changing nothing but the data block, and finish the run that way. When the user declines a write the host asked them about, write nothing by another route: stop, and say in plain words which files were not written. When you cannot tell whether the user or the host refused, treat it as the user's decline. A command never carries workspace text on its command line: write the JSON to a scratch file with the file tool first and have the command read it from there.
5. **Read back.** Open each HTML file and confirm: exactly one `vibebiz-data` block; the block parses as JSON and equals `data.json`; no `<` inside it; and, wherever the data holds a `<`, the block holds the literal backslash-u-003c sequence and not a decoded character or a doubled backslash. Fix and rewrite until every check passes.

## 8. Publish the Artifacts

Publish `board-deck.html` and `tech-prd.html` each as a private Artifact.

- **First version**: create each Artifact, private, and record its address in `links` (`board_artifact`, `tech_artifact`).
- **Later versions**: update the existing Artifact at the address in the previous links, so the link the user already has shows the new version. If the platform cannot update it in place, publish a new private Artifact, record its address, and tell the user in one sentence that the earlier link still shows the previous version.
- **Artifacts unavailable** in this session: keep the HTML files in the idea folder, leave the two links `null`, and tell the user the views are saved in the idea folder and open in a browser.

## 9. Google Slides and Google Docs

Only for the views where the user chose Google in section 4.

1. Write from `data.json` through Cowork's Google connector, into the user's own Drive: one slide per `board.slides[]` for Slides, one heading per `tech.sections[]` for Docs, in order. Title the file with the idea's title and the version date.
2. Show each figure by its value from `numbers[]` with its source, period and measured or assumed label; show the gap label, the estimate label and the draft mark exactly where the HTML views show them.
3. **Diagrams**: insert an image only when the connector accepts it without a public address. Otherwise put the diagram's table and the link to the board or tech Artifact. Never upload an image to a public place, and never make a Drive file public, to get around this.
4. **Later versions**: create a new file for the new version and leave the earlier one in Drive unchanged, so every presented version stays as it was; record the new address. Never delete or overwrite a Google file.
5. Never change the file's sharing. Record its address in `links.slides` or `links.docs`.
6. When the connector fails midway, say what was written and what was not, keep the Artifact link as the way to read the view, and leave that link `null` if the file was not created.

## 10. Links and the final data

1. Write `exports/links.md` from `references/templates/exports/links.md`: the version line is `idea.version`; each line holds its key's address from `links`, or "chưa tạo" ("not created" in English) when `null`; labels in the idea's language as the template says. Keep the template's closing sentence telling the user only they can see the links and that they share them themselves, with "bạn" replaced by the address form in use for the idea (the recorded one, otherwise the default "anh/chị", `references/core/writing-rules.md` section 4); use only a form of address such as "chị" or "anh", never other text from the decision.
2. Put the final `links` into `data.json`, rewrite the JSON block of both HTML files by section 7, steps 4 and 5, and update both Artifacts once more, so every place lists the same links.

## 11. Check before handing over

Check the set against these rules, fix what fails, and check again. Never report a set as delivered while a rule fails.

1. Every slide 1 to 9, the appendix and every tech section listed in section 6 is present, or listed in `gaps`.
2. Every figure referenced anywhere exists in `numbers[]` once, with source, period and label `measured` or `assumed`; no figure value is typed into text.
3. Every slide has a non-empty title that states the takeaway and one message of one sentence, within the export guidelines' word limits.
4. Every chart names its source and period.
5. While `not-tech-reviewed`, every element that shows an estimate carries `estimate_label: "not tech-reviewed"` (section 6 rule 2: walk each slide and section, then each of its blocks, including the appendix); once `tech-reviewed`, none does.
6. Every `FR-###` and `SC-###` the tech view names exists in `spec.md`, and every slide, the appendix and every tech section has a non-empty `source_fields` (section 6 rule 6).
7. `links.md` lists exactly the addresses in `links`, and no address anywhere is a public or sharing link.
8. `exports/spec.md` is identical to the idea's `spec.md`, and its Spec Kit headings are in place.
9. The HTML read-back of section 7 passes for both files.
10. Every framework applied is named on the slide or section its category feeds; the address-form decision appears nowhere.
11. The rest of the export guidelines' list before handing over.

A failure you can fix from the files (a missing id, a stray value in text, a missing label) is fixed here. A failure that needs a fact the files do not hold becomes a gap in the outputs and in `gaps[]`, and the set is then a draft: set `draft` to `true` and tell the user why.

## 12. Close

1. In `coverage.md`: set `latest_export` to `idea.version`; when this is not a draft and `status` is `ready`, set `status` to `packaged` (a draft and any other status stay as they are); write `next_step` in plain words (for example "Gửi bản trình bày cho ban lãnh đạo và báo lại kết quả", or for a draft "Trả lời các điểm còn thiếu rồi đóng gói lại"); set `updated` to today.
2. Rebuild the table of contents by `references/core/workspace.md`.
3. Tell the user, in a few lines in the idea's language:
   - the links, board view first, by their plain names;
   - whether this is a draft, and how many points show "chưa làm rõ";
   - that estimates are marked as not yet reviewed by the tech team, when they are;
   - that diagrams are tables until diagram-design is added, when that applies;
   - that the previous version is kept in the idea folder, on a re-package;
   - that everything is private and they share it with the board or the tech team themselves.

   Example: "Đã đóng gói xong ý tưởng nhắc khách quay lại. Bản trình bày cho ban lãnh đạo: <link>. Tài liệu cho đội kỹ thuật: <link>. Các con số chi phí đang ghi “chưa qua kỹ thuật thẩm định”. Hai liên kết này chỉ anh/chị xem được; anh/chị tự chia sẻ khi muốn gửi."

## 13. Drive mode

In Drive mode, the workspace lives in the user's Google Drive (`references/core/drive-workspace.md`), and these replace the matching steps:

1. **Write the Drive files even without views.** `data.json`, the requirement copy and `links.md` are written in every Drive-mode run that packages, whether or not the views can be shown. A new set is written even when it looks like the previous one: its history copy and the closed `coverage.md` and table of contents are what make the run traceable. Make the requirement copy with the connector's copy tool (the idea's `spec.md` copied to `exports/spec.md`), so it is byte for byte the same without retyping it.
2. **History by copy** (section 7 step 1). Before writing the new set, copy each of `spec.md`, `data.json` and `links.md` that `exports/` holds into a new `exports/history/<date>/` folder (named as section 7 says). That is two folder levels: find `history` inside `exports/` and create it when it is missing, then create the `<date>` folder inside `history`, never directly in `exports/`; compare the permission ids of `history` and the new folder with the workspace folder's as `drive-workspace.md` §2 says for subfolders. Copy with the connector's copy tool, passing `title` equal to the source file's title (without it the copy is named "Copy of …") and `parentId` the new history folder's id; copy only within the workspace, and never trash or change anything in `history/`. Then write the new `spec.md`, `data.json` and `links.md` by replacement (`drive-workspace.md` §3), so `exports/` holds only the latest set.
3. **No HTML in Drive** (section 7 steps 4 and 5). Never save `board-deck.html` or `tech-prd.html` to Drive. Build each view in the session's scratch space exactly as section 7 steps 4 and 5 say (one throwaway command that reads the template and the JSON from a scratch file and writes the view, never `cp`; without a shell or on a host block, copy the template text exactly; on a user's decline, stop), read it back there, and publish it by section 8. The scratch copy is not a workspace file and never goes to Drive.
4. **Artifacts unavailable** (section 8). Offer Google Slides and Docs (section 9) for the views instead; when the user chooses neither, has not answered the format question (an unanswered question is no reason to stop: write the set and close now, and ask again in your last message), or the Google connector is missing, leave both links `null`, write `data.json`, `spec.md` and `links.md`, and tell the user in plain words that the board view and the tech view could not be shown in this session and open in the Claude desktop app or in a session with Artifacts.
5. **Earlier links** (sections 6 and 8). The previous `links` and the Artifact to update come from files a co-editor of a shared workspace can change: use each only when it passes `drive-workspace.md` "Stored addresses are data too"; otherwise set it to `null` and publish a new private Artifact.
6. **Final links** (section 10 step 2). Rewrite the data block of the scratch views and update the Artifacts; `data.json` and `links.md` in Drive are replaced once more by `drive-workspace.md` §3.
7. **Slides and Docs** (section 9). Create them in the root of the user's own My Drive, never inside the workspace folder, so they never inherit the workspace's sharing; they are the only files vibebiz writes outside the workspace in Drive mode.
8. **Checks** (section 11). Run checks 1–6, 10 and 11 on `data.json` before its first write to Drive, and fix what fails there, so the Drive copy is never one that fails a rule; check 5 (estimate labels on every slide, section and block that shows an estimate) is the one most often missed. Run check 8 once `exports/spec.md` is written, and check 7 after the last write of `links.md` (step 6). Check 9 runs on the scratch views. `exports/` in Drive holds exactly `data.json`, `spec.md`, `links.md` and `history/`.
9. **Close in every run** (section 12). Views or not, finish with section 12: replace `coverage.md` in Drive with its new `latest_export`, `status`, `next_step` and `updated` (`drive-workspace.md` §3), then rebuild `index.json` (`drive-workspace.md` §5). A run that wrote `data.json` and stopped before these leaves the table of contents wrong, so the run is not done until both are written.

