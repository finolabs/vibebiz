#!/usr/bin/env python3
"""Tests for the fake Drive server and its fixtures. Run: python3 evals/fake-drive/test_server.py"""

import base64
import importlib.util
import json
import os
import subprocess
import sys
import tempfile
import unittest

HERE = os.path.dirname(os.path.abspath(__file__))


def load(name):
    spec = importlib.util.spec_from_file_location(name, os.path.join(HERE, name + ".py"))
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    return mod


server = load("server")
fixtures = load("fixtures")


class Base(unittest.TestCase):
    mode = "empty"
    bumps = ()

    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory()
        self.ws = self.tmp.name
        args = ["fixtures.py", self.mode, self.ws]
        for b in self.bumps:
            args += ["--bump", b]
        fixtures.main(args)
        self.root = os.path.join(self.ws, ".fake-drive")

    def tearDown(self):
        self.tmp.cleanup()

    def call(self, name, **args):
        return server.call_tool(self.root, name, args)

    def calls(self):
        with open(os.path.join(self.root, "calls.jsonl"), encoding="utf-8") as fh:
            return [json.loads(line) for line in fh]

    def find(self, query):
        return self.call("search_files", query=query)["files"]


class CreateAndRead(Base):
    def test_plain_markdown_stays_plain_and_reads_back(self):
        folder = self.call("create_file", title="vibebiz", contentMimeType=server.FOLDER)
        text = "# Ý tưởng\n\nNhắc khách quay lại — có dấu tiếng Việt.\n"
        f = self.call("create_file", title="spec.md", parentId=folder["id"], contentMimeType="text/markdown",
                      textContent=text, disableConversionToGoogleType=True)
        self.assertEqual(f["mimeType"], "text/markdown")
        self.assertEqual(self.call("read_file_content", fileId=f["id"])["content"], text)
        with open(os.path.join(self.root, "tree", "vibebiz", "spec.md"), encoding="utf-8") as fh:
            self.assertEqual(fh.read(), text)

    def test_text_is_converted_without_the_flag(self):
        f = self.call("create_file", title="notes.md", contentMimeType="text/markdown", textContent="x")
        self.assertEqual(f["mimeType"], server.GDOC)
        self.assertTrue(os.path.exists(os.path.join(self.root, "tree", "notes.md.gdoc")))

    def test_json_needs_download_not_read(self):
        f = self.call("create_file", title="index.json", contentMimeType="application/json",
                      textContent='{"vibebiz": "workspace"}', disableConversionToGoogleType=True)
        with self.assertRaises(server.DriveError):
            self.call("read_file_content", fileId=f["id"])
        got = self.call("download_file_content", fileId=f["id"])["content"]
        self.assertEqual(json.loads(base64.b64decode(got)), {"vibebiz": "workspace"})

    def test_no_content_update_tool(self):
        self.assertNotIn("update_file_content", server.TOOLS)
        f = self.call("create_file", title="a.md", contentMimeType="text/markdown", textContent="1",
                      disableConversionToGoogleType=True)
        self.call("update_file", fileId=f["id"], title="b.md")
        self.assertEqual(self.call("read_file_content", fileId=f["id"])["content"], "1")


class SearchCopyTrash(Base):
    mode = "one-workspace"

    def test_search_exact_title_finds_marker_file(self):
        hits = self.find("title = 'index.json' and trashed = false and owner = 'me'")
        self.assertEqual(len(hits), 1)
        raw = self.call("download_file_content", fileId=hits[0]["id"])["content"]
        self.assertEqual(json.loads(base64.b64decode(raw))["vibebiz"], "workspace")

    def test_search_survives_folder_rename(self):
        folder = self.find("title = 'vibebiz' and mimeType = '%s'" % server.FOLDER)[0]
        self.call("update_file", fileId=folder["id"], title="Ý tưởng cửa hàng")
        self.assertEqual(len(self.find("title = 'index.json' and trashed = false")), 1)

    def test_trash_hides_file_and_tree(self):
        f = self.find("title = 'glossary.md'")[0]
        self.call("trash_file", fileId=f["id"])
        self.assertEqual(self.find("title = 'glossary.md' and trashed = false"), [])
        self.assertEqual(len(self.find("title = 'glossary.md' and trashed = true")), 1)
        tree = os.path.join(self.root, "tree", "vibebiz", "specs", "001-giu-chan-khach-cu", "glossary.md")
        self.assertFalse(os.path.exists(tree))

    def test_copy_into_history(self):
        links = self.find("title = 'links.md'")[0]
        exports = self.find("title = 'exports'")[0]
        hist = self.call("create_file", title="history", parentId=exports["id"], contentMimeType=server.FOLDER)
        day = self.call("create_file", title="2026-11-13", parentId=hist["id"], contentMimeType=server.FOLDER)
        copy = self.call("copy_file", fileId=links["id"], parentId=day["id"], title="links.md")
        self.assertEqual(copy["parentId"], day["id"])
        self.assertEqual(len(self.find("title = 'links.md' and trashed = false")), 2)

    def test_parentheses_not_and_or(self):
        hits = self.find("(title = 'plan.md' or title = 'spec.md') and not mimeType = '%s'" % server.FOLDER)
        self.assertEqual(sorted(h["title"] for h in hits), ["plan.md", "spec.md", "spec.md"])

    def test_html_views_not_in_fixture(self):
        self.assertEqual(self.find("title = 'board-deck.html' or title = 'tech-prd.html'"), [])


class Modes(Base):
    def test_read_only_refuses_writes_and_logs(self):
        fixtures.main(["fixtures.py", "read-only", self.ws])
        with self.assertRaises(server.DriveError) as ctx:
            self.call("create_file", title="x.md", contentMimeType="text/markdown", textContent="x")
        self.assertIn("read-only", str(ctx.exception))
        self.assertEqual(self.calls()[-1]["ok"], False)

    def test_drive_full_refuses_writes(self):
        fixtures.main(["fixtures.py", "drive-full", self.ws])
        with self.assertRaises(server.DriveError) as ctx:
            self.call("create_file", title="x.md", contentMimeType="text/markdown", textContent="x")
        self.assertIn("storageQuotaExceeded", str(ctx.exception))

    def test_shared_folder_permissions_and_visibility(self):
        fixtures.main(["fixtures.py", "shared-folder", self.ws])
        spec = self.find("title = 'spec.md'")[0]
        perms = self.call("get_file_permissions", fileId=spec["id"])["permissions"]
        self.assertTrue(any(p.get("role") == "reader" for p in perms))
        self.assertEqual(spec["visibility"], "limited")

    def test_share_is_visible_in_log_and_visibility(self):
        fixtures.main(["fixtures.py", "one-workspace", self.ws])
        spec = self.find("title = 'coverage.md'")[0]
        self.call("share_file", fileId=spec["id"], role="reader", permissionId="anyoneWithLink")
        self.assertEqual(self.calls()[-1]["tool"], "share_file")
        self.assertEqual(self.call("get_file_metadata", fileId=spec["id"])["visibility"], "anyoneWithLink")

    def test_shared_drive_marks_drive_id(self):
        fixtures.main(["fixtures.py", "shared-drive", self.ws])
        folder = self.find("title = 'vibebiz'")[0]
        self.assertEqual(self.call("get_file_metadata", fileId=folder["id"])["driveId"], "shared-drive-1")

    def test_converted_file_is_google_type(self):
        fixtures.main(["fixtures.py", "converted-file", self.ws])
        self.assertEqual(self.find("title = 'coverage.md'")[0]["mimeType"], server.GDOC)

    def test_newer_version_marker(self):
        fixtures.main(["fixtures.py", "newer-version", self.ws])
        f = self.find("title = 'index.json'")[0]
        data = json.loads(base64.b64decode(self.call("download_file_content", fileId=f["id"])["content"]))
        self.assertEqual(data["plugin_version"], "9.0.0")

    def test_two_workspaces(self):
        fixtures.main(["fixtures.py", "two-workspaces", self.ws])
        self.assertEqual(len(self.find("title = 'index.json' and trashed = false")), 2)


class Bump(Base):
    mode = "one-workspace"
    bumps = ("coverage.md",)

    def test_file_changes_after_first_read(self):
        f = self.find("title = 'coverage.md'")[0]
        before = f["modifiedTime"]
        self.call("read_file_content", fileId=f["id"])
        after = self.call("get_file_metadata", fileId=f["id"])["modifiedTime"]
        self.assertNotEqual(before, after)
        self.call("read_file_content", fileId=f["id"])
        self.assertEqual(self.call("get_file_metadata", fileId=f["id"])["modifiedTime"], after)


class Log(Base):
    def test_one_line_per_call(self):
        self.call("search_files", query="title = 'x'")
        self.call("create_file", title="x.md", contentMimeType="text/markdown", textContent="x",
                  disableConversionToGoogleType=True)
        log = self.calls()
        self.assertEqual([e["tool"] for e in log], ["search_files", "create_file"])
        self.assertEqual(log[1]["args"]["title"], "x.md")


class Stdio(Base):
    def test_protocol_round_trip(self):
        msgs = [
            {"jsonrpc": "2.0", "id": 1, "method": "initialize", "params": {"protocolVersion": "2024-11-05"}},
            {"jsonrpc": "2.0", "method": "notifications/initialized"},
            {"jsonrpc": "2.0", "id": 2, "method": "tools/list"},
            {"jsonrpc": "2.0", "id": 3, "method": "tools/call",
             "params": {"name": "search_files", "arguments": {"query": "title contains 'Báo'"}}},
            {"jsonrpc": "2.0", "id": 4, "method": "tools/call",
             "params": {"name": "read_file_content", "arguments": {"fileId": "nope"}}},
        ]
        out = subprocess.run([sys.executable, "-I", os.path.join(HERE, "server.py")], cwd=self.ws,
                             input="".join(json.dumps(m) + "\n" for m in msgs),
                             capture_output=True, text=True, timeout=30, check=True)
        replies = {r["id"]: r for r in map(json.loads, out.stdout.splitlines())}
        self.assertEqual(replies[1]["result"]["serverInfo"]["name"], "google-drive")
        names = {t["name"] for t in replies[2]["result"]["tools"]}
        self.assertEqual(names, set(server.TOOLS))
        found = json.loads(replies[3]["result"]["content"][0]["text"])["files"]
        self.assertEqual([f["title"] for f in found], ["Báo cáo tuần"])
        self.assertTrue(replies[4]["result"]["isError"])


class Hostile(Base):
    def test_titles_never_escape_the_tree(self):
        evil = ["../../x.md", "../calls.jsonl", "/tmp/abs-%d.md" % os.getpid(), "..", ".", "a/b.md", ""]
        folder = self.call("create_file", title="..", contentMimeType=server.FOLDER)
        self.call("create_file", title="child.md", parentId=folder["id"], contentMimeType="text/markdown",
                  textContent="c", disableConversionToGoogleType=True)
        for t in evil:
            try:
                self.call("create_file", title=t, contentMimeType="text/markdown", textContent="x",
                          disableConversionToGoogleType=True)
            except server.DriveError:
                pass
        f = self.call("create_file", title="ok.md", contentMimeType="text/markdown", textContent="1",
                      disableConversionToGoogleType=True)
        self.call("update_file", fileId=f["id"], title="../../renamed.md")
        tree = os.path.realpath(os.path.join(self.root, "tree")) + os.sep
        for dirpath, _, names in os.walk(self.ws):
            for n in names:
                full = os.path.realpath(os.path.join(dirpath, n))
                if not full.startswith(tree):
                    self.assertIn(os.path.basename(full), ("drive.json", "calls.jsonl"), full)
        self.assertFalse(os.path.exists("/tmp/abs-%d.md" % os.getpid()))
        self.assertTrue(os.path.exists(os.path.join(self.root, "tree", "a%2Fb.md")))
        self.assertTrue(os.path.exists(os.path.join(self.root, "tree", "%2E%2E", "child.md")))
        self.assertTrue(all("seq" in e for e in self.calls()))

    def test_bad_arguments_are_errors_and_logged(self):
        bad = [("search_files", {"query": "title = 'x'", "pageToken": "x"}),
               ("search_files", {"query": "modifiedTime >"}),
               ("create_file", {"title": "x", "contentMimeType": "text/plain", "base64Content": "!!!"}),
               ("create_file", {"title": "x", "contentMimeType": "text/plain",
                                "base64Content": base64.b64encode(b"\xff\xfe").decode()}),
               ("update_file_content", {"fileId": "f0001"})]
        for name, args in bad:
            with self.assertRaises(server.DriveError):
                server.call_tool(self.root, name, args)
        log = self.calls()
        self.assertEqual([e["tool"] for e in log], [n for n, _ in bad])
        self.assertFalse(any(e["ok"] for e in log))

    def test_server_survives_bad_call_over_stdio(self):
        msgs = [{"jsonrpc": "2.0", "id": 1, "method": "tools/call",
                 "params": {"name": "search_files", "arguments": {"pageToken": "x"}}},
                {"jsonrpc": "2.0", "id": 2, "method": "tools/list"}]
        out = subprocess.run([sys.executable, "-I", os.path.join(HERE, "server.py")], cwd=self.ws,
                             input="".join(json.dumps(m) + "\n" for m in msgs),
                             capture_output=True, text=True, timeout=30, check=True)
        replies = {r["id"]: r for r in map(json.loads, out.stdout.splitlines())}
        self.assertTrue(replies[1]["result"]["isError"])
        self.assertIn("tools", replies[2]["result"])


class TrashAndMove(Base):
    mode = "one-workspace"

    def test_trashed_folder_hides_children_from_search(self):
        folder = self.find("title = 'vibebiz'")[0]
        self.call("trash_file", fileId=folder["id"])
        self.assertEqual(self.find("title = 'index.json' and trashed = false"), [])
        self.assertEqual(len(self.find("title = 'index.json' and trashed = true")), 1)
        self.assertEqual(self.find("title = 'index.json'"), [])
        self.assertEqual(self.find("title contains 'trashed'"), [])

    def test_move_rejects_cycles_and_non_folders(self):
        folder = self.find("title = 'vibebiz'")[0]
        specs = self.find("title = 'specs'")[0]
        plan = self.find("title = 'plan.md'")[0]
        with self.assertRaises(server.DriveError):
            self.call("update_file", fileId=folder["id"], parentId=specs["id"])
        with self.assertRaises(server.DriveError):
            self.call("update_file", fileId=folder["id"], parentId=plan["id"])

    def test_duplicate_folders_stay_visible(self):
        self.call("create_file", title="vibebiz", contentMimeType=server.FOLDER)
        names = os.listdir(os.path.join(self.root, "tree"))
        self.assertEqual(sum(1 for n in names if n.startswith("vibebiz")), 2)

    def test_duplicate_files_get_dup_suffix(self):
        exports = self.find("title = 'exports'")[0]
        self.call("create_file", title="links.md", parentId=exports["id"], contentMimeType="text/markdown",
                  textContent="new", disableConversionToGoogleType=True)
        d = os.path.join(self.root, "tree", "vibebiz", "specs", "001-giu-chan-khach-cu", "exports")
        self.assertEqual(sum(1 for n in os.listdir(d) if n.startswith("links.md")), 2)

    def test_etag_mismatch_fails(self):
        plan = self.find("title = 'plan.md'")[0]
        with self.assertRaises(server.DriveError):
            self.call("update_file", fileId=plan["id"], title="x", etag="stale")

    def test_pagination_and_order(self):
        first = self.call("search_files", query="mimeType = 'text/markdown'", pageSize=3, orderBy="modifiedTime desc")
        self.assertEqual(len(first["files"]), 3)
        times = [f["modifiedTime"] for f in first["files"]]
        self.assertEqual(times, sorted(times, reverse=True))
        rest = self.call("search_files", query="mimeType = 'text/markdown'", pageToken=first["nextPageToken"])
        self.assertTrue(rest["files"])

    def test_copy_default_title_and_parent(self):
        plan = self.find("title = 'plan.md'")[0]
        copy = self.call("copy_file", fileId=plan["id"])
        self.assertEqual(copy["title"], "Copy of plan.md")
        self.assertEqual(copy["parentId"], plan["parentId"])

    def test_csv_converts_to_sheet_and_google_download_is_text(self):
        f = self.call("create_file", title="t.csv", contentMimeType="text/csv", textContent="a,b")
        self.assertEqual(f["mimeType"], server.GSHEET)
        self.assertEqual(self.call("read_file_content", fileId=f["id"])["content"], "a,b")
        got = self.call("download_file_content", fileId=f["id"])
        self.assertEqual(got["mimeType"], "text/plain")


class BumpPerTitle(Base):
    mode = "one-workspace"
    bumps = ("coverage.md",)

    def test_replacement_read_back_is_not_bumped(self):
        old = self.find("title = 'coverage.md'")[0]
        self.call("read_file_content", fileId=old["id"])
        new = self.call("create_file", title="coverage.md", parentId=old["parentId"],
                        contentMimeType="text/markdown", textContent="new", disableConversionToGoogleType=True)
        self.assertEqual(self.call("read_file_content", fileId=new["id"])["content"], "new")


class NewModes(Base):
    def test_drive_full_still_allows_trash(self):
        fixtures.main(["fixtures.py", "drive-full", self.ws])
        self.call("trash_file", fileId=self.find("title = 'glossary.md'")[0]["id"])

    def test_shared_drive_files_are_not_owned_by_me(self):
        fixtures.main(["fixtures.py", "shared-drive", self.ws])
        self.assertEqual(self.find("title = 'index.json' and trashed = false and owner = 'me'"), [])
        hits = self.find("title = 'index.json' and trashed = false and 'me' in writers")
        self.assertEqual(len(hits), 0)  # group membership is not modelled; drive members find it by driveId
        idx = self.find("title = 'index.json' and trashed = false")[0]
        self.assertEqual(idx["driveId"], "shared-drive-1")

    def test_foreign_marker_is_shared_not_owned(self):
        fixtures.main(["fixtures.py", "foreign-marker", self.ws])
        self.assertEqual(self.find("title = 'index.json' and trashed = false and owner = 'me'"), [])
        hit = self.find("title = 'index.json' and trashed = false and 'me' in writers")
        self.assertEqual(len(hit), 1)
        self.assertEqual(hit[0]["owner"], "outsider@example.com")
        self.assertNotIn("driveId", hit[0])

    def test_shared_ack_changed_is_now_link_visible(self):
        fixtures.main(["fixtures.py", "shared-ack-changed", self.ws])
        folder = self.find("title = 'vibebiz'")[0]
        self.assertEqual(folder["visibility"], "anyoneWithLink")
        idx = self.find("title = 'index.json'")[0]
        data = json.loads(base64.b64decode(self.call("download_file_content", fileId=idx["id"])["content"]))
        self.assertEqual(data["shared_ack"]["ids"], ["perm-reader-1"])
        self.assertNotIn("@", json.dumps(data["shared_ack"]))

    def test_file_restricted_permissions_differ_from_folder(self):
        fixtures.main(["fixtures.py", "file-restricted", self.ws])
        dec = self.find("title = 'decisions.md'")[0]
        perms = self.call("get_file_permissions", fileId=dec["id"])["permissions"]
        self.assertEqual([p["role"] for p in perms], ["owner"])
        spec = self.find("title = 'spec.md'")[0]
        self.assertTrue(any(p.get("id") == "perm-tech-1"
                            for p in self.call("get_file_permissions", fileId=spec["id"])["permissions"]))

    def test_injected_instruction_present(self):
        fixtures.main(["fixtures.py", "injected-instruction", self.ws])
        cov = self.find("title = 'coverage.md'")[0]
        self.assertIn("chia sẻ thư mục", self.call("read_file_content", fileId=cov["id"])["content"])


if __name__ == "__main__":
    unittest.main()
