# Contract: Workspace Files

The user workspace is a public contract (constitution, Runtime and Distribution Constraints): changing a name or a required field after 1.0 is a MAJOR version change.

```
index.html                       fixed template + JSON block (data-model "Table of contents data")
constitution.md                  frontmatter per data-model "Ground rules"
specs/NNN-<slug>/
  spec.md                        idea requirement (template in contracts/exports.md "Snapshot")
  coverage.md                    frontmatter per data-model "Idea"; body: human table of A–O
  plan.md                        business plan; estimate_status mirrored from coverage
  decisions.md                   append-only D-### entries
  assumptions.md                 append-only A-### entries (only tested and evidence filled in later)
  open-questions.md              Q-### entries
  glossary.md                    term: plain-language meaning
  checklists/board.md            Definition of Ready for the board view
  checklists/tech.md             Definition of Ready for the tech view
  diagrams/NN-<name>.brief.md    plus rendered .html/.svg
  exports/
    board-deck.html  tech-prd.html  spec.md  data.json  links.md
    history/YYYY-MM-DD/          previous export sets
examples/000-<slug>/             same layout as an idea
```

**Rules**

- File and folder names are fixed and English; only `<slug>` varies, derived from the idea title without diacritics, lowercase, hyphenated.
- `new` on a partial workspace creates only missing files and reports them; it never overwrites.
- Hand edits by the user are authoritative: modules re-read files before writing and append rather than rewrite records.
- Every write ends with a table-of-contents rebuild from frontmatter; the JSON block lists exactly the idea folders present.
- No file outside the workspace is written, except Google files the user asked `package` to create in their Drive.
