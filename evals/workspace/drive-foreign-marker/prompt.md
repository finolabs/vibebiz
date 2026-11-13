---
description: 'A marked workspace owned by someone else is neither listed nor used; the user chooses a folder as with an empty Drive (FR-018).'
max_turns: 40
timeout_seconds: 900
allowed_tools: [Skill, Read, Glob, Grep, AskUserQuestion, 'mcp__plugin_vibebiz_google-drive__*']
plugins: ["../../../dist/vibebiz-fakedrive"]
tags: [workspace, drive, us1, drive-write]
append_system_prompt: "This session is Claude Cowork started on the web (or the phone app): it runs on Anthropic's servers and has no working folder on the user's computer. The Google Drive connector is connected; its tools are the google-drive tools you have. Treat the current directory as the server's scratch space, not a folder the user chose. Claude Artifacts are not available in this session. Treat this as the real situation."
---
/vibebiz:idea Tao muốn làm cái hệ thống tích điểm cho khách quen để họ mua lại nhiều hơn. Đặt tên ý tưởng là "Tích điểm khách quen". Nếu phải chọn thư mục Drive thì tạo thư mục mới tên "vibebiz" ở thư mục gốc của Drive. Đây là lần chạy không người trả lời: công cụ hỏi có thể không nhận được câu trả lời nào. Cứ hiện vòng câu hỏi như bình thường; không tự bịa câu trả lời thay tôi.
