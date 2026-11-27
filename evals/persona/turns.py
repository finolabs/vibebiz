"""Turn rules for the suite 8 harness (stdlib only, unit-tested in test_turns.py)."""

from __future__ import annotations


RECOMMENDED = ("(đề xuất)", "(recommended)")  # only the bracketed marker vibebiz writes


def budget_offer_choice(labels: list[str]) -> tuple[str, bool] | None:
    """For the ask-protocol section 8 offer, the option vibebiz recommends and whether it is the pause.

    The recommended option carries "(Đề xuất)" or "(Recommended)"; without a marker it is the first
    option (ask-protocol: recommended first). Returns None when the options are not that offer.
    """
    low = [l.lower() for l in labels]
    pause = next((l for l, x in zip(labels, low) if "tạm dừng" in x or "pause" in x), None)
    if not (pause and any("hỏi tiếp" in x or "xuất bản nháp" in x or "continue" in x or "draft" in x for x in low)):
        return None
    pick = next((l for l, x in zip(labels, low) if any(m in x for m in RECOMMENDED)), labels[0])
    if "xuất bản nháp" in pick.lower() or "draft" in pick.lower():
        pick = pause  # a draft would start packaging, which suite 8 does not measure
    return pick, pick == pause


SESSION_CAPS = ("error_max_budget_usd", "error_max_turns")


def next_turn(text: str, *, error: bool, ready: bool, paused: bool, finished: bool,
              replies: int, nudges: int, max_replies: int, max_nudges: int = 1) -> str:
    """What the persona does when the agent ends a turn: "reply", "nudge" or "end".

    A question in the message's tail gets a reply, up to `max_replies` per session. A turn
    that stops without a question and without the budget pause gets at most `max_nudges`
    persona replies per session: an impatient user who wants to finish says to go on.
    """
    if error or ready or paused or not finished:
        return "end"
    if "?" in text[-400:]:
        return "reply" if replies < max_replies else "end"
    return "nudge" if nudges < max_nudges else "end"


WRITE_TOOLS = ("Write", "Edit")
READ_TOOLS = ("Read", "Glob", "Grep")


def _inside(raw: str | None, roots: list) -> bool:
    """True when the path (relative to the first root, `~` expanded) resolves inside one of the roots."""
    from pathlib import Path
    base = Path(roots[0]).resolve()
    p = Path(raw).expanduser() if raw else base
    p = (p if p.is_absolute() else base / p).resolve()
    return any(p == Path(r).resolve() or Path(r).resolve() in p.parents for r in roots)


def tool_allowed(name: str, tool_input: dict, workspace, plugin_dir) -> bool:
    """The agent under test may write only in its workspace and read only there or in the plugin; no shell."""
    if name == "Skill" or name.startswith("Skill"):
        return True
    if name in WRITE_TOOLS:
        return _inside(tool_input.get("file_path"), [workspace])
    if name in READ_TOOLS:
        roots = [workspace, plugin_dir]
        base = tool_input.get("file_path") or tool_input.get("path")
        if not _inside(base, roots):
            return False
        if name == "Glob":  # the pattern can carry its own location: `/etc/*`, `../../*`, `~/x/*`
            return _inside(_glob_root(tool_input.get("pattern") or "", base or str(workspace)), roots)
        return True
    return False


def _glob_root(pattern: str, base: str) -> str:
    """The folder a Glob pattern searches: its literal leading components (the `/` anchor kept), joined to the base.

    A `..` after a wildcard can climb anywhere, so it searches from the filesystem root.
    """
    from pathlib import Path
    parts = Path(pattern).expanduser().parts
    lead = 0
    while lead < len(parts) and not any(c in parts[lead] for c in "*?[{"):
        lead += 1
    if ".." in parts[lead:]:
        return "/"
    if lead < len(parts):  # the components up to the first wildcard name the folder searched
        head = Path(*parts[:lead]) if lead else Path(".")
    else:  # no wildcard: the pattern names a file, searched in its folder
        head = Path(*parts).parent if parts else Path(".")
    return str(head if head.is_absolute() else Path(base).expanduser() / head)
