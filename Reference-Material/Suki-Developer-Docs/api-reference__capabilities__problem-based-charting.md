# Problem-Based Charting - Suki

**Source URL:** https://developer.suki.ai/api-reference/capabilities/problem-based-charting

---

Sukihome page
Documentation
APIs
Release Notes
Sukihome page


##### Get Started

- Overview
- Quickstart
- Learning Path
- Choose Your Integration


##### Onboarding & Authentication

- Partner Onboarding
- Partner Authentication


##### Product Capabilities

- Ambient Documentation
- Note Sections
- Specialties
- Problem-Based Charting (PBC) UPDATED
- Multilingual Support
- Note Personalization
- Dictation
- Audio Streaming & Download NEW


##### Guides

- Notification Webhook
- MCP Integration
- Executive Summary
- Technical Execution Guide


##### Help & Support

- Support
- FAQs
- Glossary

**Updated**
Pass the patient’s existing diagnoses when starting a PBC session so the generated note merges them with what’s discussed in the visit. Use the Context API for APIs, or
`ambientOptions.diagnoses`
for the Web SDK (
**v2.1.2+**
).
Optional visit-level fields in
`ambientOptions`
(
`visitType`
,
`encounterType`
,
`providerRole`
,
`reasonForVisit`
,
`chiefComplaint`
) ship in the Web SDK
**v2.2.0+**
to improve note generation. See
AmbientOptions
.
For how the system reconciles those diagnoses with the conversation (API flow), refer to
Reconciliation
. For Web SDK implementation details, refer to
Existing patient diagnoses
.
Quick summary
Problem-Based Charting (PBC) is a clinical documentation approach that organizes notes by patient problems instead of traditional note sections, and suggests diagnoses for each problem.
Last updated:
April 2026
**Problem-Based Charting is supported by:**
Ambient APIs, Web SDK, Mobile SDK

## ​Overview

Problem-Based Charting (PBC) organizes clinical notes by patient problems instead of traditional note sections. When you use PBC, Suki generates two things:
- Clinical note : Organized by each problem or diagnosis
- Structured artifacts : Suggested diagnoses with ICD-10 and IMO codes

PBC notes are different from traditional notes. In traditional notes, information is organized by sections like “History,” “Assessment,” and “Plan.” In PBC notes, information is organized by each problem, grouping all related information together.
When you enable PBC, providers get a note that has the following benefits:
- Easier to read : See everything about each problem in one place
- Better continuity : Includes existing problems from previous visits automatically
- Complete picture : Captures both old and new problems discussed during the visit
- Structured data : Generates standardized codes (ICD-10, IMO) for EHR integration


## ​How to use PBC for APIs and SDKs

You enable PBC by doing three things:
- Define which note sections to generate and which one is the PBN
- Pass the patient’s existing diagnoses into session context
- Read structured diagnosis output after the session finishes

- Configure sections for PBC
- Provide existing diagnoses
- Retrieve diagnosis results

- Web SDK: In ambientOptions.sections , set isPBNSection: true on exactly one section. Rules for defaults, overrides, and errors are in Configuration rules .
- Ambient APIs: Send the LOINC sections array in the Context API body so the Suki backend knows which note sections to generate. PBN defaults (for example, when Assessment & Plan, LOINC 51847-2 , is treated as the PBN) follow the same rules as in Configuration rules .
- Mobile SDK (iOS): Pass LOINC sections in kSections via setSessionContext . See the Mobile SDK Create session guide for field names and examples.

- Ambient APIs: Include diagnoses when you POST (and, if needed, PATCH) session context.
- Web SDK: Use ambientOptions.diagnoses . Refer to the AmbientOptions type for more details.
- Mobile SDK (iOS): Use SukiAmbientConstant.kDiagnosisInfo in setSessionContext . Refer to the Mobile SDK Create session guide for more details.

- Ambient APIs: After the session has finished processing, use the Structured Data or Encounter Structured Data APIs and related endpoints to read suggested diagnoses.
- Mobile SDK (iOS): After the session completes, call getStructuredData(for:) . See Session status and content retrieval .
- Web SDK: After the user submits the ambient session and note generation succeeds, read results from the onNoteSubmit callback (React) or the note-submission:success event (JavaScript and React). Refer to Receiving note content , Response structure , NoteContent , and Diagnosis for more details.


## ​Implementation examples

- Web SDK
- Mobile SDK (iOS)
- Ambient APIs

Use the
`diagnoses`
block in
`ambientOptions`
to provide existing patient diagnoses when starting a session.
**Code example:**
JavaScript

```
sdkClient.mount({
  rootElement: document.getElementById("suki-root"),
  encounter: encounterDetails,
  ambientOptions: {
    sections: [
      { loinc: "51848-0", isPBNSection: true }, // Mark as PBN section
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

Use
`setSessionContext`
to pass LOINC sections and structured diagnosis information. After the session ends, call
`getStructuredData(for:)`
to retrieve diagnoses and other structured output. Refer to the Mobile SDK
Create session
guide for more details.
**Code example:**
Swift

```
let context = SukiAmbientContext(
  sections: [
    SukiAmbientSection(loinc: "51848-0", isPBNSection: true), // Mark as PBN section
    SukiAmbientSection(loinc: "11450-4"),
    SukiAmbientSection(loinc: "29545-1"),
  ],
  diagnosisInfo: [
    SukiAmbientDiagnosisInfo(
      codes: [
        SukiAmbientCode(code: "I10", description: "Essential hypertension", type: .icd10),
      ],
      diagnosisNote: "Hypertension",
    ),
  ],
},
},
});
```

Use the
Context API
to provide existing patient diagnoses when starting a session.
**Code example:**
Python

```
payload = {
  "diagnoses": {
    "values": [
      {
        "codes": [
          {
            "code": "I10",
            "description": "Essential hypertension",
            "type": "ICD-10",
          },
        ],
        "diagnosis_note": "Hypertension",
      },
    ],
  },
}
```

**APIs to use:**

## POST Context API

Provide initial diagnoses when starting a session

## PATCH Update Context API

Update or add diagnoses during a session

## ​Configuration rules for PBC

When configuring PBC, follow these rules:
1

Single PBN section

Only one section can have
`isPBNSection: true`
. If multiple sections are marked as PBN, the ambient session will fail to start.
2

Default behavior

If no section includes the
`isPBNSection`
flag and the Assessment & Plan section (51847-2) is present, that section automatically becomes the PBN.
3

Explicit override

Explicitly set
`isPBNSection: false`
to prevent automatic PBN assignment.
For a given ambient session,
**only one section**
can have
`isPBNSection: true`
. If more than one section is marked as PBN, the ambient session will fail to start.

## ​Core principles

Understanding these principles helps you use PBC effectively:

## ​How PBC works

PBC processes diagnoses in three steps:
1

Provide existing diagnoses

You provide existing diagnoses when starting the session using the Context APIs.
2

Suki analyzes conversation

Suki’s AI analyzes the conversation and identifies new problems or updates to existing diagnoses.
3

Generate structured output

Suki generates a clinical note organized by problem and structured artifacts with standardized codes.
$!
/$
Suki backend includes the ML-suggested problem name and returns standardized ICD-10 code, description, and IMO equivalent in the final output.

### ​Validation rules

Each diagnosis in your request must follow these rules:
- One code per diagnosis : Each diagnosis must have exactly one code (ICD10 or IMO)
- No mixed codes : A single diagnosis cannot contain multiple code types
- Code required : Every diagnosis must include a code


### ​Input processing

Suki processes diagnoses through normalization and deduplication:
During normalization, the original input code will not be preserved. If a code cannot be mapped to an ICD10 equivalent,
**the entire diagnosis object will be skipped**
, and processing will continue with the rest of the input.

### ​Reconciliation

When you send existing diagnoses via the Context API at session start, the system
**reconciles**
them with what is discussed during the session. You get one problem list and no duplicates. This section describes the API flow (Context API to send, Structured Data API to retrieve).
For Web SDK, refer to the
Existing patient diagnoses
section in the ambient guide for more details.
**What happens to each diagnosis you send:**
- Discussed in the session - The diagnosis is updated and returned in the structured data output.
- Not discussed in the session - The diagnosis is not included in the final output.
- Matches something discussed - Your diagnosis and the one discussed are merged into a single entry (no duplicate).

The Structured Data API returns only diagnoses that were updated or newly generated.

### ​How diagnoses are generated

During the session, Suki’s AI analyzes the conversation and takes one of three actions on the diagnoses you provided:
- Update existing diagnosis : Modify the content if it was discussed
- Generate new diagnosis : Create a new diagnosis if a new problem was discussed
- Keep unchanged : Leave a diagnosis untouched if it wasn’t significantly discussed

Only diagnoses that were
**updated or newly generated**
are returned in the final output. Untouched diagnoses are not returned, if a diagnosis wasn’t discussed, it won’t appear in the output.

### ​Output enrichment

For any diagnosis that was updated or newly generated, Suki enriches it with:
- ICD10 code : Standard diagnosis code
- IMO code : Intelligent Medical Objects code
- Laterality : Left/right/bilateral information when applicable
- Post coordination flag : Indicates if the diagnosis requires additional modifiers

The IMO code returned in the output may be different from any IMO code that was sent in the input payload. This is normal: Suki uses the most accurate code based on the conversation content.
If enrichment fails, Suki still returns the diagnosis with available information to ensure you don’t lose generated content.

### ​Retrieving generated diagnoses

Refer to the
How to use PBC for APIs and SDKs
section for more details.

## ​Handling reambient scenarios

In reambient scenarios, where a single patient encounter involves multiple recording sessions, understanding how context is managed is critical.
Sessions do not
**automatically inherit diagnoses**
from previous sessions. Each session starts fresh, you must provide all relevant diagnoses for each new session.
**What this means:**
- When you use APIs in your implementation, only diagnoses passed via the Context APIs for the current session are considered
- Diagnoses from previous sessions are not automatically carried forward
- You must provide the complete and current list of all relevant diagnoses for each new session

**Your responsibilities:**
Because sessions don’t inherit context, you must provide the complete list of all relevant diagnoses for each new session. This includes:
- Modified diagnoses : Any diagnoses that were changed by the provider in previous sessions
- New diagnoses : Any newly added diagnoses from previous sessions
- Existing diagnoses : Diagnoses from previous sessions that should be retained

**Recommended workflow:**
$!
/$
After each session, retrieve the generated diagnoses using the Structured Data API, then include all relevant diagnoses (including any modifications) when starting the next session.

## ​Best practices

- Provide complete context : Always include all relevant existing diagnoses when starting a session
- Use ICD10 when possible : ICD10 codes are preferred and processed most reliably
- Handle reambient carefully : Retrieve diagnoses after each session and include them in the next session
- Validate codes : Ensure diagnosis codes are valid before sending them
- Monitor output : Check which diagnoses were updated or generated to understand what was discussed
- Update after user edits : If providers modify diagnoses, include those modifications in subsequent sessions


## ​FAQs

Last modified on
April 1, 2026
Supported Medical SpecialtiesPrevious
Multilingual SupportNext
⌘
I
- Overview
- How to use PBC for APIs and SDKs
- Implementation examples
- Configuration rules for PBC
- Core principles
- How PBC works
- Validation rules
- Input processing
- Reconciliation
- How diagnoses are generated
- Output enrichment
- Retrieving generated diagnoses
- Handling reambient scenarios
- Best practices
- FAQs

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
