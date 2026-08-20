# CM-07 Total EHR Time
## Canonical Measure Report — Internal Draft

**Measures covered:** CM-07 Total EHR Time (primary); boundary with CM-04 (Documentation Time) and CM-05 (After-Hours Documentation)
**Status:** Internal draft for review and editing before sharing externally — see the existing [CM-07 Algorithm Card](../CM-07-Total-EHR-Time.html) for the dashboard formula and pseudocode

---

## What This Measure Captures

**CM-07 Total EHR Time** is clinician time spent in the EHR across *all* tasks — note-writing, inbox management, order entry, results review, messaging — normalized per scheduled workday or per encounter. It is the **broadest efficiency indicator in the canonical measure suite**: CM-04 (Documentation Time) and CM-05 (After-Hours Documentation) are both subsets of CM-07, scoped respectively to note-writing only and to the after-hours time window.

| Construct | Canonical measure | Scope |
|---|---|---|
| Note-writing time only | CM-04 — Documentation Time | Subset: documentation tasks |
| After-hours subset of EHR time | CM-05 — After-Hours Documentation | Subset: time window (any task type) |
| All EHR activity, all hours | CM-07 — Total EHR Time | The superset |

**Why this matters for Suki's value story:** CM-07 is an **emerging measure — only 5 papers measure it explicitly** — but it contains the single most interesting cross-measure finding in the corpus: **Ma 2025 found a −19.95 min/day reduction in total EHR time, nearly 3× the −6.89 min/day reduction in documentation time alone, in the same cohort.** The interpretation offered is that ambient scribes reduce EHR burden *beyond* note-writing — possibly by enabling faster note closure and less need to revisit the chart. If this finding replicates, **CM-07 could be a more sensitive outcome than CM-04** despite being less studied — but as detailed below, the *part of the effect that makes CM-07 larger than CM-04* is precisely the part Suki cannot observe.

---

## Current Suki Hooks and Data Available

### What Suki exposes natively (H1)

| Artifact | API endpoint | What it enables |
|---|---|---|
| Session timestamps | `GET /session/{id}/transcript` / status | Same in-app duration signal as CM-04's fallback — a **partial proxy for the documentation component only** |
| Session creation logs / adoption date | `GET /session/{id}/status` (aggregated) | Pre/post adoption boundary and active-usage flag for the cohort-average denominator, per the algorithm card's formula |

### Measurement supported right now

- **Adoption-date and active-usage cohort definition** — same role as in CM-04/CM-05.
- **Documentation-component proxy only.** Per the algorithm card's "Suki Data Scope" box: **"Suki provides a partial proxy for the documentation component of total EHR time, but cannot observe inbox activity, order entry, or results review."** Session duration reflects in-app documentation time only — the majority of total EHR time occurs entirely within the EHR and is invisible to Suki.

---

## Missing or Aspirational Hooks

| Missing capability | Why it matters |
|---|---|
| **Any visibility into non-documentation EHR activity (inbox, orders, results review, chart navigation)** | This is the majority of CM-07 by definition, and — per the Ma 2025 finding — plausibly the *larger* component of any Suki-attributable effect. As with CM-05, this is a structural limit on Suki-native data, not a near-term hook gap. |
| **Session-to-encounter linkage with EHR "return visits"** | The Ma 2025 hypothesis (less need to revisit the chart after ambient documentation) could in principle be tested if Suki could see whether a provider re-opened the EHR record for an encounter after the Suki session closed — but this would require EHR-side instrumentation, not a Suki API addition |

---

## EHR-Side Data Needed

CM-07 is **entirely EHR-telemetry-dependent** for its primary signal — Suki's role is limited to cohort/adoption-date definition, same as CM-05.

| Data element | Purpose | Vendor examples / Notes |
|---|---|---|
| `avg_total_time_min` (per provider, per encounter) | The primary data element — total EHR activity across all task types | Epic `avg_total_time_min`; Cerner telemetry varies by version. **Confirm whether the field includes inbox/orders or documentation only** — same scope-confirmation issue flagged for CM-04 |
| `business_hours_min` / `after_hours_min` (per provider, per month) | Splits in-hours vs. after-hours components — the after-hours split overlaps directly with CM-05 | Epic `business_hours_min`/`after_hours_min`; Athena `business_hours_numerator` |
| Total inbox time per provider/month (hrs) | One of the named non-documentation components of CM-07 | EHR inbox-time telemetry field |
| Suki adoption date + active usage flag | Pre/post boundary and cohort denominator | Suki-native, as in CM-04/CM-05 |

**Field-scope confirmation is doubly important here**: the same EHR field name might mean "documentation only" at one site and "all EHR activity" at another. Given that CM-04, CM-05, and CM-07 all draw on overlapping EHR telemetry fields, a single upfront field-mapping exercise per site would resolve the scope ambiguity for all three measures at once.

---

## The Spillover Question

This is the central structural issue for CM-07 — and it is the inverse of CM-04's "in-app vs. full-lifecycle" gap: for CM-04, Suki sees *too little* of the documentation-time picture; for CM-07, Suki sees an even *smaller fraction* of a *larger* picture, and the part it's missing is where the most interesting effect (per Ma 2025) may live.

```
Suki-visible: in-app documentation/ambient-capture time  ──►  ~CM-04 fallback proxy
                            │
                            │   (Ma 2025: documentation-time effect = −6.89 min/day)
                            ▼
Total EHR time (CM-07) = documentation + inbox + orders + results review + chart re-review
                            │
                            │   (Ma 2025: total-EHR-time effect = −19.95 min/day — ~3× larger)
                            ▼
                  [missing link] — the ~13 min/day "spillover" effect is entirely
                  in EHR activity Suki cannot observe (inbox, orders, re-review)
```

**What is achievable today:** Suki can report the documentation-component proxy (its CM-04 fallback signal) and, separately, cohort/adoption-date definitions that any EHR-telemetry-based CM-07 analysis would need.

**What is missing:** Any way to attribute the larger "spillover" portion of a CM-07 effect to a specific mechanism. If a site reports a large CM-07 reduction alongside a smaller CM-04 reduction (replicating the Ma 2025 pattern), Suki's data cannot explain *why* — that explanation would require EHR-side analysis of which non-documentation EHR tasks changed (e.g., fewer inbox messages because notes are clearer, fewer chart re-opens because notes are complete on first pass).

**Implication for reporting:** CM-07 should be reported as an EHR-telemetry measure with Suki providing only the adoption-boundary/cohort scaffolding — the same framing as CM-05, but with the added note that CM-07's *most interesting feature* (a possible spillover effect larger than CM-04 alone) is also the part of the measure Suki is least equipped to explain.

---

## Open Questions for Suki

1. Given the field-scope ambiguity shared across CM-04/CM-05/CM-07 (does `avg_total_time_min`-style fields include or exclude documentation), would a single combined EHR field-mapping request covering all three measures be more efficient than three separate asks?
2. Does Suki have any visibility — even indirect — into whether a provider returns to the EHR record for an encounter after a Suki session closes (e.g., via a subsequent session linked to the same encounter)? This would be the most direct Suki-native signal relevant to the Ma 2025 "less chart re-review" hypothesis.
3. For sites already reporting CM-04 (documentation time) results, is total EHR time (CM-07) also available from the same EHR telemetry export, making it a low-marginal-cost addition to existing analyses?
4. Since CM-07 is described as an "emerging measure" with only 5 papers, is there interest from Suki's research team in prioritizing CM-07 alongside CM-04 in future evaluations specifically to test whether the Ma 2025 spillover finding replicates?
5. Does Suki retain any data on inbox-message volume or content (e.g., if Suki-generated notes reduce downstream clarifying-question messages from other care team members) that could serve as an indirect signal for the inbox-time component of CM-07?

---

*CM-07 Total EHR Time | Canonical Measures | Individual Impact dimension*
*Internal draft — June 2026*
