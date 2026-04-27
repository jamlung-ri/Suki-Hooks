# Web SDK Quickstart - Suki

**Source URL:** https://developer.suki.ai/web-sdk/quickstart

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

This guide walks you through setting up Suki.js in your existing JavaScript or React application, from installation to mounting the SDK UI.

## ​Prerequisites

For the rest of this documentation, we assume the following setup is complete:
- You have received your partnerId from Suki.
- Your host URLs are on the Suki allowlist.
- Your partner configuration in the Suki Platform points to your correct JWKS endpoint.
- Your JWT token contains the key that you specified as your User identifier field .


## ​Install the Suki SDK package

To begin, install the Suki web SDK package in your project. Choose the appropriate package based on your framework:
You must choose the appropriate package based on your framework. Refer to the
Installation guide
for more information.
- Javascript
- React


```
pnpm add @suki-sdk/js
```


```
pnpm add @suki-sdk/react
```

For detailed setup instructions, refer to the
Installation guide
.

### ​Initialize the SDK

Initialize the Suki SDK in your application by providing your
`partner ID`
,
`partner token`
,
`provider name`
, and
`provider organization ID`
. This step is crucial as it sets up the connection between your application and the Suki Platform.
Initialization should be done
**once**
, typically in your app’s
**entry point**
. This authenticates your app and prepares it to use Suki features.
- Javascript
- React

Import the SDK and call the
`initialize`
function with your API key. This should be done in your main application file (e.g.,
`index.js`
or
`app.js`
)
main.js

```
import { initialize } from "@suki-sdk/js";

const sdkClient = initialize({
  partnerId: "f80c8db8-a4d0-4b75-8d63-56c82b5413f0", // Replace with your actual partner ID
  partnerToken:
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWUsImlhdCI6MTUxNjIzOTAyMn0.KMUFsIDTnFmyG3nMiGM6H9FNFUROf3wh7SmqJp-QV30", // Replace with your actual partner token
  providerName: "John doe", // Replace with the full name of the provider
  providerOrgId: "1234", // Replace with the provider's organization ID
});
```


```
import { SukiProvider } from "@suki-sdk/react";

function App() {
  return (
    <SukiProvider>
      {/* Your application components go here */}
      <ComponentA />
    </SukiProvider>
  );
}
```


### ​Mount the SDK UI

After initializing the web SDK, you can mount the Suki UI into your application using the
encounter
object. This object provides patient context for ambient documentation and transcription.
If you face any issues while mounting the SDK UI, make sure you are using the correct package and framework.
- Javascript
- React

main.js

```
import { initialize } from "@suki-sdk/js";

// replace this with your actual encounter data
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

const sdkClient = initialize({
  partnerId: "f80c8db8-a4d0-4b75-8d63-56c82b5413f0", // Replace with your actual partner ID
  partnerToken:
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWUsImlhdCI6MTUxNjIzOTAyMn0.KMUFsIDTnFmyG3nMiGM6H9FNFUROf3wh7SmqJp-QV30", // Replace with your actual partner token
  providerName: "John doe", // Replace with the full name of the provider
  providerOrgId: "1234", // Replace with the provider's organization ID
});

const unsubscribeInit = sdkClient.on("init:change", (isInitialized) => {
  if (isInitialized) {
    sdkClient.mount({
      rootElement: document.getElementById("suki-root"), // The root element to mount the SDK into
      encounter: encounterDetails,
    });
  }
});

// unsubscribe from the init event when no longer needed
window.addEventListener("beforeunload", () => {
  unsubscribeInit();
});
```

ComponentA.jsx

```
import { useSuki, SukiAssistant } from "@suki-sdk/react";

const SUKI_OPTIONS = {
  partnerId: "f80c8db8-a4d0-4b75-8d63-56c82b5413f0", // Replace with your actual partner ID
  partnerToken:
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWUsImlhdCI6MTUxNjIzOTAyMn0.KMUFsIDTnFmyG3nMiGM6H9FNFUROf3wh7SmqJp-QV30", // Replace with your actual partner token
  providerName: "John doe", // Replace with the full name of the provider
  providerOrgId: "1234", // Replace with the provider's organization ID
};

function ComponentA() {
  const { init } = useSuki();

  // replace this with your actual encounter data
  const currentEncounter = {
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

  // Initialize SDK when options change or component mounts
  useEffect(() => {
    init(SUKI_OPTIONS);
  }, [init]); // Re-run when options change

  return (
    <SukiAssistant encounter={currentEncounter} />
    // rest of your code
  );
}
```


## ​Next steps

Refer to our
Ambient documentation guide
to learn more about how to use the Web Suki SDK to create your first ambient session.
Last modified on
April 1, 2026
Web SDK OverviewPrevious
Web SDK PrerequisitesNext
⌘
I
- Overview
- Prerequisites
- Install the Suki SDK package
- Initialize the SDK
- Mount the SDK UI
- Next steps

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
