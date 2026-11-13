# Feature Specification: Nhắc khách quay lại cửa hàng qua ứng dụng chat

**Feature Branch**: `000-giu-chan-khach-cu`
**Created**: 2026-11-10
**Status**: Draft
**Input**: User description: "Tao muốn làm cái hệ thống tích điểm cho khách quen để họ mua lại nhiều hơn."

## Problem & Why

Chỉ 18% khách mua lần hai trong 90 ngày ({{N-01}} đo thực tế từ báo cáo khách hàng thân thiết 6 tháng đầu năm 2026). Trung bình mỗi lần khách cũ quay lại chi tiêu {{N-09}} (650.000 đ đo thực tế từ báo cáo bán hàng nội bộ). Bốn trên năm khách mua lần đầu không bao giờ quay lại cửa hàng (dữ liệu hư cấu chuỗi thời trang Lụa Hạ).

Sự việc gần nhất: trong đợt khuyến mại tháng trước, chuỗi cửa hàng gửi tin nhắn quảng cáo đồng loạt nhưng tỷ lệ khách quay lại không đổi, do khách nhận tin không đúng nhu cầu và nhân viên tại cửa hàng không có lịch nhắc hay danh sách khách cũ cần chăm sóc.

Nguyên nhân gốc (phân tích 5 Whys): cửa hàng hoàn toàn không có lịch nhắc khách cũ sau lần mua đầu; hiện quản lý tích điểm bằng thẻ giấy, đóng dấu thủ công, tốn khoảng 6 triệu đồng mỗi tháng tiền in thẻ và 40 giờ công đối soát cuối tháng.

Các bên liên quan: khách hàng nữ công sở 25–40 tuổi tại 34 cửa hàng của chuỗi thời trang Lụa Hạ; nhân viên quầy thu ngân (người thao tác trực tiếp, thao tác nhanh dưới 10 giây); giám đốc tài chính (duyệt ngân sách); kế toán trưởng (duyệt cách đối soát).

## Outcome

Nâng tỷ lệ khách quay lại trong 90 ngày từ {{N-01}} (18% hiện nay) lên {{N-02}} (24% mục tiêu) sau 12 tuần thí điểm ({{N-08}}) tại {{N-07}} cửa hàng.

Cây chỉ số (Driver tree):
- Chỉ số kết quả (lagging): Tỷ lệ khách quay lại trong 90 ngày (từ {{N-01}} lên {{N-02}}).
- Chỉ số dẫn dắt (leading): Tỷ lệ gửi tin nhắc thành công vào ngày thứ {{N-24}} sau lần mua đầu; tỷ lệ khách mở tin và quay lại quầy mua sắm.
- Chỉ số giữ nguyên: Giá trị trung bình mỗi đơn hàng ({{N-09}}).

Ngưỡng bảo vệ trải nghiệm (Guardrail metric): Tỷ lệ khách hủy nhận tin nhắn phải dưới {{N-10}} (2% mỗi tháng).

Điều kiện dừng thí điểm (Kill criteria): Nếu tỷ lệ khách hủy nhận tin vượt {{N-10}} trong hai tháng liên tiếp, dừng chương trình ngay lập tức để rà soát lại thông điệp và tần suất.

## Alternatives

1. Giữ nguyên (Do nothing): Không tốn chi phí nhưng tỷ lệ khách quay lại đứng yên ở mức 18% ({{N-01}}), tiếp tục mất 82% khách hàng mới.
2. Sửa quy trình (Fix the process): Nhân viên tự ghi chép sổ tay và gọi điện nhắc khách. Làm được ngay nhưng tốn giờ công, khó theo dõi và dễ gây phiền hà.
3. Mua công cụ có sẵn (Buy - Phương án chọn): Thuê giải pháp nhắn tin tự động chăm sóc khách hàng có sẵn qua Zalo/ứng dụng chat. Triển khai nhanh sau {{N-19}} (4 tuần ước tính), chi phí thí điểm {{N-03}} (180 triệu đồng ước tính, chưa qua đội kỹ thuật thẩm định). Đã ghi nhận quyết định D-001.
4. Tự xây (Build): Đội kỹ thuật tự phát triển hệ thống riêng. Tùy biến hoàn toàn nhưng mất từ {{N-20}} (16 tuần) đến {{N-21}} (26 tuần) ước tính, không kịp mùa mua sắm Tết.

## AI-fit

Lời nhắc theo lịch là tự động hóa, không cần AI. Gợi ý sản phẩm dùng quy tắc theo nhóm hàng trong bản đầu tiên (ví dụ: mua áo sơ mi gợi ý chân váy công sở).

Dữ liệu sẵn có: Số điện thoại khách hàng có trên khoảng 70% hóa đơn ({{N-25}}), dữ liệu bán hàng lưu trên phần mềm quản lý bán hàng tại quầy.

Chi phí sai sót: Nếu gửi nhầm gợi ý, khách có thể hủy nhận tin; kiểm soát bằng giới hạn tối đa 1 tin nhắn/tháng và cơ chế hủy nhận tin một chạm. Điểm duyệt của con người: Trưởng phòng marketing duyệt trước toàn bộ mẫu nội dung tin nhắn trước khi hệ thống gửi tự động.

## Cost & Risk

Quy mô dự án: Vừa (M).
Chi phí thí điểm: {{N-03}} (180 triệu đồng ước tính cho 12 tuần thí điểm tại 6 cửa hàng, nhãn "chưa qua đội kỹ thuật thẩm định").

Ba kịch bản lợi nhuận gộp tăng thêm trong năm đầu (ước tính sơ bộ, nhãn "chưa qua đội kỹ thuật thẩm định"):
- Kịch bản thấp: {{N-04}} (120 triệu đồng).
- Kịch bản cơ sở: {{N-05}} (350 triệu đồng) - đủ hoàn vốn chi phí thí điểm ngay trong năm đầu.
- Kịch bản cao: {{N-06}} (600 triệu đồng).

Pre-mortem (nguyên nhân thất bại dễ xảy ra nhất): Khách hàng cảm thấy bị làm phiền bởi tin nhắn quảng cáo và hủy nhận tin hàng loạt.
Biện pháp kiểm soát: Giới hạn tần suất nghiêm ngặt (tối đa 1 tin/tháng), chỉ gửi cho khách đã đồng ý nhận tin, nội dung ngắn gọn kèm ưu đãi thiết thực.

Tuân thủ và thay đổi tổ chức: Tuân thủ quy định về bảo vệ dữ liệu cá nhân (xin phép khách lưu số điện thoại và gửi tin); đào tạo nhân viên quầy thu ngân tại 6 cửa hàng thí điểm thao tác xác nhận khách nhanh dưới 10 giây.

## Clarifications

### Session 2026-11-10

- Q: Tỷ lệ khách quay lại hiện nay là bao nhiêu và mục tiêu mong muốn sau thí điểm là gì? → A: Hiện nay tỷ lệ khách quay lại trong 90 ngày là 18% (N-01), mục tiêu nâng lên 24% (N-02) sau 12 tuần thí điểm.
- Q: Thời gian triển khai cần hoàn thành khi nào và ngân sách tối đa là bao nhiêu? → A: Cần hoàn thành trước đợt mua sắm Tết (trong vòng 5 tháng), ngân sách tối đa năm đầu 400 triệu đồng.
- Q: Quy mô thí điểm bao gồm bao nhiêu cửa hàng? → A: Thí điểm tại 6 cửa hàng (N-07) và có 6 cửa hàng đối chứng (N-23) trong tổng số 34 cửa hàng của chuỗi Lụa Hạ.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Khách mua lần đầu nhận lời nhắc đúng món sau 30 ngày (Priority: P1)

Khách hàng mới đến mua đồ tại cửa hàng Lụa Hạ lần đầu tiên, để lại số điện thoại và đồng ý nhận tin chăm sóc. Đúng ngày thứ 30 ({{N-24}}) kể từ lần mua đó, khách nhận được một tin nhắn gợi ý sản phẩm phối hợp thời trang và ưu đãi chào mừng quay lại.

**Why this priority**: Đây là nhóm khách hàng dễ bị bỏ quên và thất thoát nhiều nhất (82% không quay lại), là nguồn tăng trưởng doanh thu cốt lõi của ý tưởng.

**Independent Test**: Có thể kiểm thử độc lập trên nhóm 100 khách hàng mua lần đầu tại 1 cửa hàng: hệ thống tự động gửi tin nhắn sau đúng 30 ngày và đo lường tỷ lệ khách mở tin, mang mã đến cửa hàng mua lại.

**Acceptance Scenarios**:

1. **Given** khách mua lần đầu và đồng ý nhận tin, **When** đủ 30 ngày chưa quay lại, **Then** khách nhận một tin gợi ý sản phẩm hợp với món đã mua.
2. **Given** khách đã hủy nhận tin, **When** đủ 30 ngày, **Then** không gửi tin nào.

---

### User Story 2 - Nhân viên xem danh sách khách cần chăm sóc (Priority: P2)

Đầu mỗi ca làm việc, nhân viên thu ngân hoặc trưởng ca mở ứng dụng xem danh sách khách hàng của cửa hàng mình sắp đến hạn hoặc đã nhận lời nhắc 30 ngày, để sẵn sàng tư vấn khi khách ghé cửa hàng.

**Why this priority**: Giúp nhân viên chủ động chào đón và áp dụng đúng ưu đãi khi khách đến cửa hàng sau khi nhận tin nhắn nhắc.

**Independent Test**: Nhân viên đăng nhập vào hệ thống tại cửa hàng thí điểm, lọc danh sách khách theo ngày hẹn và kiểm tra thông tin đơn hàng cũ của khách.

**Acceptance Scenarios**:

1. **Given** nhân viên mở danh sách đầu ca, **When** có khách sắp đủ 30 ngày, **Then** hệ thống hiển thị danh sách khách hàng cần chăm sóc của cửa hàng mình.

---

### User Story 3 - Theo dõi tỷ lệ khách quay lại so với nhóm đối chứng (Priority: P3)

Giám đốc bán hàng và quản lý chuỗi theo dõi báo cáo tỷ lệ quay lại hàng tuần giữa 6 cửa hàng thí điểm ({{N-07}}) và 6 cửa hàng đối chứng ({{N-23}}) để đánh giá hiệu quả chương trình.

**Why this priority**: Cung cấp dữ liệu thực chứng phục vụ quyết định mở rộng ra toàn bộ 34 cửa hàng sau 12 tuần thí điểm.

**Independent Test**: Xuất báo cáo đối chiếu tỷ lệ mua lại sau 6 tuần và 12 tuần giữa hai nhóm cửa hàng trên cùng một tập dữ liệu hóa đơn.

**Acceptance Scenarios**:

1. **Given** kết thúc tuần thí điểm thứ 12, **When** giám đốc bán hàng mở báo cáo tổng kết, **Then** hệ thống hiển thị bảng so sánh tỷ lệ khách mua lại giữa 6 cửa hàng thí điểm và 6 cửa hàng đối chứng.

---

### Edge Cases

- Khách hàng quay lại mua sắm trước mốc 30 ngày (ví dụ ngày thứ 15): Hệ thống phải tự động hủy lịch gửi tin nhắc của ngày thứ 30 và đặt lại chu kỳ mới từ ngày mua gần nhất.
- Số điện thoại khách hàng cung cấp không tồn tại hoặc không đăng ký tài khoản ứng dụng chat: Hệ thống ghi nhận lỗi chuyển phát vào nhật ký và không thử lại quá 2 lần để tránh lãng phí chi phí tin nhắn.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: Hệ thống phải gửi tối đa một tin nhắc mỗi tháng cho mỗi khách.
- **FR-002**: Hệ thống phải bỏ qua khách đã hủy nhận tin.
- **FR-003**: Nhân viên phải xem được danh sách khách cần chăm sóc của cửa hàng mình.
- **FR-004**: Hệ thống phải ghi nhận lịch sử gửi tin nhắn và đối soát tỷ lệ quay lại mua hàng trong vòng 90 ngày.

### Key Entities *(include if feature involves data)*

- **Khách hàng**: người đã mua ít nhất một lần, có số điện thoại và trạng thái đồng ý nhận tin.
- **Lần mua**: ngày mua, cửa hàng, các món đã mua.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Tỷ lệ khách quay lại trong 90 ngày tại cửa hàng thí điểm đạt {{N-02}}, so với cửa hàng đối chứng.
- **SC-002**: Tỷ lệ khách hủy nhận tin dưới {{N-10}} mỗi tháng.
- **SC-003**: Thời gian thao tác xác nhận khách tại quầy thu ngân không vượt quá 10 giây mỗi giao dịch.
- **SC-004**: Hoàn vốn chi phí thí điểm {{N-03}} trong năm đầu theo kịch bản cơ sở {{N-05}}.

## Assumptions

- Khách hàng mua sắm tại chuỗi Lụa Hạ có sử dụng ứng dụng chat trên điện thoại thông minh.
- Ít nhất 70% ({{N-25}}) khách hàng có số điện thoại chính xác trong hệ thống quản lý bán hàng (giả định A-002).
- Phần mềm bán hàng POS hiện tại tại 34 cửa hàng có khả năng trích xuất dữ liệu hóa đơn hàng ngày để đồng bộ với công cụ gửi tin.
- Đội ngũ nhân viên thu ngân tại 6 cửa hàng thí điểm được hướng dẫn đầy đủ quy trình thao tác trước khi triển khai thực tế.
