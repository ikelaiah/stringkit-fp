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

    def test_reports_duplicate_ids_and_unsafe_links(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            site = self.build_fixture(Path(directory))
            page = site / "1.9.1" / "guide.html"
            page.write_text(
                page.read_text(encoding="utf-8").replace(
                    "</main>",
                    '<p id="guide">Duplicate identifier</p><a href="javascript:alert(1)">Unsafe</a></main>',
                ),
                encoding="utf-8",
            )
            errors = check_site(site)
            self.assertTrue(any("duplicate id" in error for error in errors))
            self.assertTrue(any("unsafe link" in error for error in errors))

    def test_requires_the_documentation_assets_and_version_targets(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            site = self.build_fixture(Path(directory))
            (site / "1.9.1" / "assets" / "site.js").unlink()
            errors = check_site(site)
            self.assertTrue(any("missing required asset" in error for error in errors))

    def rewrite_manifest(self, site: Path, versions: list[dict[str, str]], current: str = "1.9.1") -> None:
        (site / "versions.json").write_text(
            json.dumps(
                {
                    "schema_version": 1,
                    "current": current,
                    "site_url": "https://example.invalid/stringkit-fp",
                    "repository_url": "https://github.com/example/stringkit-fp",
                    "versions": versions,
                }
            ),
            encoding="utf-8",
        )

    def test_reports_versions_ordered_other_than_newest_to_oldest(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            site = self.build_fixture(Path(directory))
            self.rewrite_manifest(site, [{"release": "1.8.0", "source_ref": "v1.8.0"}, {"release": "1.9.1", "source_ref": "v1.9.1"}])
            self.assertTrue(any("ordered newest to oldest" in error for error in check_site(site)))

    def test_reports_duplicate_release_entries(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            site = self.build_fixture(Path(directory))
            self.rewrite_manifest(site, [{"release": "1.9.1", "source_ref": "v1.9.1"}, {"release": "1.9.1", "source_ref": "v1.9.1"}])
            self.assertTrue(any("duplicate release entries" in error for error in check_site(site)))

    def test_reports_a_current_release_missing_from_versions(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            site = self.build_fixture(Path(directory))
            self.rewrite_manifest(
                site,
                [{"release": "1.9.0", "source_ref": "v1.9.0"}, {"release": "1.8.0", "source_ref": "v1.8.0"}],
                current="1.9.1",
            )
            self.assertTrue(any("absent from versions" in error for error in check_site(site)))

    def test_reports_a_built_source_ref_that_differs_from_the_manifest(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            site = self.build_fixture(Path(directory))
            identity = site / "1.9.1" / "release.json"
            release = json.loads(identity.read_text(encoding="utf-8"))
            release["source_ref"] = "v9.9.9"
            identity.write_text(json.dumps(release), encoding="utf-8")
            self.assertTrue(any("differs from the declared metadata" in error for error in check_site(site)))


if __name__ == "__main__":
    unittest.main()
