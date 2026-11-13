---
type: llm
focus: 'last_message'
---

The session simulates claude.ai chat with no working folder and no Google Drive connector. PASS if the final message tells the user, in Vietnamese and plain words, that nothing was saved and how to go on: open the Claude desktop app, go to Cowork and choose a working folder, or use Cowork with Google Drive connected. It must name the desktop app (not just "open Cowork") and do nothing else: no interview, no questions about the idea, no draft requirement.
FAIL if it starts interviewing, drafts a requirement, claims to have created files, or only says "open Cowork" without naming the desktop app.
