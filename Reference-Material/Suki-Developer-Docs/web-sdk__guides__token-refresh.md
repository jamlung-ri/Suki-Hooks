# Token Refresh - Suki

**Source URL:** https://developer.suki.ai/web-sdk/guides/token-refresh

---

Sukihome page
Documentation
APIs
Release Notes
Sukihome page


##### Web SDK Overview

- Introduction
- Quickstart
- Prerequisites
- Installation
- Migration to v2 v2
- Changelog


##### Web SDK Guides

- Ambient Session
- Note Management
- Error Handling
- Token Refresh
- Telehealth
- Branding


##### API Reference

- Types
- Classes
- Functions
- Hooks
- Providers
- Components


##### Examples

- Basic Usage
- Control Visibility
- Dynamic Encounter
- Ambient Events
- Test Mode
- Using the SDK Inside an Iframe
- Advanced Configuration
- Theming and Customization


##### FAQs

- Automatic User Onboarding
- General
- Technical
- Implementation

Quick summary
The SDK automatically handles SDP token refreshes to ensure uninterrupted access to Suki services. It monitors the token’s expiration time and refreshes it in the background before it expires using the
`partnerToken`
you provided during initialization.


Update the
`partnerToken`
at runtime by calling the
`setPartnerToken`
method without requiring re-authentication.
Last updated:
March 2026

## ​Overview

This guide explains how to implement automatic token refresh for the Suki Web SDK.

## ​Authentication & token exchange

The Suki Platform uses a
**token exchange mechanism**
to securely authenticate and authorize your access to the SDK. Refer to
Partner authentication
guide for more information.
When you initialize the SDK, you must provide a
`partnerToken`
(which you receive from the EHR system). The SDK exchanges this
`partnerToken`
with the Suki Platform to get an
**SDP access token**
. All subsequent API calls use this SDP access token for authorization.

### ​Automatic token refresh

The SDK automatically handles SDP token refreshes to ensure you have uninterrupted access to Suki services. It monitors the token’s expiration time and refreshes it in the background before it expires.
This process is fully automatic and uses the
`partnerToken`
you provided during initialization.

### ​Constraints

**Important:**
- For the automatic refresh to succeed, the partnerToken you provided must still be valid at the time of the refresh. If your partnerToken expires, the SDK cannot get a new SDP access token, and API calls will fail.
- Update the partnerToken at runtime by calling the setPartnerToken method; no re-authentication is required.


## ​Example

Here’s how to update the token at runtime:
- JavaScript
- React

JavaScript

```
// whenever the access token is refreshed, call `setPartnerToken` with the new token
sdkClient.setPartnerToken("new-partner-token");
```

React

```
import { useSuki } from "@suki-sdk/react";
import { useEffect } from "react";

const MyComponent = ({ token }) => {
  const { setPartnerToken } = useSuki();

  useEffect(() => {
    // whenever the access token is refreshed, call `setPartnerToken` with the new token
    setPartnerToken(token);
  }, [setPartnerToken, token]); // token is the new partner token you want to set

  return <div>App Content</div>;
};
```


## ​Next steps

Refer to
Telehealth
guide to learn more about how Suki manages telehealth sessions.
Last modified on
April 1, 2026
Error HandlingPrevious
TelehealthNext
⌘
I
- Overview
- Authentication & token exchange
- Automatic token refresh
- Constraints
- Example
- Next steps

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
