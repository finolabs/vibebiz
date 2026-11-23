---
id: rice-ice
name: RICE and ICE scoring
lens: plan
fills: [E]
core: false
diagram_type: none
origin: RICE from Sean McBride at Intercom (reach, impact, confidence, effort); ICE from Sean Ellis's growth practice (impact, confidence, ease)
needs: []
feeds:
  - to: moscow
    passes: the scored list to cut
instead_of: []
revisit_when: [E, board-changes]
---

# RICE and ICE scoring

A way to put a long list of candidate improvements in order with a rough score each. RICE multiplies how many people an item reaches in a period, how much it moves each of them, and how sure the team is, then divides by the effort. ICE drops reach and uses impact, confidence and ease, for lists where reach is about the same or unknown. The score is a conversation aid: it makes the team say its assumptions out loud, item by item.

## When to use

- The scope (E) is a long list of candidate items (roughly eight or more) competing for one team's time over the next quarters.
- The items reach very different numbers of customers or staff, and a count exists or can be read from a report (page views, orders, store visits, tickets): use RICE. When reach is similar or nobody can count it: use ICE.
- People argue about order by loudness; the board wants to see why item 1 comes before item 9.

## When not to use

- The question is what a first release with a fixed date or budget must hold to work at all: `moscow` fits better, because it sorts by necessity, not by score.
- The list is short (about ten items or fewer), nobody has counts, and the team wants a quick sort into quick wins and big bets: `value-effort` fits better.
- The outcome is not set (C is not Clear): impact has nothing to be measured against.

## Inputs

- The candidate items, in the user's own words, and who asked for each.
- The outcome and its baseline from the outcome lens; impact is scored against it.
- For each item: what it touches (a page, a store step, a group of customers) and the report that counts it, with source and period.
- The team that does the work and a rough effort per item from that team.

## Questions

Ask about the items already listed, one round at most; never ask the user to score with a formula.

1. "Mỗi việc trong danh sách chạm tới bao nhiêu khách hoặc nhân viên mỗi tháng? Anh/chị lấy số này ở báo cáo nào?" (Offer the report the files name; a count nobody has becomes an open question.)
2. "Với một người được chạm tới, việc này giúp nhiều, vừa hay ít cho mục tiêu đã đặt?"
3. "Mình chắc đến đâu về mức giúp đó: đã có số đo, có ví dụ tương tự, hay mới là cảm nhận?"
4. "Đội làm ước mỗi việc mất bao lâu: vài ngày, vài tuần hay vài tháng?"

Reach comes only from a count on file or one the user gives with its source; an effort is the doing team's rough estimate, labelled "not tech-reviewed". A figure nobody present can give becomes an open question (ask protocol rules 5 and 10).

## Writes to

- Scope and behavior (E): the ordered list with each item's reach and its source, impact, confidence and effort, the score, and the cut line for the next quarters.
- Assumptions: each confidence that rests on a feeling rather than a measure.
- Diagram brief: none. Show a table with the columns Item, Reach (source), Impact, Confidence, Effort, Score.

## Common misuse

- Treating the score as exact; two items a few points apart are a tie for the team to decide.
- Guessing reach to fill the column. A missing count is an open question.
- Scoring confidence high for an item nobody has tested.
- Letting effort come from the person who wants the item rather than the team that builds it.

## Fashion example (fictional)

The fictional chain "Mây Chiều" has 16 website ideas and four people. Reach comes from the October page-view report; efforts are the website team's rough estimates, "not tech-reviewed".

| Item | Reach a month (page views report) | Impact | Confidence | Effort | Score |
|---|---|---|---|---|---|
| Filter by sizes in stock | 120,000 listing views | Medium | Measured in a one-month test on dresses | 2 weeks | High |
| One-step checkout | 9,000 checkout visits | High | Feeling | 8 weeks | Medium |
| Outfit suggestions | 40,000 product views | Low | Feeling | 6 weeks | Low |

The size filter goes first; one-step checkout waits for a test that turns its confidence into a measure.
