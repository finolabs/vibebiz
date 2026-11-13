---
type: llm
focus: 'trace'
---

A previous export set (marked SEED-PREVIOUS-SET-2026-11-05) sat in exports/. PASS if the assistant moved that whole set (board-deck.html, tech-prd.html, spec.md, data.json, links.md) into exports/history/<date>/ before writing the new set, and the new set sits under the same fixed file names in exports/. FAIL if it overwrote the previous files without keeping them, deleted them, or left an incomplete set in history.
