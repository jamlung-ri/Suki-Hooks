# Ambient API Quickstart - Suki

**Source URL:** https://developer.suki.ai/api-reference/quickstart

---

Sukihome page
Documentation
APIs
Release Notes
Sukihome page

- API Overview Quickstart User Authentication Security & Best Practices HTTPS Guidelines API Reference Guidelines FAQs Changelog


##### API References

- Authentication
- Ambient Session Management
- Dictation
- Ambient Content Retrieval
- User Preferences
- User Feedback
- Send Notifications
- Info


## ​Before you begin: access and credentials

You need partner credentials to use the Suki Ambient API.
Contact our
[Partnership team](https://www.suki.ai/suki-partners/)
to get your credentials. They will guide you through the
Onboarding process
and provide what you need to get started.

### ​Prerequisites

To use the Suki Ambient APIs, you must have the following:
- An OAuth-compliant authentication system
- JWT tokens with consistent user identifiers
- A publicly accessible JWKS endpoint (or Okta authorization server) for token validation

Refer to the
Partner onboarding
and
Partner authentication
guides for more details.

### ​Environments to use for development and testing

- Use https://sdp.suki.ai for production.
- For testing, use https://sdp.suki-stage.com (staging). The partnership team will confirm which environment and credentials to use.


## ​Suki Ambient APIs workflow

To integrate with the Suki
, you follow a session-based workflow.
$!
/$

## ​Getting started with Suki Ambient APIs


### ​Step 1: Authenticate and get token

To begin, you must authenticate to get your access token. Send a
**POST**
request to the
/api/v1/auth/login
endpoint with the following parameters in the request body:
- partner_id : Your unique Partner ID , which we provide to you securely offline.
- partner_token : The user’s OAuth 2.0 ID token ( Partner Token ) from your identity provider.
- provider_id (Optional): Unique identifier for the provider . Required for Bearer type partners only.

Suki verifies the
`partner_token`
using your publicly exposed
**JWKS endpoint**
(or your Okta authorization server URL if you use Okta). On a successful request, the API returns a
(
`suki_token`
) that you must include as the
`sdp_suki_token`
header for all subsequent API calls.
**Handling an unregistered user**
:
- If the user is not yet registered in our system, the /login request will fail.
- In this case, you must first call the /api/v1/auth/register endpoint to create the user, then call /login again.
- You only need to call the register endpoint once for each new user.
- Refer to the Register API reference for the full specification.


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
. When it is about to expire, you can get a new one by making the same
**POST**
request to
`/login`
with a valid
`partner_token`
.

### ​Step 2: Create ambient session

To start an ambient session, send a
**POST**
request to the
/api/v1/ambient/session/create
endpoint with the following parameters in the request body:
This guide uses
`encounter_id`
. In older versions of the API, this parameter was named
`session_group_id`
. The old name will be deprecated in a future release.
The
`multilingual`
parameter is deprecated. Multilingual support is now
**true**
by default for all Suki for Partner users.
- encounter_id (Optional): A unique identifier for the patient encounter (also called a visit). This can be any alphanumeric string up to 255 characters long.
- ambient_session_id (Optional): A UUID v4 to identify the session. If you do not provide one, Suki will generate it and include it in the response.


```
curl -X POST https://sdp.suki.ai/api/v1/ambient/session/create \
  -H "sdp_suki_token: YOUR_SUKI_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "ambient_session_id": "123dfg-456dfg-789dfg-012dfg",
    "encounter_id": "123dfg-456dfg-789dfg-012dfg"
  }'
```

Save the
`ambient_session_id`
from the response. You will need it to stream audio and retrieve content.

### ​Step 3: Seed context (optional)

After creating the session, you can send a
**POST**
request to the
/api/v1/ambient/session//context
endpoint to provide additional metadata.
Providing
**context**
significantly improves the accuracy of the generated clinical note.
Include the following parameters in the request body:
- provider_specialty (Optional): The specialty of the provider (e.g., “cardiology”).
- sections (Optional): A list of the clinical sections you want summarized, such as “Assessment and Plan” or “Chief Complaint”. If you do not provide this, a default set of sections will be used.
- patient_info (Optional): An object containing date_of_birth (for accurate age calculation) and sex ( MALE , FEMALE , OTHER , or UNKNOWN ; defaults to UNKNOWN ).

Refer to the
Context API reference
for the full request structure.

### ​Step 4: Stream audio via WebSocket

Once you have created a session, you can begin streaming audio to it over a
**WebSocket connection**
. Connect to the WebSocket endpoint at
`wss://sdp.suki.ai/ws/stream`
. For authentication, use the
`Sec-WebSocket-Protocol`
header (browser clients) with format
`SukiAmbientAuth,<ambient_session_id>,<sdp_suki_token>`
, or
`sdp_suki_token`
and
`ambient_session_id`
headers (non-browser clients). See the
Audio streaming API reference
for details.
**Audio format**
: You must stream raw audio data with the following specifications:
- encoding : LINEAR16
- sample_rate : 16KHz
- channel : Mono

For optimal performance, we recommend chunking the audio into
**100ms packets**
.
**WebSocket messages**
: The WebSocket connection supports two types of messages:
**AUDIO**
(carries the raw audio data in the required format) and
**EVENT**
(signifies a specific action on the stream). The supported events are:
- RESUME : Resumes a paused audio stream.
- CANCEL : Cancels the session. No note will be generated.
- ABORT : Aborts the stream due to an interruption. A note will be generated from the audio received so far. The session remains active and can be resumed.
- KEEP_ALIVE : Pings the server to keep the connection alive during periods of inactivity (e.g., when paused).
- EOF : Indicates the end of the file or stream.

**Keep the connection alive**
: You must send a
**KEEP_ALIVE**
event at least once every
**five seconds**
when the stream is paused to prevent the connection from closing.
**Stream behavior and timeouts**
: 1.
**Session Timeouts**
: If no audio data is sent for
**25 seconds**
, Suki will disconnect the stream. 2.
**Paused Stream**
: If the stream is paused and receiving KEEP_ALIVE events, Suki will disconnect the stream after
**30 minutes**
of inactivity.
**CANCEL vs. ABORT**
: Sending
**CANCEL**
terminates the session completely. No note will be generated. Sending
**ABORT**
ends the current stream, but the session remains
**active**
. Suki will generate a note from the audio received before the interruption. Resume streaming to the same
`ambient_session_id`
later.

### ​Step 5: End session

To complete the session and begin the note generation process, send a
**POST**
request to the
/api/v1/ambient/session//end
endpoint. This signals that no more audio will be sent for this session.

```
curl -X POST "https://sdp.suki.ai/api/v1/ambient/session/YOUR_SESSION_ID/end" \
  -H "sdp_suki_token: YOUR_SUKI_TOKEN"
```


### ​Step 6: Retrieve generated content

Once the note is ready, Suki notifies your application. The recommended way to know when a note is ready is to use a
**webhook**
. Suki will send a
`session_summary_generated`
event to a webhook endpoint that you provide. Details on configuring your webhook and its authentication will be provided during the onboarding process.
**Retrieving content manually**
: Alternatively, you can use the following endpoints to check the status and retrieve the session’s content:
- GET /api/v1/ambient/session/ /status : Check the processing status of a session.
- GET /api/v1/ambient/session/ /content : Retrieve the final, structured clinical note.
- GET /api/v1/ambient/session/ /transcript : Get the full conversation transcript, including timestamps for each part of the dialogue.


```
# Get clinical note
curl -X GET "https://sdp.suki.ai/api/v1/ambient/session/YOUR_SESSION_ID/content?cumulative=false" \
  -H "sdp_suki_token: YOUR_SUKI_TOKEN"

# Get transcript
curl -X GET "https://sdp.suki.ai/api/v1/ambient/session/YOUR_SESSION_ID/transcript" \
  -H "sdp_suki_token: YOUR_SUKI_TOKEN"
```

**Session Duration Requirement**
Your ambient session must be
**at least 1 minute long**
for note generation to occur. Sessions shorter than 1 minute will receive a
`SKIPPED`
status, meaning no clinical note was generated.
For complete technical specifications, please refer to the relevant API Reference pages.

## ​Next steps

After completing your first session, explore these resources to deepen your integration:

## Authentication API

Login, register, and JWKS configuration.

## Context API

Seed specialty, sections, and patient info for better note accuracy.

## Audio Streaming API

WebSocket connection details and message formats.

## Webhook

Configure webhooks to receive notifications when notes are ready.
Last modified on
April 1, 2026
Ambient API OverviewPrevious
User AuthenticationNext
⌘
I
- Before you begin: access and credentials
- Prerequisites
- Environments to use for development and testing
- Suki Ambient APIs workflow
- Getting started with Suki Ambient APIs
- Step 1: Authenticate and get token
- Step 2: Create ambient session
- Step 3: Seed context (optional)
- Step 4: Stream audio via WebSocket
- Step 5: End session
- Step 6: Retrieve generated content
- Next steps

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
