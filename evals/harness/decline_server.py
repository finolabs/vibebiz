"""Permission-prompt MCP server for vibebiz dev evals (dev only, no dependencies).

Claude Code calls its `decide` tool for every permission prompt in `claude -p --permission-prompt-tool
mcp__decline__decide`. It plays a user who declines: any Bash command whose text matches the
DECLINE_PATTERN environment variable is denied with a user's "no"; every other prompt is allowed.
Each request and answer is appended to the file named by DECLINE_LOG as one JSON line.
"""
import json
import os
import re
import sys

PATTERN = re.compile(os.environ.get("DECLINE_PATTERN", "index\\.html"))
LOG = os.environ.get("DECLINE_LOG", "decline-log.jsonl")
TOOL = {"name": "decide", "description": "Answer a permission prompt as the user.",
        "inputSchema": {"type": "object", "properties": {"tool_name": {"type": "string"}, "input": {"type": "object"},
                                                         "tool_use_id": {"type": "string"}}, "required": ["tool_name", "input"]}}


def answer(args):
    name, data = args.get("tool_name", ""), args.get("input", {})
    if name == "Bash" and PATTERN.search(data.get("command", "")):
        out = {"behavior": "deny", "message": "The user declined this command."}
    else:
        out = {"behavior": "allow", "updatedInput": data}
    with open(LOG, "a", encoding="utf-8") as fh:
        fh.write(json.dumps({"tool": name, "input": data, "answer": out["behavior"]}, ensure_ascii=False) + "\n")
    return out


def reply(msg_id, result):
    sys.stdout.write(json.dumps({"jsonrpc": "2.0", "id": msg_id, "result": result}) + "\n")
    sys.stdout.flush()


for line in sys.stdin:
    if not line.strip():
        continue
    msg = json.loads(line)
    method, msg_id = msg.get("method"), msg.get("id")
    if method == "initialize":
        reply(msg_id, {"protocolVersion": msg["params"].get("protocolVersion", "2025-06-18"),
                       "capabilities": {"tools": {}}, "serverInfo": {"name": "decline", "version": "0.1.0"}})
    elif method == "tools/list":
        reply(msg_id, {"tools": [TOOL]})
    elif method == "tools/call":
        out = answer(msg["params"].get("arguments", {}))
        reply(msg_id, {"content": [{"type": "text", "text": json.dumps(out)}]})
    elif msg_id is not None:
        sys.stdout.write(json.dumps({"jsonrpc": "2.0", "id": msg_id, "error": {"code": -32601, "message": "not found"}}) + "\n")
        sys.stdout.flush()
