# Module: companions

Offer, once per workspace, to set up a companion that makes the outputs better, and set it up on the user's yes where this host lets the agent do it. A companion is a plugin or connector vibebiz uses but does not ship: diagram-design for diagrams and brand, the Google tools for Slides and Docs. Used by `package` (its sections 4 and 5) and, read only, by `help`.

- **Reads**: the session's own tool and skill list; `companions` in the workspace `constitution.md` frontmatter.
- **Writes** (package only): `companions` in `constitution.md`, nothing else in that file; on a yes, the host's own plugin install for the named companion.
- **Asks through**: `references/core/ask-protocol.md`; the companion question is not counted against the question budget.

Everything the user reads follows `references/core/writing-rules.md`, in the idea's language and address form. Name a companion by what it does ("phần vẽ sơ đồ", "kết nối Google Slides"), and the plugin's name only once, in brackets.

## 1. The companions and how to tell they are present

| Id | What it adds, in one plain sentence | Present in this session when |
|---|---|---|
| `diagram-design` | the diagrams are drawn as pictures instead of tables, in the brand colors and logo of its brand profile | the session lists a skill named `diagram-design` (with or without a `plugin:` prefix) |
| `google` | the board view goes to Google Slides and the tech view to Google Docs, in the user's own Drive | the session has a tool or skill that creates the Google file the user asked for (`references/core/package.md` section 4) |

Present means present in this session's list. An installed plugin that this session has not loaded is not present.

## 2. The record

`companions` is an optional map in the `constitution.md` frontmatter, keyed by companion id, holding the user's answer. It is a working note about this workspace, not a ground rule: the plan, the checklist and analyze ignore it, the `constitution` skill keeps it as it is, and the ground-rules body shows no line for it.

```yaml
companions:
  diagram-design:
    answer: later        # install | later | never
    asked: "2026-11-28"
    reminded: null       # date of the one reminder after "later", or null
```

Re-read `constitution.md` just before writing and change only this key; the rest of the file, its `status` and `updated` stay exactly as they are. Add the key in the place the template's comment shows. A missing `constitution.md` or an unreadable `companions` counts as no record; never recreate the file for this. In Drive mode, replace the file as `references/core/drive-workspace.md` §3 says.

## 3. When to ask

Check each companion the run needs (diagram-design when at least one brief is to be rendered; google when the user asked for Slides or Docs and this session has no tool for it). Follow the first matching row:

| Situation | Do |
|---|---|
| The companion is present | no question and no setup line; leave the record as it is |
| Nobody can answer (an unattended run, an eval without the answer in its prompt) | ask nothing, write nothing, install nothing; keep the one sentence the package module gives for a missing companion |
| The user asked in this session to set it up ("cài phần vẽ sơ đồ giúp tôi") | that request is the yes: record `install` and go to §5 |
| No record | ask the question in §4 |
| `later`, `reminded` is null | one line, no question: the companion is not set up yet, and the user can say "cài giúp tôi" any time to set it up; then set `reminded` to today |
| `later` with a `reminded` date, or `never` | no question and no setup line |
| `install` | one line, no question: it was set up earlier but this session does not have it yet, so open a new session (or finish signing in to Google) and package again |

Without the companion the run goes on as before: tables with "chưa có sơ đồ" and the templates' neutral look, or the other format for that view. The run never waits on a setup.

## 4. The question

Ask one question through the question tool, in its own round, at the moment the package module names. When the google question falls in the same run as package section 4's question about the other format, ask both in one round, that question first.

The question says what the companion adds (§1) in one plain sentence, and that this run goes on with tables or the other format either way. Options, in this order:

1. **"Cài giúp tôi (Đề xuất)"** where §5 gives this host a command the agent runs: "Em cài ngay trong phiên này; ứng dụng có thể hỏi anh/chị cho phép." Where §5 gives only steps for the user, the label is **"Hướng dẫn tôi cài (Đề xuất)"**: "Em chỉ từng bước ngắn, anh/chị tự bấm." For google, add: "Anh/chị tự đăng nhập tài khoản Google."
2. **"Để sau"**: "Lần đóng gói sau em nhắc một dòng, không hỏi lại."
3. **"Không cần"**: "Em không hỏi lại; tài liệu vẫn dùng bảng." (for google: "vẫn dùng bản trên Claude hoặc trang web").

Example, diagram-design on Claude Code: "Bản trình bày đang dùng bảng ở chỗ sơ đồ. Nếu cài thêm phần vẽ sơ đồ (diagram-design), các sơ đồ sẽ hiện thành hình theo màu và logo của công ty. Lần này em vẫn đóng gói bằng bảng. Anh/chị muốn thế nào?"

Record the answer by §2 right away: "Cài giúp tôi" or "Hướng dẫn tôi cài" is `install`, "Để sau" is `later` with `reminded: null`, "Không cần" is `never`; `asked` is today. A skip records nothing, so the next package asks again. Then go to §5 on `install`, otherwise back to the package step.

## 5. Set it up, by host

Set up only the companion the user said yes to, only in this session, and only with the steps below: no other plugin, no marketplace other than the one named, no setting, auto-update or permission change. Run each command on its own and read its result; the host may ask the user to approve it, and a decline is final (`references/core/workspace.md`, top). The host is the app this session runs in, as `references/core/writing-rules.md` "Command names in this host's form" tells it. When a command is not found or fails, stop the setup there: say in one plain sentence that it did not finish and that whoever set up this app for them can add it (`/vibebiz:help` explains how), and try no other way.

**diagram-design** (source: the GitHub repository `cathrynlavery/diagram-design`):

| Host | Steps | Check |
|---|---|---|
| Claude Code | `claude plugin marketplace list`; only when no marketplace named `diagram-design` is listed, `claude plugin marketplace add cathrynlavery/diagram-design`; then `claude plugin install diagram-design@diagram-design` | `claude plugin list` shows `diagram-design@diagram-design` enabled |
| Codex | `codex plugin marketplace list`; only when `diagram-design` is not listed, `codex plugin marketplace add cathrynlavery/diagram-design`; then `codex plugin add diagram-design@diagram-design` | `codex plugin list` shows `diagram-design@diagram-design` installed |
| Antigravity | `agy plugin install https://github.com/cathrynlavery/diagram-design` | `agy plugin list` shows `diagram-design` enabled |
| Cowork | the user's steps: open Customize in the sidebar, then Plugins; choose Add marketplace and enter `cathrynlavery/diagram-design`; find Diagram Design and choose Install. When the organization does not allow adding a marketplace, the administrator adds it | the next package finds it present (§1) |

**google**: the user always signs in to Google themselves; the agent never types an address, password or code for them.

| Host | Steps | Check |
|---|---|---|
| Cowork, Claude Code | the user's steps: connect Google Slides and Google Docs (and Google Drive for a Drive workspace) in the app's Connectors, as `references/core/workspace.md` §1 "Connecting Google on this host" says | the next package finds the tool present (§1) |
| Codex | `codex plugin add google-drive@openai-curated-remote`, then the user signs in to Google in Codex; the plugin covers Drive, Slides and Docs | `codex plugin list` shows `google-drive@openai-curated-remote` installed |
| Antigravity | `agy plugin install gslides@antigravity-plugins-official` for Slides, `agy plugin install gdocs@antigravity-plugins-official` for Docs, only the ones the user asked for; then the user signs in as each plugin's first run asks | `agy plugin list` shows each one enabled |

**After the check**, tell the user in one or two plain sentences what was set up, that it starts working in a new session (Claude Code, Codex and Antigravity load a new plugin there; in Cowork, a new task), and that packaging again there draws the diagrams or writes the Google file. Show no command, path or field name. When the check fails, say it did not finish, as above; the record stays `install`, so the next package says so in one line (§3).

Done when the answer is recorded (or nothing was, on a skip or with nobody to answer), and on a yes the setup was run or its steps given, with its check result told to the user.
