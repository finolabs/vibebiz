# Câu hỏi thường gặp (FAQ)

Trang này giải đáp các thắc mắc phổ biến nhất khi sử dụng vibebiz, giúp bạn tận dụng tối đa công cụ để biến các ý tưởng kinh doanh thành tài liệu chuẩn chỉnh.

---

### 1. vibebiz là gì và khác gì so với việc trò chuyện thông thường với Claude?

Khi bạn trò chuyện thông thường với Claude, Claude thường có xu hướng đồng thuận và trả lời chung chung theo những gì bạn gợi ý. Ngược lại, **vibebiz đóng vai trò như một Giám đốc sản phẩm (Product Owner) nội bộ**:
- Có quy trình phỏng vấn chặt chẽ qua 15 điểm cốt lõi, không hỏi lan man.
- Phản biện thẳng thắn, luôn tìm kiếm điểm yếu và rủi ro tiềm ẩn của ý tưởng.
- Tự động lưu trữ câu trả lời vào các tệp có cấu trúc trên máy bạn sau mỗi vòng hỏi.
- Tự động xuất ra hai bộ tài liệu hoàn chỉnh: bản trình bày cho ban lãnh đạo và tài liệu yêu cầu cho đội kỹ thuật tương thích với chuẩn Spec Kit.

---

### 2. Tôi không có kiến thức kỹ thuật thì có dùng được vibebiz không?

**Hoàn toàn được**. vibebiz được thiết kế dành riêng cho các giám đốc kinh doanh, bán hàng và vận hành:
- Bạn không cần biết lập trình, không bao giờ phải mở cửa sổ dòng lệnh (terminal).
- Toàn bộ giao diện câu hỏi đều là trắc nghiệm bằng tiếng Việt thông thường, phương án gợi ý luôn đứng đầu.
- vibebiz tự động dịch chuyển các mong muốn kinh doanh của bạn thành ngôn ngữ đặc tả kỹ thuật chuẩn xác mà đội ngũ lập trình viên có thể hiểu ngay.

---

### 3. Dữ liệu kinh doanh của tôi có được bảo mật không?

**Rất an toàn**:
- Toàn bộ các tệp thông tin ý tưởng và mục lục nằm trọn vẹn trong thư mục làm việc trên máy tính của bạn và tài khoản Google Drive cá nhân của bạn (nếu bạn chọn lưu trên Google).
- vibebiz không gửi dữ liệu của bạn sang bất kỳ hệ thống phân tích bên thứ ba nào.
- vibebiz không bao giờ tự ý gửi email, chia sẻ liên kết hay công khai tài liệu cho bất kỳ ai. Mọi tài liệu tạo ra chỉ một mình bạn có quyền truy cập cho tới khi bạn chủ động chia sẻ.

---

### 4. Tôi có thể dùng vibebiz cho các ngành bán lẻ khác ngoài thời trang không?

**Có**. Mặc dù phiên bản hiện tại tích hợp bộ câu hỏi chuyên sâu và chỉ số đặc thù cho ngành thời trang may mặc, quy trình 15 điểm cốt lõi và bốn góc nhìn tư duy của vibebiz hoàn toàn áp dụng hiệu quả cho mọi ngành bán lẻ khác (như điện máy, điện tử, đồ gia dụng, mỹ phẩm, mẹ và bé). Đối với các ngành này, vibebiz sẽ sử dụng bộ câu hỏi bán lẻ tổng quát.

---

### 5. Nếu tôi bận và phải dừng giữa chừng thì sao?

Dữ liệu của bạn **không bao giờ bị mất**. Sau mỗi vòng câu hỏi, vibebiz ghi nhận ngay các câu trả lời vào tệp của ý tưởng. Khi muốn quay lại, dù là sau vài tiếng hay vài tuần, bạn chỉ cần gõ:

```
/vibebiz:continue
```

vibebiz sẽ tóm tắt đúng 3 dòng: điều gì đã thống nhất, lần trước dừng ở đâu và câu hỏi tiếp theo là gì, giúp bạn bắt nhịp lại ngay mà không cần nhớ lại phiên làm việc cũ.

---

### 6. Tại sao vibebiz không bao giờ khen ngợi ý tưởng của tôi?

vibebiz tuân thủ nguyên tắc **Phản biện trung thực (Anti-sycophancy)**:
- vibebiz ở đây để giúp bạn bảo vệ ý tưởng trước ban lãnh đạo, chứ không phải để làm vui lòng bạn bằng những lời khen sáo rỗng.
- Trong kinh doanh bán lẻ, một dự án triển khai vội vã có thể gây lãng phí hàng trăm triệu đồng ngân sách và làm rối loạn vận hành tại cửa hàng.
- Vì vậy, mỗi vòng phản biện luôn chỉ ra ít nhất một lý do vì sao ý tưởng có thể thất bại, buộc bạn phải suy nghĩ thấu đáo về rủi ro và các giải pháp thay thế.

---

### 7. Khi nào tôi nên chọn "không làm gì" hoặc "sửa quy trình" thay vì tự xây phần mềm?

Bốn phương án cân nhắc trước khi quyết định tự làm: không làm gì, sửa quy trình thủ công, mua phần mềm có sẵn, hoặc tự xây dựng hệ thống mới.

vibebiz luôn yêu cầu cân nhắc 4 phương án:
- **Không làm gì (Do nothing)**: Phù hợp khi chi phí giải quyết vấn đề lớn hơn thiệt hại mà vấn đề gây ra, hoặc khi vấn đề chỉ mang tính mùa vụ nhất thời.
- **Sửa quy trình thủ công (Fix the process)**: Phù hợp khi nguyên nhân gốc là do thiếu quy định, phân công ca kíp chưa hợp lý hoặc nhân viên chưa được hướng dẫn rõ ràng. Sửa quy trình thường không tốn chi phí và thấy kết quả ngay.
- **Mua phần mềm có sẵn (Buy)**: Phù hợp khi trên thị trường đã có các giải pháp phần mềm chuyên dụng giải quyết tốt bài toán đó, giúp tiết kiệm thời gian và chi phí bảo trì.
- **Tự làm (Build)**: Chỉ nên chọn khi đây là năng lực cạnh tranh cốt lõi đặc thù của doanh nghiệp mà không có phần mềm thương mại nào đáp ứng được.

---

### 8. Nhãn "chưa qua kỹ thuật thẩm định" là gì và làm sao để gỡ bỏ?

Khi bạn đóng gói ý tưởng lần đầu, các con số về chi phí, nguồn lực và thời gian mới chỉ là con số ước tính từ góc nhìn kinh doanh. vibebiz gắn nhãn **"chưa qua kỹ thuật thẩm định"** để ban lãnh đạo hiểu rõ đây là số liệu sơ bộ.

Để gỡ bỏ nhãn này:
1. Bạn gửi tài liệu kỹ thuật cho đội ngũ kỹ sư hoặc trưởng nhóm IT để họ rà soát.
2. Khi họ xác nhận hoặc sửa lại các con số, bạn mở Claude Cowork, gõ `/vibebiz:continue` và nói: *"Đội kỹ thuật đã thẩm định xong chi phí"*.
3. vibebiz ghi nhận các con số chính thức và sẽ tự động bỏ nhãn này trong lần đóng gói tiếp theo (`/vibebiz:package`).

---

### 9. Ban lãnh đạo yêu cầu sửa hoặc không phê duyệt thì tôi phải làm gì?

Bạn mở Claude Cowork, gõ `/vibebiz:continue` và báo lại bằng lời thường:
- *"Ban lãnh đạo yêu cầu sửa lại phần chi phí thử nghiệm"* hoặc
- *"Sếp chưa duyệt ý tưởng này vì lý do ngân sách"*.

vibebiz sẽ:
- Lưu lại quyết định và ý kiến chỉ đạo của ban lãnh đạo vào hồ sơ lịch sử của phiên bản đó.
- Cập nhật trạng thái ý tưởng thành "Cần chỉnh sửa" hoặc "Không được duyệt".
- Nếu cần sửa, vibebiz sẽ đồng hành cùng bạn để giải quyết đúng những điểm ban lãnh đạo băn khoăn trước khi mời bạn đóng gói lại.

---

### 10. Làm sao để có các sơ đồ trực quan trong bản trình bày?

vibebiz viết sẵn cấu trúc và mô tả chi tiết cho các sơ đồ (cây chỉ số, hành trình khách hàng, ma trận rủi ro...). Để các sơ đồ này tự động vẽ thành hình ảnh đẹp mắt, bạn cần cài đặt thêm plugin companion miễn phí mang tên **`diagram-design`**.

Nếu chưa cài plugin này, tài liệu vẫn hiển thị đầy đủ thông tin dưới dạng bảng kèm ghi chú "chưa có sơ đồ".

---

### 11. Tôi có thể xem một ý tưởng mẫu hoàn chỉnh trông ra sao không?

**Có**. Trong thư mục `examples/` của plugin có sẵn một ý tưởng mẫu hoàn chỉnh về chuỗi thời trang áp dụng chương trình gửi tin nhắn kéo khách cũ quay lại.

Bạn có thể gõ `/vibebiz:help` và hỏi: *"Cho tôi xem ý tưởng mẫu"*, vibebiz sẽ giới thiệu ý tưởng mẫu để bạn hình dung kết quả đầu ra thực tế.

### 12. Tôi dùng được vibebiz trên Cowork bản web hoặc điện thoại không?

Được, từ bản 0.1.2, nếu bạn nối Google Drive. Các bản trước chỉ chạy trong ứng dụng Claude trên máy tính, với một thư mục đang mở. Phiên Cowork mở từ web hay điện thoại chạy trên máy chủ, nên không mở được thư mục trên máy tính của bạn. Khi đó vibebiz lưu ý tưởng vào một thư mục trong Google Drive của chính bạn, với cùng cấu trúc tệp như trên máy.

Cách nối: trong Cowork, mở phần kết nối (Connectors), chọn Google Drive và đăng nhập tài khoản Google của bạn. Lần đầu, vibebiz hỏi bạn muốn dùng thư mục Drive nào. Từ đó, trên web và điện thoại bạn đều làm việc với cùng thư mục ấy; trên máy tính cũng vậy, nếu bạn không mở thư mục nào trên máy.

Một vài điều cần biết:
- Bạn có thể bắt đầu một ý tưởng trên điện thoại rồi làm tiếp trên web, hoặc ngược lại: vibebiz tự tìm lại thư mục Drive của bạn, kể cả khi bạn đã đổi tên thư mục, và không hỏi lại. Chỉ khi Drive có từ hai thư mục ý tưởng trở lên, vibebiz mới hỏi bạn dùng thư mục nào.
- Trên máy tính, nếu bạn đã mở một thư mục thì vibebiz luôn lưu vào thư mục đó và không lưu gì vào Drive. Hai nơi không tự đồng bộ với nhau.
- Thư mục Drive chỉ mình bạn xem được, trừ khi chính bạn chia sẻ. vibebiz không bao giờ chia sẻ hay đổi quyền xem của tệp nào; nếu thấy thư mục đang được chia sẻ, vibebiz báo cho bạn biết trước khi ghi.
- Bản trình bày cho ban lãnh đạo và bản PRD cho đội kỹ thuật được đăng thành Artifact riêng tư, hoặc nếu bạn chọn, thành Google Slides và Docs riêng tư; hai bản xem dạng trang web (`board-deck.html`, `tech-prd.html`) không được lưu vào Drive.

Nếu chưa nối Drive và cũng chưa mở thư mục nào, vibebiz không ghi gì và chỉ cho bạn hai cách: nối Google Drive, hoặc mở ứng dụng Claude trên máy tính, vào Cowork và chọn một thư mục.
