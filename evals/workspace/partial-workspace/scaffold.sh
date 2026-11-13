#!/usr/bin/env bash
# Seeds a fictional workspace (no real data). Run with: claude plugin eval ... --scaffold
set -euo pipefail
mkdir -p "$(dirname 'constitution.md')"
cat > 'constitution.md' <<'VIBEBIZ_SEED_0'
---
status: set
updated: "2026-11-12"
---

# MY-OWN-GROUND-RULES-MARKER
VIBEBIZ_SEED_0
mkdir -p "$(dirname 'specs/001-nhac-khach-quay-lai/coverage.md')"
cat > 'specs/001-nhac-khach-quay-lai/coverage.md' <<'VIBEBIZ_SEED_1'
---
id: "001"
slug: nhac-khach-quay-lai
title: "Nhắc khách quay lại"
language: vi
vertical: fashion
cynefin: complicated
status: clarifying
estimate_status: not-tech-reviewed
budget_rounds_used: 0
latest_export: null
next_step: "Hỏi tiếp về người dùng và kết quả mong muốn"
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
    status: missing
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

# Coverage: Nhắc khách quay lại

| Code | Category | Status | Reason (when deferred) | Updated |
|---|---|---|---|---|
| A | Problem and why | clear |  | 2026-11-12 |
| B | Users and stakeholders | missing |  | 2026-11-12 |
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

**Clear**: 1 of 15
VIBEBIZ_SEED_1
mkdir -p "$(dirname 'specs/001-nhac-khach-quay-lai/spec.md')"
cat > 'specs/001-nhac-khach-quay-lai/spec.md' <<'VIBEBIZ_SEED_2'
# Feature Specification: Nhắc khách quay lại

## Problem & Why

Chuỗi thời trang nữ công sở Lụa Hạ (34 cửa hàng, bán thêm trên website) muốn nhắc khách cũ quay lại mua. Chỉ 18% khách mua lần hai trong 90 ngày. (Nguồn: lời giám đốc kinh doanh, 2026-11-12; số do người dùng nêu, chưa kiểm chứng.)

## Clarifications

### Session 2026-11-12

- Q: Điều gì khiến bạn muốn làm việc này ngay bây giờ? → A: Khách mua một lần rồi bỏ đi.
VIBEBIZ_SEED_2
mkdir -p "$(dirname 'specs/001-nhac-khach-quay-lai/plan.md')"
cat > 'specs/001-nhac-khach-quay-lai/plan.md' <<'VIBEBIZ_SEED_3'
# Plan

HAND-EDITED-PLAN-MARKER
VIBEBIZ_SEED_3
mkdir -p "$(dirname 'specs/001-nhac-khach-quay-lai/decisions.md')"
cat > 'specs/001-nhac-khach-quay-lai/decisions.md' <<'VIBEBIZ_SEED_4'
# Decisions: Nhắc khách quay lại
VIBEBIZ_SEED_4
mkdir -p "$(dirname 'specs/001-nhac-khach-quay-lai/assumptions.md')"
cat > 'specs/001-nhac-khach-quay-lai/assumptions.md' <<'VIBEBIZ_SEED_5'
# Assumptions: Nhắc khách quay lại
VIBEBIZ_SEED_5
mkdir -p "$(dirname 'specs/001-nhac-khach-quay-lai/open-questions.md')"
cat > 'specs/001-nhac-khach-quay-lai/open-questions.md' <<'VIBEBIZ_SEED_6'
# Open questions: Nhắc khách quay lại
VIBEBIZ_SEED_6
mkdir -p "$(dirname 'specs/001-nhac-khach-quay-lai/checklists/board.md')"
cat > 'specs/001-nhac-khach-quay-lai/checklists/board.md' <<'VIBEBIZ_SEED_7'
# Definition of Ready: board
VIBEBIZ_SEED_7
mkdir -p "$(dirname 'specs/001-nhac-khach-quay-lai/checklists/tech.md')"
cat > 'specs/001-nhac-khach-quay-lai/checklists/tech.md' <<'VIBEBIZ_SEED_8'
# Definition of Ready: tech
VIBEBIZ_SEED_8
mkdir -p "$(dirname 'specs/001-nhac-khach-quay-lai/diagrams/.keep')"
: > 'specs/001-nhac-khach-quay-lai/diagrams/.keep'
mkdir -p "$(dirname 'specs/001-nhac-khach-quay-lai/exports/.keep')"
: > 'specs/001-nhac-khach-quay-lai/exports/.keep'
