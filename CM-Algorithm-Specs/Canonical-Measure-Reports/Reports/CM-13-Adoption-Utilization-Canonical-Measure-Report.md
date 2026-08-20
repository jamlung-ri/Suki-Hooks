# CM-13 Adoption Behavior and Utilization Rate
## Canonical Measure Report — Internal Draft

**Measures covered:** CM-13 Adoption Behavior and Utilization Rate (primary); no direct companion measure — CM-13 is the only canonical measure sourced entirely from Suki's own product telemetry rather than the EHR
**Status:** Internal draft for review and editing before sharing externally

---

## What This Measure Captures

**CM-13 Adoption Behavior and Utilization Rate** is the actual, observed use of the ambient AI scribe — measured as the % of eligible encounters in which the tool is used, total sessions, or paid adoption post-trial. It captures behavior (what clinicians actually do), not intention (what they say they will do).

Unlike every other canonical measure documented so far, CM-13 is not an EHR-telemetry or note-artifact measure at all. It is computed entirely from Suki's own Admin Center BigQuery tables, using query logic Suki's own teams have already run in production and cross-validated against each other via a shared validation sheet.

**Why this matters for Suki's value story:** Utilization is the gating variable behind every other outcome measure in this canonical set — a provider who never uses ambient capture cannot show a documentation-time improvement, a burnout reduction, or a coding-accuracy gain. Published utilization figures cluster in a wide but generally strong range: Ma 2025 reports 55% utilization at Stanford; Afshar 2025 reports 65.4% scribe utilization in a pragmatic RCT; AAFP 2021 reports 60% post-trial adoption. Every large deployment in the corpus (Tierney 2025: 2.5M uses in one year) reports the same structural pattern: a bimodal heavy-user/light-user distribution, with the top third of users driving a disproportionate share of total usage (89% of 2.57M encounters in Tierney 2025). Dose-response is consistent across studies — heavy users benefit most (Pearlman 2025, Omon 2025, Lukac 2025).

---

## The Suki Admin Center Metric Family

Suki's Admin Center already tracks three structurally distinct metrics that the literature corpus's various CM-13 aliases map onto — imperfectly. This is the most important thing to understand about CM-13: **the SQL is not the open question here; the mapping is.**

| Suki metric | Definition | BigQuery source | Literature aliases that (imprecisely) map to it |
|---|---|---|---|
| **Utilization** | Ambient Notes Created ÷ EHR Appointments Scheduled | `SukiUserUsage` (`ambient_created`, `appt_ehr_count`) | Utilization Rate (Ma 2025), Scribe Utilization Rate (Afshar 2025), SmartSection Utilization (Ma 2025) |
| **Adoption Rate** | % of newly onboarded users with ≥1 ambient session in a 31–60 day post-first-use window | `SukiUserUsage` (`first_usage_date`, `first_ambient_date`, `session_count`) | Adoption Rate (AAFP 2021 — though AAFP's trial design differs from Suki's window definition) |
| **Engagement Rate** | Among users active ≥1x/week or month, the % also active ≥2x | `SukiEngagementData` (`wk_ambient_cat`, `mth_ambient_cat`) | Active User Count, Days of Use as Moderator (Pearlman 2025), Utilization Stratification (Olson 2025) |
| **License Status Count** | Snapshot of users by SFDC license bucket (Active / Pending / Deactivated) | `SukiUserUsage` (`status`) | Total user denominator context; not itself an alias but required to interpret the other three |

All four are validated, production BigQuery queries — documented in Suki's internal "Admin Center — Validation of Metric Values" reference (v1.2, last updated 4/16/2026) and run against a canonical customer organization. This is a materially stronger evidence foundation than the proxy algorithms built for other canonical measures in this set, most of which require inference from Epic Clarity tables or a first-pass pilot design.

---

## Current Suki Hooks and Data Available

CM-13 is fully observable from Suki's own analytics warehouse. No EHR integration, survey, or human-rating pipeline is required to compute any of its four component metrics — a structural difference from nearly every other canonical measure in this corpus.

### What Suki exposes natively

| Artifact | BigQuery source | What it enables |
|---|---|---|
| `ambient_created`, `appt_ehr_count` | `suki-dev.analytics.SukiUserUsage` | Utilization ratio at weekly/monthly/quarterly/yearly grain, by cohort, specialty, or provider |
| `first_usage_date`, `first_ambient_date`, `session_count` | `suki-dev.analytics.SukiUserUsage` | Adoption Rate (trial-to-active-use conversion) at monthly grain |
| `wk_ambient_cat`, `mth_ambient_cat` | `suki-dev.analytics.SukiEngagementData` | Engagement Rate (depth-of-use ratio) at weekly/monthly grain |
| `status` (SFDC license state) | `suki-dev.analytics.SukiUserUsage` | License Status Count — Active / Pending / Deactivated snapshot |

### Measurement supported right now

- **Utilization %** — computed today, at every reporting grain the Admin Center supports, already visualized in a Tableau report
- **Adoption Rate %** — computed today, monthly time series and specialty breakdown
- **Engagement Rate** — computed today, weekly and monthly time series
- **Provider-level utilization ranking** — computed today, capped at 100% per provider, used for heavy/light user stratification

---

## Missing or Aspirational Hooks

Because CM-13 is already fully computable, the gaps here are about **definitional clarity**, not data access.

| Missing capability | Why it matters |
|---|---|
| **A single, published CM-13 operational definition** | Right now Utilization, Adoption Rate, and Engagement Rate are three different constructs bundled under one canonical measure name. A published crosswalk (which literature alias maps to which Suki metric, and why) would resolve most of the ambiguity documented below. |
| **Product-type scoping consistency** | Adoption Rate filters to `product_type IN ('ASSISTANT', 'COMPOSE')`; the Utilization queries do not filter on product type at all. Confirm whether this is intentional. |
| **A capped vs. uncapped reporting convention** | Provider-level utilization is capped at 100%; cohort/specialty/time-series views are not. A published convention for when to use which would prevent inconsistent external reporting. |
| **Dose-response / quartile analysis as a standard Admin Center view** | The literature consistently finds dose-response value in utilization-quartile stratification (Pearlman 2025, Omon 2025) — this is a promising Suki-native analysis that isn't yet a standard Admin Center report, but the underlying provider-level data already supports it. |

---

## EHR-Side Data Needed

Minimal, and already handled by Suki's own ingestion pipeline. The only EHR-originated element in this entire measure is the appointment-scheduling feed that becomes `appt_ehr_count`.

| Data element | Purpose | Vendor examples / Notes |
|---|---|---|
| EHR Created Appointments | Numerator input for `appt_ehr_count` | Ingested via Suki's standard EHR scheduling feed integration, not a live per-query Epic pull |
| EHR Deleted/Canceled Appointments | Subtracted from Created Appointments to form the denominator | Same ingestion path; `appt_ehr_count` = Created − Deleted |

Suki already ingests and reconciles this feed on a 24-hour sync cadence as part of onboarding every customer — there is no additional EHR-side integration work required to compute CM-13 beyond what Suki already does for every deployment. The one caveat: this means CM-13's denominator quality is only as good as a given customer's scheduling-feed completeness, which can vary in the first weeks after go-live.

---

## The Construct-Mapping Problem

This is the central structural gap for CM-13 — and it is the inverse of every other report in this set. Where CM-09's central gap ("The Missing Feedback Loop") and CM-24's central gap ("no data source exists") are about *data availability*, CM-13's gap is about *definitional precision*: the data is excellent, but the literature's vocabulary for "adoption" and "utilization" does not cleanly separate into the same buckets Suki's own metrics do.

```
Literature vocabulary              Suki Admin Center metric
──────────────────────             ─────────────────────────
"Utilization Rate"        ────┐
"Scribe Utilization Rate" ────┼──►  Utilization
"SmartSection Utilization"────┘     (ambient_created / appt_ehr_count)

"Adoption Rate"           ────┐
"% purchasing post-trial"─────┼──►  Adoption Rate
                               │     (session activity, 31-60 day post-first-use window)
                               │     ⚠ AAFP 2021's trial design ≠ Suki's window definition

"Active user count"       ────┐
"Days of use as moderator"────┼──►  Engagement Rate
"Utilization stratification"──┘     (≥2 vs. ≥1 weekly/monthly active sessions)

                    [ missing link ]
     A published, versioned crosswalk table stating which
     Suki metric each literature alias should be reported against
```

**What is achievable today:** every underlying number — Utilization, Adoption Rate, Engagement Rate, License Status Count — is already computed in production, validated, and available at fine reporting grain. This is, by a wide margin, the strongest data foundation of any canonical measure in the corpus.

**What is missing:** a single owned decision about which Suki metric represents "the" CM-13 number when a literature comparison is made, and a documented rationale for why (e.g., "Ma 2025's 55% Utilization Rate compares most directly to Suki's Utilization metric, not Adoption Rate, because both are appointment-coverage ratios; AAFP 2021's 60% is not directly comparable because it measures trial-to-paid conversion, which is closer to Suki's Adoption Rate but on a different time window").

Until this crosswalk is published and agreed, any external comparison of a customer's Suki utilization number against a published literature benchmark risks comparing two different constructs that happen to share a name.

---

## Open Questions for Suki

These are specific data-access and definitional questions, not broad capability questions:

1. Is there an existing internal crosswalk (even informal) mapping the literature's "adoption rate" / "utilization rate" / "engagement rate" language to Suki's three Admin Center metrics, or would this need to be built from scratch?
2. Why does the Utilization query not filter on `product_type` or `status` the way the Adoption Rate query does — is broader scope intentional, or should Utilization be scoped the same way?
3. Is the provider-level 100% cap on Utilization (`LEAST(1.0, ...)`) a display convention only, or does the underlying uncapped ratio (sometimes >100%) get used anywhere in customer-facing reporting?
4. How stable is `appt_ehr_count` in the first 30–60 days after a customer's EHR scheduling feed goes live — is there a known ramp period where Utilization should be interpreted cautiously?
5. Is dose-response / utilization-quartile analysis (heavy vs. light users) already run as a standard internal report, or would this need to be newly built from the provider-level utilization query?

---

*CM-13 Adoption Behavior and Utilization Rate | Canonical Measures | Use dimension*
*Internal draft — July 2026*
