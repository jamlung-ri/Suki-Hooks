# CM-03 Professional Fulfillment and Meaningfulness
## Canonical Measure Report — Internal Draft

**Measures covered:** CM-03 Professional Fulfillment and Meaningfulness (primary); boundary with CM-01 (Burnout)
**Status:** Internal draft for review and editing before sharing externally — **see "Why This Is Not a Near-Term Priority" before scoping any evaluation work**

---

## What This Measure Captures

**CM-03 Professional Fulfillment and Meaningfulness** is provider-reported positive engagement with clinical work — the presence of meaning, reward, and satisfaction in the work itself. It is measured primarily via the Stanford PFI Professional Fulfillment subscale (6-item, 1–5 scale, higher = better), with supporting custom Likert items on meaningfulness and work-life balance.

It is the **positive pole** of the well-being spectrum, distinct from CM-01:

| Construct | Canonical measure | What it captures |
|---|---|---|
| Absence of exhaustion | CM-01 — Clinician Burnout and Exhaustion | Removal of a negative state |
| Presence of engagement | CM-03 — Professional Fulfillment and Meaningfulness | Addition of a positive state |

These are **dissociable constructs** — removing a negative (burnout) does not imply adding a positive (fulfillment), and the strongest available evidence shows exactly this dissociation.

---

## Why This Is Not a Near-Term Priority

This section comes first because it should shape scoping decisions before any data-access work is done.

**The key finding:** Afshar 2025b (pragmatic RCT, n=66) found professional fulfillment increased at p=0.04 — which **missed** the pre-specified alpha of 0.025. In the same RCT, burnout (CM-01) decreased significantly (−0.44 PFI work exhaustion). The interpretation: ambient AI reduces exhaustion but does **not** significantly increase fulfillment. Burden removal and meaning addition are different mechanisms, and Suki's product addresses the former, not the latter.

**Consequences for evaluation:**
- The Suki Hook × Measure Matrix explicitly notes "No hook reliably moves this measure. Treat as aspirational, not evaluable in near-term sprints."
- The H1 deep-dive scoring rates CM-03 as **Tier 3** (score 7/12), driven by **Low Actionability (1)** — even a clean measurement would not give Suki or a customer something to act on, because no current hook is designed to move this construct.
- Any evaluation that includes CM-03 should plan for a **null result as the expected outcome**, consistent with the strongest available RCT. Including it as a primary outcome risks the evaluation being read as "Suki doesn't improve wellbeing," when the more accurate reading is "Suki improves one wellbeing construct (burnout) and not a different, dissociable one (fulfillment)."

**Recommendation:** If CM-03 is measured at all, it should be a **secondary/exploratory** outcome alongside CM-01, framed explicitly as a test of the dissociation finding — not as a standalone value-proposition metric.

---

## Current Suki Hooks and Data Available

As with CM-01 and CM-02, CM-03 is a subjective self-report construct with no API analog — Suki cannot observe "meaning" or "reward." The only Suki-native contribution is the same exposure/cohort data used for the other wellbeing measures.

### What Suki exposes natively (H1)

| Artifact | API endpoint | What it enables |
|---|---|---|
| Session creation logs | `GET /session/{id}/status` (aggregated) | Sessions per provider per day/week — defines heavy/moderate/light utilization cohorts, the independent variable for any dose-response comparison |
| Session status | `GET /session/{id}/status` | `completed`/`skipped`/`failed` rate — general adoption-quality signal, useful only as a covariate here |

### Measurement supported right now

- **Cohort definition only.** Suki data can stratify providers by utilization for a dose-response design, exactly as in CM-01 and CM-02. It cannot contribute any signal about the *outcome* itself.

---

## Missing or Aspirational Hooks

| Missing capability | Why it matters |
|---|---|
| **In-app survey distribution** | Same gap as CM-01/CM-02 — no mechanism to administer the PFI Professional Fulfillment subscale |
| **A product mechanism targeting fulfillment** | Unlike CM-01 (where H1/H8 plausibly act on the burden mechanism) or CM-02 (where H1/H8/H10/H11 act on cognitive load), no current or announced Suki hook is designed to act on meaning, reward, or engagement. This is a product gap, not just a measurement gap. |

---

## EHR-Side Data Needed

None beyond what is already required for CM-01 (provider ID, schedule/FTE data for cohort definitions). CM-03 does not have a distinct EHR-side data requirement — it is purely a survey construct with no objective correlate proposed in the corpus.

---

## Survey Instruments and Administration

### Validated instruments

- **Stanford PFI, Professional Fulfillment subscale** — 6-item, 1–5 scale (higher = better). The instrument used in the key RCT (Afshar 2025b). If CM-01 is measured via the full PFI, this subscale is collected "for free" in the same instrument — a strong argument for bundling rather than separately scoping CM-03.
- **Meaningfulness-of-work Likert items** — custom items used in Afshar 2025b alongside the PFI subscale.
- **Work-life balance items** — used in Boyter 2025, Duggan 2025; conceptually adjacent but with weaker instrument validation (the Haberle 2024 instrument-name attribution needs verification per the team's open simple-errors list).

### Suggested evaluation design

Given the "not a near-term priority" framing above, the practical recommendation is:

1. **Bundle, don't separately scope.** If a full Stanford PFI is administered for CM-01 (burnout), the Professional Fulfillment subscale comes along at no additional respondent burden. Do not stand up a separate CM-03 data-collection effort.
2. **Frame as a dissociation check, not a value claim.** Report CM-03 alongside CM-01 specifically to show whether the Afshar 2025b dissociation (burnout improves, fulfillment does not) replicates in a Suki deployment — this is scientifically useful even though it is not a marketing claim.
3. **Do not power a study around CM-03.** Given Actionability = Low and the expected-null framing, CM-03 should never be the primary outcome driving sample-size decisions.

LLM-as-judge methods do not apply — there is no artifact to rate; this is a self-report construct, and per the discussion above, one with no current product mechanism behind it.

---

## Open Questions for Suki

1. If a future hook (e.g., H8 orders staging, or something not yet in the inventory) were explicitly designed to increase time for activities clinicians find meaningful (teaching, complex case review, patient relationship-building), would that change the Actionability assessment for CM-03? This is more a product-roadmap question than a data-access question.
2. Does Suki have any aggregate (de-identified) PFI Professional Fulfillment results from prior pilots — even null results — that would help calibrate expectations before any new data collection?
3. Is there interest from Suki's research/product team in testing the Afshar 2025b dissociation finding (burnout improves, fulfillment does not) in a real-world deployment, as a way of better understanding what Suki's product does and does not address?

---

*CM-03 Professional Fulfillment and Meaningfulness | Canonical Measures | Individual Impact dimension*
*Internal draft — June 2026*
