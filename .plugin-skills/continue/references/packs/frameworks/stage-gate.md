---
id: stage-gate
name: Stage-gate rollout
lens: plan
fills: [M, L]
core: false
diagram_type: timeline
origin: Robert G. Cooper's Stage-Gate process for new products, applied here to rolling out a tested change in waves
needs: []
feeds: []
instead_of: []
revisit_when: [E, M, board-changes]
---

# Stage-gate rollout

A way to roll out a change in waves, with a checkpoint between waves where someone decides to go on, change course or stop. Each wave has a scope (which stores, channel or customers), the money released for it, the people it needs, and the figures read at its end; each checkpoint has an owner and the go and stop conditions set in advance. The board approves the first wave's money now and the rule for releasing the rest, instead of the whole amount at once.

## When to use

- The approach is chosen and already tested on a small scale (a pilot result is on file), and the rollout to the rest of the network is still one undivided step.
- M is `missing` or `partial` because the money is not split by wave, or L because nobody owns the decision at each checkpoint.
- The rollout is large enough that stopping halfway must stay possible: many stores, a season at stake, or staff to hire or train per wave.

## When not to use

- Nothing has been tested yet and nobody knows whether the change works: `test-and-control-pilot` fits better, because the first question is a fair test against a control group, not how to roll out.
- The change is small and easy to undo (a label, a report column); one launch with a review date is enough.
- Waves are impossible because the change is all-or-nothing (a single system switched over in one night); plan the cut-over and its fallback instead.

## Inputs

- The pilot result from `## Cost & Risk` or `## Outcome`: what was tested, where, for how long, and the measured effect with its source.
- The chosen route and its decision (D-###), and the stores, channels or customers still to reach.
- The cost per store or unit from the pilot, with source and label.
- The outcome's metric, guardrail and kill criteria from `## Outcome`.

## Questions

Ask about the rollout itself, one round at most; never ask the user to name a method or draw a timeline.

1. "Sau khi thử, mình mở rộng cho bao nhiêu cửa hàng ở đợt đầu, và chọn cửa hàng nào trước?"
2. "Cuối mỗi đợt, ai là người quyết đi tiếp, sửa lại hay dừng?"
3. "Con số nào ở cuối đợt cho thấy nên đi tiếp, và mức nào thì phải dừng?" (Offer the metric and kill criteria already on file.)
4. "Mỗi đợt cần thêm bao nhiêu người và mất bao lâu để chuẩn bị?"

Money per wave comes from the cost per unit on file times the wave's size, labelled as an estimate and "not tech-reviewed"; a cost nobody can give becomes an open question (ask protocol rules 5 and 10). Never set a go or stop threshold the user did not give.

## Writes to

- Cost, resources and return (M) in `## Cost & Risk`: the waves in order, each with its scope, duration and season, the money released, the people needed, in low, base and high scenarios where the files support them.
- Organizational change (L) in `## Cost & Risk`: the owner of each checkpoint, the staff hired or trained per wave, and who keeps the change going after the last wave.
- The plan's pilot roadmap: one phase per wave and one decision point per checkpoint, with the metric, guardrail and stop condition read there.
- Diagram brief: `timeline`, one bar per wave with its months, a diamond for each checkpoint labelled with its owner and its go or stop figure.

## Common misuse

- Waves with no stop condition; a checkpoint that can only say "go" is a schedule, not a gate.
- Releasing the whole budget up front while calling it a rollout in waves.
- Reading a checkpoint in a sale week or a holiday peak, when the figures cannot show the change's effect.
- Skipping the pilot because a rollout in waves "is also a test"; the first wave has no control group.

## Fashion example (fictional)

The fictional chain "Lụa Hồng" tested a free alteration counter in 4 of its 40 stores for 12 weeks; returns for poor fit on trousers and dresses fell against 4 control stores. Packaging split the other 36 stores into three waves; costs are illustrative, assumed, and "not tech-reviewed".

| Wave | Stores | Months | Money released | Checkpoint owner | Go if | Stop if |
|---|---|---|---|---|---|---|
| 1 | 8 in the south | Feb to Apr 2027 | Cost of 8 counters | Retail director | Fit returns fall as in the pilot | Fit returns do not fall, or waits pass 30 minutes |
| 2 | 12 in the north | May to Jul 2027 | Cost of 12 counters | Retail director | Same | Same |
| 3 | 16 remaining | Sep to Nov 2027 | Cost of 16 counters | Retail director | Same | Same |

The board approves wave 1 now; waves 2 and 3 are released at their checkpoints.
