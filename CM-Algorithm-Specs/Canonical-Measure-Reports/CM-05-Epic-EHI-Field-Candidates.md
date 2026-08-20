# CM-05 After-Hours Documentation — Epic EHI Field Candidates (Exhaustive Pass)

**Status:** Schema-only reconnaissance for the field-requirements approach for CM-05, part of the broader Sprint 2 feasibility prep (internal confidence against a pilot site's data before approaching South Carolina).
**Scope:** After-hours documentation time only (CM-05) — narrower than the other passes because the [canonical measure report](./CM-05-After-Hours-Documentation-Canonical-Measure-Report.md) already names a very specific data requirement (`after_hours_min` per provider per month) rather than an open field-discovery question.
**Source:** [`epic-ehi-kg`](https://github.com/) — Paul's Epic EHI Export Specification knowledge graph (7,797 tables / 63,956 columns, May 2026 release, `su118s2p`).
**Companion data file:** [`CM-05-Epic-EHI-Field-Candidates.csv`](./CM-05-Epic-EHI-Field-Candidates.csv) (137 rows).

---

## Why this run exists, and the headline result up front

The CM-05 canonical measure report already flags that EHR audit-log data is "authoritative — more so than for almost any other canonical measure" for this one, and names `after_hours_min` (an Epic Signal / User Activity Log metric) as the primary and only credible source. This pass exists to check whether that field, or anything equivalent, shows up in the public EHI Export Specification the way CM-04's and CM-22's candidate fields did.

**It doesn't.** A keyword search across all ~64,000 columns for "after hours," "pajama," "outside scheduled," "work outside work," "efficiency profile," "working hours," "logged in," "login," "activity log," and "keystroke" returned no substantive hits — mostly false positives from unrelated tables (e.g., a physical-therapy admission item literally named for pajama-top dressing ability). A table-name sweep for audit/activity-log/login-style tables (`*AUDIT_TRAIL*`, `*ACCESS_LOG*`, `*LOGIN*`, `USER_ACTIVITY*`) returned six tables, all unrelated (appeal audit trails, chat access logs, image-editing audit trails) — none are user-session or click-level activity logs.

**This is expected, not a search failure.** Epic Signal and the User Activity Log are separate, licensed reporting products layered on top of Clarity — they are not part of the public, ONC-Cures-Act-mandated EHI Export Specification this knowledge graph is built from. Their absence here is consistent with the canonical measure report's own framing, not new information about whether they're accessible; whether a given site has Signal/UAL licensed and exportable is a licensing and contracting question, not something a schema search can resolve. This is the same kind of open question the report already carries under "does this customer have Epic Signal/UAL licensed" and it stays open after this pass.

---

## Method

1. Ran the same keyword and table-name sweep methodology as the CM-04/CM-21/CM-22 passes, targeted at after-hours/audit-log/user-activity concepts (see the negative result above).
2. Rather than stop at a null result, reused CM-04's **already-established** note-timestamp candidates (`HNO_INFO`, `NOTE_ENC_INFO`, `NOTES_HISTORY_LOG`, `NOTE_EDIT_TRAIL`, and related tables — see the [CM-04 pass](./CM-04-Epic-EHI-Field-Candidates.md)) as a second-best candidate set: the same physical fields, but bucketed by hour-of-day/day-of-week instead of summed into elapsed-duration figures. This is a genuinely different use of the data than CM-04's, not a duplicate ask.
3. Checked the provider/schedule table (`CLARITY_SER`) that came up empty in the CM-22 pass, since CM-05's Gold Standard definition also needs per-provider/per-specialty scheduled working hours (to avoid the generic 9-5 default the report flags as a source of misclassification for specialties with non-standard hours).

| Bucket | Tables | Columns |
|---|---:|---:|
| Reused CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week) | ~76 (subset of the CM-04 pass) | 134 |
| Provider record (schedule/FTE — exploratory) | 1 | 3 |

---

## Headline findings

### 1. No `after_hours_min`-equivalent field exists in the public EHI export — this is a licensing question, not a field-discovery one
See above. If Signal/UAL access can be confirmed and licensed at a site, that access supersedes everything else in this document for CM-05 — it's a materially better data source than any workaround below. Worth resolving this specific question (with whoever owns the customer relationship) before investing further in the fallback approach in finding #2.

### 2. A fallback exists, but it's structurally different from the discouraged "Suki session proxy" and should be framed carefully
The canonical measure report explicitly discourages using **Suki's own session timing** as a CM-05 proxy, because it would systematically undercount (chart review, order entry, and non-Suki-assisted note editing are all invisible to Suki). That caution does not apply to the note-timestamp fields already validated for CM-04 (`HNO_INFO.CREATE_INSTANT_DTTM`/`LST_FILED_INST_DTTM`, `NOTE_ENC_INFO.ENTRY_INSTANT_DTTM`, etc.) — those are **EHR-native** timestamps, not Suki-native ones. Bucketing them by hour-of-day/day-of-week to flag after-hours documentation activity is a legitimate, if imperfect, EHR-side proxy: it captures documentation-specific after-hours work (which overlaps with, but is narrower than, the full inbox/chart-review/order-entry activity `after_hours_min` would capture). Whether this proxy is worth pursuing depends entirely on finding #1 — if Signal/UAL access is confirmed, this fallback is unnecessary; if it isn't, this is the best EHR-native signal currently identified.

### 3. Provider scheduled-hours field — same negative result as the CM-22 pass
`CLARITY_SER` (the provider/serial master file) doesn't carry a scheduled-hours or FTE field in the public export spec, consistent with what the CM-22 field-candidates pass already found when checking for the analogous "scheduled clinical hours" requirement. Treat as the same open question in both places rather than two separate gaps — flag once, resolve once.

---

## Caveats

- This pass intentionally does **not** attempt to work around the Signal/UAL gap by proposing the discouraged Suki-session proxy — see the canonical measure report's explicit warning against that approach.
- The note-timestamp fallback in finding #2 has not been checked for after-hours-specific fill rates — the density figures already gathered for CM-04 cover overall coverage, not a time-of-day breakdown. That would need to be a distinct query if this fallback is pursued.
- Table-name and keyword sweeps only — same limitation as the other passes. If Signal/UAL turns out to be licensed and its export schema isn't in this knowledge graph (likely, since it's a separate product), that would need a separate schema source entirely, not a wider sweep of this one.
- Longer-term, out of scope for this pass: whether Signal/UAL licensing status, or the note-timestamp fallback's viability, differs at South Carolina's Epic implementation.

---

*Generated 2026-08-20 from `epic-ehi-kg` (May 2026 EHI release) as part of Sprint 2 feasibility prep. Sweep script available on request.*
