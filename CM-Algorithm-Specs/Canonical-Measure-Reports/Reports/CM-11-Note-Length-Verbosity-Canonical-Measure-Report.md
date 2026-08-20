# CM-11 Note Length and Verbosity
## Canonical Measure Report — Internal Draft

**Measures covered:** CM-11 Note Length and Verbosity (primary); CM-08 Note Completeness and CM-10 Note Quality Overall (interpretive companions — see below)
**Status:** Internal draft for review and editing before sharing externally

---

## What This Measure Captures

**CM-11 Note Length and Verbosity** is the length and lexical richness of AI-generated notes, measured as word count, character count, or lexical diversity (unique vocabulary / total words). It is a proxy for verbosity and informativeness, not a quality measure in its own right — and, unlike every other measure in this batch of four, **it does not have a clear expected direction**.

| Interpretation | What it would mean | Companion signal to check |
|---|---|---|
| Longer = more thorough | Suki captures more clinically relevant content per note | Should co-occur with a *falling* CM-08 omission rate |
| Longer = padded / over-generated | Suki produces excess boilerplate or verbosity that requires editing down | Should co-occur with clinician-reported verbosity concerns and possibly a flat or falling CM-10 composite |

**Why this matters for Suki's value story:** this is a genuinely two-sided finding in the literature, and it should be presented that way rather than folded into a single "value" narrative. Wojda 2025 and Shah 2025 both flag note verbosity as a clinician concern — physicians report needing to edit AI-generated notes down, which can offset documentation-time savings even when the note is otherwise accurate and complete. At the same time, omissions are the dominant error type in this corpus (CM-08: 71–86% of errors), so a note that is *too short* is at least as likely to be a quality problem as one that is too long. CM-11 on its own cannot distinguish these cases; it is only informative when read alongside CM-08 and CM-10.

---

## Current Suki Hooks and Data Available

Unlike CM-08, CM-09, and CM-10, this is the one measure in the current batch that is **fully computable from note text alone**, with no rater pipeline required.

### What Suki exposes natively (H1)

| Artifact | API endpoint | What it enables |
|---|---|---|
| Generated note content | `GET /session/{id}/content` | Direct source for word count, character count, and lexical diversity — no additional processing needed |
| Full transcript | `GET /session/{id}/transcript` | Encounter-length context, useful for normalizing note length against how much was actually discussed |

### Measurement supported right now

- **Word / character count per note** — computed directly from `GET /session/{id}/content` for every completed session
- **Lexical diversity (type-token ratio)** — computed from the same note text; should be reported with a length-normalized variant (e.g., MTLD) rather than raw TTR, since raw TTR is mechanically inflated for shorter notes
- **Distributional reporting** — because there's no single "right" length, this measure is best reported as a distribution (mean, spread, outliers) rather than a single target number

---

## Missing or Aspirational Hooks

| Missing capability | Why it matters |
|---|---|
| **Final signed note text** | Length/diversity on the physician-accepted note (after any trims or additions) is a more meaningful signal than length of the Suki draft alone |
| **Human-authored reference note** | Needed for the note-length-ratio variant (AI note / human note); rarely available outside simulation or RCT designs |
| **Per-encounter transcript-to-note length ratio** | Would help distinguish "long because the encounter was long/complex" from "long because of padding," independent of the CM-08/CM-10 cross-check |

---

## EHR-Side Data Needed

This is the one measure in the batch where EHR data is genuinely optional rather than central — the primary unit is already computable from Suki-native data alone.

| Data element | Purpose | Vendor examples / Notes |
|---|---|---|
| Final signed note text | Extends length/diversity measurement to the physician-accepted note | Epic `HNO_NOTE_TEXT` / `HNO_PLAIN_TEXT` — **unconfirmed/exploratory**; field names and availability have not been verified against a live Epic EHI extract |
| Documentation length telemetry (chars/week) | Possible pre-aggregated fallback if raw note text access is restricted | Vendor-specific; **unconfirmed/exploratory** |
| Encounter-to-note linkage | Joins Suki `session_id` to EHR note record, needed to pair Suki-side and EHR-side length data | EHR encounter ID, MRN, or CSN |

**What can be done without this EHR data:** the full primary-unit computation (word count, character count, lexical diversity) on the Suki draft, at scale, today. **What EHR data adds:** measuring the physician-accepted final note instead of the draft, and enabling the note-length-ratio variant against a human-authored comparison note.

---

## The Direction Problem

This is the central structural issue for CM-11, and it is different in kind from the other three measures in this batch: it is not a data-access gap, it is an **interpretive ambiguity that no amount of additional data resolves on its own**.

```
Note length change (post-Suki-adoption)
        │
        ├──► increases  ──► could mean: more thorough (good)   ──► check: is CM-08 omission rate falling?
        │                could mean: more padding (concerning) ──► check: are clinicians flagging verbosity?
        │
        └──► decreases  ──► could mean: less padding (good)      ──► check: is CM-10 composite stable/rising?
                          could mean: content being dropped (bad) ──► check: is CM-08 omission rate rising?
```

**What is achievable today:** a fully automated, high-confidence measurement of note length and lexical diversity, for every session, at no data-collection cost.

**What is missing:** a standalone interpretation. CM-11 cannot tell you, by itself, whether a length change is good or bad — it can only be read meaningfully in combination with CM-08 (did completeness improve or decline?) and CM-10 (did overall quality improve or decline?), or with direct clinician feedback on verbosity burden.

This means CM-11 should never be reported as a single trend line with an implied "lower is better" or "higher is better" framing. Any dashboard presentation should either (a) show CM-11 alongside CM-08 and CM-10 in the same view, or (b) present it as a distribution/outlier-monitoring tool rather than a directional KPI.

---

## Open Questions for Suki

These are specific data-access questions, not broad capability questions:

1. Does Suki's platform retain the pre-edit draft note length separately from the length after any in-app physician edits, before EHR writeback?
2. For EHR-integrated deployments, is note text (or a pre-computed length/character-count field) exposed anywhere in Suki's data feed today, or would this require a new integration?
3. Are there existing internal Suki metrics (e.g., "average characters per note" seen in some vendor telemetry) that could be reused directly, and if so, are they computed on the draft or the final signed note?
4. Has Suki collected any qualitative feedback specifically about note verbosity/length (beyond what's captured in general satisfaction surveys) that could help calibrate what "too long" means in practice?
5. Would Suki be open to a small paired study — same encounter, Suki-generated note length vs. a physician-authored comparison note — to establish a length-ratio baseline?

---

*CM-11 Note Length and Verbosity | Canonical Measures | Information Quality dimension*
*Internal draft — July 2026*
