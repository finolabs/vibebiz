#!/usr/bin/env bash
# Seeds the fake Google Drive with fixtures.py mode 'one-workspace' plus a case edit (fictional).
# Generated; run with: claude plugin eval ... --scaffold
set -euo pipefail
mkdir -p .fake-drive
cat > .fake-drive/drive.json <<'VIBEBIZ_FAKE_DRIVE'
{
  "mode": "normal",
  "bump_after_read": [],
  "files": {
    "s0001": {
      "id": "s0001",
      "title": "Báo cáo tuần",
      "mimeType": "text/markdown",
      "parentId": "root",
      "content": "Ghi chú riêng của người dùng, không phải của vibebiz.\n",
      "modifiedTime": "2026-11-11T09:01:00.000Z",
      "createdTime": "2026-11-11T09:01:00.000Z",
      "owner": "me"
    },
    "s0002": {
      "id": "s0002",
      "title": "vibebiz",
      "mimeType": "application/vnd.google-apps.folder",
      "parentId": "root",
      "content": "",
      "modifiedTime": "2026-11-11T09:02:00.000Z",
      "createdTime": "2026-11-11T09:02:00.000Z",
      "owner": "me"
    },
    "s0003": {
      "id": "s0003",
      "title": "index.json",
      "mimeType": "application/json",
      "parentId": "s0002",
      "content": "{\n  \"vibebiz\": \"workspace\",\n  \"storage\": \"drive\",\n  \"toc_artifact\": null,\n  \"plugin_version\": \"0.1.2\",\n  \"shared_ack\": null,\n  \"workspace\": {\n    \"updated\": \"2026-11-12\",\n    \"ground_rules_status\": \"deferred\"\n  },\n  \"ideas\": [\n    {\n      \"id\": \"001\",\n      \"title\": \"Nhắc khách quay lại cửa hàng qua ứng dụng chat\",\n      \"status\": \"clarifying\",\n      \"estimate_status\": \"not-tech-reviewed\",\n      \"coverage\": {\n        \"clear\": 5,\n        \"total\": 15\n      },\n      \"next_step\": \"/vibebiz:continue\",\n      \"outputs\": [],\n      \"updated\": \"2026-11-12\"\n    }\n  ],\n  \"examples\": []\n}\n",
      "modifiedTime": "2026-11-11T09:03:00.000Z",
      "createdTime": "2026-11-11T09:03:00.000Z",
      "owner": "me"
    },
    "s0004": {
      "id": "s0004",
      "title": "constitution.md",
      "mimeType": "text/markdown",
      "parentId": "s0002",
      "content": "---\n# Workspace ground rules (data-model.md \"Ground rules\"). Written by\n# /vibebiz:constitution; stays `deferred` until the user records them.\n# Values in {{double braces}} are placeholders.\nstatus: deferred            # set | deferred\npriorities: []              # this year's priorities, e.g. [\"{{priority}}\"]\napproval_ceiling:           # budget the user approves alone\n  amount: null              # number, e.g. {{50000000}}\n  currency: \"{{VND}}\"       # currency code\nvertical: \"{{fashion}}\"     # fashion | other text; fashion selects the fashion pack\nmandatory_approvals: []     # steps that always need a person, e.g. [\"{{refunds above the ceiling}}\"]\n# Optional. Balanced scorecard perspectives with their objectives:\n# strategy_map:\n#   financial: [\"{{objective}}\"]\n#   customer: [\"{{objective}}\"]\n#   internal_process: [\"{{objective}}\"]\n#   learning_and_growth: [\"{{objective}}\"]\n# Optional. Objectives and key results the outcome lens maps ideas to:\n# okrs:\n#   - objective: \"{{objective}}\"\n#     key_results: [\"{{key result}}\"]\nupdated: \"{{YYYY-MM-DD}}\"\n---\n\n# Ground rules\n\n<!--\n  Human view of the frontmatter above, in the user's language. The\n  frontmatter is the source of truth; rebuild this body after every change.\n  While status is deferred, the plan module reminds the user to set the\n  ground rules before packaging.\n-->\n\nThese rules apply to every idea in this workspace.\n\n- **Status**: {{deferred}}\n- **This year's priorities**: {{not yet set}}\n- **Budget I can approve alone**: {{not yet set}}\n- **Business**: {{fashion}}\n- **Steps that always need a person to approve**: {{not yet set}}\n",
      "modifiedTime": "2026-11-11T09:04:00.000Z",
      "createdTime": "2026-11-11T09:04:00.000Z",
      "owner": "me"
    },
    "s0005": {
      "id": "s0005",
      "title": "specs",
      "mimeType": "application/vnd.google-apps.folder",
      "parentId": "s0002",
      "content": "",
      "modifiedTime": "2026-11-11T09:05:00.000Z",
      "createdTime": "2026-11-11T09:05:00.000Z",
      "owner": "me"
    },
    "s0006": {
      "id": "s0006",
      "title": "001-giu-chan-khach-cu",
      "mimeType": "application/vnd.google-apps.folder",
      "parentId": "s0005",
      "content": "",
      "modifiedTime": "2026-11-11T09:06:00.000Z",
      "createdTime": "2026-11-11T09:06:00.000Z",
      "owner": "me"
    },
    "s0007": {
      "id": "s0007",
      "title": "assumptions.md",
      "mimeType": "text/markdown",
      "parentId": "s0006",
      "content": "# Assumptions: Nhắc khách quay lại cửa hàng qua ứng dụng chat\n\nWhat this idea takes for granted, and whether it has been tested.\n\n## A-001\n\n- text: Khách hàng đồng ý nhận tin nhắn chăm sóc qua ứng dụng chat khi mua hàng tại quầy.\n- tested: no\n- evidence: none yet\n- riskiest: false\n- source: stated\n\n## A-002\n\n- text: Ít nhất 70% (N-25) khách hàng có số điện thoại chính xác trong hệ thống quản lý bán hàng.\n- tested: no\n- evidence: none yet\n- riskiest: true\n- source: stated\n",
      "modifiedTime": "2026-11-11T09:07:00.000Z",
      "createdTime": "2026-11-11T09:07:00.000Z",
      "owner": "me"
    },
    "s0008": {
      "id": "s0008",
      "title": "checklists",
      "mimeType": "application/vnd.google-apps.folder",
      "parentId": "s0006",
      "content": "",
      "modifiedTime": "2026-11-11T09:08:00.000Z",
      "createdTime": "2026-11-11T09:08:00.000Z",
      "owner": "me"
    },
    "s0009": {
      "id": "s0009",
      "title": "board.md",
      "mimeType": "text/markdown",
      "parentId": "s0008",
      "content": "# Board Checklist: Nhắc khách quay lại cửa hàng qua ứng dụng chat\n\n**Purpose**: Definition of Ready for the board view: the idea folder holds everything slides 1–9 and the appendix need (spec Appendix D, FR-020, FR-024)\n**Created**: 2026-11-12\n**Feature**: [spec.md](../spec.md)\n\n## Readiness (FR-020)\n\n- [x] CHK001 Problem and why (A) is clear\n- [x] CHK002 Outcome and measurement (C) is clear\n- [x] CHK003 Alternatives (D) is clear\n- [x] CHK004 Scope and behavior (E) is clear\n- [x] CHK005 AI fit (F) is clear, or the idea does not involve AI\n- [x] CHK006 Cost (M) has at least an S, M or L size\n- [x] CHK007 Every other category is clear, or deferred with a recorded reason\n  - Gaps ghi nhận có kiểm soát: giờ cao điểm (mục I) và cách chọn cửa hàng đối chứng (mục M)\n\n## Slide content (spec Appendix D)\n\n- [x] CHK008 Slide 1: the decision requested states what, how much and by when (plan.md)\n- [x] CHK009 Slide 2: the problem's current cost is stated in numbers (spec.md Problem & Why)\n- [x] CHK010 Slide 3: the outcome has a baseline or measurement plan, a target, a time frame and guardrails (spec.md Outcome)\n- [x] CHK011 Slide 4: do nothing, fix the process, buy and build are each weighed (spec.md Alternatives)\n- [x] CHK012 Slide 5: the journey before and after is described (User Story P1)\n- [x] CHK013 Slide 6: first-release scope and what comes later are separated (User Stories, Functional Requirements)\n- [x] CHK014 Slide 7: cost, resources and return are given in low, base and high scenarios (spec.md Cost & Risk, plan.md)\n- [x] CHK015 Slide 8: risks, a pre-mortem and kill criteria are recorded (spec.md Cost & Risk, Outcome)\n- [x] CHK016 Slide 9: a pilot roadmap with decision points exists (plan.md)\n  - Tiêu chí chọn 6 cửa hàng đối chứng được ghi chú là mục chưa làm rõ\n- [x] CHK017 Appendix: assumptions and open questions are recorded (assumptions.md, open-questions.md)\n- [x] CHK018 Each slide's message fits one takeaway that can be its title\n\n## Evidence (FR-024)\n\n- [x] CHK019 Every number has a source, a period and a measured or assumed label\n- [x] CHK020 No slide needs a fact that is not in the idea folder\n- [x] CHK021 Every estimate is labelled \"not tech-reviewed\" unless a tech review is recorded in decisions.md\n- [x] CHK022 Every field still empty is listed so it shows as \"not yet clarified\"\n- [x] CHK023 Dismissed risks appear in decisions.md and in the risk slide\n- [x] CHK024 Conflicts with the ground rules are recorded as decisions, or the ground rules are deferred and the plan says so\n\n## Notes\n\n- Mark items `[x]` only after the idea's files have been checked against them\n- Add findings inline under the item they concern\n",
      "modifiedTime": "2026-11-11T09:09:00.000Z",
      "createdTime": "2026-11-11T09:09:00.000Z",
      "owner": "me"
    },
    "s0010": {
      "id": "s0010",
      "title": "tech.md",
      "mimeType": "text/markdown",
      "parentId": "s0008",
      "content": "# Tech Checklist: Nhắc khách quay lại cửa hàng qua ứng dụng chat\n\n**Purpose**: Definition of Ready for the tech view and the Spec Kit snapshot: the idea folder holds everything the tech sections need (spec Appendix D, FR-020, FR-023, FR-024)\n**Created**: 2026-11-12\n**Feature**: [spec.md](../spec.md)\n\n## Readiness (FR-020)\n\n- [x] CHK001 Problem and why (A), outcome (C), alternatives (D) and scope (E) are clear\n- [x] CHK002 AI fit (F) is clear, or the idea does not involve AI\n- [x] CHK003 Cost (M) has at least an S, M or L size\n- [x] CHK004 Every other category is clear, or deferred with a recorded reason\n\n## Sections (spec Appendix D)\n\n- [x] CHK005 Business context: problem, outcome and chosen alternative can be summarized from spec.md\n- [x] CHK006 User stories are prioritized P1..Pn and each has Given/When/Then acceptance scenarios\n- [x] CHK007 Each user story can be tested on its own\n- [x] CHK008 Functional requirements use FR-### ids and each is testable\n- [x] CHK009 Key entities name the data sources, quality and owner (coverage G)\n- [x] CHK010 Integrations are named in Requirements or Assumptions (coverage H)\n- [x] CHK011 Success criteria use SC-### ids, are measurable and match the Outcome section\n- [x] CHK012 AI fit states rule, automation or AI, the data, the cost of an error and human approval points (when AI is involved)\n- [x] CHK013 Non-functional needs are stated in plain words: users, peak hours, store connectivity, devices (coverage I)\n  - Giờ cao điểm ghi nhận là mục chưa làm rõ trong bản đầu\n- [x] CHK014 Edge cases and failures are listed (coverage J)\n- [x] CHK015 Every term the tech view uses is in glossary.md (coverage N)\n- [x] CHK016 Every open question is marked blocking or non-blocking and has an owner\n\n## Spec Kit compatibility (FR-023)\n\n- [x] CHK017 spec.md keeps every Spec Kit heading unchanged: User Scenarios & Testing, Requirements, Success Criteria, Assumptions and their subheadings\n- [x] CHK018 Business sections sit before User Scenarios & Testing and none replaces a Spec Kit section\n- [x] CHK019 No \"[NEEDS CLARIFICATION]\" marker remains outside items listed as \"not yet clarified\"\n\n## Evidence (FR-024)\n\n- [x] CHK020 Every number has a source, a period and a measured or assumed label, and matches the board view's figure\n- [x] CHK021 No section needs a fact that is not in the idea folder\n- [x] CHK022 Every estimate is labelled \"not tech-reviewed\" unless a tech review is recorded in decisions.md\n- [x] CHK023 Every field still empty is listed so it shows as \"not yet clarified\"\n\n## Notes\n\n- Mark items `[x]` only after the idea's files have been checked against them\n- Add findings inline under the item they concern\n",
      "modifiedTime": "2026-11-11T09:10:00.000Z",
      "createdTime": "2026-11-11T09:10:00.000Z",
      "owner": "me"
    },
    "s0011": {
      "id": "s0011",
      "title": "coverage.md",
      "mimeType": "text/markdown",
      "parentId": "s0006",
      "content": "---\nid: \"001\"\nslug: giu-chan-khach-cu\ntitle: \"Nhắc khách quay lại cửa hàng qua ứng dụng chat\"\nlanguage: vi\nvertical: fashion\ncynefin: complicated\nstatus: packaged\nestimate_status: not-tech-reviewed\nbudget_rounds_used: 3\nlatest_export: \"2026-11-12\"\nnext_step: \"/vibebiz:continue\"\ncreated: 2026-11-10\nupdated: 2026-11-12\ncategories:\n  A: {status: clear, reason: null, prerequisites: [], filled_by: problem-framing, frameworks: [five-whys], updated: 2026-11-12}\n  B: {status: clear, reason: null, prerequisites: [A], filled_by: problem-framing, frameworks: [], updated: 2026-11-12}\n  C: {status: clear, reason: null, prerequisites: [A], filled_by: outcome, frameworks: [driver-tree], updated: 2026-11-12}\n  D: {status: clear, reason: null, prerequisites: [A, C], filled_by: challenge, frameworks: [build-buy-partner], updated: 2026-11-12}\n  E: {status: clear, reason: null, prerequisites: [C, D], filled_by: solution-sketch, frameworks: [journey-map, moscow], updated: 2026-11-12}\n  F: {status: clear, reason: null, prerequisites: [E], filled_by: solution-sketch, frameworks: [], updated: 2026-11-12}\n  G: {status: clear, reason: null, prerequisites: [E], filled_by: clarify, frameworks: [], updated: 2026-11-12}\n  H: {status: clear, reason: null, prerequisites: [E, G], filled_by: clarify, frameworks: [], updated: 2026-11-12}\n  I: {status: partial, reason: null, prerequisites: [E], filled_by: solution-sketch, frameworks: [], updated: 2026-11-12}\n  J: {status: clear, reason: null, prerequisites: [E], filled_by: solution-sketch, frameworks: [], updated: 2026-11-12}\n  K: {status: clear, reason: null, prerequisites: [E, G], filled_by: challenge, frameworks: [pre-mortem, assumption-map], updated: 2026-11-12}\n  L: {status: clear, reason: null, prerequisites: [B, E], filled_by: solution-sketch, frameworks: [], updated: 2026-11-12}\n  M: {status: partial, reason: null, prerequisites: [C, D, E], filled_by: challenge, frameworks: [test-and-control], updated: 2026-11-12}\n  N: {status: clear, reason: null, prerequisites: [], filled_by: clarify, frameworks: [], updated: 2026-11-12}\n  O: {status: clear, reason: null, prerequisites: [C, E], filled_by: outcome, frameworks: [], updated: 2026-11-12}\n---\n\n# Coverage: Nhắc khách quay lại cửa hàng qua ứng dụng chat\n\n| Code | Category | Status | Reason (when deferred) | Updated |\n|---|---|---|---|---|\n| A | Problem and why | clear | | 2026-11-12 |\n| B | Users and stakeholders | clear | | 2026-11-12 |\n| C | Outcome and measurement | clear | | 2026-11-12 |\n| D | Alternatives | clear | | 2026-11-12 |\n| E | Scope and behavior | clear | | 2026-11-12 |\n| F | AI fit | clear | | 2026-11-12 |\n| G | Data and entities | clear | | 2026-11-12 |\n| H | Integrations | clear | | 2026-11-12 |\n| I | Non-functional needs | partial | | 2026-11-12 |\n| J | Edge cases and failures | clear | | 2026-11-12 |\n| K | Risk and compliance | clear | | 2026-11-12 |\n| L | Organizational change | clear | | 2026-11-12 |\n| M | Cost, resources and return | partial | | 2026-11-12 |\n| N | Terminology | clear | | 2026-11-12 |\n| O | Completion signals | clear | | 2026-11-12 |\n\n**Clear**: 13 of 15\n",
      "modifiedTime": "2026-11-11T09:11:00.000Z",
      "createdTime": "2026-11-11T09:11:00.000Z",
      "owner": "me"
    },
    "s0012": {
      "id": "s0012",
      "title": "decisions.md",
      "mimeType": "text/markdown",
      "parentId": "s0006",
      "content": "# Decisions: Nhắc khách quay lại cửa hàng qua ứng dụng chat\n\nEvery decision about this idea, oldest first. Nothing here is ever deleted.\n\n## D-001 — Chọn phương án mua giải pháp nhắn tin có sẵn\n\n- date: 2026-11-10\n- type: answer\n- text: Chọn mua công cụ nhắn tin có sẵn thay vì tự xây hoặc sửa quy trình thủ công.\n- reason: Thời gian triển khai chỉ 4 tuần (N-19), kịp chạy trước mùa mua sắm Tết; ngân sách thí điểm 180 triệu đ (N-03) nằm trong trần ngân sách 400 triệu đ năm đầu.\n- notes: Framework build-buy-partner áp dụng tại vòng hỏi 1.\n\n## D-002 — Chọn điểm rơi gửi tin là ngày thứ 30 sau lần mua đầu\n\n- date: 2026-11-11\n- type: answer\n- text: Gửi lời nhắc chăm sóc và gợi ý sản phẩm vào đúng ngày thứ 30 (N-24) sau lần mua đầu tiên của khách.\n- reason: Phân tích hành trình khách hàng (journey-map) cho thấy sau 30 ngày khách bắt đầu quên thương hiệu nhưng vẫn còn nhớ trải nghiệm mua sắm tích cực.\n- notes: Framework journey-map áp dụng tại vòng hỏi 2.\n\n## D-003 — Đặt ngưỡng dừng thí điểm nếu tỷ lệ hủy nhận tin vượt 2%\n\n- date: 2026-11-11\n- type: answer\n- text: Nếu tỷ lệ khách hủy nhận tin vượt ngưỡng 2% (N-10) mỗi tháng trong hai tháng liên tiếp, dừng chương trình ngay lập tức.\n- reason: Kết quả phân tích Pre-mortem xác định rủi ro lớn nhất là làm phiền khách hàng; cần có van an toàn bảo vệ uy tín thương hiệu.\n- notes: Framework pre-mortem áp dụng tại vòng hỏi 2.\n\n## D-004 — Chấp nhận rủi ro nhân viên quầy ngại thêm thao tác giờ cao điểm\n\n- date: 2026-11-12\n- type: dismissed-risk\n- text: Chấp nhận rủi ro nhân viên thu ngân có thể ngại thao tác quét mã giờ cao điểm cuối tuần.\n- reason: Thao tác quét mã và xác nhận được thiết kế tối ưu dưới 10 giây; cử thêm nhân viên hỗ trợ giờ cao điểm trong 2 tuần đầu thí điểm.\n- notes: Rủi ro được giám đốc bán hàng chấp thuận sau khi cân nhắc phương án tăng cường hỗ trợ.\n",
      "modifiedTime": "2026-11-11T09:12:00.000Z",
      "createdTime": "2026-11-11T09:12:00.000Z",
      "owner": "me"
    },
    "s0013": {
      "id": "s0013",
      "title": "exports",
      "mimeType": "application/vnd.google-apps.folder",
      "parentId": "s0006",
      "content": "",
      "modifiedTime": "2026-11-11T09:13:00.000Z",
      "createdTime": "2026-11-11T09:13:00.000Z",
      "owner": "me"
    },
    "s0017": {
      "id": "s0017",
      "title": "glossary.md",
      "mimeType": "text/markdown",
      "parentId": "s0006",
      "content": "# Glossary: Nhắc khách quay lại cửa hàng qua ứng dụng chat\n\nThe words this idea uses, and what they mean here.\n\n- **Cửa hàng đối chứng**: cửa hàng không dùng lời nhắc, dùng để so sánh kết quả\n- **Khách quay lại**: khách mua thêm ít nhất một lần trong 90 ngày sau lần mua trước\n- **Lời nhắc 30 ngày**: tin nhắn gợi ý sản phẩm gửi tự động đến khách hàng sau đúng 30 ngày kể từ lần mua gần nhất\n- **Nhóm đối chứng**: nhóm 6 cửa hàng hoạt động theo quy trình cũ để đối chiếu hiệu quả với 6 cửa hàng thí điểm\n- **Tỷ lệ quay lại 90 ngày**: phần trăm khách hàng có phát sinh đơn hàng mới trong vòng 90 ngày kể từ đơn hàng trước đó\n",
      "modifiedTime": "2026-11-11T09:17:00.000Z",
      "createdTime": "2026-11-11T09:17:00.000Z",
      "owner": "me"
    },
    "s0018": {
      "id": "s0018",
      "title": "open-questions.md",
      "mimeType": "text/markdown",
      "parentId": "s0006",
      "content": "# Open questions: Nhắc khách quay lại cửa hàng qua ứng dụng chat\n\nQuestions still waiting for an answer, and who can give it.\n\n## Q-001\n\n- text: Công cụ nhắn tin có nối được với phần mềm bán hàng hiện tại không?\n- owner: Trưởng nhóm kỹ thuật\n- unblocks: Khả năng tự động đồng bộ hóa đơn và số điện thoại khách hàng sang công cụ nhắn tin.\n- blocking: true\n- category: H\n- status: open\n\n## Q-002\n\n- text: Nội dung tin nhắn do ai duyệt?\n- owner: Trưởng phòng marketing\n- unblocks: Quy trình phê duyệt thông điệp và hình ảnh sản phẩm trước khi gửi cho khách.\n- blocking: false\n- category: E\n- status: open\n",
      "modifiedTime": "2026-11-11T09:18:00.000Z",
      "createdTime": "2026-11-11T09:18:00.000Z",
      "owner": "me"
    },
    "s0019": {
      "id": "s0019",
      "title": "plan.md",
      "mimeType": "text/markdown",
      "parentId": "s0006",
      "content": "---\nestimate_status: not-tech-reviewed\nupdated: \"2026-11-12\"\n---\n\n# Business plan: Nhắc khách quay lại cửa hàng qua ứng dụng chat\n\n## Decision requested\n\nDuyệt thí điểm 12 tuần ({{N-08}}) tại 6 cửa hàng ({{N-07}}) với ngân sách thí điểm {{N-03}} (180 triệu đ, ước tính sơ bộ, nhãn \"chưa qua đội kỹ thuật thẩm định\").\n\nHạn quyết định: Trước ngày 30/11/2026 để kịp chuẩn bị và triển khai trước đợt mua sắm Tết (thời gian chuẩn bị 4 tuần {{N-19}}).\n\n## Size and scenarios\n\nQuy mô dự án: Vừa (M).\n\n| Scenario | Cost | Resources | Return | Time frame |\n|---|---|---|---|---|\n| Low | 180 triệu đ ({{N-03}})* | 6 cửa hàng thí điểm ({{N-07}}), 1 kỹ thuật bán thời gian | 120 triệu đ ({{N-04}})* | năm đầu sau thí điểm |\n| Base | 180 triệu đ ({{N-03}})* | 6 cửa hàng thí điểm ({{N-07}}), 1 kỹ thuật bán thời gian | 350 triệu đ ({{N-05}})* | năm đầu sau thí điểm |\n| High | 180 triệu đ ({{N-03}})* | 6 cửa hàng thí điểm ({{N-07}}), 1 kỹ thuật bán thời gian | 600 triệu đ ({{N-06}})* | năm đầu sau thí điểm |\n\n*\\* Các con số chi phí và lợi nhuận gộp tăng thêm mang nhãn \"chưa qua đội kỹ thuật thẩm định\" cho đến khi có thẩm định kỹ thuật chính thức.*\n\nNguồn số liệu: Ước tính sơ bộ trong kế hoạch kinh doanh.\n\n## Pilot roadmap and decision points\n\nKế hoạch chạy thí điểm trong 12 tuần ({{N-08}}), từ tháng 12/2026 đến tháng 02/2027:\n\n1. **Tuần 1 đến 4**:\n   - Cài đặt công cụ nhắn tin, tích hợp luồng dữ liệu hóa đơn từ POS.\n   - Hướng dẫn nhân viên thu ngân tại 6 cửa hàng thí điểm ({{N-07}}).\n   - Thiết lập danh sách 6 cửa hàng đối chứng ({{N-23}}).\n   - *Mục chưa làm rõ*: plan.Pilot and rollout: cách chọn cửa hàng đối chứng (tiêu chí tương đồng về quy mô doanh thu và lượng khách).\n\n2. **Tuần 5 đến 12**:\n   - Bắt đầu gửi tin nhắn nhắc sau 30 ngày ({{N-24}}) cho khách mua lần đầu.\n   - Cửa hàng đối chứng giữ nguyên quy trình vận hành hiện nay.\n   - Nhân viên tại 6 cửa hàng thí điểm theo dõi danh sách khách đến chăm sóc.\n\n3. **Điểm quyết định 1 (Tuần 6)**:\n   - Đánh giá tỷ lệ khách hủy nhận tin nhắn.\n   - Quyết định: Nếu tỷ lệ hủy vượt 2% ({{N-10}}), điều chỉnh tần suất hoặc nội dung thông điệp; nếu dưới 2%, tiếp tục giai đoạn 2.\n\n4. **Điểm quyết định 2 (Tuần 12)**:\n   - Đối chiếu tỷ lệ khách quay lại 90 ngày giữa nhóm thí điểm và nhóm đối chứng.\n   - Quyết định: Nếu đạt mục tiêu 24% ({{N-02}}) và tỷ lệ hủy dưới 2% ({{N-10}}), đề xuất ban lãnh đạo mở rộng ra toàn bộ 34 cửa hàng của chuỗi; nếu không đạt, dừng dự án theo kill criteria.\n\n## Organizational change\n\n- **Đào tạo**: Hướng dẫn khoảng 40 nhân viên thu ngân tại 6 cửa hàng thí điểm thao tác xác nhận khách trên điện thoại/máy POS trong thời gian dưới 10 giây.\n- **KPI nhân viên**: Bổ sung chỉ số tỷ lệ ghi nhận số điện thoại khách hàng tại quầy (mục tiêu đạt tối thiểu 70% hóa đơn {{N-25}}).\n- **Phân bổ nhân sự**: Cử thêm nhân viên hỗ trợ tại quầy thu ngân trong giờ cao điểm của 2 tuần đầu thí điểm để nhân viên làm quen quy trình.\n\n## Ground rules check\n\n- **Hạn mức phê duyệt**: Chi phí thí điểm 180 triệu đ ({{N-03}}) nằm trong trần ngân sách 400 triệu đ năm đầu theo định hướng của giám đốc bán hàng (D-001).\n- **Phê duyệt bắt buộc**: Giám đốc tài chính phê duyệt ngân sách thí điểm; kế toán trưởng phê duyệt cách đối soát số liệu trước khi ký hợp đồng thuê công cụ.\n- **Xung đột nguyên tắc chung**: Không có xung đột với định hướng kinh doanh năm 2026 của chuỗi thời trang Lụa Hạ.\n",
      "modifiedTime": "2026-11-11T09:19:00.000Z",
      "createdTime": "2026-11-11T09:19:00.000Z",
      "owner": "me"
    },
    "s0020": {
      "id": "s0020",
      "title": "spec.md",
      "mimeType": "text/markdown",
      "parentId": "s0006",
      "content": "# Feature Specification: Nhắc khách quay lại cửa hàng qua ứng dụng chat\n\n**Feature Branch**: `000-giu-chan-khach-cu`\n**Created**: 2026-11-10\n**Status**: Draft\n**Input**: User description: \"Tao muốn làm cái hệ thống tích điểm cho khách quen để họ mua lại nhiều hơn.\"\n\n## Problem & Why\n\nChỉ 18% khách mua lần hai trong 90 ngày ({{N-01}} đo thực tế từ báo cáo khách hàng thân thiết 6 tháng đầu năm 2026). Trung bình mỗi lần khách cũ quay lại chi tiêu {{N-09}} (650.000 đ đo thực tế từ báo cáo bán hàng nội bộ). Bốn trên năm khách mua lần đầu không bao giờ quay lại cửa hàng (dữ liệu hư cấu chuỗi thời trang Lụa Hạ).\n\nSự việc gần nhất: trong đợt khuyến mại tháng trước, chuỗi cửa hàng gửi tin nhắn quảng cáo đồng loạt nhưng tỷ lệ khách quay lại không đổi, do khách nhận tin không đúng nhu cầu và nhân viên tại cửa hàng không có lịch nhắc hay danh sách khách cũ cần chăm sóc.\n\nNguyên nhân gốc (phân tích 5 Whys): cửa hàng hoàn toàn không có lịch nhắc khách cũ sau lần mua đầu; hiện quản lý tích điểm bằng thẻ giấy, đóng dấu thủ công, tốn khoảng 6 triệu đồng mỗi tháng tiền in thẻ và 40 giờ công đối soát cuối tháng.\n\nCác bên liên quan: khách hàng nữ công sở 25–40 tuổi tại 34 cửa hàng của chuỗi thời trang Lụa Hạ; nhân viên quầy thu ngân (người thao tác trực tiếp, thao tác nhanh dưới 10 giây); giám đốc tài chính (duyệt ngân sách); kế toán trưởng (duyệt cách đối soát).\n\n## Outcome\n\nNâng tỷ lệ khách quay lại trong 90 ngày từ {{N-01}} (18% hiện nay) lên {{N-02}} (24% mục tiêu) sau 12 tuần thí điểm ({{N-08}}) tại {{N-07}} cửa hàng.\n\nCây chỉ số (Driver tree):\n- Chỉ số kết quả (lagging): Tỷ lệ khách quay lại trong 90 ngày (từ {{N-01}} lên {{N-02}}).\n- Chỉ số dẫn dắt (leading): Tỷ lệ gửi tin nhắc thành công vào ngày thứ {{N-24}} sau lần mua đầu; tỷ lệ khách mở tin và quay lại quầy mua sắm.\n- Chỉ số giữ nguyên: Giá trị trung bình mỗi đơn hàng ({{N-09}}).\n\nNgưỡng bảo vệ trải nghiệm (Guardrail metric): Tỷ lệ khách hủy nhận tin nhắn phải dưới {{N-10}} (2% mỗi tháng).\n\nĐiều kiện dừng thí điểm (Kill criteria): Nếu tỷ lệ khách hủy nhận tin vượt {{N-10}} trong hai tháng liên tiếp, dừng chương trình ngay lập tức để rà soát lại thông điệp và tần suất.\n\n## Alternatives\n\n1. Giữ nguyên (Do nothing): Không tốn chi phí nhưng tỷ lệ khách quay lại đứng yên ở mức 18% ({{N-01}}), tiếp tục mất 82% khách hàng mới.\n2. Sửa quy trình (Fix the process): Nhân viên tự ghi chép sổ tay và gọi điện nhắc khách. Làm được ngay nhưng tốn giờ công, khó theo dõi và dễ gây phiền hà.\n3. Mua công cụ có sẵn (Buy - Phương án chọn): Thuê giải pháp nhắn tin tự động chăm sóc khách hàng có sẵn qua Zalo/ứng dụng chat. Triển khai nhanh sau {{N-19}} (4 tuần ước tính), chi phí thí điểm {{N-03}} (180 triệu đồng ước tính, chưa qua đội kỹ thuật thẩm định). Đã ghi nhận quyết định D-001.\n4. Tự xây (Build): Đội kỹ thuật tự phát triển hệ thống riêng. Tùy biến hoàn toàn nhưng mất từ {{N-20}} (16 tuần) đến {{N-21}} (26 tuần) ước tính, không kịp mùa mua sắm Tết.\n\n## AI-fit\n\nLời nhắc theo lịch là tự động hóa, không cần AI. Gợi ý sản phẩm dùng quy tắc theo nhóm hàng trong bản đầu tiên (ví dụ: mua áo sơ mi gợi ý chân váy công sở).\n\nDữ liệu sẵn có: Số điện thoại khách hàng có trên khoảng 70% hóa đơn ({{N-25}}), dữ liệu bán hàng lưu trên phần mềm quản lý bán hàng tại quầy.\n\nChi phí sai sót: Nếu gửi nhầm gợi ý, khách có thể hủy nhận tin; kiểm soát bằng giới hạn tối đa 1 tin nhắn/tháng và cơ chế hủy nhận tin một chạm. Điểm duyệt của con người: Trưởng phòng marketing duyệt trước toàn bộ mẫu nội dung tin nhắn trước khi hệ thống gửi tự động.\n\n## Cost & Risk\n\nQuy mô dự án: Vừa (M).\nChi phí thí điểm: {{N-03}} (180 triệu đồng ước tính cho 12 tuần thí điểm tại 6 cửa hàng, nhãn \"chưa qua đội kỹ thuật thẩm định\").\n\nBa kịch bản lợi nhuận gộp tăng thêm trong năm đầu (ước tính sơ bộ, nhãn \"chưa qua đội kỹ thuật thẩm định\"):\n- Kịch bản thấp: {{N-04}} (120 triệu đồng).\n- Kịch bản cơ sở: {{N-05}} (350 triệu đồng) - đủ hoàn vốn chi phí thí điểm ngay trong năm đầu.\n- Kịch bản cao: {{N-06}} (600 triệu đồng).\n\nPre-mortem (nguyên nhân thất bại dễ xảy ra nhất): Khách hàng cảm thấy bị làm phiền bởi tin nhắn quảng cáo và hủy nhận tin hàng loạt.\nBiện pháp kiểm soát: Giới hạn tần suất nghiêm ngặt (tối đa 1 tin/tháng), chỉ gửi cho khách đã đồng ý nhận tin, nội dung ngắn gọn kèm ưu đãi thiết thực.\n\nTuân thủ và thay đổi tổ chức: Tuân thủ quy định về bảo vệ dữ liệu cá nhân (xin phép khách lưu số điện thoại và gửi tin); đào tạo nhân viên quầy thu ngân tại 6 cửa hàng thí điểm thao tác xác nhận khách nhanh dưới 10 giây.\n\n## Clarifications\n\n### Session 2026-11-10\n\n- Q: Tỷ lệ khách quay lại hiện nay là bao nhiêu và mục tiêu mong muốn sau thí điểm là gì? → A: Hiện nay tỷ lệ khách quay lại trong 90 ngày là 18% (N-01), mục tiêu nâng lên 24% (N-02) sau 12 tuần thí điểm.\n- Q: Thời gian triển khai cần hoàn thành khi nào và ngân sách tối đa là bao nhiêu? → A: Cần hoàn thành trước đợt mua sắm Tết (trong vòng 5 tháng), ngân sách tối đa năm đầu 400 triệu đồng.\n- Q: Quy mô thí điểm bao gồm bao nhiêu cửa hàng? → A: Thí điểm tại 6 cửa hàng (N-07) và có 6 cửa hàng đối chứng (N-23) trong tổng số 34 cửa hàng của chuỗi Lụa Hạ.\n\n## User Scenarios & Testing *(mandatory)*\n\n### User Story 1 - Khách mua lần đầu nhận lời nhắc đúng món sau 30 ngày (Priority: P1)\n\nKhách hàng mới đến mua đồ tại cửa hàng Lụa Hạ lần đầu tiên, để lại số điện thoại và đồng ý nhận tin chăm sóc. Đúng ngày thứ 30 ({{N-24}}) kể từ lần mua đó, khách nhận được một tin nhắn gợi ý sản phẩm phối hợp thời trang và ưu đãi chào mừng quay lại.\n\n**Why this priority**: Đây là nhóm khách hàng dễ bị bỏ quên và thất thoát nhiều nhất (82% không quay lại), là nguồn tăng trưởng doanh thu cốt lõi của ý tưởng.\n\n**Independent Test**: Có thể kiểm thử độc lập trên nhóm 100 khách hàng mua lần đầu tại 1 cửa hàng: hệ thống tự động gửi tin nhắn sau đúng 30 ngày và đo lường tỷ lệ khách mở tin, mang mã đến cửa hàng mua lại.\n\n**Acceptance Scenarios**:\n\n1. **Given** khách mua lần đầu và đồng ý nhận tin, **When** đủ 30 ngày chưa quay lại, **Then** khách nhận một tin gợi ý sản phẩm hợp với món đã mua.\n2. **Given** khách đã hủy nhận tin, **When** đủ 30 ngày, **Then** không gửi tin nào.\n\n---\n\n### User Story 2 - Nhân viên xem danh sách khách cần chăm sóc (Priority: P2)\n\nĐầu mỗi ca làm việc, nhân viên thu ngân hoặc trưởng ca mở ứng dụng xem danh sách khách hàng của cửa hàng mình sắp đến hạn hoặc đã nhận lời nhắc 30 ngày, để sẵn sàng tư vấn khi khách ghé cửa hàng.\n\n**Why this priority**: Giúp nhân viên chủ động chào đón và áp dụng đúng ưu đãi khi khách đến cửa hàng sau khi nhận tin nhắn nhắc.\n\n**Independent Test**: Nhân viên đăng nhập vào hệ thống tại cửa hàng thí điểm, lọc danh sách khách theo ngày hẹn và kiểm tra thông tin đơn hàng cũ của khách.\n\n**Acceptance Scenarios**:\n\n1. **Given** nhân viên mở danh sách đầu ca, **When** có khách sắp đủ 30 ngày, **Then** hệ thống hiển thị danh sách khách hàng cần chăm sóc của cửa hàng mình.\n\n---\n\n### User Story 3 - Theo dõi tỷ lệ khách quay lại so với nhóm đối chứng (Priority: P3)\n\nGiám đốc bán hàng và quản lý chuỗi theo dõi báo cáo tỷ lệ quay lại hàng tuần giữa 6 cửa hàng thí điểm ({{N-07}}) và 6 cửa hàng đối chứng ({{N-23}}) để đánh giá hiệu quả chương trình.\n\n**Why this priority**: Cung cấp dữ liệu thực chứng phục vụ quyết định mở rộng ra toàn bộ 34 cửa hàng sau 12 tuần thí điểm.\n\n**Independent Test**: Xuất báo cáo đối chiếu tỷ lệ mua lại sau 6 tuần và 12 tuần giữa hai nhóm cửa hàng trên cùng một tập dữ liệu hóa đơn.\n\n**Acceptance Scenarios**:\n\n1. **Given** kết thúc tuần thí điểm thứ 12, **When** giám đốc bán hàng mở báo cáo tổng kết, **Then** hệ thống hiển thị bảng so sánh tỷ lệ khách mua lại giữa 6 cửa hàng thí điểm và 6 cửa hàng đối chứng.\n\n---\n\n### Edge Cases\n\n- Khách hàng quay lại mua sắm trước mốc 30 ngày (ví dụ ngày thứ 15): Hệ thống phải tự động hủy lịch gửi tin nhắc của ngày thứ 30 và đặt lại chu kỳ mới từ ngày mua gần nhất.\n- Số điện thoại khách hàng cung cấp không tồn tại hoặc không đăng ký tài khoản ứng dụng chat: Hệ thống ghi nhận lỗi chuyển phát vào nhật ký và không thử lại quá 2 lần để tránh lãng phí chi phí tin nhắn.\n\n## Requirements *(mandatory)*\n\n### Functional Requirements\n\n- **FR-001**: Hệ thống phải gửi tối đa một tin nhắc mỗi tháng cho mỗi khách.\n- **FR-002**: Hệ thống phải bỏ qua khách đã hủy nhận tin.\n- **FR-003**: Nhân viên phải xem được danh sách khách cần chăm sóc của cửa hàng mình.\n- **FR-004**: Hệ thống phải ghi nhận lịch sử gửi tin nhắn và đối soát tỷ lệ quay lại mua hàng trong vòng 90 ngày.\n\n### Key Entities *(include if feature involves data)*\n\n- **Khách hàng**: người đã mua ít nhất một lần, có số điện thoại và trạng thái đồng ý nhận tin.\n- **Lần mua**: ngày mua, cửa hàng, các món đã mua.\n\n## Success Criteria *(mandatory)*\n\n### Measurable Outcomes\n\n- **SC-001**: Tỷ lệ khách quay lại trong 90 ngày tại cửa hàng thí điểm đạt {{N-02}}, so với cửa hàng đối chứng.\n- **SC-002**: Tỷ lệ khách hủy nhận tin dưới {{N-10}} mỗi tháng.\n- **SC-003**: Thời gian thao tác xác nhận khách tại quầy thu ngân không vượt quá 10 giây mỗi giao dịch.\n- **SC-004**: Hoàn vốn chi phí thí điểm {{N-03}} trong năm đầu theo kịch bản cơ sở {{N-05}}.\n\n## Assumptions\n\n- Khách hàng mua sắm tại chuỗi Lụa Hạ có sử dụng ứng dụng chat trên điện thoại thông minh.\n- Ít nhất 70% ({{N-25}}) khách hàng có số điện thoại chính xác trong hệ thống quản lý bán hàng (giả định A-002).\n- Phần mềm bán hàng POS hiện tại tại 34 cửa hàng có khả năng trích xuất dữ liệu hóa đơn hàng ngày để đồng bộ với công cụ gửi tin.\n- Đội ngũ nhân viên thu ngân tại 6 cửa hàng thí điểm được hướng dẫn đầy đủ quy trình thao tác trước khi triển khai thực tế.\n",
      "modifiedTime": "2026-11-11T09:20:00.000Z",
      "createdTime": "2026-11-11T09:20:00.000Z",
      "owner": "me"
    }
  },
  "next_id": 1,
  "clock": 1000,
  "bumped": []
}
VIBEBIZ_FAKE_DRIVE
