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
mkdir -p "$(dirname 'specs/001-first-journey-stands-alone/coverage.md')"
cat > 'specs/001-first-journey-stands-alone/coverage.md' <<'VIBEBIZ_SEED_2'
---
id: "001"
slug: first-journey-stands-alone
title: "Khách quen quét mã tích điểm"
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

# Coverage: Khách quen quét mã tích điểm

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
mkdir -p "$(dirname 'specs/001-first-journey-stands-alone/spec.md')"
cat > 'specs/001-first-journey-stands-alone/spec.md' <<'VIBEBIZ_SEED_3'
# Feature Specification: Khách quen quét mã tích điểm

## Problem & Why

Muốn khách quen mua lại. Ba hành trình ứng viên: (1) nhân viên quét mã tích điểm ở quầy, (2) khách xem điểm trên website, (3) đổi điểm lấy ưu đãi ở quầy và online.

## Clarifications

### Session 2026-11-12

- Q: Điều gì khiến bạn làm việc này? → A: Khách mua một lần rồi bỏ đi.
VIBEBIZ_SEED_3
mkdir -p "$(dirname 'specs/001-first-journey-stands-alone/plan.md')"
cat > 'specs/001-first-journey-stands-alone/plan.md' <<'VIBEBIZ_SEED_4'
# Plan: Khách quen quét mã tích điểm
VIBEBIZ_SEED_4
mkdir -p "$(dirname 'specs/001-first-journey-stands-alone/decisions.md')"
cat > 'specs/001-first-journey-stands-alone/decisions.md' <<'VIBEBIZ_SEED_5'
# Decisions: Khách quen quét mã tích điểm
VIBEBIZ_SEED_5
mkdir -p "$(dirname 'specs/001-first-journey-stands-alone/assumptions.md')"
cat > 'specs/001-first-journey-stands-alone/assumptions.md' <<'VIBEBIZ_SEED_6'
# Assumptions: Khách quen quét mã tích điểm
VIBEBIZ_SEED_6
mkdir -p "$(dirname 'specs/001-first-journey-stands-alone/open-questions.md')"
cat > 'specs/001-first-journey-stands-alone/open-questions.md' <<'VIBEBIZ_SEED_7'
# Open questions: Khách quen quét mã tích điểm
VIBEBIZ_SEED_7
mkdir -p "$(dirname 'specs/001-first-journey-stands-alone/glossary.md')"
cat > 'specs/001-first-journey-stands-alone/glossary.md' <<'VIBEBIZ_SEED_8'
# Glossary: Khách quen quét mã tích điểm
VIBEBIZ_SEED_8
mkdir -p "$(dirname 'specs/001-first-journey-stands-alone/checklists/board.md')"
cat > 'specs/001-first-journey-stands-alone/checklists/board.md' <<'VIBEBIZ_SEED_9'
# Definition of Ready: board
VIBEBIZ_SEED_9
mkdir -p "$(dirname 'specs/001-first-journey-stands-alone/checklists/tech.md')"
cat > 'specs/001-first-journey-stands-alone/checklists/tech.md' <<'VIBEBIZ_SEED_10'
# Definition of Ready: tech
VIBEBIZ_SEED_10
mkdir -p "$(dirname 'specs/001-first-journey-stands-alone/diagrams/.keep')"
: > 'specs/001-first-journey-stands-alone/diagrams/.keep'
mkdir -p "$(dirname 'specs/001-first-journey-stands-alone/exports/.keep')"
: > 'specs/001-first-journey-stands-alone/exports/.keep'
