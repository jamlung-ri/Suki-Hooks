# Migrating to Suki.js v2 Web SDK - Suki

**Source URL:** https://developer.suki.ai/web-sdk/product-updates/migration-to-v2

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
The
`v2.0.0`
release adds new features and changes that enhance clinical documentation workflows.


The new version introduces breaking changes that require immediate attention.
Refer to
Breaking changes reference
for more information.
| Change Category | Details | Migration Impact |
| --- | --- | --- |
| Required Provider Information | Two new required fields: • providerName (string): The full name of the healthcare provider using the SDK • providerOrgId (string): The unique identifier of the healthcare organization | These fields enable automatic provider onboarding in the Suki system without manual registration. Both fields must be added to your initialization configuration. |
| Ambient Options Restructure | Deprecated : prefill.noteTypeIds approach (is removed from v2.1.1 and is no longer supported) New : sections array using LOINC codes for standardized note sections | You must migrate from noteTypeIds to LOINC-based section configurations. The prefill.noteTypeIds approach is deprecated and will be removed in future versions. |
| Theme Configuration Changes | Renamed : primaryColor → primary New properties : background , secondaryBackground , foreground , warning | Update all primaryColor references to primary in your theme configuration. New properties are optional but recommended for better visual control. |
| Mount Configuration | ambientOptions parameter is now required when mounting the SDK. You must provide at least one section defined using LOINC codes. | Previously optional in v1.x, now required in v2.0. You must provide ambientOptions with at least one section defined using LOINC codes when calling mount() . |

Last updated:
March 2026

## ​Overview

The v2.0.0 release of Suki.js includes significant improvements that enhance clinical documentation workflows and standardize healthcare integrations. This guide provides step-by-step instructions to migrate your integration from v1.x to v2.0.

### ​Improvements

The
`v2.0.0`
release adds new features and changes that enhance clinical documentation workflows. Key improvements include:
- Automatic provider registration
- Standardized LOINC codes for note sections
- Expanded theme customization options
- Improved section editing with dictation copy capabilities
- Enhanced error handling with better validation and reporting


## ​Migration steps

Follow these steps in order to migrate your integration from v1.x to v2.0.

### ​Step 1: Update package version

Update to the latest version of the Suki SDK:
- JavaScript
- React


```
pnpm add @suki-sdk/js@latest
```


```
pnpm add @suki-sdk/react@latest
```


### ​Step 2: Update provider initialization

Add the required provider information to your initialization configuration. The initialization process now requires additional provider information for automatic onboarding.
- JavaScript
- React


#### ​Before (v1.x)

JavaScript

```
import { initialize } from "@suki-sdk/js";

const sdkClient = initialize({
  partnerId: "your-partner-id",
  partnerToken: "your-token",
  enableDebug: true,
  theme: {
    primaryColor: "#4287f5",
  },
});
```


#### ​After (v2.0)

JavaScript

```
import { initialize } from "@suki-sdk/js";

const sdkClient = initialize({
  // Required partner details
  partnerId: "your-partner-id",
  partnerToken: "your-token",
  providerName: "Dr. John Q. Doe", // NEW: Required
  providerOrgId: "organization-id", // NEW: Required

  // Optional fields
  providerSpecialty: "FAMILY_MEDICINE", // NEW: Optional
  enableDebug: true,
  logLevel: "info", // NEW: Optional
  isTestMode: false, // NEW: Optional
  theme: {
    primary: "#4287f5", // CHANGED: renamed from primaryColor
    background: "#ffffff", // NEW: Optional
    secondaryBackground: "#f5f5f5", // NEW: Optional
    foreground: "#333333", // NEW: Optional
    warning: "#ff9900", // NEW: Optional
  },
});
```


#### ​Before (v1.x)

React

```
import { SukiProvider, useSuki } from "@suki-sdk/react";

const initOptions = {
  partnerId: "your-partner-id",
  partnerToken: "your-token",
  enableDebug: true,
  theme: {
    primaryColor: "#4287f5",
  },
};

function App() {
  const { init, isInitialized } = useSuki();

  useEffect(() => {
    if (!isInitialized) {
      init(initOptions);
    }
  }, [init, isInitialized]);

  return <div>Your app content</div>;
}
```


#### ​After (v2.0)

React

```
import { SukiProvider, useSuki } from "@suki-sdk/react";

const initOptions = {
  // Required partner details
  partnerId: "your-partner-id",
  partnerToken: "your-token",
  providerName: "Dr. John Q. Doe", // NEW: Required
  providerOrgId: "organization-id", // NEW: Required

  // Optional fields
  providerSpecialty: "FAMILY_MEDICINE", // NEW: Optional
  enableDebug: true,
  logLevel: "info", // NEW: Optional
  isTestMode: false, // NEW: Optional
  theme: {
    primary: "#4287f5", // CHANGED: renamed from primaryColor
    background: "#ffffff", // NEW: Optional
    secondaryBackground: "#f5f5f5", // NEW: Optional
    foreground: "#333333", // NEW: Optional
    warning: "#ff9900", // NEW: Optional
  },
};

function App() {
  const { init, isInitialized } = useSuki();

  useEffect(() => {
    if (!isInitialized) {
      init(initOptions);
    }
  }, [init, isInitialized]);

  return <div>Your app content</div>;
}
```


#### ​New required fields explained


### ​Step 3: Update ambient options configuration

Replace the deprecated
`prefill.noteTypeIds`
approach with the new LOINC-based section configuration. The ambient options structure has been completely redesigned to use standardized LOINC codes instead of custom note type IDs.
- JavaScript
- React


#### ​Before (v1.x)

JavaScript

```
sdkClient.mount({
  rootElement: document.getElementById("suki-root"),
  encounter: encounterDetails,
  ambientOptions: {
    prefill: {
      noteTypeIds: ["note-type-1", "note-type-2"],
    },
  },
});
```


#### ​After (v2.0)

JavaScript

```
sdkClient.mount({
  rootElement: document.getElementById("suki-root"),
  encounter: encounterDetails,
  ambientOptions: {
    sections: [
      {
        loinc: "29545-1", // Physical Examination
      },
      {
        loinc: "10164-2", // History of Present Illness
      },
      {
        loinc: "51847-2", // Assessment and Plan
        isPBNSection: true, // NEW: Problem-based charting support
      },
    ],
  },
});
```


#### ​Before (v1.x)

React

```
<SukiAssistant
  encounter={encounter}
  ambientOptions={{
    prefill: {
      noteTypeIds: ["note-type-1", "note-type-2"],
    },
  }}
  onNoteSubmit={(note) => {
    console.log("Note submitted:", note);
  }}
/>
```


#### ​After (v2.0)

React

```
<SukiAssistant
  encounter={encounter}
  ambientOptions={{
    sections: [
      {
        loinc: "29545-1", // Physical Examination
      },
      {
        loinc: "10164-2", // History of Present Illness
      },
      {
        loinc: "51847-2", // Assessment and Plan
        isPBNSection: true, // NEW: Problem-based charting support
      },
    ],
  }}
  onNoteSubmit={(note) => {
    console.log("Note submitted:", note);
  }}
/>
```

The
`prefill.noteTypeIds`
approach is still supported but deprecated and will be removed in future versions. We strongly recommend migrating to the new section-based configuration using LOINC codes.
Refer to the
Note sections documentation
for a complete list of supported sections and corresponding LOINC codes.

### ​Step 4: Update UI options

The
`uiOptions`
property now provides more granular control over the SDK’s user interface elements, including new section editing capabilities.
- JavaScript
- React


#### ​Before (v1.x)

JavaScript

```
sdkClient.mount({
  rootElement: document.getElementById("suki-root"),
  encounter: encounterDetails,
  ambientOptions: { /* ... */ },
  uiOptions: {
    showCloseButton: true,
    showCreateEmptyNoteButton: true,
  },
  onClose: () => {
    console.log("SDK closed");
  },
});
```


#### ​After (v2.0)

JavaScript

```
sdkClient.mount({
  rootElement: document.getElementById("suki-root"),
  encounter: encounterDetails,
  ambientOptions: { /* ... */ },
  uiOptions: {
    showCloseButton: true,
    showCreateEmptyNoteButton: true,
    showStartAmbientButton: true, // NEW: Control ambient button visibility
    sectionEditing: { // NEW: Section-level editing controls
      enableDictation: true, // NEW: Voice input for sections
      enableCopy: true, // NEW: Copy functionality
    },
  },
  onClose: () => {
    console.log("SDK closed");
  },
});
```


#### ​Before (v1.x)

React

```
<SukiAssistant
  encounter={encounter}
  ambientOptions={{ /* ... */ }}
  uiOptions={{
    showCloseButton: true,
    showCreateEmptyNoteButton: true,
  }}
  onClose={() => {
    console.log("SDK closed");
  }}
/>
```


#### ​After (v2.0)

React

```
<SukiAssistant
  encounter={encounter}
  ambientOptions={{ /* ... */ }}
  uiOptions={{
    showCloseButton: true,
    showCreateEmptyNoteButton: true,
    showStartAmbientButton: true, // NEW: Control ambient button visibility
    sectionEditing: { // NEW: Section-level editing controls
      enableDictation: true, // NEW: Voice input for sections
      enableCopy: true, // NEW: Copy functionality
    },
  }}
  onClose={() => {
    console.log("SDK closed");
  }}
/>
```


#### ​UI Options Reference

Use the UI configuration options to control the visibility and functionality of various interface elements like buttons and editing features.
You should only provide explicit values when you need to enable specific features. For example:
JavaScript

```
// Enable only the copy feature and showStartAmbientButton
uiOptions: {
  showStartAmbientButton: true,
  sectionEditing: {
    enableCopy: true
  }
}
```


### ​Step 5: Update note submission handling

Update your note submission handlers to work with the new response structure that includes LOINC codes and enhanced diagnosis information.

#### ​Before (v1.x)

JavaScript

```
onNoteSubmit: (note) => {
  console.log("Note ID:", note.noteId);
  note.contents.forEach((section) => {
    console.log(`Section: ${section.title} - ${section.content}`);
  });
}
```


#### ​After (v2.0)

JavaScript

```
onNoteSubmit: (note) => {
  console.log("Note ID:", note.noteId);
  note.contents.forEach((section) => {
    console.log(`Section: ${section.title} - ${section.content}`);
    console.log(`LOINC Code: ${section.loinc_code}`); // NEW: LOINC code included
    if (section.diagnosis) { // NEW: Enhanced diagnosis information
      console.log(`Diagnosis: ${section.diagnosis.icdDescription}`);
    }
  });
}
```


#### ​Example response structure

The note submission payload now includes LOINC codes for better standardization:
JSON

```
{
  "noteId": "82467ba8-71bc-46e2-8232-20d4d5629973",
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

Refer to
NoteContent
for the complete structure of the note content.

## ​Complete migration examples

Here are complete examples showing the migration from v1.x to v2.0:
- JavaScript
- React


```
import { initialize } from "@suki-sdk/js";

const encounterDetails = {
  identifier: "encounter-id",
  patient: {
    identifier: "patient-id",
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
  partnerId: "your-partner-id",
  partnerToken: "your-token",
  enableDebug: true,
  theme: {
    primaryColor: "#4287f5",
  },
});

const unsubscribeInit = sdkClient.on("init:change", (isInitialized) => {
  if (isInitialized) {
    sdkClient.mount({
      rootElement: document.getElementById("suki-root"),
      encounter: encounterDetails,
      ambientOptions: {
        prefill: {
          noteTypeIds: ["note-type-1", "note-type-2"],
        },
      },
      uiOptions: {
        showCloseButton: true,
        showCreateEmptyNoteButton: true,
      },
      onNoteSubmit: (note) => {
        console.log("Note submitted:", note.noteId);
      },
      onClose: () => {
        console.log("SDK closed");
      },
    });
  }
});
```


```
import React, { useEffect } from "react";
import { SukiAssistant, SukiProvider, useSuki } from "@suki-sdk/react";

const initOptions = {
  partnerId: "your-partner-id",
  partnerToken: "your-token",
  enableDebug: true,
  theme: {
    primaryColor: "#4287f5",
  },
};

const encounter = {
  identifier: "encounter-123",
  patient: {
    identifier: "patient-456",
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

function App() {
  const { init, isInitialized } = useSuki();

  useEffect(() => {
    if (!isInitialized) {
      init(initOptions);
    }
  }, [init, isInitialized]);

  return (
    <SukiAssistant
      encounter={encounter}
      ambientOptions={{
        prefill: {
          noteTypeIds: ["note-type-1", "note-type-2"],
        },
      }}
      onNoteSubmit={(note) => {
        console.log("Note submitted:", note.noteId);
      }}
      uiOptions={{
        showCloseButton: true,
        showCreateEmptyNoteButton: true,
      }}
      onClose={() => {
        console.log("SDK closed");
      }}
    />
  );
}

function AppWithProvider() {
  return (
    <SukiProvider>
      <App />
    </SukiProvider>
  );
}

export default AppWithProvider;
```


## ​Breaking changes reference

This section provides detailed information about each breaking change and its migration impact.

### ​Provider information

​
providerName
string
required
The provider’s full name. This field is now required during SDK initialization to enable automatic provider onboarding to the Suki system.
**Migration Impact**
: Previously optional, now required in
`InitializationConfig`
.
​
providerOrgId
string
required
The unique identifier for the provider’s organization. This field is now required during SDK initialization.
**Migration Impact**
: Previously optional, now required in
`InitializationConfig`
. This enables seamless provider registration without manual onboarding steps.

### ​AmbientOptions structure

The
`ambientOptions`
structure has been completely redesigned in v2.0. The previous
`prefill.noteTypeIds`
approach is deprecated.
​
sections
array
required
An array of section objects that define which note sections to generate. Each section is identified by a LOINC code for improved standardization and interoperability with healthcare systems.
**v1.x Deprecated approach**
:
TypeScript

```
ambientOptions: {
  prefill: {
    noteTypeIds: ['soap', 'hpi']
  }
}
```

**v2.0 Required approach**
:
TypeScript

```
ambientOptions: {
  sections: [
    { loinc: '48765-2' }, // Allergies
    { loinc: '10164-2' }  // History of Present Illness
  ]
}
```

**Migration impact**
: You must replace all
`noteTypeIds`
references with LOINC-based section configurations. Refer to the
Note sections documentation
for complete LOINC code mappings.

### ​Theme configuration

​
primary
string
Renamed from
`primaryColor`
. Defines the primary brand color for the SDK interface.
**Migration impact**
: Update all
`primaryColor`
references to
`primary`
in your theme configuration.
​
background
string
New property. Defines the main background color for the SDK interface.
**Migration impact**
: This is a new optional property that enhances UI customization capabilities.
​
secondaryBackground
string
New property. Defines the secondary background color for panels and cards within the SDK interface.
**Migration impact**
: This is a new optional property that provides more granular control over the visual hierarchy.
​
foreground
string
New property. Defines the primary text color for the SDK interface.
**Migration impact**
: This is a new optional property that ensures text readability across different background colors.
​
warning
string
New property. Defines the color used for warning messages and alerts.
**Migration impact**
: This is a new optional property that improves the visibility of important notifications.

### ​Mount configuration

​
ambientOptions
AmbientOptions
required
Configuration options for ambient mode functionality. This field is now required when mounting the SDK.
**Migration Impact**
: Previously optional in v1.x, now required in v2.0. You must provide
`ambientOptions`
with at least one section defined when calling
`mount()`
.
**Example**
:
TypeScript

```
await sukiSDK.mount({
  target: document.getElementById('suki-container'),
  ambientOptions: {
    sections: [
      { loinc: '48765-2' }
    ]
  }
});
```


## ​Troubleshooting


### ​Common migration errors


### ​Validation checklist

After migration, verify the following:
- All required provider information is supplied in initialization ( providerName and providerOrgId )
- AmbientOptions uses the new section-based configuration with LOINC codes
- Theme configuration uses the new property names ( primary instead of primaryColor )
- Section editing features are configured as needed ( sectionEditing.enableDictation and sectionEditing.enableCopy )
- All UI options are properly configured
- Note submission handlers account for new LOINC code fields ( section.loinc_code )


## ​Next steps


## Note Sections

Learn about supported LOINC codes and section configurations

## Specialties

View the complete list of supported medical specialties

## Error Handling

Implement proper error handling for your integration

## Basic Usage

See complete examples of the v2.0 implementation
Last modified on
April 1, 2026
Web SDK InstallationPrevious
Web SDK ChangelogNext
⌘
I
- Overview
- Improvements
- Migration steps
- Step 1: Update package version
- Step 2: Update provider initialization
- New required fields explained
- Step 3: Update ambient options configuration
- Step 4: Update UI options
- UI Options Reference
- Step 5: Update note submission handling
- Before (v1.x)
- After (v2.0)
- Example response structure
- Complete migration examples
- Breaking changes reference
- Provider information
- AmbientOptions structure
- Theme configuration
- Mount configuration
- Troubleshooting
- Common migration errors
- Validation checklist
- Next steps

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
