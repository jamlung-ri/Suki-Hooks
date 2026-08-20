# CM-23 Implementation Barriers and Workflow Fit
## Canonical Measure Report — Internal Draft

**Measures covered:** CM-23 Implementation Barriers and Workflow Fit (primary); CM-13 Adoption Behavior and Utilization Rate (boundary — the behavioral outcome barriers ultimately drive) and CM-15 Provider Satisfaction and Usability (boundary — tool-level usability, vs. deployment-level implementation fit, covered separately)
**Status:** Internal draft for review and editing before sharing externally

---

## What This Measure Captures

**CM-23 Implementation Barriers and Workflow Fit** is the set of factors that impede or facilitate ambient AI scribe adoption and sustained use — technical barriers, workflow integration challenges, specialty fit, training quality, and organizational support — mapped to the Service Quality (SerQ) dimension as a property of the deployment/implementation experience itself, rather than the tool.

It is distinct from two adjacent constructs:

| Construct | Canonical measure | What it captures |
|---|---|---|
| Actual usage behavior | CM-13 — Adoption Behavior and Utilization Rate | The behavioral outcome that implementation barriers ultimately shape, measured independently of *why* |
| Tool usability | CM-15 — Provider Satisfaction and Usability | Satisfaction with the tool itself, once in use — distinct from the surrounding deployment/organizational context that determines whether use happens at all |

**Why this matters for Suki's value story:** This is one of the better-populated measures in the corpus (12 papers) and produces the single most consistent finding across the entire canonical measures set: heterogeneous adoption, with a durable cohort of heavy users, moderate users, and non-/low-users, formalized by PHTI 2025 into 3 adoption cohorts. The corpus also identifies who benefits most (high baseline documentation burden, complex narrative notes, high patient face-time) and who doesn't adopt (no existing burden, an already-optimized workflow, technical incompatibility). This is directly actionable for a customer-success motion — it tells Suki which provider profile to prioritize for onboarding effort and which to expect to remain non-adopters regardless of support quality. The one validated quantitative instrument named in the corpus (FIM/AIM/IAM, via Suhail 2026) carries an unresolved sourcing question that should be verified before it anchors any external claim — see below.

---

## Current Suki Hooks and Data Available

Implementation barriers are **not directly observable from Suki's API** as a construct, but this measure benefits from the same utilization-cohort scaffolding used across the family, plus — uniquely among this batch — a plausible use for onboarding/training completion data if Suki's customer success systems track it.

### What Suki exposes natively (H1)

| Artifact | API endpoint | What it enables |
|---|---|---|
| Session creation logs | `GET /session/{id}/status` (aggregated) | Sessions per provider per day/week — utilization intensity, the basis for the heavy/moderate/light/non-adopter cohort split central to this measure |
| Session status | `GET /session/{id}/status` | `completed` vs. `skipped` vs. `failed` rate — an early-friction proxy that may anticipate barrier themes before survey/interview data arrives |
| Suki adoption date (or its absence) | Derived from session logs | Distinguishes true non-adopters from providers not yet reached — the single hardest data point to get right for this measure |

### Measurement supported right now

- **Cohort definition, including non-adopters** — unlike every other measure in this batch, CM-23 explicitly needs to retain and analyze the non-adopter cohort rather than excluding it, since barriers are best characterized by studying who *doesn't* adopt
- **Early-friction screening** — skip/fail rate trends as a leading indicator of likely barrier themes

---

## Missing or Aspirational Hooks

| Missing capability | Why it matters |
|---|---|
| **Reaching non-adopters at all** | If Suki has no in-app or in-product channel to providers who never engaged, non-adopter survey/interview outreach must run entirely through the customer's own communication channels — the single biggest practical obstacle to this measure |
| **Onboarding/training completion records exposed via API** | Would let training quality be tested as a covariate against implementation-fit scores, rather than assumed |
| **In-app survey/interview distribution** | No documented mechanism for Suki to push the FIM/AIM/IAM instrument or barrier interview prompts to providers |
| **Structured barrier-taxonomy tagging at the point of friction** | E.g., a lightweight in-app "why did you skip this session" prompt would generate real-time barrier signal instead of relying entirely on retrospective survey/interview recall |

---

## EHR-Side Data Needed

CM-23 is largely not an EHR-data measure, but EHR-side specialty and schedule data can help explain *why* certain provider profiles adopt or don't:

| Data element | Purpose | Vendor examples / Notes |
|---|---|---|
| Provider specialty | Tests the corpus finding that high-complexity, narrative-heavy specialties adopt more readily | EHR provider directory |
| Panel size / visit volume | Proxies baseline documentation burden, a key predictor of adoption per the corpus | EHR scheduling/panel data |
| EHR technical environment (version, integration type) | Tests whether "technical incompatibility" (a named non-adopter cluster) is EHR-configuration-specific | Varies by vendor; likely IT/informatics-team-sourced, not a standard extract |

None of this is required to compute the core FIM/AIM/IAM composite score, but it materially strengthens interpretation of *why* barriers cluster the way the corpus describes.

---

## Survey Instruments and Administration

### Validated instruments (in priority order)

- **FIM / AIM / IAM (Feasibility / Acceptability / Appropriateness of Intervention Measures, Weiner et al. 2017)** — each a 4-item, 1–5 Likert scale, reported in the corpus via Suhail 2026. **Flagged for verification:** the corpus's own review notes state it is "unclear where Suhail is sourcing FIM/AIM/IUS from" — confirm the instrument's presence and correct attribution in the primary source before treating it as corpus-validated.
- **CFIR / RE-AIM / SEIPS 3.0 implementation-science frameworks** — structured mixed-methods evaluation of implementation context; SEIPS 3.0 used in Kanaparthy 2025. Not interchangeable scoring systems — pick one per deployment.
- **QUEST framework** — quality-evaluation framework for AI tools, also used in Kanaparthy 2025.
- **Non-adopter category analysis** — AAFP 2021's 4 non-adopter types and PHTI 2025's 3 adoption cohorts are the most reusable off-the-shelf taxonomies in the corpus for classifying who doesn't adopt and why.

### Suggested evaluation design

1. **Wave 1 (early adoption, weeks 4–8 post go-live):** Administer FIM/AIM/IAM (or the customer's chosen framework) to all eligible providers — including those who have not completed a single session. As with usability (CM-15), implementation fit cannot be rated before any exposure, so this is an early-experience wave, not a pre-deployment baseline.
2. **Weeks 1–16:** Track Suki utilization per provider; assign heavy/moderate/light/**non-adopter** cohorts by week 4.
3. **Wave 2 (mature use, months 4–9):** Repeat the instrument, prioritizing non-adopter response specifically — this cohort is most likely to be lost to follow-up and is the one implementation-improvement effort should target first.
4. **Qualitative companion (either wave):** Conduct semi-structured interviews or collect open-response survey items, coded against a project-specific barrier taxonomy (technical, workflow-integration, specialty-fit, training, organizational support). Report theme frequency stratified by cohort — do not average into the quantitative composite.
5. **Reporting:** Present the composite score dose-response delta and the non-adopter barrier-theme ranking side by side, since the corpus's most actionable finding is precisely which themes distinguish non-adopters from heavy users.

LLM-as-judge methods do not apply to CM-23's quantitative component (a self-report scale), but could in principle assist with theme-coding open-response survey text at scale, analogous to CM-09's approach to note-content review — this is a plausible future extension, not currently built.

---

## The Non-Adopter Reach Problem

This is the central structural gap for CM-23, and it is distinct from every other gap identified in this batch: it is not about instrument validity (CM-14, CM-16) or missing baselines (CM-15) but about **who can be reached at all**.

```
Providers who adopt (heavy/moderate/light) ──────► Reachable via Suki utilization data + in-product signals
        │
Providers who never adopt (non-adopters) ──────► [missing link] ──────► Reachable only via customer's
                                                                         own communication channels,
                                                                         entirely independent of Suki
```

**What is achievable today:** Barrier data from providers who adopted at some level, even lightly — Suki's utilization data can identify and reach this group.

**What is missing:** Any Suki-native channel to reach providers who never engaged with the product at all. These are precisely the providers whose barrier data is most valuable (per the corpus's own finding that non-adopters cluster around distinct, identifiable causes — low baseline burden, optimized workflow, technical incompatibility), and precisely the providers a Suki-only outreach strategy cannot reach by definition.

Until this is addressed, non-adopter barrier data will depend entirely on the customer's willingness and ability to survey/interview disengaged staff through their own HR or clinical-leadership channels — something that cannot be assumed as part of a standard Suki deployment.

---

## Open Questions for Suki

1. Does Suki (or Suki's customer success process) have any existing mechanism — even outside the product itself — for identifying and reaching providers who were provisioned but never completed a session?
2. Does Suki's customer success/onboarding system track training completion per provider in a form that could be extracted as a covariate for this measure?
3. Can Suki confirm or provide the FIM/AIM/IAM instrument details (item wording, scoring) if this was used in any prior internal or customer-facing evaluation, to resolve the sourcing ambiguity flagged in the underlying literature review?
4. Does Suki have aggregate (de-identified) non-adopter rate or reason-for-non-adoption data across its customer base that could serve as an external benchmark, independent of any new survey effort?
5. Would Suki be open to instrumenting a lightweight in-app "reason for skip" prompt at the point a provider bypasses a Suki-eligible encounter, to generate real-time barrier signal rather than relying entirely on retrospective survey recall?

---

*CM-23 Implementation Barriers and Workflow Fit | Canonical Measures | Service Quality dimension*
*Internal draft — July 2026*
