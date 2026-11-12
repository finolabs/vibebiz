# Eval results

One row per recorded run. Thresholds come from spec 001 Appendix I; `build` is the `dist/vibebiz/` build (commit SHA plus plugin version). Raw run output stays under `evals/results/` (git-ignored); only the summary goes here.

| Suite | Date | Build | Result | Threshold | Notes |
|---|---|---|---|---|---|
| Triggers (plugin-packaging) | 2026-11-13 | 282b32b 0.1.0 | 7/7 passed (6 skills fire on a plain-words prompt, none fires on an unrelated one) | 100% | sonnet, 1 run per case, 0.62 USD |
| Suites 1, 4, 5, 6, US6 (32 cases) | 2026-11-13 | 2ed37a5 0.1.0 | Not valid: 5/32 passed, run without write access, and 59 graders used Python-only regex flags | see Appendix I | sonnet, 1 run, 10.93 USD; harness fixed in the next commits |
| Six representative cases, rerun with write access | 2026-11-13 | 2ed37a5 0.1.0 | empty-folder and vague-terms/vi-accurate pass; routing/contradiction-supersede 0.8 (did not ask before superseding); speckit-compat/snapshot-structure 0.89 (snapshot not a byte copy); ground-rules and package failed on grader regexes, since fixed | see Appendix I | sonnet, 1 run, about 4 USD |
| package/ready-data-json-passes-check after fixture fix | 2026-11-13 | 2ed37a5 0.1.0 | 0.62: data.json, links, snapshot written; the two HTML views not written, because retyping a 100 KB template is not feasible without a shell; core/package.md now splices with a one-off command when a shell exists. A Bash-enabled eval cannot run on this machine; verify in the Cowork smoke test | 100% | sonnet, 1 run, 1.31 USD. The skill also caught two real fixture errors (monthly loss 99 vs 57 million; high case above the ceiling), now fixed |
