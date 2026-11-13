# Bắt đầu nhanh với vibebiz

Hướng dẫn này giúp bạn làm quen với vibebiz trong vài phút: từ một câu ý tưởng ban đầu đến khi nhận bộ tài liệu hoàn chỉnh để trình ban lãnh đạo và bàn giao cho đội kỹ thuật.

Quy trình tổng quan: từ ý tưởng ban đầu của giám đốc kinh doanh, vibebiz phỏng vấn qua các vòng ngắn có chọn lọc rồi tạo bản trình bày cho ban lãnh đạo và tài liệu yêu cầu cho đội kỹ thuật, giúp duyệt ngân sách và triển khai hệ thống.

---

## 1. Chuẩn bị

Bạn chỉ cần:
- **Claude Cowork**: ứng dụng trên máy tính, hoặc bản web và điện thoại.
- Một nơi để vibebiz lưu các tệp ý tưởng, chọn một trong hai:
  - **Trên máy tính:** mở sẵn một thư mục trong Cowork. Đây là cách nên dùng nếu bạn làm việc chủ yếu trên máy.
  - **Trên web hoặc điện thoại:** nối Google Drive trong phần kết nối (Connectors) của Cowork. Lần đầu, vibebiz hỏi bạn chọn thư mục Drive nào; sau đó mọi thiết bị dùng chung thư mục ấy. Xem thêm [câu hỏi 12](faq.md#12-tôi-dùng-được-vibebiz-trên-cowork-bản-web-hoặc-điện-thoại-không).
- Không cần mở cửa sổ dòng lệnh (terminal) và không cần biết lập trình.

---

## 2. Bắt đầu ý tưởng đầu tiên

Trong cuộc trò chuyện ở Claude Cowork, bạn gõ:

```
/vibebiz:idea
```

hoặc chỉ cần nói bằng lời thường: *"Tôi có ý tưởng dùng AI nhắc khách cũ quay lại mua hàng"* hay *"Tôi muốn làm ứng dụng quản lý hàng tồn cho các cửa hàng"*.

**Lần đầu sử dụng**:
- vibebiz tạo sẵn cấu trúc thư mục làm việc gồm trang mục lục `index.html` và tệp luật chung `constitution.md`.
- vibebiz mời bạn ghi vài luật chung (ngành hàng, mức chi bạn tự duyệt, việc luôn cần người duyệt). Bạn có thể chọn "Để sau" để đi thẳng vào ý tưởng; luật chung có thể bổ sung bất cứ lúc nào bằng lệnh `/vibebiz:constitution`.
- vibebiz hỏi bạn một câu mở: tình huống thực tế gần nhất khiến bạn nảy ra ý tưởng này là gì.

Sau khi bạn trả lời, vibebiz tạo thư mục riêng cho ý tưởng (ví dụ `specs/001-nhac-khach-cu/`), lập bản nháp yêu cầu đầu tiên và bắt đầu các vòng phỏng vấn ngắn.

---

## 3. Cách trả lời các vòng phỏng vấn

vibebiz không hỏi lan man. Thay vào đó, vibebiz chia việc làm rõ ý tưởng thành từng vòng ngắn gọn:

Mỗi vòng gồm tối đa bốn câu trắc nghiệm có ngữ cảnh độc lập, phương án gợi ý đứng đầu, không có lựa chọn thừa, và câu trả lời được lưu ngay vào hồ sơ ý tưởng.

- **Tối đa 4 câu hỏi mỗi vòng**: Mỗi câu đều có ngữ cảnh độc lập, giải thích rõ vì sao cần hỏi.
- **Phương án đề xuất đứng đầu**: Mỗi câu có 2 đến 4 phương án, phương án vibebiz đề xuất luôn ở vị trí đầu tiên kèm lý do ngắn gọn.
- **Có thể bỏ qua**: Nếu chưa có số liệu hoặc chưa muốn quyết, bạn bấm "Bỏ qua" (Skip). Câu bỏ qua không tính là đã đồng ý và sẽ được hỏi lại khi phù hợp.
- **Lưu ngay lập tức**: Sau mỗi vòng, mọi câu trả lời được ghi thẳng vào tệp ý tưởng. Bạn có thể tắt máy bất cứ lúc nào mà không lo mất dữ liệu.
- **Giới hạn 3 vòng mỗi buổi**: Sau 3 vòng câu hỏi, vibebiz dừng lại và hỏi bạn muốn:
  1. *Hỏi tiếp*: nếu bạn còn thời gian và muốn làm rõ thêm.
  2. *Tạm dừng*: để nghỉ ngơi hoặc thu thập thêm số liệu, hôm sau làm tiếp.
  3. *Lấy bản nháp*: xuất ngay tài liệu, các điểm chưa trả lời sẽ được ghi rõ là "chưa làm rõ".

---

## 4. Tạm dừng và làm tiếp

Khi quay lại sau vài giờ hoặc vài ngày, bạn không cần nhớ lần trước đã trao đổi những gì. Chỉ cần gõ:

```
/vibebiz:continue
```

hoặc nói: *"Làm tiếp ý tưởng nhắc khách quay lại"*.

vibebiz đọc lại toàn bộ tệp, giữ nguyên các phần bạn đã tự sửa tay (nếu có), rồi gửi bạn **bản tóm tắt đúng 3 dòng**:
1. **Đã rõ**: các điểm quan trọng đã thống nhất.
2. **Dừng ở**: ngày làm việc gần nhất và việc còn dang dở.
3. **Câu hỏi tiếp theo**: chủ đề vibebiz sẽ hỏi tiếp.

Sau đó, vòng phỏng vấn tiếp tục bình thường.

---

## 5. Xem tổng quan các ý tưởng

Bất cứ lúc nào, bạn có thể gõ:

```
/vibebiz:status
```

vibebiz hiển thị bảng danh sách mọi ý tưởng trong thư mục làm việc: trạng thái hiện tại, mức độ hoàn thành (ví dụ: `9/15 điểm đã rõ`), số liệu ước tính đã qua kỹ thuật thẩm định hay chưa, và việc cần làm tiếp theo.

Bạn cũng có thể mở tệp `index.html` trong thư mục làm việc bằng trình duyệt web bất kỳ để xem bảng mục lục trực quan kèm nút sao chép lệnh tiện lợi.

---

## 6. Đóng gói tài liệu trình duyệt

Khi ý tưởng đã sẵn sàng (rõ bài toán, mục tiêu định lượng, phương án lựa chọn và phạm vi bản đầu tiên), vibebiz sẽ gợi ý bạn đóng gói. Bạn cũng có thể chủ động yêu cầu bất cứ lúc nào:

```
/vibebiz:package
```

vibebiz sẽ:
1. Rà soát lại toàn bộ thông tin để đảm bảo không mâu thuẫn hay hổng logic.
2. Hỏi bạn muốn nhận tài liệu dưới dạng nào: **Artifact trên Claude** (xem trực tiếp, riêng tư) hay **Google Slides / Google Docs** trong Google Drive của bạn.
3. Tự động vẽ sơ đồ trực quan (nếu cài thêm plugin `diagram-design`).
4. Xuất hai bộ tài liệu:
   - **Bản trình bày cho ban lãnh đạo**: Thiết kế dạng infographic trực quan, mỗi trang một thông điệp rõ ràng kèm hình ảnh lớn, không rườm rà chữ; nêu bật bài toán kinh doanh, kết quả kỳ vọng, chi phí, rủi ro và lộ trình thử nghiệm.
   - **Tài liệu cho đội kỹ thuật (PRD)**: Đầy đủ tình huống sử dụng, yêu cầu chức năng, tiêu chí nghiệm thu và tệp đặc tả kỹ thuật tương thích chuẩn Spec Kit để kỹ sư phần mềm có thể lên kế hoạch làm ngay mà không phải phỏng vấn lại bạn từ đầu.

Nếu bạn dùng Cowork trên web hay điện thoại, ý tưởng nằm trong Google Drive của bạn: vibebiz lưu dữ liệu, bản sao yêu cầu và danh sách liên kết vào thư mục của ý tưởng trong Drive, còn bản trình bày và tài liệu kỹ thuật được đăng thành Artifact riêng tư (hoặc thành Google Slides và Docs nếu bạn chọn) chứ không lưu thành tệp trang web trong Drive.

---

## 7. Báo cáo kết quả sau cuộc họp

vibebiz không dự họp cùng bạn, nên bạn sẽ là người báo lại kết quả:
- Nếu ban lãnh đạo duyệt: gõ `/vibebiz:continue` và nói *"Ban lãnh đạo đã duyệt ý tưởng"*.
- Nếu ban lãnh đạo yêu cầu sửa: nói *"Sếp bảo giảm chi phí thử nghiệm"*, vibebiz sẽ ghi nhận ý kiến và hướng dẫn bạn sửa đúng các điểm đó để đóng gói lại.
- Khi đội kỹ thuật rà soát số liệu: nói *"Đội kỹ thuật đã thẩm định chi phí"*, vibebiz sẽ cập nhật số liệu chuẩn và gỡ nhãn *"chưa qua kỹ thuật thẩm định"* ở những lần xuất tài liệu sau.

---

## 8. Khi cần trợ giúp

Nếu chưa rõ nên gõ lệnh nào, muốn tìm hiểu một thuật ngữ hoặc xem ý tưởng mẫu hoàn chỉnh trông ra sao, bạn chỉ cần gõ:

```
/vibebiz:help
```

vibebiz sẽ giải thích ngắn gọn, dẫn nguồn từ tài liệu và chỉ đúng lệnh phù hợp với tình huống của bạn.
