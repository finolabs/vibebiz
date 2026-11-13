# Clarify

Fill the gaps no thinking lens owns, and tidy what the lenses left half done. This module adapts Spec Kit 1.4.0's `clarify` pass (its coverage scan, its question quality rules and its way of writing answers back into the spec) to vibebiz's rounds and to a reader who is not technical. It is asked to work by the router; it never chooses the frontier itself.

- **Used by**: router.
- **Reads**: `spec.md`, `coverage.md`, `glossary.md`, `decisions.md`, `open-questions.md`, `assumptions.md`, `constitution.md`, the vertical pack when the idea's `vertical` has one.
- **Writes**: `spec.md` (Clarifications, Key Entities, Requirements, Assumptions, and the section of any leftover category), `glossary.md`, `coverage.md`, plus the records the ask protocol writes (`decisions.md`, `open-questions.md`, `assumptions.md`).
- **Fills**: G (data and entities), H (integrations), N (terminology), and leftover `partial` categories the router hands over.

Ask every question through `references/core/ask-protocol.md`, write in plain language and address the user by `references/core/writing-rules.md`, and keep to the round the router gives you.

## 1. What each category needs to be clear

Use these lists for the scan (section 2) and to set the status after a round (section 6). Each item is a business fact or decision, never a technical design.

**G. Data and entities** (prerequisite E). For each thing the idea keeps or uses (customer, order, product, store, voucher, message…):
- what it is in the user's words and the few facts kept about it (for a customer: phone number, member tier, last purchase date);
- how one is told apart from another (is a customer who buys online and in store the same customer, and by what: phone number, member card);
- where the data comes from today, who owns it (a role, such as "phòng CRM"), and how trustworthy it is (complete, out of date, duplicated);
- the states it moves through when that matters (a voucher: issued, used, expired);
- rough volume in plain numbers (how many customers, orders per day), with source, period and a measured or assumed label.

**H. Integrations** (prerequisites E, G). For each system the idea must work with (point of sale, ERP, marketplaces, chat apps such as Zalo, logistics, the loyalty program):
- what goes in or out and in which direction, in business words ("lấy lịch sử mua từ máy bán hàng", "gửi tin qua Zalo OA");
- how fresh it must be, as a number ("cập nhật mỗi đêm", "trong 15 phút");
- what happens for the user when that system is unavailable;
- who owns the system or the vendor relationship.
An idea whose chosen alternative needs no system (for example "fix the process") has nothing to integrate: write that sentence in Requirements with the D-### that chose the alternative, and H is clear.

**N. Terminology** (no prerequisite). Every word the idea relies on has one meaning shared by everyone:
- business words the user uses that people in the company may read differently ("khách VIP", "khách quay lại", "tồn kho", "đơn hoàn");
- two words used for the same thing in the idea's files (choose one);
- unquantified quality words from the writing rules' list, which must become a number or an open question.

**Leftover partial categories**. When the router hands over a category another module owns that is still `partial` and only details remain (a missing number, an unclear word, a "not yet clarified" placeholder, a `[NEEDS CLARIFICATION]` marker, a vague adjective), check it against that category's elements in the router's frontier table (`references/core/router.md`) and the owning module's list, and ask only about the missing details. If what is missing is a new line of thinking (for example the alternatives were never compared), do not ask: return it to the router for its owning lens.

## 2. Scan before asking

1. Re-read every file listed under **Reads**; the user's hand edits win over anything you remember.
2. For each category you were handed, mark each item in section 1 as answered, partly answered or missing, from the files only.
3. Look facts up before turning them into questions (ask protocol, section 1): data sources, system names and volumes are often in the workspace or the user's connected documents. Ask only for the decision or the confirmation.
4. Drop a candidate question when:
   - the answer would not change scope, cost, the success measure, the acceptance tests or the board's decision;
   - it is about how to build (which database, which vendor's interface, which programming method); that belongs to the tech team and goes to `open-questions.md` with the tech team as owner only if it blocks a business decision;
   - the files already answer it.
5. If nothing material is left, ask nothing: update the statuses (section 6), tell the user in one sentence that nothing in these areas needs their decision, and return to the router.

## 3. Choose the questions

- Rank the remaining candidates by impact times uncertainty, as the router does (impact 1–3: how much the answer changes scope, cost or the board's decision; uncertainty 1–3: likely known, partly known, unknown).
- Spread the round across the categories you were handed before asking a second question in the same one, unless one high-impact gap clearly outweighs the rest.
- Keep within the round the router gave you and the ask protocol's limit of four questions. Never reveal questions you plan to ask later.

## 4. Write each question

Spec Kit's `clarify` asks one question at a time in text with a lettered table; vibebiz asks a batch through `AskUserQuestion`. Keep upstream's quality rules and adapt the form:

- **A real question, not a label.** The `question` text is a full question ending with "?" that makes sense alone. A topic name ("Nguồn dữ liệu khách hàng"), a category code or a requirement id is never a question; the topic goes in `header`.
- **The stake in the options.** Upstream adds a "why it matters" line; here each option's `description` says what choosing it means for the idea, and the recommended option's description starts with why you recommend it.
- **Recommended first.** Choose the recommendation from the ground rules, the vertical pack, earlier answers and common retail practice, and put it first with the marker the ask protocol defines.
- **Short answers become options or open text.** Where upstream would ask for a short free answer, offer two to four likely values or ranges and let the free-text box take anything else. Where no sensible options exist ("Ai đang giữ danh sách khách thành viên?"), use the round's one open question in plain text.
- **Everyday words.** No "API", "schema", "entity", "đồng bộ dữ liệu" or similar unless explained in the same sentence. Say "máy bán hàng ở cửa hàng" rather than "POS", "danh sách khách hàng" rather than "bảng khách hàng".

Examples of good questions in this module:

- G: "Khi một khách vừa mua ở cửa hàng vừa mua trên website, anh/chị muốn hệ thống coi đó là một khách hay hai khách?" with options "Một khách, nhận theo số điện thoại (Đề xuất)", "Hai khách riêng".
- H: "Lịch sử mua hàng ở cửa hàng cần được cập nhật vào danh sách nhắc khách nhanh đến mức nào?" with options "Mỗi đêm (Đề xuất)", "Trong vòng 1 giờ", "Ngay khi khách thanh toán".
- N: "Trong ý tưởng nhắc khách quay lại, \"khách VIP\" nghĩa là khách như thế nào?" with options built from the user's member tiers.

## 5. Apply each answer to the spec

After the round, write back as the ask protocol's section 7 says (Clarifications first, under today's `### Session YYYY-MM-DD`), then apply every answer to the section where it belongs:

| What the answer settles | Where it goes in `spec.md` |
|---|---|
| G: an entity, its key facts, how one is told apart, its states, its volume | `### Key Entities`: one bullet per entity, `**<name>**: <what it is, key facts, relationships>`, in the user's words; add or update, never duplicate |
| G: where data comes from, who owns it, how good it is | the entity's bullet in Key Entities; a doubt about quality also becomes an A-### and a line in `## Assumptions` |
| H: what the idea must receive from or send to another system, and how fresh | `### Functional Requirements`: a new `FR-###` with the next free number ("Hệ thống PHẢI lấy lịch sử mua từ máy bán hàng mỗi đêm"); never reuse a number |
| H: what the idea relies on another system or team to provide | `## Assumptions`, and an A-### with `source: stated` |
| H: what happens when the other system is down | `### Edge Cases` |
| N: the meaning of a term | `glossary.md` as `- **<term>**: <plain-language meaning>`, sorted alphabetically; then use that one term across `spec.md`, adding "(trước đây gọi là \"X\")" once where the old word was used |
| A vague quality word turned into a number | the requirement or success criterion that used it (`### Functional Requirements` or `### Measurable Outcomes`), with the number and its source, period and label |
| A leftover detail of another category | the section the owning module's "apply the answers" table names for it (for example C's baseline in `## Outcome` and `### Measurable Outcomes`) |

Rules for every edit:

- Replace the placeholder, the "not yet clarified" text or the ambiguous sentence the answer settles; do not leave the old and new versions side by side.
- Keep each edit short and testable; do not add narrative.
- Do not reorder sections and do not add, rename or translate headings. The only heading this module adds is `### Session YYYY-MM-DD` under `## Clarifications`, and only when today's is missing.
- Every number you write carries its source, period and a measured or assumed label; never invent a figure to fill a gap.
- A skipped question changes nothing here (its `- Skipped:` line in Clarifications is the only trace).

## 6. Update coverage

Set each handed-over category's status in `coverage.md` from the section 1 list, using only what the files now hold:

- `clear`: every item is answered, or recorded as an open question whose answer would not change the board's decision.
- `partial`: some items are answered and at least one that matters is still missing.
- `missing`: nothing is answered yet.
- `deferred`: only with a written `reason`, and only when the user chose to settle it later or the answer belongs to someone named as `owner` of an open question (Q-###). Running out of questions is not a reason to defer; the ask protocol's budget offer handles that.

A category whose only question was skipped keeps its status and its `updated` date. Then rebuild the coverage table and the clear count as the ask protocol says, and leave `next_step` and `budget_rounds_used` to the router.

## 7. Check before handing back

After every write, check and fix:

- Clarifications has exactly one line per question asked this session, answered or skipped, with no duplicates.
- No placeholder, "not yet clarified" text or `[NEEDS CLARIFICATION]` marker remains for a point that was answered.
- No earlier sentence contradicts a new answer. Search `spec.md` for every mention of each answered point (a figure's period, a name, a count) and update each one, including success criteria and the `## Assumptions` lines. `assumptions.md` is append-only: for an A-### the answer settles, fill in only its `tested` and `evidence` fields.
- One term per meaning across `spec.md` and `glossary.md`.
- Headings are unchanged and `coverage.md`'s table matches its frontmatter.

Then return to the router with the categories whose status changed. Tell the user, in one or two plain sentences in their language, what is now settled; never show file names, codes or paths.
