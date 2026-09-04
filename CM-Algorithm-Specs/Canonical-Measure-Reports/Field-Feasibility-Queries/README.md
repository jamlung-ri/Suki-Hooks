# Field Feasibility Queries — Read This First

This covers all four `CM-XX-Field-Feasibility-Queries.sql` files in this directory (CM-04, CM-05, CM-21, CM-22). Read it once; the per-measure `.md` docs only add what's specific to that measure (which tables to look at first, measure-specific caveats). The candidate field lists these batteries check against live in `../Epic-EHI-Field-Candidates/`, and the canonical measure reports that motivate them live in `../Reports/`.

## What these are

Each `.sql` file is a mechanically generated battery that checks, for every field on the corresponding `CM-XX-Epic-EHI-Field-Candidates.md` candidate list, whether that field is actually populated in your Epic Clarity build, and if it's sparse, whether that's constant over time or a recent rollout (a field that's ~0% before 2024 and 60%+ after is a version/workflow change, not a dead field). These candidate fields came from Epic's own public EHI Export Specification schema, not from anything Suki-proprietary or site-specific.

**This is a feasibility/discovery pass, not the measure calculation itself.** The goal is narrowing a long candidate list down to the handful of fields worth building the actual measure query against, before anyone writes that query. It's necessarily broader than the eventual measure logic will be, on purpose: a narrower, hand-picked field list sent in an earlier round came back missing information we needed, so this round widens the net rather than risking another back-and-forth.

## Is this safe to run against our system?

- **Read-only in effect.** Every statement is either a `SELECT`, or a `SELECT ... INTO` that populates a session-scoped temporary table from an aggregate query. Nothing here ever inserts into, updates, or deletes from any table that already exists in your system.
- **No patient-level or row-level data is ever read out.** Every query is `COUNT(*)` and `COUNT(<column>)` aggregates only, grouped by year — never `SELECT *`, never an individual row. The result set that comes back is counts, not records.
- **Nothing persists.** The `#fc_NNN`-prefixed staging tables are standard SQL Server local temporary tables: scoped to your session and automatically destroyed when your connection closes. No permanent object is created anywhere. (On Oracle/SAS, see the dialect note in each `.sql` file — those platforms don't have the same auto-temp mechanism, so a commented-out cleanup block is provided.)
- **Uniform and auditable.** Every block in a script's Phase 1 has the exact same shape: an aggregate `SELECT` into a staging table, nothing else. If you or your security/DBA team want to verify the script before running it, skim the first two or three blocks, every remaining block (there may be dozens to hundreds) follows the identical pattern.
- **No dynamic SQL, no system-catalog access, no cross-database or linked-server calls.**
- **A missing table or column can't break the run.** Every Phase 1 block is wrapped in its own `BEGIN TRY`/`BEGIN CATCH`. If a candidate table or column doesn't exist in your build, that block's staging table is still created, just with NULL counts and a `query_error` message instead of data. One table not existing never stops the script or affects any other table's results, and Phase 2 always returns its one grid regardless of how many individual tables failed.
- **Standard due diligence still applies.** Run this against your Clarity reporting layer rather than a live transactional system if your environment distinguishes the two, and route it through whatever review your organization normally requires for a new read-only report query. This document is meant to make that review fast, not to replace it.

## How to run

1. Open the `.sql` file for the measure you're checking.
2. Run the entire script, top to bottom, in one session/connection.
3. It will silently populate a series of temporary staging tables (Phase 1), then return **exactly one result grid** at the very end (Phase 2). That's everything, there's nothing else to click through or export separately.
4. Export that one grid to CSV and send it back. That's the entire ask.
5. If some tables don't exist in your build, the script does not stop or error out on your end. Those tables just show up in the grid with an error message and no counts. **Please don't spend time troubleshooting individual failures** — a wall of `query_error` values is useful information on its own, not something to fix before sending results back.

If you need to re-run the script in the same session, run the commented-out cleanup block at the bottom first (or just start a fresh connection, SQL Server temp tables clear automatically then).

## Dialect

Written for SQL Server T-SQL by default. On Oracle or in SAS PROC SQL, two mechanical swaps, noted at the top of every `.sql` file:
1. `SELECT ... INTO #fc_NNN FROM ...` → `CREATE TABLE fc_NNN AS SELECT ... FROM ...`
2. `YEAR(<col>)` → `EXTRACT(YEAR FROM <col>)` (Oracle only; SAS PROC SQL supports `YEAR()` natively)

If a column name happens to collide with a reserved word in your platform, quote it (`[COL]` on SQL Server, `"COL"` on Oracle).

The per-table `BEGIN TRY`/`BEGIN CATCH` wrapper (see "Is this safe to run" above) is SQL Server syntax and doesn't translate mechanically. On Oracle, the equivalent is a PL/SQL block per table (`BEGIN ... EXCEPTION WHEN OTHERS THEN ... END;`). SAS PROC SQL has no per-statement equivalent at all — if you're running this through PROC SQL rather than a native SQL Server/Oracle client, let us know before you run it and we'll send a PROC SQL-safe variant.

## What you'll get back, and what happens to it

One CSV per measure, with one row per `(table, column, activity_year)`: total row count, how many of those rows have that field populated for that year, and a `query_error` column that's NULL for everything that ran fine and holds the database's own error message for anything that didn't (most commonly, a table or column that doesn't exist in your build). We do the interpretation on our end (deciding what counts as usable density, spotting rollout cutovers, sorting out genuine gaps from tables/columns that just aren't there, etc.) — the ask on your side is just running the script and sending the grid back exactly as it comes out, no filtering, summarizing, or troubleshooting needed first.

## If a script is too large or slow to run as one query

CM-21's battery is the largest (2,802 candidate columns across 303 tables) and its single combined Phase 2 query has thousands of `UNION ALL` branches, which may be slow to compile or optimize on some systems even though each individual branch is cheap (it's just reading a few already-materialized rows out of a temp table). If that's a problem: Phase 1 (the actual table scans) is unaffected either way, that's the expensive part and it's already broken into one query per table. Phase 2 can be split by commenting out all but a subset of the `UNION ALL` blocks and running/exporting it in a few passes instead of one, the file is organized so each table's block of `UNION ALL` lines is contiguous and labeled with a `-- ---- fc_NNN <- TABLENAME ----` comment in Phase 1 you can search for.

## Caveats that apply across all four scripts

- **The anchor date column used for each table's `YEAR()` grouping is a heuristic** (prefers `CONTACT_DATE`, otherwise the first date-typed column found on that table), not a guarantee it's the most meaningful date field there. It's called out per-table in each measure's `.md` doc where it's known to matter; in general, treat a table's year breakdown as provisional until the chosen anchor column has been sanity-checked.
- `COUNT(<column>)` excludes `NULL` by standard SQL semantics, but not empty strings. If a `VARCHAR` field's fill rate looks surprisingly high, check whether it's storing empty strings for "no data" rather than `NULL` (`COUNT(NULLIF(<column>, ''))` instead, if so).
- Expect a long tail of near-zero results. These batteries are deliberately exhaustive rather than pre-filtered, several buckets across the four measures are included for completeness even where they're expected to be low-relevance. A wall of zeroes for those tables is the expected outcome, not a sign anything went wrong.
