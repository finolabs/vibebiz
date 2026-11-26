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
mkdir -p "$(dirname 'specs/001-fit-bcg-matrix/coverage.md')"
cat > 'specs/001-fit-bcg-matrix/coverage.md' <<'VIBEBIZ_SEED_2'
---
id: "001"
slug: fit-bcg-matrix
title: "Chia ngân sách nhập hàng 2027 giữa bốn dòng hàng"
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

# Coverage: Chia ngân sách nhập hàng 2027 giữa bốn dòng hàng

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
mkdir -p "$(dirname 'specs/001-fit-bcg-matrix/spec.md')"
cat > 'specs/001-fit-bcg-matrix/spec.md' <<'VIBEBIZ_SEED_3'
# Feature Specification: Chia ngân sách nhập hàng 2027 giữa bốn dòng hàng

**Created**: 2026-11-12

**Status**: Draft

## Problem & Why

Chuỗi giả định "Sông Lam" (25 cửa hàng thời trang công sở, có website) bán bốn dòng hàng hiện có: sơ mi, quần âu, váy công sở và áo khoác. Ngân sách nhập hàng năm 2027 không tăng, và ban giám đốc phải quyết dòng nào được thêm vốn, dòng nào giữ nguyên, dòng nào thu hẹp. Đội mua hàng nói sơ mi bán đều nhưng không còn tăng; váy công sở tăng nhanh nhưng chuỗi bán ít hơn các thương hiệu khác. Không có thị trường mới hay dòng hàng mới nào được đề xuất.

**Người liên quan**: ban giám đốc; đội mua hàng; giám đốc tài chính duyệt.

## Outcome

Biên lợi nhuận gộp năm 2027 cao hơn năm 2026 với cùng ngân sách nhập hàng (số 2026: báo cáo tài chính năm, đo; mức tăng mục tiêu chưa chốt). Giới hạn: không bỏ hẳn dòng nào trong năm 2027. Tiêu chí dừng: xem lại cách chia sau quý 2.

## Alternatives

- Không làm gì: chia ngân sách như năm 2026. Bị loại: biên lợi nhuận gộp không đổi.
- Chia đều cho bốn dòng. Bị loại: dồn thêm vốn vào dòng đã chững lại.
- Chia lại theo tốc độ tăng của thị trường và vị thế của chuỗi trong từng dòng. Được chọn (D-001).

## AI-fit

Không dùng AI; mục này hoãn.

## Cost & Risk

Cỡ L (chưa qua kỹ thuật thẩm định). Tổng ngân sách nhập hàng giữ như năm 2026; số tiền chưa ghi vào hồ sơ. Chưa có phần chia cho từng dòng (thêm vốn, giữ nguyên hay thu hẹp), chưa có kịch bản thấp, cơ sở, cao, và chưa ghi tốc độ tăng của thị trường hay vị thế của chuỗi trong từng dòng.

## Clarifications

### Session 2026-11-12

- Q: Điều gì khiến bạn làm việc này? → A: Như phần vấn đề.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Ban giám đốc chọn hướng tăng trưởng (Priority: P1)

**Acceptance Scenarios**:

1. **Given** các hướng đã được so sánh, **When** hội đồng họp, **Then** hội đồng chọn một hướng và ngân sách đi kèm

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: Kế hoạch MUST nêu cách chia ngân sách nhập hàng cho bốn dòng hiện có và lý do.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Doanh thu năm 2027 tăng so với năm 2026 (mức tăng mục tiêu như phần Outcome).

## Assumptions

- Sức mua ở thị trường hiện tại không giảm trong năm 2027 (giả định, chưa kiểm chứng).
VIBEBIZ_SEED_3
mkdir -p "$(dirname 'specs/001-fit-bcg-matrix/decisions.md')"
cat > 'specs/001-fit-bcg-matrix/decisions.md' <<'VIBEBIZ_SEED_4'
# Decisions: Chia ngân sách nhập hàng 2027 giữa bốn dòng hàng

## D-001 — Chia lại ngân sách theo từng dòng

- date: 2026-11-12
- type: answer
- text: Chia lại ngân sách nhập hàng 2027 theo tốc độ tăng của thị trường và vị thế của chuỗi trong từng dòng, thay vì chia như năm 2026 hay chia đều.
- reason: Ban giám đốc chọn trong buổi họp ngày 12/11/2026.
VIBEBIZ_SEED_4
mkdir -p "$(dirname 'specs/001-fit-bcg-matrix/assumptions.md')"
cat > 'specs/001-fit-bcg-matrix/assumptions.md' <<'VIBEBIZ_SEED_5'
# Assumptions: Chia ngân sách nhập hàng 2027 giữa bốn dòng hàng
VIBEBIZ_SEED_5
mkdir -p "$(dirname 'specs/001-fit-bcg-matrix/open-questions.md')"
cat > 'specs/001-fit-bcg-matrix/open-questions.md' <<'VIBEBIZ_SEED_6'
# Open questions: Chia ngân sách nhập hàng 2027 giữa bốn dòng hàng
VIBEBIZ_SEED_6
mkdir -p "$(dirname 'specs/001-fit-bcg-matrix/glossary.md')"
cat > 'specs/001-fit-bcg-matrix/glossary.md' <<'VIBEBIZ_SEED_7'
# Glossary: Chia ngân sách nhập hàng 2027 giữa bốn dòng hàng
VIBEBIZ_SEED_7
mkdir -p "$(dirname 'specs/001-fit-bcg-matrix/checklists/board.md')"
cat > 'specs/001-fit-bcg-matrix/checklists/board.md' <<'VIBEBIZ_SEED_8'
# Definition of Ready: board
VIBEBIZ_SEED_8
mkdir -p "$(dirname 'specs/001-fit-bcg-matrix/checklists/tech.md')"
cat > 'specs/001-fit-bcg-matrix/checklists/tech.md' <<'VIBEBIZ_SEED_9'
# Definition of Ready: tech
VIBEBIZ_SEED_9
mkdir -p "$(dirname 'specs/001-fit-bcg-matrix/diagrams/.keep')"
: > 'specs/001-fit-bcg-matrix/diagrams/.keep'
mkdir -p "$(dirname 'specs/001-fit-bcg-matrix/exports/.keep')"
: > 'specs/001-fit-bcg-matrix/exports/.keep'
