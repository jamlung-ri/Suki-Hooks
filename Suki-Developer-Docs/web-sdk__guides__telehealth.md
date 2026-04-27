# Telehealth - Suki

**Source URL:** https://developer.suki.ai/web-sdk/guides/telehealth

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

Quick summary
Telehealth sessions allow you to capture audio from different tabs on a browser window for remote patient care. This feature is opt-in and disabled by default.


The SDK supports audio capture from different tabs in the same browser window (with or without a headset), but does not support audio capture from local or native desktop applications like standalone Zoom or Teams apps.
Last updated:
March 2026

## ​Overview

Telehealth sessions are a special type of ambient session that you can use for remote patient care. The Suki Web SDK (version
`2.1.0`
and later) supports capturing audio from different tabs directly from your browser.
**Compatibility**
:
- Supported : Audio capture from different tabs in the same browser window (with or without a headset).
- Not Supported : Audio capture from local or native desktop applications (e.g., a standalone Zoom or Teams app).


## ​How to enable telehealth feature

Enable the Telehealth Audio Capture feature in the Suki Web SDK UI.
Telehealth Audio Capture feature is an
**opt-in setting**
and is
**disabled by default**
.
To enable Telehealth Audio Capture feature, follow these steps:
1

Navigate to Settings

In the Suki Web SDK UI, navigate to the
**Ambient Settings**
option.
2

Turn on telehealth audio capture

Turn on the
**Enable audio from web**
toggle button.

## ​How it works

When you enable Telehealth Audio Capture and click Start Ambient or Re-Ambient, the SDK prompts you to share your screen.
You must select the browser tab that contains your telehealth call.
In the browser’s share modal, you must also select the
**Also Share Tab Audio**
(or similar) checkbox.

### ​Session behavior

The following are the different states of the ambient session when telehealth audio capture is enabled:

## On Pause

If you close the shared tab or click the browser’s
**Stop Sharing**
button, the ambient session will automatically pause.

## On Resume

To restart the session, click
**Resume**
in the SDK. This action will open the browser’s share modal again.

## On Window/Screen Selection

The SDK uses experimental browser APIs to capture audio. While you must share a tab, selecting a Window or Screen by mistake should not result in an error.

## ​Recommendations for partners

For the best compatibility and performance, follow these recommendations:
- Use the latest version of Google Chrome.
- Use browser-based telehealth workflows.
- When you use the browser’s Share screen modal, you may see an option to share system audio if you select a specific window or your entire screen.

Suki does not officially support sharing
**system audio**
. While these options may appear and might be experimentally available in different browsers or operating systems, they are inconsistent and may not function correctly.
Suki only supports sharing
**tab audio**
. You must ensure that you select a browser tab and enable the tab audio option when prompted.

## ​Error handling


## ​Next steps

Refer to
Branding
guide to learn more about how to brand the Suki Web SDK.
Last modified on
April 1, 2026
Token RefreshPrevious
Branding and LayoutNext
⌘
I
- Overview
- How to enable telehealth feature
- How it works
- Session behavior
- Recommendations for partners
- Error handling
- Next steps

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
