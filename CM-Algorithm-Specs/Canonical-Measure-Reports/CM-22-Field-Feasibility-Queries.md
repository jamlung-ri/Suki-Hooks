# CM-22 Patient Volume/Throughput — Field Feasibility Queries

**Purpose:** turns the candidate field list in [CM-22-Epic-EHI-Field-Candidates.md](./CM-22-Epic-EHI-Field-Candidates.md) into one script a developer at any Epic site can run to report back which fields are actually populated, and if a promising-but-sparse field is a temporal artifact rather than a permanent gap.
**Companion file:** [`CM-22-Field-Feasibility-Queries.sql`](./CM-22-Field-Feasibility-Queries.sql) — 16 candidate tables, run as one script, returns one result grid. The smallest of the four batteries.
**Read first:** [`Field-Feasibility-Queries-README.md`](./Field-Feasibility-Queries-README.md) — what this is, why it's safe to run, how to run it, and how to report results back. This doc only adds what's specific to CM-22.

---

## What to look at first once results are back

1. **`PAT_ENC.ENC_CLOSED_YN`** (+ `ENC_CLOSE_DATE`, `ENC_CLOSED_USER_ID`) — the standout candidate for resolving the "completed encounter" definition question. If this comes back well-populated, that's the headline result of the whole pass.
2. **`PAT_ENC.CALCULATED_ENC_STAT_C_NAME`** — a second status field purpose-built for reporting-inclusion decisions; worth comparing its fill rate and (later, once both are populated) its actual category values against `ENC_CLOSED_YN`, since they may disagree on edge cases.
3. **`PAT_ENC_HSP_2.ENC_CLOSED_OR_COMPLETED_DATE`** — only relevant if the CM-22 population needs to include hospital/inpatient encounters, not just ambulatory ones.
4. **`PAT_ENC.APPT_STATUS_C_NAME`** — included as a deliberate negative control. This is the "scheduled" definition the canonical measure report warns against using alone; its fill rate is worth reading too, so anyone writing the eventual calculation query can see explicitly that this field was considered and set aside, not overlooked.

## Caveats specific to CM-22

- For the `PAT_ENC` overflow family specifically, several of the `_2` through `_8` member tables don't carry `CONTACT_DATE`, and the anchor-date heuristic (see the shared README) falls back to whatever date-typed column comes first (e.g. an admission-testing or billing-area date), which may not represent real encounter volume. Sanity-check those specific year breakdowns before trusting them.
- `ENC_CLOSED_YN` is documented as Y/N/null-valued, worth confirming there isn't also a blank-string variant in practice (see the shared README's empty-string caveat).
- The provider scheduled-hours/FTE field this measure's Gold Standard definition calls for was not found in the schema pass at all (see the field-candidates doc, finding #5), there is no query for it in this battery because there was no candidate field to query. If it turns out to exist under a name this pass didn't match, that's a schema-search gap to revisit, not something these 16 queries will surface.
