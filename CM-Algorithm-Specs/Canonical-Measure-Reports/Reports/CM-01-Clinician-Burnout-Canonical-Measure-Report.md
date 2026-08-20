# CM-01 Clinician Burnout and Exhaustion
## Canonical Measure Report — Internal Draft

**Measures covered:** CM-01 Clinician Burnout and Exhaustion (primary); CM-02 Cognitive and Task Load and CM-03 Professional Fulfillment (boundary measures, covered separately)
**Status:** Internal draft for review and editing before sharing externally

---

## What This Measure Captures

**CM-01 Clinician Burnout and Exhaustion** is provider-reported emotional exhaustion, depersonalization, and interpersonal disengagement from clinical work — the core burnout syndrome, measured via validated psychometric instruments (Stanford PFI Work Exhaustion subscale, Mini-Z/Mini-Z 2.0, OLBI, single-item burnout screens).

It is distinct from two adjacent constructs:

| Construct | Canonical measure | What it captures |
|---|---|---|
| In-encounter mental effort | CM-02 — Cognitive and Task Load | Moment-to-moment cognitive burden during a visit (NASA-TLX) |
| Positive engagement | CM-03 — Professional Fulfillment | Meaning and fulfillment in work — not simply the absence of burnout |
| Chronic exhaustion/disengagement | CM-09 — Burnout and Exhaustion | Cumulative emotional exhaustion and depersonalization |

**Why this matters for Suki's value story:** Burnout is the most-measured wellbeing outcome in the corpus (16 papers) and the strongest external RCT evidence anchors a Suki-relevant claim: Afshar 2025b (pragmatic RCT, n=66) found a −0.44 reduction in PFI work exhaustion. Tierney 2025 (2.5M sessions, large-scale DiD) adds objective corroboration via pajama time (−1.03 min, p=0.02) and after-hours EHR time (−1.83 min, p<0.001), plus 82% positive work-satisfaction response. Self-report-only studies (e.g., Shah 2024: −1.94 on the same PFI scale) substantially overstate effect size relative to the RCT — a gap expected from volunteer/selection bias in non-randomized quality-improvement designs.

---

## Current Suki Hooks and Data Available

Unlike CM-09 (note inaccuracy), burnout itself is **not directly observable from Suki's API** — it is a provider-reported psychological construct that requires a validated survey instrument. What Suki *can* provide is **exposure data**: utilization intensity and session-timing patterns that (a) define dose-response cohorts for a burnout study, and (b) serve as objective proxies for the mechanisms believed to drive burnout reduction (reduced after-hours documentation burden).

### What Suki exposes natively (H1)

| Artifact | API endpoint | What it enables |
|---|---|---|
| Session creation logs | `GET /session/{id}/status` (aggregated) | Sessions per provider per day/week — utilization intensity, the basis for dose-response cohorts |
| Session status | `GET /session/{id}/status` | `completed` vs. `skipped` vs. `failed` rate — adoption-quality proxy; high skip/fail rates plausibly track frustration, a precursor to burnout |
| Transcript timestamps | `GET /session/{id}/transcript` | `start_time`/`end_time` (ISO 8601, nanosecond precision) — session timing relative to clock time, usable to flag sessions occurring outside a defined "business hours" window |
| Session duration | Derived from transcript timestamps | Encounter-length proxy; not a direct burnout signal but useful for normalizing other measures |

### Measurement supported right now

- **Exposure/cohort definition** — stratify providers into heavy (≥70% utilization), moderate (30–69%), and light (<30%) users per the PHTI 2025 framework, for use as the independent variable in a burnout dose-response design
- **Session-timing distribution** — % of a provider's sessions started outside a defined business-hours window, as a rough Suki-native proxy for after-hours documentation activity (a mechanism, not the outcome itself)
- **Adoption-quality screening** — skip/fail rate trends that may flag early friction worth investigating before it shows up in survey results months later

---

## Missing or Aspirational Hooks

| Missing capability | Why it matters |
|---|---|
| **In-app survey distribution** | No documented mechanism for Suki to push a validated burnout instrument (PFI, Mini-Z, OLBI) to providers at baseline and follow-up |
| **Survey response capture/storage** | Even if surveys were distributed externally, Suki has no API for storing or linking responses to session-level utilization data |
| **Provider-level longitudinal identity across deployment phases** | Needed to match a pre-deployment baseline respondent to their post-deployment utilization tier without breaking survey anonymity |
| **Direct after-hours/pajama-time signal** | Suki's session timestamps are a proxy; the validated objective measure (EHR audit-log "pajama time," e.g., Epic Signal) lives outside Suki entirely |

---

## EHR-Side Data Needed

CM-01 is not primarily an EHR-data measure, but EHR audit-log data strengthens the *mechanism* evidence (the "why" behind any burnout change) and supports the dose-response design:

| Data element | Purpose | Vendor examples |
|---|---|---|
| After-hours/"pajama time" EHR active time per provider per month | Objective correlate of the documentation-burden pathway believed to drive burnout reduction | Epic Signal "Time Outside Scheduled Hours" / "Pajama Time" |
| Provider schedule data | Defines the "business hours" window against which Suki session timestamps and EHR activity are classified | EHR scheduling module |
| Provider ID / specialty / FTE status | Needed to stratify burnout results and exclude part-time or non-clinical staff from comparisons | EHR provider directory |

Without EHR audit-log data, Suki-native session-timing distributions can serve as a rough substitute, but they measure *when ambient sessions occur*, not total EHR burden — a known confound (CM-07's "documentation time only" vs. "total EHR time" distinction applies here too).

---

## Survey Instruments and Administration

### Validated instruments (in priority order)

- **Stanford Professional Fulfillment Index (PFI), Work Exhaustion subscale** — 10-item, 1–5 scale (higher = worse); the instrument used in the strongest external RCT (Afshar 2025b). Captures exhaustion + interpersonal disengagement.
- **Mini-Z / Mini-Z 2.0** — 10-item brief burnout screen, validated in primary care, 10–50 scale (higher = better); widely used in quality-improvement contexts (Olson 2025, Guo 2026) and explicitly proposed as the Phase 0/Phase 3 instrument in the H1 evaluation starter plan.
- **Oldenburg Burnout Inventory (OLBI)** — 16-item, disengagement + exhaustion domains (van Buchem 2024).
- **Single-item burnout question** — "How often do you feel burned out?" — low-burden screening option, useful for high-frequency pulse checks where a full instrument is impractical.
- **PROMIS Sleep Disturbance (Short Form 4a)** — proxy for restorative recovery associated with burnout; relevant as a secondary measure (Albrecht 2025).

### Suggested evaluation design

This follows the dose-response approach already recommended for H1 (Phase 0 → Phase 3 of the evaluation starter plan), since a true pre/post RCT design is rarely feasible at a single deployment:

1. **Phase 0 (pre-deployment, 4 weeks before go-live):** Administer Mini-Z (or PFI Work Exhaustion subscale) to all eligible providers. This is the baseline — and the single point most likely to be missed if Suki is engaged after go-live.
2. **Phase 1–2 (weeks 1–16):** Track Suki utilization per provider; assign heavy/moderate/light cohorts by week 4.
3. **Phase 3 (months 4–9):** Repeat the same instrument. Compare change scores across utilization cohorts (dose-response), not just pre/post pooled.
4. **Reporting:** Present results alongside the objective after-hours/pajama-time delta if EHR audit-log data is available, to corroborate the self-reported change with a mechanism-level signal — directly addressing the self-report-inflation gap seen between Afshar 2025b (RCT) and Shah 2024 (QI).

LLM-as-judge methods (used for CM-09/CM-10 note-quality measures) do not apply to CM-01 — this is a self-report psychometric construct with no transcript or note artifact to evaluate.

---

## The Baseline Problem

This is the central structural gap for CM-01, analogous to the "missing feedback loop" in CM-09 but earlier in the pipeline.

```
Pre-deployment baseline survey ──────► Suki go-live (utilization tracked) ──────► Follow-up survey
        │                                                                              │
        └────────────────────────── [missing link] ──────────────────────────────────┘
                          provider-level linkage between survey response
                          and utilization cohort, without breaking anonymity
```

**What is achievable today:** Suki utilization data from go-live forward (cohort assignment), plus a follow-up survey administered by the customer or research team.

**What is missing:**
- A pre-deployment baseline is only possible if captured *before* Suki go-live — if Suki is engaged retrospectively, this window is permanently lost.
- Even with both surveys, individual-level linkage to utilization tier requires either (a) non-anonymous survey administration (reduces response candor on a sensitive topic) or (b) a study-specific pseudonymous code maintained outside Suki.

Until this is addressed, CM-01 can only be measured as a **cohort-level dose-response comparison** (heavy vs. light users at follow-up), not a true individual-level pre/post change — unless the customer independently runs a baseline survey before go-live.

---

## Open Questions for Suki

1. Does Suki (or Suki's customer success process) have any existing template or mechanism for administering a pre-deployment baseline survey to providers before go-live?
2. Can Suki provide provider-level session-timing distributions (e.g., % of sessions starting outside a configurable business-hours window) as a Suki-native proxy for after-hours documentation activity?
3. For customers with EHR integration, does Suki receive or have access to EHR audit-log "pajama time" / after-hours active-time metrics (e.g., Epic Signal), or would this need to be requested separately from the health system?
4. Does Suki have aggregate (de-identified) burnout survey results from any prior customer pilots that could serve as additional external benchmarks beyond the published literature?
5. Would Suki be open to including a brief, validated burnout pulse item (e.g., the single-item burnout question) in an in-app feedback prompt, distinct from the existing note-quality User Feedback API?

---

*CM-01 Clinician Burnout and Exhaustion | Canonical Measures | Individual Impact dimension*
*Internal draft — June 2026*
