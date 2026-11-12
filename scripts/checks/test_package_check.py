"""Tests for the package check (T061, SC-007): valid fixtures pass, and every
seeded fault is caught with its specific problem."""

import contextlib
import io
import json
import re
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
    "invalid_chart_no_period": ["chart-no-period: slide 2 block 1"],
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


class TemplateForms(unittest.TestCase):
    def _data(self):
        return json.loads((FIX / "valid" / "exports" / "data.json").read_text())

    def test_assumed_label_alone_is_not_an_estimate(self):
        data = self._data()
        for fig in data["numbers"]:
            fig.pop("estimate", None)
        for slide in data["board"]["slides"]:
            slide.pop("estimate_label", None)
        for sec in data["tech"]["sections"]:
            sec.pop("estimate_label", None)
        self.assertEqual(package_check.check_data(data), [])

    def test_field_gap_does_not_switch_off_checks_on_present_slide(self):
        data = self._data()
        data["gaps"] = [{"field": "scope", "slide": 5}]
        data["board"]["slides"][4]["title"] = ""
        self.assertTrue(any(p.startswith("empty-title: slide 5") for p in package_check.check_data(data)))

    def test_section_content_blocks_are_checked(self):
        data = self._data()
        sec = data["tech"]["sections"][1]
        sec["content"] = [{"type": "chart", "source": "", "period": "", "items": []}]
        codes = [p.split(":")[0] for p in package_check.check_data(data)]
        self.assertIn("unsourced-chart", codes)
        self.assertIn("chart-no-period", codes)

    def test_framework_object_needs_a_name(self):
        data = self._data()
        data["board"]["slides"][2]["frameworks"] = [{"id": "x", "name": ""}]
        self.assertTrue(any(p.startswith("unnamed-framework: slide 3") for p in package_check.check_data(data)))


TEMPLATES = HERE.parent.parent / "templates" / "exports"
_DATA_BLOCK = re.compile(r'<script type="application/json" id="vibebiz-data">\n(.*?)\n</script>', re.S)


def _template_data(name):
    return json.loads(_DATA_BLOCK.search((TEMPLATES / name).read_text(encoding="utf-8")).group(1))


def _block(data, slide, btype):
    """The first block of `btype` on board slide `slide`."""
    s = next(s for s in data["board"]["slides"] if str(s["n"]) == str(slide))
    return next(b for b in s["blocks"] if b["type"] == btype)


class TemplateSamples(unittest.TestCase):
    """The fictional sample inside each export template passes the check."""

    def test_board_deck_sample_is_valid(self):
        self.assertEqual(package_check.check_data(_template_data("board-deck.html")), [])

    def test_tech_prd_sample_is_valid(self):
        self.assertEqual(package_check.check_data(_template_data("tech-prd.html")), [])

    def test_sample_uses_every_infographic_block(self):
        data = _template_data("board-deck.html")
        blocks = [b for s in data["board"]["slides"] for b in s["blocks"]]
        kinds = {(b["type"], b.get("form")) for b in blocks}
        for kind in [("ratio", None), ("tree", None), ("journey", None), ("callout", None),
                     ("controls", None), ("deadline", None), ("timeline", "gantt"), ("timeline", "steps"),
                     ("meter", "gauge"), ("meter", "donut"), ("compare", "bars"), ("compare", "cards")]:
            self.assertIn(kind, kinds)
        self.assertTrue(any(b["type"] == "chart" and "target" in b for b in blocks))


class InfographicBlocks(unittest.TestCase):
    """Each new block type: required fields, figure refs and estimate labels."""

    def setUp(self):
        self.data = _template_data("board-deck.html")

    def problems(self):
        return package_check.check_data(self.data)

    def assertCaught(self, needle):
        problems = self.problems()
        self.assertTrue(any(needle in p for p in problems), f"no problem containing {needle!r}; got {problems}")

    def test_ratio_needs_ref_and_a_sane_total(self):
        _block(self.data, 2, "ratio")["total"] = 12
        self.assertCaught("bad-block: slide 2 block 1 ratio total")
        del _block(self.data, 2, "ratio")["ref"]
        self.assertCaught("bad-block: slide 2 block 1 ratio needs ref")

    def test_tree_needs_root_and_labelled_children(self):
        tree = _block(self.data, 3, "tree")
        tree["root"] = ""
        tree["children"][1]["label"] = ""
        self.assertCaught("tree needs root")
        self.assertCaught("tree needs children")

    def test_tree_child_range_must_name_known_figures(self):
        _block(self.data, 3, "tree")["children"][0]["to_ref"] = "N-nope"
        self.assertCaught("unknown-figure: slide 3 block 2 references N-nope")

    def test_journey_needs_one_cell_per_step(self):
        _block(self.data, 5, "journey")["lanes"][0]["cells"].pop()
        self.assertCaught("bad-block: slide 5 block 1 journey needs one cell per step")

    def test_gantt_bars_need_ordered_positions(self):
        gantt = _block(self.data, 9, "timeline")
        gantt["lanes"][0]["bars"][0].update({"from": 6, "to": 2})
        gantt["items"][0]["at"] = 0
        self.assertCaught("gantt timeline needs bars with from <= to")
        self.assertCaught("gantt decision point needs at")

    def test_gantt_needs_lanes(self):
        _block(self.data, 9, "timeline")["lanes"] = []
        self.assertCaught("gantt timeline needs lanes")

    def test_gantt_span_and_lane_refs_must_exist(self):
        gantt = _block(self.data, 9, "timeline")
        gantt["span_ref"] = "N-span"
        gantt["lanes"][1]["ref"] = "N-lane"
        self.assertCaught("unknown-figure: slide 9 block 1 references N-lane")
        self.assertCaught("unknown-figure: slide 9 block 1 references N-span")

    def test_gauge_needs_a_known_threshold(self):
        gauge = _block(self.data, 8, "meter")
        gauge["threshold_ref"] = "N-nope"
        self.assertCaught("unknown-figure: slide 8 block 1 references N-nope")
        del gauge["threshold_ref"]
        self.assertCaught("bad-block: slide 8 block 1 gauge meter needs threshold_ref")

    def test_donut_needs_ref(self):
        del _block(self.data, "appendix", "meter")["ref"]
        self.assertCaught("bad-block: slide appendix block 3 donut meter needs ref")

    def test_controls_callout_and_deadline_fields(self):
        _block(self.data, 8, "controls")["items"][1]["text"] = ""
        _block(self.data, 3, "callout")["text"] = " "
        _block(self.data, 1, "deadline").update({"date": "2026-02-30", "label": ""})
        self.assertCaught("controls needs items, each with text")
        self.assertCaught("callout needs text")
        self.assertCaught("deadline needs date as YYYY-MM-DD")
        self.assertCaught("deadline needs a label")

    def test_chart_target_needs_a_known_ref(self):
        chart = _block(self.data, 7, "chart")
        chart["target"] = {"label": "Chi phí"}
        self.assertCaught("bad-block: slide 7 block 1 chart target needs ref")
        chart["target"] = {"ref": "N-nope"}
        self.assertCaught("unknown-figure: slide 7 block 1 references N-nope")

    def test_target_figure_needs_source_period_and_label(self):
        fig = next(f for f in self.data["numbers"] if f["id"] == "N-03")
        fig["period"] = ""
        self.assertCaught("figure-incomplete: N-03 has no period")

    def test_compare_side_and_card_refs_must_exist(self):
        _block(self.data, 3, "compare")["sides"][0]["ref"] = "N-side"
        _block(self.data, 6, "compare")["sides"][0]["items"][0]["ref"] = "N-card"
        self.assertCaught("unknown-figure: slide 3 block 1 references N-side")
        self.assertCaught("unknown-figure: slide 6 block 1 references N-card")

    def test_estimate_in_option_measure_needs_the_label(self):
        slide = next(s for s in self.data["board"]["slides"] if s["n"] == 4)
        slide.pop("estimate_label")
        _block(self.data, 4, "options").pop("estimate_label")
        self.assertCaught("missing-estimate-label: slide 4 block 1 shows estimate N-19, N-20, N-21")

    def test_estimate_as_chart_target_needs_the_label(self):
        slide = next(s for s in self.data["board"]["slides"] if s["n"] == 7)
        slide.pop("estimate_label")
        chart = _block(self.data, 7, "chart")
        chart.pop("estimate_label")
        chart["items"] = [{"ref": "N-11"}]
        self.assertCaught("missing-estimate-label: slide 7 block 1 shows estimate N-03")

    def test_repeated_value_on_a_ref_must_match(self):
        _block(self.data, 3, "compare")["sides"][1]["value"] = 30
        self.assertCaught("figure-mismatch: slide 3 shows N-02 as 30")

    def test_figure_id_lists_are_checked(self):
        slide = next(s for s in self.data["board"]["slides"] if s["n"] == 6)
        slide["blocks"].append({"type": "figures", "figure_ids": ["N-24", "N-gone"]})
        self.assertCaught("unknown-figure: slide 6 block 2 references N-gone")

    def test_old_data_without_new_blocks_stays_valid(self):
        # Unknown optional fields are not required: plain blocks keep passing.
        for slide in self.data["board"]["slides"]:
            for b in slide["blocks"]:
                b.pop("form", None)
                b.pop("target", None)
        self.assertNotIn("bad-block", " ".join(self.problems()))


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
        problems = package_check.check_path(_fixture("invalid_chart_no_period"))
        self.assertEqual([p.split(":")[0] for p in problems], ["chart-no-period"])
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
