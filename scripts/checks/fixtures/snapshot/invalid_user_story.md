# Feature Specification: Weekly sales summary for store managers

**Feature Branch**: `002-weekly-sales-summary`

**Created**: 2026-11-12

**Status**: Draft

**Input**: User description: "A fictional electronics retailer wants a weekly summary"

## Problem & Why

Store managers of a fictional chain build the weekly summary by hand.

## Outcome

Summary ready by Monday 9:00 for every store.

## Alternatives

Do nothing; a shared spreadsheet; buy a reporting tool; build.

## Cost & Risk

Size S.

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Nhắc khách cũ

A store manager opens the summary on Monday.

### Edge Cases

- A store has no sales that week.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The system MUST send the summary every Monday.

### Key Entities

- **Store**: one physical shop.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: 95% of summaries arrive before 9:00.

## Assumptions

- Sales data is complete by Sunday night.
