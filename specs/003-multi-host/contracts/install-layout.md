# Contract: Install layout

## What a release tag holds

At every tag on `main`, the repository root is an installable plugin for Claude Code, Codex and Antigravity:

- `.claude-plugin/plugin.json`, `.codex-plugin/plugin.json`, `.antigravity-plugin/plugin.json`, agreeing on the fields in `data-model.md` "Host manifest", each with `"skills": "./.plugin-skills/"`.
- `.plugin-skills/<skill>/` for the six entry skills, current (`data-model.md`).
- No folder named `skills/` at the root (Claude Code and Antigravity would load it in addition to `.plugin-skills/`).

Everything else in the repository also lands in the install folder (research R3) and is inert: no host loads skills, hooks or MCP servers from it. The repository MUST NOT gain a root `hooks/`, `.mcp.json`, `agents/`, `commands/` or `bin/` folder or file, since hosts load those from the plugin root (a `bin/` folder is rejected by claude.ai and Cowork).

## Generator

`scripts/build_plugin.py` owns one function that lays out a skill tree from `src/skills/`, `core/`, `templates/`, `packs/`, `docs/` and `examples/`. It writes:

- `.plugin-skills/` in the repository (tracked), and
- `dist/vibebiz/` and `dist/vibebiz.plugin` for the Cowork release archive (ignored), whose `skills/` holds the same tree.

## Check

A test fails, naming each path, when:

- a file under `.plugin-skills/` differs from the generator's output, or is missing, or is extra;
- the three manifests disagree on any shared field, the description is outside 120–160 characters, or a manifest's `skills` is not `./.plugin-skills/`;
- a root `skills/` folder exists;
- the version differs between a manifest and `templates/workspace/index.json`.

## Release

A release pull request regenerates `.plugin-skills/`, bumps the three manifests and the template version together, and records the per-host install rows (`data-model.md` "Install record") after the tag exists. The catalog pull request in `finolabs/plugins` follows the recorded rows.
