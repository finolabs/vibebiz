# Privacy

**Your business data stays in your workspace folder and your Google Drive. vibebiz sends it nowhere else.**

## What vibebiz does with data

- vibebiz is a plugin made of instructions and file templates. It runs inside Claude Cowork. It has no server, no account system and no analytics of its own.
- Everything you tell vibebiz (ideas, numbers, decisions) is written to files in the folder you opened in Cowork, and to Google Docs, Slides or Drive only when you ask for an export through your own connectors.
- vibebiz's instructions publish Artifacts private, never share an output with anyone, and never make an image or file public to put it into Slides or Docs; they use a table plus the Artifact link instead. You decide who sees an output: your Artifact and Google Drive sharing settings, and wherever you later save or send an exported file (for example `board-deck.html`), still apply.

## What vibebiz does not do

vibebiz is a set of instructions that Claude follows; it has no code of its own that runs on your computer or in the cloud. Its instructions never tell Claude to:

- send your data to any evaluator, scoring service or third-party API;
- call a network service beyond the connectors you enabled;
- read files outside the folder you opened.

File and network access are enforced by Claude Cowork and your organization's settings, not by vibebiz. If Claude ever acts against these instructions, report it as a security issue (`SECURITY.md`).

## Services you already use

While you work, Claude Cowork and the connectors you enabled (for example Google Drive, Docs and Slides) process your content under their own terms and privacy policies. vibebiz does not change that. If you install the companion plugin `diagram-design`, it processes the diagram briefs vibebiz writes, including the business content in them. Check your organization's rules about what may be entered into those services.

## Development

The maintainers use an evaluator (TypeSafe/Jev) only in developer evals on fictional fixtures, never at runtime and never with user data. The repository contains no internal data: no real people, companies, customers or figures.

## Questions

Open an issue in the repository. Do not include private business data in a public issue.

> This statement describes the design; it has not been reviewed by a lawyer.
