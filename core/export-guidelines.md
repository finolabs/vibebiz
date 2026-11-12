# Module: export guidelines

The rules every output follows: the board view, the tech view and their Google Slides and Docs versions. The package module reads this file before it builds `exports/data.json`, fills the templates or writes through a connector. This module holds rules only; it reads and writes no file.

- **Used by**: package.
- **Reads**: nothing.
- **Writes**: nothing.
- **Fills**: the output rules and the look of the outputs.

Write everything the reader sees by `references/core/writing-rules.md`, in the idea's `language` (Vietnamese by default). Field names, ids and the fixed English label values in `data.json` stay as written below in every language; the templates translate the labels for display.

## 1. One source, no new facts

1. **The idea folder is the only source.** Every slide and section is built from fields in the idea's files (`spec.md`, `plan.md`, `decisions.md`, `assumptions.md`, `open-questions.md`, `glossary.md`, the diagram briefs). List them in the slide's or section's `source_fields` by section heading or record id (`Outcome`, `Cost & Risk`, `FR-003`, `D-007`). A slide or section with nothing to cite does not exist yet: it is a gap (rule 3).
2. **Add no facts.** Packaging rephrases and shortens; it never adds a number, a claim, a name, a date or a benefit the files do not hold, not even an obvious one. When a slide reads thin, it stays thin.
3. **Show every gap.** An empty field is never dropped and never papered over. It appears as "not yet clarified" (in Vietnamese "chưa làm rõ"). A whole slide or section with nothing on file is listed in `gaps` as `slide:<n>` or `section:<id>` and the template shows it with the label; a single empty field inside a slide is a `gap` block naming the field.
4. **One value per figure.** Every number lives once in `numbers[]` as `{id, value, unit, source, period, label}`, with `label` either `measured` or `assumed`. Slides and sections refer to it only by id: through `figure_id`, `figure_ids`, or a `{{fig:<id>}}` token inside text. Never type a figure's value into text, so the board and tech views can never show two values. A figure without source or period on file is a gap, not a figure.
5. **Label estimates until the tech team reviews them.** A cost, effort, resource, return or other estimate is a figure labelled `assumed`, or marked `estimate: true`. While `idea.estimate_status` is `not-tech-reviewed`, every slide, section or block that shows one carries `estimate_label: "not tech-reviewed"` (shown in Vietnamese as "chưa qua kỹ thuật thẩm định"). After a recorded tech review sets it to `tech-reviewed`, remove the label everywhere in the next export.
6. **Draft means draft.** A package below readiness sets `idea.draft` to `true`; every gap is labelled and every page shows that it is a draft.
7. **Private only.** Nothing in `data.json` or any output is marked public or shared. Artifacts are published private; vibebiz never shares an output and never makes an image or file public to place it in Slides or Docs. When an image cannot be inserted privately, use a table plus the link to the diagram in the Artifact.

## 2. Board view: answer first

The board decides; it does not read a story. Lead with the answer and support it after: the deck opens with the decision requested, and each slide states its point before its evidence (situation, complication, question and answer in that order inside a slide only when the slide needs the background).

- **One message per slide.** `message` is one sentence, with no line break and no second point. If a slide needs two messages, one of them belongs on another slide or in the appendix.
- **The title states the takeaway.** `title` is the conclusion the board should remember, as a full sentence with its key figure where one exists ("Mỗi tháng mất {{fig:N-02}} đơn vì khách chờ trả lời quá lâu"), never a topic label ("Vấn đề", "Chi phí").
- **Everything on the slide supports the title.** Blocks that do not support the title move to the appendix.

### Slide map

The deck has these nine slides plus an appendix, in this order, with `n` 1 to 9 and then `"appendix"`. Each slide draws on the sources named; the categories column says which coverage categories feed it, which decides where a framework's result appears.

| n | Slide | Draws on | Categories |
|---|---|---|---|
| 1 | Decision requested: what is to be approved, how much, by when | `plan.md` Decision requested, Cost & Risk | M |
| 2 | The problem and what it costs today, in numbers | Problem & Why | A, B |
| 3 | The outcome: what drives it, baseline to target, guardrails | Outcome, Success Criteria | C, O |
| 4 | Alternatives considered: do nothing, fix the process, buy, build | Alternatives | D |
| 5 | Proposed solution: the journey before and after | Alternatives (chosen), User Story 1, AI-fit | E, F |
| 6 | First-release scope and what comes later | User Scenarios & Testing, Requirements (out of scope) | E |
| 7 | Cost, resources and return in low, base and high scenarios | `plan.md` Size and scenarios, Cost & Risk | M |
| 8 | Risks, how the idea could fail, kill criteria | Cost & Risk, Outcome (kill criteria), decisions on dismissed risks | K, M |
| 9 | Pilot roadmap and decision points | `plan.md` Pilot roadmap and Organizational change | L |
| appendix | Assumptions and open questions | `assumptions.md`, `open-questions.md` | all |

- When the challenge concluded that the right answer is not to build (fix the process, buy or do nothing), the deck keeps the same map and presents that recommendation: slide 1 asks for that decision and slide 5 shows the process or purchase instead of a new system.
- **Frameworks**: name every framework applied to the idea (the card ids in each category's `frameworks` in `coverage.md`, and the planning cards the plan applied) in `frameworks[]` of the slide its category feeds, with its result on that slide, and credit its origin as the card states it. A framework whose categories feed no slide (data, integrations, non-functional needs, edge cases, terminology) is named in the tech section it feeds instead.
- **The appendix** lists every assumption with whether it was tested and every open question with its owner and whether it blocks, so the board sees what is still uncertain.

## 3. Tech view

The tech view is for the internal tech team and keeps the requirement's structure so they can start planning from it. Its sections, in this order:

1. **Business context**: a short summary of the problem, the outcome and the chosen alternative, so a developer knows why before what.
2. **User stories**: every story in priority order with its Given, When, Then scenarios, and the edge cases.
3. **Requirements**: the functional requirements with their `FR-###` ids, and what is out of scope.
4. **Key entities**: the things the idea keeps or uses and their facts, in business words.
5. **Success criteria**: with their `SC-###` ids and figures.
6. **Assumptions**: from the requirement, when it has any.
7. **AI fit**: rule, automation or AI; the data available; the cost of a wrong answer; where a person approves. When the idea uses no AI, say so in one line.
8. **Non-functional needs in plain words**: number of users, peak hours, store connectivity, devices, how fresh data must be.
9. **Glossary**: every term with its plain meaning.
10. **Open questions**, split into blocking and non-blocking, each with its owner and what it unblocks.

Use the section ids that the tech requirements template defines for these sections, so the package check can find them. Keep the requirement's ids (`FR-###`, `SC-###`, `D-###`, `A-###`, `Q-###`) unchanged; never renumber. The requirement snapshot (`exports/spec.md`) ships alongside, as an exact copy of the idea's `spec.md`: its Spec Kit headings stay in English in every language.

## 4. Look and layout

- **One brand source.** Colors, fonts and logo come only from the brand profile of the companion diagram-design plugin. Without it, keep the templates' neutral look. Never invent a palette or apply an organization's brand from memory.
- **Diagrams** come from the diagram briefs, rendered by diagram-design as SVG and embedded. Without diagram-design, the slot shows a table with a "no diagram" note (in Vietnamese "chưa có sơ đồ") and the user is told once how to add the plugin; never draw a substitute.
- **Calm and readable**: generous white space, one idea per slide, a consistent order of title, message, evidence, source line. No decorative images, clip art or stock photos. Both templates support light and dark mode; do not override it.
- **Natural wording.** Edit Vietnamese for natural reading before delivery (the writing rules' style section): no word-for-word translation, no stacked nouns, no English where a common Vietnamese word exists.

## 5. Charts

1. **Choose the chart for the question**: change over time as a line or bars in time order; comparison between options or scenarios as bars; part of a whole as stacked bars, or a pie only with five parts or fewer; ranking as sorted horizontal bars; baseline to target as two bars or a line with the target marked. When a table answers the question more plainly, use the table.
2. **Every chart shows its source and period.** A `chart` block names a non-empty `source`, and every figure it plots comes from `numbers[]`, which carries the period. When the plotted figures span different periods, say so in the chart title.
3. **No 3D, no decoration**: no shadows, gradients or dual axes; bars start at zero; label values directly instead of relying on a legend where possible.
4. **Estimates look like estimates**: a chart of estimates carries the "not tech-reviewed" label like any other block, and assumed figures are marked as assumed.
5. **The chart's title is its takeaway**, as for slides.

## 6. Word limits

Count words as space-separated units (each Vietnamese syllable counts as one). The appendix and the tech view's structured lists (stories, requirements, glossary, open questions) are exempt.

| Element | Limit |
|---|---|
| Slide title | 20 words |
| Slide message | 35 words |
| All other text on one board slide, excluding figure source lines and table cells | 80 words |
| A table on a board slide | 5 rows and 4 columns; longer tables go to the appendix |
| A paragraph in the tech view | 80 words |

When the content does not fit, cut words, never facts: move detail to the appendix or the tech view rather than drop it.

## 7. Before handing over

Check each output against this list; the package check verifies the structural items in code, and the rest are yours to check:

- every slide 1–9, the appendix and every tech section is present or listed in `gaps`;
- every slide has a takeaway title and one message within the word limits;
- every slide and section names its `source_fields`;
- every figure is referenced by id and carries source, period and label, and no figure value is typed into text;
- every chart names its source and period;
- estimate labels match `estimate_status`;
- every framework applied is named on the slide or section its category feeds;
- nothing is marked public or shared, and `links.md` lists the same links as `data.json`.
