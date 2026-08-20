# Functions Reference - Suki

**Source URL:** https://developer.suki.ai/web-sdk/api-reference/functions

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

This section provides a detailed reference for all functions available in the Suki Web SDK.

## ​Initialize function

The
`initialize`
function is used to initialize the SDK with the provided options and returns a configured client instance.
The code snippet below shows how to use the
`initialize`
function to initialize the SDK with the provided options and returns a configured client instance.
JavaScript

```
import { initialize } from "@suki-sdk/js";

initialize(options: InitOptions): SDKClientInstance
```

Initializes the SDK with the provided options and returns a configured client instance.

### ​Parameters

​
options
InitOptions
required
The configuration options required to initialize the SDK.

### ​Returns

It returns a
SDKClientInstance
- The initialized SDK client instance is ready for use.

## ​Next steps

Refer to
Hooks
for more information on the available hooks.
Last modified on
April 1, 2026
Classes ReferencePrevious
Hooks ReferenceNext
⌘
I
- Overview
- Initialize function
- Parameters
- Returns
- Next steps

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
