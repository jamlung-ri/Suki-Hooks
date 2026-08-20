# Stream Audio To Dictation Session - Suki

**Source URL:** https://developer.suki.ai/api-reference/audio-transcription/stream-transcription

---

Sukihome page
Documentation
APIs
Release Notes
Sukihome page

- API Overview


##### API References

- Authentication
- Ambient Session Management
- Dictation POST Create Dictation Session NEW GET Stream Dictation Session WS POST End Dictation Session NEW
- Ambient Content Retrieval
- User Preferences
- User Feedback
- Send Notifications
- Info

GET
/
ws
/
transcribe
Streams audio to the transcription service via WebSocket.

```
curl --request GET \
  --url https://sdp.suki-stage.com/ws/transcribe \
  --header 'sdp_suki_token: <sdp_suki_token>' \
  --header 'transcription_session_id: <transcription_session_id>'
```


```
"<string>"
```

Use this WebSocket endpoint to stream audio to an active
session for
**real-time transcription**
.
Data should be streamed in chunks for optimal performance.

## ​Authentication

You must authenticate your request using the
`Sec-WebSocket-Protocol`
header.

### ​Browser clients

If you are connecting from a browser, you must use the
`Sec-WebSocket-Protocol`
header during the WebSocket handshake.
The header must specify the
`SukiAmbientAuth`
protocol, followed by the
**token**
and the
**transcription session ID**
in the following format.

```
Sec-WebSocket-Protocol: SukiTranscriptionAuth,<sdp_suki_token>,<transcription_session_id>
```


### ​Non-browser clients

If you are connecting from a non-browser client, such as a mobile or server-side application, you must provide the
**token**
and
**session ID**
as separate HTTP headers in the initial WebSocket upgrade request.
- sdp_suki_token : Your Suki token.
- transcription_session_id : The ID for the current session.


#### Headers

​
Sec-WebSocket-Protocol
string

Required FOR BROWSER CLIENTS ONLY. Sent during WebSocket handshake. Format: 'SukiTranscriptionAuth <transcription_session_id> <sdp_suki_token>'

​
sdp_suki_token
string
required

Required FOR NON-BROWSER CLIENTS ONLY: The SDP Suki token. Sent as a standard header with the initial upgrade request.

​
transcription_session_id
string
required

Required FOR NON-BROWSER CLIENTS ONLY: The transcription session ID. Sent as a standard header with the initial upgrade request.


#### Response


Switching Protocols - Indicates successful WebSocket handshake.


The response is of type string .

Last modified on
March 23, 2026
Create Dictation SessionPrevious
End SessionNext
⌘
I
Streams audio to the transcription service via WebSocket.

```
curl --request GET \
  --url https://sdp.suki-stage.com/ws/transcribe \
  --header 'sdp_suki_token: <sdp_suki_token>' \
  --header 'transcription_session_id: <transcription_session_id>'
```


```
"<string>"
```

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
