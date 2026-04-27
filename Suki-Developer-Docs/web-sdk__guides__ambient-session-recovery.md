# Re-Ambient & Session Recovery - Suki

**Source URL:** https://developer.suki.ai/web-sdk/guides/ambient-session-recovery

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


## ​Re-ambient sessions

Each ambient session creates a new note, even if the patient and encounter identifiers are the same. To continue working on an existing note:
1

Open existing note

Open the existing note in the SDK UI.
2

Initiate re-ambient

Start a re-ambient session from the note interface.
3

Intelligent merge

The SDK intelligently merges the new session content with existing note content, allowing seamless continuation.

## ​Session recovery

If the app crashes or a session is abandoned (not cancelled or submitted), the Web SDK automatically recovers the last ambient session when the app loads again.

### ​What gets recovered


### ​Best practices

Always submit or cancel the active ambient session when users navigate away from the encounter. This prevents unintended session recoveries.
**Recommendation:**
Show a confirmation dialog before navigation so users can decide whether to continue or discard the session.

## ​Next steps

- Offline behavior: Offline mode
- Note submission: Note management
- Return to Ambient session overview

Last modified on
April 1, 2026
Offline ModePrevious
Note ManagementNext
⌘
I
- Re-ambient sessions
- Session recovery
- What gets recovered
- Best practices
- Next steps

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
