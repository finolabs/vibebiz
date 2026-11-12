# Module: router

Run the interview loop for one idea: decide what to ask next, hand each category to the module that fills it, keep the session within its question budget, and tell the user what comes next. Used by the `new` and `continue` entry skills.

- **Reads**: the idea's `coverage.md`, `spec.md`, `decisions.md`, `assumptions.md`, `open-questions.md`, `glossary.md`; the workspace `constitution.md`; the framework cards in `references/packs/frameworks/`.
- **Writes**: `coverage.md` (`cynefin`, `budget_rounds_used`, `next_step`, `status` between `clarifying` and `ready`, each category's `frameworks`, `updated`, the body table); `decisions.md` for `supersede` and split decisions.
- **Asks through**: `references/core/ask-protocol.md`, which owns the question rules, the default budget of three rounds, Skip, the all-skipped round, no-answer runs and the per-round write-back of answers, decisions and open questions.

Follow `references/core/writing-rules.md` for everything the user reads. Speak to the user in the idea's `language`.

## The loop

At the start of a session (the first round for this idea in this conversation), set `budget_rounds_used` to `0`. Then repeat:

1. **Re-read** every idea file listed above. The user may have edited them by hand; their edits are authoritative, so work from the current files and never restore an older version.
2. **Set the depth** (see "Depth"): classify the idea right after intake, before the first round, and revisit the classification whenever the files or the latest answers change what it rests on.
3. **Check readiness** (see "Readiness"). If ready, offer to package and stop the loop unless the user chooses to keep going.
4. **Resolve conflicts first**: if the last answers contradict an earlier decision, handle it (see "Contradictions") before anything else.
5. **Check for two ideas** (see "Two ideas in one") when the intake or the latest answers suggest it.
6. **Compute the frontier** and **rank** it (below).
7. **Look facts up** for every candidate question before asking it (see "Facts before questions").
8. **Choose the module** for each category in the round, choose its framework card if one fits (see "Frameworks"), and let the module write the round's questions (see "Who fills what"). One round holds at most four questions in total, taken from the highest-ranked categories first.
9. **Ask the round** through the ask protocol, which writes the answers back.
10. **Close the round**: increment `budget_rounds_used` by one (an all-skipped round counts too), make sure each category the round touched has its new status and its applied cards in `frameworks`, rebuild the `coverage.md` body table from the frontmatter, write `next_step` (see "Next step"), set `updated` to today, and rebuild the table of contents by the workspace module's rules (`references/core/workspace.md`). Do this after every round, so an abandoned session loses nothing.
11. **Check the budget** (see "Budget"). If budget remains, go back to step 1.

## Depth

How deep the interview goes depends on what kind of situation the idea is in. Classify it with the Cynefin card (`references/packs/frameworks/cynefin.md`) into one of four kinds and write the value to `cynefin` in `coverage.md`. The value specify wrote at intake is only a placeholder; replace it with your classification before the first round.

Classify from what is on file (the intake answer, the spec, the ground rules), not by asking the user: the classification is a judgment vibebiz makes, and asking a sales director to name a Cynefin domain makes them learn a framework. Use these signals:

| Value | Signals | Depth |
|---|---|---|
| `clear` | Cause and fix are already known; the same fix exists elsewhere in the business or as a common product; small, cheap and easy to undo (for example adding a column to a daily sales report) | Shortest path: each lens asks only the elements still missing, one question per category where one is enough, and applies no framework card unless the user asks for one by name |
| `complicated` | The answer can be found by analysis or by asking someone who knows: data, an expert, a supplier, a comparison of options (for example choosing a tool to reconcile cash-on-delivery payments) | Full lenses, with framework cards chosen by "Frameworks" |
| `complex` | Nobody can know the result in advance because it depends on how customers or staff will react; cause and effect show only after trying (for example a new AI size advisor on the website, or a new loyalty mechanic) | Full lenses, steered toward a small test: when filling the outcome, kill criteria are required before C is `clear`; when filling alternatives and scope, recommend a pilot in a few stores or one channel against comparable stores or a control group, with a minimum duration and a season check, ahead of a full rollout; prefer the `test-and-control-pilot` card when its `fills` includes the open category |
| `chaotic` | An active crisis is hurting the business now and the user is reacting to it (for example the stores cannot take payments, or a data leak is under way) | Stabilize first: say in one sentence that the crisis needs handling before this idea, record the idea as it stands, ask at most one round on the problem (A) only if the user wants to keep going, and do not offer packaging (see "Readiness") |

- When the signals sit between two values, choose the deeper one (`complicated` over `clear`, `complex` over `complicated`): treating an uncertain idea as simple costs far more than one extra round. Choose `chaotic` only when the user describes a crisis happening now, never because an idea feels urgent.
- With nobody to answer, classify the same way and record the value; do not invent facts to settle it.
- **Revisit** at step 2 of every round: when the latest answers or the user's hand edits change a signal (for example the user says the same fix already works in another region, or that customer reaction is unknown, or that the crisis is over), write the new value and apply the new depth from this round on. Categories already `clear` stay `clear`, with one exception: a move to `complex` sets C back to `partial` when it has no kill criteria.
- Tell the user the depth in one plain sentence in the idea's language when you first set it and whenever it changes, without the word Cynefin or the value name. Examples:
  - `clear`: "Việc này đã rõ cách làm và dễ quay lại nếu không hiệu quả, nên tôi chỉ hỏi những điểm còn thiếu để bạn trình duyệt nhanh."
  - `complex`: "Chưa ai biết chắc khách sẽ phản ứng thế nào với ý tưởng này, nên tôi sẽ đề xuất thử nhỏ ở vài cửa hàng và đặt trước ngưỡng dừng."
  - `chaotic`: "Sự cố hiện tại cần được xử lý trước; tôi đã ghi lại ý tưởng để bạn quay lại sau."

## Frontier

The frontier is every category whose status is `missing` or `partial` and whose prerequisites are all `clear` or `deferred`. Prerequisites are fixed (also in each category's `prerequisites` field); the elements column is what a category needs before it is `clear`:

| Code | Category | Elements | Prerequisites |
|---|---|---|---|
| A | Problem and why | who suffers, the situation, frequency, current cost, root cause, why now | none |
| B | Users and stakeholders | who uses it, who is affected, who approves, who may resist | A |
| C | Outcome and measurement | baseline (or a measurement plan), target, time frame, guardrail, kill criteria | A |
| D | Alternatives | do nothing, fix the process, buy, build | A, C |
| E | Scope and behavior | journeys in priority order, what is out of scope | C, D |
| F | AI fit | rule, automation or AI; data available; cost of an AI error; human approval points | E |
| G | Data and entities | sources, quality, ownership | E |
| H | Integrations | point of sale, ERP, marketplaces, chat apps, logistics | E, G |
| I | Non-functional needs | number of users, peak hours, store connectivity, devices | E |
| J | Edge cases and failures | what can go wrong and what happens then | E |
| K | Risk and compliance | personal-data law, promotion registration, labor rules | E, G |
| L | Organizational change | training, changed staff KPIs, who loses authority or work | B, E |
| M | Cost, resources and return | small, medium or large size; low, base and high scenarios | C, D, E |
| N | Terminology | the business's own terms with a plain meaning | none |
| O | Completion signals | testable acceptance criteria | C, E |

- Never put a question on the round for a category outside the frontier, even when it seems quick. A question that depends on an unsettled answer (for example return on investment before the outcome is set) waits for a later round, because its answer would rest on a guess.
- A `partial` category whose only remaining gap is an open question owned by someone who is not in the conversation (`open-questions.md`, `status: open`) is not asked again; it stays `partial` until that answer arrives.
- A category with an unresolved contradiction is treated as not settled, so the categories that depend on it leave the frontier until the user decides.

## Ranking

Score each frontier category as **impact × uncertainty**, from 1 to 9, and ask the highest scores first.

- **Impact**: how much the answer changes the idea's scope, its cost or the board's decision. 1 low, 2 medium, 3 high.
- **Uncertainty**: how well the answer is already known. 1 likely known (the files or the user's words almost settle it), 2 partly known, 3 unknown.

Ties: first the category with more categories depending on it (it unlocks more of the frontier), then the earlier code. A category with uncertainty 1 is the first place to look facts up instead of asking.

## Facts before questions

The user decides; vibebiz finds facts. Before asking any question, search for the answer in this order: the idea's files; `constitution.md`; other ideas in `specs/` when they describe the same business (for example the number of stores); documents the user pointed to or attached, and their connected documents when Cowork offers a connector for them. Read only; send nothing anywhere.

- When a fact is found, write it where it belongs with its source (file or document name and date), and ask only the decision that remains, quoting the fact. Example: "Theo tài liệu bạn gửi, chuỗi có 24 cửa hàng. Bạn muốn thử ở bao nhiêu cửa hàng trước?"
- When a fact cannot be found, it may become a question; a figure the user does not know becomes a measurement plan or an open question, never your estimate.

## Who fills what

Each category goes to the module that fills it. Load a module from this skill's own `references/core/` folder.

| Category | Module | File |
|---|---|---|
| A, B | problem-framing | `references/core/lenses/problem-framing.md` |
| C, O | outcome | `references/core/lenses/outcome.md` |
| D, K | challenge | `references/core/lenses/challenge.md` |
| M | challenge for the size, risks and scenarios; the plan module completes it at packaging | `references/core/lenses/challenge.md` |
| E, F, I, J, L | solution-sketch | `references/core/lenses/solution-sketch.md` |
| G, H, N | clarify | `references/core/clarify.md` |
| any category still `partial` after its module has run | clarify | `references/core/clarify.md` |

Use the lens file at `references/core/lenses/<name>.md` whenever it is present. **Fallback when a lens file is missing** (a damaged or partial install): the clarify module handles that lens's categories, using the category's elements in the frontier table as its checklist. Do not invent lens techniques the module would normally bring, and apply no framework card for that lens. For M, clarify asks only for a size (small, medium or large) and records it as `not tech-reviewed`.

The filling module writes the content into `spec.md` and sets the category's status: `clear` when every element of the category is answered, `partial` when some are, unchanged when every question on it was skipped. A category becomes `deferred` only when the user says so, with their reason in `reason`.

## Frameworks

Framework cards (`references/packs/frameworks/<id>.md`) give a lens a proven way to fill a gap. Each card's frontmatter names its `lens` and the category codes it `fills`. Choose cards here and hand the chosen card to the lens with the category; the lens asks the card's questions.

1. **Only for an open gap**: pick a card for a category only when the category is on the frontier with status `missing` or `partial`, the card's `fills` includes that category, and the card's `lens` is the module that fills the category (table above). Read the card's "When to use" and "When not to use" against the idea's files and skip a card whose "When not to use" matches.
2. **At most two per lens per idea**: count the distinct card ids already listed in the `frameworks` of every category that lens fills. When the count is two, add no new card for that lens; it keeps using the two it has, or none.
3. **One new card per category per round**: when several cards fit, choose the one whose "When to use" best matches the idea's situation and the depth (none at `clear` unless asked by name; `test-and-control-pilot` first at `complex` when it fits).
4. **Plain words**: the lens asks the card's questions in everyday words. Do not name the framework in questions or make the user learn it; the outputs name it later.
5. **Record**: when a round asked at least one question from a card and that question was answered, add the card's id to the `frameworks` list of the category it filled. A card whose questions were all skipped is not recorded.
6. **Not chosen here**: cards with `lens: plan` are applied by the plan module at packaging, and the Cynefin card serves "Depth" only; neither counts toward a lens's two.
7. **No card, no framework**: if the pack folder or a card is missing, the lens works without it. Never apply a framework from memory without its card.

**When the user asks for a framework by name** (for example "dùng Balanced Scorecard", "phân tích SWOT giúp tôi"), match the name, in any language or common short form, to a card's `name` or `id`:

- **It fits**: the card's `fills` includes a category that is `missing` or `partial` and the lens has room under the two-card limit. Apply it in the next round for that category (or as soon as the category reaches the frontier, and say so), even at `clear` depth.
- **It does not fit**: every category in its `fills` is already `clear` or `deferred`, or its lens already has two cards. Say why in one or two plain sentences (what the framework is for, and that this part is already settled or that two methods are already in use for it), then name the card that fits the open gap closest to what the user seems to want, and offer it through the question tool: use the fitting card (recommended), or continue without it. Example: "Balanced Scorecard dùng để gắn ý tưởng với mục tiêu chiến lược, mà phần mục tiêu và cách đo của ý tưởng này đã rõ. Phần còn mở là vì sao doanh số giảm; cách hỏi 5 lần “vì sao” hợp với phần đó hơn."
- **It is a planning card** (`lens: plan`): say it is used when the plan is built at packaging, and note the request in the spec's Clarifications so packaging sees it.
- **There is no card for it**: say this version does not include that method, name the card that fits the open gap instead, and offer it the same way. Organization OKRs are not a card: when the ground rules record them, the outcome lens maps the idea to them.

## Contradictions

When an answer conflicts with an earlier decision in `decisions.md`:

1. Do not write the new answer as a decision yet, and do not edit the earlier entry.
2. Set the affected category to `partial` until the user decides.
3. In the next round, ask first, through the question tool, which one stands. Show the earlier decision with its date in the question so it stands on its own. Options: keep the earlier decision, or replace it with the new answer; recommend the one better supported by the facts on file, and say why in the option's description. Example: "Ngày 05/11 bạn chọn thử nghiệm ở 3 cửa hàng (D-004). Câu trả lời vừa rồi nói triển khai cả 24 cửa hàng ngay. Bạn giữ phương án nào?"
4. If the new answer stands, append a `supersede` entry naming the old id in `supersedes`, with the date and the user's reason, and apply it to the spec. If the earlier one stands, record the answer in Clarifications and change nothing else. Either way, the earlier entry stays in the record with its date.
5. Restore the category's status from what is now answered.

## Two ideas in one

An idea holds two independent problems when they affect different people or need different outcomes, and each could be approved, built and measured without the other (for example "nhắc khách quay lại mua" and "chấm công nhân viên cửa hàng" in one request).

1. Propose the split through the question tool, before the next round's other questions: split into two ideas (recommended when the two are independent), or keep them together. Name both parts in the user's words.
2. On split: the current idea keeps the part the user named first, unless they choose otherwise. Create a new idea folder for the other part by the specify module's rules (`references/core/specify.md`, steps 2–7), using the user's words about that part as its input without asking a new intake question. Copy the answers that belong to the new part into its spec and Clarifications; in the current spec, remove that part's content from the business sections and Spec Kit sections and keep the Clarifications history unchanged. Append an `answer` decision to both ideas naming the other folder. Re-mark the current idea's categories from what remains.
3. On keep together: append an `answer` decision with the user's reason, and do not propose the split again unless a later answer shows a new, separate problem.

## Readiness

The idea is ready to package when all of these hold:

- A, C, D and E are `clear`;
- F is `clear` when the idea involves AI;
- M has at least a small, medium or large size recorded;
- every other category is `clear` or `deferred` with a reason.

When `cynefin` is `chaotic`, do not set `ready` and do not offer to package, even when the conditions hold: the crisis comes first (see "Depth"). Offer pause instead, and write a `next_step` that names returning to the idea once the situation is stable.

When ready and `status` is `clarifying`, set `status` to `ready`. When a later answer reopens a gap in a `ready` idea, set it back to `clarifying`. Do not change any other status; those transitions belong to packaging and board outcomes.

When ready, offer through the question tool: package now (recommended), or keep refining the remaining partial points. On package, hand over to the `package` entry skill; if you cannot start it from here, tell the user in one sentence to type `/vibebiz:package`.

## Budget

When `budget_rounds_used` reaches the session budget (three rounds by default, `references/core/ask-protocol.md`) and the idea is not ready, stop and offer through the question tool:

- **Continue**: allow another budget of the same size in this session; the counter keeps counting and the offer returns at the next multiple.
- **Pause**: everything is already saved. Tell the user in one sentence what comes next and that they resume with `/vibebiz:continue`.
- **Draft**: an export with every gap labelled "not yet clarified" (in the idea's language). Hand over to the `package` entry skill and say a labelled draft is wanted; if it is not available, tell the user the draft requirement is already saved in the idea folder and offer pause.

Recommend continue when the frontier still has categories scoring 6 or more, otherwise pause. With nobody to answer, choose pause and stop.

## Next step

After every round, write `next_step` in `coverage.md`: one short action in the idea's language that tells the user what happens next, naming the topic in plain words, never a code or file. Examples:

- "Trả lời 3 câu hỏi về cách đo kết quả"
- "Chọn giữa phương án cũ và câu trả lời mới về số cửa hàng thử nghiệm"
- "Đóng gói ý tưởng thành bản trình bày và tài liệu cho đội kỹ thuật"
- "Hỏi bộ phận kho số đơn trả hàng mỗi tháng" (when the next step waits on someone else)

The table of contents copies this text, so write it for a reader who sees nothing else.
