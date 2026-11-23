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
mkdir -p "$(dirname 'specs/001-may-tinh-bang-tra-size/coverage.md')"
cat > 'specs/001-may-tinh-bang-tra-size/coverage.md' <<'VIBEBIZ_SEED_2'
---
id: "001"
slug: may-tinh-bang-tra-size
title: "Máy tính bảng tra size cho nhân viên quầy"
language: vi
vertical: fashion
cynefin: complicated
status: clarifying
estimate_status: not-tech-reviewed
budget_rounds_used: 4
latest_export: null
next_step: "Đóng gói bản nháp cho hội đồng"
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
    status: deferred
    reason: "Ý tưởng không dùng AI"
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
    status: clear
    reason: null
    prerequisites: [E, G]
    filled_by: clarify
    frameworks: []
    updated: "2026-11-12"
  I:
    status: clear
    reason: null
    prerequisites: [E]
    filled_by: solution-sketch
    frameworks: []
    updated: "2026-11-12"
  J:
    status: clear
    reason: null
    prerequisites: [E]
    filled_by: solution-sketch
    frameworks: []
    updated: "2026-11-12"
  K:
    status: clear
    reason: null
    prerequisites: [E, G]
    filled_by: challenge
    frameworks: []
    updated: "2026-11-12"
  L:
    status: partial
    reason: null
    prerequisites: [B, E]
    filled_by: solution-sketch
    frameworks: []
    updated: "2026-11-12"
  M:
    status: clear
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
    status: clear
    reason: null
    prerequisites: [C, E]
    filled_by: outcome
    frameworks: []
    updated: "2026-11-12"
---

# Coverage: Máy tính bảng tra size cho nhân viên quầy

| Code | Category | Status | Reason (when deferred) | Updated |
|---|---|---|---|---|
| A | Problem and why | clear |  | 2026-11-12 |
| B | Users and stakeholders | clear |  | 2026-11-12 |
| C | Outcome and measurement | clear |  | 2026-11-12 |
| D | Alternatives | clear |  | 2026-11-12 |
| E | Scope and behavior | clear |  | 2026-11-12 |
| F | AI fit | deferred | Ý tưởng không dùng AI | 2026-11-12 |
| G | Data and entities | clear |  | 2026-11-12 |
| H | Integrations | clear |  | 2026-11-12 |
| I | Non-functional needs | clear |  | 2026-11-12 |
| J | Edge cases and failures | clear |  | 2026-11-12 |
| K | Risk and compliance | clear |  | 2026-11-12 |
| L | Organizational change | partial |  | 2026-11-12 |
| M | Cost, resources and return | clear |  | 2026-11-12 |
| N | Terminology | clear |  | 2026-11-12 |
| O | Completion signals | clear |  | 2026-11-12 |

**Clear**: 13 of 15
VIBEBIZ_SEED_2
mkdir -p "$(dirname 'specs/001-may-tinh-bang-tra-size/spec.md')"
cat > 'specs/001-may-tinh-bang-tra-size/spec.md' <<'VIBEBIZ_SEED_3'
# Feature Specification: Máy tính bảng tra size cho nhân viên quầy

**Created**: 2026-11-12

**Status**: Draft

## Problem & Why

Chuỗi giả định "Mây Trắng" (20 cửa hàng thời trang nữ) cho nhân viên đứng quầy dùng máy tính bảng để tra size còn hàng ở cửa hàng khác. Nhân viên nghĩ đây là cách để theo dõi họ và sợ mất hoa hồng khi khách lấy hàng ở cửa hàng khác.

**Người liên quan**: nhân viên đứng quầy; quản lý cửa hàng.

## Outcome

Tỉ lệ khách hỏi size hết hàng mà vẫn mua tăng từ khoảng 10% lên 25% trong 3 tháng (ước tính).

## Alternatives

- Không làm gì.
- **Đã chọn**: máy tính bảng tra size (D-001).

## AI-fit

Không dùng AI; mục này hoãn.

## Cost & Risk

Cỡ S (chưa qua kỹ thuật thẩm định). Chưa có kế hoạch giúp nhân viên đứng quầy chịu dùng máy tính bảng, chưa rõ hoa hồng tính cho ai.

## Clarifications

### Session 2026-11-12

- Q: Điều gì khiến bạn làm việc này? → A: Như phần vấn đề.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Nhân viên tra size (Priority: P1)

**Acceptance Scenarios**:

1. **Given** khách hỏi size đã hết, **When** nhân viên tra trên máy tính bảng, **Then** nhân viên báo cửa hàng gần nhất còn size

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: Nhân viên đứng quầy MUST tra được size ở các cửa hàng khác.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Như phần Outcome.

## Assumptions

- Chưa có giả định nào được ghi.
VIBEBIZ_SEED_3
mkdir -p "$(dirname 'specs/001-may-tinh-bang-tra-size/decisions.md')"
cat > 'specs/001-may-tinh-bang-tra-size/decisions.md' <<'VIBEBIZ_SEED_4'
# Decisions: Máy tính bảng tra size cho nhân viên quầy

## D-001 — Dùng máy tính bảng tra size

- date: 2026-11-12
- type: answer
- text: Cấp máy tính bảng tra size cho nhân viên đứng quầy ở 20 cửa hàng.
- reason: Giám đốc bán lẻ chọn ngày 12/11/2026.
VIBEBIZ_SEED_4
mkdir -p "$(dirname 'specs/001-may-tinh-bang-tra-size/assumptions.md')"
cat > 'specs/001-may-tinh-bang-tra-size/assumptions.md' <<'VIBEBIZ_SEED_5'
# Assumptions: Máy tính bảng tra size cho nhân viên quầy
VIBEBIZ_SEED_5
mkdir -p "$(dirname 'specs/001-may-tinh-bang-tra-size/open-questions.md')"
cat > 'specs/001-may-tinh-bang-tra-size/open-questions.md' <<'VIBEBIZ_SEED_6'
# Open questions: Máy tính bảng tra size cho nhân viên quầy
VIBEBIZ_SEED_6
mkdir -p "$(dirname 'specs/001-may-tinh-bang-tra-size/glossary.md')"
cat > 'specs/001-may-tinh-bang-tra-size/glossary.md' <<'VIBEBIZ_SEED_7'
# Glossary: Máy tính bảng tra size cho nhân viên quầy
VIBEBIZ_SEED_7
mkdir -p "$(dirname 'specs/001-may-tinh-bang-tra-size/checklists/board.md')"
cat > 'specs/001-may-tinh-bang-tra-size/checklists/board.md' <<'VIBEBIZ_SEED_8'
# Definition of Ready: board
VIBEBIZ_SEED_8
mkdir -p "$(dirname 'specs/001-may-tinh-bang-tra-size/checklists/tech.md')"
cat > 'specs/001-may-tinh-bang-tra-size/checklists/tech.md' <<'VIBEBIZ_SEED_9'
# Definition of Ready: tech
VIBEBIZ_SEED_9
mkdir -p "$(dirname 'specs/001-may-tinh-bang-tra-size/diagrams/.keep')"
: > 'specs/001-may-tinh-bang-tra-size/diagrams/.keep'
mkdir -p "$(dirname 'specs/001-may-tinh-bang-tra-size/exports/.keep')"
: > 'specs/001-may-tinh-bang-tra-size/exports/.keep'
