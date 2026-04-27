# Providers Reference - Suki

**Source URL:** https://developer.suki.ai/web-sdk/api-reference/providers

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


## ​SukiProvider

The main provider component for the Suki SDK, which wraps your application and provides context for the SDK state and methods.
React

```
import { SukiProvider } from '@suki-sdk/react';

function App() {
  return (
    <SukiProvider>
      {/* Your application components */}
    </SukiProvider>
  );
}
```


## ​Available properties

​
children
ReactNode
The child components that will have access to the Suki SDK context

## ​Next steps

Refer to
Components section
for more information on the available components.
Last modified on
April 1, 2026
Hooks ReferencePrevious
Components ReferenceNext
⌘
I
- SukiProvider
- Available properties
- Next steps

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
