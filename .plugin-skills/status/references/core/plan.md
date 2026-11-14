# Module: plan

Turn a ready idea into the business plan the board decides on: what is asked for, the chosen approach and why the other routes lost, how big it is in low, base and high scenarios, how the pilot leads to rollout, what changes for the people in the stores, and whether it fits the organization's ground rules. The plan adds no facts of its own: it gathers what the interview settled, fills the last gaps in cost (M) and, when needed, organizational change (L), and shows every remaining gap openly.

- **Used by**: package, at readiness, before the checklist and analyze modules.
- **Reads**: the idea's `spec.md` (`## Problem & Why`, `## Outcome`, `## Alternatives`, `## AI-fit`, `## Cost & Risk`, the user stories, `## Assumptions`, `## Clarifications`), `coverage.md` (category statuses and `frameworks`, `cynefin`, `language`, `estimate_status`), `decisions.md`, `assumptions.md`, `open-questions.md`; the workspace `constitution.md` (`status`, `priorities`, `approval_ceiling`, `mandatory_approvals`, `strategy_map`, `okrs`); the template `references/templates/idea/plan.md`; the planning cards in `references/packs/frameworks/` (`lens: plan`), only under section 6.
- **Writes**: the idea's `plan.md`; `spec.md` (`## Cost & Risk` for new cost, return, rollout and organizational-change facts, and Clarifications through the ask protocol); `decisions.md` (`answer` entries through the ask protocol, `ground-rule-conflict` and `supersede` entries from section 5); `open-questions.md`; `coverage.md` (status, `frameworks` and `updated` of M, and of L when section 6 fills it; the body table).
- **Fills**: M (cost, resources and return) to completion; L when the ADKAR card applies; the ground-rule conflicts.

Follow `references/core/ask-protocol.md` for every question, `references/core/writing-rules.md` for every word the user reads (including how to address the user), and `references/core/anti-sycophancy.md` in everything the plan says about the idea.

## 1. Rules the plan never breaks

1. **No new facts.** Every line of `plan.md` traces to `spec.md`, `decisions.md`, `assumptions.md` or `constitution.md`. When the user gives a new figure or decision during this module, write it to its home in `spec.md` (or `decisions.md`) first, then copy it into the plan. The board and tech views render from those files; a fact that lives only in the plan would make the views disagree.
2. **Same number everywhere.** A figure in the plan is the figure in `spec.md`, with the same value, unit, source, period and label. Never round, convert currency or re-total it into a different claim. The one derived number allowed is payback (section 4.2), and it names the figures it comes from.
3. **Every number carries its source, period and label**: measured (đo được) when it comes from a report or count, assumed (giả định) when it is someone's estimate.
4. **Estimates stay unreviewed until reviewed.** While `estimate_status` is `not-tech-reviewed`, every cost, effort, resource or return estimate in the plan carries the label "not tech-reviewed" in the idea's language (in Vietnamese: "chưa qua kỹ thuật thẩm định"). See section 7.
5. **Gaps are shown, never filled by guessing.** Write the phrase for "not yet clarified" in the idea's language (`chưa làm rõ` in Vietnamese) for anything without an answer. Never invent a figure, a deadline, an owner or a phase to make the plan look complete.
6. **No praise, no selling.** The plan states the case and its weak points plainly; the riskiest assumption and the kill criteria appear where they apply.
7. **Leave the idea's `status` alone.** Packaging and the router own it. Report gaps to the package module (section 9).

## 2. Start

1. Re-read every file listed under **Reads**. The user's hand edits win over anything you remember.
2. If `plan.md` does not exist, create it from the template: keep its frontmatter keys, its headings in English and in their order, and its HTML comments (they guide later runs), and replace only the bracketed placeholder lines and the empty table cells. Never delete, rename or add a heading.
3. If `plan.md` exists, update it section by section from the current files. A line the user typed into the plan by hand that no other file holds is the user's statement: copy a figure or decision from it to its home in `spec.md` or `decisions.md` (source: the user's note in the plan, with today's date), then keep it. If it contradicts another file, do not choose: list it for the package module as a contradiction.
4. Set the frontmatter: `estimate_status` copied from `coverage.md` (never set it any other way), `updated` to today.
5. Write the body in the idea's `language`; headings and frontmatter stay in English.

## 3. Scan before asking

For each plan section in section 4, mark each element as on file, partly on file or missing, using only the files. Look facts up before turning them into questions: the chosen alternative and its decision in `## Alternatives`, the size and scenarios and the pilot design in `## Cost & Risk`, the time frame and kill criteria in `## Outcome`, the approval ceiling in `constitution.md`, earlier answers in `decisions.md` and `## Clarifications`. Only what is still missing and only the user can give becomes a candidate question (section 8).

## 4. Write each section

### 4.1 Decision requested

One short paragraph a board member can approve or reject:

- **What**: the chosen approach from `## Alternatives` (do nothing, fix the process, buy, partner, or build) with the decision that chose it (D-###), and in one line each why the other routes lost, from their effect, cost and risk lines. When the recommendation is not to build, say so first: that is a valid plan.
- **How much**: the amount the board is asked to release now, normally the cost of the first phase (the pilot when there is one), with its scenario figure, source and label. Name the full base-case cost beside it when it differs.
- **By when**: the date the decision is needed, and why that date (a season, a contract, a budget cycle), from the files or the user.
- **Ground-rule conflicts**: one line per current conflict from section 5, with its D-###: the amount above the approval ceiling and that someone above the user must approve it, or the step that lacks a required person's approval. The board view's decision slide is built from this paragraph, so a conflict missing here is missing from the deck.

Example in Vietnamese: "Đề nghị duyệt 120 triệu đồng (phương án cơ sở, giả định, chưa qua kỹ thuật thẩm định) để mua công cụ nhắc khách và thử ở 3 cửa hàng trong 8 tuần, quyết trước 15/01/2027 để kịp chạy trước mùa hè. Không tự làm hệ thống vì tốn gấp ba và chậm hơn hai quý (D-004)."

### 4.2 Size and scenarios

1. The size first: small, medium or large, as `## Cost & Risk` records it, in the user's terms of money and time.
2. The table, one row per scenario (low, base, high): **Cost** (one-time and per year when both exist), **Resources** (staff time, the tech team, outside help, number of stores or systems touched), **Return** (the driver from `## Outcome`, such as extra revenue, saved hours or fewer returns), **Time frame**. Every cell holds a figure with source, period, label and the estimate label, or `chưa làm rõ`.
3. **Payback**, when the one-time cost and the yearly net return are both on file for a scenario: one-time cost divided by yearly net return, in months, one line under the table per scenario, naming the two figures it comes from and labelled as an estimate. Leave it as `chưa làm rõ` when the return is unknown or not positive.
4. When the build-buy-partner card applies (section 6), the cost and return of each route the board could still choose go under the table as a short comparison in the same three scenarios; the chosen route's row is the table itself.
5. Add the riskiest assumption from `## Cost & Risk` (its A-###) in one line: the return depends on it.
6. When a budget-ceiling conflict is current (section 5), add one line under the table naming the scenario figure that exceeds the approval ceiling, the ceiling, and the conflict's D-###. The board view's cost slide is built from this section.

### 4.3 Pilot roadmap and decision points

Build the roadmap from the pilot design the challenge lens wrote in `## Cost & Risk` (test group, control group, duration, season, metric, guardrail, kill criteria) and the time frame and kill criteria in `## Outcome`. Write it as phases, usually: pilot, review, then one or more rollout waves. For each phase:

- what is done and where (which stores, channel or customer group);
- who is involved and who owns it;
- how long it runs and in which season;
- the metric and guardrail read at its end, with today's value and the target;
- the decision taken at its end: continue, change or stop, with the kill criteria that trigger a stop.

Rules:

- Take the pilot design as written; do not redesign it. When no pilot design is on file, write the phases the files support, mark the pilot `chưa làm rõ`, and report the gap to the package module. When `cynefin` is `complex`, this gap is blocking: such an idea cannot be judged without a small test first.
- A pilot that only runs in a sale week or a holiday peak cannot prove the outcome; when the design says so, point it out in the review phase line and report it.
- Rollout choices only the user can make (how many stores per wave, which region first, who decides at each checkpoint) are candidate questions (section 8).

### 4.4 Organizational change

From the organizational-change lines in `## Cost & Risk`: training (who, how long, by whom), staff KPIs or targets that change, who gains or loses work, authority or commission, who is likely to resist, support in the first weeks, and how the change is kept up after launch. When L is `deferred`, write that it was deferred and its reason. When L is `missing` or `partial` and the ADKAR card applies (section 6), fill the missing lines with it; write the answers to `## Cost & Risk` first, then here.

### 4.5 Ground rules check

Section 5 decides what goes here: either that the plan fits the ground rules, or each conflict with its D-### and a plain sentence on the rule and the figure or step that breaks it. Add the strategy link when the ground rules record objectives: which priority, strategy-map objective (with its perspective) or OKR the idea serves, and whether directly or indirectly. When the ground rules are deferred, this section says so (section 5).

## 5. Ground-rule checks

Read `constitution.md` frontmatter. A missing file or a missing `status` counts as deferred.

**Ground rules deferred.** Write in the section that the organization's ground rules are not set yet, so the plan was not checked against a budget ceiling, priorities, strategy objectives or required approvals. Remind the user once per packaging run, in one sentence, naming the command that records them, `/vibebiz:constitution`; do not repeat it in later messages of the same run, and do not stop or ask a question about it, because every other part of the plan works without them. Record no conflict. Example: "Công ty chưa đặt luật chung (mức chi anh/chị tự duyệt, ưu tiên năm nay, các việc luôn cần người duyệt), nên kế hoạch chưa được đối chiếu. Anh/chị có thể đặt bằng lệnh /vibebiz:constitution rồi đóng gói lại trước khi trình."

**Ground rules set.** Run each check whose rule is recorded, from the files only. A rule left empty (no amount, no priorities, no approvals, no objectives) is not checked: say in the section which rules were not set, and record no conflict for them.

| Check | Rule read | Conflict when |
|---|---|---|
| Budget ceiling | `approval_ceiling` | the amount in "Decision requested", or the high-scenario cost, exceeds the ceiling (same currency). Exceeding the ceiling is a conflict to show, not a reason to stop: the user needs someone above them to approve. When the currencies differ, do not convert: add an open question. When the cost is still `chưa làm rõ`, there is no conflict yet: say the ceiling could not be checked and report the gap |
| Priorities and strategy | `priorities`, `strategy_map`, `okrs` | the idea serves none of the priorities, none of the strategy-map objectives and none of the OKRs, judged from `## Problem & Why` and `## Outcome` (including the strategy link the outcome lens wrote). Name the closest one when the link is only indirect, and say it is indirect; an indirect link is not a conflict. When the outcome's metric moves against an OKR key result or a strategy-map objective (for example more discounting against a margin objective), that is a conflict too |
| Required approvals | `mandatory_approvals` | a step in the user stories, the AI-fit decision, the solution flow or the rollout acts without a person where a required approval names that kind of step (for example an AI sends a refund, changes a price or messages customers alone). Match by meaning, not by exact words; when it is unclear whether a step falls under a rule, add an open question instead of a conflict |

For each conflict:

1. Look in `decisions.md` for a `ground-rule-conflict` entry on the same rule, including one the challenge lens recorded earlier. If one exists and still describes the conflict with the current figure or step, cite it; do not add a duplicate. If the figure or step changed but the rule is still broken, append a new entry and a `supersede` entry naming the old one.
2. Otherwise append an entry (ids continue from the last D-###, never reused):

```markdown
## D-### — <rule, in a few words>

- date: YYYY-MM-DD
- type: ground-rule-conflict
- text: <what in the plan breaks which rule, with the figure and its source>
- reason: <the rule as recorded in the ground rules, and today's date>
```

3. When an earlier conflict no longer holds (the cost fell under the ceiling, a manager approval step was added), append a `supersede` entry naming it, with the reason, and drop it from the section. The old entry stays.
4. Cite every current conflict's D-### in the section, in "Decision requested" (section 4.1) and, for a budget-ceiling conflict, under the scenario table (section 4.2), and tell the user in one plain sentence per conflict. The board view shows each conflict on the decision and cost slides from those sections; never soften one, and never drop one because the user dislikes it: a conflict ends only when the plan changes or the ground rules change. Example: "Phương án cao cần 350 triệu đồng, vượt mức 200 triệu anh/chị tự duyệt (theo luật chung), nên cần cấp trên duyệt; em đã ghi điều này vào kế hoạch và bản trình bày."

## 6. Planning cards

The planning cards (`lens: plan`) are applied here at packaging, never by the router. Apply a card only when all of these hold:

- one of the categories in its `fills` is `missing` or `partial`;
- its "When not to use" does not match the idea's files;
- fewer than two planning cards are already applied to this idea (count the distinct ids of `lens: plan` cards in the `frameworks` of every category); never apply a third;
- or the user asked for it by name (noted in `## Clarifications`) and the first three conditions still hold. If one fails, say why in one plain sentence.

The two cards this module normally uses:

- **`build-buy-partner-roi`** (fills D, M): when M is `partial` because the scenarios, resources or payback are missing, or because only the build cost was counted. Use its questions in plain words to collect the figures for section 4.2: one-time and yearly cost per route, the main return driver and today's value, the team needed. Count running cost, training and store staff time, not only the purchase or build. Every figure in low, base and high, labelled as an estimate.
- **`adkar`** (fills L): when L is `missing` or `partial` and the work of store staff, supervisors or back-office teams changes. Ask its questions for the group whose work changes most, record the step where that group is stuck as the place the plan starts, and write training, support, KPI changes and owners. Guessing how staff feel is not allowed: an answer nobody present can give becomes an assumption to test in the pilot or an open question.

The other planning cards (`moscow`, `marketing-mix-4p-7p`) follow the same conditions; at readiness their categories are usually settled, so they rarely apply here.

Ask a card's questions without naming the framework. When at least one of its questions was answered, or the card's method shaped a section from the files, add its id to the `frameworks` list of the category it filled, so the outputs can name it. Without the card file, do the section in its plain form; never apply a framework from memory.

## 7. The tech-review label

- `estimate_status` lives in `coverage.md` and changes only when a `tech-review` decision is recorded (through `/vibebiz:continue`). The plan mirrors it and never changes it.
- `not-tech-reviewed`: every estimate in the plan carries the label (rule 1.4); a measured figure does not.
- `tech-reviewed`: remove the label from the plan's estimates; the measured or assumed label stays. If the review changed figures, the new ones are already in `spec.md`; copy them.
- If `decisions.md` holds a `tech-review` entry but `coverage.md` still says `not-tech-reviewed`, or the reverse, keep the label and report the mismatch to the package module. Never resolve it yourself.

## 8. Ask only for what is missing

1. Collect the candidates from sections 3 to 6: only decisions or figures that only the user knows, whose answer changes the decision requested, a scenario, the roadmap or the people plan. Drop a candidate that the files answer, or whose every answer leads to the same plan.
2. Rank them: the amount and deadline of the decision requested first, then missing scenario figures, then rollout choices, then organizational change.
3. Ask at most one round of up to four questions, by the ask protocol's rules: self-contained, plain words, two to four exclusive options with the recommended one first, number ranges built from the user's own figures or the approval ceiling and labelled as estimates. This round counts toward the session's question budget like any interview round; when the budget is already used up, the ask protocol's budget offer comes first. Example:

   "Để trình ban lãnh đạo ý tưởng nhắc khách cũ quay lại mua, anh/chị cần quyết khoản chi trước ngày nào?"
   - "Trước 15/01/2027 (Đề xuất)": "Kịp chạy thử 8 tuần trước mùa hè, khi khách quay lại mua nhiều nhất trong năm."
   - "Trước 31/03/2027": "Thử nghiệm sẽ rơi vào mùa hè; khó tách kết quả của công cụ khỏi sức mua theo mùa."
   - "Theo kỳ duyệt ngân sách quý": "Đi theo lịch duyệt thường lệ; thời điểm thử nghiệm chưa chốt được."

4. Apply each answer to its home in `spec.md` or `decisions.md` (the ask protocol writes the Clarifications and the `answer` entry), then to the plan. A skipped question leaves its element as `chưa làm rõ`. With nobody to answer, ask nothing, write the gaps and record no answer.
5. Do not ask again in this packaging run; whatever is still missing goes to the package module as a gap.

## 9. Update coverage and hand back

1. **M** is `clear` when the plan holds the size, the low, base and high cost and return each with source, period and label, the resources, the time frame, and the decision requested with its amount and deadline. Otherwise `partial` (a recorded size is enough for readiness). Never set M below the status it had.
2. **L**, when section 6 filled it: `clear` when training, KPI changes, affected roles and an owner for keeping the change up are written for each group whose work changes; otherwise it keeps its status. A category whose only question was skipped keeps its status and `updated` date.
3. Set `updated` on each category you changed and on the idea, rebuild the `coverage.md` body table and the "Clear: n of 15" line, and rebuild the table of contents by `references/core/workspace.md`.
4. Report to the package module: the plan sections or elements still `chưa làm rõ`, each with the category it belongs to; whether a missing pilot design is blocking (complex ideas); the current ground-rule conflicts by D-###; whether the ground rules are deferred; `estimate_status` and any mismatch from section 7; contradictions found in section 2.
5. Tell the user in one or two plain sentences what the plan now holds and what is still open, for example: "Kế hoạch đã có khoản đề nghị duyệt, ba phương án chi phí và lộ trình thử ở 3 cửa hàng; còn thiếu người chịu trách nhiệm đào tạo nhân viên. Khoản chi phương án cao vượt mức anh/chị tự duyệt, nên cần cấp trên duyệt." No file names, codes or paths, and no praise.
