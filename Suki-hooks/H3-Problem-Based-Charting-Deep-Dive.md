# H3 Problem-Based Charting (PBC) — Deep Dive

**Hook:** Ambient note organized by patient problems; generates ICD-10 and IMO codes as structured output
**Status:** Production. Available via APIs, Web SDK (v2.1.2+), Mobile SDK (iOS).
**Dependency:** Requires H1 (Ambient Documentation) as the base; PBC is a configuration layer on top of an ambient session, not a standalone product.
**Related hook:** H9 (Coding Suggestions) consumes H3's structured output for revenue cycle use. See [H9-Coding-Suggestions-Deep-Dive.md](H9-Coding-Suggestions-Deep-Dive.md).

---

## 1. Technical Architecture

### 1.1 What PBC Is and Is Not

PBC is a **note organization and structured coding layer** on top of ambient documentation. Without PBC, Suki generates a traditional note organized by clinical sections (HPI, Assessment & Plan, etc.). With PBC, Suki reorganizes the note around patient problems and additionally generates machine-readable diagnosis codes as structured data output.

PBC does **two things** simultaneously that must be understood separately for measurement:
1. **Note organization** — content grouped by problem rather than by section type
2. **Structured coding output** — ICD-10 and IMO codes as a machine-readable JSON artifact (`structured_data.diagnoses[]`)

These two outputs serve different downstream purposes and map to different CMs.

### 1.2 The PBC Data Pipeline

```
PRE-SESSION — Context Seeding
  Partner feeds existing patient diagnoses (from EHR problem list) into session context
  Input: ICD-10 codes (preferred) or IMO codes per diagnosis
  Method: POST /session/{id}/context → diagnoses.values[]
          OR ambientOptions.diagnoses (Web SDK v2.1.2+)
  Context also includes: specialty, provider role, visit type, chief complaint, reason for visit

  Input diagnoses per session:
    {codes: [{code: "I10", description: "Essential hypertension", type: "ICD-10"}],
     diagnosis_note: "Hypertension"}

DURING SESSION — Conversation Analysis
  Suki's CKG tracks which pre-existing diagnoses are discussed
  Identifies new problems raised in conversation
  Three possible actions per input diagnosis:
    (1) Discussed → updated, returned in output with enriched coding
    (2) Not discussed → silently dropped from output
    (3) New problem detected → generated as new diagnosis entry

POST-SESSION — Structured Output
  Note artifact (from /content):
    - LOINC-coded sections, now organized by problem
    - Each problem groups HPI, Assessment, Plan together
  Diagnosis artifact (from /structured-data):
    - Only diagnoses that were discussed OR newly generated
    - Each includes: ICD-10 code, IMO code, diagnosis_note,
      laterality_indicator, post_coord_lex_flag
  Encounter-level cumulative (from /encounter/{id}/structured-data):
    - Aggregates across multiple ambient sessions in one encounter
```

### 1.3 Key Technical Details for Measurement

**Input → output reconciliation is the core mechanism.** The difference between what was seeded (pre-existing problem list from EHR) and what appears in the output (discussed problems with updated/new codes) is the measurement surface. Diagnoses seeded but not returned = not discussed. Diagnoses returned but not seeded = newly identified. This delta is directly measurable from Suki's own data.

**AutoCoding is off by default.** Partners can toggle AutoCoding — when off, the seeded ICD-10 code is used as-is if the diagnosis is discussed. When on, Suki may recode the diagnosis based on conversation content. The AutoCoding setting affects whether output codes match input codes, which matters for coding accuracy measurement.

**Output enrichment is deterministic.** For every returned diagnosis, Suki adds: ICD-10 code, IMO equivalent, laterality (left/right/bilateral where applicable), and post-coordination flag. These are not optional or probabilistic — they are always computed and always present in the response.

**Re-ambient sessions do NOT inherit context.** In multi-session encounters, the partner must re-seed diagnoses for each new session. This creates a data integration responsibility and a potential gap source — if the partner fails to carry forward prior session output as the next session's input, problems from earlier sessions may be missed.

**ICD-10 is the recommended input; output can include ICD-10, IMO, and SNOMED.** The output code type may differ from the input code type — Suki uses the most accurate code based on conversation. This normalization is designed behavior, not an error.

### 1.4 Data Artifacts Available for Measurement

| Artifact | API Endpoint | Measurement-Relevant Fields | Retention |
|---|---|---|---|
| Input diagnosis list (seeded) | Context API payload (partner-held) | codes, type, description per diagnosis | Partner-held |
| Session structured output | `GET /session/{id}/structured-data` | `codes[]`, `diagnosis_note`, `laterality_indicator`, `post_coord_lex_flag` per discussed diagnosis | Contract duration |
| Encounter structured output | `GET /encounter/{id}/structured-data` | Same fields, cumulative across sessions | Contract duration |
| PBC note content | `GET /session/{id}/content` | Problem-organized note sections with source_transcripts | Contract duration |
| Final claim codes | Claims / EHR (external) | CPT, ICD-10, E&M level, denial status | External |

---

## 2. What Suki Can Measure from Its Own Data

**Without EHR or claims integration:**

| Metric | Computation | CM Linkage |
|---|---|---|
| PBC sessions per provider | Sessions with `isPBNSection: true` configured | CM-13 (PBC adoption rate) |
| Diagnoses generated per session | `len(structured_data.diagnoses.values)` | CM-21 proxy (coding volume) |
| New diagnoses per session (not in input) | Output diagnoses not present in seeded input | CM-08 (problem capture rate) |
| Dropped diagnoses rate | Seeded diagnoses not returned in output | Encounter scope of discussion proxy |
| ICD-10 vs. IMO code distribution | `code.type` in output | Coding standard adherence |
| Laterality capture rate | `laterality_indicator` presence | Coding completeness signal |
| Post-coordination flag rate | `post_coord_lex_flag` presence | Coding specificity signal |
| Diagnoses per encounter (cumulative) | Encounter structured data endpoint count | Encounter complexity proxy |

**Key Suki-native measurement opportunity:** The difference between *input diagnosis count* (from problem list) and *output diagnosis count* (from structured data) per session is a direct proxy for how many additional problems were identified in conversation beyond what was pre-charted. This is measurable entirely from Suki API data and has direct CM-08 and CM-21 implications.

**With EHR or claims integration:**

| Metric | Additional Source | CM Linkage |
|---|---|---|
| ICD-10 output → claim accuracy | Claims data | CM-21 (coding accuracy) |
| HCC capture rate (from ICD-10 output) | HCC mapping table applied to output | CM-21, CM-20 |
| E&M level change | Claims data (CPT 99212–99215) | CM-21, CM-20 |
| Problem list update rate | EHR post-encounter problem list | CM-08 (note → EHR fidelity) |
| Denial rate change | RCM system | CM-21 (coding defensibility) |

---

## 3. CM Fit Analysis for H3

Using the same four-dimension scoring framework as H1 (Data Access / Signal Clarity / External Benchmark / Actionability, max 12):

| CM | Measure | Data Access | Signal Clarity | External Benchmark | Actionability | Total | Tier |
|---|---|---|---|---|---|---|---|
| CM-21 | Coding Accuracy (ICD-10/HCC/E&M) | Integrated (2) | High (3) | Strong (3) | High (3) | **11** | Tier 1 |
| CM-08 | Note Completeness & Omission | Native (3) | High (3) | Moderate (2) | High (3) | **11** | Tier 1 |
| CM-20 | Financial Productivity & Revenue | Integrated (2) | High (3) | Moderate (2) | High (3) | **10** | Tier 1 |
| CM-10 | Note Quality Overall (PDQI) | External (1) | Medium (2) | Strong (3) | High (3) | **9** | Tier 2 |
| CM-04 | Documentation Time | Integrated (2) | Medium (2) | Strong (3) | High (3) | **10** | Tier 2* |
| CM-13 | Adoption Behavior | Native (3) | High (3) | Moderate (2) | High (3) | **11** | Tier 1 |
| CM-06 | Chart Closure Timeliness | Integrated (2) | High (3) | Moderate (2) | High (3) | **10** | Tier 2 |
| CM-19 | Clinical Patient Safety | External (1) | Low (1) | Weak (1) | High (3) | **6** | Monitor |

*CM-04 for PBC specifically: PBC may add time (more structured note review required) or save time (problem list auto-populated). Direction is empirically uncertain — treat as exploratory.

### 3.1 Top 3 Best-Fit CMs for H3 — Narrative Rationale

**1. CM-08 — Note Completeness and Omission Rate**
PBC's core clinical claim is that it captures *all discussed problems*, including chronic conditions that might be neglected in rushed encounters. The mechanism is direct: if a problem is discussed, it appears in the output; if not discussed, it's excluded. The delta between input diagnoses (pre-charted problem list) and output diagnoses (post-session) is the measurement. Specifically:

- **New diagnoses generated** (output not in input) = newly identified problems = completeness improvement
- **Seeded diagnoses returned** = discussed problems confirmed = documentation fidelity
- **Seeded diagnoses dropped** = problems deliberately or inadvertently not discussed

This is measurable entirely from Suki data. It operationalizes CM-08 more precisely than any prior study has done (all prior studies require human raters). The external benchmark from simulation studies (71–86% omission rates) establishes the baseline from which PBC should improve.

*Recommended operationalization:* New diagnoses per session (output count minus input count) as a rolling metric. Compare PBC-enabled sessions vs. sessions where PBC was not enabled (if cohorts exist).

**2. CM-21 — Coding Accuracy (ICD-10 / HCC / E&M)**
This is the strongest external evidence point in the entire corpus for any Suki hook: Afshar 2025b (RCT, stepped-wedge, n=66) found p<0.001 improvement in ICD-10 coding compliance. Holmgren 2026 found no increase in denial rate alongside RVU improvement — establishing that the coding gains reflect legitimate documentation of existing complexity.

PBC produces ICD-10 codes as a direct machine-readable artifact. The measurement question is: how often do Suki's suggested ICD-10 codes appear in the final claim submitted to payers? This requires connecting the structured data output to claims — but the Suki-side measurement is already done (the codes are in `structured_data.diagnoses[].codes[]`).

*Recommended operationalization:* ICD-10 code acceptance rate = (Suki-suggested codes appearing in final claim) / (total Suki-suggested codes). Stratify by: code type (ICD-10 vs. IMO), specialty, new vs. existing diagnosis.

**3. CM-20 — Financial Productivity and Revenue Impact**
Three independent papers quantify this. Holmgren 2026 (UCSF, propensity-matched): +$3,044/year per physician in RVU revenue with no denial increase. Boyter/KLAS 2025: +$9,685/year from HCC capture alone, +$1,907/year from E&M level increase. These are the financial consequence of CM-21 improvement — coding accuracy translates to revenue.

The HCC pathway is particularly important: ICD-10 codes → HCC v28 mapping → risk-adjusted payment. PBC's structured ICD-10 output is the input to this calculation. A partner can apply the CMS HCC v28 mapping table to Suki's `structured_data` output to compute expected HCC weight change per encounter without any claims data — making this partially a native computation.

*Recommended operationalization:* (a) HCC weight per encounter: apply HCC mapping to structured output, compare to pre-Suki baseline claim data. (b) E&M level: compare CPT E&M distribution pre/post PBC adoption.

---

## 4. Evaluation Starter Plan for H3

H3 is most naturally evaluated alongside H1 — since PBC requires ambient documentation. The cleanest design compares:
- **Arm A:** H1 only (ambient documentation, no PBC)
- **Arm B:** H1 + H3 (ambient documentation with PBC enabled)

If a controlled comparison isn't feasible, use a pre-post design with PBC enabled at a defined go-live date.

### Phase 0 — Pre-PBC Baseline (4 weeks)

| Activity | Source | CMs |
|---|---|---|
| Pull current ICD-10 coding accuracy (certified coder audit on 100-note sample) | Claims + expert review | CM-21 |
| Calculate current HCC capture rate per encounter (from claims) | Claims | CM-21, CM-20 |
| Calculate current E&M level distribution (CPT 99211–99215 mix) | Claims | CM-21, CM-20 |
| Document current EHR problem list update rate (% encounters where problem list changes) | EHR | CM-08 proxy |
| Pull current denial rate by code type | RCM system | CM-21 |

### Phase 1 — Activation Monitoring (Weeks 1–4)

| Metric | Source | Frequency | Threshold |
|---|---|---|---|
| PBC session rate (% ambient sessions with PBC enabled) | Suki API | Weekly | Track adoption curve |
| New diagnoses per session (output > input) | Suki API | Weekly | Rising trend = expected |
| Diagnoses per session (raw count) | Suki API | Weekly | Baseline for later comparison |
| Context seeding completeness (% sessions with diagnoses seeded) | Suki API | Weekly | <80% → integration gap |

**Critical integration check:** If context seeding rate is low (partner not feeding EHR problem list into session), PBC is operating without its primary input — the reconciliation mechanism is impaired. This should be flagged and fixed before any outcome measurement.

### Phase 2 — Coding Accuracy Outcomes (Weeks 8–20)

| Measure | Method | Design | CMs |
|---|---|---|---|
| ICD-10 code acceptance rate | Match Suki output codes to final claims | All PBC-enabled encounters | CM-21 |
| HCC weight per encounter | Apply HCC v28 mapping to Suki structured output; compare to claim | Monthly cohort comparison | CM-21, CM-20 |
| E&M level shift | Claims: pre vs. post PBC by specialty | Pre-post | CM-21, CM-20 |
| New problem capture rate | (Suki output diagnoses) − (seeded diagnoses) per session | Suki native | CM-08 |
| Denial rate | RCM system | Monthly rolling | CM-21 |

**Design note on HCC:** The HCC mapping is public (CMS publishes the ICD-10 → HCC v28 crosswalk). Suki outputs ICD-10 codes. Applying the mapping to Suki's output produces expected HCC weights per encounter — this computation can be done from Suki data alone, before claims arrive. This creates a lead indicator (expected HCC from session) that can be compared to the realized HCC in claims as a validation step.

### Phase 3 — Financial Outcomes (Months 4–9)

| Measure | Method | Design | CMs |
|---|---|---|---|
| Revenue change per clinician | RVU × Medicare conversion factor; compare pre/post | Propensity-matched or pre-post | CM-20 |
| E&M level normalized revenue | Weighted average E&M level × relative value; pre/post | Pre-post | CM-20, CM-21 |
| HCC-attributed revenue change | RAF score change × PMPM contract value | Value-based care contracts | CM-20 |
| CDI cost reduction | Reduction in CDI specialist queries | Operational | CM-20 (OpEx) |

---

## 5. Distinctive Measurement Opportunities Unique to H3

### 5.1 Input-output diagnosis delta as a native completeness signal
No existing study uses Suki's own context seeding data to measure problem capture. The number of diagnoses returned minus the number seeded is a native, real-time measure of how many problems were identified that weren't pre-charted. This requires no raters, no audio, and no gold standard — just comparing the context payload to the structured data response.

### 5.2 AutoCoding toggle as a natural experiment
When AutoCoding is off, Suki uses the seeded ICD-10 code if the diagnosis is discussed. When on, Suki may recode based on conversation. Deploying AutoCoding as an A/B toggle (or measuring differences across partners with different settings) creates a natural experiment for measuring the accuracy benefit of AI recoding vs. passthrough of existing codes.

### 5.3 Laterality and post-coordination as coding specificity signals
The `laterality_indicator` and `post_coord_lex_flag` fields in the output capture dimensions of coding specificity that are rarely studied. Laterality capture (e.g., left knee vs. right knee) affects HCC mapping and clinical specificity. Post-coordination indicates whether a code requires additional modifiers. These fields could be used to quantify whether PBC produces more specific codes than typical manual coding — a direct coding quality measure with no external equivalent.

### 5.4 The missing-context scenario as a quality baseline
Sessions where context is NOT seeded (no EHR diagnoses fed in) vs. sessions where it IS seeded provide a natural comparison of what PBC adds beyond ambient-only documentation. The hypothesis: seeded sessions will have higher diagnosis capture rates and more accurate ICD-10 codes than unseeded sessions.

---

## 6. Key Caution: PBC Is Only as Good as the EHR Integration

PBC's reconciliation mechanism depends on the partner feeding the patient's current problem list into session context. If this integration step is absent or incomplete:
- The AI cannot confirm that existing problems were discussed
- New diagnoses will be generated, but existing problems won't be reconciled
- The clinical value claim (comprehensive problem capture) is partially negated

**This is the single biggest implementation risk for H3.** Every evaluation design should include a check on context seeding completeness (% of PBC sessions where diagnoses were seeded) as a process metric. Low seeding rates invalidate outcome comparisons that assume full PBC functionality.

---

*Document produced: April 2026*
*Grounded in: Suki developer API docs; PBC capability page (April 2026); 25 canonical measure definitions; 54-paper literature corpus*
*See also: [H1-Ambient-Documentation-Deep-Dive.md](H1-Ambient-Documentation-Deep-Dive.md) | [H9-Coding-Suggestions-Deep-Dive.md](H9-Coding-Suggestions-Deep-Dive.md)*
