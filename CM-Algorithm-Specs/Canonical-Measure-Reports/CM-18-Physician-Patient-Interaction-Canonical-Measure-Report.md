# CM-18 Physician-Patient Interaction Quality
## Canonical Measure Report — Internal Draft

**Measures covered:** CM-18 Physician-Patient Interaction Quality (primary); boundary with CM-17 (Patient Experience), CM-22 (Patient Volume), and CM-02 (Cognitive Load)
**Status:** Internal draft for review and editing before sharing externally

---

## What This Measure Captures

**CM-18 Physician-Patient Interaction Quality** is a *behavioral* measure of the clinical encounter itself — face-to-face time, clinician attentiveness, screen time, and perceived engagement during the visit. It is distinct from CM-17 (Patient Experience), which is the patient's own report of relationship quality, and from CM-22 (Patient Volume), to which "patients seen per hour" and "I feel able to see more patients" were explicitly reassigned because *time does not measure quality*.

| Construct | Canonical measure | What it captures | Reporter |
|---|---|---|---|
| Behavior during the encounter | CM-18 — Physician-Patient Interaction Quality | Face time, attentiveness, screen time | Primarily clinician-reported/observed |
| Outcome of the encounter | CM-17 — Patient Experience and Relationship Quality | Relationship quality, satisfaction | Patient-reported |
| Throughput | CM-22 — Patient Volume and Throughput | Patients seen per hour | Operational |

**The headline evidence point is Shuaib 2021** (human-scribe comparator, not ambient AI): doctor-patient interaction time **doubled**, and patients/hour increased 39% — establishing the *potential* magnitude of effect documentation automation can have on this measure. Ambient AI studies to date capture CM-18 mostly via self-report survey items (Duggan 2025: "Documentation prevents me from being fully engaged," "I feel distracted by documentation while talking") rather than direct observation. Tierney 2025 is the largest ambient-AI data point: 84% of physicians reported a positive impact on visit interactions, and a patient survey (n=118) found 39% reported more time speaking with the doctor and 0% reported negative impact on visit quality.

The H1 deep-dive scores CM-18 at **6/12 (Tier 3)** — External (1) data access, Low (1) signal clarity, Moderate (2) external benchmark (Shuaib 2021), Medium (2) actionability. However, the hook×measure matrix rates **H1 as ● (strong)** for CM-18 specifically — the core mechanism (clinician looks at the patient, not the keyboard) is H1's most direct claim, with **H10 (pre-visit summaries)** and **H11 (chart Q&A)** extending it by reducing pre- and during-encounter EHR burden.

---

## Current Suki Hooks and Data Available

### What Suki exposes natively (H1, H10, H11)

| Artifact | API endpoint | What it enables |
|---|---|---|
| Transcript timestamps (start/end per segment) | `GET /session/{id}/transcript` | **Consultation duration** — one of CM-18's four defined measurement methods, directly and natively available as a byproduct of ambient capture |
| Transcript speaker/segment structure | `GET /session/{id}/transcript` | Talk-time distribution between clinician and patient — a structural proxy for "attentiveness," though not a validated one |
| Session status (`completed`/`skipped`/`failed`) | `GET /session/{id}/status` | Adoption-quality covariate, as in CM-02 |
| Note content volume / structured diagnoses | `GET /session/{id}/content`, `/structured-data` | Cognitive-offload proxy shared with CM-02 — relevant here because reduced in-visit documentation burden is the *mechanism* by which H1 is thought to improve CM-18 |

### Measurement supported right now

- **Consultation duration** — Suki's transcript timestamps directly answer one of the four measurement methods in the CM-18 definition (Direct timing, "Consultation duration"), with no additional instrumentation. This is the single strongest Suki-native data point for CM-18, comparable in directness to CM-06's session-completion timestamps.
- **Talk-time distribution as a structural proxy** — the ratio of clinician-speech time to patient-speech time, or simple turn-taking patterns, in the transcript could serve as a rough, unvalidated proxy for "attentiveness" or "engagement" — useful as a secondary/exploratory signal, not a primary outcome.
- **Cohort definition** — heavy/moderate/light utilization tiers, as elsewhere, for dose-response comparisons against self-report engagement items.

---

## Missing or Aspirational Hooks

| Missing capability | Why it matters |
|---|---|
| **Post-encounter self-report engagement item** | The dominant measurement method in the ambient-AI literature (Duggan 2025-style Likert items: "I felt fully engaged with this patient") has no Suki-native equivalent — same survey-distribution gap as CM-01/02/03, but a single-item, encounter-anchored version |
| **In-encounter EHR interaction events** | "Time searching for information" (one of the four defined methods) requires knowing how much of the encounter the clinician spent looking at the EHR vs. the patient — Suki has no visibility into EHR screen activity |
| **H10/H11 exposure metadata at the session level** | To isolate whether a pre-visit summary (H10) or in-visit chart Q&A (H11) changed in-encounter behavior, sessions need a flag for whether either feature was used — same gap noted in the CM-02 report |
| **Validated talk-time/turn-taking analytics** | The transcript contains the raw data for talk-time analysis, but no validated methodology has been applied to Suki transcripts for this purpose — this would need methodological work, not just data access, before being reportable |

---

## EHR-Side Data Needed

| Data element | Purpose | Vendor examples |
|---|---|---|
| In-encounter EHR active time (clicks/keystrokes during the visit window) | Directly operationalizes "Time searching for information" — the one CM-18 method Suki cannot touch at all | Epic Signal "Time in Notes" filtered to the encounter time window |
| Order-entry / chart-navigation events during the encounter | Same data as in the CM-02 report — isolates whether H8/H10/H11 reduce in-visit screen time specifically (vs. post-visit) | EHR audit log |

This is a smaller EHR-data ask than CM-02 or CM-06 — CM-18's strongest method (consultation duration) is already Suki-native, and the remaining gap (in-encounter EHR time) is the same audit-log data already requested for CM-02, so it can be requested once and used for both measures.

---

## Survey Instruments and Administration

### Instruments used in the literature (no single validated scale)

Unlike CM-01/02/03/17, CM-18 has **no single validated instrument** — the literature uses custom Likert items, primarily from Duggan 2025 and Stults 2025:

- "I have undivided attention to give to my patients" (Duggan 2025, Stults 2025)
- "Documentation prevents me from being fully engaged" (reverse-scored; Duggan 2025)
- "I feel distracted by documentation while talking with my patient" (reverse-scored; Duggan 2025)
- "Focus on patients during visit" (Prasad 2025)

### Suggested evaluation design

1. **Lead with consultation duration** as the primary Suki-native quantitative signal — it requires no new instrumentation and directly matches a defined CM-18 method.
2. **Add a single post-encounter or end-of-shift Likert item** ("Today, documentation did not prevent me from being fully present with my patients" or similar), bundled with whatever CM-02 NASA-TLX/PTL administration is already planned — the timing requirements are similar (close to the encounter), so the same administration mechanism can carry both.
3. **Treat talk-time/turn-taking transcript analysis as exploratory**, reported only as a secondary/corroborating signal pending methodological validation — do not present it as equivalent to observed attentiveness.
4. **Use Shuaib 2021's magnitude (doubled interaction time, +39% throughput) as a ceiling, not an expectation** — it is a human-scribe comparator and likely represents an upper bound on what ambient AI alone would achieve.

LLM-as-judge methods do not directly apply — there is no note/transcript artifact being rated for *quality* in the CM-08/CM-09 sense. However, an LLM could in principle be used to characterize transcript talk-time/turn-taking patterns at scale, which is closer to an automated-analytics application than a judge application.

---

## Open Questions for Suki

1. Can consultation duration (encounter start-to-end, from transcript timestamps) be retrieved as a simple per-session field, without requiring the full transcript to be parsed?
2. Is there any existing analysis of talk-time distribution (clinician vs. patient speech proportion) from Suki transcripts, even internally, that could inform whether this is a viable secondary signal for CM-18?
3. As with CM-02: once H10 (pre-visit summaries) or H11 (chart Q&A) reach production, will session metadata flag exposure, enabling a within-provider comparison of consultation duration and talk-time distribution with vs. without the feature?
4. Does Suki have any aggregate (de-identified) results from prior pilots using Duggan-2025-style engagement Likert items, even informally collected, that could calibrate expectations?
5. Given that the in-encounter EHR-activity data request overlaps entirely with CM-02's request, should these be scoped as a single combined EHR data-access ask covering both measures?

---

*CM-18 Physician-Patient Interaction Quality | Canonical Measures | Organizational Impact dimension*
*Internal draft — June 2026*
