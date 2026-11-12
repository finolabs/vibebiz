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
mkdir -p "$(dirname 'specs/001-cap-two-per-lens/coverage.md')"
cat > 'specs/001-cap-two-per-lens/coverage.md' <<'VIBEBIZ_SEED_2'
---
id: "001"
slug: cap-two-per-lens
title: "Giảm thiếu size cuối tuần"
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
    frameworks: [five-whys, fishbone]
    updated: "2026-11-12"
  B:
    status: partial
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

# Coverage: Giảm thiếu size cuối tuần

| Code | Category | Status | Reason (when deferred) | Updated |
|---|---|---|---|---|
| A | Problem and why | partial |  | 2026-11-12 |
| B | Users and stakeholders | partial |  | 2026-11-12 |
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
mkdir -p "$(dirname 'specs/001-cap-two-per-lens/spec.md')"
cat > 'specs/001-cap-two-per-lens/spec.md' <<'VIBEBIZ_SEED_3'
# Feature Specification: Giảm thiếu size cuối tuần

## Problem & Why

Thiếu size cuối tuần ở 12 cửa hàng. Đã dùng hai khung nguyên nhân.

## Clarifications

### Session 2026-11-12

- Q: Điều gì khiến bạn làm việc này? → A: Khách bỏ về vì hết size.
VIBEBIZ_SEED_3
mkdir -p "$(dirname 'specs/001-cap-two-per-lens/plan.md')"
cat > 'specs/001-cap-two-per-lens/plan.md' <<'VIBEBIZ_SEED_4'
# Plan: Giảm thiếu size cuối tuần
VIBEBIZ_SEED_4
mkdir -p "$(dirname 'specs/001-cap-two-per-lens/decisions.md')"
cat > 'specs/001-cap-two-per-lens/decisions.md' <<'VIBEBIZ_SEED_5'
# Decisions: Giảm thiếu size cuối tuần
VIBEBIZ_SEED_5
mkdir -p "$(dirname 'specs/001-cap-two-per-lens/assumptions.md')"
cat > 'specs/001-cap-two-per-lens/assumptions.md' <<'VIBEBIZ_SEED_6'
# Assumptions: Giảm thiếu size cuối tuần
VIBEBIZ_SEED_6
mkdir -p "$(dirname 'specs/001-cap-two-per-lens/open-questions.md')"
cat > 'specs/001-cap-two-per-lens/open-questions.md' <<'VIBEBIZ_SEED_7'
# Open questions: Giảm thiếu size cuối tuần
VIBEBIZ_SEED_7
mkdir -p "$(dirname 'specs/001-cap-two-per-lens/glossary.md')"
cat > 'specs/001-cap-two-per-lens/glossary.md' <<'VIBEBIZ_SEED_8'
# Glossary: Giảm thiếu size cuối tuần
VIBEBIZ_SEED_8
mkdir -p "$(dirname 'specs/001-cap-two-per-lens/checklists/board.md')"
cat > 'specs/001-cap-two-per-lens/checklists/board.md' <<'VIBEBIZ_SEED_9'
# Definition of Ready: board
VIBEBIZ_SEED_9
mkdir -p "$(dirname 'specs/001-cap-two-per-lens/checklists/tech.md')"
cat > 'specs/001-cap-two-per-lens/checklists/tech.md' <<'VIBEBIZ_SEED_10'
# Definition of Ready: tech
VIBEBIZ_SEED_10
mkdir -p "$(dirname 'specs/001-cap-two-per-lens/diagrams/.keep')"
: > 'specs/001-cap-two-per-lens/diagrams/.keep'
mkdir -p "$(dirname 'specs/001-cap-two-per-lens/exports/.keep')"
: > 'specs/001-cap-two-per-lens/exports/.keep'
