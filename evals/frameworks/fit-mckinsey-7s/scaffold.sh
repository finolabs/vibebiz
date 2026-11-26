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
mkdir -p "$(dirname 'specs/001-chuyen-size-giua-cua-hang/coverage.md')"
cat > 'specs/001-chuyen-size-giua-cua-hang/coverage.md' <<'VIBEBIZ_SEED_2'
---
id: "001"
slug: chuyen-size-giua-cua-hang
title: "Chuyển size bán chậm sang cửa hàng bán chạy"
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

# Coverage: Chuyển size bán chậm sang cửa hàng bán chạy

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
mkdir -p "$(dirname 'specs/001-chuyen-size-giua-cua-hang/spec.md')"
cat > 'specs/001-chuyen-size-giua-cua-hang/spec.md' <<'VIBEBIZ_SEED_3'
# Feature Specification: Chuyển size bán chậm sang cửa hàng bán chạy

**Created**: 2026-11-12

**Status**: Draft

## Problem & Why

Chuỗi giả định "Đồi Thông" (45 cửa hàng thời trang) muốn cửa hàng chuyển size bán chậm sang cửa hàng gần đó đang bán chạy. Thử năm 2026: 8 cửa hàng miền Nam chuyển đều, 8 cửa hàng miền Bắc gần như không chuyển, dù cùng được đào tạo. Quản lý cửa hàng được thưởng theo doanh số của chính cửa hàng mình; hệ thống tồn kho ghi hàng chuyển đi là giảm doanh thu của cửa hàng gửi; hai miền có hai giám đốc vùng với cách điều hành khác nhau.

**Người liên quan**: quản lý cửa hàng; giám đốc vùng miền Bắc và miền Nam; bộ phận cung ứng; phòng nhân sự (chính sách thưởng).

## Outcome

Tỉ lệ size bán chậm phải giảm giá cuối mùa giảm từ khoảng 30% xuống 20% trong 6 tháng (ước tính).

## Alternatives

- Không làm gì.
- **Đã chọn**: chuyển size giữa cửa hàng cho cả chuỗi (D-001).

## AI-fit

Không dùng AI; mục này hoãn.

## Cost & Risk

Cỡ M (chưa qua kỹ thuật thẩm định). Chưa rõ những gì trong cách công ty chia vùng, trả thưởng, hệ thống và thói quen quản lý đang kéo ngược thay đổi này, và phải đổi gì trước khi làm cả chuỗi.

## Clarifications

### Session 2026-11-12

- Q: Điều gì khiến bạn làm việc này? → A: Như phần vấn đề.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Cửa hàng chuyển size (Priority: P1)

**Acceptance Scenarios**:

1. **Given** một size bán chậm ở cửa hàng A và bán chạy ở cửa hàng B gần đó, **When** hệ thống đề xuất chuyển, **Then** cửa hàng A gửi hàng trong 2 ngày

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: Hệ thống MUST đề xuất chuyển size giữa các cửa hàng gần nhau.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Như phần Outcome.

## Assumptions

- Chưa có giả định nào được ghi.
VIBEBIZ_SEED_3
mkdir -p "$(dirname 'specs/001-chuyen-size-giua-cua-hang/decisions.md')"
cat > 'specs/001-chuyen-size-giua-cua-hang/decisions.md' <<'VIBEBIZ_SEED_4'
# Decisions: Chuyển size bán chậm sang cửa hàng bán chạy

## D-001 — Chuyển size giữa cửa hàng

- date: 2026-11-12
- type: answer
- text: Làm việc chuyển size bán chậm giữa các cửa hàng cho cả 45 cửa hàng.
- reason: Giám đốc bán lẻ chọn ngày 12/11/2026 sau kết quả thử ở hai miền.
VIBEBIZ_SEED_4
mkdir -p "$(dirname 'specs/001-chuyen-size-giua-cua-hang/assumptions.md')"
cat > 'specs/001-chuyen-size-giua-cua-hang/assumptions.md' <<'VIBEBIZ_SEED_5'
# Assumptions: Chuyển size bán chậm sang cửa hàng bán chạy
VIBEBIZ_SEED_5
mkdir -p "$(dirname 'specs/001-chuyen-size-giua-cua-hang/open-questions.md')"
cat > 'specs/001-chuyen-size-giua-cua-hang/open-questions.md' <<'VIBEBIZ_SEED_6'
# Open questions: Chuyển size bán chậm sang cửa hàng bán chạy
VIBEBIZ_SEED_6
mkdir -p "$(dirname 'specs/001-chuyen-size-giua-cua-hang/glossary.md')"
cat > 'specs/001-chuyen-size-giua-cua-hang/glossary.md' <<'VIBEBIZ_SEED_7'
# Glossary: Chuyển size bán chậm sang cửa hàng bán chạy
VIBEBIZ_SEED_7
mkdir -p "$(dirname 'specs/001-chuyen-size-giua-cua-hang/checklists/board.md')"
cat > 'specs/001-chuyen-size-giua-cua-hang/checklists/board.md' <<'VIBEBIZ_SEED_8'
# Definition of Ready: board
VIBEBIZ_SEED_8
mkdir -p "$(dirname 'specs/001-chuyen-size-giua-cua-hang/checklists/tech.md')"
cat > 'specs/001-chuyen-size-giua-cua-hang/checklists/tech.md' <<'VIBEBIZ_SEED_9'
# Definition of Ready: tech
VIBEBIZ_SEED_9
mkdir -p "$(dirname 'specs/001-chuyen-size-giua-cua-hang/diagrams/.keep')"
: > 'specs/001-chuyen-size-giua-cua-hang/diagrams/.keep'
mkdir -p "$(dirname 'specs/001-chuyen-size-giua-cua-hang/exports/.keep')"
: > 'specs/001-chuyen-size-giua-cua-hang/exports/.keep'
