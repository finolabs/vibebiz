---
type: llm
focus: 'trace'
---

Rules for a question round: at most four questions; each has two to four mutually exclusive options; the recommended option is first and marked as recommended; no option "None", "Other", "Khác" or "Không có" (the tool offers Skip and free text); every question can be understood without the surrounding text (no "as above", no jargon without explanation); open-ended questions are plain text, not options.

PASS if the first AskUserQuestion round in the trace follows every rule above.
FAIL if any rule is broken. If no multiple-choice round was asked at all, FAIL.
