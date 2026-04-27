# Session Events & Delegates - Suki

**Source URL:** https://developer.suki.ai/mobile-sdk/ambient-guides/events-and-delegates

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
The SDK uses a delegate pattern to broadcast important events during a session’s lifecycle. By conforming to the
`SukiAmbientSessionDelegate`
protocol and implementing
`sukiAmbient(sessionEvent:for:)`
, you receive real-time updates about session state changes.


Use a switch statement to handle specific events like
`.started`
,
`.paused`
,
`.suggestionsGenerated`
, or
`.convertedToOfflineSession`
to update your UI or handle errors accordingly.
Last updated:
March 2026

## ​Overview

The SDK uses a delegate pattern to broadcast important events that occur during a session’s lifecycle. By conforming to the
`SukiAmbientSessionDelegate`
protocol, you can receive real-time updates and respond to state changes in your application, such as
**updating your UI**
or
**handling errors**
.

### ​What will you learn?

In this guide, you will learn how to:
- Use the SukiAmbientSessionDelegate protocol.
- Implement the sukiAmbient(sessionEvent:for:) method .
- Use a switch statement to handle the events that are relevant to your application.


## ​How to implement the session delegate


#### ​1. Conform To The Protocol

First, declare that your class conforms to the
`SukiAmbientSessionDelegate`
protocol. You must also pass an
**instance**
of this delegate class when you initialize the SDK.

#### ​2. Implement The Delegate Method

Next, implement the
`sukiAmbient(sessionEvent:for:)`
method. The SDK calls this method every time a new session event occurs, providing the event type and the associated
`recordingId`
.
Use a
**switch statement**
within this method to handle the events that are relevant to your application.

```
extension YourViewController: SukiAmbientSessionDelegate {
    func sukiAmbient(sessionEvent event: SukiAmbientCore.SessionEvent, for recordingId: SukiAmbientCore.RecordingId) {
        // This method receives all session events for a given recording ID.
        print("Received event: \(event) for recording ID: \(recordingId)")

        // Use a switch statement to handle specific events.
        switch event {
        case .started:
            // Update your UI to show that recording has started.
            break
        case .suggestionsGenerated:
            // Notify the user that their note is ready.
            break
        case .convertedToOfflineSession:
            // Inform the user about the network issue.
            break
        // Handle other cases as needed for your app's logic.
        default:
            break
        }
    }
}
```


## ​Available session events

The
`SessionEvent`
enum provides the following cases, which are grouped by category for clarity.

#### ​Recording lifecycle

​
SessionEvent
enum
Recording lifecycle events for ambient sessions.

#### ​Content generation

​
SessionEvent
enum
Content generation events for note suggestions.

#### ​Offline mode & uploading

​
SessionEvent
enum
Offline mode and audio upload events.

#### ​Audio interruptions

​
SessionEvent
enum
Audio interruption events during recording.

#### ​All available session events cases

Below is the complete list of all available session events cases:

```
public enum SessionEvent {
    case started
    case resumed
    case paused
    case ended
    case cancelled
    case suggestionGenerationInProgress
    case suggestionsGenerated
    case suggestionsGenerationFailed
    case audioInterruptionStarted
    case audioInterruptionEnded
    case convertedToOfflineSession
    case pendingOfflineUpload
    case preparingOfflineUpload
    case uploadingAudio
    case audioUploadFailed
    case audioUploadAllRetryFailed
    case audioUploaded
    case processingUpload
    case processingUploadFailed
    case clearingBufferredAudio
    case clearedBufferredAudio
    case audioBufferFilled(withPercentage: Double) // New in v2.4.0
}
```


## ​FAQs

Last modified on
March 23, 2026
Clearing SessionsPrevious
Offline ModeNext
⌘
I
- Overview
- What will you learn?
- How to implement the session delegate
- 1. Conform To The Protocol
- 2. Implement The Delegate Method
- Available session events
- Recording lifecycle
- Content generation
- Offline mode & uploading
- Audio interruptions
- All available session events cases
- FAQs

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
