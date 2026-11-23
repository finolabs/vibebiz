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
mkdir -p "$(dirname 'specs/001-skip-npv/coverage.md')"
cat > 'specs/001-skip-npv/coverage.md' <<'VIBEBIZ_SEED_2'
---
id: "001"
slug: skip-npv
title: "Công cụ in nhãn giá điện tử cho cửa hàng"
language: vi
vertical: fashion
cynefin: complicated
status: clarifying
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
    status: partial
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

# Coverage: Công cụ in nhãn giá điện tử cho cửa hàng

| Code | Category | Status | Reason (when deferred) | Updated |
|---|---|---|---|---|
| A | Problem and why | clear |  | 2026-11-12 |
| B | Users and stakeholders | clear |  | 2026-11-12 |
| C | Outcome and measurement | clear |  | 2026-11-12 |
| D | Alternatives | partial |  | 2026-11-12 |
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

**Clear**: 12 of 15
VIBEBIZ_SEED_2
mkdir -p "$(dirname 'specs/001-skip-npv/spec.md')"
cat > 'specs/001-skip-npv/spec.md' <<'VIBEBIZ_SEED_3'
# Feature Specification: Công cụ in nhãn giá điện tử cho cửa hàng

**Created**: 2026-11-12

**Status**: Draft

## Problem & Why

Chuỗi giả định "Lụa Hồng" (30 cửa hàng thời trang nữ) đổi giá bằng tay mỗi đợt giảm giá; nhân viên mất nhiều giờ và nhãn hay sai với giá ở quầy. Có thể tự làm hệ thống nhãn giá điện tử, mua bộ có sẵn, hoặc thuê đối tác lắp và vận hành.

**Người liên quan**: nhân viên cửa hàng đổi nhãn; quản lý cửa hàng; phòng giá; giám đốc tài chính duyệt.

## Outcome

Số giờ đổi nhãn mỗi đợt giảm giá và số nhãn sai giảm trong năm 2027 (số hiện tại: báo cáo cửa hàng đợt giảm giá tháng 11/2026, đo; mức giảm mục tiêu chưa chốt). Giới hạn: không sai giá ở quầy. Tiêu chí dừng: sau hai đợt giảm giá ở cửa hàng thử mà số giờ không giảm thì dừng.

## Alternatives

- Không làm gì.
- Tự làm.
- Mua bộ có sẵn.
- Thuê đối tác.

Chưa so sánh các đường theo chi phí, lợi ích và thời gian hoàn vốn; chưa chọn đường nào.

## AI-fit

Không dùng AI; mục này hoãn.

## Cost & Risk

Cỡ L (chưa qua kỹ thuật thẩm định). Chưa có chi phí hay lợi ích của đường nào.

## Clarifications

### Session 2026-11-12

- Q: Điều gì khiến bạn làm việc này? → A: Như phần vấn đề.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Nhân viên đổi giá đợt giảm giá (Priority: P1)

**Acceptance Scenarios**:

1. **Given** phòng giá chốt giá mới, **When** đợt giảm giá bắt đầu, **Then** nhãn ở mọi cửa hàng hiện đúng giá

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: Nhãn giá MUST hiện đúng giá ở quầy.
- **FR-002**: Đường làm (tự làm, mua hay thuê) chưa làm rõ.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Số giờ đổi nhãn và số nhãn sai giảm như phần Outcome.

## Assumptions

- Wifi ở mọi cửa hàng đủ cho nhãn điện tử (giả định, chưa kiểm chứng).
VIBEBIZ_SEED_3
mkdir -p "$(dirname 'specs/001-skip-npv/decisions.md')"
cat > 'specs/001-skip-npv/decisions.md' <<'VIBEBIZ_SEED_4'
# Decisions: Công cụ in nhãn giá điện tử cho cửa hàng
VIBEBIZ_SEED_4
mkdir -p "$(dirname 'specs/001-skip-npv/assumptions.md')"
cat > 'specs/001-skip-npv/assumptions.md' <<'VIBEBIZ_SEED_5'
# Assumptions: Công cụ in nhãn giá điện tử cho cửa hàng
VIBEBIZ_SEED_5
mkdir -p "$(dirname 'specs/001-skip-npv/open-questions.md')"
cat > 'specs/001-skip-npv/open-questions.md' <<'VIBEBIZ_SEED_6'
# Open questions: Công cụ in nhãn giá điện tử cho cửa hàng
VIBEBIZ_SEED_6
mkdir -p "$(dirname 'specs/001-skip-npv/glossary.md')"
cat > 'specs/001-skip-npv/glossary.md' <<'VIBEBIZ_SEED_7'
# Glossary: Công cụ in nhãn giá điện tử cho cửa hàng
VIBEBIZ_SEED_7
mkdir -p "$(dirname 'specs/001-skip-npv/checklists/board.md')"
cat > 'specs/001-skip-npv/checklists/board.md' <<'VIBEBIZ_SEED_8'
# Definition of Ready: board
VIBEBIZ_SEED_8
mkdir -p "$(dirname 'specs/001-skip-npv/checklists/tech.md')"
cat > 'specs/001-skip-npv/checklists/tech.md' <<'VIBEBIZ_SEED_9'
# Definition of Ready: tech
VIBEBIZ_SEED_9
mkdir -p "$(dirname 'specs/001-skip-npv/diagrams/.keep')"
: > 'specs/001-skip-npv/diagrams/.keep'
mkdir -p "$(dirname 'specs/001-skip-npv/exports/.keep')"
: > 'specs/001-skip-npv/exports/.keep'
