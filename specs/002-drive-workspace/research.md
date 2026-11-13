# Research: Workspace on Google Drive

**Feature**: [spec.md](spec.md) | **Date**: 2026-11-13

**Evidence base**: on 13/11/2026 I read the tool schemas of the Google Drive connector that Claude desktop exposes in this development session. They are the tool descriptions only. I made no call against a real Drive. Cowork is assumed to use the same Anthropic-hosted connector. That assumption stays unproven until the release smoke test runs in a real Cowork web session. Fio chose on 13/11/2026 not to run a gate before building. Each finding below is labelled **schema** (read from the tool description) or **to verify** (checked in the release smoke test).

## R1. Connector capabilities

- **Decision**: build on the schema findings below. The nine connector checks in [quickstart.md](quickstart.md) "Connector checks" open the release smoke test; if a *required* one fails, v0.1.2 is not cut and the result goes back to Fio.
- **Schema findings**:
  - `create_file` creates folders (`application/vnd.google-apps.folder`, `parentId`). It creates plain files from `textContent` with `contentMimeType`. With `disableConversionToGoogleType: true` the file stays plain. Without that flag, `text/plain` and `text/markdown` turn into Google Docs. FR-007 depends on this flag.
  - `create_file` also takes `base64Content` as a reference to a local file (`sha256:<hex>:<absolute path>`). The app reads the file once the user approves the call. If Cowork supports this, a file built in the session VM could be uploaded without being retyped (to verify).
  - **`update_file` changes metadata only** (title, parent, starred, lock, description). It cannot replace a file's content. The connector has no call that edits a file in place.
  - `read_file_content` reads `text/*`; `application/json` is not in its list. `download_file_content` exists for other types (to verify).
  - `search_files` supports `title =`, `parentId =`, `mimeType`, `fullText contains`, `trashed`, `owner = 'me'` and `visibility` (`'limited'` means not shared through a link, the domain or the public).
  - `get_file_permissions`, `get_file_metadata` (with `modifiedTime` and `etag`), `copy_file`, `trash_file` and `list_file_revisions` exist.
  - `share_file` exists. vibebiz never calls it (FR-012).
- **Alternatives considered**: a Drive desktop sync folder opened as a local folder. Rejected because it does not help web or phone users, who are the reason for this feature.

## R2. Replacing a file's content (consequence of R1)

- **Decision**: vibebiz changes the content of a Drive file by replacing it, in four steps:
  1. Read the file's `modifiedTime`.
  2. Create the new content as a new plain file with the same title in the same folder.
  3. Confirm that the new file exists and that its content reads back.
  4. Move the old file to the Drive trash.
  If the `modifiedTime` changed between the read and the write, someone else edited the file: stop and ask the user before replacing anything (spec edge case on concurrent writes).
- **Rationale**: this is the only way to write new content with the tools R1 lists. Trash is recoverable for 30 days, and Drive keeps the old file there, so a failed replace loses nothing. Two files with one title can exist only between steps 2 and 4. The next run repairs that: keep the newer file once its content reads back, and report the duplicate rather than guess (spec edge case).
- **Alternatives considered**:
  - Updating a file in place: the connector has no tool for it.
  - Using Google Docs as storage: breaks FR-007 and the Spec Kit handoff.
  - One file per record: breaks the fixed file names.
- **Cost**: a question round writes about four files (coverage, spec, the record it changed, the table-of-contents data). That is about four creates and four trashes per round. Cowork may ask the user to approve each connector call (to verify, connector check 8). If it does, the docs must explain "Always allow" for the Drive connector.
- **Constitution note**: the "never delete or overwrite a Google file" rule in `core/package.md` covers the Slides and Docs files that were presented. It is unchanged. Workspace files are vibebiz's own records, and replacing them through the trash is how they are updated. The module states this boundary in writing.

## R3. Finding the workspace again (FR-004, FR-005)

- **Decision**: the Drive workspace keeps its table-of-contents data in a plain file named `index.json` at the workspace root. The file holds the same JSON as the `vibebiz-data` block of the local `index.html` and carries `"vibebiz": "workspace"`. Discovery works like this:
  1. Search for `title = 'index.json' and trashed = false and owner = 'me'`.
  2. Read each result.
  3. Keep the ones that carry the marker.
  4. If there is none, ask the user for a folder, as in spec Story 1.
  The workspace is identified by the file, so moving or renaming its folder does not matter.
- **Rationale**: a fixed file name makes the search exact and cheap. Reading only that file's content satisfies FR-014.
- **Alternatives considered**:
  - Searching for `constitution.md`: the user might have a file with that name for other reasons, and the file can be deferred.
  - Remembering the folder ID somewhere: there is nowhere outside Drive to keep it across devices.
- **Contract impact**: `index.json` is a new file, used only in Drive mode. It goes into `contracts/workspace-files.md` (spec 001) as a Drive-mode row. The local workspace is unchanged.

## R4. Plain files and types (FR-007)

- **Decision**: every create uses `disableConversionToGoogleType: true`. `.md` files use `contentMimeType: text/markdown` and `.json` files use `application/json`. If connector check 4 shows that `application/json` cannot be read back, `.json` files use `text/plain` and keep their `.json` title. A file whose type became a Google type counts as the user's own file and is reported, never rewritten (spec edge case).
- **Rationale**: a tech team must be able to download the folder and get Spec Kit files (SC-006).

## R5. Privacy check (FR-012 to FR-014)

- **Decision**: before the first write into a chosen folder, read `get_file_permissions` on that folder and on each folder above it up to My Drive. Also read `get_file_metadata` to see whether it sits in a shared drive. Anyone other than the user, or any link or domain visibility, means "shared": tell the user who can see the ideas and continue only on their yes. Record the yes in the table-of-contents data (`shared_ack` with a date), so the warning does not repeat every session. Repeat the check when the sharing set has changed since that date.
- **Rationale**: vibebiz changes no sharing, but the user should know who can read a board-level idea.
- **Alternatives considered**: refusing shared folders outright. Rejected because a director may deliberately keep ideas in a team folder.

## R6. Choosing the storage mode (FR-001 to FR-003)

- **Decision**: §1 of `core/workspace.md` checks, in order:
  1. a local working folder, which gives local mode as in 0.1.1;
  2. otherwise, a Google Drive connector that can search and create, which gives Drive mode;
  3. otherwise, the new two-way message.
  A read-only connector, meaning a create fails with a permission error, gets the same stop with its own sentence.
- **Rationale**: this matches Fio's decision that the local folder wins and the two workspaces never sync.

## R7. Table of contents and export views in Drive mode (FR-009, FR-010)

- **Decision**: in Drive mode the table-of-contents data lives only in `index.json`. After every write, vibebiz shows the table of contents as a private Artifact. It renders that Artifact from `templates/workspace/index.html` with the JSON block replaced, publishes it, and updates it at the same link when the platform allows. When the session has a shell, the splice is a one-off command, as in `core/package.md` step 4. Without a shell, vibebiz shows a short Markdown table in the chat and skips the Artifact.
  The board deck and tech PRD follow the same rule. They are published as private Artifacts and are never written to Drive. `links.md` records the Artifact links.
- **Rationale**: Fio's decisions of 13/11/2026. A connector parameter cannot carry a 20–190 KB fixed template faithfully.
- **To verify** (connector checks 7 and 8): whether a Cowork web session has a shell, and whether it can publish and update a private Artifact.

## R8. Export history in Drive (spec Story 3, scenario 2)

- **Decision**: before a re-package, create `exports/history/<date>/` and `copy_file` each current export file into it. The board deck and tech PRD are not files in Drive, so their earlier Artifact links are already recorded in the old `links.md`, which is copied too.
- **Rationale**: copying is a single server-side call, so no content has to be retyped.

## R9. Evals without a real Drive (FR-017)

- **Decision**: add a small development-only stdio MCP server, `evals/fake-drive/server.py`, written with the Python standard library. It exposes the tools from R1 (`search_files`, `read_file_content`, `download_file_content`, `create_file`, `copy_file`, `trash_file`, `get_file_metadata`, `get_file_permissions`, plus `update_file` and `share_file` so that a forbidden call is visible), with the same names and parameters, stored in a temporary folder. It logs every call to `.calls.jsonl`, so graders can prove which tools were and were not called (FR-012, FR-014). It has fixture modes for:
  - an empty Drive;
  - one workspace;
  - two workspaces;
  - a read-only Drive;
  - a shared folder;
  - a converted file;
  - a shared drive;
  - a full Drive;
  - a workspace written by a newer version.
  The `claude plugin eval` cases for the Drive mode load it through the eval's MCP configuration. Graders inspect the fake Drive's folder, so the existing structural checks (`test_workspace`, `test_index`) can run on it.
- **Rationale**: the real connector cannot run in headless evals. If T001 finds that an eval case cannot load an MCP server, the feature stops and Fio decides between a minimal Agent SDK harness and smoke-test-only coverage; `evals/persona/` does not exist yet. A fake with the same tool names exercises the module's instructions. The real connector is covered by the release smoke test.
- **Risk**: the fake can drift from the real connector. To limit that, the fake's tool list carries the date of the schema read, and the smoke test records any difference it finds.
- **Constitution IV**: the fake lives in `evals/` and never ships, the same as `scripts/`.

## R10. Messages to the user

- **Decision**: the new no-folder message for web and phone sessions without Drive names both ways forward:
  - **Vietnamese** (default form of address, `core/writing-rules.md` §4): "Phiên này không mở được thư mục nào trên máy tính, và chưa nối Google Drive, nên em chưa ghi gì. Anh/chị chọn một trong hai cách: nối Google Drive trong phần Connectors của Cowork rồi gõ lại lệnh này, ý tưởng sẽ được lưu trong một thư mục Drive anh/chị chọn; hoặc mở ứng dụng Claude trên máy tính, vào Cowork, chọn một thư mục làm việc."
  - **English**: an equivalent sentence.
  vietnamizer edits the Vietnamese before release.
- **Rationale**: FR-003 and spec Story 4.

## R11. Version

- **Decision**: v0.1.2 (Fio, 13/11/2026). The CHANGELOG lists Drive mode under Added. The constitution rule that a change to the workspace layout bumps MAJOR (Runtime and Distribution Constraints) does not fit a new storage mode that leaves the local layout untouched. A constitution amendment that clarifies this is in the plan (amendment task) and needs Fio's yes. Until he approves it, the Constitution Check records the tension in Complexity Tracking.
