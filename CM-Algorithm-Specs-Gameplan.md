# Gameplan: CM-21 & CM-22 Algorithm Specs
**Created:** 2026-05-06 | **Owner:** Joe Amlung  
**Purpose:** Deliver two canonical measure pseudo-specifications for Suki's internal data pipeline and admin console

---

## What We Are Building

Two measure algorithm specs — one financial (CM-21), one operational (CM-22) — each delivering:

1. **Measure name and concrete unit** — a dashboardable number (e.g., "% encounters where AI-suggested ICD-10 code matched final billed code")
2. **Data elements** — the discrete Suki and EHR inputs required, each defined
3. **Tiered ascertainment methods** — ranked options for how the measure can be computed, from best to fallback (see below)
4. **Pseudocode algorithm** — one per method tier; logic that combines data elements into the indicator
5. **Suki-specific tailoring note** — what is realistic given Suki's current hooks vs. aspirational

These are Suki's private IP. The specs tell Suki *what to aim for*; Amita's team figures out how to implement the query in the pipeline. We are not naming fields or writing SQL.

### Tiered Ascertainment Framework

Each spec should rank available methods by quality of evidence, using three tiers:

| Tier | Label | Description |
|---|---|---|
| 1 | **Realistic & Solid** ✓ | Our primary recommendation — rigorous enough to stand behind, achievable with Suki + EHR data that is reasonably obtainable. This is the tier Amita builds first. |
| 2 | **Aspirational / Ideal** | Best possible method if all data and conditions were available — e.g., validated instrument, prospective design, complete EHR linkage. Sets the ceiling we are working toward. |
| 3 | **Minimal / Fallback** | Lower-quality but still useful — e.g., physician survey, self-report, partial data. Documents that something is measurable even without ideal data; useful for customers with limited EHR sharing. |

The point is not to present all methods as equal — it's to show Suki the full landscape so they know what's possible, while being clear about which method is the target.

---

## Key Decisions Already Made

- **Assume EHR integration is available.** Don't design around Suki-only data; the pipeline assumes EHR data is accessible.
- **No CM-09 (Note Inaccuracy).** Suki's note quality processes are in flux. Deferred.
- **Goal is a dozen good measures, not 25.** These two specs are the proof of concept that unlocks the rest.
- **Depth is proportional to importance.** Operational/financial measures get the full algorithm treatment first.
- **Structure over perfect content.** A draft with clear structure that Suki can correct is more valuable than a polished document that misses the mark.

---

## Measures

### CM-21 — Coding Accuracy (Financial)
**What it is:** Accuracy and completeness of AI-supported ICD-10, HCC, and E/M codes  
**Why it's financial:** Directly drives revenue capture; HCC capture affects risk adjustment payments; E/M level affects per-visit reimbursement  
**Known data sources:**
- Suki: `GET /session/{id}/structured-data` — ICD-10/IMO codes generated from encounter
- EHR: Final billed ICD-10 codes, E/M CPT code, claim denial flag, HCC mapping table (ICD-10 → HCC v28)
- Benchmark: Holmgren 2026 (no increase in denial rate); Afshar 2025b (p<0.001 improvement); Boyter/KLAS (+$9,685/yr HCC, +$1,907/yr E/M)

**Tiered ascertainment methods:**

**Tier 1 — Realistic & Solid ✓ (ICD-10 match rate, data-driven)**
Primary unit: *% of encounters where Suki-suggested ICD-10 codes match final billed codes*
```
For each encounter e:
  suki_codes     = structured-data ICD-10 list from Suki session
  billed_codes   = final ICD-10 codes from EHR claim record
  match          = (suki_codes ∩ billed_codes) / billed_codes  [% overlap]

ICD_Accuracy_Rate = AVG(match) across all encounters in period
                    [filter: completed ambient sessions only; exclude dictation-only]
```
*Requires EHR claim data. Straightforward to compute once pipeline is linked.*

**Tier 2 — Aspirational / Ideal (expert coder audit)**
Unit: *% of encounters rated as correctly coded by certified coder review*
- Certified coders assess a sampled set of notes against ICD-10 + HCC + E/M standards
- Gold standard for accuracy; used in Afshar 2025b RCT
- Requires manual review labor; not scalable as a continuous operational metric
- Best for periodic validation studies, not the admin console

**Tier 3 — Minimal / Fallback (provider self-report)**
Unit: *% of providers reporting that Suki-suggested codes are accurate or mostly accurate*
- Survey question (e.g., 5-point Likert: "How often do Suki's suggested codes match what you bill?")
- No EHR data required; can be deployed even without pipeline linkage
- Low precision; subject to recall and response bias
- Useful for early-stage customers or as a sanity check alongside Tier 1

---

### CM-22 — Patient Volume and Throughput (Operational)
**What it is:** Change in patients seen per unit time — a downstream efficiency outcome of reduced documentation burden  
**Why it's operational:** Health systems directly track encounter volume; this links Suki adoption to capacity expansion  
**Known data sources:**
- Suki: Session timestamps (start/end of ambient session per provider per day); session count per provider
- EHR: Scheduled and completed encounter counts per provider per week, encounter datetime, specialty
- Benchmark: Holmgren 2026 (+0.80 encounters/week); Shuaib 2021 (+39% patients/hour, human scribe ED baseline)

**Tiered ascertainment methods:**

**Tier 1 — Realistic & Solid ✓ (encounters/week, data-driven pre/post)**
Primary unit: *Change in completed encounters per provider per week, pre vs. post Suki adoption*
```
For each provider p in period T:
  encounters_post = count of completed encounters where provider used Suki (session exists)
  encounters_pre  = count of completed encounters in matched pre-adoption period (same length)
  weeks_in_period = T / 7

Throughput_Delta = (encounters_post / weeks_in_period) - (encounters_pre / weeks_in_period)

Report as: AVG(Throughput_Delta) across providers
           [filter: providers with ≥ N Suki sessions in period; exclude onboarding ramp weeks;
            normalize for scheduled hours if part-time providers included]
```
*Requires EHR encounter data + Suki session linkage by provider. Pre-period definition to confirm with Amita.*

**Tier 2 — Aspirational / Ideal (controlled comparison with non-adopters)**
Unit: *Difference-in-differences: encounters/week for Suki adopters vs. matched non-adopters over same period*
- Controls for secular trends in volume (e.g., seasonal patterns, site-wide changes)
- Matches Holmgren 2026 methodology; most defensible for external reporting
- Requires a sufficient non-adopter comparison group at the same institution
- Best suited for Amita's quarterly business review analyses, not the real-time admin console

**Tier 3 — Minimal / Fallback (provider self-report)**
Unit: *% of providers reporting they can see more patients since adopting Suki*
- Single survey item (e.g., "Since using Suki, I am able to see more patients per day" — agree/disagree)
- Used in Albrecht 2025; no EHR data required
- Directional signal only; no magnitude or unit; cannot be trended on a dashboard
- Useful for customers without EHR data sharing or as a complement to Tier 1

---

---

## Pieces We're Working With (Katie Session Reference)

This is the full inventory of data elements available for CM-21 and CM-22. The goal is to have these laid out so we can conceptually rearrange them if the first draft algorithm isn't quite right — rather than trying to remember what's possible mid-conversation.

### Suki API — What Suki Exposes Natively

These are confirmed fields from Suki's published developer documentation.

| Piece | Source | Key Fields | Notes |
|---|---|---|---|
| **Session identity** | `POST /session/create` | `ambient_session_id`, `encounter_id` | Links Suki session to EHR encounter; `encounter_id` is optional at create time |
| **Session status** | `GET /session/{id}/status` | `status` (created / ready / running / completed / failed / aborted / skipped) | Use `completed` to filter valid sessions; `skipped` = silent recording, no note generated |
| **Transcript** | `GET /session/{id}/transcript` | `transcript` (text), `start_time`, `end_time`, `start_offset`, `end_offset`, `lang_id`, `transcript_id`, `recording_id` | Timestamps per transcript segment; `end_time - start_time` = session duration proxy |
| **Note content** | `GET /session/{id}/content` | `summary[].content`, `summary[].title`, `summary[].loinc_code`, `summary[].source_transcripts[]` | `source_transcripts[]` maps each note sentence back to the transcript phrases that generated it |
| **Structured diagnoses** | `GET /session/{id}/structured-data` | `structured_data.diagnoses.values[].codes[].code`, `.description`, `.type` (IMO/ICD-10), `.diagnosis_note`, `.laterality_indicator` | Suki's AI-generated diagnosis codes; code type field distinguishes IMO from ICD-10 |
| **Encounter-level diagnoses** | `GET /encounter/{id}/structured-data` | Same schema as session structured data | Cumulative view across all sessions in an encounter |
| **Audio recording** | `GET /session/{id}/recording` | `recordings[].recording_id`, `.presigned_url`, `.expires_at`, `.sequence_number`, `is_streamable` | Retained for a limited window; supports streaming or download |
| **Session completion event** | Webhook (`POST` to partner callback) | Fires on: session completed, failed, timed out, cancelled | Push notification; use for real-time pipeline triggers |

---

### EHR-Side Data — What Must Come from the Health System

These require EHR data sharing as part of Amita's pipeline. Availability varies by customer and EHR vendor.

**For CM-21 (Coding Accuracy):**

| Piece | What It Is | Why It Matters |
|---|---|---|
| Final billed ICD-10 codes | The diagnosis codes that actually appear on the claim, post-physician review | Ground truth for comparing against Suki's suggested codes |
| E/M CPT level | CPT code 99211–99215 assigned to the encounter | Measures whether Suki documentation supports higher-complexity billing |
| HCC mapping | ICD-10 → HCC v28 crosswalk (CMS published table) | Converts ICD codes to risk-adjustment categories; enables HCC capture rate |
| Claim denial flag | Whether the claim was denied by the payer | Proxy for coding quality; also key financial outcome |
| Claim denial reason code | Why the claim was denied | Separates coding-related denials from other denial types |
| Encounter-to-claim linkage | Join key connecting EHR encounter ID to the claim record | Needed to link Suki session → EHR encounter → claim |

**For CM-22 (Patient Volume and Throughput):**

| Piece | What It Is | Why It Matters |
|---|---|---|
| Completed encounter count | Number of completed patient encounters per provider per day/week | Core numerator for throughput |
| Scheduled encounter count | Number of scheduled slots per provider per day/week | Denominator for utilization; normalizes for panel size |
| Encounter start / end datetime | Clock time when encounter began and ended | Enables patients-per-hour and time-in-encounter calculations |
| Provider ID | Unique provider identifier, consistent across Suki and EHR | Join key for linking Suki sessions to EHR encounters by provider |
| Provider specialty | Clinical specialty (e.g., family medicine, surgery) | Enables specialty-level breakdowns on the admin console |
| Scheduled hours per provider | Part-time vs. full-time indicator | Normalizes throughput for providers with different clinical schedules |
| Pre-adoption period encounters | Encounter counts from before the provider's Suki go-live date | Baseline for pre/post comparison |

---

### Derived / Calculated Elements

Things computed from the pieces above — the "connective tissue" of the algorithm.

**For CM-21:**
- `icd_match_rate` = (Suki-suggested codes ∩ final billed codes) / final billed codes — per encounter
- `hcc_per_encounter` = count of unique HCCs mapped from final ICD-10 codes — per encounter
- `hcc_delta` = avg HCCs post-Suki minus avg HCCs pre-Suki — across providers
- `em_level_avg` = average E/M CPT level (1–5), case-mix normalized
- `denial_rate` = denied encounters / total encounters in period

**For CM-22:**
- `suki_adoption_flag` = provider has ≥ N completed Suki sessions in the measurement period
- `encounters_per_week_post` = completed encounters / weeks in post-adoption period
- `encounters_per_week_pre` = completed encounters / weeks in equivalent pre-adoption period
- `throughput_delta` = encounters_per_week_post − encounters_per_week_pre
- `encounters_per_hour` = completed encounters / scheduled clinical hours (alternative unit)

---

### Literature Benchmarks — Reference Points for Calibration

Useful for checking whether a calculated value "makes sense" and for framing Suki's results against published findings.

| Benchmark | Source | Value |
|---|---|---|
| ICD-10 coding improvement | Afshar 2025b (RCT) | Statistically significant (p<0.001); exact magnitude not published |
| HCC capture increase | Boyter/KLAS 2025 | +$9,685/provider/year |
| E/M level increase | Boyter/KLAS 2025 | +$1,907/provider/year |
| Claim denial rate change | Holmgren 2026 | No increase (null finding — reassuring) |
| ICD accuracy baseline (pre-AI) | Suki ROI draft | ~35% ML baseline; goal >90% |
| Encounters/week increase | Holmgren 2026 | +0.80 encounters/week (statistically significant) |
| Patients/hour increase | Shuaib 2021 (human scribe, ED) | +39% — upper bound comparator, not ambient AI |

---

## Steps and Timeline

| Step | Owner | When | Output |
|---|---|---|---|
| Joe preps draft data elements + algorithm sketches for both CMs | Joe | By end of week (May 8) | Working draft — rough pseudocode, candidate units, known gaps |
| Joe + Katie working session | Joe + Katie | Monday May 11, 1pm | Stress-tested algorithms; Katie flags method issues; decide on primary flavor for each |
| Full team review | All | Wednesday May 14 | Alignment on final structure; decide what to send to Suki |
| Send CM-21 + CM-22 specs to Amita and Sudha | Joe or Jamie | Wed May 14 EOD or Thu May 15 | Suki feedback round begins |
| Suki feedback received | Amita / Sudha | By Fri May 15–May 22 | Corrections to data availability, internal process changes |
| Revise and finalize | Joe | Following week | First finalized algorithm specs ready to replicate across other CMs |

*Note: Paul may be at IUB Labs on Wednesday May 14 — Joe to lead team review if needed.*

---

## What to Prepare Before the Katie Session

- **For CM-21:** Pull the `structured-data` endpoint schema from Suki dev docs. List the exact fields returned (code type, code value, confidence, source). Identify what's missing to compute match rate against billed codes.
- **For CM-22:** Confirm what Suki session timestamps are available (session start, session end, encounter linkage). Identify the EHR-side encounter count field Amita's team uses in their pipeline.
- **Both:** Bring the draft tier structure above and ask Katie to (a) confirm the Tier 1 method is sound, (b) refine or replace the pseudocode, and (c) flag whether the Tier 2 aspirational method is realistic enough to include or too far out of reach to be useful.
- **Both:** Have a back-of-envelope example number ready for Tier 1 so the algorithm feels concrete, not abstract (e.g., "if a provider has 100 encounters and 82 ICD-10 codes match, that's an 82% accuracy rate — does that formula make sense?").
- **Both:** Confirm the Tier 3 fallback — what survey question wording is methodologically defensible if a customer can't share EHR data at all?

---

## Open Questions (to resolve during working session or with Suki)

1. For CM-21: Should ICD-10 accuracy be measured as exact-match or as a hierarchical match (parent code counts as match for child)?
2. For CM-21: Do we lead with ICD-10 accuracy, HCC capture, or E/M level as the primary indicator? Or offer all three as a suite?
3. For CM-22: Is encounters/week the right unit for ambulatory, or should it be encounters/scheduled-hour to normalize for part-time providers?
4. For both: What is the standard "pre-Suki baseline" window Amita's team uses? (e.g., same period prior year, or N weeks before go-live?)
5. For both: Suki's pipeline is still being stood up — which customers are already feeding EHR data? Should the spec flag a "Suki-only" fallback?

---

## What Success Looks Like

Amita reads the spec and can hand the algorithm directly to her data engineer with enough definition to write the pipeline query. She should not need to ask us what we meant. Anant should then be able to pull the output measure into the admin console with a name and a number.
