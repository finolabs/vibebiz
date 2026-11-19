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
mkdir -p "$(dirname 'specs/001-map-feeds-preferred/coverage.md')"
cat > 'specs/001-map-feeds-preferred/coverage.md' <<'VIBEBIZ_SEED_2'
---
id: "001"
slug: map-feeds-preferred
title: "Triển khai quét mã ở quầy 34 cửa hàng"
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
    frameworks: [driver-tree]
    updated: "2026-11-12"
  D:
    status: missing
    reason: null
    prerequisites: [A, C]
    filled_by: challenge
    frameworks: []
    updated: "2026-11-12"
  E:
    status: missing
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

# Coverage: Triển khai quét mã ở quầy 34 cửa hàng

| Code | Category | Status | Reason (when deferred) | Updated |
|---|---|---|---|---|
| A | Problem and why | clear |  | 2026-11-12 |
| B | Users and stakeholders | clear |  | 2026-11-12 |
| C | Outcome and measurement | clear |  | 2026-11-12 |
| D | Alternatives | missing |  | 2026-11-12 |
| E | Scope and behavior | missing |  | 2026-11-12 |
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

**Clear**: 3 of 15
VIBEBIZ_SEED_2
mkdir -p "$(dirname 'specs/001-map-feeds-preferred/spec.md')"
cat > 'specs/001-map-feeds-preferred/spec.md' <<'VIBEBIZ_SEED_3'
# Feature Specification: Triển khai quét mã ở quầy 34 cửa hàng

## Problem & Why

Muốn quét mã tích điểm ở quầy tất cả 34 cửa hàng. Người chịu thiệt: nhân viên quầy và khách xếp hàng giờ đông. Tần suất: mỗi lần thanh toán có khách tích điểm. Chi phí hiện nay: thêm khoảng 20 giây mỗi đơn (bấm giờ ở 2 cửa hàng, tháng 10/2026, đo). Nguyên nhân gốc: phải nhập số điện thoại khách bằng tay. Vì sao làm bây giờ: chương trình tích điểm mới mở rộng ra cả chuỗi tháng 12

**Người liên quan**: nhân viên quầy; khách thành viên; quản lý 34 cửa hàng; trưởng phòng bán lẻ duyệt

## Outcome

Giảm thời gian thêm mỗi đơn từ 20 giây xuống 5 giây ở cả 34 cửa hàng trong 3 tháng (số 20 giây: bấm giờ tháng 10/2026, đo). Giới hạn: tỷ lệ đơn có tích điểm không giảm.

## Clarifications

### Session 2026-11-12

- Q: Điều gì khiến bạn làm việc này? → A: Khách quen mua lại ít.
VIBEBIZ_SEED_3
mkdir -p "$(dirname 'specs/001-map-feeds-preferred/plan.md')"
cat > 'specs/001-map-feeds-preferred/plan.md' <<'VIBEBIZ_SEED_4'
# Plan: Triển khai quét mã ở quầy 34 cửa hàng
VIBEBIZ_SEED_4
mkdir -p "$(dirname 'specs/001-map-feeds-preferred/decisions.md')"
cat > 'specs/001-map-feeds-preferred/decisions.md' <<'VIBEBIZ_SEED_5'
# Decisions: Triển khai quét mã ở quầy 34 cửa hàng
VIBEBIZ_SEED_5
mkdir -p "$(dirname 'specs/001-map-feeds-preferred/assumptions.md')"
cat > 'specs/001-map-feeds-preferred/assumptions.md' <<'VIBEBIZ_SEED_6'
# Assumptions: Triển khai quét mã ở quầy 34 cửa hàng
VIBEBIZ_SEED_6
mkdir -p "$(dirname 'specs/001-map-feeds-preferred/open-questions.md')"
cat > 'specs/001-map-feeds-preferred/open-questions.md' <<'VIBEBIZ_SEED_7'
# Open questions: Triển khai quét mã ở quầy 34 cửa hàng
VIBEBIZ_SEED_7
mkdir -p "$(dirname 'specs/001-map-feeds-preferred/glossary.md')"
cat > 'specs/001-map-feeds-preferred/glossary.md' <<'VIBEBIZ_SEED_8'
# Glossary: Triển khai quét mã ở quầy 34 cửa hàng
VIBEBIZ_SEED_8
mkdir -p "$(dirname 'specs/001-map-feeds-preferred/checklists/board.md')"
cat > 'specs/001-map-feeds-preferred/checklists/board.md' <<'VIBEBIZ_SEED_9'
# Definition of Ready: board
VIBEBIZ_SEED_9
mkdir -p "$(dirname 'specs/001-map-feeds-preferred/checklists/tech.md')"
cat > 'specs/001-map-feeds-preferred/checklists/tech.md' <<'VIBEBIZ_SEED_10'
# Definition of Ready: tech
VIBEBIZ_SEED_10
mkdir -p "$(dirname 'specs/001-map-feeds-preferred/diagrams/.keep')"
: > 'specs/001-map-feeds-preferred/diagrams/.keep'
mkdir -p "$(dirname 'specs/001-map-feeds-preferred/exports/.keep')"
: > 'specs/001-map-feeds-preferred/exports/.keep'
