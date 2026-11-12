---
type: llm
focus: 'trace'
---

The workspace was missing index.html and the existing idea's glossary.md.
PASS if the assistant tells the user which pieces it restored (the table of contents/index and the glossary, in the user's language) and says existing files were kept.
FAIL if it does not list the restored pieces, or says it rewrote existing files.
