---
type: llm
focus: 'trace'
---

In data.json (or the HTML data block), find every figure in `numbers` with `estimate: true`. Then look at every slide, the appendix and every tech section, including the text of each item inside a block (lists of assumptions and open questions, table cells, timeline bars). PASS if every element that refers to an estimate figure, by a `{{id}}` token or a reference field, carries `estimate_label` itself or sits in a block, slide or section that carries it. FAIL if any such element, in particular an appendix list item that names the 250 million VND budget, has no label on itself, its block or its slide.
