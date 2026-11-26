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
mkdir -p "$(dirname 'specs/001-fit-okr/coverage.md')"
cat > 'specs/001-fit-okr/coverage.md' <<'VIBEBIZ_SEED_2'
---
id: "001"
slug: fit-okr
title: "Bán hàng qua livestream quý 1/2027"
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
    status: missing
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

# Coverage: Bán hàng qua livestream quý 1/2027

| Code | Category | Status | Reason (when deferred) | Updated |
|---|---|---|---|---|
| A | Problem and why | clear |  | 2026-11-12 |
| B | Users and stakeholders | clear |  | 2026-11-12 |
| C | Outcome and measurement | missing |  | 2026-11-12 |
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
mkdir -p "$(dirname 'specs/001-fit-okr/spec.md')"
cat > 'specs/001-fit-okr/spec.md' <<'VIBEBIZ_SEED_3'
# Feature Specification: Bán hàng qua livestream quý 1/2027

## Problem & Why

Kênh livestream chiếm phần nhỏ trong doanh thu online năm 2026 dù lượt xem tăng (báo cáo kênh online tháng 10/2026). Quý 1/2027 công ty muốn đẩy mạnh kênh này, nhưng ba nhóm liên quan đang đặt việc riêng: nhóm nội dung muốn thêm buổi phát, nhóm kho online lo giao kịp, nhóm chăm sóc khách hàng lo đổi trả. Chưa có mục tiêu chung cho cả quý.

**Người liên quan**: nhóm nội dung livestream; nhóm kho online; nhóm chăm sóc khách hàng; giám đốc kênh online duyệt.
VIBEBIZ_SEED_3
mkdir -p "$(dirname 'specs/001-fit-okr/plan.md')"
cat > 'specs/001-fit-okr/plan.md' <<'VIBEBIZ_SEED_4'
# Plan: Bán hàng qua livestream quý 1/2027
VIBEBIZ_SEED_4
mkdir -p "$(dirname 'specs/001-fit-okr/decisions.md')"
cat > 'specs/001-fit-okr/decisions.md' <<'VIBEBIZ_SEED_5'
# Decisions: Bán hàng qua livestream quý 1/2027
VIBEBIZ_SEED_5
mkdir -p "$(dirname 'specs/001-fit-okr/assumptions.md')"
cat > 'specs/001-fit-okr/assumptions.md' <<'VIBEBIZ_SEED_6'
# Assumptions: Bán hàng qua livestream quý 1/2027
VIBEBIZ_SEED_6
mkdir -p "$(dirname 'specs/001-fit-okr/open-questions.md')"
cat > 'specs/001-fit-okr/open-questions.md' <<'VIBEBIZ_SEED_7'
# Open questions: Bán hàng qua livestream quý 1/2027
VIBEBIZ_SEED_7
mkdir -p "$(dirname 'specs/001-fit-okr/glossary.md')"
cat > 'specs/001-fit-okr/glossary.md' <<'VIBEBIZ_SEED_8'
# Glossary: Bán hàng qua livestream quý 1/2027
VIBEBIZ_SEED_8
mkdir -p "$(dirname 'specs/001-fit-okr/checklists/board.md')"
cat > 'specs/001-fit-okr/checklists/board.md' <<'VIBEBIZ_SEED_9'
# Definition of Ready: board
VIBEBIZ_SEED_9
mkdir -p "$(dirname 'specs/001-fit-okr/checklists/tech.md')"
cat > 'specs/001-fit-okr/checklists/tech.md' <<'VIBEBIZ_SEED_10'
# Definition of Ready: tech
VIBEBIZ_SEED_10
mkdir -p "$(dirname 'specs/001-fit-okr/diagrams/.keep')"
: > 'specs/001-fit-okr/diagrams/.keep'
mkdir -p "$(dirname 'specs/001-fit-okr/exports/.keep')"
: > 'specs/001-fit-okr/exports/.keep'
