# HTTPS Guidelines - Suki

**Source URL:** https://developer.suki.ai/api-reference/https-guidelines

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

Suki uses
**standard HTTP status codes**
to indicate the outcome of an API request.
- 2xx codes indicate success.
- 4xx codes indicate a client-side error (e.g., you omitted a required parameter or provided an invalid configuration).
- 5xx codes indicate a server-side error on Suki’s end. These are rare.

The following table lists the most common HTTP status codes you may receive.
| Code | Title | Description |
| --- | --- | --- |
| 200 | OK | The request was successful. |
| 201 | Created | The resource was created successfully. The URL for the new resource is in the Location header. |
| 204 | No Content | The request was successful, and there is no content to return. |
| 400 | Bad Request | The request was unacceptable, often due to malformed syntax or a missing parameter. |
| 401 | Unauthorized | The request was not authenticated. This could be due to missing, invalid, or insufficient credentials. |
| 402 | Over Quota | The request was valid, but you have exceeded your plan’s quota or rate limits. |
| 403 | Forbidden | The request was not authenticated. This could be due to missing, invalid, or insufficient credentials. |
| 404 | Not Found | The requested resource does not exist. |
| 409 | Conflict | The request conflicts with the current state of the resource (e.g., the resource already exists, or the request was based on stale data). |
| 422 | Validation Failed | The request was parsed correctly but failed a validation rule. |
| 429 | Too Many Requests | You have sent too many requests in a short period. We recommend using an exponential backoff strategy for your requests. |
| 500, 502, 503, 504 | Server Errors | An unexpected error occurred on Suki’s servers. |

Last modified on
March 23, 2026
Security & Best PracticesPrevious
API Reference GuidelinesNext
⌘
I
$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
