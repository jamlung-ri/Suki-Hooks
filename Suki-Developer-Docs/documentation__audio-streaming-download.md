# Audio Streaming & Download - Suki

**Source URL:** https://developer.suki.ai/documentation/audio-streaming-download

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
Get secure, temporary access to the original audio from
. Use it to play back recordings in your app, verify notes against the conversation, or save files for compliance.
Last updated:
March 2026
**Audio streaming & download API is supported by:**
APIs, Headless Web SDK

## ​Overview

**Audio streaming & download API**
lets you stream or download the raw recording of the conversation from an ambient session. That recording is the original audio that was captured during the visit. Those sessions already produce
, notes, and
; this API adds the
**source recording**
so you can play it back in your app, verify AI-generated notes against the conversation, or store it for compliance.
Use this capability when you need to:
- Let physicians listen back : Add a playback feature so providers can review the conversation.
- Verify AI output : Let providers compare a note to the actual conversation when they question it.
- Meet compliance needs : Save audio files for legal or regulatory requirements.

You request a recording URL from the Audio Streaming & Download API. The URL lets you either
**stream**
the audio (for playback with seeking) or
**download**
the full file.
URLs are temporary and expire after a short time for security.

## ​Benefits


## Stream for Playback

Stream audio in your app. Supports seeking and scrubbing so users can jump to any part of the recording.

## Download for Storage

Download the full audio file when you need to keep it for archival or compliance.

## Works for All Sessions

Available for both real-time streamed sessions and sessions where audio was uploaded after the visit.

## Time-Limited Access

Streaming URLs last 15 minutes for short sessions, or session length plus 10 minutes for long sessions. Download URLs last 1 hour.

## 7-Day Availability

Recordings are available for 7 days after the session. After that, they are no longer accessible.

## Access Logging

Each access is logged for compliance and security.

## WAV Format

Recordings are returned in WAV format, ready for playback in standard media players.

## ​How it works

- Finish an ambient session : Create a session, stream or upload audio, and end it. The recording is ready once the session is complete.
- Request a recording URL : Call the recording API with your session ID . Choose streaming (for playback) or download (for saving the file). Some sessions may return multiple recordings; use the one you need.
- Use the URL : Stream or download the audio in WAV format. If the response indicates streaming is not supported, use download mode instead. If the URL expires while someone is listening, request a new one .


### ​Workflow

$!
/$

## ​How to use the Download API

1

Complete an Ambient session

Create an ambient session, stream or upload audio, and end the session. The recording is available after the session is complete.
Use the
Create ambient session API
to create an ambient session.
2

Request the Recording URL

Call the
Recording API endpoint
with your ambient
`session ID`
. Use the
`download`
parameter:
`false`
for streaming (playback) or
`true`
for full file download.
3

Stream or Download

Use the returned URL to stream or download the audio (WAV format).
**URL Expiration**
:
The recording URL is available for a limited time. You need to request a new URL when it expires.
- Streaming : The URL lasts 15 minutes for short sessions. For sessions longer than 15 minutes, it lasts long enough to play the full recording (session length plus 10 minutes).
- Download : The URL lasts 1 hour.

**How long recordings are kept?**
**7 days**
from the session date. After that, the recording is no longer available.
4

Request a new URL when needed

If the URL expires during playback, call the recording endpoint again to get a fresh URL.

## ​Response structure for Download API

When the request succeeds, the API returns a
`recordings`
array. Each item in the array represents one recording chunk for the session.
​
recordings
array
List of recordings for the session. Each item contains a presigned URL and metadata.
​
is_streamable
boolean
Whether the returned URLs support streaming with Range requests. If
`false`
, use
`download=true`
to get a download URL instead.

## ​Best practices

- Stream for playback : Use streaming when building a player so users can seek to any part of the recording
- Download for archival : Use download when you need to store the file long-term
- Handle 404 on uploaded sessions : If you get 404 for a session where audio was uploaded, the recording may still be processing. Wait and retry
- Do not retry on 410 : When you get 410, the recording is permanently unavailable
- Refresh URLs when needed : For streaming, the URL lasts 15 minutes or session duration plus 10 minutes for long sessions. Request a new URL when it expires
- Use access responsibly : All access is logged; ensure your use meets your compliance requirements


## ​FAQs

Last modified on
April 1, 2026
Audio DictationPrevious
Notification Webhook for PartnersNext
⌘
I
- Overview
- Benefits
- How it works
- Workflow
- How to use the Download API
- Response structure for Download API
- Best practices
- FAQs

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
