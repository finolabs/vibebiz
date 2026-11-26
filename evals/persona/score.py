"""Scoring for suite 8, the simulated-persona sessions (spec 001 T097).

Stdlib only, so the unit test runs without the Agent SDK. Reads an idea folder
(`specs/NNN-<slug>/` in the workspace) and a fixture from `evals/fixtures/`.

- Readiness follows core/router.md "Readiness" (spec 001 Appendix A, FR-020):
  A, C, D, E clear; M sized; every other category clear or deferred with a
  reason. M is sized when its status is `clear` or `partial`: the challenge lens
  sets `partial` exactly when it records the size (core/lenses/challenge.md).
  F counts like the other categories: whether the idea involves AI is not in the
  frontmatter, so `deferred` with a reason is accepted for it.
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

from frontmatter import load  # noqa: E402

MUST_CLEAR = ("A", "C", "D", "E")
ALL_CODES = tuple("ABCDEFGHIJKLMNO")

# ---------------------------------------------------------------- readiness


def find_idea(workspace: Path) -> Path | None:
    """The single idea folder under `specs/` (first by name when several)."""
    folders = sorted(p for p in (workspace / "specs").glob("[0-9][0-9][0-9]-*") if p.is_dir())
    return folders[0] if folders else None


def readiness(coverage_path: Path) -> tuple[bool, list[str]]:
    """Return (ready, unmet) where unmet names each failing category."""
    data, _ = load(coverage_path)
    cats = data.get("categories") or {}
    unmet = []
    for code in ALL_CODES:
        cat = cats.get(code) or {}
        status = cat.get("status")
        if code in MUST_CLEAR:
            ok = status == "clear"
        elif code == "M":
            ok = status in ("clear", "partial")
        else:
            ok = status == "clear" or (status == "deferred" and bool(cat.get("reason")))
        if not ok:
            unmet.append(f"{code}:{status}")
    return not unmet, unmet


# ---------------------------------------------------------------- quantities

_WORDS = {"một": 1, "hai": 2, "ba": 3, "bốn": 4, "tư": 4, "năm": 5, "sáu": 6,
          "bảy": 7, "tám": 8, "chín": 9, "mười": 10, "mười hai": 12}
_DAYS = {"ngày": 1, "tuần": 7, "tháng": 30, "quý": 90, "năm": 365,
         "day": 1, "days": 1, "week": 7, "weeks": 7, "month": 30, "months": 30,
         "year": 365, "years": 365}
_MONEY = {"nghìn": 1e3, "ngàn": 1e3, "k": 1e3, "triệu": 1e6, "tr": 1e6,
          "tỷ": 1e9, "tỉ": 1e9, "million": 1e6, "billion": 1e9}
_HOURS = ("giờ", "tiếng", "hour", "hours", "h")
_CURRENCY = ("đồng", "đ", "vnd", "₫")

_NUM = r"\d+(?:[.,]\d+)*"
_UNIT = r"%|phần trăm|" + "|".join(sorted({*_DAYS, *_MONEY, *_HOURS, *_CURRENCY}, key=len, reverse=True))
_QTY_RE = re.compile(
    rf"(?<![\w.,])({_NUM})(?:\s*[–\-—]\s*({_NUM}))?\s*({_UNIT})?(?!\w)", re.IGNORECASE)
_WORD_RE = re.compile(
    r"(?<!\w)(" + "|".join(sorted(_WORDS, key=len, reverse=True)) + r")\s+("
    + "|".join(sorted(_DAYS, key=len, reverse=True)) + r")(?!\w)", re.IGNORECASE)


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


def quantities(text: str) -> set[tuple[str, float]]:
    """Every (kind, value) the text states; a range `25–40 x` gives both ends."""
    found: set[tuple[str, float]] = set()
    for m in _QTY_RE.finditer(text):
        unit = m.group(3)
        for tok in (m.group(1), m.group(2)):
            if tok:
                found.add(_kind(_to_float(tok), unit))
    for m in _WORD_RE.finditer(text):
        found.add(_kind(float(_WORDS[m.group(1).lower()]), m.group(2)))
    return found


def fact_numbers_present(fact: str, spec_text: str) -> bool:
    """All of the fact's quantities appear in the spec; a plain count matches any kind."""
    have = quantities(spec_text)
    values = {v for _, v in have}
    for kind, value in quantities(fact):
        if kind == "count":
            if value not in values:
                return False
        elif (kind, value) not in have:
            return False
    return True


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
    for fact in semantic:
        if fact["id"] in verdicts:
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
    ready, unmet = readiness(cov) if cov.exists() else (False, ["no coverage.md"])
    spec = idea / "spec.md"
    spec_text = spec.read_text(encoding="utf-8") if spec.exists() else ""
    return {"idea": idea.name, "ready": ready, "unmet": unmet, "facts": score_facts(fixture, spec_text, judge)}


if __name__ == "__main__":
    ws, fx = Path(sys.argv[1]), Path(sys.argv[2])
    print(json.dumps(score_workspace(ws, json.loads(fx.read_text(encoding="utf-8"))), ensure_ascii=False, indent=2))
