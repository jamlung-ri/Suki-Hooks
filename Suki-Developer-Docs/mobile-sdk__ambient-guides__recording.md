# Recording Controls - Suki

**Source URL:** https://developer.suki.ai/mobile-sdk/ambient-guides/recording

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
The Mobile SDK provides recording control methods to manage the full lifecycle of an ambient session. Use
`start`
,
`pause`
,
`resume`
,
`end`
, and
`cancel`
to control recordings with full state management.


Each method handles errors and returns results asynchronously. The SDK manages session state transitions automatically, so you can update your UI based on the current state and handle errors appropriately.
Last updated:
March 2026

## ​Overview

The
**Mobile SDK**
provides you the capability to manage the full lifecycle of an ambient session using the following recording controls. These methods allow you to
**start**
,
**pause**
,
**resume**
, and
**stop**
a recording with full state management.

### ​What will you learn?

In this guide, you will learn how to:
- Handle the recording lifecycle using the start , pause , resume , end , and cancel methods.
- Handle errors from the recording control methods.
- Understand the best practices for handling user interactions with the recording controls.


## ​Prerequisites

Before calling any of these methods, always ensure the SDK is
**initialized**
and a session has been
**created**
to prevent runtime errors.
iOS does not allow an app to start a recording while it is in the background. If you attempt this, the SDK will throw an
`appIsNotActive`
error. You should handle this case by notifying the user.

## ​Recording controls

These are the recording controls that are available in the
**Mobile SDK**
:

### ​Start recording

Begin capturing audio by calling the
`start`
method. This transitions the session into the
`Recording`
state.

---

$!
/$

---


```
do {
    // Begins the recording process for the active session.
    try SukiAmbientCore.shared.start()
} catch {
    // Handle potential errors, e.g., session not initialized.
    print(error)
}
```


### ​Pause recording

To temporarily stop capturing audio while keeping the session active, call the
`pause`
method. This transitions the session into the
`Paused`
state.

```
do {
    // Pauses the current recording. The session remains active.
    try SukiAmbientCore.shared.pause()
} catch {
    // Handle errors, e.g., no active recording to pause.
    print(error)
}
```


### ​Resume recording

If a session is paused, you can call the
`resume`
method to continue capturing audio. This transitions the session into the
`Recording`
state.

```
do {
    // Resumes a paused recording.
    try SukiAmbientCore.shared.resume()
} catch {
    // Handle errors, e.g., the session was not in a paused state.
    print(error)
}
```


### ​End session

To stop the recording and begin the content generation process, call the
`end`
method. This is the standard way to complete a session successfully.

```
do {
    // Ends the recording and triggers the note generation process.
    try SukiAmbientCore.shared.end()
} catch {
    // Handle errors, e.g., the session was already ended.
    print(error)
}
```


### ​Cancel session

To stop the recording and discard all captured data, call the
`cancel`
method. This action cannot be
**undone**
.

```
do {
    // Stops the recording and aborts the session. No content will be generated.
    try SukiAmbientCore.shared.cancel()
} catch {
    // Handle potential errors.
    print(error)
}
```


## ​Error handling

All recording control methods can throw a
`SukiAmbientCoreError`
. You must use a
**do-catch**
block to handle potential issues, such as calling a method from an invalid state.

## ​FAQs


## ​Next steps

After you have started a recording, you can proceed to the
Session status & retrieve content
guide to check the status of the session and retrieve the generated content.
Last modified on
April 1, 2026
Create SessionPrevious
Session Status & Retrieve ContentNext
⌘
I
- Overview
- What will you learn?
- Prerequisites
- Recording controls
- Start recording
- Pause recording
- Resume recording
- End session
- Cancel session
- Error handling
- FAQs
- Next steps

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
