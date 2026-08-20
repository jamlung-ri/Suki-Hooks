# Suki Hook × Measure Matrix

**Purpose:** Map Suki's distinct product capabilities ("hooks") to the 25 canonical measures (CM-01–CM-25), and flag which mappings have published evidence vs. which are measurement opportunities.

**Sources used:**
- Suki developer docs (developer.suki.ai — crawled April 2026)
- Suki whitepaper: *The Next Evolution of AI in the EHR*
- Suki blog posts and press releases (Jan 2025–Mar 2026)
- Sprint 1 Kickoff Demo Summary (15 Jan 2026)
- All 25 CM-* measure definitions

**Notation for matrix:**
- `●` = Primary — direct, mechanistic causal pathway
- `◐` = Secondary — plausible indirect pathway
- `○` = Tertiary — weak or speculative link
- *(blank)* = no meaningful relationship

**Evidence maturity (★ scale):**
- ★★★★★ = Multiple RCTs or large propensity-matched studies
- ★★★★ = At least one RCT or strong observational + telemetry data
- ★★★ = Consistent observational evidence, no RCT
- ★★ = Limited observational or simulation only
- ★ = No published external evidence; product-only or announced

---

## Part 1 — Hook Inventory

The 17 hooks are organized into four groups, reflecting their deployment maturity.

### Group A — Developer-Documented Production Capabilities
*(Have API/SDK documentation; deployable now)*

| Hook ID | Hook Name | Description |
|---|---|---|
| H1 | **Ambient Documentation** | Core ambient listening → structured clinical note. Audio → transcript → note via Clinical Knowledge Graph. |
| H2 | **Specialty-Specific Note Generation** | Specialty-tuned vocabulary, abbreviations, and note structure. 50+ specialties supported. |
| H3 | **Problem-Based Charting (PBC)** | Note organized by patient problems; generates ICD-10 and IMO codes as structured output. |
| H4 | **Multilingual Support** | Patient/provider speak in 80+ languages; note generated in English. Per-session opt-in. |
| H5 | **Note Personalization** | Per-provider verbosity setting (concise/balanced/detailed) and section format (narrative/bullets). Persistent, not per-session. |
| H6 | **Audio Dictation** | Standalone real-time speech-to-text for any EHR field. SDKs include this within ambient; standalone API-only. |
| H7 | **Audio Streaming & Download** | NEW: Raw audio/transcript access for institutional download within the 30-day window. Research/data custody use. |

### Group B — Product-Level Capabilities
*(Documented in product pages and whitepaper; not exposed as standalone developer APIs)*

| Hook ID | Hook Name | Description |
|---|---|---|
| H8 | **Ambient Orders Staging** | Spoken Rx, lab, and imaging orders staged in EHR for provider review and signature. Launched April 2025 via athenahealth. |
| H9 | **Coding Suggestions (ICD-10 / E&M / HCC)** | AI-suggested billing codes from transcript and chart; revenue cycle support at mid-cycle. |
| H10 | **Pre-Visit Patient Summaries** | AI-generated chart review before encounters (demographics, problems, meds, labs, specialist notes). |
| H11 | **Clinical Q&A / Chart Querying** | Voice-based EHR queries: "When was last A1c?" Powered by Clinical Knowledge Graph + Google Cloud Vertex AI. In advanced development. |
| H12 | **Real-Time Nudges / In-Encounter CDS** | In-visit prompts (E&M level, care gaps, clinical decision support). Beta phase. |
| H13 | **UpToDate Integration** | Evidence-based clinical content surfaced within note workflow at point of care. Announced March 2025. |
| H14 | **Patient Instructions Generation** | Ambient-generated patient-facing discharge/follow-up instructions as a note artifact. |
| H15 | **Evidence Linking** | Every generated note line traced to specific transcript timestamp. Transparency and verifiability feature. |

### Group C — In-Development / Partnership-Stage
*(Announced or in consortium; no production deployment at scale)*

| Hook ID | Hook Name | Description |
|---|---|---|
| H16 | **Suki for Nurses** | Ambient documentation for nursing workflows: flowsheets, assessments, admission/discharge forms. Nursing consortium launched Oct 2025. |
| H17 | **Telehealth / Virtual Care Integration** | Ambient documentation during virtual visits via Zoom Healthcare. |

---

## Part 2 — Hook × Measure Matrix

### Reading the matrix
Each cell shows the strength of relationship between a hook (row) and a measure (column). Primary (●) means the hook mechanistically and directly produces the measured outcome. Secondary (◐) means the hook plausibly influences the measure through an intermediate pathway. Tertiary (○) means a speculative or very indirect link.

### Wellbeing & Load Measures (CM-01–CM-03)

| Hook | CM-01 Burnout | CM-02 Cognitive Load | CM-03 Fulfillment |
|---|---|---|---|
| H1 Ambient Documentation | ● | ● | ◐ |
| H2 Specialty Notes | | ◐ | |
| H3 PBC | | ◐ | |
| H4 Multilingual | | | |
| H5 Personalization | | ◐ | |
| H6 Dictation | ◐ | ● | |
| H7 Audio Download | | | |
| H8 Orders Staging | ● | ● | ◐ |
| H9 Coding Suggestions | | ◐ | |
| H10 Pre-Visit Summaries | ◐ | ● | |
| H11 Chart Q&A | | ● | |
| H12 Real-Time Nudges | | ◐ | |
| H13 UpToDate | | ◐ | |
| H14 Patient Instructions | ◐ | ◐ | |
| H15 Evidence Linking | | | |
| H16 Suki for Nurses | ● | ● | ◐ |
| H17 Telehealth | ◐ | ● | |

**CM-01 Key note:** Best measured post H1 deployment. RCT (Afshar 2025b) shows −0.44 PFI work exhaustion; self-report substantially inflates. H8 (orders) is the second hook most plausibly affecting burnout via the "1.4 hrs/shift" order burden.

**CM-02 Key note:** NASA-TLX is the validated instrument. H1, H8, H10, H11 all directly reduce in-encounter or pre-encounter cognitive burden, but through different pathways — useful to distinguish.

**CM-03 Key note:** The RCT null finding (p=0.04 missing alpha=0.025) means removing burden ≠ adding fulfillment. No hook reliably moves this measure. Treat as aspirational, not evaluable in near-term sprints.

---

### Efficiency Measures (CM-04–CM-07)

| Hook | CM-04 Documentation Time | CM-05 After-Hours | CM-06 Chart Closure | CM-07 Total EHR Time |
|---|---|---|---|---|
| H1 Ambient Documentation | ● | ◐ | ● | ● |
| H2 Specialty Notes | ◐ | | ◐ | |
| H3 PBC | ◐ | | ◐ | |
| H4 Multilingual | | | | |
| H5 Personalization | ◐ | | | |
| H6 Dictation | ● | ◐ | ◐ | ● |
| H7 Audio Download | | | | |
| H8 Orders Staging | ● | ◐ | ◐ | ● |
| H9 Coding Suggestions | | | ● | |
| H10 Pre-Visit Summaries | | | | ● |
| H11 Chart Q&A | | | | ● |
| H12 Real-Time Nudges | | | ◐ | |
| H13 UpToDate | | | | ◐ |
| H14 Patient Instructions | ◐ | | | |
| H15 Evidence Linking | | | | |
| H16 Suki for Nurses | ● | ◐ | | ● |
| H17 Telehealth | ◐ | | | ◐ |

**CM-04 Key note:** Self-report vs. EHR telemetry gap is huge (−72% vs. −12%). Use Epic Signal / UAL for any credible measurement. H1 is the primary driver; H6 and H8 contribute independently.

**CM-05 Key note:** Persistent null in EHR telemetry across most studies. The strongest objective signal (−16.9%) is from Duggan 2025. No hook reliably moves after-hours time in objective data — clinicians re-invest saved time into more patients or other tasks. Flag as a measurement challenge, not a reliable outcome.

**CM-06 Key note:** Strong signal. FMOL (Suki customer) showed 84% improvement in notes closed within 7 days; Boyter/KLAS −41% chart closure time. H9 (coding suggestions) accelerates this specifically because coding readiness unblocks billing.

**CM-07 Key note:** Underused measure; Ma 2025 found −19.95 min/day total EHR time vs. only −6.89 min/day for notes alone — suggesting H10 and H11 (prep and Q&A) reduce chart-navigation burden independent of note writing.

---

### Note Quality Measures (CM-08–CM-12)

| Hook | CM-08 Completeness | CM-09 Accuracy/Hallucination | CM-10 Overall Quality (PDQI) | CM-11 Length/Verbosity | CM-12 NLP Metrics |
|---|---|---|---|---|---|
| H1 Ambient Documentation | ● | ● | ● | ● | ◐ |
| H2 Specialty Notes | ● | ◐ | ● | | |
| H3 PBC | ● | | ● | | |
| H4 Multilingual | ● | ◐ | ◐ | | |
| H5 Personalization | ◐ | | ◐ | ● | |
| H6 Dictation | | | | | ● |
| H7 Audio Download | | | | | ● |
| H8 Orders Staging | ◐ | ◐ | | | |
| H9 Coding Suggestions | ● | | ◐ | | |
| H10 Pre-Visit Summaries | ◐ | ◐ | ◐ | | |
| H11 Chart Q&A | | | | | |
| H12 Real-Time Nudges | ◐ | | ◐ | | |
| H13 UpToDate | | ◐ | ◐ | | |
| H14 Patient Instructions | ● | ◐ | | | |
| H15 Evidence Linking | | ● | ◐ | | |
| H16 Suki for Nurses | ● | ◐ | ◐ | | |
| H17 Telehealth | ◐ | | | | |

**CM-08 Key note:** Omissions dominate (71–86% of errors in simulation studies). PBC (H3) directly addresses this by ensuring every discussed problem is captured. Specialty notes (H2) address specialty-specific omission patterns. This is the highest-priority IQ measure for evaluation.

**CM-09 Key note:** Hallucinations less common (~31–36%) but high harm per event. Evidence linking (H15) is the specific Suki feature designed to address this — every note line is traceable to transcript. No hook eliminates hallucinations; H15 enables detection.

**CM-11 Key note:** Personalization (H5) is the only hook that directly controls this. Verbosity = CONCISE should produce measurably shorter notes. Wojda 2025 and Shah 2025 flag verbosity as a usability concern — H5 is Suki's answer.

**CM-12 Key note:** METHODOLOGICAL, not a clinical outcome. Relevant if you are designing evaluations using ROUGE/BERTScore. H7 (audio download) enables this by giving access to raw transcripts for benchmark comparison.

---

### Adoption Measures (CM-13–CM-16)

| Hook | CM-13 Adoption Behavior | CM-14 Adoption Intention | CM-15 Provider Satisfaction | CM-16 Provider Trust |
|---|---|---|---|---|
| H1 Ambient Documentation | ● | ◐ | ● | ◐ |
| H2 Specialty Notes | ● | ◐ | ● | ◐ |
| H3 PBC | ◐ | | ● | ◐ |
| H4 Multilingual | | | ◐ | |
| H5 Personalization | ● | ◐ | ● | ● |
| H6 Dictation | ◐ | | ● | |
| H7 Audio Download | | | | |
| H8 Orders Staging | ◐ | | ◐ | |
| H9 Coding Suggestions | | | ◐ | |
| H10 Pre-Visit Summaries | ◐ | | ◐ | |
| H11 Chart Q&A | ◐ | | ◐ | |
| H12 Real-Time Nudges | | | | |
| H13 UpToDate | | | ◐ | ◐ |
| H14 Patient Instructions | | | | |
| H15 Evidence Linking | | | ● | ● |
| H16 Suki for Nurses | ● | ◐ | ● | |
| H17 Telehealth | ◐ | | ◐ | |

**CM-13 Key note:** Utilization rate (% of encounters using ambient) is the most actionable Suki-internal metric and the strongest predictor of all downstream outcomes. Dose-response is consistent across the corpus: heavy users benefit most. H5 (personalization) and H2 (specialty fit) are the levers that move adoption behavior.

**CM-14 Key note:** Only 5 papers study this formally. Weak as a standalone outcome. More useful as a leading indicator of CM-13.

**CM-15 Key note:** Positive almost universally — but heavily confounded by volunteer bias. Suki's 70%+ adoption rate and KLAS score of 93.2 are the strongest external benchmarks. H5 and H2 are the specific hooks that drive preference.

**CM-16 Key note:** Under-studied (5 papers). H15 (evidence linking) is Suki's architectural response to this — it's the feature specifically designed to build trust by enabling verification. Worth studying explicitly in a Suki deployment context.

---

### Patient & Interaction Measures (CM-17–CM-19)

| Hook | CM-17 Patient Experience | CM-18 Physician-Patient Interaction | CM-19 Patient Safety |
|---|---|---|---|
| H1 Ambient Documentation | ◐ | ● | ○ |
| H2 Specialty Notes | | | |
| H3 PBC | | | ◐ |
| H4 Multilingual | ● | ● | ◐ |
| H5 Personalization | | | |
| H6 Dictation | | ◐ | |
| H7 Audio Download | | | |
| H8 Orders Staging | | | ● |
| H9 Coding Suggestions | | | ○ |
| H10 Pre-Visit Summaries | ◐ | ● | ◐ |
| H11 Chart Q&A | ◐ | ● | ● |
| H12 Real-Time Nudges | ● | | ● |
| H13 UpToDate | ◐ | | ● |
| H14 Patient Instructions | ● | | ◐ |
| H15 Evidence Linking | | | ◐ |
| H16 Suki for Nurses | ● | ● | ◐ |
| H17 Telehealth | ● | ● | |

**CM-17 Key note:** CRITICAL GAP. Only Owens 2024 uses a validated patient-reported instrument (PDRQ-9) — null in masked phase. All other "patient experience" data is clinician-reported proxy. H4 (multilingual) has the most direct and unstudied patient experience pathway — non-English-speaking patients communicating in native language is a clinically meaningful intervention with zero published evidence.

**CM-18 Key note:** Shuaib 2021 (human scribe) showed doctor-patient interaction time doubled. H1 is the ambient analog — clinician looks at patient, not keyboard. H10 and H11 extend this by reducing pre- and during-encounter EHR burden. Mostly captured via self-report items.

**CM-19 Key note:** Castro 2025 is the landmark paper: more psychiatric symptom documentation but LESS psychiatric intervention (aOR 0.83) — a possible unintended consequence. H8 (orders) introduces the highest-stakes new safety variable (order errors). H11 (chart Q&A) could improve or worsen safety depending on answer accuracy. This is the measure most in need of study and most understudied.

---

### Financial & Operational Measures (CM-20–CM-22)

| Hook | CM-20 Financial Productivity | CM-21 Coding Accuracy | CM-22 Patient Volume |
|---|---|---|---|
| H1 Ambient Documentation | ◐ | ◐ | ◐ |
| H2 Specialty Notes | | ◐ | |
| H3 PBC | ● | ● | |
| H4 Multilingual | | | |
| H5 Personalization | | | |
| H6 Dictation | | | |
| H7 Audio Download | | | |
| H8 Orders Staging | ● | | ◐ |
| H9 Coding Suggestions | ● | ● | |
| H10 Pre-Visit Summaries | | | ◐ |
| H11 Chart Q&A | | | |
| H12 Real-Time Nudges | ◐ | ● | |
| H13 UpToDate | | | |
| H14 Patient Instructions | | | |
| H15 Evidence Linking | | ◐ | |
| H16 Suki for Nurses | | | ◐ |
| H17 Telehealth | | | ◐ |

**CM-20 Key note:** Three independent papers confirm revenue impact: Holmgren 2026 (+$3,044/yr RVU increase, no denial increase), Boyter/KLAS (+$13,049/yr mostly HCC). H3 and H9 are the direct mechanisms; H1 (faster closure) is indirect. PHTI 2025 raises the policy counterpoint: individual health system ROI may conflict with payer-level costs.

**CM-21 Key note:** Most consistent finding in the corpus. Afshar 2025b (RCT, p<0.001 ICD-10 accuracy improvement). H3 (PBC) is the specific Suki mechanism — it generates ICD-10/IMO codes as structured data output. H9 is the revenue cycle layer on top. Holmgren 2026 shows no denial increase — meaning improvements reflect legitimate documentation of existing complexity, not upcoding.

**CM-22 Key note:** Holmgren 2026 shows +0.80 encounters/week with ambient adoption — small but statistically significant. H8 (orders) speeds patient turnaround. Caution: increased volume is not inherently desirable if clinicians are already capacity-constrained.

---

### Implementation & Methodology Measures (CM-23–CM-25)

| Hook | CM-23 Implementation Barriers | CM-24 Transcription Accuracy | CM-25 Evaluation Methodology |
|---|---|---|---|
| H1 Ambient Documentation | ● | ● | ◐ |
| H2 Specialty Notes | ◐ | ◐ | |
| H3 PBC | ◐ | | |
| H4 Multilingual | ● | ● | |
| H5 Personalization | ◐ | | |
| H6 Dictation | ◐ | ● | |
| H7 Audio Download | | | ● |
| H8 Orders Staging | ◐ | | |
| H9 Coding Suggestions | | | |
| H10 Pre-Visit Summaries | | | |
| H11 Chart Q&A | ◐ | | |
| H12 Real-Time Nudges | ● | | |
| H13 UpToDate | ◐ | | |
| H14 Patient Instructions | | | |
| H15 Evidence Linking | ◐ | | ◐ |
| H16 Suki for Nurses | ● | | |
| H17 Telehealth | ◐ | ◐ | |

**CM-23 Key note:** Cross-cutting. Every hook has its own workflow fit challenges. H12 (real-time nudges) and H16 (nurses) have the highest implementation friction because they require behavioral change on top of tool adoption. Non-adopter analysis (PHTI 2025: 3 cohorts) is the most practical framework.

**CM-24 Key note:** CRITICAL UPSTREAM GATE. No commercial product publishes WER. Suki's audio pipeline (16-bit, 16kHz, 100ms chunks; speaker diarization) is documented but not independently validated in literature. H4 (multilingual) introduces language-specific ASR accuracy variation. H7 (audio download) could enable institutional WER audits for the first time.

**CM-25 Key note:** META measure — assesses research quality. H7 (audio download) is the most direct hook here: it enables benchmark-quality evaluation designs by giving access to raw artifacts. For any credible Suki-specific study, propensity-matched observational (Pearlman 2025 design) or stepped-wedge RCT (Afshar 2025b design) should be the standard.

---

## Part 3 — Evidence Maturity by Hook

| Hook | Evidence Maturity | Best External Evidence | Key Gap |
|---|---|---|---|
| H1 Ambient Documentation | ★★★★★ | Afshar 2025b (RCT); Holmgren 2026 (propensity); Tierney 2025 (2.5M uses) | Product-specific Suki data thin (3 studies, mostly grey lit) |
| H2 Specialty Notes | ★★ | Prasad 2025 (specialty OR 34.6 for satisfaction) | No study isolates specialty configuration as variable |
| H3 PBC | ★★★★ | Afshar 2025b (RCT, p<0.001 ICD-10 accuracy); Boyter/KLAS | Suki-specific PBC data not published independently |
| H4 Multilingual | ★ | Owens 2024 (PDRQ-9 null) — tangentially related | No study has tested multilingual ambient AI specifically |
| H5 Personalization | ★ | Implied by satisfaction data broadly; Wojda 2025 notes verbosity concern | Never studied as independent intervention variable |
| H6 Dictation | ★★ | Included in several Wang 2025 / ASR studies; standalone not isolated | Standalone dictation vs. ambient not compared |
| H7 Audio Download | ★ | Not studied; data custody capability only | Enables future research; no clinical outcome hook |
| H8 Orders Staging | ★ | Product launched April 2025; zero published studies | Highest-potential unstudied hook in corpus |
| H9 Coding Suggestions | ★★★★ | Afshar 2025b (RCT coding accuracy); Holmgren 2026 (no denial increase); Boyter/KLAS | Revenue cycle effects at Suki specifically not published |
| H10 Pre-Visit Summaries | ★ | Concept studied (EHR burden); no ambient summary studies | Critical gap — patient summaries could shift CM-02 and CM-07 |
| H11 Chart Q&A | ★ | No studies | Major future hook; safety questions unanswered |
| H12 Real-Time Nudges | ★ | No studies (beta) | E&M upcoding audit risk is the key concern |
| H13 UpToDate Integration | ★ | General CDS literature only; no ambient-embedded CDS studies | Only patient safety benefit measurable; hard to isolate |
| H14 Patient Instructions | ★ | No studies specific to ambient-generated instructions | CM-17 (patient experience) is the measurement target |
| H15 Evidence Linking | ★ | Not studied; Suki-specific feature | Could be operationalized as a CM-16 (trust) experiment |
| H16 Suki for Nurses | ★ | Nursing burnout literature only (general); Suki for Nurses not deployed | Consortium launched Oct 2025; first deployment data expected 2026 |
| H17 Telehealth | ★★ | Zoom/telehealth documentation general; no Suki-specific telehealth study | CM-17 and CM-18 are the relevant targets |

---

## Part 4 — Measures Without a Dedicated Hook

Some measures are downstream aggregates or meta-level constructs — no single hook produces them; they emerge from combinations:

| Measure | Nature | Relationship to Hooks |
|---|---|---|
| CM-03 Professional Fulfillment | Positive well-being; dissociable from burnout | Downstream cumulative of H1+H8+all burden hooks; RCT shows null/marginal effect |
| CM-05 After-Hours Documentation | EHR behavior after scheduled hours | H1 primary driver; consistent objective null — clinicians reinvest saved time |
| CM-14 Adoption Intention | Attitudinal; leads to CM-13 | Cross-cutting downstream consequence of H5, H2, H15 |
| CM-23 Implementation Barriers | Process measure; every hook has its own | Cross-cutting; particularly important for H16 (nurses) and H12 (nudges) |
| CM-25 Evaluation Methodology | Meta-measure of study rigor | H7 (audio download) is the only hook that directly enables improved methodology |

---

## Part 5 — Sprint Planning Implications

### Tier 1: Measurable Now (Data likely available from Suki platform)
These hook-measure pairs are evaluable with existing Suki telemetry or standard surveys and have external validation benchmarks:

| Priority | Hook | Measure | Method |
|---|---|---|---|
| 1A | H1 | CM-04 Documentation Time | EHR audit-log (Epic Signal) |
| 1B | H1 | CM-06 Chart Closure Timeliness | EHR audit-log |
| 1C | H3 + H9 | CM-21 Coding Accuracy | Claims / certified coder review |
| 1D | H1 + H9 | CM-20 Financial Productivity | RVU data from claims |
| 1E | H1 | CM-13 Adoption Behavior | Suki platform utilization telemetry |
| 1F | H1 | CM-01 Burnout | Stanford PFI or Mini-Z (survey) |
| 1G | H1 | CM-10 Overall Note Quality | PDSQI-9 or physician rating |

### Tier 2: Measurable with Study Design (Requires prospective data collection)
| Priority | Hook | Measure | Method |
|---|---|---|---|
| 2A | H5 | CM-11 Note Length/Verbosity | Automated character count by verbosity setting |
| 2B | H4 | CM-17 Patient Experience | PDRQ-9 in multilingual patient cohort |
| 2C | H15 | CM-16 Provider Trust | Trust Likert scale pre/post evidence linking exposure |
| 2D | H8 | CM-04 Documentation Time | Time-to-sign including orders; separate from note-only |
| 2E | H1 | CM-08 Note Completeness | Expert rater or PDSQI-9 thoroughness domain |
| 2F | H1 | CM-24 Transcription Accuracy | WER audit using H7 audio download |

### Tier 3: Future / Requires Infrastructure
| Priority | Hook | Measure | Method |
|---|---|---|---|
| 3A | H10 | CM-02 Cognitive Load | NASA-TLX; pre-visit summary vs. no-summary design |
| 3B | H11 | CM-19 Patient Safety | EHR audit: query accuracy + downstream clinical action |
| 3C | H16 | CM-01 Burnout | Nursing burnout instrument post-deployment |
| 3D | H8 | CM-19 Patient Safety | Order error audit: staged vs. manual order |
| 3E | H12 | CM-21 Coding Accuracy | Pre/post E&M level with nudge enabled/disabled |

---

## Part 6 — Cross-Cutting Observations

1. **H1 (Ambient Documentation) is the foundational hook.** Every other hook is additive to H1. Suki without ambient documentation is just a transcription API. All adoption, satisfaction, and efficiency signals require H1 as the base.

2. **The strongest evidence is in Group C: coding and financial outcomes (H3, H9, CM-21, CM-20).** This is where Suki has a genuine distinguishing advantage over basic ambient scribes — structured ICD-10/IMO output is a technical feature, not just a note-quality claim.

3. **The most underserved outcome domain is CM-17/CM-19 (patients).** The multilingual hook (H4) is the most compelling and completely unstudied pathway to patient-reported benefit. This is a genuine research opportunity.

4. **CM-05 (after-hours documentation) is a trap.** It's widely cited by Suki marketing (−6 hrs/week) but the objective data is inconsistent. Exclude from primary outcomes in any credible evaluation.

5. **CM-24 (transcription accuracy) is the upstream quality gate no commercial vendor has addressed publicly.** H7 (audio download) creates the first institutional opportunity to audit this independently.

6. **The evidence-linking feature (H15) is Suki's architectural response to CM-09 and CM-16.** It has no external evidence but is the correct design answer to the hallucination and trust problems. Worth studying explicitly.

7. **H8 (orders staging) is the highest-upside unstudied hook.** It targets 1.4 hrs/shift of documented order burden; has a direct time-saving mechanism (CM-04); and introduces the most consequential new safety variable (CM-19). It's a natural Sprint 2 evaluation target.

---

*Document produced: April 2026*
*Sources: Suki developer.suki.ai (crawled April 2026); Suki product documentation; 25 canonical measure definitions derived from 54-paper corpus review*
