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
mkdir -p "$(dirname 'specs/001-map-revisit/coverage.md')"
cat > 'specs/001-map-revisit/coverage.md' <<'VIBEBIZ_SEED_2'
---
id: "001"
slug: map-revisit
title: "Bổ sung hàng tự động cho 12 cửa hàng"
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
    framework_reasons:
      driver-tree: "baseline and target named, the driver the idea moves was open"
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
    status: missing
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
    status: clear
    reason: null
    prerequisites: [C, D, E]
    filled_by: challenge, plan
    frameworks: [test-and-control-pilot]
    framework_reasons:
      test-and-control-pilot: "fed by driver-tree (the metric to test); the stockout-day rate tested in 3 stores against 3"
    updated: "2026-11-12"
  N:
    status: clear
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

# Coverage: Bổ sung hàng tự động cho 12 cửa hàng

| Code | Category | Status | Reason (when deferred) | Updated |
|---|---|---|---|---|
| A | Problem and why | clear |  | 2026-11-12 |
| B | Users and stakeholders | clear |  | 2026-11-12 |
| C | Outcome and measurement | clear |  | 2026-11-12 |
| D | Alternatives | clear |  | 2026-11-12 |
| E | Scope and behavior | clear |  | 2026-11-12 |
| F | AI fit | missing |  | 2026-11-12 |
| G | Data and entities | clear |  | 2026-11-12 |
| H | Integrations | missing |  | 2026-11-12 |
| I | Non-functional needs | missing |  | 2026-11-12 |
| J | Edge cases and failures | missing |  | 2026-11-12 |
| K | Risk and compliance | missing |  | 2026-11-12 |
| L | Organizational change | missing |  | 2026-11-12 |
| M | Cost, resources and return | clear |  | 2026-11-12 |
| N | Terminology | clear |  | 2026-11-12 |
| O | Completion signals | missing |  | 2026-11-12 |

**Clear**: 8 of 15
VIBEBIZ_SEED_2
mkdir -p "$(dirname 'specs/001-map-revisit/spec.md')"
cat > 'specs/001-map-revisit/spec.md' <<'VIBEBIZ_SEED_3'
# Feature Specification: Bổ sung hàng tự động cho 12 cửa hàng

## Problem & Why

12 cửa hàng hết size bán chạy trong khi kho tổng còn hàng, vì quản lý đặt hàng theo cảm giác. Vì sao làm bây giờ: mùa Tết.

**Người liên quan**: quản lý cửa hàng; nhân viên kho; trưởng phòng cung ứng duyệt

## Outcome

Tỷ lệ số ngày hết size bán chạy: mốc 18% (báo cáo tồn kho quý 3/2026, đo), mục tiêu 8% trong 4 tháng. Giới hạn: tồn kho cửa hàng không tăng quá 10%. Dừng nếu sau 8 tuần thử chưa xuống dưới 15%.

Cây con số: doanh thu size bán chạy = số ngày có hàng × doanh thu mỗi ngày có hàng; ý tưởng tác động vào nhánh số ngày có hàng.

## Cost & Return

Chạy thử 8 tuần ở 3 cửa hàng, so với 3 cửa hàng đối chứng; thành công khi tỷ lệ ngày hết size của nhóm thử thấp hơn nhóm đối chứng ít nhất 5 điểm phần trăm.

## Clarifications

### Session 2026-11-12

- Q: Tỷ lệ số ngày hết size hiện nay? → A: 18%, theo báo cáo tồn kho quý 3/2026.
VIBEBIZ_SEED_3
mkdir -p "$(dirname 'specs/001-map-revisit/plan.md')"
cat > 'specs/001-map-revisit/plan.md' <<'VIBEBIZ_SEED_4'
# Plan: Bổ sung hàng tự động cho 12 cửa hàng
VIBEBIZ_SEED_4
mkdir -p "$(dirname 'specs/001-map-revisit/decisions.md')"
cat > 'specs/001-map-revisit/decisions.md' <<'VIBEBIZ_SEED_5'
# Decisions: Bổ sung hàng tự động cho 12 cửa hàng

## D-001 — Mốc tỷ lệ ngày hết size

- date: 2026-11-12
- type: answer
- text: Tỷ lệ số ngày hết size bán chạy hiện là 18%.
- reason: Báo cáo tồn kho quý 3/2026.

## D-002 — Mốc mới thay cho D-001

- date: 2026-11-20
- type: supersede
- supersedes: D-001
- text: Tỷ lệ số ngày hết size bán chạy hiện là 26%, không phải 18%.
- reason: Phòng cung ứng đo lại tháng 11/2026; cách tính cũ bỏ sót 4 cửa hàng mở trong quý 3.
VIBEBIZ_SEED_5
mkdir -p "$(dirname 'specs/001-map-revisit/assumptions.md')"
cat > 'specs/001-map-revisit/assumptions.md' <<'VIBEBIZ_SEED_6'
# Assumptions: Bổ sung hàng tự động cho 12 cửa hàng
VIBEBIZ_SEED_6
mkdir -p "$(dirname 'specs/001-map-revisit/open-questions.md')"
cat > 'specs/001-map-revisit/open-questions.md' <<'VIBEBIZ_SEED_7'
# Open questions: Bổ sung hàng tự động cho 12 cửa hàng
VIBEBIZ_SEED_7
mkdir -p "$(dirname 'specs/001-map-revisit/glossary.md')"
cat > 'specs/001-map-revisit/glossary.md' <<'VIBEBIZ_SEED_8'
# Glossary: Bổ sung hàng tự động cho 12 cửa hàng
VIBEBIZ_SEED_8
mkdir -p "$(dirname 'specs/001-map-revisit/checklists/board.md')"
cat > 'specs/001-map-revisit/checklists/board.md' <<'VIBEBIZ_SEED_9'
# Definition of Ready: board
VIBEBIZ_SEED_9
mkdir -p "$(dirname 'specs/001-map-revisit/checklists/tech.md')"
cat > 'specs/001-map-revisit/checklists/tech.md' <<'VIBEBIZ_SEED_10'
# Definition of Ready: tech
VIBEBIZ_SEED_10
mkdir -p "$(dirname 'specs/001-map-revisit/diagrams/.keep')"
: > 'specs/001-map-revisit/diagrams/.keep'
mkdir -p "$(dirname 'specs/001-map-revisit/exports/.keep')"
: > 'specs/001-map-revisit/exports/.keep'
