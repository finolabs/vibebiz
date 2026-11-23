---
id: okr
name: OKR
lens: outcome
fills: [C, O]
core: false
diagram_type: tree
origin: Objectives and key results, developed by Andy Grove at Intel in the 1970s and spread by John Doerr's writing; used here for one idea's own period, not for an organization's OKRs
needs: []
feeds:
  - to: smart
    passes: the key results to sharpen
instead_of: []
revisit_when: [C, board-changes]
---

# OKR

Sets one ambitious objective for a fixed period, usually a quarter, and three or four key results that show it was reached, each a measured change with one owning team. It lines several teams up behind one idea for that period, and its key results become the checks that tell the idea is done.

## When to use

- Several teams work on one idea for a fixed period (a quarter push, a season launch) and each is setting its own tasks.
- C lacks an outcome the teams share, or the outcome is a list of tasks rather than measured results.
- The ground rules record no objectives for the idea to map to, and the idea needs its own for the period.

## When not to use

- The ground rules record a strategy map, and the question is which perspective and objective the idea serves: use `balanced-scorecard`.
- There is one goal for one team, and it only needs a number, a date and an owner: use `smart`.
- The ground rules already record the organization's objectives and key results: the outcome lens maps the idea to them without a card.

## Inputs

- The period and the teams in the user's words.
- Each team's current tasks or numbers, with source and period.
- The guardrails and kill criteria already in the files.

## Questions

One round at most. Offer drafts built from the files as options.

1. "Đến cuối quý này, điều gì phải khác đi để cả các nhóm cùng thấy đợt này thành công? Nói thành một câu, chưa cần con số."
2. "Ba hoặc bốn con số nào cho thấy điều đó đã xảy ra? Mỗi con số đo một thay đổi, không phải một việc cần làm." (Offer drafts: "Tỷ lệ đơn livestream giao trong 2 ngày", "Tỷ lệ người xem đặt mua".)
3. "Mỗi con số đó hiện là bao nhiêu, lấy từ đâu, và đến cuối quý cần đạt bao nhiêu?" (the starting value is a fact to look up first; the target is the user's decision)
4. "Nhóm nào chịu trách nhiệm cho từng con số?"

## Writes to

- Outcome and measurement (C): the objective as the outcome statement, each key result with baseline, target, period and owning team, and the guardrail.
- Completion signals (O): the key results as Measurable Outcomes, each with its number and source.
- Open questions: each key result without a baseline, as a measurement plan.
- Diagram brief: a tree with the objective at the top and the key results below, each labelled with its owner.

## Common misuse

- Key results that are tasks ("làm 40 buổi phát"); a key result measures a change.
- More than four key results, or one per team member; the set stays small enough to watch weekly.
- Calling a target a commitment when the user set it as a stretch; record which it is.
- Inventing a baseline or target. Record only figures the user or the files give, with source and period.

## Fashion example (fictional)

The fictional brand "Phố Lụa" runs a livestream push in Q1 2027 with its content, online-warehouse and customer-care teams. The objective is "khách xem livestream mua và nhận hàng hài lòng như mua tại cửa hàng". Its key results are the share of viewers who order (content team), orders delivered within two days (online warehouse), and the return rate of livestream orders (customer care). Two baselines come from the channel report; the delivery baseline is missing and becomes a measurement plan.
