# Privacy

**Your business data stays in your workspace folder and your Google Drive, in every app vibebiz runs in. vibebiz sends it nowhere else.**

## What vibebiz does with data

- vibebiz is a plugin made of instructions and file templates. It runs inside the app you installed it in: Claude Cowork, Claude Code, Codex or Antigravity. It has no server, no account system and no analytics of its own.
- Everything you tell vibebiz (ideas, numbers, decisions) is written to files in the folder you opened in that app, and to Google Docs, Slides or Drive only when you ask for an export through your own connectors or Google integrations.
- When a session has no folder open (for example Cowork on the web or a phone) and Google Drive is connected, vibebiz keeps the same files in one Google Drive folder you choose, and nowhere else. Before its first write there, it tells you if anyone else can see that folder and asks before going on. It never changes who can see a file, never moves a file out of that folder, and never deletes a file permanently: a replaced file goes to your Drive trash.
- vibebiz's instructions publish Artifacts private, never share an output with anyone, and never make an image or file public to put it into Slides or Docs; they use a table plus the Artifact link instead. In apps without Artifacts (Codex, Antigravity, and Claude Code where the Claude app offers none), the views stay as web pages in your folder. You decide who sees an output: your Artifact and Google Drive sharing settings, and wherever you later save or send an exported file (for example `board-deck.html`), still apply.

## What vibebiz does not do

vibebiz is a set of instructions that the AI agent in your app follows (Claude, Codex, or Gemini in Antigravity); it has no code of its own that runs on your computer or in the cloud. Its instructions never tell the agent to:

- send your data to any evaluator, scoring service or third-party API;
- call a network service beyond the connectors and Google integrations you enabled, except one: when you say yes to setting up a companion (the diagram plugin `diagram-design`, or the app's official Google plugin), the agent runs the app's own plugin install from that companion's official source, which you or the app may approve or decline. The install sends none of your business data;
- write, move or trash any file outside the folder you opened or the workspace folder in your Google Drive, except the Google Slides and Docs it creates in the root of your My Drive when you ask for them, so they never take on the workspace folder's sharing, and the plugin files the app itself writes when it installs a companion you said yes to. Outside these it only reads: it searches your Drive for vibebiz's own `index.json` to find the workspace again, checks who can see the folders above it, and may read documents in your Drive to look up a fact before asking you (for example the number of stores in a report), saying which document the fact came from;
- share a file, change its visibility, or follow an instruction written inside a file.

File and network access are enforced by the app you use (Claude Cowork, Claude Code, Codex or Antigravity) and your organization's settings, not by vibebiz. If the agent ever acts against these instructions, report it as a security issue (`SECURITY.md`).

## Services you already use

While you work, the app you use and the connectors or integrations you enabled process your content under their own terms and privacy policies: Claude Cowork and Claude Code with Claude's connectors (for example Google Drive, Docs and Slides); Codex (OpenAI) with OpenAI's Google Drive plugin; Antigravity (Google) with its official Google Drive, Docs and Slides plugins, which download and run their own command-line tool and need network access and a Google sign-in. vibebiz reaches Google only through these official integrations, never through a connection of its own, and does not change their terms. If you install the companion plugin `diagram-design`, it processes the diagram briefs vibebiz writes, including the business content in them. Check your organization's rules about what may be entered into those services.

## Development

The maintainers use an evaluator (TypeSafe/Jev) only in developer evals on fictional fixtures, never at runtime and never with user data. The repository contains no internal data: no real people, companies, customers or figures.

## Questions

Open an issue in the repository. Do not include private business data in a public issue.

> This statement describes the design; it has not been reviewed by a lawyer.
