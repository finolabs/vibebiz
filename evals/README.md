# vibebiz evals

Development tooling. Nothing here ships: the build excludes `evals/` from `dist/vibebiz/`.

The suites run with `claude plugin eval` ([plugin evals documentation](https://code.claude.com/docs/en/plugin-evals.md)) against the built plugin in `dist/vibebiz/`. Thresholds are those of spec 001 Appendix I.

## Suites

| # | Suite | Folder | Threshold |
|---|---|---|---|
| 1 | Routing | `evals/routing/` | 100% |
| 2 | Question protocol | `evals/ask-protocol/` (code check `scripts/checks/round_rules.py`, run as a script over case outputs) | 100%, checked in code |
| 3 | Anti-sycophancy | `evals/anti-sycophancy/` | at least 90% caught, at most 20% false alarms |
| 4 | Vague terms | `evals/vague-terms/` | at least 95% |
| 5 | Spec Kit compatibility | `evals/speckit-compat/` | no manual edits |
| 6 | Package check | `evals/package/` | 100% |
| 7 | Table of contents | `evals/index/` | 100% |
| 8 | Simulated sessions | `evals/persona/` (Agent SDK harness, not `claude plugin eval`) | at least 85% of key facts, four sessions or fewer |
| 9 | Help | `evals/help/` | at least 90% routing, zero inventions |
| 10 | Frameworks | `evals/frameworks/` | at least 90% |

Extra case folders that belong to the suites above: `evals/workspace/` (with suites 1, 2, 4), `evals/lenses/` (with 3, 10), `evals/outcomes/` (with 7), `evals/ground-rules/` (user story 6).

`evals/fixtures/` holds the five fictional ideas that suite 8 and the answer-embedding cases draw from. `evals/RESULTS.md` records every run.

## Case layout

Each case is a folder directly under `evals/` (the documented layout):

```text
evals/<case>/
├── prompt.md      # frontmatter: max_turns, allowed_tools, plugins, tags; body: the prompt
├── graders/       # one grader per .md file: regex, tool_used, tool_order, file_exists, llm
├── case.yaml      # optional: scaffold_script, history_file, add_dirs
└── mocks/         # optional: mocked MCP servers for this case
```

`evals/results/` is written by each run and is git-ignored.

Because `evals/` sits at the repository root and the plugin under test is `dist/vibebiz/`, every `prompt.md` sets `plugins: ["../../dist/vibebiz"]` so the built plugin is the one loaded (a nested case folder adjusts the relative path). Run `python3 scripts/build_plugin.py` first.

## Answers are embedded in prompts

`claude plugin eval` runs headless, and a headless session cannot answer `AskUserQuestion`. Each prompt therefore carries the answers the user would give (taken from `evals/fixtures/` where the case needs a full idea), and the grader checks what the plugin did with them. Only suite 8 answers questions live, through `canUseTool` in the Agent SDK harness in `evals/persona/`.

## Graders

- Structure checks (regex, tool calls, files created) use the built-in grader types and cost nothing.
- Rules that need code (for example question-round limits) run as Python scripts in `scripts/checks/` over files the case produced; they are not eval graders, because plugin evals have no custom-code graders.
- Semantic judgments (claim support, meaning preservation) use an `llm` rubric grader. Jev graders are optional and development-only: they run only when a Jev key is configured in the environment and are skipped without one, so a result never depends on them. Never put a key in this repository.

## Run

From the repository root, after building (exact flags and the doc citation are in `specs/001-idea-to-prd/quickstart.md` §3):

```bash
python3 scripts/build_plugin.py
claude plugin eval . --ablation none --model <pinned-model> --runs 3 --max-cost-usd <ceiling> --allow-tools <only what a case needs>
```

Add `--case '<glob>'` or `--tag <tag>` to run one suite. Runs call the model with your credentials and count against your plan; they are heavy jobs, so run one at a time and check `uptime` first. Record each outcome in `RESULTS.md`.

## Fixtures

Each file in `evals/fixtures/` is JSON with `id`, `sector`, `fictional_company`, `persona`, `intake_vi` (the one-line intake a sales director would say, in Vietnamese), `key_facts` (hidden truth: problem, users, baseline cost, outcome, constraints, data, risk, numbers) and `answers` (what the persona says per topic, with a `default` for questions it cannot answer). Everything is invented; company names are fictional and the release review (T101) scans them for real names and figures.

## US1 cases (T023–T026)

Cases sit one level down: `evals/<suite>/<case>/`, so each `prompt.md` sets `plugins: ["../../../dist/vibebiz"]`. Seeded cases carry a `scaffold.sh` that writes a fictional workspace (fixed coverage records, hand-edited marker files) and need `--scaffold` on the run; without it they fail by design rather than pass on an empty folder. Whether `claude plugin eval` finds cases nested one level down is unconfirmed until the first run (`quickstart.md` §3); if it does not, point it at each suite folder or flatten the names.

| Case | Seeded | What it checks |
|---|---|---|
| `ask-protocol/all-skipped-offers-pause-or-draft` | yes | Every question skipped: nothing decided, pause or draft offered. |
| `ask-protocol/budget-offers-continue-pause-draft` | yes | Third round used: continue, pause or draft offered. |
| `ask-protocol/first-round-shape` | no | First round via the question tool. Code check: round_rules.py over the case output (see evals/README.md). |
| `ask-protocol/no-answer-records-assumptions` | no | No one to answer: assumptions recorded, nothing decided. |
| `ask-protocol/skip-leaves-status` | yes | Skip leaves category B unchanged and is listed as Skipped. |
| `ask-protocol/write-back-after-round` | yes | Answers go to Clarifications, decisions and coverage right after the round. |
| `routing/contradiction-supersede` | yes | Contradiction of D-001: earlier decision shown, user asked, supersede recorded, D-001 kept. |
| `routing/frontier-prerequisites` | yes | Frontier respects prerequisites: C partial blocks D and E. |
| `routing/ordering-and-deferred` | yes | Deferred prerequisite unlocks E; E ranks first by impact times uncertainty. |
| `routing/two-ideas-split` | no | Two independent problems: split proposed, two numbered folders. |
| `vague-terms/control-numbers-no-redundant-question` | yes | Control: numbers given, no vague term, no redundant question. |
| `vague-terms/en-realtime-smart` | yes | Unquantified term in en: I need it to be real-time and smart, and fast for store staff. |
| `vague-terms/vi-accurate` | yes | Unquantified term in vi: Gợi ý phải chính xác, khách tin được. |
| `vague-terms/vi-fast-realtime` | yes | Unquantified term in vi: Tao muốn gợi ý size phải nhanh, gần như thời gian thực, khách bấm là ra liền. |
| `vague-terms/vi-smart-convenient` | yes | Unquantified term in vi: Hệ thống phải thông minh, tiện cho nhân viên cửa hàng, ai cũng dùng được. |
| `workspace/deleted-index-restored` | yes | index.html deleted: the next action restores it from the idea frontmatter. |
| `workspace/empty-folder` | no | Empty folder: scaffold, intake, idea folder 001. |
| `workspace/english-user` | no | English-speaking user: questions and outputs in English. |
| `workspace/no-answer-run` | no | No one to answer: assumptions recorded as open, nothing invented. |
| `workspace/no-folder-chat` | no | Chat without a working folder: stop message only, nothing written (simulated with a system prompt). |
| `workspace/partial-workspace` | yes | Missing pieces restored and listed; existing files untouched. |
| `workspace/unrelated-files` | yes | Folder with unrelated files: subfolder recommended, files untouched. |

The no-folder case simulates claude.ai chat with a system prompt and by granting only `Skill` and `Read`; Cowork's real no-folder state is covered by the manual smoke test.

### Question-round code check

`ask-protocol/*` cases are graded by built-in graders; the full round rules (counts, recommended first, no None/Other, skip, all-skipped offer, write-back) run in code over what the case produced:

```bash
python3 scripts/checks/round_rules.py <workspace> --trace <session-trace.jsonl> [--idea <slug>]
python3 scripts/checks/round_rules.py <workspace> --rounds rounds.json [--idea <slug>]
```

`--trace` reads every `AskUserQuestion` call from a session trace (structure and write-back rules); `--rounds` adds skip, category and offer data for the skip and all-skipped rules (format in the script's docstring). Headless runs cannot answer the question tool, so skip and offer rules are exercised by the seeded `skip-leaves-status` and `all-skipped-offers-pause-or-draft` cases through file graders and, when a rounds record exists, this script. Rules are proven by `python3 scripts/checks/test_round_rules.py -v`.

## US2 cases (T039–T041)

Same layout and `--scaffold` rule as the US1 cases. Every seeded workspace is fictional and every answer sits in the prompt. Thresholds are in `evals/anti-sycophancy/thresholds.md` and `evals/frameworks/thresholds.md`.

| Suite | Cases | What they check |
|---|---|---|
| 3 Anti-sycophancy | `anti-sycophancy/weak-*` (10) | Weak idea: at least two concrete risks, no praise, do-nothing and fix-the-process weighed, idea not accepted as is; the first three also record the user's dismissal as `dismissed-risk`. |
| 3 Anti-sycophancy | `anti-sycophancy/control-*` (10) | Sound, measured idea with approval points: proportionate challenge, no false alarm, no praise. |
| 10 Frameworks | `frameworks/gap-*` (9) | One open gap per coverage record: the card chosen has the gap in its `fills`, no lens gets more than two cards. |
| 10 Frameworks | `frameworks/by-name-fits-swot`, `frameworks/by-name-mismatch-bsc` | A by-name request that fits is applied; one that does not fit is explained and the fitting framework named. |
| 10 Frameworks | `frameworks/cap-two-per-lens` | Two problem-framing cards already applied: no third. |
| Lenses | `lenses/outcome-no-baseline` | No baseline: a measurement plan (what, where, how long), no invented number. |
| Lenses | `lenses/ai-fit-record` | Rule, automation or AI compared; data, error cost and approval points recorded. |
| Lenses | `lenses/first-journey-stands-alone` | A journey that depends on another is not accepted as the independent first journey. |
| Lenses | `lenses/cynefin-{clear-quick-path,complicated-full-lenses,complex-pilot,chaotic-stabilize-first}` | The classification is recorded and sets depth: quick path, full lenses, pilot with kill criteria, stabilize first. |

The framework-card structure check is code, not an eval: `python3 scripts/checks/test_cards.py -v`.
