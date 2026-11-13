# Quickstart: validating the Drive workspace

## Gate run (T001, before any other task)

Run this in a real Cowork session started on the web, with Google Drive connected, using a test Google account and a test folder with fictional content. It needs no vibebiz build: give each step to Cowork as a plain prompt. Record every result, with the tool name and what it returned, in `specs/002-drive-workspace/gate-run.md`. Leave out file IDs, account names and email addresses.

| # | Check | Required |
|---|---|---|
| 1 | The session lists Google Drive tools that match research R1 (search, read, create, copy, trash, metadata, permissions); record any difference | yes |
| 2 | Create a folder in My Drive and a plain `.md` file inside it with conversion off; Drive shows it as a Markdown file, not a Google Doc | yes |
| 3 | Read the `.md` file back; the content matches exactly, Vietnamese diacritics included | yes |
| 4 | Create `index.json` as `application/json`, then read it back; if that fails, try `text/plain` | yes (one of the two) |
| 5 | Search finds `index.json` by exact title in a new session, also after the folder is renamed | yes |
| 6 | Trash a file, then search with `trashed = false` and confirm it is gone | yes |
| 7 | The session can publish a private Artifact and update it at the same link | no (fallback: Markdown table in chat) |
| 8 | Whether the session has a shell; whether each Drive write asks the user for approval, and whether "Always allow" exists | no (shapes docs) |
| 9 | Repeat checks 2–6 in the Claude mobile app | no (phone support claim) |

**Stop rule**: if any required check fails, stop. Do not start T002 onward. Report the result to Fio.

## Development checks (every task)

Run only the checks for the files the task changes, one or two modules at a time:

```bash
python3 scripts/checks/test_workspace.py
```

```bash
python3 scripts/checks/test_index.py
```

```bash
python3 scripts/checks/test_build.py
```

```bash
python3 scripts/checks/test_docs_map.py
```

## Eval suites (FR-017)

Drive cases run against the fake Drive server (research R9). Run only the Drive tags and the existing workspace suite:

```bash
claude plugin eval . --tag drive --allow-tools Write Edit --ablation none --model sonnet --runs 1
```

```bash
claude plugin eval . --tag workspace --allow-tools Write Edit --ablation none --model sonnet --runs 1
```

Expected:
- Every Drive case passes: workspace found, none found, several found, no connector, read-only connector, shared folder, desktop with both available, replacement of a file that changed meanwhile, and package.
- Every 0.1.x workspace case still passes (SC-004).

## Release smoke test (before v0.1.2)

Use the built `vibebiz.plugin` in real Cowork, with a test account and fictional ideas:

1. **Web, Drive connected, no workspace.** Run `/vibebiz:new` with a one-line idea. Choose a new folder and answer one round. Check that the folder holds the contract files (contracts/drive-workspace.md) as plain files, and that the table of contents shows (Artifact or chat table). Covers SC-001.
2. **New web session (phone if possible).** Run `/vibebiz:status`, then `/vibebiz:continue`. Neither asks where the workspace is, and `continue` resumes at the next open question. Covers SC-002.
3. **Package from the web.** The board and tech Artifacts are private and their numbers match `exports/data.json`. Download the idea folder and run the Spec Kit compatibility check on `exports/spec.md`. Covers SC-006.
4. **Web without Drive.** Run each entry skill. Each writes nothing and gives the two-way message. Covers SC-003.
5. **Desktop with a local folder and Drive connected.** Run `new`. The workspace is local and nothing new appears in Drive. Covers SC-004.
6. **Sharing.** After the runs, search the test Drive for `visibility != 'limited'` among vibebiz files. Nothing is found. Covers SC-005.
