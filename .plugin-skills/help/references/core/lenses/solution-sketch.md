# Lens: solution-sketch

Turn the chosen alternative into something the board can picture and the tech team can build in slices: how the work runs today and how it would run after, three ways to get there, whether a rule, an automation or AI is the right tool, a first journey worth delivering on its own, what can go wrong, and whose work changes. The router hands this lens its categories; the lens never chooses the frontier itself.

- **Used by**: router.
- **Reads**: `spec.md`, `coverage.md` (category statuses, `cynefin`, `language`, `vertical`), `decisions.md` (above all the decision that chose an alternative), `assumptions.md`, `open-questions.md`, the workspace `constitution.md` (`mandatory_approvals`, priorities); when the idea's `vertical` is `fashion`, the fashion pack's `references/packs/retail-fashion/drivers.md` and `promotions.md` (for journeys and edge cases) and the solution-sketch examples in `questions.md`, used by that pack's README rules, otherwise the general retail questions in this file; the AI pattern catalog `references/packs/ai-patterns-retail/` for the AI-fit check; a framework card from `references/packs/frameworks/` only when the router hands one over (section 8).
- **Writes**: `spec.md` (`## User Scenarios & Testing` user stories and `### Edge Cases`, `### Functional Requirements`, `## AI-fit`, `## Cost & Risk` for organizational change, `## Assumptions`, Clarifications through the ask protocol), the journey diagram brief `diagrams/NN-journey.brief.md`, `decisions.md`, `assumptions.md` and `open-questions.md` through the ask protocol, `coverage.md` (statuses of E, F, I, J and L).
- **Fills**: E (scope and behavior), F (AI fit), I (non-functional needs), J (edge cases and failures), L (organizational change).

Follow `references/core/ask-protocol.md` for every question and `references/core/writing-rules.md` for every word the user reads. Do not praise the idea or an answer; say what the answer changes.

## 1. Start from the chosen alternative

Read the decision that chose an alternative in `decisions.md` and the `## Alternatives` section. Sketch that alternative, not the user's first idea:

- **Fix the process**: the journeys are the new routine (who does what, when, with which list or report). The AI-fit check usually ends at "a rule" or "no system needed"; write that.
- **Buy**: the journeys describe how staff use the bought product in the user's stores; what the product must do becomes requirements to check vendors against.
- **Build**: the journeys describe the new system.
- **Do nothing**: there is nothing to sketch. Write in the first user story's place that the idea was not taken forward, with the D-### id, mark E `clear` and F, I, J, L `deferred` with that reason, and return to the router.

If no alternative has been chosen yet, ask nothing and return D to the router: sketching before the alternatives are weighed would skip the challenge.

## 2. What each category needs to be clear

Use these lists for the scan (section 3) and to set the status after the round (section 7).

**E. Scope and behavior** (prerequisites C, D).
- The **current journey**: the steps people take today, who takes each one (customer, store staff, store manager, online team, warehouse, head office), and where it goes wrong, in the user's words.
- The **future journey**: the same steps after the change, with what is new, removed or moved to someone else.
- **Three alternative approaches** to the chosen alternative, compared before one is chosen (section 4.2).
- **Journeys in priority order** as user stories P1, P2 and so on; the first one delivers value on its own (section 4.4).
- **Out of scope**: what this idea will not do, in plain words.
- Functional requirements for the chosen journeys, testable and free of vague words.

**F. AI fit** (prerequisite E). Required when the idea involves AI or the user expects it to; otherwise one line saying AI is not involved and why.
- the decision: a rule, an automation, or AI, and why the simpler ones are not enough (section 5);
- the data the chosen approach needs, whether it exists, where, how good it is and who owns it;
- what an error costs, who carries it (a customer, a store, the brand) and how it is noticed;
- where a person must approve before anything reaches a customer or changes money, stock or prices, including every step in the ground rules' `mandatory_approvals`.

**I. Non-functional needs** (prerequisite E), in plain words with numbers:
- how many people use it and where (stores, head office, warehouse); how many customers it touches per day or month;
- peak times (sale days, Lunar New Year, evenings);
- store conditions: internet quality, the devices staff actually use (shared tablet, personal phone, the sales counter computer);
- how long a delay or a stop is acceptable, and what staff do meanwhile.

**J. Edge cases and failures** (prerequisite E): for each journey, what can go wrong and what happens then: missing or wrong data, the customer does not respond or refuses, stock runs out, a store is offline, the same customer appears twice, a sale period changes the pattern, a person does not do their step. For fashion, draw the sale and promotion cases from the pack's `promotions.md` and the stock and size cases from its `drivers.md`.

**L. Organizational change** (prerequisites B, E): the people whose work changes, what they do differently, the training they need, the targets or bonuses that must change so they do it, and who loses work, authority or information, from the stakeholders recorded in `## Problem & Why`.

## 3. Scan before asking

1. Re-read every file listed under **Reads**; the user's hand edits win over anything you remember.
2. For each category you were handed, mark each item in section 2 as answered, partly answered or missing, from the files only.
3. Look facts up before turning them into questions (ask protocol, section 1): who does what today is often in the problem section or the user's documents; the store count, devices and peak periods may be in `constitution.md`, other ideas or connected documents.
4. Read `cynefin` in `coverage.md` and set the depth:
   - `clear`: one journey, the AI-fit check, the main edge cases; ask only what changes scope.
   - `complicated`: the full lens.
   - `complex`: the full lens, and keep the first journey small enough to run as the pilot the challenge lens designed.
   - `chaotic`: do not sketch; return to the router.
5. Drop a candidate question when its answer would not change scope, cost, the success measure, the acceptance tests or the board's decision, when it is about how to build (which database, which programming method), or when the files already answer it.

## 4. Journeys

### 4.1 Current and future journey

Draft both journeys from the files as short numbered steps, each naming who acts, for example:

- Hiện nay: 1. Hết đợt sale, cửa hàng không liên hệ lại khách. 2. Phòng CRM xuất danh sách khách thẻ thành viên mỗi quý. 3. Không ai kiểm tra khách nào đã quay lại.
- Sau khi có: 1. Mỗi sáng thứ Hai, danh sách khách chưa quay lại sau 60 ngày được gửi cho từng cửa hàng. 2. Nhân viên gửi tin nhắc qua Zalo theo mẫu đã duyệt. 3. Cửa hàng trưởng xem số khách đã quay lại mỗi tuần.

Show the future journey to the user as option previews when there are real variants to choose between (ask protocol, rule 7); otherwise state it in the summary after the round and let the user correct it. Write both journeys into the first user story's description (section 6).

Then write the journey diagram brief (section 6.1). The journey before and after is drawn as a swimlane (one lane per role) or, when only one role acts, a flowchart.

### 4.2 Three alternative approaches

Before settling the future journey, describe three genuinely different ways to deliver the chosen alternative, for example for win-back reminders: staff send reminders by hand from a weekly list; the reminders are sent automatically on fixed dates; a model predicts which customers are about to leave and only those are contacted. For each, give the effect on the outcome, a rough size (small, medium or large, labelled as an estimate) and the main risk. Ask the user to choose one through a single question with the three approaches as options; recommend the simplest one that reaches the outcome target, and say why in its description. Record the choice through the ask protocol as an `answer` decision whose `notes` list the two approaches not chosen and why; that is where the comparison lives.

### 4.3 Out of scope

List what the idea will not do in the first release and later, in plain words. Ask only when leaving something out changes the board's decision (for example "chỉ cửa hàng, chưa làm kênh online").

### 4.4 A first journey that stands alone

User story P1 must deliver value and be demonstrable on its own, even if nothing after it is ever built: someone can see it work in one store or for one customer group and the outcome metric can move. Test it: if P2 were cancelled, would P1 still be worth what it costs? If not, cut or reorder until it is. Typical first journeys are the manual or rule-based version of the chosen approach in a few stores. When the user wants several journeys at once, ask which one to take first, with the standalone one recommended.

## 5. AI-fit check

Run this for every idea, in this order, and stop at the first answer that reaches the outcome. The simplest tool that works is the right one, because it is cheaper, easier to explain to staff and easier to check.

1. **Is a rule enough?** If the right action can be written as a fixed rule that gives the same answer every time ("khách không mua sau 60 ngày thì nhắc", "tồn dưới 3 cái thì báo"), it is a rule. No AI.
2. **Is an automation enough?** If the work is a repeated sequence of steps without judgment (export a list, send a message, fill a report, move data from one place to another), it is an automation. No AI.
3. **Is AI required?** Only when the task needs judgment on varied input that a rule cannot cover: reading free text or images, predicting who will do what, choosing among many options for each customer or product. Then answer the next three before F can be clear:
   - **Data**: what it learns or reads from, whether that data exists today, how much, how good, and who owns it. Use the matching pattern in `references/packs/ai-patterns-retail/` for what is usually needed (its `data_needed`), the usual cost (`rough_cost`), the usual risks (`risks`), where it has been done before (`prior_art`) and whether the pattern is typically a rule, an automation or AI (`fit`). Say plainly when the user's data falls short of the pattern's needs.
   - **Cost of an error**: what happens when the AI is wrong (a wrong size suggested, a message to a customer who already bought, a markdown too deep), who carries the cost, and how often an error is acceptable. Ask for the acceptable error as a number, never "chính xác".
   - **Human approval points**: where a person checks before the result reaches a customer or changes money, stock or prices. Include every step listed in the ground rules' `mandatory_approvals`. Recommend an approval point wherever an error reaches a customer or costs money and cannot be undone.

When no pattern in the catalog matches, say so, use the three questions above without the catalog's figures, and add an open question for the tech team about data and cost. Never quote a pattern's cost as the user's cost: it is an estimate, labelled "not tech-reviewed".

Example question when the files leave a real choice:

"Với ý tưởng nhắc khách cũ quay lại mua, anh/chị muốn chọn khách cần nhắc theo cách nào?"
- "Theo quy tắc ngày mua (Đề xuất)": "Đủ để bắt đầu và dễ kiểm tra: nhắc mọi khách không mua sau 60 ngày; không cần AI."
- "Để AI dự đoán khách sắp rời": "Nhắc ít khách hơn nhưng cần lịch sử mua đủ dài và sạch; khi AI đoán sai, khách trung thành bị bỏ sót."

The AI-fit check is drawn as a decision flowchart; the package step writes that brief, not this lens.

## 6. Write the round's questions and apply the answers

The router tells you how many of the round's four slots are yours and which categories they serve. Within those slots, rank your candidates by impact times uncertainty and draft them as question-tool entries by the ask protocol's rules: self-contained, naming the idea, a short header, two to four mutually exclusive options, the recommended option first with the marker, no "None"/"Other"/"Không có"/"Khác" option, previews for draft journeys or stories. At most one slot may be the round's open plain-text question, and only if the router gives it to you; use it for something real ("Hôm qua ở cửa hàng, ai là người cuối cùng gọi lại cho một khách quen, và gọi thế nào?"). Return the entries to the router with, for each, the category and the section its answer goes to. Never reveal questions you plan to ask later.

For an idea that is not fashion, or a vertical without a pack, use the general retail wording in this file's examples with the user's own products and channels.

After the router has asked the round and the ask protocol has written Clarifications and the decision records, apply each answer:

| What the answer settles | Where it goes in `spec.md` |
|---|---|
| E: a journey and its priority | `## User Scenarios & Testing`: one `### User Story N - <title> (Priority: PN)` per journey, in priority order, using the template's fields. The description holds the journey in plain words; for P1 it holds both "Hiện nay" and "Sau khi có" step lists. "Why this priority" says why it comes in this order; "Independent Test" says how it can be shown working on its own. Leave **Acceptance Scenarios** as "not yet clarified" for the outcome lens, which owns them |
| E: the chosen approach | the P1 description names it with its D-### id; the two not chosen stay in that decision's `notes` |
| E: a capability a journey needs | `### Functional Requirements`: a new `FR-###` with the next free number, testable, no vague words; never reuse a number |
| E: out of scope | the last line of `## User Scenarios & Testing` before `### Edge Cases`, as "Ngoài phạm vi: …" |
| F: rule, automation or AI; data; cost of an error; approval points | `## AI-fit`, one short paragraph or list per point; when AI is not involved, one line saying so and why |
| F: data that does not exist yet or an owner nobody knows | `## AI-fit`, and an open question with an owner |
| I: users, volumes, peak times, devices, store conditions, acceptable delay | `### Functional Requirements` as `FR-###` with the number, unit and source |
| J: what can go wrong and what happens then | `### Edge Cases`, one line per case: the situation, then what happens |
| L: whose work changes, training, changed targets, who loses work or authority | `## Cost & Risk`, in its organizational change part |
| any premise the user states | `assumptions.md` with `source: stated`, and the spec's `## Assumptions` with its A-### id |

Rules for every edit: replace the "not yet clarified" text or the placeholder the answer settles, including the template's example stories and requirements once real ones exist; leave no contradictory sentence behind; keep every heading unchanged and add only the user story headings the template's pattern provides; every number carries source, period and a measured or assumed label.

### 6.1 The journey diagram brief

When the current and future journeys are written, create or update the journey brief in the idea's `diagrams/` folder. Use the next free two-digit number, or the existing journey brief's number if one is there; never create a second journey brief. Write it as:

```markdown
---
message: "<the takeaway in the idea's language, e.g. Sau thay đổi, cửa hàng gọi lại khách chưa quay lại mỗi tuần thay vì mỗi quý>"
type: swimlane            # or flowchart when only one role acts
source_fields:
  - "spec.md: User Story 1 (Hiện nay, Sau khi có)"
placement: "board slide 5; tech view, user journeys"
rendered: none
rendered_with: none
---

Lanes or steps, before and after, copied from the spec in the idea's language.
```

- `rendered` and `rendered_with` stay `none` here. The package step asks the diagram-design companion to render the brief and then fills `rendered` with the file name and `rendered_with` with both versions, for example `vibebiz 0.1.0, diagram-design 1.0.0`. Without diagram-design both stay `none` and the outputs show a table with a "no diagram" note; never draw a substitute.
- When an answer changes a journey, update the brief's body and message in the same round and set `rendered` and `rendered_with` back to `none`, so the stale picture is redrawn.

## 7. Update coverage and hand back

Set each handed-over category's status from section 2, using only what the files now hold:

- **E** `clear` when both journeys are written, an approach was chosen from three, the stories are in priority order with a P1 that stands alone, out of scope is written and each story's requirements are testable.
- **F** `clear` when the decision and, for AI, the data, the cost of an error and the approval points are written (or AI is recorded as not involved with the reason).
- **I**, **J**, **L** `clear` when every item in their section 2 list is answered or recorded as an open question whose answer would not change the board's decision.
- `partial` when some items are answered; `missing` when none are. A category whose only question was skipped keeps its status and its `updated` date. `deferred` only when the user says so, with their reason.

Then rebuild the coverage table as the ask protocol says, leave `next_step` and `budget_rounds_used` to the router, and tell the user in one or two plain sentences what is now settled. Never show file names, codes or paths.

## 8. Framework cards

The router may hand this lens one framework card for an open category; it never picks one itself. Use a card only when it was handed over, its `lens` is `solution-sketch`, and its `fills` includes a category of yours that is still `missing` or `partial`. In the first release that card is `journey-map-service-blueprint`, loaded from `references/packs/frameworks/journey-map-service-blueprint.md`; it adds what staff and back office must do behind each customer step.

- Ask the card's questions in plain words, through the ask protocol, without making the user learn the framework; name it only if the user asked for it by name.
- Write its result where the card's "Writes to" says, within this lens's sections.
- At most two cards per lens per idea: the router counts them and records the applied card ids in the category's `frameworks` field; report to it which handed-over card had at least one question answered. Never apply a third.
- Without a card, sections 4 and 5 still run in their plain form; they are this lens's own steps.
