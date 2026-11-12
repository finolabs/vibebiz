# vibebiz

A Claude Cowork plugin that works as a product owner for retail leaders. You bring a vague idea; vibebiz interviews you until the idea is clear, challenged and measurable, then packages it as a PRD for your board and for your internal tech team.

Vietnamese version: [README.vi.md](README.vi.md)

## What vibebiz is

You start with something like "we should use AI to bring lapsed customers back". vibebiz asks one short round of questions at a time, writes every answer to files in your folder, questions the idea honestly (including "do nothing" and "fix the process"), and makes sure every goal has a baseline, a target and a way to measure it. When the idea is ready it produces two views from one source: a board deck and a tech PRD. The board deck uses an infographic format (one central visual per slide, few words, takeaway in the title). The tech view includes a requirement file in a format compatible with Spec Kit, so your developers can plan from it without rework.

vibebiz is not a coding tool and never asks you to open a terminal.

## Who it is for

Sales and operations directors in retail, online or offline (fashion first; electronics, home appliances and similar next), who own an idea for a system, an AI use or an automation and need to take it to a board and a tech team. Outputs and questions use the language you speak with it, Vietnamese by default.

## Install in Cowork

1. Download `vibebiz.plugin` from the latest [release](https://github.com/finolabs/vibebiz/releases).
2. In Claude Cowork, open Settings › Plugins, choose "Upload plugin" and select `vibebiz.plugin`.
3. Open an empty folder in Claude Cowork and get started by typing `/vibebiz:new` or `/vibebiz:help`.

Install the companion plugin `diagram-design` if you want automatic diagram rendering in the outputs (see below).

On Claude Team or Enterprise, administrators can add a short organization instruction so Claude suggests vibebiz when an employee describes an idea: [docs/admin-setup.md](docs/admin-setup.md).

## What ships

vibebiz ships six skills. Each command is a skill of the same name; you can also just say what you want in plain words.

- `/vibebiz:new`: start a new idea. Sets up the workspace in your folder if needed, asks about a real recent case, drafts a first requirement with every gap marked, then interviews you in short rounds (at most four multiple-choice questions, recommended answer first) and saves every answer.
- `/vibebiz:continue`: pick an idea back up. Re-reads its files (your own edits win), summarizes in three lines what is settled, where it stopped and the next question, then continues the rounds. Also records board outcomes (approved, rejected, needs changes) and tech team reviews of estimates.
- `/vibebiz:package`: package a clarified idea for the board and the tech team. Checks readiness (or offers a labelled draft), builds the plan, checks for gaps and contradictions, then makes a board deck and a requirements document as private Claude Artifacts or your own Google Slides and Docs, plus a Spec Kit-compatible requirement file. The same figures appear in every view with their source; earlier versions are kept. Nothing is shared or made public.
- `/vibebiz:status`: list every idea with its status, how many of the 15 points are clear and the next step. Asks nothing.
- `/vibebiz:constitution`: record or update your organization's ground rules in one round of at most four questions: this year's priorities, the budget you approve alone, your business, and the steps that always need a person to approve; optionally your strategy objectives and OKRs. Skip it and the rules stay "later". Challenge and planning check every idea against them, and the plan and the board deck show any conflict. Changing a recorded rule shows the change and asks before saving.
- `/vibebiz:help`: guide you to the right command for your situation and answer questions from the shipped documentation, citing the section. Reads a skill's current instructions before describing it, points to a fictional example idea (`examples/`) on request, and writes nothing to the workspace.

Commands in Vietnamese: [docs/commands.md](docs/commands.md).

## License

vibebiz is **source-available**: the public code is under the PolyForm Noncommercial License 1.0.0, plus a separate commercial license.

| Who you are | What you need |
|---|---|
| An individual using vibebiz for personal study or a hobby | Nothing more: free under `LICENSE` |
| A charitable, educational, public-research, public-safety, environmental or government organization | Free under `LICENSE` (noncommercial purposes as that license defines them) |
| A business using vibebiz for its work, including a business that is given vibebiz for free | A written commercial license, see [COMMERCIAL-LICENSE.md](COMMERCIAL-LICENSE.md) |
| A contributor | Agree to the [CLA](CLA.md) |

The license texts are drafts awaiting a lawyer's review. See also [TERMS.md](TERMS.md).

## Privacy

Your business data stays in your workspace folder and your Google Drive; vibebiz sends it nowhere else. Artifacts are published private and vibebiz never shares an output for you. Details: [PRIVACY.md](PRIVACY.md).

## Companion: diagram-design

vibebiz writes diagram briefs; the separate plugin [diagram-design](https://github.com/cathrynlavery/diagram-design) (MIT) renders them. It is not part of this repository. Without it, exports show a table with a "no diagram" note.

## Spec Kit

vibebiz is compatible with Spec Kit 1.4.0. What it ports and what it adds is in [UPSTREAM.md](UPSTREAM.md); third-party notices are in [THIRD_PARTY_LICENSES.md](THIRD_PARTY_LICENSES.md).

## Contributing and security

[CONTRIBUTING.md](CONTRIBUTING.md), [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md), [SECURITY.md](SECURITY.md), [CHANGELOG.md](CHANGELOG.md).
