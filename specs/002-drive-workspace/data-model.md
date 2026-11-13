# Data Model: Workspace on Google Drive

Extends spec 001's [data-model.md](../001-idea-to-prd/data-model.md). Every entity there is unchanged. This file adds only what Drive mode needs.

## Storage mode (per session, not stored)

| Value | Chosen when (in order) | Workspace root |
|---|---|---|
| `local` | the session has a user-chosen working folder | the folder, or its `vibebiz/` subfolder (as in 0.1.x) |
| `drive` | no local folder, and the Google Drive connector can search and create files | the Drive folder that holds a marked `index.json` |
| `none` | neither of the above | none: stop, write nothing (FR-003) |

The mode is decided once, at the start of each entry skill, and never changes during a run. A session never uses both modes.

## Drive workspace

Holds the same files as the local workspace ([contracts/drive-workspace.md](contracts/drive-workspace.md)), with three differences:

| Local file | Drive mode |
|---|---|
| `index.html` | replaced by `index.json` (data only) and a private Artifact that shows the table of contents |
| `specs/NNN-<slug>/exports/board-deck.html` | not written; a private Artifact, recorded in `links.md` |
| `specs/NNN-<slug>/exports/tech-prd.html` | not written; a private Artifact, recorded in `links.md` |

## `index.json` (Drive mode only)

The same object as the `vibebiz-data` JSON block in the local `index.html` (spec 001 data model, "Table of contents data"), with these fields added at the top level:

| Field | Type | Rule |
|---|---|---|
| `vibebiz` | string | always `"workspace"`; the marker discovery looks for (research R3) |
| `storage` | string | always `"drive"` |
| `toc_artifact` | string or null | the link to the private table-of-contents Artifact, once published |
| `shared_ack` | object or null | `{ "date": "YYYY-MM-DD", "who": ["<display names or 'link'>"] }` when the user confirmed using a shared folder (research R5); null otherwise |

Validation:
- `ideas[]` lists exactly the idea folders present, the same rule as local mode.
- The file is a plain file and is never a Google Doc (FR-007).
- `test_index.py` validates it against the same schema as the local block, plus the four fields above.

## File replacement (Drive mode write)

There is no in-place edit (research R2). A write is a sequence of states:

```
read (modifiedTime T0)
  → create new file with same title       [two files with one title]
  → read back new file, content matches
  → trash old file                        [one file]
```

- If the file's `modifiedTime` is no longer T0 when the write starts, stop and ask the user (concurrent edit).
- If a run is interrupted while two files share a title, the next run keeps the newer one only after it reads back, trashes the older one, and reports this. If neither reads back, both stay and vibebiz reports the duplicate.
- A trashed file is never permanently deleted by vibebiz.

## State impact

The idea lifecycle and the coverage states in spec 001 are unchanged. The storage mode does not change any status.
