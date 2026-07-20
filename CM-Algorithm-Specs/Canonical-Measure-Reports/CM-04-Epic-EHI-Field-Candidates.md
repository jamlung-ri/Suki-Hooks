# CM-04 Documentation Time — Epic EHI Field Candidates (Exhaustive Pass)

**Status:** Smoke test for the query method, run 2026-07-20 per Suki Weekly Huddle action item ([issue #186](https://github.com/jamlung-ri/amlung-task-management/issues/186)).
**Scope:** Documentation-time only (CM-04) — not run against the full measure set.
**Source:** [`epic-ehi-kg`](https://github.com/) — Paul's Epic EHI Export Specification knowledge graph (7,797 tables / 63,956 columns, May 2026 release, `su118s2p`).
**Companion data file:** [`CM-04-Epic-EHI-Field-Candidates.csv`](./CM-04-Epic-EHI-Field-Candidates.csv) (1,022 rows — full table/column detail for the density pass).

---

## Why this run exists

The three fields currently on the [CM-04 algorithm card](../CM-04-Documentation-Time.html) (`NOTES_HISTORY_LOG`, `HNO_INFO`, `PAT_ENC`) validated as *existing* in Eskenazi's Epic build via the EHI knowledge graph, but real-world coverage is very low — `NOTES_HISTORY_LOG` fills in roughly **0.1%** of encounters. Rather than continue refining that narrow, precise field set, Paul asked for the opposite move: **be exhaustive, not precise.** List every Epic field that could plausibly relate to documentation time, hand the full list to Evgenia, and let her per-field information-density query (against the real Eskenazi EHI extract) do the precision filtering that a schema-only query can't do. Whatever has usable density becomes the actual algorithm input; the rest gets dropped.

**This is schema-only reconnaissance.** The knowledge graph documents that a column *exists* in Epic's export spec — it says nothing about whether Eskenazi's build actually populates it. That determination is Evgenia's next step, not this one.

---

## Real density baseline already in hand (Evgenia, Jul 10–15 2026 thread)

Before this exhaustive pass, Evgenia had already run SAS fill-rate queries against the real Eskenazi extract for the three known fields — that thread (`Review-notes/Evgenia-reply-20Jul2026.pdf`) is the direct source of the "~0.1%" figure in the issue, and it changes how a couple of the new candidates below should be read:

| Table | Column | Fill rate | Note |
|---|---|---:|---|
| `HNO_INFO` | total rows | 456,054,802 | |
| `HNO_INFO` | `PAT_ENC_CSN_ID` | 52,163,178 (**11.4%**) | encounter link |
| `HNO_INFO` | `CREATE_INSTANT_DTTM` | 46,371,299 (**10.2%**) | |
| `HNO_INFO` | `LST_FILED_INST_DTTM` | 45,932,660 (**10.1%**) | |
| `HNO_INFO` | `ENTRY_USER_ID` | 336,236,482 (**73.7%**) | |
| `NOTES_HISTORY_LOG` | distinct `NOTE_ID` vs. `HNO_INFO` total | 405,367 / 455,233,162 (**0.09%**) | matches issue's "~0.1%"; own columns (`EDIT_HX_INSTANT`, `CONTACT_DATE`) are 100% filled *within* the table, the problem is coverage, not nulls |
| `NOTES_HISTORY_LOG` → `NOTE_ENC_INFO` join (`NOTE_CSN_ID = CONTACT_SERIAL_NUM`) | `PAT_ENC_CSN_ID` | still missing after join | confirmed a real gap, not a join bug |
| `NOTE_ENC_INFO` | total rows | 502,256,244 | ~1.1 rows/note (revisions) |
| `NOTE_ENC_INFO` | `PAT_ENC_CSN_ID` | 2,767,085 (**0.55%**) | encounter link — worse than `HNO_INFO`'s |
| `NOTE_ENC_INFO` | `ENTRY_INSTANT_DTTM` | 98,452,478 (**19.6%**) | better than `HNO_INFO`'s create instant |
| `NOTE_ENC_INFO` | `NOTE_FILE_TIME_DTTM` | 58,255,551 (**11.6%**) | |
| `NOTE_ENC_INFO` | `UPD_AUTHOR_INS_DTTM` | 62,134,056 (**12.4%**) | |
| `NOTE_ENC_INFO` | `ACTIVITY_DTTM` | 9,947,225 (**2.0%**) | |

**Implication for finding #1 below:** `NOTE_ENC_INFO`'s timestamp columns are meaningfully denser than `HNO_INFO`'s (19.6% vs. 10.2% on the create/entry instant) — Evgenia's Jul 10 email calling it "all dates missing" undersold it; the Jul 15 recheck shows real, if partial, fill. But its own `PAT_ENC_CSN_ID` is far worse (0.55%) than `HNO_INFO`'s (11.4%), so joining straight from `NOTE_ENC_INFO` to the encounter table loses most rows. Since `NOTE_ID` is ~100%-filled on both tables (`NOTE_ENC_INFO` total rows = `HNO_INFO` distinct note count), **joining `HNO_INFO.PAT_ENC_CSN_ID` to `NOTE_ENC_INFO` via `NOTE_ID`** (rather than going through `NOTE_ENC_INFO.PAT_ENC_CSN_ID` directly) combines `HNO_INFO`'s better encounter linkage with `NOTE_ENC_INFO`'s better timestamp density — worth Evgenia testing as an explicit next query, separate from the new candidates below.

---

## Method

1. Matched **table names** (not descriptions — a bare-word search on descriptions across 64k columns floods with noise; an early pass using unqualified terms like `edit`, `sign`, `author`, `hx` returned 16,415 hits before this was tightened) against note/documentation-entity patterns: `HNO_*`, `NOTE*`, `*DOCUMENT*`, `*ADDENDUM*`, `*DICTAT*`, `*TRANSCRI*`, `SMRTDTA*`/`SMARTTEXT*`/`SMARTFORM*`, `*COSIGN*`, `*ATTESTAT*`, `*CHART_CLOS*`, `*SCRIBE*`, `*AMBIENT*`, `*HOLOGRAM*`.
2. **170 tables** matched. Every column in those tables was pulled (1,022 rows) and tagged with: bucket (below), data type, org-specific flag, discontinued flag, and whether it's date/time-typed (the actual numerator/denominator candidates — 134 columns across 76 tables).
3. Tables were bucketed by name pattern so Evgenia can triage by relevance without re-deriving it:

| Bucket | Tables | Columns | Time-typed |
|---|---:|---:|---:|
| Core note lifecycle | 46 | 348 | most of the 134 |
| Administrative/non-clinical (billing, coverage, referral, prior-auth comment fields) | 42 | 220 | low |
| Smart-tool usage (SmartText/SmartForm/SmartBlock) | 43 | 175 | low |
| Ambient/AI-scribe (Epic-native) | 8 | 119 | some |
| Other note/document-adjacent | 18 | 94 | some |
| Signature/cosign/attestation | 6 | 29 | most |
| Addendum | 5 | 28 | some |
| Dictation/transcription | 2 | 9 | most |

The **administrative bucket is included for completeness but is expected to be near-zero relevance** — these are comment/memo fields on billing, coverage, and referral records, not clinical note authoring. Flagged rather than dropped, per "exhaustive not precise."

---

## Headline findings — new candidates worth prioritizing in the density check

These surfaced from the exhaustive pass and are **not** on the current CM-04 card. Ranked by how directly they bear on documentation time:

### 1. `NOTE_ENC_INFO` — richest single table found, 18 time-typed columns
Extends the note-contact model `HNO_INFO` only partially covers. Includes `ENTRY_INSTANT_DTTM`, `NOTE_FILE_TIME_DTTM`, `UPD_BY_AUTH_DTTM`, `COSIGN_INSTANT_DTTM`, `TRANSCRIPTION_DTTM`, `ACTIVITY_DTTM` ("activity date and time of the partial dictation/transcription"), plus UTC/local pairs for most of the above. **Already partially checked** — see the density baseline above: its timestamps beat `HNO_INFO`'s (19.6% vs. 10.2%), but its own encounter-ID join field is far sparser (0.55% vs. 11.4%). The fix is joining via `NOTE_ID` from `HNO_INFO` rather than using `NOTE_ENC_INFO.PAT_ENC_CSN_ID` directly — not yet tested. The other 14 time-typed columns here (cosign, file-time, transcription, treatment-summary instants) haven't been density-checked at all yet.

### 2. `NOTE_EDIT_TRAIL` — a second, structurally simpler edit-event log
`IP_ACTION_DTTM` / `ACT_TAKEN_INST_DTTM` per line, one row per action taken on a note. This is the direct sibling of `NOTES_HISTORY_LOG` for the same sessionization approach (Tier 1 on the current card) — worth checking whether it has denser event logging than `NOTES_HISTORY_LOG`'s near-zero fill rate.

### 3. `NOTES_TRANS_AUTH` — explicit dictation/transcription timing table
`DICTATION_TIME`, `TRANSCRIPTION_TIME`, `AUTH_DTTM`, `ACTIVITY_DTTM`, `EDIT_DTTM`. This is a transcription-workflow table (traditional dictation-to-transcriptionist pipeline), structurally the closest thing in Epic's own schema to what Suki's session model measures — worth checking even though it may reflect a legacy dictation workflow rather than direct-entry authoring.

### 4. `PAT_ENC_AMBIENT_SESSIONS` + `NOTE_AMBIENT_SECTIONS` — Epic's native ambient-scribe linkage
`AMBIENT_SESSION_IDENT` on both tables ties an encounter/note to Epic's own ambient-documentation session ID ("Points to DXR"). **No duration field is exported here** — the EHI spec only exposes the session identifier, not start/end timestamps — but this is strategically important beyond CM-04: it's the join key that would let Suki-adoption analysis identify (and exclude, or separately track) encounters where a *competing* ambient scribe was used instead of Suki. Worth flagging to Paul directly, not just to Evgenia's density pass.

### 5. `PAT_ADDENDUM_INFO` — addendum start→finish as a native duration pair
`ADDENDUM_STARTED_UTC_DTTM` and `ADDENDUM_DATE_TIME` (completion) bound a discrete addendum-authoring interval — this is a duration Epic hands you directly rather than one you have to sessionize from an edit log. Narrow (addenda are a minority of note activity) but clean if populated.

### 6. `HNO_INFO` itself has more unused columns than the card currently lists
`DELETE_INSTANT_DTTM`, `DATE_OF_SERVIC_DTTM`, `UPDATE_DATE`, `CRT_INST_LOCAL_DTTM`, `COMMENT_EDIT_INST_DTTM` are all on the same table already in use — cheap to add to the density check since no new join is required.

---

## Caveats

- Reference/join edges from the KG were **not** used to further expand this list (e.g., walking `PAT_ENC` outward) — the sweep is table-name-driven only. If density comes back thin across the board, a join-graph expansion from `HNO_INFO`/`NOTE_ENC_INFO`/`PAT_ENC` is the natural next widening.
- `INCOMPLETE_NOTE_EPT` appeared in the raw sweep but its own description says it's been unused since 2010 and is "exported as a formality" — included in the CSV for completeness, not recommended for the density check.
- All Epic table/column names and structure below are the **public EHI Export Specification** (ONC Cures Act mandated documentation), not proprietary. Per-column descriptions are Epic's own text (see the `epic-ehi-kg` repo README for redistribution notes if this goes external).
- Longer-term, out of scope for this pass per the issue: once density is known for Eskenazi, check whether the same fields translate to South Carolina's Epic implementation.
- The density baseline above comes from an internal email thread (`Review-notes/Evgenia-reply-20Jul2026.pdf`, marked confidential/privileged) already sitting in this repo — referenced here as internal project context, not reproduced or distributed further.

---

*Generated 2026-07-20 from `epic-ehi-kg` (May 2026 EHI release) for issue #186. Raw query script and full 1,022-row output available on request.*
