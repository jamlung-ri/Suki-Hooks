# Session Status & Events - Suki

**Source URL:** https://developer.suki.ai/web-sdk/guides/ambient-session-status

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

- Ambient Session Ambient Session Overview Implementation UPDATED Session Status PBC UPDATED Multilingual Offline Re-Ambient & Recovery
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

The Web SDK emits events to track ambient session status in real-time. The
`ambient:update`
event includes an
`ambientId`
field, which is the unique identifier for the session. Use this ID to track the session lifecycle. For details, see
emitter events types
.

## ​Lifecycle events

The Web SDK emits these events when the session state changes:
- ambient:start - Emitted when a new ambient session is started.
- ambient:pause - Emitted when the ambient session is paused.
- ambient:resume - Emitted when the ambient session is resumed.
- ambient:cancel - Emitted when the ambient session is cancelled.
- ambient:submit - Emitted when the ambient session is submitted.

- JavaScript
- React

JavaScript

```
sdkClient.on("ambient:update", (flags) => {
  console.log("Ambient in progress:", flags.isAmbientInProgress);
  console.log("Ambient paused:", flags.isAmbientPaused);
});
// lifecycle events supported by the Web SDK
sdkClient.on("ambient:start", (ambientSessionId) => {  // New in v2.0.4
console.log("Ambient started:", ambientSessionId);
});
```

React

```
import { useSuki } from "@suki-sdk/react";
import { useEffect } from "react";

const MyComponent = () => {
  const { on } = useSuki();

  useEffect(() => {
    const unsubscribe = on("ambient:update", (flags) => {
      console.log("Ambient in progress:", flags.isAmbientInProgress);
      console.log("Ambient paused:", flags.isAmbientPaused);
    });


    return () => unsubscribe();
  }, [on]);

  return <div>App Content</div>;
};
```


## ​Status flags

​
isAmbientInProgress
boolean
Returns
`true`
if an ambient session is currently active (started and not cancelled or submitted).
​
isAmbientPaused
boolean
Returns
`true`
if the ambient session is currently in a paused state.

## ​Next steps

- Implement controlled sessions: Ambient implementation
- Configure problem-based notes: PBC
- Return to Ambient session overview

Last modified on
April 1, 2026
Ambient ImplementationPrevious
Problem-Based Charting and Existing Patient DiagnosesNext
⌘
I
- Lifecycle events
- Status flags
- Next steps

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
