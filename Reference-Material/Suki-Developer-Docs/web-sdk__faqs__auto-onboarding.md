# Automatic User Onboarding - Suki

**Source URL:** https://developer.suki.ai/web-sdk/faqs/auto-onboarding

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

Starting from version 2.0.0, the Suki SDK introduces an
**auto onboarding**
feature to simplify the initial setup for new users. With this feature, a provider account is automatically created the first time a new user interacts with the SDK, eliminating the need for manual setup.

## ​How auto onboarding works

When the SDK is mounted, it uses the
`patient.identifier`
to check if a provider already exists in the Suki system:
- If the provider does not exist , the SDK will automatically create one.
- If the provider already exists , the SDK will use the existing provider data.

This behavior also extends to
**new organizations**
. If the specified organization does not exist, it will be created automatically using the
`providerOrgId`
provided during SDK initialization.
To support auto onboarding of organizations, ensure that the
`providerOrgId`
is always provided during SDK initialization.
Last modified on
March 23, 2026
Theming and CustomizationPrevious
GeneralNext
⌘
I
- How auto onboarding works

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
