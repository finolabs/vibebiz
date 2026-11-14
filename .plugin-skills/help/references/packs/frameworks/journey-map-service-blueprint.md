---
id: journey-map-service-blueprint
name: Customer journey map and service blueprint
lens: solution-sketch
fills: [E, J, L]
core: true
diagram_type: swimlane
origin: Service blueprint by G. Lynn Shostack; journey mapping from service-design practice
---

# Customer journey map and service blueprint

One card, two layers. The journey map follows the customer step by step across store, online and after-sale. The blueprint adds the lanes underneath: what store staff, the warehouse and the systems must do at each step. Together they show the journey before and after the idea, which is the first diagram of every idea.

## When to use

- The idea changes something a shopper or a store employee does, and the journey crosses more than one place (browse online, try in store, pay at the counter, return by courier).
- Scope (E) is still vague: you cannot yet say which first journey stands alone.
- You suspect failures hide at hand-offs (online order, store pickup, stock check) and edge cases (J) are not yet listed.
- Staff will do different work after the idea ships (L).

## When not to use

- The idea is a pure back-office report with no customer or store step; a simple list of steps is enough.
- The problem is still unclear (A is not Clear): mapping a journey around an unproven problem produces a pretty picture of the wrong thing.
- The user has already described one short journey fully and nothing crosses a channel.

## Inputs

- The problem statement and the main person affected (from problem-framing).
- The channels involved: store, website or app, chat, marketplace, delivery.
- The most recent real occurrence the user remembers, told step by step.
- Which systems or teams touch each step, as far as the user knows.

## Questions

Ask about one real occurrence, never an average day. Plain words, one round at most.

1. "Anh/chị kể lại lần gần nhất một khách đi từ lúc tìm đến lúc nhận hàng nhé: bước đầu tiên là gì, rồi tiếp theo?"
2. "Ở bước nào khách hoặc nhân viên phải chờ, hỏi lại hay làm lại?" (Offer the steps already named as options.)
3. "Ở mỗi bước, ai ở phía sau lo việc đó: nhân viên cửa hàng, kho, chăm sóc khách hàng, hay hệ thống?"
4. "Sau khi có ý tưởng này, bước nào biến mất, bước nào mới xuất hiện, và nhân viên nào đổi việc?"
5. "Điều gì xảy ra khi bước đó hỏng, ví dụ hết size, hàng kẹt ở kho, khách đổi ý?"

Use the answers to draw two journeys, before and after, with the same steps in the same order so the difference is visible.

## Writes to

- User Stories: the first journey (P1) and the ones that follow it, from the "after" journey.
- Edge Cases: the failures named in question 5.
- Cost & Risk and Plan: the people whose work changes (category L).
- Diagram brief: a swimlane with the customer on top and staff, back office and systems below; message "what changes for the customer and for the staff". Render only through the diagram companion; without it, show a step table.

## Common misuse

- Drawing the ideal journey instead of the real one; ask for the last real case.
- Showing only the customer lane and forgetting the staff and back-office lanes, which is where the cost and the risk sit.
- Mapping every journey at once; map one first journey that works on its own.
- Inventing times or conversion numbers for steps. Record only what the user states, with its source.

## Fashion example (fictional)

A sales director of a fictional chain, "Lụa Phố", wants shoppers to reserve a size online and try it in store. The real last case: a shopper saw a dress on the app, drove to the store, found size M missing, left. The "before" journey has five steps and ends with a lost sale. The "after" journey adds a stock check before the reservation and a fitting-room hold, so the staff lane gains two tasks: pulling the item and releasing the hold after 2 hours. The edge cases that surface: size reserved twice, shopper arrives after the hold ends, store stock count is wrong. The staff change goes to category L: the fitting-room team needs a short routine and a daily check.
