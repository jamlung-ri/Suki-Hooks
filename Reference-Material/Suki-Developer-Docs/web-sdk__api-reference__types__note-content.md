# NoteContent Type - Suki

**Source URL:** https://developer.suki.ai/web-sdk/api-reference/types/note-content

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

NoteContent type represents the content structure for clinical notes, including optional diagnosis and LOINC code. The code snippet below shows how to use the
`NoteContent`
type to create a note content object.
JavaScript

```
type NoteContent = {
  title: string;
  content: string;
  diagnosis?: Diagnosis;
  loinc_code?: string;
};
```


## ​Properties

Last modified on
April 1, 2026
EmitterEvents TypePrevious
Diagnosis TypeNext
⌘
I
- Overview
- Properties

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
