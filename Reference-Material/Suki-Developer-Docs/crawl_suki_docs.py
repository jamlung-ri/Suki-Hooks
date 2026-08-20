"""
Suki Developer Docs Crawler
Crawls developer.suki.ai, converts pages to markdown, saves locally.
Targets: SDK docs, API specs, Glossary, FAQs, Release Notes, Capabilities pages.
"""

import requests
from bs4 import BeautifulSoup
import time
import re
import os
from urllib.parse import urljoin, urlparse
from pathlib import Path

BASE_URL = "https://developer.suki.ai"
OUTPUT_DIR = Path(__file__).parent

HEADERS = {
    "User-Agent": "Mozilla/5.0 (compatible; research-crawler/1.0; +documentation-analysis)"
}

# Seed URLs — start here and follow links within the same domain
SEED_PATHS = [
    "/",
    "/documentation",
    "/web-sdk",
    "/headless-sdk",
    "/mobile-sdk",
    "/documentation/faqs",
    "/documentation/glossary",
    "/documentation/release-notes",
    "/documentation/capabilities/multilingual",
    "/documentation/capabilities/personalization",
    "/documentation/capabilities/problem-based-charting",
    "/documentation/api-reference",
    "/documentation/getting-started",
]

# Only follow links whose path starts with one of these prefixes
ALLOWED_PATH_PREFIXES = [
    "/documentation",
    "/web-sdk",
    "/headless-sdk",
    "/mobile-sdk",
    "/api",
]

MAX_PAGES = 120
DELAY_SECONDS = 1.2  # polite crawl rate


def url_to_filename(url: str) -> Path:
    parsed = urlparse(url)
    path = parsed.path.strip("/").replace("/", "__")
    if not path:
        path = "index"
    return OUTPUT_DIR / f"{path}.md"


def html_to_markdown(soup: BeautifulSoup, url: str, title: str) -> str:
    """Extract meaningful text from page and format as markdown."""
    lines = [f"# {title}", f"\n**Source URL:** {url}\n", "---\n"]

    # Remove nav, header, footer, scripts, styles
    for tag in soup.find_all(["nav", "header", "footer", "script", "style", "aside"]):
        tag.decompose()

    # Try to find the main content area
    main = (
        soup.find("main")
        or soup.find("article")
        or soup.find(class_=re.compile(r"content|main|docs|page", re.I))
        or soup.find("body")
    )

    if not main:
        return "\n".join(lines) + "\n[No content extracted]\n"

    def process_element(el, depth=0) -> list[str]:
        result = []
        if isinstance(el, str):
            text = el.strip()
            if text:
                result.append(text)
            return result

        tag = el.name if el.name else ""

        if tag in ("h1", "h2", "h3", "h4", "h5", "h6"):
            level = int(tag[1])
            text = el.get_text(strip=True)
            if text:
                result.append(f"\n{'#' * level} {text}\n")

        elif tag == "p":
            text = el.get_text(separator=" ", strip=True)
            if text:
                result.append(f"\n{text}\n")

        elif tag in ("ul", "ol"):
            for li in el.find_all("li", recursive=False):
                text = li.get_text(separator=" ", strip=True)
                if text:
                    result.append(f"- {text}")
            result.append("")

        elif tag == "pre":
            code = el.get_text()
            if code.strip():
                result.append(f"\n```\n{code.rstrip()}\n```\n")

        elif tag == "code" and el.parent and el.parent.name != "pre":
            text = el.get_text(strip=True)
            if text:
                result.append(f"`{text}`")

        elif tag == "table":
            rows = el.find_all("tr")
            table_lines = []
            for i, row in enumerate(rows):
                cells = row.find_all(["th", "td"])
                cell_texts = [c.get_text(separator=" ", strip=True) for c in cells]
                table_lines.append("| " + " | ".join(cell_texts) + " |")
                if i == 0:
                    table_lines.append("| " + " | ".join(["---"] * len(cells)) + " |")
            result.extend(table_lines)
            result.append("")

        elif tag == "a":
            text = el.get_text(strip=True)
            href = el.get("href", "")
            if text and href:
                if href.startswith("http"):
                    result.append(f"[{text}]({href})")
                else:
                    result.append(text)
            elif text:
                result.append(text)

        elif tag in ("div", "section", "article", "main", "span", "li",
                     "td", "th", "blockquote", "aside"):
            for child in el.children:
                result.extend(process_element(child, depth + 1))

        elif tag in ("strong", "b", "em", "i"):
            text = el.get_text(strip=True)
            if text:
                result.append(f"**{text}**" if tag in ("strong", "b") else f"*{text}*")

        elif tag == "hr":
            result.append("\n---\n")

        elif tag == "br":
            result.append("\n")

        return result

    parts = process_element(main)
    # Collapse excessive blank lines
    content = "\n".join(lines) + "\n" + "\n".join(parts)
    content = re.sub(r"\n{4,}", "\n\n\n", content)
    return content


def should_follow(url: str) -> bool:
    parsed = urlparse(url)
    if parsed.netloc and parsed.netloc != "developer.suki.ai":
        return False
    path = parsed.path
    return any(path.startswith(p) for p in ALLOWED_PATH_PREFIXES)


def extract_links(soup: BeautifulSoup, base_url: str) -> list[str]:
    links = []
    for a in soup.find_all("a", href=True):
        href = a["href"]
        if href.startswith("#") or href.startswith("mailto:") or href.startswith("javascript:"):
            continue
        full = urljoin(base_url, href)
        parsed = urlparse(full)
        # Normalize — strip fragments and query strings for dedup
        clean = parsed._replace(fragment="", query="").geturl()
        links.append(clean)
    return links


def get_title(soup: BeautifulSoup) -> str:
    og_title = soup.find("meta", property="og:title")
    if og_title and og_title.get("content"):
        return og_title["content"].strip()
    h1 = soup.find("h1")
    if h1:
        return h1.get_text(strip=True)
    title = soup.find("title")
    if title:
        return title.get_text(strip=True)
    return "Untitled"


def crawl():
    visited = set()
    queue = [urljoin(BASE_URL, p) for p in SEED_PATHS]
    saved = []
    failed = []

    session = requests.Session()
    session.headers.update(HEADERS)

    while queue and len(visited) < MAX_PAGES:
        url = queue.pop(0)
        parsed = urlparse(url)
        clean_url = parsed._replace(fragment="", query="").geturl()

        if clean_url in visited:
            continue
        visited.add(clean_url)

        print(f"  Fetching: {clean_url}")
        try:
            resp = session.get(clean_url, timeout=15)
            if resp.status_code == 404:
                print(f"    404 — skipping")
                failed.append((clean_url, "404"))
                time.sleep(DELAY_SECONDS)
                continue
            resp.raise_for_status()
        except Exception as e:
            print(f"    ERROR: {e}")
            failed.append((clean_url, str(e)))
            time.sleep(DELAY_SECONDS)
            continue

        soup = BeautifulSoup(resp.text, "html.parser")
        title = get_title(soup)
        markdown = html_to_markdown(soup, clean_url, title)

        outfile = url_to_filename(clean_url)
        outfile.write_text(markdown, encoding="utf-8")
        saved.append((clean_url, str(outfile.name)))
        print(f"    Saved -> {outfile.name} ({len(markdown):,} chars)")

        # Discover new links to follow
        for link in extract_links(soup, clean_url):
            link_parsed = urlparse(link)
            link_clean = link_parsed._replace(fragment="", query="").geturl()
            if link_clean not in visited and should_follow(link_clean):
                if link_clean not in queue:
                    queue.append(link_clean)

        time.sleep(DELAY_SECONDS)

    # Write summary
    summary_lines = [
        "# Suki Developer Docs Crawl Summary\n",
        f"**Pages saved:** {len(saved)}",
        f"**Pages failed/skipped:** {len(failed)}",
        f"**Total visited:** {len(visited)}\n",
        "## Saved Pages\n",
    ]
    for url, fname in saved:
        summary_lines.append(f"- [{fname}]({fname}) — {url}")
    if failed:
        summary_lines.append("\n## Failed / Skipped\n")
        for url, reason in failed:
            summary_lines.append(f"- {url} ({reason})")

    (OUTPUT_DIR / "CRAWL_SUMMARY.md").write_text("\n".join(summary_lines), encoding="utf-8")

    print(f"\nDone. {len(saved)} pages saved, {len(failed)} failed.")
    print(f"Summary: {OUTPUT_DIR / 'CRAWL_SUMMARY.md'}")


if __name__ == "__main__":
    print(f"Crawling {BASE_URL} -> {OUTPUT_DIR}\n")
    crawl()
