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
mkdir -p "$(dirname 'specs/001-skip-cost-of-inaction/coverage.md')"
cat > 'specs/001-skip-cost-of-inaction/coverage.md' <<'VIBEBIZ_SEED_2'
---
id: "001"
slug: skip-cost-of-inaction
title: "Đối soát tiền thu hộ của đơn giao hàng"
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
    status: partial
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

# Coverage: Đối soát tiền thu hộ của đơn giao hàng

| Code | Category | Status | Reason (when deferred) | Updated |
|---|---|---|---|---|
| A | Problem and why | clear |  | 2026-11-12 |
| B | Users and stakeholders | clear |  | 2026-11-12 |
| C | Outcome and measurement | clear |  | 2026-11-12 |
| D | Alternatives | partial |  | 2026-11-12 |
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
mkdir -p "$(dirname 'specs/001-skip-cost-of-inaction/spec.md')"
cat > 'specs/001-skip-cost-of-inaction/spec.md' <<'VIBEBIZ_SEED_3'
# Feature Specification: Đối soát tiền thu hộ của đơn giao hàng


## Problem & Why

Kế toán của chuỗi Sen Trắng đối soát tay tiền thu hộ từ ba đơn vị giao hàng, mất khoảng 60 giờ mỗi tháng (bảng chấm công kế toán, tháng 10/2026, đo); mỗi tháng có vài khoản lệch phải tra lại từng đơn. Người chịu thiệt là kế toán và dòng tiền về chậm. Việc này lặp lại mỗi tháng.

**Người liên quan**: kế toán; đội bán hàng online; giám đốc tài chính duyệt.

## Outcome

Rút thời gian đối soát từ 60 giờ xuống 15 giờ mỗi tháng trong 4 tháng (số 60: bảng chấm công kế toán, tháng 10/2026, đo). Giới hạn: không bỏ sót khoản lệch nào. Ngưỡng dừng: sau 2 tháng không giảm được một nửa thì dừng.

## Alternatives

- Không làm gì: tiếp tục 60 giờ mỗi tháng và tiền về chậm; ban điều hành đã chấp nhận là không thể để nguyên (họp ngày 05/11/2026).
- Mua phần mềm đối soát: chưa so sánh.
- Tự làm bảng đối soát tự động: chưa so sánh.
- Thuê đơn vị kế toán ngoài: chưa so sánh.

## Clarifications

### Session 2026-11-12

- Q: Điều gì khiến bạn làm việc này? → A: Đối soát tay mất quá nhiều giờ.
VIBEBIZ_SEED_3
mkdir -p "$(dirname 'specs/001-skip-cost-of-inaction/plan.md')"
cat > 'specs/001-skip-cost-of-inaction/plan.md' <<'VIBEBIZ_SEED_4'
# Plan: Đối soát tiền thu hộ của đơn giao hàng
VIBEBIZ_SEED_4
mkdir -p "$(dirname 'specs/001-skip-cost-of-inaction/decisions.md')"
cat > 'specs/001-skip-cost-of-inaction/decisions.md' <<'VIBEBIZ_SEED_5'
# Decisions: Đối soát tiền thu hộ của đơn giao hàng
VIBEBIZ_SEED_5
mkdir -p "$(dirname 'specs/001-skip-cost-of-inaction/assumptions.md')"
cat > 'specs/001-skip-cost-of-inaction/assumptions.md' <<'VIBEBIZ_SEED_6'
# Assumptions: Đối soát tiền thu hộ của đơn giao hàng
VIBEBIZ_SEED_6
mkdir -p "$(dirname 'specs/001-skip-cost-of-inaction/open-questions.md')"
cat > 'specs/001-skip-cost-of-inaction/open-questions.md' <<'VIBEBIZ_SEED_7'
# Open questions: Đối soát tiền thu hộ của đơn giao hàng
VIBEBIZ_SEED_7
mkdir -p "$(dirname 'specs/001-skip-cost-of-inaction/glossary.md')"
cat > 'specs/001-skip-cost-of-inaction/glossary.md' <<'VIBEBIZ_SEED_8'
# Glossary: Đối soát tiền thu hộ của đơn giao hàng
VIBEBIZ_SEED_8
mkdir -p "$(dirname 'specs/001-skip-cost-of-inaction/checklists/board.md')"
cat > 'specs/001-skip-cost-of-inaction/checklists/board.md' <<'VIBEBIZ_SEED_9'
# Definition of Ready: board
VIBEBIZ_SEED_9
mkdir -p "$(dirname 'specs/001-skip-cost-of-inaction/checklists/tech.md')"
cat > 'specs/001-skip-cost-of-inaction/checklists/tech.md' <<'VIBEBIZ_SEED_10'
# Definition of Ready: tech
VIBEBIZ_SEED_10
mkdir -p "$(dirname 'specs/001-skip-cost-of-inaction/diagrams/.keep')"
: > 'specs/001-skip-cost-of-inaction/diagrams/.keep'
mkdir -p "$(dirname 'specs/001-skip-cost-of-inaction/exports/.keep')"
: > 'specs/001-skip-cost-of-inaction/exports/.keep'
