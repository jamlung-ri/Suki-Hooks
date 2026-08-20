# Get Session Recording - Suki

**Source URL:** https://developer.suki.ai/api-reference/ambient-content/recording

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
recording
Gets presigned URLs for recordings for the ambient session.

```
curl --request GET \
  --url https://sdp.suki-stage.com/api/v1/ambient/session/{ambient_session_id}/recording \
  --header 'sdp_suki_token: <sdp_suki_token>'
```


```
{
  "recordings": [
    {
      "recording_id": "01KFJZTJWZH28GRHQXVCGW4Y47",
      "presigned_url": "https://storage.googleapis.com/...",
      "expires_at": 1738765432,
      "sequence_number": 1
    }
  ],
  "is_streamable": true
}
```

Use this endpoint to get presigned URLs for all recordings for the
. Refer to the
Audio streaming & download
guide for more details.
Use the
`download`
query parameter to control the URL type:
- If download=true , the URL is for downloading the full file.
- If download=false or omitted, the URL supports streaming with Range requests.


## ​Code examples

- Python
- TypeScript


```
import requests

ambient_session_id = "123dfg-456dfg-789dfg-012dfg" // this will be the ambient session id you get from the create ambient session API
url = f"https://sdp.suki.ai/api/v1/ambient/session/{ambient_session_id}/recording"

headers = {
    "sdp_suki_token": "<sdp_suki_token>"
}

# For streaming URLs (default)
response = requests.get(url, headers=headers)

# For download-only URLs
# response = requests.get(url, headers=headers, params={"download": True})

if response.status_code == 200:
    data = response.json()
    print(f"Streamable: {data.get('is_streamable')}")
    for rec in data.get("recordings", []):
        print(f"Recording ID: {rec.get('recording_id')}")
        print(f"Presigned URL: {rec.get('presigned_url')}")
        print(f"Expires at: {rec.get('expires_at')}")
        print(f"Sequence: {rec.get('sequence_number')}")
        print("---")
else:
    print(f"Failed to get recording URLs: {response.status_code}")
    print(response.json())
```


```
const ambientSessionId = '123dfg-456dfg-789dfg-012dfg'; // this will be the ambient session id you get from the create ambient session API

// For streaming URLs (default)
const response = await fetch(
  `https://sdp.suki.ai/api/v1/ambient/session/${ambientSessionId}/recording`,
  {
    headers: {
      'sdp_suki_token': '<sdp_suki_token>'
    }
  }
);

// For download-only URLs, append ?download=true
// const response = await fetch(
//   `https://sdp.suki.ai/api/v1/ambient/session/${ambientSessionId}/recording?download=true`,
//   { headers: { 'sdp_suki_token': '<sdp_suki_token>' } }
// );

if (response.ok) {
  const data = await response.json();
  console.log('Streamable:', data.is_streamable);
  data.recordings?.forEach((rec: any) => {
    console.log('Recording ID:', rec.recording_id);
    console.log('Presigned URL:', rec.presigned_url);
    console.log('Expires at:', rec.expires_at);
    console.log('Sequence:', rec.sequence_number);
    console.log('---');
  });
} else {
  const error = await response.json();
  console.error(`Failed to get recording URLs: ${response.status}`, error);
}
```


#### Headers

​
sdp_suki_token
string
required

SDP JWT; partner_id is read from token claims for recording access metrics.


#### Path Parameters

​
ambient_session_id
string
required

Unique identifier for the ambient session.


#### Query Parameters

​
download
boolean

If true, returns download-only URLs; if false or omitted, URLs support streaming with Range requests.


#### Response


Success Response


Response body for the /session/{ambient_session_id}/recording endpoint

​
recordings
object[]

List of recordings with presigned URLs for the ambient session.

​
is_streamable
boolean

Whether the returned URLs support streaming with Range requests.

Example
:

true

Last modified on
April 1, 2026
Get Session TranscriptPrevious
Get Session ContentNext
⌘
I
Gets presigned URLs for recordings for the ambient session.

```
curl --request GET \
  --url https://sdp.suki-stage.com/api/v1/ambient/session/{ambient_session_id}/recording \
  --header 'sdp_suki_token: <sdp_suki_token>'
```


```
{
  "recordings": [
    {
      "recording_id": "01KFJZTJWZH28GRHQXVCGW4Y47",
      "presigned_url": "https://storage.googleapis.com/...",
      "expires_at": 1738765432,
      "sequence_number": 1
    }
  ],
  "is_streamable": true
}
```

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
