# Patterns

Cost bands are rough sizes of the first working version, **not tech-reviewed**: small is weeks of one person's effort on existing tools, medium is a small team for a few months, large is a sustained team effort with new data work.

## 1. Customer-service chatbot
- **name**: Customer-service chatbot
- **data_needed**: past customer questions and the answers staff gave (a few hundred at least); current policies for shipping, returns, exchanges and size charts; order status from the order system if the bot should answer "where is my order"; a list of questions that must go to a person.
- **rough_cost**: small for fixed-question menus and policy answers; medium when it must look up orders (not tech-reviewed).
- **risks**: a wrong or invented answer about policy or price; customer frustration when no human is reachable; private order data shown to the wrong person; answers that go stale when policy changes.
- **prior_art**: retailers widely use chat assistants for frequently asked questions and order tracking, with hand-off to staff for complaints and exceptions. Common practice is to start with the ten most frequent questions.
- **fit**: rule or automation for the top fixed questions (a menu or keyword reply); AI only when the questions are varied free text and a wrong answer is cheap or a person reviews it.

## 2. Size and fit recommendation
- **name**: Size and fit recommendation
- **data_needed**: size charts per style or brand; past orders with returns and the return reason; customer measurements or past purchase sizes when the customer agrees to share them.
- **rough_cost**: small as a size chart plus a few questions; large as a learned recommendation per style (not tech-reviewed).
- **risks**: a confident wrong size raises returns instead of lowering them; sparse data for new styles; privacy of body measurements; insensitive treatment of body types.
- **prior_art**: fit questionnaires and size guides are common on fashion sites; some suggest a size from past purchase and return history. Results depend heavily on the quality of return reasons.
- **fit**: rule for a size-chart lookup by height and weight; AI only if return data is rich and the cost of a return is high enough to justify it.

## 3. Demand forecasting and store allocation
- **name**: Demand forecasting and store allocation
- **data_needed**: sales by style, size, shop and week for at least two seasons; daily stock levels (to tell no-sale from no-stock); promotion and calendar history; style attributes; shop attributes.
- **rough_cost**: medium; large when starting from messy stock history (not tech-reviewed).
- **risks**: new styles have no history; a forecast built on sales understates demand where stock ran out; shops follow or ignore the allocation; a wrong forecast ties up cash in the wrong stock.
- **prior_art**: retail planning commonly uses past sales, seasonality and comparison with similar styles; allocation often follows simple rules such as each shop's share of sales with a minimum display quantity.
- **fit**: rule for allocation by shop sales share and a minimum display; automation for weekly recalculation; AI when the number of styles, sizes and shops makes manual and rule-based planning clearly miss.

## 4. Replenishment
- **name**: Replenishment
- **data_needed**: stock by shop and size per day; sales rate; supplier or warehouse lead times; minimum and maximum levels; order rules.
- **rough_cost**: small for reorder points and alerts; medium for suggested orders across shops and a warehouse (not tech-reviewed).
- **risks**: over-ordering lines that are about to end; out-of-stock when lead times are longer than assumed; rules that ignore season; people stop checking the suggestions.
- **prior_art**: reorder-point and min-max rules are long-standing inventory practice; fashion uses them mostly for basics and continuing lines, less for short-life seasonal styles.
- **fit**: rule (min-max levels) for basics; automation for the daily check and a suggested transfer list; AI is rarely needed for the first version.

## 5. Markdown optimization
- **name**: Markdown optimization
- **data_needed**: price history per style and week; sales and stock by week; cost of each style; calendar of events; competitor price checks if available.
- **rough_cost**: small for a rule-based markdown calendar; large for learned price optimization (not tech-reviewed).
- **risks**: training customers to wait for cuts; selling below cost; effects confused with seasonality (see the traps in the retail-fashion pack); brand image; price differences across channels causing complaints.
- **prior_art**: retailers commonly use a markdown schedule by weeks on sale and sell-through targets; optimization tools estimate how demand responds to price from past data and need clean price history.
- **fit**: rule for a schedule by weeks on sale and sell-through; AI only with long, clean price history and a team to monitor the results.

## 6. Customer win-back reminders
- **name**: Customer win-back reminders
- **data_needed**: customers identified at purchase (phone or account) with last purchase date and history; consent to contact and the channel (chat app, SMS, email); an offer budget; a comparison group that does not receive reminders.
- **rough_cost**: small for a rule-based reminder (no purchase in 90 days) through an existing channel; medium with segments and personalization (not tech-reviewed).
- **risks**: messages to people who did not consent; too many messages cause blocks and complaints; discounts given to customers who would return anyway; unreliable customer identification at the shop.
- **prior_art**: campaigns for lapsed customers by recency of purchase are standard retail practice; the effect is judged against a holdout group that receives nothing.
- **fit**: rule (days since last purchase) plus automation (scheduled send); AI only to choose the best offer per customer, when there is enough history to justify it.

## 7. Review summarization
- **name**: Review summarization
- **data_needed**: customer reviews and comments by style (website, marketplace, chat, surveys); a short list of themes that matter (size, fabric, colour, delivery).
- **rough_cost**: small (not tech-reviewed).
- **risks**: summaries that hide a minority issue such as a defect; fake or biased reviews; mixed languages and slang; staff trusting a summary without reading examples.
- **prior_art**: sellers group reviews by theme (size, quality, shipping) and show the share of reviews per theme; language models are commonly used to draft such summaries from review text.
- **fit**: AI (free text is the input), with a person reading the summary and sample reviews before decisions; a keyword count is the rule-based alternative for a few fixed themes.

## 8. Automated daily and weekly reporting
- **name**: Automated daily and weekly reporting
- **data_needed**: sales, stock and traffic by shop and channel from the existing systems; agreed metric definitions (see the retail-fashion pack); the people who receive each report; the time each report is due.
- **rough_cost**: small (not tech-reviewed).
- **risks**: reports that contradict each other because definitions differ; numbers sent with stale or partial data; nobody reads them; sensitive figures sent to too many people.
- **prior_art**: scheduled dashboards and emailed summaries are routine in retail; the main work is agreeing definitions and fixing source data, not the report itself.
- **fit**: automation (scheduled report from fixed formulas); AI only for an optional plain-language commentary that a person checks before it goes out.

## 9. Cash-on-delivery reconciliation
- **name**: Cash-on-delivery reconciliation
- **data_needed**: orders marked cash-on-delivery with amounts; carrier statements and remittance reports; return and refused-delivery records; payment dates; bank receipts.
- **rough_cost**: small for matching by order number; medium when carriers use different formats or the order number is missing (not tech-reviewed).
- **risks**: unmatched amounts hide missing money; carrier fees and deductions differ from the contract; late statements; manual fixes without a record.
- **prior_art**: finance teams commonly match carrier remittances to orders by order number and flag differences for review; the same approach applies to any payment processor settlement.
- **fit**: rule and automation (matching by order number and amount, flagging differences); AI only for messy data without a shared key, with a person approving each match.
