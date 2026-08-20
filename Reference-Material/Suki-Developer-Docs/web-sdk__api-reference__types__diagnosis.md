# Diagnosis Type - Suki

**Source URL:** https://developer.suki.ai/web-sdk/api-reference/types/diagnosis

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

Diagnosis type represents the structure for clinical diagnosis information, including ICD codes. The code snippet below shows how to use the
`Diagnosis`
type to create a diagnosis object.
JavaScript

```
type Diagnosis = {
  icdCode: string;
  icdDescription: string;
  snomedCode: string;
  snomedDescription: string;
  hccCode: string;
  panelRanking: number;
  billable: boolean;
  problemLabel: string;
  suggestionType: "DEFAULT" | "ED" | "PL";
};
```


## ​Properties

Last modified on
March 23, 2026
NoteContent TypePrevious
SukiError TypeNext
⌘
I
- Overview
- Properties

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
