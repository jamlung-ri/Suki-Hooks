# Mobile SDK Overview - Suki

**Source URL:** https://developer.suki.ai/mobile-sdk/overview

---

Sukihome page
Documentation
APIs
Release Notes
Sukihome page


##### Mobile SDK Overview

- Introduction
- Capabilities
- Installation
- Configuration
- Changelog


##### Mobile SDK Guides

- Create Ambient Session UPDATED
- Recording Controls
- Session Status & Content Retrieval
- Clearing Sessions
- Session Events & Delegates
- Offline Mode


##### FAQs

- General
- Installation & Setup
- Session Management
- Content retrieval
- Offline and networking
- Troubleshooting


## ​Overview

Suki Mobile SDK is a headless SDK for iOS applications. It provides
intelligence capabilities that you can integrate directly into your native iOS app.
Use the mobile SDK to capture clinical conversations, generate notes automatically, and streamline documentation workflows.

## ​Mobile SDK capabilities

With just a few lines of code, you can use the SDK to:
- Capture Conversations : Enable hands-free, real-time ambient transcription of clinical conversations.
- Generate Notes : Automatically transform conversations into structured clinical documentation using Suki’s AI.
- Problem-Based Charting (PBC) : Support problem-oriented notes and structured diagnoses by passing diagnosis context in setSessionContext and reading structured output when the session completes. See the Problem-Based Charting guide and Create session .
- Manage Sessions : Handle the entire session lifecycle seamlessly within your application.
- Ensure Security : All data processing is handled with HIPAA-grade privacy and security.

Refer to the
Mobile SDK capabilities
page for more details on the capabilities of the Mobile SDK.

## ​Guide navigation

To get started with the Mobile SDK, you can follow the guides in the following order:
| Guide | Purpose | Key capabilities |
| --- | --- | --- |
| Create session | Session initialization and context setup | Patient info, clinical sections, multilingual support, PBC diagnosis context ( kDiagnosisInfo ) |
| Recording controls | Recording lifecycle management | Start, pause, resume, end, cancel operations |
| Session status & content retrieval | Content generation monitoring and retrieval | Status checking, content fetching, error handling |
| Offline mode | Network resilience and offline capabilities | 15-second buffer, local storage, auto-sync |
| Session events & delegates | Real-time event handling | Delegate pattern, event types, UI integration |
| Clearing sessions | Session cleanup and data privacy | User logout, data clearing, memory management |


## ​Mobile SDK workflow

The diagram below shows the complete ambient session workflow and how you can use the Mobile SDK to manage the session lifecycle.
$!
/$

## ​Next steps

To begin the integration, follow our
Installation guide
.
If you need access to the SDK, please contact our
[Partnership team](https://www.suki.ai/suki-partners/)
.
Once you have installed the SDK, start with
Create session
to begin implementing the ambient session workflow, then follow the guides in sequence to build a complete integration.
Last modified on
April 1, 2026
Mobile SDK CapabilitiesNext
⌘
I
- Overview
- Mobile SDK capabilities
- Guide navigation
- Mobile SDK workflow
- Next steps

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
