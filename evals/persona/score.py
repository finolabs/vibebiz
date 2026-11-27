"""Scoring for suite 8, the simulated-persona sessions (spec 001 T097).

Stdlib only, so the unit test runs without the Agent SDK. Reads an idea folder
(`specs/NNN-<slug>/` in the workspace) and a fixture from `evals/fixtures/`.

- Readiness follows core/router.md "Readiness" (spec 001 Appendix A, FR-020):
  A, C, D, E clear; M sized; every other category clear or deferred with a
  reason. M is sized when its status is `clear` or `partial`: the challenge lens
  sets `partial` exactly when it records the size (core/lenses/challenge.md).
  F must be clear when the fixture's `involves_ai` is true; otherwise it counts like
  the other categories. An idea whose `cynefin` is `chaotic` is never ready (the
  crisis comes first). A coverage.md that does not parse is reported as not ready.
- A key fact that carries numbers is checked deterministically: every quantity
  in the fact must appear in the idea's `spec.md`, compared by kind and value
  (percent, money in VND, duration in days, hours, plain count). A fact with no
  number needs the semantic judge, which runs in development only; without it the
  fact is reported as unscored and left out of the share.
"""

from __future__ import annotations

import json
import re
import sys
from pathlib import Path

REPO = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(REPO / "scripts" / "checks"))

from frontmatter import FrontmatterError, load  # noqa: E402

MUST_CLEAR = ("A", "C", "D", "E")
ALL_CODES = tuple("ABCDEFGHIJKLMNO")

# ---------------------------------------------------------------- readiness


def find_idea(workspace: Path) -> Path | None:
    """The single idea folder under `specs/` (first by name when several)."""
    folders = sorted(p for p in (workspace / "specs").glob("[0-9][0-9][0-9]-*") if p.is_dir())
    return folders[0] if folders else None


def readiness(coverage_path: Path, involves_ai: bool = False) -> tuple[bool, list[str]]:
    """Return (ready, unmet) where unmet names each failing category."""
    try:
        data, _ = load(coverage_path)
    except (FrontmatterError, OSError, UnicodeDecodeError) as exc:
        return False, [f"coverage.md unreadable: {exc}"]
    cats = data.get("categories") if isinstance(data.get("categories"), dict) else {}
    unmet = ["cynefin:chaotic"] if data.get("cynefin") == "chaotic" else []
    for code in ALL_CODES:
        cat = cats.get(code) if isinstance(cats.get(code), dict) else {}
        status = cat.get("status")
        if code in MUST_CLEAR or (code == "F" and involves_ai):
            ok = status == "clear"
        elif code == "M":
            ok = status in ("clear", "partial")
        else:
            ok = status == "clear" or (status == "deferred" and bool(cat.get("reason")))
        if not ok:
            unmet.append(f"{code}:{status}")
    return not unmet, unmet


# ---------------------------------------------------------------- quantities

_DAYS = {"ngày": 1, "tuần": 7, "tháng": 30, "quý": 90, "năm": 365,
         "day": 1, "days": 1, "week": 7, "weeks": 7, "month": 30, "months": 30,
         "year": 365, "years": 365}
_MONEY = {"nghìn": 1e3, "ngàn": 1e3, "k": 1e3, "triệu": 1e6, "tr": 1e6,
          "tỷ": 1e9, "tỉ": 1e9, "million": 1e6, "billion": 1e9}
_HOURS = ("giờ", "tiếng", "hour", "hours", "h")
_CURRENCY = ("đồng", "đ", "vnd", "vnđ", "₫")

_NUM = r"\d+(?:[.,]\d+)*"
_UNIT = r"%|phần trăm|" + "|".join(sorted({*_DAYS, *_MONEY, *_HOURS, *_CURRENCY}, key=len, reverse=True))
# A range shares its closing unit: `25–40 tuổi`, `từ 11 xuống 7 ngày`.
_RANGE = r"(?:\s*[–\-—]\s*|\s+(?:xuống|lên|đến|tới|to)\s+(?:còn\s+)?)"
_QTY_RE = re.compile(
    rf"(?<![\w.,])({_NUM})(?:{_RANGE}({_NUM}))?\s*({_UNIT})?(?!\w)", re.IGNORECASE)
# Number words are read as whole numerals and kept only with a unit after them (`hai mươi bảy
# giờ` is 27 hours, `bảy phần trăm` 7%, `bảy triệu` 7 million). A bare word count is not read:
# idioms such as `hai chiều`, `hai bên` and `một lần` make it unreliable, and specs write their
# figures in digits.
_DIGITS = {"một": 1, "mốt": 1, "hai": 2, "ba": 3, "bốn": 4, "tư": 4, "năm": 5, "lăm": 5,
           "sáu": 6, "bảy": 7, "tám": 8, "chín": 9}
_NUMERAL_WORDS = {*_DIGITS, "mười", "mươi", "chục", "trăm", "linh", "lẻ"}
# Punctuation is kept as its own token so `hai, ba cửa hàng` stays two numerals.
_WORD_TOKEN_RE = re.compile(r"\w+|[^\w\s]")



def _to_float(token: str) -> float:
    """Vietnamese and English separators: groups of three after a separator are thousands."""
    parts = re.split(r"[.,]", token)
    if len(parts) > 1 and all(len(p) == 3 for p in parts[1:]):
        return float("".join(parts))
    if len(parts) == 2:
        return float(f"{parts[0]}.{parts[1]}")
    return float("".join(parts))


def _kind(value: float, unit: str | None) -> tuple[str, float]:
    u = (unit or "").lower()
    if u in ("%", "phần trăm"):
        return ("pct", value)
    if u in _MONEY:
        return ("money", value * _MONEY[u])
    if u in _CURRENCY:
        return ("money", value)
    if u in _DAYS:
        return ("days", value * _DAYS[u])
    if u in _HOURS:
        return ("hours", value)
    return ("count", value)


# Dates and record ids are not quantities: 2026-11-27, 27/11/2026, 5/2027, D-019, Q-004, SC-001.
_NOT_QTY_RE = re.compile(r"\b\d{4}-\d{2}-\d{2}\b|\b\d{1,2}/\d{1,2}(?:/\d{2,4})?\b|\b\d{1,2}/\d{4}\b|\b[A-Z]{1,3}-\d+\b")


def _numeral_value(words: list[str]) -> float:
    """`hai mươi bảy` 27, `mười hai` 12, `ba trăm linh năm` 305, `bốn chục` 40."""
    total, current = 0, 0
    for w in words:
        if w in _DIGITS:
            current += _DIGITS[w]
        elif w == "mười":
            current += 10
        elif w in ("mươi", "chục"):
            current = (current or 1) * 10
        elif w == "trăm":
            total, current = total + (current or 1) * 100, 0
    return float(total + current)


def _word_quantities(text: str) -> set[tuple[str, float]]:
    """Quantities written in Vietnamese number words; one linear pass over the words."""
    words = [w.lower() for w in _WORD_TOKEN_RE.findall(text)]
    found: set[tuple[str, float]] = set()
    i = 0
    while i < len(words):
        if words[i] not in _NUMERAL_WORDS or words[i] in ("mươi", "chục", "trăm", "linh", "lẻ"):
            i += 1
            continue
        j = i + 1
        # "năm" after a numeral is the unit "year" (the digit 5 is "lăm"), except after "linh"
        # or "lẻ" and before "mươi" (`một trăm năm mươi` is 150).
        while j < len(words) and words[j] in _NUMERAL_WORDS and (
                words[j] != "năm" or words[j - 1] in ("linh", "lẻ")
                or (j + 1 < len(words) and words[j + 1] == "mươi")):
            j += 1
        run, before = words[i:j], words[i - 1] if i else ""
        nxt = words[j] if j < len(words) else ""
        after = " ".join(words[j:j + 2])
        is_unit = nxt in _DAYS or nxt in _HOURS or nxt in _MONEY or nxt in _CURRENCY
        # Step past the unit too, so `một năm sáu tháng` does not read "năm" again as 5.
        i = j + (2 if after == "phần trăm" else 1 if is_unit else 0)
        # Weekdays and month names are not quantities (`thứ hai`, `tháng Bảy năm nay`); after
        # "tháng" a shorter time unit is still a duration (`mỗi tháng hai ngày`).
        if before == "thứ" or (before == "tháng" and nxt not in ("ngày", "tuần", "giờ", "tiếng")):
            continue
        # Two digits side by side are an approximate range (`hai ba ngày`, two or three days):
        # split there and give each end the unit after the run, as `25–40 tuổi` does.
        parts, start = [], 0
        for k in range(1, len(run)):
            if run[k] in _DIGITS and run[k - 1] in _DIGITS:
                parts.append(run[start:k])
                start = k
        parts.append(run[start:])
        for part in parts:
            value = _numeral_value(part)
            if after == "phần trăm":
                found.add(("pct", value))
            elif is_unit:
                found.add(_kind(value, nxt))
    return found


def quantities(text: str) -> set[tuple[str, float]]:
    """Every (kind, value) the text states, values rounded; a range `25–40 x` gives both ends."""
    text = _NOT_QTY_RE.sub(" ", text)
    found: set[tuple[str, float]] = set()
    for m in _QTY_RE.finditer(text):
        unit = m.group(3)
        for tok in (m.group(1), m.group(2)):
            if tok:
                found.add(_kind(_to_float(tok), unit))
    found |= _word_quantities(text)
    return {(kind, round(value, 6)) for kind, value in found}


def fact_numbers_present(fact: str, spec_text: str) -> bool:
    """All of the fact's quantities appear in the spec with the same kind (a count matches only a count)."""
    return quantities(fact) <= quantities(spec_text)


# ---------------------------------------------------------------- facts


def score_facts(fixture: dict, spec_text: str, judge=None) -> dict:
    """Score each key fact; `judge(spec_text, facts) -> {id: bool}` handles facts without numbers."""
    results = {}
    semantic = []
    for fact in fixture["key_facts"]:
        if quantities(fact["fact"]):
            results[fact["id"]] = {"method": "numbers", "preserved": fact_numbers_present(fact["fact"], spec_text)}
        else:
            semantic.append(fact)
    verdicts = judge(spec_text, semantic) if (judge and semantic) else {}
    verdicts = verdicts if isinstance(verdicts, dict) else {}
    for fact in semantic:
        if isinstance(verdicts.get(fact["id"]), bool):  # a judge reply that is not a real boolean stays unscored
            results[fact["id"]] = {"method": "judge", "preserved": bool(verdicts[fact["id"]])}
        else:
            results[fact["id"]] = {"method": "unscored", "preserved": None}
    scored = [r for r in results.values() if r["preserved"] is not None]
    kept = sum(1 for r in scored if r["preserved"])
    return {
        "facts": results,
        "preserved": kept,
        "scored": len(scored),
        "unscored": len(results) - len(scored),
        "share": round(kept / len(scored), 3) if scored else None,
    }


def score_workspace(workspace: Path, fixture: dict, judge=None) -> dict:
    """Readiness and fact share for the idea in `workspace`."""
    idea = find_idea(workspace)
    if idea is None:
        return {"idea": None, "ready": False, "unmet": ["no idea folder"], "facts": score_facts(fixture, "", None)}
    cov = idea / "coverage.md"
    ready, unmet = readiness(cov, bool(fixture.get("involves_ai"))) if cov.exists() else (False, ["no coverage.md"])
    spec = idea / "spec.md"
    spec_text = spec.read_text(encoding="utf-8") if spec.exists() else ""
    return {"idea": idea.name, "ready": ready, "unmet": unmet, "facts": score_facts(fixture, spec_text, judge)}


if __name__ == "__main__":
    ws, fx = Path(sys.argv[1]), Path(sys.argv[2])
    print(json.dumps(score_workspace(ws, json.loads(fx.read_text(encoding="utf-8"))), ensure_ascii=False, indent=2))
