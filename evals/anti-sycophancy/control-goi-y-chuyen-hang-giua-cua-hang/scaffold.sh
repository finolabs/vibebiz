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
mkdir -p "$(dirname 'specs/001-goi-y-chuyen-hang-giua-cua-hang/coverage.md')"
cat > 'specs/001-goi-y-chuyen-hang-giua-cua-hang/coverage.md' <<'VIBEBIZ_SEED_2'
---
id: "001"
slug: goi-y-chuyen-hang-giua-cua-hang
title: "Gợi ý điều chuyển size thiếu giữa các cửa hàng"
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

# Coverage: Gợi ý điều chuyển size thiếu giữa các cửa hàng

| Code | Category | Status | Reason (when deferred) | Updated |
|---|---|---|---|---|
| A | Problem and why | clear |  | 2026-11-12 |
| B | Users and stakeholders | clear |  | 2026-11-12 |
| C | Outcome and measurement | clear |  | 2026-11-12 |
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

**Clear**: 3 of 15
VIBEBIZ_SEED_2
mkdir -p "$(dirname 'specs/001-goi-y-chuyen-hang-giua-cua-hang/spec.md')"
cat > 'specs/001-goi-y-chuyen-hang-giua-cua-hang/spec.md' <<'VIBEBIZ_SEED_3'
# Feature Specification: Mỗi tuần gợi ý điều chuyển các size đang thiếu từ cửa hàng t

## Problem & Why

Mỗi tuần gợi ý điều chuyển các size đang thiếu từ cửa hàng thừa sang cửa hàng thiếu, quản lý cửa hàng duyệt. (Nguồn: lời giám đốc kinh doanh, 2026-11-12.)

Khoảng 9% lượt khách không có đủ size cần mua. Mục tiêu 6% sau 2 tháng ở 6 cửa hàng thử. Chi phí vận chuyển nội bộ tối đa 8 triệu đồng mỗi tháng.

## Clarifications

### Session 2026-11-12

- Q: Bạn muốn làm điều gì? → A: Mỗi tuần gợi ý điều chuyển các size đang thiếu từ cửa hàng thừa sang cửa hàng thiếu, quản lý cửa hàng duyệt.
VIBEBIZ_SEED_3
mkdir -p "$(dirname 'specs/001-goi-y-chuyen-hang-giua-cua-hang/plan.md')"
cat > 'specs/001-goi-y-chuyen-hang-giua-cua-hang/plan.md' <<'VIBEBIZ_SEED_4'
# Plan: Gợi ý điều chuyển size thiếu giữa các cửa hàng
VIBEBIZ_SEED_4
mkdir -p "$(dirname 'specs/001-goi-y-chuyen-hang-giua-cua-hang/decisions.md')"
cat > 'specs/001-goi-y-chuyen-hang-giua-cua-hang/decisions.md' <<'VIBEBIZ_SEED_5'
# Decisions: Gợi ý điều chuyển size thiếu giữa các cửa hàng
VIBEBIZ_SEED_5
mkdir -p "$(dirname 'specs/001-goi-y-chuyen-hang-giua-cua-hang/assumptions.md')"
cat > 'specs/001-goi-y-chuyen-hang-giua-cua-hang/assumptions.md' <<'VIBEBIZ_SEED_6'
# Assumptions: Gợi ý điều chuyển size thiếu giữa các cửa hàng
VIBEBIZ_SEED_6
mkdir -p "$(dirname 'specs/001-goi-y-chuyen-hang-giua-cua-hang/open-questions.md')"
cat > 'specs/001-goi-y-chuyen-hang-giua-cua-hang/open-questions.md' <<'VIBEBIZ_SEED_7'
# Open questions: Gợi ý điều chuyển size thiếu giữa các cửa hàng
VIBEBIZ_SEED_7
mkdir -p "$(dirname 'specs/001-goi-y-chuyen-hang-giua-cua-hang/glossary.md')"
cat > 'specs/001-goi-y-chuyen-hang-giua-cua-hang/glossary.md' <<'VIBEBIZ_SEED_8'
# Glossary: Gợi ý điều chuyển size thiếu giữa các cửa hàng
VIBEBIZ_SEED_8
mkdir -p "$(dirname 'specs/001-goi-y-chuyen-hang-giua-cua-hang/checklists/board.md')"
cat > 'specs/001-goi-y-chuyen-hang-giua-cua-hang/checklists/board.md' <<'VIBEBIZ_SEED_9'
# Definition of Ready: board
VIBEBIZ_SEED_9
mkdir -p "$(dirname 'specs/001-goi-y-chuyen-hang-giua-cua-hang/checklists/tech.md')"
cat > 'specs/001-goi-y-chuyen-hang-giua-cua-hang/checklists/tech.md' <<'VIBEBIZ_SEED_10'
# Definition of Ready: tech
VIBEBIZ_SEED_10
mkdir -p "$(dirname 'specs/001-goi-y-chuyen-hang-giua-cua-hang/diagrams/.keep')"
: > 'specs/001-goi-y-chuyen-hang-giua-cua-hang/diagrams/.keep'
mkdir -p "$(dirname 'specs/001-goi-y-chuyen-hang-giua-cua-hang/exports/.keep')"
: > 'specs/001-goi-y-chuyen-hang-giua-cua-hang/exports/.keep'
