# Control Visibility - Suki

**Source URL:** https://developer.suki.ai/web-sdk/examples/control-visibility

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

Control the visibility of the Suki Web SDK using the embedded close button. This is useful when you want to show or hide the SDK from your application.

## ​Code example

The following examples show how to control the visibility of the SDK using the
`showCloseButton`
prop.
- With Close Button
- Without Close Button

This example shows how to control the visibility of the web SDK using the
`showCloseButton`
prop. When the
`showCloseButton`
is set to
`true`
, the close button is visible and the
`onClose`
prop is available.
React

```
import { SukiAssistant, SukiProvider, useSuki } from "@suki-sdk/react";

function ComponentWithCloseButton() {
const { init } = useSuki();
const [isVisible, setIsVisible] = useState(true);

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
identifier: "encounter-789",
patient: {
  identifier: "patient-101",
  name: {
    use: "usual",
    family: "Johnson",
    given: ["Sarah", "Marie"],
    suffix: ["MD"],
  },
  birthDate: "1985-03-20",
  gender: "female",
},
};

const uiOptions = { showCloseButton: true };

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

const handleClose = () => {
setIsVisible(false);
console.log("SDK closed by user");
};

if (!isVisible) {
return <div>SDK has been closed</div>;
}

return (
<SukiAssistant
  encounter={encounter}
  uiOptions={uiOptions}
  ambientOptions={ambientOptions}
  onClose={handleClose}
  onNoteSubmit={(data) => {
    console.log(data);
  }}
/>
);
}
```

This example shows how to control the visibility of the web SDK using the
`onClose`
prop. When the
`showCloseButton`
is set to
`false`
, the
`onClose`
prop is not available.
React

```
// When showCloseButton is false, onClose is not available
function ComponentWithoutCloseButton() {
const uiOptions = {
showCloseButton: false,
};

return (
<SukiAssistant
  encounter={encounter}
  uiOptions={uiOptions}
  onNoteSubmit={(data) => {
    console.log(data);
  }}
  // onClose={handleClose} // TypeScript error: Property 'onClose' does not exist
  // rest of the props
/>
);
}
```


## ​Next steps

Read the
Dynamic encounter
example to learn how to dynamically update the encounter data in the web SDK.
Last modified on
April 1, 2026
Basic UsagePrevious
Dynamic EncounterNext
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
