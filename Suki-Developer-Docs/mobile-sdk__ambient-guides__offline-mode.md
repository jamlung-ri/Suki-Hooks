# Offline Mode - Suki

**Source URL:** https://developer.suki.ai/mobile-sdk/ambient-guides/offline-mode

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

Quick summary
The Mobile SDK has an offline mode to keep your application working during network problems. When the SDK enters offline mode, it continues to record and store audio securely on the device, saves all session events, and automatically uploads everything when the connection returns.


The SDK uses a 15-second buffer to handle temporary connection problems before switching to offline mode. This gives you time to show a notification in your UI before the session goes fully offline.
Last updated:
March 2026

## ​Overview

The
**Mobile SDK**
has an
**offline**
mode to keep your application working during network problems. This ensures a session is not interrupted if the device loses its internet connection.

### ​What will you learn?

In this guide, you will learn how to:
- Handle network interruptions gracefully using the offline mode.


## ​What happens in offline mode

When the SDK enters
**offline**
mode, it handles everything in the background so the user is not interrupted. The SDK will:
- Continue to record and store audio securely on the device.
- Save all session events that happen during the outage.
- Automatically upload all saved audio and events when the connection returns.

The SDK notifies your app about these status changes using
**session delegate**
events.

### ​Network buffer feature

Before, the SDK used to directly jump into offline mode when it detected a small network issue. This was not ideal as it would interrupt the user experience.
To address this, the mobile SDK uses a
**15-second buffer**
to handle temporary connection problems. This gives you time to show a notification in your UI, like
**Connection unstable**
, before the session goes fully offline. This is important to ensure a smooth user experience.

## ​Common causes for offline mode

A session can enter
**offline**
mode for several reasons:
- Poor or lost Wi-Fi or cellular connectivity.
- The device switches between networks (e.g., Wi-Fi to cellular).
- A temporary problem with the backend service.
- A dropped connection while streaming audio.
- An issue with an authentication token.

**Important notes**
Keep the following key features of
**offline**
mode in mind:
- The SDK manages all transitions between offline and online modes automatically.
- Audio quality and session integrity are always maintained.
- The SDK can queue multiple offline sessions and will upload them in order once a connection is available.
- All data stored locally on the device is encrypted and secure.
- Offline recording is optimized to conserve battery life.

Last modified on
March 23, 2026
Session Events & DelegatesPrevious
GeneralNext
⌘
I
- Overview
- What will you learn?
- What happens in offline mode
- Network buffer feature
- Common causes for offline mode

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
