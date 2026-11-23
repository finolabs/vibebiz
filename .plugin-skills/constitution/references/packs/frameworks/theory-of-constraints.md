---
id: theory-of-constraints
name: Theory of Constraints
lens: challenge
fills: [D]
core: false
diagram_type: flowchart
origin: Eliyahu M. Goldratt, "The Goal" (1984), with its five focusing steps
needs: []
feeds: []
instead_of: []
revisit_when: [D]
---

# Theory of Constraints

A flow of work moves only as fast as its slowest step. This card finds that step and tests every alternative against it: an idea that adds speed anywhere else changes nothing. It orders the options from cheapest to dearest: use the slow step better, make the other steps serve it, and only then buy more capacity for it.

## When to use

- The idea speeds up a flow of work with several steps in a row (orders through a warehouse, replenishment, production, returns), and work piles up in front of one step while others wait.
- Alternatives (D) are open, or the chosen alternative adds capacity at a step that may not be the slowest one (a machine, more staff, software).

## When not to use

- Errors or waste are spread across every step and nothing queues at any one of them: improving the whole process step by step fits better with `lean-dmaic`.
- The cause of the slowness is unknown and could be many things (people, method, data, suppliers): find the cause first with `fishbone`.
- There is no flow of work at all (a pricing or marketing idea).

## Inputs

- The problem and the steps of the flow as the files or the user describe them.
- Where work waits, from the user's most recent busy period.

## Questions

Ask about one recent busy day or sale period, never an average. Plain words, one round at most.

1. "Trong đợt cao điểm gần nhất, việc dồn lại chờ ở khâu nào nhiều nhất? Khâu nào lại hay ngồi chờ việc?" (Offer the steps on file as options.)
2. "Khâu đó có lúc nào bị bỏ trống không: nghỉ giữa ca, chờ hàng, làm việc khác, làm lại hàng lỗi?"
3. "Có việc nào khâu đó đang làm mà khâu khác hoặc người khác làm thay được không?"
4. "Nếu khâu đó nhanh hơn, khâu nào sẽ thành chỗ dồn tiếp theo?"
5. Ask how the chosen alternative helps that step, offering the alternatives on file and "chưa rõ" as options.

## Writes to

- Alternatives (D): the slowest step, the cheap options first (use the step better, make the others serve it), then added capacity, and whether the chosen idea touches the slowest step; an idea that does not is recorded as a finding for the user to decide on.
- Assumptions: which step is slowest, as the user stated it, until a measurement confirms it.
- Open questions: queue sizes or waiting times nobody present knows, as a measurement plan.
- Diagram brief (flowchart): the steps in order, with the slowest step marked and the next one likely to slow down.

## Common misuse

- Naming the slowest step from where the noise is; it is where work waits, as the user observed it.
- Jumping to buying capacity before the cheaper options are on the table.
- Speeding up a step that is not the slowest and counting it as a gain.
- Inventing throughput, queue lengths or waiting times. Record only figures the user gives, with their source.

## Fashion example (fictional)

The fictional chain "Gió Nam" plans to buy an automatic packing machine because sale orders ship three days late. The warehouse lead says orders pile up before the checking desk (two checkers per shift) while packers wait. The card records that the machine speeds up a step that is already waiting, and lists cheaper options first: packers help check during sales, checking runs through breaks, damaged items are set aside before checking. The machine stays an alternative for later, once checking keeps pace.
