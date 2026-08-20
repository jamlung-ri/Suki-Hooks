# API Reference Guidelines - Suki

**Source URL:** https://developer.suki.ai/api-reference/api-guidelines

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

This guide explains the
**tags**
,
**indicators**
, and
**standards**
we use in our API documentation. Understanding these conventions will help you navigate the reference materials more effectively and build robust integrations.

## ​API status tags

We use the following tags next to endpoint titles to indicate their status and maturity.

### ​[NEW]

This tag indicates that an API endpoint has been recently added to Suki for partners.
- Use this safely in production; it is fully supported and documented.
- The API may receive additional non-breaking features in future updates.


### ​[UPDATED]

This tag indicates that an API endpoint has received significant, backward-compatible enhancements or modifications.
- Look for new parameters, response fields, or behavior changes that you can implement.
- Your existing integrations should continue to work without modification.


### ​[DEPRECATED]

This tag indicates that an API endpoint is scheduled for removal in a future version.
- You should plan to migrate any existing integrations to the recommended alternatives.
- Check the documentation for the specific migration timeline and replacement APIs. Suki provides migration guides to support your transition.

You should avoid using this endpoint in new integrations.

### ​[EARLY ACCESS]

This tag indicates that an API endpoint is available for testing and feedback but may not be fully stable.
- The API’s behavior may change based on feedback, and breaking changes are possible before it becomes generally available.
- Access to this API may require special configuration. We encourage your feedback to help us improve it.

Use early access APIs with caution.
The
ws
and
webhook
indicators in the API documentation indicate that an API endpoint is a WebSocket or a Webhook endpoint.

## ​Documentation standards


### ​Parameters

Each parameter in an API request is clearly marked to ensure you know what is required.
- Required : You must include these parameters in all API requests. Requests will fail without them.
- Optional : Include these parameters to access enhanced functionality. When applicable, the documentation will note the default value used if you don’t provide one.


### ​Examples

All API endpoints include comprehensive examples to guide your implementation.
- Response examples : You will find examples of success responses with realistic data, as well as common error responses. Each field in the response is described.
- Code examples : You will find practical code snippets, such as cURL commands for direct testing and JSON payloads to illustrate the request and response structure.


## ​Version management


### ​API versioning

Our APIs follow semantic versioning principles to make updates predictable.
- Major versions ( v1 , v2 ) : Indicate breaking changes that may require you to update your code.
- Minor versions ( v1.1 , v1.2 ) : Introduce new features in a backward-compatible way.
- Patch versions ( v1.1.1 , v1.1.2 ) : Include backward-compatible bug fixes and minor improvements.

The following table shows which features are available in each version:
| Feature | v1 |
| --- | --- |
| Authentication (Login/Register) | ✓ |
| Ambient session management | ✓ |
| Audio streaming (WebSocket) | ✓ |
| Content retrieval | ✓ |
| Audio transcription | ✓ |
| Multilingual support | ✓ |
| Personalization | ✓ |
| Problem-Based Charting (PBC) | ✓ |
| Webhooks | ✓ |
| User preferences | ✓ |


### ​Backward compatibility

We are committed to making platform updates as smooth as possible.
- We communicate breaking changes well in advance and provide migration guidance.
- When we add new optional parameters, your existing integrations will not break.
- Changes to the format of API responses are additive, meaning we may add new fields, but we will not remove or alter existing ones in a breaking way.


## ​Best practices


### ​Choosing the right API

- For production use : You should use APIs that are unmarked or are tagged as [NEW] or [UPDATED] . These are stable, fully supported, and have long-term compatibility guarantees.
- For development and testing : Consider using [EARLY ACCESS] APIs to preview upcoming features and provide feedback. This can help you plan for future integrations.


### ​Migration strategy

When an API you are using is marked as
`[DEPRECATED]`
, we recommend the following process:
- Assess impact : Review your current usage of the deprecated endpoint.
- Plan timeline : Check the deprecation timeline in the documentation and plan your migration.
- Test alternatives : Implement and test the recommended replacement API.
- Migrate : Update your integration in phases to minimize disruption.


### ​Getting help

For questions about API status, migration timelines, or implementation guidance, please contact our
**customer success team**
.
Read the
API changelog
section for the latest updates and changes to the APIs.

## ​Next steps

Use the following API to get started with the Suki Platform:

## Ambient API

Learn about the Ambient API
Last modified on
April 1, 2026
HTTPS GuidelinesPrevious
AuthenticationNext
⌘
I
- Overview
- API status tags
- [NEW]
- [UPDATED]
- [DEPRECATED]
- [EARLY ACCESS]
- Documentation standards
- Parameters
- Examples
- Version management
- API versioning
- Backward compatibility
- Best practices
- Choosing the right API
- Migration strategy
- Getting help
- Next steps

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
