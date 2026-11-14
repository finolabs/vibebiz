# Feature Specification: [FEATURE NAME]

**Feature Branch**: `[###-feature-name]`

**Created**: [DATE]

**Status**: Draft

**Input**: User description: "$ARGUMENTS"

<!--
  vibebiz idea requirement. This file is Spec Kit 1.4.0's spec-template.md with
  vibebiz's business sections inserted before "User Scenarios & Testing".
  Rules (contracts/exports.md "Snapshot", research R3 and R5):
  - No YAML frontmatter in this file; the idea's state lives in coverage.md.
  - Keep every heading in this file exactly as written, in every output
    language. Content under the headings is in the user's language.
  - Every number carries its source, period and a measured or assumed label.
    A missing baseline becomes a measurement plan, never an invented figure.
  - Write "not yet clarified" where a field has no answer yet; never drop it.
-->

## Problem & Why

<!--
  Coverage A (problem and why) and B (users and stakeholders); filled by the
  problem-framing lens (spec Appendix C).
  - Problem statement: one sentence the user recognizes.
  - Most recent real occurrence: what happened, where, when (no hypotheticals).
  - Who suffers and how often; root cause separated from symptoms (5 Whys).
  - Current cost: hours x people x wage, lost orders or lost customers,
    each figure with source, period and measured or assumed label.
  - Why now.
  - Users and stakeholders: who uses it, who is affected, who approves,
    who may resist.
-->

[Problem statement, most recent occurrence, who suffers, root cause, current cost, why now, stakeholders]

## Outcome

<!--
  Coverage C (outcome and measurement); filled by the outcome lens.
  - The outcome, not the output ("cut messages waiting over 15 minutes by 30%",
    not "have a chatbot").
  - Driver tree: leading and lagging indicators.
  - Baseline, target and time frame per metric (source, period, label);
    a measurement plan where no baseline exists.
  - Guardrail metrics that must not get worse.
  - Kill criteria: the result that stops the idea.
  Measurable outcomes are repeated as SC-### under Success Criteria;
  testable acceptance (coverage O) goes into the user stories.
-->

[Outcome, driver tree, baseline to target with time frame, guardrails, kill criteria]

## Alternatives

<!--
  Coverage D (alternatives); filled by the challenge lens.
  Weigh every option before build is allowed (constitution Principle III):
  - Do nothing: what waiting costs (cost of inaction).
  - Fix the process: what changes without new software.
  - Buy: an existing product or service.
  - Build: the proposed solution.
  For each: expected effect on the outcome, rough cost, main risk, and why it
  was chosen or rejected (cite the D-### id in decisions.md).
-->

[Do nothing, fix the process, buy, build: effect, cost, risk, chosen or rejected and why]

## AI-fit

<!--
  Coverage F (AI fit), required when the idea involves AI; filled by the
  solution-sketch lens. Otherwise write "AI not involved" and the reason.
  - Decision: is a rule enough, is automation enough, or is AI required.
  - Data available: source, quality, owner.
  - Cost of an AI error and who carries it.
  - Human approval points.
-->

[Rule, automation or AI and why; data available; cost of an AI error; human approval points]

## Cost & Risk

<!--
  Coverage K (risk and compliance), L (organizational change) and M (cost,
  resources and return); filled by the challenge and solution-sketch lenses
  and the plan module.
  - Size: S, M or L, then cost, resources and return in low, base and high
    scenarios. Every estimate is labelled "not tech-reviewed" until the tech
    review is recorded in decisions.md.
  - Pre-mortem: the most likely reason this failed six months from now.
  - Risks with likelihood and impact; dismissed risks stay in decisions.md.
  - Compliance: personal-data law, promotion registration, labor rules.
  - Organizational change: training, changed staff KPIs, who loses
    authority or work.
-->

[Size, three scenarios, pre-mortem, risks, compliance, organizational change]

## Clarifications

<!--
  Spec Kit clarify format, appended after every question round
  (data-model "Round"). One session heading per day:

  ### Session YYYY-MM-DD

  - Q: <question> → A: <answer>
  - Skipped: <question>

  Skipped questions are never written as answers.
-->

## User Scenarios & Testing *(mandatory)*

<!--
  IMPORTANT: User stories should be PRIORITIZED as user journeys ordered by importance.
  Each user story/journey must be INDEPENDENTLY TESTABLE - meaning if you implement just ONE of them,
  you should still have a viable MVP (Minimum Viable Product) that delivers value.

  Assign priorities (P1, P2, P3, etc.) to each story, where P1 is the most critical.
  Think of each story as a standalone slice of functionality that can be:
  - Developed independently
  - Tested independently
  - Deployed independently
  - Demonstrated to users independently
-->

### User Story 1 - [Brief Title] (Priority: P1)

[Describe this user journey in plain language]

**Why this priority**: [Explain the value and why it has this priority level]

**Independent Test**: [Describe how this can be tested independently - e.g., "Can be fully tested by [specific action] and delivers [specific value]"]

**Acceptance Scenarios**:

1. **Given** [initial state], **When** [action], **Then** [expected outcome]
2. **Given** [initial state], **When** [action], **Then** [expected outcome]

---

### User Story 2 - [Brief Title] (Priority: P2)

[Describe this user journey in plain language]

**Why this priority**: [Explain the value and why it has this priority level]

**Independent Test**: [Describe how this can be tested independently]

**Acceptance Scenarios**:

1. **Given** [initial state], **When** [action], **Then** [expected outcome]

---

### User Story 3 - [Brief Title] (Priority: P3)

[Describe this user journey in plain language]

**Why this priority**: [Explain the value and why it has this priority level]

**Independent Test**: [Describe how this can be tested independently]

**Acceptance Scenarios**:

1. **Given** [initial state], **When** [action], **Then** [expected outcome]

---

[Add more user stories as needed, each with an assigned priority]

### Edge Cases

<!--
  ACTION REQUIRED: The content in this section represents placeholders.
  Fill them out with the right edge cases.
-->

- What happens when [boundary condition]?
- How does system handle [error scenario]?

## Requirements *(mandatory)*

<!--
  ACTION REQUIRED: The content in this section represents placeholders.
  Fill them out with the right functional requirements.
-->

### Functional Requirements

- **FR-001**: System MUST [specific capability, e.g., "allow users to create accounts"]
- **FR-002**: System MUST [specific capability, e.g., "validate email addresses"]
- **FR-003**: Users MUST be able to [key interaction, e.g., "reset their password"]
- **FR-004**: System MUST [data requirement, e.g., "persist user preferences"]
- **FR-005**: System MUST [behavior, e.g., "log all security events"]

*Example of marking unclear requirements:*

- **FR-006**: System MUST authenticate users via [NEEDS CLARIFICATION: auth method not specified - email/password, SSO, OAuth?]
- **FR-007**: System MUST retain user data for [NEEDS CLARIFICATION: retention period not specified]

### Key Entities *(include if feature involves data)*

- **[Entity 1]**: [What it represents, key attributes without implementation]
- **[Entity 2]**: [What it represents, relationships to other entities]

## Success Criteria *(mandatory)*

<!--
  ACTION REQUIRED: Define measurable success criteria.
  These must be technology-agnostic and measurable.
-->

### Measurable Outcomes

- **SC-001**: [Measurable metric, e.g., "Users can complete account creation in under 2 minutes"]
- **SC-002**: [Measurable metric, e.g., "System handles 1000 concurrent users without degradation"]
- **SC-003**: [User satisfaction metric, e.g., "90% of users successfully complete primary task on first attempt"]
- **SC-004**: [Business metric, e.g., "Reduce support tickets related to [X] by 50%"]

## Assumptions

<!--
  ACTION REQUIRED: The content in this section represents placeholders.
  Fill them out with the right assumptions based on reasonable defaults
  chosen when the feature description did not specify certain details.
-->

- [Assumption about target users, e.g., "Users have stable internet connectivity"]
- [Assumption about scope boundaries, e.g., "Mobile support is out of scope for v1"]
- [Assumption about data/environment, e.g., "Existing authentication system will be reused"]
- [Dependency on existing system/service, e.g., "Requires access to the existing user profile API"]
