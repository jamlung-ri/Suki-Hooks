# CM-22 Patient Volume/Throughput — Field Feasibility Queries

**Purpose:** turns the candidate field list in [CM-22-Epic-EHI-Field-Candidates.md](./CM-22-Epic-EHI-Field-Candidates.md) into queries a developer at any Epic site can run against Clarity (or an equivalent reporting layer) to report back which fields are actually populated, and if a promising-but-sparse field is a temporal artifact rather than a permanent gap.
**Companion file:** [`CM-22-Field-Feasibility-Queries.sql`](./CM-22-Field-Feasibility-Queries.sql) — 16 auto-generated queries, one per candidate table.

---

## How to run

Each query in the `.sql` file targets one candidate table in a single pass: it counts total rows and, where the table has a date/datetime column, groups by calendar year so a sparse field's fill rate can be read across time. Tables without any date-typed column get a flat total-only query instead.

This is the smallest of the four query batteries, run the whole file; there's no need to phase it by priority the way CM-04/CM-21 do. No changes needed for SQL Server or SAS PROC SQL; on Oracle, replace `YEAR(<col>)` with `EXTRACT(YEAR FROM <col>)` throughout.

## What to look at first once results are back

1. **`PAT_ENC.ENC_CLOSED_YN`** (+ `ENC_CLOSE_DATE`, `ENC_CLOSED_USER_ID`) — the standout candidate for resolving the "completed encounter" definition question. If this comes back well-populated, that's the headline result of the whole pass.
2. **`PAT_ENC.CALCULATED_ENC_STAT_C_NAME`** — a second status field purpose-built for reporting-inclusion decisions; worth comparing its fill rate and (later, once both are populated) its actual category values against `ENC_CLOSED_YN`, since they may disagree on edge cases.
3. **`PAT_ENC_HSP_2.ENC_CLOSED_OR_COMPLETED_DATE`** — only relevant if the CM-22 population needs to include hospital/inpatient encounters, not just ambulatory ones.
4. **`PAT_ENC.APPT_STATUS_C_NAME`** — included as a deliberate negative control. This is the "scheduled" definition the canonical measure report warns against using alone; report its fill rate too, so anyone writing the eventual calculation query can see explicitly that this field was considered and set aside, not overlooked.

## How to report back

Same shape as the other three batteries: report the raw `(table, column, activity_year, total_rows, <column>_filled)` output, not just computed percentages.

## Caveats

- **The anchor date column chosen for each table's `YEAR()` grouping is a heuristic** (prefers `CONTACT_DATE`, otherwise the first date-typed column found). For the `PAT_ENC` overflow family specifically, several of the `_2` through `_8` member tables don't carry `CONTACT_DATE` and the picked fallback anchor (e.g. an admission-testing or billing-area date) may not represent real encounter volume. Sanity-check before trusting those specific year breakdowns.
- `COUNT(<column>)` excludes `NULL` by standard SQL semantics, but not empty strings. `ENC_CLOSED_YN` in particular is documented as Y/N/null-valued — worth confirming there isn't also a blank-string variant in practice.
- The provider scheduled-hours/FTE field this measure's Gold Standard definition calls for was not found in the schema pass at all (see the field-candidates doc, finding #5) — there is no query for it in this battery because there was no candidate field to query. If it turns out to exist under a name this pass didn't match, that's a schema-search gap to revisit, not something these 16 queries will surface.
