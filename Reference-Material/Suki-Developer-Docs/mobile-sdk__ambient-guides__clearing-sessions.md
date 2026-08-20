# Clearing Sessions - Suki

**Source URL:** https://developer.suki.ai/mobile-sdk/ambient-guides/clearing-sessions

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
The
`clear()`
method removes all locally stored Suki sessions from the device. The primary use case is to clear user-specific data when a user signs out of your application, ensuring data privacy and preparing the SDK for a new user session.


You cannot call
`clear()`
during an active session; it will throw an error. Always ensure no sessions are active before calling this method.
Last updated:
March 2026

## ​What will you learn?

In this guide, you will learn how to:
- Clear all locally stored Suki sessions from the device by calling the clear() method.
- Handle errors from the clear() method.


## ​Clear all sessions

Remove all locally stored Suki sessions from the device by calling the
`clear()`
method.
The primary use case for this method is to
**clear user-specific data**
when a user
**signs out**
of your application. This ensures data privacy and prepares the SDK for a new user session.
Do not call the
`clear()`
method during an
**active session**
; this will throw an error.

```
do {
    // Removes all persisted session data from the device.
    try SukiAmbientCore.shared.clear()
} catch {
    // Handle potential errors.
    print(error)
}
```


## ​FAQs


## ​Next steps

After you clear the sessions, proceed to our
Session events & delegates
guide to listen to the session events.
Last modified on
April 1, 2026
Session Status & Retrieve ContentPrevious
Session Events & DelegatesNext
⌘
I
- What will you learn?
- Clear all sessions
- FAQs
- Next steps

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
