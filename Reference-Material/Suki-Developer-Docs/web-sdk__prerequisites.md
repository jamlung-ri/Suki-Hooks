# Web SDK Prerequisites - Suki

**Source URL:** https://developer.suki.ai/web-sdk/prerequisites

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

This guide outlines the technical requirements your application must meet to integrate with the Suki Platform web SDK.

### ​Browser support

Your application must use a browser that is
**ES6-compatible**
. Check the full compatibility list
[here](https://caniuse.com/?search=es6)
.

### ​Authentication requirements

Your authentication system must meet the following requirements:
- It must be OAuth-compliant.
- It must provide a JWT token that contains a consistent, unique user identifier.
- It must have a publicly accessible JWKS endpoint for token signature validation.

For more information on the authentication requirements, refer to the
Partner authentication
guide.

## ​Information you must provide

As a Suki development partner, you must provide the following items to your Suki contact before you can integrate the Suki Web SDK:
- Partner name : A unique name that identifies your EMR/EHR.
- JWKS endpoint : The publicly accessible URL that Suki will use to validate the signature on user JWT tokens. This is provided by your identity provider.
- User identifier field : The specific key name in your JWT token that uniquely identifies a user. This can be email, username, userId, sub, or another field that represents the user uniquely in your system.
- Host URLs : The public URLs for your test and production client applications where you will embed the Suki Web SDK. We need these URLs to add your application to our allowlist.


## ​Information you will receive from Suki

Before you can start the integration, your Suki contact will provide you with the following:
- Partner ID : A unique identifier issued by Suki. You must send this partnerId when you initialize the Suki Web SDK.

For more information on the information you will receive from Suki, refer to the
Partner onboarding
guide.
Last modified on
April 1, 2026
Web SDK QuickstartPrevious
Web SDK InstallationNext
⌘
I
- Overview
- Browser support
- Authentication requirements
- Information you must provide
- Information you will receive from Suki

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
