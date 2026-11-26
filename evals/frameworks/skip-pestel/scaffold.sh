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
mkdir -p "$(dirname 'specs/001-skip-pestel/coverage.md')"
cat > 'specs/001-skip-pestel/coverage.md' <<'VIBEBIZ_SEED_2'
---
id: "001"
slug: skip-pestel
title: "Đổi phần mềm bán hàng ở 30 cửa hàng trước Tết"
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

# Coverage: Đổi phần mềm bán hàng ở 30 cửa hàng trước Tết

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
mkdir -p "$(dirname 'specs/001-skip-pestel/spec.md')"
cat > 'specs/001-skip-pestel/spec.md' <<'VIBEBIZ_SEED_3'
# Feature Specification: Đổi phần mềm bán hàng ở 30 cửa hàng trước Tết


## Problem & Why

Phần mềm bán hàng cũ ở 30 cửa hàng của chuỗi Gió Nam hay treo giờ cao điểm, mỗi lần treo quầy phải ghi tay hóa đơn. Người chịu thiệt là khách chờ lâu và thu ngân. Việc này xảy ra mỗi cuối tuần.

**Người liên quan**: thu ngân; quản lý cửa hàng; phòng công nghệ; giám đốc vận hành duyệt.

## Outcome

Giảm số lần treo máy giờ cao điểm từ khoảng 12 lần mỗi tuần xuống dưới 2 lần trong 2 tháng sau khi đổi (số 12: sổ sự cố của phòng công nghệ, tháng 10/2026, đo). Giới hạn: thời gian thanh toán mỗi khách không tăng. Ngưỡng dừng: tháng đầu số lần treo không giảm thì quay lại phần mềm cũ.

## Alternatives

- Không làm gì: tiếp tục ghi tay khi treo.
- Nâng cấp máy cũ: không khắc phục được lỗi phần mềm.
- **Đã chọn**: đổi sang phần mềm bán hàng mới đã mua, cài ở cả 30 cửa hàng trước Tết.

## User Scenarios & Testing

Cài phần mềm mới ở 30 cửa hàng trong tháng 12, đào tạo thu ngân, chạy song song một tuần. Ngoài phạm vi: kho và website.

## Key Entities

Hóa đơn bán hàng, mặt hàng, giá, ca thu ngân. Chuyển từ phần mềm cũ sang mới.

## Clarifications

### Session 2026-11-12

- Q: Điều gì khiến bạn làm việc này? → A: Máy bán hàng hay treo.
VIBEBIZ_SEED_3
mkdir -p "$(dirname 'specs/001-skip-pestel/plan.md')"
cat > 'specs/001-skip-pestel/plan.md' <<'VIBEBIZ_SEED_4'
# Plan: Đổi phần mềm bán hàng ở 30 cửa hàng trước Tết
VIBEBIZ_SEED_4
mkdir -p "$(dirname 'specs/001-skip-pestel/decisions.md')"
cat > 'specs/001-skip-pestel/decisions.md' <<'VIBEBIZ_SEED_5'
# Decisions: Đổi phần mềm bán hàng ở 30 cửa hàng trước Tết
VIBEBIZ_SEED_5
mkdir -p "$(dirname 'specs/001-skip-pestel/assumptions.md')"
cat > 'specs/001-skip-pestel/assumptions.md' <<'VIBEBIZ_SEED_6'
# Assumptions: Đổi phần mềm bán hàng ở 30 cửa hàng trước Tết
VIBEBIZ_SEED_6
mkdir -p "$(dirname 'specs/001-skip-pestel/open-questions.md')"
cat > 'specs/001-skip-pestel/open-questions.md' <<'VIBEBIZ_SEED_7'
# Open questions: Đổi phần mềm bán hàng ở 30 cửa hàng trước Tết
VIBEBIZ_SEED_7
mkdir -p "$(dirname 'specs/001-skip-pestel/glossary.md')"
cat > 'specs/001-skip-pestel/glossary.md' <<'VIBEBIZ_SEED_8'
# Glossary: Đổi phần mềm bán hàng ở 30 cửa hàng trước Tết
VIBEBIZ_SEED_8
mkdir -p "$(dirname 'specs/001-skip-pestel/checklists/board.md')"
cat > 'specs/001-skip-pestel/checklists/board.md' <<'VIBEBIZ_SEED_9'
# Definition of Ready: board
VIBEBIZ_SEED_9
mkdir -p "$(dirname 'specs/001-skip-pestel/checklists/tech.md')"
cat > 'specs/001-skip-pestel/checklists/tech.md' <<'VIBEBIZ_SEED_10'
# Definition of Ready: tech
VIBEBIZ_SEED_10
mkdir -p "$(dirname 'specs/001-skip-pestel/diagrams/.keep')"
: > 'specs/001-skip-pestel/diagrams/.keep'
mkdir -p "$(dirname 'specs/001-skip-pestel/exports/.keep')"
: > 'specs/001-skip-pestel/exports/.keep'
