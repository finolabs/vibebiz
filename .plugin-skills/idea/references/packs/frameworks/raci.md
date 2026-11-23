---
id: raci
name: RACI
lens: plan
fills: [B, L]
core: false
diagram_type: none
origin: Responsibility assignment matrix, a long-standing project management practice
needs: []
feeds:
  - to: adkar
    passes: who must adopt
  - to: kotter
    passes: who leads the change
instead_of: []
revisit_when: [B, L]
---

# RACI

A table of who does what in a process that several teams share. For each step, one person or team is marked for each role: who does the work, who answers for the result (exactly one), who must be asked before, and who is told after. Gaps and overlaps in the table are the plan's work items.

## When to use

- Several teams touch one process (stores, online customer care, warehouse, finance) and nobody can say who approves a step.
- Users and stakeholders (B) or organizational change (L) is Missing or Partial because ownership of the new steps is unclear.
- Past disputes came from two teams each thinking the other one decides, or from a step nobody owned.

## When not to use

- One team does the whole process; there is no hand-off to assign.
- Owners are clear and the open question is whether staff will take up the change: `adkar` fits better, since it finds the step where a group is stuck.
- The change reshapes the whole company and needs leaders to drive it: `kotter` fits better.

## Inputs

- The steps of the process, from the solution flow, the journey map or the process map when they exist.
- The teams and roles involved, with a named person per role where the user can give one.
- Past disputes or dropped steps.

## Questions

Ask step by step, starting with the step that caused the most disputes.

1. "Ở bước này, ai là người trực tiếp làm?"
2. "Nếu bước này sai, ai là một người chịu trách nhiệm cuối cùng?"
3. "Ai cần được hỏi ý kiến trước khi làm, và ai chỉ cần được báo sau?"
4. "Có bước nào hiện chưa ai nhận, hoặc hai bộ phận cùng nghĩ mình quyết không?"

An answer nobody present can give becomes an open question naming the step and the role.

## Writes to

- Users and stakeholders (B): the teams and roles per step, with the one accountable owner.
- Cost & Risk and Plan (L): the owners named in the rollout, steps with no owner or two owners as risks to resolve before the pilot.
- Open questions: roles the user could not assign.

## Common misuse

- Two accountable owners for one step; the table only works with exactly one.
- Marking everyone as "must be asked", which slows every step.
- Filling the table from the org chart instead of from what happens today.
- Leaving it out of the rollout plan; the table matters when a step goes wrong in week one.

## Fashion example (fictional)

A fictional chain, "Sen Vàng", lets online shoppers return goods in any store. Today a store manager waits for online customer care, which waits for finance, before a refund goes out, and shoppers wait five days. The table shows the store does the check, online customer care answers for the refund, finance is told after, and the warehouse is asked before only for damaged goods. The step "who decides a damaged item is the shopper's fault" had no owner; it becomes the first item to settle before the pilot.
