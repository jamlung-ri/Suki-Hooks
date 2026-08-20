# Suki Hooks

Algorithm specification cards and review tooling for the Suki AI ambient documentation evaluation — a collaboration between Regenstrief Institute / Indiana University and Suki AI.

Each Canonical Measure (CM) algorithm card defines the unit(s), dashboard formula, expected trend, and data requirements for a given measure so that organizations can implement them accurately and consistently.

---

## GitLab Pages

### Algorithm Cards

| Page | Description |
|---|---|
| [CM Algorithm Cards — Combined](https://jamlung.gitlab.io/Suki-Hooks/CM-Algorithm-Specs/CM-Algorithm-Cards-Combined.html) | All six CM cards in one scrollable document with sticky navigation — start here |
| [CM-04 · Documentation Time](https://jamlung.gitlab.io/Suki-Hooks/CM-Algorithm-Specs/CM-04-Documentation-Time.html) | Minutes per encounter; EHR audit-log gold standard, Suki session timestamps as native fallback |
| [CM-05 · After-Hours Documentation](https://jamlung.gitlab.io/Suki-Hooks/CM-Algorithm-Specs/CM-05-After-Hours-Documentation.html) | After-hours minutes per provider per month (Pajama Time) |
| [CM-07 · Total EHR Time](https://jamlung.gitlab.io/Suki-Hooks/CM-Algorithm-Specs/CM-07-Total-EHR-Time.html) | Total EHR minutes per encounter across all task types |
| [CM-20 · Financial Productivity](https://jamlung.gitlab.io/Suki-Hooks/CM-Algorithm-Specs/CM-20-Financial-Productivity.html) | Three operationalizations: wRVUs, paid revenue, E/M Level 4–5 share |
| [CM-21 · Coding Accuracy](https://jamlung.gitlab.io/Suki-Hooks/CM-Algorithm-Specs/CM-21-Coding-Accuracy.html) | Three operationalizations: ICD-10 coding depth, Suki suggestion match rate, denial rate |
| [CM-22 · Patient Volume & Throughput](https://jamlung.gitlab.io/Suki-Hooks/CM-Algorithm-Specs/CM-22-Patient-Volume.html) | Completed encounters per provider per week |

### Reference & Tooling

| Page | Description |
|---|---|
| [EHR / Suki Data Crosswalk](https://jamlung.gitlab.io/Suki-Hooks/CM-Algorithm-Specs/Measures_suki_ehr_crosswalk.html) | Maps each CM to EHR vendor fields (Epic, Cerner, Athena) and Suki data availability |
| [Algorithm Card Template](https://jamlung.gitlab.io/Suki-Hooks/CM-Algorithm-Specs/CM-Algorithm-Card-Template.html) | Blank template for authoring new CM algorithm cards |

---

## Repository Structure

```
CM-Algorithm-Specs/                    # Published site (GitHub Pages + GitLab Pages) — do not rename this path
  index.html                           # Landing page
  CM-Algorithm-Cards-Combined.html     # All 25 CM cards combined — primary reference
  CM-01-*.html … CM-25-*.html          # Individual algorithm cards
  CM-Algorithm-Card-Template.html      # Blank template for new cards
  Measures_suki_ehr_crosswalk.html     # EHR / Suki data crosswalk (interactive)
  Suki-Sprint-2-Proposal.html          # Sprint 2 proposal (5 Epic-sourced measures)
  build.py                             # Combines individual CM files into the Combined HTML
  build_sprint2_proposal.py            # Builds the Sprint 2 proposal from the Epic-sourced subset
  assets/                              # Images used by the published cards
  Canonical-Measure-Reports/           # Not published/linked from the site — internal working detail per measure
    Reports/                           #   CM-XX-...-Canonical-Measure-Report.md (narrative writeups + template)
    Epic-EHI-Field-Candidates/         #   CM-XX-Epic-EHI-Field-Candidates.md/.csv (EHI schema sweep results)
    Field-Feasibility-Queries/         #   CM-XX-Field-Feasibility-Queries.md/.sql + shared README
  _archive/                            # Earlier working documents and specs

Hook-Deep-Dives/                       # H1/H3/H9 "Suki hook" deep-dive writeups + measure matrix
Reference-Material/                    # Input/background material, not deliverables
  Suki-Developer-Docs/                 #   Crawled Suki API/SDK documentation
  Suki-Product-Info/                   #   Product/marketing background docs
  Vendors/                             #   EHR vendor field-mapping CSVs
Process-Notes/                         # Internal working notes
  Review-notes/                        #   Meeting notes and transcripts
  Presentations/                       #   Slide/presentation drafts

assets/, index.html                    # Root redirect page for GitLab Pages (see .gitlab-ci.yml)
```

## Authoring a New Algorithm Card

1. Copy `CM-Algorithm-Specs/CM-Algorithm-Card-Template.html` to `CM-Algorithm-Specs/CM-XX-[Short-Name].html`
2. Replace every `[PLACEHOLDER]` with measure-specific content (sections documented in HTML comments)
3. Add the new filename to the `CM_FILES` list in `build.py`
4. Run `build.py` to regenerate `CM-Algorithm-Cards-Combined.html`

```
python build.py
```
