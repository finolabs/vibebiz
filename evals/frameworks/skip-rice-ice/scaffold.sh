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
mkdir -p "$(dirname 'specs/001-skip-rice-ice/coverage.md')"
cat > 'specs/001-skip-rice-ice/coverage.md' <<'VIBEBIZ_SEED_2'
---
id: "001"
slug: skip-rice-ice
title: "Ứng dụng đặt giữ hàng tại cửa hàng"
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
    status: clear
    reason: null
    prerequisites: [A, C]
    filled_by: challenge
    frameworks: []
    updated: "2026-11-12"
  E:
    status: partial
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

# Coverage: Ứng dụng đặt giữ hàng tại cửa hàng

| Code | Category | Status | Reason (when deferred) | Updated |
|---|---|---|---|---|
| A | Problem and why | clear |  | 2026-11-12 |
| B | Users and stakeholders | clear |  | 2026-11-12 |
| C | Outcome and measurement | clear |  | 2026-11-12 |
| D | Alternatives | clear |  | 2026-11-12 |
| E | Scope and behavior | partial |  | 2026-11-12 |
| F | AI fit | deferred | Ý tưởng không dùng AI | 2026-11-12 |
| G | Data and entities | clear |  | 2026-11-12 |
| H | Integrations | clear |  | 2026-11-12 |
| I | Non-functional needs | clear |  | 2026-11-12 |
| J | Edge cases and failures | clear |  | 2026-11-12 |
| K | Risk and compliance | clear |  | 2026-11-12 |
| L | Organizational change | clear |  | 2026-11-12 |
| M | Cost, resources and return | clear |  | 2026-11-12 |
| N | Terminology | clear |  | 2026-11-12 |
| O | Completion signals | clear |  | 2026-11-12 |

**Clear**: 13 of 15
VIBEBIZ_SEED_2
mkdir -p "$(dirname 'specs/001-skip-rice-ice/spec.md')"
cat > 'specs/001-skip-rice-ice/spec.md' <<'VIBEBIZ_SEED_3'
# Feature Specification: Ứng dụng đặt giữ hàng tại cửa hàng

**Created**: 2026-11-12

**Status**: Draft

## Problem & Why

Chuỗi giả định "Mây Chiều" (40 cửa hàng thời trang nữ) muốn cho khách đặt giữ một món hàng trên website rồi đến cửa hàng thử và mua. Các phòng đã gửi 9 tính năng mong muốn: giữ hàng 24 giờ, nhắn tin nhắc khách, chọn khung giờ đến, đổi cửa hàng nhận, thanh toán trước, tích điểm, gợi ý món đi kèm, xếp hàng ưu tiên, đánh giá sau khi mua. Bản đầu phải chạy trước Tết 2027, và đội chỉ làm kịp một phần.

**Người liên quan**: khách mua online; nhân viên cửa hàng giữ hàng; đội website; giám đốc bán lẻ duyệt.

## Outcome

30% số món được giữ được mua tại cửa hàng trong 3 tháng đầu (giả định, đo từ hệ thống bán hàng sau khi chạy). Giới hạn: nhân viên cửa hàng không mất quá 5 phút cho mỗi lượt giữ hàng. Tiêu chí dừng: dưới 15% sau 2 tháng thì dừng.

## Alternatives

- Không làm gì.
- Giữ hàng qua điện thoại như hiện tại: nhiều cửa hàng quên giữ.
- **Đã chọn**: tính năng giữ hàng trên website, bản đầu nhỏ, chạy trước Tết.

## AI-fit

Không dùng AI; mục này hoãn.

## Cost & Risk

Cỡ M (chưa qua kỹ thuật thẩm định). Số tiền chưa làm rõ.

## Clarifications

### Session 2026-11-12

- Q: Điều gì khiến bạn làm việc này? → A: Như phần vấn đề.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Khách mua trên website (Priority: P1)

**Acceptance Scenarios**:

1. **Given** khách vào website, **When** khách tìm và mua hàng, **Then** khách hoàn tất đơn mà không bỏ giữa chừng

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: Khách MUST giữ được một món hàng tại một cửa hàng.
- **FR-002**: Những tính năng nào vào bản đầu trước Tết chưa làm rõ.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Tỉ lệ chuyển đổi trên website tăng như phần Outcome.

## Assumptions

- Đội website giữ nguyên 4 người trong năm 2027 (giả định, chưa kiểm chứng).
VIBEBIZ_SEED_3
mkdir -p "$(dirname 'specs/001-skip-rice-ice/decisions.md')"
cat > 'specs/001-skip-rice-ice/decisions.md' <<'VIBEBIZ_SEED_4'
# Decisions: Ứng dụng đặt giữ hàng tại cửa hàng
VIBEBIZ_SEED_4
mkdir -p "$(dirname 'specs/001-skip-rice-ice/assumptions.md')"
cat > 'specs/001-skip-rice-ice/assumptions.md' <<'VIBEBIZ_SEED_5'
# Assumptions: Ứng dụng đặt giữ hàng tại cửa hàng
VIBEBIZ_SEED_5
mkdir -p "$(dirname 'specs/001-skip-rice-ice/open-questions.md')"
cat > 'specs/001-skip-rice-ice/open-questions.md' <<'VIBEBIZ_SEED_6'
# Open questions: Ứng dụng đặt giữ hàng tại cửa hàng
VIBEBIZ_SEED_6
mkdir -p "$(dirname 'specs/001-skip-rice-ice/glossary.md')"
cat > 'specs/001-skip-rice-ice/glossary.md' <<'VIBEBIZ_SEED_7'
# Glossary: Ứng dụng đặt giữ hàng tại cửa hàng
VIBEBIZ_SEED_7
mkdir -p "$(dirname 'specs/001-skip-rice-ice/checklists/board.md')"
cat > 'specs/001-skip-rice-ice/checklists/board.md' <<'VIBEBIZ_SEED_8'
# Definition of Ready: board
VIBEBIZ_SEED_8
mkdir -p "$(dirname 'specs/001-skip-rice-ice/checklists/tech.md')"
cat > 'specs/001-skip-rice-ice/checklists/tech.md' <<'VIBEBIZ_SEED_9'
# Definition of Ready: tech
VIBEBIZ_SEED_9
mkdir -p "$(dirname 'specs/001-skip-rice-ice/diagrams/.keep')"
: > 'specs/001-skip-rice-ice/diagrams/.keep'
mkdir -p "$(dirname 'specs/001-skip-rice-ice/exports/.keep')"
: > 'specs/001-skip-rice-ice/exports/.keep'
