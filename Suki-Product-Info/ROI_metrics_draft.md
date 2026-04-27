# ROI Metrics Draft

> **Note:** Columns for Level of Aggregation, Primary Data Source(s), Filters / Exclusions, Reporting Cadence, and Owner are not yet populated. See [Other / Pending](#other--pending) for additional topics flagged for input.

---

## 1. Encounter Level

| Metric Name | Definition | Formula / Logic |
|---|---|---|
| Amended Encounter | E&M increase | — |
| Rework Cost | RCM component; recapture/decrease in loss vs. cost savings from RCM | — |
| CPT Increase | CPT increase (capture of procedures done in office) | # of new CPTs captured ambiently as an average against baseline (pre-CPT) |
| ICD Accuracy | ICD-10 prediction accuracy | Building on ML baseline of 35% accurate, how often does the word match the ICD-10 code (goal: north of 90%) |
| wRVU | Denominator is encounter | — |
| HCC Accuracy | — | — |
| Query Rate | Coding query reduction based on more accurate E&M and CPT codes | — |
| Changes in Visit Modifier Codes | — | — |

---

## 2. Clinical Outcomes

| Metric Name | Definition | Formula / Logic |
|---|---|---|
| HEDIS Percentile | Care gaps closed (HEDIS); start with top 7 against NCQA HEDIS cutpoints | Age/gender (Colorectal, Breast RC, Cervical); chronic conditions (diabetes A1c testing, retinopathy, high blood pressure); then outcomes |
| STAR Rating | STARs HEDIS bumps that help plans and providers increase ratings | AVG STAR point increase |
| RAF Increase — CMS HCCs | RAF increase (CMS HCC) | Incremental RAF # increase (0.157) × avg RAF weight expressed as PMPM or PMPY$ |
| RAF Increase — HHS HCCs | RAF increase (ACA HHS HCC) | Incremental RAF # increase (0.157) × avg RAF weight expressed as PMPM or PMPY$ |
| Reduced Waste | Reduced waste (Milliman, etc.) | % avoidable ER use reduction, % reduced IP to OBS, etc. |

---

## 3. Financial Outcomes

| Metric Name | Definition | Formula / Logic |
|---|---|---|
| Total Cost of Care | Suki users save more in $ than non-Suki users | Suki population % vs. non-Suki population |
| Denials Reduction | Actual denied $ reduction from Suki users | Denied $ of Suki users % vs. denied % of non-Suki users |
| Appeals Reduction | Cost of appeals % reduction | $ of appeals pre vs. post Suki |

---

## 4. Opex Savings

| Metric Name | Definition | Formula / Logic |
|---|---|---|
| Cost Savings — CDI | CDI cost reduction | Reduced # of CDI documentation specialists employed |
| Cost Savings — Coding | Coding cost reduction | Reduced # of coders employed (per chart or per claim) |

---

## 5. User-Related

### Efficiency Metrics

| Metric Name | Definition | Formula / Logic |
|---|---|---|
| Pajama Time | — | — |
| Time on Unscheduled Days | — | — |

### Nursing-Related

| Metric Name | Definition | Formula / Logic |
|---|---|---|
| *(To be defined)* | — | — |

---

## 6. Patient-Related

| Metric Name | Definition | Formula / Logic |
|---|---|---|
| Listening | — | — |
| Questions Answered | — | — |

---

## 7. Other / Pending

The following topics have been flagged for inclusion but have not yet been defined:

- In-office procedures — increase in appointment times?
- Inpatient care — admission, length of stay, discharge
- Readmission rate
- Quality metric tracking

> **Action item:** Get input from Marketing and Adrienne on metrics to add or refine.
