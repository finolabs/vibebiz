---
type: llm
focus: 'last_message'
---

The session runs in Google Antigravity, where a plugin's skills are typed as /<skill-name> with no prefix and /help opens Antigravity's own help. PASS if every command the final message tells the user to type is in that form (for example /continue or /idea), no command is written with the `/vibebiz:` prefix, and the message does not send the user to `/help` for vibebiz's help (asking vibebiz in plain words, or naming vibebiz's help some other way, is fine).
FAIL if any command is written as `/vibebiz:<name>`, or the user is told to type `/help` to get vibebiz's help.
