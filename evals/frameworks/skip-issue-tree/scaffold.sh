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
mkdir -p "$(dirname 'specs/001-skip-issue-tree/coverage.md')"
cat > 'specs/001-skip-issue-tree/coverage.md' <<'VIBEBIZ_SEED_2'
---
id: "001"
slug: skip-issue-tree
title: "Đơn online bị đóng gói sai size"
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
    status: partial
    reason: null
    prerequisites: []
    filled_by: problem-framing
    frameworks: []
    updated: "2026-11-12"
  B:
    status: missing
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

# Coverage: Đơn online bị đóng gói sai size

| Code | Category | Status | Reason (when deferred) | Updated |
|---|---|---|---|---|
| A | Problem and why | partial |  | 2026-11-12 |
| B | Users and stakeholders | missing |  | 2026-11-12 |
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

**Clear**: 0 of 15
VIBEBIZ_SEED_2
mkdir -p "$(dirname 'specs/001-skip-issue-tree/spec.md')"
cat > 'specs/001-skip-issue-tree/spec.md' <<'VIBEBIZ_SEED_3'
# Feature Specification: Đơn online bị đóng gói sai size

## Problem & Why

Đơn online từ kho Thủ Đức hay bị đóng gói sai size. Tuần trước một đơn áo sơ mi size M bị giao size L, khách gửi trả và đội chăm sóc khách hàng phải gửi lại đơn mới. Người chịu thiệt là khách nhận sai hàng và đội chăm sóc khách hàng xử lý đổi trả.

**Người liên quan**: nhân viên đóng gói ở kho Thủ Đức; trưởng kho; đội chăm sóc khách hàng.
VIBEBIZ_SEED_3
mkdir -p "$(dirname 'specs/001-skip-issue-tree/plan.md')"
cat > 'specs/001-skip-issue-tree/plan.md' <<'VIBEBIZ_SEED_4'
# Plan: Đơn online bị đóng gói sai size
VIBEBIZ_SEED_4
mkdir -p "$(dirname 'specs/001-skip-issue-tree/decisions.md')"
cat > 'specs/001-skip-issue-tree/decisions.md' <<'VIBEBIZ_SEED_5'
# Decisions: Đơn online bị đóng gói sai size
VIBEBIZ_SEED_5
mkdir -p "$(dirname 'specs/001-skip-issue-tree/assumptions.md')"
cat > 'specs/001-skip-issue-tree/assumptions.md' <<'VIBEBIZ_SEED_6'
# Assumptions: Đơn online bị đóng gói sai size
VIBEBIZ_SEED_6
mkdir -p "$(dirname 'specs/001-skip-issue-tree/open-questions.md')"
cat > 'specs/001-skip-issue-tree/open-questions.md' <<'VIBEBIZ_SEED_7'
# Open questions: Đơn online bị đóng gói sai size
VIBEBIZ_SEED_7
mkdir -p "$(dirname 'specs/001-skip-issue-tree/glossary.md')"
cat > 'specs/001-skip-issue-tree/glossary.md' <<'VIBEBIZ_SEED_8'
# Glossary: Đơn online bị đóng gói sai size
VIBEBIZ_SEED_8
mkdir -p "$(dirname 'specs/001-skip-issue-tree/checklists/board.md')"
cat > 'specs/001-skip-issue-tree/checklists/board.md' <<'VIBEBIZ_SEED_9'
# Definition of Ready: board
VIBEBIZ_SEED_9
mkdir -p "$(dirname 'specs/001-skip-issue-tree/checklists/tech.md')"
cat > 'specs/001-skip-issue-tree/checklists/tech.md' <<'VIBEBIZ_SEED_10'
# Definition of Ready: tech
VIBEBIZ_SEED_10
mkdir -p "$(dirname 'specs/001-skip-issue-tree/diagrams/.keep')"
: > 'specs/001-skip-issue-tree/diagrams/.keep'
mkdir -p "$(dirname 'specs/001-skip-issue-tree/exports/.keep')"
: > 'specs/001-skip-issue-tree/exports/.keep'
