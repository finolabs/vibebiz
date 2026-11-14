# vibebiz

Plugin đóng vai người phụ trách sản phẩm (product owner) cho nhà sáng lập và lãnh đạo doanh nghiệp. Ứng dụng chính là Claude Cowork; vibebiz cũng chạy trong Claude Code, Codex và Antigravity với đủ sáu lệnh như nhau. Bạn mang đến một ý tưởng còn mơ hồ; vibebiz phỏng vấn cho tới khi ý tưởng rõ ràng, được phản biện và đo lường được, rồi đóng gói thành bản PRD (tài liệu yêu cầu sản phẩm) cho hội đồng quản trị và đội kỹ thuật nội bộ.

English version: [README.md](README.md)

## vibebiz là gì

Bạn bắt đầu với một câu như "mình muốn dùng AI để kéo khách cũ quay lại". vibebiz hỏi từng vòng ngắn, ghi mọi câu trả lời vào các tệp trong thư mục của bạn, phản biện ý tưởng một cách thẳng thắn (kể cả phương án "không làm gì" và "sửa quy trình") và bảo đảm mỗi mục tiêu đều có mốc hiện tại, mức đích và cách đo. Khi ý tưởng đã sẵn sàng, vibebiz tạo hai bản xem từ cùng một nguồn: bản trình bày cho ban lãnh đạo và bản PRD cho đội kỹ thuật. Bản trình bày được thiết kế theo dạng infographic trực quan (mỗi trang một hình ảnh trung tâm, ít chữ, thông điệp nổi bật ở tiêu đề). Bản kỹ thuật có kèm một tệp yêu cầu theo định dạng tương thích với Spec Kit (bộ công cụ viết đặc tả của giới lập trình), để đội kỹ thuật lập kế hoạch tiếp mà không phải làm lại.

vibebiz không phải công cụ lập trình. Trong Cowork, bạn không bao giờ phải mở cửa sổ dòng lệnh (terminal); trong Claude Code, Codex và Antigravity, bạn chỉ gõ một hai dòng lệnh lúc cài, sau đó mọi việc diễn ra bằng trò chuyện thông thường.

## Dành cho ai

Nhà sáng lập và lãnh đạo doanh nghiệp vừa và nhỏ (không cần rành kỹ thuật) đang có một ý tưởng về hệ thống, cách dùng AI hoặc tự động hóa và cần đưa ý tưởng đó ra trước hội đồng quản trị và đội kỹ thuật. Ngành bán lẻ được hỗ trợ trước, cả bán trực tuyến lẫn tại cửa hàng (thời trang trước, sau đó là điện máy, đồ gia dụng và các ngành tương tự): các ví dụ và gói kiến thức có sẵn hiện nay đều dành cho ngành bán lẻ. Câu hỏi và kết quả dùng đúng ngôn ngữ bạn trao đổi, mặc định là tiếng Việt.

## Cài đặt

Hãy chọn ứng dụng bạn đang dùng. Ở ứng dụng nào, vibebiz cũng có đủ sáu lệnh và tạo cùng một bộ tệp; ý tưởng bắt đầu ở ứng dụng này có thể làm tiếp ở ứng dụng khác, miễn là cả hai cùng mở một thư mục hoặc cùng một thư mục Google Drive.

Cài thêm plugin đi kèm `diagram-design` nếu bạn muốn sơ đồ được vẽ tự động trong kết quả (xem bên dưới).

Với gói Claude Team hoặc Enterprise, quản trị viên có thể thêm một đoạn hướng dẫn chung cho tổ chức để Claude gợi ý vibebiz khi nhân viên kể về một ý tưởng: [docs/admin-setup.md](docs/admin-setup.md).

### Cowork (ứng dụng chính)

1. Tải tệp `vibebiz.plugin` ở [bản phát hành](https://github.com/finolabs/vibebiz/releases) mới nhất.
2. Trong Claude Cowork, mở Cài đặt › Plugin, chọn "Tải plugin lên" và chọn tệp `vibebiz.plugin`.
3. Mở một thư mục trống trong Claude Cowork và bắt đầu bằng cách gõ `/vibebiz:idea` hoặc `/vibebiz:help`. Trên web hoặc điện thoại, Cowork không mở được thư mục trên máy tính của bạn, nên hãy nối Google Drive trong phần kết nối (Connectors) của Cowork: vibebiz sẽ lưu ý tưởng vào một thư mục Drive bạn chọn, cùng cấu trúc tệp như trên máy. Trên máy tính, thư mục đang mở luôn được ưu tiên, và hai nơi không tự đồng bộ với nhau.

### Claude Code

```bash
claude plugin marketplace add finolabs/plugins
claude plugin install vibebiz@finolabs
```

Nếu đang ở trong Claude Code và đã thêm danh mục plugin (marketplace) của FINOLABS, bạn gõ `/plugin install vibebiz@finolabs` cũng được. Sau đó mở thư mục dự án và gõ `/vibebiz:idea`. Nếu mỗi lệnh vibebiz hiện hai lần, nghĩa là máy bạn có cả bản đồng bộ từ tài khoản Claude lẫn bản cài từ danh mục; hãy giữ một bản ([câu hỏi 13](docs/faq.md)).

### Codex

```bash
codex plugin marketplace add finolabs/plugins
codex plugin add vibebiz@finolabs
```

Mở một thư mục làm việc trong Codex rồi gõ `$idea`, hoặc kể ý tưởng bằng lời thường. Codex hiện mọi lệnh vibebiz với dấu `$` ở đầu: `$continue`, `$package`, `$help`, v.v.

### Antigravity

```bash
agy plugin install https://github.com/finolabs/vibebiz
```

Mở một thư mục làm việc trong Antigravity rồi gõ `/idea`, hoặc kể ý tưởng bằng lời thường. Antigravity hiện các lệnh không kèm phần `vibebiz:`: `/continue`, `/package`, v.v. Riêng phần trợ giúp thì khác: `/help` mở trợ giúp của chính Antigravity, nên bạn hãy hỏi bằng lời ("vibebiz dùng thế nào?"). Antigravity có thể đã tự chép một bản vibebiz cũ từ Claude Code sang; hãy gỡ bản đó trước khi cài ([câu hỏi 16](docs/faq.md)).

## Mỗi ứng dụng làm được gì

vibebiz xem ứng dụng bạn đang dùng làm được gì (mở thư mục, vào Google Drive, hiện trang xem) rồi dùng đúng cách đó; thiếu thứ gì, vibebiz chỉ bạn cách bật và đề nghị cách khác.

| | Cowork | Claude Code | Codex | Antigravity |
|---|---|---|---|---|
| Cách gõ lệnh | `/vibebiz:idea` | `/vibebiz:idea` | `$idea` | `/idea`; muốn trợ giúp thì hỏi bằng lời |
| Lưu ý tưởng trong thư mục trên máy | thư mục bạn mở (ứng dụng trên máy tính) | thư mục dự án | thư mục làm việc | thư mục làm việc |
| Lưu ý tưởng trong Google Drive | kết nối Google Drive của Cowork | kết nối Google Drive của ứng dụng Claude | plugin Google Drive của OpenAI | plugin Google Drive chính thức của Antigravity |
| Bản trình bày trên Google Slides, PRD trên Google Docs | kết nối Slides và Docs của Cowork | khi ứng dụng Claude đã nối Slides và Docs | plugin Google Drive của OpenAI | plugin Google Slides và Google Docs chính thức của Antigravity |
| Xem bản trình bày và PRD ở đâu | Artifact riêng tư (trang chỉ bạn mở được trong Claude) | Artifact riêng tư nếu ứng dụng Claude có; nếu không, trang web trong thư mục ý tưởng | trang web trong thư mục ý tưởng, mở bằng trình duyệt | trang web trong thư mục ý tưởng, mở bằng trình duyệt |
| Câu hỏi hiện ra thế nào | nút chọn, tối đa bốn câu, mỗi câu tối đa bốn phương án | như Cowork | nút chọn của Codex nếu Codex có (tối đa ba câu mỗi lần, nên một vòng có thể chia làm hai lượt); nếu không, các phương án đánh số trong tin nhắn | nút chọn của Antigravity |

Khi ứng dụng không có nút chọn, vibebiz hỏi đúng vòng đó bằng tin nhắn thường, các phương án được đánh số; bạn trả lời bằng số hoặc bằng lời của mình. Khi chưa mở thư mục nào và cũng chưa nối Google Drive, vibebiz không lưu gì và chỉ bạn hai cách: mở một thư mục làm việc trong ứng dụng, hoặc nối Google Drive.

### Nối Google

- **Cowork**: mở phần kết nối (Connectors) và nối Google Drive (thêm Google Slides và Docs nếu muốn có bản trình bày và PRD trên Google).
- **Claude Code**: nối Google Drive trong phần kết nối (Connectors) của ứng dụng Claude.
- **Codex**: cài plugin Google Drive trong Codex rồi đăng nhập tài khoản Google; plugin này dùng được cho cả Docs và Slides.
- **Antigravity**: cài plugin Google Drive chính thức của Antigravity (thêm plugin Google Slides và Google Docs để đóng gói) rồi đăng nhập tài khoản Google. Các plugin này cần kết nối mạng và lần đầu sẽ tự tải một chương trình nhỏ đi kèm; bản thân vibebiz không chạy chương trình nào.

Ở ứng dụng nào, tệp cũng chỉ nằm trong thư mục của bạn hoặc Google Drive của chính bạn, ở chế độ riêng tư; vibebiz không bao giờ chia sẻ hay công khai tệp nào.

## Có gì trong bản phát hành

vibebiz có sáu kỹ năng. Mỗi lệnh là một kỹ năng (skill) cùng tên; bạn cũng có thể chỉ cần nói điều mình muốn bằng lời thường. Các lệnh dưới đây được viết như Cowork và Claude Code hiển thị; trong Codex bạn gõ `$idea`, trong Antigravity gõ `/idea`, các lệnh khác cũng vậy.

- `/vibebiz:idea`: bắt đầu một ý tưởng mới. vibebiz chuẩn bị thư mục làm việc nếu cần, hỏi về một tình huống thật gần đây, viết bản nháp yêu cầu đầu tiên với mọi chỗ còn thiếu được đánh dấu, rồi hỏi bạn từng vòng ngắn (tối đa bốn câu trắc nghiệm, phương án nên chọn đứng đầu) và lưu lại mọi câu trả lời.
- `/vibebiz:continue`: làm tiếp một ý tưởng. vibebiz đọc lại các tệp (phần bạn tự sửa được giữ nguyên), tóm tắt trong ba dòng điều gì đã rõ, lần trước dừng ở đâu và câu hỏi tiếp theo, rồi hỏi tiếp. Lệnh này cũng ghi nhận kết quả phê duyệt của ban lãnh đạo (duyệt, không duyệt, cần sửa) và kết quả thẩm định chi phí của đội kỹ thuật.
- `/vibebiz:package`: đóng gói một ý tưởng đã rõ để trình ban lãnh đạo và gửi đội kỹ thuật. vibebiz kiểm tra ý tưởng đã đủ điều kiện chưa (hoặc đề nghị bản nháp có ghi rõ chỗ thiếu), lập kế hoạch, soát chỗ thiếu và chỗ mâu thuẫn, rồi tạo bản trình bày và tài liệu yêu cầu dưới dạng Artifact riêng tư trên Claude (ở ứng dụng không có Artifact thì là trang web trong thư mục ý tưởng) hoặc Google Slides, Google Docs của chính bạn, kèm một tệp yêu cầu dùng được với Spec Kit. Mọi con số giống nhau ở mọi bản và có nguồn. vibebiz giữ lại các phiên bản cũ, không chia sẻ và không để công khai tài liệu nào.
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

Ở mọi ứng dụng, dữ liệu kinh doanh của bạn nằm trong thư mục làm việc và Google Drive của bạn; vibebiz không gửi nó đi đâu khác. Trong Codex và Antigravity, vibebiz chỉ vào Google qua tích hợp Google chính thức của chính ứng dụng đó. Artifact được đăng ở chế độ riêng tư; vibebiz không bao giờ tự chia sẻ kết quả thay bạn hay công khai tệp nào. Chi tiết: [PRIVACY.md](PRIVACY.md).

## Plugin đi kèm: diagram-design

vibebiz viết bản mô tả sơ đồ; plugin riêng [diagram-design](https://github.com/cathrynlavery/diagram-design) (MIT) vẽ chúng. Plugin này không nằm trong kho mã này. Khi không có nó, kết quả hiển thị một bảng kèm ghi chú "chưa có sơ đồ".

## Spec Kit

vibebiz tương thích với Spec Kit 1.4.0. Phần nào được chuyển từ upstream và phần nào là của riêng vibebiz nằm trong [UPSTREAM.md](UPSTREAM.md); thông báo bên thứ ba nằm trong [THIRD_PARTY_LICENSES.md](THIRD_PARTY_LICENSES.md).

## Đóng góp và bảo mật

[CONTRIBUTING.md](CONTRIBUTING.md), [CODE_OF_CONDUCT.md](CODE_OF_CONDUCT.md), [SECURITY.md](SECURITY.md), [CHANGELOG.md](CHANGELOG.md).
