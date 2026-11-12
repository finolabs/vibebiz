# vibebiz evals

Development tooling. Nothing here ships: the build excludes `evals/` from `dist/vibebiz/`.

The suites run with `claude plugin eval` ([plugin evals documentation](https://code.claude.com/docs/en/plugin-evals.md)) against the built plugin in `dist/vibebiz/`. Thresholds are those of spec 001 Appendix I.

## Suites

| # | Suite | Folder | Threshold |
|---|---|---|---|
| 1 | Routing | `evals/routing/` | 100% |
| 2 | Question protocol | `evals/ask-protocol/` (code grader `scripts/checks/round_rules.py`) | 100%, checked in code |
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
