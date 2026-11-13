---
description: 'Solution lens: AI fit records rule/automation/AI, data, error cost and approval points.'
max_turns: 25
timeout_seconds: 600
allowed_tools: [Skill, Read, Write, Edit, Glob, Grep, AskUserQuestion]
plugins: ["../../../dist/vibebiz"]
tags: [lenses, us2, suite10]
---
Tiếp tục ý tưởng "Gợi ý size cho khách". Về phần AI: tôi nghĩ dùng AI. Dữ liệu có là 3 năm lịch sử bán và đổi trả, khoảng 400.000 đơn, có ghi size và lý do đổi. Nếu gợi ý sai size thì khách đổi trả, mỗi lần đổi tốn khoảng 45.000 đồng vận chuyển hai chiều. Gợi ý chỉ hiện cho khách, không tự đặt hàng. Quản lý thương mại điện tử duyệt cách gợi ý trước khi bật, và duyệt lại mỗi quý. Đây là lần chạy không người trả lời thêm: công cụ hỏi có thể không nhận được câu trả lời nào, cứ hiện vòng câu hỏi như bình thường và không tự bịa câu trả lời thay tôi.
