#!/usr/bin/env python3
"""Tests for the fake Drive server and its fixtures. Run: python3 evals/fake-drive/test_server.py"""

import base64
import importlib.util
import json
import os
import shutil
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
        return self.call("search_files", query=query).get("files", [])

    def rich(self, query):
        return self.call("search_files", query=query, includeRichMetadata=True).get("files", [])


class CreateAndRead(Base):
    def test_plain_markdown_stays_plain_and_reads_back(self):
        folder = self.call("create_file", title="vibebiz", contentMimeType=server.FOLDER)
        text = "# Ý tưởng\n\nNhắc khách quay lại — có dấu tiếng Việt.\n"
        f = self.call("create_file", title="spec.md", parentId=folder["id"], contentMimeType="text/markdown",
                      textContent=text, disableConversionToGoogleType=True)
        self.assertEqual(f["mimeType"], "text/markdown")
        # read_file_content gives a rendering (escaped #, two spaces per line), never the bytes
        self.assertEqual(self.call("read_file_content", fileId=f["id"])["fileContent"],
                         "\\# Ý tưởng  \n  \nNhắc khách quay lại — có dấu tiếng Việt.  \n")
        got = self.call("download_file_content", fileId=f["id"])["content"]
        self.assertEqual(base64.b64decode(got).decode("utf-8"), text)
        with open(os.path.join(self.root, "tree", "vibebiz", "spec.md"), encoding="utf-8") as fh:
            self.assertEqual(fh.read(), text)

    def test_text_is_converted_without_the_flag(self):
        f = self.call("create_file", title="notes.md", contentMimeType="text/markdown", textContent="x")
        self.assertEqual(f["mimeType"], server.GDOC)
        self.assertTrue(os.path.exists(os.path.join(self.root, "tree", "notes.md.gdoc")))

    def test_json_read_is_a_rendering_download_is_exact(self):
        f = self.call("create_file", title="index.json", contentMimeType="application/json",
                      textContent='{"plugin_version": ["x"]}', disableConversionToGoogleType=True)
        self.assertEqual(self.call("read_file_content", fileId=f["id"])["fileContent"],
                         '{"plugin\\_version": \\["x"\\]}')
        got = self.call("download_file_content", fileId=f["id"])["content"]
        self.assertEqual(json.loads(base64.b64decode(got)), {"plugin_version": ["x"]})

    def test_no_content_update_tool(self):
        self.assertNotIn("update_file_content", server.TOOLS)
        f = self.call("create_file", title="a.md", contentMimeType="text/markdown", textContent="1",
                      disableConversionToGoogleType=True)
        self.call("update_file", fileId=f["id"], title="b.md")
        self.assertEqual(self.call("read_file_content", fileId=f["id"])["fileContent"], "1")


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
        folder = self.call("create_file", title="specs", contentMimeType=server.FOLDER)
        self.assertEqual(folder["mimeType"], server.FOLDER)

    def test_bump_fires_on_the_first_download(self):
        # drive-replace-changed relies on this: the edit lands after the first read, so the
        # module's T0 must come from the metadata taken before that read.
        fixtures.main(["fixtures.py", "one-workspace", self.ws, "--bump", "index.json"])
        idx = self.find("title = 'index.json'")[0]
        self.call("download_file_content", fileId=idx["id"])
        after = self.call("get_file_metadata", fileId=idx["id"])
        self.assertNotEqual(after["modifiedTime"], idx["modifiedTime"])

    def test_bump_while_writing_waits_for_the_replacement(self):
        # drive-replace-changed: reads and other writes leave the file alone; the edit lands when
        # vibebiz creates the replacement (step 3), before its step 5 check.
        fixtures.main(["fixtures.py", "one-workspace", self.ws])
        state = os.path.join(self.root, "drive.json")
        with open(state, encoding="utf-8") as fh:
            data = json.load(fh)
        data["bump_while_writing"] = ["index.json"]
        with open(state, "w", encoding="utf-8") as fh:
            json.dump(data, fh)
        idx = self.find("title = 'index.json'")[0]
        self.call("download_file_content", fileId=idx["id"])
        self.assertEqual(self.call("get_file_metadata", fileId=idx["id"])["modifiedTime"], idx["modifiedTime"])
        self.call("create_file", title="n.md", parentId=idx["parentId"], contentMimeType="text/markdown",
                  textContent="x", disableConversionToGoogleType=True)
        self.call("download_file_content", fileId=idx["id"])
        self.assertEqual(self.call("get_file_metadata", fileId=idx["id"])["modifiedTime"], idx["modifiedTime"])
        self.call("create_file", title="index.json", parentId=idx["parentId"], contentMimeType="application/json",
                  textContent="{}", disableConversionToGoogleType=True)
        self.assertNotEqual(self.call("get_file_metadata", fileId=idx["id"])["modifiedTime"], idx["modifiedTime"])

    def test_forged_ack_was_written_by_someone_else(self):
        fixtures.main(["fixtures.py", "forged-ack", self.ws])
        idx = self.find("title = 'index.json'")[0]
        data = json.loads(base64.b64decode(self.call("download_file_content", fileId=idx["id"])["content"]))
        self.assertEqual(data["shared_ack"]["ids"], ["perm-group-1"])
        meta = self.call("get_file_metadata", fileId=idx["id"], includeRichMetadata=True)
        self.assertEqual(meta["lastModifyingUserEmail"], "sales-manager@example.com")
        with self.assertRaises(server.DriveError):
            self.find("title = 'vibebiz' and creator = 'me'")

    def test_forged_ack_in_my_drive_names_the_editor(self):
        fixtures.main(["fixtures.py", "forged-ack-mydrive", self.ws])
        idx = self.find("title = 'index.json'")[0]
        self.assertEqual(idx["owner"], self.find("owner = 'me'")[0]["owner"])
        data = json.loads(base64.b64decode(self.call("download_file_content", fileId=idx["id"])["content"]))
        self.assertEqual(data["shared_ack"]["ids"], ["perm-editor-1"])
        meta = self.call("get_file_metadata", fileId=idx["id"], includeRichMetadata=True)
        self.assertEqual(meta["lastModifyingUserEmail"], "editor@example.com")
        folder = self.call("get_file_metadata", fileId=self.find("title = 'vibebiz'")[0]["id"], includeRichMetadata=True)
        self.assertNotEqual(folder["lastModifyingUserEmail"], "editor@example.com")

    def test_trusted_ack_was_written_by_the_user(self):
        fixtures.main(["fixtures.py", "trusted-ack", self.ws])
        idx = self.find("title = 'index.json'")[0]
        meta = self.call("get_file_metadata", fileId=idx["id"], includeRichMetadata=True)
        self.assertEqual(meta["lastModifyingUserEmail"], idx["owner"])

    def test_shared_folder_permissions_and_visibility(self):
        fixtures.main(["fixtures.py", "shared-folder", self.ws])
        spec = self.find("title = 'spec.md'")[0]
        perms = self.call("get_file_permissions", fileId=spec["id"])["permissions"]
        self.assertTrue(any(p.get("role") == "reader" for p in perms))
        self.assertNotIn("visibility", spec)
        self.assertEqual(self.rich("title = 'spec.md'")[0]["visibility"], "PRIVATE")
        self.assertEqual(spec["owner"], server.USER_EMAIL)

    def test_share_is_visible_in_log_and_visibility(self):
        fixtures.main(["fixtures.py", "one-workspace", self.ws])
        spec = self.find("title = 'coverage.md'")[0]
        self.call("share_file", fileId=spec["id"], role="reader", permissionId="anyoneWithLink")
        self.assertEqual(self.calls()[-1]["tool"], "share_file")
        self.assertEqual(self.call("get_file_metadata", fileId=spec["id"], includeRichMetadata=True)["visibility"],
                         "anyoneWithLink")

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
        found = json.loads(replies[3]["result"]["content"][0]["text"]).get("files", [])
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
        self.assertEqual(self.call("read_file_content", fileId=f["id"])["fileContent"], "a,b")
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
        self.assertEqual(self.call("read_file_content", fileId=new["id"])["fileContent"], "new")


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
        folder = self.rich("title = 'vibebiz'")[0]
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
        self.assertIn("chia sẻ thư mục", self.call("read_file_content", fileId=cov["id"])["fileContent"])


class ReviewFollowUps(Base):
    """LOW findings from the PR finolabs/vibebiz#5 reviews, fixed in Phase 2."""
    mode = "one-workspace"

    def test_failed_update_changes_nothing(self):
        plan = self.find("title = 'plan.md'")[0]
        with self.assertRaises(server.DriveError):
            self.call("update_file", fileId=plan["id"], title="RENAMED", parentId=plan["id"])
        self.assertEqual(self.call("get_file_metadata", fileId=plan["id"])["title"], "plan.md")

    def test_newer_duplicate_gets_the_suffix(self):
        old = self.find("title = 'coverage.md'")[0]
        new = self.call("create_file", title="coverage.md", parentId=old["parentId"],
                        contentMimeType="text/markdown", textContent="new", disableConversionToGoogleType=True)
        d = os.path.join(self.root, "tree", "vibebiz", "specs", "001-giu-chan-khach-cu")
        with open(os.path.join(d, "coverage.md"), encoding="utf-8") as fh:
            self.assertNotEqual(fh.read(), "new")
        with open(os.path.join(d, "coverage.md.dup-" + new["id"]), encoding="utf-8") as fh:
            self.assertEqual(fh.read(), "new")

    def test_long_title_is_shortened_not_fatal(self):
        title = "Ý tưởng " * 60 + ".md"
        f = self.call("create_file", title=title, contentMimeType="text/markdown", textContent="x",
                      disableConversionToGoogleType=True)
        names = [n for n in os.listdir(os.path.join(self.root, "tree")) if "~" in n]
        self.assertEqual(len(names), 1)
        self.assertLessEqual(len(names[0].encode("utf-8")), 255)
        self.call("search_files", query="title = 'x'")  # the server still saves after it

    def test_titles_differing_only_in_case_stay_apart(self):
        a = self.call("create_file", title="Notes.md", contentMimeType="text/markdown", textContent="A",
                      disableConversionToGoogleType=True)
        b = self.call("create_file", title="notes.md", contentMimeType="text/markdown", textContent="b",
                      disableConversionToGoogleType=True)
        names = sorted(os.listdir(os.path.join(self.root, "tree")))
        self.assertIn("Notes.md", names)
        self.assertIn("notes.md.dup-" + b["id"], names)
        self.assertNotEqual(a["id"], b["id"])

    def test_shared_drive_files_name_their_last_modifier(self):
        fixtures.main(["fixtures.py", "shared-drive", self.ws])
        self.assertNotIn("creator", self.find("title = 'index.json'")[0])
        idx = self.call("get_file_metadata", fileId=self.find("title = 'vibebiz'")[0]["id"], includeRichMetadata=True)
        self.assertEqual(idx["lastModifyingUserEmail"], "sales-manager@example.com")
        with self.assertRaises(server.DriveError):
            self.find("title = 'index.json' and creator = 'me'")


class MirrorEdges(Base):
    def test_long_google_title_keeps_gdoc_and_dup_suffixes(self):
        title = "a" * 250
        one = self.call("create_file", title=title, contentMimeType="text/plain", textContent="1")
        two = self.call("create_file", title=title, contentMimeType="text/plain", textContent="2")
        names = sorted(os.listdir(os.path.join(self.root, "tree")))
        base = [n for n in names if n.startswith("a" * 200 + "~") and n.endswith(".gdoc")]
        self.assertEqual(len(base), 1, names)
        self.assertIn(base[0] + ".dup-" + two["id"], names)
        self.assertNotEqual(one["id"], two["id"])

    def test_older_folder_keeps_plain_name_after_a_move(self):
        child = self.call("create_file", title="child", contentMimeType=server.FOLDER)
        older = self.call("create_file", title="vibebiz", contentMimeType=server.FOLDER)
        newer = self.call("create_file", title="vibebiz", contentMimeType=server.FOLDER)
        self.call("update_file", fileId=child["id"], parentId=newer["id"])
        tree = os.path.join(self.root, "tree")
        self.assertTrue(os.path.isdir(os.path.join(tree, "vibebiz.dup-" + newer["id"], "child")))
        self.assertFalse(os.path.exists(os.path.join(tree, "vibebiz", "child")))
        self.assertTrue(os.path.isdir(os.path.join(tree, "vibebiz")))
        self.assertNotEqual(older["id"], newer["id"])


class SecurityFollowUps(Base):
    """LOW findings from the PR finolabs/vibebiz#6 security review."""

    def test_symlinked_tree_is_refused(self):
        outside = tempfile.mkdtemp()
        try:
            self.call("search_files", query="title = 'x'")
            tree = os.path.join(self.root, "tree")
            shutil.rmtree(tree)
            os.symlink(outside, tree)
            with self.assertRaises(server.DriveError):
                self.call("create_file", title="x.md", contentMimeType="text/markdown", textContent="x",
                          disableConversionToGoogleType=True)
            self.assertEqual(os.listdir(outside), [])
        finally:
            shutil.rmtree(outside)

    def test_symlinked_log_is_refused(self):
        outside = tempfile.NamedTemporaryFile(delete=False)
        outside.close()
        try:
            os.symlink(outside.name, os.path.join(self.root, "calls.jsonl"))
            with self.assertRaises(server.DriveError):
                self.call("search_files", query="title = 'x'")
            with open(outside.name, encoding="utf-8") as fh:
                self.assertEqual(fh.read(), "")
        finally:
            os.unlink(outside.name)

    def test_hard_linked_state_is_refused_and_outside_file_unchanged(self):
        for name in ("drive.json", "calls.jsonl"):
            with self.subTest(name):
                self.call("search_files", query="title = 'x'")
                outside = tempfile.NamedTemporaryFile("w", suffix=".txt", delete=False, encoding="utf-8")
                outside.write("OUTSIDE")
                outside.close()
                try:
                    state = os.path.join(self.root, name)
                    os.unlink(state)
                    os.link(outside.name, state)
                    with self.assertRaises(server.DriveError):
                        self.call("search_files", query="title = 'x'")
                    with open(outside.name, encoding="utf-8") as fh:
                        self.assertEqual(fh.read(), "OUTSIDE")
                    os.unlink(state)
                finally:
                    os.unlink(outside.name)

    def test_symlinked_state_file_is_refused_and_never_copied(self):
        outside = tempfile.NamedTemporaryFile("w", suffix=".json", delete=False, encoding="utf-8")
        outside.write('{"secret_token": "FAKE-VALUE"}')
        outside.close()
        try:
            state = os.path.join(self.root, "drive.json")
            os.unlink(state)
            os.symlink(outside.name, state)
            with self.assertRaises(server.DriveError):
                self.call("search_files", query="title = 'x'")
            for dirpath, _, names in os.walk(self.ws):
                for n in names:
                    full = os.path.join(dirpath, n)
                    if not os.path.islink(full):
                        with open(full, encoding="utf-8", errors="ignore") as fh:
                            self.assertNotIn("FAKE-VALUE", fh.read(), full)
        finally:
            os.unlink(outside.name)

    def test_symlinked_root_is_refused(self):
        outside = tempfile.mkdtemp()
        try:
            os.makedirs(os.path.join(outside, "tree"))
            open(os.path.join(outside, "tree", "keepme"), "w").close()
            shutil.rmtree(self.root)
            os.symlink(outside, self.root)
            with self.assertRaises(server.DriveError):
                self.call("search_files", query="title = 'x'")
            self.assertTrue(os.path.exists(os.path.join(outside, "tree", "keepme")))
        finally:
            shutil.rmtree(outside)

    def test_refused_copy_changes_nothing(self):
        f = self.call("create_file", title="a.md", contentMimeType="text/markdown", textContent="1",
                      disableConversionToGoogleType=True)
        before = json.load(open(os.path.join(self.root, "drive.json"), encoding="utf-8"))["clock"]
        with self.assertRaises(server.DriveError):
            self.call("copy_file", fileId=f["id"], title=123)
        after = json.load(open(os.path.join(self.root, "drive.json"), encoding="utf-8"))["clock"]
        self.assertEqual(before, after)

    def test_non_text_title_is_refused_and_server_keeps_working(self):
        f = self.call("create_file", title="a.md", contentMimeType="text/markdown", textContent="1",
                      disableConversionToGoogleType=True)
        for bad in (123, None, ["x"]):
            with self.assertRaises(server.DriveError):
                self.call("update_file", fileId=f["id"], title=bad)
            with self.assertRaises(server.DriveError):
                self.call("create_file", title=bad, contentMimeType="text/markdown", textContent="1")
        self.call("search_files", query="title = 'a.md'")

    def test_nfc_and_nfd_titles_stay_apart(self):
        import unicodedata
        nfc = unicodedata.normalize("NFC", "Ý tưởng.md")
        nfd = unicodedata.normalize("NFD", "Ý tưởng.md")
        self.call("create_file", title=nfc, contentMimeType="text/markdown", textContent="1",
                  disableConversionToGoogleType=True)
        b = self.call("create_file", title=nfd, contentMimeType="text/markdown", textContent="2",
                      disableConversionToGoogleType=True)
        names = os.listdir(os.path.join(self.root, "tree"))
        self.assertTrue(any(n.endswith(".dup-" + b["id"]) for n in names), names)


if __name__ == "__main__":
    unittest.main()
