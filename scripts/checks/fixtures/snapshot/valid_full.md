# Feature Specification: Nhắc khách cũ quay lại mua hàng

**Feature Branch**: `001-nhac-khach-cu-quay-lai`

**Created**: 2026-11-12

**Status**: Draft

**Input**: User description: "Chuỗi cửa hàng thời trang giả định muốn nhắc khách lâu chưa quay lại"

## Problem & Why

Khách thành viên của một chuỗi giả định bỏ đi sau mùa giảm giá; cửa hàng không biết ai cần nhắc.

## Outcome

Tỷ lệ khách quay lại trong mùa tăng từ 18% lên 24% (số liệu giả định).

## Alternatives

Không làm gì; sửa quy trình gọi điện tại cửa hàng; mua công cụ có sẵn; tự xây.

## AI-fit

Một quy tắc theo số ngày chưa mua là đủ cho bản đầu; chưa cần AI.

## Cost & Risk

Cỡ S. Rủi ro: gửi tin nhắn khi khách chưa đồng ý nhận.

## Clarifications

### Session 2026-11-12

- Q: Ai được gửi tin nhắn? → A: Chỉ khách đã đồng ý nhận tin.
- Skipped: Kênh nhắn tin ưu tiên

## User Scenarios & Testing *(mandatory)*

<!--
  ### This commented heading is ignored
-->

### User Story 1 - Nhắc khách lâu chưa quay lại (Priority: P1)

Quản lý cửa hàng thấy danh sách khách cần nhắc mỗi sáng.

**Why this priority**: Đây là giá trị chính.

**Independent Test**: Chạy với một cửa hàng giả định.

**Acceptance Scenarios**:

1. **Given** một khách 60 ngày chưa mua, **When** đến sáng thứ Hai, **Then** khách có trong danh sách

---

### User Story 2 - Xem kết quả nhắc (Priority: P2)

Giám đốc kinh doanh xem số khách quay lại sau khi nhắc.

---

### Edge Cases

- Khách đổi số điện thoại thì sao?

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: Hệ thống MUST lập danh sách khách 60 ngày chưa mua.
- **FR-002**: Hệ thống MUST chỉ nhắc khách đã đồng ý nhận tin.

### Key Entities *(include if feature involves data)*

- **Khách thành viên**: người có thẻ thành viên.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Tỷ lệ khách quay lại trong mùa đạt 24% (giả định, so với FR-001).

## Assumptions

- Dữ liệu mua hàng có sẵn hằng ngày.
