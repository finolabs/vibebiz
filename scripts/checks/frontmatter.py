"""Parse the YAML subset used in vibebiz frontmatter (development tooling only).

Supported shapes (specs/001-idea-to-prd/data-model.md):

- block maps (``key: value``) nested by indentation (spaces only);
- block lists (``- item``), including lists of maps (``- objective: ...``);
- flow lists and maps (``[a, b]``, ``{amount: 100, currency: VND}``), nestable;
- plain, single-quoted and double-quoted scalars;
- ``null``/``~``/empty -> None, ``true``/``false`` -> bool, integers and
  decimals -> int/float; everything else, dates included, stays a string;
- full-line comments and `` #`` comments after a value.

Anchors, aliases, tags, multi-document streams and block scalars (``|``, ``>``)
are outside the subset and raise ``FrontmatterError``.
"""

from __future__ import annotations

import re
from pathlib import Path

__all__ = ["FrontmatterError", "parse_yaml", "split_frontmatter", "parse_frontmatter", "load", "check"]

_KEY_RE = re.compile(r"^([A-Za-z0-9_][A-Za-z0-9_\-]*)\s*:(?:\s+(.*))?$")
_INT_RE = re.compile(r"^[-+]?\d+$")
_FLOAT_RE = re.compile(r"^[-+]?\d+\.\d+$")


class FrontmatterError(ValueError):
    """Malformed frontmatter; the message names the line when known."""

    def __init__(self, message: str, line: int | None = None):
        self.line = line
        super().__init__(f"line {line}: {message}" if line is not None else message)


def _strip_comment(text: str, line_no: int) -> str:
    """Remove a trailing `` #`` comment that is outside quotes."""
    quote = None
    i = 0
    while i < len(text):
        ch = text[i]
        if quote:
            if quote == '"' and ch == "\\":
                i += 2
                continue
            if ch == quote:
                if quote == "'" and i + 1 < len(text) and text[i + 1] == "'":
                    i += 2
                    continue
                quote = None
        elif ch in "'\"":
            quote = ch
        elif ch == "#" and (i == 0 or text[i - 1] in " \t"):
            return text[:i].rstrip()
        i += 1
    if quote:
        raise FrontmatterError(f"unterminated {quote} quote", line_no)
    return text.rstrip()


def _scalar(text: str, line_no: int):
    text = text.strip()
    if text == "" or text in ("null", "~", "Null", "NULL"):
        return None
    if text[0] == '"':
        if len(text) < 2 or text[-1] != '"':
            raise FrontmatterError("unterminated double-quoted string", line_no)
        body = text[1:-1]
        out, i = [], 0
        escapes = {"n": "\n", "t": "\t", '"': '"', "\\": "\\", "/": "/"}
        while i < len(body):
            ch = body[i]
            if ch == "\\":
                if i + 1 >= len(body) or body[i + 1] not in escapes:
                    raise FrontmatterError(f"unsupported escape in {text}", line_no)
                out.append(escapes[body[i + 1]])
                i += 2
                continue
            if ch == '"':
                raise FrontmatterError(f"unescaped quote inside {text}", line_no)
            out.append(ch)
            i += 1
        return "".join(out)
    if text[0] == "'":
        if len(text) < 2 or text[-1] != "'":
            raise FrontmatterError("unterminated single-quoted string", line_no)
        body = text[1:-1]
        if re.search(r"(?<!')'(?!')", body.replace("''", "")):
            raise FrontmatterError(f"unescaped quote inside {text}", line_no)
        return body.replace("''", "'")
    if text[0] in "&*!|>%@`":
        raise FrontmatterError(f"unsupported YAML syntax: {text}", line_no)
    if text in ("true", "True", "TRUE"):
        return True
    if text in ("false", "False", "FALSE"):
        return False
    if _INT_RE.match(text):
        return int(text)
    if _FLOAT_RE.match(text):
        return float(text)
    return text


class _Flow:
    """Recursive-descent parser for flow collections on one line."""

    def __init__(self, text: str, line_no: int):
        self.text, self.pos, self.line = text, 0, line_no

    def error(self, message: str):
        raise FrontmatterError(f"{message} in flow value {self.text}", self.line)

    def ws(self):
        while self.pos < len(self.text) and self.text[self.pos] == " ":
            self.pos += 1

    def parse(self):
        value = self.value()
        self.ws()
        if self.pos != len(self.text):
            self.error("unexpected text after closing bracket")
        return value

    def value(self):
        self.ws()
        if self.pos >= len(self.text):
            self.error("missing value")
        ch = self.text[self.pos]
        if ch == "[":
            return self.seq()
        if ch == "{":
            return self.mapping()
        return self.atom()

    def atom(self):
        start = self.pos
        if self.text[self.pos] in "'\"":
            quote = self.text[self.pos]
            self.pos += 1
            while self.pos < len(self.text):
                ch = self.text[self.pos]
                if quote == '"' and ch == "\\":
                    self.pos += 2
                    continue
                if ch == quote:
                    if quote == "'" and self.text[self.pos + 1 : self.pos + 2] == "'":
                        self.pos += 2
                        continue
                    break
                self.pos += 1
            if self.pos >= len(self.text):
                self.error("unterminated quote")
            self.pos += 1
        else:
            while self.pos < len(self.text) and self.text[self.pos] not in ",]}:":
                self.pos += 1
            # A colon inside a plain scalar (e.g. a time) is kept unless followed by a space.
            while (
                self.pos < len(self.text)
                and self.text[self.pos] == ":"
                and self.text[self.pos + 1 : self.pos + 2] not in (" ", "")
            ):
                self.pos += 1
                while self.pos < len(self.text) and self.text[self.pos] not in ",]}:":
                    self.pos += 1
        return _scalar(self.text[start : self.pos], self.line)

    def seq(self):
        self.pos += 1
        items = []
        self.ws()
        if self.text[self.pos : self.pos + 1] == "]":
            self.pos += 1
            return items
        while True:
            items.append(self.value())
            self.ws()
            if self.pos >= len(self.text):
                self.error("missing ]")
            ch = self.text[self.pos]
            self.pos += 1
            if ch == "]":
                return items
            if ch != ",":
                self.error(f"expected , or ] but found {ch!r}")

    def mapping(self):
        self.pos += 1
        result: dict = {}
        self.ws()
        if self.text[self.pos : self.pos + 1] == "}":
            self.pos += 1
            return result
        while True:
            self.ws()
            key = self.atom()
            if not isinstance(key, (str, int)) or key == "":
                self.error("missing key")
            key = str(key)
            self.ws()
            if self.text[self.pos : self.pos + 1] != ":":
                self.error(f"expected : after key {key!r}")
            self.pos += 1
            if key in result:
                self.error(f"duplicate key {key!r}")
            result[key] = self.value()
            self.ws()
            if self.pos >= len(self.text):
                self.error("missing }")
            ch = self.text[self.pos]
            self.pos += 1
            if ch == "}":
                return result
            if ch != ",":
                self.error(f"expected , or }} but found {ch!r}")


def _value(text: str, line_no: int):
    if text.startswith("[") or text.startswith("{"):
        return _Flow(text, line_no).parse()
    return _scalar(text, line_no)


def _tokenize(text: str, first_line: int):
    """Yield (line_no, indent, content) for meaningful lines."""
    lines = []
    for offset, raw in enumerate(text.split("\n")):
        line_no = first_line + offset
        if raw.strip() == "" or raw.lstrip().startswith("#"):
            continue
        stripped = raw.lstrip(" ")
        if stripped.startswith("\t") or "\t" in raw[: len(raw) - len(raw.lstrip())]:
            raise FrontmatterError("tab used for indentation", line_no)
        content = _strip_comment(stripped, line_no)
        lines.append((line_no, len(raw) - len(stripped), content))
    return lines


class _Block:
    def __init__(self, lines):
        self.lines, self.i = lines, 0

    def peek(self):
        return self.lines[self.i] if self.i < len(self.lines) else None

    def parse(self, indent: int):
        line_no, ind, content = self.peek()
        if ind != indent:
            raise FrontmatterError("unexpected indentation", line_no)
        if content == "-" or content.startswith("- "):
            return self.seq(indent)
        return self.mapping(indent)

    def child(self, parent_indent: int, line_no: int):
        """Parse the nested block after ``key:`` or ``-`` with no inline value."""
        nxt = self.peek()
        if nxt is None or nxt[1] <= parent_indent:
            return None
        return self.parse(nxt[1])

    def mapping(self, indent: int):
        result: dict = {}
        while True:
            cur = self.peek()
            if cur is None or cur[1] < indent:
                return result
            line_no, ind, content = cur
            if ind > indent:
                raise FrontmatterError("unexpected indentation", line_no)
            if content == "-" or content.startswith("- "):
                raise FrontmatterError("list item where a key was expected", line_no)
            match = _KEY_RE.match(content)
            if not match:
                raise FrontmatterError(f"expected 'key: value' but found {content!r}", line_no)
            key, rest = match.group(1), (match.group(2) or "").strip()
            if key in result:
                raise FrontmatterError(f"duplicate key {key!r}", line_no)
            self.i += 1
            if rest:
                result[key] = _value(rest, line_no)
                nxt = self.peek()
                if nxt is not None and nxt[1] > indent:
                    raise FrontmatterError(f"key {key!r} has both an inline value and a nested block", nxt[0])
            else:
                nxt = self.peek()
                # A block list may sit at the same indent as its key.
                if nxt is not None and nxt[1] == indent and (nxt[2] == "-" or nxt[2].startswith("- ")):
                    result[key] = self.seq(indent)
                else:
                    result[key] = self.child(indent, line_no)

    def seq(self, indent: int):
        items = []
        while True:
            cur = self.peek()
            if cur is None or cur[1] < indent:
                return items
            line_no, ind, content = cur
            if ind > indent:
                raise FrontmatterError("unexpected indentation", line_no)
            if not (content == "-" or content.startswith("- ")):
                # End of a same-indent list under a key; let the caller continue.
                if _KEY_RE.match(content):
                    return items
                raise FrontmatterError(f"expected a list item but found {content!r}", line_no)
            rest = content[1:].strip()
            self.i += 1
            if not rest:
                items.append(self.child(indent, line_no))
                continue
            if _KEY_RE.match(rest) and not rest.startswith(("'", '"', "[", "{")):
                # "- key: value" opens a map whose keys align with "key".
                item_indent = indent + (len(content) - len(content[1:].lstrip(" ")))
                self.i -= 1
                self.lines[self.i] = (line_no, item_indent, rest)
                items.append(self.mapping(item_indent))
                continue
            items.append(_value(rest, line_no))
            nxt = self.peek()
            if nxt is not None and nxt[1] > indent:
                raise FrontmatterError("list item has both an inline value and a nested block", nxt[0])


def parse_yaml(text: str, first_line: int = 1) -> dict:
    """Parse a YAML-subset document whose top level is a map."""
    lines = _tokenize(text, first_line)
    if not lines:
        return {}
    block = _Block(lines)
    if lines[0][1] != 0:
        raise FrontmatterError("top-level keys must not be indented", lines[0][0])
    result = block.parse(0)
    if not isinstance(result, dict):
        raise FrontmatterError("frontmatter must be a map of keys", lines[0][0])
    if block.peek() is not None:
        raise FrontmatterError("unexpected indentation", block.peek()[0])
    return result


def split_frontmatter(text: str) -> tuple[str, str, int]:
    """Return (frontmatter text, body, line number of the first frontmatter line)."""
    if text.startswith("﻿"):
        text = text[1:]
    lines = text.split("\n")
    if not lines or lines[0].rstrip() != "---":
        raise FrontmatterError("file does not start with a '---' frontmatter line", 1)
    for idx in range(1, len(lines)):
        if lines[idx].rstrip() == "---":
            return "\n".join(lines[1:idx]), "\n".join(lines[idx + 1 :]), 2
    raise FrontmatterError("frontmatter has no closing '---' line")


def parse_frontmatter(text: str) -> tuple[dict, str]:
    """Return (data, body) for a Markdown file with YAML-subset frontmatter."""
    fm, body, first = split_frontmatter(text)
    return parse_yaml(fm, first), body


def load(path) -> tuple[dict, str]:
    """Read ``path`` and return (data, body); errors name the file."""
    path = Path(path)
    try:
        return parse_frontmatter(path.read_text(encoding="utf-8"))
    except FrontmatterError as exc:
        raise FrontmatterError(f"{path}: {exc}") from None


def check(path) -> list[str]:
    """Return the problems in ``path``'s frontmatter (empty list = parses)."""
    try:
        load(path)
    except FrontmatterError as exc:
        return [str(exc)]
    except (OSError, UnicodeDecodeError) as exc:
        return [f"{path}: cannot read: {exc}"]
    return []
