# Components Reference - Suki

**Source URL:** https://developer.suki.ai/web-sdk/api-reference/components

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

This section provides a detailed reference for all React components available in the Suki Web SDK.

## ​SukiAssistant component

The
`SukiAssistant`
is the main UI component that renders the Suki Assistant interface within your React application. It manages the
**display**
and
**interaction**
for ambient sessions.
The code snippet below shows how to use the
`SukiAssistant`
component to render the Suki Assistant interface within your React application.
React

```
import { SukiAssistant, SukiProvider } from '@suki-sdk/react';

function App() {
  return (
    <SukiProvider>
      <SukiAssistant
        // props
      />
    </SukiProvider>
  );
}
```


### ​Available props


### ​Type safety for onClose prop

The
`SukiAssistant`
component employs conditional typing to ensure type safety for the
`onClose`
prop, which is dynamically determined by the
`uiOptions.showCloseButton`
configuration:

## ​Next steps

Refer to the
Examples section
to learn more about how to use the Web SDK in your application.
Last modified on
April 1, 2026
Providers ReferencePrevious
Basic UsageNext
⌘
I
- Overview
- SukiAssistant component
- Available props
- Type safety for onClose prop
- Next steps

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
