# CM-02 Cognitive and Task Load
## Canonical Measure Report — Internal Draft

**Measures covered:** CM-02 Cognitive and Task Load (primary); boundary with CM-01 (Burnout) and CM-04 (Documentation Time)
**Status:** Internal draft for review and editing before sharing externally

---

## What This Measure Captures

**CM-02 Cognitive and Task Load** is the mental effort, time pressure, and frustration a clinician experiences *during* or *immediately after* a clinical encounter — the in-the-moment cognitive demand of documentation, measured via NASA-TLX (full instrument or subscales: Mental Demand, Physical Demand, Temporal Demand, Performance, Effort, Frustration) or the Physician Task Load Index (PTL, a 4-item NASA-TLX adaptation, 0–100 scale, lower = better).

It is distinct from two adjacent constructs:

| Construct | Canonical measure | What it captures |
|---|---|---|
| Sustained emotional depletion | CM-01 — Clinician Burnout and Exhaustion | Cumulative exhaustion/disengagement, measured over weeks-to-months |
| Time spent documenting | CM-04 — Documentation Time | Duration (minutes), an objective behavioral measure |
| In-the-moment mental effort | CM-02 — Cognitive and Task Load | Subjective workload during/just after a single encounter |

**Why this matters for Suki's value story:** CM-02 is the construct most directly tied to the *mechanism* by which ambient documentation is supposed to help — removing the dual-task burden of listening to a patient while typing or navigating the EHR. Per the H1×CM matrix, four distinct hooks plausibly reduce cognitive load through different pathways: H1 (ambient documentation removes in-visit typing), H8 (orders staging removes in-visit order-entry burden), H10 (pre-visit summaries reduce prep-phase cognitive load), and H11 (chart Q&A removes in-visit chart-navigation burden). Distinguishing *which* pathway drives a NASA-TLX change is itself a useful evaluation question, not just whether it changes.

---

## Current Suki Hooks and Data Available

CM-02 has the same fundamental limitation as CM-01: it is a subjective, in-the-moment self-report construct with no direct API analog. Suki cannot observe a clinician's mental effort. What Suki *can* provide are session-level behavioral signals that plausibly correlate with reduced in-encounter cognitive burden — useful as secondary/corroborating evidence alongside a NASA-TLX survey, not as a substitute for it.

### What Suki exposes natively (H1)

| Artifact | API endpoint | What it enables |
|---|---|---|
| Session status | `GET /session/{id}/status` | `completed` vs. `skipped`/`failed` rate — a high skip/fail rate may indicate sessions where the clinician abandoned ambient capture mid-encounter, a possible frustration signal |
| Transcript timestamps | `GET /session/{id}/transcript` | Session/encounter duration — pairing this with note section count and complexity gives a rough "cognitive load per minute of encounter" normalization |
| Note content | `GET /session/{id}/content` | Number and length of generated sections — a proxy for how much documentation work was *offloaded* from the clinician to Suki for a given encounter |
| Structured diagnoses (PBC) | `GET /session/{id}/structured-data` | Number of ICD-10/IMO codes generated automatically — a proxy for coding-related cognitive offload, one specific component of task load |

### Measurement supported right now

- **Offload proxy** — for a given encounter, the volume of note content and number of structured codes Suki generated without manual entry is a rough proxy for cognitive/task work *removed* from the clinician, even though it does not measure the clinician's perceived effort directly
- **Session abandonment as a frustration flag** — elevated `skipped`/`failed` rates for a provider, especially if concentrated around specific encounter types, may flag situations where ambient capture itself added friction rather than reducing it
- **Cohort definition** — as with CM-01, heavy/moderate/light utilization tiers (PHTI 2025 framework) provide the independent variable for any dose-response NASA-TLX comparison

---

## Missing or Aspirational Hooks

| Missing capability | Why it matters |
|---|---|
| **In-session or immediate post-session micro-survey** | NASA-TLX validity depends on being administered *immediately* after the task it measures — Suki has no mechanism to prompt a clinician for a 1–6 item rating right after a session completes |
| **Pre-visit summary exposure flag (H10)** | If/when pre-visit summaries become available, knowing whether a given encounter was preceded by one is required to test the Tier 3 evaluation design (summary vs. no-summary) |
| **Chart Q&A usage events (H11)** | Same issue — no event log of in-visit chart queries to correlate with reduced lookup burden |
| **Per-encounter "manual correction" signal** | No data on how much a clinician had to manually adjust the generated note during the visit itself (vs. post-visit edits), which would be the most direct in-session task-load proxy Suki could offer |

---

## EHR-Side Data Needed

CM-02 is primarily a survey measure, but EHR audit-log data on *in-encounter* EHR interaction provides an objective corroborating signal for the specific mechanism (reduced typing/clicking during the visit):

| Data element | Purpose | Vendor examples |
|---|---|---|
| In-encounter EHR active time (keystrokes/clicks during the visit) | Objective proxy for in-visit task load — the mechanism NASA-TLX self-report is meant to capture | Epic Signal "Time in Notes" during the encounter window |
| Order-entry events during the encounter | Isolates the H8 (orders staging) pathway from the H1 (note-writing) pathway | EHR order-entry audit log |
| Chart-review/navigation events during the encounter | Isolates the H10/H11 (pre-visit prep, chart Q&A) pathway | EHR audit log (chart open/navigation events) |

Without this data, Suki-native session timing and note-content volume are the only available proxies, and they cannot distinguish *which* of the four plausible hooks (H1, H8, H10, H11) is driving any observed change.

---

## Survey Instruments and Administration

### Validated instruments (in priority order)

- **NASA-TLX (full)** — 6-domain instrument: Mental Demand, Physical Demand, Temporal Demand, Performance, Effort, Frustration. Used in Bracken 2025, PHTI 2025, Omon 2025, Stults 2025. Can be scored as a composite or by subscale — the Frustration and Temporal Demand subscales are most relevant to documentation-specific burden (Karavassilis 2025, Bracken 2025).
- **Physician Task Load Index (PTL)** — 4-item NASA-TLX adaptation, 0–100 scale (lower = better); used in Shah 2024. Lower respondent burden than full NASA-TLX, useful for repeated/frequent administration.
- **Custom cognitive-demand Likert items** — used in Olson 2025 and Duggan 2025 ("Cognitive Burden," "Note-Related Cognitive Task Load"). Lower validity but lower burden; only recommended as a supplement, not a substitute.

### Suggested evaluation design

NASA-TLX's validity is **time-sensitive** in a way CM-01's burnout instruments are not — it must be administered close to the task it measures (immediately post-encounter or post-shift), not weeks later. This creates a different operational challenge than CM-01:

1. **Per-encounter or per-shift administration**, not just pre/post-deployment. A practical compromise (used in several corpus studies) is a brief end-of-shift PTL or NASA-TLX-subscale survey rather than per-encounter.
2. **Dose-response framing**: compare NASA-TLX/PTL scores between heavy and light Suki users at the same point in time, since a true pre/post comparison requires the same timing discipline as CM-01 (pre-deployment baseline).
3. **Pathway isolation (Tier 3, future)**: once H10 (pre-visit summaries) or H11 (chart Q&A) are available, a within-provider design — encounters with vs. without the feature exposure — can isolate which mechanism drives a NASA-TLX change, addressing the "useful to distinguish" note in the hook matrix.
4. **Pair with objective corroboration**: where EHR audit-log in-encounter active-time data is available, report it alongside the NASA-TLX result, the same self-report-vs.-objective pairing recommended for CM-01.

LLM-as-judge methods do not apply to CM-02 — there is no note or transcript artifact being rated; the construct is the clinician's experienced workload.

---

## The Timing Problem

CM-02's central structural gap is narrower but stricter than CM-01's baseline problem: the instrument's validity depends on **proximity to the encounter**, and Suki has no mechanism to trigger a survey at that moment.

```
Encounter ends ──────► Session completes (Suki) ──────► [missing link] ──────► NASA-TLX/PTL prompt
                                                            in-session or
                                                          immediate post-session
                                                          micro-survey trigger
```

**What is achievable today:** Session completion is a known, timestamped event (`status = completed`). In principle this is exactly the trigger a micro-survey would need.

**What is missing:** Any mechanism — in-app prompt, webhook to a partner survey tool, SMS/email trigger — that fires off of session completion to administer a 1–6 item workload rating while the encounter is still fresh. Without this, CM-02 falls back to end-of-shift or periodic administration, which is weaker (more recall aggregation across multiple encounters) but more operationally feasible.

---

## Open Questions for Suki

1. Does Suki's webhook-on-completion event (`session_id`, `encounter_id`, `status`) fire with enough latency tolerance to trigger an external micro-survey (e.g., via the partner app) immediately after a session completes?
2. Is there an existing or planned in-app feedback prompt (beyond the note-quality User Feedback API) that could be extended to include a brief workload item (e.g., single NASA-TLX Frustration or Temporal Demand item) without disrupting clinical workflow?
3. For PBC-enabled sessions, can the count and type of auto-generated ICD-10/IMO codes be retrieved at the per-encounter level, to use as a coding-offload proxy alongside survey data?
4. Once H10 (pre-visit summaries) or H11 (chart Q&A) reach production, will session-level metadata indicate whether a given encounter was exposed to either feature — needed to run the pathway-isolation design described above?
5. Does Suki have any aggregate (de-identified) NASA-TLX or PTL results from prior pilots that could serve as additional external benchmarks?

---

*CM-02 Cognitive and Task Load | Canonical Measures | Individual Impact dimension*
*Internal draft — June 2026*
