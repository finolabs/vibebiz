---
id: npv
name: NPV and payback
lens: plan
fills: [M]
core: false
diagram_type: bar
origin: Discounted cash flow from corporate finance (Irving Fisher's work on interest and present value); payback period from common capital-budgeting practice
needs: [tco, build-buy-partner-roi]
feeds: []
instead_of: []
revisit_when: [C, M, board-changes, tech-review]
---

# NPV and payback

A way to judge whether money spent now is worth a return that arrives over several years. Each year's net amount (return minus cost) is brought back to today's value with a rate the company uses for its own money; adding them gives the net present value. Payback is the simpler partner: the month when the money paid out is earned back. The board sees both, in low, base and high scenarios.

## When to use

- The cost of the chosen route is on file year by year (from `tco` or `build-buy-partner-roi`), and M is `missing` or `partial` because nobody has weighed it against the return over the years.
- The return starts late or grows over time (a store network ramping up, a contract over several years), so a simple yearly comparison misleads.
- Finance or the board asks "is it worth it" and "when do we get the money back".

## When not to use

- Only the purchase or build price is on file and the recurring costs are missing: `tco` fits better, because the years of cost come first.
- The route is not chosen and the board must compare building, buying and partnering: `build-buy-partner-roi` fits better; it gives each route a simple payback, and this card follows once a route is chosen.
- The amount is small and the return comes within the first year; the plan's payback line is enough.

## Inputs

- The yearly costs of the chosen route, with source, period and label, as `tco` or `build-buy-partner-roi` wrote them in `## Cost & Risk`.
- The return driver from `## Outcome` (extra revenue, cost saved, hours freed), its value today and its target, with source.
- The number of years the board will judge, and the rate finance uses for its own money (the discount rate).

## Questions

Ask only for what is still missing, one round at most; never ask the user to compute a present value.

1. "Khoản lợi (tiền tiết kiệm hay doanh thu thêm) bắt đầu từ năm nào và mỗi năm khoảng bao nhiêu? Anh/chị lấy số này ở đâu?"
2. "Phòng tài chính đang dùng mức lãi nào để so các khoản đầu tư: theo lãi vay của công ty hay một mức chung?" (Offer the rate the ground rules or finance named; a rate nobody knows becomes an open question to finance.)
3. "Hội đồng chấp nhận hoàn vốn trong bao lâu thì duyệt?"

Never invent a return, a rate or a cost: a figure nobody present can give becomes an open question with its owner, and today's value follows ask protocol rule 5. Present value and payback are estimates derived from labelled inputs and carry "not tech-reviewed" until reviewed (rule 10).

## Writes to

- Cost, resources and return (M) in `## Cost & Risk`: the net amount per year in low, base and high scenarios, the rate and its source, the net present value per scenario, and the payback month, each naming the figures it comes from; when an input is missing, that scenario's result is "not yet clarified".
- Open questions: each missing return, rate or year, with who can answer it.
- Diagram brief: `bar`, one bar per year for the net amount (below zero while paying out), base scenario, with the payback month marked.

## Common misuse

- Mixing yearly costs from one route with returns from another.
- Picking a low rate so the total looks good; the rate comes from finance and is stated with its source.
- Counting a return that the outcome lens never set as a target.
- Presenting the present value as exact; a small change in a late year's return can flip it, which the low scenario must show.

## Fashion example (fictional)

The fictional chain "Lụa Hồng" chose to rent a partner-run warehouse for its northern online orders for four years (D-001); the yearly costs came from the earlier cost count. Savings start in year two. Figures are illustrative, assumed, and "not tech-reviewed".

| Year | Cost | Saving | Net | Source |
|---|---|---|---|---|
| 1 | 900 million VND | 0 | −900 million VND | Partner quote, Oct 2026 |
| 2 | 600 million VND | 1,000 million VND | +400 million VND | Operations report Q3 2026 (assumed volume) |
| 3 | 600 million VND | 1,100 million VND | +500 million VND | Same |
| 4 | 600 million VND | 1,100 million VND | +500 million VND | Same |

At the rate finance named, the base case pays back in year three and the net present value is positive; the low case, with flat order volume, does not pay back within the contract, and the plan says so.
