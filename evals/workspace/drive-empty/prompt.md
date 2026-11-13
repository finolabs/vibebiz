---
description: 'Web, empty Drive: idea creates the contract layout in a new Drive folder as plain files, and the user''s own file is left unchanged (spec 002 US1; the FR-008 save-before-question order is not gradable headless).'
max_turns: 40
timeout_seconds: 900
allowed_tools: [Skill, Read, Glob, Grep, AskUserQuestion, 'mcp__plugin_vibebiz_google-drive__*']
plugins: ["../../../dist/vibebiz-fakedrive"]
tags: [workspace, drive, us1, drive-write]
append_system_prompt: "This session is Claude Cowork started on the web (or the phone app): it runs on Anthropic's servers and has no working folder on the user's computer. The Google Drive connector is connected; its tools are the google-drive tools you have. Treat the current directory as the server's scratch space, not a folder the user chose. Claude Artifacts are not available in this session. Treat this as the real situation."
---
/vibebiz:idea Tao muốn có cái công cụ báo cho nhân viên cửa hàng khi một size bán chạy sắp hết hàng, để đặt bổ sung kịp. Đặt tên ý tưởng là "Báo sắp hết size". Nếu phải chọn thư mục Drive thì tạo thư mục mới tên "vibebiz" ở thư mục gốc của Drive. Đây là lần chạy không người trả lời: công cụ hỏi có thể không nhận được câu trả lời nào. Cứ hiện vòng câu hỏi như bình thường; không tự bịa câu trả lời thay tôi.
