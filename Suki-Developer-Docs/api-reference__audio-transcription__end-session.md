# End Session - Suki

**Source URL:** https://developer.suki.ai/api-reference/audio-transcription/end-session

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
{transcription_session_id}
/
end
Ends a transcription session.

```
curl --request POST \
  --url https://sdp.suki-stage.com/api/v1/transcription/session/{transcription_session_id}/end \
  --header 'sdp_suki_token: <sdp_suki_token>'
```


```
{
  "code": 400,
  "message": "invalid request"
}
```

Use this endpoint to end an active
session and retrieve the final transcription results. This endpoint stops the audio streaming and returns the complete
along with
metadata.
Returns a
`200 OK`
status with success message.

#### Headers

​
sdp_suki_token
string
required

sdp_suki_token


#### Path Parameters

​
transcription_session_id
string
required

transcription_session_id


#### Response


Success Response

Last modified on
March 23, 2026
Stream Audio To Dictation SessionPrevious
Ambient Content Retrieval APINext
⌘
I
Ends a transcription session.

```
curl --request POST \
  --url https://sdp.suki-stage.com/api/v1/transcription/session/{transcription_session_id}/end \
  --header 'sdp_suki_token: <sdp_suki_token>'
```


```
{
  "code": 400,
  "message": "invalid request"
}
```

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
