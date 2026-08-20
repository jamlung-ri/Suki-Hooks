# CM-22 Patient Volume/Throughput — Epic EHI Field Candidates (Exhaustive Pass)

**Status:** Schema-only reconnaissance for the field-requirements approach for CM-22, part of the broader Sprint 2 feasibility prep (internal confidence against a pilot site's data before approaching South Carolina).
**Scope:** Completed-encounter counting for CM-22 — narrower than CM-04 or CM-21 because Suki's side of the data is already sufficient (adoption date, weekly active-use flags, per the [CM-22 canonical measure report](./CM-22-Patient-Volume-Canonical-Measure-Report.md)); the only open question is EHR-side.
**Source:** [`epic-ehi-kg`](https://github.com/) — Paul's Epic EHI Export Specification knowledge graph (7,797 tables / 63,956 columns, May 2026 release, `su118s2p`).
**Companion data file:** [`CM-22-Epic-EHI-Field-Candidates.csv`](./CM-22-Epic-EHI-Field-Candidates.csv) (566 rows).

---

## Why this run exists

The CM-22 canonical measure report names one central open issue: **"The Completed-Encounter Definition Gap"** — whether the EHR field a site hands over for "encounter count" reflects appointments scheduled, visits roomed, or notes signed, since only the last matches both the algorithm card's Gold Standard and Suki's own existing "total closed encounter count" telemetry convention. This pass exists to find the specific clarity field(s) that resolve that definition question, plus the provider/date fields needed to aggregate at weekly grain for the within-provider design the report recommends.

**This is schema-only reconnaissance.** A column existing in the EHI export spec says nothing about whether the pilot site's build populates or maintains it — that's the site data team's next step, not this one.

---

## Method

Matched table names against three concept clusters: the core encounter record, appointment/scheduling status, and provider scheduling/FTE records. Much narrower sweep than CM-04 or CM-21 by design — CM-22's data requirement genuinely is narrow (one status flag, one date field, a provider join key), so an intentionally broad table-name net was not needed the way it was for documentation-time or coding-accuracy's much larger candidate universe.

| Bucket | Tables | Columns |
|---|---:|---:|
| Encounter / visit record (`PAT_ENC` + overflow family, `PAT_ENC_HSP*`) | 10 | 540 |
| Appointment / scheduling status | 5 | 23 |
| Provider record (FTE / schedule — exploratory) | 1 | 3 |

---

## Headline findings

### 1. `PAT_ENC.ENC_CLOSED_YN` — directly resolves the Completed-Encounter Definition Gap
This is the single most important find of this pass. `PAT_ENC` carries a flag, `ENC_CLOSED_YN`, described exactly as needed: *"signifies if this encounter is closed as of the time of the enterprise reporting extract"* (Y/N/null). Paired with `ENC_CLOSE_DATE` (the date the encounter closed) and `ENC_CLOSED_USER_ID` (who closed it), this is very plausibly the field that answers the report's central open question — a closed encounter is the closest clarity-native concept to "note signed," which is what both the Gold Standard definition and Suki's existing telemetry convention require. **Not yet confirmed** that "closed" is semantically identical to "signed" at the pilot site specifically (some sites close encounters on billing completion rather than note signature) — this is exactly the kind of definitional nuance to raise with the site data team alongside the density check, not something resolvable from the schema alone.

### 2. `PAT_ENC.CALCULATED_ENC_STAT_C_NAME` — a second, possibly more directly usable status field
Described as *"a status flag used to determine whether to include data from the encounter in the SlicerDicer reporting application"*, with a stated category range starting at "1-Possible" — i.e., Epic's own reporting tool already uses this field to decide encounter inclusion. If its categories map cleanly onto "should this count as a completed encounter," it may be a more direct answer than `ENC_CLOSED_YN` since it's purpose-built for reporting inclusion rather than administrative closure. Worth checking both fields' actual category values against each other in the density pass, since they may disagree on edge cases (e.g., an encounter closed for billing but excluded from SlicerDicer reporting for a different reason).

### 3. `PAT_ENC_HSP_2.ENC_CLOSED_OR_COMPLETED_DATE` — hospital-encounter equivalent
For sites/encounter types where the base `PAT_ENC` closure fields don't apply cleanly (inpatient/hospital encounters), this overflow-family field gives an analogous closed-or-completed date. Relevant if the pilot site's CM-22 population needs to include hospital encounters, not just ambulatory ones.

### 4. `PAT_ENC.APPT_STATUS_C_NAME` — the "scheduled" definition, for contrast
Directly names the appointment-status category (e.g., "1 = Scheduled") the report warns against using alone. Useful as a negative control in the density check: if a developer's query naively pulls `APPT_STATUS_C_NAME = 'Completed'` instead of `ENC_CLOSED_YN = 'Y'`, that's the exact misdefinition the canonical measure report flags as the most likely source of a misleading CM-22 number. Worth writing the eventual query to explicitly log which field was used, per the report's own recommendation.

### 5. Provider scheduled-hours/FTE field — not found in this pass
The report's EHR-side data table calls for "scheduled clinical hours per provider per week" as the normalizer for part-time schedules. This pass did not turn up a clean candidate — `CLARITY_SER` (the provider/serial master file) matched the table-name sweep but only 3 columns matched narrowly, and a direct keyword search for "scheduled clinical hours" / "provider FTE" across all 64k columns returned no strong hits (the closest matches were unrelated: claim-line "provider penalty" and MyChart "provider viewed history" fields). Two plausible explanations, neither confirmed: (a) this data lives in a scheduling-template module not well-covered by the EHI export spec's table-name conventions, so a join-graph expansion from `CLARITY_SER` or a raw-description keyword pass (rather than table-name matching) might still find it; or (b) it genuinely isn't in Clarity and needs to come from a scheduling system or HR feed outside Epic, as the canonical measure report already anticipated as a fallback. Flag this explicitly to the site data team as an open question rather than treating its absence here as a confirmed gap.

---

## Caveats

- Provider-ID join key (needed to link `PAT_ENC` rows to a Suki session/provider) was not verified by column name in this pass — the standard Epic field is typically on `PAT_ENC` or one of its overflow tables; confirm before writing the join query, same caveat as the CM-21 pass.
- Weekly-grain aggregation is a `GROUP BY` on `CONTACT_DATE` (present and time-typed on `PAT_ENC`), not a separate field — no schema gap there, just confirm date range coverage in the density check.
- Table-name-driven only, same limitation as the CM-04 and CM-21 passes — a join-graph expansion from `PAT_ENC` or a raw-description keyword sweep is the natural next widening if the FTE/scheduled-hours gap (finding #5) needs to be chased further.
- Longer-term, out of scope for this pass: whether the same fields translate to South Carolina's Epic implementation.

---

*Generated 2026-08-20 from `epic-ehi-kg` (May 2026 EHI release) as part of Sprint 2 feasibility prep. Sweep script available on request.*
