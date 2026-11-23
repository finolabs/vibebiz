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
mkdir -p "$(dirname 'specs/001-tu-van-phoi-do-video/coverage.md')"
cat > 'specs/001-tu-van-phoi-do-video/coverage.md' <<'VIBEBIZ_SEED_2'
---
id: "001"
slug: tu-van-phoi-do-video
title: "Tư vấn phối đồ qua video cho khách online"
language: vi
vertical: fashion
cynefin: complex
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

# Coverage: Tư vấn phối đồ qua video cho khách online

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
mkdir -p "$(dirname 'specs/001-tu-van-phoi-do-video/spec.md')"
cat > 'specs/001-tu-van-phoi-do-video/spec.md' <<'VIBEBIZ_SEED_3'
# Feature Specification: Tư vấn phối đồ qua video cho khách online

**Created**: 2026-11-12

**Status**: Draft

## Problem & Why

Chuỗi giả định "Lụa Hồng" (40 cửa hàng thời trang nữ) muốn cho khách online gọi video với nhân viên cửa hàng để được tư vấn phối đồ trước khi mua. Chưa thử ở đâu; chưa biết khách có gọi không và có mua nhiều hơn không.

**Người liên quan**: khách mua online; nhân viên tư vấn ở cửa hàng; đội online; giám đốc kinh doanh online duyệt.

## Outcome

Giá trị đơn online trung bình tăng (số hiện tại: báo cáo online tháng 10/2026, đo; mức tăng mục tiêu chưa chốt). Giới hạn: nhân viên cửa hàng không bỏ khách tại quầy để nghe gọi. Tiêu chí dừng: chưa chốt.

## Alternatives

- Không làm gì.
- Tư vấn qua tin nhắn như hiện tại.
- **Đã chọn**: thử tư vấn qua video.

## AI-fit

Không dùng AI; mục này hoãn.

## Cost & Risk

Cỡ M (chưa qua kỹ thuật thẩm định). Chưa có thiết kế thử nghiệm, chưa có chi phí hay lợi ích.

## Clarifications

### Session 2026-11-12

- Q: Điều gì khiến bạn làm việc này? → A: Như phần vấn đề.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Khách online gọi video để được tư vấn (Priority: P1)

**Acceptance Scenarios**:

1. **Given** khách xem một món trên website, **When** khách bấm gọi video, **Then** nhân viên tư vấn và khách đặt đơn

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: Khách MUST gọi được video với nhân viên trong giờ cửa hàng mở.
- **FR-002**: Cách thử và đo tác dụng chưa làm rõ.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Giá trị đơn online trung bình tăng như phần Outcome.

## Assumptions

- Khách online sẵn lòng bật video khi mua đồ (giả định, chưa kiểm chứng).
VIBEBIZ_SEED_3
mkdir -p "$(dirname 'specs/001-tu-van-phoi-do-video/decisions.md')"
cat > 'specs/001-tu-van-phoi-do-video/decisions.md' <<'VIBEBIZ_SEED_4'
# Decisions: Tư vấn phối đồ qua video cho khách online
VIBEBIZ_SEED_4
mkdir -p "$(dirname 'specs/001-tu-van-phoi-do-video/assumptions.md')"
cat > 'specs/001-tu-van-phoi-do-video/assumptions.md' <<'VIBEBIZ_SEED_5'
# Assumptions: Tư vấn phối đồ qua video cho khách online
VIBEBIZ_SEED_5
mkdir -p "$(dirname 'specs/001-tu-van-phoi-do-video/open-questions.md')"
cat > 'specs/001-tu-van-phoi-do-video/open-questions.md' <<'VIBEBIZ_SEED_6'
# Open questions: Tư vấn phối đồ qua video cho khách online
VIBEBIZ_SEED_6
mkdir -p "$(dirname 'specs/001-tu-van-phoi-do-video/glossary.md')"
cat > 'specs/001-tu-van-phoi-do-video/glossary.md' <<'VIBEBIZ_SEED_7'
# Glossary: Tư vấn phối đồ qua video cho khách online
VIBEBIZ_SEED_7
mkdir -p "$(dirname 'specs/001-tu-van-phoi-do-video/checklists/board.md')"
cat > 'specs/001-tu-van-phoi-do-video/checklists/board.md' <<'VIBEBIZ_SEED_8'
# Definition of Ready: board
VIBEBIZ_SEED_8
mkdir -p "$(dirname 'specs/001-tu-van-phoi-do-video/checklists/tech.md')"
cat > 'specs/001-tu-van-phoi-do-video/checklists/tech.md' <<'VIBEBIZ_SEED_9'
# Definition of Ready: tech
VIBEBIZ_SEED_9
mkdir -p "$(dirname 'specs/001-tu-van-phoi-do-video/diagrams/.keep')"
: > 'specs/001-tu-van-phoi-do-video/diagrams/.keep'
mkdir -p "$(dirname 'specs/001-tu-van-phoi-do-video/exports/.keep')"
: > 'specs/001-tu-van-phoi-do-video/exports/.keep'
