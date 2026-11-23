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
mkdir -p "$(dirname 'specs/001-fit-ansoff/coverage.md')"
cat > 'specs/001-fit-ansoff/coverage.md' <<'VIBEBIZ_SEED_2'
---
id: "001"
slug: fit-ansoff
title: "Hướng tăng doanh thu năm 2027"
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

# Coverage: Hướng tăng doanh thu năm 2027

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
| M | Cost, resources and return | clear |  | 2026-11-12 |
| N | Terminology | clear |  | 2026-11-12 |
| O | Completion signals | clear |  | 2026-11-12 |

**Clear**: 13 of 15
VIBEBIZ_SEED_2
mkdir -p "$(dirname 'specs/001-fit-ansoff/spec.md')"
cat > 'specs/001-fit-ansoff/spec.md' <<'VIBEBIZ_SEED_3'
# Feature Specification: Hướng tăng doanh thu năm 2027

**Created**: 2026-11-12

**Status**: Draft

## Problem & Why

Chuỗi giả định "Sông Lam" (25 cửa hàng thời trang công sở ở miền Bắc, có website) có doanh thu năm 2026 đi ngang so với năm 2025 (báo cáo tài chính năm, đo). Ban giám đốc muốn doanh thu năm 2027 tăng nhưng mỗi người đề xuất một hướng: giám đốc vận hành muốn mở cửa hàng ở miền Trung; đội mua hàng muốn thêm dòng đồ trẻ em cho khách hiện tại; đội marketing muốn bán nhiều hơn cho khách quen ở 25 cửa hàng hiện có.

**Người liên quan**: ban giám đốc; đội vận hành; đội mua hàng; đội marketing.

## Outcome

Doanh thu năm 2027 tăng 15% so với năm 2026 (số 2026: báo cáo tài chính năm, đo; mức 15% là mục tiêu ban giám đốc đặt). Giới hạn: biên lợi nhuận gộp không giảm. Tiêu chí dừng: sau hai quý, doanh thu hướng mới chưa bù được chi phí đã bỏ ra thì dừng mở rộng.

## Alternatives

- Không làm gì: doanh thu đi ngang.
- Mở cửa hàng ở miền Trung (đề xuất của giám đốc vận hành).

Các hướng khác (dòng đồ trẻ em, bán thêm cho khách quen) mới được nêu miệng, chưa ai so sánh các hướng với nhau.

## AI-fit

Không dùng AI; mục này hoãn.

## Cost & Risk

Cỡ L (chưa qua kỹ thuật thẩm định). Số tiền chưa làm rõ.

## Clarifications

### Session 2026-11-12

- Q: Điều gì khiến bạn làm việc này? → A: Như phần vấn đề.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Ban giám đốc chọn hướng tăng trưởng (Priority: P1)

**Acceptance Scenarios**:

1. **Given** các hướng đã được so sánh, **When** hội đồng họp, **Then** hội đồng chọn một hướng và ngân sách đi kèm

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: Kế hoạch MUST nêu một hướng tăng trưởng chính và lý do chọn.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Doanh thu năm 2027 tăng so với năm 2026 (mức tăng mục tiêu như phần Outcome).

## Assumptions

- Sức mua ở thị trường hiện tại không giảm trong năm 2027 (giả định, chưa kiểm chứng).
VIBEBIZ_SEED_3
mkdir -p "$(dirname 'specs/001-fit-ansoff/decisions.md')"
cat > 'specs/001-fit-ansoff/decisions.md' <<'VIBEBIZ_SEED_4'
# Decisions: Hướng tăng doanh thu năm 2027
VIBEBIZ_SEED_4
mkdir -p "$(dirname 'specs/001-fit-ansoff/assumptions.md')"
cat > 'specs/001-fit-ansoff/assumptions.md' <<'VIBEBIZ_SEED_5'
# Assumptions: Hướng tăng doanh thu năm 2027
VIBEBIZ_SEED_5
mkdir -p "$(dirname 'specs/001-fit-ansoff/open-questions.md')"
cat > 'specs/001-fit-ansoff/open-questions.md' <<'VIBEBIZ_SEED_6'
# Open questions: Hướng tăng doanh thu năm 2027
VIBEBIZ_SEED_6
mkdir -p "$(dirname 'specs/001-fit-ansoff/glossary.md')"
cat > 'specs/001-fit-ansoff/glossary.md' <<'VIBEBIZ_SEED_7'
# Glossary: Hướng tăng doanh thu năm 2027
VIBEBIZ_SEED_7
mkdir -p "$(dirname 'specs/001-fit-ansoff/checklists/board.md')"
cat > 'specs/001-fit-ansoff/checklists/board.md' <<'VIBEBIZ_SEED_8'
# Definition of Ready: board
VIBEBIZ_SEED_8
mkdir -p "$(dirname 'specs/001-fit-ansoff/checklists/tech.md')"
cat > 'specs/001-fit-ansoff/checklists/tech.md' <<'VIBEBIZ_SEED_9'
# Definition of Ready: tech
VIBEBIZ_SEED_9
mkdir -p "$(dirname 'specs/001-fit-ansoff/diagrams/.keep')"
: > 'specs/001-fit-ansoff/diagrams/.keep'
mkdir -p "$(dirname 'specs/001-fit-ansoff/exports/.keep')"
: > 'specs/001-fit-ansoff/exports/.keep'
