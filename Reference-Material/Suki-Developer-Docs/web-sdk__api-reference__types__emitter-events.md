# EmitterEvents Type - Suki

**Source URL:** https://developer.suki.ai/web-sdk/api-reference/types/emitter-events

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

EmitterEvents type represents the events that can be emitted by the web SDK for monitoring session state and handling responses. The code snippet below shows how to use the
`EmitterEvents`
type to create an emitter events object.
Version
`2.0.4`
of the Suki Web SDK updates the
`EmitterEvents`
type. Use these events to track granular details for authentication processes and ambient session lifecycles.

## ​Authentication events

The web SDK supports
**six new auth events**
that allow you to monitor registration and token refreshes:

## ​Ambient events

These additional events will help you monitor the state of the ambient session and handle responses accordingly.
JavaScript

```
type EmitterEvents = {
  ready: never;
  "init:change": boolean;
  close: never;
  // login events supported by the Web SDK
  "login:success": never; // New in v2.0.4
  "login:fail": SukiError;
  "register:success": never; 
  "register:fail": SukiError;
  "token-refresh:success": never;
  "token-refresh:fail": SukiError;
  "ambient:update": {
    ambientId: string;
    isAmbientInProgress: boolean;
    isAmbientPaused: boolean;
  };
  // lifecycle events supported by the Web SDK
  "ambient:start": { // New in v2.0.4
    ambientId: string;
  },
  "ambient:pause": {
    ambientId: string;
  },
  "ambient:resume": {
    ambientId: string;
  },
  "ambient:cancel": {
    ambientId: string;
  },
  "ambient:submit": {
    ambientId: string;
  }
  "note-submission:success": {
    noteId: string;
    contents: Array<{ title: string; content: NoteContent }>;
  };
  error: SukiError;
};
```

To identify the
`SUKIError`
from above events, refer to the
error codes
section for more information.

## ​Properties

Last modified on
April 1, 2026
LogLevel TypePrevious
NoteContent TypeNext
⌘
I
- Overview
- Authentication events
- Ambient events
- Properties

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
