# Quickstart Guide - Suki

**Source URL:** https://developer.suki.ai/documentation/getting-started

---

Sukihome page
Documentation
APIs
Release Notes
Sukihome page


##### Get Started

- Overview
- Quickstart
- Learning Path
- Choose Your Integration


##### Onboarding & Authentication

- Partner Onboarding
- Partner Authentication


##### Product Capabilities

- Ambient Documentation
- Note Sections
- Specialties
- Problem-Based Charting (PBC) UPDATED
- Multilingual Support
- Note Personalization
- Dictation
- Audio Streaming & Download NEW


##### Guides

- Notification Webhook
- MCP Integration
- Executive Summary
- Technical Execution Guide


##### Help & Support

- Support
- FAQs
- Glossary


## ​Overview

This quickstart guide will help you integrate Suki’s ambient documentation capabilities into your healthcare application. You’ll go from initial setup to your first successful
in just a few steps.

### ​What you’ll accomplish

By completing this guide, you will:
- Set up authentication with Suki Platform
- Choose and integrate your preferred SDK or API
- Create your first ambient session with patient information
- Record and stream audio for at least 1 minute
- Retrieve a fully structured clinical note with transcript

**Estimated Time:**
30-45 minutes
**New to Suki?**
Consider following our comprehensive
Learning path
for a structured, step-by-step journey from onboarding to production deployment with progress tracking and time estimates.

## ​What you need before starting

To integrate your application with Suki Platform, you must meet the following requirements:

## OAuth-compliant authentication system

For secure user management

## JWT tokens with consistent user identifiers

For user authentication

## Publicly accessible JWKS endpoint

For token validation

## ES6 compatible browser

Modern browser support (for Web SDK)

## ​Required information from Suki

You’ll need the following from Suki to get started:
- Partner ID : Unique identifier provided by Suki


## ​How authentication works

Suki supports the following public key sharing authentication mechanisms. You will use your own identity provider to issue the token.
- Stored Secret - You provide your public key to Suki, and we store it securely in our database as an encrypted file.
- JWKS URL : You host your public keys at a public JSON Web Key Set ( JWKS ) endpoint, and Suki fetches them dynamically to verify tokens.
- Okta - You use Okta as your Identity Provider, and Suki obtains the public key from your Okta issuer URL.
- JWT Assertion - You share your public key as a signed JWT that follows the RFC 7523 standard. Suki then verifies this JWT using our public key.

Refer to the
Partner onboarding
and
Partner authentication
guides for more information.
**Need Access?**
If you don’t have the required information yet, contact our
[partnership team](https://www.suki.ai/suki-partners/)
to begin the onboarding process.

## ​Step 1: Choose your integration path

Select the integration method that best fits your application requirements: Refer to the
Integration decision guide
to help you decide.

## Web SDK

**Best for:**
React/JavaScript web applications
Pre-built UI components with automatic state management

## Mobile SDK

**Best for:**
Native iOS applications
Native framework optimized for mobile audio capture

## Direct APIs

**Best for:**
Custom implementations
Maximum flexibility with direct API control

## ​Step 2: Integration setup for API and SDKs

Once you have chosen your integration method, select an option below. The setup guide for your chosen path will appear on this page.
- Web SDK
- Mobile SDK
- Direct APIs

1

Install the package

Choose the appropriate package for your framework:
- JavaScript
- React

Bash

```
npm install @suki-sdk/js
```

Bash

```
npm install @suki-sdk/react
```

2

Initialize SDK

Wrap your app with
`SukiProvider`
and initialize the SDK:

```
import { initialize } from "@suki-sdk/js";

  const sdkClient = initialize({
    partnerId: "f80c8db8-a4d0-4b75-8d63-56c82b5413f0", // Replace with your actual partner ID
    partnerToken:
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWUsImlhdCI6MTUxNjIzOTAyMn0.KMUFsIDTnFmyG3nMiGM6H9FNFUROf3wh7SmqJp-QV30", // Replace with your actual partner token
    providerName: "John doe", // Replace with the full name of the provider
    providerOrgId: "1234", // Replace with the provider's organization ID
  });
```

3

Mount UI

In the same component where you initialized the SDK, mount the
`SukiAssistant`
component with encounter data:

```
import { initialize } from "@suki-sdk/js";

      // replace this with your actual encounter data
      const encounterDetails = {
        identifier: "6ec3920f-b0b1-499d-a4e9-889bf788e5ab",
        patient: {
          identifier: "905c2521-25eb-4324-9978-724636df3436",
          name: {
            use: "official",
            family: "Doe",
            given: ["John"],
            suffix: ["MD"],
          },
          birthDate: "1990-01-01",
          gender: "Male",
        },
      };

      const sdkClient = initialize({
        partnerId: "f80c8db8-a4d0-4b75-8d63-56c82b5413f0", // Replace with your actual partner ID
        partnerToken:
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWUsImlhdCI6MTUxNjIzOTAyMn0.KMUFsIDTnFmyG3nMiGM6H9FNFUROf3wh7SmqJp-QV30", // Replace with your actual partner token
        providerName: "John doe", // Replace with the full name of the provider
        providerOrgId: "1234", // Replace with the provider's organization ID
      });

      const unsubscribeInit = sdkClient.on("init:change", (isInitialized) => {
        if (isInitialized) {
          sdkClient.mount({
            rootElement: document.getElementById("suki-root"), // The root element to mount the SDK into
            encounter: encounterDetails,
          });
        }
      });

      // unsubscribe from the init event when no longer needed
      window.addEventListener("beforeunload", () => {
        unsubscribeInit();
      });
```

4

Start recording

Click the recording button in the Suki web SDK UI to start capturing the conversation.
5

Record for at least 1 minute

Record a test conversation. The session should be at least
**1 minute long**
for note generation to occur.
6

Stop and retrieve note

Click stop recording button in the Suki web SDK UI. The generated note will automatically appear in the web SDK UI panel.
For complete web SDK capabilities, refer to the
Web SDK section
of the documentation.
1

Install the framework

Add the Suki Mobile SDK to your iOS project following the
Installation guide
.
2

Initialize the SDK

Configure the SDK when your application starts:

```
import SukiAmbientCore

// Set the SDK environment
SukiAmbientCoreManager.shared.environment = .stage

// Initialize the SDK with partner information
let partnerInfo: [String: AnyHashable] = [
    SukiAmbientConstant.kPartnerId: "your-partner-id",
    SukiAmbientConstant.kProviderInfo: [
        SukiAmbientConstant.kOrgId: "provider_org_id",
        SukiAmbientConstant.kName: "Dr. Jane Smith",
        SukiAmbientConstant.kId: "providerId",
        SukiAmbientConstant.kSpeciality: "FAMILY_MEDICINE"
    ]
]

do {
    try SukiAmbientCore.shared.initialize(
        withPartnerInfo: partnerInfo,
        with: true,
        onCompletion: { result in
            // Handle initialization result
        },
        withSessionDelegate: self,
        withTokenProvider: self
    )
} catch {
    print("Initialization failed: \(error)")
}
```

3

Create session

Initialize an ambient session with patient information:

```
let sessionContext = [
        SukiAmbientConstant.kSessionId: <encounter-id>,
        SukiAmbientConstant.kIsMultilingual:isMultingual
    ] as [String : AnyHashable]        
    SukiAmbientCoreManager.shared.createSession(with: sessionContext, onCompletion: { result in
        switch result {
        case .success(let sessionResponse):
            print("Success")
        case .failure(let error):
            Print("error = \(error)")
        }
    })
```

4

Start recording

Begin capturing the clinical conversation:

```
do {
    try SukiAmbientCore.shared.start()
} catch {
    print("Recording failed: \(error)")
}
```

5

Record for at least 1 minute

Capture audio for at least
**1 minute**
to ensure note generation occurs.
6

End session

Stop the recording and trigger note generation:

```
do {
    try SukiAmbientCore.shared.end()
} catch {
    print("End session failed: \(error)")
}
```

7

Retrieve generated content

Get the generated clinical note and transcript:

```
// Get the recording ID from the session
let recordingId = sessionId // Use the session ID as recording ID

// Retrieve content
SukiAmbientCore.shared.content(for: recordingId) { result in
    switch result {
    case .success(let suggestions):
        print("Generated Note: \(suggestions)")
    case .failure(let error):
        print("Failed to retrieve content: \(error)")
    }
}

// Retrieve transcript
SukiAmbientCoreManager.shared.transcript(for: recordingId) { result in
    switch result {
    case .success(let response):
        let transcriptText = (response.finalTranscript ?? []).compactMap { $0.transcript }.joined(separator: " ")
        print("Transcript: \(transcriptText)")
    case .failure(let error):
        print("Failed to retrieve transcript: \(error)")
    }
}
```

For complete mobile SDK capabilities, refer to the
Mobile SDK section
of the documentation.
1

Authenticate and get token

Get your access token by calling the login endpoint: If not registered in Suki, you will need to call the register endpoint first. Call the
Register
endpoint to register a new user.

```
curl -X POST https://sdp.suki.ai/api/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "partner_id": "your-partner-id",
    "partner_token": "your-jwt-token",
    "provider_id": "provider-123"
  }'
```

Save the
`suki_token`
from the response. This token is valid for
**1 hour**
and must be included as
`sdp_suki_token`
header for all subsequent API calls.
2

Create ambient session

Start a new ambient session:

```
curl -X POST https://sdp.suki.ai/api/v1/ambient/session/create \
  -H "sdp_suki_token: YOUR_SUKI_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "ambient_session_id": "123dfg-456dfg-789dfg-012dfg",
    "encounter_id": "123dfg-456dfg-789dfg-012dfg",
    "multilingual": false
  }'
```

Save the
`ambient_session_id`
from the response. You’ll need it to stream audio and retrieve content.
3

Stream audio via WebSocket

Connect to the WebSocket endpoint to stream audio in real-time:

```
curl --request GET \
--url https://sdp.suki-stage.com/ws/stream \
--header 'ambient_session_id: <ambient_session_id>' \
--header 'sdp_suki_token: <sdp_suki_token>'
```

For non-browser clients, use separate headers:
`sdp_suki_token`
and
`ambient_session_id`
in the WebSocket upgrade request.
4

End session

Signal that the conversation is over to trigger note generation:

```
curl -X POST "https://sdp.suki.ai/api/v1/ambient/session/YOUR_SESSION_ID/end" \
  -H "sdp_suki_token: YOUR_SUKI_TOKEN"
```

5

Retrieve generated content

After ending the session, wait a few seconds for processing, then fetch the clinical note:

```
curl -X GET "https://sdp.suki.ai/api/v1/ambient/session/YOUR_SESSION_ID/content?cumulative=false" \
  -H "sdp_suki_token: YOUR_SUKI_TOKEN"
```

**Session Duration Requirement**
Your ambient session must be
**at least 1 minute long**
for note generation to occur. Sessions shorter than 1 minute will receive a
`SKIPPED`
status, meaning no clinical note was generated.
For complete API capabilities, refer to the
API reference
of the documentation.

### ​Verify success

After completing your first session, you should see:
**For Web SDK:**
- The generated clinical note automatically appears in the Suki UI panel
- Sections are organized according to your LOINC configuration
- Transcript is available within the UI

**For Mobile SDK:**
- Call content() and transcript() to retrieve the note and transcript respectively
- Check the session status to confirm successful completion
- Access structured sections and conversation transcript programmatically

**For Direct API:**
- GET request to /api/v1/ambient/session/{ambient_session_id}/content returns: summary - Array of structured clinical note sections
- GET request to /api/v1/ambient/session/{ambient_session_id}/transcript returns: final_transcript - Complete conversation transcript with speaker identification
- GET request to /api/v1/ambient/session/{ambient_session_id}/status returns: status - Session status ( created , ready , running , aborted , skipped , failed , completed )


## ​Step 3: Advanced configuration (optional but recommended)

Configure the generated note in many ways. For example, to generate a customized clinical note, refer to the
LOINC codes
to define the sections you want to generate.

```
{
  "sections": [
    {
      "loinc": "10164-2",
      "title": "History of Present Illness"
    },
    {
      "loinc": "51847-2", 
      "title": "Assessment and Plan"
    }
  ]
}
```


## ​Next steps


## Ambient Documentation Guide

Learn more about how ambient documentation works

## Authentication Setup

Understand how to authenticate your application with Suki

## Note Sections

Customize clinical note structure and LOINC codes

## API Reference

Explore detailed API specifications

## ​Success checklist

Before moving to production, ensure you have successfully completed these steps:

## ​Troubleshooting


### ​Common issues


### ​Getting help

- Technical Issues: Review our FAQs
- Integration Support: Contact our Support team
- Partnership Questions: Reach out to our Partnership team

Last modified on
April 1, 2026
Suki For Partners OverviewPrevious
Developer Learning PathNext
⌘
I
- Overview
- What you’ll accomplish
- What you need before starting
- Required information from Suki
- How authentication works
- Step 1: Choose your integration path
- Step 2: Integration setup for API and SDKs
- Verify success
- Step 3: Advanced configuration (optional but recommended)
- Next steps
- Success checklist
- Troubleshooting
- Common issues
- Getting help

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
