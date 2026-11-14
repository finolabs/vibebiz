---
id: moscow
name: MoSCoW
lens: plan
fills: [E]
core: true
diagram_type: none
origin: Dai Clegg, from the DSDM method
---

# MoSCoW

A plain-language scope cut. Sort every requested capability into Must, Should, Could and Won't (this time), so the first release is small enough to finish and still useful.

## When to use

- The list of wanted features is long and the first release must be smaller.
- Several stakeholders each want something different and the scope (E) needs a fair way to choose.
- The plan needs a clear line between the first release and what comes later.

## When not to use

- The list is two or three items; a decision is enough.
- The outcome is not defined (C is not Clear): without it, nothing can be called a Must.
- To rank by value for money. MoSCoW sorts by necessity, not by return; use a value-effort view for that.

## Inputs

- The candidate capabilities, in the user's own words.
- The outcome and the kill criterion the first release must serve.
- Hard limits: budget ceiling, date, rules that always need a person's approval.
- Who asked for each capability, when known.

## Questions

1. "Nếu bản đầu tiên chỉ làm được ba việc, ba việc nào để ý tưởng này vẫn đạt mục tiêu?" (Must)
2. "Việc nào không có thì bản đầu vẫn chạy được nhưng nhân viên sẽ khó chịu?" (Should)
3. "Việc nào nghe hay nhưng bỏ đi cũng không ai phản đối?" (Could)
4. "Việc nào anh/chị đồng ý để dành cho lần sau, và vì sao?" (Won't this time)
5. "Nếu thiếu một việc Must, anh/chị có còn ra mắt không?" (Tests that a Must is truly a Must.)

## Writes to

- Scope and behavior (E): User Stories and Functional Requirements for the Musts; the rest under what comes later.
- Out of scope list, with the reason for each Won't.
- Plan: first-release scope and the next steps after it.

## Common misuse

- Everything becomes a Must. Keep Musts to what the outcome cannot do without, and challenge each one.
- Reading Won't as "never"; it means "not in this release".
- Sorting without a reference to the outcome, so the loudest voice wins.
- Hiding the Won'ts; the board and the tech team both need to see them.

## Fashion example (fictional)

For a fictional "Hoa Đăng" store-pickup idea, the requested list: reserve online, SMS when ready, fitting-room hold, loyalty points on pickup, gift wrapping, live stock count. Must: reserve online, live stock count (without it shoppers arrive to missing sizes). Should: SMS when ready. Could: fitting-room hold. Won't this time: loyalty points on pickup, gift wrapping. The director first marked five items Must; the check "would we still launch without it?" moved three of them down, and the first release shrank to two stores and two Musts.
