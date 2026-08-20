# Create Ambient Session - Suki

**Source URL:** https://developer.suki.ai/api-reference/ambient-sessions/create

---

Sukihome page
Documentation
APIs
Release Notes
Sukihome page

- API Overview


##### API References

- Authentication
- Ambient Session Management POST Create Ambient Session POST Seed Ambient Session Context PATCH Update Session Context POST Session Metadata DEPRECATED GET Audio Streaming WS POST End Ambient Session
- Dictation
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
ambient
/
session
/
create
Creates an ambient session.

```
curl --request POST \
  --url https://sdp.suki-stage.com/api/v1/ambient/session/create \
  --header 'Content-Type: application/json' \
  --header 'sdp_suki_token: <sdp_suki_token>' \
  --data '
{
  "ambient_session_id": "123dfg-456dfg-789dfg-012dfg",
  "encounter_id": "123dfg-456dfg-789dfg-012dfg"
}
'
```


```
{
  "ambient_session_id": "123dfg-456dfg-789dfg-012dfg"
}
```

**Updated**
The
`multilingual`
parameter is deprecated.
Multilingual support is now
**enabled by default**
for all ambient sessions. You no longer need to pass this parameter. The API automatically supports conversations in multiple languages and generates the
in English.
Use this endpoint to create an
. Suki will generate an
`ambient_session_id`
and return it in the response.
Use this
`ambient_session_id`
to identify the
in subsequent API calls. We recommend that an ambient session be at least
**1 minute long**
.
In case of a short session, the note generation will be
`skipped`
.

## ​Code examples

- Python
- TypeScript


```
import requests

url = "https://sdp.suki.ai/api/v1/ambient/session/create"
headers = {
    "sdp_suki_token": "<sdp_suki_token>",
    "Content-Type": "application/json"
}

payload = {
    "ambient_session_id": "123dfg-456dfg-789dfg-012dfg",  # Optional, UUID format
    "encounter_id": "123dfg-456dfg-789dfg-012dfg"  # Optional, UUID format
}

response = requests.post(url, json=payload, headers=headers)

if response.status_code == 201:
    data = response.json()
    ambient_session_id = data["ambient_session_id"]
    print(f"Session created successfully. Session ID: {ambient_session_id}")
else:
    print(f"Failed to create session: {response.status_code}")
    print(response.json())
```


```
const response = await fetch('https://sdp.suki.ai/api/v1/ambient/session/create', {
  method: 'POST',
  headers: {
    'sdp_suki_token': '<sdp_suki_token>',
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({
    ambient_session_id: '123dfg-456dfg-789dfg-012dfg', // Optional, UUID format
    encounter_id: '123dfg-456dfg-789dfg-012dfg' // Optional, UUID format
  })
});

if (response.ok) {
  const data = await response.json();
  const ambientSessionId = data.ambient_session_id;
  console.log(`Session created successfully. Session ID: ${ambientSessionId}`);
} else {
  const error = await response.json();
  console.error(`Failed to create session: ${response.status}`, error);
}
```


#### Headers

​
sdp_suki_token
string
required

sdp_suki_token


#### Body

application/json

CreateSessionRequest


Request body for the /session/create endpoint

​
ambient_session_id
string

Optional - UUID format

Example
:

"123dfg-456dfg-789dfg-012dfg"

​
encounter_id
string

Optional - UUID format

Example
:

"123dfg-456dfg-789dfg-012dfg"

​
multilingual
boolean
deprecated

Deprecated. Multilingual support is now true by default. To disable it, contact the Suki support team.

Example
:

true


#### Response


Success Response


Response body for the /session/create endpoint

​
ambient_session_id
string
Example
:

"123dfg-456dfg-789dfg-012dfg"

Last modified on
March 26, 2026
Ambient Session Management APIPrevious
Seed Ambient Session ContextNext
⌘
I
Creates an ambient session.

```
curl --request POST \
  --url https://sdp.suki-stage.com/api/v1/ambient/session/create \
  --header 'Content-Type: application/json' \
  --header 'sdp_suki_token: <sdp_suki_token>' \
  --data '
{
  "ambient_session_id": "123dfg-456dfg-789dfg-012dfg",
  "encounter_id": "123dfg-456dfg-789dfg-012dfg"
}
'
```


```
{
  "ambient_session_id": "123dfg-456dfg-789dfg-012dfg"
}
```

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
