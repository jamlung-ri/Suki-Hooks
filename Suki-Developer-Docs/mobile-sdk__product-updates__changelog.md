# Mobile SDK Changelog - Suki

**Source URL:** https://developer.suki.ai/mobile-sdk/product-updates/changelog

---

Sukihome page
Documentation
APIs
Release Notes
Sukihome page


##### Mobile SDK Overview

- Introduction
- Capabilities
- Installation
- Configuration
- Changelog


##### Mobile SDK Guides

- Create Ambient Session UPDATED
- Recording Controls
- Session Status & Content Retrieval
- Clearing Sessions
- Session Events & Delegates
- Offline Mode


##### FAQs

- General
- Installation & Setup
- Session Management
- Content retrieval
- Offline and networking
- Troubleshooting

Suki’s Mobile SDK versioning policy is based on the semantic versioning standard. For example, in version 1.2.3, 1 is the major version, 2 is the minor version, and 3 is the patch version.
When we release a new Mobile SDK version for new features or bug fixes, we increment one of these three version components depending on the type of change introduced.
​
v2.5.0
Enhancements
API Changes
Dec 2025

### ​Enhancements

- Enhanced visit context : Added support for visit-related metadata parameters in the setSessionContext method, including visit type, encounter type, provider role, reason for visit, and chief complaint. These parameters provide additional context to improve note generation accuracy and clinical relevance.


### ​API changes

- Extended setSessionContext method to accept new optional visit context parameters: visit_type : Enum values include “New Patient / Intake”, “Established patient”, “Wellness”, “ED” encounter_type : Enum values include “ambulatory”, “inpatient”, “ED” provider_role : Enum values include “Primary/Attending”, “Consulting” reason_for_visit : String parameter with a maximum of 255 characters chief_complaint : String parameter with a maximum of 255 characters
- All new parameters are optional ; existing flows continue to work without these parameters
- Free text fields ( reason_for_visit and chief_complaint ) enforce a 255-character limit

​
v2.4.0
New Features
Enhancements
Oct 2025

### ​New features

- User feedback collection : Added submitFeedback(_:for:onCompletion:) method to collect user feedback on AI-generated content, helping you gather insights on note quality and user satisfaction.
- Audio buffer monitoring : Added audioBufferFilled(withPercentage: Double) case to the session delegate to notify you when the audio buffer reaches a certain fill percentage. This helps you display connection status indicators in your UI.


### ​Enhancements

- Improved offline handling : Offline mode now includes a 15-second buffer to handle temporary connection problems. This gives you more time to show connection status notifications in your UI before the session fully transitions to offline mode.
- Enhanced getting started guide : Improved the getting started guide with a workflow diagram to help you understand the process of using the Suki Mobile SDK.

​
v2.3.0
New Features
Enhancements
Jul 2025

### ​New features

- Personalization preferences : Added setPersonalizationPreferences(_:completionHandler:) method to configure clinical note generation preferences. Customize verbosity levels and note section styles to match your clinical documentation needs.


### ​Enhancements

- Note customization options : Configure verbosity levels (concise, balanced, detailed) and note section styles (narrative or bulleted) for supported LOINC sections including History of Present Illness, Assessment, Plan, and Assessment & Plan.


### ​API changes

- New setPersonalizationPreferences(_:completionHandler:) method for configuring note generation preferences
- Preferences are persisted and automatically applied to all future note generations

​
v2.2.1
New Features
API Changes
Jul 2025

### ​New features

- Diagnosis context support : Added SukiAmbientConstant.kDiagnosisInfo parameter to setSessionContext for structured diagnosis context, improving note accuracy by providing relevant diagnosis information.
- Structured data retrieval : Introduced getStructuredData(for:onCompletion:) method to retrieve structured output data and diagnoses from completed sessions, enabling better integration with EHR systems.


### ​API changes

- Extended setSessionContext with diagnosis information support
- New getStructuredData method for accessing structured session output
- Supports ICD-10, IMO, and SNOMED code types

​
v2.2.0
New Features
Enhancements
API Changes
June 2025

### ​New features

- Session context method : Introduced setSessionContext(with:onCompletion:) method for setting patient, provider context, and LOINC codes after session creation, providing more flexibility in when you provide context information.


### ​Enhancements

- Improved session workflow : Separated patient, provider, and section context from createSession to a dedicated setSessionContext method, making the session creation process more streamlined.
- Enhanced LOINC integration : Enhanced section generation using LOINC codes with automatic clinical section creation. LOINC codes alone are sufficient: the SDK automatically generates appropriate clinical sections.


### ​API changes

- createSession method now focuses solely on session initialization
- Patient, provider, and section context should be set using setSessionContext
- LOINC codes alone are sufficient: SDK automatically generates appropriate clinical sections

​
v2.1.0
New Features
Enhancements
Bug Fixes
May 2025

### ​New features

- Audio buffering : Implemented audio buffering to reduce the number of offline sessions caused by brief internet interruptions, improving session continuity during temporary network issues.
- Multilingual support : Added SukiAmbientConstant.kMultilingual parameter to session creation for multilingual processing support, enabling accurate note generation for conversations in multiple languages.


### ​Enhancements

- Background recording handling : Added proper error handling when attempting to start recording while the app is backgrounded, providing clearer error messages and preventing unexpected behavior.


### ​Bug fixes

- Fixed “No record exist for offline upload” failure category identified through note failure tracing dashboard
- Improved session recovery reliability during network transitions

Last modified on
March 23, 2026
Mobile SDK ConfigurationPrevious
Create SessionNext
⌘
I
Filters
$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
