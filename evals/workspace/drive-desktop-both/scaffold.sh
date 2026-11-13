#!/usr/bin/env bash
# Seeds the fake Google Drive with fixtures.py mode 'empty' (fictional): no vibebiz workspace, one unrelated user file.
# Run with: claude plugin eval ... --scaffold
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
    }
  },
  "next_id": 1,
  "clock": 1000,
  "bumped": []
}
VIBEBIZ_FAKE_DRIVE
