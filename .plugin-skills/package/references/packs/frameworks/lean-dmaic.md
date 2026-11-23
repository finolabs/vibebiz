---
id: lean-dmaic
name: Lean and DMAIC
lens: solution-sketch
fills: [E, J]
core: false
diagram_type: timeline
origin: Lean from the Toyota Production System (Taiichi Ohno) and its later Western description; DMAIC (Define, Measure, Analyze, Improve, Control) from the Six Sigma practice
needs: [sipoc]
feeds:
  - to: test-and-control-pilot
    passes: the improvement to prove
instead_of: []
revisit_when: [E, J]
---

# Lean and DMAIC

A disciplined way to improve a process that already runs and is already outlined: define the defect or waste, measure it on today's process, find its cause, make one improvement, and set controls so the gain holds. It turns "make the process better" into one first release with a measured target and a way to keep it.

## When to use

- The idea improves an existing, repeating process that is already outlined (its steps, inputs and receivers are on file, for example from the process outline card).
- The trouble is defects, rework, waste or uneven results spread over the steps, and there is or can be a measure of it.
- Scope (E) is open on which improvement comes first and how the result is held; or edge cases (J) are open on what happens when the improved step fails.

## When not to use

- The process has not been outlined yet (where it starts and ends, who hands what to whom): outline it first with `sipoc`.
- Work piles up in front of one step while others wait: the slowest step decides the speed, and `theory-of-constraints` fits better.
- The idea creates a new process or a customer-facing feature rather than improving one that runs.

## Inputs

- The process outline on file (steps, inputs, outputs, receivers, requirements).
- The defect or waste and its measure, with source, from the problem and outcome sections.

## Questions

Ask about the outlined process and one recent period. Plain words, one round at most; skip what the outline already answers.

1. "Trong các bước đã vẽ, lỗi hoặc việc phải làm lại xảy ra nhiều nhất ở bước nào? Kỳ gần nhất có ghi lại không, ghi ở đâu?" (Offer the outlined steps as options.)
2. "Theo những người làm bước đó, vì sao lỗi xảy ra: thiếu hướng dẫn, dữ liệu vào sai, dụng cụ, hay quá tải?"
3. "Bản đầu chỉ sửa một chỗ thì nên sửa chỗ nào, và những bước nào giữ nguyên?"
4. "Sau khi sửa, ai sẽ theo dõi con số đó hàng tuần, và nếu nó tăng lại thì làm gì?"
5. "Nếu bước đã cải tiến trục trặc (thiết bị hỏng, người mới, hàng lạ), quy trình chạy tiếp thế nào?"

## Writes to

- User Stories and Functional Requirements (E): the one improvement in the first release, the steps it changes, the steps that stay as they are, and the control that holds the gain (who checks which figure, how often, what triggers action).
- Edge Cases (J): what happens when the improved step fails (question 5).
- Outcome: the measure from question 1 as the baseline when the files lack one, with its source; otherwise a measurement plan.
- Diagram brief (timeline): the five phases (define, measure, analyze, improve, control) with what each produces for this idea.

## Common misuse

- Starting without an outline of the process; the improvement then fixes a step that may not exist as described.
- Improving several steps at once; the first release changes one and measures it.
- Skipping the control phase, so the gain fades after the project ends.
- Inventing defect rates or cycle times. Record only figures the user gives, with their source, and turn a missing one into a measurement plan.

## Fashion example (fictional)

The fictional chain "Gió Nam" has outlined its returns process at the central warehouse: receive, check condition, sort for resale, repair or disposal, enter in the system, shelve. About 12% of returns are sorted into the wrong condition (the warehouse check log, October 2026, measured). Checkers say the cause is no shared description of each condition. The first release adds a condition checklist on a tablet at the checking step only; the warehouse lead reviews the error rate weekly and retrains when it rises above the agreed line. Entry and shelving stay as they are.
