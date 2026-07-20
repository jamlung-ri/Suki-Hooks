# CM-12 Automated NLP Evaluation Metrics
## Canonical Measure Report — Internal Draft

**Measures covered:** CM-12 Automated NLP Evaluation Metrics (primary — methodological); CM-08, CM-09, CM-10 (the measures this one validates, not a component or companion relationship)
**Status:** Internal draft for review and editing before sharing externally

---

## What This Measure Captures

**CM-12 Automated NLP Evaluation Metrics** is explicitly flagged in the underlying corpus as a **METHODOLOGICAL MEASURE**: computational similarity metrics — n-gram overlap (ROUGE), semantic similarity (BERTScore/BLEURT), and entity-level or token-level accuracy metrics (F1) — used to evaluate AI-generated notes against a reference standard. It is not a clinical outcome measure. It measures whether an *automated evaluation approach* is technically valid, i.e., whether it agrees closely enough with human judgment to be trusted as a scaling signal.

This distinguishes CM-12 sharply from CM-08, CM-09, and CM-10, which measure properties of Suki's notes themselves:

| Measure | What it measures |
|---|---|
| CM-08 / CM-09 / CM-10 | Properties of the AI-generated note (completeness, accuracy, overall quality) |
| CM-12 | Whether the *tool used to measure* CM-08/09/10 at scale can be trusted |

**Why this matters for Suki's value story:** CM-12 does not belong in a documentation-quality trend narrative at all — reporting "our ROUGE score went up" says nothing about whether Suki's notes got better; it says the evaluation tool got better at (or worse at) approximating what physician raters already said. The most load-bearing finding in this domain is a cautionary one: Moramarco 2022 found that a naive Levenshtein (edit) distance baseline performs as well as BERTScore on clinical notes, which argues against reflexively adopting expensive embedding-based metrics without benchmarking them against a cheap baseline first. Afshar 2025b's LLM-as-judge validation (used across CM-08/09/10) is the strongest evidence in the corpus that an automated evaluator *can* be trusted — but that trust has to be established per-instrument and per-domain, which is exactly what CM-12's algorithm does.

---

## Current Suki Hooks and Data Available

CM-12 does not require any new Suki-native data collection — it reuses the note text and pilot outputs already needed for CM-08/09/10.

### What Suki exposes natively (H1)

| Artifact | API endpoint | What it enables |
|---|---|---|
| Generated note content | `GET /session/{id}/content` | The AI-note side of every metric computation |
| Full transcript | `GET /session/{id}/transcript` | Alternate reference text when no physician-authored note exists for a pair |

### Measurement supported right now

- **Metric computation** — ROUGE/BERTScore/F1/Levenshtein can all be computed on Suki note text today, entirely outside Suki's platform, using standard open-source NLP tooling
- **Nothing scored natively by Suki** — Suki does not compute or expose any of these metrics itself; this is fully an external evaluation-pipeline activity

---

## Missing or Aspirational Hooks

| Missing capability | Why it matters |
|---|---|
| **Final signed note text** | Preferred reference source for computing metrics against the clinician's true final intent, closing the same Missing Feedback Loop as CM-08/CM-09 |
| **Structured pilot-result storage** | If CM-08/09/10 pilot outputs (human/LLM-judge scores) were stored in a queryable format, CM-12's correlation step could be automated rather than run as a manual analysis each time |

---

## EHR-Side Data Needed

| Data element | Purpose | Vendor examples / Notes |
|---|---|---|
| Reference note (physician-authored or trusted comparison note) | The comparison text every candidate metric is computed against | Same reference-availability constraint as CM-11 |
| Final signed note text | Preferred reference source once available | Epic `HNO_NOTE_TEXT`; Cerner `clinical_event.RESULT_VAL` |
| Encounter-to-note linkage | Joins Suki `session_id` to EHR note record | EHR encounter ID, MRN, or CSN |

CM-12 can run entirely on transcript-based references without any EHR data — the EHR-side note text simply makes the reference standard more meaningful (the clinician's final note rather than the transcript), the same distinction that runs through CM-08 and CM-09.

---

## Human Rating and LLM-as-Judge

<!-- CM-12 is unusual: it doesn't generate new human ratings, it validates against ratings already collected for CM-08/09/10. -->

### Validated instruments

- **PDQI-9 / PDSQI-9 human and LLM-judge scores** (from the CM-08/09/10 pilot): the ground truth CM-12 correlates automated metrics against. CM-12 does not run its own rating pilot — it is entirely downstream of CM-08/09/10.
- **Candidate automated metrics**: Levenshtein distance, ROUGE-1/2/L, BERTScore, BLEURT, token-level F1, entity-linking accuracy. None of these is independently "validated" for clinical note evaluation in the way PDQI-9/PDSQI-9 is — validating them against human ratings is exactly what this measure does.

### Suggested evaluation design

**Run once the CM-08/09/10 pilot has produced a calibration sample with human and LLM-judge scores:**

1. Reuse the CM-08/09/10 pilot's note/reference pairs and their human/LLM-judge composite scores — do not collect a new sample.
2. Compute each candidate automated metric (start with Levenshtein and ROUGE-L as cheap baselines, then BERTScore) on the same pairs.
3. Correlate each candidate metric against the human/LLM-judge composite score.
4. Approve any metric clearing a locally-calibrated agreement threshold as a scaling/screening signal for future CM-08/09/10 rounds.
5. Re-run this calibration whenever the note-generation model version changes or the CM-08/09/10 sample is refreshed — not on a recurring monitoring cadence.

---

## Not a Longitudinal Measure — The Calibration-vs-Outcome Distinction

The central structural point for CM-12 is not a data gap, and it is not an ambiguous direction like CM-11 — it is a **category mismatch** if this measure is treated like the other three. CM-08, CM-09, CM-10, and CM-11 all have a meaningful "before Suki / after Suki" or "over time" reading. CM-12 does not.

```
CM-08 / CM-09 / CM-10 / CM-11:  measured on Suki's notes  ──►  tracked over time, pre/post adoption
CM-12:                          measures the EVALUATOR itself ──►  one-time or periodic recalibration,
                                                                    triggered by model-version changes,
                                                                    not tracked as a trend
```

**What is achievable today:** a defensible answer to "can we trust automated scoring to scale CM-08/09/10 beyond a manual rating sample?" — using data and pilot outputs Suki/the evaluation team will already have collected.

**What this means for reporting:** CM-12 should never appear on the same trend dashboard as CM-08/09/10/11 with a "before/after" framing. It should be reported as a one-time (or periodically refreshed) validity finding — e.g., "BERTScore correlates at r = 0.78 with our human/LLM-judge composite; approved as a scaling signal as of [date]; last recalibrated when model version X shipped." Presenting it as a rising or falling trend line would misrepresent what it is measuring.

---

## Open Questions for Suki

These are specific data-access questions, not broad capability questions:

1. Does Suki have any existing internal use of ROUGE/BERTScore/F1-style automated metrics in its own model evaluation process that could be reused or compared against here?
2. Would Suki be willing to flag note-generation model version changes to the evaluation team, so CM-12's calibration can be re-run at the right cadence rather than silently going stale?
3. Are there existing physician-authored reference notes (from simulation, RCT, or pilot customer data) that Suki has access to and could make available for a CM-12 calibration sample?
4. Is there interest from Suki's side in adopting an approved automated metric (once validated) as a pre-screening signal ahead of the CM-08/09/10 rating pipeline, to reduce rater burden?
5. Should CM-12's calibration results be treated as internal-only (evaluation-team tooling) or included in external-facing materials as evidence of measurement rigor?

---

*CM-12 Automated NLP Evaluation Metrics | Canonical Measures | Information Quality dimension*
*Internal draft — July 2026*
