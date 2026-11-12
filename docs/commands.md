# Các lệnh của vibebiz

> Bản nháp. Trang này chỉ liệt kê những lệnh đã có trong bản hiện tại và sẽ được bổ sung khi có thêm lệnh mới.

Mỗi lệnh là một kỹ năng (skill) cùng tên trong plugin vibebiz. Bạn có thể gõ lệnh, hoặc chỉ cần nói điều mình muốn bằng lời thường, Claude sẽ tự chọn đúng lệnh. Mọi lệnh đều cần một thư mục làm việc đang mở trong Cowork; nếu chưa mở, vibebiz sẽ nhắc bạn mở thư mục trước và không làm gì thêm.

## /vibebiz:new

**Dùng khi**: bạn có một ý tưởng mới về hệ thống, cách dùng AI hoặc việc muốn tự động hóa. Ví dụ: "Tôi muốn dùng AI nhắc khách cũ quay lại mua."

**vibebiz sẽ làm gì**:

1. Chuẩn bị thư mục làm việc nếu chưa có. Nếu thư mục đã có tệp khác, vibebiz hỏi bạn muốn dùng thư mục này hay tạo một thư mục con riêng (nên chọn thư mục con). vibebiz chỉ bổ sung phần còn thiếu và không ghi đè tệp nào của bạn.
2. Lần đầu dùng, vibebiz mời bạn ghi vài luật chung cho mọi ý tưởng (ưu tiên năm nay, mức chi bạn tự duyệt, ngành hàng, việc luôn cần người duyệt). Bạn có thể để sau.
3. Hỏi một câu mở về tình huống thật gần nhất đã khiến bạn nghĩ tới ý tưởng.
4. Tạo một thư mục riêng cho ý tưởng, viết bản nháp yêu cầu đầu tiên và cho bạn xem bảng những điểm đã rõ và còn thiếu.
5. Hỏi từng vòng ngắn, mỗi vòng tối đa bốn câu trắc nghiệm, phương án nên chọn luôn đứng đầu. Bạn có thể bỏ qua câu nào cũng được; câu bị bỏ qua không bị tính là đã đồng ý. Sau mỗi vòng, câu trả lời được ghi ngay vào tệp.
6. Sau ba vòng, vibebiz hỏi bạn muốn hỏi tiếp, tạm dừng hay lấy bản nháp. Bản nháp yêu cầu, với các điểm còn thiếu được ghi rõ là "chưa làm rõ", luôn được lưu sẵn trong thư mục của ý tưởng.

## /vibebiz:continue

**Dùng khi**: bạn muốn làm tiếp một ý tưởng đã bắt đầu trước đó. Ví dụ: "Làm tiếp ý tưởng nhắc khách quay lại."

**vibebiz sẽ làm gì**:

1. Chọn ý tưởng bạn nhắc tới. Nếu bạn có nhiều ý tưởng đang làm dở, vibebiz hỏi bạn chọn ý tưởng nào.
2. Đọc lại các tệp của ý tưởng như hiện tại. Nếu bạn đã tự sửa tệp, vibebiz giữ nguyên phần bạn sửa.
3. Tóm tắt trong ba dòng: điều gì đã rõ, lần trước dừng ở đâu và câu hỏi tiếp theo là gì.
4. Tiếp tục hỏi từng vòng như lúc bắt đầu.

## /vibebiz:status

**Dùng khi**: bạn muốn xem nhanh tất cả ý tưởng đang đến đâu. Ví dụ: "Các ý tưởng của tôi đến đâu rồi?"

**vibebiz sẽ làm gì**: liệt kê mọi ý tưởng với trạng thái, số điểm đã rõ trên 15 điểm, bước tiếp theo và ngày cập nhật, rồi cập nhật lại mục lục. Lệnh này không hỏi bạn câu nào. Ý tưởng mẫu (nếu có) không nằm trong danh sách.
