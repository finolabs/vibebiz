# Đọc các tài liệu vibebiz tạo ra

> Bản nháp. Trang này mô tả những gì `/vibebiz:package` tạo ra trong bản hiện tại. Sơ đồ minh họa sẽ được bổ sung sau.

Khi bạn đóng gói một ý tưởng, vibebiz tạo hai tài liệu cho hai nhóm người đọc khác nhau, cùng lấy từ một nguồn là các tệp của ý tưởng:

- **Bản trình bày cho ban lãnh đạo**: để ban lãnh đạo quyết định có duyệt hay không.
- **Tài liệu cho đội kỹ thuật**: để đội kỹ thuật hiểu cần làm gì và bắt đầu lên kế hoạch.

Hai tài liệu này không thêm bất kỳ thông tin nào ngoài những gì bạn đã trả lời hoặc đã có trong tệp. Chỗ nào chưa có thông tin thì để trống kèm nhãn ghi rõ, không bị bỏ đi.

## Bản trình bày cho ban lãnh đạo

Bản trình bày đi thẳng vào câu trả lời: trang đầu tiên nêu ngay điều cần ban lãnh đạo duyệt, các trang sau đưa ra căn cứ. Mỗi trang chỉ có một ý, và tiêu đề trang chính là điều người đọc cần nhớ, chứ không phải tên chủ đề.

| Trang | Nội dung |
|---|---|
| 1 | Điều cần duyệt: duyệt việc gì, bao nhiêu tiền, trước ngày nào |
| 2 | Vấn đề hiện nay và cái giá phải trả, bằng con số |
| 3 | Kết quả mong muốn: từ mức hiện tại lên mức mục tiêu, và các chỉ số không được phép xấu đi |
| 4 | Các phương án đã cân nhắc: giữ nguyên, sửa quy trình, mua sẵn, tự làm |
| 5 | Giải pháp đề xuất: công việc trước và sau khi thay đổi |
| 6 | Phạm vi của bản đầu tiên và những gì để sau |
| 7 | Chi phí, nguồn lực và lợi ích theo ba kịch bản thấp, cơ sở, cao |
| 8 | Rủi ro, những cách ý tưởng có thể thất bại, và ngưỡng dừng |
| 9 | Lộ trình thử nghiệm và các mốc cần quyết định |
| Phụ lục | Các giả định và những câu hỏi còn mở |

Nếu khi phản biện, vibebiz và bạn kết luận rằng không nên tự làm (chỉ cần sửa quy trình, hoặc mua phần mềm có sẵn), bản trình bày vẫn giữ thứ tự trên nhưng đề xuất phương án đó.

Nếu vibebiz đã dùng một phương pháp quản trị để làm rõ ý tưởng (ví dụ hỏi 5 lần "vì sao" để tìm nguyên nhân gốc), tên phương pháp và kết quả của nó xuất hiện trên trang có liên quan, kèm ghi chú về nguồn gốc của phương pháp.

## Tài liệu cho đội kỹ thuật

Tài liệu này giữ cấu trúc của một bản yêu cầu để đội kỹ thuật có thể bắt tay vào ngay:

1. Bối cảnh kinh doanh: vấn đề, kết quả mong muốn và phương án đã chọn.
2. Các tình huống sử dụng theo thứ tự ưu tiên, mỗi tình huống có các bước kiểm tra "khi… thì…".
3. Các yêu cầu, mỗi yêu cầu có mã riêng, và những gì nằm ngoài phạm vi.
4. Những thông tin cần lưu và dùng.
5. Tiêu chí thành công, có con số.
6. Các giả định, nếu có.
7. Mức độ phù hợp với AI: chỉ cần quy tắc, tự động hóa hay thật sự cần AI; nếu AI sai thì thiệt hại thế nào; chỗ nào cần người duyệt.
8. Các yêu cầu vận hành bằng lời thường: bao nhiêu người dùng, giờ cao điểm, mạng ở cửa hàng, thiết bị.
9. Bảng thuật ngữ.
10. Các câu hỏi còn mở, chia làm hai loại: đang chặn công việc và không chặn, mỗi câu có người phụ trách trả lời.

Kèm theo tài liệu là **một bản sao của tệp yêu cầu**. Đội kỹ thuật có thể đưa thẳng tệp này vào Spec Kit để lên kế hoạch kỹ thuật mà không phải sửa. Các tiêu đề mục trong tệp này giữ nguyên tiếng Anh vì công cụ của đội kỹ thuật tìm mục theo đúng các tiêu đề đó; nội dung vẫn bằng ngôn ngữ của bạn.

## Các nhãn bạn sẽ gặp

| Nhãn | Ý nghĩa | Bạn nên làm gì |
|---|---|---|
| **chưa làm rõ** | Điểm này chưa có thông tin trong các tệp của ý tưởng | Trả lời thêm bằng `/vibebiz:continue` rồi đóng gói lại |
| **Bản nháp** | Ý tưởng được đóng gói khi còn thiếu điều kiện; mọi chỗ thiếu đều ghi "chưa làm rõ" | Dùng để trao đổi sớm, chưa nên dùng để xin duyệt |
| **chưa qua kỹ thuật thẩm định** | Con số ước tính (chi phí, công sức, lợi ích) chưa được đội kỹ thuật xác nhận | Nhờ đội kỹ thuật xem lại, rồi báo kết quả cho vibebiz bằng `/vibebiz:continue` (xem mục "Sau buổi trình" bên dưới); lần đóng gói sau sẽ bỏ nhãn này |
| **đo được** / **giả định** | Con số lấy từ số liệu thật, hay là con số bạn ước đoán | Thay số giả định bằng số đo được khi có |
| **chưa có sơ đồ** | Chưa cài plugin vẽ sơ đồ diagram-design, nên chỗ sơ đồ hiện bảng | Nhờ quản trị viên cài thêm diagram-design nếu muốn có sơ đồ |

## Con số

Mỗi con số chỉ có một giá trị, giống nhau ở bản trình bày, tài liệu kỹ thuật và bản trên Google. Bên cạnh mỗi con số luôn có nguồn (lấy từ đâu), thời kỳ (tháng, quý hay năm nào) và nhãn đo được hoặc giả định. Mỗi biểu đồ đều ghi nguồn và thời kỳ. vibebiz không đưa con số thiếu nguồn vào tài liệu; chỗ đó ghi "chưa làm rõ".

## Sơ đồ

Nếu đã cài plugin diagram-design, vibebiz nhờ plugin này vẽ các sơ đồ như cây chỉ số, công việc trước và sau, so sánh phương án, rủi ro và lộ trình thử nghiệm. Màu sắc và phông chữ lấy theo bộ nhận diện đã khai báo trong diagram-design.

Trên Google Slides và Google Docs, vibebiz chỉ chèn sơ đồ khi làm được việc đó mà không phải để ảnh ở chế độ công khai. Nếu không, chỗ đó là một bảng kèm liên kết tới sơ đồ trong Artifact.

## Các định dạng và liên kết

- **Artifact trên Claude**: vibebiz luôn tạo Artifact cho cả hai tài liệu. Khi đóng gói lại, Artifact được cập nhật ngay tại liên kết cũ, nên người bạn đã gửi liên kết sẽ thấy bản mới.
- **Google Slides và Google Docs**: tạo trong Google Drive của chính bạn nếu bạn chọn. Mỗi lần đóng gói lại tạo một tệp mới, tệp cũ vẫn nằm nguyên trong Drive.
- **Tệp liên kết** trong thư mục của ý tưởng liệt kê mọi liên kết của phiên bản mới nhất. Mục lục của thư mục làm việc cũng hiện các liên kết này.

## Riêng tư và chia sẻ

Mọi tài liệu chỉ mình bạn xem được. vibebiz không bao giờ tự chia sẻ, không gửi liên kết cho ai và không để tệp hay hình ảnh ở chế độ công khai. Khi muốn ban lãnh đạo hoặc đội kỹ thuật xem, bạn tự bấm chia sẻ trong Claude hoặc Google Drive.

Dữ liệu kinh doanh của bạn nằm trong thư mục làm việc và Google Drive của bạn.

## Các phiên bản cũ

Mỗi lần đóng gói lại, vibebiz chuyển bộ tài liệu trước vào thư mục lịch sử của ý tưởng, đặt tên theo ngày của phiên bản đó. Nếu trong một ngày bạn đóng gói nhiều lần, các bộ sau có thêm số thứ tự. Không phiên bản nào bị xóa, nên bạn luôn tìm lại được đúng bản đã trình cho ban lãnh đạo.

## Sau buổi trình

vibebiz không dự họp, nên bạn là người báo lại kết quả. Cứ nói bằng lời thường, ví dụ "ban lãnh đạo duyệt ý tưởng nhắc khách rồi" hoặc "sếp bảo giảm chi phí thử nghiệm", hoặc gõ `/vibebiz:continue`.

- **Quyết định của ban lãnh đạo**: vibebiz ghi lại quyết định (duyệt, không duyệt hoặc cần sửa), ngày quyết định và góp ý, gắn với đúng phiên bản bạn đã trình, tức là bộ tài liệu mang ngày đóng gói của bản ấy trong thư mục lịch sử. Nhờ vậy, sau nhiều lần sửa và trình lại, bạn vẫn biết ban lãnh đạo đã nói gì về từng bản.
- **Yêu cầu sửa**: vibebiz hỏi trước về đúng những điểm ban lãnh đạo nêu, rồi đóng gói lại thành phiên bản mới để bạn trình tiếp. Bản cũ và quyết định cũ vẫn được giữ.
- **Kết quả thẩm định của đội kỹ thuật**: vibebiz ghi lại ngày, vai trò của người thẩm định và các con số đã sửa (kèm số cũ). Khi mọi con số ước tính đã qua thẩm định, lần đóng gói sau bỏ nhãn "chưa qua kỹ thuật thẩm định". Các tài liệu đã tạo trước đó vẫn giữ nhãn cũ, nên hãy đóng gói lại trước khi gửi tiếp.

## Trang mục lục

Thư mục làm việc có một trang mục lục (mở bằng trình duyệt) liệt kê mọi ý tưởng của bạn. Mỗi ý tưởng có:

- **Trạng thái**: đang làm rõ, sẵn sàng đóng gói, đã đóng gói, đã trình ban lãnh đạo, cần chỉnh sửa, được duyệt hoặc không được duyệt. Ý nghĩa từng trạng thái có trong [Các lệnh của vibebiz](commands.md).
- **Nhãn ước tính**: con số ước tính đã qua kỹ thuật thẩm định hay chưa.
- **Thanh mức rõ**: bao nhiêu trong 15 điểm cần làm rõ đã rõ.
- **Bước tiếp theo**: việc cần làm tiếp, kèm lệnh cần gõ và nút "Chép lệnh" để dán vào Cowork.
- **Liên kết** tới bản trình bày, tài liệu kỹ thuật và các bản trên Google, nếu đã có.

Ý tưởng mẫu nằm riêng ở mục "Ví dụ" và không tính vào danh sách ý tưởng của bạn. vibebiz tự cập nhật trang này sau mỗi lần làm việc; bạn cũng có thể gõ `/vibebiz:status` để xem cùng danh sách ngay trong cuộc trò chuyện.
