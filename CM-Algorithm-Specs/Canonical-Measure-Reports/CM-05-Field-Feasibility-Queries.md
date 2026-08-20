# CM-05 After-Hours Documentation — Field Feasibility Queries

**Purpose:** turns the candidate field list in [CM-05-Epic-EHI-Field-Candidates.md](./CM-05-Epic-EHI-Field-Candidates.md) into queries a developer at any Epic site can run. Read the field-candidates doc first: the honest headline there is that no `after_hours_min`-equivalent field exists in the public EHI export at all, so this battery is narrower and more conditional than the other three.
**Companion file:** [`CM-05-Field-Feasibility-Queries.sql`](./CM-05-Field-Feasibility-Queries.sql) — 77 auto-generated queries, reusing the CM-04 note-timestamp candidate tables.

---

## Before running any of this: the real first question is a licensing one, not a query one

If Epic Signal or the User Activity Log is licensed and its export is accessible at a site, that is a materially better data source for CM-05 than anything in this battery, and supersedes it. Confirming Signal/UAL access is a question for whoever owns the customer/site relationship, not something these queries can answer. Only fall back to the queries below if that answer is no, or is still pending and a fallback signal is wanted in the meantime.

## How to run

The auto-generated `.sql` file is mechanically identical in shape to the CM-04 battery, one query per table, grouped by year where a date column exists, because it reuses the same underlying tables (`HNO_INFO`, `NOTE_ENC_INFO`, `NOTES_HISTORY_LOG`, `NOTE_EDIT_TRAIL`, and related). If CM-04's density check has already been run at a given site, most of this battery's fill-rate results are already known and don't need to be re-run; what's new here is the *use* of those same fields (bucketing by hour-of-day, not just checking they're populated).

## The follow-up query this battery doesn't auto-generate

Once a note-timestamp field's basic fill rate is confirmed (via the CM-04 battery or this one), the CM-05-specific question is what fraction of that activity falls outside business hours. That's a hand-written follow-up, not something worth mechanically generating, since it needs a judgment call on what counts as "after hours" for a given site/specialty. A starting template:

```sql
-- Example: after-hours share of HNO_INFO note-creation activity.
-- Adjust the business-hours window and weekday/weekend handling per site.
-- DATEPART is SQL Server syntax; SAS PROC SQL also supports it. On Oracle,
-- use TO_CHAR(<col>, 'HH24') / TO_CHAR(<col>, 'D') instead.
SELECT
    YEAR(CREATE_INSTANT_DTTM) AS activity_year,
    COUNT(*) AS total_rows,
    SUM(CASE
            WHEN DATEPART(HOUR, CREATE_INSTANT_DTTM) NOT BETWEEN 7 AND 18
                 OR DATEPART(WEEKDAY, CREATE_INSTANT_DTTM) IN (1, 7)
            THEN 1 ELSE 0
        END) AS after_hours_rows
FROM HNO_INFO
GROUP BY YEAR(CREATE_INSTANT_DTTM)
ORDER BY activity_year;
```

## How to report back

Same shape as the other batteries for the base fill-rate queries: raw `(table, column, activity_year, total_rows, <column>_filled)` counts. For the after-hours follow-up query, report the after-hours share alongside the total, and note whatever business-hours definition was used, since that's a per-site judgment call, not a fixed constant.

## Caveats

- This fallback is explicitly **not** the Suki-session-timing proxy the canonical measure report warns against. It uses EHR-native note timestamps, not Suki's own session data. It's still an imperfect proxy for the full `after_hours_min` picture: it only captures documentation activity, not inbox work, chart review, or order entry outside any note, so it will systematically undercount relative to a true Signal/UAL figure. Report it as a documentation-specific after-hours signal, not as CM-05 itself.
- **The anchor date column chosen for each table's `YEAR()` grouping is a heuristic**, same caveat as the CM-04 battery it's reused from, since it's the same table set.
- `COUNT(<column>)` excludes `NULL` but not empty strings, same as the other batteries.
- The provider scheduled-hours field CM-05's Gold Standard definition also calls for (to avoid the generic 9-5 default) was not found in this schema pass either, same negative result as the CM-22 pass on `CLARITY_SER`. Treat it as one open question shared across both measures, not two separate gaps.
