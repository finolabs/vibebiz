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
mkdir -p "$(dirname 'specs/001-fit-stage-gate/coverage.md')"
cat > 'specs/001-fit-stage-gate/coverage.md' <<'VIBEBIZ_SEED_2'
---
id: "001"
slug: fit-stage-gate
title: "Mở rộng quầy sửa đồ miễn phí ra 40 cửa hàng"
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

# Coverage: Mở rộng quầy sửa đồ miễn phí ra 40 cửa hàng

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
mkdir -p "$(dirname 'specs/001-fit-stage-gate/spec.md')"
cat > 'specs/001-fit-stage-gate/spec.md' <<'VIBEBIZ_SEED_3'
# Feature Specification: Mở rộng quầy sửa đồ miễn phí ra 40 cửa hàng

**Created**: 2026-11-12

**Status**: Draft

## Problem & Why

Chuỗi giả định "Lụa Hồng" (40 cửa hàng thời trang nữ) đã thử quầy sửa đồ miễn phí (lên gấu, bóp eo) ở 4 cửa hàng trong 12 tuần, từ tháng 7 đến tháng 9/2026. Khách mua quần âu và váy ở các cửa hàng thử ít trả hàng vì không vừa hơn.

**Người liên quan**: khách mua quần âu và váy; thợ sửa đồ; quản lý cửa hàng; giám đốc bán lẻ duyệt.

## Outcome

Tỉ lệ trả hàng vì không vừa của quần âu và váy giảm (kết quả thử: 4 cửa hàng thử giảm rõ so với 4 cửa hàng đối chứng, báo cáo bán hàng tháng 7 đến 9/2026, đo). Giới hạn: khách không chờ quá 30 phút. Tiêu chí dừng: một đợt mở rộng mà tỉ lệ trả hàng không giảm thì dừng đợt sau.

## Alternatives

- Không làm gì.
- Mở cả 36 cửa hàng còn lại cùng lúc: thiếu thợ và khó dừng nếu sai.
- **Đã chọn**: mở rộng theo từng đợt (D-001).

## AI-fit

Không dùng AI; mục này hoãn.

## Cost & Risk

Cỡ M (chưa qua kỹ thuật thẩm định). Chi phí một quầy ở cửa hàng thử: máy may và thợ bán thời gian (báo cáo chi phí thử, tháng 9/2026, đo). Chưa chia 36 cửa hàng còn lại thành các đợt, chưa có số tiền duyệt cho từng đợt, chưa có điều kiện đi tiếp hay dừng ở cuối mỗi đợt, chưa có kịch bản thấp, cơ sở, cao.

## Clarifications

### Session 2026-11-12

- Q: Điều gì khiến bạn làm việc này? → A: Như phần vấn đề.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Khách cần sửa đồ khi mua (Priority: P1)

**Acceptance Scenarios**:

1. **Given** khách mua quần âu hay váy chưa vừa, **When** khách nhờ sửa tại quầy, **Then** khách nhận đồ đã sửa trong 30 phút

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: Mỗi cửa hàng có quầy MUST sửa lên gấu và bóp eo miễn phí.
- **FR-002**: Các đợt mở rộng và điều kiện qua đợt chưa làm rõ.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Tỉ lệ trả hàng vì không vừa giảm như phần Outcome.

## Assumptions

- Tuyển đủ thợ bán thời gian cho mỗi đợt (giả định, chưa kiểm chứng).
VIBEBIZ_SEED_3
mkdir -p "$(dirname 'specs/001-fit-stage-gate/decisions.md')"
cat > 'specs/001-fit-stage-gate/decisions.md' <<'VIBEBIZ_SEED_4'
# Decisions: Mở rộng quầy sửa đồ miễn phí ra 40 cửa hàng

## D-001 — Mở rộng quầy sửa đồ theo từng đợt

- date: 2026-11-12
- type: answer
- text: Mở rộng quầy sửa đồ miễn phí từ 4 cửa hàng thử ra 40 cửa hàng, theo từng đợt, không mở cùng lúc.
- reason: Thử 12 tuần ở 4 cửa hàng đạt mục tiêu; giám đốc bán lẻ chọn sau buổi xem kết quả ngày 12/11/2026.
VIBEBIZ_SEED_4
mkdir -p "$(dirname 'specs/001-fit-stage-gate/assumptions.md')"
cat > 'specs/001-fit-stage-gate/assumptions.md' <<'VIBEBIZ_SEED_5'
# Assumptions: Mở rộng quầy sửa đồ miễn phí ra 40 cửa hàng
VIBEBIZ_SEED_5
mkdir -p "$(dirname 'specs/001-fit-stage-gate/open-questions.md')"
cat > 'specs/001-fit-stage-gate/open-questions.md' <<'VIBEBIZ_SEED_6'
# Open questions: Mở rộng quầy sửa đồ miễn phí ra 40 cửa hàng
VIBEBIZ_SEED_6
mkdir -p "$(dirname 'specs/001-fit-stage-gate/glossary.md')"
cat > 'specs/001-fit-stage-gate/glossary.md' <<'VIBEBIZ_SEED_7'
# Glossary: Mở rộng quầy sửa đồ miễn phí ra 40 cửa hàng
VIBEBIZ_SEED_7
mkdir -p "$(dirname 'specs/001-fit-stage-gate/checklists/board.md')"
cat > 'specs/001-fit-stage-gate/checklists/board.md' <<'VIBEBIZ_SEED_8'
# Definition of Ready: board
VIBEBIZ_SEED_8
mkdir -p "$(dirname 'specs/001-fit-stage-gate/checklists/tech.md')"
cat > 'specs/001-fit-stage-gate/checklists/tech.md' <<'VIBEBIZ_SEED_9'
# Definition of Ready: tech
VIBEBIZ_SEED_9
mkdir -p "$(dirname 'specs/001-fit-stage-gate/diagrams/.keep')"
: > 'specs/001-fit-stage-gate/diagrams/.keep'
mkdir -p "$(dirname 'specs/001-fit-stage-gate/exports/.keep')"
: > 'specs/001-fit-stage-gate/exports/.keep'
