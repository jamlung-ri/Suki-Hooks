# CM-17 Patient Experience and Relationship Quality
## Canonical Measure Report — Internal Draft

**Measures covered:** CM-17 Patient Experience and Relationship Quality (primary); boundary with CM-18 (Physician-Patient Interaction Quality) and CM-16 (Provider Trust in AI)
**Status:** Internal draft for review and editing before sharing externally — **see "The Multilingual Opportunity" for the most actionable framing**

---

## What This Measure Captures

**CM-17 Patient Experience and Relationship Quality** is the patient's own report of the quality of the patient-physician interaction — relationship quality, visit satisfaction, and the experience of being heard. It is measured primarily via the PDRQ-9 (Patient-Doctor Relationship Questionnaire, 9-item validated scale), generic patient satisfaction surveys (Press Ganey or custom), Patient Likelihood to Recommend (LTR, an NPS-style item), patient consent/opt-out compliance, and qualitative patient feedback.

**This is the most underdeveloped outcome domain in the entire canonical measures corpus.** Only one paper (Owens 2024) uses a validated patient-reported instrument (PDRQ-9), and it found a **null result in the masked phase** (p=.31) — the open-label phase was positive, but that is more consistent with a patient-expectation effect than a relationship-quality effect. Every other "patient experience" data point in the literature is clinician-reported or anecdotal (e.g., Tierney 2025's patient survey, n=118: 56% positive impact on visit quality, 39% reported more time speaking with the doctor, 92% comfortable/neutral with AI — useful signal, but not from a validated instrument).

The H1 deep-dive scores CM-17 at **5/12 (Tier 3)** — the lowest of any wellbeing/experience measure — driven by **External (1)** data access, **Low (1)** signal clarity, and **Weak (1)** external benchmark. As with CM-03, a clean measurement of CM-17 via H1 alone would not be highly informative. What changes this picture is **H4 (multilingual)** — see below.

---

## Current Suki Hooks and Data Available

### What Suki exposes natively (H1, H4, H17)

| Artifact | API endpoint | What it enables |
|---|---|---|
| Session creation logs | `GET /session/{id}/status` (aggregated) | Cohort definition by utilization tier, as in CM-01/02/03 |
| Transcript segment language (`lang_id`) | `GET /session/{id}/transcript` | **Per-segment spoken language** — Suki transcribes 80+ languages even though notes are always generated in English. This is a direct, already-collected signal for whether a given encounter involved a non-English-speaking patient. |
| Note content — Patient Instructions section (LOINC 69730-0) | `GET /session/{id}/content` | Presence/absence and content of a patient-facing instructions section — relevant to H14 and to what the patient actually receives from the visit |
| Telehealth session flag (H17, where applicable) | `GET /session/{id}/status` / session metadata | Identifies encounters conducted via telehealth, the other channel where CM-17/CM-18 are the primary relevant outcomes |

### Measurement supported right now

- **Cohort definition only**, as with CM-01/02/03 — Suki cannot observe the patient's subjective experience directly. The H1×CM matrix marks CM-17 as ◐ (partial) for H1, reflecting that ambient documentation is *plausibly* relevant to patient experience (clinician looks at the patient, not a screen) but this pathway is better captured under CM-18.
- **Multilingual-encounter identification** — `lang_id` on transcript segments lets Suki flag, today, which encounters involved a patient speaking a language other than English. This is the one piece of Suki-native data that maps onto a *specific, unstudied, and clinically meaningful* mechanism (see below), rather than a generic utilization proxy.

---

## Missing or Aspirational Hooks

| Missing capability | Why it matters |
|---|---|
| **In-app patient survey distribution (PDRQ-9, LTR)** | The fundamental gap — Suki has no mechanism to reach the *patient* at all; all current survey-distribution gaps (CM-01/02/03) are about reaching clinicians, but this one is about reaching patients, a different population with different consent/contact requirements |
| **Patient consent/opt-out capture** | One of the five defined CM-17 measurement methods ("Patient consent compliance," "Patient Opt-Out Rate") is purely operational — whether a patient agreed to ambient recording — but no consent-capture field appears in the current Suki API surface |
| **Language-pathway exposure flag at the session level** | `lang_id` exists per transcript segment, but there is no session-level summary field (e.g., "primary patient language ≠ English") that would make the multilingual cohort trivial to construct without post-processing every transcript |
| **H14 (Patient Instructions) exposure/delivery confirmation** | Even if Suki generates a Patient Instructions section, there is no signal for whether it was actually given to or reviewed by the patient — the delivery step, not just the generation step, is what would plausibly affect CM-17 |

---

## EHR-Side Data Needed

CM-17 is primarily a survey/operational measure with minimal EHR-side data requirements beyond what supports cohort definition:

| Data element | Purpose | Notes |
|---|---|---|
| Patient demographic/language data (preferred language field) | Cross-check and enrich the Suki-derived multilingual cohort; needed to distinguish "patient spoke another language in this encounter" from "patient's documented preferred language" | Standard EHR demographics field |
| Patient contact information (for survey distribution) | Required if PDRQ-9/satisfaction surveys are distributed outside the visit | Subject to consent and privacy requirements distinct from provider-survey logistics |
| Existing patient satisfaction survey data (Press Ganey or site equivalent) | Many sites already collect this — could provide a pre/post comparison without new instrumentation | Site-dependent; often siloed from clinical data |

---

## Survey Instruments and Administration

### Validated instruments (in priority order)

- **PDRQ-9 (Patient-Doctor Relationship Questionnaire)** — 9-item validated patient-reported relationship-quality scale. The only validated instrument used for CM-17 in the corpus (Owens 2024), and the one that produced a null masked-phase result. Highest construct validity but highest respondent-recruitment burden (requires reaching patients post-visit).
- **Patient satisfaction survey (Press Ganey / custom)** — widely deployed operationally at many sites already; lower marginal cost if a site already runs one, but generally not validated against the specific "AI scribe present" condition.
- **Patient Likelihood to Recommend (LTR)** — single NPS-style item; lowest respondent burden, lowest construct specificity.

### Suggested evaluation design

Given the weak prior evidence (a single null result) and weak data access, CM-17 should **not** be a standalone primary outcome. Two paths forward, in order of recommendation:

1. **Piggyback on existing site-level patient satisfaction infrastructure.** If a deployment site already administers Press Ganey or an equivalent survey, request a pre/post (or AI-exposed vs. not-exposed) breakout rather than standing up new data collection. This is the only path with realistic near-term feasibility.
2. **Targeted PDRQ-9 in the multilingual cohort (see below).** Rather than attempting a broad, low-powered CM-17 study, use the `lang_id`-derived multilingual cohort as the *one* place where a CM-17 effect is most plausible and least studied — concentrating limited survey-distribution effort where it is most likely to be informative.

LLM-as-judge methods do not apply — CM-17 is a patient-reported construct with no artifact for an LLM to rate.

---

## The Multilingual Opportunity

This is the most actionable framing for CM-17, and it comes directly from the hook-measure matrix's "most underserved outcome domain" analysis:

**The finding:** H4 (multilingual transcription/note generation) is described as "the most direct and unstudied patient experience pathway... non-English-speaking patients communicating in their native language is a clinically meaningful intervention with zero published evidence." The hook matrix's priority sprint plan (2B) specifically pairs **H4 + CM-17 via PDRQ-9 in a multilingual patient cohort**.

**Why this changes the Tier 3 framing:** CM-17's low score (5/12) is driven by weak signal clarity and weak external benchmarks *for the general case*. But for the multilingual subgroup specifically:

- **The mechanism is concrete and novel** — a patient who can speak to their physician in their own language, with the physician listening rather than typing/translating, is a plausible and previously untested driver of relationship quality.
- **Suki already has the cohort-identification data** — `lang_id` on transcript segments identifies these encounters today, without any new hook.
- **There is zero published evidence either way** — meaning even a modest, well-targeted study would be a genuine contribution, not a replication of a null result (as a general-population CM-17 study would risk being, given Owens 2024).

```
Transcript segments (Suki, today) ──► lang_id ≠ "en" ──► Multilingual-encounter cohort
                                                                  │
                                                          [missing link]
                                                   PDRQ-9 distribution to this
                                                   specific patient cohort post-visit
                                                                  │
                                                                  ▼
                                          First validated-instrument evidence on
                                          H4's patient-experience pathway
```

**What is achievable today:** Identifying the multilingual-encounter cohort from existing transcript data, with no new instrumentation.

**What is missing:** Any mechanism to distribute PDRQ-9 (or a shorter relationship-quality instrument) to patients in that cohort post-visit — the same patient-survey-distribution gap as the general case, but now targeted at a cohort where the answer would actually be new information.

---

## Open Questions for Suki

1. Is there a session-level (not just segment-level) summary of patient-spoken language already computed or computable, to make multilingual-cohort identification straightforward at scale?
2. Does Suki have, or plan to build, any mechanism for distributing a brief post-visit patient survey (even outside the Suki app itself — e.g., via SMS/patient portal integration)? This is the single highest-leverage gap for CM-17.
3. Is patient consent/opt-out status for ambient recording captured anywhere in Suki's data model today, even if not currently exposed via the API documented here?
4. For H14 (Patient Instructions): is there any signal — even indirect — for whether a generated Patient Instructions section was provided to or viewed by the patient (e.g., printed, sent to portal)?
5. Would Suki's research/product team have interest in a small, targeted PDRQ-9 study in the multilingual cohort (Sprint Priority 2B in the hook matrix), given the combination of an unstudied mechanism, an existing identification signal, and zero prior published evidence to contradict?

---

*CM-17 Patient Experience and Relationship Quality | Canonical Measures | Organizational Impact dimension*
*Internal draft — June 2026*
