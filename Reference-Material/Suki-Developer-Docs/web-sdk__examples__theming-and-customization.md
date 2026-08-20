# Theming and Customization - Suki

**Source URL:** https://developer.suki.ai/web-sdk/examples/theming-and-customization

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

Customize the Suki Web SDK to match your application’s design. This gives you full control over the look and feel of the SDK, including the colors, fonts, and overall design.

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
Theme colors are optional and will default to the Suki brand colors if not provided.
JavaScript

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
      partnerToken: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWUsImlhdCI6MTUxNjIzOTAyMn0.KMUFsIDTnFmyG3nMiGM6H9FNFUROf3wh7SmqJp-QV30", // Replace with your actual partner token
      providerName: "John doe", // Replace with the full name of the provider
      providerOrgId: "1234", // Replace with the provider's organization ID
      theme: {
          primary: rgb(28, 28, 28),   //just an example, replace with your primary color
          background: rgb(255, 255, 255),  // Replace with your background color
          secondaryBackground: rgb(233, 233, 240),  // Replace with your secondary background color
          foreground: rgb(0, 0, 0),  // Replace with your foreground color
          warning: rgb(255, 184, 0)  // Replace with your warning color
      },
    });
  }, [init]);


  return <MySDKComponent  />;
}

function MySDKComponent() {
  const handleNoteSubmit = (data) => {
    console.log("Note submitted:", data);
  };

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

  const uiOptions = {
    showCloseButton: false,
    showCreateEmptyNoteButton: false,
    showStartAmbientButton: true,
    sectionEditing: {
      enableDictation: false,
      enableCopy: true,
    }
  }

  return (
    <SukiAssistant
      encounter={encounter}
      onNoteSubmit={handleNoteSubmit}
      uiOptions={uiOptions}
      // rest of the props as needed
    />
  );
}
```

Last modified on
March 26, 2026
Advanced ConfigurationPrevious
Automatic User OnboardingNext
⌘
I
- Overview
- Code example

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
