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

**Dùng khi**: bạn muốn làm tiếp một ý tưởng đã bắt đầu trước đó, hoặc báo cho vibebiz biết chuyện gì đã xảy ra sau khi trình: ban lãnh đạo duyệt, không duyệt hay yêu cầu sửa, hoặc đội kỹ thuật đã thẩm định chi phí. Ví dụ: "Làm tiếp ý tưởng nhắc khách quay lại", "Ban lãnh đạo duyệt ý tưởng nhắc khách rồi", "Đội kỹ thuật đã xem lại chi phí".

**vibebiz sẽ làm gì khi bạn làm tiếp**:

1. Chọn ý tưởng bạn nhắc tới. Nếu bạn có nhiều ý tưởng đang làm dở, vibebiz hỏi bạn chọn ý tưởng nào.
2. Đọc lại các tệp của ý tưởng như hiện tại. Nếu bạn đã tự sửa tệp, vibebiz giữ nguyên phần bạn sửa.
3. Tóm tắt trong ba dòng: điều gì đã rõ, lần trước dừng ở đâu và câu hỏi tiếp theo là gì.
4. Tiếp tục hỏi từng vòng như lúc bắt đầu.

**Khi bạn báo kết quả buổi trình ban lãnh đạo**:

1. vibebiz ghi lại quyết định (duyệt, không duyệt hoặc cần sửa), ngày quyết định và góp ý của ban lãnh đạo, gắn với đúng phiên bản tài liệu bạn đã trình.
2. vibebiz chỉ hỏi thêm những gì bạn chưa nói: bản nào đã trình (nếu bạn đã đóng gói nhiều lần), ngày nào, và ban lãnh đạo góp ý gì. Bạn có thể bỏ qua câu góp ý; vibebiz không tự viết thay.
3. Trạng thái của ý tưởng đổi theo quyết định và hiện ngay trên mục lục.
4. Nếu ban lãnh đạo yêu cầu sửa, vibebiz hỏi bạn muốn sửa ngay hay để sau. Khi sửa, vibebiz hỏi trước về đúng những điểm ban lãnh đạo nêu, rồi mời bạn đóng gói lại thành phiên bản mới.
5. Nếu bạn muốn làm lại một ý tưởng đã được duyệt hoặc không được duyệt, vibebiz hỏi xác nhận rồi mở lại ý tưởng. Mọi quyết định và phiên bản cũ vẫn được giữ nguyên.

**Khi bạn báo đội kỹ thuật đã thẩm định chi phí**:

1. vibebiz ghi lại ngày thẩm định, ai thẩm định (theo vai trò, ví dụ "trưởng nhóm kỹ thuật") và các con số đội kỹ thuật đã sửa, kèm số cũ để đối chiếu.
2. Khi mọi con số ước tính đã qua thẩm định, lần đóng gói sau sẽ bỏ nhãn "chưa qua kỹ thuật thẩm định". Nếu đội kỹ thuật mới xem một phần, nhãn vẫn giữ cho tới khi xem hết.
3. Tài liệu đã tạo trước đó vẫn mang nhãn cũ, nên vibebiz đề nghị đóng gói lại để có bản mới không còn nhãn.

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

**vibebiz sẽ làm gì**: liệt kê mọi ý tưởng với trạng thái, ước tính đã qua kỹ thuật thẩm định hay chưa, số điểm đã rõ trên 15 điểm, bước tiếp theo kèm lệnh cần gõ, liên kết tới tài liệu và ngày cập nhật, rồi cập nhật lại mục lục. Lệnh này không hỏi bạn câu nào. Ý tưởng mẫu (nếu có) không nằm trong danh sách.

## Trạng thái của một ý tưởng

Mỗi ý tưởng luôn ở một trong bảy trạng thái. Bạn thấy trạng thái này trong `/vibebiz:status` và trên trang mục lục của thư mục làm việc.

| Trạng thái | Nghĩa là | Đi tiếp bằng |
|---|---|---|
| Đang làm rõ | vibebiz đang hỏi để làm rõ ý tưởng | `/vibebiz:continue` |
| Sẵn sàng đóng gói | Đã đủ điều kiện để làm tài liệu trình ban lãnh đạo | `/vibebiz:package` |
| Đã đóng gói | Đã có bản trình bày và tài liệu cho đội kỹ thuật, chưa trình | Trình ban lãnh đạo rồi báo lại bằng `/vibebiz:continue` |
| Đã trình ban lãnh đạo | Bạn báo đã trình, đang chờ quyết định | Báo quyết định bằng `/vibebiz:continue` |
| Cần chỉnh sửa | Ban lãnh đạo yêu cầu sửa | `/vibebiz:continue`; ý tưởng quay về "Đang làm rõ" khi bạn bắt đầu sửa |
| Được duyệt | Ban lãnh đạo đã duyệt | Gửi tài liệu cho đội kỹ thuật; muốn làm lại thì mở lại bằng `/vibebiz:continue` |
| Không được duyệt | Ban lãnh đạo không duyệt | Muốn làm lại thì mở lại bằng `/vibebiz:continue` |

Xuất bản nháp không làm đổi trạng thái. Khi mở lại một ý tưởng đã được duyệt hoặc không được duyệt, ý tưởng quay về "Đang làm rõ" và mọi quyết định cũ vẫn còn trong hồ sơ.

Bên cạnh trạng thái là nhãn ước tính: "Chưa qua kỹ thuật thẩm định" cho tới khi bạn báo đội kỹ thuật đã thẩm định, sau đó là "Đã qua kỹ thuật thẩm định".
