# CM-20 Financial Productivity and Revenue Impact
## Canonical Measure Report — Internal Draft

**Measures covered:** CM-20 Financial Productivity and Revenue Impact (primary); boundary with CM-21 (Coding Accuracy)
**Status:** Internal draft for review and editing before sharing externally — **see "The Societal Spending Caveat" before using CM-20 figures in external-facing ROI materials**

---

## What This Measure Captures

**CM-20 Financial Productivity and Revenue Impact** is the change in physician financial productivity associated with ambient AI scribe use — captured organizationally, not individually, as RVU changes, revenue per clinician per year, or ROI. The [algorithm card](../CM-20-Financial-Productivity.html) defines three parallel operationalizations:

| Sub-measure | Unit | What it captures |
|---|---|---|
| CM-20a — wRVU Output | wRVUs per provider per week | Billed work-intensity, independent of dollar conversion |
| CM-20b — Billing Revenue | Adjusted net revenue per provider per month ($) | The dollar outcome of wRVU and coding changes |
| CM-20c — E/M Level Improvement | % of encounters at Level 4–5 | The coding-complexity-capture mechanism behind a, b |

**Why this matters for Suki's value story:** Three independent papers show financial productivity improvement — Holmgren 2026 (+0.04 wRVU/encounter, +1.81 wRVU/week, ≈$3,044/provider/year, UCSF, **with no increase in denials**) and Boyter/KLAS 2025 (+$13,049/provider/year combined, **mostly from HCC capture** [+$9,685] with a smaller E/M-level-gain component [+$1,907]). The Holmgren "no denial increase" detail is important — it is the closest the corpus comes to addressing the "is this overcoding or legitimate capture?" question for CM-20 specifically.

---

## The Societal Spending Caveat

This section comes first because it should shape how CM-20 is framed in any external-facing material — it is the financial-productivity analog to CM-03's "not a near-term priority" framing and CM-19's "scope narrowing."

**PHTI 2025's concern, stated directly:** *even accurate higher coding increases healthcare system spending.* If Suki helps a provider capture HCC codes or E/M levels that more accurately reflect patient complexity, that is a **legitimate documentation-completeness improvement** (and arguably a CM-08/CM-21 win) — but it also means **more dollars flow through the system overall**. The individual health system's ROI (more revenue) and the payer/societal interest (lower total spend) can point in **opposite directions** for the same underlying change.

**Practical implications:**
- CM-20 figures (especially CM-20b, dollar revenue) are legitimate and valuable **from the customer's perspective** — they answer "what does this tool do for our bottom line."
- They should **not** be presented as a population-health or "lowers healthcare costs" claim without qualification — the literature explicitly does not support that framing, and PHTI 2025 raises it as a tension, not a resolved question.
- **CM-20c should always be read alongside CM-21's denial-rate measure** (per the algorithm card's explicit cross-reference): rising E/M levels with rising denials suggests overcoding; rising E/M levels with stable/falling denials (the Holmgren pattern) suggests legitimate complexity capture. CM-20 alone cannot distinguish these.

---

## Current Suki Hooks and Data Available

### What Suki exposes natively (H1, H3, H9)

| Artifact | API endpoint | What it enables |
|---|---|---|
| Session creation logs / adoption date | `GET /session/{id}/status` (aggregated) | Pre/post adoption boundary for all three CM-20 sub-measures |
| Active usage flag (monthly) | `GET /session/{id}/status` | Monthly active-provider denominator, as in CM-04/05/07 |
| Session timestamps | `GET /session/{id}/transcript` / status | Optional within-week active-use period definition |
| Structured diagnoses / PBC output (ICD-10/IMO codes) | `GET /session/{id}/structured-data` | Plausibly correlated with wRVU/E/M-level changes via the coding-completeness mechanism — but see the structural gap below |

### Measurement supported right now

- **Adoption boundary, active-usage flag, and session-timestamp scaffolding** — per the algorithm card's "Suki Data Scope" box: *"The value Suki provides to this measure is the adoption boundary (first session date), the active usage flag (monthly denominator), and the session timestamp... These inputs are necessary to construct the pre/post comparison but do not constitute the outcome signal."* This is the same role Suki plays for CM-05 and CM-07.
- **No direct measurement of any CM-20 sub-measure.** wRVUs, billing codes, revenue collected, and E/M level distributions all reside in the EHR and RCM system — **Suki has no visibility into billing workflows**, per the algorithm card.

---

## Missing or Aspirational Hooks

| Missing capability | Why it matters |
|---|---|
| **Any linkage between Suki's structured-data output and the billed code that actually results** | Suki generates structured ICD-10/IMO codes (PBC), but has no visibility into whether/how these translate into the codes that are actually *billed* — the step where wRVU and E/M-level outcomes are determined. Without this, the PBC output is a candidate *leading indicator* for CM-20, but an untested one. |
| **Coding-acceptance/edit signal** | If a clinician accepts, edits, or rejects Suki's suggested codes before billing, that acceptance rate would be the most direct Suki-native predictor of whether PBC output is likely to affect CM-20 outcomes — this is the same gap noted in the CM-21 boundary below |

---

## EHR-Side Data Needed

CM-20 is **entirely EHR/RCM-telemetry-dependent** for its outcome signal — Suki's role is scaffolding only, as with CM-05/CM-07.

| Data element | Purpose | Vendor examples / Notes |
|---|---|---|
| `wrvu_total` (per provider, aggregated weekly) | CM-20a primary field | EHR/billing system wRVU export |
| `revenue_paid` (adjusted net, per provider per month) | CM-20b primary field | EHR claims/RCM system. **Use adjusted net, not gross charges** — gross misleads under payer-mix shifts |
| `em_new_level4_count`, `em_est_level4_count`, `em_new_level5_count`, `em_est_level5_count`, `em_total_count` | CM-20c numerator/denominator | EHR billing export, full per-level counts needed for accurate denominator |
| Denial rate (from CM-21) | Required cross-reference for interpreting CM-20c | EHR/RCM denial data |
| Provider specialty, employment-status changes during the window | Exclusion criteria — providers who changed specialty/site/employment should be excluded from the pre/post comparison | HR/credentialing data |

---

## Boundary with CM-21 (Coding Accuracy)

Two CM-20 aliases were explicitly **moved from CM-21** in the canonical measures corpus: "Revenue Impact of HCC Capture" (+$9,685/year, Boyter/KLAS) and "Revenue Impact of E/M Level Improvement" (+$1,907/year, Boyter/KLAS). The stated rationale: **"dollar value of coding inaccuracy/improvement is financial impact"** — i.e., CM-21 measures whether coding is *accurate/complete*, and CM-20 measures the *dollar consequence* of that accuracy/completeness.

This means a single underlying mechanism (Suki's structured coding output improving documentation completeness) potentially feeds **both** CM-21 (as a rate/accuracy measure) and CM-20 (as a dollar measure) — and any Suki-native signal relevant to one (e.g., PBC code-acceptance rate) is likely relevant to the other. Evaluation planning for CM-20 and CM-21 should be coordinated rather than scoped independently.

---

## The Coding-to-Billing Visibility Gap

This is the central structural gap for CM-20 — structurally similar to CM-05/CM-07's "Suki sees adoption boundary, not the outcome," but with a candidate leading indicator (PBC structured output) that the others lack.

```
Suki PBC output: structured ICD-10/IMO codes generated per session
                            │
                    [missing link]
        Code acceptance/edit by clinician → code submitted for billing
        → wRVU assigned → claim adjudicated → revenue collected/denied
                            │
                            ▼
              CM-20a (wRVU) / CM-20b (revenue) / CM-20c (E/M level share)
```

**What is achievable today:** Suki generates the structured-data output that is the *first step* of this pipeline, and provides the adoption-boundary/cohort scaffolding needed for any EHR-side pre/post comparison.

**What is missing:** Every step from "code generated by Suki" to "dollars collected" — acceptance/editing, submission, adjudication, and collection — happens entirely outside Suki's visibility. A CM-20 finding therefore cannot currently be attributed to a specific Suki mechanism; it can only be reported as a site-level pre/post association, with Suki adoption as the boundary marker.

**Implication for reporting:** CM-20 should be reported as **"associated with Suki adoption"** rather than **"caused by [specific Suki feature]"** until the acceptance/edit-rate linkage (noted under Missing or Aspirational Hooks) is available — at which point a mechanism-level claim (e.g., "PBC code suggestions with X% acceptance rate are associated with Y wRVU change") would become possible.

---

## Open Questions for Suki

1. Is there any per-session data on whether a clinician accepted, edited, or rejected Suki's PBC-suggested codes before they were submitted for billing? This is the single highest-value missing link for connecting Suki's structured output to CM-20 outcomes.
2. For sites where EHR billing/RCM data (`wrvu_total`, `revenue_paid`, E/M level counts) is available, would Suki's team be willing to coordinate a combined CM-20/CM-21 data request, given the shared underlying mechanism noted above?
3. Does Suki have access to denial-rate data (CM-21) for any site where CM-20 data is also available, to support the recommended joint CM-20c/CM-21 interpretation?
4. Given the Holmgren 2026 "no denial increase" finding, would Suki's team be interested in replicating that specific pairing (wRVU/revenue increase + denial rate stable) as a template for a credible CM-20 claim that pre-addresses the overcoding concern?
5. Is there any internal Suki data (even informal) on PBC code-suggestion volume or acceptance rates from prior pilots that could serve as a leading indicator while EHR billing data access is being arranged?

---

*CM-20 Financial Productivity and Revenue Impact | Canonical Measures | Organizational Impact dimension*
*Internal draft — June 2026*
