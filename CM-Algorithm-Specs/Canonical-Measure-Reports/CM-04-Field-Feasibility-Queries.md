# CM-04 Documentation Time — Field Feasibility Queries

**Purpose:** turns the candidate field list in [CM-04-Epic-EHI-Field-Candidates.md](./CM-04-Epic-EHI-Field-Candidates.md) into queries a developer at any Epic site can run against Clarity (or an equivalent reporting layer) to report back which fields are actually populated, and if a promising-but-sparse field is a temporal artifact rather than a permanent gap.
**Companion file:** [`CM-04-Field-Feasibility-Queries.sql`](./CM-04-Field-Feasibility-Queries.sql) — 170 auto-generated queries, one per candidate table.

---

## How to run

Each query in the `.sql` file targets one candidate table in a single pass: it counts total rows and, where the table has a date/datetime column, groups by calendar year so a sparse field's fill rate can be read across time (a field that's ~0% pre-2024 and 60%+ after is a rollout/version change, not a bad field — this exact pattern is why this step exists). Tables without any date-typed column get a flat total-only query instead.

Run the whole file as a batch, or table-by-table if starting with the priority list below. No changes needed for SQL Server or SAS PROC SQL; on Oracle, replace `YEAR(<col>)` with `EXTRACT(YEAR FROM <col>)` throughout.

## Priority tables — run these first

The exhaustive pass surfaced six headline candidates (see the field-candidates doc for full reasoning); these are the ones worth a developer's first pass before the remaining ~164 tables in the full battery:

1. **`NOTE_ENC_INFO`** — richest single table found; already has a partial density baseline (see the field-candidates doc), the remaining ~14 time-typed columns haven't been checked at all.
2. **`NOTE_EDIT_TRAIL`** — sibling edit-event log to `NOTES_HISTORY_LOG`; worth checking whether it has denser event logging.
3. **`NOTES_TRANS_AUTH`** — explicit dictation/transcription timing table.
4. **`PAT_ENC_AMBIENT_SESSIONS`** + **`NOTE_AMBIENT_SECTIONS`** — Epic's native ambient-scribe session linkage; strategically useful beyond CM-04 (identifying non-Suki ambient-scribe encounters), so worth running even if not chosen as the final CM-04 field.
5. **`PAT_ADDENDUM_INFO`** — a native start→finish duration pair, no sessionization needed.
6. **`HNO_INFO`** (extra columns) — cheap to check since it's already in use, no new join required.

## How to report back

For each table, report the raw output (not just the computed percentage) — small denominators can make a rounded percentage misleading, and the raw counts are what let someone later tell a temporal cutover apart from noise. The most useful shape to hand back is one row per `(table, column, activity_year)` with `total_rows` and `<column>_filled`, the same grain the year-grouped queries already produce. That reshapes cleanly onto the existing candidate CSV if it's worth merging in later.

## Caveats

- **The anchor date column chosen for each table's `YEAR()` grouping is a heuristic** (prefers `CONTACT_DATE`, otherwise the first date-typed column found), not a guarantee it's the most meaningful date field on that table. Sanity-check the chosen anchor before trusting the year breakdown, especially on tables where the picked column looks like an estimate/administrative date rather than the table's real activity date.
- `COUNT(<column>)` excludes `NULL` by standard SQL semantics, but not empty strings. If a `VARCHAR` field's fill rate looks surprisingly high, check whether it's actually storing empty strings for "no data" (`COUNT(NULLIF(<column>, ''))` instead).
- Several of these tables are very large (hundreds of millions of rows, per the density baseline already in hand for `HNO_INFO`/`NOTE_ENC_INFO`). For tables that size, consider adding a `WHERE <anchor> >= '2024-01-01'` first pass before running the unfiltered version, both for query cost and because recent data is what most directly answers the feasibility question.
- Expect most of the 170 tables to come back near-zero. That's the expected outcome of an exhaustive, not precise, sweep — the administrative/non-clinical bucket in particular is included for completeness, not because it's likely to be useful.
