---
description: 'Cowork on the web with Google Drive connected and no folder: until Phase 4, new gives the §1a "not ready" message, calls no Drive tool and writes nothing (spec 002 Phase 3 stub).'
max_turns: 15
timeout_seconds: 420
allowed_tools: [Skill, Read, Write, Edit, 'mcp__plugin_vibebiz_google-drive__*']
plugins: ["../../../dist/vibebiz-fakedrive"]
tags: [workspace, drive, us4, drive-stub]
append_system_prompt: "This session is Claude Cowork started on the web (or the phone app): it runs on Anthropic's servers and has no working folder on the user's computer. The Google Drive connector is connected; its tools are the google-drive tools you have. Treat the current directory as the server's scratch space, not a folder the user chose. Treat this as the real situation."
---
/vibebiz:new Tao muốn làm cái hệ thống tích điểm cho khách quen để họ mua lại nhiều hơn.
