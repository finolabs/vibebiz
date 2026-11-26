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
mkdir -p "$(dirname 'specs/001-fit-rice-ice/coverage.md')"
cat > 'specs/001-fit-rice-ice/coverage.md' <<'VIBEBIZ_SEED_2'
---
id: "001"
slug: fit-rice-ice
title: "Xếp thứ tự việc cải tiến website năm 2027"
language: vi
vertical: fashion
cynefin: complicated
status: clarifying
estimate_status: not-tech-reviewed
budget_rounds_used: 0
latest_export: null
next_step: "Đóng gói cho hội đồng"
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
    status: deferred
    reason: "Ý tưởng không dùng AI"
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
    status: clear
    reason: null
    prerequisites: [E, G]
    filled_by: clarify
    frameworks: []
    updated: "2026-11-12"
  I:
    status: clear
    reason: null
    prerequisites: [E]
    filled_by: solution-sketch
    frameworks: []
    updated: "2026-11-12"
  J:
    status: clear
    reason: null
    prerequisites: [E]
    filled_by: solution-sketch
    frameworks: []
    updated: "2026-11-12"
  K:
    status: clear
    reason: null
    prerequisites: [E, G]
    filled_by: challenge
    frameworks: []
    updated: "2026-11-12"
  L:
    status: clear
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
    status: clear
    reason: null
    prerequisites: [C, E]
    filled_by: outcome
    frameworks: []
    updated: "2026-11-12"
---

# Coverage: Xếp thứ tự việc cải tiến website năm 2027

| Code | Category | Status | Reason (when deferred) | Updated |
|---|---|---|---|---|
| A | Problem and why | clear |  | 2026-11-12 |
| B | Users and stakeholders | clear |  | 2026-11-12 |
| C | Outcome and measurement | clear |  | 2026-11-12 |
| D | Alternatives | clear |  | 2026-11-12 |
| E | Scope and behavior | partial |  | 2026-11-12 |
| F | AI fit | deferred | Ý tưởng không dùng AI | 2026-11-12 |
| G | Data and entities | clear |  | 2026-11-12 |
| H | Integrations | clear |  | 2026-11-12 |
| I | Non-functional needs | clear |  | 2026-11-12 |
| J | Edge cases and failures | clear |  | 2026-11-12 |
| K | Risk and compliance | clear |  | 2026-11-12 |
| L | Organizational change | clear |  | 2026-11-12 |
| M | Cost, resources and return | clear |  | 2026-11-12 |
| N | Terminology | clear |  | 2026-11-12 |
| O | Completion signals | clear |  | 2026-11-12 |

**Clear**: 13 of 15
VIBEBIZ_SEED_2
mkdir -p "$(dirname 'specs/001-fit-rice-ice/spec.md')"
cat > 'specs/001-fit-rice-ice/spec.md' <<'VIBEBIZ_SEED_3'
# Feature Specification: Xếp thứ tự việc cải tiến website năm 2027

**Created**: 2026-11-12

**Status**: Draft

## Problem & Why

Chuỗi giả định "Mây Chiều" (40 cửa hàng thời trang nữ, website bán khoảng 25% doanh thu) có tỉ lệ chuyển đổi trên website 1,2% (báo cáo phân tích website tháng 10/2026, đo). Đội website 4 người nhận 16 đề xuất cải tiến từ các phòng: lọc theo size còn hàng, thanh toán một bước, ảnh người mẫu theo chiều cao, gợi ý phối đồ, lưu giỏ hàng, đánh giá có ảnh và 10 việc khác. Mỗi đề xuất chạm tới một số trang khác nhau, và báo cáo phân tích website đã có số lượt xem từng trang mỗi tháng. Đội chỉ làm được vài việc mỗi quý và đang tranh cãi làm việc nào trước.

**Người liên quan**: đội website; đội thương mại điện tử; đội marketing; đội chăm sóc khách hàng; giám đốc thương mại điện tử duyệt.

## Outcome

Tỉ lệ chuyển đổi trên website từ 1,2% lên 1,6% trong năm 2027 (số 1,2%: báo cáo phân tích website tháng 10/2026, đo). Giới hạn: tốc độ tải trang không chậm hơn hiện tại. Tiêu chí dừng: một việc đã làm xong mà sau 6 tuần không đổi tỉ lệ chuyển đổi ở trang nó chạm tới thì không làm tiếp các việc cùng loại.

## Alternatives

- Không làm gì: giữ website như hiện tại.
- Thuê thêm người: chưa có ngân sách.
- **Đã chọn**: làm lần lượt các đề xuất với đội hiện có, theo một thứ tự rõ ràng.

## AI-fit

Không dùng AI; mục này hoãn.

## Cost & Risk

Cỡ M (chưa qua kỹ thuật thẩm định). Số tiền chưa làm rõ.

## Clarifications

### Session 2026-11-12

- Q: Điều gì khiến bạn làm việc này? → A: Như phần vấn đề.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Khách mua trên website (Priority: P1)

**Acceptance Scenarios**:

1. **Given** khách vào website, **When** khách tìm và mua hàng, **Then** khách hoàn tất đơn mà không bỏ giữa chừng

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: Kế hoạch MUST nêu thứ tự làm 16 đề xuất cho hai quý đầu năm 2027 và lý do.
- **FR-002**: Danh sách 16 đề xuất nằm trong tệp danh sách của đội website; mỗi đề xuất ghi trang nó chạm tới.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Tỉ lệ chuyển đổi trên website tăng như phần Outcome.

## Assumptions

- Đội website giữ nguyên 4 người trong năm 2027 (giả định, chưa kiểm chứng).
VIBEBIZ_SEED_3
mkdir -p "$(dirname 'specs/001-fit-rice-ice/decisions.md')"
cat > 'specs/001-fit-rice-ice/decisions.md' <<'VIBEBIZ_SEED_4'
# Decisions: Xếp thứ tự việc cải tiến website năm 2027
VIBEBIZ_SEED_4
mkdir -p "$(dirname 'specs/001-fit-rice-ice/assumptions.md')"
cat > 'specs/001-fit-rice-ice/assumptions.md' <<'VIBEBIZ_SEED_5'
# Assumptions: Xếp thứ tự việc cải tiến website năm 2027
VIBEBIZ_SEED_5
mkdir -p "$(dirname 'specs/001-fit-rice-ice/open-questions.md')"
cat > 'specs/001-fit-rice-ice/open-questions.md' <<'VIBEBIZ_SEED_6'
# Open questions: Xếp thứ tự việc cải tiến website năm 2027
VIBEBIZ_SEED_6
mkdir -p "$(dirname 'specs/001-fit-rice-ice/glossary.md')"
cat > 'specs/001-fit-rice-ice/glossary.md' <<'VIBEBIZ_SEED_7'
# Glossary: Xếp thứ tự việc cải tiến website năm 2027
VIBEBIZ_SEED_7
mkdir -p "$(dirname 'specs/001-fit-rice-ice/checklists/board.md')"
cat > 'specs/001-fit-rice-ice/checklists/board.md' <<'VIBEBIZ_SEED_8'
# Definition of Ready: board
VIBEBIZ_SEED_8
mkdir -p "$(dirname 'specs/001-fit-rice-ice/checklists/tech.md')"
cat > 'specs/001-fit-rice-ice/checklists/tech.md' <<'VIBEBIZ_SEED_9'
# Definition of Ready: tech
VIBEBIZ_SEED_9
mkdir -p "$(dirname 'specs/001-fit-rice-ice/diagrams/.keep')"
: > 'specs/001-fit-rice-ice/diagrams/.keep'
mkdir -p "$(dirname 'specs/001-fit-rice-ice/exports/.keep')"
: > 'specs/001-fit-rice-ice/exports/.keep'
