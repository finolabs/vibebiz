# Decisions: {{Idea title}}

<!--
  Append-only record (data-model.md "Decision"). Never edit or delete an
  entry; replace it with a new entry of type `supersede` that names the old id.
  Ids are D-001, D-002, ... and are never reused. Dates are YYYY-MM-DD.
  Field names and enum values stay in English; text, reason and notes are in
  the idea's language.

  type:
    answer               a decision the user made in a question round
    dismissed-risk       a risk the user chose to accept (never delete it)
    board-outcome        the board's decision on a presented export version
    tech-review          the tech team reviewed the estimates
    ground-rule-conflict the idea conflicts with constitution.md
    supersede            replaces an earlier decision (fill `supersedes`)

  Entry format (copy below the last entry; leave optional fields out when
  they do not apply):

  ## D-### — <short title>

  - date: YYYY-MM-DD
  - type: answer | dismissed-risk | board-outcome | tech-review | ground-rule-conflict | supersede
  - text: <what was decided>
  - reason: <why>
  - supersedes: <D-### or omit>
  - export_version: <exports/history folder name; board-outcome only>
  - outcome: approved | rejected | needs-changes   (board-outcome only)
  - notes: <anything else>
-->

Every decision about this idea, oldest first. Nothing here is ever deleted.
