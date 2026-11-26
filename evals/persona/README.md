# Suite 8: simulated sessions

Development tooling (spec 001 T097). An Agent SDK harness, not `claude plugin eval`: it answers the question tool live.

- `run.py` builds the plugin, runs `/vibebiz:idea` with a fixture's `intake_vi` in a fresh temporary workspace, and answers every `AskUserQuestion` through `can_use_tool` with a persona model (impatient, non-technical, Vietnamese) that knows only the fixture's `key_facts` and `answers`. A plain-text question gets a persona reply as the next user turn. A turn that stops with no question and no budget pause gets one persona reply per session (`turns.py`), because an impatient user who wants to finish tells it to go on. The persona gives its prepared answer in its own words when no option says the same, and never picks an option that defers to someone else when its facts answer the question. At the budget offer (ask-protocol section 8) the harness picks the option vibebiz recommends, never the draft (Fio, 27/11/2026); a pause ends the session and the next one starts with `/vibebiz:continue`. A session that reaches `--session-cost` or `--max-turns` ends there and the run goes on to the next session. A figure the fixture holds (how many, how much, what share) is given, never handed to someone else; a figure it lacks is a fixture gap. Readiness stays strict: a category waiting on someone else's answer is not ready. The run stops when `coverage.md` meets the readiness rule (core/router.md "Readiness"), after four sessions, or at the cost cap.
- `score.py` (stdlib only) scores the workspace: readiness, and the share of key facts preserved in the idea's `spec.md`. A fact with numbers is checked in code (each quantity, normalized by kind: percent, VND, days, hours, count); a fact without numbers goes to a judge model, in development only, or stays unscored with `--no-judge`.
- Output: `evals/results/persona-<fixture>-<time>.json` (git-ignored) with the idea folder beside it, and one summary line, written even when the harness fails mid-run. A persona or judge reply that is not JSON counts as a skip (`persona_errors`, `judge_error`). No new session starts with under 0.05 USD of the run's cap left, the cap counts persona calls inside a turn, and the judge is skipped once the cap is reached. A run passes only when no fact is left unscored.

The agent uses the signed-in Claude Code account of the default config folder: the CLI finds that sign-in in the macOS keychain under `USER`, which the heavy-job lock drops unless passed (`--pass-env USER`); a `CLAUDE_CONFIG_DIR` pointing at another folder has the same effect ("Not logged in") and must be unset. The harness stops at the first session that returns an error. The settings sources are empty (no personal hooks, plugins or MCP servers load) and only the six vibebiz skills are enabled. Sonnet runs the agent, the persona and the judge by default; `--session-cost` caps each agent session and `--max-cost` the whole run.

```bash
cd evals/persona && uv sync --frozen
```

```bash
python3 -I <delegate skill folder>/scripts/heavy_run.py run --label vibebiz-suite8 --pass-env USER -- uv run --frozen python run.py ../fixtures/fashion-1-loyalty.json
```

```bash
python3 -m unittest discover -s evals/persona -p 'test_*.py' -v
```

`test_run.py` checks the `can_use_tool` decisions with the persona stubbed and needs the harness environment; plain `python3` skips it:

```bash
cd evals/persona && uv run --frozen python -m unittest test_run -v
```
