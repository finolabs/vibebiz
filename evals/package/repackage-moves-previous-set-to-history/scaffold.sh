#!/usr/bin/env bash
# Seeds a fictional workspace (no real data). Run with: claude plugin eval ... --scaffold
set -euo pipefail
mkdir -p "$(dirname 'constitution.md')"
cat > 'constitution.md' <<'VIBEBIZ_SEED_0'
---
status: set
priorities: ["giảm tỉ lệ trả hàng online", "giữ khách quen"]
approval_ceiling:
  amount: 300000000
  currency: VND
vertical: fashion
mandatory_approvals: ["duyệt bởi người trước khi gửi khuyến mãi"]
updated: "2026-11-12"
---

# Ground rules
VIBEBIZ_SEED_0
mkdir -p "$(dirname 'index.html')"
cat > 'index.html' <<'VIBEBIZ_SEED_1'
<!doctype html><html><head><meta charset="utf-8"><title>vibebiz</title></head><body><script type="application/json" id="vibebiz-data">{"workspace": {"updated": "2026-11-12", "ground_rules_status": "set"}, "ideas": [{"id": "001", "title": "Gợi ý size trên website", "status": "packaged", "estimate_status": "not-tech-reviewed", "coverage": {"clear": 14, "total": 15}, "next_step": "Đóng gói cho hội đồng", "outputs": ["exports/board-deck.html", "exports/tech-prd.html"], "updated": "2026-11-12"}], "examples": []}</script></body></html>
VIBEBIZ_SEED_1
mkdir -p "$(dirname 'specs/001-goi-y-size-tren-website/coverage.md')"
cat > 'specs/001-goi-y-size-tren-website/coverage.md' <<'VIBEBIZ_SEED_2'
---
id: "001"
slug: goi-y-size-tren-website
title: "Gợi ý size trên website"
language: vi
vertical: fashion
cynefin: complicated
status: packaged
estimate_status: not-tech-reviewed
budget_rounds_used: 0
latest_export: "2026-11-05"
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
    status: clear
    reason: null
    prerequisites: [C, D]
    filled_by: solution-sketch
    frameworks: []
    updated: "2026-11-12"
  F:
    status: clear
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
    status: deferred
    reason: "Giai đoạn đầu chỉ chạy trên website; tích hợp sàn để sau."
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

# Coverage: Gợi ý size trên website

| Code | Category | Status | Reason (when deferred) | Updated |
|---|---|---|---|---|
| A | Problem and why | clear |  | 2026-11-12 |
| B | Users and stakeholders | clear |  | 2026-11-12 |
| C | Outcome and measurement | clear |  | 2026-11-12 |
| D | Alternatives | clear |  | 2026-11-12 |
| E | Scope and behavior | clear |  | 2026-11-12 |
| F | AI fit | clear |  | 2026-11-12 |
| G | Data and entities | clear |  | 2026-11-12 |
| H | Integrations | deferred | Giai đoạn đầu chỉ chạy trên website; tích hợp sàn để sau. | 2026-11-12 |
| I | Non-functional needs | clear |  | 2026-11-12 |
| J | Edge cases and failures | clear |  | 2026-11-12 |
| K | Risk and compliance | clear |  | 2026-11-12 |
| L | Organizational change | clear |  | 2026-11-12 |
| M | Cost, resources and return | clear |  | 2026-11-12 |
| N | Terminology | clear |  | 2026-11-12 |
| O | Completion signals | clear |  | 2026-11-12 |

**Clear**: 14 of 15
VIBEBIZ_SEED_2
mkdir -p "$(dirname 'specs/001-goi-y-size-tren-website/spec.md')"
cat > 'specs/001-goi-y-size-tren-website/spec.md' <<'VIBEBIZ_SEED_3'
# Feature Specification: Gợi ý size trên website

**Feature Branch**: `001-goi-y-size-tren-website`

**Created**: 2026-11-12

**Status**: Draft

**Input**: User description: "Khách online trả hàng nhiều quá vì không vừa size, tao muốn có cái gì đó gợi ý size cho họ."

## Problem & Why

Mộc Nhiên Denim (thương hiệu quần jean giả định, 12 cửa hàng, 60% doanh thu qua website) có tỉ lệ trả hàng online 31%, trong đó 58% vì sai size. Mỗi tháng khoảng 1.900 đơn trả, mỗi đơn tốn trung bình 52.000 đồng vận chuyển hai chiều và xử lý; đội chăm sóc khách hàng 9 người xử lý đổi trả. (Nguồn: số liệu do giám đốc kinh doanh nêu, 2026-11-12; chưa kiểm chứng.)

## Outcome

Giảm tỉ lệ trả hàng vì sai size từ 58% xuống 40% trong 4 tháng kể từ ngày chạy thử. Giới hạn bảo vệ: khách không phải trả lời quá 3 câu hỏi, vì tỉ lệ bỏ giỏ hàng đã ở mức 68%. Tiêu chí dừng: nếu sau 2 tháng chạy thử tỉ lệ sai size không giảm xuống dưới 50%, hoặc quá 1 trên 5 gợi ý bị khách báo là sai, dừng và xem lại.

## Alternatives

- Không làm gì: tiếp tục mất khoảng 99 triệu đồng mỗi tháng cho đơn trả vì sai size (1.900 đơn x 58% x 52.000 đồng, ước tính chưa kiểm chứng).
- Sửa quy trình: bảng size rõ hơn, ảnh người mẫu kèm số đo, nhắn xác nhận size trước khi giao.
- Mua công cụ gợi ý size có sẵn.
- Tự xây gợi ý dựa trên 2 năm lịch sử đơn và lý do trả.

Đề xuất: làm bước sửa quy trình ngay, thử gợi ý size theo lịch sử đơn ở một nhóm hàng.

## AI-fit

Một quy tắc theo bảng size là đủ cho khách mua lần đầu; gợi ý dựa trên lịch sử mua và trả của nhóm khách tương tự cần mô hình thống kê. Có 2 năm lịch sử đơn và lý do trả; chưa có số đo cơ thể. Gợi ý sai làm khách mất lòng tin, chấp nhận sai tối đa 1 trên 5 gợi ý. Nhân viên chăm sóc khách hàng duyệt các trường hợp gợi ý lệch quá hai cỡ.

## Cost & Risk

Cỡ M. Ngân sách tối đa 250 triệu đồng, quyết định trong quý này (ước tính chưa được đội kỹ thuật xem xét). Rủi ro chính: gợi ý sai làm khách mất lòng tin; hỏi quá nhiều câu làm tăng bỏ giỏ. Đội chăm sóc khách hàng đổi cách làm việc: thêm bước duyệt các trường hợp lệch cỡ.

## Clarifications

### Session 2026-11-12

- Q: Điều gì khiến bạn muốn làm việc này ngay bây giờ? → A: Khách trả hàng vì sai size quá nhiều, 31% đơn online.
- Q: Kết quả mong muốn là gì? → A: Giảm trả hàng vì size từ 58% xuống 40% trong 4 tháng.
- Q: Có giới hạn nào khi hỏi khách? → A: Không quá 3 câu, vì bỏ giỏ hàng đã ở mức 68%.
- Skipped: Có tích hợp với các sàn thương mại điện tử ngay từ đầu không?

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Khách nhận gợi ý size khi chọn quần (Priority: P1)

Khách mua online chọn một chiếc quần và thấy gợi ý size sau tối đa 3 câu hỏi ngắn.

**Why this priority**: Đây là chỗ khách chọn sai size nên là giá trị chính.

**Independent Test**: Chạy với một nhóm hàng quần nam trên website và so tỉ lệ trả vì size với nhóm đối chứng.

**Acceptance Scenarios**:

1. **Given** khách chưa từng mua, **When** khách trả lời 3 câu hỏi về chiều cao, cân nặng và kiểu mặc, **Then** website hiển thị một size gợi ý kèm lý do ngắn
2. **Given** khách đã mua trước đó, **When** khách mở trang sản phẩm, **Then** website gợi ý size dựa trên đơn cũ mà không hỏi thêm

---

### User Story 2 - Nhân viên chăm sóc khách duyệt gợi ý lệch (Priority: P2)

Nhân viên chăm sóc khách xem danh sách gợi ý lệch quá hai cỡ so với size khách từng mua và xác nhận hoặc sửa.

**Why this priority**: Giữ lòng tin của khách khi gợi ý có thể sai.

**Independent Test**: Tạo 10 trường hợp lệch giả định và kiểm tra nhân viên duyệt được trong ngày.

**Acceptance Scenarios**:

1. **Given** một gợi ý lệch quá hai cỡ, **When** đơn được tạo, **Then** đơn vào danh sách chờ duyệt của nhân viên

---

### Edge Cases

- Khách mua quần cho người khác thì gợi ý theo ai?
- Khách bỏ qua cả 3 câu hỏi thì sao?
- Mẫu quần mới chưa có lịch sử đơn thì gợi ý thế nào?

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: Hệ thống MUST đưa ra một size gợi ý sau tối đa 3 câu hỏi.
- **FR-002**: Hệ thống MUST ghi lại size gợi ý và size khách chọn để đo tỉ lệ trả vì sai size.
- **FR-003**: Hệ thống MUST chuyển gợi ý lệch quá hai cỡ cho nhân viên chăm sóc khách duyệt.
- **FR-004**: Hệ thống MUST cho phép khách bỏ qua gợi ý và tự chọn size.

### Key Entities *(include if feature involves data)*

- **Đơn hàng**: lịch sử mua, size đã chọn, lý do trả nếu có.
- **Gợi ý size**: size đề xuất, lý do, mức tin cậy, kết quả khách chọn.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Tỉ lệ trả hàng vì sai size giảm từ 58% xuống 40% trong 4 tháng (giả định, đo từ lịch sử đơn).
- **SC-002**: Không quá 1 trên 5 gợi ý bị khách báo là sai.
- **SC-003**: Tỉ lệ bỏ giỏ hàng không tăng quá mức 68% hiện tại.

## Assumptions

- Lịch sử 2 năm đơn và lý do trả đủ sạch để dùng (chưa kiểm chứng).
- Khách chấp nhận trả lời tối đa 3 câu hỏi.
- Tích hợp với sàn thương mại điện tử để giai đoạn sau.
VIBEBIZ_SEED_3
mkdir -p "$(dirname 'specs/001-goi-y-size-tren-website/plan.md')"
cat > 'specs/001-goi-y-size-tren-website/plan.md' <<'VIBEBIZ_SEED_4'
---
estimate_status: not-tech-reviewed
updated: "2026-11-12"
---

# Business plan: Gợi ý size trên website

## Decision requested

Hội đồng duyệt tối đa 250 triệu đồng năm đầu để chạy thử gợi ý size ở một nhóm hàng quần nam, quyết định trong quý này.

## Size and scenarios

Cỡ M (ước tính chưa được đội kỹ thuật xem xét).

| Scenario | Cost | Resources | Return | Time frame |
|---|---|---|---|---|
| Low | 180 triệu đồng (giả định) | 2 người trong 3 tháng | tiết kiệm 10 triệu đồng mỗi tháng (giả định) | 4 tháng chạy thử |
| Base | 250 triệu đồng (giả định) | 3 người trong 4 tháng | tiết kiệm khoảng 17,8 triệu đồng mỗi tháng: 342 đơn x 52.000 đồng (giả định, từ số đo trên đơn trả hiện tại) | 4 tháng chạy thử |
| High | 320 triệu đồng (giả định) | 4 người trong 5 tháng | tiết kiệm 25 triệu đồng mỗi tháng (giả định) | 4 tháng chạy thử |

## Pilot roadmap and decision points

1. Tháng 1: sửa quy trình (bảng size, nhắn xác nhận) và đo lại tỉ lệ sai size.
2. Tháng 2 đến 3: chạy thử gợi ý ở nhóm quần nam; điểm quyết định cuối tháng 3 theo tiêu chí dừng.
3. Tháng 4: mở rộng sang nhóm quần nữ nếu sai size dưới 50% và gợi ý sai không quá 1 trên 5.

## Organizational change

Đội chăm sóc khách hàng (9 người) thêm bước duyệt gợi ý lệch quá hai cỡ; cần buổi hướng dẫn nửa ngày.

## Ground rules check

Ngân sách 250 triệu đồng nằm dưới mức giám đốc kinh doanh được tự duyệt 300 triệu đồng. Không có xung đột với bước duyệt bắt buộc của con người.
VIBEBIZ_SEED_4
mkdir -p "$(dirname 'specs/001-goi-y-size-tren-website/decisions.md')"
cat > 'specs/001-goi-y-size-tren-website/decisions.md' <<'VIBEBIZ_SEED_5'
# Decisions: Gợi ý size trên website

## D-001 — Giới hạn số câu hỏi

- date: 2026-11-12
- type: answer
- text: Không hỏi khách quá 3 câu.
- reason: Tỉ lệ bỏ giỏ hàng đã ở mức 68%.

## D-002 — Tích hợp sàn để sau

- date: 2026-11-12
- type: answer
- text: Hoãn tích hợp với sàn thương mại điện tử sang giai đoạn sau.
- reason: Giai đoạn đầu chỉ chạy trên website.
VIBEBIZ_SEED_5
mkdir -p "$(dirname 'specs/001-goi-y-size-tren-website/assumptions.md')"
cat > 'specs/001-goi-y-size-tren-website/assumptions.md' <<'VIBEBIZ_SEED_6'
# Assumptions: Gợi ý size trên website

## A-001

- text: Lịch sử 2 năm đơn và lý do trả đủ sạch để dùng.
- tested: no
- evidence: chưa có
- riskiest: true
- source: stated

## A-002

- text: Khách chấp nhận trả lời tối đa 3 câu hỏi.
- tested: no
- evidence: chưa có
- riskiest: false
- source: stated
VIBEBIZ_SEED_6
mkdir -p "$(dirname 'specs/001-goi-y-size-tren-website/open-questions.md')"
cat > 'specs/001-goi-y-size-tren-website/open-questions.md' <<'VIBEBIZ_SEED_7'
# Open questions: Gợi ý size trên website

## Q-001

- text: Nhóm hàng nào chạy thử đầu tiên, quần nam hay quần nữ?
- owner: giám đốc kinh doanh
- unblocks: kế hoạch chạy thử
- blocking: false
- category: E
- status: open
VIBEBIZ_SEED_7
mkdir -p "$(dirname 'specs/001-goi-y-size-tren-website/glossary.md')"
cat > 'specs/001-goi-y-size-tren-website/glossary.md' <<'VIBEBIZ_SEED_8'
# Glossary: Gợi ý size trên website

- Trả vì sai size: đơn bị trả lại mà lý do khách chọn là không vừa size.
- Bỏ giỏ hàng: khách thêm hàng vào giỏ nhưng không thanh toán.
VIBEBIZ_SEED_8
mkdir -p "$(dirname 'specs/001-goi-y-size-tren-website/checklists/board.md')"
cat > 'specs/001-goi-y-size-tren-website/checklists/board.md' <<'VIBEBIZ_SEED_9'
# Definition of Ready: board

- [x] Quyết định cần hội đồng duyệt, số tiền và hạn được nêu rõ
- [x] Vấn đề có số liệu hiện tại và nguồn
- [x] Kết quả có mức hiện tại, mục tiêu, thời hạn và tiêu chí dừng
- [x] Đã cân nhắc không làm gì và sửa quy trình
- [x] Chi phí và lợi ích có ba kịch bản, gắn nhãn ước tính chưa được đội kỹ thuật xem xét
VIBEBIZ_SEED_9
mkdir -p "$(dirname 'specs/001-goi-y-size-tren-website/checklists/tech.md')"
cat > 'specs/001-goi-y-size-tren-website/checklists/tech.md' <<'VIBEBIZ_SEED_10'
# Definition of Ready: tech

- [x] Mỗi câu chuyện người dùng có kịch bản Given/When/Then kiểm tra được
- [x] Yêu cầu đánh số FR-### và tiêu chí thành công SC-###
- [x] Dữ liệu và thực thể chính được nêu
- [x] Mục AI có chi phí sai và điểm con người duyệt
- [x] Câu hỏi mở được đánh dấu chặn hoặc không chặn
VIBEBIZ_SEED_10
mkdir -p "$(dirname 'specs/001-goi-y-size-tren-website/diagrams/.keep')"
: > 'specs/001-goi-y-size-tren-website/diagrams/.keep'
mkdir -p "$(dirname 'specs/001-goi-y-size-tren-website/exports/board-deck.html')"
cat > 'specs/001-goi-y-size-tren-website/exports/board-deck.html' <<'VIBEBIZ_SEED_12'
<!doctype html><html><body><!-- SEED-PREVIOUS-SET-2026-11-05 --></body></html>
VIBEBIZ_SEED_12
mkdir -p "$(dirname 'specs/001-goi-y-size-tren-website/exports/tech-prd.html')"
cat > 'specs/001-goi-y-size-tren-website/exports/tech-prd.html' <<'VIBEBIZ_SEED_13'
<!doctype html><html><body><!-- SEED-PREVIOUS-SET-2026-11-05 --></body></html>
VIBEBIZ_SEED_13
mkdir -p "$(dirname 'specs/001-goi-y-size-tren-website/exports/spec.md')"
cat > 'specs/001-goi-y-size-tren-website/exports/spec.md' <<'VIBEBIZ_SEED_14'
# Feature Specification: Gợi ý size trên website

**Feature Branch**: `001-goi-y-size-tren-website`

**Created**: 2026-11-12

**Status**: Draft

**Input**: User description: "Khách online trả hàng nhiều quá vì không vừa size, tao muốn có cái gì đó gợi ý size cho họ."

## Problem & Why

Mộc Nhiên Denim (thương hiệu quần jean giả định, 12 cửa hàng, 60% doanh thu qua website) có tỉ lệ trả hàng online 31%, trong đó 58% vì sai size. Mỗi tháng khoảng 1.900 đơn trả, mỗi đơn tốn trung bình 52.000 đồng vận chuyển hai chiều và xử lý; đội chăm sóc khách hàng 9 người xử lý đổi trả. (Nguồn: số liệu do giám đốc kinh doanh nêu, 2026-11-12; chưa kiểm chứng.)

## Outcome

Giảm tỉ lệ trả hàng vì sai size từ 58% xuống 40% trong 4 tháng kể từ ngày chạy thử. Giới hạn bảo vệ: khách không phải trả lời quá 3 câu hỏi, vì tỉ lệ bỏ giỏ hàng đã ở mức 68%. Tiêu chí dừng: nếu sau 2 tháng chạy thử tỉ lệ sai size không giảm xuống dưới 50%, hoặc quá 1 trên 5 gợi ý bị khách báo là sai, dừng và xem lại.

## Alternatives

- Không làm gì: tiếp tục mất khoảng 99 triệu đồng mỗi tháng cho đơn trả vì sai size (1.900 đơn x 58% x 52.000 đồng, ước tính chưa kiểm chứng).
- Sửa quy trình: bảng size rõ hơn, ảnh người mẫu kèm số đo, nhắn xác nhận size trước khi giao.
- Mua công cụ gợi ý size có sẵn.
- Tự xây gợi ý dựa trên 2 năm lịch sử đơn và lý do trả.

Đề xuất: làm bước sửa quy trình ngay, thử gợi ý size theo lịch sử đơn ở một nhóm hàng.

## AI-fit

Một quy tắc theo bảng size là đủ cho khách mua lần đầu; gợi ý dựa trên lịch sử mua và trả của nhóm khách tương tự cần mô hình thống kê. Có 2 năm lịch sử đơn và lý do trả; chưa có số đo cơ thể. Gợi ý sai làm khách mất lòng tin, chấp nhận sai tối đa 1 trên 5 gợi ý. Nhân viên chăm sóc khách hàng duyệt các trường hợp gợi ý lệch quá hai cỡ.

## Cost & Risk

Cỡ M. Ngân sách tối đa 250 triệu đồng, quyết định trong quý này (ước tính chưa được đội kỹ thuật xem xét). Rủi ro chính: gợi ý sai làm khách mất lòng tin; hỏi quá nhiều câu làm tăng bỏ giỏ. Đội chăm sóc khách hàng đổi cách làm việc: thêm bước duyệt các trường hợp lệch cỡ.

## Clarifications

### Session 2026-11-12

- Q: Điều gì khiến bạn muốn làm việc này ngay bây giờ? → A: Khách trả hàng vì sai size quá nhiều, 31% đơn online.
- Q: Kết quả mong muốn là gì? → A: Giảm trả hàng vì size từ 58% xuống 40% trong 4 tháng.
- Q: Có giới hạn nào khi hỏi khách? → A: Không quá 3 câu, vì bỏ giỏ hàng đã ở mức 68%.
- Skipped: Có tích hợp với các sàn thương mại điện tử ngay từ đầu không?

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Khách nhận gợi ý size khi chọn quần (Priority: P1)

Khách mua online chọn một chiếc quần và thấy gợi ý size sau tối đa 3 câu hỏi ngắn.

**Why this priority**: Đây là chỗ khách chọn sai size nên là giá trị chính.

**Independent Test**: Chạy với một nhóm hàng quần nam trên website và so tỉ lệ trả vì size với nhóm đối chứng.

**Acceptance Scenarios**:

1. **Given** khách chưa từng mua, **When** khách trả lời 3 câu hỏi về chiều cao, cân nặng và kiểu mặc, **Then** website hiển thị một size gợi ý kèm lý do ngắn
2. **Given** khách đã mua trước đó, **When** khách mở trang sản phẩm, **Then** website gợi ý size dựa trên đơn cũ mà không hỏi thêm

---

### User Story 2 - Nhân viên chăm sóc khách duyệt gợi ý lệch (Priority: P2)

Nhân viên chăm sóc khách xem danh sách gợi ý lệch quá hai cỡ so với size khách từng mua và xác nhận hoặc sửa.

**Why this priority**: Giữ lòng tin của khách khi gợi ý có thể sai.

**Independent Test**: Tạo 10 trường hợp lệch giả định và kiểm tra nhân viên duyệt được trong ngày.

**Acceptance Scenarios**:

1. **Given** một gợi ý lệch quá hai cỡ, **When** đơn được tạo, **Then** đơn vào danh sách chờ duyệt của nhân viên

---

### Edge Cases

- Khách mua quần cho người khác thì gợi ý theo ai?
- Khách bỏ qua cả 3 câu hỏi thì sao?
- Mẫu quần mới chưa có lịch sử đơn thì gợi ý thế nào?

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: Hệ thống MUST đưa ra một size gợi ý sau tối đa 3 câu hỏi.
- **FR-002**: Hệ thống MUST ghi lại size gợi ý và size khách chọn để đo tỉ lệ trả vì sai size.
- **FR-003**: Hệ thống MUST chuyển gợi ý lệch quá hai cỡ cho nhân viên chăm sóc khách duyệt.
- **FR-004**: Hệ thống MUST cho phép khách bỏ qua gợi ý và tự chọn size.

### Key Entities *(include if feature involves data)*

- **Đơn hàng**: lịch sử mua, size đã chọn, lý do trả nếu có.
- **Gợi ý size**: size đề xuất, lý do, mức tin cậy, kết quả khách chọn.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Tỉ lệ trả hàng vì sai size giảm từ 58% xuống 40% trong 4 tháng (giả định, đo từ lịch sử đơn).
- **SC-002**: Không quá 1 trên 5 gợi ý bị khách báo là sai.
- **SC-003**: Tỉ lệ bỏ giỏ hàng không tăng quá mức 68% hiện tại.

## Assumptions

- Lịch sử 2 năm đơn và lý do trả đủ sạch để dùng (chưa kiểm chứng).
- Khách chấp nhận trả lời tối đa 3 câu hỏi.
- Tích hợp với sàn thương mại điện tử để giai đoạn sau.
VIBEBIZ_SEED_14
mkdir -p "$(dirname 'specs/001-goi-y-size-tren-website/exports/data.json')"
cat > 'specs/001-goi-y-size-tren-website/exports/data.json' <<'VIBEBIZ_SEED_15'
{
  "idea": {
    "id": "001",
    "title": "Gợi ý size trên website",
    "language": "vi",
    "version": "2026-11-05",
    "draft": false,
    "estimate_status": "not-tech-reviewed"
  },
  "board": {
    "slides": []
  },
  "tech": {
    "sections": []
  },
  "numbers": [],
  "gaps": [],
  "links": {
    "board_artifact": "https://example.invalid/artifact/seed-board",
    "tech_artifact": "https://example.invalid/artifact/seed-tech",
    "slides": null,
    "docs": null
  }
}
VIBEBIZ_SEED_15
mkdir -p "$(dirname 'specs/001-goi-y-size-tren-website/exports/links.md')"
cat > 'specs/001-goi-y-size-tren-website/exports/links.md' <<'VIBEBIZ_SEED_16'
# Links

- Board (Artifact): https://example.invalid/artifact/seed-board
- Tech (Artifact): https://example.invalid/artifact/seed-tech
VIBEBIZ_SEED_16
