#!/usr/bin/env python3
"""
build.py — Combine individual CM Algorithm Card HTML files into one document.

Usage:
    python build.py                 # outputs CM-Algorithm-Cards-Combined.html
    python build.py --check         # list found/missing files without building

Requirements:
    pip install beautifulsoup4
"""

import re
import sys
from pathlib import Path

try:
    from bs4 import BeautifulSoup
except ImportError:
    print("Error: beautifulsoup4 is required.  pip install beautifulsoup4")
    sys.exit(1)

# ── CM order and display labels ─────────────────────────────────────────────

CM_FILES = [
    "CM-01-Clinician-Burnout.html",
    "CM-02-Cognitive-Task-Load.html",
    "CM-03-Professional-Fulfillment.html",
    "CM-04-Documentation-Time.html",
    "CM-05-After-Hours-Documentation.html",
    "CM-06-Chart-Closure-Timeliness.html",
    "CM-07-Total-EHR-Time.html",
    "CM-08-Note-Completeness.html",
    "CM-09-Note-Inaccuracy.html",
    "CM-10-Note-Quality-Overall.html",
    "CM-11-Note-Length-Verbosity.html",
    "CM-12-Automated-NLP-Metrics.html",
    "CM-13-Adoption-Utilization.html",
    "CM-14-Adoption-Intention.html",
    "CM-15-Provider-Satisfaction.html",
    "CM-16-Provider-Trust.html",
    "CM-17-Patient-Experience.html",
    "CM-18-Physician-Patient-Interaction.html",
    "CM-19-Clinical-Patient-Safety.html",
    "CM-20-Financial-Productivity.html",
    "CM-21-Coding-Accuracy.html",
    "CM-22-Patient-Volume.html",
    "CM-23-Implementation-Barriers.html",
    "CM-24-Transcription-ASR-Accuracy.html",
    "CM-25-Evaluation-Methodology.html",
]

CM_LABELS = {
    "CM-01-Clinician-Burnout.html":         ("CM-01", "Clinician Burnout"),
    "CM-02-Cognitive-Task-Load.html":            ("CM-02", "Cognitive Load"),
    "CM-03-Professional-Fulfillment.html":  ("CM-03", "Professional Fulfillment"),
    "CM-04-Documentation-Time.html":        ("CM-04", "Documentation Time"),
    "CM-05-After-Hours-Documentation.html": ("CM-05", "After-Hours Documentation"),
    "CM-06-Chart-Closure-Timeliness.html":  ("CM-06", "Chart Closure Timeliness"),
    "CM-07-Total-EHR-Time.html":            ("CM-07", "Total EHR Time"),
    "CM-08-Note-Completeness.html":         ("CM-08", "Note Completeness"),
    "CM-09-Note-Inaccuracy.html":           ("CM-09", "Note Inaccuracy"),
    "CM-10-Note-Quality-Overall.html":      ("CM-10", "Note Quality Overall"),
    "CM-11-Note-Length-Verbosity.html":     ("CM-11", "Note Length/Verbosity"),
    "CM-12-Automated-NLP-Metrics.html":     ("CM-12", "Automated NLP Metrics"),
    "CM-13-Adoption-Utilization.html":      ("CM-13", "Adoption/Utilization"),
    "CM-14-Adoption-Intention.html":        ("CM-14", "Adoption Intention"),
    "CM-15-Provider-Satisfaction.html":     ("CM-15", "Provider Satisfaction"),
    "CM-16-Provider-Trust.html":            ("CM-16", "Provider Trust"),
    "CM-17-Patient-Experience.html":        ("CM-17", "Patient Experience"),
    "CM-18-Physician-Patient-Interaction.html": ("CM-18", "Physician-Patient Interaction"),
    "CM-19-Clinical-Patient-Safety.html":   ("CM-19", "Clinical Patient Safety"),
    "CM-20-Financial-Productivity.html":    ("CM-20", "Financial Productivity"),
    "CM-21-Coding-Accuracy.html":           ("CM-21", "Coding Accuracy"),
    "CM-22-Patient-Volume.html":            ("CM-22", "Patient Volume"),
    "CM-23-Implementation-Barriers.html":   ("CM-23", "Implementation Barriers"),
    "CM-24-Transcription-ASR-Accuracy.html": ("CM-24", "Transcription/ASR Accuracy"),
    "CM-25-Evaluation-Methodology.html":    ("CM-25", "Evaluation Methodology"),
}

OUTPUT_FILE = "CM-Algorithm-Cards-Combined.html"

# ── Extra CSS added only in the combined document ────────────────────────────

COMBINED_CSS = """
    /* ── Combined-document nav ── */
    body { margin: 0; }
    .cm-nav {
      position: sticky;
      top: 0;
      z-index: 100;
      background: #1e2d3d;
      display: flex;
      flex-wrap: wrap;
      align-items: stretch;
      padding: 0 8px;
      box-shadow: 0 2px 10px rgba(0,0,0,0.22);
    }
    .cm-nav-logo {
      display: flex;
      align-items: center;
      padding: 0 16px 0 8px;
      border-right: 1px solid rgba(255,255,255,0.1);
      margin-right: 4px;
      font-size: 11px;
      font-weight: 700;
      text-transform: uppercase;
      letter-spacing: 0.1em;
      color: rgba(255,255,255,0.35);
      white-space: nowrap;
    }
    .nav-item {
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      padding: 7px 12px;
      text-decoration: none;
      border-bottom: 3px solid transparent;
      transition: border-color 0.12s;
      min-width: 80px;
    }
    .nav-item:hover { border-bottom-color: rgba(0,121,107,0.6); }
    .nav-item.active { border-bottom-color: #00796b; }
    .nav-code {
      font-family: "Courier New", Courier, monospace;
      font-size: 11.5px;
      font-weight: 700;
      color: #7fb8d0;
      letter-spacing: 0.04em;
    }
    .nav-name {
      font-size: 9.5px;
      color: rgba(255,255,255,0.45);
      white-space: nowrap;
      margin-top: 1px;
    }
    .cm-section {
      border-bottom: 3px solid #d9dee6;
      scroll-margin-top: 56px;
    }
    .cm-section:last-child { border-bottom: 0; }
    @media (max-width: 620px) {
      .nav-name { display: none; }
      .nav-item { padding: 8px 8px; min-width: 52px; }
    }
    @media print {
      .cm-nav { display: none; }
      .cm-section { border: 0; page-break-before: always; }
      .cm-section:first-child { page-break-before: auto; }
    }
"""

# ── Scroll-spy JS for nav highlight ─────────────────────────────────────────

SCROLL_SPY_JS = """
<script>
(function () {
  var sections = document.querySelectorAll('.cm-section');
  var links    = document.querySelectorAll('.nav-item');
  var nav      = document.querySelector('.cm-nav');

  function update() {
    var offset = nav ? nav.offsetHeight + 24 : 60;
    var active = sections[0] && sections[0].id;
    sections.forEach(function (s) {
      if (s.getBoundingClientRect().top <= offset) active = s.id;
    });
    links.forEach(function (a) {
      a.classList.toggle('active', a.getAttribute('href') === '#' + active);
    });
  }

  window.addEventListener('scroll', update, { passive: true });
  update();
})();
</script>
"""

# ── Helpers ──────────────────────────────────────────────────────────────────

def anchor_id(filename):
    """cm-04, cm-05, … from filename."""
    m = re.match(r"(CM-\d+)", filename, re.IGNORECASE)
    return m.group(1).lower() if m else re.sub(r"\.html$", "", filename).lower()


def extract_style(soup):
    """Return the text content of the first <style> tag."""
    tag = soup.find("style")
    return (tag.string or "") if tag else ""


def extract_page_div(soup, filename):
    """Return the outer HTML of the .page div."""
    tag = soup.find("div", class_="page")
    if tag is None:
        print(f"  Warning: no <div class='page'> found in {filename}")
        return ""
    return str(tag)


def extract_switcher_script(soup):
    """Return the inner text of the algo-switcher tab script, if present.

    This <script> lives as a sibling after </div class="page"> in source
    files, so extract_page_div() never captures it. Cards that use the
    tabbed Generic/Epic algorithm layout (algo-switcher) are inert without
    it — the tabs render but clicking does nothing and no tab shows as
    active on load.
    """
    for tag in soup.find_all("script"):
        if tag.string and "algo-switcher" in tag.string:
            return tag.string
    return None


def build_nav(files):
    items = ['  <span class="cm-nav-logo">Algorithm Cards</span>']
    for fname in files:
        aid = anchor_id(fname)
        code, name = CM_LABELS[fname]
        items.append(
            f'  <a class="nav-item" href="#{aid}">'
            f'<span class="nav-code">{code}</span>'
            f'<span class="nav-name">{name}</span>'
            f'</a>'
        )
    return "\n".join(items)


def build_section(page_html, anchor):
    return (
        f'<section class="cm-section" id="{anchor}">\n'
        f'{page_html}\n'
        f'</section>'
    )


# ── Main ─────────────────────────────────────────────────────────────────────

def main():
    check_only = "--check" in sys.argv
    here = Path(__file__).parent

    # Resolve and verify files
    found, missing = [], []
    for fname in CM_FILES:
        p = here / fname
        (found if p.exists() else missing).append((fname, p))

    for fname, _ in missing:
        print(f"  Missing: {fname}")
    if missing and not check_only:
        print(f"\n{len(missing)} file(s) missing — fix before building.")
        sys.exit(1)

    if check_only:
        print(f"Found {len(found)}/{len(CM_FILES)} files.")
        for fname, p in found:
            print(f"  OK   {p.stat().st_size:>8,} bytes  {fname}")
        return

    # Parse all files
    soups = {}
    for fname, p in found:
        soups[fname] = BeautifulSoup(p.read_text(encoding="utf-8"), "html.parser")

    # Extract shared CSS from first file (all files share identical styles)
    shared_css = extract_style(soups[found[0][0]])

    # Build nav HTML
    nav_html = build_nav([f for f, _ in found])

    # Build section HTML for each CM
    sections = []
    switcher_script = None
    for fname, _ in found:
        page_html = extract_page_div(soups[fname], fname)
        if page_html:
            sections.append(build_section(page_html, anchor_id(fname)))
        if switcher_script is None:
            switcher_script = extract_switcher_script(soups[fname])
    sections_html = "\n\n".join(sections)

    switcher_script_html = (
        f"<script>\n{switcher_script}\n</script>\n" if switcher_script else ""
    )

    # Assemble combined document
    out_parts = [
        '<!doctype html>\n',
        '<html lang="en">\n',
        '<head>\n',
        '  <meta charset="utf-8">\n',
        '  <meta name="viewport" content="width=device-width, initial-scale=1">\n',
        '  <title>Suki AI — CM Algorithm Cards</title>\n',
        '  <style>\n',
        shared_css, '\n',
        COMBINED_CSS,
        '  </style>\n',
        '</head>\n',
        '<body>\n\n',
        '<nav class="cm-nav" aria-label="Canonical Measures">\n',
        nav_html, '\n',
        '</nav>\n\n',
        sections_html, '\n\n',
        switcher_script_html,
        SCROLL_SPY_JS,
        '\n</body>\n',
        '</html>\n',
    ]
    combined = "".join(out_parts)

    output_path = here / OUTPUT_FILE
    output_path.write_text(combined, encoding="utf-8")

    size_kb = output_path.stat().st_size / 1024
    print(f"Built: {output_path.name}  ({size_kb:.0f} KB)")
    print(f"  algo-switcher tab script: {'included' if switcher_script else 'NOT FOUND (no card uses tabs?)'}")
    print(f"  {len(sections)} sections:")
    for fname, p in found:
        print(f"  + {fname}  ({p.stat().st_size:,} bytes)")


if __name__ == "__main__":
    main()
