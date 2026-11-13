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
mkdir -p "$(dirname 'specs/001-gap-c-driver-tree/coverage.md')"
cat > 'specs/001-gap-c-driver-tree/coverage.md' <<'VIBEBIZ_SEED_2'
---
id: "001"
slug: gap-c-driver-tree
title: "Tăng doanh thu cửa hàng quận trung tâm"
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
    status: partial
    reason: null
    prerequisites: [A]
    filled_by: outcome
    frameworks: []
    updated: "2026-11-12"
  D:
    status: missing
    reason: null
    prerequisites: [A, C]
    filled_by: challenge
    frameworks: []
    updated: "2026-11-12"
  E:
    status: missing
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

# Coverage: Tăng doanh thu cửa hàng quận trung tâm

| Code | Category | Status | Reason (when deferred) | Updated |
|---|---|---|---|---|
| A | Problem and why | clear |  | 2026-11-12 |
| B | Users and stakeholders | clear |  | 2026-11-12 |
| C | Outcome and measurement | partial |  | 2026-11-12 |
| D | Alternatives | missing |  | 2026-11-12 |
| E | Scope and behavior | missing |  | 2026-11-12 |
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

**Clear**: 2 of 15
VIBEBIZ_SEED_2
mkdir -p "$(dirname 'specs/001-gap-c-driver-tree/spec.md')"
cat > 'specs/001-gap-c-driver-tree/spec.md' <<'VIBEBIZ_SEED_3'
# Feature Specification: Tăng doanh thu cửa hàng quận trung tâm

## Problem & Why

Doanh thu trung bình mỗi cửa hàng trung tâm là 1,8 tỉ đồng mỗi tháng, muốn tăng.

## Clarifications

### Session 2026-11-12

- Q: Điều gì khiến bạn làm việc này? → A: Muốn tăng doanh thu.
VIBEBIZ_SEED_3
mkdir -p "$(dirname 'specs/001-gap-c-driver-tree/plan.md')"
cat > 'specs/001-gap-c-driver-tree/plan.md' <<'VIBEBIZ_SEED_4'
# Plan: Tăng doanh thu cửa hàng quận trung tâm
VIBEBIZ_SEED_4
mkdir -p "$(dirname 'specs/001-gap-c-driver-tree/decisions.md')"
cat > 'specs/001-gap-c-driver-tree/decisions.md' <<'VIBEBIZ_SEED_5'
# Decisions: Tăng doanh thu cửa hàng quận trung tâm
VIBEBIZ_SEED_5
mkdir -p "$(dirname 'specs/001-gap-c-driver-tree/assumptions.md')"
cat > 'specs/001-gap-c-driver-tree/assumptions.md' <<'VIBEBIZ_SEED_6'
# Assumptions: Tăng doanh thu cửa hàng quận trung tâm
VIBEBIZ_SEED_6
mkdir -p "$(dirname 'specs/001-gap-c-driver-tree/open-questions.md')"
cat > 'specs/001-gap-c-driver-tree/open-questions.md' <<'VIBEBIZ_SEED_7'
# Open questions: Tăng doanh thu cửa hàng quận trung tâm
VIBEBIZ_SEED_7
mkdir -p "$(dirname 'specs/001-gap-c-driver-tree/glossary.md')"
cat > 'specs/001-gap-c-driver-tree/glossary.md' <<'VIBEBIZ_SEED_8'
# Glossary: Tăng doanh thu cửa hàng quận trung tâm
VIBEBIZ_SEED_8
mkdir -p "$(dirname 'specs/001-gap-c-driver-tree/checklists/board.md')"
cat > 'specs/001-gap-c-driver-tree/checklists/board.md' <<'VIBEBIZ_SEED_9'
# Definition of Ready: board
VIBEBIZ_SEED_9
mkdir -p "$(dirname 'specs/001-gap-c-driver-tree/checklists/tech.md')"
cat > 'specs/001-gap-c-driver-tree/checklists/tech.md' <<'VIBEBIZ_SEED_10'
# Definition of Ready: tech
VIBEBIZ_SEED_10
mkdir -p "$(dirname 'specs/001-gap-c-driver-tree/diagrams/.keep')"
: > 'specs/001-gap-c-driver-tree/diagrams/.keep'
mkdir -p "$(dirname 'specs/001-gap-c-driver-tree/exports/.keep')"
: > 'specs/001-gap-c-driver-tree/exports/.keep'
