# Web SDK Overview - Suki

**Source URL:** https://developer.suki.ai/web-sdk

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

The Suki Web SDK provides
**pre-built UI components**
and
**React hooks**
that let you seamlessly integrate
intelligence capabilities directly into your web application.
Because this SDK includes all necessary user interface elements, you can quickly embed Suki’s ambient intelligence capabilities without having to design the frontend yourself.
To integrate Suki’s AI capabilities, use
**Suki.js**
, our core
**JavaScript/TypeScript SDK**
. This package provides the essential methods and events for embedding the Suki Web SDK into your application.
With the Suki Web SDK, you can add features like:
- Ambient note generation
- Medical transcription
- Note management


## ​Supported platforms

The SDK is supported on the following platforms:

## React

The SDK is supported on React.
Install the Suki Web SDK for React:

## Vanilla JavaScript

The SDK is supported on Vanilla JavaScript.
Install the Suki Web SDK for Vanilla JavaScript:

## Other Frameworks

The SDK is supported on other frameworks like Vue, Angular, etc.
While it is optimised for
**React**
, you can also easily integrate it with
**vanilla JavaScript**
or other frameworks.

## ​How it works

The following diagram illustrates the Web SDK architecture and workflow:
$!
/$

### ​Architecture workflow


Client Side (Your Web Application)

- Your React, JavaScript, or web app that integrates the SDK
- Core SDK package that handles authentication, session management, and communication
- Pre-built UI for recording, transcription, and note display


Suki Backend

- Validates partner credentials (Partner ID and token)
- Manages audio streaming and processing
- Processes audio in real-time and generates structured clinical notes


Data Flow

- Initialize SDK with partner credentials → Authenticate with suki backend
- Mount pre-built UI with encounter data
- User starts recording → SDK streams audio to Ambient Service
- AI Engine processes audio and generates notes
- Results return through Suki Backend → UI displays the note and transcript


## ​Key features


## Ambient Note Generation

The SDK allows you to automatically capture spoken patient encounters and generate structured clinical notes in real time.

## Medical Transcription

Integrate high-accuracy medical transcription that supports specialty-specific terminology and multiple languages and accents.

## Note Management

The SDK includes features for managing clinical notes within your application.

## ​Key benefits

The web SDK provides the following benefits:

## ​Next steps

Refer to our
Installation guide
to get started with the Suki SDK.
Last modified on
April 1, 2026
Web SDK QuickstartNext
⌘
I
- Overview
- Supported platforms
- How it works
- Architecture workflow
- Key features
- Key benefits
- Next steps

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
