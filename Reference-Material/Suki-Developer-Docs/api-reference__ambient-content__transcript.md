# Get Session Transcript - Suki

**Source URL:** https://developer.suki.ai/api-reference/ambient-content/transcript

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
transcript
Gets the completed transcripts for the ambient session.

```
curl --request GET \
  --url https://sdp.suki-stage.com/api/v1/ambient/session/{ambient_session_id}/transcript \
  --header 'sdp_suki_token: <sdp_suki_token>'
```


```
{
  "final_transcript": [
    {
      "end_offset": {
        "hours": 0,
        "minutes": 6,
        "nanos": 80000000,
        "seconds": 42
      },
      "end_time": "2024-12-04T09:40:48.792948332Z",
      "lang_id": "en",
      "recording_id": "c9d59aa8-cd48-4f5a-be81-5d0c9d2a5885",
      "start_offset": {
        "hours": 0,
        "minutes": 6,
        "nanos": 80000000,
        "seconds": 42
      },
      "start_time": "2024-12-04T09:40:42.393948332Z",
      "transcript": "The patient has shown an allergy to pollen",
      "transcript_id": "01JE8GP4RTHH0KDEGRSTRVPMGH"
    }
  ]
}
```

Use this endpoint to get the full
for a specified
after it has completed.
**Updated:**
The response will now include the new
`lang_id`
field within the payload. The
`lang_id`
field indicates the language in which the transcript was sent.
For a full list of language codes and their corresponding languages, refer to the
Language code reference
section.

## ​Code examples

- Python
- TypeScript


```
import requests

ambient_session_id = "123dfg-456dfg-789dfg-012dfg"
url = f"https://sdp.suki.ai/api/v1/ambient/session/{ambient_session_id}/transcript"

headers = {
    "sdp_suki_token": "<sdp_suki_token>"
}

response = requests.get(url, headers=headers)

if response.status_code == 200:
    transcript_data = response.json()
    print("Transcript:")
    for transcript in transcript_data.get("final_transcript", []):
        print(f"Transcript ID: {transcript.get('transcript_id')}")
        print(f"Recording ID: {transcript.get('recording_id')}")
        print(f"Language: {transcript.get('lang_id')}")
        print(f"Transcript: {transcript.get('transcript')}")
        print(f"Start Time: {transcript.get('start_time')}")
        print(f"End Time: {transcript.get('end_time')}")
        
        # Start offset (relative to beginning of audio)
        start_offset = transcript.get('start_offset', {})
        if start_offset:
            print(f"Start Offset: {start_offset.get('hours')}h {start_offset.get('minutes')}m {start_offset.get('seconds')}s")
        
        # End offset (relative to beginning of audio)
        end_offset = transcript.get('end_offset', {})
        if end_offset:
            print(f"End Offset: {end_offset.get('hours')}h {end_offset.get('minutes')}m {end_offset.get('seconds')}s")
        
        print("---")
else:
    print(f"Failed to get transcript: {response.status_code}")
    print(response.json())
```


```
const ambientSessionId = '123dfg-456dfg-789dfg-012dfg';
const response = await fetch(
  `https://sdp.suki.ai/api/v1/ambient/session/${ambientSessionId}/transcript`,
  {
    headers: {
      'sdp_suki_token': '<sdp_suki_token>'
    }
  }
);

if (response.ok) {
  const transcriptData = await response.json();
  console.log('Transcript:');
  transcriptData.final_transcript?.forEach((transcript: any) => {
    console.log(`Transcript ID: ${transcript.transcript_id}`);
    console.log(`Recording ID: ${transcript.recording_id}`);
    console.log(`Language: ${transcript.lang_id}`);
    console.log(`Transcript: ${transcript.transcript}`);
    console.log(`Start Time: ${transcript.start_time}`);
    console.log(`End Time: ${transcript.end_time}`);
    
    // Start offset (relative to beginning of audio)
    if (transcript.start_offset) {
      const { hours, minutes, seconds } = transcript.start_offset;
      console.log(`Start Offset: ${hours}h ${minutes}m ${seconds}s`);
    }
    
    // End offset (relative to beginning of audio)
    if (transcript.end_offset) {
      const { hours, minutes, seconds } = transcript.end_offset;
      console.log(`End Offset: ${hours}h ${minutes}m ${seconds}s`);
    }
    
    console.log('---');
  });
} else {
  const error = await response.json();
  console.error(`Failed to get transcript: ${response.status}`, error);
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


Response body for the /session/{ambient_session_id}/transcript endpoint

​
final_transcript
object[]

Collection of transcripts for the ambient session

Last modified on
April 1, 2026
Get Session StatusPrevious
Get Session RecordingNext
⌘
I
Gets the completed transcripts for the ambient session.

```
curl --request GET \
  --url https://sdp.suki-stage.com/api/v1/ambient/session/{ambient_session_id}/transcript \
  --header 'sdp_suki_token: <sdp_suki_token>'
```


```
{
  "final_transcript": [
    {
      "end_offset": {
        "hours": 0,
        "minutes": 6,
        "nanos": 80000000,
        "seconds": 42
      },
      "end_time": "2024-12-04T09:40:48.792948332Z",
      "lang_id": "en",
      "recording_id": "c9d59aa8-cd48-4f5a-be81-5d0c9d2a5885",
      "start_offset": {
        "hours": 0,
        "minutes": 6,
        "nanos": 80000000,
        "seconds": 42
      },
      "start_time": "2024-12-04T09:40:42.393948332Z",
      "transcript": "The patient has shown an allergy to pollen",
      "transcript_id": "01JE8GP4RTHH0KDEGRSTRVPMGH"
    }
  ]
}
```

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
