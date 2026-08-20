# Ambient Implementation - Suki

**Source URL:** https://developer.suki.ai/web-sdk/guides/ambient-implementation

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
From
**v2.2.0+**
, you can pass
**optional session-level metadata**
in
`ambientOptions`
(in
`mount`
or
`setAmbientOptions`
) to improve note generation. When you set
**visitType**
, the Web SDK also uses it as the
**note title**
in the patient note list (see
Note list titles
).
Learn more in the
AmbientOptions
reference.
**These parameters are optional**
; omitting them does not break existing flows.

## ​Controlled session management

The following example shows how to implement controlled session management in JavaScript and React for the Ambient feature in the Web SDK.
- JavaScript
- React

controlled.js

```
import { initialize } from "@suki-sdk/js";

let isSukiReady = false;

// Replace with your actual encounter data
const encounterDetails = {
  identifier: "6ec3920f-b0b1-499d-a4e9-889bf788e5ab",
  patient: {
    identifier: "905c2521-25eb-4324-9978-724636df3436",
    name: {
      use: "official",
      family: "Doe",
      given: ["John"],
      suffix: ["MD"],
    },
    birthDate: "1990-01-01",
    gender: "Male",
  },
};

const sukiInstance = initialize({
  partnerId: "f80c8db8-a4d0-4b75-8d63-56c82b5413f0", // Replace with your actual partner ID
  partnerToken: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...", // Replace with your actual partner token
  providerName: "John Doe", // Replace with the full name of the provider
  providerOrgId: "1234", // Replace with the provider's organization ID
  providerSpecialty: "FAMILY_MEDICINE", // Replace with the provider's specialty
});

const unsubscribeInit = sdkClient.on("init:change", (isInitialized) => {
  if (isInitialized) {
    sdkClient.mount({
      rootElement: document.getElementById("suki-root"), // The root element to mount the SDK into
      encounter: encounterDetails,
      ambientOptions: {
        sections: [
          { loinc: "51848-0" },
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
        // Optional session context (visit_type, encounter_type, provider_role, reason_for_visit, chief_complaint)
        visitType: "ESTABLISHED_PATIENT", // New in v2.2.0
        encounterType: "AMBULATORY",
        providerRole: "PRIMARY/ATTENDING",
        reasonForVisit: "Follow-up for hypertension",
        chiefComplaint: "Headache",
      },
    });
  } else {
    isSukiReady = false; // Reset the ready state if initialization fails
  }
});

const unsubscribeReady = sdkClient.on("ready", () => {
  isSukiReady = true;
});

// Ambient session control functions
function startAmbient() {
  if (isSukiReady) {
    sdkClient.startAmbient();
  } else {
    console.error("Suki SDK is not ready yet.");
  }
}

function pauseAmbient() {
  if (isSukiReady) {
    sdkClient.pauseAmbient();
  } else {
    console.error("Suki SDK is not ready yet.");
  }
}

function resumeAmbient() {
  if (isSukiReady) {
    sdkClient.resumeAmbient();
  } else {
    console.error("Suki SDK is not ready yet.");
  }
}

function cancelAmbient() {
  if (isSukiReady) {
    sdkClient.cancelAmbient();
  } else {
    console.error("Suki SDK is not ready yet.");
  }
}

function submitAmbient() {
  if (isSukiReady) {
    sdkClient.submitAmbient();
  } else {
    console.error("Suki SDK is not ready yet.");
  }
}

// Attach event listeners to buttons
document.getElementById("start-ambient").addEventListener("click", startAmbient);
document.getElementById("pause-ambient").addEventListener("click", pauseAmbient);
document.getElementById("resume-ambient").addEventListener("click", resumeAmbient);
document.getElementById("cancel-ambient").addEventListener("click", cancelAmbient);
document.getElementById("submit-ambient").addEventListener("click", submitAmbient);

// Cleanup function to destroy the SDK and event listeners
// Call this function when you no longer need the SDK
function destroy() {
  isSukiReady = false;
  unsubscribeInit();
  unsubscribeReady();
  sdkClient.destroy();
  
  // Remove event listeners
  document.getElementById("start-ambient").removeEventListener("click", startAmbient);
  document.getElementById("pause-ambient").removeEventListener("click", pauseAmbient);
  document.getElementById("resume-ambient").removeEventListener("click", resumeAmbient);
  document.getElementById("cancel-ambient").removeEventListener("click", cancelAmbient);
  document.getElementById("submit-ambient").removeEventListener("click", submitAmbient);
  
  // Clear the root element
  document.getElementById("suki-root").innerHTML = "";
}
```

controlled.jsx

```
import { useSuki, SukiAssistant } from "@suki-sdk/react";
import { useState, useEffect, useMemo } from "react";

const SUKI_OPTIONS = {
  partnerId: "f80c8db8-a4d0-4b75-8d63-56c82b5413f0", // Replace with your actual partner ID
  partnerToken: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...", // Replace with your actual partner token
  providerName: "John Doe", // Replace with the full name of the provider
  providerOrgId: "1234", // Replace with the provider's organization ID
};

function Controlled() {
  const { cancelAmbient, pauseAmbient, resumeAmbient, startAmbient, submitAmbient, init, on } = useSuki();
  const [isSukiReady, setIsSukiReady] = useState(false);

  // Replace with your actual encounter data
  const currentEncounter = useMemo(
    () => ({
      identifier: "6ec3920f-b0b1-499d-a4e9-889bf788e5ab",
      patient: {
        identifier: "905c2521-25eb-4324-9978-724636df3436",
        name: {
          use: "official",
          family: "Doe",
          given: ["John"],
          suffix: ["MD"],
        },
        birthDate: "1990-01-01",
        gender: "Male",
      },
    }),
    []
  );

  // Initialize SDK when component mounts
  useEffect(() => {
    init(SUKI_OPTIONS);
  }, [init]);

  // Set up event listeners for SDK initialization and readiness
  useEffect(() => {
    const unsubscribeInit = on("init:change", (isInitialized) => {
      if (!isInitialized) {
        setIsSukiReady(false); // Reset the ready state if initialization fails
      }
    });

    const unsubscribeReady = on("ready", () => {
      setIsSukiReady(true);
    });

    return () => {
      unsubscribeInit();
      unsubscribeReady();
    };
  }, [on]);

  return (
    <>
      <SukiAssistant
        encounter={currentEncounter}
        ambientOptions={{
          sections: [
            { loinc: "51848-0" },
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
          visitType: "ESTABLISHED_PATIENT", // New in v2.2.0
          encounterType: "AMBULATORY",
          providerRole: "PRIMARY/ATTENDING",
          reasonForVisit: "Follow-up for hypertension",
          chiefComplaint: "Headache",
        }}
      />

      {isSukiReady && (
        <div>
          <button onClick={startAmbient}>Start Ambient</button>
          <button onClick={pauseAmbient}>Pause Ambient</button>
          <button onClick={resumeAmbient}>Resume Ambient</button>
          <button onClick={cancelAmbient}>Cancel Ambient</button>
          <button onClick={submitAmbient}>Submit Ambient</button>
        </div>
      )}
      {/* Rest of your code */}
    </>
  );
}
```


## ​Update encounter and ambient options

Update encounter data or ambient options when a new encounter loads in your EHR.
Diagnosis can be updated for every encounter. When you pass a new patient (or update the encounter), pass that encounter’s
**diagnoses**
in
`ambientOptions`
(e.g. via
`setAmbientOptions`
or the
`ambientOptions`
prop). You need to pass diagnoses whenever the encounter or patient changes.
- JavaScript
- React

JavaScript

```
// Update encounter data
sdkClient.setEncounter({
  identifier: "qsc2393g-b0b1-499d-a4e9-983cq125g5op",
  patient: {
    identifier: "25eb905-1232-082132-aw12320do4r",
    name: {
      use: "official",
      family: "Smith",
      given: ["Jane"],
      suffix: [],
    },
    birthDate: "1985-05-15",
    gender: "Female",
  },
});

// Update ambient options
sdkClient.setAmbientOptions({
  sections: [
    { loinc: "48765-2" },
    { loinc: "10157-6" },
    { loinc: "10164-2" },
  ],
  diagnoses: {
    values: [
      {
        codes: [
          { code: "I10", description: "Essential hypertension", type: "ICD-10" },
        ],
        diagnosisNote: "Hypertension",
      },
    ],
  },
  visitType: "ESTABLISHED_PATIENT",
  encounterType: "AMBULATORY",
  providerRole: "PRIMARY/ATTENDING",
  reasonForVisit: "Follow-up for hypertension",
  chiefComplaint: "Blood pressure check",
});
```

React

```
<SukiAssistant
  encounter={{
    identifier: "qsc2393g-b0b1-499d-a4e9-983cq125g5op",
    patient: {
      identifier: "25eb905-1232-082132-aw12320do4r",
      name: {
        use: "official",
        family: "Smith",
        given: ["Jane"],
        suffix: [],
      },
      birthDate: "1985-05-15",
      gender: "Female",
    },
  }}
  ambientOptions={{
    sections: [
      { loinc: "48765-2" },
      { loinc: "10157-6" },
      { loinc: "10164-2" },
    ],
    diagnoses: {
      values: [
        {
          codes: [
            { code: "I10", description: "Essential hypertension", type: "ICD-10" },
          ],
          diagnosisNote: "Hypertension",
        },
      ],
    },
    visitType: "ESTABLISHED_PATIENT",
    encounterType: "AMBULATORY",
    providerRole: "PRIMARY/ATTENDING",
    reasonForVisit: "Follow-up for hypertension",
    chiefComplaint: "Blood pressure check",
  }}
/>
```

Passing new encounter data or ambient options to the
`SukiAssistant`
component automatically updates the encounter details or sections for note generation.

## ​Next steps

- Track session state: Ambient session status
- Configure problem-based notes: PBC
- Return to Ambient session overview

Last modified on
April 1, 2026
Ambient Session OverviewPrevious
Session Status & EventsNext
⌘
I
- Controlled session management
- Update encounter and ambient options
- Next steps

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
