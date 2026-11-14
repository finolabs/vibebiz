# Tech Checklist: Nhắc khách quay lại cửa hàng qua ứng dụng chat

**Purpose**: Definition of Ready for the tech view and the Spec Kit snapshot: the idea folder holds everything the tech sections need (spec Appendix D, FR-020, FR-023, FR-024)
**Created**: 2026-11-12
**Feature**: [spec.md](../spec.md)

## Readiness (FR-020)

- [x] CHK001 Problem and why (A), outcome (C), alternatives (D) and scope (E) are clear
- [x] CHK002 AI fit (F) is clear, or the idea does not involve AI
- [x] CHK003 Cost (M) has at least an S, M or L size
- [x] CHK004 Every other category is clear, or deferred with a recorded reason

## Sections (spec Appendix D)

- [x] CHK005 Business context: problem, outcome and chosen alternative can be summarized from spec.md
- [x] CHK006 User stories are prioritized P1..Pn and each has Given/When/Then acceptance scenarios
- [x] CHK007 Each user story can be tested on its own
- [x] CHK008 Functional requirements use FR-### ids and each is testable
- [x] CHK009 Key entities name the data sources, quality and owner (coverage G)
- [x] CHK010 Integrations are named in Requirements or Assumptions (coverage H)
- [x] CHK011 Success criteria use SC-### ids, are measurable and match the Outcome section
- [x] CHK012 AI fit states rule, automation or AI, the data, the cost of an error and human approval points (when AI is involved)
- [x] CHK013 Non-functional needs are stated in plain words: users, peak hours, store connectivity, devices (coverage I)
  - Giờ cao điểm ghi nhận là mục chưa làm rõ trong bản đầu
- [x] CHK014 Edge cases and failures are listed (coverage J)
- [x] CHK015 Every term the tech view uses is in glossary.md (coverage N)
- [x] CHK016 Every open question is marked blocking or non-blocking and has an owner

## Spec Kit compatibility (FR-023)

- [x] CHK017 spec.md keeps every Spec Kit heading unchanged: User Scenarios & Testing, Requirements, Success Criteria, Assumptions and their subheadings
- [x] CHK018 Business sections sit before User Scenarios & Testing and none replaces a Spec Kit section
- [x] CHK019 No "[NEEDS CLARIFICATION]" marker remains outside items listed as "not yet clarified"

## Evidence (FR-024)

- [x] CHK020 Every number has a source, a period and a measured or assumed label, and matches the board view's figure
- [x] CHK021 No section needs a fact that is not in the idea folder
- [x] CHK022 Every estimate is labelled "not tech-reviewed" unless a tech review is recorded in decisions.md
- [x] CHK023 Every field still empty is listed so it shows as "not yet clarified"

## Notes

- Mark items `[x]` only after the idea's files have been checked against them
- Add findings inline under the item they concern
