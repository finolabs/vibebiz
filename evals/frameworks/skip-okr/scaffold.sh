#!/usr/bin/env bash
# Seeds a fictional workspace (no real data). Run with: claude plugin eval ... --scaffold
set -euo pipefail
mkdir -p "$(dirname 'constitution.md')"
cat > 'constitution.md' <<'VIBEBIZ_SEED_0'
---
status: set
priorities: ["Giữ chân khách cũ"]
approval_ceiling:
  amount: 50000000
  currency: "VND"
vertical: fashion
mandatory_approvals: []
strategy_map:
  financial: ["Tăng biên lợi nhuận gộp"]
  customer: ["Tăng tỷ lệ khách quay lại mua"]
  internal_process: ["Rút ngắn thời gian đổi trả"]
  learning_and_growth: ["Nhân viên cửa hàng tư vấn được theo dữ liệu khách"]
updated: "2026-11-12"
---

# Ground rules

Ưu tiên năm nay: giữ chân khách cũ. Bản đồ chiến lược: tài chính (tăng biên lợi nhuận gộp), khách hàng (tăng tỷ lệ khách quay lại mua), quy trình (rút ngắn thời gian đổi trả), học hỏi (nhân viên cửa hàng tư vấn được theo dữ liệu khách).
VIBEBIZ_SEED_0
mkdir -p "$(dirname 'index.html')"
cat > 'index.html' <<'VIBEBIZ_SEED_1'
<!doctype html><html><head><meta charset="utf-8"><title>vibebiz</title></head><body><script type="application/json" id="vibebiz-data">{"workspace":{"updated":"2026-11-12","ground_rules_status":"set"},"ideas":[],"examples":[]}</script></body></html>
VIBEBIZ_SEED_1
mkdir -p "$(dirname 'specs/001-skip-okr/coverage.md')"
cat > 'specs/001-skip-okr/coverage.md' <<'VIBEBIZ_SEED_2'
---
id: "001"
slug: skip-okr
title: "Chương trình khách quen cho hội đồng"
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

# Coverage: Chương trình khách quen cho hội đồng

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
mkdir -p "$(dirname 'specs/001-skip-okr/spec.md')"
cat > 'specs/001-skip-okr/spec.md' <<'VIBEBIZ_SEED_3'
# Feature Specification: Chương trình khách quen cho hội đồng

## Problem & Why

Khách mua lần đầu ít quay lại: chỉ một phần nhỏ mua lần hai trong sáu tháng (báo cáo khách hàng quý 3/2026). Chương trình khách quen tặng ưu đãi theo lần mua. Hội đồng quản trị xem mọi ý tưởng theo bản đồ chiến lược bốn góc nhìn và sẽ hỏi chương trình này phục vụ mục tiêu nào.

**Người liên quan**: khách đã mua một lần; quản lý cửa hàng; nhóm CRM; hội đồng quản trị duyệt.
VIBEBIZ_SEED_3
mkdir -p "$(dirname 'specs/001-skip-okr/plan.md')"
cat > 'specs/001-skip-okr/plan.md' <<'VIBEBIZ_SEED_4'
# Plan: Chương trình khách quen cho hội đồng
VIBEBIZ_SEED_4
mkdir -p "$(dirname 'specs/001-skip-okr/decisions.md')"
cat > 'specs/001-skip-okr/decisions.md' <<'VIBEBIZ_SEED_5'
# Decisions: Chương trình khách quen cho hội đồng
VIBEBIZ_SEED_5
mkdir -p "$(dirname 'specs/001-skip-okr/assumptions.md')"
cat > 'specs/001-skip-okr/assumptions.md' <<'VIBEBIZ_SEED_6'
# Assumptions: Chương trình khách quen cho hội đồng
VIBEBIZ_SEED_6
mkdir -p "$(dirname 'specs/001-skip-okr/open-questions.md')"
cat > 'specs/001-skip-okr/open-questions.md' <<'VIBEBIZ_SEED_7'
# Open questions: Chương trình khách quen cho hội đồng
VIBEBIZ_SEED_7
mkdir -p "$(dirname 'specs/001-skip-okr/glossary.md')"
cat > 'specs/001-skip-okr/glossary.md' <<'VIBEBIZ_SEED_8'
# Glossary: Chương trình khách quen cho hội đồng
VIBEBIZ_SEED_8
mkdir -p "$(dirname 'specs/001-skip-okr/checklists/board.md')"
cat > 'specs/001-skip-okr/checklists/board.md' <<'VIBEBIZ_SEED_9'
# Definition of Ready: board
VIBEBIZ_SEED_9
mkdir -p "$(dirname 'specs/001-skip-okr/checklists/tech.md')"
cat > 'specs/001-skip-okr/checklists/tech.md' <<'VIBEBIZ_SEED_10'
# Definition of Ready: tech
VIBEBIZ_SEED_10
mkdir -p "$(dirname 'specs/001-skip-okr/diagrams/.keep')"
: > 'specs/001-skip-okr/diagrams/.keep'
mkdir -p "$(dirname 'specs/001-skip-okr/exports/.keep')"
: > 'specs/001-skip-okr/exports/.keep'
