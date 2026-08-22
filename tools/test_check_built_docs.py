#!/usr/bin/env python3
"""Regression tests for generated StringKit-FP documentation validation."""

from __future__ import annotations

import json
import sys
import tempfile
import unittest
from pathlib import Path


TOOLS = Path(__file__).resolve().parent
sys.path.insert(0, str(TOOLS))

from build_docs import build_site  # noqa: E402
from check_built_docs import check_site  # noqa: E402


class CheckBuiltDocsTests(unittest.TestCase):
    def build_fixture(self, root: Path) -> Path:
        source = root / "docs"
        output = root / "site" / "1.9.1"
        source.mkdir()
        (source / "index.md").write_text("# Index\n\n[Guide](guide.md)\n", encoding="utf-8")
        (source / "guide.md").write_text("# Guide\n\nAll good.\n", encoding="utf-8")
        (source / "layout.json").write_text(json.dumps({"schema_version": 1, "release": "1.9.1"}), encoding="utf-8")
        versions = source / "versions.json"
        versions.write_text(
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
        build_site(source, output, output.parent, versions)
        return output.parent

    def test_accepts_a_complete_versioned_site(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            self.assertEqual([], check_site(self.build_fixture(Path(directory))))

    def test_reports_a_missing_generated_link_target(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            site = self.build_fixture(Path(directory))
            page = site / "1.9.1" / "index.html"
            page.write_text(page.read_text(encoding="utf-8").replace('guide.html', 'missing.html'), encoding="utf-8")
            self.assertTrue(any("missing link target" in error for error in check_site(site)))


if __name__ == "__main__":
    unittest.main()
