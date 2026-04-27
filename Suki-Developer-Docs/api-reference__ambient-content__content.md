# Get Session Content - Suki

**Source URL:** https://developer.suki.ai/api-reference/ambient-content/content

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
content
Gets the content for the ambient session.

```
curl --request GET \
  --url https://sdp.suki-stage.com/api/v1/ambient/session/{ambient_session_id}/content \
  --header 'sdp_suki_token: <sdp_suki_token>'
```


```
{
  "summary": [
    {
      "content": "Asthma exacerbation",
      "loinc_code": "18776-5",
      "source_transcripts": [
        "asthma",
        "exacerbation"
      ],
      "title": "ASSESSMENT AND PLAN"
    }
  ]
}
```

Use this endpoint to get the summary and
associated with the specified
.
This endpoint uses the
`cumulative`
query parameter to get the cumulative summary and structured data for the specified ambient session. If the query parameter is not provided, the default value is
`false`
.
You have two options for the
`cumulative`
query parameter:
​
cumulative
boolean
Determines whether to retrieve cumulative or snapshot data.
**Understanding the SKIPPED Status**
If you see a session with a
`SKIPPED`
status, it means that the
was
**not generated**
because the conversation
was
**empty**
.
This status is an expected outcome if an ambient session is started but contains no audible speech (for example, a silent recording). It does not indicate a system error.
Unlike a
`FAILED`
status, which indicates a processing error,
`SKIPPED`
is a successful outcome where no action was needed. Typically filter out or ignore sessions with this status in your application’s user interface.

## ​Code examples

- Python
- TypeScript


```
import requests

ambient_session_id = "123dfg-456dfg-789dfg-012dfg"
url = f"https://sdp.suki.ai/api/v1/ambient/session/{ambient_session_id}/content"

headers = {
    "sdp_suki_token": "<sdp_suki_token>"
}

# Get snapshot content (default, cumulative=false)
response = requests.get(url, headers=headers, params={"cumulative": False})

if response.status_code == 200:
    content = response.json()
    print("Generated Note:")
    for section in content.get("summary", []):
        print(f"\nTitle: {section.get('title')}")
        print(f"LOINC Code: {section.get('loinc_code')}")
        print(f"Content: {section.get('content')}")
        
        # Source transcripts used to generate this content
        source_transcripts = section.get('source_transcripts', [])
        if source_transcripts:
            print(f"Source Transcripts: {', '.join(source_transcripts)}")
else:
    print(f"Failed to get content: {response.status_code}")
    print(response.json())
```


```
const ambientSessionId = '123dfg-456dfg-789dfg-012dfg';

// Get snapshot content (default, cumulative=false)
const response = await fetch(
  `https://sdp.suki.ai/api/v1/ambient/session/${ambientSessionId}/content?cumulative=false`,
  {
    headers: {
      'sdp_suki_token': '<sdp_suki_token>'
    }
  }
);

if (response.ok) {
  const content = await response.json();
  console.log('Generated Note:');
  content.summary?.forEach((section: any) => {
    console.log(`\nTitle: ${section.title}`);
    console.log(`LOINC Code: ${section.loinc_code}`);
    console.log(`Content: ${section.content}`);
    
    // Source transcripts used to generate this content
    if (section.source_transcripts && section.source_transcripts.length > 0) {
      console.log(`Source Transcripts: ${section.source_transcripts.join(', ')}`);
    }
  });
} else {
  const error = await response.json();
  console.error(`Failed to get content: ${response.status}`, error);
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


#### Query Parameters

​
cumulative
boolean
default:
false

Optional - Determines whether to retrieve cumulative or snapshot data.


#### Response


Success Response


Response body for the /session/{ambient_session_id}/content endpoint

​
summary
object[]

Summary of the ambient session.

Last modified on
March 26, 2026
Get Session RecordingPrevious
Get Encounter ContentNext
⌘
I
Gets the content for the ambient session.

```
curl --request GET \
  --url https://sdp.suki-stage.com/api/v1/ambient/session/{ambient_session_id}/content \
  --header 'sdp_suki_token: <sdp_suki_token>'
```


```
{
  "summary": [
    {
      "content": "Asthma exacerbation",
      "loinc_code": "18776-5",
      "source_transcripts": [
        "asthma",
        "exacerbation"
      ],
      "title": "ASSESSMENT AND PLAN"
    }
  ]
}
```

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
