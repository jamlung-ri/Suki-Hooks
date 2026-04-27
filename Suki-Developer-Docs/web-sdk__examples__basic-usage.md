# Basic Usage - Suki

**Source URL:** https://developer.suki.ai/web-sdk/examples/basic-usage

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


## ​Overview

This guide shows you how to get started with the Suki React SDK in your application.

## ​Code example

This example below covers the complete setup, including the
**root provider**
,
**dynamic props**
,
**UI customization**
, and
**event handling**
.
React

```
import { SukiAssistant, SukiProvider, useSuki } from "@suki-sdk/react";

function Root() {
  return (
    <SukiProvider>
      <App />
    </SukiProvider>
  );
}

function App() {
  const { init } = useSuki();

  useEffect(() => {
    init({
      partnerId: "f80c8db8-a4d0-4b75-8d63-56c82b5413f0", // Replace with your actual partner ID
      partnerToken:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWUsImlhdCI6MTUxNjIzOTAyMn0.KMUFsIDTnFmyG3nMiGM6H9FNFUROf3wh7SmqJp-QV30", // Replace with your actual partner token
      providerName: "John doe", // Replace with the full name of the provider
      providerOrgId: "1234", // Replace with the provider's organization ID
    });
  }, [init]);

  const encounter = {
    identifier: "6ec3920f-b0b1-499d-a4e9-889bf788e5ab",
    patient: {
      identifier: "905c2521-25eb-4324-9978-724636df3436",
      name: {
        use: "usual",
        family: "Smith",
        given: ["John"],
        suffix: [],
      },
      birthDate: "1980-01-15",
      gender: "male",
    },
  };

  return <MySDKComponent encounter={encounter} />;
}

function MySDKComponent({ encounter }) {
  const handleNoteSubmit = (data) => {
    console.log("Note submitted:", data.noteId);
    data.contents.forEach((section) => {
      console.log(`Section: ${section.title} - ${section.content}`);
    });
  };

  const ambientOptions = {
    sections: [
      {
        loinc: "51847-2", // Assessment and Plan
        isPBNSection: true,
      },
      {
        loinc: "10164-2", // History of Present Illness
      },
      {
        loinc: "10187-3", // Review of Systems
      },
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
    visitType: "ESTABLISHED_PATIENT", // New in v2.2.0
    encounterType: "AMBULATORY",
    providerRole: "PRIMARY/ATTENDING",
    reasonForVisit: "Follow-up for hypertension",
    chiefComplaint: "Headache",
  };

  return (
    <SukiAssistant
      encounter={encounter}
      onNoteSubmit={handleNoteSubmit}
      ambientOptions={ambientOptions}
    />
  );
}
```


## ​Next steps

Read the
Control visibility
example to learn how to control the visibility of the SDK.
Last modified on
April 1, 2026
Components ReferencePrevious
Control VisibilityNext
⌘
I
- Overview
- Code example
- Next steps

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
