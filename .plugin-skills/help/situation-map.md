# Situation map

Help uses this map to route a situation the user describes to one entry skill, then stops. It lists only the entry skills that ship in this version; a situation that matches none of them is answered with "this version does not cover it yet". Situations are written in the user's words, Vietnamese first.

| Situation | Entry point |
|---|---|
| Có một ý tưởng mới về hệ thống, cách dùng AI hoặc việc muốn tự động hóa ("tôi có ý tưởng", "lên ý tưởng", "tôi muốn làm một ứng dụng…") | /vibebiz:idea |
| Mở một thư mục mới và muốn bắt đầu dùng vibebiz | /vibebiz:idea |
| Muốn làm tiếp một ý tưởng đã bắt đầu ("làm tiếp ý tưởng hôm trước") | /vibebiz:continue |
| Đã tạm dừng sau ba vòng câu hỏi và muốn trả lời tiếp | /vibebiz:continue |
| Muốn có người phản biện một ý tưởng mới, chỉ ra điểm yếu trước khi trình ("ý tưởng này có ổn không", "tìm giúp chỗ dễ thất bại") | /vibebiz:idea |
| Muốn phản biện kỹ hơn hoặc đặt mục tiêu đo được cho một ý tưởng đang làm ("đo kết quả thế nào", "nếu không làm thì sao") | /vibebiz:continue |
| Muốn dùng một phương pháp cụ thể cho ý tưởng đang làm ("phân tích SWOT giúp tôi", "dùng Balanced Scorecard", "hỏi 5 lần vì sao") | /vibebiz:continue |
| Tình hình của ý tưởng đang làm đã thay đổi và muốn vibebiz hỏi lại cho phù hợp ("sự cố đã xử lý xong", "hóa ra chi nhánh khác đã làm việc này rồi") | /vibebiz:continue |
| Ý tưởng đã rõ và cần tài liệu trình ban lãnh đạo hoặc gửi đội kỹ thuật ("làm slide", "viết PRD", "đóng gói ý tưởng") | /vibebiz:package |
| Muốn lấy bản nháp của ý tưởng dù còn chỗ chưa rõ ("xuất bản nháp") | /vibebiz:package |
| Muốn xem tất cả ý tưởng đang đến đâu ("các ý tưởng của tôi đến đâu rồi") | /vibebiz:status |
| Muốn ghi luật chung cho mọi ý tưởng của công ty ("ghi luật chung", "ưu tiên năm nay của công ty là…") | /vibebiz:constitution |
| Muốn sửa luật chung đã ghi, thêm mục tiêu chiến lược hoặc OKR ("đổi mức chi tôi tự duyệt", "thêm OKR năm nay") | /vibebiz:constitution |
| Muốn dùng vibebiz trên web hoặc điện thoại, hoặc vibebiz báo chưa mở được thư mục nào ("dùng trên điện thoại được không", "chưa có thư mục thì làm sao") | /vibebiz:help |
| Chưa biết bắt đầu từ đâu, muốn tìm hiểu cách dùng vibebiz hoặc cần hướng dẫn chọn lệnh phù hợp ("hướng dẫn tôi dùng", "làm gì tiếp theo", "tôi nên dùng lệnh nào", "cách dùng vibebiz") | /vibebiz:help |
| Muốn xem một ý tưởng mẫu đã làm xong trông như thế nào ("cho xem ví dụ mẫu", "xem ý tưởng mẫu", "đầu ra trông ra sao") | /vibebiz:help |
| Hỏi về cách thức hoạt động, quy trình hoặc tài liệu của vibebiz ("tài liệu ở đâu", "giải thích quy trình", "nhãn này nghĩa là gì") | /vibebiz:help |

## After the board meeting and the tech review

Reported events about a packaged idea go to continue, which records them; help only routes.

| Situation | Entry point |
|---|---|
| Đã trình ban lãnh đạo và có quyết định ("sếp duyệt rồi", "ban lãnh đạo không duyệt", "ban giám đốc yêu cầu sửa phần chi phí") | /vibebiz:continue |
| Đã trình nhưng ban lãnh đạo chưa trả lời ("trình rồi, đang chờ") | /vibebiz:continue |
| Đội kỹ thuật đã xem lại chi phí, công sức hoặc lợi ích ước tính ("bên kỹ thuật thẩm định xong chi phí") | /vibebiz:continue |
| Muốn bỏ nhãn "chưa qua kỹ thuật thẩm định" khỏi tài liệu (cần báo kết quả thẩm định trước, rồi đóng gói lại) | /vibebiz:continue |
| Muốn làm lại một ý tưởng đã được duyệt hoặc không được duyệt ("mở lại ý tưởng này") | /vibebiz:continue |
| Muốn biết mỗi trạng thái của ý tưởng nghĩa là gì, hoặc ý tưởng nào đã được duyệt | /vibebiz:status |
