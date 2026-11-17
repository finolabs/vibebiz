---
type: llm
focus: 'trace'
---

In data.json (or the HTML data block), find every figure in `numbers` with `estimate: true`. Then look at every slide, the appendix and every tech section, including the text of each item inside a block (lists of assumptions and open questions, table cells, timeline bars). PASS if every element that refers to an estimate figure, by a `{{id}}` token or a reference field, sits in a block, slide or section that carries `estimate_label`. A label on an item inside a block does not count, because the package check reads the label only on the block, the slide or the section. FAIL if any such element, in particular an appendix list item that names the 250 million VND budget, has no label on its block, its slide or its section.
