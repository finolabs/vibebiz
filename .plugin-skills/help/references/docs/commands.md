# Các lệnh của vibebiz

Mỗi lệnh trong số sáu lệnh là một kỹ năng (skill) cùng tên trong plugin vibebiz: `idea`, `continue`, `package`, `status`, `constitution`, và `help`. Bạn có thể gõ trực tiếp tên lệnh, hoặc chỉ cần nói điều mình muốn bằng lời thường, Claude sẽ tự nhận biết và chọn đúng lệnh phù hợp. Mọi lệnh đều cần một nơi để lưu: một thư mục làm việc đang mở trong ứng dụng Claude trên máy tính, hoặc một thư mục trong Google Drive của bạn khi dùng Cowork trên web hay điện thoại. Nếu chưa có nơi nào, vibebiz chỉ ra hai cách đó cho bạn và không làm gì thêm.

Hành trình của một ý tưởng trải qua các bước: khởi tạo với `/vibebiz:idea`, làm rõ và phản biện qua các vòng với `/vibebiz:continue`, đóng gói tài liệu với `/vibebiz:package`, và cập nhật kết quả thẩm định kỹ thuật hoặc quyết định của ban lãnh đạo.

## /vibebiz:idea

**Dùng khi**: bạn có một ý tưởng mới về hệ thống, cách dùng AI hoặc việc muốn tự động hóa. Ví dụ: "Tôi có ý tưởng", "Tôi muốn dùng AI nhắc khách cũ quay lại mua hàng", "Lên ý tưởng làm trợ lý tư vấn size".

**vibebiz sẽ làm gì**:

1. Chuẩn bị thư mục làm việc nếu chưa có. Nếu thư mục đã có tệp khác, vibebiz hỏi bạn muốn dùng thư mục này hay tạo một thư mục con riêng (nên chọn thư mục con để tách biệt với tệp cá nhân). vibebiz chỉ bổ sung phần còn thiếu và không bao giờ ghi đè tệp nào của bạn.
2. Lần đầu dùng, vibebiz mời bạn ghi vài luật chung cho mọi ý tưởng (ưu tiên năm nay, mức chi bạn tự duyệt, ngành hàng, việc luôn cần người duyệt). Bạn có thể để sau và ghi bất cứ lúc nào bằng `/vibebiz:constitution`.
3. Hỏi một câu mở về tình huống thật gần nhất đã khiến bạn nghĩ tới ý tưởng.
4. Tạo một thư mục riêng cho ý tưởng, viết bản nháp yêu cầu đầu tiên và cho bạn xem bảng những điểm đã rõ và còn thiếu.
5. Hỏi từng vòng ngắn, mỗi vòng tối đa bốn câu trắc nghiệm, phương án nên chọn luôn đứng đầu. Bạn có thể bỏ qua câu nào cũng được; câu bị bỏ qua không bị tính là đã đồng ý. Sau mỗi vòng, câu trả lời được ghi ngay vào tệp.
6. Sau ba vòng, vibebiz hỏi bạn muốn hỏi tiếp, tạm dừng hay lấy bản nháp. Bản nháp yêu cầu, với các điểm còn thiếu được ghi rõ là "chưa làm rõ", luôn được lưu sẵn trong thư mục của ý tưởng.

## /vibebiz:continue

**Dùng khi**: bạn muốn làm tiếp một ý tưởng đã bắt đầu trước đó, hoặc báo cho vibebiz biết chuyện gì đã xảy ra sau khi trình: ban lãnh đạo duyệt, không duyệt hay yêu cầu sửa, hoặc đội kỹ thuật đã thẩm định chi phí. Ví dụ: "Làm tiếp ý tưởng nhắc khách quay lại", "Ban lãnh đạo duyệt ý tưởng nhắc khách rồi", "Đội kỹ thuật đã xem lại chi phí".

**vibebiz sẽ làm gì khi bạn làm tiếp**:

1. Chọn ý tưởng bạn nhắc tới. Nếu bạn có nhiều ý tưởng đang làm dở, vibebiz hỏi bạn chọn ý tưởng nào.
2. Đọc lại các tệp của ý tưởng như hiện tại. Nếu bạn đã tự sửa tệp bằng tay, vibebiz tôn trọng và giữ nguyên phần bạn sửa.
3. Tóm tắt trong ba dòng: điều gì đã rõ, lần trước dừng ở đâu và câu hỏi tiếp theo là gì.
4. Tiếp tục hỏi từng vòng ngắn như lúc bắt đầu.

**Khi bạn báo kết quả buổi trình ban lãnh đạo**:

1. vibebiz ghi lại quyết định (duyệt, không duyệt hoặc cần sửa), ngày quyết định và góp ý của ban lãnh đạo, gắn với đúng phiên bản tài liệu bạn đã trình trong thư mục lịch sử.
2. vibebiz chỉ hỏi thêm những gì bạn chưa nói: bản nào đã trình (nếu bạn đã đóng gói nhiều lần), ngày nào, và ban lãnh đạo góp ý gì. Bạn có thể bỏ qua câu góp ý; vibebiz không tự ý viết thay.
3. Trạng thái của ý tưởng đổi theo quyết định và hiện ngay trên mục lục.
4. Nếu ban lãnh đạo yêu cầu sửa, vibebiz hỏi bạn muốn sửa ngay hay để sau. Khi sửa, vibebiz hỏi trước về đúng những điểm ban lãnh đạo nêu, rồi mời bạn đóng gói lại thành phiên bản mới.
5. Nếu bạn muốn làm lại một ý tưởng đã được duyệt hoặc không được duyệt, vibebiz hỏi xác nhận rồi mở lại ý tưởng. Mọi quyết định và phiên bản cũ vẫn được giữ nguyên vẹn trong hồ sơ.

**Khi bạn báo đội kỹ thuật đã thẩm định chi phí**:

1. vibebiz ghi lại ngày thẩm định, ai thẩm định (theo vai trò, ví dụ "trưởng nhóm kỹ thuật") và các con số đội kỹ thuật đã sửa, kèm số cũ để đối chiếu.
2. Khi mọi con số ước tính đã qua thẩm định, lần đóng gói sau sẽ bỏ nhãn "chưa qua kỹ thuật thẩm định". Nếu đội kỹ thuật mới xem một phần, nhãn vẫn giữ cho tới khi xem hết.
3. Tài liệu đã tạo trước đó vẫn mang nhãn cũ, nên vibebiz đề nghị đóng gói lại để có bản mới không còn nhãn.

## /vibebiz:package

**Dùng khi**: ý tưởng đã đủ rõ và bạn cần tài liệu để trình ban lãnh đạo và gửi đội kỹ thuật. Ví dụ: "Làm slide trình ý tưởng nhắc khách quay lại", "Viết PRD cho ý tưởng này", "Đóng gói ý tưởng".

**vibebiz sẽ làm gì**:

1. Kiểm tra ý tưởng đã đủ điều kiện chưa. Nếu còn thiếu, vibebiz liệt kê những điểm còn thiếu và để bạn chọn: trả lời thêm vài câu (nên chọn) hoặc lấy ngay bản nháp, trong đó mọi chỗ thiếu ghi rõ là "chưa làm rõ".
2. Lập kế hoạch thực hiện, rà xem ban lãnh đạo và đội kỹ thuật đã có đủ thông tin chưa, rồi soát xem các tệp có chỗ nào mâu thuẫn hay thiếu. Chỗ nào cần bạn quyết, vibebiz hỏi lại theo từng vòng ngắn như khi làm rõ ý tưởng.
3. Hỏi bạn muốn nhận bản trình bày dưới dạng Artifact trên Claude hay Google Slides, và tài liệu kỹ thuật dưới dạng Artifact hay Google Docs. Nếu chưa kết nối Google, vibebiz đề nghị dùng Artifact.
4. Vẽ sơ đồ (cây chỉ số, hành trình trước và sau, các phương án, rủi ro, lộ trình thử nghiệm) nếu đã cài plugin diagram-design; nếu chưa, chỗ sơ đồ hiện một bảng kèm ghi chú "chưa có sơ đồ".
5. Tạo bản trình bày cho ban lãnh đạo (theo phong cách infographic trực quan, mỗi trang một thông điệp cô đọng kèm một hình ảnh lớn), tài liệu cho đội kỹ thuật và một bản sao yêu cầu để đội kỹ thuật dùng trực tiếp với Spec Kit. Mọi con số giống nhau ở cả hai bản, kèm nguồn, thời kỳ và ghi rõ là số đo được hay số giả định. Chi phí ước tính ghi "chưa qua kỹ thuật thẩm định" cho tới khi đội kỹ thuật xác nhận.
6. Khi đóng gói lại, vibebiz chuyển bản cũ vào thư mục lịch sử của ý tưởng và cập nhật Artifact ngay tại liên kết cũ. Nếu ý tưởng nằm trong Google Drive, vibebiz chép bản cũ vào thư mục lịch sử, và hai bản xem dạng trang web không được lưu vào Drive: bạn xem chúng qua Artifact riêng tư, hoặc qua Google Slides và Docs nếu bạn chọn.
7. Gửi bạn các liên kết. Mọi tài liệu chỉ mình bạn xem được: vibebiz không bao giờ tự chia sẻ hay để công khai. Bạn tự chia sẻ cho ban lãnh đạo hoặc đội kỹ thuật khi muốn.

Cách đọc từng tài liệu: [Đọc các tài liệu vibebiz tạo ra](reading-outputs.md).

## /vibebiz:status

**Dùng khi**: bạn muốn xem nhanh tất cả ý tưởng trong thư mục làm việc đang đến đâu. Ví dụ: "Các ý tưởng của tôi đến đâu rồi?", "Xem danh sách ý tưởng".

**vibebiz sẽ làm gì**: liệt kê mọi ý tưởng với trạng thái, ước tính đã qua kỹ thuật thẩm định hay chưa, số điểm đã rõ trên 15 điểm, bước tiếp theo kèm lệnh cần gõ, liên kết tới tài liệu và ngày cập nhật, rồi cập nhật lại mục lục `index.html`. Lệnh này chỉ đọc dữ liệu và không hỏi bạn câu nào. Ý tưởng mẫu (nếu có) nằm riêng và không tính vào danh sách này.

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

Xuất bản nháp không làm đổi trạng thái. Khi mở lại một ý tưởng đã được duyệt hoặc không được duyệt, ý tưởng quay về "Đang làm rõ" và mọi quyết định cũ vẫn còn nguyên trong hồ sơ.

Bên cạnh trạng thái là nhãn ước tính: "Chưa qua kỹ thuật thẩm định" cho tới khi bạn báo đội kỹ thuật đã thẩm định, sau đó là "Đã qua kỹ thuật thẩm định".

## /vibebiz:constitution

**Dùng khi**: bạn muốn ghi hoặc sửa luật chung cho mọi ý tưởng của công ty. Ví dụ: "Ghi luật chung cho công ty", "Đổi mức chi tôi tự duyệt thành 300 triệu", "Thêm OKR năm nay của công ty".

**vibebiz sẽ làm gì**:

1. Chuẩn bị thư mục làm việc nếu chưa có, như khi bắt đầu ý tưởng mới. Bạn có thể ghi luật chung trước khi có ý tưởng nào.
2. Hỏi một vòng tối đa bốn câu: ngành hàng của bạn, mức chi bạn được tự duyệt, những việc luôn cần người duyệt (ví dụ đổi giá bán, gửi tin cho khách, hoàn tiền, dùng dữ liệu cá nhân của khách) và hai, ba ưu tiên năm nay. Câu nào đã có câu trả lời trong lời bạn nói thì vibebiz không hỏi lại. Bạn bỏ qua câu nào thì luật đó giữ nguyên; bỏ qua cả vòng thì luật chung vẫn để sau.
3. Nếu công ty đã có mục tiêu chiến lược theo bốn góc nhìn (tài chính, khách hàng, quy trình nội bộ, học hỏi và phát triển) hoặc OKR năm nay, bạn dán vào hoặc chỉ tài liệu; vibebiz ghi lại đúng như bạn đưa, không tự đặt thêm mục tiêu.
4. Nếu bạn sửa luật đã ghi, vibebiz cho bạn xem phần thay đổi (trước và sau) và chỉ lưu khi bạn đồng ý.
5. Lưu luật chung và cập nhật mục lục.

**Sau đó**: khi phản biện và lập kế hoạch cho từng ý tưởng, vibebiz đối chiếu với luật chung. Ý tưởng cần khoản chi vượt mức bạn tự duyệt, bỏ qua một việc luôn cần người duyệt, hoặc đi ngược mục tiêu đã ghi sẽ được ghi rõ trong kế hoạch và trên bản trình bày cho ban lãnh đạo. Nếu luật chung còn để sau, vibebiz nhắc bạn một lần khi lập kế hoạch.

## /vibebiz:help

**Dùng khi**: bạn chưa biết bắt đầu từ đâu, muốn tìm hiểu cách vibebiz hoạt động, cần hướng dẫn chọn lệnh phù hợp, muốn giải thích một thuật ngữ hay nhãn trong tài liệu, hoặc muốn xem ý tưởng mẫu. Ví dụ: "Dùng vibebiz thế nào", "Giờ tôi làm gì tiếp", "Tôi nên dùng lệnh nào", "Nhãn chưa qua kỹ thuật thẩm định nghĩa là gì", "Cho xem ý tưởng mẫu".

**vibebiz sẽ làm gì**:

1. **Khi bạn nêu một ý tưởng**: vibebiz không đi vào phỏng vấn ngay mà hướng dẫn bạn gõ `/vibebiz:idea` (hoặc `/vibebiz:continue` nếu ý tưởng đã có sẵn) để bắt đầu quy trình làm rõ bài bản.
2. **Khi bạn mô tả tình huống**: vibebiz đối chiếu tình huống của bạn với bảng tình huống, đọc chỉ dẫn hiện tại của kỹ năng đó rồi giải thích ngắn gọn trong hai, ba câu lý do vì sao lệnh đó phù hợp và bước đầu tiên lệnh sẽ làm, sau đó dừng lại. vibebiz không tự ý chạy lệnh thay bạn.
3. **Khi bạn hỏi về cách dùng hoặc thuật ngữ**: vibebiz chỉ trả lời dựa trên các tài liệu chính thức đi kèm, dẫn nguồn rõ ràng theo tên tài liệu và tiêu đề mục. Nếu tài liệu chưa đề cập, vibebiz nói thẳng là chưa có thông tin thay vì tự đoán hoặc bịa ra tính năng.
4. **Khi bạn muốn xem ý tưởng mẫu**: vibebiz giới thiệu ý tưởng mẫu hoàn chỉnh trong thư mục `examples/` để bạn hình dung kết quả đầu ra thực tế trông như thế nào.
5. **Không thay đổi tệp**: lệnh này hoàn toàn mang tính hướng dẫn và tra cứu; vibebiz không tạo, sửa đổi hay ghi đè bất kỳ tệp nào trong thư mục làm việc của bạn.
