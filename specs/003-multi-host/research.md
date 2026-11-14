# Research: Install from the catalog on Claude Code, Codex and Antigravity

Read-only research on 14/11/2026, on this machine: Claude Code 2.1.325, codex-cli 0.167.2, agy 1.5.8. Sources are the hosts' docs and CLI help, the plugin caches on this machine, and the layouts of `finolabs/vietnamizer` and `finolabs/agybird`.

## R1. What each host installs from

| Host | Sources | Sub-folder at a ref | Evidence |
| --- | --- | --- | --- |
| Claude Code | relative path, `github` (repository root), `url`, `git-subdir`, `npm`, `archive`, `command` | Yes, `git-subdir` with `path` and `ref` | code.claude.com/docs/en/plugins/marketplace-reference |
| Codex | marketplace: local path, `owner/repo[@ref]`, Git URL, `--sparse`; entry: `local`, `url`, `git-subdir`, `npm` | Yes, `git-subdir` | `codex plugin marketplace add --help`; developers.openai.com/codex/plugins/build |
| Antigravity | a local directory, `<plugin>@<marketplace>` for Google's own marketplaces, and per its docs a GitHub repository URL | Not documented | `agy plugin --help`, binary strings, antigravity.google/docs/plugins |
| Cowork | a marketplace the user adds (GitHub `owner/repo`), and the uploaded `.plugin` archive | Organization sync accepts `git-subdir`; user marketplaces undocumented | claude.com/docs/cowork/guide/plugins |

**Decision**: install from the repository root at a release tag on every host.
**Rationale**: it is the only source all three hosts share. A sub-folder (`git-subdir`) is not available on Antigravity.
**Alternatives considered**: a committed build in a sub-folder (fails on Antigravity); a separate distribution repository with the built tree at its root (works everywhere and ships no development folders, but adds a second repository and a push step to every release). Fio chose the first layout below on 14/11/2026.

## R2. Layout: generated skills in `.plugin-skills/`, as vietnamizer does

- All three manifests take a `skills` path. Claude Code and Antigravity load it **in addition to** the default `skills/` folder; Codex's rule is undocumented, and agybird ships no `skills/` folder for that reason. So a root `skills/` folder of unbuilt sources would load next to the built skills, without their `references/`.
- `finolabs/vietnamizer` and `finolabs/agybird` keep generated skills in a tracked dot-folder (`.plugin-skills/`, `.codex-skills/`), point every manifest's `skills` at it, and check it in CI.

**Decision** (Fio, 14/11/2026): track the built skills in `.plugin-skills/<skill>/` (the six entry skills, each with its `references/`), point all three manifests at `./.plugin-skills/`, and move the source skills from `skills/` to `src/skills/` so no host loads them. A check fails when `.plugin-skills/` differs from what the build would write.
**Rationale**: one repository and one tag, the pattern the organization already runs, and the catalog checker needs no change.
**Accepted cost**: about 6.5 MB of generated files in the repository, and every install also copies the development folders (`evals/`, `specs/`, `scripts/`, `.specify/`, `.claude/skills/`). They are inert: no host loads skills from them. Spec FR-002 is relaxed accordingly.
**Probe (T001, 14/11/2026, Claude Code 2.1.325)**: a copy of the repository with `.plugin-skills/` taken from the build, no root `skills/`, and `"skills": "./.plugin-skills/"` in `.claude-plugin/plugin.json` passes `claude plugin validate`. Loaded with `--plugin-dir` under a distinct name (`vibebiz-t001`, so the synced `vibebiz` copy could not shadow it), the session listed exactly the six entry skills; the copy's `.claude/skills/speckit-*` did not load as plugin skills. A first probe under the name `vibebiz` was void: the synced upload answered instead.
**Alternatives considered**: thin adapter skills that read `core/` from the plugin root, as vietnamizer's skills do. Rejected for now: whether Cowork resolves files outside a skill's own folder is still an open check (`CLAUDE.md` "Platform findings"), and the copies are known to work.

## R3. No exclude list on install

None of the three hosts honors an ignore or exclude list. Observed caches: Claude Code copies the whole plugin directory except `.git` (vietnamizer's cache holds `specs/`, `tests/`); Codex and Antigravity copy the whole repository, `.git` included. This is why development folders ship with layout R2.

## R4. Question tools

| Host | Tool | Limits |
| --- | --- | --- |
| Cowork, Claude Code | `AskUserQuestion` | 1–4 questions, 2–4 options, Skip and free text (documented for Claude Code) |
| Codex | `request_user_input` | unverified |
| Antigravity | `ask_question` | unverified |

**Decision**: `core/ask-protocol.md` names the tool by role ("the host's question tool"), keeps the 1–4 / 2–4 rules as vibebiz's own limits, and splits a round when a host allows fewer. Plain-text questions remain the fallback. The real limits are measured in the first install run on each host (task), not assumed.

## R5. What changes for the user on non-Cowork hosts

- Local folder mode already writes `board-deck.html`, `tech-prd.html` and `index.html` in the workspace; nothing new is needed for the outputs.
- `core/workspace.md` §1 speaks of "the folder the user opened in Cowork" and its "Neither" message names Cowork's Connectors and the desktop app. On another host, "Neither" means no folder is open: the message tells the user to open a folder, and names Cowork for Drive mode.
- `core/package.md` offers Artifacts and Google Slides and Docs; on a host without them it says they are Cowork features and offers the local views.
- Skill names: Claude Code and Cowork show `/vibebiz:idea`; Codex shows skills as `$<name>` or by plugin; Antigravity as `/<name>`. Measured at the first install; `help` and the docs give each host's form.

## R6. Proof of install

- No headless harness like `claude plugin eval` exists for Codex or Antigravity. Each release records, per host, a real install from the tag (catalog for Claude Code and Codex, repository URL for Antigravity) and one scripted or manual run of the fictional example from `idea` to `package`, in `evals/RESULTS.md`.
- `agy plugin install <GitHub URL>` is documented but was not reproduced on this machine (the probe was not run); the first release install checks it.
- The catalog's `scripts/check-catalogs.py --remote` reads `.claude-plugin/plugin.json`, `.codex-plugin/plugin.json` and `.antigravity-plugin/plugin.json` at the pinned tag; with all three present, vibebiz needs no `CLAUDE_ONLY` exception and the `list-vibebiz` branch is superseded by a plain entry in both catalogs.

## R7. Codex and Antigravity in depth (14/11/2026)

Read-only research for parity (Fio, 14/11/2026). Evidence: docs fetched today, CLI help, strings in the shipped binaries (they show code exists, not runtime behavior), the plugin caches, and finolabs-vibecode, agybird and vietnamizer. "Unverified" items are measured in Phase 1 tasks.

### Codex (codex-cli 0.167.2; CLI, desktop app, IDE)

- **Manifest**: `.codex-plugin/plugin.json` (a root `plugin.json` also works; avoid it, Antigravity reads a root `plugin.json` with a closed schema). Listing fields in `interface`: `displayName` and `shortDescription` at most 30 characters, `longDescription` at most 4000.
- **Skills**: discovered from the folder `skills` names; a root `SKILL.md` is not discovered. Frontmatter `name` and `description`; Claude-only keys ignored. Users type `$idea` or `/skills`; the model sees `vibebiz:idea`. Skills auto-trigger from their description.
- **Question tool** `request_user_input`: 1–3 questions per call ("prefer 1"), each with `id`, `header` (12 characters or fewer), one-sentence `question`, 2–3 `options` (`label` 1–5 words plus `description`), recommended first; the client adds "Other" itself; no multi-select found. Offered in Plan mode; in Default mode only when listed (feature `default_mode_request_user_input` is under development and off); not supported in `codex exec`. So most Codex sessions ask in plain text. Unverified until a real run in the CLI, the app and the IDE.
- **Files**: default Auto mode writes the workspace and temp; elsewhere needs approval. A skill reads its own files by paths relative to its `SKILL.md` folder (no plugin-root variable outside hooks). Whether reading `references/` prompts: unverified.
- **Preview**: the bundled `visualize` plugin renders a local HTML file inline in the desktop app (it writes the file and puts `visualize{"path":"<abs>"}` on its own line; a CDN allowlist applies); the in-app browser opens `file://` URLs. No private shareable page like an Artifact.
- **Google**: OpenAI's `google-drive` plugin (skills google-drive, google-docs, google-sheets, google-slides) over a ChatGPT connector; tools appear as `mcp__codex_apps__google_drive_*` (for example `_get_presentation`, `_batch_update_document`, `_import_document`). New decks go through a `presentations` runtime. Auth is the connector's OAuth. Detect by the tools present. A plugin's `apps` reference blocks an OpenAI directory submission, so vibebiz does not declare it.
- **Distribution**: `codex plugin marketplace add <owner/repo[@ref]|url>`, `codex plugin add vibebiz@finolabs`, updates with `codex plugin marketplace upgrade`. Catalog entries need `policy` and `category`. Pinning: add the plugin's own repository at its tag; whether a `url` entry takes a `ref` is unverified.
- **Headless**: `codex exec` (`--json`, `--output-schema`, `-C`, `--ephemeral`, `--ignore-user-config`) cannot answer questions; `codex app-server` exposes `turn/start` and a `item/tool/requestUserInput` server request, so a harness could answer them (unverified).

### Antigravity (agy 1.5.8; CLI, app)

- **Manifest**: `.antigravity-plugin/plugin.json` (precedence over a root `plugin.json`); only `name` required, the marketplace wants `displayName`, `description`, `version`, `logo`, `author`; `skills` adds folders to `skills/`; `suggestedPrompts` at most 3. `agy plugin validate --strict` warns about a root `AGENTS.md`.
- **Skills**: `name` kebab-case matching its folder, `description` up to 1,024 characters; invoked as `/<name>` with no plugin prefix; auto-trigger from the description. vibebiz's `help` meets the built-in `/help`; which wins is unverified.
- **Question tool** `ask_question`: `questions[]` (at least 1), options at least 2, "unnumbered and without an Other option; the UI adds both", `is_multi_select`, `write_in_response`, `skipped`. No maximums found. In print mode (`agy -p`) it is auto-answered with `skipped=true`.
- **Files**: Default preset sandboxes to the workspace and temp; outside needs approval, granted per folder. Plugins install read-only at `~/.gemini/config/plugins/<name>`. In `SKILL.md`, paths are relative to the skill folder.
- **Preview**: Artifacts panel in the app (plans, diffs, images); `/generative_ui` widgets (single HTML file, sandboxed, app only, not in the CLI); built-in browser for localhost in the app (not for business accounts; `file://` undocumented).
- **Google**: official `gdrive`, `gdocs`, `gslides`, `gsheets` plugins from `antigravity-plugins-official`. Each skill downloads and runs its own CLI with an Antigravity-managed Google sign-in, so the user's host needs a shell and network. `gdrive` also offers a `@drive` context. vibebiz hands off to these skills; it runs no script itself.
- **Distribution**: `agy plugin install https://github.com/<owner>/<repo>`; binary strings show GitHub-only installs with `--ref` and a subpath (unverified). Third-party catalogs are not supported; the official marketplace takes partners through an intake form (validate `--strict` clean, README, 128 px logo).
- **Headless**: `agy -p` with `--output-format json|stream-json`, `--input-format stream-json`, `--mode`, `--add-dir`; `agy acp` stdio server. Answering `ask_question` through stream-json or ACP is unverified.
- **Stale import**: Antigravity imported vibebiz 0.1.2 from Claude Code by itself (`~/.gemini/config/import_manifest.json`, 13/11/2026).

### Claude Code desktop

This development session (Claude Code in the desktop app) exposes an `Artifact` tool and Google Drive, Docs and Sheets connector tools (no Slides tool seen). Whether plugin skills reach them is unverified. vibebiz therefore decides by the tools present on Claude Code too.

**Decision** (Fio, 14/11/2026): parity on every host through its own tools, chosen by the tools present (spec Settled Decisions). **Rationale**: both new hosts have first-party Google Drive, Docs and Slides and a preview, so "Cowork only" was a choice, not a host limit. **Alternatives considered**: folder mode plus preview only, with Google on Codex and Antigravity deferred (smaller, no third-party dependency); Fio chose parity.
