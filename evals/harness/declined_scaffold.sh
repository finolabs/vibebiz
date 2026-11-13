#!/bin/bash
# Dev UAT case (T056): the user declines the shell command that writes index.html while `idea` scaffolds a new
# local workspace. Usage: declined_scaffold.sh <empty scratch dir>. Passes when no index.html exists at the end,
# no later write of index.html was attempted, and the final message says what was not saved.
set -euo pipefail
W=$1; R=$(cd "$(dirname "$0")/../.." && pwd)
mkdir -p "$W"; cd "$W"
[ -z "$(ls -A .)" ] || { echo "scratch dir must be empty"; exit 2; }
cat > .decline-mcp.json <<JSON
{"mcpServers": {"decline": {"command": "python3", "args": ["-I", "$R/evals/harness/decline_server.py"],
  "env": {"DECLINE_PATTERN": "index\\\\.html", "DECLINE_LOG": "$W/.decline-log.jsonl"}}}}
JSON
claude -p --setting-sources project --strict-mcp-config --mcp-config .decline-mcp.json \
  --permission-prompt-tool mcp__decline__decide --plugin-dir "$R/dist/vibebiz" --add-dir "$R/dist/vibebiz" \
  --model sonnet --output-format stream-json --verbose \
  "/vibebiz:idea chị muốn làm chương trình nhắc khách quay lại mua lõi lọc nước sau 60 ngày cho chuỗi điện máy (hư cấu)" \
  > .run.jsonl 2> .run.err || true
python3 -I - "$W" <<'PY'
import json, os, sys
w = sys.argv[1]
log = [json.loads(l) for l in open(os.path.join(w, ".decline-log.jsonl"))] if os.path.exists(os.path.join(w, ".decline-log.jsonl")) else []
declined = [i for i, e in enumerate(log) if e["answer"] == "deny"]
later = [e for e in log[(declined[0] + 1 if declined else len(log)):]
         if "index.html" in json.dumps(e["input"], ensure_ascii=False)]
final = ""
for l in open(os.path.join(w, ".run.jsonl")):
    d = json.loads(l)
    if d.get("type") == "result":
        final = d.get("result") or ""
        cost = d.get("total_cost_usd", 0)
checks = {
    "a-decline-happened": bool(declined),
    "no-index-html": not os.path.exists(os.path.join(w, "index.html")),
    "no-later-index-write": not later,
    "says-not-saved": any(k in final.lower() for k in ("mục lục", "index.html", "chưa lưu", "không ghi", "chưa ghi")),
}
print(json.dumps(checks), "cost", round(cost, 2))
print("prompts:", [(e["tool"], e["answer"], json.dumps(e["input"], ensure_ascii=False)[:90]) for e in log])
print("FINAL:", final[:1500])
sys.exit(0 if all(checks.values()) else 1)
PY
