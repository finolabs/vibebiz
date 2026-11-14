# vibebiz

A plugin that works as a product owner for founders and business leaders. Its main app is Claude Cowork; it also runs in Claude Code, Codex and Antigravity, with the same six commands. You bring a vague idea; vibebiz interviews you until the idea is clear, challenged and measurable, then packages it as a PRD for your board and for your internal tech team.

Vietnamese version: [README.vi.md](README.vi.md)

## What vibebiz is

You start with something like "we should use AI to bring lapsed customers back". vibebiz asks one short round of questions at a time, writes every answer to files in your folder, questions the idea honestly (including "do nothing" and "fix the process"), and makes sure every goal has a baseline, a target and a way to measure it. When the idea is ready it produces two views from one source: a board deck and a tech PRD. The board deck uses an infographic format (one central visual per slide, few words, takeaway in the title). The tech view includes a requirement file in a format compatible with Spec Kit, so your developers can plan from it without rework.

vibebiz is not a coding tool. In Cowork you never need a terminal; in Claude Code, Codex and Antigravity, installing it takes one or two typed lines, and after that you work in plain conversation.

## Who it is for

Founders and leaders of small and mid-sized businesses who are not technical, who own an idea for a system, an AI use or an automation and need to take it to their board and a tech team. Retail comes first, online or offline (fashion first; electronics, home appliances and similar next): the examples and knowledge packs that ship today are for retail. Outputs and questions use the language you speak with it, Vietnamese by default.

## Install

Pick the app you already use. Each install gives you the same six commands and the same files; an idea started in one app continues in another when both reach the same folder or the same Google Drive folder.

Install the companion plugin `diagram-design` if you want automatic diagram rendering in the outputs (see below).

On Claude Team or Enterprise, administrators can add a short organization instruction so Claude suggests vibebiz when an employee describes an idea: [docs/admin-setup.md](docs/admin-setup.md).

### Cowork (main app)

1. Download `vibebiz.plugin` from the latest [release](https://github.com/finolabs/vibebiz/releases).
2. In Claude Cowork, open Settings › Plugins, choose "Upload plugin" and select `vibebiz.plugin`.
3. Open an empty folder in Claude Cowork and get started by typing `/vibebiz:idea` or `/vibebiz:help`. On the web or a phone, where Cowork cannot open a folder on your computer, connect Google Drive in Cowork's Connectors instead: vibebiz then keeps your ideas in a Drive folder you choose, with the same layout. On the desktop an open folder always wins, and the two are never synced.

### Claude Code

```bash
claude plugin marketplace add finolabs/plugins
claude plugin install vibebiz@finolabs
```

Inside Claude Code, once the FINOLABS catalog is added, typing `/plugin install vibebiz@finolabs` does the same. Open your project folder and type `/vibebiz:idea`. If each vibebiz command shows up twice, you have both the copy synced from your Claude account and the catalog copy: keep one ([FAQ 13](docs/faq.md)).

### Codex

```bash
codex plugin marketplace add finolabs/plugins
codex plugin add vibebiz@finolabs
```

Open a workspace folder in Codex and type `$idea`, or describe your idea in plain words. Codex shows every vibebiz command with a `$` in front: `$continue`, `$package`, `$help` and so on.

### Antigravity

```bash
agy plugin install https://github.com/finolabs/vibebiz
```

Open a workspace folder in Antigravity and type `/idea`, or describe your idea in plain words. Antigravity shows the commands without the `vibebiz:` part: `/continue`, `/package` and so on. The one exception is help: `/help` opens Antigravity's own help, so ask in words instead ("vibebiz, how do I use this?"). Antigravity may have copied an older vibebiz from Claude Code by itself; remove that copy before installing ([FAQ 16](docs/faq.md)).

## What works in each app

vibebiz checks what the app in front of you can do (open a folder, reach Google Drive, show a page) and uses that; when something is missing, it tells you how to turn it on and offers another way.

| | Cowork | Claude Code | Codex | Antigravity |
|---|---|---|---|---|
| How you type a command | `/vibebiz:idea` | `/vibebiz:idea` | `$idea` | `/idea`; for help, ask in words |
| Ideas kept in a folder on your computer | the folder you open (desktop app) | your project folder | your workspace folder | your workspace folder |
| Ideas kept in Google Drive | Cowork's Google Drive connector | the Claude app's Google Drive connector | OpenAI's Google Drive plugin | Antigravity's official Google Drive plugin |
| Board deck in Google Slides, PRD in Google Docs | Cowork's Slides and Docs connectors | when the Claude app has them connected | OpenAI's Google Drive plugin | Antigravity's official Google Slides and Google Docs plugins |
| Where you see the board deck and the PRD | a private Artifact (a page only you can open in Claude) | a private Artifact where the Claude app offers one; otherwise web pages in the idea folder | web pages in the idea folder, opened in your browser | web pages in the idea folder, opened in your browser |
| How questions arrive | answer buttons, up to four questions with up to four choices | the same | Codex's answer buttons where Codex offers them (at most three at a time, so one round may come in two parts); otherwise numbered choices in text | Antigravity's answer buttons |

Without a question tool, vibebiz asks the same round in plain text with numbered choices, and you answer by number or in your own words. With neither a folder open nor Google Drive connected, vibebiz saves nothing and tells you the two ways forward: open a working folder in the app, or connect Google Drive.

### Connect Google

- **Cowork**: open Connectors and connect Google Drive (and Google Slides and Docs for the board deck and the PRD).
- **Claude Code**: connect Google Drive in the Claude app's Connectors.
- **Codex**: install the Google Drive plugin in Codex and sign in with your Google account; the same plugin covers Docs and Slides.
- **Antigravity**: install Antigravity's official Google Drive plugin (and its Google Slides and Google Docs plugins for packaging) and sign in with your Google account. These plugins need internet access and download their own small helper program the first time; vibebiz itself runs no program.

In every app the files go only into your folder or your own Google Drive, private; vibebiz never shares a file or makes one public.

## What ships

vibebiz ships six skills. Each command is a skill of the same name; you can also just say what you want in plain words. The commands below are written as Cowork and Claude Code show them; in Codex type `$idea`, in Antigravity `/idea`, and so on.

- `/vibebiz:idea`: start a new idea. Sets up the workspace in your folder if needed, asks about a real recent case, drafts a first requirement with every gap marked, then interviews you in short rounds (at most four multiple-choice questions, recommended answer first) and saves every answer.
- `/vibebiz:continue`: pick an idea back up. Re-reads its files (your own edits win), summarizes in three lines what is settled, where it stopped and the next question, then continues the rounds. Also records board outcomes (approved, rejected, needs changes) and tech team reviews of estimates.
- `/vibebiz:package`: package a clarified idea for the board and the tech team. Checks readiness (or offers a labelled draft), builds the plan, checks for gaps and contradictions, then makes a board deck and a requirements document as private Claude Artifacts (web pages in the idea folder in apps without Artifacts) or your own Google Slides and Docs, plus a Spec Kit-compatible requirement file. The same figures appear in every view with their source; earlier versions are kept. Nothing is shared or made public.
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

See also [TERMS.md](TERMS.md).

## Privacy

In every app, your business data stays in your workspace folder and your Google Drive; vibebiz sends it nowhere else. In Codex and Antigravity it reaches Google only through those apps' own official Google integrations. Artifacts are published private and vibebiz never shares an output for you or makes a file public. Details: [PRIVACY.md](PRIVACY.md).

## Companion: diagram-design

vibebiz writes diagram briefs; the separate plugin [diagram-design](https://github.com/cathrynlavery/diagram-design) (MIT) renders them. It is not part of this repository. Without it, exports show a table with a "no diagram" note.

## Spec Kit

vibebiz is compatible with Spec Kit 1.4.0. What it ports and what it adds is in [UPSTREAM.md](UPSTREAM.md); third-party notices are in [THIRD_PARTY_LICENSES.md](THIRD_PARTY_LICENSES.md).

## Contributing and security

[CONTRIBUTING.md](CONTRIBUTING.md), [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md), [SECURITY.md](SECURITY.md), [CHANGELOG.md](CHANGELOG.md).
