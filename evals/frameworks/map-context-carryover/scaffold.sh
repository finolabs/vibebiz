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
mkdir -p "$(dirname 'specs/001-map-context-carryover/coverage.md')"
cat > 'specs/001-map-context-carryover/coverage.md' <<'VIBEBIZ_SEED_2'
---
id: "001"
slug: map-context-carryover
title: "Giữ chân khách thành viên mua lại"
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
    frameworks: [five-whys]
    framework_reasons:
      five-whys: "one recent lapsed member traced to the cause: no reminder after the first purchase"
    updated: "2026-11-12"
  B:
    status: clear
    reason: null
    prerequisites: [A]
    filled_by: problem-framing
    frameworks: []
    updated: "2026-11-12"
  C:
    status: missing
    reason: null
    prerequisites: [A]
    filled_by: outcome
    frameworks: []
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

# Coverage: Giữ chân khách thành viên mua lại

| Code | Category | Status | Reason (when deferred) | Updated |
|---|---|---|---|---|
| A | Problem and why | clear |  | 2026-11-12 |
| B | Users and stakeholders | clear |  | 2026-11-12 |
| C | Outcome and measurement | missing |  | 2026-11-12 |
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

**Clear**: 2 of 15
VIBEBIZ_SEED_2
mkdir -p "$(dirname 'specs/001-map-context-carryover/spec.md')"
cat > 'specs/001-map-context-carryover/spec.md' <<'VIBEBIZ_SEED_3'
# Feature Specification: Giữ chân khách thành viên mua lại

## Problem & Why

Khách thành viên mua lần đầu rồi không quay lại: 62% thành viên mới trong quý 3/2026 không mua lần hai trong 90 ngày (báo cáo thành viên quý 3/2026, đo). Người chịu thiệt: phòng marketing và quản lý cửa hàng mất doanh thu mua lại.

Chuỗi nguyên nhân từ một trường hợp gần đây (chị khách mua váy ở cửa hàng Quận 7 ngày 02/09/2026, không quay lại):
1. Vì sao chị không quay lại? Chị không biết có hàng mới hợp size của mình.
2. Vì sao chị không biết? Chuỗi không gửi tin gì sau lần mua đầu.
3. Vì sao không gửi? Danh sách thành viên nằm ở máy bán hàng, phòng marketing không lấy ra được theo ngày mua.
4. Vì sao không lấy được? Máy bán hàng không có chức năng xuất danh sách theo ngày, chưa ai yêu cầu.
5. Nguyên nhân gốc: không có bước nhắc khách sau lần mua đầu, vì dữ liệu ngày mua không ra khỏi máy bán hàng.

Câu mô tả vấn đề: thành viên mới không quay lại vì chuỗi không nhắc họ sau lần mua đầu. Vì sao làm bây giờ: mùa Tết bắt đầu từ tháng 1.

**Người liên quan**: phòng marketing; quản lý cửa hàng; khách thành viên mới; trưởng phòng bán lẻ duyệt

## Clarifications

### Session 2026-11-12

- Q: Điều gì khiến bạn làm việc này? → A: Khách mới mua một lần rồi mất hút.
VIBEBIZ_SEED_3
mkdir -p "$(dirname 'specs/001-map-context-carryover/plan.md')"
cat > 'specs/001-map-context-carryover/plan.md' <<'VIBEBIZ_SEED_4'
# Plan: Giữ chân khách thành viên mua lại
VIBEBIZ_SEED_4
mkdir -p "$(dirname 'specs/001-map-context-carryover/decisions.md')"
cat > 'specs/001-map-context-carryover/decisions.md' <<'VIBEBIZ_SEED_5'
# Decisions: Giữ chân khách thành viên mua lại
VIBEBIZ_SEED_5
mkdir -p "$(dirname 'specs/001-map-context-carryover/assumptions.md')"
cat > 'specs/001-map-context-carryover/assumptions.md' <<'VIBEBIZ_SEED_6'
# Assumptions: Giữ chân khách thành viên mua lại
VIBEBIZ_SEED_6
mkdir -p "$(dirname 'specs/001-map-context-carryover/open-questions.md')"
cat > 'specs/001-map-context-carryover/open-questions.md' <<'VIBEBIZ_SEED_7'
# Open questions: Giữ chân khách thành viên mua lại
VIBEBIZ_SEED_7
mkdir -p "$(dirname 'specs/001-map-context-carryover/glossary.md')"
cat > 'specs/001-map-context-carryover/glossary.md' <<'VIBEBIZ_SEED_8'
# Glossary: Giữ chân khách thành viên mua lại
VIBEBIZ_SEED_8
mkdir -p "$(dirname 'specs/001-map-context-carryover/checklists/board.md')"
cat > 'specs/001-map-context-carryover/checklists/board.md' <<'VIBEBIZ_SEED_9'
# Definition of Ready: board
VIBEBIZ_SEED_9
mkdir -p "$(dirname 'specs/001-map-context-carryover/checklists/tech.md')"
cat > 'specs/001-map-context-carryover/checklists/tech.md' <<'VIBEBIZ_SEED_10'
# Definition of Ready: tech
VIBEBIZ_SEED_10
mkdir -p "$(dirname 'specs/001-map-context-carryover/diagrams/.keep')"
: > 'specs/001-map-context-carryover/diagrams/.keep'
mkdir -p "$(dirname 'specs/001-map-context-carryover/exports/.keep')"
: > 'specs/001-map-context-carryover/exports/.keep'
