# Web SDK Installation - Suki

**Source URL:** https://developer.suki.ai/web-sdk/installation

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

We have modularized the Suki Web SDK into
**framework-specific packages**
so you only need to install the one that fits your environment.
The SDK is built for modern JavaScript and requires an
[ES6 compatible browser](https://caniuse.com/?search=es6)
.

## ​Prerequisites

For the rest of this documentation, we will assume you have completed the
Partner onboarding
process and that:
- You have received your partnerId from Suki
- Your partner configuration includes a valid JWKS endpoint
- Your authentication token contains the correct user identifier (e.g., sub , email )


## ​Install the package


### ​For plain JavaScript

Use the
`@suki-sdk/js`
package for plain JavaScript projects or with frameworks like
**Vue**
,
**Angular**
, or
**Solid.js**
. This package provides the core SDK functionality without tying it to a specific UI library.
To install the package, run one of the following commands:

```
pnpm add @suki-sdk/js
```


### ​For React

For React applications, you should use the
`@suki-sdk/react`
package. It includes React-specific hooks and components that make it easy to integrate Suki’s functionality into your application.
To install the package, run one of the following commands:

```
pnpm add @suki-sdk/react
```


## ​Next steps

Read the
Quickstart guide
guide to get started with the Suki SDK.
Last modified on
April 1, 2026
Web SDK PrerequisitesPrevious
Migrating to Suki.js v2 Web SDKNext
⌘
I
- Overview
- Prerequisites
- Install the package
- For plain JavaScript
- For React
- Next steps

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
