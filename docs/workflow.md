# vibebiz hỏi ý tưởng của bạn như thế nào

Trang này giải thích cặn kẽ cách vibebiz đào sâu một ý tưởng: 15 điểm cần làm rõ, cây phụ thuộc giữa các câu hỏi, bốn góc nhìn tư duy, các phương pháp quản trị có sẵn và cách vibebiz quyết định hỏi sâu hay hỏi nhanh.

Bạn không bắt buộc phải đọc trang này để sử dụng vibebiz. Khi bắt đầu bằng `/vibebiz:new` hoặc tiếp tục bằng `/vibebiz:continue`, vibebiz sẽ tự động tính toán và chọn câu hỏi thích hợp nhất. Trang này dành cho lúc bạn muốn hiểu nguyên lý vì sao vibebiz lại đặt ra những câu hỏi đó.

Hành trình toàn diện của một ý tưởng từ khởi tạo, các vòng phỏng vấn làm rõ, đóng gói tài liệu đến cập nhật kết quả thẩm định và phê duyệt của ban lãnh đạo.

---

## 15 điểm cần làm rõ của một ý tưởng

Mỗi ý tưởng khi hoàn thiện cần trả lời 15 điểm cốt lõi (từ A đến O). Các điểm này không được hỏi ngẫu nhiên hay theo thứ tự bảng chữ cái, mà tuân theo **cây phụ thuộc**: một điểm chỉ được hỏi khi những điểm làm nền tảng cho nó đã được làm rõ hoặc được bạn chủ động tạm hoãn có lý do.

Cây phụ thuộc giữa 15 điểm từ A đến O: một điểm chỉ được hỏi khi các điểm điều kiện tiên quyết của nó đã được làm rõ hoặc hoãn lại có lý do.

| Mã | Điểm cần làm rõ | Cần rõ trước điểm nào | Góc nhìn phụ trách |
|---|---|---|---|
| A | Vấn đề và lý do: ai gặp khó khăn, tình huống thật, tần suất, chi phí hiện tại, nguyên nhân gốc | Không cần | Vấn đề |
| B | Người dùng và các bên liên quan: ai trực tiếp dùng, ai bị ảnh hưởng, ai phê duyệt, ai có thể phản đối | A | Vấn đề |
| C | Kết quả mong muốn và cách đo: mốc hiện tại, mục tiêu, thời hạn, chỉ số bảo vệ, ngưỡng dừng | A | Kết quả |
| D | Các phương án khác: không làm gì, sửa quy trình, mua sẵn, tự làm | A, C | Phản biện |
| E | Phạm vi và cách hoạt động: các luồng trải nghiệm chính, việc gì nằm ngoài phạm vi | C, D | Phác thảo giải pháp |
| F | Có cần AI hay không: quy tắc, tự động hóa hay AI; dữ liệu sẵn có; thiệt hại nếu AI sai; điểm người duyệt | E | Phác thảo giải pháp |
| G | Dữ liệu và thông tin: nguồn dữ liệu, chất lượng dữ liệu, quyền sở hữu dữ liệu | E | Hỏi trực tiếp |
| H | Kết nối hệ thống: máy bán hàng (POS), ERP, sàn thương mại điện tử, ứng dụng nhắn tin, đơn vị vận chuyển | E, G | Hỏi trực tiếp |
| I | Yêu cầu vận hành bằng lời thường: lượng người dùng, giờ cao điểm, mạng cửa hàng, thiết bị | E | Phác thảo giải pháp |
| J | Tình huống ngoại lệ và lỗi: khi mạng mất, dữ liệu sai, khách đổi ý thì xử lý thế nào | E | Phác thảo giải pháp |
| K | Rủi ro và tuân thủ: bảo vệ dữ liệu cá nhân, đăng ký chương trình khuyến mại, luật lao động | E, G | Phản biện |
| L | Thay đổi trong tổ chức: đào tạo nhân viên, KPI thay đổi, ai mất quyền hoặc thay đổi công việc | B, E | Phác thảo giải pháp |
| M | Chi phí, nguồn lực và lợi ích: quy mô S/M/L, ba kịch bản thấp - cơ sở - cao | C, D, E | Phản biện & Kế hoạch |
| N | Thuật ngữ: các từ ngữ đặc thù trong doanh nghiệp cần định nghĩa thống nhất | Không cần | Hỏi trực tiếp |
| O | Dấu hiệu hoàn thành: các tiêu chí chấp nhận cụ thể, kiểm tra được bằng con số | C, E | Kết quả |

---

## Vòng lặp định tuyến câu hỏi

Trong mỗi phiên làm việc, vibebiz vận hành theo một vòng lặp tự động khép kín để chọn ra câu hỏi đắt giá nhất:

Vòng lặp định tuyến của vibebiz: tính toán biên câu hỏi từ các điểm còn thiếu, chọn góc nhìn và phương pháp thích hợp, gửi vòng câu hỏi trắc nghiệm, rồi ghi nhận câu trả lời vào tệp ngay lập tức.

1. **Rà soát độ phủ**: Kiểm tra xem trong 15 điểm, điểm nào đã rõ (`clear`), điểm nào mới rõ một phần (`partial`), điểm nào còn thiếu (`missing`) và điểm nào tạm hoãn (`deferred`).
2. **Tính toán biên câu hỏi (Frontier)**: Lọc ra tập hợp các điểm chưa rõ nhưng *đã thỏa mãn toàn bộ điều kiện tiên quyết*. vibebiz không bao giờ hỏi về chi phí hay công nghệ khi bài toán kinh doanh hoặc kết quả đo lường còn chưa được xác định.
3. **Xếp thứ tự ưu tiên**: Trong các điểm đủ điều kiện hỏi, điểm nào có điểm số **Mức độ tác động × Độ bất định** cao nhất sẽ được hỏi trước:
   - *Mức độ tác động* (1: thấp, 2: vừa, 3: cao): câu trả lời sẽ làm thay đổi phạm vi, ngân sách hay quyết định của ban lãnh đạo nhiều đến mức nào.
   - *Độ bất định* (1: đã rõ phần nào, 2: biết một phần, 3: hoàn toàn chưa rõ).
4. **Tự tra cứu trước khi hỏi**: vibebiz tìm kiếm trong các tệp của thư mục làm việc hoặc tài liệu đính kèm trước; nếu đã có số liệu, vibebiz dùng luôn số liệu đó và chỉ hỏi bạn quyết định lựa chọn.
5. **Gửi vòng câu hỏi và ghi nhận**: Hỏi tối đa 4 câu qua công cụ trắc nghiệm. Nhận câu trả lời, ghi ngay vào hồ sơ ý tưởng và cập nhật trạng thái tiến độ.

---

## Bốn góc nhìn tư duy

vibebiz chia việc đào sâu ý tưởng thành bốn góc nhìn tư duy chuyên biệt, giúp người làm kinh doanh không bị thiên vị hay bỏ sót góc khuất:

Mối liên hệ giữa bốn góc nhìn tư duy và các nhóm điểm cần làm rõ trong hồ sơ ý tưởng.

| Góc nhìn | vibebiz tìm hiểu điều gì | Điểm phụ trách |
|---|---|---|
| **Vấn đề** | Lần gần nhất chuyện này xảy ra, nguyên nhân gốc rễ, ai chịu ảnh hưởng, hiện tại đang tốn bao nhiêu tiền/giờ; gói gọn thành một câu nêu vấn đề duy nhất | A, B |
| **Kết quả** | Biến mong muốn trừu tượng thành con số đo lường cụ thể: mốc hiện tại, mục tiêu kỳ vọng, thời hạn, các chỉ số không được phép suy giảm (guardrail), và ngưỡng dừng lỗ/dừng dự án (kill criteria). Nếu chưa có số đo hiện tại, vibebiz yêu cầu lập kế hoạch đo lường trước | C, O |
| **Phản biện** | Ý tưởng có thể thất bại vì đâu, niềm tin ngầm nào chưa được kiểm chứng, cái giá của việc không làm gì, sửa quy trình hoặc mua sẵn có tốt hơn tự làm không, cách thử nghiệm nhỏ trước khi chi tiền lớn | D, K, một phần M |
| **Phác thảo giải pháp** | Hành trình trước và sau khi có giải pháp, phần nào cần AI và phần nào chỉ cần quy tắc nghiệp vụ/tự động hóa, phiên bản đầu tiên tự đứng độc lập mang lại giá trị là gì, tình huống lỗi, sự thay đổi công việc của nhân sự | E, F, I, J, L |

### Phản biện thẳng thắn, không nịnh bợ

Góc phản biện là đặc sản của vibebiz:
- vibebiz **không bao giờ khen ngợi** ý tưởng để làm hài lòng người dùng.
- Mỗi vòng có câu hỏi phản biện luôn đưa ra **ít nhất một lý do cụ thể vì sao ý tưởng có thể thất bại**.
- vibebiz luôn đặt lên bàn cân ba phương án thay thế trước khi chấp nhận phương án tự xây dựng:
  Bốn phương án cân nhắc trước khi quyết định tự làm: không làm gì, sửa quy trình thủ công, mua phần mềm có sẵn, hoặc tự xây dựng hệ thống mới.
- Nếu bạn quyết định bỏ qua một rủi ro được cảnh báo, vibebiz tôn trọng quyết định của bạn nhưng sẽ **ghi lại rủi ro bị bỏ qua** kèm lý do của bạn vào tệp `decisions.md` để ban lãnh đạo nắm được khi xem xét.

### Đánh giá mức độ phù hợp với AI

Nếu ý tưởng có nhắc tới AI, vibebiz sử dụng cây quyết định để đánh giá khách quan:

Cây quyết định mức độ phù hợp với AI: phân biệt rõ ràng khi nào chỉ cần quy tắc nghiệp vụ, khi nào cần tự động hóa quy trình, và khi nào thực sự cần tới trí tuệ nhân tạo.

- Liệu một quy tắc nghiệp vụ đơn giản (If-Else) hay tự động hóa phần mềm thông thường có giải quyết được không?
- Dữ liệu lịch sử có sẵn và đủ sạch để huấn luyện hoặc làm ngữ cảnh cho AI không?
- Khi AI đưa ra kết quả sai (ảo giác, nhầm lẫn), chi phí thiệt hại là bao nhiêu?
- Điểm chốt chặn nào bắt buộc phải có con người phê duyệt trước khi hành động được thực thi?

---

## Các phương pháp quản trị có sẵn

vibebiz tích hợp sẵn 15 phương pháp quản trị kinh điển, được chọn lọc kỹ cho ngành bán lẻ thời trang. Mỗi phương pháp chỉ được dùng khi nó giúp làm rõ một điểm còn thiếu trên cây phụ thuộc, và mỗi góc nhìn dùng tối đa hai phương pháp cho một ý tưởng.

Bạn không cần phải học thuộc các phương pháp này: vibebiz sẽ đặt câu hỏi bằng ngôn ngữ kinh doanh thông thường, sau đó ghi nhận tên phương pháp và kết quả trên các trang tài liệu.

| Góc nhìn | Phương pháp | Nguồn gốc | Dùng để làm gì |
|---|---|---|---|
| Vấn đề | **5 Whys** (Hỏi 5 lần vì sao) | Sakichi Toyoda / Hệ thống sản xuất Toyota | Tách triệu chứng bề mặt ("doanh số sụt giảm") khỏi nguyên nhân gốc (đứt size, giao hàng trễ, sai cơ cấu mẫu) |
| Vấn đề | **Fishbone** (Sơ đồ xương cá) | Kaoru Ishikawa | Phân tích các vấn đề vận hành phức tạp có nhiều nguyên nhân đan xen (tồn kho, tỷ lệ trả hàng, phòng thử đồ quá tải) |
| Vấn đề | **Jobs to be done** | Clayton Christensen | Tìm hiểu việc thật sự mà khách hàng và nhân viên cửa hàng đang cần hoàn thành |
| Kết quả | **Driver tree** (Cây chỉ số) | Phân tích quản trị kinh doanh | Bẻ nhỏ doanh thu thành: Lượt khách × Tỷ lệ mua × Số món/đơn × Giá bình quân để biết can thiệp vào mắt xích nào |
| Kết quả | **Balanced Scorecard** | Robert Kaplan & David Norton | Gắn kết quả của ý tưởng với 4 góc nhìn chiến lược: tài chính, khách hàng, quy trình nội bộ, học hỏi và phát triển |
| Phản biện | **SWOT** | Albert Humphrey / Stanford | Đặt điểm yếu nội bộ và mối đe dọa thị trường lên trang giấy một cách minh bạch |
| Phản biện | **Pre-mortem** (Giả định thất bại) | Gary Klein | Tưởng tượng dự án đã thất bại hoàn toàn sau 6 tháng để tìm ra nguyên nhân tiềm ẩn trước khi chi tiền |
| Phản biện | **Assumption map** (Bản đồ giả định) | David Bland & Alexander Osterwalder | Phân loại các niềm tin ngầm theo mức độ quan trọng và mức độ đã kiểm chứng để tìm ra giả định rủi ro nhất |
| Phản biện | **Thử nghiệm có nhóm đối chứng** | Phương pháp luận khoa học bán lẻ | Thử nghiệm ở vài cửa hàng đại diện so với cửa hàng đối chứng tương đương, đủ thời gian và tránh yếu tố mùa vụ |
| Phác thảo giải pháp | **Hành trình khách hàng & Sơ đồ dịch vụ** | Thiết kế dịch vụ / Service Design | Vẽ rõ trải nghiệm của khách hàng cùng các hoạt động hỗ trợ ở hậu cần và cửa hàng |
| Lập kế hoạch | **4P / 7P** | E. Jerome McCarthy / Booms & Bitner | Rà soát sản phẩm, giá, kênh, khuyến mại, con người, quy trình và cơ sở vật chất |
| Lập kế hoạch | **Tự làm, mua sẵn hay hợp tác (kèm ROI)** | Phân tích đầu tư tài chính | So sánh bài toán kinh tế giữa tự phát triển, mua giải pháp đóng gói hoặc thuê ngoài |
| Lập kế hoạch | **MoSCoW** | Dai Clegg | Phân loại phạm vi bản đầu tiên: Phải có (Must), Nên có (Should), Có thì tốt (Could), Để sau (Won't) |
| Lập kế hoạch | **ADKAR** | Prosci / Jeff Hiatt | Quản trị sự thay đổi: Đảm bảo nhân viên cửa hàng nhận thức, mong muốn, có kỹ năng và thực tế áp dụng quy trình mới |
| Định tuyến | **Cynefin** | Dave Snowden | Xác định độ phức tạp của bài toán để quyết định hỏi nhanh hay hỏi sâu |

### Yêu cầu một phương pháp cụ thể

Bạn hoàn toàn có thể yêu cầu: *"Phân tích SWOT cho ý tưởng này giúp tôi"* hoặc *"Dùng cây chỉ số để bẻ doanh thu"*.
- Nếu phương pháp đó phục vụ đúng một điểm đang còn thiếu trên cây phụ thuộc, vibebiz sẽ áp dụng ngay ở vòng tiếp theo.
- Nếu điểm đó đã được làm rõ hoặc góc nhìn đó đã dùng đủ 2 phương pháp, vibebiz sẽ giải thích lý do ngắn gọn và gợi ý phương pháp phù hợp hơn với phần đang còn khuyết.

---

## Hỏi nhanh hay hỏi sâu (Khung Cynefin)

Không phải ý tưởng nào cũng cần hỏi kỹ như nhau. vibebiz phân loại ý tưởng thành 4 cấp độ phức tạp để điều chỉnh độ sâu phỏng vấn:

| Loại tình huống | Dấu hiệu nhận biết | Cách vibebiz xử lý |
|---|---|---|
| **Rõ ràng (Clear)** | Đã biết rõ nguyên nhân và cách làm, nơi khác đã làm thành công, chi phí thấp. Ví dụ: thêm trường thông tin vào báo cáo ca | Phỏng vấn theo luồng nhanh, chỉ hỏi những điểm còn thiếu, mỗi điểm thường 1 câu, không dùng thêm phương pháp phức tạp |
| **Cần phân tích (Complicated)** | Có giải pháp đúng nhưng đòi hỏi phân tích số liệu hoặc ý kiến chuyên gia. Ví dụ: chọn giải pháp đối soát tiền COD vận chuyển | Phỏng vấn đầy đủ 4 góc nhìn, áp dụng các phương pháp phân tích bài bản |
| **Khó đoán trước (Complex)** | Kết quả phụ thuộc vào hành vi con người (khách hàng, nhân viên), không thể tính trước trên giấy. Ví dụ: trợ lý AI tư vấn phối đồ | Phỏng vấn kỹ lưỡng, tập trung vào thiết kế thử nghiệm nhỏ có đối chứng và xác định ngưỡng dừng dự án |
| **Khủng hoảng (Chaotic)** | Đang có sự cố gây thiệt hại khẩn cấp. Ví dụ: lỗi hệ thống khiến toàn chuỗi cửa hàng không quét được mã thanh toán | Khuyên bạn tập trung dập tắt sự cố trước, ghi nhận lại ý tưởng ban đầu và tạm dừng phỏng vấn cho tới khi vận hành ổn định |

---

## Tiêu chuẩn sẵn sàng đóng gói (Definition of Ready)

vibebiz chỉ đề xuất đóng gói chính thức khi ý tưởng đạt chuẩn:
1. **Bốn điểm cốt lõi phải Rõ ràng (Clear)**: Vấn đề (A), Kết quả mong muốn (C), Phương án cân nhắc (D), và Phạm vi giải pháp (E).
2. **Nếu có AI**: Điểm phù hợp với AI (F) bắt buộc phải Rõ ràng.
3. **Chi phí và nguồn lực (M)**: Ít nhất phải có ước lượng quy mô (S, M hoặc L).
4. **Các điểm còn lại**: Đã Rõ ràng hoặc Tạm hoãn có ghi rõ lý do.

Nếu chưa đạt chuẩn mà bạn cần tài liệu gấp, vibebiz sẽ xuất **Bản nháp (Draft)** với mọi vị trí chưa hoàn thiện được gắn nhãn rõ ràng là "chưa làm rõ".
