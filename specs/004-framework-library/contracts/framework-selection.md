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

There is no limit per lens or per idea. The round budget is the only bound. When several cards pass, the router picks the card whose "When to use" best matches the idea and depth, and writes one line in `framework_reasons`.

Planning cards follow conditions 2 to 4 at packaging, against the categories still open or shaped from the files (`core/plan.md` §6).

## How it is asked

- The card's questions are asked in everyday words through the ask protocol.
- No question, option, description or preview contains a framework's name or asks the user to choose a method (FR-002).

## How it is shown

- Each applied card is named once in the spec section it shaped, and in `frameworks[]` of the slide its category feeds, as `{id, name, result}` (unchanged from `contracts/exports.md`).
- Several cards may appear across a package, and more than one on a slide. A result that does not fit the slide's fixed layout goes to the appendix (FR-008).
- The board view's pyramid principle / SCQA is a rule of the export guidelines, not a card, and is not listed in `frameworks[]`.

## By name

Unchanged (spec 001 FR-038), with one edit. The "does not fit" reason "its lens already has two cards" becomes "this part is already covered by another method".
