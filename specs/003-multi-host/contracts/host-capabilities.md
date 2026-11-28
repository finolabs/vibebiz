# Contract: Host capabilities

vibebiz offers the same features on every supported host, each through that host's own tools (constitution 1.4.0). Every run decides by what the session actually has, never by the host's name. This table is what to expect and where to look; cells marked "measure" are confirmed by the Phase 1 tasks before the modules rely on them.

## Capability map

| Capability | Cowork | Claude Code | Codex | Antigravity |
| --- | --- | --- | --- | --- |
| Local folder workspace | the opened folder (desktop) | the project folder | the workspace folder | the workspace folder |
| Google Drive workspace | Drive connector | Drive connector tools when connected (desktop app; a plugin skill sees them, T008) | `mcp__codex_apps__google_drive_*` tools from OpenAI's Google Drive plugin (measure) | official `gdrive` skill: every operation the Drive contract needs exists (research R7, T007) |
| Google Slides | Slides connector | when a Slides tool is present | the `google-slides` skill or `presentations` runtime of the Google Drive plugin (measure) | official `gslides` skill: create, then move into the idea's folder; private local images (T007) |
| Google Docs | Docs connector | Docs connector tools when connected | the `google-docs` skill / Drive document tools (measure) | official `gdocs` skill: create or import a local Markdown file (T007) |
| Views shown in the host | private Artifact | private Artifact when the `Artifact` tool is present (desktop app, T008); else file paths | `visualize` inline preview (desktop app) or in-app browser on the `file://` path; else file paths (measure) | app preview or built-in browser where available; else file paths (measure) |
| Question tool | `AskUserQuestion` 1–4 questions, 2–4 options | `AskUserQuestion` | `request_user_input` 1–3 questions, 2–3 options, offered in Plan mode, in Default mode only when listed; else plain text | `ask_question`: options are plain strings, at least five accepted, multi-select; skipped in `agy -p` (T006) |
| Skill name shown | `/vibebiz:idea` | `/vibebiz:idea` | `$idea` (model: `vibebiz:idea`; app-server lists `vibebiz:idea`) | `/idea`; `/help` opens Antigravity's own help, so vibebiz's help is reached by asking for it (T005) |
| Install | `vibebiz.plugin`, or a marketplace | catalog `vibebiz@finolabs` | catalog `vibebiz@finolabs` | `agy plugin install https://github.com/finolabs/vibebiz` |
| Companion setup (`core/companions.md` §5) | user's steps only: Customize › Plugins › Add marketplace `cathrynlavery/diagram-design` › Install; Google through Connectors | agent runs `claude plugin marketplace add cathrynlavery/diagram-design` (when not listed), `claude plugin install diagram-design@diagram-design`; Google through the Claude app's Connectors | agent runs `codex plugin marketplace add cathrynlavery/diagram-design`, `codex plugin add diagram-design@diagram-design`; `codex plugin add google-drive@openai-curated-remote`, user signs in | agent runs `agy plugin install https://github.com/cathrynlavery/diagram-design`; `agy plugin install gslides@antigravity-plugins-official` / `gdocs@antigravity-plugins-official`, user signs in |

## Choosing a path

1. **Storage** (`core/workspace.md` §1): a working folder the user chose → local mode; else Google Drive tools or skills present → Drive mode; else neither → the "Neither" message for this host.
2. **Drive operations** (`core/drive-workspace.md`): the module names each operation by role (search by title and parent, read, download, create with a parent, copy, trash, read permissions) and maps it to the tools present: Cowork's connector, Codex's `google_drive_*` tools, or Antigravity's `gdrive` skill. Every Drive rule of `specs/002-drive-workspace/contracts/drive-workspace.md` holds on every host: the user picks the folder, sharing is named and confirmed before the first write, files change only by replacement, nothing is shared or made public. An operation the host cannot do (for example reading a file's permissions) stops the run before writing, as a missing connector tool does in Cowork.
3. **Slides and Docs** (`core/package.md`): the same content rules on every host (from `exports/data.json`, gaps "not yet clarified", estimates "not tech-reviewed", a table plus a link instead of any image that would need to be public).
4. **Views**: Artifact if the tool exists; else the host's preview of the local file; else the file paths. Drive mode without an Artifact tool shows the views from a temporary local copy only if the host has a preview; it never writes `board-deck.html` or `tech-prd.html` to Drive.
5. **Questions** (`core/ask-protocol.md`): vibebiz's limits stay (one to four questions per round, two to four options, recommended first, never adding "None" or "Other"). When the host tool allows fewer, split the round into several calls and trim no option the user needs: a question with four options becomes plain text if the tool takes three. Without a tool, ask in plain text with numbered choices.

## Companion setup: what is verified

Checked on 28/11/2026. "Verified" means the command's syntax and names come from the host CLI's own `--help` and listing on a real install, or from the host's or the companion's documentation; no install was run for this change. Every cell marked unverified is confirmed at the first real setup and recorded in `evals/RESULTS.md` before the modules rely on it.

| Host | Companion | Status | Source |
| --- | --- | --- | --- |
| Claude Code | diagram-design | verified: `claude plugin marketplace add <source>` and `claude plugin install <plugin>@<marketplace>` (Claude Code 2.1.332 `--help`); marketplace name `diagram-design` from the repository's `.claude-plugin/marketplace.json`; the same two lines in diagram-design's README. Unverified: whether the running session sees it without a new session (README: `/reload-plugins` or the next session) | `claude plugin --help`; github.com/cathrynlavery/diagram-design README "Install" |
| Codex | diagram-design | verified: `codex plugin marketplace add`, `codex plugin add <plugin>@<marketplace>` (codex-cli 0.169.0 `--help`); README gives the same lines and says to start a new session | `codex plugin --help`; diagram-design README |
| Codex | google | verified name `google-drive@openai-curated-remote` from `codex plugin list`; unverified: the Google sign-in flow after a CLI install | `codex plugin list`, `codex plugin add --help` |
| Antigravity | diagram-design | partly verified: `agy plugin install <target>` (agy 1.5.19 help); `agy plugin validate` on the repository reports a Claude Code plugin that `plugin install` converts. Unverified: the converted install loading and rendering, and whether a new session is needed | `agy plugin help`, `agy plugin validate` |
| Antigravity | google | verified names `gdrive`, `gslides`, `gdocs` from `antigravity-plugins-official` in `agy plugin list`; `plugin[@marketplace]` from `agy plugin help`. Unverified: install by that form, first-run sign-in | `agy plugin list`, `agy plugin help` |
| Cowork | diagram-design | documented UI steps (Customize › Plugins › Add marketplace, `owner/repo` accepted, then Install); the agent has no command for it. Unverified: whether a new task is needed, and an organization's restriction on adding marketplaces in practice | claude.com/docs/cowork/guide/plugins |
| Cowork, Claude Code | google | connectors only; the user connects and signs in | existing rows above, `core/workspace.md` §1 |

## When a feature is not available

vibebiz writes nothing for that feature, says in plain words how to turn it on in this host (Cowork: Connectors; Codex: install and connect OpenAI's Google Drive plugin; Antigravity: install and sign in to the official Google plugins), and offers the alternative (the folder workspace, the HTML views). It never invents a substitute or calls a tool that is not there.
