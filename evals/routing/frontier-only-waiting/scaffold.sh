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
next_step: "SEED"
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
    status: clear
    reason: null
    prerequisites: [C, D]
    filled_by: solution-sketch
    frameworks: []
    updated: "2026-11-12"
  F:
    status: deferred
    reason: "Để sau buổi chọn phần mềm"
    prerequisites: [E]
    filled_by: solution-sketch
    frameworks: []
    updated: "2026-11-12"
  G:
    status: deferred
    reason: "Để sau buổi chọn phần mềm"
    prerequisites: [E]
    filled_by: clarify
    frameworks: []
    updated: "2026-11-12"
  H:
    status: deferred
    reason: "Để sau buổi chọn phần mềm"
    prerequisites: [E, G]
    filled_by: clarify
    frameworks: []
    updated: "2026-11-12"
  I:
    status: deferred
    reason: "Để sau buổi chọn phần mềm"
    prerequisites: [E]
    filled_by: solution-sketch
    frameworks: []
    updated: "2026-11-12"
  J:
    status: deferred
    reason: "Để sau buổi chọn phần mềm"
    prerequisites: [E]
    filled_by: solution-sketch
    frameworks: []
    updated: "2026-11-12"
  K:
    status: deferred
    reason: "Để sau buổi chọn phần mềm"
    prerequisites: [E, G]
    filled_by: challenge
    frameworks: []
    updated: "2026-11-12"
  L:
    status: deferred
    reason: "Để sau buổi chọn phần mềm"
    prerequisites: [B, E]
    filled_by: solution-sketch
    frameworks: []
    updated: "2026-11-12"
  M:
    status: partial
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
    status: deferred
    reason: "Để sau buổi chọn phần mềm"
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
| E | Scope and behavior | clear |  | 2026-11-12 |
| F | AI fit | deferred | Để sau buổi chọn phần mềm | 2026-11-12 |
| G | Data and entities | deferred | Để sau buổi chọn phần mềm | 2026-11-12 |
| H | Integrations | deferred | Để sau buổi chọn phần mềm | 2026-11-12 |
| I | Non-functional needs | deferred | Để sau buổi chọn phần mềm | 2026-11-12 |
| J | Edge cases and failures | deferred | Để sau buổi chọn phần mềm | 2026-11-12 |
| K | Risk and compliance | deferred | Để sau buổi chọn phần mềm | 2026-11-12 |
| L | Organizational change | deferred | Để sau buổi chọn phần mềm | 2026-11-12 |
| M | Cost, resources and return | partial |  | 2026-11-12 |
| N | Terminology | clear |  | 2026-11-12 |
| O | Completion signals | deferred | Để sau buổi chọn phần mềm | 2026-11-12 |

**Clear**: 5 of 15
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

- Không làm gì: tỷ lệ giữ ở 18%; mỗi tháng khoảng 1.500 khách mua một lần rồi không quay lại, mất khoảng 600 triệu đồng doanh thu mua lần hai mỗi tháng (báo cáo bán hàng quý 3/2026, đo); chờ thêm thì mất thêm hai mùa hàng như vậy.
- Sửa quy trình: nhân viên cửa hàng tự nhắn tay qua Zalo; đã thử ở 2 cửa hàng tháng 8/2026, mỗi người chỉ nhắn được khoảng 20 khách một ngày.
- Mua phần mềm nhắn tin có sẵn: phương án được chọn, đã thu hẹp còn hai nhà cung cấp; giá thuê bao hằng tháng chưa có (đã hỏi, xem Q-001).
- Tự xây: loại, vì đội kỹ thuật không có người rảnh trước tháng 3/2027.

## Scope & Behavior

Hành trình theo thứ tự ưu tiên: (1) phần mềm tự gửi tin Zalo nhắc khách chưa mua lần hai sau 45 ngày kể từ lần mua đầu; (2) khách bấm vào tin để xem hàng mới của cửa hàng gần nhất; (3) khách bấm từ chối thì không nhận tin nữa. Ngoài phạm vi: khuyến mãi riêng cho từng khách, gọi điện, khách chỉ mua online.

## Cost & Risk

Quy mô: nhỏ (ước tính của người dùng, chưa qua kỹ thuật thẩm định). Chi phí thuê bao hằng tháng: chưa làm rõ, chờ Q-001 (nhà cung cấp).

## Clarifications

### Session 2026-11-12

- Q: Điều gì khiến bạn muốn làm việc này ngay bây giờ? → A: Khách mua một lần rồi bỏ đi.
- Q: Chọn cách nào để nhắc khách? → A: Mua phần mềm nhắn tin có sẵn.
VIBEBIZ_SEED_3
mkdir -p "$(dirname 'specs/001-nhac-khach-quay-lai/plan.md')"
cat > 'specs/001-nhac-khach-quay-lai/plan.md' <<'VIBEBIZ_SEED_4'
# Plan: Nhắc khách quay lại
VIBEBIZ_SEED_4
mkdir -p "$(dirname 'specs/001-nhac-khach-quay-lai/decisions.md')"
cat > 'specs/001-nhac-khach-quay-lai/decisions.md' <<'VIBEBIZ_SEED_5'
# Decisions: Nhắc khách quay lại
VIBEBIZ_SEED_5
mkdir -p "$(dirname 'specs/001-nhac-khach-quay-lai/assumptions.md')"
cat > 'specs/001-nhac-khach-quay-lai/assumptions.md' <<'VIBEBIZ_SEED_6'
# Assumptions: Nhắc khách quay lại
VIBEBIZ_SEED_6
mkdir -p "$(dirname 'specs/001-nhac-khach-quay-lai/open-questions.md')"
cat > 'specs/001-nhac-khach-quay-lai/open-questions.md' <<'VIBEBIZ_SEED_7'
# Open questions: Nhắc khách quay lại

## Q-001

- text: Giá thuê bao hằng tháng của hai phần mềm nhắn tin đang cân nhắc là bao nhiêu?
- owner: nhà cung cấp phần mềm (phòng mua hàng đã gửi yêu cầu báo giá ngày 2026-11-10)
- unblocks: so sánh giá giữa hai phần mềm; quy mô chi phí (M)
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
