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
mkdir -p "$(dirname 'specs/001-fit-smart/coverage.md')"
cat > 'specs/001-fit-smart/coverage.md' <<'VIBEBIZ_SEED_2'
---
id: "001"
slug: fit-smart
title: "Giảm tồn kho cuối mùa"
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
    frameworks: [okr]
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

# Coverage: Giảm tồn kho cuối mùa

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
mkdir -p "$(dirname 'specs/001-fit-smart/spec.md')"
cat > 'specs/001-fit-smart/spec.md' <<'VIBEBIZ_SEED_3'
# Feature Specification: Giảm tồn kho cuối mùa

## Problem & Why

Cuối mỗi mùa còn nhiều hàng tồn phải giảm giá sâu, ăn vào biên lợi nhuận (báo cáo hàng tồn cuối mùa thu đông 2026). Nhóm mua hàng đặt số lượng theo cảm tính, phân bổ cho cửa hàng chia đều.

**Người liên quan**: nhóm mua hàng; nhóm phân bổ hàng; quản lý cửa hàng; giám đốc hàng hóa duyệt.

## Outcome

Mục tiêu mùa thu đông 2027: bán hết hàng mùa mà không phải giảm giá sâu (OKR).

- Kết quả then chốt 1: giảm tồn kho cuối mùa nhiều hơn.
- Kết quả then chốt 2: bán hết hàng sớm hơn.
- Kết quả then chốt 3: ít phải giảm giá hơn.
VIBEBIZ_SEED_3
mkdir -p "$(dirname 'specs/001-fit-smart/plan.md')"
cat > 'specs/001-fit-smart/plan.md' <<'VIBEBIZ_SEED_4'
# Plan: Giảm tồn kho cuối mùa
VIBEBIZ_SEED_4
mkdir -p "$(dirname 'specs/001-fit-smart/decisions.md')"
cat > 'specs/001-fit-smart/decisions.md' <<'VIBEBIZ_SEED_5'
# Decisions: Giảm tồn kho cuối mùa
VIBEBIZ_SEED_5
mkdir -p "$(dirname 'specs/001-fit-smart/assumptions.md')"
cat > 'specs/001-fit-smart/assumptions.md' <<'VIBEBIZ_SEED_6'
# Assumptions: Giảm tồn kho cuối mùa
VIBEBIZ_SEED_6
mkdir -p "$(dirname 'specs/001-fit-smart/open-questions.md')"
cat > 'specs/001-fit-smart/open-questions.md' <<'VIBEBIZ_SEED_7'
# Open questions: Giảm tồn kho cuối mùa
VIBEBIZ_SEED_7
mkdir -p "$(dirname 'specs/001-fit-smart/glossary.md')"
cat > 'specs/001-fit-smart/glossary.md' <<'VIBEBIZ_SEED_8'
# Glossary: Giảm tồn kho cuối mùa
VIBEBIZ_SEED_8
mkdir -p "$(dirname 'specs/001-fit-smart/checklists/board.md')"
cat > 'specs/001-fit-smart/checklists/board.md' <<'VIBEBIZ_SEED_9'
# Definition of Ready: board
VIBEBIZ_SEED_9
mkdir -p "$(dirname 'specs/001-fit-smart/checklists/tech.md')"
cat > 'specs/001-fit-smart/checklists/tech.md' <<'VIBEBIZ_SEED_10'
# Definition of Ready: tech
VIBEBIZ_SEED_10
mkdir -p "$(dirname 'specs/001-fit-smart/diagrams/.keep')"
: > 'specs/001-fit-smart/diagrams/.keep'
mkdir -p "$(dirname 'specs/001-fit-smart/exports/.keep')"
: > 'specs/001-fit-smart/exports/.keep'
