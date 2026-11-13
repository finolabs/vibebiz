#!/usr/bin/env python3
"""Seed a fake Drive for one eval case (development only).

Usage: python3 -I fixtures.py <mode> <workspace> [--bump <title>]...
--bump makes the server change that file (content and modifiedTime) right after its first
content read, as if another device edited it between vibebiz's read and its write.
Writes <workspace>/.fake-drive/drive.json for the fake Drive server (server.py).

Modes: empty, one-workspace, two-workspaces, read-only, shared-folder, shared-drive,
converted-file, drive-full, newer-version. Every workspace is built from the repository's
fictional example (examples/000-giu-chan-khach-cu) and the workspace templates, without the
HTML views that Drive mode never stores (specs/002-drive-workspace/data-model.md).
"""

import json
import os
import re
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
REPO = os.path.dirname(os.path.dirname(HERE))
EXAMPLE = os.path.join(REPO, "examples", "000-giu-chan-khach-cu")
TEMPLATES = os.path.join(REPO, "templates", "workspace")
FOLDER = "application/vnd.google-apps.folder"
GDOC = "application/vnd.google-apps.document"
MODES = ("empty", "one-workspace", "two-workspaces", "read-only", "shared-folder",
         "shared-drive", "converted-file", "drive-full", "newer-version")
SKIP = {"board-deck.html", "tech-prd.html"}


class Builder:
    def __init__(self):
        self.files = {}
        self.n = 0
        self.clock = 0

    def stamp(self):
        self.clock += 1
        return "2026-11-1%dT09:%02d:00.000Z" % (1 + self.clock // 60, self.clock % 60)

    def add(self, title, parent="root", mime=FOLDER, content="", **extra):
        self.n += 1
        fid = "s%04d" % self.n
        t = self.stamp()
        f = {"id": fid, "title": title, "mimeType": mime, "parentId": parent, "content": content,
             "modifiedTime": t, "createdTime": t, "owner": "me"}
        f.update(extra)
        self.files[fid] = f
        return fid

    def tree(self, src, parent):
        for name in sorted(os.listdir(src)):
            path = os.path.join(src, name)
            if name.startswith(".") or name in SKIP:
                continue
            if os.path.isdir(path):
                self.tree(path, self.add(name, parent))
            else:
                mime = "application/json" if name.endswith(".json") else "text/markdown"
                with open(path, encoding="utf-8") as fh:
                    self.add(name, parent, mime, fh.read())


def index_json(version="0.1.2"):
    with open(os.path.join(TEMPLATES, "index.html"), encoding="utf-8") as fh:
        html = fh.read()
    block = re.search(r'<script type="application/json" id="vibebiz-data">(.*?)</script>', html, re.S)
    data = json.loads(block.group(1))
    data["ideas"][0]["id"] = "001"
    out = {"vibebiz": "workspace", "storage": "drive", "toc_artifact": None,
           "plugin_version": version, "shared_ack": None}
    out.update(data)
    return json.dumps(out, ensure_ascii=False, indent=2) + "\n"


def workspace(b, name, version="0.1.2", parent="root", **folder_extra):
    root = b.add(name, parent, **folder_extra)
    b.add("index.json", root, "application/json", index_json(version))
    with open(os.path.join(TEMPLATES, "constitution.md"), encoding="utf-8") as fh:
        b.add("constitution.md", root, "text/markdown", fh.read())
    specs = b.add("specs", root)
    b.tree(EXAMPLE, b.add("001-giu-chan-khach-cu", specs))
    return root


def build(mode):
    if mode not in MODES:
        raise SystemExit("unknown mode %r; expected one of %s" % (mode, ", ".join(MODES)))
    b = Builder()
    data = {"mode": "normal", "bump_after_read": []}
    b.add("Báo cáo tuần", "root", "text/markdown", "Ghi chú riêng của người dùng, không phải của vibebiz.\n")
    if mode == "empty":
        pass
    elif mode == "two-workspaces":
        workspace(b, "vibebiz")
        workspace(b, "Ý tưởng 2026")
    elif mode == "shared-folder":
        workspace(b, "vibebiz", permissions=[
            {"type": "user", "role": "reader", "displayName": "Trần Minh (hư cấu)",
             "emailAddress": "reader@example.com"}])
    elif mode == "shared-drive":
        workspace(b, "vibebiz", driveId="shared-drive-1", permissions=[
            {"type": "group", "role": "writer", "displayName": "Phòng bán hàng (hư cấu)",
             "emailAddress": "sales@example.com"}])
    elif mode == "newer-version":
        workspace(b, "vibebiz", version="9.0.0")
    else:
        workspace(b, "vibebiz")
    if mode == "read-only":
        data["mode"] = "read-only"
    if mode == "drive-full":
        data["mode"] = "drive-full"
    if mode == "converted-file":
        for f in b.files.values():
            if f["title"] == "coverage.md":
                f["mimeType"] = GDOC
    data.update({"files": b.files, "next_id": 1, "clock": 1000, "bumped": []})
    return data


def main(argv):
    if len(argv) < 3 or len(argv) % 2 == 0:
        raise SystemExit(__doc__)
    mode, ws, rest = argv[1], argv[2], argv[3:]
    bumps = []
    for flag, value in zip(rest[::2], rest[1::2]):
        if flag != "--bump":
            raise SystemExit(__doc__)
        bumps.append(value)
    root = os.path.join(ws, ".fake-drive")
    os.makedirs(root, exist_ok=True)
    with open(os.path.join(root, "drive.json"), "w", encoding="utf-8") as fh:
        data = build(mode)
        data["bump_after_read"] = bumps
        json.dump(data, fh, ensure_ascii=False, indent=2)


if __name__ == "__main__":
    main(sys.argv)
