# CM-08 Note Completeness and Omission Rate
## Canonical Measure Report — Internal Draft

**Prepared for:** Suki meeting with Sudha, May 6, 2026 (companion to CM-09)
**Measures covered:** CM-08 Note Completeness and Omission Rate (primary); CM-09 Note Inaccuracy Rate (companion — opposite error type)
**Status:** Internal draft for review and editing before sharing externally

---

## What This Measure Captures

**CM-08 Note Completeness and Omission Rate** is whether clinically relevant information discussed in the encounter is captured in the AI-generated note, measured as omission rates, completeness scores, or presence of expected data elements. It is distinct from CM-09 (Note Inaccuracy Rate), which measures content that is *present but wrong*. Together, they cover the two principal failure modes of ambient documentation:

| Error type | Canonical measure | Example |
|---|---|---|
| Missing information | CM-08 — Completeness and Omission Rate | Medication dose mentioned in visit not captured in note |
| Wrong or invented information | CM-09 — Note Inaccuracy Rate | Negation reversed: "patient denies chest pain" → "patient reports chest pain" |

**Why this matters for Suki's value story:** Omissions are the dominant error type in ambient documentation — all 5 simulation studies in the corpus that categorize error types find omissions account for 71–86% of all errors (Kernberg 2023: 86%; Arko 2025: 71%), making completeness the single most consistent Information Quality finding in the literature. Omissions are also more clinically dangerous *in aggregate* than hallucinations for a subtle reason: a missing data point is invisible unless someone goes looking for it, whereas an inserted or contradictory statement is more likely to be caught on read-through. The patient doesn't complain about what's not in the note.

---

## Current Suki Hooks and Data Available

Suki's API provides the same artifacts used for CM-09, applied in the opposite direction — instead of checking whether note content is supported by the transcript, CM-08 checks whether transcript content is represented in the note.

### What Suki exposes natively (H1 + H15)

| Artifact | API endpoint | What it enables |
|---|---|---|
| Full transcript | `GET /session/{id}/transcript` | Ground truth of what was discussed; basis for the expected-element checklist |
| Note content with evidence links | `GET /session/{id}/content` | `source_transcripts[]` lets an auditor confirm whether a transcript-evidenced element made it into the note at all |
| Structured diagnoses | `GET /session/{id}/structured-data` | Machine-readable ICD-10/IMO codes — can be checked for omitted diagnoses discussed in conversation |
| Session audio | `GET /session/{id}/recording` | Raw audio for re-review; retained 30 days |

### Measurement supported right now

- **Automated omission-flag rate** — extract expected clinical elements from the transcript (history items, medications, findings) and flag any with no corresponding note sentence
- **New medication capture check** — whether medications mentioned in the encounter appear in the note's medication list
- **Reference-checklist coverage** — a fixed list of expected elements per encounter type, checked against note content

### A weak existing proxy: `amendment_count`

Suki's vendor metrics mapping already links an `amendment_count` field ("amended or addendum note count") to CM-08 as an **indirect proxy**. This is worth tracking because it is cheap and already instrumented, but it is not a substitute for the rating pipeline below: it counts *any* post-signature note re-open, without distinguishing an omission fix (CM-08), an accuracy correction (CM-09), or an unrelated edit (formatting, coding, dictation cleanup). Treat it as a low-cost screening signal to prioritize chart review, not as a reportable completeness rate.

---

## Missing or Aspirational Hooks

The following capabilities would substantially improve note completeness measurement but are not currently available as documented API endpoints.

| Missing capability | Why it matters |
|---|---|
| **Physician-edited note** (post-accept, pre-sign) | The physician's version after edits — including content they added back in — is the implicit ground truth for what was missing |
| **Edit diff / change log** | Distinguishing *additions* (omission fixes) from *corrections* (CM-09) requires knowing what kind of edit occurred, not just that one occurred |
| **In-app edit events** (character-level or section-level) | Would support real-time, note-level omission-rate computation without manual review |
| **`amendment_count` sub-typing** | If Suki (or the EHR) could tag amendments as addition vs. correction vs. other, the existing weak proxy becomes a much stronger signal |

---

## EHR-Side Data Needed

For health systems with EHR integration, the following fields close the feedback loop — identical to CM-09's requirements, since both measures depend on the same physician-edit signal.

| Data element | Purpose | Vendor examples |
|---|---|---|
| Final signed note text | Gold standard to diff against Suki draft, including content the physician added back | Epic `HNO_NOTE_TEXT`; Cerner `clinical_event.RESULT_VAL` |
| Note version history / edit audit trail | Reconstructs physician edits between Suki output and final note | Epic NoteActivity; EHR audit log table |
| Note signature timestamp and signatory user | Confirms the physician reviewed and accepted the note | Epic `HNO_NOTE.SIGN_INST` |
| Encounter-to-note linkage | Joins Suki `session_id` to EHR note record | EHR encounter ID, MRN, or CSN |

Without the EHR's note version history, there is no programmatic way to know what the physician added back in. As with CM-09, the Suki draft and the EHR final note must both be present to compute a completeness measure at scale rather than as a one-off rater exercise.

---

## Human Rating and LLM-as-Judge

### Validated instruments

- **PDQI-9** (Physician Documentation Quality Instrument): 9-item, 5-point Likert; includes a *Thoroughness* subscale specifically designed to assess whether clinically relevant content is present. Originally designed for human notes; widely used in simulation studies.
- **PDSQI-9** (Provider Documentation Summarization QI): Adapted for AI-generated notes. The same LLM-as-judge validation pattern used for CM-09's Accuracy domain (Afshar 2025b) applies to the Thoroughness domain.

### Suggested evaluation design

**For a small, rapid pilot** using existing Suki sessions — run alongside the CM-09 pilot on the same sample, since it uses the same transcript/note pairs:

1. Pull 50–100 completed session transcripts and note pairs using the `source_transcripts[]` payload.
2. Ask 2–3 physician raters to score each note's Thoroughness domain using the PDQI-9 rubric, flagging specific missing elements.
3. Run an LLM-as-judge prompt (Claude or GPT-4) using the same rubric on the same pairs.
4. Compute inter-rater agreement and human-LLM agreement as a calibration step.
5. If LLM agreement is acceptable (r ≥ 0.7), scale automated scoring to the full session corpus.

Running CM-08 and CM-09 rating in the same pilot wave is efficient — both use the same physician raters, the same transcript/note pairs, and the same PDQI-9/PDSQI-9 instrument, just different subscales.

---

## The Missing Feedback Loop

This is the same central structural gap identified for CM-09, viewed from the opposite direction. Suki generates a note. The physician reviews it, adds back anything missing, and signs it. The physician's additions are the most direct signal of what Suki omitted — but Suki never sees those additions.

```
Suki draft ──────► Physician review ──────► Final signed note (EHR)
     │                                            │
     └──────────── [missing link] ────────────────┘
                edit diff (additions = omissions)
```

**What Suki currently has:** the draft (transcript + generated note), plus a weak `amendment_count` signal that a re-open happened at all.

**What Suki does not have:** which specific content the physician added back in, the final note, or the diff between them.

Closing this loop requires either:
- **An EHR integration** that captures note version history and feeds it back to Suki's analytics pipeline, or
- **A contractual data-sharing provision** in future customer agreements requesting note edit logs or final note text for evaluation purposes.

Until this loop is closed, note completeness can only be measured through simulation studies or one-off rater exercises against the transcript — not as a continuously monitored operational metric against the clinician's true final intent.

---

## Open Questions for Suki

These are specific data-access questions, not broad capability questions:

1. Does Suki's platform retain the pre-edit version of the note after a physician makes changes in the Suki interface (before writing back to the EHR)?
2. Can `amendment_count` (or an equivalent field) be broken down by amendment type — addition, correction, or other — rather than reported as a single undifferentiated count?
3. Are character-level or section-level edit events logged between Suki note generation and provider acceptance, and if so, can additions be distinguished from corrections?
4. Can Suki's `source_transcripts[]` payload be used as the evidence basis for an LLM-as-judge Thoroughness evaluation, run alongside the existing CM-09 Accuracy pilot, or are there data-use constraints that would prevent this?
5. Are there pilot customers where Suki has access to note audit data (edit history, final note) that could support a small completeness validity study?

---

*CM-08 Note Completeness and Omission Rate | Canonical Measures | Information Quality dimension*
*Internal draft — July 2026 | For review before sharing with Sudha / external partners*
