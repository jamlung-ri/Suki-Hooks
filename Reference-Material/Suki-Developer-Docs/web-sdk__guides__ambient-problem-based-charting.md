# Problem-Based Charting and Existing Patient Diagnoses - Suki

**Source URL:** https://developer.suki.ai/web-sdk/guides/ambient-problem-based-charting

---

Sukihome page
Documentation
APIs
Release Notes
Sukihome page


##### Web SDK Overview

- Introduction
- Quickstart
- Prerequisites
- Installation
- Migration to v2 v2
- Changelog


##### Web SDK Guides

- Ambient Session Ambient Session Overview Implementation UPDATED Session Status PBC UPDATED Multilingual Offline Re-Ambient & Recovery
- Note Management
- Error Handling
- Token Refresh
- Telehealth
- Branding


##### API Reference

- Types
- Classes
- Functions
- Hooks
- Providers
- Components


##### Examples

- Basic Usage
- Control Visibility
- Dynamic Encounter
- Ambient Events
- Test Mode
- Using the SDK Inside an Iframe
- Advanced Configuration
- Theming and Customization


##### FAQs

- Automatic User Onboarding
- General
- Technical
- Implementation

**Updated**
The
`diagnoses`
block in
`ambientOptions`
is supported in the Web SDK
`v2.1.2`
. Pass the patient’s existing diagnoses (e.g. from the EMR) so the session merges them with what’s discussed in the visit. Refer to the
Existing patient diagnoses
guide for more details.
Problem-Based Charting (PBC) organizes clinical notes by patient problems instead of traditional note sections. To enable it in the Web SDK, mark one section as the Problem-Based Note (PBN) by setting
`isPBNSection: true`
on that section in
`ambientOptions`
(using the section’s
LOINC code
).

## ​Implementation

- JavaScript
- React

JavaScript

```
sdkClient.mount({
  rootElement: document.getElementById("suki-root"),
  encounter: encounterDetails,
  ambientOptions: {
    sections: [
      { loinc: "51848-0", isPBNSection: true }, // Assessment and Plan as PBN
      { loinc: "11450-4" },
      { loinc: "29545-1" },
    ],
    diagnoses: { // New in v2.1.2
      values: [
        {
          codes: [
            {
              code: "I10",
              description: "Essential hypertension",
              type: "ICD-10",
            },
          ],
          diagnosisNote: "Hypertension",
        },
      ],
    },
  },
});
```

React

```
<SukiAssistant
  encounter={currentEncounter}
  ambientOptions={{
    sections: [
      { loinc: "51848-0", isPBNSection: true }, // Assessment and Plan as PBN
      { loinc: "11450-4" },
      { loinc: "29545-1" },
    ],
    diagnoses: { // New in v2.1.2
      values: [
        {
          codes: [
            {
              code: "I10",
              description: "Essential hypertension",
              type: "ICD-10",
            },
          ],
          diagnosisNote: "Hypertension",
        },
      ],
    },
  }}
/>
```


## ​Configuration rules

1

Single PBN section

Only one section can have
`isPBNSection: true`
. If multiple sections are marked as PBN, the ambient session will fail to start.
2

Explicit flag values

Explicitly pass
`true`
or
`false`
for the
`isPBNSection`
flag. The value provided will be respected as-is.
3

Default behavior

If no section includes the
`isPBNSection`
flag (i.e., left
`undefined`
) and the Assessment & Plan section (51847-2) is present, that section will automatically be treated as the PBN.
4

Override default

If you explicitly set
`isPBNSection: false`
on the Assessment & Plan section, the automatic default behavior will not apply.
For a given ambient session,
**only one section**
can have
`isPBNSection: true`
. If more than one section is marked as PBN, the ambient session will fail to start.

## ​Existing patient diagnoses

Pass the patient’s current diagnoses (e.g. from the EMR) into the session using the
`diagnoses`
block in the
`ambientOptions`
object. The SDK automatically merges them with what’s discussed during the visit so the note has one problem list and no duplicates.
When you switch to a new patient or encounter, pass that encounter’s diagnoses in
`ambientOptions`
; see
Update encounter and ambient options
for more details.
Diagnoses can be seeded
**only at the start of the first session**
in an encounter.
In re-ambient (later sessions in the same encounter), you cannot seed diagnoses; rely on the note from the previous session for any updates.
A diagnosis you pass in is included in the note only if the provider or patient talks about it during the visit. If they don’t mention it, it’s left out.

### ​Requirements for passing diagnoses

- You must have at least one PBC section in your ambientOptions.sections (set isPBNSection: true ).
- For each diagnosis you pass in: Include exactly one code in the codes array. Set the code type to "ICD-10" . Provide at least one of code or description (you can provide both). diagnosis_note is optional.

**Things to keep in mind**
- Input: Only ICD-10 is supported for the diagnoses you pass in. Output can include ICD-10, IMO, and SNOMED.
- AutoCoding: Off by default so your seeded data is used as is.

**Response**
The response is
**unchanged**
when you pass diagnoses. You receive the same object (
`noteId`
,
`encounterId`
,
`contents`
) via
`onNoteSubmit`
or
`note-submission:success`
.
For the full response structure, refer to
Note management - Response structure
.

## ​Next steps

- Track session state: Ambient session status
- Multilingual sessions: Multilingual support
- Return to Ambient session overview

Last modified on
April 1, 2026
Session Status & EventsPrevious
Multilingual SessionsNext
⌘
I
- Implementation
- Configuration rules
- Existing patient diagnoses
- Requirements for passing diagnoses
- Next steps

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
