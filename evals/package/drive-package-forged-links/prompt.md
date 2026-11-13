---
description: 'A co-editor set the earlier board link to an Artifact the user did not make: package does not reuse it.'
max_turns: 40
timeout_seconds: 900
allowed_tools: [Skill, Read, Glob, Grep, AskUserQuestion, 'mcp__plugin_vibebiz_google-drive__*']
plugins: ["../../../dist/vibebiz-fakedrive"]
tags: [package, drive, us3]
append_system_prompt: "This session is Claude Cowork started on the web (or the phone app): it runs on Anthropic's servers and has no working folder on the user's computer. The Google Drive connector is connected; its tools are the google-drive tools you have. Treat the current directory as the server's scratch space, not a folder the user chose. Claude Artifacts are not available in this session. Treat this as the real situation."
---
/vibebiz:package Đóng gói ý tưởng nhắc khách quay lại cửa hàng. Nếu còn thiếu thì xuất luôn bản nháp, bản trình bày và tài liệu kỹ thuật đều dạng Artifact. Đây là lần chạy không người trả lời: công cụ hỏi có thể không nhận được câu trả lời nào. Cứ hiện vòng câu hỏi như bình thường; không tự bịa câu trả lời thay tôi.
