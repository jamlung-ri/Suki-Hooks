# Advanced Configuration - Suki

**Source URL:** https://developer.suki.ai/web-sdk/examples/advanced-configuration

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

Customize the Suki Assistant Web SDK to fit your application’s specific needs. This example covers the complete setup, including the
**root provider**
,
**dynamic props**
,
**UI customization**
, and
**event handling**
, as shown in the comprehensive example.

## ​Configurations


### ​Wrapping your application

Wrapping your application with the
`SukiProvider`
component is the first step in configuring the Suki Assistant Web SDK. This is necessary for the SDK and its hooks to function correctly.

```
import { SukiProvider } from "@suki-sdk/react";

// This is the root of your application
function Root() { 
  return (
    <SukiProvider>
      <App />
    </SukiProvider>
  );
}
```


### ​Initializing the SDK

Before you can use advanced features, you must
**initialize the SDK**
. This is done within the
`SukiProvider`
context.
Once inside the provider, you can use the
`useSuki`
hook to get the
`init`
function. You should call this function
**once**
when your application loads, typically inside a
`useEffect`
hook.

```

import { SukiProvider, useSuki } from "@suki-sdk/react";
import { useEffect } from "react";

function App() {
  const { init } = useSuki();

  useEffect(() => {
    init({
      partnerId: "f80c8db8-a4d0-4b75-8d63-56c82b5413f0", // Replace with your partner ID
      partnerToken: "YOUR_JWT_HERE", // Replace with your partner token
      providerName: "John Doe", // Replace with your provider's name
      providerOrgId: "1234", // Replace with your provider's organization ID
      theme: {
        primary: "#0066cc", // Replace with your primary color
        background: "#ffffff", // Replace with your background color
      },
    });
  }, [init]);

  // ... rest of the application
}
```


### ​Configure the SukiAssistant component

The
`<SukiAssistant />`
component is the main UI for the SDK. Configure its behavior and appearance by passing it the following props.

#### ​Handling dynamic encounters

The
`encounter`
prop is the most important piece of contextual information.
The example below demonstrates how to dynamically change this prop to load different patient encounters into the SDK.

```
import { useState } from "react";

// In your main App component...
const [encounter, setEncounter] = useState(encounters[0]); // encounters is your array of data

return (
  <>
    {/* Buttons to demonstrate switching the encounter context */}
    <button onClick={() => setEncounter(encounters[0])}>
      Load Encounter 1
    </button>
    <button onClick={() => setEncounter(encounters[1])}>
      Load Encounter 2
    </button>

    {/* Pass the currently selected encounter to the component */}
    <SukiAssistant encounter={encounter} {...otherProps} />
  </>
);
```


#### ​Ambient and UI options

The
`ambientOptions`
and
`uiOptions`
props are used to configure the ambient session and the user interface of the SDK.

#### ​Event handlers

Listen for key events from the SDK by providing
`callback`
functions as props. This allows your application to react when a user takes an action.
- onNoteSubmit : This function is called when a note is successfully generated and submitted. It receives an object containing the noteId and the contents of the note.
- onClose : This function is called when the user clicks the close button in the UI.


## ​Complete example

This example ties all the concepts together, showing the
`SukiProvider`
,
`SukiAssistant`
,
`useSuki`
hook, dynamic encounters, and all configuration props in a single, working component structure.

```
import { SukiAssistant, SukiProvider, useSuki } from "@suki-sdk/react";
import React, { useEffect, useState } from "react";

// Mock data for demonstration
const encounters = [
  {
    identifier: "6ec3920f-b0b1-499d-a4e9-889bf788e5ab",
    patient: {
      identifier: "905c2521-25eb-4324-9978-724636df3436",
      name: { family: "Smith", given: ["John"] },
      birthDate: "1980-01-15",
      gender: "male",
    },
  },
  {
    identifier: "qsc2393g-b0b1-499d-a4e9-983cq125g5op",
    patient: {
      identifier: "25eb905-1232-082132-aw12320do4r",
      name: { family: "Johnson", given: ["Sarah"] },
      birthDate: "1985-03-20",
      gender: "female",
    },
  },
];

// 1. SukiProvider must wrap the root of your application
function Root() {
  return (
    <SukiProvider>
      <App />
    </SukiProvider>
  );
}

// 2. The main application component handles initialization and state
function App() {
  const { init } = useSuki();
  const [encounter, setEncounter] = useState(encounters[0]);

  useEffect(() => {
    init({
      partnerId: "f80c8db8-a4d0-4b75-8d63-56c82b5413f0", // Replace with your actual partner ID
      partnerToken: "YOUR_JWT_HERE", // Replace with your actual partner token
      providerName: "John doe",
      providerOrgId: "1234",
      theme: {
        primary: "#0066cc",
        background: "#ffffff",
      },
    });
  }, [init]);

  // Define ambient options for note generation
  const ambientOptions = {
    sections: [
      { loinc: "51847-2", isPBNSection: true }, // Assessment and Plan
      { loinc: "10164-2" }, // History of Present Illness
      { loinc: "10187-3" }, // Review of Systems
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
  };

  return (
    <>
      <h3>Select an Encounter:</h3>
      <button onClick={() => setEncounter(encounters[0])}>
        Load John Smith
      </button>
      <button onClick={() => setEncounter(encounters[1])}>
        Load Sarah Johnson
      </button>
      <hr />
      <AdvancedSDKComponent
        encounter={encounter}
        ambientOptions={ambientOptions}
      />
    </>
  );
}

// 3. This component renders and manages the SukiAssistant UI
function AdvancedSDKComponent({ encounter, ambientOptions }) {
  const [isVisible, setIsVisible] = useState(true);

  // Define UI options to customize the interface
  const uiOptions = {
    showCloseButton: true,
    showStartAmbientButton: true,
    showCreateEmptyNoteButton: false,
    sectionEditing: {
      enableDictation: true,
      enableCopy: false,
    },
  };

  // Define event handlers to react to SDK events
  const handleNoteSubmit = (data) => {
    console.log("Note submitted successfully:", data.noteId);
    data.contents.forEach((section) => {
      console.log(`- ${section.title}: ${section.content}`);
    });
  };

  const handleClose = () => {
    setIsVisible(false);
    console.log("SDK closed by user");
  };

  if (!isVisible) {
    return <div>SDK has been closed.</div>;
  }

  return (
    <SukiAssistant
      encounter={encounter}
      uiOptions={uiOptions}
      ambientOptions={ambientOptions}
      onNoteSubmit={handleNoteSubmit}
      onClose={handleClose}
    />
  );
}
```


## ​Next steps

Read the
Theming and customization
example to learn how to customize the UI of the SDK.
Last modified on
April 1, 2026
Use Suki SDK Inside an IframePrevious
Theming and CustomizationNext
⌘
I
- Overview
- Configurations
- Wrapping your application
- Initializing the SDK
- Configure the SukiAssistant component
- Handling dynamic encounters
- Ambient and UI options
- Event handlers
- Complete example
- Next steps

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
