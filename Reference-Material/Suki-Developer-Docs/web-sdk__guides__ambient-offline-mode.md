# Offline Mode - Suki

**Source URL:** https://developer.suki.ai/web-sdk/guides/ambient-offline-mode

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

The Web SDK supports offline mode so ambient sessions continue during network interruptions. When the connection is lost, recording continues and audio is stored locally until connectivity is restored.
The SDK uses a
**15-second buffer**
before transitioning to offline mode. Use this delay to display a connection status notification (for example,
**Connection unstable**
) in your UI before the session goes fully offline.

## ​What triggers offline mode

A session enters offline mode due to:
- Network interruptions
- Backend unavailability
- High latency in audio transmission
- Socket connection drops
- Authentication failures


## ​Offline mode behavior

When the session enters offline mode, the SDK automatically:

## Continues Recording

Audio recording continues without interruption during network issues.

## Local Storage

Audio and metadata are stored locally on the device.

## Automatic Upload

Stored data is automatically uploaded once connection is restored.

## User Notification

Users are notified about offline status and reconnection attempts.
During offline mode,
**session submission is temporarily paused**
. The SDK will continuously attempt to reconnect and submit the note once connectivity is reestablished.

## ​Next steps

- Re-ambient and recovery: Session recovery
- Multilingual: Multilingual support
- Return to Ambient session overview

Last modified on
April 1, 2026
Multilingual SessionsPrevious
Re-Ambient & Session RecoveryNext
⌘
I
- What triggers offline mode
- Offline mode behavior
- Next steps

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
