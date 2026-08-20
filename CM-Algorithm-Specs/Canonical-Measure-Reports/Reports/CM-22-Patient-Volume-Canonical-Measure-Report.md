# CM-22 Patient Volume and Throughput
## Canonical Measure Report — Internal Draft

**Measures covered:** CM-22 Patient Volume and Throughput (primary); related to CM-04 (Documentation Time, the proposed mechanism) and CM-01 (Burnout, the interpretation caveat)
**Status:** Internal draft for review and editing before sharing externally — **see "The Week-Level Within-Provider Design Opportunity" for a Suki-native analysis approach that is unusually strong for this measure**

---

## What This Measure Captures

**CM-22 Patient Volume and Throughput** is the change in completed encounters per provider per week (or, in ED settings, patient-flow metrics like door-to-doc time and length of stay), framed as a **downstream capacity effect of reduced documentation burden**. The [algorithm card](../CM-22-Patient-Volume.html) defines a single primary unit:

| Construct | Unit | Notes |
|---|---|---|
| **Primary unit (this report's focus)** — Completed encounters/provider/week | Signed, completed encounters, normalized to scheduled clinical hours | Gold Standard per the algorithm card |
| Scheduled encounters/week (Default/Practical) | From the EHR schedule, when completion/signing status is unavailable | Use with caution — does not reflect the documentation-driven capacity effect |
| ED throughput metrics (door-to-doc, length of stay) | Minutes | Only 6 papers total measure CM-22; the ED data (Shuaib 2021) is from a **human-scribe baseline study**, not ambient AI |

**Why this matters for Suki's value story:** CM-22 is a **thinly-studied measure (6 papers)**, but Holmgren 2026 found a statistically significant **+0.80 completed encounters/provider/week** with ambient AI adoption — a small but real effect, consistent with the theory that documentation-time savings (CM-04) convert into capacity. The Shuaib 2021 figure (+39% patients/hour, ED, human scribes) is cited as an **upper-bound comparator from an adjacent intervention type**, not a Suki-relevant benchmark.

**The interpretation caveat that should travel with any CM-22 number:** per the algorithm card's caution box, **increased volume is not universally desirable** — higher throughput without corresponding documentation-time relief (CM-04) or adequate staffing "warrants investigation" rather than celebration. CM-22 should generally be reported **alongside** CM-04, not in isolation.

---

## The Week-Level Within-Provider Design Opportunity

This section comes first because, unlike most measures in this report series, CM-22 has a Suki-native analytical advantage worth highlighting rather than a gap to apologize for.

**The standard approach** for most canonical measures is a month-level pre/post comparison anchored on each provider's Suki adoption date — Suki provides the adoption-date boundary, and the EHR provides the outcome.

**The stronger alternative for CM-22**, per the algorithm card's "Suki Data Scope" box: *"Suki identifies which weeks are active-use weeks, but encounter counts come entirely from the EHR... a provider who used Suki in 3 out of 4 weeks in a month can be analyzed at the week level, with the 3 Suki weeks as 'post-adoption' and the 1 non-Suki week as a within-provider control."*

```
Provider's month: Week 1 (Suki used) | Week 2 (Suki used) | Week 3 (no Suki) | Week 4 (Suki used)
                          │                    │                   │                  │
                   "post" week           "post" week        within-provider      "post" week
                                                                control week
                          └────────────────────┴───────────────────┴──────────────────┘
                                    Completed encounters/week from EHR, compared
                                    within the SAME provider, SAME month
```

**Why this matters:** a within-provider, within-month comparison controls for nearly every confounder that plagues month-level pre/post designs — specialty, panel size, seasonal scheduling patterns, and individual provider baseline productivity are all held constant. This is a **stronger design than what most other CM reports in this series can offer**, and it is enabled entirely by data Suki already has (weekly session counts) plus EHR data Suki already needs anyway (weekly completed-encounter counts).

**What is achievable today:** Suki can provide per-provider, per-week "active Suki use" flags — this is a finer-grained version of the adoption-date field already used elsewhere.

**What is missing:** the EHR side of this design requires completed-encounter counts at **weekly**, not monthly, grain — confirm this granularity is available before committing to the week-level design over the simpler month-level one.

---

## Current Suki Hooks and Data Available

### What Suki exposes natively (H1)

| Artifact | API endpoint | What it enables |
|---|---|---|
| Session creation logs / adoption date | `GET /session/{id}/status` (aggregated) | Month-level pre/post adoption boundary, per the algorithm card's primary formula |
| Per-week session counts | `GET /session/{id}/status`, aggregated by week | The **week-level "active use" flag** that enables the within-provider design above |
| Active usage flag (monthly) | `GET /session/{id}/status` | Active-provider cohort denominator (post onboarding-ramp, default 30 days) |

### Measurement supported right now

- **Adoption-date / active-usage cohort definition** — same role as in CM-04/05/07/20/21.
- **Week-level active-use flags** — already derivable from existing session timestamp data without new instrumentation; this is the input that makes the within-provider design above possible **today**, contingent only on matching EHR-side weekly granularity.
- **No direct measurement of encounter counts.** Per the algorithm card: *"Suki identifies which weeks are active-use weeks, but encounter counts come entirely from the EHR."*

---

## Missing or Aspirational Hooks

| Missing capability | Why it matters |
|---|---|
| **None specific to Suki's role** — CM-22's Suki-native contribution (adoption date + weekly active-use flags) is already sufficient for either the month-level or week-level design | Unlike CM-05/CM-07/CM-20, there is no "if only Suki could see X" gap here — the limiting factor is entirely EHR-side data granularity, addressed below |

---

## EHR-Side Data Needed

CM-22's outcome signal — completed encounter counts — is **entirely EHR-sourced**; Suki's role is cohort/timing scaffolding only.

| Data element | Purpose | Vendor examples / Notes |
|---|---|---|
| Total completed (signed) encounters per provider/month | Primary numerator, month-level design | Epic/Cerner `total_encounters` — **must be filtered to signed notes only**; unsigned notes inflate the count per the algorithm card's key note |
| Total completed (signed) encounters per provider/**week** | Primary numerator, week-level within-provider design | Same field as above at weekly grain — confirm availability before choosing this design |
| Avg completed encounters per working day | Alternative denominator-normalized form if scheduled-hours data unavailable | Epic/Cerner `encounters_per_day` |
| Scheduled clinical hours per provider per week | Normalizes for part-time schedules — critical, since a provider cutting from 5 to 4 clinical days shows a raw encounter drop unrelated to Suki | EHR scheduling module or HR system |
| Provider specialty | Stratification and exclusion of providers who changed specialty mid-window | EHR provider record |
| Provider ID crosswalk | Joins EHR encounter records to Suki session records | Must be reconciled between systems, as elsewhere |

**The "patients seen" vs. "closed encounter count" definition issue** (flagged explicitly in the canonical measure definition): Suki's own existing telemetry already uses "total closed encounter count" (signed-note-required) — which happens to **match the algorithm card's Gold Standard definition exactly**. When requesting EHR data, confirm whether the field returned reflects appointments scheduled, visits roomed, or notes signed — these are increasingly strict definitions, and only the last matches both Suki's existing convention and the Gold Standard.

---

## The Completed-Encounter Definition Gap

This is the central structural issue for CM-22 — smaller in scope than most other reports' central gaps, because Suki's side of the data is essentially complete. The risk is a **definitional mismatch at the EHR boundary**, not a missing Suki capability.

```
Suki-native: per-provider adoption date + weekly active-use flags  ──►  fully available today
                                                                              │
                                                                      [definition check]
                            EHR field for "encounter count" — is it:
                              (a) appointments scheduled?
                              (b) visits roomed/checked in?
                              (c) notes signed (= "completed encounter")?
                                                                              │
                                                                              ▼
                          Only (c) matches the Gold Standard AND Suki's existing
                          "total closed encounter count" convention
```

**What is achievable today:** the entire Suki-side contribution (adoption date, weekly active-use flags) is ready now, and Suki's existing telemetry convention is already aligned with the Gold Standard definition — an unusually favorable starting point compared to other CM reports.

**What is missing:** confirmation, per site/EHR, that the requested encounter-count field reflects signed notes rather than scheduled or roomed visits. Using an unconfirmed field risks either (a) inflating apparent throughput gains with no-shows/cancellations included, or (b) introducing a definitional mismatch between Suki's "closed encounter count" and the EHR's reported figure that makes the two numbers non-comparable.

**Implication for reporting:** before reporting any CM-22 number, explicitly state which encounter-count definition was used and confirm it matches "signed, completed encounter" — a one-line confirmation that resolves what would otherwise be the most likely source of a misleading CM-22 figure.

---

## Open Questions for Suki

1. Is the within-provider, week-level design (3 active-use weeks vs. 1 non-use week per month) something Suki's data infrastructure already supports at the weekly grain, or would it require new aggregation logic on top of existing session timestamps?
2. For Suki's existing "total closed encounter count" telemetry — is this metric already validated against EHR-reported signed-encounter counts at any site, which would help confirm the EHR-side field mapping described above?
3. Given that CM-22 should be reported alongside CM-04 (per the algorithm card's caution box), would a combined CM-04/CM-22 data request make sense, since both rely on overlapping EHR encounter/provider data?
4. Is there appetite to pilot the week-level within-provider design at a single site as a proof-of-concept, given that it requires no new Suki-side capability and could produce a more credible CM-22 estimate than a month-level comparison?
5. Since only 6 papers measure CM-22 and the strongest non-Holmgren evidence (Shuaib 2021) is from a human-scribe ED study, would Suki's research team consider CM-22 a priority for a future evaluation, or a secondary measure to report opportunistically alongside CM-04?

---

*CM-22 Patient Volume and Throughput | Canonical Measures | Organizational Impact dimension*
*Internal draft — June 2026*
