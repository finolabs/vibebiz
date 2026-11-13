---
description: 'Control: numbers given, no vague term, no redundant question.'
max_turns: 25
timeout_seconds: 600
allowed_tools: [Skill, Read, Write, Edit, Glob, Grep, AskUserQuestion]
plugins: ["../../../dist/vibebiz"]
tags: [vague-terms, us1, suite4]
---
Tiếp tục ý tưởng "Nhắc khách quay lại". Yêu cầu của tôi: gợi ý size phải hiện ra trong vòng 3 giây ở 95% lượt xem, cho tối đa 500 khách cùng lúc vào giờ cao điểm. Hãy ghi lại. Đây là lần chạy không người trả lời: công cụ hỏi có thể không nhận được câu trả lời nào. Cứ hiện vòng câu hỏi như bình thường; không tự bịa câu trả lời thay tôi.
