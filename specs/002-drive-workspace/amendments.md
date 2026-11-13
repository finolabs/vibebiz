# Amendments for spec 002 (Drive workspace)

Drafts from T017. Fio approved both on 13/11/2026; they are applied in the Phase 3 pull request.

## A1. Constitution 1.1.0 → 1.2.0 (MINOR)

**Why MINOR:** the change expands guidance, adding a declared storage variant and a connector to the target runtime. It removes and redefines no principle.

**Runtime and Distribution Constraints**, replace the first and third bullets:

```text
- Target runtime is Claude Cowork with its native question tool, Claude Artifacts, the Google
  Workspace connectors for Docs and Slides, and the Google Drive connector, which holds the
  workspace when a session has no local folder (Cowork on the web or a phone).
- The user workspace layout and file names defined in `CLAUDE.md` are a public contract. A change
  to the local layout is a breaking change for existing users and MUST bump the plugin's MAJOR
  version. Drive mode is a declared variant of that layout; its differences are listed in
  `specs/002-drive-workspace/contracts/drive-workspace.md`, and any other difference is a change
  to the contract.
```

**Sync Impact Report** (an HTML comment at the top of the constitution):

```text
Version change: 1.1.0 → 1.2.0 (MINOR)
Modified sections: Runtime and Distribution Constraints (target runtime adds the Google Drive
  connector; the MAJOR-bump rule covers the local layout, Drive mode is a declared variant)
Added sections: none
Removed sections: none
Follow-up: CLAUDE.md "Plugin shape" and "Workspace and outputs" (A2)
```

`Last Amended` becomes the date of approval.

## A2. CLAUDE.md

**"Plugin shape"**, replace the bullet about claude.ai chat:

```text
- Installed plugins also load in claude.ai chat and in Cowork on the web or a phone, which have no local folder. Every entry skill picks its storage first: a local folder, then Google Drive through Cowork's connector, otherwise it writes nothing and names both ways forward (`core/workspace.md` §1).
```

**"Workspace and outputs"**, add after the first bullet:

```text
- Drive mode keeps the same layout in a Drive folder the user chooses, with the differences listed in `specs/002-drive-workspace/contracts/drive-workspace.md`: `index.json` instead of `index.html`, and the board and tech views as private Artifacts only. vibebiz never shares or changes the visibility of a Drive file.
```

## Status

| Draft | Status |
|---|---|
| A1 | approved by Fio 13/11/2026, applied |
| A2 | approved by Fio 13/11/2026, applied |
