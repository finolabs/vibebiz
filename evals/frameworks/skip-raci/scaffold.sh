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
mkdir -p "$(dirname 'specs/001-may-quet-ma-kiem-kho/coverage.md')"
cat > 'specs/001-may-quet-ma-kiem-kho/coverage.md' <<'VIBEBIZ_SEED_2'
---
id: "001"
slug: may-quet-ma-kiem-kho
title: "Máy quét mã kiểm kho cho nhân viên cửa hàng"
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

# Coverage: Máy quét mã kiểm kho cho nhân viên cửa hàng

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
mkdir -p "$(dirname 'specs/001-may-quet-ma-kiem-kho/spec.md')"
cat > 'specs/001-may-quet-ma-kiem-kho/spec.md' <<'VIBEBIZ_SEED_3'
# Feature Specification: Máy quét mã kiểm kho cho nhân viên cửa hàng

**Created**: 2026-11-12

**Status**: Draft

## Problem & Why

Chuỗi giả định "Mai Đào" (25 cửa hàng giày) cho nhân viên cửa hàng dùng máy quét mã để kiểm kho hằng tuần thay cho đếm tay. Lần thử máy quét năm 2025 ở 3 cửa hàng, nhân viên vẫn đếm tay vì sợ máy báo thiếu hàng thì bị trừ lương.

**Người liên quan**: nhân viên cửa hàng làm kiểm kho; quản lý cửa hàng duyệt kết quả, như hiện nay.

## Outcome

Thời gian kiểm kho mỗi tuần giảm từ khoảng 4 giờ xuống 1 giờ mỗi cửa hàng (ước tính). Giới hạn: sai lệch tồn kho không tăng.

## Alternatives

- Không làm gì.
- **Đã chọn**: dùng máy quét (D-001).

## AI-fit

Không dùng AI; mục này hoãn.

## Cost & Risk

Cỡ S (chưa qua kỹ thuật thẩm định). Chưa có kế hoạch giúp nhân viên chịu dùng máy quét, chưa rõ quy định trừ lương khi thiếu hàng có đổi không.

## Clarifications

### Session 2026-11-12

- Q: Điều gì khiến bạn làm việc này? → A: Như phần vấn đề.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Nhân viên kiểm kho bằng máy quét (Priority: P1)

**Acceptance Scenarios**:

1. **Given** nhân viên bắt đầu kiểm kho, **When** quét hết các kệ, **Then** kết quả gửi cho quản lý cửa hàng duyệt

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: Nhân viên cửa hàng MUST kiểm kho bằng máy quét mỗi tuần.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Như phần Outcome.

## Assumptions

- Chưa có giả định nào được ghi.
VIBEBIZ_SEED_3
mkdir -p "$(dirname 'specs/001-may-quet-ma-kiem-kho/decisions.md')"
cat > 'specs/001-may-quet-ma-kiem-kho/decisions.md' <<'VIBEBIZ_SEED_4'
# Decisions: Máy quét mã kiểm kho cho nhân viên cửa hàng

## D-001 — Dùng máy quét kiểm kho

- date: 2026-11-12
- type: answer
- text: Thay đếm tay bằng máy quét mã ở cả 25 cửa hàng.
- reason: Giám đốc vận hành chọn ngày 12/11/2026.
VIBEBIZ_SEED_4
mkdir -p "$(dirname 'specs/001-may-quet-ma-kiem-kho/assumptions.md')"
cat > 'specs/001-may-quet-ma-kiem-kho/assumptions.md' <<'VIBEBIZ_SEED_5'
# Assumptions: Máy quét mã kiểm kho cho nhân viên cửa hàng
VIBEBIZ_SEED_5
mkdir -p "$(dirname 'specs/001-may-quet-ma-kiem-kho/open-questions.md')"
cat > 'specs/001-may-quet-ma-kiem-kho/open-questions.md' <<'VIBEBIZ_SEED_6'
# Open questions: Máy quét mã kiểm kho cho nhân viên cửa hàng
VIBEBIZ_SEED_6
mkdir -p "$(dirname 'specs/001-may-quet-ma-kiem-kho/glossary.md')"
cat > 'specs/001-may-quet-ma-kiem-kho/glossary.md' <<'VIBEBIZ_SEED_7'
# Glossary: Máy quét mã kiểm kho cho nhân viên cửa hàng
VIBEBIZ_SEED_7
mkdir -p "$(dirname 'specs/001-may-quet-ma-kiem-kho/checklists/board.md')"
cat > 'specs/001-may-quet-ma-kiem-kho/checklists/board.md' <<'VIBEBIZ_SEED_8'
# Definition of Ready: board
VIBEBIZ_SEED_8
mkdir -p "$(dirname 'specs/001-may-quet-ma-kiem-kho/checklists/tech.md')"
cat > 'specs/001-may-quet-ma-kiem-kho/checklists/tech.md' <<'VIBEBIZ_SEED_9'
# Definition of Ready: tech
VIBEBIZ_SEED_9
mkdir -p "$(dirname 'specs/001-may-quet-ma-kiem-kho/diagrams/.keep')"
: > 'specs/001-may-quet-ma-kiem-kho/diagrams/.keep'
mkdir -p "$(dirname 'specs/001-may-quet-ma-kiem-kho/exports/.keep')"
: > 'specs/001-may-quet-ma-kiem-kho/exports/.keep'
