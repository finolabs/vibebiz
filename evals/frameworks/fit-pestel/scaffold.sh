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
mkdir -p "$(dirname 'specs/001-fit-pestel/coverage.md')"
cat > 'specs/001-fit-pestel/coverage.md' <<'VIBEBIZ_SEED_2'
---
id: "001"
slug: fit-pestel
title: "Bán hàng online cho khách ở nước láng giềng"
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
    status: clear
    reason: null
    prerequisites: [C, D]
    filled_by: solution-sketch
    frameworks: []
    updated: "2026-11-12"
  F:
    status: clear
    reason: null
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
    status: partial
    reason: null
    prerequisites: [E, G]
    filled_by: challenge
    frameworks: []
    updated: "2026-11-12"
  L:
    status: deferred
    reason: "Người dùng để sau, chưa cần cho vòng này"
    prerequisites: [B, E]
    filled_by: solution-sketch
    frameworks: []
    updated: "2026-11-12"
  M:
    status: deferred
    reason: "Người dùng để sau, chưa cần cho vòng này"
    prerequisites: [C, D, E]
    filled_by: challenge, plan
    frameworks: []
    updated: "2026-11-12"
  N:
    status: deferred
    reason: "Người dùng để sau, chưa cần cho vòng này"
    prerequisites: []
    filled_by: clarify
    frameworks: []
    updated: "2026-11-12"
  O:
    status: deferred
    reason: "Người dùng để sau, chưa cần cho vòng này"
    prerequisites: [C, E]
    filled_by: outcome
    frameworks: []
    updated: "2026-11-12"
---

# Coverage: Bán hàng online cho khách ở nước láng giềng

| Code | Category | Status | Reason (when deferred) | Updated |
|---|---|---|---|---|
| A | Problem and why | clear |  | 2026-11-12 |
| B | Users and stakeholders | clear |  | 2026-11-12 |
| C | Outcome and measurement | clear |  | 2026-11-12 |
| D | Alternatives | clear |  | 2026-11-12 |
| E | Scope and behavior | clear |  | 2026-11-12 |
| F | AI fit | clear |  | 2026-11-12 |
| G | Data and entities | clear |  | 2026-11-12 |
| H | Integrations | clear |  | 2026-11-12 |
| I | Non-functional needs | clear |  | 2026-11-12 |
| J | Edge cases and failures | clear |  | 2026-11-12 |
| K | Risk and compliance | partial |  | 2026-11-12 |
| L | Organizational change | deferred | Người dùng để sau, chưa cần cho vòng này | 2026-11-12 |
| M | Cost, resources and return | deferred | Người dùng để sau, chưa cần cho vòng này | 2026-11-12 |
| N | Terminology | deferred | Người dùng để sau, chưa cần cho vòng này | 2026-11-12 |
| O | Completion signals | deferred | Người dùng để sau, chưa cần cho vòng này | 2026-11-12 |

**Clear**: 10 of 15
VIBEBIZ_SEED_2
mkdir -p "$(dirname 'specs/001-fit-pestel/spec.md')"
cat > 'specs/001-fit-pestel/spec.md' <<'VIBEBIZ_SEED_3'
# Feature Specification: Bán hàng online cho khách ở nước láng giềng


## Problem & Why

Mỗi tuần fanpage của chuỗi Mây Hồng nhận vài chục tin nhắn từ khách ở nước láng giềng hỏi mua, nhưng công ty phải từ chối vì không giao hàng ra nước ngoài. Người chịu thiệt là đội bán hàng online mất đơn. Việc này kéo dài từ đầu năm 2026.

**Người liên quan**: khách ở nước láng giềng; đội bán hàng online; kế toán; giám đốc thương mại duyệt.

## Outcome

Có đơn đầu tiên từ nước láng giềng trong 3 tháng và đạt 200 đơn mỗi tháng sau 9 tháng (hiện 0 đơn). Giới hạn: tỷ lệ hoàn hàng quốc tế không quá mức hoàn trong nước. Ngưỡng dừng: sau 6 tháng dưới 50 đơn mỗi tháng thì dừng.

## Alternatives

- Không làm gì: tiếp tục từ chối khách.
- Bán qua sàn quốc tế: phí cao, đã hỏi giá.
- **Đã chọn**: nhận đơn trên website, giao qua một đơn vị vận chuyển quốc tế.

## User Scenarios & Testing

Khách ở nước láng giềng đặt hàng trên website, trả bằng thẻ, nhận hàng trong 7 ngày qua đơn vị vận chuyển quốc tế. Ngoài phạm vi bản đầu: đổi trả tại chỗ, cửa hàng bên đó.

## Key Entities

Đơn hàng quốc tế; khách hàng (tên, địa chỉ, số điện thoại, email); phiếu vận chuyển. Dữ liệu nằm trong hệ thống website hiện có.

## Clarifications

### Session 2026-11-12

- Q: Điều gì khiến bạn làm việc này? → A: Khách nước ngoài hỏi mua mà không bán được.
VIBEBIZ_SEED_3
mkdir -p "$(dirname 'specs/001-fit-pestel/plan.md')"
cat > 'specs/001-fit-pestel/plan.md' <<'VIBEBIZ_SEED_4'
# Plan: Bán hàng online cho khách ở nước láng giềng
VIBEBIZ_SEED_4
mkdir -p "$(dirname 'specs/001-fit-pestel/decisions.md')"
cat > 'specs/001-fit-pestel/decisions.md' <<'VIBEBIZ_SEED_5'
# Decisions: Bán hàng online cho khách ở nước láng giềng
VIBEBIZ_SEED_5
mkdir -p "$(dirname 'specs/001-fit-pestel/assumptions.md')"
cat > 'specs/001-fit-pestel/assumptions.md' <<'VIBEBIZ_SEED_6'
# Assumptions: Bán hàng online cho khách ở nước láng giềng
VIBEBIZ_SEED_6
mkdir -p "$(dirname 'specs/001-fit-pestel/open-questions.md')"
cat > 'specs/001-fit-pestel/open-questions.md' <<'VIBEBIZ_SEED_7'
# Open questions: Bán hàng online cho khách ở nước láng giềng
VIBEBIZ_SEED_7
mkdir -p "$(dirname 'specs/001-fit-pestel/glossary.md')"
cat > 'specs/001-fit-pestel/glossary.md' <<'VIBEBIZ_SEED_8'
# Glossary: Bán hàng online cho khách ở nước láng giềng
VIBEBIZ_SEED_8
mkdir -p "$(dirname 'specs/001-fit-pestel/checklists/board.md')"
cat > 'specs/001-fit-pestel/checklists/board.md' <<'VIBEBIZ_SEED_9'
# Definition of Ready: board
VIBEBIZ_SEED_9
mkdir -p "$(dirname 'specs/001-fit-pestel/checklists/tech.md')"
cat > 'specs/001-fit-pestel/checklists/tech.md' <<'VIBEBIZ_SEED_10'
# Definition of Ready: tech
VIBEBIZ_SEED_10
mkdir -p "$(dirname 'specs/001-fit-pestel/diagrams/.keep')"
: > 'specs/001-fit-pestel/diagrams/.keep'
mkdir -p "$(dirname 'specs/001-fit-pestel/exports/.keep')"
: > 'specs/001-fit-pestel/exports/.keep'
