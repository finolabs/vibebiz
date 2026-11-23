---
id: leading-lagging
name: Leading and lagging indicators
lens: outcome
fills: [C]
core: false
diagram_type: line
origin: Performance-measurement practice that pairs outcome (lag) measures with the earlier measures that predict them, as in Kaplan and Norton's work on the balanced scorecard; no single originator
needs: []
feeds:
  - to: test-and-control-pilot
    passes: the early signal
  - to: stage-gate
    passes: gate metrics
instead_of: []
revisit_when: [C]
---

# Leading and lagging indicators

Pairs the outcome, a lagging number that arrives weeks or months after the work, with one or two leading numbers that move first and predict it. Each leading number gets a reading date and a level that says "on track" or "not yet". The team learns early whether the idea works, instead of waiting for the result.

## When to use

- The outcome is known, but it can only be read late (return rate a month after delivery, repeat purchase within 90 days, season sell-through).
- C lacks a leading indicator, or the leading numbers named are activity counts that do not predict the outcome.
- The board or the team must decide early, at a pilot review or after the first weeks, whether to continue.

## When not to use

- The top result is open and the question is which drivers make it up: use `driver-tree`.
- Teams follow different numbers and no company-wide number is chosen yet: use `north-star-metric` first.
- The outcome can already be read daily or weekly; a second, earlier number adds little.

## Inputs

- The outcome with baseline, target and period, from the files.
- The driver the idea moves, from the driver tree when one is applied.
- The data the business already records early (clicks, size selections, fitting-room requests, first-week sales), with source.

## Questions

One round at most. Offer candidate early numbers built from the driver as options.

1. "Kết quả cuối cùng chỉ biết sau bao lâu kể từ khi việc diễn ra?" (a fact to look up first; ask only if no file has it)
2. "Trước khi kết quả đó hiện ra, khách hoặc nhân viên làm gì khác đi mà mình thấy được ngay? Ví dụ: tỷ lệ khách dùng gợi ý size trước khi đặt hàng (Đề xuất), tỷ lệ đơn đổi size trước khi giao."
3. "Con số sớm đó hiện ghi ở đâu, và đọc được sau bao lâu?"
4. "Đến tuần thứ mấy, con số sớm đạt mức nào thì coi là đang đi đúng hướng, mức nào thì cần dừng lại xem xét?" (the levels are the user's decision)

## Writes to

- Outcome and measurement (C): the leading indicator for the driver, with source, reading date and on-track level; the lagging outcome stays as written.
- Kill criteria: a leading level that triggers a review, when the user sets one.
- Assumptions: the link between the leading and the lagging number, labelled until a pilot confirms it.
- Diagram brief: a line chart of the leading and the lagging number over the same weeks, each labelled with source and period; until real readings exist, a table of the planned readings instead.

## Common misuse

- Choosing an activity count (sessions held, messages sent) as the leading number; it must predict the outcome, not just show work.
- Treating the leading number as the goal; teams then push it without the outcome moving.
- Picking a leading number nobody records yet without a plan to record it.
- Inventing readings or levels. Record only figures the user or the files give, with source and period.

## Fashion example (fictional)

The fictional brand "Mộc Lam" adds a size helper to its website to cut size-related returns from 18% to 12% within six months; the return rate is read more than 30 days after delivery. The leading numbers are the share of orders placed after using the helper and the share of orders whose size is changed before shipping, both readable the next day from the order system. The team sets a review if helper use stays low after week three; that the helper predicts fewer returns stays an assumption until the pilot reads both.
