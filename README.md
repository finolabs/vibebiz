# vibebiz

A Claude Cowork plugin that works as a product owner for retail leaders. You bring a vague idea; vibebiz interviews you until the idea is clear, challenged and measurable, then packages it as a PRD for your board and for your internal tech team.

Vietnamese version: [README.vi.md](README.vi.md)

## What vibebiz is

You start with something like "we should use AI to bring lapsed customers back". vibebiz asks one short round of questions at a time, writes every answer to files in your folder, questions the idea honestly (including "do nothing" and "fix the process"), and makes sure every goal has a baseline, a target and a way to measure it. When the idea is ready it produces two views from one source: a board deck and a tech PRD. The tech view includes a requirement file in a format compatible with Spec Kit, so your developers can plan from it without rework.

vibebiz is not a coding tool and never asks you to open a terminal.

## Who it is for

Sales and operations directors in retail, online or offline (fashion first; electronics, home appliances and similar next), who own an idea for a system, an AI use or an automation and need to take it to a board and a tech team. Outputs and questions use the language you speak with it, Vietnamese by default.

## Install by upload

1. Get the plugin file `vibebiz.plugin` from a release (none published yet).
2. In Claude Cowork, upload the plugin file.
3. Open an empty folder in Cowork and start with the `new` skill.

Install the companion plugin `diagram-design` if you want diagrams in the outputs (see below).

## What ships

This section lists each skill when the story that delivers it ships. Each command is a skill of the same name; you can also just say what you want in plain words.

- `/vibebiz:new`: start a new idea. Sets up the workspace in your folder if needed, asks about a real recent case, drafts a first requirement with every gap marked, then interviews you in short rounds (at most four multiple-choice questions, recommended answer first) and saves every answer.
- `/vibebiz:continue`: pick an idea back up. Re-reads its files (your own edits win), summarizes in three lines what is settled, where it stopped and the next question, then continues the rounds.
- `/vibebiz:status`: list every idea with its status, how many of the 15 points are clear and the next step. Asks nothing.

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
