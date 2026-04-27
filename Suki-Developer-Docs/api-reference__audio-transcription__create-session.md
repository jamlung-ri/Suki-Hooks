# Create Dictation Session - Suki

**Source URL:** https://developer.suki.ai/api-reference/audio-transcription/create-session

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

POST
/
api
/
v1
/
transcription
/
session
/
create
Creates a transcription session.

```
curl --request POST \
  --url https://sdp.suki-stage.com/api/v1/transcription/session/create \
  --header 'Content-Type: application/json' \
  --header 'sdp_suki_token: <sdp_suki_token>' \
  --data '
{
  "audio_config": {
    "audio_encoding": "LINEAR16",
    "audio_language": "en-US",
    "sample_rate_hertz": 16000
  },
  "transcription_session_id": "123dfg-456dfg-789dfg-012dfg"
}
'
```


```
{
  "transcription_session_id": "123dfg-456dfg-789dfg-012dfg"
}
```

Use this endpoint to create a
session to transcribe audio from patient-
conversations into text.
Refer to the
Audio dictation guide
for more information.
Returns a
`201 Created`
status with the
`transcription_session_id`
that is used to identify the session for transcribing audio and ending the session.

#### Headers

​
sdp_suki_token
string
required

sdp_suki_token


#### Body

application/json

CreateTranscriptionSessionRequest


Request body for the /transcription/session/create endpoint

​
audio_config
object

Optional - Audio configuration for the transcription session

​
transcription_session_id
string

Optional - UUID format. If not provided, a session ID will be automatically generated.

Example
:

"123dfg-456dfg-789dfg-012dfg"


#### Response


Success Response


Response body for the /transcription/session/create endpoint

​
transcription_session_id
string

Unique identifier for the transcription session

Example
:

"123dfg-456dfg-789dfg-012dfg"

Last modified on
April 1, 2026
Dictation APIPrevious
Stream Audio To Dictation SessionNext
⌘
I
Creates a transcription session.

```
curl --request POST \
  --url https://sdp.suki-stage.com/api/v1/transcription/session/create \
  --header 'Content-Type: application/json' \
  --header 'sdp_suki_token: <sdp_suki_token>' \
  --data '
{
  "audio_config": {
    "audio_encoding": "LINEAR16",
    "audio_language": "en-US",
    "sample_rate_hertz": 16000
  },
  "transcription_session_id": "123dfg-456dfg-789dfg-012dfg"
}
'
```


```
{
  "transcription_session_id": "123dfg-456dfg-789dfg-012dfg"
}
```

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
