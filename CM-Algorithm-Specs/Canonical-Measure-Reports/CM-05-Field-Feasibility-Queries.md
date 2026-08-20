# CM-05 After-Hours Documentation — Field Feasibility Queries

**Purpose:** turns the candidate field list in [CM-05-Epic-EHI-Field-Candidates.md](./CM-05-Epic-EHI-Field-Candidates.md) into one script a developer at any Epic site can run. Read the field-candidates doc first: the honest headline there is that no `after_hours_min`-equivalent field exists in the public EHI export at all, so this battery is narrower and more conditional than the other three.
**Companion file:** [`CM-05-Field-Feasibility-Queries.sql`](./CM-05-Field-Feasibility-Queries.sql) — 77 candidate tables (reusing the CM-04 note-timestamp candidates), run as one script, returns one result grid.
**Read first:** [`Field-Feasibility-Queries-README.md`](./Field-Feasibility-Queries-README.md) — what this is, why it's safe to run, how to run it, and how to report results back. This doc only adds what's specific to CM-05.

---

## Before running any of this: the real first question is a licensing one, not a query one

If Epic Signal or the User Activity Log is licensed and its export is accessible at a site, that is a materially better data source for CM-05 than anything in this battery, and supersedes it. Confirming Signal/UAL access is a question for whoever owns the customer/site relationship, not something these queries can answer. Only run the battery below if that answer is no, or is still pending and a fallback signal is wanted in the meantime.

## What this battery actually checks

Because it reuses the CM-04 note-timestamp tables (`HNO_INFO`, `NOTE_ENC_INFO`, `NOTES_HISTORY_LOG`, `NOTE_EDIT_TRAIL`, and related), if CM-04's battery has already been run at a given site, most of these fill-rate results are already known and don't need to be re-run. What's new for CM-05 is the *use* of those fields (bucketing by hour-of-day, not just confirming they're populated), covered by the follow-up query below rather than the auto-generated script itself.

## The follow-up query this battery doesn't auto-generate

Once a note-timestamp field's basic fill rate is confirmed, the CM-05-specific question is what fraction of that activity falls outside business hours. That's a hand-written follow-up, not something worth mechanically generating, since it needs a judgment call on what counts as "after hours" for a given site/specialty. Same packaging convention as the auto-generated script (one long-format result set), so results are directly comparable and combinable:

```sql
-- Example: after-hours share of HNO_INFO note-creation activity.
-- Adjust the business-hours window and weekday/weekend handling per site.
-- Read-only, aggregate-only, same safety properties as the auto-generated
-- battery (see the shared README).
-- DATEPART is SQL Server syntax; SAS PROC SQL also supports it. On Oracle,
-- use TO_CHAR(<col>, 'HH24') / TO_CHAR(<col>, 'D') instead.
SELECT
    'HNO_INFO' AS table_name,
    'CREATE_INSTANT_DTTM' AS column_name,
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

Report the after-hours share alongside the total, and note whatever business-hours definition was used since that's a per-site judgment call, not a fixed constant.

## Caveats specific to CM-05

- This fallback is explicitly **not** the Suki-session-timing proxy the canonical measure report warns against. It uses EHR-native note timestamps, not Suki's own session data. It's still an imperfect proxy for the full `after_hours_min` picture: it only captures documentation activity, not inbox work, chart review, or order entry outside any note, so it will systematically undercount relative to a true Signal/UAL figure. Report it as a documentation-specific after-hours signal, not as CM-05 itself.
- The anchor-date heuristic (see the shared README) applies here too, same caveat as the CM-04 battery this reuses, since it's the same table set.
- The provider scheduled-hours field CM-05's Gold Standard definition also calls for (to avoid the generic 9-5 default) was not found in this schema pass either, same negative result as the CM-22 pass on `CLARITY_SER`. Treat it as one open question shared across both measures, not two separate gaps.
