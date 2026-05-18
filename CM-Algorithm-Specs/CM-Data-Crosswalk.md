# CM Data Crosswalk: Suki Inputs vs. EHR Inputs
**Created:** 2026-05-13 | **Owner:** Joe Amlung  
**Validated against:** Josh Vest & Katie Allen, `Measures_suki_ehr_crosswalk.xlsx` (2026-05-13)  
**Purpose:** For each priority canonical measure, identify what data Suki already has vs. what must come from the EHR partner. This is the primary deliverable for Amita and Sudha.

---

## How to Read This Table

**Implied comparison for all measures:** Pre-Suki vs. post-Suki, per provider. The pre/post boundary is defined by each provider's first completed Suki session (adoption date).

**Universal Suki input (applies to every row):** Provider-level usage logs linking each provider ID to their Suki adoption status, adoption date, and session activity. Josh and Katie refer to this as "usage logs" in the crosswalk; it maps to session records from Suki's API. For most measures, this is the only Suki contribution — the EHR provides everything else.

**EHR field names in parentheses** are the actual fields Suki is already pulling from Epic, Cerner, Meditech, and Athena partners. These names are consistent across all four EHR systems unless otherwise noted.

**Aggregation level:** Monthly per provider, by default. Some measures can be computed at the encounter level.

---

## The Crosswalk

| Canonical Measure | Category | What You're Measuring | Suki Inputs ("Usage Logs") | EHR Inputs Required |
|---|---|---|---|---|
| **CM-20a: wRVU Output** | Financial | Change in total work RVUs billed per provider per month | Provider ID → Suki user flag; adoption date | Total work RVUs by provider by service month (`wrvu_total`); provider encounters by month; provider IDs; limited to eligible providers & settings |
| **CM-20b: Billing Revenue** | Financial | Change in total paid revenue per provider per month | Provider ID → Suki user flag; adoption date | Total paid revenue by provider by service month — adjusted net revenue if possible (`revenue_paid`); provider IDs; provider encounters by month |
| **CM-20c: E/M Level Improvement** | Financial | Change in distribution of E/M complexity levels billed — specifically the share of Level 4–5 encounters | Provider ID → Suki user flag; adoption date | Full E/M code counts by level, new and established patients (`em_new_level1_count` through `em_new_level5_count`; `em_est_level1_count` through `em_est_level5_count`); total E/M visits (`em_total_count`); avg ICD-10 diagnosis codes per encounter (`icd10_codes_per_enc`); provider IDs; provider encounters by month |
| **CM-21a: ICD-10 Coding Depth** | Financial / Quality | Change in average number of ICD-10 diagnosis codes documented per encounter — a proxy for coding completeness | Provider ID → Suki user flag; adoption date | Avg ICD-10 diagnosis codes per encounter (`icd10_codes_per_enc`); provider IDs; provider encounters by month |
| **CM-21b: ICD-10 Suggestion Match Rate** | Financial / Quality | % of Suki-suggested ICD-10 codes that appear in final billed codes — a direct accuracy measure | Suki-generated ICD-10 codes (`structured-data` endpoint); session completion status; encounter ID (join key to EHR) | Final billed ICD-10 codes per encounter; encounter-to-claim linkage. *Note: this measure goes beyond what Suki is currently pulling from EHR partners and requires a dedicated pipeline linkage.* |
| **CM-21c: Claim Denial Rate** | Financial / Quality | % of Level 4–5 claims denied — proxy for coding accuracy and documentation quality | Provider ID → Suki user flag; adoption date | Denied Level 4–5 claim count (`denial_l45_count`); total Level 4–5 claims submitted (`total_l45_submitted`); full E/M code counts needed for denominators; provider IDs |
| **CM-22: Patient Volume and Throughput** | Operational | Change in completed encounters per provider per day or month | Provider ID → Suki user flag; adoption date; session count (to define active-use periods) | Total closed encounters (`total_encounters`); avg completed encounters per working day (`encounters_per_day`); provider IDs; provider specialty; limited to eligible providers & settings |
| **CM-04: Documentation Time** | Operational | Change in average documentation time per encounter | Provider ID → Suki user flag; adoption date | Avg documentation time per encounter in minutes (`avg_doc_time_min`); provider IDs; provider encounters by month |
| **CM-05: After-Hours Documentation** | Operational | Change in time spent documenting outside business hours ("pajama time") | Provider ID → Suki user flag; adoption date | After-hours EHR time per provider per month (`after_hours_min`); total login time; provider IDs; provider encounters by month |
| **CM-07: Total EHR Time** | Operational | Change in total time providers spend in the EHR per month | Provider ID → Suki user flag; adoption date | Avg total provider time per encounter (`avg_total_time_min`); business-hours EHR time per provider per month (`business_hours_min`); total inbox time per provider per month (`inbox_time_hrs`); provider IDs; provider encounters by month |

---

## Notes by Measure

**CM-20a/b (wRVU and Revenue):** These are the same underlying financial story at two levels of specificity. `wrvu_total` is the work-value denominator; `revenue_paid` is the dollar translation. Both are already in Suki's EHR pull. Adjusted net revenue is preferred over gross for `revenue_paid`.

**CM-20c (E/M Level Improvement):** The key calculation is the change in percentage of visits coded at Level 4 or 5. Numerator: count of Level 4 + Level 5 encounters. Denominator: total E/M visits (`em_total_count`). Full per-level counts are needed even though the summary stat is just the high-complexity share. `icd10_codes_per_enc` can serve as an additional proxy — higher average ICD count per encounter suggests more complete documentation, which tends to support higher E/M levels.

**CM-21a (ICD-10 Coding Depth):** This is the proxy measure available from Suki's current EHR pull. Average number of ICD-10 codes per encounter increases when documentation is more complete. It is not a direct accuracy measure but is what Suki can compute with currently available data.

**CM-21b (ICD-10 Match Rate):** This is the direct accuracy measure — requires Suki's AI-generated diagnosis codes from the `structured-data` API endpoint matched against final billed ICD-10 codes. This goes beyond the current EHR data pull and requires a dedicated pipeline step. *Confirm with Amita whether EHR clients are providing encounter-to-claim linkage.* Note: Suki may return IMO codes rather than ICD-10 directly; an IMO → ICD-10 mapping step may be required before comparison.

**CM-21c (Denial Rate):** Placed under CM-21 because denial is primarily a coding quality outcome. Also relevant to CM-20 (financial impact of denials). Focused on Level 4–5 claims specifically — these are the high-complexity encounters where documentation quality most influences coding accuracy and therefore denial risk.

**CM-22 (Encounters/Week):** Suki's EHR pull provides both `total_encounters` (monthly count) and `encounters_per_day` (daily average). Note: in the "From SUKI" data, E/M level counts are also mapped to CM-22 — this reflects the throughput story that as providers see more patients, encounter volume by level changes. The simpler `total_encounters` or `encounters_per_day` is the primary unit.

**CM-04 (Documentation Time):** `avg_doc_time_min` is already in Suki's EHR pull across all four EHR platforms. This is a direct measure of the time burden Suki is meant to reduce. Should decrease post-adoption.

**CM-05 (After-Hours Documentation):** `after_hours_min` is available from Epic, Cerner, Meditech, and Athena. Athena provides more granular breakdowns (`after_hours_encounter_time`, `after_hours_inbox_time`). Should decrease post-adoption. Numerous aliases in the literature ("pajama time," "after-hours EHR use," "off-hours documentation burden") — `after_hours_min` standardized to per-provider per-month is the preferred unit.

**CM-07 (Total EHR Time):** Inclusive of business-hours EHR time, inbox time, orders, and messaging. Epic specifically provides `inbox_time_hrs` separately; Athena provides `business_hours_inbox_time` and `after_hours_inbox_time`. Should decrease post-adoption, though the inbox component may be less sensitive to ambient documentation than documentation time itself.

---

## What Suki Already Has (Summary)

For nine of the ten rows, Suki's contribution is:
1. **Provider Suki user flag** — which provider IDs are Suki users in a given measurement window
2. **Adoption date** — date of each provider's first completed session; defines the pre/post boundary
3. **Session count** — for active-use period filtering (CM-22 primarily)

The exception is CM-21b (ICD-10 Match Rate), where Suki also contributes AI-generated diagnosis codes from the `GET /session/{id}/structured-data` endpoint. This measure requires additional pipeline work beyond the current EHR data pull.

The EHR fields listed in the table (e.g., `wrvu_total`, `avg_doc_time_min`, `total_encounters`) are already part of Suki's data pull from Epic, Cerner, Meditech, and Athena partners. The mapping task is connecting these fields to canonical measures and computing pre/post deltas.

---

## HCC Capture Rate (Deferred)

HCC capture rate was identified in earlier spec drafts as a CM-21 sub-measure. It is **not** in Suki's current EHR data pull and is not addressed in the crosswalk. `ma_patient_count` (Medicare Advantage patient count by provider by month) is available from Epic and Athena, which is relevant context for HCC-eligible populations, but the HCC capture calculation itself requires ICD-10 → HCC v28 mapping applied to final billed codes — a step not currently in the pipeline.

This should be flagged to Amita as an aspirational add once the core measures are live.

---

## Literature Benchmarks (for calibration)

| Measure | Benchmark Finding | Source |
|---|---|---|
| CM-20a: wRVU delta | +1.81 wRVUs/week ≈ +$3,044/provider/year | Holmgren 2026 (UCSF) |
| CM-20b: Broader revenue | +$13,049/provider/year (includes HCC and E/M gains) | Boyter/KLAS 2025 |
| CM-20c: E/M level | +$1,907/provider/year from E/M level improvement | Boyter/KLAS 2025 |
| CM-21c: Denial rate | No increase in denial rate post-adoption | Holmgren 2026 |
| CM-22: Encounters/week | +0.80 encounters/week (statistically significant) | Holmgren 2026 |
| CM-04: Documentation time | Significant reductions reported across multiple studies | Tierney 2024, Ma 2025, others |
| CM-05: After-hours documentation | Significant reduction in pajama time reported | Olson 2025, Duggan 2025 |

---

*CM Data Crosswalk | v1.1 | 2026-05-13 | Validated against Measures_suki_ehr_crosswalk.xlsx | Internal working document — Suki IP*
