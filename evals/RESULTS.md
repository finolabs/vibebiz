# Eval results

One row per recorded run. Thresholds come from spec 001 Appendix I; `build` is the `dist/vibebiz/` build (commit SHA plus plugin version). Raw run output stays under `evals/results/` (git-ignored); only the summary goes here.

| Suite | Date | Build | Result | Threshold | Notes |
|---|---|---|---|---|---|
| Triggers (plugin-packaging) | 2026-11-13 | 282b32b 0.1.0 | 7/7 passed (6 skills fire on a plain-words prompt, none fires on an unrelated one) | 100% | sonnet, 1 run per case, 0.62 USD |
