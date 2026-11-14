---
description: 'Local folder, no Artifact, Slides or Docs tool, user asks for Google Slides (spec 003 FR-006): no Slides call, how to connect Slides here, the HTML views offered.'
max_turns: 40
timeout_seconds: 900
allowed_tools: [Skill, Read, Write, Edit, Glob, Grep, AskUserQuestion]
plugins: ["../../../dist/vibebiz"]
tags: [package, spec003, host-neutral]
append_system_prompt: 'This session runs in Google Antigravity, not in Claude Cowork or the Claude app. There is no Artifact tool and no Google Slides, Google Docs or Google Drive tool or skill in this session. Treat this as the real situation.'
---
Đóng gói ý tưởng "Gợi ý size trên website". Tôi chọn Google Slides cho bản hội đồng. Nếu không làm được thì hỏi tôi, tôi chưa quyết.
