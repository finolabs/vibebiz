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
mkdir -p "$(dirname 'specs/001-fit-npv/coverage.md')"
cat > 'specs/001-fit-npv/coverage.md' <<'VIBEBIZ_SEED_2'
---
id: "001"
slug: fit-npv
title: "Kho trung tâm cho đơn online miền Bắc"
language: vi
vertical: fashion
cynefin: complicated
status: ready
estimate_status: not-tech-reviewed
budget_rounds_used: 0
latest_export: null
next_step: "Đóng gói cho hội đồng"
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
    status: clear
    reason: null
    prerequisites: [B, E]
    filled_by: solution-sketch
    frameworks: []
    updated: "2026-11-12"
  M:
    status: partial
    reason: null
    prerequisites: [C, D, E]
    filled_by: challenge, plan
    frameworks: [tco]
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

# Coverage: Kho trung tâm cho đơn online miền Bắc

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
| L | Organizational change | clear |  | 2026-11-12 |
| M | Cost, resources and return | partial |  | 2026-11-12 |
| N | Terminology | clear |  | 2026-11-12 |
| O | Completion signals | clear |  | 2026-11-12 |

**Clear**: 13 of 15
VIBEBIZ_SEED_2
mkdir -p "$(dirname 'specs/001-fit-npv/spec.md')"
cat > 'specs/001-fit-npv/spec.md' <<'VIBEBIZ_SEED_3'
# Feature Specification: Kho trung tâm cho đơn online miền Bắc

**Created**: 2026-11-12

**Status**: Draft

## Problem & Why

Chuỗi giả định "Lụa Hồng" (30 cửa hàng thời trang nữ) giao đơn online miền Bắc từ 12 cửa hàng; đơn hay trễ và cửa hàng bận vào giờ cao điểm. Ban giám đốc đã chọn thuê một kho trung tâm do đối tác vận hành trong 4 năm (D-001).

**Người liên quan**: khách mua online; nhân viên cửa hàng đang đóng gói đơn; đối tác kho; giám đốc tài chính duyệt.

## Outcome

Chi phí giao mỗi đơn online miền Bắc giảm từ năm thứ hai (số hiện tại: báo cáo vận hành quý 3/2026, đo; mức giảm mục tiêu chưa chốt). Giới hạn: thời gian giao không dài hơn hiện tại. Tiêu chí dừng: sau năm đầu mà chi phí mỗi đơn không giảm thì xem lại hợp đồng.

## Alternatives

- Không làm gì: giao từ cửa hàng như hiện tại.
- Tự mở kho: vốn lớn, chậm một năm.
- **Đã chọn**: thuê kho của đối tác (D-001).

## AI-fit

Không dùng AI; mục này hoãn.

## Cost & Risk

Cỡ L (chưa qua kỹ thuật thẩm định). Chi phí từng năm của hợp đồng thuê kho (báo giá đối tác tháng 10/2026, giả định, chưa qua kỹ thuật thẩm định):

| Năm | Chi phí | Nguồn |
|---|---|---|
| 1 | 900 triệu đồng (gồm phí thiết lập) | Báo giá đối tác, 10/2026 |
| 2 | 600 triệu đồng | Báo giá đối tác, 10/2026 |
| 3 | 600 triệu đồng | Báo giá đối tác, 10/2026 |
| 4 | 600 triệu đồng | Báo giá đối tác, 10/2026 |

 Khoản tiết kiệm chỉ bắt đầu từ năm thứ hai, khi đủ đơn qua kho. Chưa so khoản tiết kiệm theo từng năm với chi phí, chưa tính thời gian hoàn vốn, chưa có kịch bản thấp, cơ sở, cao cho lợi ích.

## Clarifications

### Session 2026-11-12

- Q: Điều gì khiến bạn làm việc này? → A: Như phần vấn đề.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Khách mua online miền Bắc nhận hàng (Priority: P1)

**Acceptance Scenarios**:

1. **Given** khách đặt đơn online, **When** kho trung tâm xử lý đơn, **Then** khách nhận hàng đúng hẹn

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: Đơn online miền Bắc MUST được đóng gói tại kho trung tâm.
- **FR-002**: Lợi ích theo từng năm và thời gian hoàn vốn chưa làm rõ.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Chi phí giao mỗi đơn giảm như phần Outcome.

## Assumptions

- Số đơn online miền Bắc không giảm trong 4 năm (giả định, chưa kiểm chứng).
VIBEBIZ_SEED_3
mkdir -p "$(dirname 'specs/001-fit-npv/decisions.md')"
cat > 'specs/001-fit-npv/decisions.md' <<'VIBEBIZ_SEED_4'
# Decisions: Kho trung tâm cho đơn online miền Bắc

## D-001 — Thuê kho của đối tác vận hành

- date: 2026-11-12
- type: answer
- text: Thuê một kho trung tâm do đối tác vận hành cho đơn online miền Bắc, hợp đồng 4 năm.
- reason: Ban giám đốc chọn sau khi so với tự mở kho và giữ cách giao từ cửa hàng.
VIBEBIZ_SEED_4
mkdir -p "$(dirname 'specs/001-fit-npv/assumptions.md')"
cat > 'specs/001-fit-npv/assumptions.md' <<'VIBEBIZ_SEED_5'
# Assumptions: Kho trung tâm cho đơn online miền Bắc
VIBEBIZ_SEED_5
mkdir -p "$(dirname 'specs/001-fit-npv/open-questions.md')"
cat > 'specs/001-fit-npv/open-questions.md' <<'VIBEBIZ_SEED_6'
# Open questions: Kho trung tâm cho đơn online miền Bắc
VIBEBIZ_SEED_6
mkdir -p "$(dirname 'specs/001-fit-npv/glossary.md')"
cat > 'specs/001-fit-npv/glossary.md' <<'VIBEBIZ_SEED_7'
# Glossary: Kho trung tâm cho đơn online miền Bắc
VIBEBIZ_SEED_7
mkdir -p "$(dirname 'specs/001-fit-npv/checklists/board.md')"
cat > 'specs/001-fit-npv/checklists/board.md' <<'VIBEBIZ_SEED_8'
# Definition of Ready: board
VIBEBIZ_SEED_8
mkdir -p "$(dirname 'specs/001-fit-npv/checklists/tech.md')"
cat > 'specs/001-fit-npv/checklists/tech.md' <<'VIBEBIZ_SEED_9'
# Definition of Ready: tech
VIBEBIZ_SEED_9
mkdir -p "$(dirname 'specs/001-fit-npv/diagrams/.keep')"
: > 'specs/001-fit-npv/diagrams/.keep'
mkdir -p "$(dirname 'specs/001-fit-npv/exports/.keep')"
: > 'specs/001-fit-npv/exports/.keep'
