# Suki Hooks

Algorithm specification cards and review tooling for the Suki AI ambient documentation evaluation — a collaboration between Regenstrief Institute / Indiana University and Suki AI.

Each Canonical Measure (CM) algorithm card defines the unit(s), dashboard formula, expected trend, and data requirements for a given measure so that organizations can implement them accurately and consistently.

---

## GitLab Pages

| Page | Description |
|---|---|
| [CM Algorithm Review Workspace](https://jamlung.gitlab.io/Suki-Hooks/CM-Algorithm-Specs/CM-Algorithm-Review-Workspace.html) | Interactive workspace for reviewing and validating CM algorithm specs (CM-20, CM-21, CM-22) |
| [CM-05 · After-Hours Documentation](https://jamlung.gitlab.io/Suki-Hooks/CM-Algorithm-Specs/CM-05-After-Hours-Documentation.html) | Algorithm card — unit definition, dashboard formula, expected trend, and data requirements for after-hours documentation time |
| [CM Measure Report](https://jamlung.gitlab.io/Suki-Hooks/CM-Algorithm-Specs/CM-Measure-Report.html) | Printable data requirements report for CM-20 and CM-21 (for Suki data/analytics team) |
| [EHR / Suki Data Crosswalk](https://jamlung.gitlab.io/Suki-Hooks/CM-Algorithm-Specs/Measures_suki_ehr_crosswalk.html) | Maps each canonical measure to EHR vendor fields (Epic, Cerner, Athena) and available Suki data |
| [Algorithm Card Template](https://jamlung.gitlab.io/Suki-Hooks/CM-Algorithm-Specs/CM-Algorithm-Card-Template.html) | Blank template for authoring new CM algorithm cards |

---

## Repository Structure

```
CM-Algorithm-Specs/
  CM-05-After-Hours-Documentation.html   # Algorithm card — CM-05
  CM-Algorithm-Card-Template.html        # Template for new algorithm cards
  CM-Algorithm-Review-Workspace.html     # Interactive review workspace (CM-20, 21, 22)
  CM-Measure-Report.html                 # Printable data requirements report
  Measures_suki_ehr_crosswalk.html       # EHR / Suki data crosswalk
  CM-20-Financial-Productivity-Revenue-Algorithm-Spec.md
  CM-21-Coding-Accuracy-Algorithm-Spec.md
  CM-22-Patient-Volume-Throughput-Algorithm-Spec.md
  CM-Algorithm-Specs-Gameplan.md
  CM-Data-Crosswalk.md
Review-notes/                            # Working session notes and transcripts
```

## Authoring a New Algorithm Card

Copy `CM-Algorithm-Specs/CM-Algorithm-Card-Template.html` to `CM-Algorithm-Specs/CM-XX-[Short-Name].html` and replace every `[PLACEHOLDER]` with measure-specific content. Required sections are documented in the template's HTML comments.
