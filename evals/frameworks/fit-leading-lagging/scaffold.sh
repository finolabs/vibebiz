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
mkdir -p "$(dirname 'specs/001-fit-leading-lagging/coverage.md')"
cat > 'specs/001-fit-leading-lagging/coverage.md' <<'VIBEBIZ_SEED_2'
---
id: "001"
slug: fit-leading-lagging
title: "Gợi ý size trên website"
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
    status: partial
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

# Coverage: Gợi ý size trên website

| Code | Category | Status | Reason (when deferred) | Updated |
|---|---|---|---|---|
| A | Problem and why | clear |  | 2026-11-12 |
| B | Users and stakeholders | clear |  | 2026-11-12 |
| C | Outcome and measurement | partial |  | 2026-11-12 |
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
mkdir -p "$(dirname 'specs/001-fit-leading-lagging/spec.md')"
cat > 'specs/001-fit-leading-lagging/spec.md' <<'VIBEBIZ_SEED_3'
# Feature Specification: Gợi ý size trên website

## Problem & Why

Khách mua online chọn sai size nên trả hàng nhiều; khách tự chọn size trên trang sản phẩm, không có ai tư vấn. Người chịu thiệt là khách phải đổi trả và đội chăm sóc khách hàng xử lý đổi trả.

**Người liên quan**: khách mua online; đội chăm sóc khách hàng; trưởng nhóm thương mại điện tử duyệt.

## Outcome

Giảm tỷ lệ trả hàng vì sai size trên website từ 18% xuống 12% trong 6 tháng (số 18%: báo cáo đổi trả quý 3/2026, đo). Giới hạn: tỷ lệ chuyển đổi không giảm.

Cây chỉ số (driver tree): tỷ lệ trả hàng vì sai size = số đơn trả vì sai size ÷ số đơn giao. Ý tưởng tác động vào việc khách chọn đúng size ngay lần đầu. Tỷ lệ trả hàng chỉ đo được sau khi khách nhận hàng và gửi trả, thường hơn 30 ngày sau khi giao; chưa có chỉ số nào đọc được sớm hơn.
VIBEBIZ_SEED_3
mkdir -p "$(dirname 'specs/001-fit-leading-lagging/plan.md')"
cat > 'specs/001-fit-leading-lagging/plan.md' <<'VIBEBIZ_SEED_4'
# Plan: Gợi ý size trên website
VIBEBIZ_SEED_4
mkdir -p "$(dirname 'specs/001-fit-leading-lagging/decisions.md')"
cat > 'specs/001-fit-leading-lagging/decisions.md' <<'VIBEBIZ_SEED_5'
# Decisions: Gợi ý size trên website
VIBEBIZ_SEED_5
mkdir -p "$(dirname 'specs/001-fit-leading-lagging/assumptions.md')"
cat > 'specs/001-fit-leading-lagging/assumptions.md' <<'VIBEBIZ_SEED_6'
# Assumptions: Gợi ý size trên website
VIBEBIZ_SEED_6
mkdir -p "$(dirname 'specs/001-fit-leading-lagging/open-questions.md')"
cat > 'specs/001-fit-leading-lagging/open-questions.md' <<'VIBEBIZ_SEED_7'
# Open questions: Gợi ý size trên website
VIBEBIZ_SEED_7
mkdir -p "$(dirname 'specs/001-fit-leading-lagging/glossary.md')"
cat > 'specs/001-fit-leading-lagging/glossary.md' <<'VIBEBIZ_SEED_8'
# Glossary: Gợi ý size trên website
VIBEBIZ_SEED_8
mkdir -p "$(dirname 'specs/001-fit-leading-lagging/checklists/board.md')"
cat > 'specs/001-fit-leading-lagging/checklists/board.md' <<'VIBEBIZ_SEED_9'
# Definition of Ready: board
VIBEBIZ_SEED_9
mkdir -p "$(dirname 'specs/001-fit-leading-lagging/checklists/tech.md')"
cat > 'specs/001-fit-leading-lagging/checklists/tech.md' <<'VIBEBIZ_SEED_10'
# Definition of Ready: tech
VIBEBIZ_SEED_10
mkdir -p "$(dirname 'specs/001-fit-leading-lagging/diagrams/.keep')"
: > 'specs/001-fit-leading-lagging/diagrams/.keep'
mkdir -p "$(dirname 'specs/001-fit-leading-lagging/exports/.keep')"
: > 'specs/001-fit-leading-lagging/exports/.keep'
