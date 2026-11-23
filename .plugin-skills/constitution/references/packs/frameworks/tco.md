---
id: tco
name: Total cost of ownership
lens: plan
fills: [M]
core: false
diagram_type: bar
origin: Total cost of ownership, popularised by Gartner for IT purchases in the late 1980s and used across procurement since
needs: []
feeds:
  - to: npv
    passes: the yearly cost of the chosen route
instead_of: []
revisit_when: [M, board-changes, tech-review]
---

# Total cost of ownership

A way to count what a chosen route really costs over the years it is used, not only what it costs to buy or build. It adds the one-time costs (purchase or build, devices, setup, data clean-up, first training) to the costs that come back every year (subscription or licence, support, hosting, devices replaced, refresher training, and the staff time the new way takes or frees), over a fixed number of years. The board sees one total per year and for the whole period, in low, base and high scenarios.

## When to use

- The route is chosen (D is clear: buy, build or partner) and M is `missing` or `partial` because only the purchase or build price is on file.
- The route has costs that recur: a subscription, devices, support, or store staff time that changes.
- The board will ask "what does this cost us every year from now", not "which route is best".

## When not to use

- The route is not chosen yet and the board must compare building, buying and partnering: `build-buy-partner-roi` fits better, because it costs every route side by side with its return and payback.
- The yearly costs are on file and the open question is whether the return over the years is worth the money, counting when it arrives: `npv` fits better.
- A one-off cost with nothing recurring (a single campaign, a one-time clean-up); the size and scenarios in the plan cover it.

## Inputs

- The chosen route and its decision (D-###) from `## Alternatives`.
- The figures on file in `## Cost & Risk`: purchase or build price, quotes, size, with source and period.
- The number of stores, devices and staff the route touches, from the spec.
- The period of use the board will judge (usually three years) and the yearly budget cycle.

## Questions

Ask only for the cost lines still missing, one round at most; never ask the user to build the total themselves.

1. "Ngoài khoản mua ban đầu, mỗi năm mình còn phải trả những khoản nào cho cách làm này: phí thuê bao, hỗ trợ, thiết bị thay mới?" (Offer the lines the quote names; a line nobody knows becomes an open question to the supplier.)
2. "Bao nhiêu cửa hàng và bao nhiêu nhân viên sẽ dùng, và mỗi người cần học mất bao lâu?"
3. "Cách làm mới làm nhân viên cửa hàng tốn thêm hay đỡ được bao nhiêu giờ mỗi tháng?"
4. "Hội đồng sẽ xét khoản này trong mấy năm dùng: hai, ba hay năm năm?"

Never fill a price, a fee or a staff-time figure from memory or from the market: a figure nobody present can give becomes an open question with its owner (the supplier, finance), and today's value follows ask protocol rule 5. Every estimate carries the label "not tech-reviewed" until reviewed (rule 10).

## Writes to

- Cost, resources and return (M) in `## Cost & Risk`: the one-time costs and the yearly costs by line, each with source, period and its measured or assumed label; the total per year and for the period in low, base and high scenarios; the lines still open.
- Open questions: each cost line nobody could give, with who can answer it.
- Diagram brief: `bar`, one stacked bar per year split into one-time and recurring costs, base scenario, with low and high noted beside it.

## Common misuse

- Counting only the price on the quote and leaving out staff time, training and devices.
- Filling a missing fee with a typical market price; it becomes a fact nobody gave.
- Mixing currencies or periods in one total.
- Using it to pick a route; once the routes are still open, the comparison comes first.

## Fashion example (fictional)

The fictional chain "Lụa Hồng" chose to buy a handheld stock-count tool for its 30 stores (D-001). Only the first-year licence quote was on file. Packaging collected the lines below; figures are illustrative, assumed, and "not tech-reviewed".

| Line | Year 1 | Year 2 | Year 3 | Source |
|---|---|---|---|---|
| Licence (one-time) | 90 million VND | — | — | Supplier quote, Oct 2026 |
| Subscription | 36 million VND | 36 million VND | 36 million VND | Supplier quote, Oct 2026 |
| Scanners (60) | 120 million VND | — | 20 million VND | Not yet clarified: open question to purchasing |
| Staff training | 2 hours per person | 1 hour per new hire | 1 hour per new hire | Operations manager (assumed) |

The base total over three years is shown with the scanner price still open, so the board sees what is known and what waits on purchasing.
