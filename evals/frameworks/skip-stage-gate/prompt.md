---
description: 'Stage-gate not chosen at packaging: nothing is tested yet and nobody knows whether customers will use the service, so a test against a control group comes before planning rollout waves.'
max_turns: 30
timeout_seconds: 900
allowed_tools: [Skill, Read, Write, Edit, Glob, Grep, AskUserQuestion]
plugins: ["../../../dist/vibebiz"]
tags: [frameworks, us4, suite10, spec004]
---
Đóng gói bản nháp ý tưởng "Tư vấn phối đồ qua video cho khách online" để trình hội đồng. Chưa ai biết khách có chịu dùng không; ban giám đốc muốn biết làm sao để thấy dịch vụ có tác dụng trước khi bỏ nhiều tiền. Chọn dạng Artifact cho cả bản hội đồng và bản kỹ thuật; nếu phiên này không đăng được Artifact, cứ giữ các tệp HTML trong thư mục exports của ý tưởng. Đây là lần chạy không người trả lời thêm: công cụ hỏi có thể không nhận được câu trả lời nào, cứ hiện câu hỏi như bình thường và không tự bịa câu trả lời thay tôi.
