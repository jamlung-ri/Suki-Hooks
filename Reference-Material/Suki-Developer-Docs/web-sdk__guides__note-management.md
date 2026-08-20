# Note Management - Suki

**Source URL:** https://developer.suki.ai/web-sdk/guides/note-management

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

Quick summary
After submitting an ambient session, Suki generates a clinical note in the background. Once ready, you can retrieve the note content and save it to your EHR.


Receive note content using either the
`onNoteSubmit`
prop (React only) or the
`note-submission:success`
event (React and JavaScript). The SDK provides the note ID, contents organized by sections, and LOINC codes for each section. Generated notes title will have titles that match the
**visitType**
value passed during session init.
Last updated:
April 2026

## ​Overview

After submitting an ambient session, Suki generates a clinical note in the background. Once ready, you can retrieve the note content and save it to your EHR.

## ​Note generation

Note generation happens automatically after session submission. Generation time depends on connectivity:
- Online : Faster generation since audio is processed in real-time during the conversation
- Offline : Slower generation since the entire audio file must upload first after connection is restored

For more details, see the
Offline mode
guide.

## ​Receiving note content

When a note is successfully submitted, the SDK provides the note content to your application. Receive it using either method:
- onNoteSubmit prop (React only, recommended)
- note-submission:success event (React and JavaScript)

- JavaScript
- React

JavaScript

```
const unsubscribeNoteSubmission = sdkClient.on("note-submission:success", (note) => {
  console.log("Note ID:", note.noteId);
  console.log("Encounter ID:", note.encounterId);
  console.log("Note contents:", note.contents);
  
  // Save to your EHR
  note.contents.forEach((section) => {
    console.log(`Section: ${section.title}`);
    console.log(`Content: ${section.content}`);
    console.log(`LOINC Code: ${section.loinc_code}`);
  });
});
```

React

```
import { useSuki } from "@suki-sdk/react";
import { useCallback } from "react";

const { on } = useSuki();

useEffect(() => {
  const unsubscribeNoteSubmission = on("note-submission:success", (note) => {
    console.log("Note submitted:", note);
  });

  return () => unsubscribeNoteSubmission();
}, [on]);

const handleNoteSubmit = useCallback((note) => {
  console.log("Note ID:", note.noteId);
  console.log("Encounter ID:", note.encounterId);
  
  // Save to your EHR
  note.contents.forEach((section) => {
    console.log(`Section: ${section.title} - ${section.content}`);
    if (section.diagnosis) {
      console.log(`Diagnosis: ${section.diagnosis.icdDescription}`);
    }
  });
}, []);

return (
  <SukiAssistant
    onNoteSubmit={handleNoteSubmit}
    // other props
  />
);
```


### ​Note titles in the Web SDK UI

When you pass
**visitType**
in
**ambientOptions**
at session init (for example in
`mount`
,
**ambientOptions**
on
**SukiAssistant**
, or
**setAmbientOptions**
), the Web SDK uses that value as the
**title**
for the generated note in the in-product patient note list. The generated note title will match the
**visitType**
value. This helps clinicians distinguish multiple notes created on the same day.

---


---

The generated note will have
**Created At Timestamp**
instead of
**Today**
date.
If
**visitType**
is omitted, the UI keeps the previous generic title behavior and the note title will show as
**Note**
.
Use values that match your integration contract (refer to the
visitTypes
reference for more information on
available enum values. For the full
**ambientOptions**
available parameters, refer to the
AmbientOptions
reference guide.

## ​Response structure

When a note is successfully submitted, you receive a response object with the following structure:
JSON

```
{
  "noteId": "82467ba8-71bc-46e2-8232-20d4d5629973",
  "encounterId": "encounter-12345",
  "contents": [
    {
      "title": "History",
      "content": "The patient is a 50-year-old female who has been experiencing fever for the last 10 days...",
      "loinc_code": "18233-4",
      "diagnosis": null
    },
    {
      "title": "Review of Systems",
      "content": "- No additional symptoms or pertinent negatives discussed during the encounter.",
      "loinc_code": "10164-2",
      "diagnosis": null
    },
    {
      "title": "Assessment and Plan",
      "content": "Viral hepatitis B with hepatic coma",
      "loinc_code": "51847-2",
      "diagnosis": {
        "icdCode": "B19.11",
        "icdDescription": "Unspecified viral hepatitis B with hepatic coma",
        "snomedCode": "26206000",
        "snomedDescription": "Hepatic coma due to viral hepatitis B",
        "hccCode": "HCC-1",
        "panelRanking": 1,
        "billable": true,
        "problemLabel": "Unspecified viral hepatitis B with hepatic coma"
      }
    }
  ]
}
```


### ​Response fields

​
noteId
string
Unique identifier for the generated note
​
encounterId
string
Unique identifier for the encounter associated with the note
​
contents
Array<NoteContent>
Array of note sections. Each section contains:
- title : Section title (e.g., “History of Present Illness”)
- content : Section content in plain text
- loinc_code : LOINC code for the section (optional)
- diagnosis : Diagnosis information if applicable (optional). Refer to Diagnosis for complete structure.

For complete type definitions, refer to
NoteContent
and
Diagnosis
.

## ​Next steps

- Learn about Token refresh to keep sessions alive
- Explore Error handling for note submission failures

Last modified on
April 1, 2026
Re-Ambient & Session RecoveryPrevious
Error HandlingNext
⌘
I
- Overview
- Note generation
- Receiving note content
- Note titles in the Web SDK UI
- Response structure
- Response fields
- Next steps

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
