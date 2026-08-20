# H9 Coding Suggestions (ICD-10 / E&M / HCC) — Deep Dive

**Hook:** AI-suggested billing codes from transcript and chart; revenue cycle support at mid-cycle
**Status:** Product-level capability (not exposed as a standalone developer API; consumed through H3's structured output and partner RCM workflows)
**Dependency:** Requires H3 (Problem-Based Charting) as its upstream input. H9 is the revenue cycle interpretation layer applied to H3's machine-readable ICD-10/IMO output. H3 without H9 produces codes; H9 converts those codes into E&M levels, HCC categories, and billing-ready CPT suggestions.
**Evidence maturity:** ★★★★ — Strongest financial evidence in the corpus for any Suki hook. One RCT (Afshar 2025b, p<0.001 ICD-10 accuracy); one propensity-matched observational (Holmgren 2026); one rigorous grey-literature case study (Boyter/KLAS 2025).
**Related hooks:** H3 (PBC) is the upstream producer; H12 (Real-Time Nudges) is an in-encounter analog for E&M level prompting. See [H3-Problem-Based-Charting-Deep-Dive.md](H3-Problem-Based-Charting-Deep-Dive.md).

---

## 1. Technical Architecture

### 1.1 What H9 Is and Is Not

H9 is **not an independent Suki product** — it is a revenue cycle interpretation layer that operates on H3's structured data output. Understanding this dependency is essential for evaluation design: H9 cannot be measured in isolation from H3. Any deployment that does not have PBC enabled (H3) has no H9 activity to evaluate.

The pipeline is:

```
H1 (Ambient Documentation)
  → Transcript + clinical note (note artifact)

H3 (Problem-Based Charting)
  → structured_data.diagnoses[]: ICD-10 codes, IMO codes, laterality, post-coordination
  → This is H3's output and H9's input

H9 (Coding Suggestions)
  → Applies revenue cycle interpretation to H3's ICD-10 output:
      (a) E&M level derivation — maps documentation complexity to CPT 99211–99215
      (b) HCC categorization — maps ICD-10 codes to CMS HCC v28 risk-adjustment categories
      (c) CPT procedure capture — identifies procedures mentioned but not explicitly coded
      (d) Code compliance signal — flags ICD-10 codes that are under-specified or unacceptable for billing
  → Output is consumed by partner RCM systems, CDI workflows, or provider dashboards
```

H9 does **three things** that are distinct from H3:
1. **E&M level recommendation** — translates note complexity into an E&M complexity tier (1–5)
2. **HCC mapping** — applies CMS HCC v28 crosswalk to ICD-10 codes to compute RAF weight
3. **Coding defensibility** — ensures ICD-10 codes are specific enough to survive payer audit without triggering denials

### 1.2 The H9 Revenue Cycle Pipeline

```
INPUT — H3 Structured Output (per session/encounter)
  ICD-10 codes[] per discussed diagnosis
  IMO codes[] per discussed diagnosis
  laterality_indicator (left/right/bilateral)
  post_coord_lex_flag (modifier required)
  diagnosis_note (supporting text)

H9 PROCESSING — Revenue Cycle Interpretation
  Step 1: Code validation
    - ICD-10 specificity check (acceptable for billing vs. unspecified code)
    - Laterality completeness (missing laterality where required = billing risk)
    - Post-coordination compliance (modifier attached where flagged)
  
  Step 2: E&M level derivation
    - Medical decision-making (MDM) complexity from note content
    - Time-based E&M where documentation supports it
    - Maps to CPT: 99202–99215 (office/outpatient)
  
  Step 3: HCC categorization
    - Apply CMS HCC v28 ICD-10 → HCC crosswalk to each code
    - Compute RAF weight contribution per new/updated HCC category
    - Flag HCC categories not present in prior encounter data
  
  Step 4: Procedure code identification
    - Detect procedures mentioned in conversation not in existing CPT charges
    - Stage as coding suggestion for provider/coder review

OUTPUT — Coding-Ready Artifact
  Suggested E&M level (CPT code + supporting rationale)
  HCC categories with RAF weight per code
  Procedure CPT suggestions
  Code compliance flags
  Passed to partner: EHR charge capture, RCM system, CDI workflow
```

### 1.3 Key Technical Details for Measurement

**H9's quality is bounded by H3's quality.** If context seeding is incomplete (EHR problem list not fed into session), H3's output is degraded, and H9 inherits those gaps. The single biggest failure mode in H9 measurement is attributing coding inaccuracies to H9 when the actual problem is upstream H3 context seeding.

**E&M level derivation is the highest-stakes output.** E&M upcoding is a compliance risk; undercoding leaves revenue on the table. H9 must navigate between these. The Holmgren 2026 finding that denial rates did not increase alongside RVU gains is the critical validation that E&M improvement reflects documentation quality, not upcoding.

**HCC computation from Suki output is reproducible by the partner.** The CMS HCC v28 crosswalk is publicly available. Any partner holding H3's `structured_data.diagnoses[].codes[]` can independently apply the HCC mapping and compute expected RAF weight per encounter. This creates a **lead indicator** — expected HCC revenue from session output — that can be compared to realized HCC revenue in claims as a validation audit.

**ICD-10 accuracy baseline is 35% without AI coding assistance.** Suki's internal ROI metrics frame the goal as exceeding 90% match between AI-suggested ICD-10 and final claim code. This 35% → 90%+ trajectory is the primary measurement target for CM-21.

**AutoCoding setting affects H9 inputs.** When AutoCoding is off (H3 default), seeded ICD-10 codes are passed through unchanged if discussed. When on, H3 may recode — and H9 then applies revenue cycle interpretation to a potentially recoded output. The AutoCoding setting should be documented for every H9 measurement cohort.

**CDI query rate is a downstream H9 signal.** Clinical Documentation Improvement (CDI) specialists query providers when documentation is insufficient to support the codes billed. H9 should reduce CDI query volume — if queries drop, it is evidence that H9-supported documentation is coding-defensible.

### 1.4 Data Artifacts Available for Measurement

| Artifact | Source | Measurement-Relevant Fields | Retention |
|---|---|---|---|
| H3 structured output (H9 input) | `GET /session/{id}/structured-data` | `codes[]`, `diagnosis_note`, `laterality_indicator`, `post_coord_lex_flag` | Contract duration |
| Encounter-level cumulative | `GET /encounter/{id}/structured-data` | Same fields, aggregated across sessions | Contract duration |
| E&M level suggestion | H9 → Partner RCM (partner-held) | Suggested CPT 99202–99215 | Partner-held |
| HCC categories computed | Derivable from H3 output + HCC v28 table | HCC category ID, RAF weight per code | Derivable |
| Final claim codes | Claims / RCM system (external) | Final CPT, ICD-10, E&M level, denial status | External |
| CDI query log | CDI system (external) | Query volume, resolution rate, query type | External |
| Code acceptance | Partner comparison of H9 suggestion vs. claim | Match / override rate | Partner-held |

---

## 2. What Suki Can Measure from Its Own Data

**Without EHR or claims integration:**

| Metric | Computation | CM Linkage |
|---|---|---|
| ICD-10 codes per session | `len(structured_data.diagnoses[].codes)` | CM-21 (coding volume) |
| Laterality completeness rate | `laterality_indicator` present / total diagnoses with laterality-sensitive codes | CM-21 (coding specificity) |
| Post-coordination compliance rate | `post_coord_lex_flag` present + modifier assigned / total flagged codes | CM-21 (coding completeness) |
| HCC-eligible codes per session | Apply HCC v28 crosswalk to output codes; count HCC-mapped codes | CM-20 (expected HCC revenue lead indicator) |
| New HCC categories per session | HCC categories in output not present in seeded problem list | CM-20 (HCC capture rate) |
| New diagnoses per session (H3 delta) | Output codes not in seeded input | CM-08 (problem capture) |
| Context seeding completeness | % of H3/H9 sessions where diagnoses were seeded | Process integrity gate |

**Key Suki-native computation:** Any partner holding H3's structured output can apply the CMS HCC v28 mapping table (public) to compute expected RAF weight change per encounter — before any claims data arrives. This is a **lead indicator of financial impact** that does not require external data linkage.

**With EHR or claims integration:**

| Metric | Additional Source | CM Linkage |
|---|---|---|
| ICD-10 code acceptance rate | Claims (final ICD-10 vs. Suki suggested) | CM-21 (coding accuracy) |
| E&M level accuracy | Claims CPT vs. H9 suggested E&M level | CM-21, CM-20 |
| HCC capture rate (realized) | Claims → HCC mapping vs. Suki output HCC mapping | CM-20 (realized vs. expected RAF) |
| Denial rate by code source | RCM system: Suki-originated codes vs. manual codes | CM-21 (coding defensibility) |
| CDI query reduction | CDI system: query volume pre/post H9 | CM-20 (OpEx — CDI savings) |
| Revenue per encounter change | RVU × Medicare conversion factor | CM-20 (financial productivity) |
| Coding staff hours per chart | Time-in-motion: coder time per chart pre/post | CM-20 (OpEx — coding labor savings) |

---

## 3. CM Fit Analysis for H9

Using the same four-dimension scoring framework as H1 and H3 (Data Access / Signal Clarity / External Benchmark / Actionability, max 12):

| CM | Measure | Data Access | Signal Clarity | External Benchmark | Actionability | Total | Tier |
|---|---|---|---|---|---|---|---|
| CM-21 | Coding Accuracy (ICD-10/HCC/E&M) | Integrated (2) | High (3) | Strong (3) | High (3) | **11** | Tier 1 |
| CM-20 | Financial Productivity & Revenue | Integrated (2) | High (3) | Strong (3) | High (3) | **11** | Tier 1 |
| CM-06 | Chart Closure Timeliness | Integrated (2) | High (3) | Moderate (2) | High (3) | **10** | Tier 1 |
| CM-08 | Note Completeness & Omission | Native (3) | High (3) | Moderate (2) | High (3) | **11** | Tier 1 |
| CM-13 | Adoption Behavior | Native (3) | High (3) | Moderate (2) | High (3) | **11** | Tier 1 |
| CM-02 | Cognitive Load | External (1) | Medium (2) | Strong (3) | High (3) | **9** | Tier 2 |
| CM-19 | Clinical Patient Safety | External (1) | Low (1) | Weak (1) | Moderate (2) | **5** | Monitor |

*Note: CM-13 for H9 specifically measures whether H9 is enabled alongside H3, not H1 adoption. The relevant adoption metric is PBC + coding suggestion utilization rate.*

### 3.1 Top 3 Best-Fit CMs for H9 — Narrative Rationale

**1. CM-21 — Coding Accuracy (ICD-10 / HCC / E&M)**
This is the primary functional claim of H9. Three external data points support it:

- **Afshar 2025b** (RCT, stepped-wedge, n=66): Statistically significant improvement in ICD-10 coding compliance (p<0.001). This is the field's gold standard study design and its result directly validates H9's mechanism.
- **Holmgren 2026** (UCSF, propensity-matched): No increase in denial rate alongside RVU revenue increase — the critical payer-audit validation that coding improvement reflects legitimate documentation, not upcoding.
- **Boyter/KLAS 2025** (n=371, Epic UAL): HCC capture improvement translating to $9,685/clinician/year. HCC capture is a direct downstream consequence of ICD-10 coding accuracy, making this the financial operationalization of CM-21.

Suki's own ROI framing establishes the baseline: ICD-10 ML accuracy without AI assistance is approximately 35%. H9's target is 90%+ match between suggested code and final claim. This 35→90% trajectory is directly measurable by comparing H9 output codes to claims data.

*Recommended operationalization:* ICD-10 code acceptance rate = (H9-suggested codes appearing in final claim) / (total H9-suggested codes). Stratify by code type (ICD-10 vs. IMO), new vs. existing diagnosis, and AutoCoding on/off setting. Track denial rate as the compliance check.

**2. CM-20 — Financial Productivity and Revenue Impact**
H9 has the strongest and most granular financial evidence of any Suki hook:

| Revenue Pathway | Study | Finding |
|---|---|---|
| RVU per physician | Holmgren 2026 | +$3,044/year (propensity-matched, no denial increase) |
| HCC capture | Boyter/KLAS 2025 | +$9,685/clinician/year |
| E&M complexity | Boyter/KLAS 2025 | +$1,907/clinician/year |
| E&M volume | Boyter/KLAS 2025 | +$1,456/clinician/year |
| **Combined** | **Boyter/KLAS 2025** | **+$13,049/clinician/year** |

These three pathways are mechanistically distinct and should be tracked separately:
- **HCC pathway:** ICD-10 code → HCC v28 mapping → RAF score → risk-adjusted payment (Medicare Advantage, ACO contracts). Computable from Suki output alone.
- **E&M pathway:** Medical decision-making complexity documented → higher CPT code justified → higher fee-for-service reimbursement. Requires claims comparison.
- **CDI pathway:** Fewer CDI specialist queries → lower operational cost per chart. Requires CDI system data.

*Recommended operationalization:* (a) Apply HCC v28 mapping to H3/H9 structured output to compute expected RAF weight per encounter as a lead indicator. (b) Compare CPT E&M level distribution (99212–99215 mix) pre/post H9 adoption using claims. (c) Track CDI query volume from CDI workflow system.

**3. CM-06 — Chart Closure Timeliness**
H9 accelerates chart closure through a specific mechanism: coding readiness unblocks billing. In many ambulatory workflows, a note cannot be submitted to billing until ICD-10 codes are assigned. Without AI coding support, coders or CDI specialists must review and complete codes post-encounter — creating a coding queue that delays chart closure and billing cycle time. H9 provides coding-ready output at the point of care, removing this downstream bottleneck.

Boyter/KLAS 2025 found a 41% reduction in chart closure time with ambient AI — though this was measured for the full H1+H3+H9 stack, not H9 specifically. The mechanism H9 contributes is distinct from H1: H1 reduces note-writing time; H9 reduces the coding-completion delay.

*Recommended operationalization:* Time from encounter end to chart closed (Epic UAL or equivalent), stratified by whether H9 coding suggestions were accepted vs. overridden. Hypothesis: sessions where H9 codes are accepted close faster than sessions requiring manual code correction.

---

## 4. Evaluation Starter Plan for H9

H9 is evaluated as part of the H3+H9 stack. A deployment with H3 but not H9 (PBC enabled, no downstream coding workflow) provides a useful comparison arm — it isolates the incremental value of the revenue cycle interpretation layer over and above the note organization and code generation that H3 already provides.

**Recommended design options:**
- **Arm A:** H1 only (ambient, no PBC, no coding suggestions) — control
- **Arm B:** H1 + H3 (ambient + PBC, structured ICD-10 output) — H3 contribution
- **Arm C:** H1 + H3 + H9 (full coding suggestion workflow) — H9 incremental contribution

If a three-arm design is not feasible, a pre-post design with a defined H9 go-live is acceptable.

### Phase 0 — Pre-H9 Baseline (4 weeks before H9 activation)

| Activity | Source | CMs |
|---|---|---|
| Pull E&M level distribution (CPT 99211–99215 mix) | Claims | CM-21, CM-20 |
| Calculate current HCC capture rate per encounter | Claims + HCC v28 table | CM-21, CM-20 |
| Document current ICD-10 coding accuracy (certified coder audit on 100-note sample) | Claims + expert review | CM-21 |
| Measure current denial rate by code type | RCM system | CM-21 |
| Measure current CDI query volume per week | CDI system | CM-20 (OpEx) |
| Document time from encounter to chart closure | EHR audit log (Epic UAL) | CM-06 |
| Confirm context seeding completeness rate | Suki API (H3 prerequisite check) | Process integrity |

### Phase 1 — Activation Monitoring (Weeks 1–4 post-launch)

| Metric | Source | Frequency | Alert Threshold |
|---|---|---|---|
| H3 context seeding rate (prerequisite) | Suki API | Weekly | <80% → integration gap |
| H9 coding suggestion acceptance rate | Partner RCM | Weekly | <50% → interface or trust issue |
| ICD-10 codes per session | Suki API | Weekly | Baseline calibration |
| HCC-eligible codes per session | HCC v28 mapping applied to Suki output | Weekly | Rising = expected |
| E&M level distribution shift | Claims (lag 2–4 weeks) | Bi-weekly | Monitoring for upcoding pattern |

**Critical check — upcoding audit:** Any increase in E&M level should be accompanied by denial rate monitoring. If E&M levels increase AND denial rates increase, this is a signal of documentation insufficiency (coding suggestions accepted without adequate supporting documentation). Holmgren 2026 established that legitimate complexity improvement does not increase denials — if denials rise, treat as a compliance signal requiring immediate CDI review.

### Phase 2 — Coding Accuracy Outcomes (Weeks 8–20)

| Measure | Method | Design | CMs |
|---|---|---|---|
| ICD-10 code acceptance rate | Match H9 suggested codes to final claims | All H9-enabled encounters | CM-21 |
| ICD-10 specificity rate | % of output codes that are billable (non-unspecified) | Suki native | CM-21 |
| E&M level accuracy | Compare H9 E&M suggestion to final CPT claim | Monthly cohort | CM-21, CM-20 |
| HCC categories captured (expected) | Apply HCC v28 to Suki output; compute RAF weight per encounter | Suki native (lead indicator) | CM-20 |
| HCC categories captured (realized) | Claims HCC coding vs. expected from Suki | Monthly cohort | CM-20 |
| Denial rate by code origin | Claims: Suki-suggested vs. manually coded | Monthly rolling | CM-21 |
| CDI query volume | CDI system: total queries pre vs. post H9 | Weekly | CM-20 (OpEx) |
| Chart closure time | EHR UAL: encounter end → chart closed | Bi-weekly | CM-06 |

**HCC lead indicator methodology:** At the end of each week, take all H3 `structured_data.diagnoses[].codes[]` outputs from that week's sessions. Apply the CMS HCC v28 ICD-10 → HCC crosswalk (public document). Sum the RAF weights per HCC category per encounter. This produces an **expected HCC revenue per encounter** figure from Suki data alone — no claims needed. When claims arrive 30–60 days later, compare expected vs. realized to validate H9's coding accuracy.

### Phase 3 — Financial Outcomes (Months 4–9)

| Measure | Method | Design | CMs |
|---|---|---|---|
| Revenue per clinician (RVU) | RVU × Medicare CF; pre vs. post by cohort | Propensity-matched or pre-post | CM-20 |
| HCC-attributed revenue | RAF score change × PMPM contract value | Value-based care contracts | CM-20 |
| E&M-level revenue | Weighted avg E&M × RVU; pre vs. post | Pre-post | CM-20, CM-21 |
| CDI labor cost reduction | CDI FTE or specialist hours per chart | Operational | CM-20 (OpEx) |
| Coding labor cost reduction | Coder time per chart pre vs. post | Operational | CM-20 (OpEx) |
| Total financial impact per clinician | Sum above pathways; compare to Boyter/KLAS benchmark | Comparison | CM-20 |

---

## 5. Distinctive Measurement Opportunities Unique to H9

### 5.1 HCC v28 lead indicator — financial impact from Suki data alone
No claims data or external linkage is required to estimate H9's HCC financial impact. The CMS HCC v28 crosswalk is public and deterministic. Applying it to H3's `structured_data` output produces expected RAF weights per encounter. A deployment evaluating H9 can generate a monthly expected HCC revenue trajectory from Suki API data alone — and then validate it against realized claims when they become available. This is a unique evaluation opportunity: most financial studies require 6–12 months of claims lag; the lead indicator is available within days of the session.

### 5.2 Code acceptance rate as a provider trust signal
When H9 coding suggestions are consistently accepted, it indicates that providers and coders trust the AI output enough to submit it to billing. When suggestions are consistently overridden, it indicates distrust, disagreement, or accuracy failure. The acceptance/override rate over time is both a CM-21 (accuracy) signal and a CM-16 (trust) signal — and it is measurable from partner RCM data without any clinical audit. Tracking acceptance rate over the first 90 days tests whether provider trust builds or plateaus.

### 5.3 AutoCoding as a natural experiment for coding accuracy
When AutoCoding is off, H3 passes through the seeded ICD-10 code as-is if the problem is discussed. When on, H3 may recode based on conversation. H9 applies revenue cycle interpretation to whichever code is passed. Partners with different AutoCoding settings (or a deployment that toggles AutoCoding) provide a natural experiment: Do AI-recoded diagnoses (AutoCoding on) produce better HCC mapping and E&M level derivation than passthrough codes (AutoCoding off)? This question has direct practical implications for the value of the AI recoding capability.

### 5.4 Denial rate as a coding defensibility index
Holmgren 2026 is uniquely valuable as an external benchmark because it tracked both the revenue benefit (higher RVU) and the compliance signal (no denial increase) simultaneously. A Suki-specific evaluation that replicates this dual measurement — tracking E&M level shift AND denial rate in the same cohort — directly tests whether coding improvements reflect legitimate documentation quality or compliance risk. This is the specific measurement design that would distinguish Suki's H9 from documented upcoding behavior associated with some other AI coding tools.

---

## 6. Key Cautions for H9

### 6.1 Upcoding audit risk is real and must be managed
Automated E&M level suggestions carry inherent audit risk. CMS and private payers actively monitor for statistical outliers in E&M distribution — a clinic whose E&M mix shifts dramatically post-AI deployment may trigger a targeted audit. The Holmgren 2026 finding (no denial increase alongside RVU improvement) is reassuring, but it was a propensity-matched observational study at a single academic health system, not a multi-site randomized trial. Any organization deploying H9 should establish an E&M audit cadence at activation and maintain denial rate monitoring throughout. If coding levels increase, so must supporting documentation quality.

### 6.2 E&M comparison requires case-mix adjustment
E&M level distribution varies by specialty, patient complexity, and payer mix. A pre-post comparison that does not control for case mix will confound H9's coding accuracy effect with natural variation in patient population. The Boyter/KLAS study used a normalized case-mix adjustment — any Suki-specific study must do the same. Failure to adjust will overstate effect size if the post-H9 patient population happens to be sicker.

### 6.3 PHTI 2025 system-level cost concern
The Pacific Health Technology Institute 2025 analysis raises a population-level counterpoint: revenue cycle improvements that capture more HCCs and increase E&M levels may increase total healthcare costs for payers, even if individual health systems benefit. This does not invalidate H9 as a product — documenting existing complexity is appropriate and defensible. But it means that presenting H9's revenue gains as net social benefit is overstated. Suki's evaluation framing should be careful to distinguish between (a) documenting complexity that already existed but was undercoded, and (b) increasing measured acuity through better coding.

### 6.4 H9 is only as accurate as H3 context seeding
The upstream H3 dependency is H9's most important operational constraint. If context seeding is incomplete — the partner does not feed the EHR problem list into session — H3's output is degraded, and H9 is working with an incomplete diagnosis set. The context seeding rate should be measured as a **process integrity gate** before any H9 outcome analysis. Low seeding rates (<80%) should pause outcome measurement and trigger integration investigation.

---

## 7. External Evidence Summary for H9

| Study | Design | n | H9-Relevant Finding |
|---|---|---|---|
| Afshar 2025b | RCT, stepped-wedge | 66 | ICD-10 coding compliance improved (p<0.001) |
| Holmgren 2026 | Propensity-matched observational | UCSF multi-site | +$3,044/year RVU; **no increase in denial rate** |
| Boyter/KLAS 2025 | Single-site case study (Epic UAL, n=371) | 600 users | +$9,685/yr HCC; +$1,907/yr E&M complexity; +$1,456/yr E&M volume; total **$13,049/clinician/year** |

*Note: All three studies used Ambience Healthcare, not Suki specifically. Revenue cycle claims for Suki are supported by the same mechanism (structured ICD-10 output → HCC/E&M mapping) but have not been independently published for Suki deployments. This is a gap that Suki-specific evaluation would directly address.*

---

*Document produced: April 2026*
*Grounded in: Suki developer API docs; Suki product documentation (April 2026); 25 canonical measure definitions; 54-paper literature corpus; Boyter/KLAS 2025; Holmgren 2026; Afshar 2025b*
*See also: [H3-Problem-Based-Charting-Deep-Dive.md](H3-Problem-Based-Charting-Deep-Dive.md) | [H1-Ambient-Documentation-Deep-Dive.md](H1-Ambient-Documentation-Deep-Dive.md)*
