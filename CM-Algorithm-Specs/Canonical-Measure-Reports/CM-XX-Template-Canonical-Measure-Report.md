# CM-XX [Measure Name]
## Canonical Measure Report — Internal Draft

<!--
TEMPLATE NOTES (delete this comment block before finalizing a report)

- Replace CM-XX and [Measure Name] in the title above.
- "Measures covered" should name the primary measure and any closely related
  boundary/companion measures (with one-line distinctions), following the
  pattern used in CM-01, CM-09, and CM-17.
- "Prepared for" is optional — include only if the report was drafted ahead
  of a specific meeting or deliverable (see CM-09).
- Section order below reflects the common structure across existing reports.
  Not every section applies to every measure:
    - "Human Rating and LLM-as-Judge" applies to artifact-based measures
      (note text, transcripts) — see CM-09.
    - "Survey Instruments and Administration" applies to self-report/
      psychometric measures — see CM-01, CM-17.
    - A measure may need one, both, or neither; delete what doesn't apply.
    - The "structural gap" diagram section (e.g., "The Missing Feedback
      Loop," "The Baseline Problem") is the central narrative device of each
      report — identify the one structural gap that most limits this
      measure and name the section after it.
    - Additional bespoke sections (e.g., "The Multilingual Opportunity" in
      CM-17) are encouraged when a measure has a uniquely actionable angle
      that doesn't fit the standard sections.
- End every report with the standard footer line, updated for this measure's
  dimension and draft date.
-->

**Prepared for:** [optional — meeting/deliverable context, or delete this line]
**Measures covered:** CM-XX [Measure Name] (primary); CM-YY [Related Measure] (boundary/companion — one-line distinction)
**Status:** Internal draft for review and editing before sharing externally

---

## What This Measure Captures

**CM-XX [Measure Name]** is [one- to two-sentence definition of the construct, including the validated instrument(s) or data source(s) typically used to measure it].

It is distinct from related constructs:

| Construct | Canonical measure | What it captures |
|---|---|---|
| [Related construct A] | CM-YY — [Name] | [one-line distinction] |
| [Related construct B] | CM-ZZ — [Name] | [one-line distinction] |

**Why this matters for Suki's value story:** [Summarize the strength and direction of external evidence — cite specific studies with effect sizes, sample sizes, and study design (RCT vs. QI vs. self-report). Note any known biases (e.g., self-report inflation vs. RCT) and how this measure fits into Suki's broader value narrative.]

---

## Current Suki Hooks and Data Available

[One framing sentence: is this measure directly observable from Suki's API, or does it require external instruments (surveys) with Suki providing only cohort/exposure data? State which hooks (H#) are relevant.]

### What Suki exposes natively (H#, H#, ...)

| Artifact | API endpoint | What it enables |
|---|---|---|
| [Artifact name] | `GET /session/{id}/...` | [What this enables for this measure] |
| [Artifact name] | `GET /session/{id}/...` | [What this enables for this measure] |

### Measurement supported right now

- **[Capability name]** — [what can be computed today and how]
- **[Capability name]** — [what can be computed today and how]

---

## Missing or Aspirational Hooks

The following capabilities would substantially improve [measure] measurement but are not currently available as documented API endpoints.

| Missing capability | Why it matters |
|---|---|
| **[Capability]** | [Why this gap matters for this measure] |
| **[Capability]** | [Why this gap matters for this measure] |

---

## EHR-Side Data Needed

[One framing sentence on how central EHR data is to this measure — e.g., "essential to close the loop" vs. "minimal beyond cohort definition."]

| Data element | Purpose | Vendor examples / Notes |
|---|---|---|
| [Data element] | [Purpose] | [Epic/Cerner field name, or "Notes" if no vendor-specific mapping] |

[Optional closing paragraph: what can be done without this EHR data vs. what is permanently blocked without it.]

---

<!-- Include ONE or BOTH of the following two sections, depending on measure type. Delete whichever doesn't apply. -->

## Human Rating and LLM-as-Judge

<!-- Use for artifact-based measures (note content, transcripts, structured data) -->

### Validated instruments

- **[Instrument name]**: [description, original use case, what subscale/domain is relevant]
- **[Instrument name]**: [description, validation status for AI-generated content, e.g., LLM-as-judge correlation with human raters]

### Suggested evaluation design

**For a small, rapid pilot** using existing Suki sessions:

1. [Step — e.g., pull N session transcript/note pairs]
2. [Step — human rater scoring]
3. [Step — LLM-as-judge scoring]
4. [Step — agreement calibration]
5. [Step — scale-up criteria]

---

## Survey Instruments and Administration

<!-- Use for self-report/psychometric measures -->

### Validated instruments (in priority order)

- **[Instrument name]** — [item count, scale, what it captures, where it's been used in the corpus]
- **[Instrument name]** — [item count, scale, what it captures, where it's been used in the corpus]

### Suggested evaluation design

1. **Phase 0 (pre-deployment baseline):** [instrument administration timing]
2. **Phase 1–N (utilization tracking):** [cohort assignment approach]
3. **Follow-up:** [repeat measurement and comparison design]
4. **Reporting:** [how to present alongside objective/mechanism-level data, if available]

[Note on whether LLM-as-judge methods apply — typically "no" for self-report constructs with no artifact to evaluate.]

---

## The [Central Structural Gap Name]

<!-- Name this section after the single biggest structural gap limiting this
measure — e.g., "The Missing Feedback Loop" (CM-09), "The Baseline Problem"
(CM-01). This is the central narrative of the report. -->

This is the central structural gap for CM-XX[, analogous to [related gap in another report] but at a different point in the pipeline].

```
[ASCII diagram showing the pipeline: what Suki has → missing link → what's needed]
```

**What is achievable today:** [summary]

**What is missing:** [summary]

[Closing paragraph: what this means for how the measure can be reported in the interim — e.g., "can only be measured as X, not Y, until this is addressed."]

---

## Open Questions for Suki

These are specific data-access questions, not broad capability questions:

1. [Question about whether a specific data element/field exists or is retained]
2. [Question about whether an event/log is captured]
3. [Question about EHR-integration data access]
4. [Question about whether existing Suki data (e.g., source_transcripts, lang_id) can be repurposed for this measure, and any data-use constraints]
5. [Question about prior pilot data, benchmarks, or willingness to add a new lightweight signal]

---

*CM-XX [Measure Name] | Canonical Measures | [Dimension — e.g., Information Quality / Individual Impact / Organizational Impact] dimension*
*Internal draft — [Month Year]*
