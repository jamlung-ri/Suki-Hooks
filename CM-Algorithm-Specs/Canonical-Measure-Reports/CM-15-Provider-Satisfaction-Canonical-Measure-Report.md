# CM-15 Provider Satisfaction and Usability
## Canonical Measure Report — Internal Draft

**Measures covered:** CM-15 Provider Satisfaction and Usability (primary); CM-01 Clinician Burnout and Exhaustion (boundary — emotional/wellbeing outcome, not tool evaluation) and CM-14 Adoption Intention and Long-Term Use (boundary — stated future intent, covered separately)
**Status:** Internal draft for review and editing before sharing externally

---

## What This Measure Captures

**CM-15 Provider Satisfaction and Usability** is provider-reported satisfaction with the ambient AI scribe tool, including perceived usability, ease of use, and overall acceptability, most commonly measured via the System Usability Scale (SUS, 0–100, industry average ≈ 68) or ad hoc Likert satisfaction items.

It is distinct from two adjacent constructs:

| Construct | Canonical measure | What it captures |
|---|---|---|
| Emotional/wellbeing outcome | CM-01 — Clinician Burnout and Exhaustion | Exhaustion and disengagement, not evaluation of the tool itself |
| Stated future intent | CM-14 — Adoption Intention and Long-Term Use | Willingness to keep using the tool going forward — recommendation and long-term-use items were moved *into* CM-15 from CM-14 during corpus derivation, since they behave more like satisfaction than intention |

**Why this matters for Suki's value story:** Provider satisfaction is the most consistently positive finding in the entire corpus — 21 papers touch it, and results skew strongly favorable (Shah 2024: 65% report improved efficiency, 98% find it easy to use). But this consistency should be read with real caution. The corpus's own key note is explicit: most studies recruited volunteers or interested practitioners, inflating results relative to a representative sample. Prasad 2025 is the critical counter-signal — providers with under 2 years of virtual-scribe tenure showed satisfaction strongly *negatively* associated with tenure, the opposite of what a simple "it gets better with use" narrative would predict. Any satisfaction claim in Suki's value story should be paired with a note on sampling method (opt-in vs. mandatory/randomized), since that single design choice plausibly explains more variance across the corpus than any product difference.

---

## Current Suki Hooks and Data Available

Satisfaction and usability are **not directly observable from Suki's API** — like burnout, this is a provider-reported subjective evaluation. Suki's contribution is limited to the same utilization-cohort scaffolding used across this measure family, plus session-status data that offers a rough early-warning proxy for friction.

### What Suki exposes natively (H1)

| Artifact | API endpoint | What it enables |
|---|---|---|
| Session creation logs | `GET /session/{id}/status` (aggregated) | Sessions per provider per day/week — utilization intensity, the basis for dose-response cohorts |
| Session status | `GET /session/{id}/status` | `completed` vs. `skipped` vs. `failed` rate — a rough early-friction signal that may anticipate low usability ratings before survey results arrive |

### Measurement supported right now

- **Exposure/cohort definition** — stratify providers into heavy (≥70% utilization), moderate (30–69%), and light (<30%) users per the PHTI 2025 framework, for use as the independent variable in a satisfaction dose-response design
- **Early-friction screening** — skip/fail rate trends as a leading indicator worth investigating before survey data arrives

---

## Missing or Aspirational Hooks

| Missing capability | Why it matters |
|---|---|
| **In-app survey distribution** | No documented mechanism for Suki to push the SUS (or any satisfaction instrument) to providers at defined intervals |
| **Survey response capture/storage** | Even if surveys were distributed externally, Suki has no API for storing or linking responses to session-level utilization data |
| **Provider-level longitudinal identity across waves** | Needed to match an early-experience respondent to their mature-use follow-up without breaking survey anonymity |
| **Standardized cross-customer benchmark** | Suki has no aggregated, standardized SUS benchmark across its customer base — each deployment currently starts from zero |

---

## EHR-Side Data Needed

CM-15 is not an EHR-data measure. No EHR-side data element is required beyond, optionally, provider schedule/specialty data if a deployment wants to stratify satisfaction results by clinical setting.

---

## Survey Instruments and Administration

### Validated instruments (in priority order)

- **System Usability Scale (SUS)** — validated 10-item instrument, 5-point Likert per item, scored 0–100 via the standard adjustment-and-multiply-by-2.5 formula (industry average ≈ 68). The only formally named validated instrument in the corpus (Shah 2024) — recommended as the standard going forward given its cross-industry benchmark value.
- **UTAUT perceived-usefulness / perceived-ease-of-use constructs** — validated multi-item constructs, used in van Buchem 2024.
- **Ad hoc single- or multi-item Likert satisfaction scales** — the pattern actually used by roughly 20 of the 21 papers in the corpus; low burden, but not standardized or cross-study comparable.
- **Overall product preference (head-to-head)** — used in Lukac 2025's two-scribe RCT comparison; useful if Suki is being evaluated against a competing product, not for a standalone satisfaction score.

### Suggested evaluation design

1. **Wave 1 (early experience, weeks 4–8 post go-live):** Administer the SUS to all eligible providers. Unlike burnout, there is no meaningful pre-exposure baseline for a usability rating — this is the earliest point a genuine impression can form, not a "Phase 0."
2. **Weeks 1–16:** Track Suki utilization per provider; assign heavy/moderate/light cohorts by week 4.
3. **Wave 2 (mature use, months 4–9):** Repeat the SUS. Compare change scores across utilization cohorts (dose-response), not just pooled averages.
4. **Sampling:** Wherever feasible, use a mandatory or randomly-sampled respondent pool rather than opt-in recruitment — this is the single design choice most likely to determine whether the result looks like the (inflated) corpus average or something closer to Prasad 2025's counter-signal.
5. **Reporting:** Present the SUS score against the 68-point industry benchmark, and disclose the sampling method alongside any headline number.

LLM-as-judge methods do not apply to CM-15 — this is a self-report psychometric construct with no transcript or note artifact to evaluate.

---

## The Volunteer Sample Problem

This is the central structural gap for CM-15 — not a missing data pipeline, but a missing *representative sample*.

```
Opt-in / volunteer respondent pool ──────► Consistently high satisfaction (corpus average)
        │
        └────────────────────────── [missing counterfactual] ──────────────────────┐
                          mandatory or randomly-sampled respondent pool,               │
                          which would reveal the true population distribution          │
                          (Prasad 2025's negative tenure-satisfaction finding           │
                          suggests it would look meaningfully different)               ▼
                                                                          A more defensible, less
                                                                          inflated satisfaction estimate
```

**What is achievable today:** A satisfaction score from whichever respondent pool a deployment can reach — typically opt-in, given no in-app survey mechanism exists.

**What is missing:** A mechanism (in-app or otherwise) to reach a representative, non-self-selected sample of providers, including those who are dissatisfied enough to disengage before ever answering a survey.

Until this is addressed, any CM-15 result should be reported with its sampling method disclosed, and treated as an upper-bound estimate unless the respondent pool was mandatory or randomized.

---

## Open Questions for Suki

1. Does Suki (or Suki's customer success process) have any existing template or mechanism for administering the SUS (or a satisfaction survey) to providers post-deployment?
2. Can Suki provide provider-level session-status distributions (completed/skipped/failed rates) as an early-friction proxy to flag likely low-satisfaction segments before survey results arrive?
3. Does Suki have aggregate (de-identified) SUS or satisfaction results from prior customer deployments that could serve as a cross-customer benchmark, beyond the published literature's 68-point industry average?
4. For customers where Suki does have some feedback mechanism, is respondent participation mandatory, opt-in, or something in between — and can that be disclosed alongside any satisfaction figure Suki reports externally?
5. Would Suki be open to including a brief, standardized satisfaction pulse item (distinct from a full SUS administration) as a lightweight recurring signal, similar to the burnout pulse-item question raised for CM-01?

---

*CM-15 Provider Satisfaction and Usability | Canonical Measures | User Satisfaction dimension*
*Internal draft — July 2026*
