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
mkdir -p "$(dirname 'specs/001-skip-leading-lagging/coverage.md')"
cat > 'specs/001-skip-leading-lagging/coverage.md' <<'VIBEBIZ_SEED_2'
---
id: "001"
slug: skip-leading-lagging
title: "Cộng đồng chạy bộ của thương hiệu"
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

# Coverage: Cộng đồng chạy bộ của thương hiệu

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
mkdir -p "$(dirname 'specs/001-skip-leading-lagging/spec.md')"
cat > 'specs/001-skip-leading-lagging/spec.md' <<'VIBEBIZ_SEED_3'
# Feature Specification: Cộng đồng chạy bộ của thương hiệu

## Problem & Why

Cộng đồng chạy bộ của thương hiệu ra mắt tháng 11/2025, mỗi tuần có buổi chạy chung ở ba thành phố. Mỗi nhóm báo một con số riêng: marketing báo người theo dõi, nhóm sự kiện báo người tham gia, cửa hàng báo doanh thu giày từ thành viên. Ban điều hành không biết cộng đồng có làm thành viên gắn bó và mua lại hay không, nên chưa quyết ngân sách năm 2027.

**Người liên quan**: thành viên cộng đồng; nhóm marketing; nhóm sự kiện; quản lý cửa hàng; giám đốc thương hiệu duyệt.
VIBEBIZ_SEED_3
mkdir -p "$(dirname 'specs/001-skip-leading-lagging/plan.md')"
cat > 'specs/001-skip-leading-lagging/plan.md' <<'VIBEBIZ_SEED_4'
# Plan: Cộng đồng chạy bộ của thương hiệu
VIBEBIZ_SEED_4
mkdir -p "$(dirname 'specs/001-skip-leading-lagging/decisions.md')"
cat > 'specs/001-skip-leading-lagging/decisions.md' <<'VIBEBIZ_SEED_5'
# Decisions: Cộng đồng chạy bộ của thương hiệu
VIBEBIZ_SEED_5
mkdir -p "$(dirname 'specs/001-skip-leading-lagging/assumptions.md')"
cat > 'specs/001-skip-leading-lagging/assumptions.md' <<'VIBEBIZ_SEED_6'
# Assumptions: Cộng đồng chạy bộ của thương hiệu
VIBEBIZ_SEED_6
mkdir -p "$(dirname 'specs/001-skip-leading-lagging/open-questions.md')"
cat > 'specs/001-skip-leading-lagging/open-questions.md' <<'VIBEBIZ_SEED_7'
# Open questions: Cộng đồng chạy bộ của thương hiệu
VIBEBIZ_SEED_7
mkdir -p "$(dirname 'specs/001-skip-leading-lagging/glossary.md')"
cat > 'specs/001-skip-leading-lagging/glossary.md' <<'VIBEBIZ_SEED_8'
# Glossary: Cộng đồng chạy bộ của thương hiệu
VIBEBIZ_SEED_8
mkdir -p "$(dirname 'specs/001-skip-leading-lagging/checklists/board.md')"
cat > 'specs/001-skip-leading-lagging/checklists/board.md' <<'VIBEBIZ_SEED_9'
# Definition of Ready: board
VIBEBIZ_SEED_9
mkdir -p "$(dirname 'specs/001-skip-leading-lagging/checklists/tech.md')"
cat > 'specs/001-skip-leading-lagging/checklists/tech.md' <<'VIBEBIZ_SEED_10'
# Definition of Ready: tech
VIBEBIZ_SEED_10
mkdir -p "$(dirname 'specs/001-skip-leading-lagging/diagrams/.keep')"
: > 'specs/001-skip-leading-lagging/diagrams/.keep'
mkdir -p "$(dirname 'specs/001-skip-leading-lagging/exports/.keep')"
: > 'specs/001-skip-leading-lagging/exports/.keep'
