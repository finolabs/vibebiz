#!/usr/bin/env bash
# Seeds a fictional workspace (no real data). Run with: claude plugin eval ... --scaffold
set -euo pipefail
mkdir -p "$(dirname 'constitution.md')"
cat > 'constitution.md' <<'VIBEBIZ_SEED_0'
---
status: set
priorities: ["cut online returns", "keep loyal customers"]
approval_ceiling:
  amount: 300000000
  currency: VND
vertical: fashion
mandatory_approvals: ["a person approves before any promotion is sent"]
updated: "2026-11-12"
---

# Ground rules
VIBEBIZ_SEED_0
mkdir -p "$(dirname 'index.html')"
cat > 'index.html' <<'VIBEBIZ_SEED_1'
<!doctype html><html><head><meta charset="utf-8"><title>vibebiz</title></head><body><script type="application/json" id="vibebiz-data">{"workspace": {"updated": "2026-11-12", "ground_rules_status": "set"}, "ideas": [{"id": "001", "title": "Size recommendation on the website", "status": "ready", "estimate_status": "not-tech-reviewed", "coverage": {"clear": 14, "total": 15}, "next_step": "Package for the board", "outputs": [], "updated": "2026-11-12"}], "examples": []}</script></body></html>
VIBEBIZ_SEED_1
mkdir -p "$(dirname 'specs/001-size-recommendation-on-the-website/coverage.md')"
cat > 'specs/001-size-recommendation-on-the-website/coverage.md' <<'VIBEBIZ_SEED_2'
---
id: "001"
slug: size-recommendation-on-the-website
title: "Size recommendation on the website"
language: en
vertical: fashion
cynefin: complicated
status: ready
estimate_status: not-tech-reviewed
budget_rounds_used: 0
latest_export: null
next_step: "Package for the board"
created: "2026-11-12"
updated: "2026-11-12"
categories:
  A:
    status: clear
    reason: null
    prerequisites: []
    filled_by: problem-framing
    frameworks: []
    updated: "2026-11-12"
  B:
    status: clear
    reason: null
    prerequisites: [A]
    filled_by: problem-framing
    frameworks: []
    updated: "2026-11-12"
  C:
    status: clear
    reason: null
    prerequisites: [A]
    filled_by: outcome
    frameworks: []
    updated: "2026-11-12"
  D:
    status: clear
    reason: null
    prerequisites: [A, C]
    filled_by: challenge
    frameworks: []
    updated: "2026-11-12"
  E:
    status: clear
    reason: null
    prerequisites: [C, D]
    filled_by: solution-sketch
    frameworks: []
    updated: "2026-11-12"
  F:
    status: clear
    reason: null
    prerequisites: [E]
    filled_by: solution-sketch
    frameworks: []
    updated: "2026-11-12"
  G:
    status: clear
    reason: null
    prerequisites: [E]
    filled_by: clarify
    frameworks: []
    updated: "2026-11-12"
  H:
    status: deferred
    reason: "The first phase runs on the website only; marketplaces later."
    prerequisites: [E, G]
    filled_by: clarify
    frameworks: []
    updated: "2026-11-12"
  I:
    status: clear
    reason: null
    prerequisites: [E]
    filled_by: solution-sketch
    frameworks: []
    updated: "2026-11-12"
  J:
    status: clear
    reason: null
    prerequisites: [E]
    filled_by: solution-sketch
    frameworks: []
    updated: "2026-11-12"
  K:
    status: clear
    reason: null
    prerequisites: [E, G]
    filled_by: challenge
    frameworks: []
    updated: "2026-11-12"
  L:
    status: clear
    reason: null
    prerequisites: [B, E]
    filled_by: solution-sketch
    frameworks: []
    updated: "2026-11-12"
  M:
    status: clear
    reason: null
    prerequisites: [C, D, E]
    filled_by: challenge, plan
    frameworks: []
    updated: "2026-11-12"
  N:
    status: clear
    reason: null
    prerequisites: []
    filled_by: clarify
    frameworks: []
    updated: "2026-11-12"
  O:
    status: clear
    reason: null
    prerequisites: [C, E]
    filled_by: outcome
    frameworks: []
    updated: "2026-11-12"
---

# Coverage: Size recommendation on the website

| Code | Category | Status | Reason (when deferred) | Updated |
|---|---|---|---|---|
| A | Problem and why | clear |  | 2026-11-12 |
| B | Users and stakeholders | clear |  | 2026-11-12 |
| C | Outcome and measurement | clear |  | 2026-11-12 |
| D | Alternatives | clear |  | 2026-11-12 |
| E | Scope and behavior | clear |  | 2026-11-12 |
| F | AI fit | clear |  | 2026-11-12 |
| G | Data and entities | clear |  | 2026-11-12 |
| H | Integrations | deferred | The first phase runs on the website only; marketplaces later. | 2026-11-12 |
| I | Non-functional needs | clear |  | 2026-11-12 |
| J | Edge cases and failures | clear |  | 2026-11-12 |
| K | Risk and compliance | clear |  | 2026-11-12 |
| L | Organizational change | clear |  | 2026-11-12 |
| M | Cost, resources and return | clear |  | 2026-11-12 |
| N | Terminology | clear |  | 2026-11-12 |
| O | Completion signals | clear |  | 2026-11-12 |

**Clear**: 14 of 15
VIBEBIZ_SEED_2
mkdir -p "$(dirname 'specs/001-size-recommendation-on-the-website/spec.md')"
cat > 'specs/001-size-recommendation-on-the-website/spec.md' <<'VIBEBIZ_SEED_3'
# Feature Specification: Size recommendation on the website

**Feature Branch**: `001-size-recommendation-on-the-website`

**Created**: 2026-11-12

**Status**: Draft

**Input**: User description: "Online customers return too much because the size does not fit; I want something that recommends a size."

## Problem & Why

Larkspur Denim (a fictional jeans brand, 12 stores, 60% of revenue online) has a 31% online return rate, and 58% of those returns are for the wrong size. About 1,900 returned orders a month cost 52,000 VND each in two-way shipping and handling; a customer care team of 9 handles them. (Source: figures given by the sales director, 2026-11-12; not verified.)

## Outcome

Cut returns for the wrong size from 58% to 40% within 4 months of the pilot start. Guardrail: customers answer at most 3 questions, because cart abandonment is already 68%. Kill criteria: if after 2 months of pilot the wrong-size share is not below 50%, or more than 1 in 5 recommendations is reported wrong, stop and review.

## Alternatives

- Do nothing: keep paying about 99 million VND a month for wrong-size returns (1,900 orders x 58% x 52,000 VND, estimate not verified).
- Fix the process: clearer size chart, model photos with measurements, a size confirmation message before shipping.
- Buy a ready-made size tool.
- Build a recommendation from 2 years of order history and return reasons.

Proposed: fix the process now and pilot a history-based recommendation on one product group.

## AI-fit

A rule from the size chart is enough for first-time buyers; recommending from the purchase and return history of similar customers needs a statistical model. There are 2 years of order and return-reason history; body measurements do not exist. A wrong recommendation costs customer trust; at most 1 in 5 wrong is accepted. A customer care agent reviews recommendations that are more than two sizes off.

## Cost & Risk

Size M. Budget up to 250 million VND, decided this quarter (estimate not tech-reviewed). Main risks: a wrong recommendation costs trust; too many questions raise cart abandonment. The customer care team gets a new review step.

## Clarifications

### Session 2026-11-12

- Q: What makes you want to do this now? → A: Too many returns for the wrong size, 31% of online orders.
- Q: What outcome do you want? → A: Cut wrong-size returns from 58% to 40% in 4 months.
- Q: Is there a limit on asking customers? → A: No more than 3 questions, because cart abandonment is already 68%.
- Skipped: Should marketplaces be integrated from the start?

## User Scenarios & Testing *(mandatory)*

### User Story 1 - A customer gets a size recommendation while choosing jeans (Priority: P1)

An online customer picks a pair of jeans and sees a recommended size after at most 3 short questions.

**Why this priority**: This is where customers pick the wrong size, so it is the main value.

**Independent Test**: Run on one men's jeans group on the website and compare the wrong-size return rate with a control group.

**Acceptance Scenarios**:

1. **Given** a first-time customer, **When** the customer answers 3 questions about height, weight and fit, **Then** the website shows one recommended size with a short reason
2. **Given** a returning customer, **When** the customer opens a product page, **Then** the website recommends a size from past orders without asking more

---

### User Story 2 - A care agent reviews off-size recommendations (Priority: P2)

A customer care agent sees recommendations more than two sizes off the customer's past sizes and confirms or corrects them.

**Why this priority**: Protects customer trust when a recommendation may be wrong.

**Independent Test**: Create 10 fictional off-size cases and check that an agent reviews them within the day.

**Acceptance Scenarios**:

1. **Given** a recommendation more than two sizes off, **When** the order is created, **Then** the order joins the agent's review queue

---

### Edge Cases

- What if the customer buys for someone else?
- What if the customer skips all 3 questions?
- What if a new style has no order history?

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The system MUST show one recommended size after at most 3 questions.
- **FR-002**: The system MUST record the recommended size and the size the customer chose, to measure wrong-size returns.
- **FR-003**: The system MUST send recommendations more than two sizes off to a customer care agent for review.
- **FR-004**: The system MUST let the customer ignore the recommendation and choose a size.

### Key Entities *(include if feature involves data)*

- **Order**: purchase history, chosen size, return reason if any.
- **Size recommendation**: recommended size, reason, confidence, what the customer chose.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Wrong-size returns fall from 58% to 40% within 4 months (assumed, measured from order history).
- **SC-002**: No more than 1 in 5 recommendations is reported wrong.
- **SC-003**: Cart abandonment does not rise above the current 68%.

## Assumptions

- Two years of order and return-reason history is clean enough to use (not verified).
- Customers accept answering at most 3 questions.
- Marketplace integration is left for a later phase.
VIBEBIZ_SEED_3
mkdir -p "$(dirname 'specs/001-size-recommendation-on-the-website/plan.md')"
cat > 'specs/001-size-recommendation-on-the-website/plan.md' <<'VIBEBIZ_SEED_4'
---
estimate_status: not-tech-reviewed
updated: "2026-11-12"
---

# Business plan: Size recommendation on the website

## Decision requested

The board is asked to approve up to 250 million VND in year one to pilot size recommendation on one men's jeans group, decided this quarter.

## Size and scenarios

Size M (estimate not tech-reviewed).

| Scenario | Cost | Resources | Return | Time frame |
|---|---|---|---|---|
| Low | 180 million VND (assumed) | 2 people for 3 months | saves 10 million VND a month (assumed) | 4-month pilot |
| Base | 250 million VND (assumed) | 3 people for 4 months | saves about 17.8 million VND a month: 342 orders x 52,000 VND (assumed, from current return figures) | 4-month pilot |
| High | 320 million VND (assumed) | 4 people for 5 months | saves 25 million VND a month (assumed) | 4-month pilot |

## Pilot roadmap and decision points

1. Month 1: fix the process (size chart, confirmation message) and re-measure the wrong-size rate.
2. Months 2 to 3: pilot on men's jeans; decision point at the end of month 3 against the kill criteria.
3. Month 4: extend to women's jeans if wrong-size is under 50% and no more than 1 in 5 recommendations is wrong.

## Organizational change

The customer care team (9 people) gets a review step for recommendations more than two sizes off; a half-day briefing is needed.

## Ground rules check

The 250 million VND budget is under the sales director's 300 million VND approval ceiling. No conflict with the mandatory human approval step.
VIBEBIZ_SEED_4
mkdir -p "$(dirname 'specs/001-size-recommendation-on-the-website/decisions.md')"
cat > 'specs/001-size-recommendation-on-the-website/decisions.md' <<'VIBEBIZ_SEED_5'
# Decisions: Size recommendation on the website

## D-001 — Question limit

- date: 2026-11-12
- type: answer
- text: Never ask the customer more than 3 questions.
- reason: Cart abandonment is already 68%.

## D-002 — Marketplaces later

- date: 2026-11-12
- type: answer
- text: Defer marketplace integration to a later phase.
- reason: The first phase runs on the website only.
VIBEBIZ_SEED_5
mkdir -p "$(dirname 'specs/001-size-recommendation-on-the-website/assumptions.md')"
cat > 'specs/001-size-recommendation-on-the-website/assumptions.md' <<'VIBEBIZ_SEED_6'
# Assumptions: Size recommendation on the website

## A-001

- text: Two years of order and return-reason history is clean enough to use.
- tested: no
- evidence: none yet
- riskiest: true
- source: stated

## A-002

- text: Customers accept answering at most 3 questions.
- tested: no
- evidence: none yet
- riskiest: false
- source: stated
VIBEBIZ_SEED_6
mkdir -p "$(dirname 'specs/001-size-recommendation-on-the-website/open-questions.md')"
cat > 'specs/001-size-recommendation-on-the-website/open-questions.md' <<'VIBEBIZ_SEED_7'
# Open questions: Size recommendation on the website

## Q-001

- text: Which product group pilots first, men's or women's jeans?
- owner: sales director
- unblocks: pilot plan
- blocking: false
- category: E
- status: open
VIBEBIZ_SEED_7
mkdir -p "$(dirname 'specs/001-size-recommendation-on-the-website/glossary.md')"
cat > 'specs/001-size-recommendation-on-the-website/glossary.md' <<'VIBEBIZ_SEED_8'
# Glossary: Size recommendation on the website

- Wrong-size return: an order sent back where the customer's reason is that the size did not fit.
- Cart abandonment: the customer adds items to the cart but does not pay.
VIBEBIZ_SEED_8
mkdir -p "$(dirname 'specs/001-size-recommendation-on-the-website/checklists/board.md')"
cat > 'specs/001-size-recommendation-on-the-website/checklists/board.md' <<'VIBEBIZ_SEED_9'
# Definition of Ready: board

- [x] The decision, amount and deadline are stated
- [x] The problem has current figures with sources
- [x] The outcome has a baseline, target, period and kill criteria
- [x] Do nothing and fix the process were weighed
- [x] Cost and return have three scenarios, labelled not tech-reviewed
VIBEBIZ_SEED_9
mkdir -p "$(dirname 'specs/001-size-recommendation-on-the-website/checklists/tech.md')"
cat > 'specs/001-size-recommendation-on-the-website/checklists/tech.md' <<'VIBEBIZ_SEED_10'
# Definition of Ready: tech

- [x] Each user story has testable Given/When/Then scenarios
- [x] Requirements are numbered FR-### and success criteria SC-###
- [x] Data and key entities are named
- [x] AI fit records the cost of an error and the human approval point
- [x] Open questions are marked blocking or non-blocking
VIBEBIZ_SEED_10
mkdir -p "$(dirname 'specs/001-size-recommendation-on-the-website/diagrams/.keep')"
: > 'specs/001-size-recommendation-on-the-website/diagrams/.keep'
mkdir -p "$(dirname 'specs/001-size-recommendation-on-the-website/exports/.keep')"
: > 'specs/001-size-recommendation-on-the-website/exports/.keep'
