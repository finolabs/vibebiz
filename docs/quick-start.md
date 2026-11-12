# Bắt đầu nhanh với vibebiz

Hướng dẫn này giúp bạn làm quen với vibebiz trong vài phút: từ một câu ý tưởng ban đầu đến khi nhận được bộ tài liệu hoàn chỉnh để trình ban lãnh đạo và bàn giao cho đội kỹ thuật.

Quy trình tổng quan: từ một câu ý tưởng ban đầu của giám đốc kinh doanh, vibebiz phỏng vấn qua các vòng ngắn có chọn lọc, tạo ra bản trình bày cho ban lãnh đạo và tài liệu yêu cầu cho đội kỹ thuật, phục vụ việc phê duyệt ngân sách và triển khai hệ thống.

---

## 1. Chuẩn bị

Bạn chỉ cần:
- Ứng dụng **Claude Cowork** trên máy tính.
- Mở sẵn một thư mục trên máy để làm việc (nơi vibebiz sẽ lưu các tệp ý tưởng và trang mục lục).
- Không cần mở cửa sổ dòng lệnh (terminal) và không cần kiến thức lập trình.

---

## 2. Bắt đầu ý tưởng đầu tiên

Trong cuộc trò chuyện ở Claude Cowork, bạn gõ:

```
/vibebiz:new
```

hoặc chỉ cần nói bằng lời thường: *"Tôi có ý tưởng dùng AI nhắc khách cũ quay lại mua hàng"* hay *"Tôi muốn làm ứng dụng quản lý hàng tồn cho các cửa hàng"*.

**Lần đầu tiên sử dụng**:
- vibebiz sẽ tạo sẵn cấu trúc thư mục làm việc gồm trang mục lục `index.html` và tệp luật chung `constitution.md`.
- vibebiz mời bạn ghi vài luật chung (ngành hàng, mức chi bạn tự duyệt, những việc luôn cần người duyệt). Bạn có thể chọn "Để sau" để đi thẳng vào ý tưởng; luật chung có thể bổ sung bất cứ lúc nào bằng lệnh `/vibebiz:constitution`.
- vibebiz hỏi bạn một câu mở: tình huống thật gần nhất khiến bạn nảy ra ý tưởng này là gì.

Sau câu trả lời của bạn, vibebiz tạo thư mục riêng cho ý tưởng (ví dụ `specs/001-nhac-khach-cu/`), lập bản nháp yêu cầu đầu tiên và bắt đầu các vòng phỏng vấn ngắn.

---

## 3. Cách trả lời các vòng phỏng vấn

vibebiz không hỏi tràng giang đại hải. Thay vào đó, vibebiz chia việc làm rõ ý tưởng thành từng vòng ngắn, có phương pháp:

Mỗi vòng câu hỏi gồm tối đa bốn câu trắc nghiệm có ngữ cảnh độc lập, phương án gợi ý đứng đầu, không có lựa chọn thừa, và câu trả lời được lưu lại ngay lập tức vào hồ sơ ý tưởng.

- **Tối đa 4 câu hỏi mỗi vòng**: Mỗi câu đều có ngữ cảnh tự đứng độc lập, giải thích rõ vì sao lại hỏi câu đó.
- **Phương án đề xuất đứng đầu**: Mỗi câu có 2 đến 4 phương án lựa chọn, phương án vibebiz đề xuất luôn ở vị trí đầu tiên kèm lý do ngắn gọn.
- **Có thể bỏ qua**: Nếu chưa có số liệu hoặc chưa muốn quyết, bạn bấm "Bỏ qua" (Skip). Câu bị bỏ qua không bị tính là đã đồng ý và sẽ được hỏi lại khi phù hợp.
- **Lưu ngay lập tức**: Sau mỗi vòng, mọi câu trả lời được ghi thẳng vào tệp của ý tưởng. Bạn có thể tắt máy bất cứ lúc nào mà không lo mất dữ liệu.
- **Ngân sách 3 vòng mỗi buổi**: Sau 3 vòng câu hỏi, vibebiz dừng lại và hỏi bạn muốn:
  1. *Hỏi tiếp*: nếu bạn đang có thời gian và muốn làm rõ thêm.
  2. *Tạm dừng*: để nghỉ ngơi hoặc thu thập thêm số liệu, hôm sau làm tiếp.
  3. *Lấy bản nháp*: xuất ngay tài liệu với các điểm chưa trả lời được ghi rõ là "chưa làm rõ".

---

## 4. Tạm dừng và làm tiếp

Khi bạn quay lại sau vài giờ hoặc vài ngày, bạn không cần phải nhớ lần trước đã nói những gì. Chỉ cần gõ:

```
/vibebiz:continue
```

hoặc nói: *"Làm tiếp ý tưởng nhắc khách quay lại"*.

vibebiz sẽ đọc lại toàn bộ tệp, giữ nguyên các phần bạn đã tự sửa bằng tay (nếu có), và gửi bạn **bản tóm tắt đúng 3 dòng**:
1. **Đã rõ**: những điểm quan trọng đã được thống nhất.
2. **Dừng ở**: ngày làm việc gần nhất và việc đang dang dở.
3. **Câu hỏi tiếp theo**: chủ đề tiếp theo mà vibebiz sẽ hỏi.

Sau đó, vòng phỏng vấn tiếp tục bình thường.

---

## 5. Xem tổng quan các ý tưởng

Bất cứ lúc nào, bạn có thể gõ:

```
/vibebiz:status
```

vibebiz sẽ hiển thị bảng danh sách mọi ý tưởng trong thư mục làm việc, trạng thái hiện tại, mức độ hoàn thành (ví dụ: `9/15 điểm đã rõ`), con số ước tính đã qua kỹ thuật thẩm định hay chưa, và việc cần làm tiếp theo.

Bạn cũng có thể mở tệp `index.html` trong thư mục làm việc bằng trình duyệt web bất kỳ để xem bảng mục lục trực quan có nút chép lệnh tiện lợi.

---

## 6. Đóng gói tài liệu trình duyệt

Khi ý tưởng đã đạt chuẩn sẵn sàng (đã rõ bài toán, con số kết quả, phương án lựa chọn và phạm vi bản đầu tiên), vibebiz sẽ gợi ý bạn đóng gói. Bạn cũng có thể chủ động yêu cầu bất kỳ lúc nào:

```
/vibebiz:package
```

vibebiz sẽ:
1. Rà soát lại toàn bộ thông tin để đảm bảo không có mâu thuẫn hay lỗ hổng logic.
2. Hỏi bạn muốn nhận tài liệu dưới dạng nào: **Artifact trên Claude** (xem trực tiếp, riêng tư) hay **Google Slides / Google Docs** trong Google Drive của bạn.
3. Tự động vẽ các sơ đồ trực quan (nếu có cài plugin companion `diagram-design`).
4. Xuất ra hai bộ tài liệu:
   - **Bản trình bày cho ban lãnh đạo**: Thiết kế theo dạng infographic trực quan, mỗi trang một thông điệp rõ ràng kèm hình ảnh lớn, không rườm rà chữ, nêu bật bài toán kinh doanh, con số kết quả, chi phí, rủi ro và lộ trình thử nghiệm.
   - **Tài liệu cho đội kỹ thuật (PRD)**: Đầy đủ các trường hợp sử dụng, yêu cầu chức năng, tiêu chí chấp nhận và một tệp đặc tả kỹ thuật tương thích với chuẩn Spec Kit để kỹ sư phần mềm có thể lên kế hoạch làm ngay mà không phải phỏng vấn lại bạn từ đầu.

---

## 7. Báo cáo kết quả sau cuộc họp

vibebiz không tham dự cuộc họp cùng bạn, nên bạn là người báo lại kết quả:
- Nếu ban lãnh đạo phê duyệt: gõ `/vibebiz:continue` và nói *"Ban lãnh đạo đã duyệt ý tưởng"*.
- Nếu ban lãnh đạo yêu cầu sửa: nói *"Sếp bảo giảm chi phí thử nghiệm"*, vibebiz sẽ ghi nhận góp ý và hướng dẫn bạn sửa đúng những điểm đó để đóng gói lại.
- Khi đội kỹ thuật xem lại số liệu: nói *"Đội kỹ thuật đã thẩm định chi phí"*, vibebiz sẽ cập nhật số liệu chuẩn và gỡ bỏ nhãn *"chưa qua kỹ thuật thẩm định"* trên các tài liệu xuất bản lần sau.

---

## 8. Khi cần trợ giúp

Nếu bạn băn khoăn không biết nên gõ lệnh nào, muốn hiểu một thuật ngữ hoặc muốn xem một ý tưởng mẫu hoàn chỉnh trông ra sao, hãy gõ:

```
/vibebiz:help
```

vibebiz sẽ giải thích ngắn gọn, dẫn nguồn từ tài liệu và chỉ cho bạn đúng lệnh cần dùng cho tình huống của bạn.
