# CM-19 Clinical Patient Safety
## Canonical Measure Report — Internal Draft

**Measures covered:** CM-19 Clinical Patient Safety (primary); boundary with CM-09 (Note Inaccuracy / Hallucination), CM-08 (Note Completeness)
**Status:** Internal draft for review and editing before sharing externally — **see "Scope Narrowing" before treating any error-rate data as a CM-19 finding**

---

## What This Measure Captures

**CM-19 Clinical Patient Safety** is patient *harm* outcomes associated with ambient AI documentation — adverse events, AHRQ harm scores, and gaps between what gets documented and what clinical action actually follows. The canonical measures corpus describes this as **"the most concerning and least studied outcome dimension"** — only 9 papers touch it, most using simulated or survey data rather than real patient outcomes, and per the H1×CM hook matrix it is **"the measure most in need of study and most understudied."**

The H1 deep-dive scores CM-19 at **6/12 ("Monitor")** — External (1) data access, Low (1) signal clarity, Weak (1) external benchmark, but **High (3) actionability** (a safety finding would always be actionable). H1 (ambient documentation) itself is rated **○ (none)** for CM-19 in the hook×measure matrix — ambient note generation alone does not plausibly move a harm outcome. The two hooks that *do* introduce safety-relevant pathways are:

- **H8 (orders staging)** — described as introducing **"the highest-stakes new safety variable"**: an order placed (or not placed, or placed incorrectly) based on an AI-assisted workflow is a direct safety-relevant event, unlike a documentation error in a note.
- **H11 (chart Q&A)** — "could improve or worsen safety depending on answer accuracy" — if a clinician asks Suki a clinical question and acts on the answer, an inaccurate answer is a safety event in a way an inaccurate note section is not.

---

## Scope Narrowing: CM-19 vs. CM-09 (Critical)

The canonical measure definition includes an explicit, prescriptive scope warning that should govern how *any* error-rate data is framed:

> **True patient safety requires measured patient harm outcomes. Errors in documentation that do not demonstrate a downstream patient outcome are technical quality issues (→ CM-09 Note Inaccuracy Rate), not safety. Severity of error is not patient safety without evidence of patient harm.**

The corpus goes further and flags several commonly-cited "safety" items as likely **misclassified** and candidates for reclassification to CM-09 or CM-08 unless a patient-outcome link is demonstrated:

| Cited as CM-19 in literature | Recommended classification absent outcome evidence |
|---|---|
| "Clinically Significant Errors in AI Notes" (Biro 2025, Anderson 2025) | CM-09 (Note Inaccuracy) — unless a downstream patient outcome is documented |
| "Negation Errors" (Bundy 2024) | CM-09 (Note Inaccuracy / Hallucination) |
| RDoC Symptom Documentation Level, PHQ-9 Documentation (Castro 2025) | CM-08 (Note Completeness) — documentation completeness, not a harm outcome |
| Likelihood of Psychiatric Intervention, aOR (Castro 2025) | Quality of care / clinical decision rate — adjacent to safety but not itself a harm event |

**Practical implication for Suki:** the H1×CM matrix's "evidence linking" feature (H15, the architectural response to CM-09/CM-16) and any note-accuracy auditing built for CM-09 will generate data that *looks* safety-relevant but, per this scope note, should be reported under CM-09/CM-08 unless paired with an actual downstream clinical-action or harm signal. Only when an error or completeness gap is traced through to an observed clinical action (or its absence) does it become a CM-19 finding.

---

## The Castro 2025 Replication Opportunity

This is the landmark finding in the CM-19 literature and the most concrete, replicable design pattern available:

**The finding:** Castro 2025 found that ambient scribe use was associated with **more psychiatric symptom documentation but significantly *less* psychiatric intervention** (aOR 0.83, p=.005, preprint only). The interpretation offered is a potential unintended consequence — the AI documents more thoroughly, but something about the workflow (e.g., the clinician reviewing AI-generated documentation rather than actively eliciting and acting on symptoms in real time) is associated with *less* downstream clinical action.

**Why this matters for Suki:** this is the only finding in the entire CM-19 literature that links a *documented* signal (symptom documentation level — something Suki's structured-data output plausibly increases) to a *clinical action* signal (intervention rate — something only the EHR can provide). It is a template for the kind of analysis CM-19 needs: **documentation-completeness data (Suki-native) + downstream clinical-action data (EHR) → association testing**, exactly the design Castro 2025 used.

```
Suki structured output (PBC / ICD-10, note sections) ──► Documentation completeness signal
                                                                    │
                                                            [missing link]
                                                     EHR order/intervention data for
                                                     the same encounters
                                                                    │
                                                                    ▼
                                          Replication test: does increased documentation
                                          completeness correlate with increased OR decreased
                                          downstream clinical action? (Castro 2025 pattern)
```

**What is achievable today:** Suki's structured-data output (`/structured-data`, PBC-generated ICD-10/IMO codes, note section presence/absence) already provides a documentation-completeness signal per encounter — the same kind of signal Castro 2025 used (RDoC level, PHQ-9 documentation).

**What is missing:** Any linkage to EHR order/intervention data for the same encounters, without which the documentation-completeness signal cannot be connected to a clinical-action outcome — and per the Scope Narrowing section above, remains a CM-08/CM-09 finding, not a CM-19 finding, until that linkage exists.

---

## Current Suki Hooks and Data Available

### What Suki exposes natively

| Artifact | API endpoint | What it enables |
|---|---|---|
| Structured diagnoses / PBC output | `GET /session/{id}/structured-data` | Documentation-completeness signal (e.g., was a relevant symptom/diagnosis captured as a structured code) — the Suki-side half of the Castro 2025 replication design above |
| `source_transcripts[]` evidence linking | `GET /session/{id}/content` | If H11 (chart Q&A) is in use, evidence linking could in principle support auditing whether a chart Q&A answer was grounded in the source record — relevant to the "answer accuracy" half of the H11 safety concern |
| Session status (`completed`/`skipped`/`failed`/`aborted`) | `GET /session/{id}/status` | Denominator hygiene only |

### Measurement supported right now

- **Nothing measures CM-19 directly today.** Consistent with H1 = ○ for this measure, Suki's current production hooks (H1, ambient documentation) do not have a plausible direct safety pathway.
- **Documentation-completeness signal exists** for a Castro-2025-style design, but is unusable for CM-19 without EHR-side linkage (see above) — until then it is CM-08 data.
- **H8 and H11 are the relevant future hooks**, not H1 — any CM-19 evaluation plan should be scoped against H8/H11 deployment timelines, not current production capability.

---

## Missing or Aspirational Hooks

| Missing capability | Why it matters |
|---|---|
| **H8 order-staging audit trail** | If/when H8 (orders staging) ships, an audit trail distinguishing AI-staged orders from manually-entered orders — and whether staged orders were accepted, edited, or rejected before submission — is the foundation of the "order error audit: staged vs. manual order" design (hook matrix Sprint 3D) |
| **H11 chart Q&A answer-accuracy audit** | For "EHR audit: query accuracy + downstream clinical action" (hook matrix Sprint 3B) — requires both the Q&A interaction log (question asked, answer given, evidence cited) and a way to verify the answer against the source record |
| **Encounter-level linkage to EHR orders/interventions** | The single biggest structural gap — without it, no Suki-native documentation signal can be tested against a clinical-action outcome, which is the only thing that makes a finding "CM-19" rather than "CM-08/CM-09" per the scope note |

---

## EHR-Side Data Needed

| Data element | Purpose | Notes |
|---|---|---|
| Order/intervention data linked to encounter (e.g., psychiatric referral, medication order, follow-up scheduling) | The clinical-action half of the Castro 2025 replication design; also required for the H8 order-error audit once that hook ships | Highest-priority EHR data request for this measure |
| AHRQ Harm Score / formal incident reports | The "gold standard" CM-19 outcome, but typically lives in administrative/risk-management systems separate from the EHR proper — likely the hardest data to access of any canonical measure | Site-dependent; may require a separate data-sharing path from clinical EHR data |
| PHQ-9 / structured screening documentation fields | EHR-side equivalent of the documentation-completeness signal, for cross-validation against Suki's structured output | Standard EHR flowsheet/screening field |

---

## Open Questions for Suki

1. For sessions where PBC/structured-data output includes a symptom or diagnosis code, is there any existing or feasible way to link that encounter to subsequent EHR order/intervention data — even in a limited pilot — to attempt a Castro-2025-style replication?
2. What is the realistic timeline for H8 (orders staging) reaching a stage where an audit trail (AI-staged vs. manual, accepted/edited/rejected) would exist? CM-19 evaluation planning should be sequenced against this.
3. Similarly, for H11 (chart Q&A): once available, will interaction logs (question, answer, cited evidence) be retained in a form that supports an accuracy audit?
4. Is Suki aware of any internal safety-monitoring or incident-reporting process for AI-generated content today, even informal, that could serve as an early-warning signal ahead of formal CM-19 instrumentation?
5. Given the Scope Narrowing guidance above, would Suki's team find it useful to have CM-09 (Note Inaccuracy) reporting explicitly annotated with "downstream clinical action observed: yes/no/unknown," so that any future CM-19 analysis can be retrospectively identified from existing CM-09 data collection rather than requiring new instrumentation?

---

*CM-19 Clinical Patient Safety | Canonical Measures | Organizational Impact dimension*
*Internal draft — June 2026*
