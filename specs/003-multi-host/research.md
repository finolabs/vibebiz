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
