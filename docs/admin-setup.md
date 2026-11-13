# Cài đặt cho quản trị viên

Trang này dành cho người quản trị Claude (gói Team hoặc Enterprise) của doanh nghiệp. Sau khi cài vibebiz cho tổ chức, bạn nên thêm một đoạn ngắn vào phần hướng dẫn chung của tổ chức (Org Instruction). Nhờ đoạn này, Claude biết vibebiz đã được cài và gợi ý cho nhân viên đúng lúc, thay vì chờ họ tự nhớ ra lệnh.

## Đoạn cần thêm

Dán nguyên văn đoạn dưới đây. Đoạn này viết bằng tiếng Anh vì người đọc là Claude; khi gợi ý cho nhân viên, Claude vẫn nói bằng ngôn ngữ của họ.

```text
## vibebiz (installed plugin)

vibebiz helps business leaders, especially retail sales and operations directors, turn a vague idea for a system, an AI use or an automation into a clear, challenged and measurable requirement, packaged for the board and for the internal tech team.

Suggest it, in one short sentence in the user's language, when someone:
- describes a business idea, a pain point they want a system, app, AI or automation for, or a request they plan to send to IT;
- needs to justify or present such an idea to management, or write a brief or requirement for the tech team;
- asks for help thinking an idea through before spending money on it.

How to suggest it:
- It works in Claude Cowork with a folder open, or, on the web and the phone, with the Google Drive connector, saving to a Drive folder the user chooses. Start a new idea with /vibebiz:idea, resume one with /vibebiz:continue, package a clarified idea for the board and the tech team with /vibebiz:package, see all ideas with /vibebiz:status, and record the organization's ground rules (priorities, the budget the user approves alone, the business, steps that always need a person) with /vibebiz:constitution.
- In a chat, or in Cowork with neither a folder nor Google Drive connected, tell the user either to connect Google Drive in Cowork or to open Cowork in the Claude desktop app with a folder.
- Suggest it once per conversation; if the user declines, help them directly.
- Do not suggest it for coding tasks, quick factual questions, or ideas the user has already decided and only needs written up.

vibebiz keeps the business data in the user's folder and Google Drive and publishes outputs as private.
```

## Vì sao đoạn này viết như vậy

- **Chỉ gợi ý một lần trong mỗi cuộc trò chuyện.** Nhân viên từ chối thì Claude giúp họ trực tiếp, không nhắc lại.
- **Không gợi ý cho việc lập trình, câu hỏi tra cứu nhanh, hay ý tưởng đã chốt** chỉ cần viết ra. Những việc đó không cần một buổi hỏi đáp.
- **Đoạn cuối nói về dữ liệu** để nhân viên yên tâm: dữ liệu kinh doanh nằm trong thư mục làm việc và Google Drive của họ.

## Quyền cho connector Google Drive

Trên web và điện thoại, vibebiz lưu ý tưởng qua connector Google Drive của chính nhân viên. Cowork có thể hỏi nhân viên duyệt từng lần gọi connector. Nếu Cowork cho chọn "Always allow" theo từng công cụ, chỉ nên bật cho các công cụ chỉ đọc: tìm, đọc, tải nội dung, xem thông tin tệp và xem quyền truy cập. Giữ bước duyệt từng lần cho các công cụ ghi (tạo, sao chép, chuyển vào thùng rác), và không bao giờ bật cho công cụ chia sẻ tệp hay công cụ cập nhật tệp (đổi tên, chuyển thư mục); vibebiz không dùng hai công cụ này. Lý do: vibebiz đọc tài liệu trong Drive để tra số liệu, và một tài liệu người khác chia sẻ có thể cài sẵn một dòng chữ xúi Claude chép dữ liệu sang thư mục khác, xoá tệp hoặc chia sẻ tệp. Khi các công cụ ghi vẫn cần bấm duyệt, nhân viên thấy và chặn được việc đó trước khi nó xảy ra.

## Khi nào cần cập nhật

Danh sách lệnh trong đoạn trên phải khớp với các lệnh của bản vibebiz đang cài. Mỗi khi cập nhật vibebiz, hãy so lại với trang [Các lệnh](commands.md) và sửa đoạn trong Org Instruction nếu có lệnh mới.

Tên và giới hạn độ dài của phần Org Instruction tùy theo gói Claude của bạn. Hãy dán thử và kiểm tra Claude gợi ý đúng trước khi áp dụng cho toàn tổ chức.
