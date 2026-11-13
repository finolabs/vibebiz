# Contract: Entry Skills

The plugin's only user-facing interface: six skills invoked as `/vibebiz:<name>` or by matching user requests. Every entry skill first checks for a working folder (FR-005); without one it tells the user to open Cowork with a folder and stops. Every skill that writes rebuilds the table of contents (FR-004).

| Skill | Triggers on | Preconditions | Does | Writes | Stops when |
|---|---|---|---|---|---|
| `idea` | "/vibebiz:idea", "I have an idea", "brainstorm", "lên ý tưởng", "I want an app / AI / automation for …" | working folder | Scaffold or repair the workspace by folder state; offer ground rules and the example on first use; intake one open question; create the idea folder; classify Cynefin; start the router loop | workspace files, idea folder, coverage, spec draft | budget reached (offer continue, pause, draft) or readiness met (offer package) |
| `continue` | "/vibebiz:continue", "continue my idea", "the board approved / rejected / wants changes", "tech reviewed the estimate" | an idea exists | Pick the idea (ask if several are open); three-line summary; resume the loop; or record a board outcome or tech review | spec Clarifications, decisions, coverage | same as `idea` |
| `status` | "/vibebiz:status", "where are my ideas" | workspace | List ideas with status, coverage, next step; excludes examples | nothing but the table of contents | after the list |
| `package` | "/vibebiz:package", "make the slides / PRD" | an idea exists | Readiness check (offer draft below it); plan, checklists, analysis; one round for formats; diagram briefs and rendering; build exports from `data.json`; package check; move the previous set to history | plan, checklists, diagrams, exports, links | outputs delivered with links, or a failed check returned to the loop |
| `constitution` | "/vibebiz:constitution", "set our ground rules" | workspace | One round of up to four questions; optional strategy map and OKRs | `constitution.md` | after the round; skippable (deferred) |
| `help` | "/vibebiz:help", "how do I use this", "what next", "what can vibebiz do" | none (works without a workspace for doc questions) | Route a situation to one entry skill and stop; answer from shipped docs with the section; say when docs do not cover it; offer the example | `examples/` only when the user accepts the example | after the answer |

**Routing boundary**: a description of an idea goes to `idea` (or `continue` when it matches an existing idea); a question about using vibebiz goes to `help`. Descriptions of the six skills must state this boundary so they do not trigger on each other's requests.

**Refusals**: no skill shares an output, makes a file public, writes outside the workspace except the user's own Google files it was asked to create, or overwrites a file it did not create in this action.
