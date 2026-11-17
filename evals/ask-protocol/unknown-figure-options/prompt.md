---
description: 'Unknown repeat-purchase rate: question options must not supply vibebiz estimates.'
max_turns: 25
timeout_seconds: 600
allowed_tools: [Skill, Read, Write, Edit, Glob, Grep, AskUserQuestion]
plugins: ["../../../dist/vibebiz"]
tags: [ask-protocol, us1, suite2]
---
Tao có ý tưởng nhắc khách cũ quay lại mua ở một cửa hàng thời trang giả định. Đặt tên ý tưởng là "Nhắc khách mua lại". Tao thấy khách mua một lần rồi ít quay lại, nhưng chưa biết tỷ lệ khách mua lại hiện nay, kể cả ước chừng. Chưa có báo cáo hay số liệu nào trong thư mục, cũng không có tài liệu đính kèm hoặc nguồn dữ liệu nào được kết nối. Trước khi bàn mục tiêu, hỏi tao một câu có các lựa chọn về tỷ lệ khách mua lại hiện nay. Cứ hiện câu hỏi như bình thường dù công cụ hỏi trong lần chạy này có thể không nhận được câu trả lời.
