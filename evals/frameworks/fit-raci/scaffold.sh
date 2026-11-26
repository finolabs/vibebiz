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
mkdir -p "$(dirname 'specs/001-doi-tra-online-tai-cua-hang/coverage.md')"
cat > 'specs/001-doi-tra-online-tai-cua-hang/coverage.md' <<'VIBEBIZ_SEED_2'
---
id: "001"
slug: doi-tra-online-tai-cua-hang
title: "Đổi trả đơn online tại cửa hàng"
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

# Coverage: Đổi trả đơn online tại cửa hàng

| Code | Category | Status | Reason (when deferred) | Updated |
|---|---|---|---|---|
| A | Problem and why | clear |  | 2026-11-12 |
| B | Users and stakeholders | partial |  | 2026-11-12 |
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

**Clear**: 12 of 15
VIBEBIZ_SEED_2
mkdir -p "$(dirname 'specs/001-doi-tra-online-tai-cua-hang/spec.md')"
cat > 'specs/001-doi-tra-online-tai-cua-hang/spec.md' <<'VIBEBIZ_SEED_3'
# Feature Specification: Đổi trả đơn online tại cửa hàng

**Created**: 2026-11-12

**Status**: Draft

## Problem & Why

Chuỗi giả định "Sen Vàng" (30 cửa hàng thời trang nam) muốn cho khách mua online trả hàng tại bất kỳ cửa hàng nào. Hiện khách phải gửi bưu điện, chờ khoảng 5 ngày mới được hoàn tiền (ước tính của bộ phận chăm sóc khách online). Hai lần thử trước ở 2 cửa hàng đều dừng vì cửa hàng chờ bộ phận online, bộ phận online chờ kế toán, và không ai biết ai quyết món hàng hỏng là lỗi của khách.

**Người liên quan**: khách mua online; nhân viên cửa hàng; bộ phận chăm sóc khách online; kho; kế toán. Chưa rõ ai duyệt hoàn tiền và ai quyết hàng hỏng.

## Outcome

Thời gian hoàn tiền giảm từ khoảng 5 ngày xuống 2 ngày trong 3 tháng (ước tính). Giới hạn: tỉ lệ hoàn tiền sai không tăng.

## Alternatives

- Không làm gì.
- **Đã chọn**: cho trả tại cửa hàng với quy trình chung (D-001).

## AI-fit

Không dùng AI; mục này hoãn.

## Cost & Risk

Cỡ S (chưa qua kỹ thuật thẩm định). Chưa có người chịu trách nhiệm cho từng bước, chưa có ai được hỏi trước hay báo sau, chưa có kế hoạch đào tạo cho nhân viên cửa hàng.

## Clarifications

### Session 2026-11-12

- Q: Điều gì khiến bạn làm việc này? → A: Như phần vấn đề.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Khách trả đơn online tại cửa hàng (Priority: P1)

**Acceptance Scenarios**:

1. **Given** khách mua online mang hàng tới cửa hàng, **When** nhân viên kiểm hàng đạt, **Then** khách được hoàn tiền trong 2 ngày

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: Cửa hàng MUST nhận hàng trả của đơn online.
- **FR-002**: Người duyệt hoàn tiền ở từng bước chưa làm rõ.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Như phần Outcome.

## Assumptions

- Chưa có giả định nào được ghi.
VIBEBIZ_SEED_3
mkdir -p "$(dirname 'specs/001-doi-tra-online-tai-cua-hang/decisions.md')"
cat > 'specs/001-doi-tra-online-tai-cua-hang/decisions.md' <<'VIBEBIZ_SEED_4'
# Decisions: Đổi trả đơn online tại cửa hàng

## D-001 — Cho trả đơn online tại cửa hàng

- date: 2026-11-12
- type: answer
- text: Cho khách trả hàng mua online tại mọi cửa hàng.
- reason: Giám đốc bán lẻ chọn ngày 12/11/2026 sau hai lần thử dừng giữa chừng.
VIBEBIZ_SEED_4
mkdir -p "$(dirname 'specs/001-doi-tra-online-tai-cua-hang/assumptions.md')"
cat > 'specs/001-doi-tra-online-tai-cua-hang/assumptions.md' <<'VIBEBIZ_SEED_5'
# Assumptions: Đổi trả đơn online tại cửa hàng
VIBEBIZ_SEED_5
mkdir -p "$(dirname 'specs/001-doi-tra-online-tai-cua-hang/open-questions.md')"
cat > 'specs/001-doi-tra-online-tai-cua-hang/open-questions.md' <<'VIBEBIZ_SEED_6'
# Open questions: Đổi trả đơn online tại cửa hàng
VIBEBIZ_SEED_6
mkdir -p "$(dirname 'specs/001-doi-tra-online-tai-cua-hang/glossary.md')"
cat > 'specs/001-doi-tra-online-tai-cua-hang/glossary.md' <<'VIBEBIZ_SEED_7'
# Glossary: Đổi trả đơn online tại cửa hàng
VIBEBIZ_SEED_7
mkdir -p "$(dirname 'specs/001-doi-tra-online-tai-cua-hang/checklists/board.md')"
cat > 'specs/001-doi-tra-online-tai-cua-hang/checklists/board.md' <<'VIBEBIZ_SEED_8'
# Definition of Ready: board
VIBEBIZ_SEED_8
mkdir -p "$(dirname 'specs/001-doi-tra-online-tai-cua-hang/checklists/tech.md')"
cat > 'specs/001-doi-tra-online-tai-cua-hang/checklists/tech.md' <<'VIBEBIZ_SEED_9'
# Definition of Ready: tech
VIBEBIZ_SEED_9
mkdir -p "$(dirname 'specs/001-doi-tra-online-tai-cua-hang/diagrams/.keep')"
: > 'specs/001-doi-tra-online-tai-cua-hang/diagrams/.keep'
mkdir -p "$(dirname 'specs/001-doi-tra-online-tai-cua-hang/exports/.keep')"
: > 'specs/001-doi-tra-online-tai-cua-hang/exports/.keep'
