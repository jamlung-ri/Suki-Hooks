# Ambient Session Overview - Suki

**Source URL:** https://developer.suki.ai/web-sdk/guides/ambient

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

Quick summary
An ambient session captures patient-provider conversations and generates clinical notes in real-time. The SDK handles recording, note generation, and error handling automatically.


Manage sessions in two ways: uncontrolled mode where users interact only with SDK UI controls, or controlled mode where your EHR system controls when sessions start and stop through external triggers.
Last updated:
March 2026

## ​Overview

An ambient session captures patient-provider conversations and generates clinical notes in real-time. The SDK handles recording, note generation, and error handling automatically.
To generate notes, you must configure sections that organize the content. Use either predefined note types or
LOINC codes
. The SDK creates notes from the conversation using these configured sections.
LOINC code support is available in
**version 2.0**
and above. See the
note sections documentation
for supported codes. For older versions, contact support to configure note types.

## ​Session management in Web SDK

Manage ambient sessions in the Web SDK in two ways:

## Uncontrolled Mode

Users interact only with SDK UI controls. The SDK manages the session lifecycle automatically.

## Controlled Mode

Your EHR system controls the session lifecycle (start, stop, resume) through external triggers. The SDK handles recording and note generation while your app controls when sessions start and stop.

## ​Ambient guides


## Implementation

Controlled session management and updating encounter or ambient options.

## Session Status

Lifecycle events and status flags for ambient sessions.

## Problem-Based Charting

Enable PBC and pass existing patient diagnoses.

## Multilingual Support

Use multiple languages in ambient sessions.

## Offline Mode

How sessions behave during network interruptions.

## Re-Ambient & Recovery

Continue existing notes and recover abandoned sessions.
Last modified on
April 1, 2026
Web SDK ChangelogPrevious
Ambient ImplementationNext
⌘
I
- Overview
- Session management in Web SDK
- Ambient guides

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
