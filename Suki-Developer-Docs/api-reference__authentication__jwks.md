# JWKS URL - Suki

**Source URL:** https://developer.suki.ai/api-reference/authentication/jwks

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

GET
/
api
/
auth
/
.well-known
/
jwks-pub.json
Well-known JWKS endpoint

```
curl --request GET \
  --url https://sdp.suki-stage.com/api/auth/.well-known/jwks-pub.json
```


```
{
  "keys": [
    {
      "alg": "RS256",
      "e": "AQAB",
      "kid": "sdp-pub",
      "kty": "RSA",
      "n": "yeNlzlub94YgerT030codqEztjfU_S6X4DbDA_iVKkjAWtYfPHDzz_sPCT1Axz6isZdf3lHpq_gYX4Sz-cbe4rjmigxUxr-FgKHQy3HeCdK6hNq9ASQvMK9LBOpXDNn7mei6RZWom4wo3CMvvsY1w8tjtfLb-yQwJPltHxShZq5-ihC9irpLI9xEBTgG12q5lGIFPhTl_7inA1PFK97LuSLnTJzW0bj096v_TMDg7pOWm_zHtF53qbVsI0e3v5nmdKXdFf9BjIARRfVrbxVxiZHjU6zL6jY5QJdh1QCmENoejj_ytspMmGW7yMRxzUqgxcAqOBpVm0b-_mW3HoBdjQ",
      "use": "sig"
    }
  ]
}
```

Use this public endpoint to get the
(JSON Web Key Set) containing Suki’s public keys. Use these keys to verify the signature of any
issued by Suki, such as the
`suki_token`
.
This endpoint follows the
**RFC 7517**
standard.
**Authentication**
This is a public endpoint and does not require authentication.

## ​Key use cases

- Verify Tokens : Confirm the authenticity of the suki_token you receive from our authentication API.
- Handle Key Rotation : Automatically discover new public keys when Suki rotates its signing keys.
- Maintain Security : Follow industry best practices for JWT validation.


## ​Code examples

- Python
- TypeScript


```
import requests

url = "https://sdp.suki.ai/api/auth/.well-known/jwks-pub.json"

response = requests.get(url)

if response.status_code == 200:
    jwks = response.json()
    print("Public keys retrieved successfully")
    print(f"Keys: {jwks}")
else:
    print(f"Failed to retrieve JWKS: {response.status_code}")
```


```
const response = await fetch('https://sdp.suki.ai/api/auth/.well-known/jwks-pub.json');

if (response.ok) {
  const jwks = await response.json();
  console.log('Public keys retrieved successfully');
  console.log('Keys:', jwks);
} else {
  console.error(`Failed to retrieve JWKS: ${response.status}`);
}
```


#### Response

200 - */*

public key for the service


JSON Web Key Sets

​
keys
object[]
Last modified on
March 23, 2026
LoginPrevious
Ambient Session Management APINext
⌘
I
Well-known JWKS endpoint

```
curl --request GET \
  --url https://sdp.suki-stage.com/api/auth/.well-known/jwks-pub.json
```


```
{
  "keys": [
    {
      "alg": "RS256",
      "e": "AQAB",
      "kid": "sdp-pub",
      "kty": "RSA",
      "n": "yeNlzlub94YgerT030codqEztjfU_S6X4DbDA_iVKkjAWtYfPHDzz_sPCT1Axz6isZdf3lHpq_gYX4Sz-cbe4rjmigxUxr-FgKHQy3HeCdK6hNq9ASQvMK9LBOpXDNn7mei6RZWom4wo3CMvvsY1w8tjtfLb-yQwJPltHxShZq5-ihC9irpLI9xEBTgG12q5lGIFPhTl_7inA1PFK97LuSLnTJzW0bj096v_TMDg7pOWm_zHtF53qbVsI0e3v5nmdKXdFf9BjIARRfVrbxVxiZHjU6zL6jY5QJdh1QCmENoejj_ytspMmGW7yMRxzUqgxcAqOBpVm0b-_mW3HoBdjQ",
      "use": "sig"
    }
  ]
}
```

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
