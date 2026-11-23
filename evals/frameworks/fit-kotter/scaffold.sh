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
mkdir -p "$(dirname 'specs/001-giao-don-online-tu-cua-hang/coverage.md')"
cat > 'specs/001-giao-don-online-tu-cua-hang/coverage.md' <<'VIBEBIZ_SEED_2'
---
id: "001"
slug: giao-don-online-tu-cua-hang
title: "Giao đơn online từ hàng của 60 cửa hàng"
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

# Coverage: Giao đơn online từ hàng của 60 cửa hàng

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
mkdir -p "$(dirname 'specs/001-giao-don-online-tu-cua-hang/spec.md')"
cat > 'specs/001-giao-don-online-tu-cua-hang/spec.md' <<'VIBEBIZ_SEED_3'
# Feature Specification: Giao đơn online từ hàng của 60 cửa hàng

**Created**: 2026-11-12

**Status**: Draft

## Problem & Why

Chuỗi giả định "Gió Nam" (60 cửa hàng thời trang) muốn giao đơn online từ hàng có sẵn ở cửa hàng gần khách nhất, thay vì chỉ từ kho tổng. Việc này đổi cách làm của cửa hàng, bộ phận online và cung ứng. Đã thử hai lần (2024 và 2025), lần nào cũng chìm sau vài tháng vì chỉ giám đốc thương mại điện tử thúc, còn chỉ tiêu cửa hàng chỉ tính khách mua tại quầy.

**Người liên quan**: quản lý và nhân viên 60 cửa hàng; bộ phận online; cung ứng; giám đốc bán lẻ, giám đốc cung ứng, giám đốc thương mại điện tử.

## Outcome

Tỉ lệ đơn online giao trong ngày tăng lên 40% trong 6 tháng (ước tính, hiện chưa đo). Giới hạn: không thiếu hàng tại quầy vì giao online.

## Alternatives

- Không làm gì.
- **Đã chọn**: giao từ cửa hàng, làm cho cả chuỗi (D-001).

## AI-fit

Không dùng AI; mục này hoãn.

## Cost & Risk

Cỡ L (chưa qua kỹ thuật thẩm định). Chưa có ai trong ban lãnh đạo ngoài giám đốc thương mại điện tử đứng ra dẫn, chưa có kết quả sớm để cho cả chuỗi thấy, chưa có cách giữ thay đổi sau khi triển khai.

## Clarifications

### Session 2026-11-12

- Q: Điều gì khiến bạn làm việc này? → A: Như phần vấn đề.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Cửa hàng giao đơn online (Priority: P1)

**Acceptance Scenarios**:

1. **Given** khách đặt online, **When** cửa hàng gần nhất còn hàng, **Then** cửa hàng soạn và giao trong ngày

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: Đơn online MUST được giao từ cửa hàng gần nhất còn hàng.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Như phần Outcome.

## Assumptions

- Chưa có giả định nào được ghi.
VIBEBIZ_SEED_3
mkdir -p "$(dirname 'specs/001-giao-don-online-tu-cua-hang/decisions.md')"
cat > 'specs/001-giao-don-online-tu-cua-hang/decisions.md' <<'VIBEBIZ_SEED_4'
# Decisions: Giao đơn online từ hàng của 60 cửa hàng

## D-001 — Giao đơn online từ cửa hàng

- date: 2026-11-12
- type: answer
- text: Giao đơn online từ hàng của cửa hàng gần khách nhất, cho cả 60 cửa hàng.
- reason: Tổng giám đốc chọn ngày 12/11/2026, lần thứ ba thử việc này.
VIBEBIZ_SEED_4
mkdir -p "$(dirname 'specs/001-giao-don-online-tu-cua-hang/assumptions.md')"
cat > 'specs/001-giao-don-online-tu-cua-hang/assumptions.md' <<'VIBEBIZ_SEED_5'
# Assumptions: Giao đơn online từ hàng của 60 cửa hàng
VIBEBIZ_SEED_5
mkdir -p "$(dirname 'specs/001-giao-don-online-tu-cua-hang/open-questions.md')"
cat > 'specs/001-giao-don-online-tu-cua-hang/open-questions.md' <<'VIBEBIZ_SEED_6'
# Open questions: Giao đơn online từ hàng của 60 cửa hàng
VIBEBIZ_SEED_6
mkdir -p "$(dirname 'specs/001-giao-don-online-tu-cua-hang/glossary.md')"
cat > 'specs/001-giao-don-online-tu-cua-hang/glossary.md' <<'VIBEBIZ_SEED_7'
# Glossary: Giao đơn online từ hàng của 60 cửa hàng
VIBEBIZ_SEED_7
mkdir -p "$(dirname 'specs/001-giao-don-online-tu-cua-hang/checklists/board.md')"
cat > 'specs/001-giao-don-online-tu-cua-hang/checklists/board.md' <<'VIBEBIZ_SEED_8'
# Definition of Ready: board
VIBEBIZ_SEED_8
mkdir -p "$(dirname 'specs/001-giao-don-online-tu-cua-hang/checklists/tech.md')"
cat > 'specs/001-giao-don-online-tu-cua-hang/checklists/tech.md' <<'VIBEBIZ_SEED_9'
# Definition of Ready: tech
VIBEBIZ_SEED_9
mkdir -p "$(dirname 'specs/001-giao-don-online-tu-cua-hang/diagrams/.keep')"
: > 'specs/001-giao-don-online-tu-cua-hang/diagrams/.keep'
mkdir -p "$(dirname 'specs/001-giao-don-online-tu-cua-hang/exports/.keep')"
: > 'specs/001-giao-don-online-tu-cua-hang/exports/.keep'
