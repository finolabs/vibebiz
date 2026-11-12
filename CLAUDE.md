# vibebiz — project instructions

vibebiz is a Claude Cowork plugin that works as a product owner for non-technical retail leaders. A sales director (online or offline; fashion, electronics, home appliances and similar retail) starts from a vague idea about a system, an AI use or an automation; vibebiz interviews them until the idea is clear, challenged and measurable, and packages it as a PRD for the board and for the internal tech team.

The constitution at `.specify/memory/constitution.md` is the governing law of this repository; this file holds the detailed design and must not contradict it. When the two conflict, raise the conflict and resolve it by amendment instead of picking one.

These rules record the design decisions Fio settled on 12/11/2026. A rule here changes only with Fio's yes; when a spec or plan conflicts with this file, raise the conflict instead of picking one. The full design detail for the MVP (taxonomy, protocol, lenses, outputs, diagrams, framework library, fashion pack, docs, evals) lives in the appendices of `specs/001-idea-to-prd/spec.md`.

## Two roles of Spec Kit

- **Development tool.** This repository is developed with Spec Kit 1.4.0 (`.specify/`, `.claude/skills/speckit-*`). Write specs, plans and tasks with it. These files are development tooling and never ship in the plugin.
- **Upstream for the port.** The plugin ports Spec Kit 1.4.0 *content* to Cowork: the spec, plan, checklist and constitution templates, the `clarify` coverage taxonomy, and the specification writing rules. It does not port the mechanics: bash scripts, git branches, hooks, `feature.json`, extensions. Cowork users have no terminal, so runtime behavior is instructions and file operations only.
- Pin the port to 1.4.0. `UPSTREAM.md` lists every section taken from upstream and every section that is vibebiz's own, so a later upgrade can be diffed. Upgrade only with Fio's yes.
- Keep the mandatory sections of `spec.md` (User Scenarios & Testing, Requirements, Success Criteria, Assumptions) identical to upstream, so the tech team can run `speckit-plan` on an exported `spec.md` without edits. Business sections (Problem & Why, Outcome, Alternatives, AI-fit, Cost & Risk) are added before them, never in place of them.
- Say "compatible with Spec Kit"; never use Spec Kit as vibebiz branding.

## Independence

- vibebiz depends on nothing from `finolabs-vibecode`. vibecode is for development teams. Do not reference, import or reuse its skills (for example `shape`, `fnl-ask`) inside the plugin. The only link to a tech team is the Spec Kit-compatible file format.
- `diagram-design` (cathrynlavery/diagram-design, MIT) is a companion plugin. Never copy it into this repository. vibebiz writes diagram briefs; diagram-design renders them. Its brand profile is the single brand source for diagrams and exports. Without it installed, exports show a table with a "no diagram" note; do not draw a substitute.

## Plugin shape (agreed)

- Plugin name `vibebiz`. Entry points are user-invocable skills, written as `skills/*/SKILL.md` and never as legacy `commands/` (Cowork shows both as skills): `/vibebiz:new`, `/vibebiz:continue`, `/vibebiz:status`, `/vibebiz:package`, `/vibebiz:constitution`, `/vibebiz:help`.
- Installed plugins also load in claude.ai chat, which has no working folder. A skill that needs the workspace checks for it first and, without one, tells the user to open the idea in Cowork instead of running partway.
- Skills: `biz-router`, `biz-constitution`, `biz-specify`, `biz-clarify`, the four lenses `problem-framing`, `outcome`, `challenge`, `solution-sketch`, then `biz-plan`, `biz-checklist`, `biz-analyze`, `biz-package`, `help`.
- The router's backlog is the coverage map: Spec Kit's `clarify` taxonomy extended with business categories A–O, each with its prerequisites (no ROI before Outcome, no model non-functionals before AI-fit). Readiness to package: A, C, D, E Clear; F Clear when AI is involved; M at least S/M/L; the rest Clear or Deferred with a reason.
- Interview protocol (`core/references/ask-protocol.md`, owned by `biz-clarify`, used by every skill that asks): frontier rounds adapted from mattpocock's `grilling` (MIT), asked through Cowork's native question tool. At most 4 questions per round, 2–4 mutually exclusive options, the recommended option first, no manufactured options, each question understandable on its own, open questions in plain text, answers written to the files after every round, a question budget per session (about 3 rounds) followed by an offer to continue, pause or export a draft. Facts are found by the agent; only decisions go to the user.
- The question tool always shows a Skip button and a free-text box, so options never include "None" or "Other". A skipped question stays unanswered (the category keeps its Partial or Missing status); it is never read as accepting the recommendation.
- With nobody to answer (a headless or eval run, or the tool unavailable), proceed on stated assumptions, record each as open in `open-questions.md` and the coverage map, and never invent an answer.
- The `challenge` lens never praises an idea, gives at least one reason the idea could be wrong per round, defends "do nothing" and "fix the process" before build is allowed, and records a dismissed risk in `decisions.md` instead of deleting it.
- `help` routes by situation and answers only from the shipped `docs/`; when the docs do not say, it says so. It reads a skill's current `SKILL.md` before describing it.
- Vertical packs: the first release ships `packs/retail-fashion` and `packs/ai-patterns-retail` only; electronics and home appliances come later. Lenses fall back to general retail questions for other verticals.
- Framework library (`packs/frameworks/`): one card per management framework, applied only to fill an open coverage gap, at most two per lens per idea, asked in plain words and named in the outputs; the user may request one by name. The first release ships the fifteen core cards chosen for fashion apparel retail (spec 001, Appendix F); Cynefin sets the router's depth.

## User workspace contract

`/vibebiz:new` scaffolds this on first run, never overwrites an existing file, and repairs only missing pieces:

```
index.html                  table of contents for every idea, rebuilt after every write
constitution.md
specs/NNN-<slug>/
  spec.md coverage.md plan.md decisions.md assumptions.md open-questions.md glossary.md
  checklists/  diagrams/
  exports/  board-deck.html  tech-prd.html  spec.md (snapshot)  links.md
    history/YYYY-MM-DD/     previous export sets, moved here before each re-package
examples/000-<slug>/        optional fictional example
```

The slug comes from the user's idea title, without diacritics. Every other file and folder name is fixed and in English.

- Outputs and questions use the language the user communicates in (Vietnamese by default); Spec Kit's mandatory headings in the snapshot never change.
- Artifacts are published private; vibebiz never shares any output. Sharing is the user's own action.
- Board outcomes (approved, rejected, needs changes) are recorded in `decisions.md` against the presented export version and drive the idea's status.

## Outputs

- Board view: Claude Artifact or Google Slides. Tech view: Claude Artifact or Google Docs. Both render from the idea folder only. Packaging adds no new facts; a missing field shows as "not yet clarified" and is never silently dropped. Every slide or section traces to a spec field, and numbers match across views with source, period and an assumed/measured label.
- Estimates carry "not tech-reviewed" until `plan.md` records the tech review.
- Diagrams by format: the Artifact is the primary path and embeds the SVG; the board view defaults to an Artifact. Google Slides and Docs accept only PNG, JPEG or GIF fetched from a public URL, so vibebiz never makes an image public to insert it. Cowork's Google Docs and Slides connectors write text, tables and layout directly into the file (Fio, 12/11/2026), so no file conversion is needed. For a diagram in Slides or Docs, insert the image only when the connector accepts it without a public URL; otherwise insert a table plus a link to the diagram in the Artifact. Rasterizing SVG inside the Cowork sandbox is experimental and never assumed: Cowork's network allowlist blocks the browser download that diagram-design's Playwright PNG export needs.
- `package-check` gates every export: completeness, cross-view consistency, one message per slide with the takeaway as the title, a source on every chart, an index that matches the folder.

## Language and naming

- Repository structure, file and folder names, and the instruction prompts in `SKILL.md`, references and templates are in English.
- Text for users (questions, outputs, `docs/` content, `README.vi.md`) is in Vietnamese, written for people who are not technical. Edit Vietnamese prose for natural wording before release.
- `README.md` is in English; `README.vi.md` is in Vietnamese with the same sections and the same license and install tables.

## Licensing and content hygiene

- Source-available, not open source: PolyForm Noncommercial 1.0.0 for the public code plus a commercial license. Never call vibebiz "open source". Businesses, including those given vibebiz for free, need a written commercial license (a free grant states the business, term, scope and update rights).
- Copyright holder is Fioenix for now. Before Finolabs sells a license, Fioenix needs a written assignment or license to Finolabs.
- Contributions require the CLA (`CLA.md`).
- Keep the MIT notices of Spec Kit and `grilling` in `THIRD_PARTY_LICENSES.md`.
- Framework cards and packs describe third-party frameworks (for example Strategyzer's canvases, which are CC BY-SA) in vibebiz's own words and credit their origin; never copy their text, layout or artwork verbatim.
- The license, the commercial terms and the CLA need a lawyer's review before the repository goes public. The repository stays private until Fio says otherwise.
- No internal data in the repository: no real people, companies, customers or figures, and no organization's constitution or brand. Example workspaces, vertical packs and eval fixtures are fictional or built from public knowledge. Organization-specific material lives only in a user's workspace.
- `PRIVACY.md` states that business data stays in the user's workspace and Google Drive and that the plugin sends it nowhere else. TypeSafe/Jev is used only in developer evals, never at runtime.

## Docs, diagrams and the example

- `docs/` (Vietnamese content, English file names): `quick-start.md`, `commands.md`, `workflow.md`, `reading-outputs.md`, `faq.md`, `glossary.md`, with diagrams in `docs/diagrams/NN-<name>.brief.md` plus `.svg` and `.png`, rendered with diagram-design.
- Each diagram brief names the skills, commands or templates it illustrates and the plugin version it was rendered at; a brief whose subject changed since its render is redrawn before release.
- The fictional example in `examples/` must pass `package-check` and the Spec Kit compatibility check; rebuild it whenever a template changes.
- Before cutting a version, review everything that describes the product (README pair, docs, diagrams, `help`'s situation map, the example) against what ships, and check that every command and skill appears in `help`'s map and in `docs/commands.md` and that nothing else does.

## Evals

The suites agreed in the design: routing respects prerequisites; Ask-protocol conformance; anti-sycophancy (a bad-idea set with a good-idea control); vague-term quantification; Spec Kit compatibility (run `speckit-plan` on an exported `spec.md`); package-check catches seeded omissions; index integrity; simulated end-to-end sessions with a hidden-truth persona (fashion first, plus other retail verticals to test the core); `help` routing and no-invention. Structure checks run in code; semantic support and meaning-preservation judgments may use Jev. A Cowork smoke test runs by hand before each release.

## Platform findings and open checks

Findings from documentation and web sources on 12/11/2026, not yet run in Cowork:

- Cowork runs a Linux VM with Bash, Python 3.10 and pip behind a network allowlist that admins can turn off; scripts stay optional (constitution Principle IV).
- Cowork's question tool is `AskUserQuestion` with a Skip button; the 1–4 questions and 2–4 options limits are documented for Claude Code only.
- Headless `claude -p` and `claude plugin eval` cannot answer `AskUserQuestion`; put answers in the eval prompt. The simulated-persona suite uses an Agent SDK harness that answers through `canUseTool`.
- Spec Kit 1.4.0 templates match 1.0.5; `clarify` changed only its Deferred rule. 1.4.0 adds template presets, a later option for a vibebiz preset on the tech side.

Verify at the first Cowork smoke test: the question tool's limits in Cowork, and whether the Google Docs and Slides connectors can insert an image without making it public.
