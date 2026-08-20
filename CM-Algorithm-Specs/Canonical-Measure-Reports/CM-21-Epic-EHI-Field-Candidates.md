# CM-21 Coding Accuracy — Epic EHI Field Candidates (Exhaustive Pass)

**Status:** Schema-only reconnaissance for the field-requirements approach for CM-21, part of the broader Sprint 2 feasibility prep (internal confidence against a pilot site's data before approaching South Carolina). This also settles an open question from a separate discussion about whether E/M levels and HCC codes are actually exposed in Epic clarity at all — see Headline Finding #1 and #2.
**Scope:** Algorithms 1 and 3 of the [CM-21 card](../CM-21-Coding-Accuracy.html) (ICD-10 coding depth; L4-5 claim denial rate) and the E/M-level/HCC fields those depend on. **Algorithm 2** (Suki-suggested codes vs. billed codes) is explicitly out of scope here — see caveat below.
**Source:** [`epic-ehi-kg`](https://github.com/) — Paul's Epic EHI Export Specification knowledge graph (7,797 tables / 63,956 columns, May 2026 release, `su118s2p`).
**Companion data file:** [`CM-21-Epic-EHI-Field-Candidates.csv`](./CM-21-Epic-EHI-Field-Candidates.csv) (2,802 rows).

---

## Why this run exists, and why Algorithm 2 is excluded

Same method as the [CM-04 pass](./CM-04-Epic-EHI-Field-Candidates.md): be exhaustive on table names first, let the pilot site's data team's density check against the real extract do the precision filtering a schema-only search can't do.

CM-21's [canonical measure report](./CM-21-Coding-Accuracy-Canonical-Measure-Report.md) splits the measure into three algorithms, and only two of them are a clarity-field question:

- **Algorithm 1 (ICD-10 coding depth)** and **Algorithm 3 (L4-5 denial rate)** both depend on EHR-side fields Suki has no visibility into — this pass covers them.
- **Algorithm 2 (Suki-suggested ICD-10 codes vs. final billed codes)** is blocked on encounter-to-claim linkage and IMO→ICD-10 mapping, per the canonical measure report — a pipeline/integration question, not a "which clarity field" question. Including it in this sweep would misrepresent the actual blocker as a field-availability problem. It's tracked separately; the billed-code side of that comparison (final billed ICD-10/CPT per encounter) does overlap with tables found here (`HSP_ACCT_CPT_CODES`, `HSP_ACCT_CLM_CPT`), so this pass is still useful groundwork for it once linkage exists.

**This is schema-only reconnaissance.** A column existing in the EHI export spec says nothing about whether the pilot site's build populates it — that's the site data team's next step, not this one.

---

## Method

1. Matched **table names** against four concept clusters: ICD-10/diagnosis coding, HCC/risk adjustment, E/M level/CPT coding, and claims/denials. Table-name matching (not description matching) to avoid the noise flood the CM-04 pass hit on bare-word description search.
2. **303 tables** matched, **2,802 columns** pulled and tagged with bucket, data type, org-specific flag, discontinued flag, and PK membership.
3. The claims/denials bucket was deliberately narrowed during the pass — an initial sweep on `*CLAIM*` returned 472 tables, almost all deep claims-processing/EDI-interface sub-tables (`AP_CLAIM_IF_ACE_*`, clearinghouse edit codes) with no coding-accuracy relevance. Narrowed to top-level claim/status tables plus explicit denial/appeal tables, landing at 80.

| Bucket | Tables | Columns |
|---|---:|---:|
| ICD-10 / Diagnosis coding | 202 | 1,044 |
| HCC / Risk adjustment | 7 | 56 |
| E/M level / CPT coding | 20 | 141 |
| Claims / Denials | 80 | 1,586 |

The ICD-10 bucket's 202 tables include a large tail of narrow clinical-context diagnosis-link tables (e.g., disease-registry, order-linked, allergy-linked DX fields) that are unlikely to be Algorithm 1's actual source — flagged in the CSV for completeness rather than dropped, per "exhaustive not precise."

---

## Headline findings

### 1. `PAT_ENC_EM_CODE_DX` — the direct E/M-level field
Settles an open question from an earlier discussion (E/M levels were floated as "might be in clarity somewhere" but not confirmed): **E/M codes are exposed in Epic clarity.** `PAT_ENC_EM_CODE_DX` links E/M codes to diagnoses per encounter (one row per E/M code–diagnosis pair); `ADDITIONAL_EM_CODE` and `EM_CODE_CALC` sit alongside it. `EM_CODE_CALC` is the most interesting of the three for Suki's purposes: it has an `EM_CODE_SOURCE_C_NAME` column that explicitly tracks **whether the E/M code was filed manually or derived from documentation** — structurally the same "was this AI-assisted or manual" distinction Algorithm 2 wants for ICD-10 codes, just for E/M level instead. Worth flagging to Paul as a second linkage opportunity alongside Algorithm 2, not just a CM-21 Algorithm-1-adjacent field.

### 2. `CVG_MEM_RISK_ADJ_FACT` — HCC/risk-adjustment fields exist, but the naive "HCC" search misses them
Also settles that question for HCC: **risk-adjustment data is exposed**, but a literal keyword search for "HCC" in column descriptions returns a false positive (`UNOS_CLIN_INFO_2.HX_OF_HCC_YN` — hepatocellular carcinoma history, unrelated). The real table is `CVG_MEM_RISK_ADJ_FACT` ("member level risk adjustment factor"), keyed off `COVERAGE`/`PATIENT` rather than the encounter — this is a payer/coverage-level RAF score, not an encounter-level HCC capture flag, which matters for how Algorithm 1's ICD-10-depth-as-completeness-proxy would need to be joined. `CANCER_RISK_SCORE_*` tables also matched the risk-adjustment table-name pattern but are clinical cancer-risk scoring, not billing risk adjustment — false positives, kept in the CSV and flagged there.

### 3. `AP_CLAIM` / `CLAIM_INFO` — claim status and denial fields for Algorithm 3
`AP_CLAIM.STATUS_C_NAME` carries the claim's processing status (pending/clean/denied/void) directly; `AP_CLAIM.CL_DEN_PEND_DTTM` and `CL_DEN_PEND_EXAM_ID` timestamp and attribute a clean/deny/pend decision; `AP_CLAIM_2.DENY_CLM_SRC_C_NAME` tracks denial source. `CLM_VALUES_5.NON_PAYMENT_RSN_CD`/`NON_PAYMENT_RSN_DESC` give a claim-level denial reason code and description directly — likely the cleanest single field for filtering to coding-related denials specifically (vs. authorization/eligibility denials), which the canonical measure report flags as a required filter. Not yet checked whether this field's denial-reason taxonomy actually distinguishes "coding" from other categories at the pilot site — that's a question for the site data team's density pass, not resolvable from the schema alone.

### 4. `HSP_ACCT_CPT_CODES` / `HSP_ACCT_CLM_CPT` — final billed procedure codes at the hospital-account level
These are the CPT-code-level billed output on the Hospital Accounts Receivable master file — the natural "final billed codes" comparison target once encounter-to-claim linkage exists for Algorithm 2, and directly relevant to Algorithm 3's E/M level 4-5 denominator (billed E/M level per encounter).

### 5. `HSP_BDC_DENIAL_DATA` / `HSP_BDC_DENIED_DIAGNOSES` — denial detail at the EOB line level
Part of the Denial/Remark/Correspondence (BDC) master file: one row per denied claim/EOB line, with a paired `HSP_BDC_DENIED_DIAGNOSES` table linking denied diagnoses specifically. More granular than `AP_CLAIM`'s claim-level status — worth density-checking both, since the coarser `AP_CLAIM.STATUS_C_NAME` may be denser (more consistently populated) even though `HSP_BDC_DENIAL_DATA` is more precise.

---

## Caveats

- **Algorithm 2 is intentionally out of scope** — see above. Do not read the absence of an "encounter-to-claim linkage field" finding here as evidence that linkage is infeasible; it's a different kind of question (integration/API design) than this pass answers.
- Reference/join edges from the KG were not used to expand this list further (e.g., walking outward from `PATIENT`/`COVERAGE` for other risk-adjustment tables) — table-name-driven only, same limitation as the CM-04 pass.
- `CANCER_RISK_SCORE_*` and `HX_OF_HCC_YN`-style false positives are flagged inline above and in the CSV, not filtered out, per "exhaustive not precise."
- Provider-ID crosswalk field (needed to join any of this back to a Suki session) was not verified in this pass — confirm the actual column name on `PAT_ENC` or its overflow family before writing the join query.
- Longer-term, out of scope for this pass: whether the same fields translate to South Carolina's Epic implementation.

---

*Generated 2026-08-20 from `epic-ehi-kg` (May 2026 EHI release) as part of Sprint 2 feasibility prep. Sweep script available on request.*
