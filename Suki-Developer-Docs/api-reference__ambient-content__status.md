# Get Session Status - Suki

**Source URL:** https://developer.suki.ai/api-reference/ambient-content/status

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
- Dictation
- Ambient Content Retrieval GET Get Session Status GET Get Session Transcript GET Get Session Recording NEW GET Get Session Content GET Get Encounter Content GET Get Structured Data GET Get Encounter Structured Data
- User Preferences
- User Feedback
- Send Notifications
- Info

GET
/
api
/
v1
/
ambient
/
session
/
{ambient_session_id}
/
status
Gets the status of the ambient session.

```
curl --request GET \
  --url https://sdp.suki-stage.com/api/v1/ambient/session/{ambient_session_id}/status \
  --header 'sdp_suki_token: <sdp_suki_token>'
```


```
{
  "status": "completed"
}
```

Use this endpoint to get the
**current status**
of an
. Use it to track the session’s progress, for example, to see if it is ready to receive audio, still processing, or has completed.

## ​Session status values

Use the following status values to track the session’s progress:
- created : The ambient session has been created but has not yet started.
- ready : The ambient session has started and is ready for audio streaming.
- running : The ambient session is actively processing audio and generating content.
- aborted : The ambient session has been cancelled by the user or client.
- skipped : The ambient session was skipped because not enough audio was received or the transcript was empty.
- failed : The ambient session failed due to an error during processing.
- completed : The ambient session completed successfully and generated the final content.

**paused**
status is no longer supported.
Upon reaching
**completed**
state, the session is ready to return the content, transcripts, or other
.

## ​Code examples

- Python
- TypeScript


```
import requests

ambient_session_id = "123dfg-456dfg-789dfg-012dfg"
url = f"https://sdp.suki.ai/api/v1/ambient/session/{ambient_session_id}/status"

headers = {
    "sdp_suki_token": "<sdp_suki_token>"
}

response = requests.get(url, headers=headers)

if response.status_code == 200:
    status_data = response.json()
    status = status_data.get("status")
    print(f"Session status: {status}")
    
    if status == "completed":
        print("Session completed successfully. Content is ready.")
    elif status == "failed":
        print("Session failed during processing.")
    elif status == "skipped":
        print("Session was skipped (empty transcript or too short).")
else:
    print(f"Failed to get status: {response.status_code}")
    print(response.json())
```


```
const ambientSessionId = '123dfg-456dfg-789dfg-012dfg';
const response = await fetch(
  `https://sdp.suki.ai/api/v1/ambient/session/${ambientSessionId}/status`,
  {
    headers: {
      'sdp_suki_token': '<sdp_suki_token>'
    }
  }
);

if (response.ok) {
  const statusData = await response.json();
  const status = statusData.status;
  console.log(`Session status: ${status}`);
  
  if (status === 'completed') {
    console.log('Session completed successfully. Content is ready.');
  } else if (status === 'failed') {
    console.log('Session failed during processing.');
  } else if (status === 'skipped') {
    console.log('Session was skipped (empty transcript or too short).');
  }
} else {
  const error = await response.json();
  console.error(`Failed to get status: ${response.status}`, error);
}
```


#### Headers

​
sdp_suki_token
string
required

sdp_suki_token


#### Path Parameters

​
ambient_session_id
string
required

ambient_session_id


#### Response


Success Response


Response body for the /session/{ambient_session_id}/status endpoint

​
status
enum<string>

status of the ambient session

Available options
:
`created`
,
`ready`
,
`running`
,
`paused`
,
`aborted`
,
`failed`
,
`completed`
Example
:

"completed"

Last modified on
March 23, 2026
Ambient Content Retrieval APIPrevious
Get Session TranscriptNext
⌘
I
Gets the status of the ambient session.

```
curl --request GET \
  --url https://sdp.suki-stage.com/api/v1/ambient/session/{ambient_session_id}/status \
  --header 'sdp_suki_token: <sdp_suki_token>'
```


```
{
  "status": "completed"
}
```

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
