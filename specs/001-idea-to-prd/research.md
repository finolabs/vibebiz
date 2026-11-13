# Research: Idea to PRD

Phase 0 for `plan.md`. Sources are the design session (2026-11-12), the installed Spec Kit 1.4.0, Anthropic's `create-cowork-plugin` skill, and the documentation and web sources recorded in `CLAUDE.md` "Platform findings". Items marked **verify** are checked at the first Cowork smoke test.

## R1. Plugin shape: six skills plus modules

- **Decision**: The plugin exposes exactly six skills, the entry points `idea`, `continue`, `status`, `package`, `constitution` and `help`. Router, interview engine, lenses, plan, checklists, analysis and packaging are **modules**: reference files loaded on demand by the entry skills, not skills of their own (Fio, 2026-11-12).
- **Rationale**: Every skill's description sits in context and can trigger on its own; Cowork documents no way to hide a skill. Eighteen skills would compete for triggers and context; six entry points match what the user actually invokes. Progressive disclosure (skill body under 3,000 words, detail in references) is the pattern Anthropic's Cowork guidance recommends.
- **Alternatives considered**: eighteen skills as first listed in `CLAUDE.md` (rejected: mis-triggering, context cost); entry skills plus four lens skills (rejected: lenses would still trigger on generic "analyze my idea" requests outside the flow).

## R2. Shared modules across skills

- **Decision**: Modules live once in the source tree under `core/`. A development build step copies `core/` into each skill's `references/` in the distributable, and each `SKILL.md` refers only to files inside its own folder.
- **Rationale**: Skills reliably resolve files in their own directory; resolving a path outside the skill folder from inside Cowork is undocumented. Copying at build time keeps one source of truth without relying on it.
- **Alternatives considered**: relative paths such as `../../core/` (rejected: undocumented, **verify** later and drop the copy if it works); duplicating modules by hand (rejected: drift).

## R3. Machine-readable workspace files

- **Decision**: Human-readable Markdown everywhere, with YAML frontmatter for the fields code and the table of contents need. The idea's state lives in `coverage.md` frontmatter; `spec.md` carries no frontmatter, so the snapshot stays a plain Spec Kit file. Decisions, assumptions and open questions are append-only lists with stable ids.
- **Rationale**: Users can read and edit every file; checks and the table of contents parse frontmatter without guessing; append-only ids keep history when a decision is replaced.
- **Alternatives considered**: a separate JSON state file (rejected: users cannot read it, easy to drift from the Markdown); frontmatter in `spec.md` (rejected: risks Spec Kit compatibility).

## R4. Data-driven HTML for the table of contents and exports

- **Decision**: `index.html`, `board-deck.html` and `tech-prd.html` are fixed templates with one embedded JSON data block and a small inline renderer. vibebiz writes only the data; layout never changes between runs. Each idea's export data is also saved as `exports/data.json`, the single source for the board view, the tech view, Slides and Docs.
- **Rationale**: A model rewriting HTML each time drifts in layout and can drop sections; filling data into a fixed template makes completeness, cross-view number consistency and table-of-contents integrity checkable in code (FR-024, FR-025, SC-007). Inline script in a page the user opens is not a script run on their machine, so constitution Principle IV holds.
- **Alternatives considered**: model-written HTML (rejected: drift, uncheckable); Markdown exports only (rejected: board needs a designed page).
- **Note**: `exports/data.json` adds one file to the workspace contract in `CLAUDE.md`.

## R5. Spec Kit compatibility of the snapshot

- **Decision**: The idea template is Spec Kit 1.4.0's `spec-template.md` with business sections (Problem & Why, Outcome, Alternatives, AI-fit, Cost & Risk) inserted after the header block and before "User Scenarios & Testing". Mandatory headings stay in English in every output language. A development check compares headings with the pinned template, and an integration test runs `speckit-plan` on the fictional example's snapshot.
- **Rationale**: FR-023 and SC-002; Spec Kit's commands locate sections by heading.
- **Alternatives considered**: a Spec Kit preset that adds the business sections (deferred: a later option for the tech side, not needed for compatibility).

## R6. Questions in Cowork

- **Decision**: All decisions go through `AskUserQuestion` per the protocol in spec Appendix B; Skip leaves a category unchanged; with no answer available the module records stated assumptions as open.
- **Rationale**: Anthropic's Cowork skills use `AskUserQuestion` and document its Skip button and free-text box; limits of four questions and two to four options are documented for Claude Code (**verify** in Cowork).
- **Alternatives considered**: numbered text questions as in `grilling` (rejected: slower and error-prone for non-technical users).

## R7. Diagrams

- **Decision**: vibebiz writes a diagram brief per diagram (`diagrams/NN-<name>.brief.md`) and asks the companion `diagram-design` skill to render HTML/SVG; Artifacts embed the SVG. PNG export is not relied on in Cowork. Docs diagrams are rendered during development in Claude Code, where PNG export works.
- **Rationale**: diagram-design's PNG path needs Playwright and a Chromium download that Cowork's network allowlist blocks; SVG needs no script.
- **Alternatives considered**: vendoring diagram-design (rejected by Principle IV); drawing diagrams with inline SVG in vibebiz itself (rejected: duplicate design system, lower quality).

## R8. Google Slides and Docs, and Artifacts

- **Decision**: Slides and Docs are written directly through Cowork's Google connectors from `exports/data.json`. Images are inserted only when the connector accepts them without a public URL; otherwise a table plus a link to the Artifact diagram. Artifacts are published private and updated at the same link on re-packaging; vibebiz never shares.
- **Rationale**: Fio confirmed the connectors write directly; the Google APIs need publicly reachable PNG/JPEG/GIF for images, which FR-027 forbids. **Verify**: private image insertion, and updating an Artifact in place from Cowork.
- **Alternatives considered**: building `.pptx`/`.docx` and importing (dropped after Fio's confirmation).

## R9. Interview depth (Cynefin)

- **Decision**: After intake, the router classifies the idea: **clear** (known solution, low cost: shortest path, minimum lenses), **complicated** (analysis needed: full lenses), **complex** (outcome uncertain: push toward a test-and-control pilot and kill criteria), **chaotic** (an active crisis: stabilize first, record the idea, defer packaging). The classification is recorded and revisited when answers change it.
- **Rationale**: FR-040; a depth rule business users recognize.
- **Alternatives considered**: fixed depth for every idea (rejected: wastes the user's patience on simple ideas).

## R10. Language

- **Decision**: The session language is the language of the user's first substantive message about the idea, recorded per idea; questions and outputs use it, Vietnamese when unclear.
- **Rationale**: FR-027a; recording it per idea keeps exports consistent across sessions.

## R11. Evaluation and checks

- **Decision**: Development-only tooling in Python 3 standard library for structural checks (`scripts/checks/`), run by `python3 -m unittest`; `claude plugin eval` suites under `evals/` with answers embedded in prompts; a simulated-persona harness on the Claude Agent SDK for Python (pinned) answering `AskUserQuestion` through `canUseTool`; optional Jev graders for claim support and meaning preservation, skipped when no key is configured.
- **Rationale**: Principle V; headless runs cannot answer the question tool; contributors must be able to run structural checks without paid services.
- **Alternatives considered**: TypeScript harness (rejected: two toolchains for one small repository).

## R12. Packaging and distribution

- **Decision**: `scripts/build_plugin.py` assembles `dist/vibebiz/` (manifest, six skills with copied modules, templates, packs, docs) and zips `dist/vibebiz.plugin`, which Cowork installs by upload. `dist/` is ignored by git. Version starts at 0.1.0 and follows SemVer; marketplace publication is out of scope for this feature.
- **Rationale**: Cowork installs from a marketplace, a Git repository or an uploaded package; the repository is private, so upload is the reliable internal path.
- **Alternatives considered**: installing straight from the private repository (**verify** whether Cowork can reach a private repository).

## R13. Vertical and framework content

- **Decision**: First release content: `packs/retail-fashion`, `packs/ai-patterns-retail`, and fifteen framework cards in `packs/frameworks/` (spec Appendix F), all in vibebiz's own words with fictional examples; each card follows the schema in `contracts/modules.md`.
- **Rationale**: FR-019, FR-036 to FR-042, Principle VI.
