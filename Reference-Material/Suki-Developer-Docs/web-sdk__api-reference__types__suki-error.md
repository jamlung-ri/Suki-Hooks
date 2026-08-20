# SukiError Type - Suki

**Source URL:** https://developer.suki.ai/web-sdk/api-reference/types/suki-error

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

- Types Types Overview Encounter Patient InitOptions PartnerDetails ThemeOptions MountOptions UIOptions SectionEditingOptions AmbientOptions UPDATED Section LogLevel EmitterEvents NoteContent Diagnosis SukiError
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

SukiError type represents the structure for SDK errors. The code snippet below shows how to use the
`SukiError`
type to create a suki error object.
JavaScript

```
type SukiError = {
  code: ErrorCode;
  details: ErrorDetail;
};
```


## ​Properties


## ​ErrorCode identifier

ErrorCode represents the unique identifiers for different types of SDK errors. The following table lists the available error code identifiers and their descriptions.
| Code | Name | Category | Description |
| --- | --- | --- | --- |
| SUKI0001 | init:sdk-init-failed | Initialization | SDK initialization failed |
| SUKI0002 | init:auth-failed | Authentication | User authentication failed |
| SUKI0003 | init:mount-failed | Initialization | SDK mounting to DOM failed |
| SUKI0004 | init:messenger-failed | Initialization | Internal messaging system failed |
| SUKI0005 | init:invalid-options | Initialization | Invalid initialization options provided |
| SUKI0006 | navigate:failed | Navigation | Navigation within SDK failed |
| SUKI0007 | create-appointment:failed | Encounter | Failed to create appointment/encounter |
| SUKI0008 | get-appointment:failed | Encounter | Failed to retrieve appointment/encounter |
| SUKI0009 | create-patient:failed | Patient | Failed to create patient record |
| SUKI0010 | update-patient:failed | Patient | Failed to update patient information |
| SUKI0011 | get-patient:failed | Patient | Failed to retrieve patient information |
| SUKI0012 | note-submission:failed | Notes | Failed to submit clinical note |
| SUKI0013 | ambient-fail | Ambient | Ambient session operation failed |
| SUKI0014 | encounter-fail | Encounter | General encounter operation failed |
| SUKI0015 | token-update-fail | Authentication | Failed to update partner token |
| SUKI0016 | unsupported-loinc-codes | Configuration | Provided LOINC codes are not supported |
| SUKI0017 | no-supported-loinc-codes | Configuration | No supported LOINC codes found in configuration |
| SUKI0018 | multiple-pbn-sections | Configuration | Multiple sections marked as PBN (Problem-Based Note) |


## ​ErrorDetail

ErrorDetail represents the detailed information about a specific error. The code snippet below shows how to use the
`ErrorDetail`
type to create an error detail object.
JavaScript

```
type ErrorDetail = {
  name: `init:sdk-init-failed` | `init:auth-failed` ...;
  message: string;
  reason?: ErrorReasons;
}
```


### ​ErrorDetail properties


## ​ErrorReasons

ErrorReasons represents the specific reasons that provide additional context for why an error occurred.
JavaScript

```
type ErrorReasons =
  | "lib-error"
  | "no-init"
  | "no-partner-token"
  | "missing-partner-details"
  | "no-init-or-auth"
  | "service-error"
  | "already-started"
  | "no-ambient"
  | "ambient-in-progress"
  | "invalid-encounter"
  | "unsupported-loinc-codes"
  | "no-supported-loinc-codes"
  | "multiple-pbn-sections";
```

The below table lists the available error reasons and their descriptions.
| Reason | Category | Description |
| --- | --- | --- |
| already-started | State | Operation attempted when already in progress |
| ambient-in-progress | Ambient | Cannot perform action while ambient session is active |
| invalid-encounter | Data | Provided encounter data is invalid or malformed |
| lib-error | System | Internal library or system error |
| missing-partner-details | Configuration | Required partner authentication details are missing |
| multiple-pbn-sections | Configuration | Multiple sections marked as PBN when only one is allowed |
| no-ambient | State | No ambient session available for operation |
| no-init | State | SDK not initialized before operation attempted |
| no-init-or-auth | Authentication | SDK not initialized or user not authenticated |
| no-partner-token | Authentication | Partner token is missing or invalid |
| no-supported-loinc-codes | Configuration | No supported LOINC codes found |
| service-error | Network | External service or API error |
| unsupported-loinc-codes | Configuration | Provided LOINC codes are not supported |


## ​Example

JavaScript

```
const error = {
  code: "SUKI0001",
  details: {
    name: "init:sdk-init-failed",
    message: "SDK initialization failed",
    reason: "lib-error"
  }
};
```

Last modified on
April 1, 2026
Diagnosis TypePrevious
Classes ReferenceNext
⌘
I
- Overview
- Properties
- ErrorCode identifier
- ErrorDetail
- ErrorDetail properties
- ErrorReasons
- Example

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
