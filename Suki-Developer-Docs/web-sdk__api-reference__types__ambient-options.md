# AmbientOptions Type - Suki

**Source URL:** https://developer.suki.ai/web-sdk/api-reference/types/ambient-options

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

- Ambient Session
- Note Management
- Error Handling
- Token Refresh
- Telehealth
- Branding


##### API Reference

- Types Types Overview Encounter Patient InitOptions PartnerDetails ThemeOptions MountOptions UIOptions SectionEditingOptions AmbientOptions UPDATED Section LogLevel EmitterEvents NoteContent Diagnosis SukiError
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
`v2.2.0+`
Added additional optional session-level metadata: Pass
**visit context**
(
`visitType`
,
`encounterType`
,
`reasonForVisit`
,
`chiefComplaint`
) and
**providerRole**
in
`ambientOptions`
to improve note generation. Pass these at session init (e.g. in
`mount`
or when calling
`setAmbientOptions`
).

## ​Overview

AmbientOptions type represents the configuration options for ambient session functionality. The code snippet below shows how to use the
`AmbientOptions`
type to create an ambient options object.
JavaScript

```
type AmbientOptions = { 
  sections?: Section[];
  diagnoses?: { // New in v2.1.2
    values: Array<{
      codes: Array<{ code?: string; description?: string; type: "ICD-10" }>;
      diagnosis_note?: string;
    }>;
  };
  // Optional session context // New in v2.2.0
  visitType?: string;       // Enum: use values from Visit Types API
  encounterType?: string;   // Enum: use values from Encounter Types API
  providerRole?: string;   // Enum: use values from Provider Roles API
  reasonForVisit?: string;  // Max 255 characters
  chiefComplaint?: string;   // Max 255 characters
};
```


## ​Properties

​
sections
Section[]
Array of clinical note LOINC sections to generate suggestions for
​
diagnoses
object
**Optional**
- Pass the patient’s existing diagnoses (e.g. from the EMR) when PBC is enabled so the session merges them with what’s discussed and avoids duplicate problems. Each diagnosis needs one ICD-10 code. See
Existing patient diagnoses
for details.
​
visitType
string
**Optional**
- Type of visit (e.g.
`NEW_PATIENT`
,
`ESTABLISHED_PATIENT`
,
`WELLNESS`
,
`ED`
). Also refer to
Visit types
for available enum values.
Pass with LOINC codes at session init to improve note accuracy.
In the Web SDK UI, this value is used to set the
**title**
for the generated note in the patient note list when present, so clinicians see a meaningful label (for example,
**NEW_PATIENT**
or
**ESTABLISHED_PATIENT**
) instead of the generic
**Note**
label across multiple notes from the same day.
​
encounterType
string
**Optional**
- Setting of the encounter (e.g.
`AMBULATORY`
,
`INPATIENT`
,
`ED`
).
​
providerRole
string
**Optional**
- Provider’s role in the encounter (e.g.
`PRIMARY/ATTENDING`
,
`CONSULTING`
).  Also refer to
Provider roles
for available enum values.
​
reasonForVisit
string
**Optional**
- Free-text reason for the visit. Maximum
**255 characters**
. Helps focus the note on the primary reason for the visit.
​
chiefComplaint
string
**Optional**
- Patient’s primary complaint or concern. Maximum
**255 characters**
. Helps structure the chief complaint section of the note.
Last modified on
April 1, 2026
SectionEditingOptions TypePrevious
Section TypeNext
⌘
I
- Overview
- Properties

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
