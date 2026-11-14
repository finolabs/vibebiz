<!--
Sync Impact Report
Version change: 1.3.0 → 1.4.0 (MINOR)
Modified sections: Principle IV and Runtime and Distribution Constraints: Claude Code, Codex and
Antigravity move from local folder mode only to parity with Cowork through each host's own tools
(Drive workspace, Google Slides and Docs, the host's preview); vibebiz picks each path by the
tools present; a host integration that runs its own tools is the user's connector.
Earlier on 14/11/2026, 1.2.1 → 1.3.0 (MINOR): Principle I (the host's question tool), IV (other
hosts supported), V (a recorded install and run on every other supported host), Runtime
constraints.
Added sections: none
Removed sections: none
Follow-up: CLAUDE.md "Plugin shape" and "Workspace and outputs" follow in the spec 003
implementation (tasks T028); README pair, docs and help follow there too. Fio approved both
amendments on 14/11/2026.
-->
# vibebiz Constitution

## Core Principles

### I. Non-Technical User First

vibebiz serves retail business leaders who do not write code and never open a terminal.

- Everything a user reads (questions, outputs, docs, `README.vi.md`) MUST be plain Vietnamese.
  A technical term MUST be explained the first time it appears.
- Every decision put to the user MUST go through the host's native question tool (Cowork's
  `AskUserQuestion` or its equivalent on another supported host): at most four
  questions per round, two to four mutually exclusive options, the recommended option first,
  and each question understandable without the surrounding text. Only open-ended questions use
  plain text.
- The agent MUST look up facts itself; only decisions go to the user.
- Answers MUST be written to the idea's files after every round, so an abandoned session loses
  nothing. A session MUST respect its question budget and then offer to continue, pause or
  export a draft.

Rationale: an impatient, non-technical user abandons a long or jargon-heavy interview; the
product fails the moment that happens.

### II. Spec Kit Compatibility by Contract

The tech-team handoff is a file format, not a tool dependency.

- An exported `spec.md` MUST keep Spec Kit's mandatory sections (User Scenarios & Testing,
  Requirements, Success Criteria, Assumptions) identical in name and structure, so `speckit-plan`
  runs on it without edits. Business sections MUST be added before them, never in their place.
- Ported content (templates, the `clarify` coverage taxonomy, specification writing rules) MUST
  come from the pinned upstream version, currently Spec Kit 1.4.0. `UPSTREAM.md` MUST list which
  sections are upstream and which are vibebiz's own.
- Spec Kit's mechanics (scripts, git branches, hooks, extensions) MUST NOT be ported.
- vibebiz MUST describe itself as compatible with Spec Kit and MUST NOT use Spec Kit as branding.

Rationale: the tech team's process stays untouched, and an upstream upgrade stays a diff.

### III. Evidence Over Agreement

vibebiz exists to sharpen an idea, not to flatter it.

- The `challenge` lens MUST NOT praise an idea, MUST give at least one reason the idea could be
  wrong per round, and MUST weigh "do nothing" and "fix the process" before build is allowed.
- A risk the user dismisses MUST be recorded in `decisions.md`, never deleted.
- Every number in a spec or export MUST carry its source, period and a measured or assumed label.
  A missing baseline MUST become a measurement plan, never an invented figure.
- Packaging MUST NOT add facts. A missing field MUST appear as "not yet clarified". Every slide
  or section MUST trace to a field in the idea folder, and numbers MUST match across views.
- Estimates MUST carry "not tech-reviewed" until the tech review is recorded.

Rationale: the board decides on these documents; an unsupported claim costs real money.

### IV. Self-Contained Runtime

The plugin runs with nothing but its own files and the user's connectors. Claude Cowork is the
primary runtime; Claude Code, Codex and Antigravity are supported at parity with it, each
through its own tools.

- Runtime behavior MUST be instructions and file operations; skills MUST NOT require scripts,
  hooks or a shell on the user's machine. A host integration that runs its own tools (for
  example Antigravity's Google plugins) is a user connector, used through that host's skills or
  tools, never shipped or scripted by vibebiz.
- The plugin MUST NOT depend on, import or reference `finolabs-vibecode` or any of its skills.
- `diagram-design` is a companion plugin and MUST NOT be copied into this repository. When it is
  absent, exports MUST show a table with a "no diagram" note instead of a substitute drawing.
- `/vibebiz:idea` MUST NOT overwrite an existing user file; it repairs only missing pieces of the
  workspace contract.

Rationale: a non-technical user cannot debug a missing interpreter or a clobbered file.

### V. Eval-Proven Behavior

Skill behavior is code and is tested like code.

- A change to skill behavior MUST start from an eval case or fixture that fails for the reason
  the change addresses, and MUST end with that case passing.
- Structural properties (question counts, sections, cross-view numbers, index integrity, docs
  coverage) MUST be checked in code. Semantic judgments (claim support, meaning preservation,
  sycophancy) MAY use an approved evaluator such as Jev, never at plugin runtime.
- Each release MUST pass the agreed eval suites and a manual Cowork smoke test, and MUST record
  a real install from its tag and a run in a local folder on every other supported host.

Rationale: prompt behavior drifts silently; only a failing case proves a fix and guards it.

### VI. Clean Source-Available Repository

- The repository MUST NOT contain internal data: no real people, companies, customers or figures,
  and no organization's constitution or brand. Examples, vertical packs and eval fixtures MUST be
  fictional or built from public knowledge.
- vibebiz is source-available under PolyForm Noncommercial 1.0.0 with a separate commercial
  license; it MUST NOT be called open source. Contributions MUST be covered by the CLA.
  Third-party MIT notices (Spec Kit, `grilling`) MUST be kept in `THIRD_PARTY_LICENSES.md`.
- Repository structure, file and folder names, and instruction prompts MUST be in English.
- Secrets, env files and incidental build outputs MUST NOT be committed.

Rationale: the repository is a product Finolabs will sell; one leaked record or licence slip is
not reversible.

### VII. Docs Ship With Behavior

- A change to a command, skill, template or output MUST update, in the same change, every
  description of it: `README.md` and `README.vi.md`, `docs/`, the affected diagram briefs and
  renders, `help`'s situation map and the fictional example.
- `help` MUST answer only from the shipped docs and MUST say when the docs do not cover a question.
- Every command and skill MUST appear in `help`'s map and `docs/commands.md`, and those two
  places MUST NOT list anything that does not ship.

Rationale: users learn vibebiz from its docs and `help`; stale docs teach the wrong product.

## Runtime and Distribution Constraints

- Primary runtime is Claude Cowork with its native question tool, Claude Artifacts, the Google
  Workspace connectors for Docs and Slides, and the Google Drive connector, which holds the
  workspace when a session has no local folder (Cowork on the web or a phone).
- Claude Code, Codex and Antigravity are supported at parity with Cowork: the same six entry
  skills and workspace, the local folder and the Google Drive workspace, Google Slides and Docs,
  and the board and tech views in the host's preview, each through that host's own tools.
  vibebiz chooses every path by the tools present in the session, not by the host's name. Where
  a host has no equivalent (a private Claude Artifact), vibebiz uses its nearest one and says
  what differs; where a feature is not connected, it says how to connect it and offers the
  alternative.
- A release tag MUST install as a working plugin on every supported host with no build step on
  the user's side.
- Board view exports to an Artifact, the host's preview or Google Slides; tech view exports to an
  Artifact, the host's preview or Google Docs, always with the `spec.md` snapshot.
- The user workspace layout and file names defined in `CLAUDE.md` are a public contract. A change
  to the local layout is a breaking change for existing users and MUST bump the plugin's MAJOR
  version. Drive mode is a declared variant of that layout; its differences are listed in
  `specs/002-drive-workspace/contracts/drive-workspace.md`, and any other difference is a change
  to the contract.
- Business data stays in the user's workspace and Google Drive; the plugin sends it nowhere else.

## Development Workflow and Quality Gates

- Features are specified, planned and tasked with Spec Kit 1.4.0 in this repository. That tooling
  (`.specify/`, `.claude/skills/speckit-*`) is development-only and MUST NOT ship in the plugin.
- Every plan MUST pass the Constitution Check against this file before tasks are generated.
- Commits are atomic and verb-led; versions follow SemVer with a changelog entry per release.
- Every pull request needs a code review before merge; a change touching licensing, privacy or
  user data handling also needs a security and privacy review.
- Before a version is cut, everything that describes the product is reviewed against what ships
  (Principle VII), and the eval suites and smoke test pass (Principle V).
- Going public needs Fio's explicit approval. Fio approved publishing with v0.1.0 without a
  lawyer's review of the license, commercial terms and CLA (13/11/2026).

## Governance

- This constitution governs development of vibebiz. `CLAUDE.md` holds the detailed design and
  MUST NOT contradict it; a conflict is raised and resolved by amendment, not by picking one.
- An amendment needs Fio's approval, a version bump and an updated `Last Amended` date:
  MAJOR for removing or redefining a principle, MINOR for a new principle or materially expanded
  guidance, PATCH for clarifications.
- Reviews and plans check compliance; a justified exception is recorded in the plan's Complexity
  Tracking with its reason.

**Version**: 1.4.0 | **Ratified**: 2026-11-12 | **Last Amended**: 2026-11-14
