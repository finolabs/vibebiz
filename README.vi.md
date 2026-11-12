# vibebiz

Plugin cho Claude Cowork, đóng vai người phụ trách sản phẩm (product owner) cho lãnh đạo ngành bán lẻ. Bạn mang đến một ý tưởng còn mơ hồ; vibebiz phỏng vấn cho tới khi ý tưởng rõ ràng, được phản biện và đo lường được, rồi đóng gói thành bản PRD (tài liệu yêu cầu sản phẩm) cho hội đồng quản trị và đội kỹ thuật nội bộ.

English version: [README.md](README.md)

## vibebiz là gì

Bạn bắt đầu với một câu như "mình muốn dùng AI để kéo khách cũ quay lại". vibebiz hỏi từng vòng ngắn, ghi mọi câu trả lời vào các tệp trong thư mục của bạn, phản biện ý tưởng một cách thẳng thắn (kể cả phương án "không làm gì" và "sửa quy trình") và bảo đảm mỗi mục tiêu đều có mốc hiện tại, mức đích và cách đo. Khi ý tưởng đã sẵn sàng, vibebiz tạo hai bản xem từ cùng một nguồn: bản trình bày cho hội đồng quản trị và bản PRD cho đội kỹ thuật. Bản kỹ thuật có kèm một tệp yêu cầu theo định dạng tương thích với Spec Kit (bộ công cụ viết đặc tả của giới lập trình), để đội kỹ thuật lập kế hoạch tiếp mà không phải làm lại.

vibebiz không phải công cụ lập trình và không bao giờ bắt bạn mở cửa sổ dòng lệnh.

## Dành cho ai

Giám đốc kinh doanh và vận hành ngành bán lẻ, bán trực tuyến hay tại cửa hàng (thời trang trước, sau đó là điện máy, đồ gia dụng và các ngành tương tự), đang có một ý tưởng về hệ thống, cách dùng AI hoặc tự động hóa và cần đưa ý tưởng đó ra trước hội đồng quản trị và đội kỹ thuật. Câu hỏi và kết quả dùng đúng ngôn ngữ bạn trao đổi, mặc định là tiếng Việt.

## Cài đặt bằng cách tải lên

1. Lấy tệp plugin `vibebiz.plugin` từ một bản phát hành (hiện chưa có bản nào).
2. Trong Claude Cowork, tải tệp plugin lên.
3. Mở một thư mục trống trong Cowork và bắt đầu bằng kỹ năng `new`.

Cài thêm plugin đi kèm `diagram-design` nếu bạn muốn có sơ đồ trong kết quả (xem bên dưới).

## Có gì trong bản phát hành

Mục này liệt kê từng kỹ năng khi phần việc tạo ra nó được phát hành. Mỗi lệnh là một kỹ năng (skill) cùng tên; bạn cũng có thể chỉ cần nói điều mình muốn bằng lời thường.

- `/vibebiz:new`: bắt đầu một ý tưởng mới. vibebiz chuẩn bị thư mục làm việc nếu cần, hỏi về một tình huống thật gần đây, viết bản nháp yêu cầu đầu tiên với mọi chỗ còn thiếu được đánh dấu, rồi hỏi bạn từng vòng ngắn (tối đa bốn câu trắc nghiệm, phương án nên chọn đứng đầu) và lưu lại mọi câu trả lời.
- `/vibebiz:continue`: làm tiếp một ý tưởng. vibebiz đọc lại các tệp (phần bạn tự sửa được giữ nguyên), tóm tắt trong ba dòng điều gì đã rõ, lần trước dừng ở đâu và câu hỏi tiếp theo, rồi hỏi tiếp.
- `/vibebiz:status`: liệt kê mọi ý tưởng với trạng thái, số điểm đã rõ trên 15 điểm và bước tiếp theo. Lệnh này không hỏi gì.

Chi tiết các lệnh: [docs/commands.md](docs/commands.md).

## Giấy phép

vibebiz là phần mềm **công khai mã nguồn có điều kiện (source-available)**: mã công khai theo Giấy phép PolyForm Noncommercial 1.0.0, kèm một giấy phép thương mại riêng.

| Bạn là | Bạn cần |
|---|---|
| Cá nhân dùng vibebiz để học tập hoặc làm theo sở thích | Không cần gì thêm: miễn phí theo `LICENSE` |
| Tổ chức từ thiện, giáo dục, nghiên cứu công, an toàn công cộng, môi trường hoặc cơ quan nhà nước | Miễn phí theo `LICENSE` (mục đích phi thương mại theo định nghĩa của giấy phép đó) |
| Doanh nghiệp dùng vibebiz cho công việc, kể cả doanh nghiệp được tặng vibebiz miễn phí | Giấy phép thương mại bằng văn bản, xem [COMMERCIAL-LICENSE.md](COMMERCIAL-LICENSE.md) |
| Người đóng góp | Đồng ý với [CLA](CLA.md) |

Các văn bản giấy phép hiện là bản nháp, đang chờ luật sư rà soát. Xem thêm [TERMS.md](TERMS.md).

## Quyền riêng tư

Dữ liệu kinh doanh của bạn nằm trong thư mục làm việc và Google Drive của bạn; vibebiz không gửi nó đi đâu khác. Artifact được đăng ở chế độ riêng tư và vibebiz không bao giờ tự chia sẻ kết quả thay bạn. Chi tiết: [PRIVACY.md](PRIVACY.md).

## Plugin đi kèm: diagram-design

vibebiz viết bản mô tả sơ đồ; plugin riêng [diagram-design](https://github.com/cathrynlavery/diagram-design) (MIT) vẽ chúng. Plugin này không nằm trong kho mã này. Khi không có nó, kết quả hiển thị một bảng kèm ghi chú "chưa có sơ đồ".

## Spec Kit

vibebiz tương thích với Spec Kit 1.4.0. Phần nào được chuyển từ upstream và phần nào là của riêng vibebiz nằm trong [UPSTREAM.md](UPSTREAM.md); thông báo bên thứ ba nằm trong [THIRD_PARTY_LICENSES.md](THIRD_PARTY_LICENSES.md).

## Đóng góp và bảo mật

[CONTRIBUTING.md](CONTRIBUTING.md), [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md), [SECURITY.md](SECURITY.md), [CHANGELOG.md](CHANGELOG.md).
