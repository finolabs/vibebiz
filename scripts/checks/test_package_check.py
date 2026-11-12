"""Tests for the package check (T061, SC-007): valid fixtures pass, and every
seeded fault is caught with its specific problem."""

import contextlib
import io
import json
import sys
import unittest
from pathlib import Path

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE))

import package_check  # noqa: E402

FIX = HERE / "fixtures" / "package"

# fixture -> substrings that must each appear in some problem.
EXPECTED = {
    "invalid_missing_slide": ["missing-slide: slide 6"],
    "invalid_missing_section": ["missing-section: section ai-fit"],
    "invalid_no_traceability": ["untraceable: slide 6 has no source_fields"],
    "invalid_unknown_figure": ["unknown-figure: slide 3", "N-nope"],
    "invalid_figure_unsourced": ["figure-incomplete: N-return-rate has no source"],
    "invalid_figure_no_period": ["figure-incomplete: N-return-rate has no period"],
    "invalid_figure_no_label": ["figure-incomplete: N-return-rate label"],
    "invalid_figure_mismatch": ["figure-mismatch: slide 3 shows N-return-rate as 0.2"],
    "invalid_figure_duplicate": ["figure-mismatch: N-return-rate is defined twice"],
    "invalid_unsourced_chart": ["unsourced-chart: slide 2 block 1"],
    "invalid_estimate_unlabelled": ["missing-estimate-label: slide 7", "N-payback"],
    "invalid_estimate_unlabelled_section": ["missing-estimate-label: section success-criteria"],
    "invalid_stale_label": ["stale-estimate-label"],
    "invalid_empty_title": ["empty-title: slide 5"],
    "invalid_two_messages": ["many-messages: slide 5"],
    "invalid_no_message": ["no-message: slide 5"],
    "invalid_unnamed_framework": ["unnamed-framework: slide 3"],
    "invalid_unnamed_framework_block": ["unnamed-framework: slide 4 block 1"],
    "invalid_public_flag": ["public-sharing: links.public"],
    "invalid_public_visibility": ["public-sharing", "visibility"],
    "invalid_bad_status": ["bad-estimate-status"],
    "invalid_missing_key": ["bad-structure: missing top-level key numbers"],
    "invalid_links_mismatch": ["links-mismatch: https://example.com/artifact/size-advice",
                               "links-mismatch: https://example.com/other"],
    "invalid_unknown_spec_id": ["untraceable: slide 2 cites FR-099"],
    "invalid_links_missing": ["links-mismatch: exports/links.md is missing"],
}


def _fixture(name):
    folder = FIX / name
    return folder if folder.is_dir() else FIX / f"{name}.json"


class ValidFixtures(unittest.TestCase):
    def test_valid_folder_has_no_problems(self):
        self.assertEqual(package_check.check_path(FIX / "valid"), [])

    def test_gap_listed_omission_is_valid(self):
        self.assertEqual(package_check.check_path(FIX / "valid_gap_listed.json"), [])

    def test_tech_reviewed_without_labels_is_valid(self):
        self.assertEqual(package_check.check_path(FIX / "valid_tech_reviewed.json"), [])

    def test_gap_slide_needs_no_content(self):
        # Without the gaps entry the same data is invalid (guards the valid case above).
        data = json.loads((FIX / "valid_gap_listed.json").read_text())
        data["gaps"] = []
        self.assertTrue(any(p.startswith("missing-slide: slide 6") for p in package_check.check_data(data)))


class InvalidFixtures(unittest.TestCase):
    def test_every_invalid_fixture_has_an_expectation(self):
        on_disk = {p.stem if p.suffix == ".json" else p.name
                   for p in FIX.iterdir() if p.name.startswith("invalid_")}
        self.assertEqual(on_disk, set(EXPECTED))

    def test_each_seeded_fault_is_caught(self):
        for name, needles in EXPECTED.items():
            with self.subTest(fixture=name):
                problems = package_check.check_path(_fixture(name))
                self.assertTrue(problems, f"{name}: nothing caught")
                for needle in needles:
                    self.assertTrue(any(needle in p for p in problems),
                                    f"{name}: no problem containing {needle!r}; got {problems}")

    def test_single_fault_fixtures_report_only_their_fault(self):
        # A fixture seeds one fault, so unrelated rules must stay quiet.
        problems = package_check.check_path(_fixture("invalid_unsourced_chart"))
        self.assertEqual([p.split(":")[0] for p in problems], ["unsourced-chart"])
        problems = package_check.check_path(_fixture("invalid_estimate_unlabelled"))
        self.assertEqual([p.split(":")[0] for p in problems], ["missing-estimate-label"])


class Cli(unittest.TestCase):
    def _run(self, arg):
        out = io.StringIO()
        with contextlib.redirect_stdout(out):
            code = package_check.main([str(arg)])
        return code, out.getvalue()

    def test_exit_zero_on_valid_folder_and_file(self):
        self.assertEqual(self._run(FIX / "valid")[0], 0)
        self.assertEqual(self._run(FIX / "valid" / "exports" / "data.json")[0], 0)

    def test_exit_one_and_prints_problems(self):
        code, out = self._run(_fixture("invalid_unsourced_chart"))
        self.assertEqual(code, 1)
        self.assertIn("unsourced-chart", out)

    def test_exit_two_when_unreadable(self):
        self.assertEqual(self._run(FIX / "does-not-exist")[0], 2)


if __name__ == "__main__":
    unittest.main()
