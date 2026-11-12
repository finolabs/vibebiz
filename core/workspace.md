# Workspace module

Every entry skill loads this module first. It finds the user's working folder, decides what state the folder is in, creates or repairs the workspace, numbers and names idea folders, and rebuilds the table of contents (`index.html`) after every write. The layout is a public contract: names are fixed and English, and only the idea slug varies.

**Reads**: the working folder, `constitution.md` frontmatter, every idea's `coverage.md` frontmatter, the plugin's `templates/` folder.
**Writes**: workspace scaffold, idea folders, `index.html`.
**Fills**: layout and table of contents only; never a coverage category.

## 1. Find the working folder (every entry skill, before anything else)

1. Look for the folder the user opened in Cowork: a user-chosen folder you can read and write with your file tools. A scratch or temporary location the platform gave you is not a working folder.
2. If there is none (this is claude.ai chat, which has no working folder), say so plainly and stop. Write nothing, ask nothing else, do not continue partway. Use the user's language, Vietnamese by default:
   - Vietnamese: "vibebiz cần chạy trong Cowork với một thư mục đã mở, vì mọi ý tưởng được lưu thành tệp trong thư mục đó. Bạn mở Cowork, chọn một thư mục làm việc, rồi gõ lại lệnh này nhé."
   - English: "vibebiz needs Cowork with a folder open, because every idea is saved as files in that folder. Open Cowork, choose a working folder, then run this command again."
3. The skills that work without a workspace (`help` answering a documentation question) skip steps 4 onward and write nothing.

Why: an entry skill that runs without a folder would lose every answer when the chat ends; the user would not know why.

## 2. Locate the workspace root and the plugin's templates

**Workspace root**: the opened folder, or its `vibebiz/` subfolder when the user chose a subfolder earlier. Check the opened folder first, then `vibebiz/`. Everything below is relative to the root, and nothing is ever written outside it.

**Templates**: the plugin ships `templates/` at the plugin root, which is two levels above a skill's own folder.

1. From the folder that holds your `SKILL.md`, read `../../templates/workspace/index.html`. If that file opens, `../../templates/` is the templates folder.
2. If it does not open, look at the nearest parent folders of your skill folder (up to four levels) for a folder named `templates` that holds `workspace/index.html` and `idea/coverage.md`.
3. If you still cannot read the templates, stop the scaffold. Tell the user in plain words that the plugin looks incomplete and ask them to reinstall it. Write no workspace file: do not recreate a template from memory, because fixed templates keep every workspace identical and checkable. Work that needs no new file (reading an idea, answering `status` from existing files) may continue.

Why: resolving a path outside the skill folder is not yet confirmed in Cowork (the first smoke test checks it), so the lookup has a fallback and a safe stop.

## 3. Folder state

Ignore hidden files and operating-system litter (`.DS_Store`, `Thumbs.db`). A file counts as vibebiz's own only when it matches its marker:

| Piece | Marker |
|---|---|
| `index.html` | contains the `<script type="application/json" id="vibebiz-data">` block |
| `constitution.md` | frontmatter with `status` of `set` or `deferred` |
| `specs/` | holds at least one folder named `NNN-<slug>` |

A file with a required name that does not match its marker is the user's own file. Never overwrite it, never rebuild it.

| State | Test | Action |
|---|---|---|
| Empty | no files left after ignoring litter | scaffold (section 4), then intake |
| Complete | `index.html`, `constitution.md` and `specs/` all present and matching their markers | no scaffold; intake |
| Partial | at least one vibebiz piece present, at least one missing | restore only what is missing and list it (section 5); intake |
| Unrelated files | files exist, none is a vibebiz piece | ask: use this folder or a `vibebiz/` subfolder (below) |

Unrelated files may sit beside a workspace; they never change a Complete or Partial state. If a required name is taken by the user's own file (for example their own `index.html`), treat the folder as Unrelated and ask.

**Ask for Unrelated files** with `AskUserQuestion` (ask-protocol module): one question, two options, recommended first: a `vibebiz/` subfolder (recommended: keeps the user's files untouched) or this folder. Word it without folder jargon, for example "Thư mục này đang có sẵn tệp khác. Mình lập không gian làm việc ở đâu?" with "Thư mục con mới tên vibebiz (khuyên dùng)" and "Ngay trong thư mục này". Skipped or nobody to answer: use the `vibebiz/` subfolder and record that as an assumption in the idea's `assumptions.md` once the idea exists.

## 4. Scaffold

Create, from the templates, only what the state calls for:

1. `index.html` from `templates/workspace/index.html`.
2. `constitution.md` from `templates/workspace/constitution.md` (status stays `deferred`; the `constitution` skill sets ground rules).
3. `specs/` (empty folder).

`examples/` is never created here; the example returns only when the user asks for it (`help`).

An idea folder (`specs/NNN-<slug>/`, section 6) is created from `templates/idea/`: `spec.md`, `coverage.md`, `plan.md`, `decisions.md`, `assumptions.md`, `open-questions.md`, `glossary.md`, `checklists/board.md`, `checklists/tech.md`, plus the empty folders `diagrams/` and `exports/`. The files `board-deck.html`, `tech-prd.html`, `spec.md`, `data.json` and `links.md` inside `exports/` are made by `package`, not here.

**Placeholders.** A template marks values to fill as `{{...}}` on its live lines (lines inside comments are guidance and stay as they are). Replace every one on a live line:

- Structural values you know: `{{NNN}}`, `{{slug}}`, `{{YYYY-MM-DD}}` (today's date from the session), the idea title, the language and vertical the caller (the specify module) passes in.
- When the braces hold an example default (`{{vi}}`, `{{fashion}}`, `{{VND}}`, `{{complicated}}`) and no value is known, keep that default as the value. The router revises `cynefin` after intake.
- When the braces hold a description (`{{next step}}`, `{{Idea title}}`) and nothing is known, write "not yet clarified" in the user's language.

Leave no `{{` on a live line of a file you wrote. Never mark a category `clear` while scaffolding; every category starts `missing` as the template says.

**Write rules.** Never overwrite: before creating any file, check it does not exist; if it does, leave it untouched. Re-read a file just before changing it, because the user may have edited it by hand, and hand edits win. If a write fails, report the file name and what is left undone; do not retry by overwriting.

## 5. Repair a partial workspace

1. List what is missing: workspace pieces, and for every folder in `specs/`, any missing file or folder from the idea layout in section 4. A deleted `index.html` counts as missing and is restored from the template, then rebuilt (section 7).
2. Create only the missing items from the templates. Existing files are never touched, even when they differ from the template.
3. A restored `coverage.md` starts with every category `missing`: take the id and slug from the folder name and the title from the first heading of `spec.md` (the folder name if there is none). Tell the user the coverage record was rebuilt, and let the router re-derive statuses from the spec at the next round rather than guessing them here.
4. Report every restored item to the user in plain words ("Mình đã tạo lại: mục lục, nguyên tắc chung"), without file paths where a plain name will do. Say nothing when nothing was missing.

## 6. Number and name an idea folder

- **Number `NNN`**: scan `specs/` for folders named `<digits>-<anything>`. Take the highest number and add one, as three digits with leading zeros (`001`, `014`). Numbers are never reused, so a gap left by a deleted folder stays a gap. `examples/` folders are excluded from numbering; the example is always `000`. If the highest number is 999, stop and tell the user, since the layout allows three digits.
- **Slug** from the idea title:
  1. Strip diacritics: decompose to NFD and drop combining marks; map `đ` to `d` and `Đ` to `D` first, because they do not decompose.
  2. Lowercase.
  3. Replace every run of characters that are not `a-z` or `0-9` with one hyphen.
  4. Trim hyphens at both ends.
  5. If longer than 40 characters, cut at the last hyphen before the limit.
  6. If nothing is left (a title with no Latin letters or digits), use `idea`.

  Example: "Nhắc khách mua lại qua Zalo" becomes `nhac-khach-mua-lai-qua-zalo`, so the folder is `specs/001-nhac-khach-mua-lai-qua-zalo/`.
- Two ideas with the same slug stay distinct through the number prefix.
- The folder name never changes after creation, even if the title is later edited; the `title` field in `coverage.md` carries the current title.

## 7. Rebuild the table of contents after every write

Run this as the last step of any action that wrote or changed a workspace file, including the scaffold, a round write-back, a status change and a package. It also runs when the user deleted `index.html` and you restored it. `status` writes nothing but this.

Only the JSON block inside `index.html` changes; the layout, styles and renderer in the file stay exactly as they are.

**Build the data from frontmatter** (the frontmatter is the source of truth; never from memory of earlier rounds). Key order as below, two-space indent:

- `workspace`: `updated` is today's date; `ground_rules_status` is `status` from `constitution.md` frontmatter (`set` or `deferred`; `deferred` when the file or the field is missing).
- `ideas[]`: one entry per folder in `specs/` named `NNN-<slug>`, ascending by number, none left out, none invented. Each entry:
  - `id`, `title`, `status`, `estimate_status`: from `coverage.md` frontmatter (`id` as three-digit text).
  - `coverage`: `{ "clear": <count of categories A–O whose status is clear>, "total": 15 }`. Deferred, partial and missing do not count as clear.
  - `next_step`: the `next_step` value from that idea's `coverage.md`, copied as written (the router writes it after every round). If it is empty or absent, use `/vibebiz:continue`.
  - `outputs`: a list of `{ "label", "href" }` for what exists now, in this order, never for anything absent:
    1. `exports/board-deck.html`: label "Bản trình bày cho ban lãnh đạo", href `specs/NNN-<slug>/exports/board-deck.html`.
    2. `exports/tech-prd.html`: label "Tài liệu cho đội kỹ thuật", href likewise.
    3. every `https://` link recorded in `exports/links.md` (Artifact, Slides, Docs), label taken from the name written beside it.

    Hrefs are relative to the workspace root, or `https://` only. No other scheme, no absolute paths. Use English labels instead when the idea's `language` is `en`. An idea with no exports has `"outputs": []`.
  - `updated`: `updated` from `coverage.md`.
- `examples[]`: the same entry shape for each folder under `examples/` (`000-<slug>`, numbered `000`), ascending by folder name; `[]` when there is none. Examples appear here and nowhere in `ideas[]`, `status` counts or numbering.

If an idea's `coverage.md` exists but its frontmatter cannot be read, still list the folder: `title` from the folder name, `status` `clarifying`, `estimate_status` `not-tech-reviewed`, `coverage` `{ "clear": 0, "total": 15 }`, `next_step` saying the coverage record needs repair, and tell the user. Do not edit that file here.

**Write the block safely.**

1. Compose the JSON as valid JSON: double quotes, escaped inner quotes and backslashes, no trailing commas, line breaks inside strings written as `\n`.
2. Escape every `<` inside the JSON text as `\u003c` (backslash, `u`, `0`, `0`, `3`, `c`). After that, the block must contain no `<` character at all. This is what stops a title or next step such as `</script>` from closing the block early and breaking the page or injecting markup. Keep other characters as they are, including Vietnamese letters.
3. Replace only the text between `<script type="application/json" id="vibebiz-data">` and the first `</script>` after it. Leave everything else in the file untouched.
4. If `index.html` is missing, restore it from the template first and then replace the block. If it exists but has no such block, it is the user's own file: do not touch it, tell the user the table of contents was not updated and why.

**Check after writing.** Read the file back and confirm: exactly one `vibebiz-data` block; the JSON parses; `ideas` lists exactly the `NNN-<slug>` folders present in `specs/` and `examples` exactly those under `examples/`; no `<` inside the block. Fix and rewrite the block if any check fails. Never claim the table of contents is up to date without this read-back.

## Contract boundaries

- File and folder names are fixed English names from the workspace contract; only `<slug>` varies.
- No file is written outside the workspace root, except the Google files `package` creates in the user's Drive at the user's request.
- Nothing is made public or shared.
