# vibebiz

Plugin cho Claude Cowork, đóng vai người phụ trách sản phẩm (product owner) cho lãnh đạo ngành bán lẻ. Bạn mang đến một ý tưởng còn mơ hồ; vibebiz phỏng vấn cho tới khi ý tưởng rõ ràng, được phản biện và đo lường được, rồi đóng gói thành bản PRD (tài liệu yêu cầu sản phẩm) cho hội đồng quản trị và đội kỹ thuật nội bộ.

English version: [README.md](README.md)

## vibebiz là gì

Bạn bắt đầu với một câu như "mình muốn dùng AI để kéo khách cũ quay lại". vibebiz hỏi từng vòng ngắn, ghi mọi câu trả lời vào các tệp trong thư mục của bạn, phản biện ý tưởng một cách thẳng thắn (kể cả phương án "không làm gì" và "sửa quy trình") và bảo đảm mỗi mục tiêu đều có mốc hiện tại, mức đích và cách đo. Khi ý tưởng đã sẵn sàng, vibebiz tạo hai bản xem từ cùng một nguồn: bản trình bày cho ban lãnh đạo và bản PRD cho đội kỹ thuật. Bản trình bày được thiết kế theo dạng infographic trực quan (mỗi trang một hình ảnh trung tâm, ít chữ, thông điệp nổi bật ở tiêu đề). Bản kỹ thuật có kèm một tệp yêu cầu theo định dạng tương thích với Spec Kit (bộ công cụ viết đặc tả của giới lập trình), để đội kỹ thuật lập kế hoạch tiếp mà không phải làm lại.

vibebiz không phải công cụ lập trình và không bao giờ bắt bạn mở cửa sổ dòng lệnh.

## Dành cho ai

Giám đốc kinh doanh và vận hành ngành bán lẻ, bán trực tuyến hay tại cửa hàng (thời trang trước, sau đó là điện máy, đồ gia dụng và các ngành tương tự), đang có một ý tưởng về hệ thống, cách dùng AI hoặc tự động hóa và cần đưa ý tưởng đó ra trước hội đồng quản trị và đội kỹ thuật. Câu hỏi và kết quả dùng đúng ngôn ngữ bạn trao đổi, mặc định là tiếng Việt.

## Cài đặt trong Cowork

1. Tải tệp `vibebiz.plugin` ở [bản phát hành](https://github.com/finolabs/vibebiz/releases) mới nhất.
2. Trong Claude Cowork, mở Cài đặt › Plugin, chọn "Tải plugin lên" và chọn tệp `vibebiz.plugin`.
3. Mở một thư mục trống trong Claude Cowork và bắt đầu bằng cách gõ `/vibebiz:new` hoặc `/vibebiz:help`. Trên web hoặc điện thoại, Cowork không mở được thư mục trên máy tính của bạn, nên hãy nối Google Drive trong phần kết nối (Connectors) của Cowork: vibebiz sẽ lưu ý tưởng vào một thư mục Drive bạn chọn, cùng cấu trúc tệp như trên máy. Trên máy tính, thư mục đang mở luôn được ưu tiên, và hai nơi không tự đồng bộ với nhau.

Cài thêm plugin đi kèm `diagram-design` nếu bạn muốn sơ đồ được vẽ tự động trong kết quả (xem bên dưới).

Với gói Claude Team hoặc Enterprise, quản trị viên có thể thêm một đoạn hướng dẫn chung cho tổ chức để Claude gợi ý vibebiz khi nhân viên kể về một ý tưởng: [docs/admin-setup.md](docs/admin-setup.md).

## Có gì trong bản phát hành

vibebiz có sáu kỹ năng. Mỗi lệnh là một kỹ năng (skill) cùng tên; bạn cũng có thể chỉ cần nói điều mình muốn bằng lời thường.

- `/vibebiz:new`: bắt đầu một ý tưởng mới. vibebiz chuẩn bị thư mục làm việc nếu cần, hỏi về một tình huống thật gần đây, viết bản nháp yêu cầu đầu tiên với mọi chỗ còn thiếu được đánh dấu, rồi hỏi bạn từng vòng ngắn (tối đa bốn câu trắc nghiệm, phương án nên chọn đứng đầu) và lưu lại mọi câu trả lời.
- `/vibebiz:continue`: làm tiếp một ý tưởng. vibebiz đọc lại các tệp (phần bạn tự sửa được giữ nguyên), tóm tắt trong ba dòng điều gì đã rõ, lần trước dừng ở đâu và câu hỏi tiếp theo, rồi hỏi tiếp. Lệnh này cũng ghi nhận kết quả phê duyệt của ban lãnh đạo (duyệt, không duyệt, cần sửa) và kết quả thẩm định chi phí của đội kỹ thuật.
- `/vibebiz:package`: đóng gói một ý tưởng đã rõ để trình ban lãnh đạo và gửi đội kỹ thuật. vibebiz kiểm tra ý tưởng đã đủ điều kiện chưa (hoặc đề nghị bản nháp có ghi rõ chỗ thiếu), lập kế hoạch, soát chỗ thiếu và chỗ mâu thuẫn, rồi tạo bản trình bày và tài liệu yêu cầu dưới dạng Artifact riêng tư trên Claude hoặc Google Slides, Google Docs của chính bạn, kèm một tệp yêu cầu dùng được với Spec Kit. Mọi con số giống nhau ở mọi bản và có nguồn. vibebiz giữ lại các phiên bản cũ, không chia sẻ và không để công khai tài liệu nào.
- `/vibebiz:status`: liệt kê mọi ý tưởng với trạng thái, số điểm đã rõ trên 15 điểm và bước tiếp theo. Lệnh này không hỏi gì.
- `/vibebiz:constitution`: ghi hoặc sửa luật chung của công ty trong một vòng tối đa bốn câu hỏi: ưu tiên năm nay, mức chi bạn tự duyệt, ngành hàng và những việc luôn cần người duyệt; có thể thêm mục tiêu chiến lược và OKR nếu công ty đã có. Bỏ qua thì luật chung được để sau. Khi phản biện và lập kế hoạch, vibebiz đối chiếu từng ý tưởng với các luật này; chỗ nào vượt luật được ghi rõ trong kế hoạch và bản trình bày. Khi sửa luật đã ghi, vibebiz cho bạn xem phần thay đổi và hỏi trước khi lưu.
- `/vibebiz:help`: hướng dẫn chọn đúng lệnh phù hợp với tình huống của bạn và giải đáp thắc mắc từ tài liệu đi kèm có dẫn nguồn. Lệnh này đọc hướng dẫn hiện tại của kỹ năng trước khi mô tả, giới thiệu ý tưởng mẫu (`examples/`) khi bạn muốn xem, và không ghi bất kỳ tệp nào vào thư mục làm việc.

Chi tiết các lệnh: [docs/commands.md](docs/commands.md).

## Giấy phép

vibebiz là phần mềm **công khai mã nguồn có điều kiện (source-available)**: mã công khai theo Giấy phép PolyForm Noncommercial 1.0.0, kèm một giấy phép thương mại riêng.

| Bạn là | Bạn cần |
|---|---|
| Cá nhân dùng vibebiz để học tập hoặc làm theo sở thích | Không cần gì thêm: miễn phí theo `LICENSE` |
| Tổ chức từ thiện, giáo dục, nghiên cứu công, an toàn công cộng, môi trường hoặc cơ quan nhà nước | Miễn phí theo `LICENSE` (mục đích phi thương mại theo định nghĩa của giấy phép đó) |
| Doanh nghiệp dùng vibebiz cho công việc, kể cả doanh nghiệp được tặng vibebiz miễn phí | Giấy phép thương mại bằng văn bản, xem [COMMERCIAL-LICENSE.md](COMMERCIAL-LICENSE.md) |
| Người đóng góp | Đồng ý với [CLA](CLA.md) |

Xem thêm [TERMS.md](TERMS.md).

## Quyền riêng tư

Dữ liệu kinh doanh của bạn nằm trong thư mục làm việc và Google Drive của bạn; vibebiz không gửi nó đi đâu khác. Artifact được đăng ở chế độ riêng tư và vibebiz không bao giờ tự chia sẻ kết quả thay bạn. Chi tiết: [PRIVACY.md](PRIVACY.md).

## Plugin đi kèm: diagram-design

vibebiz viết bản mô tả sơ đồ; plugin riêng [diagram-design](https://github.com/cathrynlavery/diagram-design) (MIT) vẽ chúng. Plugin này không nằm trong kho mã này. Khi không có nó, kết quả hiển thị một bảng kèm ghi chú "chưa có sơ đồ".

## Spec Kit

vibebiz tương thích với Spec Kit 1.4.0. Phần nào được chuyển từ upstream và phần nào là của riêng vibebiz nằm trong [UPSTREAM.md](UPSTREAM.md); thông báo bên thứ ba nằm trong [THIRD_PARTY_LICENSES.md](THIRD_PARTY_LICENSES.md).

## Đóng góp và bảo mật

[CONTRIBUTING.md](CONTRIBUTING.md), [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md), [SECURITY.md](SECURITY.md), [CHANGELOG.md](CHANGELOG.md).
