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
mkdir -p "$(dirname 'specs/001-fit-tco/coverage.md')"
cat > 'specs/001-fit-tco/coverage.md' <<'VIBEBIZ_SEED_2'
---
id: "001"
slug: fit-tco
title: "Phần mềm đếm hàng tồn bằng máy quét cho cửa hàng"
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

# Coverage: Phần mềm đếm hàng tồn bằng máy quét cho cửa hàng

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
mkdir -p "$(dirname 'specs/001-fit-tco/spec.md')"
cat > 'specs/001-fit-tco/spec.md' <<'VIBEBIZ_SEED_3'
# Feature Specification: Phần mềm đếm hàng tồn bằng máy quét cho cửa hàng

**Created**: 2026-11-12

**Status**: Draft

## Problem & Why

Chuỗi giả định "Lụa Hồng" (30 cửa hàng thời trang nữ) đếm hàng tồn bằng giấy mỗi tháng; mỗi lần đếm một cửa hàng mất cả buổi tối và số đếm hay lệch với hệ thống. Ban giám đốc muốn đếm bằng máy quét cầm tay.

**Người liên quan**: nhân viên cửa hàng đếm hàng; quản lý cửa hàng; phòng vận hành; giám đốc tài chính duyệt.

## Outcome

Thời gian đếm hàng mỗi cửa hàng giảm và số lệch giữa hàng thật với hệ thống giảm trong năm 2027 (số hiện tại: báo cáo kiểm kê tháng 9/2026, đo; mức giảm mục tiêu chưa chốt). Giới hạn: không đóng cửa hàng để đếm. Tiêu chí dừng: sau 3 tháng ở cửa hàng thử mà thời gian đếm không giảm thì dừng.

## Alternatives

- Không làm gì: đếm bằng giấy như hiện tại.
- Tự làm phần mềm: đội kỹ thuật không rảnh trong năm 2027.
- **Đã chọn**: mua phần mềm của nhà cung cấp (D-001).

## AI-fit

Không dùng AI; mục này hoãn.

## Cost & Risk

Cỡ M (chưa qua kỹ thuật thẩm định). Giá mua bản quyền lần đầu theo báo giá nhà cung cấp tháng 10/2026 đã có trong hồ sơ báo giá. Chưa tính phí thuê bao hằng năm, máy quét, đào tạo nhân viên, thời gian nhân viên cửa hàng và phí hỗ trợ trong ba năm dùng; chưa có kịch bản thấp, cơ sở, cao.

## Clarifications

### Session 2026-11-12

- Q: Điều gì khiến bạn làm việc này? → A: Như phần vấn đề.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Nhân viên cửa hàng đếm hàng (Priority: P1)

**Acceptance Scenarios**:

1. **Given** cửa hàng có máy quét, **When** đến kỳ kiểm kê, **Then** nhân viên đếm xong và số lên hệ thống

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: Nhân viên MUST đếm hàng bằng máy quét cầm tay.
- **FR-002**: Tổng chi phí trong ba năm dùng chưa làm rõ.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Thời gian đếm và số lệch giảm như phần Outcome.

## Assumptions

- Nhà cung cấp giữ giá bản quyền trong năm 2027 (giả định, chưa kiểm chứng).
VIBEBIZ_SEED_3
mkdir -p "$(dirname 'specs/001-fit-tco/decisions.md')"
cat > 'specs/001-fit-tco/decisions.md' <<'VIBEBIZ_SEED_4'
# Decisions: Phần mềm đếm hàng tồn bằng máy quét cho cửa hàng

## D-001 — Mua phần mềm đếm hàng của nhà cung cấp

- date: 2026-11-12
- type: answer
- text: Mua phần mềm đếm hàng tồn bằng máy quét cầm tay của một nhà cung cấp có sẵn, không tự làm.
- reason: Giám đốc vận hành chọn sau khi xem bản chạy thử của nhà cung cấp.
VIBEBIZ_SEED_4
mkdir -p "$(dirname 'specs/001-fit-tco/assumptions.md')"
cat > 'specs/001-fit-tco/assumptions.md' <<'VIBEBIZ_SEED_5'
# Assumptions: Phần mềm đếm hàng tồn bằng máy quét cho cửa hàng
VIBEBIZ_SEED_5
mkdir -p "$(dirname 'specs/001-fit-tco/open-questions.md')"
cat > 'specs/001-fit-tco/open-questions.md' <<'VIBEBIZ_SEED_6'
# Open questions: Phần mềm đếm hàng tồn bằng máy quét cho cửa hàng
VIBEBIZ_SEED_6
mkdir -p "$(dirname 'specs/001-fit-tco/glossary.md')"
cat > 'specs/001-fit-tco/glossary.md' <<'VIBEBIZ_SEED_7'
# Glossary: Phần mềm đếm hàng tồn bằng máy quét cho cửa hàng
VIBEBIZ_SEED_7
mkdir -p "$(dirname 'specs/001-fit-tco/checklists/board.md')"
cat > 'specs/001-fit-tco/checklists/board.md' <<'VIBEBIZ_SEED_8'
# Definition of Ready: board
VIBEBIZ_SEED_8
mkdir -p "$(dirname 'specs/001-fit-tco/checklists/tech.md')"
cat > 'specs/001-fit-tco/checklists/tech.md' <<'VIBEBIZ_SEED_9'
# Definition of Ready: tech
VIBEBIZ_SEED_9
mkdir -p "$(dirname 'specs/001-fit-tco/diagrams/.keep')"
: > 'specs/001-fit-tco/diagrams/.keep'
mkdir -p "$(dirname 'specs/001-fit-tco/exports/.keep')"
: > 'specs/001-fit-tco/exports/.keep'
