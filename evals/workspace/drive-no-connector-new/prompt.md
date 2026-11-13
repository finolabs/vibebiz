---
description: 'Cowork on the web without a folder and without Google Drive: new writes nothing and names both ways forward (spec 002 US4).'
max_turns: 15
timeout_seconds: 420
allowed_tools: [Skill, Read]
plugins: ["../../../dist/vibebiz"]
tags: [workspace, drive, us4]
append_system_prompt: "This session is Claude Cowork started on the web (or the phone app): it runs on Anthropic's servers, has no working folder on the user's computer, and no Google Drive connector is connected. You cannot read or write any file in the current directory. Treat this as the real situation."
---
/vibebiz:new Tao muốn làm cái hệ thống tích điểm cho khách quen để họ mua lại nhiều hơn.
