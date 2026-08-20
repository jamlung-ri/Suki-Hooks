# Test Mode - Suki

**Source URL:** https://developer.suki.ai/web-sdk/examples/test-mode

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

Test mode is a feature that allows you to use the Suki web SDK in test mode for development and testing purposes before going live. This is useful for testing the SDK in a sandbox environment before deploying it to production.

## ​Code example

The example below demonstrates how to use the test mode in the web SDK.
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
      isTestMode: true, // Enable test mode
      enableDebug: true, // Enable debug mode for development
      logLevel: "debug", // Set log level to debug
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
    console.log("Note submitted:", data);
  };

  return (
    <SukiAssistant
      encounter={encounter}
      onNoteSubmit={handleNoteSubmit}
      // rest of the props as needed
    />
  );
}
```

Test mode is enabled by setting the
`isTestMode`
prop to
`true`
in the
`init`
options.

## ​Next steps

Refer to the
SDK inside an iframe
example to learn how to use the web SDK inside an iframe.
Last modified on
April 1, 2026
Ambient EventsPrevious
Use Suki SDK Inside an IframeNext
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
