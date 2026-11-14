# Implementation Plan: Install from the catalog on Claude Code, Codex and Antigravity

**Branch**: `003-multi-host` | **Date**: 2026-11-14 | **Spec**: [spec.md](spec.md)

**Input**: Feature specification from `specs/003-multi-host/spec.md`

## Summary

A release tag of vibebiz must install as a working plugin on Claude Code, Codex and Antigravity, from the repository root, with no build on the user's side, and vibebiz must work at parity with Cowork on each host through that host's own tools (Fio, 14/11/2026): folder and Drive workspaces, Google Slides and Docs, the views in the host's preview, and questions through the host's question tool. Following the organization's pattern (vietnamizer, agybird), the built skills are tracked in `.plugin-skills/`, every host manifest points there, and the source skills move to `src/skills/`; a check keeps the copy current. The modules choose every path by the tools present (contracts/host-capabilities.md), Drive operations are named by role and mapped per host, and each release records real runs on every host before the catalog entry.

## Technical Context

**Language/Version**: Markdown instructions (skills and `core/` modules); Python 3.10+ standard library for development scripts and checks (unchanged).

**Primary Dependencies**: none at runtime (constitution Principle IV). Hosts: Claude Cowork, Claude Code 2.1.325, Codex CLI 0.167.2, Antigravity 1.5.8 (versions on the development machine, 14/11/2026).

**Storage**: the user's local workspace folder; Drive mode unchanged and Cowork-only.

**Testing**: `scripts/checks/` (unittest), `claude plugin validate .`, the workspace and package eval suites (`claude plugin eval`), and recorded manual or scripted runs on Codex and Antigravity (research R6).

**Target Platform**: Cowork (desktop, web, phone); Claude Code, Codex and Antigravity in local folder mode.

**Project Type**: skills-only agent plugin.

**Performance Goals**: not applicable.

**Constraints**: no runtime scripts or shell (Principle IV); the workspace layout and file names do not change (public contract); `vibebiz.plugin` for Cowork keeps its content (FR-008); the description stays 120–160 characters and identical across the three manifests and the catalog.

**Scale/Scope**: six entry skills; about 425 generated files (6.5 MB) in `.plugin-skills/`.

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.* Checked against constitution 1.4.0 (amended on this branch, Fio approved 14/11/2026).

| Principle | Result |
| --- | --- |
| I. Non-technical user first | Pass. Questions go through the host's question tool with the same rules; the new messages for Cowork-only features are plain Vietnamese. |
| II. Spec Kit compatibility | Pass. Exports unchanged. |
| III. Evidence over agreement | Pass. No change to lenses or packaging rules. |
| IV. Self-contained runtime | Pass. Instructions and file operations only; Antigravity's Google plugins run their own CLI as the user's connector, used through their skills; vibebiz ships and runs no script. |
| V. Eval-proven behavior | Pass with work: the stale-copy check starts from a failing test; each instruction change starts from a failing eval case where one can run headless (Claude Code); Codex and Antigravity runs are recorded per release as Principle V now requires. |
| VI. Clean repository | **Exception**, see Complexity Tracking: generated files are tracked. They are repository-required outputs with a drift check, not incidental build outputs. |
| VII. Docs ship with behavior | Pass with work: README pair, `docs/`, `help`'s map and the example change in the same pull request. |
| Workflow: Spec Kit tooling never ships | **Exception**, see Complexity Tracking: an install from the repository root copies `.specify/` and `.claude/skills/speckit-*`. No host loads them as plugin skills. |

Post-design re-check (after Phase 1): unchanged; both exceptions remain justified.

## Project Structure

### Documentation (this feature)

```text
specs/003-multi-host/
├── plan.md
├── research.md
├── data-model.md
├── quickstart.md
├── contracts/
│   ├── install-layout.md
│   └── host-capabilities.md     # capability map and path choice per host
├── checklists/requirements.md
└── tasks.md             # /speckit-tasks, not created here
```

### Source Code (repository root)

```text
.claude-plugin/plugin.json        # skills: ./.plugin-skills/  (Claude Code, Cowork)
.codex-plugin/plugin.json         # new; same name, version, description, keywords
.antigravity-plugin/plugin.json   # new; same fields
.plugin-skills/<skill>/           # generated, tracked: SKILL.md + references/{core,templates,packs}
                                  # (+ references/{docs,examples} for help)
src/skills/<skill>/SKILL.md       # source skills, moved from skills/
core/  templates/  packs/  docs/  examples/   # unchanged sources
scripts/build_plugin.py           # reads src/skills; new --check-skills / write of .plugin-skills
scripts/checks/test_build.py      # stale-copy and manifest-agreement tests
scripts/checks/test_docs_map.py   # path moves to src/skills
evals/RESULTS.md                  # per-host install and run records
```

**Structure Decision**: one repository; the repository root at a tag is the installable plugin (contracts/install-layout.md). `dist/vibebiz/` and `vibebiz.plugin` are still built for the Cowork release archive, from the same generator, so both outputs share one code path.

## Phase 0: Research

Done: [research.md](research.md) (R1 sources per host, R2 layout, R3 no exclude list, R4 question tools, R5 user-facing changes, R6 proof of install). No NEEDS CLARIFICATION remains; two facts are left to measure at the first install (question-tool limits on Codex and Antigravity, and `agy plugin install` from a GitHub URL).

## Phase 1: Design

- [data-model.md](data-model.md): no change to the workspace; entities are the generated copy and the manifests.
- [contracts/install-layout.md](contracts/install-layout.md): what a tag holds, what the generator writes, what the check enforces.
- [contracts/host-capabilities.md](contracts/host-capabilities.md): what each host supports and what vibebiz says on a host without a feature.
- [quickstart.md](quickstart.md): install and run checks per host, and the catalog step.

## Order of work

See [tasks.md](tasks.md): measure first (Phase 1, with a stop rule before Drive work), then the installable layout, the Claude Code MVP, host-neutral instructions, the folder journeys on Codex and Antigravity, Drive, Slides and Docs, views, docs, and the release with per-host records before a fresh catalog pull request (the `list-vibebiz` branch is superseded).

## Complexity Tracking

| Violation | Why Needed | Simpler Alternative Rejected Because |
|-----------|------------|-------------------------------------|
| VI: generated files tracked (`.plugin-skills/`, about 6.5 MB) | Every host installs the repository at a tag; only built skills work, and no host builds | A separate distribution repository ships a clean tree, but adds a second repository and a push to every release; Fio chose the tracked layout (14/11/2026) |
| Workflow: `.specify/` and `.claude/skills/speckit-*` reach users' install folders | No host honors an exclude list (research R3), so a root install copies everything tracked | Same as above; the folders are inert in an installed plugin, and moving Spec Kit tooling out of the repository would break the development workflow |
