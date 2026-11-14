# Data Model: Install from the catalog on Claude Code, Codex and Antigravity

The user workspace does not change: same layout, file names and `index.json`/`index.html` rules as 0.1.4 (`specs/001-idea-to-prd/contracts/workspace-files.md`, `specs/002-drive-workspace/contracts/drive-workspace.md`). `templates/workspace/index.json` keeps recording `plugin_version`, which becomes 0.1.5.

## Generated skill copy (`.plugin-skills/<skill>/`)

- One folder per entry skill: `idea`, `continue`, `status`, `package`, `constitution`, `help`.
- Holds `SKILL.md` (copied from `src/skills/<skill>/`) and `references/core/`, `references/templates/`, `references/packs/`; `help` also holds `references/docs/` and `references/examples/`.
- Never edited by hand; written only by the generator. State: **current** (byte-identical to what the generator would write) or **stale** (any difference, missing or extra file). A stale copy fails the checks.

## Host manifest

| Field | Rule |
| --- | --- |
| `name` | `vibebiz` in all three |
| `version` | identical in all three and in `templates/workspace/index.json` |
| `description` | identical, 120–160 characters |
| `keywords` | identical list |
| `skills` | `./.plugin-skills/` in all three |
| license, homepage, repository | identical where the host's schema has the field |

Files: `.claude-plugin/plugin.json`, `.codex-plugin/plugin.json`, `.antigravity-plugin/plugin.json`. The Codex manifest also carries its `interface` block (display name, category, links), as finolabs-vibecode's does.

## Install record (`evals/RESULTS.md`)

One row per host per release: date, host and version, install command and source (catalog entry or repository URL at the tag), result, and the example run's result (package check, Spec Kit compatibility check). The catalog entry is proposed only after all three rows pass (FR-011).
