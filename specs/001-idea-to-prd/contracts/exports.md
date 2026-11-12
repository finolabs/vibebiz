# Contract: Exports

## `exports/data.json`

The single source for every output format (research R4). Top-level keys:

- `idea`: `id`, `title`, `language`, `version` (export date folder), `draft` (boolean), `estimate_status`.
- `board`: ordered `slides[]`, each `{n, title (the takeaway), message, source_fields[], blocks[], diagram (brief id or null), frameworks[]}` following spec Appendix D slides 1–9 plus appendix.
- `tech`: ordered `sections[]`, each `{id, heading, source_fields[], content}`: business context, user stories, requirements, key entities, success criteria, AI fit, non-functional needs, glossary, open questions (blocking, non-blocking).
- `numbers[]`: every figure used anywhere, `{id, value, unit, source, period, label (measured | assumed)}`; slides and sections reference figures by `id` only, so both views show the same value.
- `gaps[]`: fields shown as "not yet clarified".
- `links`: Artifact, Slides and Docs URLs.

**Package check** (code, development and eval): every Appendix D slide and tech section present or listed in `gaps`; every figure referenced by id exists and carries source, period and label; slide titles non-empty and one message per slide; every chart block names a source; `estimate_status` label present on estimate figures when `not-tech-reviewed`; `links.md` matches `links`.

## `board-deck.html` and `tech-prd.html`

Fixed templates with one `<script type="application/json" id="vibebiz-data">` block holding `data.json` and an inline renderer. The same file is published as a private Artifact and updated at the same link on re-packaging. Diagrams are embedded SVG from the rendered briefs; without diagram-design, a table with a "no diagram" note.

## Google Slides and Docs

Written through Cowork's connectors from the same `data.json`: one slide per `board.slides[]`, one heading per `tech.sections[]`. Images only when insertable without a public URL; otherwise a table plus the Artifact link. Created in the user's Drive; never shared by vibebiz.

## Snapshot (`exports/spec.md`)

A copy of the idea's `spec.md` at packaging time. Structure:

```
# Feature Specification: <title>
**Feature Branch** / **Created** / **Status** / **Input** lines
## Problem & Why            (vibebiz)
## Outcome                  (vibebiz)
## Alternatives             (vibebiz)
## AI-fit                   (vibebiz, when AI is involved)
## Cost & Risk              (vibebiz)
## Clarifications           (Spec Kit clarify format)
## User Scenarios & Testing *(mandatory)*     (Spec Kit 1.4.0, heading unchanged)
## Requirements *(mandatory)*                 (Spec Kit 1.4.0, heading unchanged)
## Success Criteria *(mandatory)*             (Spec Kit 1.4.0, heading unchanged)
## Assumptions                                (Spec Kit 1.4.0, heading unchanged)
```

Subheadings of the Spec Kit sections (`### User Story N - … (Priority: Pn)`, `### Functional Requirements`, `### Key Entities`, `### Measurable Outcomes`, `### Edge Cases`) and the `FR-###` / `SC-###` id formats match the pinned template. Content may be in any language; headings stay as above.
