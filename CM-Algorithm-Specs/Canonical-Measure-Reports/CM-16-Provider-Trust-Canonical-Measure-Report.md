# CM-16 Provider Trust in AI
## Canonical Measure Report — Internal Draft

**Measures covered:** CM-16 Provider Trust in AI (primary); CM-15 Provider Satisfaction and Usability (boundary — overall experience after use, vs. trust as a precondition) and CM-19 Clinical Patient Safety (boundary — overreliance/automation-bias risk sits at this intersection but is not itself measured here)
**Status:** Internal draft for review and editing before sharing externally

---

## What This Measure Captures

**CM-16 Provider Trust in AI** is the degree to which clinicians perceive AI-generated documentation as accurate and dependable enough to act on without exhaustive verification — measured via a direct Likert trust item, or via qualitative coding of skepticism and verification behavior in interviews.

It is distinct from two adjacent constructs:

| Construct | Canonical measure | What it captures |
|---|---|---|
| Overall experience after use | CM-15 — Provider Satisfaction and Usability | A retrospective evaluation of the tool as a whole, formed after and because of use |
| Downstream patient harm | CM-19 — Clinical Patient Safety | Actual adverse events or harm outcomes — trust is an attitudinal precondition that can precede either appropriate confidence or unsafe over-reliance, but CM-16 alone cannot distinguish the two |

**Why this matters for Suki's value story — and the central caveat:** This is the thinnest evidence base in the current batch after CM-14. Only 3 papers formally measure trust as a study outcome (Afshar 2025b, Shah 2025, Wojda 2025), and 2 of the 3 are qualitative. The corpus explicitly places this construct in the Use (U) dimension rather than User Satisfaction (US) *because* it is theorized to precede adoption rather than result from it — clinicians who doubt output accuracy either reject the tool outright or over-verify every note, both of which surface as adoption failure rather than a satisfaction score. Related but distinct constructs — ethical/legal concern (Falcetta 2023) and fear of downstream consequences (Bundy 2024) — were deliberately excluded from this measure and belong to Organizational Impact and Individual Impact dimensions respectively. Any value-story claim here should be flagged as based on a small, mixed-methods evidence base, not a large corpus consensus.

---

## Current Suki Hooks and Data Available

Trust is **not directly observable from Suki's API** — like burnout and satisfaction, this is a provider-reported attitudinal construct, and unlike those two, Suki has no natural proxy signal (no session-timing or skip/fail-rate analog tracks trust specifically). Suki's contribution is limited to utilization-cohort scaffolding.

### What Suki exposes natively (H1)

| Artifact | API endpoint | What it enables |
|---|---|---|
| Session creation logs | `GET /session/{id}/status` (aggregated) | Sessions per provider per day/week — utilization intensity, the basis for dose-response cohorts |

### Measurement supported right now

- **Exposure/cohort definition** — stratify providers into heavy (≥70% utilization), moderate (30–69%), and light (<30%) users per the PHTI 2025 framework, for use as the independent variable in a trust dose-response design

Notably, this is a smaller Suki contribution than any other measure in this batch — there is no Suki-native proxy for verification behavior (e.g., time spent reviewing a note before signing), so the trust construct itself remains entirely dependent on external survey/interview data.

---

## Missing or Aspirational Hooks

| Missing capability | Why it matters |
|---|---|
| **In-app survey distribution** | No documented mechanism for Suki to push a trust item to providers at defined intervals |
| **Verification-behavior signal** | Suki has no timestamped record of note-review or edit activity that could serve as a behavioral proxy for verification/over-reliance — unlike CM-01's after-hours timing proxy, there is no analog here |
| **Interview/qualitative data capture** | No mechanism to collect or store structured qualitative theme codes tied to session-level data |
| **A larger validated evidence base** | Not a Suki data gap, but a literature gap — only 3 papers measure this construct, limiting how confidently any Suki-sponsored result can be interpreted against a corpus benchmark |

---

## EHR-Side Data Needed

CM-16 is not an EHR-data measure. No EHR-side data element is required to compute it.

---

## Survey Instruments and Administration

### Validated instruments (in priority order)

- **Direct "Trust in AI" Likert item** — used as a secondary outcome in Afshar 2025b's pragmatic RCT. The only quantitative instance of this construct in the corpus; exact item wording and scale anchor are not confirmed in the reviewed materials.
- **Qualitative thematic coding of skepticism and verification behavior** — used in Shah 2025 and Wojda 2025, both HCI/qualitative studies of physician perspectives on ambient AI scribes.
- **Accuracy Confidence survey items** — referenced via Karavassilis 2025 as an alias, though that paper is not listed among the 3 formally measuring this construct as a study outcome — treat as a loosely related data point, not a fourth confirmed source.

### Suggested evaluation design

1. **Phase 0 (at or before go-live):** Administer a generalized/dispositional trust-in-AI item — trust in AI documentation tools broadly, since trust in Suki specifically cannot be rated before any use.
2. **Weeks 1–16:** Track Suki utilization per provider; assign heavy/moderate/light cohorts by week 4.
3. **Phase 3 (months 4–9):** Repeat a Suki-specific version of the trust item. Separately, conduct semi-structured interviews with a subsample, coding for verification-behavior themes (always re-checks, spot-checks, rarely verifies) per Shah 2025/Wojda 2025 methodology.
4. **Reporting:** Present the quantitative dose-response delta alongside — not blended with — the qualitative theme distribution. A rising trust score paired with a "rarely verifies" theme cluster is a different finding than a rising trust score paired with continued spot-checking, and the two should not be collapsed into one number.

LLM-as-judge methods do not apply to CM-16 in the way they do to CM-09/CM-10 note-quality measures — there is no note-quality artifact to score. However, if verification-behavior data (e.g., edit timing or content-change patterns) ever becomes available, an LLM-as-judge approach could in principle classify edit patterns into the same skepticism taxonomy used for interview coding — this is speculative and not currently supported by any Suki data element.

---

## The Overreliance Blind Spot

This is the central structural gap for CM-16. A rising trust score is, on its own, ambiguous — it cannot distinguish appropriate calibrated confidence from unsafe automation bias.

```
Trust-in-AI Likert score (rising) ──────► Ambiguous: which of these is actually happening?
        │
        ├──────► Appropriate confidence: verification calibrated to actual (low) error rate
        │
        └──────► Automation bias: verification drops below what accuracy actually warrants
                          │
                          └────────────────── [missing link] ──────────────────┐
                                    a paired verification-behavior or                │
                                    error-detection signal, which would                │
                                    distinguish the two paths above                    ▼
                                                                      Would require either
                                                                      CM-09-style note-accuracy
                                                                      data or a direct behavioral
                                                                      verification-time signal —
                                                                      neither exists for CM-16 today
```

**What is achievable today:** A trust score and a qualitative verification-behavior theme code, reported side by side.

**What is missing:** A quantitative link between the two — ideally, trust score cross-tabulated against actual note-accuracy rate (CM-09) for the same providers, which would let a rising trust score be validated against whether the confidence is actually warranted.

Until this is addressed, CM-16 should never be reported as a standalone safety-adjacent metric. A high trust score is a Use-dimension finding about adoption readiness, not a Patient Safety finding — see CM-19's own scope-narrowing guidance for the same boundary from the other direction.

---

## Open Questions for Suki

1. Does Suki (or Suki's customer success process) have any existing template or mechanism for administering a trust-in-AI item to providers at defined intervals?
2. Does Suki retain any timestamped signal of note review or edit activity between AI-generated draft and provider sign-off that could serve as an indirect verification-behavior proxy, even if not originally designed for this purpose?
3. Has Suki, in any prior customer engagement, collected qualitative feedback (interviews, open-response survey items) that touches on trust or skepticism themes, even informally, that could inform instrument or taxonomy design here?
4. If Suki's note-accuracy work (CM-09's `source_transcripts[]`-based evaluation) matures into an operational metric, would Suki support cross-tabulating it against a trust survey for the same provider cohort, to test whether trust tracks actual accuracy?
5. Given the thin evidence base (3 papers, 2 qualitative), would Suki be interested in co-sponsoring a small dedicated trust-calibration study, rather than folding this into a general satisfaction survey where the distinct precondition-vs-outcome framing could get lost?

---

*CM-16 Provider Trust in AI | Canonical Measures | Use dimension*
*Internal draft — July 2026*
