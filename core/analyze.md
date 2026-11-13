# Module: analyze

Read every file of one idea and find where they disagree with each other or leave a gap, before anything is packaged. Return the findings, each with a severity, to the router, which turns the ones that need a decision into questions. This module changes no file and asks the user nothing.

- **Used by**: package, after the plan and checklist modules and before any output is built.
- **Reads**: the idea's `spec.md`, `plan.md`, `coverage.md`, `decisions.md`, `assumptions.md`, `open-questions.md`, `glossary.md`, `checklists/board.md`, `checklists/tech.md`, the diagram briefs in `diagrams/`; the workspace `constitution.md`.
- **Writes**: nothing. The findings are returned in the conversation (section 6).
- **Fills**: the consistency result.

The approach comes from Spec Kit's `analyze` command (GitHub, MIT license): a read-only cross-file pass that builds an inventory of what the files claim, runs a fixed set of detection passes, ranks what it finds by severity and hands the list back instead of editing anything. vibebiz keeps that shape and changes what is compared: the business sections, the plan, the decisions and assumptions records and the figures of one idea, instead of a spec, a technical plan and a task list.

## 1. Rules

1. **Read-only.** Do not edit, fix, reword or reorder any file, even when the fix looks obvious. A fix chosen by vibebiz is a fact the user did not give; the router asks for it instead. Do not update `coverage.md` either: statuses change only when the router acts on a finding.
2. **Work from the files as they are now.** Re-read each file at the start of the run; the user's hand edits are authoritative. Never fill a gap from memory of the conversation.
3. **Report only what the files show.** Every finding names the files and section headings it comes from and quotes the conflicting words or figures briefly. Never report a section as missing without having looked for it, and never invent a conflict to look thorough. A clean idea gets an empty findings list.
4. **Same files, same result.** Run the passes in the order of section 3 and number findings in that order, so a second run on unchanged files gives the same ids and counts.
5. **Talk to the router, not the user.** The findings are written in English for the router. Only the `ask` line of each finding (section 5) is written in the idea's language, in plain words, because the router may reuse it when it writes the question.
6. **At most 50 findings.** Keep the highest severities; summarize the rest by pass and count in one line.

## 2. Build the inventory first

Before the passes, note for yourself (do not output it) what each file claims:

- **Figures**: every number in any file, with its value, unit, source, period, measured or assumed label, the estimate label when present, and where it appears. Treat two numbers as the same figure when they describe the same quantity for the same scope (for example "số tin nhắn chờ quá 15 phút mỗi ngày" in Outcome and in a success criterion).
- **Decisions**: every `D-###` with its date, type and whether a later `supersede` entry replaces it; the current decision on each topic is the latest one not superseded.
- **Requirements**: each user story with its priority and acceptance scenarios, each `FR-###`, each `SC-###`, the outcome's baseline, target, time frame, guardrails and kill criteria.
- **Assumptions and open questions**: each `A-###` with `tested` and `riskiest`; each `Q-###` with `blocking`, `category` and `status`.
- **Coverage**: each category's status and reason, `estimate_status`, `language`.
- **Terms**: each glossary term and the other words the files use for the same thing.
- **Gaps**: every "not yet clarified" marker in the idea's language (in Vietnamese `chưa làm rõ`), every `[NEEDS CLARIFICATION]` marker, every bracketed template placeholder left in place, every empty section.

## 3. The passes

Run every pass. Each pass has a letter used in finding ids.

**D: duplicates.** Two stories, requirements, success criteria, risks or glossary entries that say the same thing in different words, or one figure stated twice under different names. Note which wording is clearer; the router asks which one stays only when they differ in substance, otherwise the finding is low.

**X: contradictions.** Two statements that cannot both hold:
- a section of `spec.md` or `plan.md` still applies a decision that a later `supersede` entry replaced, or says something different from the current decision on the same topic;
- the plan's scope, pilot or rollout differs from the spec's (stores, channels, dates, the chosen alternative);
- the chosen alternative in Alternatives differs from what the stories and the plan build (for example "fix the process" chosen, but the stories describe a new system);
- a category marked `clear` in `coverage.md` whose section still holds a gap, or a category marked `deferred` with no reason;
- `estimate_status` in `plan.md` differs from `coverage.md`;
- the plan exceeds the approval ceiling or skips a mandatory human approval in `constitution.md` with no `ground-rule-conflict` decision on file;
- a diagram brief whose message or figures differ from the sections it names as its source.

**M: unmeasurable outcomes.** The outcome, a success criterion, a guardrail, a kill criterion or a requirement that cannot be checked:
- the outcome lacks a baseline or a measurement plan, a target, a time frame, at least one guardrail or a kill criterion;
- it states an activity instead of a result ("có chatbot" instead of the change the chatbot should bring);
- it uses a vague quality word with no number (the writing rules' list: "nhanh", "tốt hơn", "thông minh"…), outside a quote marked as the user's words;
- a success criterion names no metric the business can read, or names how the system is built instead of what changes for people.

**F: figures that differ.** Use the figure inventory:
- the same figure with different values, units or periods in two places (spec and plan, spec and a diagram brief, a scenario table and Cost & Risk);
- a figure with no source, no period or no measured or assumed label;
- a derived figure (a total, a payback, a percentage change) that does not follow from the figures it names;
- while `estimate_status` is `not-tech-reviewed`, an estimate without the "not tech-reviewed" label; once `tech-reviewed`, an estimate that still carries it;
- a baseline presented as measured whose source is the user's guess, or an assumed figure presented as a fact.

**A: requirements without acceptance.**
- a user story without at least one Given, When, Then scenario, or with a scenario that cannot be checked by watching what happens;
- a functional requirement that no story or scenario covers;
- an outcome or success criterion that no story contributes to, or a priority-one story that no success criterion measures;
- an AI decision with no human approval point or no stated cost of a wrong answer, when the idea involves AI.

**G: gaps.** Every gap from the inventory, judged against readiness:
- a gap in a category readiness requires (problem, outcome, alternatives and scope; AI fit when AI is involved; at least a small, medium or large size for cost) is never acceptable;
- a gap in a category marked `deferred` with a reason is expected: report it as low only when the section does not say it is deferred;
- an open question marked `blocking` with `status: open`;
- the riskiest assumption untested with no test in the plan's pilot.

**T: terminology drift.** Two words used for one thing across files ("khách quay lại" in Outcome, "khách trung thành" in the plan), or a glossary term used with another meaning.

**P: principle checks.** The rules vibebiz keeps for every idea: doing nothing and fixing the process were weighed before build; a risk the user dismissed appears in `decisions.md` with their reason (a risk listed in an earlier export or in Clarifications that is now in neither Cost & Risk nor `decisions.md`); no number lacks a source.

## 4. Severity

| Severity | Meaning | Examples |
|---|---|---|
| critical | The board or the tech team would decide on something false, or a readiness condition is not met | a figure with two values; the plan contradicting the current decision; a readiness category with a gap; a ground-rule conflict with no decision on file; build chosen without weighing doing nothing and fixing the process |
| high | A claim the board or the tech team cannot check | an unmeasurable outcome; a vague word in a requirement; a story without acceptance; a figure missing source, period or label; a missing or stale estimate label; an open blocking question; a dismissed risk missing from the record |
| medium | The reader could be misled, but no decision changes | terminology drift; a duplicate that differs in substance; a requirement no story covers; a diagram brief out of step with its source on wording only |
| low | Wording and tidiness | a duplicate with the same meaning; a deferred gap whose section does not say it is deferred |

Every contradiction and every gap in a readiness category is critical or high: those always go back to the interview before packaging. Medium and low findings go to the router too, which may ask them in the same round or leave them for the user to see in the draft.

## 5. Each finding

Give each finding these fields:

- `id`: the pass letter and a running number within the pass (`X1`, `X2`, `F1`).
- `pass`: duplicates, contradiction, unmeasurable, figures, acceptance, gap, terminology or principle.
- `severity`: critical, high, medium or low.
- `categories`: the coverage codes A–O the finding touches, so the router can hand it to the module that fills them.
- `where`: file names and section headings (and the record ids such as `D-004`, `FR-003`, `A-002`).
- `what`: one sentence naming the conflict or gap, quoting the words or figures briefly.
- `resolve`: one of
  - `ask`: only the user can decide (which of two values stands, a missing target, a missing kill criterion);
  - `look-up`: the answer may already be in the workspace or the user's documents; the router looks it up before asking;
  - `owner`: the answer belongs to someone else (the tech team for an estimate, the warehouse for a volume); the router records or updates an open question;
  - `restate`: the files already hold the answer and only another file is out of step (for example the plan still uses a superseded store count); the router confirms with the user before the owning module rewrites it, because analyze never edits.
- `ask`: for `ask` and `restate`, the decision in one plain sentence in the idea's language, with no file name, code or jargon. Example: "Kế hoạch ghi thử ở 24 cửa hàng, nhưng quyết định ngày 05/11 là thử ở 3 cửa hàng. Giữ con số nào?"

## 6. Return to the router

Return one block in this order:

1. **Verdict**: `clear` when there is no critical or high finding, `return-to-interview` otherwise.
2. **Findings**: a table with the fields of section 5, critical first, then high, medium, low; within a severity, in pass order.
3. **Counts**: findings by severity and by pass, and the overflow line when more than 50.
4. **Gaps for the outputs**: the sections and fields that will show "not yet clarified", so the package module lists them in `gaps` and a labelled draft shows them.

What happens next is decided outside this module:

- On `return-to-interview`, the router treats the findings as frontier items: it sets the categories they touch to `partial` where they were `clear`, resolves contradictions first by its own rules (show the earlier decision with its date and ask which stands), looks facts up before asking, and asks the rest within the usual round and budget limits. Nothing is packaged until a new analyze run returns `clear`, unless the user chooses a labelled draft.
- On a labelled draft, the findings do not block: the package module shows every gap as "not yet clarified" and marks the outputs as a draft.
- With nobody to answer, the router records each `ask` finding as an open question and changes no decision.
