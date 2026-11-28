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
mkdir -p "$(dirname 'specs/001-nhac-khach-quay-lai/coverage.md')"
cat > 'specs/001-nhac-khach-quay-lai/coverage.md' <<'VIBEBIZ_SEED_2'
---
id: "001"
slug: nhac-khach-quay-lai
title: "Nhắc khách quay lại"
language: vi
vertical: fashion
cynefin: complicated
status: clarifying
estimate_status: not-tech-reviewed
budget_rounds_used: 0
latest_export: null
next_step: "Thử quy trình mới ở 2 cửa hàng để biết tỷ lệ mua lần hai tăng bao nhiêu điểm phần trăm"
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

# Coverage: Nhắc khách quay lại

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
| N | Terminology | clear |  | 2026-11-12 |
| O | Completion signals | missing |  | 2026-11-12 |

**Clear**: 4 of 15
VIBEBIZ_SEED_2
mkdir -p "$(dirname 'specs/001-nhac-khach-quay-lai/spec.md')"
cat > 'specs/001-nhac-khach-quay-lai/spec.md' <<'VIBEBIZ_SEED_3'
# Feature Specification: Nhắc khách quay lại

## Problem & Why

Chuỗi thời trang nữ công sở Lụa Hạ (34 cửa hàng, bán thêm trên website) muốn nhắc khách cũ quay lại mua. Chỉ 18% khách mua lần hai trong 90 ngày (báo cáo bán hàng quý 3/2026, đo). Khách mua một lần rồi không ai liên lạc lại; cửa hàng chỉ đăng bài Facebook. Làm ngay vì hàng thu đông về đầu tháng 9.

## Users & Stakeholders

Người dùng: nhân viên chăm sóc khách hàng ở văn phòng (3 người). Người bị ảnh hưởng: khách đã mua ít nhất một lần và để lại số điện thoại. Người duyệt: giám đốc kinh doanh. Có thể phản đối: quản lý cửa hàng, vì lo khách bị làm phiền.

## Outcome & Measurement

Tăng tỷ lệ khách mua lần hai trong 90 ngày từ 18% lên 24% trong 6 tháng (báo cáo bán hàng quý 3/2026, đo). Giới hạn: tỷ lệ khách bấm từ chối nhận tin dưới 3%. Chỉ số theo dõi sớm: tỷ lệ khách bấm vào tin nhắn, đọc hằng tuần. Ngưỡng dừng: sau 8 tuần thử ở 4 cửa hàng mà tỷ lệ mua lần hai không tăng ít nhất 2 điểm phần trăm so với 4 cửa hàng đối chứng thì dừng.

## Alternatives

- Không làm gì: tỷ lệ giữ ở 18%.
- Sửa quy trình: phương án được chọn làm trước (D-001): nhân viên chăm sóc khách hàng nhắn tay theo danh sách lọc từ báo cáo bán hàng; chưa biết làm vậy tăng được bao nhiêu khách quay lại (xem Q-001).
- Mua phần mềm nhắn tin có sẵn: để sau, chỉ xét nếu sửa quy trình không đạt.
- Tự xây: loại, vì đội kỹ thuật không có người rảnh trước tháng 3/2027.

## Clarifications

### Session 2026-11-12

- Q: Điều gì khiến bạn muốn làm việc này ngay bây giờ? → A: Khách mua một lần rồi bỏ đi.
- Q: Làm hướng nào trước? → A: Sửa quy trình trước.
VIBEBIZ_SEED_3
mkdir -p "$(dirname 'specs/001-nhac-khach-quay-lai/plan.md')"
cat > 'specs/001-nhac-khach-quay-lai/plan.md' <<'VIBEBIZ_SEED_4'
# Plan: Nhắc khách quay lại
VIBEBIZ_SEED_4
mkdir -p "$(dirname 'specs/001-nhac-khach-quay-lai/decisions.md')"
cat > 'specs/001-nhac-khach-quay-lai/decisions.md' <<'VIBEBIZ_SEED_5'
# Decisions: Nhắc khách quay lại

## D-001

- date: 2026-11-12
- category: D
- decision: Làm trước phương án sửa quy trình (nhân viên chăm sóc khách hàng nhắn tay theo danh sách); mua phần mềm để sau.
- source: người dùng chọn
VIBEBIZ_SEED_5
mkdir -p "$(dirname 'specs/001-nhac-khach-quay-lai/assumptions.md')"
cat > 'specs/001-nhac-khach-quay-lai/assumptions.md' <<'VIBEBIZ_SEED_6'
# Assumptions: Nhắc khách quay lại
VIBEBIZ_SEED_6
mkdir -p "$(dirname 'specs/001-nhac-khach-quay-lai/open-questions.md')"
cat > 'specs/001-nhac-khach-quay-lai/open-questions.md' <<'VIBEBIZ_SEED_7'
# Open questions: Nhắc khách quay lại

## Q-001

- text: Sửa quy trình nhắn tay tăng được bao nhiêu điểm phần trăm khách mua lần hai?
- owner: người dùng, sau khi thử ở 2 cửa hàng
- unblocks: so sánh với phương án mua phần mềm; quy mô chi phí (M)
- blocking: false
- category: D
- status: open
VIBEBIZ_SEED_7
mkdir -p "$(dirname 'specs/001-nhac-khach-quay-lai/glossary.md')"
cat > 'specs/001-nhac-khach-quay-lai/glossary.md' <<'VIBEBIZ_SEED_8'
# Glossary: Nhắc khách quay lại
VIBEBIZ_SEED_8
mkdir -p "$(dirname 'specs/001-nhac-khach-quay-lai/checklists/board.md')"
cat > 'specs/001-nhac-khach-quay-lai/checklists/board.md' <<'VIBEBIZ_SEED_9'
# Definition of Ready: board
VIBEBIZ_SEED_9
mkdir -p "$(dirname 'specs/001-nhac-khach-quay-lai/checklists/tech.md')"
cat > 'specs/001-nhac-khach-quay-lai/checklists/tech.md' <<'VIBEBIZ_SEED_10'
# Definition of Ready: tech
VIBEBIZ_SEED_10
mkdir -p "$(dirname 'specs/001-nhac-khach-quay-lai/diagrams/.keep')"
: > 'specs/001-nhac-khach-quay-lai/diagrams/.keep'
mkdir -p "$(dirname 'specs/001-nhac-khach-quay-lai/exports/.keep')"
: > 'specs/001-nhac-khach-quay-lai/exports/.keep'
