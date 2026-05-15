# CM Data Crosswalk: Suki Inputs vs. EHR Inputs
**Created:** 2026-05-13 | **Owner:** Joe Amlung  
**Purpose:** For each priority canonical measure, identify what data Suki already has vs. what must come from the EHR partner. This is the primary deliverable for Amita and Sudha.

---

## How to Read This Table

**Implied comparison for all measures:** Pre-Suki vs. post-Suki, per provider. The pre/post boundary is defined by each provider's first completed Suki session (adoption date).

**Universal Suki input (applies to every row):** A provider-level flag linking a provider ID to their Suki adoption status and adoption date. For most measures below, this is the only Suki contribution — the EHR provides everything else.

**What Suki needs to ask partners for:** The EHR inputs column is the ask list for health system data-sharing agreements.

---

## The Crosswalk

| Canonical Measure | Category | What You're Measuring | Suki Inputs | EHR Inputs Required |
|---|---|---|---|---|
| **CM-20a: wRVU Output** | Financial | Change in work RVUs billed per provider per week | Provider ID → Suki user flag; adoption date (first completed session) | Billed CPT code per encounter; CMS wRVU weight table (PFS); completed encounter count per provider per week; provider specialty; scheduled clinical hours |
| **CM-20b: Revenue per Clinician** | Financial | Dollar translation of wRVU delta | Same as CM-20a | Same as CM-20a plus Medicare conversion factor (CMS, updated annually) |
| **CM-20c: Claim Denial Rate** | Financial | % of claims denied pre vs. post Suki adoption | Provider ID → Suki user flag; adoption date | Denied encounter count; total submitted encounter count; denial reason codes (to separate coding-related denials) |
| **CM-21a: ICD-10 Suggestion Match Rate** | Financial | % of Suki-suggested ICD-10 codes that appear in final billed codes | Suki-suggested ICD-10 codes (`structured-data` endpoint); session completion status; encounter ID (join key to EHR) | Final billed ICD-10 codes per encounter; encounter-to-claim linkage |
| **CM-21b: HCC Capture Rate** | Financial | Change in HCC-mappable diagnoses captured per encounter | Provider ID → Suki user flag; adoption date | Final billed ICD-10 codes; CMS HCC v28 mapping table; provider ID |
| **CM-21c: E/M Level** | Financial | Change in average E/M CPT complexity level billed | Provider ID → Suki user flag; adoption date | E/M CPT code per encounter (99211–99215); provider ID |
| **CM-22: Encounters per Week** | Operational | Change in completed patient encounters per provider per week | Provider ID → Suki user flag; adoption date; session count per week (to filter active-use weeks) | Completed encounter count per provider per week; provider ID; provider specialty; scheduled clinical hours (for part-time normalization) |

---

## Notes by Measure

**CM-20a/b (wRVU and Revenue):** The math is straightforward once CPT data are available — billed CPT code → CMS wRVU weight → weekly sum → pre/post delta. The question is whether Amita's pipeline currently receives billed CPT codes or only encounter counts. CPT is required; encounter count alone is not enough.

**CM-20c (Denial Rate):** Denial reason codes are important — a coding-related denial is different from an administrative one. Without reason codes, the denial rate is a blunt instrument.

**CM-21a (ICD-10 Match Rate):** This is the one measure where Suki contributes substantive data beyond the user flag. Suki generates diagnosis codes from the ambient session; the question is whether those codes are ICD-10 directly or IMO codes that require a mapping step before comparison to billed ICD-10. Confirm with Amita.

**CM-21b (HCC Capture):** HCC capture requires applying the CMS HCC v28 crosswalk to final billed ICD-10 codes. The HCC mapping table is publicly available. The data element is the same as CM-21a (final billed ICD-10); the analysis step differs.

**CM-21c (E/M Level):** Simplest of the CM-21 suite. E/M CPT code is a single field per encounter. Average level pre vs. post is a direct comparison.

**CM-22 (Encounters/Week):** Suki's contribution is the user flag and adoption date. The encounter count itself is entirely from the EHR. Normalizing for scheduled clinical hours is recommended if part-time providers are included.

---

## What Suki Already Has (Summary)

For five of the seven rows, Suki's contribution is the same two things:
1. **Provider Suki user flag** — which provider IDs are Suki users in a given measurement window
2. **Adoption date** — date of each provider's first completed session; defines the pre/post boundary

The exception is CM-21a, where Suki also contributes the **AI-generated diagnosis codes** from the `GET /session/{id}/structured-data` endpoint.

Everything else — CPT codes, encounter counts, billed diagnoses, claim status — must come from the EHR.

---

## Literature Benchmarks (for calibration)

| Measure | Benchmark Finding | Source |
|---|---|---|
| CM-20a: wRVU delta | +1.81 wRVUs/week ≈ +$3,044/provider/year | Holmgren 2026 (UCSF) |
| CM-20b: Broader revenue | +$13,049/provider/year (includes HCC and E/M gains) | Boyter/KLAS 2025 |
| CM-20c: Denial rate | No increase in denial rate post-adoption | Holmgren 2026 |
| CM-21b: HCC capture revenue | +$9,685/provider/year | Boyter/KLAS 2025 |
| CM-21c: E/M level revenue | +$1,907/provider/year | Boyter/KLAS 2025 |
| CM-22: Encounters/week | +0.80 encounters/week (statistically significant) | Holmgren 2026 |

---

*CM Data Crosswalk | v1.0 | 2026-05-13 | Internal working document — Suki IP*
