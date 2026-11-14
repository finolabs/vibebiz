# Quickstart: validate installs on three hosts

Run on a machine where vibebiz is not installed for the host under test (remove a synced or earlier copy first, and note it). Use a scratch folder outside any repository.

## 1. Repository checks (before tagging)

```bash
python3 -m unittest scripts/checks/test_build.py scripts/checks/test_docs_map.py
claude plugin validate .
```

Expected: tests pass; validation passes (warnings allowed). Then change one line in a `core/` module without regenerating and rerun `test_build.py`: it fails and names the stale files under `.plugin-skills/`.

## 2. Claude Code from the catalog (after the catalog lists the tag) or from the tag

```bash
claude plugin marketplace add finolabs/plugins
claude plugin install vibebiz@finolabs
```

Before the catalog lists it, use a scratch marketplace whose entry is `{"source":"github","repo":"finolabs/vibebiz","ref":"v0.1.5"}`. In the scratch folder run `/vibebiz:idea` with the fictional example idea, answer one round, then `continue` and `package`. Expected: the workspace passes `scripts/checks/package_check.py` and the Spec Kit compatibility check; every skill found its `references/`.

## 3. Codex

```bash
codex plugin marketplace add finolabs/plugins
codex plugin add vibebiz@finolabs
```

Same run as step 2. Record the skill name form Codex shows and the limits of `request_user_input`.

## 4. Antigravity

```bash
agy plugin install https://github.com/finolabs/vibebiz
```

If the URL form fails, record the error, then install from a clone checked out at the tag (`agy plugin install <clone>`), and record that the URL form does not work. Same run as step 2; record the skill name form and the limits of `ask_question`.

## 5. Cowork

Install `vibebiz.plugin` from the release and run the Cowork smoke test (`specs/001-idea-to-prd/quickstart.md`). Expected: unchanged from 0.1.4.

## 6. Record and list

Add one row per host to `evals/RESULTS.md` (`data-model.md` "Install record"). With all rows passing, open a pull request in `finolabs/plugins` adding vibebiz to both catalogs pinned to the tag, and run `python3 -I scripts/check-catalogs.py --remote` there.
