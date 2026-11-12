# Module: specify

Turn the user's first description of an idea into a new idea folder, a draft requirement with every gap marked, and the first coverage record. Used by the `new` entry skill after the workspace is ready (`references/core/workspace.md`).

- **Reads**: the user's description of the idea and their answer to the intake question; `constitution.md` (for `vertical`); the existing `specs/` folders (for the next number).
- **Writes**: `specs/NNN-<slug>/` created from `templates/idea/`; `spec.md` (draft); `coverage.md` (frontmatter and body table).
- **Fills**: the initial status of every category A–O. Later rounds belong to the router (`references/core/router.md`).

Follow `references/core/writing-rules.md` for everything the user reads and `references/core/ask-protocol.md` for how questions are asked.

## 1. Ask one open intake question

Ask exactly one open question, in plain text (not the question tool), about the situation behind the idea: what is happening today that made the user think of it. Ask for a real, recent case, not a hypothetical, because a concrete case reveals the problem, the people and the cost far better than a description of the solution.

Example in Vietnamese:

> Trước khi đi vào giải pháp, bạn kể giúp lần gần nhất chuyện này xảy ra: chuyện gì đã diễn ra, ở cửa hàng hay kênh nào, ai bị ảnh hưởng và việc đó tốn của bạn những gì?

- Ask nothing else in this step. Choices and multiple-choice rounds start in the router.
- The intake question is not a question round and does not count toward `budget_rounds_used`.
- If the user already described a real, recent case in their first message, do not ask again; use what they wrote.
- If nobody can answer (an unattended or evaluation run), do not invent a situation: continue with the first message alone and record what is missing as `missing`.

## 2. Set the language

Set `language` from the user's first substantive message about the idea (a message that describes the idea, not a greeting or a command): `vi` for Vietnamese, `en` for English, otherwise its language code. When it is unclear or mixed, use `vi`. Use this language for every question and output of this idea from now on, in this session and in later ones.

## 3. Name the idea and create its folder

1. Write a short title (at most about eight words) in the idea's language that names the problem or the outcome in the user's own terms, for example "Nhắc khách quay lại mua lần hai". Do not name a technology the user did not choose.
2. Derive the slug from the title: remove diacritics (đ becomes d), lowercase, words joined by single hyphens, only `a-z`, `0-9` and `-`; keep it short by dropping filler words if needed. Example: "Nhắc khách quay lại mua lần hai" becomes `nhac-khach-quay-lai-mua-lan-hai`.
3. Take `NNN` as the next free three-digit number after the highest existing `specs/NNN-*` folder (`001` when there is none). `examples/` never counts. The number keeps two ideas with the same slug apart.
4. Create `specs/NNN-<slug>/` from `templates/idea/` by the workspace module's rules: create only missing files, never overwrite an existing file, and fill the `{{...}}` placeholders. If the folder already exists, stop and take the next free number instead; never write into another idea's folder.

Fill `coverage.md` frontmatter as follows:

| Field | Value |
|---|---|
| `id`, `slug`, `title` | from step 3 |
| `language` | from step 2 |
| `vertical` | `vertical` from `constitution.md` when its status is `set`; otherwise the vertical the user named; otherwise `not yet clarified` in the idea's language |
| `cynefin` | `complicated` as a provisional value; the router owns this field and revises it |
| `status` | `clarifying` |
| `estimate_status` | `not-tech-reviewed` |
| `budget_rounds_used` | `0` |
| `latest_export` | `null` |
| `next_step` | see step 7 |
| `created`, `updated`, every category's `updated` | today's date, `YYYY-MM-DD` |
| `categories` | statuses from step 5; keep `prerequisites` and `filled_by` exactly as in the template |

## 4. Draft the requirement

Edit the new `spec.md`; keep every heading exactly as written in the template, in every language, because the tech team's tools rely on them.

- **Title line**: replace `[FEATURE NAME]` with the title.
- **Feature Branch**: `NNN-<slug>`. **Created**: today's date. **Status**: `Draft`.
- **Input**: record the idea in the user's words: `User description: "<first message, verbatim>"`. When the intake answer added to it, append it in the same line, verbatim, after the first message. Do not correct, translate or summarize their words.
- **Business sections** (Problem & Why, Outcome, Alternatives, AI-fit, Cost & Risk): write only what the user actually said, in the idea's language, close to their wording and with no figures they did not give. Every element the section's comment lists that has no answer yet is written as the phrase for "not yet clarified" in the idea's language (`chưa làm rõ` in Vietnamese, `not yet clarified` in English), so every gap is visible.
- **Numbers**: a figure the user gave gets its source (the user, today), its period when they gave one, and the label `assumed` unless they said it was measured. A baseline the user did not give is a gap, never an estimate of yours.
- **Clarifications**: add `### Session YYYY-MM-DD` with one bullet `- Q: <intake question> → A: <answer>` when the intake question was asked and answered.
- **Spec Kit sections** (User Scenarios & Testing, Requirements, Success Criteria, Assumptions): replace the template's bracketed example placeholders with draft content or the "not yet clarified" phrase; keep the headings and subheading patterns (`### User Story 1 - <title> (Priority: P1)`, `### Edge Cases`, `### Functional Requirements`, `### Key Entities`, `### Measurable Outcomes`) and the `FR-###` and `SC-###` id formats. Draft User Story 1 from the situation the user described when they gave enough for it; otherwise leave its fields as "not yet clarified". Write a functional requirement only for behavior the user asked for; a vague quality word such as "nhanh", "thông minh" or "real-time" stays out of the requirement until the router has asked for a measurable value (`references/core/writing-rules.md`).
- Leave the HTML comments in place; later modules follow them.

## 5. Set the initial category statuses

For each category A–O (the elements are listed in the router's frontier table, `references/core/router.md`), judge it only against what the user wrote:

- `clear`: every element the category lists is stated by the user (rare at intake).
- `partial`: the user said something that belongs to the category, but not all of it.
- `missing`: nothing yet.

Never set `deferred` at intake; it needs the user's own reason. Never mark a category `clear` because its answer seems obvious; obvious answers are where ideas go wrong. Typical intake results: A and B `partial`, sometimes C or E `partial`, the rest `missing`. Set `reason: null` for every category.

Then rebuild the body table of `coverage.md` from the frontmatter and update the "Clear: N of 15" line. The body is in the idea's language; frontmatter keys and values stay in English.

## 6. Show what is clear and what is missing

Show the user a short table, in the idea's language, with one row per category, its plain name and its status word, followed by one sentence on what comes next. Do not show codes, field names or file paths. Vietnamese names and status words:

| Category | Vietnamese name |
|---|---|
| A | Vấn đề và lý do |
| B | Người dùng và các bên liên quan |
| C | Kết quả mong muốn và cách đo |
| D | Các phương án khác |
| E | Phạm vi và cách hoạt động |
| F | Có cần AI hay không |
| G | Dữ liệu |
| H | Kết nối với hệ thống khác |
| I | Yêu cầu vận hành (số người dùng, giờ cao điểm, thiết bị) |
| J | Tình huống ngoại lệ và lỗi |
| K | Rủi ro và tuân thủ |
| L | Thay đổi trong tổ chức |
| M | Chi phí, nguồn lực và lợi ích |
| N | Thuật ngữ |
| O | Dấu hiệu hoàn thành |

Status words: `clear` → "Đã rõ", `partial` → "Rõ một phần", `missing` → "Chưa có". Keep the table to the fifteen rows; no commentary per row.

## 7. Set the next step and hand over

1. Write `next_step` in the idea's language: one short action naming the first topic the router will ask about, for example "Trả lời vòng câu hỏi đầu tiên về vấn đề và người bị ảnh hưởng". The router overwrites it after every round.
2. Set `updated` to today and rebuild the table of contents by the workspace module's rules.
3. Hand over to the router to start the first round. If the intake already shows two independent problems, the router proposes the split before its first round.
