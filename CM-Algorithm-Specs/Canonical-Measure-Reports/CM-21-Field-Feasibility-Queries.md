# CM-21 Coding Accuracy — Field Feasibility Queries

**Purpose:** turns the candidate field list in [CM-21-Epic-EHI-Field-Candidates.md](./CM-21-Epic-EHI-Field-Candidates.md) into queries a developer at any Epic site can run against Clarity (or an equivalent reporting layer) to report back which fields are actually populated, and if a promising-but-sparse field is a temporal artifact rather than a permanent gap.
**Companion file:** [`CM-21-Field-Feasibility-Queries.sql`](./CM-21-Field-Feasibility-Queries.sql) — 303 auto-generated queries, one per candidate table.
**Scope note:** same as the field-candidates doc — this covers Algorithm 1 (ICD-10 coding depth) and Algorithm 3 (denial rate) inputs, not Algorithm 2 (Suki-suggested vs. billed codes), which is blocked on encounter-to-claim linkage rather than field availability.

---

## How to run

Each query in the `.sql` file targets one candidate table in a single pass: it counts total rows and, where the table has a date/datetime column, groups by calendar year so a sparse field's fill rate can be read across time. Tables without any date-typed column get a flat total-only query instead.

Run the whole file as a batch, or table-by-table if starting with the priority list below. No changes needed for SQL Server or SAS PROC SQL; on Oracle, replace `YEAR(<col>)` with `EXTRACT(YEAR FROM <col>)` throughout.

## Priority tables — run these first

The exhaustive pass surfaced five headline candidates across the four buckets (see the field-candidates doc for full reasoning); these are the ones worth a developer's first pass before the remaining ~298 tables in the full battery:

1. **`PAT_ENC_EM_CODE_DX`**, **`ADDITIONAL_EM_CODE`**, **`EM_CODE_CALC`** — the direct E/M-level fields. `EM_CODE_CALC.EM_CODE_SOURCE_C_NAME` is worth extra attention: it tracks whether the code was filed manually vs. derived from documentation.
2. **`CVG_MEM_RISK_ADJ_FACT`** (+ its history table) — the HCC/risk-adjustment factor table, keyed off coverage/patient rather than encounter.
3. **`AP_CLAIM`** (+ `AP_CLAIM_2`) — claim status/denial fields (`STATUS_C_NAME`, `CL_DEN_PEND_DTTM`, `DENY_CLM_SRC_C_NAME`) and **`CLM_VALUES_5`** (`NON_PAYMENT_RSN_CD`/`_DESC`) — the claim-level denial-reason fields, likely the cleanest single source for filtering to coding-related denials specifically.
4. **`HSP_ACCT_CPT_CODES`** + **`HSP_ACCT_CLM_CPT`** — final billed procedure codes at the hospital-account level.
5. **`HSP_BDC_DENIAL_DATA`** + **`HSP_BDC_DENIED_DIAGNOSES`** — more granular denial detail (EOB-line level) than `AP_CLAIM`'s claim-level status; worth checking both since the coarser field may be denser even though the finer one is more precise.

## How to report back

Same shape as the CM-04 queries: report the raw `(table, column, activity_year, total_rows, <column>_filled)` output, not just computed percentages, so small-denominator noise can be told apart from a real signal later.

If any of the denial-reason fields (priority tables #3/#5) come back well-populated, the next useful thing to know isn't just fill rate, it's whether the reason-code taxonomy actually distinguishes coding-related denials from authorization/eligibility denials. That's a values/category question a straight fill-rate query doesn't answer; worth a follow-up "distinct values" query on those specific columns once fill rate is confirmed.

## Caveats

- **The anchor date column chosen for each table's `YEAR()` grouping is a heuristic** (prefers `CONTACT_DATE`, otherwise the first date-typed column found), not a guarantee it's the most meaningful date field on that table. This matters more here than for CM-04/CM-22: many of the 303 tables are deep billing/claims sub-tables where the auto-picked anchor may be an administrative or estimate date rather than the record's real activity date. Sanity-check before trusting any single table's year breakdown.
- `COUNT(<column>)` excludes `NULL` by standard SQL semantics, but not empty strings. Check `VARCHAR` fields that look surprisingly well-populated for empty-string-as-null.
- The claims/denials bucket (80 tables) was already narrowed once from an initial 472-table match on `*CLAIM*` down to genuinely denial/status-relevant tables — it's still the largest bucket here and includes some deep sub-tables (appeal audit trails, EDI correspondence detail) that are more likely to be near-zero for coding-accuracy purposes specifically. Expect a long tail of zeroes; that's expected, not a query problem.
- The `HCC / risk adjustment` table-name pattern matched two `CANCER_RISK_SCORE_*` tables that are clinical cancer-risk scoring, unrelated to billing risk adjustment — included in the batch for completeness, flagged here so a near-zero or off-topic result there isn't mistaken for a real gap in the risk-adjustment data itself.
