# Contract: how vibebiz chooses and shows frameworks (spec 004)

This replaces the framework rules of spec 001 FR-037 and `core/router.md` "Frameworks" where they differ. Everything else in those rules stands.

## Who chooses

- vibebiz chooses every framework. The user never picks, ranks or names one unless they named it first (FR-001).
- The router chooses cards for the interview lenses. The plan module chooses `lens: plan` cards at packaging. A lens never picks a card itself.

## When a card is handed over

A card is handed to a lens for a category only when all of these hold:

1. The category is on the frontier with status `missing` or `partial`.
2. The card's `fills` includes the category, and the card's `lens` is the module that fills it.
3. The card is not already in that category's `frameworks`.
4. No other card is handed for that category in this round.
5. The Cynefin depth allows it: none at `clear` unless the user asked by name.
6. Its `needs` are met: one listed card is applied, or every category that card fills is `clear` (research R12).
7. No card of its `instead_of` group is already applied to this category.

There is no limit per lens or per idea. The round budget is the only bound. When several cards pass, the router prefers a card that an applied card `feeds`. Among the rest it picks the card whose "When to use" best matches the idea and depth. It writes one line in `framework_reasons`, naming the feeding card when there is one.

## Context passed on

When the handed card is fed, the hand-off names the feeding card and its `passes` text. The lens reads that result from the files and does not ask again what it answers (research R13).

## Revisits

A `supersede` in a category listed in an applied card's `revisit_when`, or the events `board-changes` and `tech-review` recorded by `continue`, sends the card back. Its category becomes `partial` with the reason "revisit: <card id>". The card is redone first, then the applied cards it feeds, in feed order, inside the round budget, asking only about the change (research R14).

Planning cards follow conditions 2 to 4, 6 and 7 at packaging, against the categories still open or shaped from the files (`core/plan.md` §6).

## How it is asked

- The card's questions are asked in everyday words through the ask protocol.
- No question, option, description or preview contains a framework's name or asks the user to choose a method (FR-002).

## How it is shown

- Each applied card is named once in the spec section it shaped, and in `frameworks[]` of the slide its category feeds, as `{id, name, result}` (unchanged from `contracts/exports.md`).
- Several cards may appear across a package, and more than one on a slide. A result that does not fit the slide's fixed layout goes to the appendix (FR-008).
- The board view's pyramid principle / SCQA is a rule of the export guidelines, not a card, and is not listed in `frameworks[]`.

## By name

Unchanged (spec 001 FR-038), with one edit. The "does not fit" reason "its lens already has two cards" becomes "this part is already covered by another method".
