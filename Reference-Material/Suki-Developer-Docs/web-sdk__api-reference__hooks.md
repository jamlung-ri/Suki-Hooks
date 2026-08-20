# Hooks Reference - Suki

**Source URL:** https://developer.suki.ai/web-sdk/api-reference/hooks

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

This section provides a detailed reference for all React hooks available in the Suki Web SDK.

## ​useSuki hook

The
`useSuki`
hook is a React hook for managing SDK state and operations within React components.
The code snippet below shows how to use the
`useSuki`
hook to access SDK state and methods:
Typescript

```
const client: UseSukiReturn = useSuki();
```


### ​Returns

It returns a
UseSukiReturn
object containing SDK state and methods for ambient session management.

## ​UseSukiReturn type

Return type of the
`useSuki`
hook containing SDK state and methods.
JavaScript

```
type UseSukiReturn = {
  activeAmbientId: string | null;
  attemptLogin: () => void;
  cancelAmbient: () => void;
  error: SukiError | null;
  init: (options: ReactInitOptions) => void;
  isAmbientInProgress: boolean;
  isAmbientPaused: boolean;
  isInitialized: boolean;
  on: <T extends keyof EmitterEvents>(
    type: T,
    handler: (args: EmitterEvents[T]) => void | Promise<void>,
  ) => () => void;
  pauseAmbient: () => void;
  resumeAmbient: () => void;
  setEncounter: (encounter: Encounter) => Promise<void>;
  setPartnerToken: (partnerToken: string) => void;
  startAmbient: () => void;
  submitAmbient: () => void;
};
```


### ​Available properties


### ​Available methods


## ​Next steps

Refer to the
Provider types
to learn more about the provider types.
Last modified on
April 1, 2026
Functions ReferencePrevious
Providers ReferenceNext
⌘
I
- Overview
- useSuki hook
- Returns
- UseSukiReturn type
- Available properties
- Available methods
- Next steps

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
