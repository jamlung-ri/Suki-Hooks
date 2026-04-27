# Ambient Events - Suki

**Source URL:** https://developer.suki.ai/web-sdk/examples/ambient-events

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

The Web SDK emits events when the ambient session state changes. Listen for these events to track the state of the ambient session and handle responses accordingly.
For more information, refer to the
Emitter-events-type
section.

## ​Code example

The example below demonstrates how to listen for ambient events in the web SDK.
React

```
import { SukiAssistant, SukiProvider, useSuki } from "@suki-sdk/react";

function MyComponent() {
  const { on, activeAmbientId } = useSuki();

  useEffect(() => {
    const handleAmbientUpdate = (event) => {
      console.log("Ambient event received:", event);
    };

    // Subscribe to ambient update events
    const unsubscribe = on("ambient-update", handleAmbientUpdate);

    // Cleanup subscription on unmount
    return () => {
      unsubscribe();
    };
  }, [on]);

  return (
    <>
      Active Ambient ID: {activeAmbientId}
      <SukiAssistant
      // props
      />
    </>
  );
}
```


## ​Next steps

Refer to the
Test mode
example to learn how to use the test mode in the web SDK.
Last modified on
April 1, 2026
Dynamic EncounterPrevious
Test ModeNext
⌘
I
- Overview
- Code example
- Next steps

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
