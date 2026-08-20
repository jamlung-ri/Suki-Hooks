# Web SDK Changelog - Suki

**Source URL:** https://developer.suki.ai/web-sdk/product-updates/changelog

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

Suki’s SDK versioning policy is based on the semantic versioning standard. For example, in version 1.2.3, 1 is the major version, 2 is the minor version, and 3 is the patch version.
When we release a new SDK version for new features or bug fixes, we increment one of these three version components depending on the type of change introduced.
​
v2.2.0
Enhancements
API Changes
April 2026

### ​Enhancements

- Added additional context parameters : Pass optional session-level metadata in ambientOptions to improve note generation accuracy. Pass the following parameters along with LOINC codes at session init (in mount or setAmbientOptions ): visitType : Enum values include NEW_PATIENT , ESTABLISHED_PATIENT , WELLNESS , ED . encounterType : Enum values include AMBULATORY , INPATIENT , ED . providerRole : Enum values include PRIMARY/ATTENDING , CONSULTING . reasonForVisit : String, maximum 255 characters. chiefComplaint : String, maximum 255 characters.
- All new parameters are optional ; absence does not break existing flows.
- Free text fields ( reasonForVisit , chiefComplaint ) enforce a 255-character limit .

**Code example**

```
{
  "ambientOptions": {
    "visitType": "ESTABLISHED_PATIENT", 
    "encounterType": "AMBULATORY",
    "providerRole": "PRIMARY/ATTENDING",
    "reasonForVisit": "Follow-up for hypertension",
    "chiefComplaint": "Headache"
  }
}
```

- Cutom note titles from visit type : When you pass visitType in ambientOptions , the Web SDK uses that value as the title for the generated note in the in-product patient note list, instead of the generic Note label. That makes it easier for clinicians to tell multiple notes apart on the same day. If visitType is omitted, the UI keeps the previous generic title behavior.

​
v2.1.2
Enhancements
March 2026

### ​Enhancements

- Notification Webhook : The Web SDK now supports notification webhook. Receive notifications about session completion or failure by implementing your own webhook endpoint.
Learn more about how webhook work and how to implement your own webhook endpoint to receive them in the Notification webhook for partners documentation.
- Existing patient diagnoses for Problem-Based Charting : Pass the patient’s existing diagnoses (e.g. from the EMR) into an ambient session using the diagnoses block in ambientOptions . The session merges them with what’s discussed during the visit so you avoid duplicate problems in the note. Use this when you have at least one PBC section ( isPBNSection: true ); each diagnosis needs one ICD-10 code. Refer to the Existing patient diagnoses guide for more details.

​
v2.1.1
Enhancements
Removed
Jan 2026

### ​Enhancements

- Multilingual capability : The Web SDK now supports multilingual capability by default. Patients and providers can speak in their preferred language; the SDK generates the clinical note in English. No configuration is required, and you do not need to contact Technical Support to enable this feature.
- Optional patient fields : The birthDate and gender properties are now optional in the Patient type. Omit these fields when creating patient objects if the information isn’t available, making it easier to integrate patient data from systems where this information may be missing.


### ​Removed

- AmbientOptions : The prefill.noteTypeIds property is no longer supported in the AmbientOptions type. You must use the sections property instead.

​
v2.1.0
New Features
Nov 2025

### ​New features

- Telehealth audio capture : Capture audio directly from separate tabs from the same browser window hosting your telehealth session. This ensures accurate ambient clinical documentation during virtual visits via Zoom, Teams, and other telehealth platforms.

This feature is an
**opt-in setting**
and is
**disabled by default**
. To enable this feature, follow the steps in the
Telehealth guide
.
​
v2.0.4
Enhancements
Sep 2025

### ​Enhancements

- Enhanced event monitoring : Added 6 new authentication events and 5 new ambient session lifecycle events to the EmitterEvents type. These events provide granular visibility into login, registration, token refresh, and session state changes, helping you build better error handling and user feedback in your application.
- Improved offline handling : Offline mode now includes a 15-second buffer to handle temporary connection problems. This gives you time to show connection status notifications in your UI before the session transitions to offline mode, improving the user experience during brief network interruptions.
- User feedback collection : Collect user feedback on AI-generated content directly through the SDK. This helps you gather insights on note quality and user satisfaction.

​
v2.0.3
New Features
Bug Fixes
June 2025

### ​New features

- Bearer token authentication : Added support for Bearer token authentication by allowing you to pass providerId during SDK initialization. This provides more flexibility for authentication workflows.

main.js

```
import { initialize } from "@suki-sdk/js";

initialize({
  partnerId: "your-partner-id",
  partnerToken: "your-partner-token",
  providerId: "provider-id"
});
```

App.tsx

```
import { useSuki } from "@suki-sdk/react";

const { init } = useSuki();

useEffect(() => {
  init({
    partnerId: "your-partner-id",
    partnerToken: "your-partner-token",
    providerId: "provider-id"
  });
}, []);
```


### ​Bug fixes

- Fixed incorrect isAmbientInProgress and isAmbientPaused flags in ambient:update events
- Fixed activeAmbientId not resetting in the useSuki hook after a session is submitted or cancelled


### ​Additional changes

- Removed insert script option from section editing in the note page

​
v2.0.2
New Features
May 2025

### ​New features

- Problem-based charting support : Added support for problem-based charting (PBN) with LOINC codes. Use the isPBNSection property in your ambientOptions to enable problem-based note generation for specific sections.


```
{
  "ambientOptions": {
    "sections": [
      {
        "loinc": "10164-2", // History of Present Illness
        "isPBNSection": true
      }
    ]
  }
}
```

Read more about problem-based charting in the
Ambient guide
.
​
v2.0.1
Enhancements
May 2025

### ​Enhancements

- Updated default UI options : Updated default values for uiOptions to match the latest UI configuration. Close button, start ambient button, dictation, copy, and insert script features are now enabled by default, while the create empty note button is disabled by default.

​
v2.0.0
Major Changes
April 2025

### ​Major changes

- Automated user registration : Programmatically create organizations and users during SDK initialization, reducing manual setup and accelerating onboarding workflows.
- LOINC code integration : Standardize note sections using LOINC codes, improving note quality, scalability, and integration consistency across healthcare systems.
- Expanded theme customization : Enhanced theme options with additional properties for greater control over SDK appearance. Refer to the Theming guide for examples and customization options.

​
v1.0.3
Bug Fixes
February 2025

### ​Bug fixes

- Various bug fixes and stability improvements

​
v1.0.2
Bug Fixes
December 2024

### ​Bug fixes

- Various bug fixes and stability improvements

​
v1.0.1
Bug Fixes
December 2024

### ​Bug fixes

- Various bug fixes and stability improvements

​
v1.0.0
New Features
December 2024

### ​New features

- Initial stable release : Enhanced user experience with visual improvements, faster note generation, and improved stability

​
v0.5.0
New Features
July 2024

### ​New features

- Initial release : Clinical note creation by listening to provider-patient conversations

Last modified on
April 1, 2026
Migrating to Suki.js v2 Web SDKPrevious
Ambient Session OverviewNext
⌘
I
Filters
$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
