---
description: 'Commands named in the form the host shows (spec 003 T033): on Antigravity /continue, never /vibebiz:continue, and help reached in words, not /help.'
max_turns: 20
timeout_seconds: 900
allowed_tools: [Skill, Read, Write, Edit, Glob, Grep]
plugins: ["../../../dist/vibebiz"]
tags: [routing, spec003, host-neutral]
append_system_prompt: 'This session runs in Google Antigravity, not in Claude Cowork or the Claude app. In this app a plugin''s skills are typed as /<skill-name> with no plugin prefix (for example /idea), and /help opens Antigravity''s own help, not a plugin''s. Treat this as the real situation.'
---
Dùng vibebiz cho tôi xem các ý tưởng của tôi đang ở đâu. Tôi gõ gì để làm tiếp một ý tưởng, và muốn hỏi cách dùng thì làm sao?
