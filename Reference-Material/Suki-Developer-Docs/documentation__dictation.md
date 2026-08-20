# Audio Dictation - Suki

**Source URL:** https://developer.suki.ai/documentation/dictation

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
Audio Dictation converts spoken conversations into text in real-time. Use this feature to enable transcription of patient-provider conversations.
Last updated:
March 2026
**Audio Dictation is supported by:**
APIs
SDKs include
as part of
note generation; the standalone Audio Dictation feature (speech-to-text only) is available via APIs only.

## ​Overview

Audio Dictation converts spoken conversations into text in real-time.
Use the
**Dictation**
feature to enable transcription of patient-provider conversations in real-time. This helps providers focus on the conversation instead of worrying about transcribing it.

## ​Key features


## Real-time Transcription

See text appear as people speak, no waiting for the conversation to end.

## Multiple Sessions

Run multiple dictation sessions under one parent session for complex workflows.

## WebSocket Streaming

Low-latency audio streaming for fast, responsive dictation.

## Clean Transcripts

Automatically formatted with proper punctuation, capitalization, and filler words removed.

## Intermediate and Final Texts

Receive both intermediate (partial) transcripts as speech is processed and final transcripts when segments are complete.

## ​How it works

Dictation works in three simple steps:
- Create a session : Create a dictation session and get a transcription_session_id
- Stream audio : Connect via WebSocket and stream audio data to that session
- Receive transcripts : Get transcribed text in real-time as you stream

**Multiple streams:**
Create multiple WebSocket connections to stream audio to the same dictation session. This is useful if you need to:
- Stream from multiple sources simultaneously
- Handle reconnections if a WebSocket drops
- Manage complex audio workflows

All streams use the same
`transcription_session_id`
, and transcripts from all streams are combined into one session.

### ​Workflow

$!
/$

## ​How to use dictation

Follow these steps to dictate audio:
1

Create parent dictation session

Create a parent session using the
POST
Create dictation session API
. This returns a
`transcription_session_id`
that you’ll use for all child sessions.
**Optional audio configuration:**
Customize audio settings when creating the session:

```
{
  "audio_config": {
    "audio_encoding": "LINEAR16",      // Default: LINEAR16
    "audio_language": "en-US",         // Default: en-US
    "sample_rate_hertz": 16000         // Default: 16000
  }
}
```

Audio configuration is optional. If not provided, default values are used. Currently, only English (
`en-US`
) is supported for dictation.
2

Stream audio via WebSocket

Connect to the WebSocket endpoint
GET
`/ws/transcribe`
and stream your audio data. You’ll receive transcribed text in real-time as you stream.
**Authentication:**
- Browser clients : Use Sec-WebSocket-Protocol header with format: SukiTranscriptionAuth,<sdp_suki_token>,<transcription_session_id>
- Non-browser clients : Send sdp_suki_token and transcription_session_id as HTTP headers

Create multiple streaming sessions under the same parent session ID.
3

Receive Real-Time Transcripts

As you stream audio, Suki processes it and returns transcribed text immediately. Transcripts are automatically formatted with punctuation and capitalization.
4

End dictation session

When finished, call the end transcription session API to properly close the session.
cURL

```
curl -X POST https://sdp.suki.ai/api/v1/transcription/session/{transcription_session_id}/end \
-H "sdp_suki_token: {sdp_suki_token}"
```


## ​Related APIs


## Create Transcription Session

Create a parent transcription session

## Stream Audio

Stream audio for real-time transcription

## End Session

End a transcription session

## ​Best practices

- Stream in chunks : Send audio data in chunks rather than all at once for better performance
- Handle errors gracefully : WebSocket connections can drop; implement reconnection logic
- End sessions properly : Always call the end session API when finished to free up resources
- Use appropriate audio settings : Match your audio encoding and sample rate to your source
- Monitor session state : Track active sessions to prevent resource leaks
- Test audio quality : Ensure your audio source meets the required specifications for best results


## ​FAQs

Last modified on
April 1, 2026
PersonalizationPrevious
Audio Streaming & DownloadNext
⌘
I
- Overview
- Key features
- How it works
- Workflow
- How to use dictation
- Related APIs
- Best practices
- FAQs

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
