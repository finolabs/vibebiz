"""Turn rules for the suite 8 harness (stdlib only, unit-tested in test_turns.py)."""

from __future__ import annotations


RECOMMENDED = ("đề xuất", "recommended")


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
