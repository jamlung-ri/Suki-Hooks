# Mobile SDK Installation - Suki

**Source URL:** https://developer.suki.ai/mobile-sdk/installation

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


## ​Set up your environment

Follow these steps to install the
**Suki Mobile SDK**
and set up your development environment.
1

Download the framework

Download the
`SukiAmbientCore.framework`
file.
2

Add the framework to your project

Drag the
`SukiAmbientCore.framework`
file into your
**Xcode project navigator**
. In the dialog box that appears, select the
**Copy items if needed**
checkbox and click
**Finish**
.
3

Embed the framework

In your app’s target settings, navigate to the
**General**
tab and find the
**Frameworks, Libraries, and Embedded Content**
section. Change the setting for
`SukiAmbientCore.framework`
to
**Embed & Sign**
.
4

Add the NSMicrophoneUsageDescription key

Add the
`NSMicrophoneUsageDescription`
key to your
`Info.plist`
file. You
**must provide**
a value for this key that explains to the user why your app needs microphone access.
Apple requires this key and a descriptive string to access the device’s microphone for recording conversations.

## ​Next steps

After you install the SDK, proceed to our
Configuration guide
to start using the mobile SDK features.
Last modified on
April 1, 2026
Mobile SDK CapabilitiesPrevious
Mobile SDK ConfigurationNext
⌘
I
- Set up your environment
- Next steps

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
