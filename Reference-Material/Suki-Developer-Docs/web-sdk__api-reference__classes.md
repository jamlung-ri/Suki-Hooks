# Classes Reference - Suki

**Source URL:** https://developer.suki.ai/web-sdk/api-reference/classes

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

This section provides a detailed reference for all classes available in the Suki Web SDK.

## ​SDKClient instance

The
`SDKClientInstance`
is the primary interface for interacting with the Suki Web SDK, providing comprehensive methods for managing encounters, ambient sessions, and event subscriptions.
The code snippet below shows how to use the
`SDKClientInstance`
class to interact with the Suki Web SDK.
JavaScript

```
interface SDKClientInstance {
  activeAmbientId: string | null;
  attemptLogin(): Promise<true | void>;
  setPartnerToken(partnerToken: string): void;
  cancelAmbient(): void;
  cleanup(): void;
  destroy(): void;
  mount(options: MountOptions): Promise<void>;
  on<T extends keyof EmitterEvents>(
    type: T,
    handler: (data: EmitterEvents[T]) => void | Promise<void>,
  ): () => void;
  pauseAmbient(): void;
  resumeAmbient(): void;
  setAmbientOptions(options: AmbientOptions): void;
  setEncounter(encounter: Encounter): Promise<void>;
  startAmbient(): void;
  submitAmbient(): void;
}
```


### ​Properties

​
activeAmbientId
string | null
The ID of the currently active ambient session, or
`null`
if no session is active.

### ​Available methods


## ​Next steps

Refer to the
Functions
to learn more about the available functions in the Suki Web SDK.
Last modified on
April 1, 2026
SukiError TypePrevious
Functions ReferenceNext
⌘
I
- Overview
- SDKClient instance
- Properties
- Available methods
- Next steps

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
