# CM-10 Note Quality Overall
## Canonical Measure Report — Internal Draft

**Measures covered:** CM-10 Note Quality Overall (primary); CM-08 Note Completeness (component — Thoroughness domain) and CM-09 Note Inaccuracy Rate (component — Accuracy domain)
**Status:** Internal draft for review and editing before sharing externally

---

## What This Measure Captures

**CM-10 Note Quality Overall** is the aggregate quality rating of an AI-generated clinical note using a validated multi-dimensional instrument — most commonly the PDQI-9/PDSQI-9 composite (which assesses Accuracy, Thoroughness, Usefulness, Organization, Comprehensibility, Succinctness, Synthesis, and Consistency as a single score), the SAIL score, or a single-item global quality rating.

It is not an independent construct so much as a **rollup**:

| Component | Canonical measure | Relationship to CM-10 |
|---|---|---|
| Accuracy domain | CM-09 — Note Inaccuracy Rate | One of the nine PDQI-9/PDSQI-9 domains summed into the CM-10 composite |
| Thoroughness domain | CM-08 — Note Completeness | One of the nine PDQI-9/PDSQI-9 domains summed into the CM-10 composite |
| Usefulness, Organization, Comprehensibility, Succinctness, Synthesis, Consistency | *(not independently canonicalized)* | Captured only through the CM-10 composite |

**Why this matters for Suki's value story:** PDQI-9 was originally designed for human-authored notes and has since been adapted and validated for AI-generated content — Afshar 2025b's LLM-as-judge implementation of PDSQI-9 correlates well enough with physician ratings for research-grade automated scoring, and reports scores of 3.97–4.99/5.0, the highest composite ratings in the corpus. But raw composite numbers need an anchor to be meaningful: Kernberg 2023 reports approximate scale bands of 26.2 ≈ "terrible or bad" and 36.6 ≈ "good or excellent" on a comparable scale, with their own study mean (29.7) landing closer to "terrible" — a useful caution against reporting a bare composite number without calibration context.

---

## Current Suki Hooks and Data Available

CM-10 uses exactly the same Suki-native artifacts as CM-08 and CM-09, because it is scored from the same transcript/note pairs by the same rater pipeline — it simply asks raters to score all nine PDQI-9/PDSQI-9 domains instead of one.

### What Suki exposes natively (H1 + H15)

| Artifact | API endpoint | What it enables |
|---|---|---|
| Full transcript | `GET /session/{id}/transcript` | Ground truth of what was said; basis for rater review across all 9 domains |
| Note content with evidence links | `GET /session/{id}/content` | `source_transcripts[]` supports evidence-based rating for every domain, not just Accuracy/Thoroughness |
| Structured diagnoses | `GET /session/{id}/structured-data` | Supplementary context raters can use for Synthesis / Organization judgments |

### Measurement supported right now

- **Composite rating pipeline** — the same transcript/note pairs pulled for CM-08/CM-09 pilots can be scored on all 9 PDQI-9/PDSQI-9 domains in a single pass, at no additional data-collection cost
- **Nothing computed natively** — unlike CM-11's automated text metrics, CM-10's composite requires human or LLM-judge rating; there is no automated proxy for the six non-CM-08/CM-09 domains

---

## Missing or Aspirational Hooks

| Missing capability | Why it matters |
|---|---|
| **Physician-edited note** (post-accept, pre-sign) | Would allow scoring the composite against the clinician's true final note, not just the transcript |
| **Edit diff / change log** | Which domains the physician's edits touched (accuracy fixes vs. trims for succinctness vs. reorganization) would let the composite be decomposed automatically |
| **Structured rating storage** | If Suki hosted pilot rating results alongside session data, composite trends could be tracked in the same dashboard as utilization data |

---

## EHR-Side Data Needed

| Data element | Purpose | Vendor examples |
|---|---|---|
| Final signed note text | Gold standard to diff against Suki draft | Epic `HNO_NOTE_TEXT`; Cerner `clinical_event.RESULT_VAL` |
| Note version history / edit audit trail | Reconstructs physician edits, which domains they touched | Epic NoteActivity; EHR audit log table |
| Encounter-to-note linkage | Joins Suki `session_id` to EHR note record | EHR encounter ID, MRN, or CSN |

As with CM-08/CM-09, this data is not strictly required to run a pilot (which can be scored against the transcript), but is required to move from one-off rater exercises to a continuously monitored composite.

---

## Human Rating and LLM-as-Judge

### Validated instruments

- **PDQI-9** (Physician Documentation Quality Instrument): 9-item, 5-point Likert, max 45; originally for human notes; the standard composite reference instrument in this literature.
- **PDSQI-9** (Provider Documentation Summarization QI): AI-note-adapted version. Afshar 2025b validated an LLM-as-judge implementation against physician ratings — the strongest evidence in the corpus that automated composite scoring is feasible at scale.
- **SAIL Score**: a separate standards-based composite instrument, not numerically equivalent to PDQI-9/PDSQI-9 — collect and report on its own track if used.

### Suggested evaluation design

**Run in the same pilot wave as CM-08 and CM-09**, since all three share the same sample and rater pool:

1. Pull 50–100 completed session transcript/note pairs using the `source_transcripts[]` payload.
2. Ask 2–3 physician raters to score all 9 PDQI-9/PDSQI-9 domains per note (not just Accuracy and Thoroughness).
3. Run an LLM-as-judge prompt using the same 9-domain rubric on the same pairs.
4. Compute human-LLM agreement — overall composite and per domain.
5. If LLM agreement is acceptable (r ≥ 0.7), scale automated composite scoring to the full session corpus. Report the composite mean *and* all nine per-domain means; never report the composite alone.

---

## The Composite Overlap Problem

Unlike CM-09's Missing Feedback Loop or CM-08's transcript-only reference, CM-10's central structural issue is not a data gap — it's definitional. Two of its nine input domains are already independently tracked as their own canonical measures (CM-08, CM-09), and the corpus's own Key Note flags this directly: *"The PDQI is a composite, see CM-08 and CM-09 for component error types."*

```
CM-10 Composite (9 domains, PDQI-9/PDSQI-9)
  ├── Accuracy domain            ──► reported independently as CM-09
  ├── Thoroughness domain        ──► reported independently as CM-08
  └── 6 other domains            ──► reported only within CM-10
      (Usefulness, Organization, Comprehensibility,
       Succinctness, Synthesis, Consistency)
```

**What is achievable today:** a full 9-domain composite score, using the same pilot design already proposed for CM-08/CM-09, at essentially no marginal data-collection cost.

**What is unresolved:** whether CM-10 should be reported as a *fourth* measure alongside CM-08/CM-09, given ~22% of its inputs (2 of 9 domains) duplicate those measures, or whether it should be trimmed to report only the six non-overlapping domains, with the full composite reserved for cases where a single top-line quality number is specifically requested (e.g., executive reporting). This is a scope/deduplication decision for the measure set, not a data-availability gap, and is listed as an open question below rather than resolved in the algorithm itself.

---

## Open Questions for Suki

These are specific data-access questions, not broad capability questions:

1. Should CM-10 be reported as a standalone composite alongside CM-08/CM-09, or trimmed/merged given the domain overlap — and if trimmed, should it report only the six non-CM-08/CM-09 domains?
2. Does Suki have internal quality-scoring pilots or benchmarks (PDQI-9, PDSQI-9, SAIL, or otherwise) already run against Suki-generated notes that could anchor the composite's scale interpretation?
3. Can the same rating pipeline proposed for CM-08/CM-09 be extended to all 9 PDQI-9/PDSQI-9 domains in one pass, or are there cost/rater-burden constraints that would require scoring domains separately?
4. If a SAIL score or other alternate composite is of interest, does Suki have a preference for which instrument becomes the primary CM-10 reporting standard?
5. Are there pilot customers where composite quality ratings have already been collected (internally or via a partner) that could seed the calibration sample?

---

*CM-10 Note Quality Overall | Canonical Measures | Information Quality dimension*
*Internal draft — July 2026*
