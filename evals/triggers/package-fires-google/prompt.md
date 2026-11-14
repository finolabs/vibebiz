---
description: 'Trigger: package-fires-google'
max_turns: 4
timeout_seconds: 300
allowed_tools: [Skill, Read, Glob, Grep, AskUserQuestion]
plugins: ["../../../dist/vibebiz"]
tags: [triggers]
---
Đóng gói ý tưởng thành bản trình bày Google Slides và tài liệu Google Docs. Đây là lần chạy không người trả lời thêm: công cụ hỏi có thể không nhận được câu trả lời nào, đừng tự bịa câu trả lời thay tôi.
