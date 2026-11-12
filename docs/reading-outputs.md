# Đọc các tài liệu vibebiz tạo ra

Khi bạn hoàn thành việc làm rõ một ý tưởng và thực hiện đóng gói bằng lệnh `/vibebiz:package`, vibebiz sẽ tạo ra hai tài liệu riêng biệt cho hai nhóm đối tượng độc giả khác nhau, cùng được kết xuất từ một nguồn dữ liệu duy nhất trong hồ sơ ý tưởng:

1. **Bản trình bày cho ban lãnh đạo**: phục vụ việc ra quyết định phê duyệt chủ trương, ngân sách và phương án triển khai.
2. **Tài liệu cho đội kỹ thuật (PRD)**: phục vụ việc thiết kế giải pháp chi tiết và lập kế hoạch xây dựng hệ thống.

Một nguồn dữ liệu duy nhất từ các tệp của ý tưởng được kết xuất thành hai tài liệu riêng biệt: bản trình bày cho ban lãnh đạo và tài liệu yêu cầu cho đội kỹ thuật, qua các định dạng Artifact trên Claude hoặc Google Slides/Docs.

Hai tài liệu này phản ánh trung thực những gì bạn đã trao đổi với vibebiz, không tự ý bịa đặt thêm dữ liệu. Những điểm chưa được bạn xác nhận sẽ được giữ nguyên kèm nhãn cảnh báo rõ ràng thay vì bị bỏ sót.

---

## Bản trình bày cho ban lãnh đạo

Bản trình bày được thiết kế theo phong cách **infographic trực quan**:
- **Mỗi trang một thông điệp lớn**: Tiêu đề trang chính là kết luận hoặc điều ban lãnh đạo cần nhớ, không dùng tiêu đề chung chung như "Tổng quan" hay "Kế hoạch".
- **Rất ít chữ, ưu tiên hình ảnh**: Mỗi trang tập trung vào một hình ảnh trực quan hoặc biểu đồ lớn ở vị trí trung tâm, loại bỏ các đoạn văn bản dài dòng để người đọc nắm bắt bản chất vấn đề chỉ trong vài giây.
- **Đi thẳng vào câu trả lời**: Mở đầu ngay bằng quyết định cần phê duyệt, các trang sau đóng vai trò cung cấp căn cứ và chứng minh tính khả thi.

Cấu trúc các trang trong bản trình bày:

| Trang | Nội dung chính |
|---|---|
| **1** | **Điều cần phê duyệt**: quyết định việc gì, mức ngân sách bao nhiêu, mốc hoàn thành khi nào |
| **2** | **Bài toán thực tế và chi phí hiện tại**: thiệt hại cụ thể bằng con số (doanh thu mất mát, giờ công lãng phí) |
| **3** | **Kết quả kỳ vọng**: mức hiện tại lên mục tiêu, các chỉ số không được để xấu đi, và ngưỡng dừng dự án |
| **4** | **Các phương án đã so sánh**: phân tích giữa giữ nguyên, sửa quy trình, mua sẵn phần mềm và tự làm |
| **5** | **Giải pháp đề xuất**: hành trình vận hành trước và sau khi thay đổi |
| **6** | **Phạm vi bản đầu tiên**: những tính năng bắt buộc phải có để tạo ra giá trị độc lập, và những gì để sau |
| **7** | **Bài toán kinh tế**: chi phí đầu tư, nguồn lực và lợi tức kỳ vọng theo ba kịch bản (thấp, cơ sở, cao) |
| **8** | **Rủi ro và biện pháp phòng ngừa**: những cách ý tưởng có thể gặp trục trặc và kế hoạch đối phó |
| **9** | **Lộ trình thử nghiệm và các mốc quyết định**: các giai đoạn triển khai thí điểm và tiêu chí đánh giá |
| **Phụ lục** | **Giả định và các câu hỏi còn mở**: danh sách các điểm đang chờ kiểm chứng hoặc người phụ trách trả lời |

Nếu trong quá trình phản biện, bạn và vibebiz thống nhất rằng phương án tối ưu là sửa quy trình hoặc mua phần mềm có sẵn thay vì tự xây dựng hệ thống mới, bản trình bày vẫn giữ nguyên cấu trúc chặt chẽ trên nhưng đề xuất chính xác phương án đó cho ban lãnh đạo.

Khi một phương pháp quản trị (như SWOT, 5 Whys, Driver tree) được áp dụng để làm rõ ý tưởng, tên phương pháp và kết quả phân tích sẽ xuất hiện trên trang tương ứng kèm thông tin nguồn gốc phương pháp.

---

## Tài liệu cho đội kỹ thuật

Tài liệu này là một bản đặc tả yêu cầu sản phẩm (PRD) hoàn chỉnh, giúp các kỹ sư phần mềm hiểu rõ bối cảnh và bắt tay vào việc ngay:

1. **Bối cảnh kinh doanh**: tóm tắt vấn đề cần giải quyết, kết quả đo lường kỳ vọng và phương án đã chọn.
2. **Các tình huống sử dụng (User Stories)**: sắp xếp theo mức độ ưu tiên từ P1 đến Pn, mỗi tình huống có các kịch bản kiểm thử rõ ràng theo cấu trúc "Cho trước / Khi / Thì" (Given / When / Then).
3. **Các yêu cầu chức năng**: mỗi yêu cầu có mã nhận diện riêng, kèm danh sách những việc nằm ngoài phạm vi.
4. **Các thực thể và thông tin cần lưu trữ**: mô tả dữ liệu nguồn, chất lượng dữ liệu và nơi lưu trữ.
5. **Tiêu chí thành công**: các chỉ số kỹ thuật và vận hành đo đếm được.
6. **Các giả định**: danh sách các điều kiện được coi là đúng để triển khai.
7. **Đánh giá mức độ phù hợp với AI**: làm rõ liệu bài toán chỉ cần quy tắc (rules), tự động hóa (automation) hay bắt buộc cần AI; chi phí thiệt hại khi AI đưa ra kết quả sai; và các điểm chốt chặn bắt buộc phải có con người phê duyệt.
8. **Yêu cầu vận hành phi chức năng**: quy mô người dùng, lưu lượng giờ cao điểm, chất lượng mạng tại cửa hàng, loại thiết bị hỗ trợ.
9. **Bảng thuật ngữ**: giải thích các từ ngữ nghiệp vụ đặc thù của công ty.
10. **Các câu hỏi còn mở**: phân loại thành câu hỏi gây chặn tiến độ (blocking) và không chặn tiến độ (non-blocking), kèm người chịu trách nhiệm giải đáp.

### Bản sao yêu cầu tương thích với Spec Kit

Đi kèm tài liệu kỹ thuật là một **bản sao đặc tả (snapshot)**. Đội ngũ kỹ thuật có thể đưa trực tiếp tệp này vào công cụ lập kế hoạch Spec Kit mà không cần chỉnh sửa hay định dạng lại. Các tiêu đề mục bắt buộc trong bản sao này được giữ nguyên theo chuẩn tiếng Anh để công cụ tự động nhận diện, trong khi toàn bộ nội dung nghiệp vụ vẫn hiển thị bằng ngôn ngữ bạn đã trao đổi.

---

## Các nhãn bạn sẽ gặp trong tài liệu

vibebiz sử dụng các nhãn chuẩn mực để người đọc nhận biết ngay mức độ tin cậy của từng thông tin:

| Nhãn | Ý nghĩa | Bạn nên làm gì |
|---|---|---|
| **chưa làm rõ** | Thông tin này chưa được cung cấp hoặc chưa có dữ liệu trong hồ sơ | Dùng `/vibebiz:continue` trả lời thêm các câu hỏi rồi đóng gói lại |
| **Bản nháp (Draft)** | Tài liệu được xuất khi ý tưởng chưa đạt đủ điều kiện hoàn thiện | Dùng để trao đổi sơ bộ trong nội bộ nhóm, không dùng để xin ban lãnh đạo phê duyệt chính thức |
| **chưa qua kỹ thuật thẩm định** | Các con số ước tính về chi phí, nhân lực hoặc thời gian chưa được đội kỹ thuật xác nhận | Nhờ đội kỹ thuật thẩm định số liệu, sau đó báo lại cho vibebiz qua `/vibebiz:continue` để gỡ bỏ nhãn này |
| **đo được** / **giả định** | Con số dựa trên dữ liệu thực tế đã đo đếm, hoặc là con số ước tính giả định | Thay thế các con số giả định bằng số liệu đo lường thực tế khi có |
| **chưa có sơ đồ** | Thư viện vẽ sơ đồ chưa được cài đặt, vị trí sơ đồ được thay bằng bảng tóm tắt | Cài đặt thêm plugin companion diagram-design nếu muốn có sơ đồ trực quan |

---

## Tính nhất quán của con số

Nguyên tắc bất di bất dịch của vibebiz là **một nguồn dữ liệu duy nhất (Single Source of Truth)**:
- Mọi con số trong bản trình bày ban lãnh đạo, tài liệu kỹ thuật và bản sao Spec Kit đều lấy chung từ một tệp dữ liệu `data.json`.
- Tuyệt đối không có tình trạng số liệu ở bản slide khác với số liệu trong tài liệu kỹ thuật.
- Bên cạnh mỗi con số luôn có đủ 3 yếu tố: **nguồn số liệu** (lấy từ đâu), **thời kỳ đo lường** (tháng/quý/năm nào), và **nhãn xác thực** (số đo được hay số giả định).
- vibebiz không đưa các con số thiếu nguồn vào tài liệu; vị trí đó sẽ được ghi rõ là "chưa làm rõ".

---

## Định dạng xuất bản và quyền riêng tư

### Các định dạng hỗ trợ

- **Claude Artifact (Khuyên dùng)**: Bản trình bày và tài liệu kỹ thuật được tạo dưới dạng trang web tương tác riêng tư ngay trong Claude. Khi bạn cập nhật hoặc đóng gói lại, Artifact được cập nhật trực tiếp tại đúng liên kết cũ.
- **Google Slides và Google Docs**: Được tạo trực tiếp trong Google Drive cá nhân của bạn nếu bạn chọn liên kết tài khoản. Mỗi lần đóng gói lại sẽ tạo một tệp phiên bản mới trong Drive của bạn.
- **Tệp liên kết `links.md`**: Lưu toàn bộ đường dẫn trực tuyến của phiên bản mới nhất ngay trong thư mục của ý tưởng để bạn tiện mở lại.

### Bảo mật và quyền riêng tư

- Toàn bộ dữ liệu kinh doanh của bạn nằm trọn vẹn trong thư mục làm việc trên máy tính và tài khoản Google Drive của bạn.
- vibebiz **không bao giờ tự chia sẻ tài liệu**, không gửi email, không công khai đường dẫn cho bất kỳ ai.
- Tài liệu xuất ra chỉ có duy nhất bạn truy cập được; khi bạn muốn chia sẻ cho ban lãnh đạo hoặc đội kỹ thuật, bạn tự chủ động bấm nút chia sẻ trong Claude hoặc Google Drive.

---

## Quản lý phiên bản và lịch sử

Bản đồ cấu trúc thư mục làm việc hiển thị vị trí của trang mục lục, tệp luật chung, các thư mục ý tưởng với đầy đủ tài liệu xuất bản và thư mục lịch sử lưu trữ các phiên bản cũ.

Mỗi khi bạn đóng gói lại một ý tưởng, vibebiz tự động:
1. Chuyển toàn bộ tài liệu của phiên bản cũ vào thư mục lịch sử `exports/history/YYYY-MM-DD/`.
2. Tạo bộ tài liệu mới ở thư mục chính `exports/`.
3. Không có tệp nào bị xóa bỏ, giúp bạn luôn tra cứu lại được chính xác phiên bản đã từng trình cho ban lãnh đạo vào bất kỳ ngày nào trong quá khứ.

---

## Cập nhật kết quả sau buổi trình ban lãnh đạo

Sau cuộc họp với ban lãnh đạo hoặc buổi làm việc với đội kỹ thuật, bạn chỉ cần gõ `/vibebiz:continue` và nói bằng lời thường:

- **Ban lãnh đạo phê duyệt**: vibebiz ghi nhận ngày duyệt, ý kiến chỉ đạo, gắn quyết định với đúng phiên bản đã trình và cập nhật trạng thái ý tưởng thành "Được duyệt".
- **Ban lãnh đạo yêu cầu sửa**: vibebiz ghi nhận các điểm cần điều chỉnh, chuyển trạng thái sang "Cần chỉnh sửa", và ưu tiên phỏng vấn làm rõ các điểm đó trước khi mời bạn đóng gói phiên bản mới.
- **Đội kỹ thuật thẩm định xong chi phí**: vibebiz ghi nhận các con số chính thức, lưu số cũ vào hồ sơ đối chiếu, và tự động bỏ nhãn "chưa qua kỹ thuật thẩm định" trong lần đóng gói tiếp theo.

---

## Trang mục lục ý tưởng

Thư mục làm việc của bạn luôn có tệp `index.html`. Khi mở tệp này bằng trình duyệt, bạn sẽ thấy bảng điều khiển trực quan hiển thị:
- Danh sách toàn bộ các ý tưởng của công ty kèm trạng thái hiện tại.
- Thanh mức độ rõ nét (bao nhiêu điểm trên 15 điểm đã hoàn thành).
- Nhãn thẩm định chi phí kỹ thuật.
- Bước hành động tiếp theo kèm nút sao chép lệnh nhanh để dán vào Claude.
- Liên kết trực tiếp tới các bản slide và tài liệu kỹ thuật đã xuất bản.
- Khu vực hiển thị các ý tưởng mẫu để tham khảo.
