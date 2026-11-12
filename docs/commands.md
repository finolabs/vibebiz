# Các lệnh của vibebiz

> Bản nháp. Trang này chỉ liệt kê những lệnh đã có trong bản hiện tại và sẽ được bổ sung khi có thêm lệnh mới.

Mỗi lệnh là một kỹ năng (skill) cùng tên trong plugin vibebiz. Bạn có thể gõ lệnh, hoặc chỉ cần nói điều mình muốn bằng lời thường, Claude sẽ tự chọn đúng lệnh. Mọi lệnh đều cần một thư mục làm việc đang mở trong Cowork; nếu chưa mở, vibebiz sẽ nhắc bạn mở thư mục trước và không làm gì thêm.

## /vibebiz:new

**Dùng khi**: bạn có một ý tưởng mới về hệ thống, cách dùng AI hoặc việc muốn tự động hóa. Ví dụ: "Tôi muốn dùng AI nhắc khách cũ quay lại mua."

**vibebiz sẽ làm gì**:

1. Chuẩn bị thư mục làm việc nếu chưa có. Nếu thư mục đã có tệp khác, vibebiz hỏi bạn muốn dùng thư mục này hay tạo một thư mục con riêng (nên chọn thư mục con). vibebiz chỉ bổ sung phần còn thiếu và không ghi đè tệp nào của bạn.
2. Lần đầu dùng, vibebiz mời bạn ghi vài luật chung cho mọi ý tưởng (ưu tiên năm nay, mức chi bạn tự duyệt, ngành hàng, việc luôn cần người duyệt). Bạn có thể để sau và ghi bất cứ lúc nào bằng `/vibebiz:constitution`.
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

## /vibebiz:package

**Dùng khi**: ý tưởng đã đủ rõ và bạn cần tài liệu để trình ban lãnh đạo và gửi đội kỹ thuật. Ví dụ: "Làm slide trình ý tưởng nhắc khách quay lại", "Viết PRD cho ý tưởng này".

**vibebiz sẽ làm gì**:

1. Kiểm tra ý tưởng đã đủ điều kiện chưa. Nếu còn thiếu, vibebiz liệt kê những điểm còn thiếu và để bạn chọn: trả lời thêm vài câu (nên chọn) hoặc lấy ngay bản nháp, trong đó mọi chỗ thiếu ghi rõ là "chưa làm rõ".
2. Lập kế hoạch thực hiện, rà xem ban lãnh đạo và đội kỹ thuật đã có đủ thông tin chưa, rồi soát xem các tệp có chỗ nào mâu thuẫn hay thiếu. Chỗ nào cần bạn quyết, vibebiz hỏi lại theo từng vòng ngắn như khi làm rõ ý tưởng.
3. Hỏi bạn muốn nhận bản trình bày dưới dạng Artifact trên Claude hay Google Slides, và tài liệu kỹ thuật dưới dạng Artifact hay Google Docs. Nếu chưa kết nối Google, vibebiz đề nghị dùng Artifact.
4. Vẽ sơ đồ (cây chỉ số, hành trình trước và sau, các phương án, rủi ro, lộ trình thử nghiệm) nếu đã cài plugin diagram-design; nếu chưa, chỗ sơ đồ hiện một bảng kèm ghi chú "chưa có sơ đồ".
5. Tạo bản trình bày cho ban lãnh đạo, tài liệu cho đội kỹ thuật và một bản sao yêu cầu để đội kỹ thuật dùng với Spec Kit. Mọi con số giống nhau ở cả hai bản, kèm nguồn, thời kỳ và ghi rõ là số đo được hay số giả định. Chi phí ước tính ghi "chưa qua kỹ thuật thẩm định" cho tới khi đội kỹ thuật xác nhận.
6. Khi đóng gói lại, vibebiz giữ bản cũ trong thư mục lịch sử của ý tưởng và cập nhật Artifact ngay tại liên kết cũ.
7. Gửi bạn các liên kết. Mọi tài liệu chỉ mình bạn xem được: vibebiz không bao giờ tự chia sẻ hay để công khai. Bạn tự chia sẻ cho ban lãnh đạo hoặc đội kỹ thuật khi muốn.

Cách đọc từng tài liệu: [Đọc các tài liệu vibebiz tạo ra](reading-outputs.md).

## /vibebiz:status

**Dùng khi**: bạn muốn xem nhanh tất cả ý tưởng đang đến đâu. Ví dụ: "Các ý tưởng của tôi đến đâu rồi?"

**vibebiz sẽ làm gì**: liệt kê mọi ý tưởng với trạng thái, số điểm đã rõ trên 15 điểm, bước tiếp theo và ngày cập nhật, rồi cập nhật lại mục lục. Lệnh này không hỏi bạn câu nào. Ý tưởng mẫu (nếu có) không nằm trong danh sách.

## /vibebiz:constitution

**Dùng khi**: bạn muốn ghi hoặc sửa luật chung cho mọi ý tưởng của công ty. Ví dụ: "Ghi luật chung cho công ty", "Đổi mức chi tôi tự duyệt thành 300 triệu", "Thêm OKR năm nay của công ty".

**vibebiz sẽ làm gì**:

1. Chuẩn bị thư mục làm việc nếu chưa có, như khi bắt đầu ý tưởng mới. Bạn có thể ghi luật chung trước khi có ý tưởng nào.
2. Hỏi một vòng tối đa bốn câu: ngành hàng của bạn, mức chi bạn được tự duyệt, những việc luôn cần người duyệt (ví dụ đổi giá bán, gửi tin cho khách, hoàn tiền, dùng dữ liệu cá nhân của khách) và hai, ba ưu tiên năm nay. Câu nào đã có câu trả lời trong lời bạn nói thì vibebiz không hỏi lại. Bạn bỏ qua câu nào thì luật đó giữ nguyên; bỏ qua cả vòng thì luật chung vẫn để sau.
3. Nếu công ty đã có mục tiêu chiến lược theo bốn góc nhìn (tài chính, khách hàng, quy trình nội bộ, học hỏi và phát triển) hoặc OKR năm nay, bạn dán vào hoặc chỉ tài liệu; vibebiz ghi lại đúng như bạn đưa, không tự đặt thêm mục tiêu.
4. Nếu bạn sửa luật đã ghi, vibebiz cho bạn xem phần thay đổi (trước và sau) và chỉ lưu khi bạn đồng ý.
5. Lưu luật chung và cập nhật mục lục.

**Sau đó**: khi phản biện và lập kế hoạch cho từng ý tưởng, vibebiz đối chiếu với luật chung. Ý tưởng cần khoản chi vượt mức bạn tự duyệt, bỏ qua một việc luôn cần người duyệt, hoặc đi ngược mục tiêu đã ghi sẽ được ghi rõ trong kế hoạch và trên bản trình bày cho ban lãnh đạo. Nếu luật chung còn để sau, vibebiz nhắc bạn một lần khi lập kế hoạch.
