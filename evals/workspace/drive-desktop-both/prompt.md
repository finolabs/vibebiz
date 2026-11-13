---
description: 'Desktop with a local folder and Google Drive connected: the local folder wins, nothing goes to Drive (spec 002 US5).'
max_turns: 25
timeout_seconds: 600
allowed_tools: [Skill, Read, Write, Edit, Glob, Grep, AskUserQuestion, 'mcp__plugin_vibebiz_google-drive__*']
plugins: ["../../../dist/vibebiz-fakedrive"]
tags: [workspace, drive, us5, drive-write]
append_system_prompt: "This session is Cowork in the Claude desktop app, and the user chose the current directory as the working folder; it is empty apart from hidden files. The Google Drive connector is also connected. Treat this as the real situation."
---
Tao có ý tưởng này: Tao muốn làm cái hệ thống tích điểm cho khách quen để họ mua lại nhiều hơn. Đặt tên ý tưởng là "Nhắc khách quay lại". Đây là lần chạy không người trả lời: công cụ hỏi có thể không nhận được câu trả lời nào. Cứ hiện vòng câu hỏi như bình thường; không tự bịa câu trả lời thay tôi.
