#!/usr/bin/env bash
# Seeds a fictional workspace (no real data). Run with: claude plugin eval ... --scaffold
set -euo pipefail
mkdir -p "$(dirname 'constitution.md')"
cat > 'constitution.md' <<'VIBEBIZ_SEED_0'
---
status: deferred
priorities: []
vertical: fashion
updated: "2026-11-12"
---

# Ground rules
VIBEBIZ_SEED_0
mkdir -p "$(dirname 'index.html')"
cat > 'index.html' <<'VIBEBIZ_SEED_1'
<!doctype html><html><head><meta charset="utf-8"><title>vibebiz</title></head><body><script type="application/json" id="vibebiz-data">{"workspace":{"updated":"2026-11-12","ground_rules_status":"deferred"},"ideas":[],"examples":[]}</script></body></html>
VIBEBIZ_SEED_1
mkdir -p "$(dirname 'specs/001-ai-fit-record/coverage.md')"
cat > 'specs/001-ai-fit-record/coverage.md' <<'VIBEBIZ_SEED_2'
---
id: "001"
slug: ai-fit-record
title: "Gợi ý size cho khách"
language: vi
vertical: fashion
cynefin: complicated
status: clarifying
estimate_status: not-tech-reviewed
budget_rounds_used: 0
latest_export: null
next_step: "Hỏi tiếp"
created: "2026-11-12"
updated: "2026-11-12"
categories:
  A:
    status: clear
    reason: null
    prerequisites: []
    filled_by: problem-framing
    frameworks: []
    updated: "2026-11-12"
  B:
    status: clear
    reason: null
    prerequisites: [A]
    filled_by: problem-framing
    frameworks: []
    updated: "2026-11-12"
  C:
    status: clear
    reason: null
    prerequisites: [A]
    filled_by: outcome
    frameworks: []
    updated: "2026-11-12"
  D:
    status: clear
    reason: null
    prerequisites: [A, C]
    filled_by: challenge
    frameworks: []
    updated: "2026-11-12"
  E:
    status: clear
    reason: null
    prerequisites: [C, D]
    filled_by: solution-sketch
    frameworks: []
    updated: "2026-11-12"
  F:
    status: missing
    reason: null
    prerequisites: [E]
    filled_by: solution-sketch
    frameworks: []
    updated: "2026-11-12"
  G:
    status: missing
    reason: null
    prerequisites: [E]
    filled_by: clarify
    frameworks: []
    updated: "2026-11-12"
  H:
    status: missing
    reason: null
    prerequisites: [E, G]
    filled_by: clarify
    frameworks: []
    updated: "2026-11-12"
  I:
    status: missing
    reason: null
    prerequisites: [E]
    filled_by: solution-sketch
    frameworks: []
    updated: "2026-11-12"
  J:
    status: missing
    reason: null
    prerequisites: [E]
    filled_by: solution-sketch
    frameworks: []
    updated: "2026-11-12"
  K:
    status: missing
    reason: null
    prerequisites: [E, G]
    filled_by: challenge
    frameworks: []
    updated: "2026-11-12"
  L:
    status: missing
    reason: null
    prerequisites: [B, E]
    filled_by: solution-sketch
    frameworks: []
    updated: "2026-11-12"
  M:
    status: missing
    reason: null
    prerequisites: [C, D, E]
    filled_by: challenge, plan
    frameworks: []
    updated: "2026-11-12"
  N:
    status: missing
    reason: null
    prerequisites: []
    filled_by: clarify
    frameworks: []
    updated: "2026-11-12"
  O:
    status: missing
    reason: null
    prerequisites: [C, E]
    filled_by: outcome
    frameworks: []
    updated: "2026-11-12"
---

# Coverage: Gợi ý size cho khách

| Code | Category | Status | Reason (when deferred) | Updated |
|---|---|---|---|---|
| A | Problem and why | clear |  | 2026-11-12 |
| B | Users and stakeholders | clear |  | 2026-11-12 |
| C | Outcome and measurement | clear |  | 2026-11-12 |
| D | Alternatives | clear |  | 2026-11-12 |
| E | Scope and behavior | clear |  | 2026-11-12 |
| F | AI fit | missing |  | 2026-11-12 |
| G | Data and entities | missing |  | 2026-11-12 |
| H | Integrations | missing |  | 2026-11-12 |
| I | Non-functional needs | missing |  | 2026-11-12 |
| J | Edge cases and failures | missing |  | 2026-11-12 |
| K | Risk and compliance | missing |  | 2026-11-12 |
| L | Organizational change | missing |  | 2026-11-12 |
| M | Cost, resources and return | missing |  | 2026-11-12 |
| N | Terminology | missing |  | 2026-11-12 |
| O | Completion signals | missing |  | 2026-11-12 |

**Clear**: 5 of 15
VIBEBIZ_SEED_2
mkdir -p "$(dirname 'specs/001-ai-fit-record/spec.md')"
cat > 'specs/001-ai-fit-record/spec.md' <<'VIBEBIZ_SEED_3'
# Feature Specification: Gợi ý size cho khách

## Problem & Why

Đổi trả vì sai size là 22% đơn. Muốn gợi ý size cho khách khi mua online.

## Clarifications

### Session 2026-11-12

- Q: Điều gì khiến bạn làm việc này? → A: Đổi trả vì sai size cao.
VIBEBIZ_SEED_3
mkdir -p "$(dirname 'specs/001-ai-fit-record/plan.md')"
cat > 'specs/001-ai-fit-record/plan.md' <<'VIBEBIZ_SEED_4'
# Plan: Gợi ý size cho khách
VIBEBIZ_SEED_4
mkdir -p "$(dirname 'specs/001-ai-fit-record/decisions.md')"
cat > 'specs/001-ai-fit-record/decisions.md' <<'VIBEBIZ_SEED_5'
# Decisions: Gợi ý size cho khách
VIBEBIZ_SEED_5
mkdir -p "$(dirname 'specs/001-ai-fit-record/assumptions.md')"
cat > 'specs/001-ai-fit-record/assumptions.md' <<'VIBEBIZ_SEED_6'
# Assumptions: Gợi ý size cho khách
VIBEBIZ_SEED_6
mkdir -p "$(dirname 'specs/001-ai-fit-record/open-questions.md')"
cat > 'specs/001-ai-fit-record/open-questions.md' <<'VIBEBIZ_SEED_7'
# Open questions: Gợi ý size cho khách
VIBEBIZ_SEED_7
mkdir -p "$(dirname 'specs/001-ai-fit-record/glossary.md')"
cat > 'specs/001-ai-fit-record/glossary.md' <<'VIBEBIZ_SEED_8'
# Glossary: Gợi ý size cho khách
VIBEBIZ_SEED_8
mkdir -p "$(dirname 'specs/001-ai-fit-record/checklists/board.md')"
cat > 'specs/001-ai-fit-record/checklists/board.md' <<'VIBEBIZ_SEED_9'
# Definition of Ready: board
VIBEBIZ_SEED_9
mkdir -p "$(dirname 'specs/001-ai-fit-record/checklists/tech.md')"
cat > 'specs/001-ai-fit-record/checklists/tech.md' <<'VIBEBIZ_SEED_10'
# Definition of Ready: tech
VIBEBIZ_SEED_10
mkdir -p "$(dirname 'specs/001-ai-fit-record/diagrams/.keep')"
: > 'specs/001-ai-fit-record/diagrams/.keep'
mkdir -p "$(dirname 'specs/001-ai-fit-record/exports/.keep')"
: > 'specs/001-ai-fit-record/exports/.keep'
