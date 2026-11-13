#!/usr/bin/env bash
# Seeds the fake Google Drive with fixtures.py mode 'empty' plus a case edit (fictional).
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
    "u0001": {
      "id": "u0001",
      "title": "vibebiz",
      "mimeType": "application/vnd.google-apps.folder",
      "parentId": "root",
      "content": "",
      "modifiedTime": "2026-11-11T09:30:00.000Z",
      "createdTime": "2026-11-11T09:30:00.000Z",
      "owner": "me"
    },
    "u0002": {
      "id": "u0002",
      "title": "constitution.md",
      "mimeType": "text/markdown",
      "parentId": "u0001",
      "content": "# Luật riêng của tôi\n\nMY-OWN-GROUND-RULES-MARKER: tự viết tay, không phải của vibebiz.\n",
      "modifiedTime": "2026-11-11T09:31:00.000Z",
      "createdTime": "2026-11-11T09:31:00.000Z",
      "owner": "me"
    }
  },
  "next_id": 1,
  "clock": 1000,
  "bumped": []
}
VIBEBIZ_FAKE_DRIVE
