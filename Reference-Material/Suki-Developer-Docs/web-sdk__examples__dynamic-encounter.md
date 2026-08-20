# Dynamic Encounter - Suki

**Source URL:** https://developer.suki.ai/web-sdk/examples/dynamic-encounter

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

Encounter data contains patient and provider information. You pass it to the
`SukiAssistant`
component to pre-populate the SDK.
**Dynamic encounter**
means you can change the
`encounter`
prop after the component loads. When you pass new encounter data, the SDK automatically updates it for note generation.

## ​Code example

The example below shows how to change encounter data using React state:

```
import { SukiAssistant, SukiProvider, useSuki } from "@suki-sdk/react";

function DynamicEncounterComponent() {
  const [currentEncounter, setCurrentEncounter] = useState(initialEncounter); // Replace with your initial encounter data

  const switchToNewPatient = () => {
    const newEncounter = {
      identifier: "6ec3920f-b0b1-499d-a4e9-889bf788e5ab", // Sample identifier (Replace with your actual encounter identifier without any spaces).
      patient: {
        identifier: "905c2521-25eb-4324-9978-724636df3436", // Sample identifier (Replace with your actual patient identifier without any spaces).
        name: {
          use: "usual",
          family: "Wilson",
          given: ["Emma"],
          suffix: [],
        },
        birthDate: "1992-07-10",
        gender: "female",
      },
    };

    setCurrentEncounter(newEncounter);
  };

  return (
    <SukiProvider>
      <div>
        <button onClick={switchToNewPatient}>Switch to New Patient</button>

        <SukiAssistant
          encounter={currentEncounter}
          // rest of the props
        />
      </div>
    </SukiProvider>
  );
}
```


## ​Next steps

Refer to
Ambient events
to learn more about how to track and manage ambient interactions in the web SDK.
Last modified on
April 1, 2026
Control VisibilityPrevious
Ambient EventsNext
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
