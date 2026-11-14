# vibebiz — project instructions

vibebiz is a plugin for Claude Cowork (the primary runtime) and, at parity through each host's own tools, for Claude Code, Codex and Antigravity (Fio, 14/11/2026, constitution 1.4.0). It works as a product owner for non-technical retail leaders. A sales director (online or offline; fashion, electronics, home appliances and similar retail) starts from a vague idea about a system, an AI use or an automation; vibebiz interviews them until the idea is clear, challenged and measurable, and packages it as a PRD for the board and for the internal tech team.

The constitution at `.specify/memory/constitution.md` is the governing law of this repository; this file holds the repository-wide rules and must not contradict it. When the two conflict, raise the conflict and resolve it by amendment instead of picking one.

These rules record the design decisions Fio settled on 12/11/2026. A rule here changes only with Fio's yes. **Where the detail lives**: repository-wide rules are here; the feature design is in `specs/001-idea-to-prd/` (spec appendices A–I for taxonomy, interview protocol, lenses, outputs, diagrams, framework library, fashion pack, workspace, docs and evals; `contracts/` for skills, files and exports; `data-model.md` for fields and states). Change a rule in one place and point to it from the other; when a spec or plan conflicts with this file, raise the conflict instead of picking one.

## Two roles of Spec Kit

- **Development tool.** This repository is developed with Spec Kit 1.4.0 (`.specify/`, `.claude/skills/speckit-*`). Write specs, plans and tasks with it. These files are development tooling and never ship in the plugin.
- **Upstream for the port.** The plugin ports Spec Kit 1.4.0 *content* to Cowork: the spec, plan, checklist and constitution templates, the `clarify` coverage taxonomy, and the specification writing rules. It does not port the mechanics: bash scripts, git branches, hooks, `feature.json`, extensions.
- Pin the port to 1.4.0. `UPSTREAM.md` lists every section taken from upstream and every section that is vibebiz's own. Upgrade only with Fio's yes.
- The snapshot keeps Spec Kit's mandatory headings unchanged in every language, with business sections before them (`contracts/exports.md` "Snapshot").
- Say "compatible with Spec Kit"; never use Spec Kit as vibebiz branding.

## Independence

- vibebiz depends on nothing from `finolabs-vibecode`. vibecode is for development teams. Do not reference, import or reuse its skills (for example `shape`, `fnl-ask`) inside the plugin. The only link to a tech team is the Spec Kit-compatible file format.
- `diagram-design` (cathrynlavery/diagram-design, MIT) is a companion plugin. Never copy it into this repository. vibebiz writes diagram briefs; diagram-design renders them. Its brand profile is the single brand source. Without it, exports show a table with a "no diagram" note; do not draw a substitute. Template blocks are a separate thing (Fio, 13/11/2026): the export templates may draw fixed-layout infographic blocks (charts, metric tiles, KPI tree, customer journey, Gantt, gauge, source matrix) from `exports/data.json`, because their layout is fixed and every value comes from the data. A free-form diagram is never drawn by vibebiz itself.

## Plugin shape

- Plugin name `vibebiz`, skills-only. **Exactly six skills**, the entry points, written as `skills/*/SKILL.md` and never as legacy `commands/`: `idea`, `continue`, `status`, `package`, `constitution`, `help` (Fio, 12/11/2026). Everything else (router, ask protocol, clarify, specify, the four lenses, plan, checklist, analyze, package, workspace, export guidelines, writing rules, anti-sycophancy) is a **module** in `core/`, never a skill (`contracts/modules.md`).
- The build copies `core/` into each skill's `references/`; a `SKILL.md` refers only to files inside its own folder. Keep `SKILL.md` bodies under 3,000 words.
- Write and edit every `SKILL.md`, `core/` module and framework card with the `writing-for-agents` skill (Fio, 13/11/2026): the description is a context pointer, steps end on completion criteria, detail moves into references, and no-ops and duplicates are pruned.
- On Claude Code, Codex and Antigravity vibebiz offers the folder and Drive workspaces, Google Slides and Docs, and the views in the host's preview through that host's own tools, choosing each path by the tools present (`specs/003-multi-host/contracts/host-capabilities.md`).
- Installed plugins also load in claude.ai chat and in Cowork on the web or a phone, which have no local folder. Every entry skill picks its storage first: a local folder, then Google Drive through Cowork's connector, otherwise it writes nothing and names both ways forward (`core/workspace.md` §1).
- Questions follow the interview protocol (spec Appendix B) through the host's question tool (Cowork's `AskUserQuestion`, or its equivalent on another supported host): never add "None" or "Other" (the tool has Skip and free text), a skip leaves the category unchanged, and with nobody to answer proceed on recorded assumptions without inventing answers.
- First-release content: `packs/retail-fashion`, `packs/ai-patterns-retail`, and the fifteen framework cards in `packs/frameworks/` (spec Appendix F). Frameworks are applied only to fill an open coverage gap, at most two per lens per idea.

## Workspace and outputs

- The user workspace is a public contract (`contracts/workspace-files.md`): fixed English names, slug from the idea title without diacritics, `idea` never overwrites and repairs only missing pieces, the table of contents is rebuilt after every write.
- Drive mode keeps the same layout in a Drive folder the user chooses, with the differences listed in `specs/002-drive-workspace/contracts/drive-workspace.md`: `index.json` instead of `index.html`, and the board and tech views as private Artifacts or, at the user's choice, private Google Slides and Docs; `board-deck.html` and `tech-prd.html` are never written to Drive. vibebiz never shares or changes the visibility of a Drive file.
- All outputs render from `exports/data.json` into fixed templates; packaging adds no facts, shows gaps as "not yet clarified", keeps numbers identical across views with source, period and label, and labels estimates "not tech-reviewed" until reviewed.
- Privacy: Artifacts are published private; vibebiz never shares an output and never makes an image or file public to insert it into Slides or Docs (a table plus the Artifact link instead).
- Outputs and questions use the language the user communicates in, Vietnamese by default.

## Language and naming

- Repository structure, file and folder names, and the instruction prompts in `SKILL.md`, modules and templates are in English.
- Text for users (questions, outputs, `docs/` content, `README.vi.md`) is in the user's language, Vietnamese by default, written for people who are not technical. Edit Vietnamese prose for natural wording before release.
- `README.md` is in English; `README.vi.md` is in Vietnamese with the same sections and the same license and install tables.

## Licensing and content hygiene

- Source-available, not open source: PolyForm Noncommercial 1.0.0 for the public code plus a commercial license. Never call vibebiz "open source". Businesses, including those given vibebiz for free, need a written commercial license (a free grant states the business, term, scope and update rights).
- Copyright holder is Fioenix for now. Before Finolabs sells a license, Fioenix needs a written assignment or license to Finolabs.
- Contributions require the CLA (`CLA.md`).
- Keep the MIT notices of Spec Kit and `grilling` in `THIRD_PARTY_LICENSES.md`.
- Framework cards and packs describe third-party frameworks (for example Strategyzer's canvases, which are CC BY-SA) in vibebiz's own words and credit their origin; never copy their text, layout or artwork verbatim.
- The repository goes public with v0.1.0; Fio decided on 13/11/2026 that the license, the commercial terms and the CLA ship without a lawyer's review.
- No internal data in the repository: no real people, companies, customers or figures, and no organization's constitution or brand. Examples, packs and eval fixtures are fictional or built from public knowledge.
- `PRIVACY.md` states that business data stays in the user's workspace and Google Drive and that the plugin sends it nowhere else. TypeSafe/Jev is used only in developer evals, never at runtime.

## Release review

Before cutting a version, review everything that describes the product (README pair, `docs/` and its diagrams, `help`'s situation map, the fictional example) against what ships; every entry skill appears in `help`'s map and `docs/commands.md` and nothing else does; the example passes the package check and the Spec Kit compatibility check; the eval suites (spec Appendix I) and the Cowork smoke test (`quickstart.md`) pass.

## Platform findings and open checks

Findings from documentation and web sources on 12/11/2026, not yet run in Cowork:

- Cowork runs a Linux VM with Bash, Python 3.10 and pip behind a network allowlist that admins can turn off; scripts stay optional (constitution Principle IV).
- Cowork's question tool is `AskUserQuestion` with a Skip button; the 1–4 questions and 2–4 options limits are documented for Claude Code only.
- Headless `claude -p` and `claude plugin eval` cannot answer `AskUserQuestion`; put answers in the eval prompt. The simulated-persona suite uses an Agent SDK harness that answers through `canUseTool`.
- diagram-design's PNG export needs Playwright and a Chromium download that Cowork's allowlist blocks; SVG needs no script. Google Slides and Docs accept only PNG, JPEG or GIF from a public URL.
- Cowork's Google Docs and Slides connectors write text, tables and layout directly (Fio, 12/11/2026).
- Spec Kit 1.4.0 templates match 1.0.5; `clarify` changed only its Deferred rule. 1.4.0 adds template presets, a later option for a vibebiz preset on the tech side.

Verify at the first Cowork smoke test: the question tool's limits in Cowork, private image insertion in Slides and Docs, updating an Artifact in place, resolving files across skill folders, and installing from a private repository.
