#!/usr/bin/env bash
# Seeds a fictional workspace (no real data). Run with: claude plugin eval ... --scaffold
set -euo pipefail
mkdir -p "$(dirname 'bao-cao-thang-10.txt')"
cat > 'bao-cao-thang-10.txt' <<'VIBEBIZ_SEED_0'
Doanh thu tháng 10 (số bịa cho bài kiểm tra): 1.000.
VIBEBIZ_SEED_0
mkdir -p "$(dirname 'ghi-chu-ca-nhan.md')"
cat > 'ghi-chu-ca-nhan.md' <<'VIBEBIZ_SEED_1'
UNRELATED-NOTES-MARKER
VIBEBIZ_SEED_1
