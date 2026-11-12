# Feature Specification: Idea to PRD

**Feature Branch**: `001-idea-to-prd`

**Created**: 2026-11-12

**Status**: Draft

**Input**: User description: "The vibebiz MVP: a Claude Cowork plugin that takes a non-technical retail sales director from a vague idea about a system, an AI use or an automation to a clarified, challenged and measurable requirement, packaged as a board view and a tech view, with help, docs and a fictional example. Design decisions are recorded in `CLAUDE.md` and the constitution."

## Settled Decisions

Decided by Fio on 2026-11-12 during the design session (full detail in `CLAUDE.md`):

- Primary user: a retail sales director (online or offline) in fashion, electronics, home appliances or similar retail, who is not technical and uses Claude Cowork.
- Purpose: internal use first; Finolabs sells commercial licenses later.
- Outputs: a board view (Claude Artifact or Google Slides) for approval, and a tech view (Claude Artifact or Google Docs) with a Spec Kit-compatible `spec.md` for the internal tech team.
- The interview follows Spec Kit 1.4.0's `clarify` coverage approach, extended for business, with frontier rounds adapted from `grilling`, asked through Cowork's native question tool.
- No dependency on `finolabs-vibecode`; `diagram-design` is a companion plugin.
- The first release ships the fashion vertical pack only; electronics and home appliances come later (Fio, 2026-11-12, during specification).
- vibebiz ships a library of management frameworks chosen by coverage gap; the first release carries fifteen cards selected for fashion apparel retail; third-party material is never copied verbatim (Fio, 2026-11-12).
- The appendices below record the agreed design detail from the design session so it is not lost; requirements above take precedence where they are more specific.

## Clarifications

### Session 2026-11-12

- Q: May vibebiz share an exported Artifact link with other people? → A: No. vibebiz publishes Artifacts as private only and never shares them; the user shares them with the board or tech team themselves.
- Q: Which language do the board view, tech view and requirement snapshot use? → A: The language the user is communicating in; Spec Kit's mandatory section headings stay as upstream so the snapshot remains compatible.
- Q: What happens to earlier exports when an idea is packaged again? → A: Keep history. `exports/` always holds the latest outputs under their fixed names; the previous set moves to `exports/history/YYYY-MM-DD/`; each Artifact is updated at the same link.
- Q: Does vibebiz record the board's decision for each presented version? → A: Yes. The user reports the outcome through continue; vibebiz records approved, rejected or needs changes, with date and notes, in the decisions record, tied to the presented version in history, and shows it as the idea's status.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Turn a vague idea into a clarified requirement (Priority: P1)

A sales director opens a folder in Cowork, starts vibebiz, and describes an idea in a sentence or two, for example "I want AI to remind customers to come back and buy again." vibebiz sets up a workspace if none exists, records the idea in the user's own words, drafts a first requirement with every gap marked, and then interviews the user in short rounds of multiple-choice questions, each with a recommended answer. Each round asks only what can be decided now, in an order where no answer depends on a question not yet settled. After every round the answers are written to the idea's files. When the session's question budget runs out, the user chooses to continue, pause or export a draft.

**Why this priority**: Clarifying a vague idea is the core value; every other story builds on the files this one produces. On its own it already gives the user a written, structured requirement they did not have before.

**Independent Test**: In an empty folder, start vibebiz with a one-sentence idea, answer three rounds of questions, and confirm that the workspace exists, the idea folder holds a draft requirement whose answered points match the answers given, and the coverage record shows which categories are clear, partial or missing.

**Acceptance Scenarios**:

1. **Given** an empty folder opened in Cowork, **When** the user starts a new idea, **Then** vibebiz creates the standard workspace (table of contents, constitution file, ideas folder) and a numbered folder for the idea, and overwrites nothing.
2. **Given** a folder that already holds files unrelated to vibebiz, **When** the user starts a new idea, **Then** vibebiz asks whether to set up the workspace here or in a new subfolder, recommending the subfolder.
3. **Given** a new idea, **When** the first round of questions appears, **Then** it holds at most four questions, each with two to four mutually exclusive options, the recommended option first, no "None" or "Other" option, and enough context to be understood on its own.
4. **Given** a round in progress, **When** the user skips a question, **Then** that point stays unanswered in the coverage record and is not treated as accepting the recommendation.
5. **Given** a question that depends on another unsettled question (for example return on investment before the outcome is set), **When** vibebiz builds a round, **Then** the dependent question is held for a later round.
6. **Given** a fact vibebiz can find in the workspace or the user's connected documents, **When** it would otherwise ask, **Then** it looks the fact up instead and asks only for the decision.
7. **Given** the user answers with a vague term such as "real-time", "smart" or "fast", **When** vibebiz records the requirement, **Then** it asks for a measurable value before writing it as a requirement.
8. **Given** the session's question budget is used, **When** the round ends, **Then** vibebiz offers to continue, pause, or export a draft with the gaps labelled.

---

### User Story 2 - Challenge the idea and define its outcome (Priority: P2)

Once the problem is clear, vibebiz guides the user through four thinking lenses as the coverage gaps require: framing the real problem (who suffers, how often, what it costs today), defining a measurable outcome (baseline, target, guardrails, kill criteria), challenging the idea (pre-mortem, riskiest assumptions, and the alternatives of doing nothing, fixing the process or buying), and sketching the solution (current and future journey, three alternative approaches, a check of whether rules, automation or AI fit, the smallest valuable first release, edge cases and organizational change).

**Why this priority**: Without challenge and a measurable outcome, the requirement is a wish list; the board cannot approve it and the tech team cannot test it. It depends on Story 1's files.

**Independent Test**: Seed a clarified idea that is deliberately weak (for example "replace all customer service staff with an AI chatbot next week"), run the lenses, and confirm that vibebiz names concrete risks, presents doing nothing and fixing the process as serious options, and records every risk the user dismisses.

**Acceptance Scenarios**:

1. **Given** a clarified problem, **When** the outcome lens runs, **Then** the outcome is stated as a change in a measured result, with a baseline, a target, a time frame, at least one guardrail and a kill criterion.
2. **Given** no baseline exists, **When** the outcome lens runs, **Then** vibebiz writes a measurement plan (what, where, for how long) instead of inventing a number.
3. **Given** any idea, **When** the challenge lens runs, **Then** each round gives at least one reason the idea could fail, never praises the idea, and compares the idea with doing nothing, fixing the process and buying before building is accepted.
4. **Given** the user dismisses a risk, **When** the round is recorded, **Then** the risk and the user's reason are kept in the decisions record.
5. **Given** an idea that involves AI, **When** the solution sketch runs, **Then** it records whether a rule, an automation or AI is the right tool, what data exists, what happens when the AI is wrong, and where a person must approve.
6. **Given** the solution sketch, **When** it is complete, **Then** the first user journey can be delivered and demonstrated on its own.
7. **Given** a coverage gap that a known management framework fills (for example a driver tree for an outcome, or a fishbone for a root cause), **When** a lens runs, **Then** vibebiz applies at most two frameworks for that lens, asks in plain words without making the user learn the framework, and names the framework in the outputs.
8. **Given** the user asks for a framework by name (for example "use the Balanced Scorecard"), **When** it fills an open gap, **Then** vibebiz applies it; **When** it does not, **Then** vibebiz says why and names the framework that fits the gap.

---

### User Story 3 - Package for the board and the tech team (Priority: P3)

When the coverage record shows the idea is ready, the user asks vibebiz to package it. vibebiz checks readiness and consistency, then produces a board view (decision requested, problem and its cost, outcome, alternatives considered, proposed solution, first-release scope, cost and return in three scenarios, risks and kill criteria, pilot roadmap, appendix of assumptions and open questions) and a tech view (business context, user journeys with acceptance scenarios, requirements, success criteria, AI fit, non-functional needs in plain words, glossary, blocking and non-blocking open questions), plus a snapshot of the requirement file that the tech team can feed into Spec Kit directly. Diagrams illustrate the metric tree, journeys, alternatives, risks and roadmap.

**Why this priority**: Packaging turns the work into something the board can decide on and the tech team can build from. It needs Stories 1 and 2 to have content worth packaging.

**Independent Test**: Package a ready idea and confirm that every board slide and tech section traces to a field in the idea folder, the same numbers appear in both views, unfilled fields show as "not yet clarified", and `speckit-plan` runs on the exported requirement file without manual edits.

**Acceptance Scenarios**:

1. **Given** an idea below the readiness threshold, **When** the user asks to package, **Then** vibebiz lists what is missing and offers to continue the interview or export a labelled draft.
2. **Given** a ready idea, **When** packaging starts, **Then** the user chooses the format for each view through one question round (board: Artifact or Slides; tech: Artifact or Docs).
3. **Given** a field that is empty, **When** a view is produced, **Then** the field appears as "not yet clarified" and is never silently dropped.
4. **Given** both views, **When** they are compared, **Then** every number matches and carries its source, period and a measured or assumed label.
5. **Given** estimates not yet reviewed by the tech team, **When** a view is produced, **Then** every estimate is labelled "not tech-reviewed".
6. **Given** a board slide, **When** it is checked, **Then** it carries one message and its title states the takeaway, and every chart names its source.
7. **Given** the companion diagram plugin is not installed, **When** a view needs a diagram, **Then** a table with a "no diagram" note appears in its place and the user is told how to get diagrams.
8. **Given** the Slides or Docs format, **When** a diagram must be inserted, **Then** no image is ever made publicly accessible to do so; if it cannot be inserted privately, a table and a link to the diagram in the Artifact appear instead.
9. **Given** the tech team later confirms the estimates, **When** the user reports it, **Then** the label is removed from subsequent exports.

---

### User Story 4 - Resume work and see the state of every idea (Priority: P4)

A sales director comes back days later and opens the workspace's table of contents, which lists every idea with its status (clarifying, ready to package, packaged, presented to the board, approved, rejected, needs changes) and whether its estimates are tech-reviewed, its coverage (for example 9 of 15 clear), the next step and links to its outputs. They resume an idea; vibebiz summarizes in three lines what was settled, where it stopped and what comes next, and continues.

**Why this priority**: Ideas take several sessions; without resume and a clear overview, users lose their place and abandon ideas. It is valuable only once Stories 1–3 exist.

**Independent Test**: Create two ideas at different stages, close the session, reopen the folder, open the table of contents and resume one idea; confirm the table matches the folder and the summary matches the recorded decisions.

**Acceptance Scenarios**:

1. **Given** any change vibebiz makes in the workspace, **When** the change completes, **Then** the table of contents is rebuilt and matches the folder.
2. **Given** a paused idea, **When** the user resumes it, **Then** vibebiz states what was settled, where it stopped and the next question before asking anything.
3. **Given** the user asks for status, **When** vibebiz answers, **Then** it lists every idea with its coverage and next step, excluding the fictional example.
4. **Given** the user edited an idea's files by hand, **When** vibebiz resumes, **Then** it reads the current files and does not overwrite the edits.
5. **Given** a packaged idea, **When** the user reports that it was presented and the board approved, rejected or asked for changes, **Then** vibebiz records the outcome with date and notes against the presented version and the table of contents shows the new status.

---

### User Story 5 - Get help, read the docs, see an example (Priority: P5)

A user who is unsure what to do asks "how do I use this?" or "what do I do next?". vibebiz's help points to the right entry point for their situation and stops; it answers questions about vibebiz only from the shipped Vietnamese docs, with diagrams that show the workflow and its thinking, and says plainly when the docs do not cover something. The user can open a fictional example idea that went through the whole process to see what finished outputs look like.

**Why this priority**: Non-technical users will not remember entry points; help and a worked example lower the cost of the first and second use. It describes the other stories, so it comes after them.

**Independent Test**: Ask help a set of situation questions and questions about features that do not exist; confirm it routes each situation to the right entry point, refuses to invent features, and opens the example on request.

**Acceptance Scenarios**:

1. **Given** a described situation, **When** the user asks for help, **Then** help names the entry point to use and does not run it.
2. **Given** a question the docs do not answer, **When** help responds, **Then** it says the docs do not cover it instead of inventing an answer.
3. **Given** the user asks what a finished output looks like, **When** help responds, **Then** it offers to copy the fictional example into the workspace's examples folder.
4. **Given** the user describes a new idea to help, **When** help responds, **Then** it points to starting a new idea rather than answering as help.

---

### User Story 6 - Set the organization's ground rules (Priority: P6)

Before or after the first idea, the user records their organization's ground rules in four questions or fewer: this year's priorities, the budget ceiling they can approve themselves, their retail vertical, and the steps that always need a person's approval. vibebiz uses these rules when it challenges an idea and drafts the plan, and flags an idea that conflicts with them.

**Why this priority**: The ground rules sharpen challenge and planning, but every earlier story works with them deferred.

**Independent Test**: Record ground rules with a low budget ceiling, run an idea whose estimate exceeds it, and confirm the plan flags the conflict.

**Acceptance Scenarios**:

1. **Given** no ground rules, **When** the user starts the first idea, **Then** vibebiz offers to record them and lets the user skip, marking them deferred.
2. **Given** deferred ground rules, **When** the plan is drafted, **Then** vibebiz reminds the user that they are missing.
3. **Given** ground rules, **When** an idea conflicts with one, **Then** the conflict appears in the plan and the board view.

---

### Edge Cases

- The user skips every question in a round: nothing is recorded as decided, and vibebiz offers to pause or export a draft.
- The user abandons the session mid-round: answers from completed rounds are already saved; resume picks up at the open round.
- The plugin is invoked in a chat without a working folder: vibebiz says it needs Cowork with a folder open and does nothing else.
- No one can answer (an unattended or evaluation run): vibebiz proceeds on stated assumptions, records each as open, and never invents an answer.
- The user contradicts an earlier decision: vibebiz shows the earlier decision and asks which one stands; the replaced decision stays in the record with its date.
- The idea is really two ideas: vibebiz proposes splitting it into two idea folders.
- The challenge concludes the right answer is not to build (fix the process or buy): packaging still works and the board view presents that recommendation.
- Two ideas produce the same folder name: the number prefix keeps them distinct.
- The Google connector is unavailable: vibebiz offers the Artifact format instead.
- The user communicates in English: questions and all outputs for that idea are in English; Vietnamese stays the default otherwise.
- The user deletes the table of contents or the example: the next vibebiz action restores the table of contents; the example returns only on request.

## Requirements *(mandatory)*

### Functional Requirements

**Workspace and entry points**

- **FR-001**: vibebiz MUST offer six entry points the user can invoke: start a new idea, continue an idea, show status, package an idea, record ground rules, and help.
- **FR-002**: Starting a new idea MUST set up the standard workspace when absent, restore only missing pieces when partial, and never overwrite an existing file.
- **FR-003**: The workspace MUST follow the fixed layout and English file names defined in `CLAUDE.md`; only the idea folder's slug comes from the user's title, without diacritics.
- **FR-004**: The table of contents MUST list every idea with status, coverage, next step, links to outputs and last update, and MUST be rebuilt after every change vibebiz makes.
- **FR-005**: Every entry point that needs a workspace MUST detect a session without a working folder and tell the user to open Cowork with a folder instead of running partway.

**Interview**

- **FR-006**: vibebiz MUST track each idea's coverage across categories A–O (problem and why, users and stakeholders, outcome and measurement, alternatives, scope and behavior, AI fit, data and entities, integrations, non-functional needs, edge cases, risk and compliance, organizational change, cost and return, terminology, completion signals) with a status of Clear, Partial, Missing or Deferred with a reason.
- **FR-007**: Each round MUST contain only questions whose prerequisite categories are settled, ordered by impact and uncertainty.
- **FR-008**: Each round MUST follow the question rules in `CLAUDE.md`: at most four questions, two to four mutually exclusive options, recommended option first, no "None" or "Other", self-contained wording, open questions in plain text.
- **FR-009**: A skipped question MUST leave its category status unchanged.
- **FR-010**: vibebiz MUST write the answers and the resulting decisions to the idea's files after every round, with the date.
- **FR-011**: vibebiz MUST apply a per-session question budget (default three rounds) and then offer to continue, pause or export a draft.
- **FR-012**: vibebiz MUST ask for a measurable value whenever an answer uses an unquantified quality term before recording it as a requirement.
- **FR-013**: With no one to answer, vibebiz MUST proceed on stated assumptions recorded as open and MUST NOT record an invented answer as decided.

**Thinking lenses**

- **FR-014**: The problem lens MUST ask about the most recent real occurrence of the problem rather than hypotheticals, and MUST state the current cost in time, money or lost sales where the user can estimate it.
- **FR-015**: The outcome lens MUST produce a baseline (or a measurement plan), target, time frame, at least one guardrail and a kill criterion.
- **FR-016**: The challenge lens MUST NOT praise an idea, MUST give at least one reason per round the idea could fail, and MUST compare doing nothing, fixing the process and buying before building is accepted.
- **FR-017**: Risks the user dismisses MUST be kept in the decisions record with the user's reason.
- **FR-018**: The solution lens MUST record the current and future journey, at least three alternative approaches, the rules/automation/AI fit check, the smallest independently valuable first journey, edge cases and the people whose work changes.
- **FR-019**: Lens questions MUST draw on the fashion vertical pack when the recorded vertical is fashion, and MUST fall back to the general retail questions for any other vertical.

**Frameworks**

- **FR-036**: vibebiz MUST ship a framework library of cards, each stating when to use it and when not to, the coverage categories it fills, the inputs it needs, its question set, where its result is written, its diagram type, common misuse, a fictional fashion-retail example and its origin for attribution.
- **FR-037**: A lens MUST select a framework only to fill an open coverage gap, MUST apply at most two frameworks per lens per idea, and MUST ask in plain language.
- **FR-038**: The user MUST be able to request a framework by name; vibebiz applies it when it fills an open gap and otherwise explains why and names the framework that fits.
- **FR-039**: Outputs MUST name each framework applied, and the board view MUST show its result in the slide the framework's coverage category feeds.
- **FR-040**: The router MUST classify each idea's situation as clear, complicated, complex or chaotic and set interview depth from it: a quick path for clear, analysis for complicated, small pilots and experiments for complex, stabilize first for chaotic.
- **FR-041**: Framework cards and packs MUST be written in vibebiz's own words; no third-party text, layout or artwork is copied verbatim.
- **FR-042**: The first release MUST ship the fifteen core cards listed in Appendix F plus the Cynefin depth rule; the other frameworks in Appendix F come in later releases.

**Packaging**

- **FR-020**: Packaging MUST require Clear status for problem, outcome, alternatives and scope; Clear AI fit when AI is involved; at least a size estimate for cost; and Clear or Deferred-with-reason for every other category, or else offer a labelled draft.
- **FR-021**: Before producing outputs, vibebiz MUST check the idea's files for contradictions and gaps and return to the interview for any it finds.
- **FR-022**: The board view MUST contain the sections listed in User Story 3 in that order, one message per slide with the takeaway as its title.
- **FR-023**: The tech view MUST contain the sections listed in User Story 3, and MUST ship with a snapshot of the requirement file whose mandatory sections match Spec Kit 1.4.0 so that `speckit-plan` runs on it without edits.
- **FR-024**: Outputs MUST add no facts beyond the idea folder; empty fields MUST show "not yet clarified"; numbers MUST match across views with source, period and label; estimates MUST show "not tech-reviewed" until the review is recorded.
- **FR-025**: A packaging check MUST verify completeness, cross-view consistency, slide rules, chart sources and table-of-contents integrity before outputs are delivered.
- **FR-026**: vibebiz MUST write a diagram brief (message, type, source fields, placement) for each diagram and hand it to the companion diagram plugin; without that plugin, a table with a "no diagram" note MUST appear instead.
- **FR-027**: vibebiz MUST NOT make any image or document publicly accessible to insert it into Slides or Docs, MUST publish Artifacts as private, and MUST NOT share any output with anyone; sharing is the user's own action.
- **FR-027a**: Questions and outputs MUST use the language the user is communicating in (Vietnamese by default); the requirement snapshot MUST keep Spec Kit's mandatory section headings unchanged in any language.
- **FR-028**: Outputs MUST be saved under the idea's exports folder with their fixed names, and online links recorded in its links file. Packaging again MUST first move the previous set into a dated history folder, so every earlier version stays retrievable, and MUST update each Artifact at its existing link.

**Resume, help, ground rules**

- **FR-029**: Continuing an idea MUST start with a three-line summary of what was settled, where work stopped and the next question.
- **FR-029a**: vibebiz MUST record each board outcome (approved, rejected, needs changes) with date, notes and the presented version, and MUST derive the idea's status from its latest outcome.
- **FR-030**: Help MUST route a described situation to an entry point and stop, MUST answer questions about vibebiz only from the shipped docs, and MUST say when the docs do not cover a question.
- **FR-031**: The plugin MUST ship Vietnamese user docs (quick start, entry points, workflow, reading outputs, FAQ, glossary) with diagrams of the workflow and its thinking, and a fictional example idea that passes the packaging check.
- **FR-032**: Recording ground rules MUST take at most one round of four questions, MUST be skippable, and the plan MUST flag conflicts with recorded rules.

**Repository and distribution**

- **FR-033**: The repository MUST ship the license, commercial-license, contributor-agreement, privacy, security, conduct, contribution, third-party-notice and upstream-mapping documents named in `CLAUDE.md`, an English `README.md` and a Vietnamese `README.vi.md` with matching sections.
- **FR-034**: The repository MUST contain no real people, companies, customers or business figures.
- **FR-035**: Every entry point and skill MUST appear in help's situation map and the entry-points doc, and nothing that does not ship may appear there.

### Key Entities *(include if feature involves data)*

- **Workspace**: one organization's folder; holds the table of contents, ground rules, ideas and optional examples.
- **Ground rules (constitution)**: the organization's priorities, approval budget, vertical and mandatory human approvals.
- **Idea**: one numbered folder with its requirement, coverage record, plan, decisions, assumptions, open questions, glossary, checklists, diagram briefs and exports.
- **Coverage category**: one of A–O, with status, prerequisites, last update and the lens that fills it.
- **Round**: up to four questions asked together; its answers become decisions or open questions.
- **Decision**: a settled answer with date and reason, including dismissed risks.
- **Assumption**: a stated premise with whether it has been tested.
- **Open question**: an unsettled point with its owner and what unblocks it, marked blocking or non-blocking.
- **Board view / Tech view**: the two outputs rendered from one idea folder.
- **Requirement snapshot**: the Spec Kit-compatible copy of the requirement taken at packaging time.
- **Export version**: one packaged set of outputs with its date; earlier versions live in the dated history folder.
- **Board outcome**: approved, rejected or needs changes, with date, notes and the export version it refers to.
- **Diagram brief**: what a diagram must say, its type, source fields and placement.
- **Vertical pack**: retail-vertical examples and questions (fashion in the first release) plus a retail AI and automation pattern catalog.
- **Example idea**: a fictional idea taken through the full process.
- **Framework card**: one management framework described for use by a lens, with the fields in FR-036.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: In a pilot with one or two internal sales directors and two real ideas each, every idea reaches a packaged board view and tech view within four sessions.
- **SC-002**: When the tech team runs Spec Kit's clarification on an exported requirement snapshot, it raises three or fewer questions per idea.
- **SC-003**: The board reaches a decision on each pilot idea from the board view without an extra meeting to re-ask basics.
- **SC-004**: Each pilot user starts a second idea without being prompted.
- **SC-005**: In simulated sessions covering three fashion ideas and two ideas from other retail verticals, the outputs preserve at least 85% of the key facts held by the simulated user.
- **SC-006**: On a set of deliberately weak ideas, the challenge flags at least 90% with concrete risks, while flagging no more than 20% of a control set of sound ideas.
- **SC-007**: The packaging check catches 100% of seeded omissions, cross-view number mismatches and unsourced charts.
- **SC-008**: 100% of question rounds in evaluation follow the round rules and respect category prerequisites.
- **SC-009**: At least 95% of vague quality terms in evaluation answers are turned into measurable values or recorded as open.
- **SC-010**: Help routes at least 90% of situation questions correctly and invents no feature in any evaluation case.
- **SC-011**: In evaluation, at least 90% of framework selections fill the coverage gap that was open, and no lens applies more than two frameworks to one idea.

## Assumptions

- Users run Claude Cowork on the desktop with a folder open; claude.ai chat without a folder is out of scope beyond detecting it.
- Cowork's question tool behaves as documented for Claude Code (up to four questions, two to four options, Skip and free text); this is verified at the first Cowork smoke test.
- Cowork's Google Docs and Slides connectors write directly into files (stated by Fio); whether they can insert an image privately is verified at the first smoke test.
- The companion diagram plugin, when installed, renders SVG without scripts; PNG export is not available in Cowork's sandbox and is not relied on.
- The first release is for internal use under a free written commercial license; pricing and sales terms are out of scope.
- The organization's data never leaves the user's workspace and their own Google Drive; no evaluation service is called at runtime.
- One workspace serves one organization; multi-organization use is out of scope.
- Integrations with point-of-sale, ERP or marketplace systems are out of scope; facts come from the user and their own documents.
- Only the fashion vertical pack ships in the first release; electronics and home appliances follow in later releases. The core workflow works for any retail vertical without a pack.

## Appendix A - Coverage Taxonomy

Spec Kit 1.4.0's `clarify` categories (scope, data, UX flow, non-functional, integration, edge cases, constraints, terminology, completion signals) extended with business categories. A category is asked only after its prerequisites are settled. Each round is the frontier of the dependency tree, ordered by impact times uncertainty.

| Code | Category | Prerequisites | Written to | Filled by |
|---|---|---|---|---|
| A | Problem and why: who suffers, the situation, frequency, current cost, root cause, why now | none | Problem & Why | problem-framing |
| B | Users and stakeholders: who uses it, who is affected, who approves, who may resist | A | Problem & Why, User Stories | problem-framing |
| C | Outcome and measurement: baseline, target, time frame, guardrail, kill criteria | A | Outcome, Success Criteria | outcome |
| D | Alternatives: do nothing, fix the process, buy, build | A, C | Alternatives | challenge |
| E | Scope and behavior: journeys P1..Pn, out of scope | C, D | User Stories, Functional Requirements | solution-sketch |
| F | AI fit: rule, automation or AI; data available; cost of an AI error; human approval points | E | AI-fit | solution-sketch |
| G | Data and entities: sources, quality, ownership | E | Key Entities | clarify (module) |
| H | Integrations: point of sale, ERP, marketplaces, chat apps, logistics | E, G | Requirements, Assumptions | clarify (module) |
| I | Non-functional needs in plain words: number of users, peak hours, store connectivity, devices | E | Requirements | solution-sketch |
| J | Edge cases and failures | E | Edge Cases | solution-sketch |
| K | Risk and compliance: personal-data law, promotion registration, labor rules | E, G | Cost & Risk | challenge |
| L | Organizational change: training, changed staff KPIs, who loses authority or work | B, E | Cost & Risk, Plan | solution-sketch |
| M | Cost, resources and return: S/M/L size, three scenarios | C, D, E | Cost & Risk, Plan | challenge, plan (module) |
| N | Terminology | none | glossary | clarify (module) |
| O | Completion signals: testable acceptance criteria | C, E | Acceptance Scenarios | outcome |

Readiness to package: A, C, D and E Clear; F Clear when AI is involved; M at least an S/M/L size; every other category Clear or Deferred with a reason.

## Appendix B - Interview Protocol and Session Flow

**Question rules** (adapted from Spec Kit `clarify` and mattpocock's `grilling`):

- Facts are found by vibebiz in the workspace and the user's documents; only decisions go to the user.
- A round is the current frontier: questions whose prerequisites are settled. At most four questions per round, two to four mutually exclusive options, the recommended option first, no "None" or "Other" (the tool shows Skip and free text), each question understandable on its own, `multiSelect` when options are not exclusive, previews for draft outcomes, stories or flows.
- Open-ended questions ("tell me about the last time this happened") use plain text.
- After every round: answers go to the requirement's Clarifications section with the date, decisions to the decisions record, and the coverage record is updated.
- Question budget: three rounds per session by default, then an offer to continue, pause or export a draft.
- Skip leaves a category unchanged; with nobody to answer, proceed on stated, recorded assumptions.

**Session flow**:

1. First use of `/vibebiz:new`: scaffold the workspace; offer ground rules in one round (year priorities, approval ceiling, vertical, mandatory human approvals) or defer them; offer the fictional example.
2. Intake: one open question about the situation behind the idea; create `specs/NNN-<slug>/`, a draft requirement with gaps marked, and the first coverage record; show a short table of what is clear and missing.
3. Router loop: compute the frontier, choose the lens (and framework, Appendix F), ask one round, write back, update coverage, rebuild the table of contents; at the budget, offer continue, pause or draft.
4. `/vibebiz:continue`: read the coverage record, summarize in three lines (settled, where it stopped, next question), resume the loop. Also records tech review of estimates and board outcomes.
5. At readiness: business plan, Definition of Ready checklists for the board and the tech team, consistency analysis; any gap returns to the loop.
6. `/vibebiz:package`: one round to choose formats, diagram briefs, render, build, package check, links recorded; earlier exports move to history.
7. `/vibebiz:status`: every idea with coverage, status and next step.

## Appendix C - Thinking Lenses

- **problem-framing** (A, B): ask about the most recent real occurrence, never hypotheticals; 5 Whys to separate symptom from cause; jobs to be done for customers and staff; current cost in hours times people times wage, lost orders or lost customers; output is a one-sentence problem statement the user recognizes.
- **outcome** (C, O): turn outputs into outcomes ("have a chatbot" becomes "cut messages waiting over 15 minutes by 30%"); a driver tree with leading and lagging indicators; a measurement plan when no baseline exists; kill criteria.
- **challenge** (D, K, part of M): pre-mortem ("six months from now this failed; what is the most likely reason?"); assumption map across desirability, viability, feasibility, usability and ethics, marking the riskiest untested assumption; defend doing nothing and fixing the process before build; cost of inaction. Never praise; at least one failure reason per round; dismissed risks recorded.
- **solution-sketch** (E, F, I, J, L): current and future journey (the first diagram brief); three alternative approaches before choosing; AI fit decision tree (is a rule enough, is automation enough, is AI required, who carries the cost of an AI error); a first journey that stands alone; edge cases; people whose work changes.
- **clarify (module)** fills G, H, N and any remaining Partial category.

## Appendix D - Outputs

**Rules**: one source (the idea folder); no new facts at packaging; every slide or section traces to a field; empty fields show "not yet clarified"; numbers match across views with source, period and measured or assumed label; estimates labelled "not tech-reviewed" until reviewed.

**Board view** (Artifact by default, or Google Slides), answer-first (pyramid principle, SCQA), one message per slide, the title states the takeaway:

| # | Slide | Source |
|---|---|---|
| 1 | Decision requested: what, how much, by when | Plan, Cost |
| 2 | The problem and what it costs today, in numbers | Problem & Why |
| 3 | Outcome: driver tree, baseline to target, guardrails | Outcome, Success Criteria |
| 4 | Alternatives considered: do nothing, fix the process, buy, build | Alternatives |
| 5 | Proposed solution: journey before and after | Solution sketch, User Story P1 |
| 6 | First-release scope and what comes later | Scope |
| 7 | Cost, resources and return in low, base and high scenarios | Cost & Risk |
| 8 | Risks, pre-mortem, kill criteria | Challenge |
| 9 | Pilot roadmap and decision points | Plan |
| Appendix | Assumptions, open questions | Assumptions, Open questions |

**Tech view** (Artifact or Google Docs): business context summary; Spec Kit sections in full (User Stories P1..Pn with Given/When/Then, Functional Requirements, Key Entities, Success Criteria, Assumptions); AI fit; non-functional needs in plain words; glossary; open questions marked blocking or non-blocking; the requirement snapshot alongside.

**Aesthetics**: the diagram-design brand profile is the single brand source; charts follow data-visualization rules (the right chart for the question, source and period on every chart, no 3D, no pie with more than five parts); word limits per slide; Vietnamese edited for natural wording; the plugin carries these guidelines in its own references.

**Package check**: every required field filled or labelled; numbers consistent across views; one message per slide with the takeaway as title; every chart sourced; "not tech-reviewed" labels correct; table of contents matches the folder.

## Appendix E - Diagrams

| Content | Diagram type |
|---|---|
| Driver tree (outcome and drivers) | tree |
| Journey before and after | swimlane or flowchart |
| Alternatives compared | quadrant or radar |
| Risks (impact x likelihood) | quadrant |
| AI fit check | decision flowchart |
| Pilot and rollout | timeline or Gantt |
| Return in three scenarios | bar |
| Stakeholders and people affected | org chart or nested |
| Baseline to target | line or bar |

Each diagram brief states its message, type, source fields and placement. Artifacts embed SVG; Slides and Docs insert an image only when the connector accepts it without a public URL, otherwise a table plus a link to the Artifact diagram.

## Appendix F - Framework Library

Frameworks serve the coverage map: one is applied only when it fills an open category, at most two per lens per idea, asked in plain words, named in the outputs. Each card carries the fields in FR-036 and is written in vibebiz's own words.

**Full catalog by lens** (later releases unless marked core):

| Lens or skill | Frameworks | Used for |
|---|---|---|
| problem-framing | 5 Whys (core), Fishbone / Ishikawa (core), Jobs to be done (core), issue tree (MECE), Porter value chain | Root cause; where the idea sits in the value chain |
| outcome | Driver / KPI tree (core), Balanced Scorecard (core), North Star metric, OKR, SMART, leading vs lagging | Measurable outcomes; which BSC perspective the idea moves (financial, customer, internal process, learning and growth) |
| challenge | SWOT (core), pre-mortem (core), assumption map (core), test-and-control pilot (core), Porter Five Forces, PESTEL, cost of inaction, Six Thinking Hats, Theory of Constraints | Context, weaknesses, whether the bottleneck is really where the idea aims, how to prove it cheaply |
| solution-sketch | Customer journey map and service blueprint (core, one card), Value Proposition Canvas, Kano, Lean / DMAIC | Journeys across store, online and back office; must-have versus delighters; the fix-the-process alternative |
| plan (module) | 4P / 7P marketing mix (core), build-buy-partner with ROI and payback (core), MoSCoW (core), ADKAR (core), STP, Ansoff, BCG matrix, RICE / ICE, value-effort matrix, TCO, NPV, three scenarios, stage-gate, RACI, Kotter, McKinsey 7S | Market fit, the investment case, scope cut, rollout and staff adoption |
| router (module) | Cynefin (core depth rule) | Interview depth: clear, complicated, complex, chaotic |
| board view | Pyramid principle / SCQA | Built into the export guidelines |

**The fifteen core cards for fashion apparel retail**, and why each earns its place:

| # | Card | Lens | Why it matters for a fashion sales director |
|---|---|---|---|
| 1 | 5 Whys | problem-framing | Separates "sales are down" from the cause (missing sizes, late deliveries, wrong mix) |
| 2 | Fishbone | problem-framing | Operational problems with many causes: stockouts, returns, slow fitting-room turnover |
| 3 | Jobs to be done | problem-framing | What the shopper and the store staff are really trying to get done |
| 4 | Driver tree | outcome | Store revenue = footfall x conversion x units per transaction x average selling price; online = traffic x conversion x average order value |
| 5 | Balanced Scorecard | outcome | Ties the idea to the company's strategy perspectives and the board's language |
| 6 | SWOT | challenge | The framing boards expect; forces the weaknesses and threats onto the page |
| 7 | Pre-mortem | challenge | Surfaces how a rollout fails in stores before money is spent |
| 8 | Assumption map | challenge | Finds the riskiest untested belief, such as "customers will use size recommendations" |
| 9 | Test-and-control pilot | challenge | Fashion ideas are proven in pilot stores against control stores, with a minimum duration and a season check |
| 10 | Customer journey map and service blueprint | solution-sketch | Omnichannel journeys plus what staff and back office must do to support them |
| 11 | 4P / 7P marketing mix | plan (module) | Product, price, place, promotion, plus people, process and physical evidence for a store-based service |
| 12 | Build-buy-partner with ROI and payback | plan (module) | Many retail tools exist as products; the investment case the board decides on |
| 13 | MoSCoW | plan (module) | Plain-language scope cut for the first release |
| 14 | ADKAR | plan (module) | Store staff adoption is the most common failure of retail rollouts |
| 15 | Cynefin | router (module) | Sets the interview depth and pushes complex ideas toward small pilots |

OKR has no card in the first release: when the organization uses OKRs, they are recorded in the ground rules and the outcome lens maps the idea to them.

**Ground rules link**: the organization's constitution may hold its BSC strategy map and yearly OKRs, so challenge and planning check which objective an idea serves, not only the budget ceiling.

## Appendix G - Fashion Pack and Retail AI Patterns

**Fashion pack** (`packs/retail-fashion`):

- Drivers: newness and drop cadence, sell-through, size curve, markdown depth and timing, seasonality (Lunar New Year, back to school, mid-season and year-end sales), returns driven by size and fit, omnichannel fulfilment.
- Metrics: sell-through rate, GMROI, open-to-buy, markdown rate, size-curve fit, conversion, units per transaction, average selling price, footfall, RFM segments, customer lifetime value, return rate.
- Diagnostic traps: missing sizes read as weak demand; promotion uplift confused with seasonality or weather; channel shift read as growth.
- Promotion patterns: clearance at season end, markdown erosion of margin, bundles.

**Retail AI and automation pattern catalog** (`packs/ai-patterns-retail`), each with the data it needs, rough cost, risks and prior art: customer-service chatbot, size and fit recommendation, demand forecasting and store allocation, replenishment, markdown optimization, customer win-back reminders, review summarization, automated daily and weekly reporting, cash-on-delivery reconciliation.

## Appendix H - Workspace, Docs, Help and Example

**Workspace** (fixed English names; slug from the idea title without diacritics):

```
index.html
constitution.md
specs/NNN-<slug>/
  spec.md coverage.md plan.md decisions.md assumptions.md open-questions.md glossary.md
  checklists/board.md  checklists/tech.md  diagrams/
  exports/  board-deck.html  tech-prd.html  spec.md  data.json  links.md
    history/YYYY-MM-DD/
examples/000-<slug>/
```

`/vibebiz:new` by folder state: empty folder, scaffold then intake; partial workspace, restore missing pieces and list them; complete workspace, intake; folder with unrelated files, ask whether to use it or a `vibebiz/` subfolder (recommended).

**Docs** (Vietnamese content, English names): `quick-start.md`, `commands.md`, `workflow.md`, `reading-outputs.md`, `faq.md`, `glossary.md`, with diagrams in `docs/diagrams/NN-<name>.brief.md` plus `.svg` and `.png`:

| # | Diagram | Type | In |
|---|---|---|---|
| 1 | The big picture: vague idea, vibebiz, two outputs, board approval and tech handoff | high-level | quick-start |
| 2 | One idea's journey: new, continue rounds, package, tech review | timeline | commands, workflow |
| 3 | The router loop: coverage, frontier, lens, round, write back | loop | workflow |
| 4 | The A–O dependency tree | tree | workflow |
| 5 | Lenses and the categories they fill | nested or matrix | workflow |
| 6 | Four alternatives: do nothing, fix the process, buy, build | quadrant | workflow, faq |
| 7 | AI fit: rule, automation or AI | decision flowchart | glossary, workflow |
| 8 | Workspace map with exports and index highlighted | tree | reading-outputs |
| 9 | One source, two views, three formats | data flow | reading-outputs |
| 10 | Anatomy of a question round | annotated mockup | quick-start |

Each brief names what it illustrates and the plugin version it was rendered at; a brief whose subject changed is redrawn before release.

**Help**: routes a described situation to an entry point and stops; answers about vibebiz only from the docs, citing the section; says when the docs do not cover it; reads a skill's current instructions before describing it; may be invoked by the model for "how do I use this" questions, while describing an idea goes to the router.

**Example**: a fictional fashion chain's idea (for example win-back reminders through a chat app) taken through the whole process with complete exports; lives in `examples/`, is not counted by status, is shown under "Examples" in the table of contents, and is rebuilt whenever a template changes.

## Appendix I - Evaluation and Pilot

| # | Suite | Checks | Threshold |
|---|---|---|---|
| 1 | Routing | Frontier and lens chosen from a fixed coverage record; prerequisites respected | 100% |
| 2 | Question protocol | Round rules, write-back after each round | 100%, checked in code |
| 3 | Anti-sycophancy | Weak ideas flagged with concrete risks; control set of sound ideas | at least 90% caught, at most 20% false alarms |
| 4 | Vague terms | Unquantified terms turned into values or open questions | at least 95% |
| 5 | Spec Kit compatibility | Snapshot has the 1.4.0 mandatory sections; `speckit-plan` runs on it | no manual edits |
| 6 | Package check | Seeded omissions, mismatched numbers, unsourced charts caught; traceability | 100% |
| 7 | Table of contents | Matches the folder after every action | 100% |
| 8 | Simulated sessions | Hidden-truth persona (impatient, non-technical) across three fashion ideas and two other retail ideas; rounds to readiness, budget hits, facts preserved | at least 85% of key facts, four sessions or fewer |
| 9 | Help | Routing, no invented features, help versus router; docs and README pair cover exactly what ships | at least 90% routing, zero inventions |
| 10 | Frameworks | Selection fills the open gap; at most two per lens | at least 90% |

Structure checks run in code; semantic judgments (claim support, meaning preservation) may use Jev in development only. Headless runs cannot answer the question tool, so eval prompts carry the answers; the simulated-persona suite uses an Agent SDK harness that answers through `canUseTool`. A manual Cowork smoke test runs before each release.

**Pilot**: one or two internal sales directors, two real ideas each; measure time to package, sessions and abandonment, questions the tech team still asks when clarifying the snapshot (target three or fewer), whether the board decides without an extra meeting, and whether the user starts a second idea unprompted.
