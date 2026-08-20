# H1 Ambient Documentation — Deep Dive

**Hook:** Ambient listening → AI-generated structured clinical note
**Status:** Production. Core product. Foundation for all other hooks.
**Supported integrations:** Web SDK (React/JS), Mobile SDK (iOS), Headless Web SDK, SDP REST APIs

---

## 1. Technical Architecture

### 1.1 The Data Pipeline

Suki's ambient documentation follows a four-stage pipeline from audio to EHR-ready note:

```
STAGE 1 — Audio Capture
  Provider initiates session (POST /session/create → ambient_session_id)
  Audio streams via WebSocket (16-bit, 16kHz mono, 100ms chunks)
  Speaker diarization runs in real-time (doctor vs. patient identified)
  Session states: created → ready → running → [completed | failed | skipped | aborted]

STAGE 2 — Automatic Speech Recognition
  Raw audio → timestamped transcript segments
  Each segment carries: transcript text, start/end timestamps, start/end offsets,
  recording_id, transcript_id, lang_id (language detected)
  Available via: GET /session/{id}/transcript → final_transcript[]

STAGE 3 — Clinical Knowledge Graph (CKG) Processing
  Transcript + EHR context (demographics, problem list, meds, labs — from prior visit)
  CKG identifies clinically relevant content
  Organizes content into requested LOINC-coded note sections
  If PBC enabled: generates ICD-10 + IMO codes per discussed problem
  Evidence linking: maps which transcript segments produced which note content

STAGE 4 — Structured Output Delivery
  Clinical note → GET /session/{id}/content → summary[]
    Each section: {loinc_code, title, content, source_transcripts[]}
  Structured diagnoses (PBC) → GET /session/{id}/structured-data
    → structured_data.diagnoses.values[] with ICD-10/IMO codes
  Audio artifact → GET /session/{id}/recording (within 30 days; NEW endpoint)
  Webhook push on completion → partner endpoint notified asynchronously
```

### 1.2 Data Artifacts — What Suki Holds

The following data artifacts are accessible via API within 30 days of the session:

| Artifact | API Endpoint | Fields Available | Retention |
|---|---|---|---|
| Session status | `GET /session/{id}/status` | `status` enum (created/ready/running/aborted/skipped/failed/completed) | Until session expiry |
| Full transcript | `GET /session/{id}/transcript` | `transcript`, `transcript_id`, `recording_id`, `start_time`, `end_time`, `start_offset`, `end_offset`, `lang_id` per segment | 30 days |
| Clinical note | `GET /session/{id}/content` | `content`, `loinc_code`, `title`, `source_transcripts[]` per section | Contract duration |
| Structured diagnoses | `GET /session/{id}/structured-data` | ICD-10/IMO `code`, `description`, `type`, `diagnosis_note`, `laterality_indicator`, `post_coord_lex_flag` per diagnosis | Contract duration |
| Raw audio | `GET /session/{id}/recording` | Binary audio file | 30 days |
| Encounter-level note | `GET /encounter/{id}/content` | Cumulative across multiple sessions per encounter | Contract duration |
| Encounter-level structured data | `GET /encounter/{id}/structured-data` | Cumulative diagnoses across sessions | Contract duration |
| Webhook event | POST to partner endpoint | `session_id`, `encounter_id`, `status`, `error_code`, `error_detail` | Partner-held |

### 1.3 Key Technical Facts for Measurement

**Evidence linking is built into the API.** The `source_transcripts[]` field on each note section maps exactly which transcript phrases produced that content. This is not an add-on — it is in the content payload. This field enables transcript-to-note auditing at scale without listening to audio.

**Session timestamps are high-resolution.** `start_time` and `end_time` on transcript segments are ISO 8601 with nanosecond precision. `start_offset` / `end_offset` are relative to session start in hours/minutes/seconds/nanos. This means encounter duration is derivable from the transcript payload.

**Multilingual is now default.** As of the latest API version, `multilingual` is enabled by default for all sessions. `lang_id` is returned per transcript segment — so language mix within a session is detectable.

**Session status is a quality signal.** `SKIPPED` (empty/too-short session) and `FAILED` (processing error) are distinct. Tracking these rates per provider over time is a native utilization quality metric.

**User feedback is an API endpoint.** The User Feedback API allows clinicians to submit note quality ratings. If the partner app surfaces this, it creates a continuous structured stream of in-app satisfaction data.

---

## 2. What Data Suki Can Measure From Its Own Platform

No EHR integration required for the following. Suki has this data natively for every deployment:

| Metric | Suki Data Source | What It Measures | CM Linkage |
|---|---|---|---|
| Sessions per provider per day/week | Session creation logs | Utilization intensity | CM-13 |
| Completed vs. skipped vs. failed rate | Session status logs | Adoption quality; ASR reliability | CM-13, CM-24 |
| Session duration | `end_time − start_time` from transcript | Encounter length proxy | — |
| Note section character count | `len(content)` per `loinc_code` | Note verbosity per section | CM-11 |
| Number of ICD-10 codes generated per session | `structured_data.diagnoses` count | Coding output rate | CM-21 |
| Language distribution per session | `lang_id` per transcript segment | Multilingual utilization | H4 tracking |
| Processing latency | Webhook timestamp − session end time | System quality | CM-24 proxy |
| User feedback rating | User Feedback API | In-app note quality | CM-15, CM-10 |
| `source_transcripts` coverage | `source_transcripts[]` vs. `transcript` length | What fraction of conversation became note | CM-08 proxy |

**What EHR integration unlocks (when available):**

| Metric | Additional Data Source | What It Measures | CM Linkage |
|---|---|---|---|
| Time from session completion to note signing | EHR note-signature timestamp | Chart closure | CM-06 |
| Same-day closure rate | Note sign date vs. encounter date | Chart closure | CM-06 |
| ICD-10 suggestion acceptance rate | Suki suggested codes vs. final claim codes | Coding accuracy | CM-21 |
| RVU change pre/post adoption | Claims data | Financial productivity | CM-20 |
| Total EHR active time | Epic Signal / UAL audit log | Total EHR burden | CM-07 |
| Documentation time in notes | Epic Signal / UAL audit log | Documentation time | CM-04 |

---

## 3. CM Fit Analysis for H1

### 3.1 Scoring Criteria

Each measure is scored on four dimensions:

- **Data Access** — Can Suki access the required data without external systems?
  - Native (3) = from Suki API alone
  - Integrated (2) = requires EHR integration
  - External (1) = requires surveys, researchers, or external data
  - Infeasible (0) = not measurable in practice

- **Signal Clarity** — Is the measurement clean, low-ambiguity, and free of major confounds?
  - High (3) = objective, validated, well-defined
  - Medium (2) = self-report or proxy with known limitations
  - Low (1) = highly confounded or no validated method

- **External Benchmark** — Does published evidence provide a comparison standard?
  - Strong (3) = RCT or propensity-matched data exists
  - Moderate (2) = observational data in multiple studies
  - Weak (1) = simulation or single study only
  - None (0) = no published evidence

- **Actionability** — Can Suki act on the result within a deployment?
  - High (3) = directly informs product or deployment decisions
  - Medium (2) = informs program management or reporting
  - Low (1) = informative but not actionable in near term

**Maximum possible score: 12**

### 3.2 Ranked Scoring Table

| CM | Measure Name | Data Access | Signal Clarity | External Benchmark | Actionability | Total | Tier |
|---|---|---|---|---|---|---|---|
| CM-13 | Adoption Behavior & Utilization | Native (3) | High (3) | Moderate (2) | High (3) | **11** | Tier 1 |
| CM-06 | Chart Closure Timeliness | Integrated (2) | High (3) | Moderate (2) | High (3) | **10** | Tier 1 |
| CM-21 | Coding Accuracy (ICD-10/HCC/E&M) | Integrated (2) | High (3) | Strong (3) | High (3) | **11** | Tier 1 |
| CM-11 | Note Length & Verbosity | Native (3) | High (3) | Moderate (2) | High (3) | **11** | Tier 1 |
| CM-15 | Provider Satisfaction & Usability | External (1) | Medium (2) | Strong (3) | High (3) | **9** | Tier 1 |
| CM-04 | Documentation Time | Integrated (2) | Medium→High (2) | Strong (3) | High (3) | **10** | Tier 1 |
| CM-10 | Note Quality Overall (PDQI) | External (1) | Medium (2) | Strong (3) | High (3) | **9** | Tier 2 |
| CM-01 | Clinician Burnout & Exhaustion | External (1) | Medium (2) | Strong (3) | High (3) | **9** | Tier 2 |
| CM-08 | Note Completeness & Omission | Native→External (2) | Medium (2) | Moderate (2) | High (3) | **9** | Tier 2 |
| CM-16 | Provider Trust in AI | External (1) | Medium (2) | Weak (1) | High (3) | **7** | Tier 2 |
| CM-24 | Transcription & ASR Accuracy | Native (3) | High (3) | Weak (1) | High (3) | **10** | Tier 2 |
| CM-09 | Note Accuracy & Hallucination | Native→External (2) | Medium (2) | Moderate (2) | High (3) | **9** | Tier 2 |
| CM-02 | Cognitive & Task Load | External (1) | Medium (2) | Strong (3) | Medium (2) | **8** | Tier 2 |
| CM-18 | Physician-Patient Interaction | External (1) | Low (1) | Moderate (2) | Medium (2) | **6** | Tier 3 |
| CM-20 | Financial Productivity & Revenue | Integrated (2) | High (3) | Moderate (2) | High (3) | **10** | Tier 3* |
| CM-05 | After-Hours Documentation | Integrated (2) | Low (1) | Strong (3) | Medium (2) | **8** | Avoid** |
| CM-17 | Patient Experience | External (1) | Low (1) | Weak (1) | Medium (2) | **5** | Tier 3 |
| CM-03 | Professional Fulfillment | External (1) | Medium (2) | Strong (3) | Low (1) | **7** | Tier 3 |
| CM-07 | Total EHR Time | Integrated (2) | High (3) | Moderate (2) | Medium (2) | **9** | Tier 2 |
| CM-22 | Patient Volume & Throughput | Integrated (2) | High (3) | Weak (1) | Medium (2) | **8** | Tier 3 |
| CM-14 | Adoption Intention | External (1) | Medium (2) | Weak (1) | Low (1) | **5** | Skip |
| CM-19 | Clinical Patient Safety | External (1) | Low (1) | Weak (1) | High (3) | **6** | Monitor |
| CM-23 | Implementation Barriers | External (1) | Medium (2) | Moderate (2) | High (3) | **8** | Tier 2 |
| CM-12 | Automated NLP Metrics | Native (3) | High (3) | Weak (1) | Low (1) | **8** | Research |
| CM-25 | Evaluation Methodology Quality | — | — | — | — | — | Meta |

*CM-20: high score but depends on claims data linkage; best positioned as a 6-month+ outcome.
**CM-05: high confound (objective null pattern is reproducible); recommend deprioritizing despite score.

### 3.3 Best-Fit CMs for Suki — Narrative Rationale

**Top 5 for any Suki deployment, in priority order:**

**1. CM-13 — Adoption Behavior and Utilization Rate**
This is Suki's most native, cleanest measure. Sessions per provider per day is computed entirely from Suki telemetry with no external data dependency. It is the strongest predictor of all downstream outcomes — dose-response is consistent across the entire corpus (Tierney 2025, Pearlman 2025, Olson 2025). Without adoption, no other measure moves. Track this from day one of any deployment.

*Recommended operationalization:* Utilization rate = sessions completed / scheduled encounters (requires encounter schedule data). If schedule data unavailable: sessions per provider per day as a raw rate. Stratify into heavy (≥70% utilization), moderate (30–69%), and light (<30%) cohorts per PHTI 2025 framework.

**2. CM-06 — Chart Closure Timeliness**
Requires minimal EHR integration: only note-signing timestamp vs. encounter date. Produces a hard operational metric (same-day closure rate, time-to-close in hours) that is immediately legible to health system administrators and directly affects revenue cycle (bill-drop timing). FMOL (a Suki customer) showed 84% improvement in notes closed within 7 days. This is one of Suki's strongest case study claims — and one of the most straightforward to validate independently.

*Recommended operationalization:* % encounters with note signed ≤24 hours of encounter date (pre vs. post Suki). Also track median hours-to-sign.

**3. CM-11 — Note Length and Verbosity**
Uniquely, this is computable entirely from Suki's own `content` API — no EHR or survey needed. Character count per LOINC section per session per provider. This matters because: (a) verbosity is the most-cited physician complaint about AI notes (Wojda 2025, Shah 2025), and (b) Suki's Personalization feature (H5) directly controls it — making this a product feature validation metric, not just an outcome. Baseline note length before personalization settings are tuned, then track change.

*Recommended operationalization:* Mean ± SD characters per note, broken down by verbosity setting (CONCISE/BALANCED/DETAILED) and by LOINC section. Track editing behavior if note-edit events are available.

**4. CM-21 — Coding Accuracy (ICD-10 / HCC / E&M)**
Suki generates `structured_data.diagnoses[]` with ICD-10 and IMO codes per session. This is a direct, machine-readable output — not inferred. The coding accuracy question becomes: do the suggested codes match what appears in the final claim? This requires connecting Suki's structured output to claims data, which requires EHR or RCM integration. But the Suki side of the measurement is already done. The RCT evidence here is the strongest in the corpus (Afshar 2025b: p<0.001 improvement in ICD-10 coding compliance). No denial increase seen in Holmgren 2026. This is Suki's strongest defensible financial claim.

*Recommended operationalization:* ICD-10 code acceptance rate (Suki-suggested codes that appear in final claim / total suggested codes). HCC capture rate per encounter pre vs. post. Requires claims linkage.

**5. CM-04 — Documentation Time**
The canonical outcome — 27 papers, the most-measured in the corpus. Self-report is unreliable (−72% vs. −12% in EHR telemetry). The right method is Epic Signal / audit log telemetry. Suki's FMOL case study uses this method. Without EHR integration, use per-note time from Suki session data as a proxy (session duration ≈ encounter length; gap between session completion and note delivery ≈ processing time). Self-report survey is a reasonable second-best but should be labeled as such.

*Recommended operationalization:* EHR audit-log preferred. Time-in-notes per 8-hour workday (Ma 2025 methodology) or per encounter (Guo 2026 methodology). Pre-post design with at least 4-week baseline and 12-week follow-up (Afshar 2025 playbook).

---

## 4. Evaluation Starter Plan

This plan is designed to be deployable by Suki in partnership with any health system customer. It uses a phased approach: start with what you have (Suki telemetry), layer in surveys, then layer in EHR data.

### Phase 0 — Pre-Deployment Baseline (4 weeks before go-live)

**Objective:** Establish pre-Suki baseline on key measures.

| Activity | Data Source | CMs Addressed |
|---|---|---|
| Collect EHR audit log for documentation time | Epic Signal / UAL | CM-04, CM-07 |
| Collect chart closure rates (% same-day sign) | EHR note metadata | CM-06 |
| Administer Mini-Z burnout survey (all eligible providers) | Survey | CM-01 |
| Administer SUS usability baseline on current workflow | Survey | CM-15 |
| Document encounter volume and scheduling pattern | Scheduling system | CM-22 |
| Pull 30-day baseline ICD-10 coding accuracy sample | Claims / certified coder review | CM-21 |

**Deliverable:** Pre-deployment baseline report with provider-level and aggregate values for CM-04, CM-06, CM-21, CM-01.

---

### Phase 1 — Activation and Early Adoption (Weeks 1–6 post go-live)

**Objective:** Monitor adoption quality and catch early implementation problems.

| Metric | Source | Frequency | Action Threshold |
|---|---|---|---|
| Utilization rate per provider (sessions/day) | Suki API | Weekly | <30% → outreach to low adopters |
| SKIPPED session rate | Suki API | Weekly | >15% → audio or workflow issue |
| FAILED session rate | Suki API | Weekly | >5% → technical investigation |
| Note character count per section | Suki content API | Weekly | Outliers → personalization review |
| User feedback ratings (if surfaced) | User Feedback API | Continuous | <3/5 sustained → quality review |
| Implementation barrier survey (qualitative) | Survey | Week 3 | Open-ended; identify friction points |

**Deliverable:** Weekly adoption dashboard for Suki customer success. Stratify providers into heavy/moderate/light cohorts by week 4.

---

### Phase 2 — Efficiency Outcomes (Weeks 6–16)

**Objective:** Demonstrate time and closure impact. Enough adoption has occurred for meaningful comparison.

| Measure | Method | Comparison | CMs |
|---|---|---|---|
| Documentation time (per note, per day) | EHR audit log (Epic Signal) | Pre-deployment baseline | CM-04 |
| Chart closure timeliness (% same-day) | EHR note metadata | Pre-deployment baseline | CM-06 |
| Total EHR time per workday | EHR audit log | Pre-deployment baseline | CM-07 |
| Note length by verbosity setting | Suki content API | Cross-group (CONCISE vs. BALANCED) | CM-11 |
| Adoption rate stratified by specialty | Suki telemetry | Between-group comparison | CM-13 |

**Design note:** Use heavy-user vs. light-user comparison (dose-response design) if a controlled pre-post is not feasible. This is the Ma 2025 and Pearlman 2025 approach and is actionable without a control arm.

**Deliverable:** Efficiency outcome report at 12 weeks. Present as: "Among providers using Suki for ≥70% of encounters, documentation time changed by X compared to pre-Suki baseline and compared to light users."

---

### Phase 3 — Quality and Revenue Outcomes (Months 4–9)

**Objective:** Establish note quality and financial impact with sufficient sample size.

| Measure | Method | Sample / Design | CMs |
|---|---|---|---|
| Coding accuracy (ICD-10 acceptance rate) | Suki structured output vs. final claim | All encounters with Suki PBC session | CM-21 |
| HCC capture rate (per encounter) | Claims data | Pre-deployment vs. post; heavy vs. light | CM-21, CM-20 |
| RVU / revenue per clinician | Claims data | Propensity-matched cohort (Holmgren design) | CM-20 |
| Note quality (PDSQI-9) | LLM-as-judge OR physician rater | Random sample of 200 notes, blinded | CM-10 |
| Note completeness audit | Expert rater: source_transcripts vs. content | Random sample of 50 sessions | CM-08 |
| Burnout (Mini-Z repeat) | Survey | All providers from Phase 0 | CM-01 |

**Design note for note completeness (CM-08):** Use Suki's own `source_transcripts` field as a scaffold. For each note section, compare source phrases to content text. Any content element with no source transcript match is a candidate hallucination (CM-09). Any transcript segment not represented in any note section is a candidate omission (CM-08). This can be automated at scale — it does not require human listening.

**Deliverable:** 6-month outcomes summary suitable for publication or executive reporting. Should include the PHTI 2025 framework: clinician level (CM-01, CM-04), patient level (CM-17 if measured), system level (CM-21, CM-20).

---

### Phase 4 — Research-Grade Study (Month 6+, optional)

**Objective:** Generate publishable evidence for Suki specifically (only 3 external studies exist).

| Design Option | Description | Best for |
|---|---|---|
| Stepped-wedge rollout | Sequential activation of providers by cohort; all eventually receive Suki | Internal rollout with staggered go-live (Afshar 2025b model) |
| Dose-response observational | Compare heavy, moderate, and light users on key outcomes | Any deployment; no control group needed |
| Propensity-matched | Match Suki users to non-users on specialty, tenure, panel size | Multi-site deployment; Holmgren 2026 model |
| Simulation quality study | Sample of audio + transcript + note triads; expert rating | Note quality (CM-08, CM-09, CM-10) without patient data |

**Priority study:** A Suki-specific stepped-wedge evaluation measuring CM-21 (coding accuracy), CM-04 (documentation time via Epic Signal), and CM-06 (chart closure) would fill the largest evidence gap in the corpus and strengthen Suki's external credibility substantially.

---

## 5. What Makes H1 Distinctive as a Measurement Target

Three things about Suki's ambient documentation implementation create measurement opportunities that don't exist for most competitors:

### 5.1 The `source_transcripts` field enables non-invasive quality audit
Every note section exposes which transcript phrases generated it. This is Suki's evidence linking feature. For evaluation purposes, it means you can:
- Identify note content with no transcript source → hallucination candidates (CM-09)
- Identify transcript content with no note representation → omission candidates (CM-08)
- Do this at population scale from existing API data, without human listeners or gold-standard cases

No other commercial product has published this kind of audit. Suki's architecture makes it tractable.

### 5.2 Session state machine provides a native reliability signal
The `created → ready → running → completed/skipped/failed` status sequence is a structured signal about system performance. `SKIPPED` rate (empty/short sessions) tracks behavioral adoption quality. `FAILED` rate tracks technical reliability. Both are measurable continuously without any survey — and both are early warning indicators that precede downstream outcome changes.

### 5.3 Encounter-level cumulative content supports longitudinal note quality analysis
The `/encounter/{id}/content` and `/encounter/{id}/structured-data` endpoints aggregate across multiple ambient sessions per encounter (reambient scenarios). This supports analyzing how note quality changes across repeated sessions for complex encounters — a design relevant to inpatient or multi-visit contexts.

---

## 6. The One Measure to Deprioritize: CM-05 (After-Hours Documentation)

Despite being Suki's most prominent marketing claim ("saves 6 hours of after-hours work per week"), CM-05 should not be a primary evaluation outcome. The evidence is unambiguous:

- Objective EHR telemetry (the right measurement method) shows null or marginal effects in most studies (Pearlman 2025, Stults 2025)
- The exceptions are self-report studies (the wrong method) and one outlier (Duggan 2025: −16.9%)
- The Afshar 2025b RCT finding (−0.50 hrs/day Work Outside Work) becomes non-significant after removing the top 3% of outliers
- Clinicians appear to reinvest documentation time savings into more patients or other tasks — not into time off

Measuring CM-05 with EHR telemetry will most likely produce a null result, which undermines the evaluation without disproving genuine H1 benefits. Measure CM-04 (total documentation time) and CM-06 (chart closure) instead — these show consistent objective effects and are operationally meaningful.

---

*Document produced: April 2026*
*Grounded in: Suki developer API docs (developer.suki.ai); 25 canonical measure definitions; 54-paper literature corpus*
