# CM-04 Documentation Time — Field Feasibility Queries

**Purpose:** turns the candidate field list in [CM-04-Epic-EHI-Field-Candidates.md](./CM-04-Epic-EHI-Field-Candidates.md) into one script a developer at any Epic site can run to report back which fields are actually populated, and if a promising-but-sparse field is a temporal artifact rather than a permanent gap.
**Companion file:** [`CM-04-Field-Feasibility-Queries.sql`](./CM-04-Field-Feasibility-Queries.sql) — 170 candidate tables, run as one script, returns one result grid.
**Read first:** [`Field-Feasibility-Queries-README.md`](./Field-Feasibility-Queries-README.md) — what this is, why it's safe to run, how to run it, and how to report results back. This doc only adds what's specific to CM-04.

---

## Priority tables — look at these first once results are back

The exhaustive pass surfaced six headline candidates (see the field-candidates doc for full reasoning); worth checking these first in the returned CSV, ahead of the remaining ~164 tables:

1. **`NOTE_ENC_INFO`** — richest single table found; already has a partial density baseline (see the field-candidates doc), the remaining ~14 time-typed columns haven't been checked at all.
2. **`NOTE_EDIT_TRAIL`** — sibling edit-event log to `NOTES_HISTORY_LOG`; worth checking whether it has denser event logging.
3. **`NOTES_TRANS_AUTH`** — explicit dictation/transcription timing table.
4. **`PAT_ENC_AMBIENT_SESSIONS`** + **`NOTE_AMBIENT_SECTIONS`** — Epic's native ambient-scribe session linkage; strategically useful beyond CM-04 (identifying non-Suki ambient-scribe encounters), so worth checking even if not chosen as the final CM-04 field.
5. **`PAT_ADDENDUM_INFO`** — a native start→finish duration pair, no sessionization needed.
6. **`HNO_INFO`** (extra columns) — cheap to check since it's already in use, no new join required.

## Caveats specific to CM-04

- Several of these tables are very large (hundreds of millions of rows, per the density baseline already in hand for `HNO_INFO`/`NOTE_ENC_INFO`). If the script runs slowly on this file specifically, that's most likely those two tables' Phase 1 blocks, consider adding a `WHERE <anchor> >= '2024-01-01'` to just those blocks for a faster first pass (see the shared README for the general version of this note).
- Expect most of the 170 tables to come back near-zero. That's the expected outcome of an exhaustive, not precise, sweep, the administrative/non-clinical bucket in particular is included for completeness, not because it's likely to be useful.
