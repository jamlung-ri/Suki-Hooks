# Login - Suki

**Source URL:** https://developer.suki.ai/api-reference/authentication/login

---

Sukihome page
Documentation
APIs
Release Notes
Sukihome page

- API Overview


##### API References

- Authentication POST Register POST Login GET JWKS URL
- Ambient Session Management
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
auth
/
login
Authenticates user.

```
curl --request POST \
  --url https://sdp.suki-stage.com/api/v1/auth/login \
  --header 'Content-Type: application/json' \
  --data '
{
  "partner_id": "your-partner-id",
  "partner_token": "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9...",
  "provider_id": "provider-123"
}
'
```


```
{
  "suki_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c"
}
```

Use this endpoint to authenticate a
. On a successful request, this endpoint returns a
(
`suki_token`
) that you must use to authorize all subsequent API calls for that user.
The
`suki_token`
is a
that is valid for
**one hour**
. It contains the
**user**
,
**organization**
, and
information needed to access Suki services.
If you are using the
Assertion authentication method, the response may also include an additional
`jwt_bearer`
field.

## ​Code examples

- Python
- TypeScript


```
import requests

url = "https://sdp.suki.ai/api/v1/auth/login"

payload = {
    "partner_id": "your-partner-id",
    "partner_token": "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9...",
    "provider_id": "provider-123"  # Optional
}

response = requests.post(url, json=payload)

if response.status_code == 200:
    data = response.json()
    suki_token = data["suki_token"]
    print(f"Authentication successful. Token: {suki_token}")
else:
    print(f"Authentication failed: {response.status_code}")
    print(response.json())
```


```
const response = await fetch('https://sdp.suki.ai/api/v1/auth/login', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({
    partner_id: 'your-partner-id',
    partner_token: 'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9...',
    provider_id: 'provider-123' // Optional
  })
});

if (response.ok) {
  const data = await response.json();
  const sukiToken = data.suki_token;
  console.log(`Authentication successful. Token: ${sukiToken}`);
} else {
  const error = await response.json();
  console.error(`Authentication failed: ${response.status}`, error);
}
```


#### Body

application/json

AuthenticationRequest


Request body for the /auth/login endpoint

​
partner_id
string
required

Unique identifier for the partner. This will be shared securely by Suki to the partner through a separate partner registration process.

Example
:

"your-partner-id"

​
partner_token
string
required

JWT token issued by trusted authorization server. The token must include Provider Email.

Example
:

"eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9..."

​
provider_id
string

Optional - Unique identifier for the provider. This is required for Bearer type partners only and will be ignored for other partner types. This must match a pre-defined expression.

Example
:

"provider-123"


#### Response


Success Response


Response received after authenticating user

​
suki_token
string
Example
:

"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c"

Last modified on
March 23, 2026
RegisterPrevious
JWKS URLNext
⌘
I
Authenticates user.

```
curl --request POST \
  --url https://sdp.suki-stage.com/api/v1/auth/login \
  --header 'Content-Type: application/json' \
  --data '
{
  "partner_id": "your-partner-id",
  "partner_token": "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9...",
  "provider_id": "provider-123"
}
'
```


```
{
  "suki_token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c"
}
```

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
