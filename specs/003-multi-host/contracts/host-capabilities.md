# Contract: Host capabilities

| Capability | Cowork desktop | Cowork web or phone | Claude Code | Codex | Antigravity |
| --- | --- | --- | --- | --- | --- |
| Local folder workspace | yes | no | yes | yes | yes |
| Google Drive workspace | when no folder is open | yes | no | no | no |
| Board and tech views as local HTML | yes | no | yes | yes | yes |
| Private Artifacts | yes | yes | no | no | no |
| Google Slides and Docs | yes | yes | no | no | no |
| Question tool | `AskUserQuestion` | `AskUserQuestion` | `AskUserQuestion` | `request_user_input` | `ask_question` |
| Install | `vibebiz.plugin` or a marketplace | same account sync | catalog `vibebiz@finolabs` | catalog `vibebiz@finolabs` | `agy plugin install` with the repository URL |

"no" for Drive, Artifacts and Slides/Docs means the host session has no such tool. vibebiz decides by the tools the session actually has, not by the host's name; the table is what to expect.

## Behavior on a host without a feature

- **No folder open, no Drive tool**: the entry skill writes nothing and gives the "Neither" message. On a non-Cowork host the message tells the user to open a folder and run the command again, and says that keeping ideas in Google Drive works in Claude Cowork.
- **Artifacts or Slides/Docs asked for, not available**: `package` says these are Cowork features and offers to write `board-deck.html` and `tech-prd.html` in the idea's `exports/`; it writes them only after the user agrees, or at once if the user's request was simply to package.
- **Drive mode asked for, not available**: as "No folder open"; an open local folder is used as usual.

## Questions

`core/ask-protocol.md` refers to "the host's question tool". vibebiz's own limits stay (one to four questions per round, two to four options, recommended first, no "None"/"Other"). When the host's tool takes fewer questions per call, send the round in several calls; when there is no question tool, ask in plain text with numbered options. The measured limits of `request_user_input` and `ask_question` are recorded at the first install run and copied into this table.
