"""Tests for frontmatter.py, the YAML-subset parser (T011)."""

import sys
import unittest
from pathlib import Path

HERE = Path(__file__).resolve().parent
sys.path.insert(0, str(HERE))

import frontmatter  # noqa: E402
from frontmatter import FrontmatterError, check, load, parse_yaml  # noqa: E402

FIXTURES = HERE / "fixtures" / "frontmatter"


class ValidShapes(unittest.TestCase):
    def test_constitution_shapes(self):
        data, body = load(FIXTURES / "valid_constitution.md")
        self.assertEqual(data["status"], "set")
        self.assertEqual(
            data["priorities"],
            ["Raise repeat purchases in the store chain", "Cut stock-outs of core sizes"],
        )
        self.assertEqual(data["approval_ceiling"], {"amount": 50000000, "currency": "VND"})
        self.assertEqual(data["mandatory_approvals"], ["Price changes", "Customer messaging"])
        self.assertEqual(data["strategy_map"]["internal"], [])
        self.assertEqual(data["okrs"][0]["objective"], "Customers come back within the season")
        self.assertEqual(len(data["okrs"][0]["key_results"]), 2)
        self.assertEqual(data["okrs"][1]["key_results"], ["Stock-outs below 3%"])
        self.assertEqual(data["updated"], "2026-11-12")
        self.assertIn("# Ground rules", body)

    def test_coverage_categories_a_to_o(self):
        data, _ = load(FIXTURES / "valid_coverage.md")
        self.assertEqual(data["id"], "001")
        self.assertEqual(data["title"], "Nhắc khách cũ quay lại: thử nghiệm")
        self.assertIsNone(data["latest_export"])
        self.assertEqual(data["budget_rounds_used"], 2)
        self.assertEqual(list(data["categories"]), list("ABCDEFGHIJKLMNO"))
        self.assertEqual(data["categories"]["A"]["frameworks"], ["jobs-to-be-done"])
        self.assertEqual(data["categories"]["D"]["prerequisites"], ["A", "C"])
        self.assertEqual(data["categories"]["K"]["status"], "deferred")
        self.assertEqual(
            data["categories"]["K"]["reason"],
            "Legal review booked for next month, it's outside this round",
        )

    def test_valid_fixtures_have_no_problems(self):
        for path in sorted(FIXTURES.glob("valid_*.md")):
            with self.subTest(path.name):
                self.assertEqual(check(path), [])

    def test_scalars(self):
        data = parse_yaml(
            'a: true\nb: false\nc: ~\nd: 3.5\ne: -2\nf: "x # not a comment"\n'
            "g: plain # comment\nh: https://example.test/a\ni: '00 1'\nj: \"tab\\tquote\\\"\"\n"
        )
        self.assertEqual(
            data,
            {
                "a": True, "b": False, "c": None, "d": 3.5, "e": -2,
                "f": "x # not a comment", "g": "plain",
                "h": "https://example.test/a", "i": "00 1", "j": 'tab\tquote"',
            },
        )

    def test_nested_flow_and_block_list_at_key_indent(self):
        data = parse_yaml("a: {b: [1, 2], c: {d: x}}\nlist:\n- one\n- two\nafter: 1\n")
        self.assertEqual(data, {"a": {"b": [1, 2], "c": {"d": "x"}}, "list": ["one", "two"], "after": 1})

    def test_apostrophe_inside_plain_scalar(self):
        data = parse_yaml("title: Women's wear\nnote: don't # comment\ntags: [x, y's]\nq: 'it''s'\n")
        self.assertEqual(data["title"], "Women's wear")
        self.assertEqual(data["note"], "don't")
        self.assertEqual(data["tags"], ["x", "y's"])
        self.assertEqual(data["q"], "it's")

    def test_empty_frontmatter(self):
        self.assertEqual(frontmatter.parse_frontmatter("---\n---\nbody\n"), ({}, "body\n"))


class MalformedInput(unittest.TestCase):
    EXPECTED = {
        "invalid_unclosed.md": "no closing '---'",
        "invalid_no_start.md": "does not start with a '---'",
        "invalid_duplicate_key.md": "line 3: duplicate key 'status'",
        "invalid_tab_indent.md": "line 3: tab used for indentation",
        "invalid_unterminated_quote.md": "line 2: unterminated \" quote",
        "invalid_list_item.md": "line 4: expected a list item",
        "invalid_flow.md": "line 2: missing ]",
        "invalid_indentation.md": "line 3: key 'status' has both an inline value and a nested block",
        "invalid_no_key.md": "line 2: expected 'key: value'",
    }

    def test_every_invalid_fixture_is_covered(self):
        self.assertEqual(sorted(p.name for p in FIXTURES.glob("invalid_*.md")), sorted(self.EXPECTED))

    def test_invalid_fixtures_raise_clear_errors(self):
        for name, fragment in self.EXPECTED.items():
            with self.subTest(name):
                with self.assertRaises(FrontmatterError) as ctx:
                    load(FIXTURES / name)
                self.assertIn(fragment, str(ctx.exception))
                self.assertIn(name, str(ctx.exception))
                problems = check(FIXTURES / name)
                self.assertEqual(len(problems), 1)
                self.assertIn(fragment, problems[0])

    def test_unsupported_syntax(self):
        for text in ("a: &anchor x\n", "a: |\n  text\n", "a: [1, 2] extra\n", "- top level list\n"):
            with self.subTest(text):
                with self.assertRaises(FrontmatterError):
                    parse_yaml(text)

    def test_inline_value_with_nested_block(self):
        with self.assertRaises(FrontmatterError) as ctx:
            parse_yaml("a: x\n  b: y\n")
        self.assertIn("both an inline value and a nested block", str(ctx.exception))


if __name__ == "__main__":
    unittest.main()
