---
type: llm
focus: 'trace'
---

The transcript is a vibebiz run on a fake Google Drive. PASS if, every time the assistant calls AskUserQuestion after the first round, the idea's coverage.md (and the answers of the round before) were already written to Drive with a create_file call earlier in the transcript, and if the user is shown a table of contents of the workspace (an Artifact link or a short table in chat). FAIL if a round of questions is asked while the previous round's answers exist only in chat, or if no table of contents is shown.
