# User Authentication - Suki

**Source URL:** https://developer.suki.ai/api-reference/provider-authentication

---

Sukihome page
Documentation
APIs
Release Notes
Sukihome page

- API Overview Quickstart User Authentication Security & Best Practices HTTPS Guidelines API Reference Guidelines FAQs Changelog


##### API References

- Authentication
- Ambient Session Management
- Dictation
- Ambient Content Retrieval
- User Preferences
- User Feedback
- Send Notifications
- Info


## ​Overview

To use the
**Suki SDP APIs**
, you must first authenticate your users to get a
(also known as
`sdp_suki_token`
).
This guide explains the
**two main endpoints**
for the authentication workflow:
- Register user : A one-time call to register a new provider in the Suki system.
- Authenticate user : Call this endpoint to get a suki_token ( sdp_suki_token ) for a registered provider.

**Not a Suki Partner?**
To use the Suki APIs, you must first register your organisation as a partner. To begin, please follow the
Partner onboarding
guide to learn more.
After you are registered, you will use a
(
`partnerToken`
) to authenticate your API requests. The
`partnerToken`
is a
that
**you**
provide, and it is a
**required parameter**
when registering a provider. Find more details on how to get a
`partnerToken`
in the
Partner authentication
guide.

## ​Register provider/user account

Use the below endpoint to
**register**
a new
**provider/user**
in the Suki platform. You only need to do this
**once**
for each new provider.
**Endpoint**
:
Register
**Method:**
POST

### ​Registration scenarios

$!
/$
The
`Register`
endpoint handles three main scenarios:
- New user registration : If the provider does not exist in the Suki system, this call creates a new user and links them to your partner account and organization.
- Existing user, new partner link : If the provider already exists but is not linked to your partner account, this call links them to your partner and their existing organization.
- Existing user, already linked : If the provider is already registered and linked to your partner account, the API returns a 409 Conflict error.


## ​Authenticate provider/user session

After a provider is registered, call
Login
endpoint to get a Suki access token (
`sdp_suki_token`
).

### ​JWKS endpoint

Suki provides a public
**JWKS (JSON Web Key Set)**
endpoint that you can use to verify the signature of the
`sdp_suki_token`
that our API returns.
**Endpoint:**
`/api/auth/.well-known/jwks-pub.json`
**Method:**
GET
**Authentication:**
None (Public)

### ​Use cases

$!
/$
- Token verification : Fetch public keys to verify JWTs issued by Suki.
- Signature validation : Validate the signature of the sdp_suki_token .
- Key rotation : Automatically discover new public keys when Suki rotates our signing keys.

Last modified on
April 1, 2026
Ambient API QuickstartPrevious
Security & Best PracticesNext
⌘
I
- Overview
- Register provider/user account
- Registration scenarios
- Authenticate provider/user session
- JWKS endpoint
- Use cases

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
