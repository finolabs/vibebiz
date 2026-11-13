#!/usr/bin/env python3
"""Fake Google Drive MCP server for vibebiz evals (development only, never shipped).

Mirrors the tool names and parameters of the Google Drive connector as read from its tool
schemas on 13/11/2026 (specs/002-drive-workspace/research.md R1). It keeps a small Drive in
<root>/drive.json, logs every call to <root>/calls.jsonl, and mirrors the live (not trashed)
files into <root>/tree/ so eval graders can read them. Google-type files are mirrored with a
".gdoc" suffix. The default root is ./.fake-drive in the server's working directory, which
`claude plugin eval` sets to the case workspace.

Fixture flags in drive.json:
  "mode": "normal" | "read-only" | "drive-full"
  "bump_after_read": [title, ...]  after the first content read of a file with that title,
                                   change its content and modifiedTime (another device edited
                                   it); fires once per title, so a same-title replacement that
                                   vibebiz creates and reads back is left alone

Standard library only. Python 3.10+.
"""

import argparse
import base64
import datetime as _dt
import hashlib
import json
import os
import re
import shutil
import sys
import unicodedata

SCHEMA_DATE = "2026-11-13"
FOLDER = "application/vnd.google-apps.folder"
GDOC = "application/vnd.google-apps.document"
GOOGLE_PREFIX = "application/vnd.google-apps."
GSHEET = "application/vnd.google-apps.spreadsheet"
CONVERTIBLE = {"text/plain": GDOC, "text/markdown": GDOC, "text/html": GDOC, "text/csv": GSHEET}
READABLE_GOOGLE = (GDOC, GSHEET, "application/vnd.google-apps.presentation")


class DriveError(Exception):
    pass


def unlink_if_link(path):
    if os.path.islink(path):
        os.unlink(path)


def refuse_links(root):
    """Fail closed when the state folder or any state file is a symlink (never read or write through one)."""
    for path in (root, os.path.join(root, "drive.json"), os.path.join(root, "tree"),
                 os.path.join(root, "calls.jsonl")):
        if os.path.islink(path):
            raise DriveError("Refused: the fake Drive state at %s is a symlink" % os.path.basename(path))


def safe_component(title):
    """Encode one Drive title as a single, harmless path component for the mirror tree."""
    out = title.replace("%", "%25").replace("/", "%2F").replace("\\", "%5C").replace("\0", "%00")
    if out in ("", ".", ".."):
        out = out.replace(".", "%2E") or "%00"
    return out


def fit_component(name, limit=200):
    """Keep an encoded title under common file-system limits (255 bytes) without losing uniqueness.

    Applied to the title before any suffix (".gdoc", ".dup-<id>"), so suffixes always survive.
    """
    if len(name.encode("utf-8")) <= limit:
        return name
    cut = name.encode("utf-8")[:limit].decode("utf-8", "ignore")
    # A hash of the whole title, so two items with one long title still collide and get ".dup-".
    return "%s~%s" % (cut, hashlib.sha1(name.encode("utf-8")).hexdigest()[:8])


# ---------------------------------------------------------------- state


class Drive:
    def __init__(self, root):
        self.root = root
        os.makedirs(root, exist_ok=True)
        self.path = os.path.join(root, "drive.json")
        if os.path.exists(self.path):
            with open(self.path, encoding="utf-8") as fh:
                self.data = json.load(fh)
        else:
            self.data = {}
        self.data.setdefault("mode", "normal")
        self.data.setdefault("files", {})
        self.data.setdefault("next_id", 1)
        self.data.setdefault("clock", 0)
        self.data.setdefault("bump_after_read", [])
        self.data.setdefault("bumped", [])
        self.save()

    @property
    def files(self):
        return self.data["files"]

    def tick(self):
        self.data["clock"] += 1
        base = _dt.datetime(2026, 11, 13, 8, 0, 0, tzinfo=_dt.timezone.utc)
        return (base + _dt.timedelta(seconds=self.data["clock"])).strftime("%Y-%m-%dT%H:%M:%S.000Z")

    def new_id(self):
        n = self.data["next_id"]
        self.data["next_id"] = n + 1
        return "f%04d" % n

    def get(self, file_id):
        f = self.files.get(file_id)
        if f is None:
            raise DriveError("File not found: %s" % file_id)
        return f

    def save(self):
        unlink_if_link(self.path)
        with open(self.path, "w", encoding="utf-8") as fh:
            json.dump(self.data, fh, ensure_ascii=False, indent=2)
        tree = os.path.join(self.root, "tree")
        unlink_if_link(tree)  # a symlinked tree would send the mirror elsewhere
        shutil.rmtree(tree, ignore_errors=True)
        os.makedirs(tree, exist_ok=True)
        real_tree = os.path.join(os.path.realpath(self.root), "tree") + os.sep
        if os.path.realpath(tree) + os.sep != real_tree:
            raise DriveError("Refused: the mirror folder is not a plain folder")
        dirs = {"root": tree}
        used = set()

        def place(parent_dir, f, suffix=""):
            name = fit_component(safe_component(f["title"])) + suffix
            target = os.path.join(parent_dir, name)
            # A second live item with one title (compared without case, as macOS does) stays
            # visible: the older item keeps the plain name, the newer one gets ".dup-<id>".
            key = unicodedata.normalize("NFC", target).casefold()
            if key in used:
                target = os.path.join(parent_dir, name + ".dup-" + f["id"])
                key = unicodedata.normalize("NFC", target).casefold()
            used.add(key)
            if not os.path.realpath(target).startswith(real_tree):
                return None  # never mirror outside the tree
            return target

        def folder_dir(fid, seen=()):
            if fid in dirs:
                return dirs[fid]
            f = self.files.get(fid)
            if f is None or fid in seen:
                return None
            parent = folder_dir(f.get("parentId") or "root", seen + (fid,))
            if parent is None:
                return None
            target = place(parent, f)
            if target is not None:
                os.makedirs(target, exist_ok=True)
            dirs[fid] = target
            return target

        live = sorted((f for f in self.files.values() if self._alive_chain(f)),
                      key=lambda f: (f.get("createdTime", f["modifiedTime"]), f["id"]))
        def depth(f):
            n, seen, pid = 0, set(), f.get("parentId")
            while pid not in (None, "root") and pid in self.files and pid not in seen:
                seen.add(pid)
                n += 1
                pid = self.files[pid].get("parentId")
            return n

        # Place folders level by level, oldest first, so the older of two same-title folders
        # keeps the plain name whatever order their children are reached in.
        for f in sorted((f for f in live if f["mimeType"] == FOLDER),
                        key=lambda f: (depth(f), f.get("createdTime", f["modifiedTime"]), f["id"])):
            folder_dir(f["id"])
        for f in live:
            if f["mimeType"] == FOLDER:
                continue
            parent = folder_dir(f.get("parentId") or "root")
            if parent is None:
                continue
            target = place(parent, f, ".gdoc" if f["mimeType"].startswith(GOOGLE_PREFIX) else "")
            if target is None:
                continue
            with open(target, "w", encoding="utf-8") as fh:
                fh.write(f.get("content", ""))

    def _alive_chain(self, f):
        seen = set()
        while f is not None and f["id"] not in seen:
            if f.get("trashed"):
                return False
            seen.add(f["id"])
            pid = f.get("parentId")
            f = self.files.get(pid) if pid not in (None, "root") else None
        return True


def public(f, drive):
    out = {
        "id": f["id"],
        "title": f["title"],
        "mimeType": f["mimeType"],
        "parentId": f.get("parentId", "root"),
        "modifiedTime": f["modifiedTime"],
        "createdTime": f.get("createdTime", f["modifiedTime"]),
        "etag": "etag-%s-%s" % (f["id"], f["modifiedTime"]),
        "trashed": bool(f.get("trashed")),
        "owner": f.get("owner", "me"),
        "visibility": visibility(f, drive),
    }
    if f.get("driveId"):
        out["driveId"] = f["driveId"]
    if f.get("creator"):
        out["creator"] = f["creator"]
    return out


def visibility(f, drive):
    perms = effective_permissions(f, drive)
    kinds = {p.get("type") for p in perms}
    if "anyone" in kinds:
        return "anyoneWithLink"
    if "domain" in kinds:
        return "domainWithLink"
    return "limited"


def effective_permissions(f, drive):
    perms = list(f.get("permissions", []))
    seen = {f["id"]}
    pid = None if f.get("inheritedPermissionsDisabled") else f.get("parentId")
    while pid not in (None, "root") and pid in drive.files and pid not in seen:
        seen.add(pid)
        parent = drive.files[pid]
        perms.extend(parent.get("permissions", []))
        pid = None if parent.get("inheritedPermissionsDisabled") else parent.get("parentId")
    if not any(p.get("role") == "owner" for p in perms):
        owner = f.get("owner", "me")
        perms.insert(0, {"id": "perm-owner", "type": "user", "role": "owner",
                         "displayName": "me" if owner == "me" else owner, "emailAddress": owner})
    return perms


# ---------------------------------------------------------------- search query

TOKEN = re.compile(r"\s*(\(|\)|'(?:\\'|[^'])*'|!=|<=|>=|=|<|>|[A-Za-z_]+)")


def tokenize(q):
    pos, out = 0, []
    while pos < len(q):
        if q[pos:].strip() == "":
            break
        m = TOKEN.match(q, pos)
        if not m:
            raise DriveError("Invalid query near: %s" % q[pos:pos + 20])
        out.append(m.group(1))
        pos = m.end()
    return out


class Query:
    def __init__(self, q):
        self.t = tokenize(q)
        self.i = 0
        self.mentions_trashed = False

    def peek(self):
        return self.t[self.i] if self.i < len(self.t) else None

    def take(self):
        tok = self.peek()
        self.i += 1
        return tok

    def parse(self):
        if not self.t:
            return lambda f, d: True
        node = self.expr()
        if self.peek() is not None:
            raise DriveError("Unexpected token: %s" % self.peek())
        return node

    def expr(self):
        left = self.term()
        while self.peek() == "or":
            self.take()
            right = self.term()
            left = (lambda a, b: lambda f, d: a(f, d) or b(f, d))(left, right)
        return left

    def term(self):
        left = self.factor()
        while self.peek() == "and":
            self.take()
            right = self.factor()
            left = (lambda a, b: lambda f, d: a(f, d) and b(f, d))(left, right)
        return left

    def factor(self):
        tok = self.peek()
        if tok == "not":
            self.take()
            inner = self.factor()
            return lambda f, d: not inner(f, d)
        if tok == "(":
            self.take()
            node = self.expr()
            if self.take() != ")":
                raise DriveError("Missing )")
            return node
        return self.clause()

    def clause(self):
        a = self.take()
        if a == "trashed":
            self.mentions_trashed = True
        if a and a.startswith("'"):
            value = unquote(a)
            if self.take() != "in":
                raise DriveError("Expected 'in'")
            field = self.take()
            return lambda f, d: in_clause(value, field, f, d)
        op = self.take()
        if op == "contains":
            value = unquote(self.take())
            return lambda f, d: contains_clause(a, value, f, d)
        if op not in ("=", "!=", "<", "<=", ">", ">="):
            raise DriveError("Unsupported operator: %s" % op)
        raw = self.take()
        value = unquote(raw) if raw and raw.startswith("'") else raw
        return lambda f, d: compare_clause(a, op, value, f, d)


def unquote(tok):
    if not tok or not tok.startswith("'"):
        raise DriveError("Expected a quoted value")
    return tok[1:-1].replace("\\'", "'")


def is_trashed(f, drive):
    return not drive._alive_chain(f)


def field_value(name, f, drive):
    if name == "title":
        return f["title"]
    if name == "mimeType":
        return f["mimeType"]
    if name == "parentId":
        return f.get("parentId", "root")
    if name in ("modifiedTime", "createdTime", "viewedByMeTime"):
        return f.get(name, f["modifiedTime"])
    if name == "owner":
        return f.get("owner", "me")
    if name == "creator":
        return f.get("creator", f.get("owner", "me"))
    if name == "trashed":
        return "true" if is_trashed(f, drive) else "false"
    if name == "visibility":
        return visibility(f, drive)
    if name in ("starred", "sharedWithMe"):
        return "true" if f.get(name) else "false"
    raise DriveError("Unsupported query term: %s" % name)


def compare_clause(name, op, value, f, drive):
    actual = field_value(name, f, drive)
    if op == "=":
        return actual == value
    if op == "!=":
        return actual != value
    if value is None:
        raise DriveError("Missing value after %s" % op)
    return {"<": actual < value, "<=": actual <= value, ">": actual > value, ">=": actual >= value}[op]


def contains_clause(name, value, f, drive):
    if name == "fullText":
        return value.lower() in (f["title"] + "\n" + f.get("content", "")).lower()
    return value.lower() in str(field_value(name, f, drive)).lower()


def in_clause(value, field, f, drive):
    if field in ("readers", "writers"):
        roles = ("reader", "commenter", "writer", "owner") if field == "readers" else ("writer", "owner")
        if value == "me" and f.get("owner", "me") == "me":
            return True
        return any(p.get("emailAddress") == value and p.get("role") in roles
                   for p in effective_permissions(f, drive))
    if field == "folderProperties":
        return value in f.get("folderProperties", [])
    raise DriveError("Unsupported 'in' field: %s" % field)


# ---------------------------------------------------------------- tools


def need_write(drive, adds_bytes=True):
    if drive.data["mode"] == "read-only":
        raise DriveError("Insufficient permissions: the connector has read-only access to this Drive.")
    if adds_bytes and drive.data["mode"] == "drive-full":
        raise DriveError("storageQuotaExceeded: The user's Drive storage quota has been exceeded.")


def maybe_bump(drive, f):
    if f["title"] in drive.data["bump_after_read"] and f["title"] not in drive.data["bumped"]:
        drive.data["bumped"].append(f["title"])
        f["content"] = f.get("content", "") + "\n<!-- edited on another device -->\n"
        f["modifiedTime"] = drive.tick()


def t_search_files(drive, a):
    parsed = Query(a.get("query") or "")
    match = parsed.parse()
    found = []
    for f in drive.files.values():
        # The connector documents trashed as "default false": without a trashed clause,
        # trashed files (and files inside a trashed folder) are left out.
        if not parsed.mentions_trashed and is_trashed(f, drive):
            continue
        if match(f, drive):
            found.append(f)
    if a.get("orderBy", "").startswith("modifiedTime"):
        found.sort(key=lambda f: f["modifiedTime"], reverse="asc" not in a["orderBy"])
    try:
        size = int(a.get("pageSize") or 50)
        start = int(a.get("pageToken") or 0)
    except (TypeError, ValueError):
        raise DriveError("pageSize and pageToken must be integers")
    page = found[start:start + size]
    out = []
    for f in page:
        item = public(f, drive)
        if not a.get("excludeContentSnippets") and not f["mimeType"] == FOLDER:
            item["snippet"] = f.get("content", "")[:200]
        out.append(item)
    result = {"files": out}
    if start + size < len(found):
        result["nextPageToken"] = str(start + size)
    return result


def t_read_file_content(drive, a):
    f = drive.get(a.get("fileId"))
    mt = f["mimeType"]
    if not (mt.startswith("text/") or mt in READABLE_GOOGLE):
        raise DriveError("Unsupported mime type for read_file_content: %s" % mt)
    text = f.get("content", "")
    maybe_bump(drive, f)
    return {"fileId": f["id"], "title": f["title"], "content": text}


def t_download_file_content(drive, a):
    f = drive.get(a.get("fileId"))
    if f["mimeType"] == FOLDER:
        raise DriveError("Cannot download a folder")
    text = f.get("content", "")
    maybe_bump(drive, f)
    return {"fileId": f["id"], "mimeType": f["mimeType"] if not f["mimeType"].startswith(GOOGLE_PREFIX) else "text/plain",
            "content": base64.b64encode(text.encode("utf-8")).decode("ascii")}


def t_create_file(drive, a):
    need_write(drive)
    title = a.get("title")
    if not isinstance(title, str) or not title:
        raise DriveError("title is required and must be text")
    parent = a.get("parentId") or "root"
    if parent != "root":
        p = drive.get(parent)
        if p["mimeType"] != FOLDER:
            raise DriveError("Parent is not a folder")
    mime = a.get("contentMimeType") or a.get("mimeType") or ""
    text = a.get("textContent")
    b64 = a.get("base64Content") or a.get("content")
    if text is not None and b64 is not None:
        raise DriveError("Set only one of textContent and base64Content")
    if b64 is not None:
        if b64.startswith("sha256:"):
            raise DriveError("File references are not supported by the fake Drive")
        try:
            text = base64.b64decode(b64, validate=True).decode("utf-8")
        except (ValueError, UnicodeDecodeError):
            raise DriveError("base64Content is not valid base64 UTF-8 text")
    if mime == FOLDER:
        final = FOLDER
        text = ""
    elif text is not None and not mime:
        raise DriveError("contentMimeType is required when content is provided")
    elif mime in CONVERTIBLE and not a.get("disableConversionToGoogleType"):
        final = CONVERTIBLE[mime]
    else:
        final = mime or GDOC
    now = drive.tick()
    f = {"id": drive.new_id(), "title": title, "mimeType": final, "parentId": parent,
         "content": text or "", "modifiedTime": now, "createdTime": now, "owner": "me"}
    if a.get("inheritedPermissionsDisabled") and final == FOLDER:
        f["inheritedPermissionsDisabled"] = True
    drive.files[f["id"]] = f
    return public(f, drive)


def t_copy_file(drive, a):
    need_write(drive)
    src = drive.get(a.get("fileId"))
    if src["mimeType"] == FOLDER:
        raise DriveError("Cannot copy a folder")
    parent = a.get("parentId") or src.get("parentId", "root")
    if parent != "root" and drive.get(parent)["mimeType"] != FOLDER:
        raise DriveError("Parent is not a folder")
    if a.get("title") is not None and not isinstance(a["title"], str):
        raise DriveError("title must be text")
    now = drive.tick()
    f = dict(src)
    f.update({"id": drive.new_id(), "title": a.get("title") or "Copy of " + src["title"],
              "parentId": parent, "modifiedTime": now, "createdTime": now, "permissions": []})
    f.pop("trashed", None)
    drive.files[f["id"]] = f
    return public(f, drive)


def t_trash_file(drive, a):
    need_write(drive, adds_bytes=False)
    f = drive.get(a.get("fileId"))
    f["trashed"] = True
    f["modifiedTime"] = drive.tick()
    return {}


def t_get_file_metadata(drive, a):
    f = drive.get(a.get("fileId"))
    out = public(f, drive)
    if a.get("includeRichMetadata"):
        out["owner_name"] = "me"
    return out


def t_get_file_permissions(drive, a):
    f = drive.get(a.get("fileId"))
    return {"permissions": effective_permissions(f, drive)}


def t_update_file(drive, a):
    need_write(drive, adds_bytes=False)
    f = drive.get(a.get("fileId"))
    if a.get("etag") and a["etag"] != public(f, drive)["etag"]:
        raise DriveError("FAILED_PRECONDITION: the file was modified since the etag was returned")
    if "title" in a and not (isinstance(a["title"], str) and a["title"]):
        raise DriveError("title must be non-empty text")
    pid = a.get("parentId")
    if pid and pid != "root":
        if drive.get(pid)["mimeType"] != FOLDER:
            raise DriveError("Parent is not a folder")
        cur, seen = pid, set()
        while cur not in (None, "root") and cur not in seen:
            if cur == f["id"]:
                raise DriveError("Cannot move a folder into itself")
            seen.add(cur)
            cur = drive.files.get(cur, {}).get("parentId")
    # All checks passed: apply every change together, as the real API does.
    for key in ("title", "description", "starred", "inheritedPermissionsDisabled"):
        if key in a:
            f[key] = a[key]
    if pid:
        f["parentId"] = pid
    f["modifiedTime"] = drive.tick()
    return public(f, drive)


def t_share_file(drive, a):
    need_write(drive, adds_bytes=False)
    f = drive.get(a.get("fileId"))
    perm = {"role": a.get("role")}
    if a.get("emailAddress"):
        perm.update(type="user", emailAddress=a["emailAddress"])
    elif a.get("permissionId") == "anyoneWithLink":
        perm.update(type="anyone")
    else:
        perm.update(type="audience", id=a.get("permissionId") or a.get("chatSpaceId"))
    f.setdefault("permissions", []).append(perm)
    return {"permission": perm}


def obj(props, required=()):
    return {"type": "object", "properties": props, "required": list(required)}


S, B, I = {"type": "string"}, {"type": "boolean"}, {"type": "integer"}

TOOLS = {
    "search_files": (t_search_files, "Search for Drive files using a structured query (title, fullText, mimeType, modifiedTime, parentId, owner, trashed, visibility, and/or/not).",
                     obj({"query": S, "pageSize": I, "pageToken": S, "orderBy": S, "excludeContentSnippets": B, "includeRichMetadata": B, "snippetVerbosity": S})),
    "read_file_content": (t_read_file_content, "Fetch a natural language representation of a known Drive file. Supports text/* and Google types.",
                          obj({"fileId": S, "includeComments": B}, ["fileId"])),
    "download_file_content": (t_download_file_content, "Download the content of a Drive file as a base64 encoded string.",
                              obj({"fileId": S, "exportMimeType": S, "revisionId": S}, ["fileId"])),
    "create_file": (t_create_file, "Create or upload a file to Google Drive. Text content in textContent with contentMimeType. By default supported content is converted to Google types; set disableConversionToGoogleType to keep it. Folders: contentMimeType application/vnd.google-apps.folder.",
                    obj({"title": S, "parentId": S, "contentMimeType": S, "textContent": S, "base64Content": S, "disableConversionToGoogleType": B, "inheritedPermissionsDisabled": B, "pregeneratedId": S}, ["title"])),
    "copy_file": (t_copy_file, "Copy an existing file, optionally with a new title and parent folder.",
                  obj({"fileId": S, "parentId": S, "title": S, "pregeneratedId": S}, ["fileId"])),
    "trash_file": (t_trash_file, "Move a Drive file to the trash. It does not permanently delete the file.",
                   obj({"fileId": S}, ["fileId"])),
    "get_file_metadata": (t_get_file_metadata, "Get general metadata about a Drive file, including modifiedTime and etag.",
                          obj({"fileId": S, "includeRichMetadata": B, "excludeContentSnippets": B, "snippetVerbosity": S}, ["fileId"])),
    "get_file_permissions": (t_get_file_permissions, "List the permissions of a Drive file.",
                             obj({"fileId": S}, ["fileId"])),
    "update_file": (t_update_file, "Update the metadata of a Drive file (title, parent, description, starred, inherited permissions). Does not change content.",
                    obj({"fileId": S, "title": S, "parentId": S, "description": S, "starred": B, "etag": S, "inheritedPermissionsDisabled": B}, ["fileId"])),
    "share_file": (t_share_file, "Share a Drive file with a user, group, or anyone with the link.",
                   obj({"fileId": S, "role": S, "emailAddress": S, "permissionId": S, "chatSpaceId": S, "expirationTime": S}, ["fileId", "role"])),
}


# ---------------------------------------------------------------- MCP stdio


def log_call(root, name, args, result, error):
    path = os.path.join(root, "calls.jsonl")
    unlink_if_link(path)
    seq = 1
    if os.path.exists(path):
        with open(path, encoding="utf-8") as fh:
            seq = sum(1 for _ in fh) + 1
    entry = {"seq": seq, "tool": name, "args": args, "ok": error is None}
    if error is not None:
        entry["error"] = error
    with open(path, "a", encoding="utf-8") as fh:
        fh.write(json.dumps(entry, ensure_ascii=False) + "\n")


def call_tool(root, name, args):
    refuse_links(root)  # nothing is read, written or logged through a link
    drive = Drive(root)
    try:
        try:
            if name not in TOOLS:
                raise DriveError("Unknown tool: %s" % name)
            if not isinstance(args, dict):
                raise DriveError("Arguments must be an object")
            result = TOOLS[name][0](drive, args)
        except DriveError:
            raise
        except Exception as exc:  # a bad argument must never kill the stdio loop
            raise DriveError("Invalid request: %s" % exc.__class__.__name__)
    except DriveError as exc:
        drive.save()
        log_call(root, name, args, None, str(exc))
        raise
    drive.save()
    log_call(root, name, args, result, None)
    return result


def serve(root):
    def send(msg):
        sys.stdout.write(json.dumps(msg, ensure_ascii=False) + "\n")
        sys.stdout.flush()

    for line in sys.stdin:
        line = line.strip()
        if not line:
            continue
        try:
            msg = json.loads(line)
        except ValueError:
            continue
        mid, method = msg.get("id"), msg.get("method")
        if method == "initialize":
            send({"jsonrpc": "2.0", "id": mid, "result": {
                "protocolVersion": (msg.get("params") or {}).get("protocolVersion", "2024-11-05"),
                "capabilities": {"tools": {}},
                "serverInfo": {"name": "google-drive", "version": "fake-" + SCHEMA_DATE}}})
        elif method == "tools/list":
            send({"jsonrpc": "2.0", "id": mid, "result": {"tools": [
                {"name": n, "description": d, "inputSchema": s} for n, (_, d, s) in TOOLS.items()]}})
        elif method == "tools/call":
            params = msg.get("params") or {}
            try:
                result = call_tool(root, params.get("name"), params.get("arguments") or {})
                send({"jsonrpc": "2.0", "id": mid, "result": {
                    "content": [{"type": "text", "text": json.dumps(result, ensure_ascii=False)}]}})
            except Exception as exc:  # never let one bad call end the server
                send({"jsonrpc": "2.0", "id": mid, "result": {
                    "content": [{"type": "text", "text": str(exc) if isinstance(exc, DriveError) else "Internal error"}],
                    "isError": True}})
        elif mid is not None:
            send({"jsonrpc": "2.0", "id": mid, "result": {}})


def main(argv=None):
    ap = argparse.ArgumentParser(description=__doc__.splitlines()[0])
    ap.add_argument("--root", default=os.path.join(os.getcwd(), ".fake-drive"))
    args = ap.parse_args(argv)
    serve(os.path.abspath(args.root))


if __name__ == "__main__":
    main()
