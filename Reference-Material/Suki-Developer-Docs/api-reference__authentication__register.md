# Register - Suki

**Source URL:** https://developer.suki.ai/api-reference/authentication/register

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
register
Registers a user.

```
curl --request POST \
  --url https://sdp.suki-stage.com/api/v1/auth/register \
  --header 'Content-Type: application/json' \
  --data '
{
  "partner_id": "your-partner-id",
  "partner_token": "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9...",
  "provider_id": "provider-123",
  "provider_name": "Dr. John Smith",
  "provider_org_id": "org-123",
  "provider_specialty": "CARDIOLOGY"
}
'
```


```
This response has no body data.
```

Use this endpoint to register a
**new healthcareprovider**
in the Suki platform or to link an
**existing provider**
to a new
**Partner**
-organization relationship.
This is a
**one-time**
setup call for each provider within an organization.

## ​Registration scenarios

This endpoint handles
**three**
different scenarios depending on the user’s status in the Suki system.
| Scenario | Condition | Actions Taken | Response |
| --- | --- | --- | --- |
| New User | The provider does not exist in Suki. | • Creates a new organization •  Links your partner account to the organization •  Creates a new user with the provided details | 201 Created |
| Existing User, New Link | The provider exists but is not yet linked to your partner account. | • Verifies the user and organization details • Links your partner account to the existing organization | 201 Created |
| Existing User, Already Linked | The provider and organization are already linked to your partner account. | • Detects the existing link | 409 Conflict |


## ​Code examples

- Python
- TypeScript


```
import requests

url = "https://sdp.suki.ai/api/v1/auth/register"

payload = {
    "partner_id": "your-partner-id",
    "partner_token": "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9...",
    "provider_name": "Dr. John Smith",
    "provider_org_id": "org-123",
    "provider_id": "provider-123",  # Optional
    "provider_specialty": "CARDIOLOGY"  # Optional, defaults to FAMILY_MEDICINE
}

response = requests.post(url, json=payload)

if response.status_code == 201:
    print("Provider registered successfully")
elif response.status_code == 409:
    print("Provider already linked to this partner")
else:
    print(f"Registration failed: {response.status_code}")
    print(response.json())
```


```
const response = await fetch('https://sdp.suki.ai/api/v1/auth/register', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({
    partner_id: 'your-partner-id',
    partner_token: 'eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9...',
    provider_name: 'Dr. John Smith',
    provider_org_id: 'org-123',
    provider_id: 'provider-123', // Optional
    provider_specialty: 'CARDIOLOGY' // Optional, defaults to FAMILY_MEDICINE
  })
});

if (response.status === 201) {
  console.log('Provider registered successfully');
} else if (response.status === 409) {
  console.log('Provider already linked to this partner');
} else {
  const error = await response.json();
  console.error(`Registration failed: ${response.status}`, error);
}
```


#### Body

application/json

RegistrationRequest


Request body for the /auth/register endpoint

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
provider_name
string
required

Name of the provider.

Example
:

"Dr. John Smith"

​
provider_org_id
string
required

Health system or organization to which the provider belongs.

Example
:

"org-123"

​
provider_id
string

Optional - Unique identifier for the provider. This is required for Bearer type partners only and will be ignored for other partner types. This must match a pre-defined expression.

Example
:

"provider-123"

​
provider_specialty
string

Optional - Medical specialty of the provider. Defaults to FAMILY_MEDICINE if not provided.

Example
:

"CARDIOLOGY"


#### Response

Last modified on
March 23, 2026
Authentication APIPrevious
LoginNext
⌘
I
Registers a user.

```
curl --request POST \
  --url https://sdp.suki-stage.com/api/v1/auth/register \
  --header 'Content-Type: application/json' \
  --data '
{
  "partner_id": "your-partner-id",
  "partner_token": "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9...",
  "provider_id": "provider-123",
  "provider_name": "Dr. John Smith",
  "provider_org_id": "org-123",
  "provider_specialty": "CARDIOLOGY"
}
'
```


```
This response has no body data.
```

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
