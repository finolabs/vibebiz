---
id: sipoc
name: SIPOC (with a Requirements column)
lens: solution-sketch
fills: [E, J]
core: false
diagram_type: none
origin: SIPOC from the quality-management and Six Sigma practice (Suppliers, Inputs, Process, Outputs, Customers); the Requirements column follows the SIRPOC variant used in process improvement
needs: []
feeds:
  - to: journey-map-service-blueprint
    passes: the hand-offs that reach the customer
  - to: driver-tree
    passes: the step whose delay to measure
  - to: lean-dmaic
    passes: the process map for Define
  - to: raci
    passes: owner of each step
instead_of: []
revisit_when: [E, J]
---

# SIPOC (with a Requirements column)

A one-page outline of an internal process before anyone redesigns it. It names who supplies what, what goes in, the few big steps, what comes out, who receives it, and what each receiver needs from it. It draws the boundary of an automation idea: where the process starts, where it ends, and which hand-offs the idea must keep working.

## When to use

- The idea changes or automates an existing internal process with hand-offs between people, teams or systems (stores to warehouse, warehouse to transport, buying to finance).
- Scope (E) is open: you cannot yet say where the process starts and stops, or which steps the first release covers.
- Failures seem to happen at hand-offs (an order lost in chat, a file rekeyed by hand), and the edge cases (J) are not listed.

## When not to use

- The idea is mainly a customer journey across channels with no internal hand-off: use `journey-map-service-blueprint`, which follows the customer step by step.
- The process is already mapped and the question is how to improve or measure it: `lean-dmaic` fits better.
- The problem is still unclear (A is not Clear): outlining a process around an unproven problem fixes the wrong thing.

## Inputs

- The problem statement (from problem-framing) and the process the idea touches.
- The teams and systems the user names: stores, warehouse, transport, buying, finance, the sales or stock system, chat groups, spreadsheets.
- The most recent real run of the process the user remembers, start to end.

## Questions

Ask about one real run of the process, never an average week. Plain words, one round at most.

1. "Lần gần nhất việc này diễn ra, nó bắt đầu từ đâu và kết thúc ở đâu? Ví dụ từ lúc cửa hàng thấy thiếu hàng đến lúc hàng lên kệ."
2. "Ở giữa có những bước lớn nào? Kể bốn đến sáu bước theo thứ tự là đủ." (Offer the steps already named as options.)
3. "Ai hoặc bộ phận nào đưa thông tin hay hàng vào quy trình, và họ đưa cái gì? Ví dụ cửa hàng gửi danh sách thiếu, kho gửi phiếu xuất."
4. "Cuối quy trình có gì được tạo ra, và ai nhận nó?"
5. "Người nhận cần thứ đó đúng như thế nào thì mới dùng được: đủ mã, đúng ngày, đúng định dạng?" (The Requirements column.)
6. "Ở bước bàn giao nào việc hay bị chậm, thất lạc hoặc phải làm lại?"

Use the answers to write one SIPOC table for the process today, and a second one for the process after the idea when the user has described it, with the same steps in the same order so the difference is visible.

## Writes to

- User Stories and Functional Requirements (E): the process boundary, the steps the first release covers, and what stays manual.
- Edge Cases (J): the hand-offs named in question 6 and what happens when an input is missing or late.
- Key Entities and Assumptions: the inputs and outputs named in questions 3 and 4, and the systems that hold them. These feed the clarify module's data and integration questions; they do not fill G or H by themselves.
- Diagram brief: none. Show the SIPOC as a table with the columns Suppliers, Inputs, Process, Outputs, Customers, Requirements.

## Common misuse

- Listing twenty detailed steps; SIPOC keeps four to six big steps, and the detail belongs to a later process map.
- Filling the Requirements column with what the team thinks the receiver wants; record only what the user states, or mark it as an open question.
- Treating every supplier and customer as external; in retail operations most of them are internal teams.
- Inventing volumes, lead times or error rates for a step. Record only figures the user gives, with their source, and turn a missing one into a measurement plan.

## Fashion example

The fictional chain "Lụa Mới" has 20 stores. Each Monday store managers post their shortfalls in a chat group; the central warehouse copies them into a spreadsheet, picks the stock and books trucks.

| Suppliers | Inputs | Process | Outputs | Customers | Requirements |
|---|---|---|---|---|---|
| Store managers | List of missing sizes per item | 1. Post shortfalls in chat | Replenishment order | Central warehouse | Item code and size, by Monday noon |
| Central warehouse | Stock on hand | 2. Collect orders in a spreadsheet; 3. Pick and pack | Packed cartons, dispatch note | Transport team | One dispatch note per store |
| Transport team | Truck schedule | 4. Load and deliver | Delivered stock | Stores | On the shelf before Friday |

The idea, an automatic replenishment order built from sales, removes steps 1 and 2. The table shows that the warehouse still needs the order by Monday noon with item codes, and that the transport schedule is outside the first release.
