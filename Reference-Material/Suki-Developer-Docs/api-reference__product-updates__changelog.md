# API Changelog - Suki

**Source URL:** https://developer.suki.ai/api-reference/product-updates/changelog

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

Suki’s API versioning policy is based on the semantic versioning standard. For example, in version 1.2.3, 1 is the major version, 2 is the minor version, and 3 is the patch version.
When we release a new API version for new features or bug fixes, we increment one of these three version components depending on the type of change introduced.
​
v1.2.1
New Endpoints
March 2026

### ​New endpoints

- Audio streaming and download : We’ve added a new endpoint for audio streaming and download from ambient sessions. Stream or download the audio recording from an ambient session. GET /api/v1/ambient/session/ /recording

Learn more in the
Audio streaming and download
documentation.
​
v1.1.1
Deprecated
Feb 2026

### ​Deprecated

- Multilingual support : The multilingual parameter is deprecated in the Create Ambient Session endpoint. When you call create ambient session API, the multilingual support is now set to true by default .

​
v1.1.0
New Endpoints
Dec 2025

### ​New endpoints

- Audio transcription API : Added support for real-time audio transcription. Create transcription sessions, stream transcription data, and end sessions to get final transcripts. This enables use cases like dictation, real-time captioning, and transcript generation. POST /api/v1/transcription/session/create POST /api/v1/transcription/session/ /end GET /ws/transcribe

​
v1.0.1
Enhancements
Nov 2025

### ​Enhancements

- Code examples : Added code examples in Python and TypeScript for all SDP APIs, making it easier to integrate with the platform regardless of your preferred programming language.

​
v1.0.0
New Endpoints
Enhancements
Oct 2025

### ​New endpoints

- Info endpoints : Introduced three new info endpoints to provide supported enum values, helping you validate context data before submission and ensuring data consistency. GET /api/v1/info/encounter-types GET /api/v1/info/visit-types GET /api/v1/info/provider-roles
- API reference guidelines : Added a new API reference guidelines page to help you understand API status tags, versioning, and documentation standards.


### ​Enhancements

- Enhanced API documentation : Significantly restructured and enhanced API reference documentation for better developer experience, clearer organization, and improved discoverability.
- Problem-based charting guide : Completely rewritten the Problem-Based Charting (PBC) guide with a clearer structure and more detailed explanations of the processing pipeline.
- Audio streaming authentication : Added detailed authentication guidance for both browser and non-browser clients in the Audio streaming API reference documentation.
- Enhanced context support : Updated the Ambient session context APIs to support a new VisitContext schema, including fields like chief_complaint and visit_type . The provider context has also been enhanced to support provider_role .


### ​Removed support

- SNOMED codes : SNOMED codes are no longer supported for the diagnosis context
- Paused state : Paused state is no longer supported for ambient sessions

Last modified on
April 1, 2026
MiscellaneousPrevious
Authentication APINext
⌘
I
Filters
$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
