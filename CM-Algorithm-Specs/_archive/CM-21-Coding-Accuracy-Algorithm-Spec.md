# CM-21 — Coding Accuracy Algorithm Spec
**Category:** Financial  
**Status:** First draft — for review with Katie, then Amita/Sudha  
**Canonical measure:** Accuracy and completeness of AI-supported ICD-10, HCC, and E/M codes

---

## What This Measures

Whether the diagnosis and billing codes that Suki generates from an encounter match the codes that the physician ultimately bills — and whether Suki's documentation supports capturing the full complexity of the encounter. Better ambient documentation should surface diagnoses more reliably, reduce undercoding, and produce notes that support higher-accuracy billing without increasing denial rates.

**Primary unit:** % of Suki-suggested ICD-10 codes that match the final billed codes, per encounter  
**Reporting grain:** Per provider, per period (monthly or quarterly); rolled up to health system  
**Direction:** Higher = better (for match rate); lower = better (for denial rate)

---

## Tiered Ascertainment Methods

### Tier 1 — Realistic & Solid ✓ (data-driven ICD-10 match rate)

**What it requires:** Suki structured data + EHR final billed ICD-10 codes, linked by encounter ID

**Data elements:**
| Element | Source | Suki Field / EHR Field |
|---|---|---|
| Suki-suggested ICD-10 codes | `GET /session/{id}/structured-data` | `structured_data.diagnoses.values[].codes[]` where `.type = "ICD-10"` (or map from IMO) |
| Encounter linkage | Suki session → EHR | `encounter_id` passed at session create |
| Final billed ICD-10 codes | EHR claim record | Billed diagnosis code list, post-physician sign-off |
| Session completion status | `GET /session/{id}/status` | `status = "completed"` — filter out skipped/failed sessions |

**Pseudocode:**
```
For each completed Suki session s linked to encounter e:

  suki_codes  = set of ICD-10 codes from structured-data for session s
                [note: Suki may return IMO codes; confirm whether ICD-10 is available
                 directly or requires IMO → ICD-10 mapping step]

  billed_codes = set of final billed ICD-10 codes from EHR claim for encounter e

  IF billed_codes is empty: skip encounter (claim not yet processed)

  match_rate_e = |suki_codes ∩ billed_codes| / |billed_codes|
                 [% of billed codes that Suki also suggested]

REPORT:
  ICD_Accuracy_Rate = AVG(match_rate_e) across all encounters in period
  [Filter: completed sessions only; exclude encounters with no linked claim;
   exclude encounters within provider's first 30 days on Suki (onboarding ramp)]
```

**Example:** Provider has 100 encounters. On average, Suki suggested 3 ICD codes and the physician billed 3. Across encounters, 2.5 of those 3 billed codes were in Suki's suggestion set → ICD Accuracy Rate = 83%.

**Limitation:** Match rate measures overlap, not whether Suki's suggestions were *correct*. A physician who ignores Suki and codes independently will show a low match rate even if both are accurate. Interpret alongside denial rate.

---

### Tier 2 — Aspirational / Ideal (expert coder audit)

**What it requires:** Certified coder review of a sampled set of encounters

**Data elements:**
| Element | Source |
|---|---|
| Suki-generated note content | `GET /session/{id}/content` — full note with `source_transcripts[]` |
| Suki-suggested codes | `GET /session/{id}/structured-data` |
| Final signed note (for comparison) | EHR note text, post-physician edits |
| Coder rating | Manual rubric: does the documentation support the codes billed? |

**Pseudocode:**
```
Sample N encounters (recommend N ≥ 50 for pilot)

For each encounter e in sample:
  coder_rating_e = certified coder assessment of:
    (a) Are Suki-suggested codes supported by note content?  [Y/N per code]
    (b) Are there additional codes the note supports that were not billed?  [list]
    (c) Is the E/M level supported by documentation complexity?  [Y/N]

REPORT:
  Coding_Compliance_Rate = % encounters rated as fully accurate by coder
  Undercoding_Rate       = % encounters where coder identified missed billable codes
  EM_Support_Rate        = % encounters where documentation supports billed E/M level
```

**Why it's Tier 2:** Requires labor-intensive manual review. Not scalable for continuous monitoring, but appropriate for periodic validation studies (e.g., annual audit) or initial calibration of Tier 1.

---

### Tier 3 — Minimal / Fallback (provider self-report)

**What it requires:** Provider survey; no EHR data needed

**Survey item:**
> "How often do Suki's suggested diagnosis codes match the codes you ultimately bill?"  
> (1) Never — (2) Rarely — (3) Sometimes — (4) Usually — (5) Almost always

**Pseudocode:**
```
REPORT:
  % of providers responding "Usually" or "Almost always"
  Mean Likert score across respondents
  [Filter: providers with ≥ 4 weeks of Suki use at time of survey]
```

**Why it's Tier 3:** Subjective, imprecise, and cannot be trended on a real-time dashboard. Use only when EHR data sharing is not yet in place, or as a supplemental signal alongside Tier 1.

---

## Companion Indicators (same data, additional signal)

These can be computed from the same Tier 1 data pipeline without additional data requests:

| Indicator | Formula | Unit |
|---|---|---|
| **HCC capture rate** | Map final billed ICD-10 → HCC v28; count unique HCCs per encounter | Avg HCCs per encounter |
| **HCC capture delta** | Avg HCCs post-Suki minus avg HCCs pre-Suki (same provider cohort) | Δ HCCs per encounter |
| **E/M level (avg)** | Average CPT E/M level (99211=1 … 99215=5) per provider per period | Avg E/M level (1–5 scale) |
| **E/M level delta** | Avg E/M level post minus pre, normalized for case mix | Δ E/M level |
| **Claim denial rate** | Denied encounters / total encounters | % denied |

*Recommend surfacing ICD accuracy rate as the primary admin console metric; offer HCC delta and E/M delta as secondary metrics for customers who track risk adjustment or billing revenue.*

---

## Open Questions for Suki

1. Does Suki's `structured-data` endpoint return ICD-10 codes directly, or IMO codes that require a separate crosswalk to ICD-10? (Field `.type` appears to return "IMO" in the example — clarify.)
2. Is the `encounter_id` reliably populated at session creation, or is it often absent? This is the critical join key to the EHR claim record.
3. Does Suki retain `structured-data` indefinitely, or is there a retention window (like the 30-day audio limit)?
4. For HCC computation: does Suki have the CMS HCC v28 mapping table internally, or would Amita's pipeline apply the crosswalk?
5. Sudha noted Suki has recently redesigned note quality evaluation processes — does that affect how ICD-10 codes are generated or surfaced? Any changes to the `structured-data` response expected?

---

## Literature Anchors

| Finding | Source | Relevance |
|---|---|---|
| Coding accuracy improvement (p<0.001) | Afshar 2025b (RCT) | Validates that ambient AI improves coding; supports Tier 1 as meaningful metric |
| No increase in claim denial rate | Holmgren 2026 | Coding improvement is legitimate capture, not upcoding |
| +$9,685/provider/year (HCC) | Boyter/KLAS 2025 | Benchmark for HCC companion indicator |
| +$1,907/provider/year (E/M level) | Boyter/KLAS 2025 | Benchmark for E/M level companion indicator |
| ICD accuracy baseline ~35% (pre-AI ML) | Suki ROI draft | Starting point; Suki's internal target is >90% |

---

*CM-21 Coding Accuracy | Algorithm Spec v0.1 | 2026-05-06 | Internal draft — Suki IP*
