---
description: 'Desktop without a folder, Drive connected: a Drive workspace is used, as on the web (spec 002 US5).'
max_turns: 40
timeout_seconds: 900
allowed_tools: [Skill, Read, Glob, Grep, AskUserQuestion, 'mcp__plugin_vibebiz_google-drive__*']
plugins: ["../../../dist/vibebiz-fakedrive"]
tags: [workspace, drive, us5, drive-write]
append_system_prompt: "This session is Cowork in the Claude desktop app, started without choosing a working folder: there is no folder on the user's computer to read or write. The Google Drive connector is connected; its tools are the google-drive tools you have. Treat the current directory as scratch space, not a folder the user chose. Claude Artifacts are not available in this session. Treat this as the real situation."
---
/vibebiz:idea Tao muốn làm cái hệ thống tích điểm cho khách quen để họ mua lại nhiều hơn. Đặt tên ý tưởng là "Tích điểm khách quen". Nếu phải chọn thư mục Drive thì tạo thư mục mới tên "vibebiz" ở thư mục gốc của Drive. Đây là lần chạy không người trả lời: công cụ hỏi có thể không nhận được câu trả lời nào. Cứ hiện vòng câu hỏi như bình thường; không tự bịa câu trả lời thay tôi.
