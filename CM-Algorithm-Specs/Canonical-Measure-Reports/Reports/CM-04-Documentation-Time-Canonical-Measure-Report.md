# CM-04 Documentation Time
## Canonical Measure Report — Internal Draft

**Measures covered:** CM-04 Documentation Time (primary); boundary with CM-05 (After-Hours Documentation), CM-06 (Chart Closure Timeliness), and CM-07 (Total EHR Time)
**Status:** Internal draft for review and editing before sharing externally — see the existing [CM-04 Algorithm Card](../CM-04-Documentation-Time.html) for the dashboard formula and pseudocode

---

## What This Measure Captures

**CM-04 Documentation Time** is clinician time spent creating, editing, and finalizing a clinical note, from note initiation to signature (including post-signature addenda), expressed as minutes per encounter. It is the **most frequently measured efficiency outcome in the entire corpus** (31 papers).

It is distinct from three adjacent constructs that are easy to conflate:

| Construct | Canonical measure | What it captures |
|---|---|---|
| In-clinic note authoring time | CM-04 — Documentation Time | Minutes per encounter spent writing/editing/signing the note |
| After-hours documentation | CM-05 — After-Hours Documentation | The subset of EHR time occurring outside scheduled hours ("pajama time") |
| Whether/when the note gets signed | CM-06 — Chart Closure Timeliness | Completion *behavior*, not duration |
| All EHR activity (notes + inbox + orders + review) | CM-07 — Total EHR Time | A superset that includes CM-04 plus non-documentation EHR tasks |

**Why this matters for Suki's value story:** CM-04 has the **widest reported effect-size range of any measure in the corpus** — from −12% (EHR telemetry: Ma 2025, Guo 2026) to −72% (self-report: AAFP 2021). The corpus's explicit guidance is that **self-report systematically overstates reductions by 3–6× relative to EHR audit-log telemetry**, and that per-note vs. per-day units are not interchangeable. This makes CM-04 simultaneously the easiest measure to get *a* number for and the easiest to get a *misleading* number for — methodological discipline (objective telemetry, consistent units, ramp-period exclusion) matters more here than for almost any other measure.

---

## Current Suki Hooks and Data Available

CM-04 is the measure with the most mature existing treatment in this card set — the [algorithm card](../CM-04-Documentation-Time.html) already defines the dashboard formula (cohort-average documentation minutes per encounter, pre/post Suki adoption, excluding the onboarding ramp). This report focuses on the data-access picture behind that formula.

### What Suki exposes natively (H1)

| Artifact | API endpoint | What it enables |
|---|---|---|
| Session start/end timestamps | `GET /session/{id}/transcript` (or status) | Per-session duration — the **fallback** data source named in the algorithm card when EHR telemetry is unavailable |
| Session completion timestamp + adoption date | `GET /session/{id}/status` (aggregated) | Defines each provider's pre/post-adoption boundary — **Suki's primary contribution** to the CM-04 formula regardless of which duration data source is used |
| Session status (`completed`/`skipped`/`failed`) | `GET /session/{id}/status` | Active-provider/active-usage flag for the cohort-average denominator |

### Measurement supported right now

- **Adoption-date and active-usage cohort definition** — Suki-native data fully answers the "who counts, and from when" questions in the algorithm card's formula, independent of which duration source is used.
- **Fallback duration proxy** — Suki session duration can stand in for documentation time where EHR telemetry is unavailable, with the explicit caveat (already in the algorithm card's "Suki Data Scope" box) that it captures **in-app time only**.

---

## Missing or Aspirational Hooks

| Missing capability | Why it matters |
|---|---|
| **Post-session EHR editing/signing time** | Suki's session duration ends when the dictation/ambient capture session ends — any further note editing or signing inside the EHR is invisible to Suki. This is the gap that makes the Suki-native fallback systematically *understate* true documentation time relative to EHR telemetry. |
| **Per-session note-section edit tracking** | Knowing how much of a generated note was edited post-session (vs. accepted as-is) would let Suki distinguish "fast because little editing needed" from "fast in-app but followed by long EHR editing" — directly relevant to interpreting a low session-duration number correctly. |

---

## EHR-Side Data Needed

EHR audit-log telemetry is the **preferred, gold-standard** data source per the algorithm card — this section summarizes why and what's needed.

| Data element | Purpose | Vendor examples / Notes |
|---|---|---|
| `avg_doc_time_min` (per provider, per encounter) | The primary data source for the CM-04 formula | Epic Signal / UAL `avg_doc_time_min`; Cerner equivalent. **Confirm field scope** — some EHR telemetry fields bundle inbox/order-entry time with note time, which would overlap with CM-07 |
| Encounters by month (per provider) | Denominator for per-encounter normalization | EHR encounter export, limited to eligible types/settings |
| Provider ID crosswalk | Joins EHR audit records to Suki session records | Must be reconciled between systems before analysis |

**Without EHR telemetry**, CM-04 can still be reported using Suki session duration alone, but it should be explicitly labeled as an **in-app time proxy**, not full documentation time — the algorithm card's "Suki Data Scope" box already states this, and any report using Suki-only data should repeat the caveat rather than presenting the number as equivalent to an EHR-telemetry figure.

---

## The In-App vs. Full-Lifecycle Gap

This is the central structural gap for CM-04 — distinct from, but related to, CM-06's "draft-availability vs. signature" gap.

```
Encounter starts ──► Suki session (dictation/ambient capture) ──► Session ends (Suki "completed")
                                                                          │
                                                                  [missing link]
                                                            Note review, editing,
                                                            and signing inside the EHR
                                                                          │
                                                                          ▼
                                              Note signed (true end of "documentation time")
```

**What is achievable today:** Suki session duration measures the first segment of this pipeline — the ambient-capture/dictation portion — accurately and natively.

**What is missing:** Any visibility into the second segment (post-session EHR review/edit/sign), which is exactly where EHR audit-log telemetry's "documentation time" figure includes time that Suki cannot see.

**Implication for reporting:** a Suki-only CM-04 figure is best framed as **"in-app authoring time"**, a leading component of documentation time, not the full measure. If a site's EHR telemetry shows a smaller improvement than Suki's session-duration trend suggests, the gap above — not measurement error — is the most likely explanation, and is also the same gap underlying CM-06's distinction between draft-availability and signature timing.

---

## Open Questions for Suki

1. Is Suki session duration measured strictly as ambient-capture/dictation time, or does it include any time the clinician spends reviewing/editing the generated note within the Suki interface itself (as opposed to within the EHR)?
2. Does Suki have visibility into post-session note edits made *within the EHR* via any integration channel (e.g., a callback when the note is finalized/signed)?
3. For sites where both EHR telemetry (`avg_doc_time_min`) and Suki session duration are available for the same encounters, has any internal comparison been done to quantify the typical gap between the two — i.e., how much "invisible" post-session EHR time there tends to be?
4. Can the onboarding-ramp exclusion (default 30 days, per the algorithm card) be operationalized directly from Suki's adoption-date field, or does it require a separately-defined ramp-period parameter per site?
5. Does Suki retain per-session note-edit metadata (e.g., percentage of generated note text retained vs. edited) that could serve as a secondary signal for "how much work remained after the Suki session ended"?

---

*CM-04 Documentation Time | Canonical Measures | Individual Impact dimension*
*Internal draft — June 2026*
