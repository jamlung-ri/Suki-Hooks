# CM-24 Transcription and ASR Accuracy
## Canonical Measure Report — Internal Draft

**Measures covered:** CM-24 Transcription and ASR Accuracy (primary); upstream of CM-08 (Note Completeness), CM-09 (Note Inaccuracy), CM-10, and CM-12 — ASR errors propagate into all note-quality measures, but CM-24 scores the *transcript*, not the note
**Status:** Internal draft for review and editing before sharing externally

---

## What This Measure Captures

**CM-24 Transcription and ASR Accuracy** is the technical accuracy of automatic speech recognition (ASR) in transcribing clinical conversations — Word Error Rate (WER), speaker diarization accuracy, and medical vocabulary recognition. It is the **upstream quality gate**: if the transcript is wrong, the generated note will be wrong regardless of how good the summarization/NLP layer downstream is.

It is distinct from the note-quality measures it feeds:

| Construct | Canonical measure | What it captures |
|---|---|---|
| Transcript fidelity | CM-24 — Transcription and ASR Accuracy | Did the ASR correctly convert speech to text? |
| Note completeness | CM-08 — Note Completeness | Did the generated note include everything clinically relevant that was said (correctly transcribed or not)? |
| Note accuracy | CM-09 — Note Inaccuracy Rate | Does the generated note contain fabricated or incorrect content (regardless of transcript source)? |

**Why this matters for Suki's value story — and why this report reads differently from every other one in this set:** the honest answer is that it currently *cannot* matter, because the data doesn't exist. Only 3 papers in the entire 54-paper corpus measure ASR accuracy as an outcome at all (Anderson 2025, Wang 2025, van Buchem 2021), and van Buchem 2021's own scoping review documents that **no commercial ambient-AI vendor — Suki included — publishes WER or diarization accuracy figures.** This is a fundamental, industry-wide evidence gap, not a Suki-specific weakness: the acoustic quality of every commercial ambient scribe product (DAX, Abridge, Suki, Ambience) is entirely unknown in the published literature. This report should not be read as building toward a value claim; it should be read as documenting why one cannot currently be made, and what would need to change for that to become possible.

---

## Current Suki Hooks and Data Available

Suki's API exposes the two artifacts a WER pilot would need as raw inputs — but not the artifacts needed to actually score WER.

### What Suki exposes natively (H1)

| Artifact | API endpoint | What it enables |
|---|---|---|
| Full transcript (final text) | `GET /session/{id}/transcript` | The ASR *output* — but not the decoder-internal data (confidence, N-best lists, word-level alignment) that a rigorous WER pipeline would compare against |
| Session audio | `GET /session/{id}/recording` | Raw audio for re-transcription by an independent human transcriptionist — the necessary starting point for any WER pilot; retained 30 days |

### Measurement supported right now

None. This is the one canonical measure in the corpus where the honest answer to "what can be computed today" is **nothing**, using only currently-documented Suki hooks. The formula is standard and well understood industrywide; the blocker is entirely on the data-availability side.

---

## Missing or Aspirational Hooks

Every one of these would need to exist before CM-24 could be computed for Suki sessions — this is a longer and more foundational list than for any other canonical measure in the corpus.

| Missing capability | Why it matters |
|---|---|
| **ASR decoder output** (word-level confidence, timestamps, N-best hypotheses) | The raw material a WER alignment needs beyond the already-exposed final transcript text |
| **A reference-transcript production workflow** | WER cannot be computed without an independent, human-produced ground-truth transcript for at least a sample of sessions |
| **Ground-truth speaker-turn labels** | Required to score diarization accuracy separately from word-level WER |
| **A published or shared vendor WER benchmark** | Would let Suki's numbers be interpreted in context — none exists industry-wide today |
| **A clinical-vocabulary tagging layer over reference transcripts** | Required to compute Medical Term Recall (Wang 2025) as distinct from generic WER, since standard WER under/over-penalizes clinical terms depending on tokenization |

---

## EHR-Side Data Needed

Minimal to none. This measure does not require EHR data at all — the entire evaluation is Suki-audio-to-transcript, upstream of any EHR write-back. The blocker is exclusively on the ASR pipeline / reference-transcript side, not the EHR side.

---

## Suggested Evaluation Design (If Pursued)

Unlike CM-09, this is not a pilot design Suki can run purely with data it already has — it requires a new, dedicated benchmarking effort. Included here for planning purposes; none of this belongs on the algorithm card itself, since the card documents the *standard field method*, not a proposal.

### Validated instruments / methods

- **Word Error Rate (WER)** — the field-standard metric; NIST `sclite` or the open-source `jiwer` library are the common scoring tools. Requires a human reference transcript.
- **Speaker Diarization Accuracy** — standard in speech-processing evaluation (e.g., DER — Diarization Error Rate — is a closely related, more granular metric worth considering as an alternative or complement).
- **Medical Term Recall (MTR)** — Wang 2025's proposed submetric; requires a clinical-vocabulary tagging pass on top of the reference transcript.

### Suggested evaluation design

**For a small, rapid pilot**, structured similarly to CM-09's PDQI-9 pilot pattern but adapted for transcript-level (not note-level) evaluation:

1. Sample 50–100 completed sessions with available audio (`GET /session/{id}/recording`, 30-day retention window — sampling must happen promptly after the encounter).
2. Commission an independent, professional medical transcriptionist to produce reference transcripts, blind to the Suki ASR output.
3. Score WER via standard edit-distance alignment (`jiwer` or equivalent) between the Suki transcript and the reference transcript.
4. Have the same transcriptionist (or a second rater) label ground-truth speaker turns; score diarization accuracy separately.
5. Tag clinical vocabulary in the reference transcripts (drug names, anatomical terms, abbreviations) to compute Medical Term Recall as a submetric.
6. Report WER, diarization accuracy, and MTR as a distribution (not a single point estimate) — audio quality and speaker overlap vary significantly by encounter, and the corpus's own Key Note suggests this variance is itself informative.

This design would make Suki the first ambient-AI vendor with a published WER figure in this literature space — a genuinely differentiated position, precisely because the current opacity is industry-wide rather than Suki-specific.

---

## The Industry-Wide Opacity Gap

This is the central structural gap for CM-24, and it differs in kind from every other report in this set: it is not a Suki-integration gap or a feedback-loop gap — it is an **industry-wide absence of published data** that happens to also apply to Suki.

```
Session audio (Suki has this) ──► [ missing: reference transcript ] ──► WER score
                                          │
                                   [ missing: ASR decoder output ]
                                          │
                              No vendor — Suki, DAX, Abridge, Ambience —
                              publishes this data. Documented pattern
                              since van Buchem 2021.
```

**What is achievable today:** nothing, using only currently-documented Suki data. The formula is not in question; the inputs are.

**What is missing:** a reference-transcript production workflow (either an internal benchmarking pilot or a data-sharing arrangement with an independent transcription vendor), and an internal decision on whether Suki wants to be the first vendor in this space to publish a WER figure.

Until either of those exists, CM-24 can only be reported as "formula defined, data unavailable" — not as a measured value, and not as a projected trend. Any external-facing material referencing CM-24 should state plainly that this is a known, industry-wide gap rather than implying Suki's ASR quality is unmeasured for any product-specific reason.

---

## Open Questions for Suki

These are specific data-access questions, not broad capability questions:

1. Does Suki's ASR pipeline retain any decoder-internal output (word-level confidence, timestamps, N-best hypotheses) internally, even if not exposed via the documented API — and could a research-only extract be made available for a benchmarking pilot?
2. Has Suki ever commissioned or reviewed an internal WER benchmark against a reference transcript, even informally, that could inform expected ranges before a new pilot is designed?
3. Would Suki be willing to participate in a small reference-transcript benchmarking pilot (50–100 sessions), given the opportunity to be the first ambient-AI vendor with a published WER figure?
4. Is there an existing relationship with a third-party medical transcription vendor that could be leveraged for reference-transcript production, rather than building this capability from scratch?
5. Does Suki's ASR pipeline vary by audio input device or environment (e.g., phone mic vs. dedicated hardware) in a way that would require stratifying any future WER benchmark by device/environment rather than reporting a single aggregate figure?

---

*CM-24 Transcription and ASR Accuracy | Canonical Measures | System Quality dimension*
*Internal draft — July 2026*
