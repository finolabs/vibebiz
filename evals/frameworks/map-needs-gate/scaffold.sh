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
mkdir -p "$(dirname 'specs/001-map-needs-gate/coverage.md')"
cat > 'specs/001-map-needs-gate/coverage.md' <<'VIBEBIZ_SEED_2'
---
id: "001"
slug: map-needs-gate
title: "Thử phòng thử đồ tự phục vụ"
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
    status: deferred
    reason: 'ban lãnh đạo chưa chốt mục tiêu, họp lại tháng 1'
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
    status: clear
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
    status: clear
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

# Coverage: Thử phòng thử đồ tự phục vụ

| Code | Category | Status | Reason (when deferred) | Updated |
|---|---|---|---|---|
| A | Problem and why | clear |  | 2026-11-12 |
| B | Users and stakeholders | clear |  | 2026-11-12 |
| C | Outcome and measurement | deferred | ban lãnh đạo chưa chốt mục tiêu, họp lại tháng 1 | 2026-11-12 |
| D | Alternatives | clear |  | 2026-11-12 |
| E | Scope and behavior | clear |  | 2026-11-12 |
| F | AI fit | missing |  | 2026-11-12 |
| G | Data and entities | clear |  | 2026-11-12 |
| H | Integrations | missing |  | 2026-11-12 |
| I | Non-functional needs | missing |  | 2026-11-12 |
| J | Edge cases and failures | missing |  | 2026-11-12 |
| K | Risk and compliance | missing |  | 2026-11-12 |
| L | Organizational change | missing |  | 2026-11-12 |
| M | Cost, resources and return | missing |  | 2026-11-12 |
| N | Terminology | clear |  | 2026-11-12 |
| O | Completion signals | missing |  | 2026-11-12 |

**Clear**: 6 of 15
VIBEBIZ_SEED_2
mkdir -p "$(dirname 'specs/001-map-needs-gate/spec.md')"
cat > 'specs/001-map-needs-gate/spec.md' <<'VIBEBIZ_SEED_3'
# Feature Specification: Thử phòng thử đồ tự phục vụ

## Problem & Why

Khách xếp hàng chờ phòng thử đồ cuối tuần trung bình 9 phút (bấm giờ ở 3 cửa hàng, tháng 10/2026, đo); 1 trên 5 khách bỏ hàng lại vì chờ lâu (ước tính của quản lý cửa hàng). Người chịu thiệt: khách và nhân viên bán hàng.

**Người liên quan**: khách; nhân viên phòng thử; quản lý cửa hàng; trưởng phòng bán lẻ duyệt

## Outcome

Mốc hiện tại: 9 phút chờ phòng thử cuối tuần (đo). Mục tiêu chưa chốt: ban lãnh đạo hoãn đến cuộc họp tháng 1.

## Alternatives

Không làm gì: tiếp tục mất khách bỏ hàng. Thêm nhân viên phòng thử cuối tuần: khoảng 6 triệu đồng mỗi cửa hàng mỗi tháng (ước tính). Phòng thử tự phục vụ: khách quét mã thẻ hàng để vào phòng trống. Người dùng chọn thử phòng thử tự phục vụ.

## Scope

Khách quét mã thẻ hàng ở cửa phòng thử, màn hình báo phòng trống, nhân viên chỉ xử lý khi khách cần đổi size. Ngoài phạm vi: thanh toán trong phòng thử.

## Data

Mã thẻ hàng, trạng thái phòng, thời gian vào ra.

## Clarifications

### Session 2026-11-12

- Q: Điều gì khiến bạn làm việc này? → A: Khách bỏ hàng vì chờ phòng thử.
VIBEBIZ_SEED_3
mkdir -p "$(dirname 'specs/001-map-needs-gate/plan.md')"
cat > 'specs/001-map-needs-gate/plan.md' <<'VIBEBIZ_SEED_4'
# Plan: Thử phòng thử đồ tự phục vụ
VIBEBIZ_SEED_4
mkdir -p "$(dirname 'specs/001-map-needs-gate/decisions.md')"
cat > 'specs/001-map-needs-gate/decisions.md' <<'VIBEBIZ_SEED_5'
# Decisions: Thử phòng thử đồ tự phục vụ
VIBEBIZ_SEED_5
mkdir -p "$(dirname 'specs/001-map-needs-gate/assumptions.md')"
cat > 'specs/001-map-needs-gate/assumptions.md' <<'VIBEBIZ_SEED_6'
# Assumptions: Thử phòng thử đồ tự phục vụ
VIBEBIZ_SEED_6
mkdir -p "$(dirname 'specs/001-map-needs-gate/open-questions.md')"
cat > 'specs/001-map-needs-gate/open-questions.md' <<'VIBEBIZ_SEED_7'
# Open questions: Thử phòng thử đồ tự phục vụ
VIBEBIZ_SEED_7
mkdir -p "$(dirname 'specs/001-map-needs-gate/glossary.md')"
cat > 'specs/001-map-needs-gate/glossary.md' <<'VIBEBIZ_SEED_8'
# Glossary: Thử phòng thử đồ tự phục vụ
VIBEBIZ_SEED_8
mkdir -p "$(dirname 'specs/001-map-needs-gate/checklists/board.md')"
cat > 'specs/001-map-needs-gate/checklists/board.md' <<'VIBEBIZ_SEED_9'
# Definition of Ready: board
VIBEBIZ_SEED_9
mkdir -p "$(dirname 'specs/001-map-needs-gate/checklists/tech.md')"
cat > 'specs/001-map-needs-gate/checklists/tech.md' <<'VIBEBIZ_SEED_10'
# Definition of Ready: tech
VIBEBIZ_SEED_10
mkdir -p "$(dirname 'specs/001-map-needs-gate/diagrams/.keep')"
: > 'specs/001-map-needs-gate/diagrams/.keep'
mkdir -p "$(dirname 'specs/001-map-needs-gate/exports/.keep')"
: > 'specs/001-map-needs-gate/exports/.keep'
