# Feature Specification: A wider framework library that vibebiz chooses from on its own

**Feature Branch**: `004-framework-library`

**Created**: 2026-11-18

**Status**: Draft

**Input**: User description: "Add SIPOC (SIRPOC) to vibebiz. Don't ask the user which framework to write with, because they don't know frameworks. vibebiz has to be smart and informed enough to guide users from the context, ask questions to get more information when it needs to, and from that choose different frameworks to help them write the documents. A deck or document can use several frameworks at the same time." (Fio, 18/11/2026)

## Settled Decisions

- **vibebiz chooses, the user never does** (Fio, 18/11/2026). vibebiz picks frameworks from what is on file and from the answers to its own questions. It never asks the user to choose a framework, never lists frameworks as options, and never makes the user learn one. It asks plain questions when it needs more information, and those questions come from the cards it chose. This keeps the current design (router rule 4, and the lenses' "never picks one itself"). The only change is that this becomes a rule the evals check.
- **Several frameworks per package** (Fio, 18/11/2026). One deck or document may show the results of several frameworks at once, each on the slide or section its category feeds. This already holds today (`core/package.md` step 4). This spec widens the choice behind it.
- **SIPOC with a Requirements column** (Fio asked for "SIPOC (SIRPOC)"). One card covers both. Its rows are Suppliers, Inputs, Process, Outputs and Customers. A Requirements column says what each customer needs from each output, which is what users of the SIRPOC variant add. The card names both forms in its `origin`.
- **A user who names a framework** keeps the current behavior (spec 001 FR-038): vibebiz applies it when it fills an open gap and otherwise says why. This is the only path where a framework name comes from the user.
- **The whole catalog ships** (Fio, 18/11/2026, Q1). Besides SIPOC, this release adds every framework that spec 001 Appendix F lists for later releases except three scenarios, 25 cards:
  - problem-framing: issue tree (MECE), Porter value chain;
  - outcome: North Star metric, OKR, SMART, leading vs lagging indicators;
  - challenge: Porter Five Forces, PESTEL, cost of inaction, Six Thinking Hats, Theory of Constraints;
  - solution-sketch: Value Proposition Canvas, Kano, Lean / DMAIC;
  - plan: STP, Ansoff, BCG matrix, RICE / ICE, value-effort matrix, TCO, NPV, stage-gate, RACI, Kotter, McKinsey 7S.
  The library grows from 15 to 41 cards: SIPOC plus these 25. Two catalog entries stay built into modules instead of becoming cards (Fio, 18/11/2026). Pyramid principle / SCQA stays a rule of the board view's export guidelines. Three scenarios (low, base and high) stays the way the plan module writes category M. The outputs name both when they shape a slide or section.
- **Gap-driven limit** (Fio, 18/11/2026, Q2). "At most two cards per lens per idea" is removed. A new card is applied only when it fills an open category that no applied card has filled, one new card per category per round, inside the interview's round budget, which does not change.

- **Cards are linked into a routing map** (Fio, 19/11/2026). vibebiz is long-lifecycle brainstorming. It helps a user clarify the strategic picture in their head over many sessions and packages it as a deck and documents. A larger library alone is not enough: the cards are linked so the router knows what each card's result enriches next. Each card declares four kinds of link in its own frontmatter:
  - `needs`: a hard prerequisite;
  - `feeds`: a named result passed to another card, which also sets the preferred order;
  - `instead_of`: cards that fill the same gap, of which one is chosen;
  - `revisit_when`: when the card is redone over the idea's life, together with the cards it feeds.
  Gaps still decide what is asked; the map only sets preference, context and revisits. The map is part of this spec, done before the 26 new cards, and the 15 existing cards get links too (Fio, 19/11/2026).
- **No constitution amendment.** The constitution sets no limit on frameworks. The `CLAUDE.md` lines "the fifteen framework cards" and "at most two per lens per idea" change in the same pull request as the implementation, with Fio's yes on this spec.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - A process idea is framed with SIPOC without the user hearing the word (Priority: P1)

A store operations director wants to automate stock replenishment between the warehouse and stores. vibebiz sees that the idea changes an existing process with clear hand-offs. It asks plain questions about who sends what, which steps happen, what comes out and who receives it, and what each receiver needs it to be. The requirements document then shows a SIPOC table of the process before and after the change, named "SIPOC". At no point is the director asked to choose or explain a framework.

**Why this priority**: this is the gap Fio found. Process-automation ideas are common in retail operations and today have no card for the process boundary and its hand-offs.

**Independent Test**: run the SIPOC eval case: a fictional replenishment idea with the answers in the prompt. Graders check that the questions follow the SIPOC card, that no question or option names a framework or asks the user to pick one, and that the output carries the SIPOC result on the slide or section its category feeds.

**Acceptance Scenarios**:

1. **Given** an idea that changes an existing internal process with hand-offs between teams or systems, and its scope category is open, **When** the router plans the next round, **Then** it hands the SIPOC card to the lens that fills that category, and the questions ask about suppliers, inputs, steps, outputs, receivers and their needs in everyday words.
2. **Given** the SIPOC questions were answered, **When** the idea is packaged, **Then** the document names SIPOC once in the section it shaped and shows its table, and the board deck shows the result on the slide that category feeds.
3. **Given** an idea about a customer-facing journey with no internal hand-off, **When** the router chooses cards, **Then** it does not choose SIPOC. The journey map card fits instead.

---

### User Story 2 - vibebiz combines several frameworks for one idea (Priority: P1)

A sales director describes a vague loyalty idea. Across the rounds vibebiz uses, for example, 5 Whys for the cause, a driver tree for the target, a pre-mortem for the risks and MoSCoW for the first release. Each is chosen because a category was still open and the card fits the situation. The package names every framework that shaped it, each on its own slide or section.

**Why this priority**: Fio's main point. vibebiz must choose from context and combine frameworks. The two-per-lens limit and a small library should not block it.

**Independent Test**: run a routing eval on a fixed coverage record with several open categories across lenses. Check which cards the router hands over across rounds against the expected set, under the gap-driven rule. Then run the package check to see that every applied card appears where its category feeds.

**Acceptance Scenarios**:

1. **Given** several open categories in different lenses, **When** the interview runs to readiness, **Then** each card applied filled a category that was open when it was chosen, and no card was applied to a category already clear.
2. **Given** a lens already applied cards, **When** a category of that lens is still open and another card fills it better than the ones applied, **Then** the router applies the better card in the next round, and the interview still reaches readiness within its round budget.
3. **Given** a package built from an idea with four applied cards, **When** the package check runs, **Then** all four are named in the outputs, each on the slide or section its category feeds.

---

### User Story 3 - Each framework builds on the last (Priority: P1)

A sales director comes back to an idea over several weeks. The first week, vibebiz found the cause of falling repeat visits through 5 Whys. When the target comes up, the driver tree starts from that cause and does not ask about it again. When the costs come up later, NPV waits until the cost of ownership or the build-or-buy comparison is on file. When the board asks for a lower budget, vibebiz redoes the cost card and then the return card that reads from it, and asks only about what changed. The director sees one conversation that deepens, not a series of unrelated questionnaires.

**Why this priority**: this is what makes vibebiz a long-lifecycle brainstorming partner rather than a form. Without links, more cards only means a bigger pile to pick from (Fio, 19/11/2026).

**Independent Test**:
- Run the map eval cases on fixed coverage records:
  - one card fed by an applied card is preferred over an equal fit;
  - a fed card's questions do not re-ask the passed result;
  - a card whose `needs` are unmet is not handed over;
  - only one card from an `instead_of` group is applied;
  - a changed fact triggers the revisit of the card and the applied cards it feeds.
- The link check in code passes on all 41 cards.

**Acceptance Scenarios**:

1. **Given** two cards fit an open category equally, and an applied card `feeds` one of them, **When** the router chooses, **Then** it picks the fed card and says so in `framework_reasons`.
2. **Given** a card is handed over and an applied card feeds it a named result, **When** the lens writes the round's questions, **Then** it reads that result from the files and asks only about what is still missing.
3. **Given** a card whose `needs` lists cards none of which is applied, and whose categories are not yet clear by other means, **When** the router plans the round, **Then** it does not hand that card over.
4. **Given** one card of an `instead_of` group is applied for a category, **When** the category is still open, **Then** the router does not hand over another card of that group for it.
5. **Given** a fact in a category listed in an applied card's `revisit_when` is superseded, or the board asks for changes, **When** the user continues the idea, **Then** the router redoes that card in the next round, asking only about the change. It then redoes the applied cards it feeds, in order, inside the round budget.

---

### User Story 4 - The library grows by cards, not by changes to the router (Priority: P2)

A maintainer adds a new card in vibebiz's own words, with its lens, the categories it fills and when to use it. The router can choose it on the next idea with no change to the router or the lenses. The help skill and the docs list what ships, and nothing more.

**Why this priority**: the catalog in spec 001 Appendix F lists about thirty more frameworks for later releases. Each should cost a card and its eval, not a redesign.

**Independent Test**: add the 25 catalog cards, each with its links. Run the framework eval suite and the help eval. Every new card is chosen in at least one case where it fits and passed over in a case where it does not. The docs name exactly the cards that ship.

**Acceptance Scenarios**:

1. **Given** a new card with valid frontmatter, **When** the build runs, **Then** it is copied to every skill that reads cards, and the build test counts the new total.
2. **Given** two cards that fill the same open category, **When** the router chooses one, **Then** it picks the one whose "When to use" matches the idea and the depth better, and records why in one line in `coverage.md`.

---

### Edge Cases

- The user asks for a framework vibebiz does not have, such as Six Sigma by name. vibebiz says this version does not include it and applies the card that fits the open gap, as spec 001 FR-038 says. It never applies a framework from memory without a card.
- An idea where no card fits an open category. The lens asks its own questions. Not every gap needs a framework.
- A `clear` idea at the shortest depth. No card is applied unless the user asks for one by name, as today.
- A card that fills a category another module owns, for example SIPOC touching data sources (G) and integrations (H), which the clarify module fills. The plan settles which module asks the card's questions.
- A user who answers "I don't know" to a card's question. The ask protocol's rule 5 applies. The card's result shows the gap as not yet clarified and invents nothing.
- The organization already records its OKRs in the ground rules. The outcome lens keeps mapping the idea to them, as today. The OKR card is used only to draft the idea's own objective and key results when the ground rules hold none.
- Two new cards that overlap, such as RICE / ICE and the value-effort matrix, or TCO, NPV and the plan module's three scenarios. The router applies one per open category and never stacks overlapping cards on the same gap.
- A `feeds` chain longer than the round budget allows. The router follows the chain only while categories stay open and rounds remain; the rest waits for the next session, which `continue` picks up from the map.
- A link that points to a card that does not ship, or `needs` that loop. The link check in code fails the build; nothing reaches a user.
- A revisit whose change does not alter the card's result. The card is marked done again without new questions, and the chain stops there.
- Many frameworks on one slide. The board deck stays readable: each slide shows at most the results its layout fixes, and the rest go to the appendix.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: vibebiz MUST NOT ask the user to choose, rank or name a framework, and MUST NOT offer framework names as question options, unless the user named a framework first.
- **FR-002**: A card's questions MUST be asked in everyday words without the framework's name. The name appears only in the outputs, once in the section the card shaped.
- **FR-003**: vibebiz MUST ship a SIPOC card with the fields of spec 001 FR-036. It is written in vibebiz's own words, with a fictional retail example and its origin, covering both the five-column form and the Requirements column.
- **FR-004**: The router MUST choose SIPOC only for an idea that changes an existing process with hand-offs between people, teams or systems, and only while a category the card fills is open.
- **FR-005**: The router MUST replace spec 001 FR-037's "at most two per lens per idea" with the gap-driven rule (Settled Decisions). It keeps "only to fill an open gap" and "one new card per category per round".
- **FR-006**: vibebiz MUST ship the 25 catalog cards listed in Settled Decisions, each with the fields of spec 001 FR-036. Third-party frameworks are described in vibebiz's own words and credited.
- **FR-007**: When several cards fit one open category, the router MUST pick by the card's "When to use" against the idea and its Cynefin depth. It MUST record the chosen card and a one-line reason in `coverage.md`.
- **FR-008**: The package MUST name every applied card and place its result on the slide or section its category feeds. Results that do not fit a slide's fixed layout go to the appendix.
- **FR-009**: Adding a card MUST need no change to the router or the lens modules: lens, category codes, `When to use` and `When not to use` in the card are enough for it to be chosen.
- **FR-010**: `help`'s situation map, `docs/` and both READMEs MUST describe the framework library as it ships. They say vibebiz chooses the frameworks, and they never list a framework that does not ship.
- **FR-011**: The board view MUST follow the pyramid principle / SCQA through the export guidelines, as spec 001 Appendix F says. If the guidelines do not yet carry it, this release adds it there, not as a card.

- **FR-012**: Every card MUST declare its links in its frontmatter: `needs` (card ids, satisfied when one of them is applied or every category it fills is clear), `feeds` (each a target card id and the named result passed), `instead_of` (card ids, declared on both sides) and `revisit_when` (category codes and the events `board-changes` and `tech-review`). Empty lists are allowed.
- **FR-013**: The router MUST NOT hand over a card whose `needs` are unmet, and MUST NOT apply a second card from an `instead_of` group to the same category.
- **FR-014**: When several cards fit, the router MUST prefer one that an applied card `feeds`, before comparing "When to use".
- **FR-015**: When a fed card is handed over, the lens MUST read the passed results from the idea's files and MUST NOT ask again what they already answer (spec 001 "facts before questions").
- **FR-016**: When a fact in a category listed in an applied card's `revisit_when` changes (a `supersede` in `decisions.md`, or a board or tech review recorded by `continue`), the router MUST redo that card and then the applied cards it feeds, in feed order, inside the round budget, asking only about what changed.
- **FR-017**: A check in code MUST verify the map:
  - every link names a shipped card;
  - `instead_of` is declared on both sides;
  - `needs` has no cycle;
  - `revisit_when` uses only codes A to O and the two events.
  The build MUST generate a readable table of the map into `docs/`, for `help`.

### Key Entities

- **Framework card**: unchanged from spec 001 (FR-036). The router may now choose among more cards per lens.
- **Card link**: one of `needs`, `feeds`, `instead_of`, `revisit_when` in a card's frontmatter. Together the links of all cards form the routing map.
- **Applied framework record**: the card id in a category's `frameworks` list in `coverage.md`, now with a one-line reason for the choice.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: In the framework eval suite, no question or option asks the user to choose or learn a framework: 100% of cases.
- **SC-002**: The card the router hands over fills a category that is open and fits the idea in at least 90% of cases (spec 001 Appendix I suite 10, same threshold).
- **SC-003**: Every new card, SIPOC included, is chosen in at least one eval case where it fits and passed over in at least one where it does not.
- **SC-004**: In the package check, 100% of applied cards appear in the outputs where their category feeds.
- **SC-005**: The simulated-session suite does not get worse: rounds to readiness stay at four sessions or fewer, and key facts preserved stay at 85% or more.
- **SC-006**: In the map eval cases, the router follows `needs`, `instead_of` and the `feeds` preference in 100% of cases, and a fed card re-asks a passed result in none of them.
- **SC-007**: In a revisit case, only the changed card and the applied cards it feeds are redone, and every question asked is about the change.

## Assumptions

- The coverage categories A to O do not change. New cards fill existing categories.
- Each card stays a single file in `packs/frameworks/`, read by the router through the build's `references/`.
- The interview's round budget and the four-questions-per-round limit do not change, so more cards can mean more rounds only within the existing budget.
- New cards are described from public knowledge in vibebiz's own words. No framework text, layout or artwork is copied, as `CLAUDE.md` requires.
- Eval cost grows with the library: SC-003 needs at least two cases per new card, about 52 cases. Cases may share fixtures, and the suite runs per changed card, as the plugin-packaging trigger rule does.
- The release is 0.1.x, a compatible change: the workspace layout and file names stay the same.
