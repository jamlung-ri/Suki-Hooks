# Notification Webhook for Partners - Suki

**Source URL:** https://developer.suki.ai/documentation/webhook

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

Quick summary
Suki supports
`push`
and
`pull`
mechanisms based on partner requirements for notifications.


When you choose Push: Suki
POST
to your callback URL when a session completes, fails, times out, or is cancelled; you host the endpoint and receive notifications one-way and immediately.
Last updated:
March 2026
**Notification webhook is supported by:**
APIs. Web SDK, Mobile SDK, Headless Web SDK use SDP API for sending notifications.

## ​Overview

Suki for Partners provides a
endpoint so your application can be notified when ambient sessions complete or fail. You configure a callback URL. When an event occurs, Suki sends a
POST
request to that URL.
This guide explains how webhooks work and how push compares to pull. Suki supports both push and pull based on partner requirements. This guide focuses on push (webhooks). It also covers how the capability applies across APIs and SDKs and how to implement and secure your webhook endpoint.

## ​Push vs pull

Notifications can be delivered in two main ways:
- Pull: Your application repeatedly asks Suki whether something has changed (for example, Polling the Session Status endpoint ). Your system is responsible for when and how often to check.
- Push: Suki sends a request to your application when an event happens. Your application exposes an endpoint that Suki calls; you do not need to poll.

Suki supports both
**push**
and
**pull**
based on partner requirements. When you choose to use push mechanism, Suki sends a single
POST
request to a callback URL that you provide when a session completes, fails, times out, or is cancelled.
With
**push mechanism**
, you host the
**callback URL**
and the
**infrastructure that receives the notification**
.
Suki does not store or queue notifications; delivery is
**one-way**
and
**immediate**
.

## ​Events you receive from webhook

Your webhook endpoint can receive notifications for the following events:

## Session completion

The ambient session finished and note generation completed. The payload includes
**session**
and
**encounter**
identifiers and links to retrieve content (transcript, status, content).

## Session failure

The session or note generation failed. The payload includes
**error codes**
and
**details**
.

## Session timeout

The session timed out. The payload includes
**session**
and
**encounter**
identifiers.

## Session cancellation

The session was cancelled. The payload includes
**session**
and
**encounter**
identifiers.
Success payloads include
`_links`
so you can fetch the
**session content**
,
**transcript**
, and
**status**
using the SDP APIs.
For the exact payload shapes, refer to the
Asynchronous notifications (webhook)
API reference.

## ​Notification capability across all offerings

Webhook notifications are part of the
**Suki Developer Platform (SDP)**
API. You register a webhook callback URL at the
**partner level**
during onboarding; that URL is used for all sessions created under your partner account.
The Web SDK, Mobile SDK, and Headless Web SDK all use the same notification webhook for sending notifications to your callback URL.
When a session is started and ended from any of these clients, the same SDP backend processes it and sends the webhook notification to your callback URL.
We configure one webhook URL per partner. That single URL receives all webhook notifications for your organization, whether the session was created with the direct API, Web SDK, Mobile SDK, or Headless Web SDK. You do not need a separate URL for each client to receive notifications.

## ​Configuring your webhook

Webhook configuration is done during
**partner onboarding**
. You provide Suki with the
**callback URL**
(the full URL of the endpoint that will receive
POST
requests). This URL is stored at the partner level and is used for all webhook notifications for your organization.
You cannot register or change your webhook URL through a self-service portal or API. Provide your callback URL to the Suki team (for example, during
partner onboarding
). Suki will configure it for your partner account and confirm the URL with you once it is set.
Your endpoint must follow these requirements:
- Accept POST requests.
- Use HTTPS only. Suki will not send webhooks to HTTP URLs.
- Respond with 2xx (for example, 200) on successful receipt so Suki can consider the notification delivered. Handle validation and business logic after returning 200 if needed.
- Be reachable from the internet (no localhost or private IPs in production).


## ​Implementing your webhook endpoint

Your application hosts the endpoint that receives webhook requests. Suki sends each notification as a
POST
with a JSON body. Your handler should read the top-level
`status`
field and branch on its value:
`"success"`
or
`"failure"`
.
The sections below describe the payload structure for each case, show example payloads, and give implementation tips. For the full request/response specification and sample code in Python and TypeScript, refer to the
Asynchronous notifications (webhook)
API reference.

### ​Payload structure

Every webhook body includes a top-level
`status`
field. All other fields depend on that value.
**Whenstatusis"success":**
The payload identifies the session and encounter and provides links to retrieve results. It includes:
- session_id , encounter_id (always present)
- Optionally: sessions , additional_info , _links

Use the
`_links`
object to get URLs for fetching session content, encounter content, status, and transcripts from the SDP APIs. The
`sessions`
array lists the session IDs tied to the encounter.
**Whenstatusis"failure":**
The payload identifies the session and encounter and describes the error. It includes:
- session_id , encounter_id , error_code , error_detail

Use these fields to log the failure, trigger alerts, or show an error in your application.

### ​Example payloads

The following examples show the JSON bodies your endpoint receives. Use them to validate your parser and to see how the structure maps to the description above.
**Success:**
When a session completes and note generation succeeds, your endpoint receives a payload like this:
JSON

```
{
  "_links": {
    "contents": [
      {
        "href": "/path/to/resource", // the URL to fetch the session content
        "method": "GET",
        "name": "name",
        "type": "application/json"
      }
    ],
    "encounter_content": [
      {
        "href": "/path/to/resource", // the URL to fetch the encounter content
        "method": "GET",
        "name": "name",
        "type": "application/json"
      }
    ],
    "status": [
      {
        "href": "/path/to/resource", // the URL to fetch the status
        "method": "GET",
        "name": "name",
        "type": "application/json"
      }
    ],
    "transcripts": [
      {
        "href": "/path/to/resource", // the URL to fetch the transcripts
        "method": "GET",
        "name": "name",
        "type": "application/json"
      }
    ]
  },
  "additional_info": {
    "priority": "high"
  },
  "encounter_id": "4d753ce1-bbff-43e1-950a-82dea2d86873",
  "session_id": "a953839a-ddcd-407d-b9b0-3ed4b6be4be2",
  "sessions": [
    "20965414-929a-4f71-a3e5-b92bec07d086",
    "29de56bc-960a-4cd5-b18f-79a798d62874"
  ],
  "status": "success"
}
```

Combine each
`href`
in
`_links`
with your SDP base URL and send a
GET
request with the appropriate authentication to retrieve content, encounter content, status, or transcripts. The
`sessions`
array lists all session IDs for this encounter.
**Failure:**
When a session or note generation fails, your endpoint receives a payload like this:
JSON

```
{
  "encounter_id": "29de56bc-960a-4cd5-b18f-79a798d62874", // the ID of the encounter that failed
  "error_code": "ERROR_CODE_TRANSCRIPTION", // the error code that occurred
  "error_detail": "Error in transcription", // the error detail
  "session_id": "20965414-929a-4f71-a3e5-b92bec07d086", // the ID of the session that failed
  "status": "failure"
}
```

Use
`error_code`
and
`error_detail`
to log the failure, send an alert, or display an error to the user.

### ​Implementation tips

- Return 200 OK quickly and do heavy work (SDP API calls, database updates) in a background job or queue.
- Treat the handler as idempotent; use session_id to detect duplicate deliveries and process each notification only once.
- Keep the endpoint highly available (e.g. load balancer or redundant instances).
- Log that a webhook was received plus session_id , encounter_id , and status ; avoid logging full bodies if they contain sensitive data.


## ​Responses from Suki webhook endpoint

When you call the Suki Webhook Endpoint (for example, using the
`href`
values in
`_links`
to fetch content, status, or transcripts), Suki returns an HTTP status and, for errors, a JSON body with
`code`
and
`message`
.
| Code | Description |
| --- | --- |
| 200 | OK. The request succeeded. |
| 400 | Bad Request. The request was invalid. Example: {"code": 400, "message": "invalid request"} |
| 401 | Unauthorized. The token is invalid or authentication failed. Example: {"code": 401, "message": "invalid token"} |
| 500 | Internal Server Error. The server encountered an error. Example: {"code": 500, "message": "internal server error"} |

In your application, handle
`401`
by re-authenticating or refreshing the token. Handle
`400`
by fixing the request or showing an error. Consider retrying on
`5xx`
when appropriate.

## ​Security best practices

Follow these practices when implementing your webhook endpoint:
For more detail, refer to
Security & best practices
and
Authentication FAQs
(webhook authentication).
Last modified on
March 23, 2026
Audio Streaming & DownloadPrevious
Documentation MCP IntegrationNext
⌘
I
- Overview
- Push vs pull
- Events you receive from webhook
- Notification capability across all offerings
- Configuring your webhook
- Implementing your webhook endpoint
- Payload structure
- Example payloads
- Implementation tips
- Responses from Suki webhook endpoint
- Security best practices

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
