# CM-20 — Financial Productivity and Revenue Impact Algorithm Spec
**Category:** Financial  
**Status:** First draft — for review with Katie, then Amita/Sudha  
**Canonical measure:** Changes in physician financial productivity associated with ambient AI use — measured as RVU output, revenue per clinician per year, or ROI

---

## What This Measures

Whether providers using Suki generate more billable work value per unit of clinical time — and what that translates to in dollars. The mechanism: ambient documentation captures encounter complexity more completely → notes support higher RVU coding → more revenue per encounter without increasing denial rates. CM-20 is the financial bottom line; CM-21 (Coding Accuracy) is the upstream driver.

**Relationship to CM-21:** CM-21 measures *whether codes are accurate*. CM-20 measures *what the revenue impact of those codes is*. A health system that wants a single financial metric should start here. One that wants to understand *why* the number moved should also look at CM-21.

**Primary unit:** Change in work Relative Value Units (wRVUs) per provider per week, pre vs. post Suki adoption  
**Translated unit:** Additional revenue per clinician per year ($) = Δ wRVUs/week × 52 weeks × Medicare conversion factor  
**Reporting grain:** Per provider, per period (quarterly or annual); aggregated to site and health system  
**Direction:** Higher delta = better

---

## Tiered Ascertainment Methods

### Tier 1 — Realistic & Solid ✓ (data-driven wRVU pre/post)

**What it requires:** Billed CPT codes with CMS wRVU weights per encounter, linked to Suki session records by provider and date; pre-adoption encounter data from the same provider

**Data elements:**
| Element | Source | Field / Notes |
|---|---|---|
| Suki session existence per provider per week | Suki session records | `ambient_session_id` + provider ID; use to define post-adoption periods |
| Session completion status | `GET /session/{id}/status` | `status = "completed"` — only active-use weeks count |
| Provider Suki adoption date | Suki admin data | Date of first completed session; defines pre/post boundary |
| Billed CPT code per encounter | EHR / claims | CPT code (e.g., 99213, 99214) assigned to completed encounter |
| wRVU weight per CPT code | CMS Physician Fee Schedule | Published annually; e.g., 99213 = 1.30 wRVU, 99214 = 1.92 wRVU |
| Encounters per provider per week | EHR encounter table | Completed encounter count, per provider per calendar week |
| Provider ID (join key) | Shared Suki + EHR | Must be consistent identifier across systems |
| Medicare conversion factor | CMS | 2026: ~$33.29 per wRVU (for dollar translation; confirm current year rate) |

**Pseudocode:**
```
For each provider p:

  adoption_date_p = date of provider's first completed Suki session
  ramp_end_p      = adoption_date_p + 30 days  [exclude onboarding ramp]

  POST period:
    For each week w where provider p has ≥ 1 completed Suki session
    AND week w > ramp_end_p:
      wRVUs_week_w = SUM(cpt_wrvu_weight) across all completed encounters in week w

    wRVUs_per_week_post_p = AVG(wRVUs_week_w) across post-period weeks

  PRE period:
    For the equivalent-length window before adoption_date_p:
      wRVUs_per_week_pre_p = AVG(wRVUs_week_w) across pre-period weeks
      [Same calendar weeks, prior year preferred to control for seasonality]

  wRVU_delta_p = wRVUs_per_week_post_p - wRVUs_per_week_pre_p

REPORT:
  AVG(wRVU_delta_p) across all qualifying providers         [Δ wRVUs/week]
  Revenue_per_clinician_per_year = AVG(wRVU_delta_p)
                                   × 52
                                   × Medicare_conversion_factor  [$]

  [Filter: providers with ≥ 4 weeks of post-ramp Suki use; ≥ 10 encounters/week pre-period;
   exclude providers who changed specialty, employment status, or site during window;
   normalize for case mix if specialty mix shifts between pre and post periods]
```

**Example:** A provider averaged 42.0 wRVUs/week before Suki. Post-ramp, they averaged 43.8 wRVUs/week. Delta = +1.8 wRVUs/week × 52 weeks × $33.29 = **+$3,115/year**.

**Benchmark check:** Holmgren 2026 found +1.81 wRVUs/week ≈ $3,044/year at UCSF using a similar methodology — this would be very consistent.

---

### Tier 2 — Aspirational / Ideal (full ROI calculation)

**What it requires:** Tier 1 revenue data plus Suki contract cost per provider and any implementation/training costs; optionally, cost comparison against human scribe alternative

**Data elements:** Everything in Tier 1, plus:
| Element | Source |
|---|---|
| Suki contract cost per provider per year | Suki / finance team |
| Implementation and onboarding costs | Health system finance |
| Human scribe cost per provider per year (if applicable) | Health system finance |
| Non-adopter wRVU trend (for DiD) | EHR — control group of non-adopting providers |

**Pseudocode:**
```
For each provider p (or provider cohort):

  revenue_gain_p = wRVU_delta_p × 52 × Medicare_conversion_factor
  suki_cost_p    = annual Suki license cost per provider + pro-rated onboarding cost

  ROI_p = (revenue_gain_p - suki_cost_p) / suki_cost_p   [expressed as X:1 ratio or %]

  Net_benefit_p = revenue_gain_p - suki_cost_p             [$]

REPORT:
  AVG(ROI_p) across providers             [e.g., "3.2:1 ROI"]
  AVG(Net_benefit_p) per provider/year    [$]
  [Optional: compare against human scribe cost if Suki is replacing scribes]
```

**Why it's Tier 2:** Requires Suki cost data and implementation cost accounting — information Suki holds internally or that varies by contract. Also benefits from a difference-in-differences control group to rule out secular RVU trends. Best suited for Amita's quarterly business review presentations to health system leadership (the "here's your ROI" slide), not the real-time admin console.

**Published benchmark:** Boyter/KLAS 2025 reported +$13,049/year per provider for Ambience — a much larger figure, primarily driven by HCC capture ($9,685) plus E/M level gains ($1,907) plus other coding improvements. Suki's equivalent will depend on its HCC capture performance (CM-21 companion indicator).

---

### Tier 3 — Minimal / Fallback (provider self-report)

**What it requires:** Provider survey; no claims or financial data needed

**Survey items:**
> "Since using Suki, I believe my documentation captures the full complexity of my patient encounters more completely."  
> (1) Strongly disagree — (5) Strongly agree

> "I believe Suki has had a positive impact on the revenue my practice generates."  
> (1) Strongly disagree — (5) Strongly agree

**Pseudocode:**
```
REPORT:
  % responding "Agree" or "Strongly agree" to each item
  Mean Likert score per item
  [Filter: providers with ≥ 4 weeks of Suki use at time of survey;
   restrict revenue item to providers with awareness of their billing productivity]
```

**Why it's Tier 3:** Providers often do not have visibility into their own RVU output or billing revenue. The documentation complexity item is more answerable but still subjective. Use only when financial data is unavailable.

---

## Companion Indicators (same data, additional signal)

| Indicator | Formula | Unit | Notes |
|---|---|---|---|
| **wRVUs per encounter** | Total wRVUs / completed encounters in period | wRVUs per encounter | Encounter-level productivity; Holmgren 2026: +0.04/encounter |
| **wRVUs per clinical hour** | Total wRVUs / scheduled clinical hours | wRVUs per hour | Normalizes for part-time providers |
| **Revenue per encounter** | wRVUs per encounter × Medicare rate | $/encounter | Dollar-denominated alternative to RVU unit |
| **Cost savings vs. scribe** | Annual scribe cost − Suki cost per provider | $/provider/year | For health systems that replaced human scribes with Suki |
| **VBC panel revenue** | Suki-attributed change in VBC-attributed panel size × per-member revenue | $ | Relevant for providers in value-based care contracts; from Haberle 2024 |

---

## Open Questions for Suki

1. Does Amita's pipeline currently receive billed CPT codes from EHR clients, or only encounter counts? CPT codes are required to apply wRVU weights.
2. Is Suki's contract cost per provider per year a fixed figure that can be used in ROI calculations, or does it vary enough by contract that ROI must be computed customer-by-customer?
3. For customers who replaced human scribes with Suki, does Amita track the prior scribe cost to enable a cost-comparison calculation?
4. The Boyter/KLAS figure (+$13,049/year) is driven heavily by HCC capture — does Suki have data on whether its customers are seeing similar HCC gains? This would require the HCC companion indicator from CM-21 to be live in the pipeline first.
5. Are any current Suki customers large enough to run a meaningful difference-in-differences comparison (i.e., have both adopters and non-adopters at the same site)?

---

## Important Caveat

PHTI 2025 raises a system-level concern: even *accurate* higher coding increases healthcare spending from the payer perspective. A health system benefits from capturing more RVUs; payers and society bear that cost. Suki and Regenstrief should be thoughtful about how this measure is presented externally — framing it as "capturing complexity that was already there" (supported by Holmgren 2026's null denial finding) is more defensible than "increasing revenue."

This is a presentation framing issue, not a measurement issue. The algorithm is sound regardless.

---

## Literature Anchors

| Finding | Source | Relevance |
|---|---|---|
| +1.81 wRVUs/week ≈ +$3,044/year | Holmgren 2026 | Primary benchmark; UCSF; no denial increase; matches Tier 1 method |
| +$13,049/year (HCC + E/M + other) | Boyter/KLAS 2025 | Upper-bound benchmark; Ambience product; heavily HCC-driven |
| wRVUs per encounter: +0.04 | Holmgren 2026 | Encounter-level companion indicator benchmark |
| ROI and cost comparison | Cao 2024 | Dermatology-specific; methodology reference for Tier 2 |
| VBC panel size change | Haberle 2024 | Relevant for VBC companion indicator |
| Scribe cost comparison | Shuaib 2021 | Human scribe baseline for cost-comparison calculation |

---

*CM-20 Financial Productivity and Revenue Impact | Algorithm Spec v0.1 | 2026-05-06 | Internal draft — Suki IP*
