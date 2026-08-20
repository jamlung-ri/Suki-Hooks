# CM-14 Adoption Intention and Long-Term Use
## Canonical Measure Report — Internal Draft

**Measures covered:** CM-14 Adoption Intention and Long-Term Use (primary); CM-13 Adoption Behavior and Utilization Rate (boundary — what providers actually do, vs. stated intent) and CM-15 Provider Satisfaction and Usability (boundary — recommendation/long-term-use items were reclassified there, covered separately)
**Status:** Internal draft for review and editing before sharing externally

---

## What This Measure Captures

**CM-14 Adoption Intention and Long-Term Use** is provider-reported intention to continue using the ambient AI scribe beyond the study period, including willingness to adopt and implementation readiness — the attitudinal (stated-intent) side of the Technology Acceptance Model (TAM) / UTAUT distinction, as opposed to actual adoption behavior.

It is distinct from two adjacent constructs:

| Construct | Canonical measure | What it captures |
|---|---|---|
| Actual usage behavior | CM-13 — Adoption Behavior and Utilization Rate | What providers actually do, independent of what they say they intend to do |
| Recommendation and satisfaction | CM-15 — Provider Satisfaction and Usability | Recommendation likelihood, recommendation intention, and long-term-use satisfaction items — reclassified out of CM-14 during corpus derivation as closer to satisfaction than to intention |

**Why this matters for Suki's value story — and the central caveat:** This is the one canonical measure in the current batch with essentially no direct empirical grounding in the reviewed literature. Only 5–6 papers in the corpus touch adoption intention at all (Evans 2025, Galloway 2024, Ma 2025, Omon 2025, Tierney 2025, Billings 2025b), and none of them reports fielding a validated multi-item TAM/UTAUT Behavioral Intention instrument with published psychometrics. What exists instead are single ad hoc items ("intention to use," "willingness to adopt," "implementation intent") and one operational proxy (Ma 2025's license relinquishment rate). Tierney 2025's one genuinely interesting finding is negative-space: physician age and years since graduation are **not** predictive of adoption, which cuts against the common generational-adoption narrative — useful to know, but it is a finding about behavior/predictors, not a validated intention score. Any value-story claim built on this measure should be labeled as theory-derived and exploratory, not as a corpus-replicated effect size, unlike CM-01 (burnout) or CM-09 (note inaccuracy) where the algorithm cards can point to specific RCT or QI effect sizes.

---

## Current Suki Hooks and Data Available

Adoption intention is **not directly observable from Suki's API** — it is a provider-reported attitudinal construct. What Suki can provide is the same exposure/cohort scaffolding used across this measure family, plus one operational proxy specific to this measure: license/seat status.

### What Suki exposes natively (H1)

| Artifact | API endpoint | What it enables |
|---|---|---|
| Session creation logs | `GET /session/{id}/status` (aggregated) | Sessions per provider per day/week — utilization intensity, the basis for dose-response cohorts |
| Session status | `GET /session/{id}/status` | `completed` vs. `skipped` vs. `failed` rate — early-friction proxy |
| Seat/license administration records | Suki account/seat admin system (not the session API) | Active vs. relinquished license status — an operational behavioral proxy for intention, per Ma 2025 |

### Measurement supported right now

- **Exposure/cohort definition** — stratify providers into heavy (≥70% utilization), moderate (30–69%), and light (<30%) users per the PHTI 2025 framework
- **License relinquishment tracking** — % of clinicians who returned licenses, the one Suki-adjacent operational proxy actually used in the corpus (Ma 2025)

---

## Missing or Aspirational Hooks

| Missing capability | Why it matters |
|---|---|
| **Any validated intention instrument fielded in the corpus** | Not a Suki data gap, but a literature gap — this is the reason CM-14 must be treated as theory-derived rather than evidence-anchored |
| **In-app survey distribution** | No documented mechanism for Suki to push a TAM/UTAUT-derived instrument to providers at baseline and follow-up |
| **Survey response capture/storage** | Even if surveys were distributed externally, Suki has no API for storing or linking responses to session-level utilization data |
| **Provider-level longitudinal identity across deployment phases** | Needed to match a Phase 0 respondent to their Phase 3 utilization tier without breaking survey anonymity |

---

## EHR-Side Data Needed

CM-14 is not an EHR-data measure at all. No EHR-side data element is required to compute it — the entire measure depends on external survey administration plus Suki's utilization and seat-status data.

---

## Survey Instruments and Administration

### Validated instruments (in priority order)

- **UTAUT Behavioral Intention construct (Venkatesh 2003)** — 3–4 items, typically 7-point Likert. The theoretical framework named in the measure's own definition. **Not confirmed as fielded by any paper in this corpus** — treat as the aspirational gold standard, not a proven instrument.
- **TAM Intention to Use construct (Davis 1989)** — similar structure, older and more widely validated in general technology-acceptance research outside healthcare. Also not corpus-confirmed as fielded.
- **Single ad hoc Likert items actually observed in the corpus** — "intention to use" (Evans 2025, Galloway 2024), "willingness to adopt" (Omon 2025), "implementation intent" (Omon 2025). Low-burden, but not psychometrically validated as multi-item scales.
- **License relinquishment (operational, not survey)** — % of clinicians who returned licenses (Ma 2025). A real behavioral proxy, but binary and lagging — it only captures full discontinuation, not gradations of declining intention.

### Suggested evaluation design

1. **Phase 0 (at or before go-live):** Administer a TAM/UTAUT-derived intention-to-adopt item set (or, if time does not allow instrument selection/validation, the corpus-observed single-item proxies) to all eligible providers. Unlike usability or trust (CM-15, CM-16), intention-to-adopt is a meaningful pre-exposure question, so a true Phase 0 baseline is possible here.
2. **Phase 1–2 (weeks 1–16):** Track Suki utilization per provider; assign heavy/moderate/light cohorts by week 4; track license/seat status continuously.
3. **Phase 3 (months 4–9):** Repeat the same instrument, now asking about intention-to-continue. Compare change scores across utilization cohorts (dose-response). Report license-relinquishment rate by cohort as a behavioral corroboration.
4. **Reporting:** Present the survey-based dose-response delta alongside the relinquishment-rate delta. If the two diverge (e.g., stated intention rises but relinquishment also rises), report both rather than reconciling them — the divergence itself is informative.

LLM-as-judge methods do not apply to CM-14 — this is a self-report attitudinal construct with no transcript or note artifact to evaluate.

---

## The Missing Instrument Problem

This is the central structural gap for CM-14, and it is different in kind from the gaps identified for the other measures in this batch (CM-15's missing baseline, CM-16's thin evidence base, CM-23's missing feedback loop to non-adopters). For CM-14, the gap is not a missing data pipeline — it is a missing **validated instrument in the evidence base itself**.

```
TAM/UTAUT theoretical framework (cited in CM-14's own definition)
        │
        └────────────────────── [missing link] ──────────────────────┐
                    no paper in the reviewed corpus reports             │
                    fielding a validated multi-item instrument          │
                    with published psychometrics for this construct     │
                                                                          ▼
                                                        Single ad hoc Likert items and one
                                                        operational proxy (license relinquishment) —
                                                        the only corpus-observed operationalizations
```

**What is achievable today:** Suki utilization-tier scaffolding, license/seat status tracking, and administration of a single ad hoc intention item consistent with what the corpus actually reports.

**What is missing:** A validated, psychometrically tested TAM/UTAUT Behavioral Intention instrument that has actually been fielded and scored in an ambient-scribe context. Sourcing or validating one is a literature/instrument-design task, not a Suki data-access task.

Until this is addressed, any CM-14 dashboard value should be presented as a theory-derived, exploratory pilot metric — explicitly not a replication of an established corpus finding, and with lower confidence than every other measure in this set. This caveat should travel with the number wherever it is shown, not just live in this report.

---

## Open Questions for Suki

1. Does Suki (or Suki's customer success process) have any existing template or mechanism for administering a pre-deployment intention survey to providers before go-live?
2. Can Suki provide provider-level license/seat status history (active vs. relinquished, and the date of any status change) as a behavioral corroboration signal for stated intention?
3. Has Suki, in any prior customer engagement, fielded a TAM- or UTAUT-derived instrument (even informally) whose item wording or aggregate results could inform instrument selection here?
4. Would Suki be open to funding or co-developing a validated short-form intention instrument specifically for ambient-scribe contexts, given that none currently exists in the published literature reviewed for this corpus?
5. Does Suki have aggregate (de-identified) license-relinquishment data across customers that could serve as an external benchmark for the operational proxy, independent of any new survey effort?

---

*CM-14 Adoption Intention and Long-Term Use | Canonical Measures | Use dimension*
*Internal draft — July 2026*
