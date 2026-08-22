#!/usr/bin/env python3
"""Build StringKit-FP Markdown documentation as a small, dependency-free site."""

from __future__ import annotations

import argparse
import hashlib
import html
import json
import os
import re
import shutil
import zipfile
from dataclasses import dataclass
from pathlib import Path
from urllib.parse import quote, urlsplit


OUTPUT_MARKER = ".stringkit-fp-docs-output"
LINK_PATTERN = re.compile(r"(?<!!)\[([^\]]+)\]\(([^)]+)\)")
HEADING_PATTERN = re.compile(r"^(#{1,6})\s+(.+?)\s*$")
FENCE_PATTERN = re.compile(r"^```([^`]*)\s*$")
LIST_PATTERN = re.compile(r"^\s*([-*+]|\d+\.)\s+(.+)$")


@dataclass(frozen=True)
class SiteConfig:
    current: str
    release: str
    source_ref: str
    repository_url: str
    site_url: str
    versions: list[dict[str, str]]


def load_config(versions_path: Path, release: str | None = None) -> SiteConfig:
    try:
        data = json.loads(versions_path.read_text(encoding="utf-8"))
        current = str(data["current"])
        versions = data["versions"]
        if not isinstance(versions, list) or not versions:
            raise ValueError("versions must be a non-empty list")
        selected_release = release or current
        entry = next((item for item in versions if item["release"] == selected_release), None)
        if entry is None:
            raise ValueError(f"release {selected_release!r} is not declared")
        if not isinstance(entry, dict):
            raise ValueError("current version must be an object")
        return SiteConfig(
            current=current,
            release=selected_release,
            source_ref=str(entry["source_ref"]),
            repository_url=str(data["repository_url"]).rstrip("/"),
            site_url=str(data["site_url"]).rstrip("/"),
            versions=[
                {"release": str(item["release"]), "source_ref": str(item["source_ref"])}
                for item in versions
            ],
        )
    except (OSError, KeyError, TypeError, ValueError, json.JSONDecodeError) as exc:
        raise ValueError(f"invalid version metadata {versions_path}: {exc}") from exc


def slug(value: str) -> str:
    value = re.sub(r"[`*_]", "", value).strip().lower()
    value = re.sub(r"[^a-z0-9]+", "-", value).strip("-")
    return value or "section"


def markdown_anchors(path: Path) -> set[str]:
    anchors: set[str] = set()
    for line in path.read_text(encoding="utf-8").splitlines():
        match = HEADING_PATTERN.match(line)
        if match:
            base = slug(match.group(2))
            anchor = base
            suffix = 2
            while anchor in anchors:
                anchor = f"{base}-{suffix}"
                suffix += 1
            anchors.add(anchor)
    return anchors


def is_external(target: str) -> bool:
    parsed = urlsplit(target)
    return bool(parsed.scheme or parsed.netloc or target.startswith(("mailto:", "#")))


def split_target(target: str) -> tuple[str, str]:
    path, separator, fragment = target.partition("#")
    return path, fragment if separator else ""


def project_relative(candidate: Path, project_root: Path) -> str:
    return candidate.resolve().relative_to(project_root.resolve()).as_posix()


def relative_url(source: Path, target: Path) -> str:
    return os.path.relpath(target, source).replace(os.sep, "/")


def validate_source_links(source: Path, documents: list[Path], project_root: Path) -> None:
    document_set = {path.resolve() for path in documents}
    for document in documents:
        for _label, raw_target in LINK_PATTERN.findall(document.read_text(encoding="utf-8")):
            target = raw_target.strip()
            if is_external(target):
                continue
            relative_path, fragment = split_target(target)
            candidate = (document.parent / relative_path).resolve() if relative_path else document.resolve()
            try:
                candidate.relative_to(project_root.resolve())
            except ValueError as exc:
                raise ValueError(f"broken internal link in {document}: {target}") from exc
            if not candidate.is_file():
                raise ValueError(f"broken internal link in {document}: {target}")
            if (
                candidate.suffix.lower() == ".md"
                and candidate.is_relative_to(source.resolve())
                and candidate not in document_set
            ):
                raise ValueError(f"broken internal link in {document}: {target}")
            if (
                fragment
                and candidate.suffix.lower() == ".md"
                and candidate.is_relative_to(source.resolve())
                and fragment not in markdown_anchors(candidate)
            ):
                raise ValueError(f"broken internal link anchor in {document}: {target}")


def ensure_layout(source: Path, config: SiteConfig) -> None:
    layout_path = source / "layout.json"
    try:
        layout = json.loads(layout_path.read_text(encoding="utf-8"))
        if layout.get("schema_version") != 1:
            raise ValueError("schema_version must be 1")
        if str(layout.get("release")) != config.release:
            raise ValueError("release must match versions.json current")
        required = layout.get("required_pages", [])
        if not isinstance(required, list) or not all(isinstance(item, str) for item in required):
            raise ValueError("required_pages must be an array of paths")
        missing = [page for page in required if not (source / page).is_file()]
        if missing:
            raise ValueError(f"missing required documentation page(s): {', '.join(missing)}")
    except (OSError, ValueError, json.JSONDecodeError) as exc:
        raise ValueError(f"invalid documentation layout {layout_path}: {exc}") from exc


def link_resolver(
    document: Path,
    html_page: Path,
    source: Path,
    output: Path,
    project_root: Path,
    config: SiteConfig,
):
    def resolve(raw_target: str) -> str:
        target = raw_target.strip()
        if is_external(target):
            return target
        relative_path, fragment = split_target(target)
        candidate = (document.parent / relative_path).resolve() if relative_path else document.resolve()
        if candidate.suffix.lower() == ".md" and candidate.is_relative_to(source.resolve()):
            generated = output / candidate.relative_to(source).with_suffix(".html")
            href = relative_url(html_page.parent, generated)
        elif candidate == document.resolve() and not relative_path:
            href = ""
        else:
            location = project_relative(candidate, project_root)
            href = f"{config.repository_url}/blob/{quote(config.source_ref, safe='')}/{quote(location, safe='/')}"
        return href + (f"#{fragment}" if fragment else "")

    return resolve


def render_inline(text: str, resolve_link) -> str:
    tokens: list[str] = []

    def stash(value: str) -> str:
        tokens.append(value)
        return f"\x00{len(tokens) - 1}\x00"

    def render_link(match: re.Match[str]) -> str:
        label, target = match.groups()
        return stash(
            f'<a href="{html.escape(resolve_link(target), quote=True)}">'
            f"{render_inline_plain(label)}</a>"
        )

    rendered = LINK_PATTERN.sub(render_link, text)
    rendered = html.escape(rendered)
    rendered = re.sub(r"`([^`]+)`", lambda match: f"<code>{html.escape(match.group(1))}</code>", rendered)
    rendered = re.sub(r"\*\*([^*]+)\*\*", r"<strong>\1</strong>", rendered)
    rendered = re.sub(r"(?<!\*)\*([^*]+)\*", r"<em>\1</em>", rendered)
    for index, token in enumerate(tokens):
        rendered = rendered.replace(f"\x00{index}\x00", token)
    return rendered


def render_inline_plain(text: str) -> str:
    result = html.escape(text)
    result = re.sub(r"`([^`]+)`", r"<code>\1</code>", result)
    result = re.sub(r"\*\*([^*]+)\*\*", r"<strong>\1</strong>", result)
    return result


def is_table_separator(line: str) -> bool:
    cells = [cell.strip() for cell in line.strip().strip("|").split("|")]
    return bool(cells) and all(re.fullmatch(r":?-{3,}:?", cell) for cell in cells)


def table_cells(line: str, resolve_link) -> list[str]:
    return [render_inline(cell.strip(), resolve_link) for cell in line.strip().strip("|").split("|")]


def markdown_to_html(markdown: str, resolve_link) -> str:
    lines = markdown.splitlines()
    chunks: list[str] = []
    paragraph: list[str] = []
    index = 0
    heading_ids: set[str] = set()

    def flush_paragraph() -> None:
        if paragraph:
            chunks.append(f"<p>{render_inline(' '.join(paragraph), resolve_link)}</p>")
            paragraph.clear()

    while index < len(lines):
        line = lines[index]
        fence = FENCE_PATTERN.match(line)
        heading = HEADING_PATTERN.match(line)
        list_match = LIST_PATTERN.match(line)
        if fence:
            flush_paragraph()
            language = fence.group(1).strip().lower()
            index += 1
            code: list[str] = []
            while index < len(lines) and not FENCE_PATTERN.match(lines[index]):
                code.append(lines[index])
                index += 1
            if index == len(lines):
                raise ValueError("unclosed code fence")
            language_class = f' class="language-{html.escape(language, quote=True)}"' if language else ""
            chunks.append(f"<pre><code{language_class}>{html.escape(chr(10).join(code))}</code></pre>")
        elif heading:
            flush_paragraph()
            level, title = len(heading.group(1)), heading.group(2)
            base = slug(title)
            identifier = base
            suffix = 2
            while identifier in heading_ids:
                identifier = f"{base}-{suffix}"
                suffix += 1
            heading_ids.add(identifier)
            chunks.append(f"<h{level} id=\"{identifier}\">{render_inline(title, resolve_link)}</h{level}>")
        elif line.strip().startswith("|") and index + 1 < len(lines) and is_table_separator(lines[index + 1]):
            flush_paragraph()
            headers = table_cells(line, resolve_link)
            index += 2
            rows: list[list[str]] = []
            while index < len(lines) and lines[index].strip().startswith("|"):
                rows.append(table_cells(lines[index], resolve_link))
                index += 1
            header_html = "".join(f"<th>{cell}</th>" for cell in headers)
            body_html = "".join("<tr>" + "".join(f"<td>{cell}</td>" for cell in row) + "</tr>" for row in rows)
            chunks.append(f"<table><thead><tr>{header_html}</tr></thead><tbody>{body_html}</tbody></table>")
            index -= 1
        elif list_match:
            flush_paragraph()
            ordered = list_match.group(1).endswith(".")
            tag = "ol" if ordered else "ul"
            items: list[str] = []
            while index < len(lines):
                item_match = LIST_PATTERN.match(lines[index])
                if not item_match or item_match.group(1).endswith(".") != ordered:
                    break
                items.append(f"<li>{render_inline(item_match.group(2), resolve_link)}</li>")
                index += 1
            chunks.append(f"<{tag}>" + "".join(items) + f"</{tag}>")
            index -= 1
        elif not line.strip():
            flush_paragraph()
        else:
            paragraph.append(line.strip())
        index += 1
    flush_paragraph()
    return "\n".join(chunks)


def page_shell(title: str, body: str, config: SiteConfig, page: Path, output: Path) -> str:
    version_links = []
    for item in config.versions:
        release = item["release"]
        target = output.parent / release / "index.html"
        href = relative_url(page.parent, target)
        label = f"{release} (current)" if release == config.release else release
        version_links.append(f'<a href="{html.escape(href, quote=True)}">{html.escape(label)}</a>')
    stylesheet = relative_url(page.parent, output / "assets" / "site.css")
    return f"""<!doctype html>
<html lang="en"><head><meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="stringkit-release" content="{html.escape(config.release, quote=True)}">
<title>{html.escape(title)} — StringKit-FP</title>
<link rel="stylesheet" href="{html.escape(stylesheet, quote=True)}">
</head><body><header><a class="brand" href="{html.escape(relative_url(page.parent, output / 'index.html'), quote=True)}">StringKit-FP docs</a><span>v{html.escape(config.release)}</span></header>
<main>{body}</main>
<footer><nav aria-label="Documentation versions">Versions: {' · '.join(version_links)}</nav><p>Generated from the StringKit-FP documentation source.</p></footer>
</body></html>
"""


SITE_CSS = """*{box-sizing:border-box}body{margin:0;background:#f5f7fb;color:#1c2733;font:16px/1.6 system-ui,-apple-system,Segoe UI,sans-serif}header,main,footer{max-width:72rem;margin:auto;padding:1rem 1.4rem}header{display:flex;gap:1rem;align-items:center;border-bottom:1px solid #d9e1eb;background:#fff}.brand{font-weight:750;color:#063e70;text-decoration:none}header span{color:#506274}main{max-width:60rem;background:#fff;margin-top:2rem;margin-bottom:2rem;padding:clamp(1.25rem,4vw,3rem);border:1px solid #d9e1eb;border-radius:.6rem;box-shadow:0 8px 30px #102a4310}h1,h2,h3{line-height:1.2;color:#102a43;margin-top:1.8em}h1{margin-top:0}a{color:#0868ae}code{background:#edf2f7;padding:.1em .3em;border-radius:.2em}pre{overflow:auto;background:#102a43;color:#f7fafc;padding:1rem;border-radius:.45rem}pre code{padding:0;background:transparent}table{border-collapse:collapse;width:100%;margin:1rem 0}th,td{border:1px solid #cfd8e3;padding:.55rem;text-align:left;vertical-align:top}th{background:#edf3f8}li+li{margin-top:.35rem}footer{color:#52606d;font-size:.9rem}@media(max-width:640px){header,main,footer{padding-left:1rem;padding-right:1rem}main{margin-top:0;border:0;border-radius:0;box-shadow:none}}"""


def prepare_output(output: Path, release: str) -> None:
    marker = output / OUTPUT_MARKER
    if output.exists() and any(output.iterdir()):
        if not marker.is_file():
            raise ValueError(f"refusing to replace unmarked documentation output: {output}")
        shutil.rmtree(output)
    output.mkdir(parents=True, exist_ok=True)
    marker.write_text(release + "\n", encoding="utf-8")


def write_landing_page(site_root: Path, config: SiteConfig) -> None:
    target = f"{config.current}/index.html"
    site_root.mkdir(parents=True, exist_ok=True)
    (site_root / "index.html").write_text(
        f"""<!doctype html><html lang="en"><head><meta charset="utf-8"><meta name="viewport" content="width=device-width, initial-scale=1"><meta http-equiv="refresh" content="0; url={target}"><title>StringKit-FP documentation</title></head><body><p>Opening <a href="{target}">StringKit-FP {html.escape(config.release)} documentation</a>.</p></body></html>\n""",
        encoding="utf-8",
    )
    (site_root / ".nojekyll").write_text("", encoding="utf-8")
    (site_root / "versions.json").write_text(
        json.dumps({"schema_version": 1, "current": config.release, "versions": config.versions}, indent=2) + "\n",
        encoding="utf-8",
    )


def write_offline_archive(site_root: Path, archive: Path, release: str) -> str:
    archive.parent.mkdir(parents=True, exist_ok=True)
    root_name = f"stringkit-fp-docs-{release}"
    with zipfile.ZipFile(archive, "w", compression=zipfile.ZIP_DEFLATED) as bundle:
        for path in sorted(path for path in site_root.rglob("*") if path.is_file()):
            if path.resolve() == archive.resolve() or path.name == OUTPUT_MARKER:
                continue
            info = zipfile.ZipInfo(f"{root_name}/{path.relative_to(site_root).as_posix()}")
            info.date_time = (1980, 1, 1, 0, 0, 0)
            info.compress_type = zipfile.ZIP_DEFLATED
            info.external_attr = 0o644 << 16
            bundle.writestr(info, path.read_bytes())
    digest = hashlib.sha256(archive.read_bytes()).hexdigest()
    archive.with_name(archive.name + ".sha256").write_text(f"{digest}  {archive.name}\n", encoding="ascii")
    return digest


def build_site(
    source: Path,
    output: Path,
    site_root: Path,
    versions_path: Path,
    offline_archive: Path | None = None,
    release: str | None = None,
) -> int:
    source = source.resolve()
    output = output.resolve()
    site_root = site_root.resolve()
    config = load_config(versions_path.resolve(), release)
    ensure_layout(source, config)
    if output.name != config.release or output.parent != site_root:
        raise ValueError("versioned output must be site-root/<current release>")
    documents = sorted(source.rglob("*.md"))
    if not documents:
        raise ValueError(f"no Markdown documents found in {source}")
    validate_source_links(source, documents, source.parent)
    prepare_output(output, config.release)
    (output / "assets").mkdir()
    (output / "assets" / "site.css").write_text(SITE_CSS + "\n", encoding="utf-8")
    search_entries: list[dict[str, str]] = []
    for document in documents:
        relative = document.relative_to(source)
        page = output / relative.with_suffix(".html")
        page.parent.mkdir(parents=True, exist_ok=True)
        markdown = document.read_text(encoding="utf-8")
        resolver = link_resolver(document, page, source, output, source.parent, config)
        body = markdown_to_html(markdown, resolver)
        title_match = HEADING_PATTERN.search(markdown)
        title = title_match.group(2) if title_match else relative.stem
        page.write_text(page_shell(title, body, config, page, output), encoding="utf-8")
        search_entries.append({"title": title, "url": relative.with_suffix(".html").as_posix(), "text": re.sub(r"\s+", " ", markdown)})
    (output / "search-index.json").write_text(json.dumps(search_entries, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
    (output / "release.json").write_text(json.dumps({"schema_version": 1, "release": config.release, "source_ref": config.source_ref, "page_count": len(documents)}, indent=2) + "\n", encoding="utf-8")
    write_landing_page(site_root, config)
    if offline_archive:
        write_offline_archive(site_root, offline_archive.resolve(), config.release)
    print(f"Built {len(documents)} StringKit-FP documentation pages in {output}")
    return len(documents)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--source", type=Path, default=Path("docs"))
    parser.add_argument("--versions", type=Path, default=Path("docs/versions.json"))
    parser.add_argument("--output", type=Path)
    parser.add_argument("--site-root", type=Path)
    parser.add_argument("--offline-archive", type=Path)
    parser.add_argument("--release", help="build this release from its matching documentation source")
    args = parser.parse_args()
    config = load_config(args.versions.resolve(), args.release)
    site_root = args.site_root or Path("build/docs-site")
    output = args.output or site_root / config.release
    build_site(args.source, output, site_root, args.versions, args.offline_archive, args.release)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
