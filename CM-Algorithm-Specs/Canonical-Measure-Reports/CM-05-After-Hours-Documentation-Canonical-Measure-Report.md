# CM-05 After-Hours Documentation
## Canonical Measure Report — Internal Draft

**Measures covered:** CM-05 After-Hours Documentation (primary); boundary with CM-04 (Documentation Time) and CM-01 (Burnout)
**Status:** Internal draft for review and editing before sharing externally — **see "Why This Is a Trap for Primary Outcomes" before scoping any evaluation around this measure**

---

## What This Measure Captures

**CM-05 After-Hours Documentation** ("pajama time," "Work Outside Work") is clinician time spent on clinical documentation outside scheduled working hours — minutes per provider per month, lower is better. It is distinct from CM-04 (Documentation Time) because it captures **work-life boundary effects specifically**: a provider could have unchanged total documentation time (CM-04) but shift more or less of it into evenings/weekends (CM-05), and these would tell different stories.

This is one of the most clinically meaningful outcomes in the corpus — it directly affects physician wellbeing and is the EHR-telemetry counterpart to the "pajama time" item in CM-01's survey instruments (PFI, Mini-Z).

---

## Why This Is a Trap for Primary Outcomes

This section comes first because, per the hook-measure matrix's explicit strategic note: **"CM-05 (after-hours documentation) is a trap. It's widely cited by Suki marketing (−6 hrs/week) but the objective data is inconsistent. Exclude from primary outcomes in any credible evaluation."**

**The evidence pattern:**
- **Self-report shows improvement.** This is where marketing-cited numbers (e.g., "−6 hrs/week") come from.
- **Objective EHR telemetry shows a consistent null pattern across most corpus papers** (Pearlman 2025, Stults 2025) — after-hours time does **not** improve significantly.
- **Exceptions exist but are fragile:** Duggan 2025 (−16.9%), Boyter/KLAS 2025 (−39% UAL) show improvement, but Afshar 2025b's −0.50 hrs/day result **disappears after removing the top 3% of outlier users** — meaning a small number of very-high-after-hours-time clinicians are driving the entire effect.
- **One genuinely strong objective signal exists:** Tierney 2025 (the largest real-world dataset in the corpus, 2.5M sessions) found a difference-in-differences reduction in pajama time of −1.03 min (p=0.02) and a reduction in time outside 7am–7pm of −1.83 min (p<0.001). This is small in absolute terms but statistically robust at scale.

**Consequences for evaluation:**
- If CM-05 is reported at all, it should be a **secondary outcome with explicit outlier-sensitivity reporting** (e.g., report both the full-sample and outlier-trimmed effect, as the Afshar 2025b fragility makes clear this matters).
- **Do not use Suki-native session timing as a proxy** for this measure — the algorithm card's "Suki Data Scope" box is explicit that this would *systematically undercount* after-hours time (see below).
- Any external communication citing a large after-hours reduction should be checked against whether it is self-reported or EHR-telemetry-based, given the 3-6x self-report inflation pattern seen across CM-04/CM-05/CM-01.

---

## Current Suki Hooks and Data Available

### What Suki exposes natively (H1)

| Artifact | API endpoint | What it enables |
|---|---|---|
| Session creation timestamps | `GET /session/{id}/status` (aggregated) | Each provider's Suki adoption date — the pre/post boundary for the cohort comparison, per the algorithm card's formula |
| Session timestamps outside business hours | `GET /session/{id}/transcript` / status | Could flag *that a Suki session occurred* outside business hours — but see below for why this is not the same as the measure |

### Measurement supported right now

- **Adoption-date / pre-post boundary only.** Per the algorithm card's "Suki Data Scope" box: **"Suki's contribution to this measure is the adoption boundary, not the documentation signal."** Suki session timing indicates when a dictation/ambient-capture session was *initiated*, not total EHR documentation time, and using it as a proxy would systematically undercount — chart review, note editing, and order entry outside any Suki session are invisible to Suki, and note signing happens in the EHR.
- **Cohort definition** — heavy/moderate/light utilization tiers, as elsewhere, useful for the dose-response framing if CM-05 is reported as a secondary outcome.

---

## Missing or Aspirational Hooks

| Missing capability | Why it matters |
|---|---|
| **Any visibility into EHR activity outside Suki sessions** | This is not really a "hook" Suki could plausibly add — after-hours EHR activity (inbox, chart review, order entry, note editing) that doesn't involve ambient capture is structurally outside what Suki observes. Listed here mainly to be explicit that this is a permanent, not temporary, gap for Suki-native data. |
| **Provider working-hours/schedule data** | Needed to apply the algorithm card's "Gold Standard" definition (per-provider/per-specialty scheduled hours) rather than the generic 9-5 default, which over-counts after-hours time for specialties with non-standard hours (e.g., surgeons 09:00–21:00) |

---

## EHR-Side Data Needed

EHR audit-log data is **authoritative** for this measure — more so than for almost any other canonical measure, given that the Suki-native fallback is explicitly discouraged.

| Data element | Purpose | Vendor examples / Notes |
|---|---|---|
| `after_hours_min` (per provider, per month) | The primary and only credible data source for CM-05 | Epic Signal / UAL `after_hours_min` or equivalent |
| Per-provider/per-specialty scheduled working hours | Defines the after-hours boundary correctly (Gold Standard); without it, a generic 9-5 default is used, which the algorithm card flags as a source of systematic misclassification | EHR scheduling/HR system export |
| Outlier-sensitivity breakdown (e.g., top 3% by after-hours time) | Required given the Afshar 2025b fragility finding — any reported effect should be checked for outlier-driven results | Derived from the same `after_hours_min` data |

Without EHR audit-log data, **CM-05 cannot be credibly measured at all** — this is one of the few canonical measures where Suki-native data provides essentially nothing beyond cohort/adoption-date definition, and where that limitation should be stated plainly rather than worked around with a proxy.

---

## The Self-Report vs. Objective Divergence

This is the central structural issue for CM-05 — not a missing data link, but a **methodological trap** that has already caught prior reporting (per the "marketing-cited −6 hrs/week" framing above).

```
Clinician self-report ("how much less do you work at home?")  ──►  Large reported improvement
                                                                              │
                                                              [DIVERGENCE — not a data gap,
                                                               a measurement-validity gap]
                                                                              │
EHR audit-log after_hours_min (objective)  ──►  Null or small, outlier-sensitive improvement
```

**What is achievable today:** Suki can report self-reported impressions (if collected via survey, per CM-01/02/03's survey-distribution gap) — but these are exactly the numbers the corpus warns are 3-6× inflated.

**What is missing:** EHR audit-log `after_hours_min` data, which is the only objective signal, and even that signal is small and outlier-sensitive in most studies (the Tierney 2025 exception being the strongest because of its scale, n=2.5M sessions).

**Implication for reporting:** any CM-05 number sourced from self-report should be labeled as such and never presented alongside or in place of an EHR-telemetry figure. If EHR telemetry is unavailable, the honest framing is "CM-05 cannot be measured for this deployment" rather than substituting a self-report or Suki-session proxy.

---

## Open Questions for Suki

1. Given that the algorithm card explicitly discourages using Suki session timing as a CM-05 proxy, is there any partial signal Suki could responsibly provide (e.g., flagging that ambient-capture sessions occurred outside business hours) that would be useful as a *qualifying* indicator without being presented as the measure itself?
2. Does Suki have access to, or visibility into, provider scheduling data from any EHR integration that could support the "Gold Standard" per-provider working-hours definition?
3. For sites where `after_hours_min` EHR telemetry is available, would Suki's team be willing to report both the full-sample and outlier-trimmed (e.g., excluding top 3% by after-hours time) effect, given the Afshar 2025b fragility finding?
4. Does Suki have any aggregate self-reported "time saved at home" data from prior pilots, and if so, can it be paired with EHR telemetry from the same sites to characterize Suki's own self-report/objective gap (rather than relying on the general corpus pattern)?
5. Is there appetite to proactively frame CM-05 as a secondary/contextual measure in external materials, given the strategic guidance that it should be excluded from primary outcomes?

---

*CM-05 After-Hours Documentation | Canonical Measures | Individual Impact dimension*
*Internal draft — June 2026*
