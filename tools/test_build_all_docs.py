#!/usr/bin/env python3
"""Regression tests for building all declared documentation releases."""

from __future__ import annotations

import json
import sys
import tempfile
import unittest
from pathlib import Path


TOOLS = Path(__file__).resolve().parent
sys.path.insert(0, str(TOOLS))

from build_all_docs import build_all  # noqa: E402


class BuildAllDocsTests(unittest.TestCase):
    def test_builds_the_current_release_without_a_git_worktree(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            source = root / "docs"
            source.mkdir()
            (source / "index.md").write_text("# Documentation\n", encoding="utf-8")
            (source / "layout.json").write_text(json.dumps({"schema_version": 1, "release": "1.9.1"}), encoding="utf-8")
            (source / "versions.json").write_text(
                json.dumps(
                    {
                        "schema_version": 1,
                        "current": "1.9.1",
                        "site_url": "https://example.invalid/stringkit-fp",
                        "repository_url": "https://github.com/example/stringkit-fp",
                        "versions": [{"release": "1.9.1", "source_ref": "main"}],
                    }
                ),
                encoding="utf-8",
            )

            count = build_all(root, root / "site", root / "artifacts")

            self.assertEqual(1, count)
            self.assertTrue((root / "site" / "1.9.1" / "index.html").is_file())
            self.assertTrue((root / "artifacts" / "stringkit-fp-docs-1.9.1.zip").is_file())


if __name__ == "__main__":
    unittest.main()
