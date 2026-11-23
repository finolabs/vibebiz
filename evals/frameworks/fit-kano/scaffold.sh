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
mkdir -p "$(dirname 'specs/001-fit-kano/coverage.md')"
cat > 'specs/001-fit-kano/coverage.md' <<'VIBEBIZ_SEED_2'
---
id: "001"
slug: fit-kano
title: "Nâng cấp ứng dụng mua sắm"
language: vi
vertical: fashion
cynefin: complicated
status: clarifying
estimate_status: not-tech-reviewed
budget_rounds_used: 0
latest_export: null
next_step: "Hỏi tiếp"
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
    status: missing
    reason: null
    prerequisites: [E]
    filled_by: solution-sketch
    frameworks: []
    updated: "2026-11-12"
  G:
    status: missing
    reason: null
    prerequisites: [E]
    filled_by: clarify
    frameworks: []
    updated: "2026-11-12"
  H:
    status: missing
    reason: null
    prerequisites: [E, G]
    filled_by: clarify
    frameworks: []
    updated: "2026-11-12"
  I:
    status: missing
    reason: null
    prerequisites: [E]
    filled_by: solution-sketch
    frameworks: []
    updated: "2026-11-12"
  J:
    status: missing
    reason: null
    prerequisites: [E]
    filled_by: solution-sketch
    frameworks: []
    updated: "2026-11-12"
  K:
    status: missing
    reason: null
    prerequisites: [E, G]
    filled_by: challenge
    frameworks: []
    updated: "2026-11-12"
  L:
    status: missing
    reason: null
    prerequisites: [B, E]
    filled_by: solution-sketch
    frameworks: []
    updated: "2026-11-12"
  M:
    status: missing
    reason: null
    prerequisites: [C, D, E]
    filled_by: challenge, plan
    frameworks: []
    updated: "2026-11-12"
  N:
    status: missing
    reason: null
    prerequisites: []
    filled_by: clarify
    frameworks: []
    updated: "2026-11-12"
  O:
    status: missing
    reason: null
    prerequisites: [C, E]
    filled_by: outcome
    frameworks: []
    updated: "2026-11-12"
---

# Coverage: Nâng cấp ứng dụng mua sắm

| Code | Category | Status | Reason (when deferred) | Updated |
|---|---|---|---|---|
| A | Problem and why | clear |  | 2026-11-12 |
| B | Users and stakeholders | clear |  | 2026-11-12 |
| C | Outcome and measurement | clear |  | 2026-11-12 |
| D | Alternatives | clear |  | 2026-11-12 |
| E | Scope and behavior | partial |  | 2026-11-12 |
| F | AI fit | missing |  | 2026-11-12 |
| G | Data and entities | missing |  | 2026-11-12 |
| H | Integrations | missing |  | 2026-11-12 |
| I | Non-functional needs | missing |  | 2026-11-12 |
| J | Edge cases and failures | missing |  | 2026-11-12 |
| K | Risk and compliance | missing |  | 2026-11-12 |
| L | Organizational change | missing |  | 2026-11-12 |
| M | Cost, resources and return | missing |  | 2026-11-12 |
| N | Terminology | missing |  | 2026-11-12 |
| O | Completion signals | missing |  | 2026-11-12 |

**Clear**: 4 of 15
VIBEBIZ_SEED_2
mkdir -p "$(dirname 'specs/001-fit-kano/spec.md')"
cat > 'specs/001-fit-kano/spec.md' <<'VIBEBIZ_SEED_3'
# Feature Specification: Nâng cấp ứng dụng mua sắm


## Problem & Why

Ứng dụng mua sắm của chuỗi Lụa Xanh có lượt mở giảm từ đầu năm 2026; khách nói ứng dụng chậm và thiếu tiện ích. Khảo sát 250 khách tháng 9/2026 đã gắn mỗi tính năng dự kiến với một nỗi khổ: thanh toán một chạm, theo dõi đơn, lưu số đo, thử đồ bằng ảnh, đổi điểm lấy quà, đặt giữ hàng ở cửa hàng, chat với stylist. Người chịu thiệt là khách dùng ứng dụng và doanh số kênh ứng dụng. Việc này kéo dài nhiều tháng.

**Người liên quan**: khách dùng ứng dụng; đội sản phẩm số; giám đốc marketing duyệt.

## Outcome

Tăng số khách mua qua ứng dụng mỗi tháng từ 4.000 lên 5.500 trong 6 tháng (số 4.000: báo cáo ứng dụng tháng 10/2026, đo). Giới hạn: điểm đánh giá ứng dụng không giảm. Ngưỡng dừng: sau 3 tháng không tăng thì dừng.

## Alternatives

- Không làm gì: lượt mở tiếp tục giảm.
- Chỉ sửa lỗi chậm: cần làm nhưng không đủ.
- **Đã chọn**: nâng cấp ứng dụng với một nhóm tính năng mới.

## Clarifications

### Session 2026-11-12

- Q: Điều gì khiến bạn làm việc này? → A: Khách mở ứng dụng ít dần.
VIBEBIZ_SEED_3
mkdir -p "$(dirname 'specs/001-fit-kano/plan.md')"
cat > 'specs/001-fit-kano/plan.md' <<'VIBEBIZ_SEED_4'
# Plan: Nâng cấp ứng dụng mua sắm
VIBEBIZ_SEED_4
mkdir -p "$(dirname 'specs/001-fit-kano/decisions.md')"
cat > 'specs/001-fit-kano/decisions.md' <<'VIBEBIZ_SEED_5'
# Decisions: Nâng cấp ứng dụng mua sắm
VIBEBIZ_SEED_5
mkdir -p "$(dirname 'specs/001-fit-kano/assumptions.md')"
cat > 'specs/001-fit-kano/assumptions.md' <<'VIBEBIZ_SEED_6'
# Assumptions: Nâng cấp ứng dụng mua sắm
VIBEBIZ_SEED_6
mkdir -p "$(dirname 'specs/001-fit-kano/open-questions.md')"
cat > 'specs/001-fit-kano/open-questions.md' <<'VIBEBIZ_SEED_7'
# Open questions: Nâng cấp ứng dụng mua sắm
VIBEBIZ_SEED_7
mkdir -p "$(dirname 'specs/001-fit-kano/glossary.md')"
cat > 'specs/001-fit-kano/glossary.md' <<'VIBEBIZ_SEED_8'
# Glossary: Nâng cấp ứng dụng mua sắm
VIBEBIZ_SEED_8
mkdir -p "$(dirname 'specs/001-fit-kano/checklists/board.md')"
cat > 'specs/001-fit-kano/checklists/board.md' <<'VIBEBIZ_SEED_9'
# Definition of Ready: board
VIBEBIZ_SEED_9
mkdir -p "$(dirname 'specs/001-fit-kano/checklists/tech.md')"
cat > 'specs/001-fit-kano/checklists/tech.md' <<'VIBEBIZ_SEED_10'
# Definition of Ready: tech
VIBEBIZ_SEED_10
mkdir -p "$(dirname 'specs/001-fit-kano/diagrams/.keep')"
: > 'specs/001-fit-kano/diagrams/.keep'
mkdir -p "$(dirname 'specs/001-fit-kano/exports/.keep')"
: > 'specs/001-fit-kano/exports/.keep'
