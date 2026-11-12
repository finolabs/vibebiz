# Contract: Exports

## `exports/data.json`

The single source for every output format (research R4). Top-level keys:

- `idea`: `id`, `title`, `language`, `version` (export date folder), `draft` (boolean), `estimate_status`.
- `board`: ordered `slides[]`, each `{n, title (the takeaway), message, source_fields[], blocks[], diagram (brief id or null), frameworks[]}` following spec Appendix D slides 1–9 plus appendix.
- `tech`: ordered `sections[]`, each `{id, heading, source_fields[], content}`: business context, user stories, requirements, key entities, success criteria, AI fit, non-functional needs, glossary, open questions (one section holding blocking and non-blocking questions).
- `numbers[]`: every figure used anywhere, `{id, value, unit, source, period, label (measured | assumed)}`; slides and sections reference figures by `id` only, so both views show the same value.
- `gaps[]`: fields shown as "not yet clarified".
- `links`: `board_artifact`, `tech_artifact`, `slides` and `docs` URLs.

**Package check** (code, development and eval): every Appendix D slide and tech section present or listed in `gaps`; every figure referenced by id exists and carries source, period and label; slide titles non-empty and one message per slide; every chart block names a source and a period; `estimate_status` label present on estimate figures when `not-tech-reviewed`; `links.md` matches `links`.

### data.json conventions

What `scripts/checks/package_check.py` and the export templates (`board-deck.html`, `tech-prd.html`) both rely on. Change one side only together with the other.

- **Top keys**: `idea`, `board`, `tech`, `numbers`, `gaps`, `links`; `diagrams` and `labels` are optional. `idea` has `id`, `title`, `language`, `version`, `draft`, `estimate_status` (`not-tech-reviewed` | `tech-reviewed`).
- **Slide ids**: `board.slides[].n` is 1 to 9, then `"appendix"`. Each slide has `title`, `message` (one message, no line break), `source_fields[]`, `blocks[]`, `diagram`, `frameworks[]`.
- **Section ids**: `tech.sections[].id` is `business-context`, `user-stories`, `requirements`, `key-entities`, `success-criteria`, `ai-fit`, `non-functional`, `glossary`, `open-questions` (one section for blocking and non-blocking questions; each question carries `blocking`). `assumptions` is optional. Each section has `heading`, `source_fields[]`, and `content`: an array of blocks, or a plain string shown as one paragraph.
- **Block types** (slide `blocks[]` and section `content[]`): `text`, `list`, `figures`, `chart`, `table`, `stories`, `defs`, `questions`, `gap`, and `framework` (`name`). The templates skip unknown types.
- **Figure tokens**: figures come only from `numbers[]`. Text writes a figure as `{{ID}}` (for example `{{N-01}}`); `figures` and `chart` blocks list them as `items[].ref`. An `items` entry may repeat `value` for the check to compare with `numbers[]` (the templates ignore it). Every figure has `id`, `value`, `source`, `period`, `label` (`measured` | `assumed`).
- **Estimates**: `numbers[].estimate: true` marks an estimate (`label: "assumed"` alone does not). While `estimate_status` is `not-tech-reviewed`, the templates show a "not tech-reviewed" badge on it, and the check requires `estimate_label: "not tech-reviewed"` on every slide, section or block that shows one (on the element or on its slide or section), so the Slides and Docs outputs carry the label too. Once `tech-reviewed`, no `estimate_label` may remain.
- **Charts**: a `chart` block needs a non-empty `source` and a non-empty `period` (the export guidelines require both).
- **Gaps**: `gaps[]` entries are a field name (string), `{field, slide}` or `{field, section}`. A required slide or section that is absent must appear in a `{field, slide}` or `{field, section}` entry; a gap never switches off the other checks on content that is present.
- **Frameworks**: `frameworks[]` entries are a name (string) or `{id, name, result}`; the name is never empty.
- **Links keys**: `links` has exactly `board_artifact`, `tech_artifact`, `slides`, `docs`; each is an https URL or `null`. `links.md` lists the same URLs.
- **Labels**: `labels` is optional, `{ "<key>": "<text>" }`, and overrides the templates' built-in English text for non-Vietnamese ideas only; for Vietnamese ideas it is ignored.
- **Diagrams**: `diagrams[]` entries are `{id, message, type, svg, fallback}`. `id` is the brief id named by `slide.diagram` or `section.diagram`; `svg` is rendered SVG markup or `null`; `fallback` is `{columns[], rows[][]}`, shown with a "no diagram" note when `svg` is `null`.
- **Sharing**: no `public`, `shared` or similar flag, and no `visibility: public`, anywhere in the file.

Optional presentation fields are listed by the templates (the comment at the top of each template), not here.

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
