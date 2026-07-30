#!/usr/bin/env python3
"""
build_sprint2_proposal.py — Build the Suki Sprint 2 proposal site.

Filters the full CM Algorithm Cards set down to the five measures with a
plausible Epic Clarity data source (CM-04, CM-05, CM-06, CM-07, CM-22, per
the 2026-07-30 Suki QI Session review with Josh Vest and Paul Biondich) and
prepends an overview section laying out the Sprint 2 / phase-two proposal —
the main focus of this document, with the measure cards as supporting detail.

This is the Sprint 1 deliverable to Sudha — GitHub issue #228, superseding #165.
The full 25-measure site (index.html / CM-Algorithm-Cards-Combined.html)
remains the internal working artifact and is not affected by this script.

Usage:
    python build_sprint2_proposal.py

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

# ── Scope: the five Epic-sourced measures only ──────────────────────────────

EPIC_FILES = [
    "CM-04-Documentation-Time.html",
    "CM-05-After-Hours-Documentation.html",
    "CM-06-Chart-Closure-Timeliness.html",
    "CM-07-Total-EHR-Time.html",
    "CM-22-Patient-Volume.html",
]

EPIC_LABELS = {
    "CM-04-Documentation-Time.html":        ("CM-04", "Documentation Time"),
    "CM-05-After-Hours-Documentation.html": ("CM-05", "After-Hours Documentation"),
    "CM-06-Chart-Closure-Timeliness.html":  ("CM-06", "Chart Closure Timeliness"),
    "CM-07-Total-EHR-Time.html":            ("CM-07", "Total EHR Time"),
    "CM-22-Patient-Volume.html":            ("CM-22", "Patient Volume"),
}

OUTPUT_FILE = "Suki-Sprint-2-Proposal.html"

# ── Extra CSS (nav + overview section) ───────────────────────────────────────

SITE_CSS = """
    /* ── Site nav ── */
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

    /* ── Overview section ── */
    .status-table td, .status-table th { vertical-align: top; }

    /* Source/status vocabulary shared with index.html's grouping view */
    .tag-source-epic   { background: var(--teal-light); color: var(--teal); }
    .tag-status-draft      { background: var(--soft); color: var(--muted); }
    .tag-status-reviewed   { background: #e7f3ed; color: #2d6a4f; }
    .tag-status-prototype  { background: #d7f0e3; color: #1b6b43; font-weight: 700; }
    .tag-status-real-world { background: #c8ecd9; color: #0f5132; font-weight: 700; }

    .proposal-list {
      list-style: none;
      margin: 0 0 20px;
      padding: 0;
      counter-reset: step;
    }
    .proposal-list > li {
      position: relative;
      padding: 4px 0 16px 40px;
      border-left: 2px solid var(--line);
      margin-left: 14px;
    }
    .proposal-list > li:last-child { border-left-color: transparent; padding-bottom: 0; }
    .proposal-list > li::before {
      counter-increment: step;
      content: counter(step);
      position: absolute;
      left: -15px;
      top: 0;
      width: 28px;
      height: 28px;
      border-radius: 50%;
      background: var(--teal);
      color: #fff;
      font-size: 12.5px;
      font-weight: 800;
      display: flex;
      align-items: center;
      justify-content: center;
    }
    .proposal-list h3 {
      margin: 0 0 4px;
      font-size: 14.5px;
    }
    .proposal-list p {
      margin: 0;
      font-size: 13px;
      color: var(--muted);
      line-height: 1.55;
    }

    .out-of-scope {
      display: flex;
      flex-wrap: wrap;
      gap: 6px;
      margin-top: 8px;
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

# ── Overview section content ────────────────────────────────────────────────

OVERVIEW_HTML = """
<div class="page">

  <header class="masthead">
    <img src="assets/ri-mark.png" alt="Regenstrief Institute" class="ri-logo">
    <p class="eyebrow">Sprint 1 Deliverable &mdash; Suki AI Partnership</p>
    <h1>Epic-Sourced Canonical Measures</h1>
    <p>
      Regenstrief Institute / Indiana University &mdash; algorithm specifications for the Suki AI
      canonical measures that can be evaluated directly from a health system&rsquo;s own Epic
      instance.
    </p>
  </header>

  <p class="section-label">Scope of This Document</p>
  <div class="scope-box" style="margin-bottom:20px">
    <p>
      Suki AI&rsquo;s canonical measure set spans clinician well-being, note quality, adoption,
      financial productivity, and EHR-efficiency constructs. Of these, five &mdash;
      <strong>Documentation Time (CM-04)</strong>, <strong>After-Hours Documentation (CM-05)</strong>,
      <strong>Chart Closure Timeliness (CM-06)</strong>, <strong>Total EHR Time (CM-07)</strong>, and
      <strong>Patient Volume &amp; Throughput (CM-22)</strong> &mdash; have a plausible data source in
      Epic&rsquo;s Clarity data model. This document covers those five measures only.
    </p>
    <p>
      The remaining canonical measures &mdash; survey-based well-being and satisfaction measures,
      note-quality ratings, financial/productivity measures, and evaluation-methodology
      measures &mdash; rely on survey instruments, human/LLM rating, or claims data rather than
      Epic Clarity, and are out of scope for this deliverable.
    </p>
    <div class="out-of-scope">
      <span class="source-tag" style="background:var(--soft);color:var(--muted)">Survey-based well-being &amp; satisfaction</span>
      <span class="source-tag" style="background:var(--soft);color:var(--muted)">Note quality (human / LLM rating)</span>
      <span class="source-tag" style="background:var(--soft);color:var(--muted)">Financial &amp; coding measures</span>
      <span class="source-tag" style="background:var(--soft);color:var(--muted)">Evaluation-methodology measures</span>
    </div>
  </div>

  <p class="section-label">Measure Status</p>
  <table class="data-table status-table" style="margin-bottom:28px" aria-label="Measure status">
    <thead>
      <tr>
        <th>Measure</th>
        <th>Primary Data Source</th>
        <th>Epic Clarity Source</th>
        <th>Maturity Status</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td><a href="#cm-04">CM-04 &mdash; Documentation Time</a></td>
        <td><span class="source-tag tag-source-epic">Epic / EHR</span></td>
        <td><code>NOTES_HISTORY_LOG</code>, <code>HNO_INFO</code></td>
        <td>
          <span class="source-tag tag-status-prototype">Prototype Implementation</span><br>
          <span style="font-size:12px;color:var(--muted)">Join paths and field names checked against a live Epic
          instance; candidate fields narrowed to the ones with real data density. The most mature
          of the five.</span>
        </td>
      </tr>
      <tr>
        <td><a href="#cm-05">CM-05 &mdash; After-Hours Documentation</a></td>
        <td><span class="source-tag tag-source-epic">Epic / EHR</span></td>
        <td>Same note-event tables, time-of-day filter</td>
        <td><span class="source-tag tag-status-draft">Draft</span></td>
      </tr>
      <tr>
        <td><a href="#cm-06">CM-06 &mdash; Chart Closure Timeliness</a></td>
        <td><span class="source-tag tag-source-epic">Epic / EHR</span></td>
        <td>Signature / chart-close timestamps</td>
        <td><span class="source-tag tag-status-draft">Draft</span></td>
      </tr>
      <tr>
        <td><a href="#cm-07">CM-07 &mdash; Total EHR Time</a></td>
        <td><span class="source-tag tag-source-epic">Epic / EHR</span></td>
        <td>Clarity / Epic Signal</td>
        <td><span class="source-tag tag-status-draft">Draft</span></td>
      </tr>
      <tr>
        <td><a href="#cm-22">CM-22 &mdash; Patient Volume &amp; Throughput</a></td>
        <td><span class="source-tag tag-source-epic">Epic / EHR</span></td>
        <td>Encounter counts</td>
        <td><span class="source-tag tag-status-draft">Draft</span></td>
      </tr>
    </tbody>
  </table>
  <p style="font-size:12px;color:var(--muted);margin:-16px 0 28px">
    All five measures share the same primary data source &mdash; Epic / EHR, per the grouping on
    the working index &mdash; which is exactly what makes them the Epic-sourced subset in the
    first place. Maturity status follows the same four-stage scale used there: Draft (generated,
    not yet reviewed) &rarr; Human/Practitioner Reviewed &rarr; Prototype Implementation (checked
    against a live instance) &rarr; Real-World Implementation. &ldquo;Draft&rdquo; here means the
    field mapping follows the same approach used for Documentation Time, but hasn&rsquo;t yet been
    checked against a live Epic instance. See each card&rsquo;s Algorithm section for the proposed
    join paths and open ambiguities.
  </p>

  <p class="section-label">Pre-Work Already Underway</p>
  <div class="scope-box" style="margin-bottom:20px">
    <p>
      Ahead of formally kicking off Sprint 2, we&rsquo;re confirming feasibility across all five
      of these measures &mdash; not just Documentation Time, which is furthest along &mdash; by
      looking at what test queries against a live Epic instance actually return, and checking
      whether the underlying Clarity tables have been populated consistently since go-live
      (a gap there is a red flag, not an expected pattern). The goal is to catch weak-data risk
      now, so Sprint 2 isn&rsquo;t the first place we discover it.
    </p>
  </div>

  <p class="section-label">Proposed Next Stage &mdash; Sprint 2 / Phase Two</p>
  <ol class="proposal-list">
    <li>
      <h3>Confirm feasibility at a second site</h3>
      <p>
        Once the pre-work above gives us confidence in the primary Epic instance, extend the
        same validation to at least one additional Epic instance &mdash; e.g., the proposed
        proof-of-concept with the South Carolina team &mdash; to check whether the same Clarity
        tables and fields carry usable data outside a single implementation, before asking a
        partner site to run anything themselves.
      </p>
    </li>
    <li>
      <h3>Shop candidate algorithms to other health systems</h3>
      <p>
        Package one or more of these Epic-sourced measure specifications so additional health
        systems can evaluate feasibility against their own Epic instance &mdash; a narrow,
        low-effort ask (run a query, share what came back) rather than a full study commitment.
      </p>
    </li>
    <li>
      <h3>Work with Suki&rsquo;s technical team on a repeatable process</h3>
      <p>
        Collaborate with Suki&rsquo;s engineering team to turn the field-mapping-and-validation
        workflow into a documented, repeatable process &mdash; potentially built into Suki&rsquo;s
        own tooling &mdash; so new measures or new health systems can be onboarded without a
        bespoke one-off analysis each time.
      </p>
    </li>
    <li>
      <h3>Evaluate additional candidate measures</h3>
      <p>
        A few other canonical measures came up on the call as possibly having an Epic source but
        weren&rsquo;t confirmed &mdash; for example, Coding Accuracy (CM-21), where E/M visit-level
        and HCC diagnosis codes may or may not exist in Clarity. Worth a quick check alongside the
        Sprint 2 field-mapping work before deciding whether to expand this set.
      </p>
    </li>
  </ol>

  <p style="font-size:12px;color:var(--muted)">
    The full set of 25 draft canonical measures &mdash; including well-being, note-quality, and
    financial measures &mdash; remains an internal working document and is not part of this
    deliverable.
  </p>

</div>
"""

# ── Helpers (shared logic with build.py) ────────────────────────────────────

def anchor_id(filename):
    m = re.match(r"(CM-\d+)", filename, re.IGNORECASE)
    return m.group(1).lower() if m else re.sub(r"\.html$", "", filename).lower()


def extract_style(soup):
    tag = soup.find("style")
    return (tag.string or "") if tag else ""


def split_css_statements(css_text):
    statements = []
    depth = 0
    start = 0
    for i, ch in enumerate(css_text):
        if ch == "{":
            depth += 1
        elif ch == "}":
            depth -= 1
            if depth == 0:
                statements.append(css_text[start:i + 1])
                start = i + 1
    tail = css_text[start:].strip()
    if tail:
        statements.append(tail)
    return [s.strip() for s in statements if s.strip()]


def merge_css(soups, filenames):
    seen = set()
    merged = []
    for fname in filenames:
        for stmt in split_css_statements(extract_style(soups[fname])):
            key = re.sub(r"\s+", " ", stmt).strip()
            if key not in seen:
                seen.add(key)
                merged.append(stmt)
    return "\n".join(merged)


def extract_page_div(soup, filename):
    tag = soup.find("div", class_="page")
    if tag is None:
        print(f"  Warning: no <div class='page'> found in {filename}")
        return ""
    return str(tag)


def namespace_switcher_ids(soup, suffix):
    for panel in soup.select(".algo-panel[id]"):
        panel["id"] = f'{panel["id"]}-{suffix}'
    for tab in soup.select(".algo-tab[data-panel]"):
        tab["data-panel"] = f'{tab["data-panel"]}-{suffix}'
        if tab.get("aria-controls"):
            tab["aria-controls"] = f'{tab["aria-controls"]}-{suffix}'


def extract_switcher_script(soup):
    for tag in soup.find_all("script"):
        if tag.string and "algo-switcher" in tag.string:
            return tag.string
    return None


def build_nav(files):
    items = [
        '  <span class="cm-nav-logo">Epic Measures</span>',
        '  <a class="nav-item" href="#overview">'
        '<span class="nav-code">&#9673;</span>'
        '<span class="nav-name">Overview</span>'
        '</a>',
    ]
    for fname in files:
        aid = anchor_id(fname)
        code, name = EPIC_LABELS[fname]
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
    here = Path(__file__).parent

    found, missing = [], []
    for fname in EPIC_FILES:
        p = here / fname
        (found if p.exists() else missing).append((fname, p))

    for fname, _ in missing:
        print(f"  Missing: {fname}")
    if missing:
        print(f"\n{len(missing)} file(s) missing — fix before building.")
        sys.exit(1)

    soups = {}
    for fname, p in found:
        soups[fname] = BeautifulSoup(p.read_text(encoding="utf-8"), "html.parser")

    shared_css = merge_css(soups, [f for f, _ in found])

    nav_html = build_nav([f for f, _ in found])

    sections = [build_section(OVERVIEW_HTML.strip(), "overview")]
    switcher_script = None
    for fname, _ in found:
        namespace_switcher_ids(soups[fname], anchor_id(fname))
        page_html = extract_page_div(soups[fname], fname)
        if page_html:
            sections.append(build_section(page_html, anchor_id(fname)))
        if switcher_script is None:
            switcher_script = extract_switcher_script(soups[fname])
    sections_html = "\n\n".join(sections)

    switcher_script_html = (
        f"<script>\n{switcher_script}\n</script>\n" if switcher_script else ""
    )

    out_parts = [
        '<!doctype html>\n',
        '<html lang="en">\n',
        '<head>\n',
        '  <meta charset="utf-8">\n',
        '  <meta name="viewport" content="width=device-width, initial-scale=1">\n',
        '  <title>Suki Sprint 2 Proposal — Epic-Sourced Canonical Measures</title>\n',
        '  <style>\n',
        shared_css, '\n',
        SITE_CSS,
        '  </style>\n',
        '</head>\n',
        '<body>\n\n',
        '<nav class="cm-nav" aria-label="Epic-Sourced Canonical Measures">\n',
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
    print(f"  algo-switcher tab script: {'included' if switcher_script else 'NOT FOUND'}")
    print(f"  {len(sections)} sections (overview + {len(found)} measures):")
    for fname, p in found:
        print(f"  + {fname}  ({p.stat().st_size:,} bytes)")


if __name__ == "__main__":
    main()
