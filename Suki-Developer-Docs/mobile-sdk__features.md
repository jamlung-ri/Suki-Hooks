# Mobile SDK Capabilities - Suki

**Source URL:** https://developer.suki.ai/mobile-sdk/features

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

The Suki Mobile SDK lets you add AI-powered clinical documentation to your iOS healthcare app. It’s a
**headless SDK**
, which means you build your own user interface while using Suki’s backend features for recording conversations and generating clinical notes.
**What can you do with the Mobile SDK?**
- Record conversations : Capture patient-provider conversations using the device microphone
- Generate clinical notes : Automatically create structured clinical documentation from conversations
- Work offline : Continue recording even when the network is unstable or unavailable
- Manage sessions : Control when recording starts, stops, pauses, and resumes
- Stay secure : All data is encrypted and HIPAA-compliant

**How it works:**
The Mobile SDK handles the complex parts, audio recording, transcription, and note generation, while you focus on building your app’s user interface. You call SDK methods to start and stop recording, and the SDK handles everything else in the background.

## ​Core capabilities


### ​Session management

You control the entire lifecycle of clinical documentation sessions:
**What you can do:**

## Create sessions

Start a new session with patient information, clinical sections (LOINC codes), and provider details

## Control recording

Start, pause, resume, end, or cancel recording at any time

## Update context

Change patient information or session details during an active session

## Support multiple languages

Enable multilingual support so patients can speak in their preferred language
**Example workflow:**
$!
/$
Always provide
**complete patient context**
(demographics, visit type, etc.) when creating sessions. This helps Suki generate more accurate and relevant clinical notes.

### ​Offline mode

The Mobile SDK keeps working even when the network is unstable or unavailable.
**How offline mode works:**
$!
/$
**Why this matters:**
Clinicians often work in areas with poor network coverage (hospitals, clinics, remote locations). Offline mode ensures they can continue documenting without interruption, and their data syncs automatically when connectivity returns.
The
**15-second**
buffer gives you time to show a “Connection unstable” message in your UI before the session enters full offline mode.

### ​AI-powered note generation

Suki’s AI automatically transforms conversations into structured clinical notes.
**What gets generated:**

## Structured sections

Notes organized by clinical sections you specify (using LOINC codes)

## Real-time updates

See content being generated as the conversation happens

## Medical accuracy

Uses healthcare-specific terminology and context

## Formatted output

Clean, professional notes ready for EHR integration
**Example:**
During a conversation, the AI might generate:
- History of Present Illness : “Patient presents with 3-day history of chest pain…”
- Assessment : “Acute coronary syndrome, rule out myocardial infarction”
- Plan : “Order EKG, cardiac enzymes, consider cardiac catheterization”

The SDK handles all the complex AI processing; you just retrieve the final note when the session ends.

### ​Problem-Based Charting (PBC)

When your integration uses
**Problem-Based Charting**
, pass the patient’s existing diagnoses with
`SukiAmbientConstant.kDiagnosisInfo`
in
`setSessionContext`
, and retrieve suggested diagnoses after the session with
`getStructuredData(for:)`
.

### ​Configuration options

The SDK offers flexible configuration to match your app’s needs:
**Environment settings:**
- Choose development, staging, or production environments
- Configure endpoints and API URLs

**Recording options:**
- Enable or disable background recording (when app is minimized)
- Control audio quality and encoding settings

**Authentication:**
- Secure token management with automatic refresh
- Partner ID and provider information setup

**Event handling:**
- Use delegate patterns to receive real-time session updates
- Subscribe to events like recording started, paused, or note generated

**Example:**
Swift

```
// Set environment
SukiAmbientCoreManager.shared.environment = .production

// Configure background recording
let partnerInfo: [String: AnyHashable] = [
    SukiAmbientConstant.kPartnerId: "your-partner-id",
    // ... other config
]
```

This flexibility lets you adapt the SDK to your specific workflow and requirements.

### ​Security and HIPAA compliance

The Mobile SDK is built with healthcare-grade security to protect patient data.
**Security features:**
- End-to-end encryption : All audio and clinical data is encrypted during transmission and when stored
- HIPAA compliant : Designed to meet healthcare privacy and security requirements
- Secure authentication : Tokens are handled securely with automatic refresh
- Device protection : Offline data stored on the device is also encrypted

All audio data and clinical content is encrypted both in transit and when stored locally on the device.

### ​Real-time monitoring

Track session status and respond to events as they happen.
**What you can monitor:**
$!
/$
**How it works:**
The SDK uses a delegate pattern to broadcast events during a session’s lifecycle. You conform to the
`SukiAmbientSessionDelegate`
protocol and implement the
`sukiAmbient(sessionEvent:for:)`
method to receive real-time updates.
**Example events:**
- .started - Recording starts
- .paused - Recording is paused
- .resumed - Recording resumes
- .ended - Recording ends
- .suggestionsGenerated - Note content is ready
- .convertedToOfflineSession - Session goes offline
- .suggestionsGenerationFailed - Note generation fails


### ​Easy integration

The Mobile SDK is designed to be simple to integrate and use.
**Developer-friendly features:**
- Swift APIs : Native Swift interfaces that feel natural to iOS developers
- Clear documentation : Comprehensive guides and code examples
- Sensible defaults : Works out of the box with minimal configuration
- Production ready : Battle-tested SDK used in real healthcare applications
- Scalable : Works for small clinics or large hospital systems


## ​Next steps

Learn how to
Install the Mobile SDK
and
Create your first session
.
Last modified on
April 1, 2026
Mobile SDK OverviewPrevious
Mobile SDK InstallationNext
⌘
I
- Overview
- Core capabilities
- Session management
- Offline mode
- AI-powered note generation
- Problem-Based Charting (PBC)
- Configuration options
- Security and HIPAA compliance
- Real-time monitoring
- Easy integration
- Next steps

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
