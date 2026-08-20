# CM-21 Coding Accuracy (ICD-10, HCC, and E/M)
## Canonical Measure Report — Internal Draft

**Measures covered:** CM-21 Coding Accuracy (primary, three operationalizations); boundary with CM-20 (Financial Productivity and Revenue Impact)
**Status:** Internal draft for review and editing before sharing externally — **see "The Encounter-to-Claim Linkage Opportunity" for the most directly Suki-attributable measure in this entire report series**

---

## What This Measure Captures

**CM-21 Coding Accuracy** is whether clinical documentation supports correct, complete coding of the encounter — ICD-10 diagnosis codes, HCC capture for risk adjustment, and E/M coding level. It explicitly **bridges Information Quality (note quality sufficient for accurate coding) and Net Benefits (coding accuracy drives revenue and population-health metrics)**. The [algorithm card](../CM-21-Coding-Accuracy.html) defines three operationalizations:

| Sub-measure | Unit | Direction | Suki's role |
|---|---|---|---|
| Algorithm 1 — ICD-10 Coding Depth | ICD-10 codes per encounter | ↑ Higher is better (completeness proxy) | Adoption boundary / cohort only — EHR field `icd10_codes_per_enc` |
| **Algorithm 2 — ICD-10 Suggestion Match Rate** | % of Suki-suggested codes appearing in final billed codes | ↑ Higher is better | **Suki provides the primary data** — the only CM-21 algorithm where this is true |
| Algorithm 3 — Claim Denial Rate (Level 4–5) | % of L4–5 claims denied | ↓ Lower is better (payer validation) | Adoption boundary / cohort only — RCM fields `denial_l45_count`, `total_l45_submitted` |

**Why this matters for Suki's value story:** Coding improvement is **"one of the most consistent findings"** in the corpus — Afshar 2025b (RCT, n=66, p<0.001), Boyter/KLAS 2025, and Holmgren 2026 all show it. Critically, **Holmgren 2026 found NO increase in denial rate** alongside the coding improvement — the corpus's strongest available evidence that the improvement is *legitimate documentation of existing complexity*, not upcoding. As with CM-20, PHTI 2025 still flags the population-level cost concern regardless of legitimacy.

---

## The Encounter-to-Claim Linkage Opportunity

This is the central narrative for CM-21 — and arguably the single most actionable item across all CM reports produced so far, because it is the **one place where Suki's own output can be directly validated against ground truth**.

**The opportunity:** Algorithm 2 compares Suki's AI-generated ICD-10 codes (from `GET /session/{id}/structured-data`) directly against the final billed codes for the same encounter. Unlike every other algorithm in CM-20/CM-21 — where Suki only provides cohort/adoption scaffolding around an EHR-side outcome — **Algorithm 2's primary data point originates from Suki itself**. A high match rate is a direct, self-contained demonstration of Suki's coding-suggestion quality; a target of ~85–90% at maturity is suggested by the algorithm card, with the explicit caveat that 100% would actually be a *bad* sign (it would mean codes are accepted without clinical review).

**What's required and currently missing:**
1. **Encounter-to-claim linkage** — the algorithm card states plainly: *"Requires encounter-to-claim linkage between the Suki API and EHR claims records — not part of the standard Suki EHR data pull."* An encounter ID must be passed to Suki at session creation and preserved through to the claim record.
2. **IMO → ICD-10 mapping** — Suki may return IMO (Intelligent Medical Objects) codes rather than ICD-10 directly; these need to be mapped before comparison.

```
GET /session/{id}/structured-data ──► Suki-suggested codes (possibly IMO)
                                              │
                                      [missing link 1]
                                  IMO → ICD-10 mapping
                                              │
                                      [missing link 2]
                            encounter-to-claim linkage (join key)
                                              │
                                              ▼
                              EHR claim record: final billed ICD-10 codes
                                              │
                                              ▼
                          Match rate = |Suki codes ∩ billed codes| / |billed codes|
```

**What is achievable today:** Suki already generates the structured-coding output (the left side of the pipeline) for every session with PBC enabled.

**What is missing:** Both the mapping step and the linkage step are pipeline/integration work, not new product capability — this distinguishes CM-21's Algorithm 2 from most "missing hooks" elsewhere in this report series, which require new product features. Here, the data largely exists on both sides; what's missing is the *join*.

**Why this is worth prioritizing:** every other "Suki contribution" in CM-20/CM-21 is scaffolding (adoption date, active-usage flag) around an outcome Suki cannot see or influence directly. Algorithm 2 is the one metric where "Suki's suggestions were right X% of the time" is both **true on its face** and **the actual measure** — making it unusually well-suited as a first deliverable for any coding-accuracy evaluation.

---

## Current Suki Hooks and Data Available

### What Suki exposes natively (H1, H3, H9)

| Artifact | API endpoint | What it enables |
|---|---|---|
| Structured ICD-10/IMO codes per session | `GET /session/{id}/structured-data` | The primary data source for Algorithm 2 — Suki's own coding suggestions |
| Session creation logs / adoption date | `GET /session/{id}/status` (aggregated) | Pre/post boundary for Algorithms 1 and 3 (cohort scaffolding only) |
| Active usage flag (monthly) | `GET /session/{id}/status` | Active-provider denominator across all three algorithms |

### Measurement supported right now

- **Algorithm 2 inputs exist on the Suki side today** — the structured-data endpoint returns per-session coding suggestions; what's missing is the linkage/mapping described above, not the underlying data generation.
- **Algorithms 1 and 3 — cohort scaffolding only**, identical role to CM-20: adoption date and active-usage flag, with the actual coding-depth and denial-rate data residing entirely in EHR/RCM systems.

---

## Missing or Aspirational Hooks

| Missing capability | Why it matters |
|---|---|
| **Encounter ID pass-through at session creation** | The foundational requirement for Algorithm 2 — without an encounter ID attached to each Suki session, there is no way to later join Suki's suggested codes to the corresponding claim |
| **IMO → ICD-10 mapping step** | If Suki's structured-data output returns IMO codes, this mapping must happen before any match-rate computation — likely a one-time engineering task rather than ongoing data access |
| **Code-acceptance/edit signal (shared with CM-20)** | As noted in the CM-20 report, knowing whether a clinician accepted/edited/rejected a suggested code before billing would let Algorithm 2 distinguish "Suki was right" from "Suki was wrong but the clinician corrected it before submission" — both currently collapse into the same match/non-match result |

---

## EHR-Side Data Needed

| Data element | Purpose | Vendor examples / Notes |
|---|---|---|
| Final billed ICD-10 codes per encounter | Algorithm 2's comparison target | EHR claim record (all vendors) — requires the encounter-to-claim linkage above |
| `icd10_codes_per_enc` | Algorithm 1 primary field | Epic/Cerner `icd10_codes_per_enc` |
| `denial_l45_count`, `total_l45_submitted` + denial reason codes | Algorithm 3 — must be filtered to coding-related denials specifically (not authorization/eligibility) | Epic `denial_l45_count`/`total_l45_submitted`; Cerner/Athena claims system varies |
| E/M level counts (new + established) | Denominator for Algorithm 3 if claims system doesn't provide a pre-filtered L4–5 total | Epic/Cerner E/M level count fields |

---

## Boundary with CM-20 (Financial Productivity)

As noted in the CM-20 report, two dollar-valued items (HCC capture revenue, E/M-level-improvement revenue) were moved **from** CM-21 **to** CM-20 — CM-21 retains the underlying **rate/accuracy** metrics (coding depth, match rate, denial rate), while CM-20 owns the **dollar consequence**. Practically: **Algorithm 2's match rate is the leading indicator for both measures** — if Suki's suggestions reliably match what gets billed, that is evidence both for CM-21 (accuracy) and, via the coding-completeness mechanism, for CM-20 (revenue). A combined CM-20/CM-21 data request (as recommended in the CM-20 report) would let Algorithm 2's match-rate data serve both purposes.

---

## Open Questions for Suki

1. Is encounter ID already passed to Suki at session creation in any current integration, or would this require a new field in the session-creation API?
2. Does the structured-data endpoint return IMO codes, ICD-10 codes directly, or both — and if IMO, is a mapping table to ICD-10 already maintained internally that could be reused?
3. For any site where Suki has previously had access to claims data (even for a different purpose), is encounter-to-claim linkage already solved, or would this be greenfield for every new site?
4. Given that Algorithm 2 is the one CM where Suki's own output is the primary signal, would Suki's product/research team be interested in prioritizing a small-scale pilot (e.g., one site, 90 days) specifically to compute a real match-rate number — even before broader CM-20/21 EHR data access is arranged?
5. Is there any existing internal tracking of code-acceptance/edit rates (clinician accepts/edits/rejects a Suki-suggested code) that could substitute for, or complement, the claims-based match rate while the linkage pipeline is being built?

---

*CM-21 Coding Accuracy (ICD-10, HCC, and E/M) | Canonical Measures | Organizational Impact dimension*
*Internal draft — June 2026*
