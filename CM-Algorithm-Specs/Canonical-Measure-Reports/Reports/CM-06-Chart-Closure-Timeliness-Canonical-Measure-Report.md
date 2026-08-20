# CM-06 Chart Closure Timeliness
## Canonical Measure Report — Internal Draft

**Measures covered:** CM-06 Chart Closure Timeliness (primary); boundary with CM-04 (Documentation Time)
**Status:** Internal draft for review and editing before sharing externally

---

## What This Measure Captures

**CM-06 Chart Closure Timeliness** is whether and how quickly clinical notes are completed and *signed* — a documentation-completion-behavior measure, distinct from how long the note took to write. It is operationalized via several related metrics:

| Operationalization | What it captures |
|---|---|
| Same-day encounter closure rate (%) | Share of encounters whose note is signed on the same calendar day |
| Time to chart closure (hours) | Elapsed time from encounter end to note signature |
| 24-hour / CPT documentation deficiency rate | Share of notes still unsigned 24 hours after the encounter |
| Note completion before next patient | Whether the note for encounter *N* is signed before encounter *N+1* begins |
| Chart completion timing survey | Self-reported perception of how "caught up" a clinician feels on documentation |

Unlike CM-04 (Documentation Time), which measures *how long it takes to write* a note, CM-06 measures *whether and when the note gets finished and signed* — a clinician can write a note quickly but still leave it unsigned for days. This distinction is the basis for the **definitional ambiguities** below, which should be resolved before scoping any evaluation.

This is a **Tier 1 measure** (H1 deep-dive score 10/12) — among the highest data-access scores of any canonical measure, because Suki already produces session-level, encounter-anchored timestamps that map closely onto the closure-timing question.

---

## Definitional Ambiguities

These should be resolved up front, since they change both the formula and the EHR fields needed.

### Same-day vs. 24-hour window

"Same-day closure" is **calendar-bounded** — an encounter at 4:45 PM and a note signed at 7:00 AM the next day fails "same-day" despite being closed in under 15 hours. "Within 24 hours" is **duration-bounded** and does not penalize late-day visits for a clock-based artifact. The canonical measure definition explicitly recommends: *prefer the 24-hour window for pre/post evaluation, and document which convention a given site uses.*

**Implication for Suki:** if Suki reports a "same-day" rate using its own session timestamps, that rate will diverge from an EHR-reported "same-day" rate for reasons that have nothing to do with documentation behavior — purely because of when in the day the visit occurred. Any comparison across the two data sources needs the same windowing convention applied to both, and the 24-hour convention is the safer default.

### Overlap with CM-04 (Documentation Time)

CM-04 measures minutes-per-encounter spent documenting; CM-06 measures time-to-signature. These are correlated but not the same — a note can be drafted in 3 minutes (fast CM-04) and sit unsigned for 2 days (poor CM-06), or take 15 minutes to draft but be signed immediately (slow CM-04, perfect CM-06). The canonical measures corpus flags that the "time to chart" framing of CM-06 risks being read as a restatement of CM-04 and recommends the scope be held strictly to **completion/signature behavior**, not drafting duration. Any CM-06 report or evaluation should make this distinction explicit, since both measures will plausibly draw on the same underlying Suki session-timestamp data.

### The "Time to Close Encounter" literature flag

Pearlman 2025 reports a "Time to Close Encounter" outcome, but it is **not yet verified** whether this measures note *signature* (CM-06) or a broader workflow event such as patient discharge or room turnover. Until this is confirmed, Pearlman 2025 should be treated as a candidate benchmark for CM-06, not a confirmed one.

---

## Current Suki Hooks and Data Available

CM-06 has unusually strong data-access relative to other canonical measures, because Suki's own session lifecycle already produces an encounter-anchored timestamp sequence. The key limitation is that **Suki's "session complete" timestamp is a note-generation event, not a note-signature event** — the clinician still has to review and sign the note in the EHR after Suki produces it. Suki's native data can measure "time to a complete draft," which is a leading indicator of, but not identical to, "time to signature."

### What Suki exposes natively (H1, H9)

| Artifact | API endpoint | What it enables |
|---|---|---|
| Session creation / encounter-end timestamp | `GET /session/{id}/status` | Anchor point for "time since encounter ended" |
| Session completion timestamp (`status = completed`) | `GET /session/{id}/status` | Time from encounter end to note draft availability — a *leading proxy* for chart closure, not closure itself |
| Transcript timestamps | `GET /session/{id}/transcript` | Cross-check on encounter end time independent of EHR scheduling data |
| Session status distribution (`completed`/`skipped`/`failed`/`aborted`) | `GET /session/{id}/status` | Denominator hygiene — distinguishes "no note was ever drafted" from "note drafted but not yet signed" |

### Suki-side bucketed closure-rate fields (already defined in the CM crosswalk)

The Suki-EHR crosswalk already defines a bucketed structure for this exact measure, suggesting Suki or a partner has already modeled CM-06 as a distribution across closure-delay buckets rather than a single rate:

| Field | Meaning |
|---|---|
| `same_day_count` / `same_day_numerator` | Notes signed same calendar day as encounter |
| `next_day_count` / `next_day_numerator` | Notes signed the next calendar day |
| `two_three_day_count` / `two_three_day_numerator` | Notes signed 2–3 days after encounter |
| `four_five_day_count` / `four_five_day_numerator` | Notes signed 4–5 days after encounter |
| `six_plus_day_count` / `six_plus_day_numerator` | Notes signed 6+ days after encounter |

Plausible denominators for these buckets, also present in the crosswalk: `total_signed_notes` (associated with CM-13) and `total_encounters` / `total_closed_encounter_count` (associated with CM-22).

**Important caveat:** these bucket fields are *defined* in the crosswalk but their **source of truth is not yet confirmed** — see Open Questions below. If the "day signed" component comes from the EHR (i.e., Suki receives a signature-confirmation callback or EHR export), these fields directly answer the CM-06 question. If "day signed" is inferred from Suki's own session-completion timestamp, these fields measure draft-availability timing, not actual signature timing, and should be relabeled/reframed accordingly.

### Measurement supported right now

- **Draft-availability timing distribution** — using session-completion timestamps relative to encounter-end timestamps, Suki can already bucket encounters into same-day / next-day / 2-3 day / etc. for *draft availability*, mirroring the bucket structure above.
- **Denominator hygiene** — `completed` vs. `skipped`/`failed`/`aborted` status lets the closure-rate denominator be defined correctly (e.g., excluding encounters where no Suki draft was ever produced, vs. counting them as "never closed").
- **Cohort definition** — heavy/moderate/light utilization tiers, as in CM-01/02/03, for dose-response comparisons against EHR-confirmed closure rates.

---

## Missing or Aspirational Hooks

| Missing capability | Why it matters |
|---|---|
| **EHR signature-confirmation callback or export** | The single biggest gap: Suki's "completed" event is draft-ready, not signed. Without a signal for the actual signature event, CM-06 cannot be measured end-to-end from Suki data alone. |
| **Encounter-sequence linkage ("next patient")** | The "note completion before next patient" operationalization requires knowing the start time of the *next* encounter for the same provider — Suki has no native concept of a provider's daily schedule sequence. |
| **Provider schedule / scheduled-encounter sequence** | Same as above — needed to compute "before next patient" without EHR schedule data. |
| **Confirmation of `same_day_count`/`next_day_count` etc. source-of-truth** | As noted above, these fields may already solve CM-06 if their "day signed" component is EHR-sourced — this needs to be confirmed before treating them as a ready-made answer. |

---

## EHR-Side Data Needed

| Data element | Purpose | Vendor examples |
|---|---|---|
| Note signature timestamp | The ground-truth event CM-06 measures — when the note moved from draft to signed/final | Epic: `HNO_NOTE` signature instant field; Cerner/Athena: equivalent note-status/signature-event field |
| Encounter end timestamp (EHR-side) | Cross-check / alternative anchor to Suki's own encounter-end timestamp, useful where Suki and EHR scheduling data diverge | Standard encounter/appointment record |
| Provider's daily encounter sequence (schedule) | Required for the "before next patient" operationalization | EHR scheduling export |
| Note status transitions (draft → pended → signed) | Distinguishes "never closed" from "closed late" — needed for accurate 24-hour deficiency rates | EHR audit log / note status history |

Without EHR signature timestamps, every Suki-native "closure" metric is actually a **draft-availability** metric — a meaningful and likely strongly-correlated proxy, but not the canonical measure itself. This should be stated explicitly in any external-facing report using Suki-only data for CM-06.

---

## Benchmark Evidence

- **Boyter 2025 / KLAS (UAL-based)** — reported a **41% reduction in chart closure time** following ambient documentation deployment, measured via EHR user-activity-log (UAL) data — i.e., using the EHR-side signature/closure event, not a vendor's self-reported session data.
- **FMOL** — reported an **84% improvement in the share of notes closed within 7 days** of the encounter, a coarser (weekly-bucket) version of the same closure-timing concept.

Both benchmarks rely on EHR-side closure events, reinforcing that the strongest available evidence for this measure comes from audit-log/UAL data rather than vendor session data — useful context for what a credible Suki-side evaluation would need to match.

---

## Open Questions for Suki

1. For the `same_day_count` / `next_day_count` / etc. fields already defined in the Suki-EHR crosswalk: is the "day signed" component derived from an EHR signature-confirmation signal, or from Suki's own session-completion timestamp? This determines whether these fields already answer CM-06 or whether they measure draft-availability instead.
2. Does Suki receive any callback, webhook, or export from integrated EHRs indicating when a Suki-generated note is actually signed/finalized by the clinician — separate from Suki's own `status = completed` event?
3. Is provider daily-schedule/encounter-sequence data available to Suki (e.g., via the EHR integration) that could support the "note completed before next patient" operationalization without a separate EHR data pull?
4. Can Pearlman 2025's "Time to Close Encounter" outcome definition be clarified — does it measure note signature specifically, or a broader workflow event (e.g., room turnover, discharge)? This affects whether it can be cited as a CM-06 benchmark.
5. For sites already reporting `total_signed_notes` (CM-13) and `total_closed_encounter_count` (CM-22) figures, can these be cross-tabulated by closure-delay bucket to validate the bucket fields above against a known EHR-confirmed baseline?

---

*CM-06 Chart Closure Timeliness | Canonical Measures | Documentation Efficiency dimension*
*Internal draft — June 2026*
