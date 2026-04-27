# Security & Best Practices - Suki

**Source URL:** https://developer.suki.ai/api-reference/security-best-practices

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

This section provides best practices for securing your Suki web SDK. These best practices are applicable to all Suki APIs.

## ​Security best practices

All API requests must use
**HTTPS**
(TLS 1.2 or higher) to ensure data encryption in transit. Never send requests over unencrypted HTTP connections.

### ​Token management

Following are the best practices for token management:

## Store tokens securely

Never expose
`sdp_suki_token`
in client-side code, logs, or version control. Store tokens securely on your backend server.

## Handle token expiration

Implement token refresh logic to automatically obtain a new
`sdp_suki_token`
when the current one expires. Call the
`/login`
endpoint with a valid
to refresh.

## Validate JWTs

When receiving
`sdp_suki_token`
from Suki, verify its signature using the public keys from the
endpoint (
Authentication/jwks
) (
`/api/auth/.well-known/jwks-pub.json`
).

## Use secure partner tokens

Your
must be a standards-compliant
signed with RS256 (RSA Signature with SHA-256) algorithm. Ensure your
endpoint is publicly accessible and properly configured.

### ​Webhook security

Following are the best practices for webhook security:

### ​Data protection

Following are the best practices for data protection:

### ​Error handling

Following are the best practices for error handling:
For more details on security and compliance, see the
Security FAQs
.
Last modified on
April 1, 2026
User AuthenticationPrevious
HTTPS GuidelinesNext
⌘
I
- Overview
- Security best practices
- Token management
- Webhook security
- Data protection
- Error handling

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
