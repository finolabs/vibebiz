"""The routing map between framework cards (spec 004 FR-012, FR-017).

Each card declares four link keys in its frontmatter:
  needs:        [card ids]            any one applied, or every category that card fills is clear
  feeds:        [{to: id, passes: text}]
  instead_of:   [card ids]            declared on both sides
  revisit_when: [codes A-O, board-changes, tech-review]

`check` validates the links across a folder; `render` writes docs/framework-map.md and packs/framework-index.md (the router's lookup),
the plain-Vietnamese table `help` reads. Python 3.10+ standard library only.

Run: python3 scripts/checks/framework_map.py check
     python3 scripts/checks/framework_map.py render
"""

from __future__ import annotations

import argparse
import sys
from pathlib import Path

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE))

from frontmatter import load  # noqa: E402

REPO = HERE.parent.parent
CARDS_DIR = REPO / "packs" / "frameworks"
DOC = REPO / "docs" / "framework-map.md"
INDEX = REPO / "packs" / "framework-index.md"
LINK_KEYS = ("needs", "feeds", "instead_of", "revisit_when")
EVENTS = {"board-changes", "tech-review"}
CODES = set("ABCDEFGHIJKLMNO")


def _cards(directory: Path) -> dict[str, dict]:
    cards = {}
    for path in sorted(directory.glob("*.md")):
        data, _ = load(path)
        cards[str(data.get("id") or path.stem)] = data
    return cards


def _list(value) -> list:
    return value if isinstance(value, list) else []


def check(directory: Path = CARDS_DIR) -> list[str]:
    cards = _cards(directory)
    problems: list[str] = []
    for cid, data in cards.items():
        for key in LINK_KEYS:
            if key not in data:
                problems.append(f"{cid}: missing link key '{key}'")
            elif data[key] not in (None, []) and not isinstance(data[key], list):
                problems.append(f"{cid}: '{key}' must be a list")
        for target in _list(data.get("needs")) + _list(data.get("instead_of")):
            if target not in cards:
                problems.append(f"{cid}: links to '{target}', which is not a shipped card")
        for feed in _list(data.get("feeds")):
            if not isinstance(feed, dict) or not feed.get("to") or not feed.get("passes"):
                problems.append(f"{cid}: each feeds entry needs 'to' and 'passes'")
            elif feed["to"] not in cards:
                problems.append(f"{cid}: feeds '{feed['to']}', which is not a shipped card")
            elif feed["to"] == cid:
                problems.append(f"{cid}: feeds itself")
        for other in _list(data.get("instead_of")):
            if other in cards and cid not in _list(cards[other].get("instead_of")):
                problems.append(f"{cid}: instead_of '{other}' is not declared on both sides")
        for value in _list(data.get("revisit_when")):
            if value not in CODES and value not in EVENTS:
                problems.append(f"{cid}: revisit_when '{value}' is not a category code or an event")
    # needs must not loop
    state: dict[str, int] = {}

    def visit(node: str, trail: list[str]) -> None:
        state[node] = 1
        for nxt in _list(cards.get(node, {}).get("needs")):
            if nxt not in cards:
                continue
            if state.get(nxt) == 1:
                problems.append(f"needs cycle: {' → '.join(trail + [node, nxt])}")
            elif state.get(nxt) is None:
                visit(nxt, trail + [node])
        state[node] = 2

    for cid in cards:
        if state.get(cid) is None:
            visit(cid, [])
    return problems


def render(directory: Path = CARDS_DIR) -> str:
    cards = _cards(directory)
    lines = [
        "# Các phương pháp nối với nhau thế nào",
        "",
        "vibebiz tự chọn phương pháp phân tích (framework) theo phần còn trống của ý tưởng; bạn không phải chọn. "
        "Bảng này cho biết phương pháp nào cần có trước, kết quả của nó được dùng tiếp ở đâu, và khi nào nó được làm lại. "
        "Bảng được tạo tự động từ các thẻ phương pháp; đừng sửa tay.",
        "",
        "| Phương pháp | Cần có trước | Kết quả dùng tiếp cho | Chọn một trong | Làm lại khi |",
        "|---|---|---|---|---|",
    ]
    names = {cid: str(d.get("name") or cid) for cid, d in cards.items()}
    for cid in sorted(cards, key=lambda c: names[c].lower()):
        d = cards[cid]
        needs = ", ".join(names.get(n, n) for n in _list(d.get("needs"))) or "—"
        feeds = ", ".join(names.get(f["to"], f["to"]) for f in _list(d.get("feeds")) if isinstance(f, dict)) or "—"
        inst = ", ".join(names.get(n, n) for n in _list(d.get("instead_of"))) or "—"
        rev = ", ".join({"board-changes": "ban lãnh đạo yêu cầu sửa", "tech-review": "đội kỹ thuật thẩm định"}.get(v, f"mục {v} đổi")
                        for v in _list(d.get("revisit_when"))) or "—"
        lines.append(f"| {names[cid]} | {needs} | {feeds} | {inst} | {rev} |")
    return "\n".join(lines) + "\n"


def render_index(directory: Path = CARDS_DIR) -> str:
    """The router's lookup from a category to the cards that fill it, built from card frontmatter."""
    cards = _cards(directory)
    by_slot: dict[tuple[str, str], list[str]] = {}
    for cid, d in cards.items():
        for code in _list(d.get("fills")):
            by_slot.setdefault((str(code), str(d.get("lens"))), []).append(cid)
    lines = [
        "# Framework card index",
        "",
        "Generated from the frontmatter of the cards in `frameworks/` by `scripts/checks/framework_map.py render`; do not edit by hand. "
        "Look a category up here to find every card whose `fills` includes it, then read those cards' files. "
        "The card file stays the authority for \"When to use\", \"When not to use\", `feeds` and `revisit_when`.",
        "",
        "## By category",
        "",
        "| Code | Lens | Cards |",
        "|---|---|---|",
    ]
    for code, lens in sorted(by_slot):
        lines.append(f"| {code} | {lens} | {', '.join(sorted(by_slot[(code, lens)]))} |")
    lines += [
        "",
        "## Cards",
        "",
        "| Card | Lens | Fills | Needs | Instead of | Feeds |",
        "|---|---|---|---|---|---|",
    ]
    for cid in sorted(cards):
        d = cards[cid]
        fills = ", ".join(str(c) for c in _list(d.get("fills"))) or "—"
        needs = ", ".join(_list(d.get("needs"))) or "—"
        inst = ", ".join(_list(d.get("instead_of"))) or "—"
        feeds = ", ".join(f["to"] for f in _list(d.get("feeds")) if isinstance(f, dict) and f.get("to")) or "—"
        lines.append(f"| {cid} | {d.get('lens')} | {fills} | {needs} | {inst} | {feeds} |")
    return "\n".join(lines) + "\n"


def main(argv: list[str] | None = None) -> int:
    parser = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    parser.add_argument("mode", choices=("check", "render"))
    args = parser.parse_args(argv)
    if args.mode == "check":
        problems = check()
        for p in problems:
            print(p)
        print("map ok" if not problems else f"{len(problems)} problems")
        return 1 if problems else 0
    DOC.write_text(render(), encoding="utf-8")
    INDEX.write_text(render_index(), encoding="utf-8")
    print(f"wrote {DOC.relative_to(REPO)} and {INDEX.relative_to(REPO)}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
