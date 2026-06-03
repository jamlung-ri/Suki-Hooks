# CM-22 — Patient Volume and Throughput Algorithm Spec
**Category:** Operational  
**Status:** First draft — for review with Katie, then Amita/Sudha  
**Canonical measure:** Change in patients seen per unit time as a downstream efficiency outcome of reduced documentation burden

---

## What This Measures

Whether providers using Suki are able to see more patients per unit of clinical time — a direct operational signal that ambient documentation is freeing up time previously consumed by note-writing. The mechanism: less time in the note → more time available for patient care → more encounters completed per day or week.

**Primary unit:** Change in completed encounters per provider per week (post-Suki vs. pre-Suki baseline)  
**Reporting grain:** Per provider, per period (monthly or quarterly); aggregated to specialty, site, and health system  
**Direction:** Higher delta = better (with the caveat that increased volume should not come at the expense of visit quality or provider workload)

---

## Tiered Ascertainment Methods

### Tier 1 — Realistic & Solid ✓ (data-driven pre/post encounter count)

**What it requires:** EHR completed encounter counts per provider per week, linked to Suki session records to identify adoption date and active use periods

**Data elements:**
| Element | Source | Suki Field / EHR Field |
|---|---|---|
| Suki session existence per provider | Suki session records | `ambient_session_id` + provider ID, grouped by week |
| Session completion status | `GET /session/{id}/status` | `status = "completed"` — only count valid sessions |
| Provider Suki adoption date | Suki admin data | Date of first completed session per provider |
| Completed encounters per week | EHR scheduling / encounter table | Count of encounters with completed status, per provider per calendar week |
| Provider ID (join key) | Shared between Suki + EHR | Must be consistent identifier across both systems |
| Provider specialty | EHR provider table | For specialty-level breakdowns |
| Scheduled clinical hours | EHR / HR system | To normalize for part-time providers (optional but recommended) |

**Pseudocode:**
```
For each provider p:

  adoption_date_p   = date of provider's first completed Suki session
  ramp_end_p        = adoption_date_p + 30 days  [exclude onboarding ramp]

  POST period:
    encounters_post_p = count of completed EHR encounters for provider p
                        where encounter_date > ramp_end_p
                        AND provider has ≥ 1 completed Suki session in that week
    weeks_post_p      = count of calendar weeks in post period

  PRE period:
    encounters_pre_p  = count of completed EHR encounters for provider p
                        in the equivalent-length window before adoption_date_p
                        [same calendar weeks, prior year preferred to control for seasonality]
    weeks_pre_p       = count of calendar weeks in pre period

  enc_per_week_post_p = encounters_post_p / weeks_post_p
  enc_per_week_pre_p  = encounters_pre_p  / weeks_pre_p

  throughput_delta_p  = enc_per_week_post_p - enc_per_week_pre_p

REPORT:
  AVG(throughput_delta_p) across all qualifying providers
  [Filter: providers with ≥ 4 weeks of post-ramp Suki use; ≥ 10 encounters/week in pre period;
   exclude providers who changed employment status, specialty, or site during measurement window]
```

**Example:** A family medicine provider averaged 28 encounters/week before Suki. After a 30-day ramp, they averaged 29.1 encounters/week over the following quarter. Throughput delta = +1.1 encounters/week. Across 50 providers, AVG delta = +0.9 encounters/week.

**Benchmark check:** Holmgren 2026 found +0.80 encounters/week with ambient AI adoption — a +0.9 result would be consistent with published evidence.

---

### Tier 2 — Aspirational / Ideal (difference-in-differences with non-adopter controls)

**What it requires:** Encounter counts for both Suki adopters and a matched group of non-adopters at the same institution, over the same time period

**Data elements:** Same as Tier 1, plus:
| Element | Source |
|---|---|
| Non-adopter encounter counts | EHR — providers at same site who have not used Suki during measurement period |
| Matching criteria | Specialty, panel size, scheduled hours, pre-period volume — matched at provider level |

**Pseudocode:**
```
For each adopter provider p, identify matched non-adopter provider q:
  [Match on: same specialty, similar pre-period encounters/week (±20%),
   same site, similar scheduled hours]

DiD_p = (enc_per_week_post_p - enc_per_week_pre_p)
      - (enc_per_week_post_q - enc_per_week_pre_q)

REPORT:
  AVG(DiD_p) across all matched adopter-control pairs
  [Interpretation: controls for secular trends in volume — e.g., site-wide changes,
   seasonal patterns, staffing changes — that would affect all providers regardless of Suki]
```

**Why it's Tier 2:** Requires a sufficient non-adopter comparison group at the same institution, which may not exist once adoption reaches saturation. Best suited for Amita's quarterly business reviews, not the real-time admin console. Methodologically matches Holmgren 2026.

---

### Tier 3 — Minimal / Fallback (provider self-report)

**What it requires:** Provider survey; no EHR data needed

**Survey item:**
> "Since adopting Suki, I am able to see more patients per day than I could before."  
> (1) Strongly disagree — (2) Disagree — (3) Neither — (4) Agree — (5) Strongly agree

**Secondary item:**
> "Approximately how many additional patients per week do you see since using Suki?" *(open numeric)*

**Pseudocode:**
```
REPORT:
  % of providers responding "Agree" or "Strongly agree" (items 4–5)
  Median self-reported additional patients per week (from numeric item)
  [Filter: providers with ≥ 4 weeks of Suki use at time of survey]
```

**Why it's Tier 3:** Directional signal only; subject to recall bias and social desirability effects. Cannot be trended continuously. Used in Albrecht 2025. Appropriate only when EHR data sharing is not available or as a supplemental cross-check.

---

## Companion Indicators (same data, additional signal)

| Indicator | Formula | Unit | Setting |
|---|---|---|---|
| **Encounters per scheduled hour** | Completed encounters / scheduled clinical hours per provider | Encounters/hr | Normalizes for part-time providers |
| **Patients seen per hour (ED)** | Completed ED encounters / hours on shift | Patients/hr | ED-specific; matches Shuaib 2021 |
| **Door-to-doc time** | Time from patient arrival to first physician contact | Minutes | ED only; requires ED operational data |
| **Visit capacity utilization** | Completed encounters / scheduled encounter slots | % utilization | Reveals whether open slots exist or true volume is increasing |

*Recommend encounters/week delta as primary admin console metric for ambulatory settings; offer encounters/hour for ED customers. Door-to-doc and utilization are secondary metrics for customers with richer operational data.*

---

## Open Questions for Suki

1. Is provider ID consistent between Suki session records and EHR encounter records? This is the join key — any mismatch breaks the pre/post linkage.
2. What is Suki's standard definition of a "Suki-assisted encounter"? (i.e., does a session need to reach `completed` status, or does any started session count toward adoption?)
3. Does Suki track provider go-live / adoption dates internally, or does that need to come from the health system?
4. For the pre-period baseline: does Amita's team have a standard convention (e.g., same period prior year, or N weeks before go-live)? We need to align on this before writing the pipeline query.
5. Do any current Suki customers have both encounter EHR data in the pipeline AND sufficient non-adopters to attempt a Tier 2 difference-in-differences analysis?

---

## Important Caveat

Increased patient volume is not unconditionally desirable. If a provider sees more patients without a corresponding increase in scheduled time or compensation, this metric could be interpreted as increased workload, not efficiency gain. The admin console presentation should contextualize this metric alongside:
- Provider time saved (documentation efficiency measures — CM-01 / CM-02)
- Provider satisfaction / burnout scores
- Whether additional encounters were *scheduled* (deliberate capacity expansion) or *squeezed in* (workload intensification)

This framing matters for how Suki presents the metric to health system leadership.

---

## Literature Anchors

| Finding | Source | Relevance |
|---|---|---|
| +0.80 encounters/week with ambient AI | Holmgren 2026 | Primary benchmark; statistically significant; matches our Tier 1 method |
| +39% patients/hour | Shuaib 2021 | Human scribe in ED — upper-bound comparator; not directly comparable to ambient AI |
| Ability to see additional patients (survey) | Albrecht 2025 | Validates Tier 3 survey approach; directional signal |
| Throughput referenced but not formally measured | Bundy 2024, Haberle 2024, Boyter/KLAS 2025 | Contextual support; no usable benchmark numbers |

---

*CM-22 Patient Volume and Throughput | Algorithm Spec v0.1 | 2026-05-06 | Internal draft — Suki IP*
