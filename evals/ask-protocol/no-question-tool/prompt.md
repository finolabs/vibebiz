---
description: 'Host without a question tool, user present (spec 003 FR-010): the next round in plain text with numbered choices, at most four, not an unattended run.'
max_turns: 25
timeout_seconds: 600
allowed_tools: [Skill, Read, Write, Edit, Glob, Grep]
plugins: ["../../../dist/vibebiz"]
tags: [ask-protocol, spec003, host-limits]
append_system_prompt: 'This host has no question tool: there is no AskUserQuestion or similar tool in this session. The user is present, reads your messages and replies in chat. Treat this as the real situation.'
---
Tiếp tục ý tưởng "Nhắc khách quay lại". Hỏi tôi vòng tiếp theo, tôi đang ngồi đây trả lời.
