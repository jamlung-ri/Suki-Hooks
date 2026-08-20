# Error Handling - Suki

**Source URL:** https://developer.suki.ai/web-sdk/guides/error-handling

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
The SDK uses a consistent error structure with error codes, names, and optional reasons to help you handle errors like initialization failures, patient creation issues, and note submission problems.


Listen for SDK-wide errors by subscribing to the
`error`
event using either the
`SukiClient`
instance (JavaScript) or the
`useSuki`
hook (React). This allows you to log and respond to issues across authentication, session management, or note handling.
Last updated:
March 2026

## ​Overview

The SDK uses a consistent error structure to help you handle errors like initialization failures, patient creation issues, and note submission problems.
All SDK errors include an
**error code**
,
**name**
, and optional
**reason**
to make debugging easier.

## ​Listening for errors

Listen for SDK-wide errors by subscribing to the
`error`
event using either the
`SukiClient`
instance (JavaScript) or the
`useSuki`
hook (React). This allows you to log and respond to issues across authentication, session management, or note handling.
- JavaScript
- React

JavaScript

```
const unsubscribeError = sdkClient.on(
  "error",
  (error) => {
    console.error("SDK error occurred:", error);
    // Use error.code, error.details.name, and error.details.reason
  },
);
```

React

```

import { useSuki } from "@suki-sdk/react";
import { useEffect } from "react";

const MyComponent = () => {
  const { on } = useSuki();

  useEffect(() => {
    const unsubscribe = on("error", (error) => {
      console.error("SDK error occurred:", error);
      // Use error.code, error.details.name, and error.details.reason
    });

    return () => {
      unsubscribe();
    };
  }, [on]);

  return <div>App Content</div>;
};
```


## ​Error object structure

Every error emitted by the SDK conforms to a predictable shape that includes a top-level code and a details object with contextual information.
SukiError.ts

```
type SukiError = {
  code: "SUKI0001" | "SUKI0002" | ...;
  details: {
    name: string; // e.g., "init:sdk-init-failed"
    message: string;
    reason?: string; // e.g., "lib-error", "no-init"
  };
};
```


### ​Example

JSON

```
{
  "code": "SUKI0001",
  "details": {
    "name": "init:sdk-init-failed",
    "message": "SDK initialization failed",
    "reason": "lib-error"
  }
}
```

For more details on the error codes and their meanings, refer to
error codes
section in the types reference.

## ​Handling specific errors

Use
`switch`
statements or conditional logic to handle specific error codes:
- JavaScript
- React

JavaScript

```
const unsubscribeError = sdkClient.on("error", (error) => {
  switch (error.code) {
    case "SUKI0002":
      console.error("Authentication failed. Please log in again.");
      break;
    case "SUKI0009":
      console.error("Patient creation failed. Check input data.");
      break;
    case "SUKI0013":
      if (error.details.reason === "no-ambient") {
        console.error("Ambient session was not found.");
      }
      break;
    default:
      console.error("Unhandled SDK error:", error.details.message);
  }
});
```

React

```
useEffect(() => {
  const unsubscribe = on("error", (error) => {
    switch (error.code) {
      case "SUKI0002":
        console.error("Authentication failed. Please log in again.");
        break;
      case "SUKI0009":
        console.error("Patient creation failed. Check input data.");
        break;
      case "SUKI0013":
        if (error.details.reason === "no-ambient") {
          console.error("Ambient session was not found.");
        }
        break;
      default:
        console.error("Unhandled SDK error:", error.details.message);
    }
  });

  return () => unsubscribe();
}, [on]);
```


## ​Best practices

- Log or report the full SukiError object for debugging and support.
- Use reason field for granular handling or user messaging.
- Always show helpful, user-friendly messages when relevant.
- Implement retries for transient errors (e.g., token expiration or network interruptions) to ensure resilience.


## ​Next steps

Refer to
Token refresh
guide to learn more about how to refresh the token and keep the session alive.
Last modified on
April 1, 2026
Note ManagementPrevious
Token RefreshNext
⌘
I
- Overview
- Listening for errors
- Error object structure
- Example
- Handling specific errors
- Best practices
- Next steps

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
