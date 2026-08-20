# Encounter Type - Suki

**Source URL:** https://developer.suki.ai/web-sdk/api-reference/types/encounter

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

Encounter type represents a clinical encounter with patient information. The code snippet below shows how to use the
`Encounter`
type to create an encounter object.
JavaScript

```
type Encounter = {
  identifier?: string;
  patient: Patient;
};
```


## ​Properties

Last modified on
April 1, 2026
Types ReferencePrevious
Patient TypeNext
⌘
I
- Overview
- Properties

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
