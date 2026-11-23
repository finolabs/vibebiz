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
mkdir -p "$(dirname 'specs/001-fit-stp/coverage.md')"
cat > 'specs/001-fit-stp/coverage.md' <<'VIBEBIZ_SEED_2'
---
id: "001"
slug: fit-stp
title: "Dòng áo khoác giá tầm trung mùa đông 2027"
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
    status: partial
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

# Coverage: Dòng áo khoác giá tầm trung mùa đông 2027

| Code | Category | Status | Reason (when deferred) | Updated |
|---|---|---|---|---|
| A | Problem and why | clear |  | 2026-11-12 |
| B | Users and stakeholders | partial |  | 2026-11-12 |
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

**Clear**: 12 of 15
VIBEBIZ_SEED_2
mkdir -p "$(dirname 'specs/001-fit-stp/spec.md')"
cat > 'specs/001-fit-stp/spec.md' <<'VIBEBIZ_SEED_3'
# Feature Specification: Dòng áo khoác giá tầm trung mùa đông 2027

**Created**: 2026-11-12

**Status**: Draft

## Problem & Why

Chuỗi giả định "Gió Bấc" (30 cửa hàng, có website) bán áo khoác cho mọi kiểu khách, và doanh số áo khoác mùa đông 2026 giảm so với mùa trước (báo cáo bán hàng tháng 2/2026, đo). Khách mua áo khoác của chuỗi rất khác nhau: sinh viên, nhân viên văn phòng, phụ huynh mua cho con, khách du lịch. Đội mua hàng muốn ra một dòng áo khoác giá tầm trung riêng cho mùa đông 2027 nhưng chưa thống nhất bán cho ai.

**Người liên quan**: đội mua hàng; đội thương mại điện tử; quản lý 30 cửa hàng; giám đốc kinh doanh duyệt. Chưa chốt nhóm khách mục tiêu: đội mua hàng đề xuất nhân viên văn phòng 25–35 tuổi, đội thương mại điện tử đề xuất sinh viên mới đi làm, quản lý cửa hàng ở tỉnh đề xuất phụ huynh mua cho cả nhà.

## Outcome

Doanh số áo khoác mùa đông 2027 cao hơn mùa đông 2026 (số mùa 2026: báo cáo bán hàng, đo; mức tăng mục tiêu chưa chốt vì phụ thuộc nhóm khách được chọn). Giới hạn: không giảm giá áo khoác hiện có. Tiêu chí dừng: sau 6 tuần mở bán, tỉ lệ bán hết dưới 30% thì dừng nhập thêm.

## Alternatives

- Không làm gì: bán tiếp dòng áo khoác hiện có cho mọi kiểu khách.
- Giảm giá dòng hiện có: đã làm mùa 2026, doanh số vẫn giảm.
- **Đã chọn**: ra một dòng áo khoác giá tầm trung riêng, nhắm vào một nhóm khách rõ ràng.

## AI-fit

Không dùng AI; mục này hoãn.

## Cost & Risk

Cỡ M (chưa qua kỹ thuật thẩm định). Chi phí chủ yếu là nhập hàng; số tiền chưa làm rõ.

## Clarifications

### Session 2026-11-12

- Q: Điều gì khiến bạn làm việc này? → A: Như phần vấn đề.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Khách mục tiêu tìm thấy dòng áo khoác mới (Priority: P1)

Nhóm khách được chọn thấy dòng áo mới ở cửa hàng và trên website.

**Acceptance Scenarios**:

1. **Given** dòng áo đã lên kệ, **When** khách thuộc nhóm mục tiêu vào cửa hàng, **Then** khách thấy dòng áo ở khu trưng bày chính

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: Dòng áo MUST có giá tầm trung.
- **FR-002**: Số mẫu, size và màu của đợt đầu chưa làm rõ, phụ thuộc nhóm khách được chọn.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Tỉ lệ bán hết sau 6 tuần từ 30% trở lên.

## Assumptions

- Giá tầm trung là khoảng giá khách của chuỗi chấp nhận được (giả định, chưa kiểm chứng).
VIBEBIZ_SEED_3
mkdir -p "$(dirname 'specs/001-fit-stp/decisions.md')"
cat > 'specs/001-fit-stp/decisions.md' <<'VIBEBIZ_SEED_4'
# Decisions: Dòng áo khoác giá tầm trung mùa đông 2027
VIBEBIZ_SEED_4
mkdir -p "$(dirname 'specs/001-fit-stp/assumptions.md')"
cat > 'specs/001-fit-stp/assumptions.md' <<'VIBEBIZ_SEED_5'
# Assumptions: Dòng áo khoác giá tầm trung mùa đông 2027
VIBEBIZ_SEED_5
mkdir -p "$(dirname 'specs/001-fit-stp/open-questions.md')"
cat > 'specs/001-fit-stp/open-questions.md' <<'VIBEBIZ_SEED_6'
# Open questions: Dòng áo khoác giá tầm trung mùa đông 2027
VIBEBIZ_SEED_6
mkdir -p "$(dirname 'specs/001-fit-stp/glossary.md')"
cat > 'specs/001-fit-stp/glossary.md' <<'VIBEBIZ_SEED_7'
# Glossary: Dòng áo khoác giá tầm trung mùa đông 2027
VIBEBIZ_SEED_7
mkdir -p "$(dirname 'specs/001-fit-stp/checklists/board.md')"
cat > 'specs/001-fit-stp/checklists/board.md' <<'VIBEBIZ_SEED_8'
# Definition of Ready: board
VIBEBIZ_SEED_8
mkdir -p "$(dirname 'specs/001-fit-stp/checklists/tech.md')"
cat > 'specs/001-fit-stp/checklists/tech.md' <<'VIBEBIZ_SEED_9'
# Definition of Ready: tech
VIBEBIZ_SEED_9
mkdir -p "$(dirname 'specs/001-fit-stp/diagrams/.keep')"
: > 'specs/001-fit-stp/diagrams/.keep'
mkdir -p "$(dirname 'specs/001-fit-stp/exports/.keep')"
: > 'specs/001-fit-stp/exports/.keep'
