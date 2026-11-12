# Module: router

Run the interview loop for one idea: decide what to ask next, hand each category to the module that fills it, keep the session within its question budget, and tell the user what comes next. Used by the `new` and `continue` entry skills.

- **Reads**: the idea's `coverage.md`, `spec.md`, `decisions.md`, `assumptions.md`, `open-questions.md`, `glossary.md`; the workspace `constitution.md`.
- **Writes**: `coverage.md` (`budget_rounds_used`, `next_step`, `status` between `clarifying` and `ready`, `updated`, the body table); `decisions.md` for `supersede` and split decisions.
- **Asks through**: `references/core/ask-protocol.md`, which owns the question rules, the default budget of three rounds, Skip, the all-skipped round, no-answer runs and the per-round write-back of answers, decisions and open questions.

Follow `references/core/writing-rules.md` for everything the user reads. Speak to the user in the idea's `language`.

## The loop

At the start of a session (the first round for this idea in this conversation), set `budget_rounds_used` to `0`. Then repeat:

1. **Re-read** every idea file listed above. The user may have edited them by hand; their edits are authoritative, so work from the current files and never restore an older version.
2. **Check readiness** (see "Readiness"). If ready, offer to package and stop the loop unless the user chooses to keep going.
3. **Resolve conflicts first**: if the last answers contradict an earlier decision, handle it (see "Contradictions") before anything else.
4. **Check for two ideas** (see "Two ideas in one") when the intake or the latest answers suggest it.
5. **Compute the frontier** and **rank** it (below).
6. **Look facts up** for every candidate question before asking it (see "Facts before questions").
7. **Choose the module** for each category in the round and let it write the round's questions (see "Who fills what"). One round holds at most four questions in total, taken from the highest-ranked categories first.
8. **Ask the round** through the ask protocol, which writes the answers back.
9. **Close the round**: increment `budget_rounds_used` by one (an all-skipped round counts too), make sure each category the round touched has its new status, rebuild the `coverage.md` body table from the frontmatter, write `next_step` (see "Next step"), set `updated` to today, and rebuild the table of contents by the workspace module's rules (`references/core/workspace.md`). Do this after every round, so an abandoned session loses nothing.
10. **Check the budget** (see "Budget"). If budget remains, go back to step 1.

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

**Fallback while a lens module is absent**: if the lens file for a category does not exist in this skill's `references/core/lenses/` folder, the clarify module handles the category, using the category's elements in the frontier table as its checklist. Do not invent lens techniques the module would normally bring. For M, clarify asks only for a size (small, medium or large) and records it as `not tech-reviewed`.

The filling module writes the content into `spec.md` and sets the category's status: `clear` when every element of the category is answered, `partial` when some are, unchanged when every question on it was skipped. A category becomes `deferred` only when the user says so, with their reason in `reason`.

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
