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
mkdir -p "$(dirname 'specs/001-skip-sipoc/coverage.md')"
cat > 'specs/001-skip-sipoc/coverage.md' <<'VIBEBIZ_SEED_2'
---
id: "001"
slug: skip-sipoc
title: "Tư vấn size trên website"
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

# Coverage: Tư vấn size trên website

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
mkdir -p "$(dirname 'specs/001-skip-sipoc/spec.md')"
cat > 'specs/001-skip-sipoc/spec.md' <<'VIBEBIZ_SEED_3'
# Feature Specification: Tư vấn size trên website


## Problem & Why

Khách mua online chọn sai size nên trả hàng nhiều; khách tự chọn size trên trang sản phẩm, không có ai tư vấn. Người chịu thiệt là khách phải đổi trả và đội chăm sóc khách hàng xử lý đổi trả. Việc này xảy ra mỗi ngày.

**Người liên quan**: khách mua online; đội chăm sóc khách hàng; trưởng nhóm thương mại điện tử duyệt.

## Outcome

Giảm tỷ lệ trả hàng vì sai size trên website từ 18% xuống 12% trong 6 tháng (số 18%: báo cáo đổi trả quý 3/2026, đếm theo đơn hàng, đo). Giới hạn: tỷ lệ chuyển đổi không giảm dưới 2,1% (tháng 10/2026, đo). Chỉ số theo dõi sớm: tỷ lệ trả hàng vì sai size của khách có dùng gợi ý so với khách không dùng, đọc hằng tuần. Ngưỡng dừng: sau 8 tuần thử mà mức giảm chưa tới 2 điểm phần trăm thì dừng và xem lại.

## Alternatives

- Không làm gì: tỷ lệ trả hàng giữ nguyên.
- Sửa nội dung: thêm bảng size chi tiết. Đã có, khách ít đọc.
- Mua công cụ gợi ý size: đang so sánh giá.
- **Đã chọn**: gợi ý size trên trang sản phẩm dựa trên số đo khách nhập.

## Clarifications

### Session 2026-11-12

- Q: Điều gì khiến bạn làm việc này? → A: Tỷ lệ trả hàng vì sai size cao.
VIBEBIZ_SEED_3
mkdir -p "$(dirname 'specs/001-skip-sipoc/plan.md')"
cat > 'specs/001-skip-sipoc/plan.md' <<'VIBEBIZ_SEED_4'
# Plan: Tư vấn size trên website
VIBEBIZ_SEED_4
mkdir -p "$(dirname 'specs/001-skip-sipoc/decisions.md')"
cat > 'specs/001-skip-sipoc/decisions.md' <<'VIBEBIZ_SEED_5'
# Decisions: Tư vấn size trên website
VIBEBIZ_SEED_5
mkdir -p "$(dirname 'specs/001-skip-sipoc/assumptions.md')"
cat > 'specs/001-skip-sipoc/assumptions.md' <<'VIBEBIZ_SEED_6'
# Assumptions: Tư vấn size trên website
VIBEBIZ_SEED_6
mkdir -p "$(dirname 'specs/001-skip-sipoc/open-questions.md')"
cat > 'specs/001-skip-sipoc/open-questions.md' <<'VIBEBIZ_SEED_7'
# Open questions: Tư vấn size trên website
VIBEBIZ_SEED_7
mkdir -p "$(dirname 'specs/001-skip-sipoc/glossary.md')"
cat > 'specs/001-skip-sipoc/glossary.md' <<'VIBEBIZ_SEED_8'
# Glossary: Tư vấn size trên website
VIBEBIZ_SEED_8
mkdir -p "$(dirname 'specs/001-skip-sipoc/checklists/board.md')"
cat > 'specs/001-skip-sipoc/checklists/board.md' <<'VIBEBIZ_SEED_9'
# Definition of Ready: board
VIBEBIZ_SEED_9
mkdir -p "$(dirname 'specs/001-skip-sipoc/checklists/tech.md')"
cat > 'specs/001-skip-sipoc/checklists/tech.md' <<'VIBEBIZ_SEED_10'
# Definition of Ready: tech
VIBEBIZ_SEED_10
mkdir -p "$(dirname 'specs/001-skip-sipoc/diagrams/.keep')"
: > 'specs/001-skip-sipoc/diagrams/.keep'
mkdir -p "$(dirname 'specs/001-skip-sipoc/exports/.keep')"
: > 'specs/001-skip-sipoc/exports/.keep'
