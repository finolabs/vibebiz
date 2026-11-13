# Contract: Drive Workspace

Extends spec 001's [workspace-files.md](../../001-idea-to-prd/contracts/workspace-files.md). The local workspace contract is unchanged.

```
<user-chosen Drive folder>/
  index.json                     table-of-contents data + marker + plugin_version (data-model "index.json")
  constitution.md
  specs/NNN-<slug>/
    spec.md  coverage.md  plan.md  decisions.md  assumptions.md
    open-questions.md  glossary.md
    checklists/board.md  checklists/tech.md
    diagrams/NN-<name>.brief.md  (+ rendered .svg when diagram-design ran)
    exports/
      spec.md  data.json  links.md
      history/YYYY-MM-DD/        copies of the previous export set
```

**Rules** (in addition to the local rules, which all hold):

- Names, layout and slug rules are identical to the local workspace, with exactly three differences (detail in [data-model.md](../data-model.md) "Drive workspace"): `index.json` replaces `index.html`, and `exports/board-deck.html` and `exports/tech-prd.html` are never written (the board and tech views are private Artifacts or, at the user's choice, private Google Slides and Docs).
- Every file is a plain file created with conversion to Google types turned off. `.md` files are `text/markdown`; `.json` files are `application/json`, or `text/plain` if research R4 shows that type cannot be read back.
- Content changes go through a file replacement ([data-model.md](../data-model.md) "File replacement"). Nothing is updated in place, and nothing is deleted permanently.
- vibebiz never calls the connector's sharing tool, never changes a file's visibility or parent folder outside the workspace, and never reads file content outside the workspace, except the `index.json` search.
- Google Slides and Docs that `package` creates follow spec 001's existing rules: they live in the user's Drive, are private, are never overwritten, and each version gets a new file.

## Entry-skill behavior by storage mode

| Skill | `local` | `drive` | `none` |
|---|---|---|---|
| `idea` | as 0.1.x | find or choose the workspace (FR-005), privacy check (FR-013), scaffold missing pieces, create the idea | stop, two-way message |
| `continue` | as 0.1.x | find the workspace; resume | stop, two-way message |
| `status` | as 0.1.x | find the workspace; answer from `index.json` and `coverage.md` | stop, two-way message |
| `package` | as 0.1.x | write `data.json`, `spec.md` and `links.md`; publish the board and tech views as private Artifacts (or Slides/Docs); copy the old set to history | stop, two-way message |
| `constitution` | as 0.1.x | find the workspace; write `constitution.md` | stop, two-way message |
| `help` | no workspace needed | no workspace needed | no workspace needed |
