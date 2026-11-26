# Quickstart: validate spec 004

Run from the feature worktree. Check `uptime` first: run one heavy job at a time, at a one-minute load of 25 or less, and never more than two test modules in one command.

## 1. Structure (code)

```bash
python3 -m unittest scripts/checks/test_cards.py scripts/checks/test_build.py
```

Expected:
- all tests pass;
- 41 cards, 15 of them `core: true`;
- the build test sees every card in each skill that reads cards.

```bash
python3 -m unittest scripts/checks/test_docs_map.py
```

Expected: the docs and the help map describe the library as it ships (FR-010).

## 2. Selection evals

Build `.plugin-skills/` first:

```bash
python3 scripts/build_plugin.py --skills
```

Then:

```bash
claude plugin eval . --case gap-driven-no-stacking --ablation none --model sonnet --runs 1 --no-publish --trust-plugin --scaffold --allow-tools Write Edit --output-dir .finolabs/eval/004-gap-driven
```

Expected: the open category gets a card and the filled one gets none.

For each new card, run its `fit-<id>` and `skip-<id>` cases the same way:
- the card is chosen in `fit-<id>`;
- in `skip-<id>`, the neighbour or no card is chosen.

Expected:
- **SC-003:** every new card is chosen where it fits and passed over where it does not;
- **SC-001:** the no-framework-name grader passes in every case.

## 3. Package

```bash
python3 scripts/checks/package_check.py examples/000-giu-chan-khach-cu
```

Expected: it passes. One package eval with four applied cards names all four where their categories feed (SC-004).

## 4. Before release

- The whole framework suite once, with spec 001 SC-011 and spec 004 SC-002 at 90% or more.
- The simulated-session suite (SC-005).
- The Cowork smoke test (constitution §V).
- The release review of the README pair, `docs/` and the help map.
