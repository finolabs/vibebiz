---
# vibebiz idea state (data-model.md "Idea"). Values in {{double braces}} are
# placeholders the workspace module fills when it creates the idea folder.
id: "{{NNN}}"                     # three digits, matches the folder number
slug: "{{slug}}"                  # from the title, no diacritics, lowercase, hyphenated
title: "{{Idea title}}"
language: "{{vi}}"                # vi | en | other language code, set at intake
vertical: "{{vertical}}"          # defaults to the ground rules' vertical
cynefin: "{{complicated}}"        # clear | complicated | complex | chaotic; set by the router
status: clarifying                # clarifying | ready | packaged | presented | approved | rejected | needs-changes
estimate_status: not-tech-reviewed  # not-tech-reviewed | tech-reviewed; flips only on a recorded tech review
budget_rounds_used: 0             # question rounds used this session; reset at session start
latest_export: null               # date folder name under exports/ history, or null
next_step: "{{next step}}"        # short next action in the user's language; written by the router after every round
created: "{{YYYY-MM-DD}}"
updated: "{{YYYY-MM-DD}}"
# Each category: status clear | partial | missing | deferred; reason is
# required when status is deferred, null otherwise; prerequisites are fixed
# (spec Appendix A); frameworks lists applied card ids, at most two per lens.
categories:
  A:  # Problem and why
    status: missing
    reason: null
    prerequisites: []
    filled_by: problem-framing
    frameworks: []
    updated: "{{YYYY-MM-DD}}"
  B:  # Users and stakeholders
    status: missing
    reason: null
    prerequisites: [A]
    filled_by: problem-framing
    frameworks: []
    updated: "{{YYYY-MM-DD}}"
  C:  # Outcome and measurement
    status: missing
    reason: null
    prerequisites: [A]
    filled_by: outcome
    frameworks: []
    updated: "{{YYYY-MM-DD}}"
  D:  # Alternatives
    status: missing
    reason: null
    prerequisites: [A, C]
    filled_by: challenge
    frameworks: []
    updated: "{{YYYY-MM-DD}}"
  E:  # Scope and behavior
    status: missing
    reason: null
    prerequisites: [C, D]
    filled_by: solution-sketch
    frameworks: []
    updated: "{{YYYY-MM-DD}}"
  F:  # AI fit
    status: missing
    reason: null
    prerequisites: [E]
    filled_by: solution-sketch
    frameworks: []
    updated: "{{YYYY-MM-DD}}"
  G:  # Data and entities
    status: missing
    reason: null
    prerequisites: [E]
    filled_by: clarify
    frameworks: []
    updated: "{{YYYY-MM-DD}}"
  H:  # Integrations
    status: missing
    reason: null
    prerequisites: [E, G]
    filled_by: clarify
    frameworks: []
    updated: "{{YYYY-MM-DD}}"
  I:  # Non-functional needs
    status: missing
    reason: null
    prerequisites: [E]
    filled_by: solution-sketch
    frameworks: []
    updated: "{{YYYY-MM-DD}}"
  J:  # Edge cases and failures
    status: missing
    reason: null
    prerequisites: [E]
    filled_by: solution-sketch
    frameworks: []
    updated: "{{YYYY-MM-DD}}"
  K:  # Risk and compliance
    status: missing
    reason: null
    prerequisites: [E, G]
    filled_by: challenge
    frameworks: []
    updated: "{{YYYY-MM-DD}}"
  L:  # Organizational change
    status: missing
    reason: null
    prerequisites: [B, E]
    filled_by: solution-sketch
    frameworks: []
    updated: "{{YYYY-MM-DD}}"
  M:  # Cost, resources and return
    status: missing
    reason: null
    prerequisites: [C, D, E]
    filled_by: challenge, plan
    frameworks: []
    updated: "{{YYYY-MM-DD}}"
  N:  # Terminology
    status: missing
    reason: null
    prerequisites: []
    filled_by: clarify
    frameworks: []
    updated: "{{YYYY-MM-DD}}"
  O:  # Completion signals
    status: missing
    reason: null
    prerequisites: [C, E]
    filled_by: outcome
    frameworks: []
    updated: "{{YYYY-MM-DD}}"
---

# Coverage: {{Idea title}}

<!--
  Human view of the frontmatter above. Rebuild this table from the frontmatter
  after every round; the frontmatter is the source of truth. Write the body in
  the idea's language; keep the frontmatter keys and values in English.
  Ready to package (spec Appendix A, FR-020): A, C, D and E clear; F clear when
  AI is involved; M at least an S, M or L size; every other category clear or
  deferred with a reason.
-->

| Code | Category | Status | Reason (when deferred) | Updated |
|---|---|---|---|---|
| A | Problem and why | missing | | {{YYYY-MM-DD}} |
| B | Users and stakeholders | missing | | {{YYYY-MM-DD}} |
| C | Outcome and measurement | missing | | {{YYYY-MM-DD}} |
| D | Alternatives | missing | | {{YYYY-MM-DD}} |
| E | Scope and behavior | missing | | {{YYYY-MM-DD}} |
| F | AI fit | missing | | {{YYYY-MM-DD}} |
| G | Data and entities | missing | | {{YYYY-MM-DD}} |
| H | Integrations | missing | | {{YYYY-MM-DD}} |
| I | Non-functional needs | missing | | {{YYYY-MM-DD}} |
| J | Edge cases and failures | missing | | {{YYYY-MM-DD}} |
| K | Risk and compliance | missing | | {{YYYY-MM-DD}} |
| L | Organizational change | missing | | {{YYYY-MM-DD}} |
| M | Cost, resources and return | missing | | {{YYYY-MM-DD}} |
| N | Terminology | missing | | {{YYYY-MM-DD}} |
| O | Completion signals | missing | | {{YYYY-MM-DD}} |

**Clear**: 0 of 15
