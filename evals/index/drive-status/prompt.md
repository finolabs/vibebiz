---
description: 'status in Drive mode answers from index.json and coverage.md and writes no file; the table of contents is the chat table (spec 002 US2).'
max_turns: 40
timeout_seconds: 900
allowed_tools: [Skill, Read, Glob, Grep, AskUserQuestion, 'mcp__plugin_vibebiz_google-drive__*']
plugins: ["../../../dist/vibebiz-fakedrive"]
tags: [index, drive, us2]
append_system_prompt: "This session is Claude Cowork started on the web (or the phone app): it runs on Anthropic's servers and has no working folder on the user's computer. The Google Drive connector is connected; its tools are the google-drive tools you have. Treat the current directory as the server's scratch space, not a folder the user chose. Claude Artifacts are not available in this session. Treat this as the real situation."
---
/vibebiz:status
