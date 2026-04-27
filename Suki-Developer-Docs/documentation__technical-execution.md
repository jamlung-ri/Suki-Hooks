# Suki SDKs technical execution - Suki

**Source URL:** https://developer.suki.ai/documentation/technical-execution

---

Sukihome page
Documentation
APIs
Release Notes
Sukihome page


##### Get Started

- Overview
- Quickstart
- Learning Path
- Choose Your Integration


##### Onboarding & Authentication

- Partner Onboarding
- Partner Authentication


##### Product Capabilities

- Ambient Documentation
- Note Sections
- Specialties
- Problem-Based Charting (PBC) UPDATED
- Multilingual Support
- Note Personalization
- Dictation
- Audio Streaming & Download NEW


##### Guides

- Notification Webhook
- MCP Integration
- Executive Summary
- Technical Execution Guide


##### Help & Support

- Support
- FAQs
- Glossary


Technical Execution


# Technical Execution


Suki SDKs & APIs · Engineering checklist


How integration works, what partners need, critical technical requirements, and integration timeline


## Technical execution at a glance


Learn how to integrate Suki SDKs and APIs into your product. Go through this technical execution guide for technical requirements and the integration process for our developer tools.


## How integration works


These four phases apply across the Web SDK, Mobile SDK, Headless Web SDK, and SDP REST APIs. Your surface changes how you implement each step; use the Critical technical requirements section below for checklists by product.

1

### Setup and configuration


Partner ID, security (JWKS), and environment setup. Install the Web or Headless package, embed the Mobile SDK, or configure SDP REST API clients.

>
2

### Authentication


Connect your IdP, issue partner tokens, and validate access for embedded SDKs or server-side SDP API calls.

>
3

### Ambient session and AI


Run sessions with Web or Headless UI, native mobile capture, or API-driven flows. Stream audio, receive transcript and structured clinical note.

>
4

### Note delivery


Receive structured payloads (JSON), map to your formats, and route to chart, record, or downstream systems.


## What partners need


To use our developer tools, you need to have the following:


### ✓ Identity & Security System


An existing authentication system (OAuth 2.0 or similar) is the foundation. The SDK connects to what’s already in place. Most organizations already meet these requirements.


### ✓ Development environment


Teams shipping a browser client with React ( @suki-sdk/react ) or JavaScript ( @suki-sdk/js ) are ready. Server-rendered-only stacks still need a supported client bundle. Standard tools and package managers are all that’s needed.


### ✓ Clinical knowledge


Clinical teams already understand their specialties and documentation requirements. That expertise configures the SDK for optimal note generation.


### ✓ Structured data path


Ability to receive structured payloads and route them into charts, care plans, billing, or other downstream systems. The SDK delivers LOINC-oriented note data your services can map and persist.


### ✓ Audio capabilities


Standard web browser microphone permissions and HTTPS connections. Capabilities every modern web application already supports.


### ✓ User information


Stable identifiers and context for the person using the SDK (for example, physician, nurse, case manager, or virtual care role), plus organization or tenant IDs you already store.


## Integration Methods


### Web SDK


Use our pre-built browser UI with the Web SDK for React or JavaScript to get started quickly.

View Checklist

### Mobile SDK


Use our native iOS SDK to integrate Suki clinical intelligence into your native iOS applications.

View Checklist

### SDP REST APIs


Use our SDP REST APIs and webhooks to integrate Suki clinical intelligence into your backend or custom client.

View Checklist

### Headless Web SDK


Use our headless Web SDK to integrate Suki clinical intelligence into your web application with full control over your own user interface.

View Checklist

## Integration timeline


From concept to production in weeks, not months.


### Build & customize


SDK integration and UI customization so the experience matches your product.


### Total time to value


2-4 weeks from start to production launch. Compare that to 6-12 months building ambient AI from scratch.

Week 1
Week 2–3
Week 4
Go-live

### Kickoff


Partner onboarding and environment setup.


### Validate & ship


Testing, QA, and production deployment with confidence.


## Expanded reference

- Web SDK
- Mobile SDK
- SDP REST APIs
- Headless Web SDK


## Critical technical requirements (Web SDK)


These five areas require attention for smooth deployment. Each requirement is standard for modern healthcare web applications.


#### Authentication


Requirements

- OAuth 2.0 compliant identity provider or custom JWT generation system
- Publicly accessible JWKS endpoint (HTTPS) for token verification
- JWT tokens signed with RS256 algorithm
- Required claims: exp , iss , aud , and user identifier


Why it matters: Secure authentication is the foundation of trust. Get this right from the start, and everything else flows smoothly.

Partner Authentication Guide

#### Installation


Requirements

- React or JavaScript development environment
- Node.js with npm, pnpm, or yarn package manager
- ES6 compatible browser environment


Package selection

- React apps: install @suki-sdk/react
- Non-React browser apps: install @suki-sdk/js


Why it matters: Match the package to the stack. React apps get React-optimized components. The JS package targets browser JavaScript outside React. This avoids unnecessary complexity.

Installation Guide

#### Specialties information


Requirements

- List of medical specialties the application supports
- Understanding of LOINC codes for clinical note sections
- Mapping between encounter types and appropriate LOINC codes


Why it matters: Context is everything. A cardiology note looks different from a behavioral health note. Proper configuration ensures notes are clinically appropriate and perfectly formatted for partner workflows.

Supported Specialties
LOINC Codes and Note Sections
Specialty Context

#### Note output and downstream integration


Requirements

- Infrastructure to receive note submission events or callbacks
- Logic to parse LOINC-encoded JSON structure
- Workflow to map Suki’s output format to your systems of record or handoff targets


Why it matters: Completed notes arrive as LOINC-encoded JSON. Partner systems receive structured, ready-to-use data for charts, exports, or internal services. No manual translation needed.

Note Submission and Retrieval

#### Microphone permissions


Requirements

- Microphone access permission flow in the application
- HTTPS connection for production (required for microphone access)
- Iframe configuration if embedding: add allow=“microphone; clipboard-write; clipboard-read” attributes


Why it matters: Audio capture is essential. Without proper microphone permissions, the system can’t function. Ensure permissions are requested and iframe configurations are correct.

Iframe Permissions Guide

## Critical technical requirements (Mobile SDK)


These areas need attention for native iOS deployments. The Mobile SDK is a headless framework: you own the UI while the SDK handles audio, sessions, and platform services.


#### Authentication and tokens


Requirements

- Implement tokenProvider protocol so the mobile SDK can request authentication tokens when needed
- Pass PartnerID , ProviderInfo , and related fields to initialize as described in configuration guide
- Use .stage for development and .prod for production


Why it matters: The SDK exchanges tokens with Suki services on a predictable contract. A correct token provider and initialization payload avoid auth failures during sessions.

Partner Authentication
Configuration

#### Installation and platform


Requirements

- Xcode project targeting iOS 13.0 or later
- SukiAmbientCore.framework added, embedded, and set to Embed & Sign
- NSMicrophoneUsageDescription in Info.plist with a clear, user-facing explanation


Why it matters: Apple enforces microphone disclosure and embedding rules. A correct deployment target and framework embedding prevent runtime crashes and App Store rejection.

Mobile SDK Installation

#### Session lifecycle and delegates


Requirements

- Session delegate implementation for lifecycle and status updates
- Recording flows aligned with your UX: start, pause, resume, end, and cancel as needed
- Background recording flag in initialize when your product requires it


Why it matters: Ambient capture is stateful. Delegates keep your UI and backend logic in sync with SDK events and errors.

Create Session
Recording Controls

#### Content and downstream integration


Requirements

- Logic to poll or receive structured content when a session completes
- Mapping of structured output into your EHR, exports, or internal services
- Offline mode awareness: recording can continue when the network is unstable; sync when connectivity returns


Why it matters: Clinical value lands when notes reach the right system. Plan retrieval and persistence before go-live.

Session Status and Content Retrieval

## Critical technical requirements (SDP REST APIs)


Use these when your backend or a custom client orchestrates login, sessions, and content without the pre-built Web SDK UI. Follow REST and streaming patterns in the API reference.


#### Authentication and tokens


Requirements

- HTTPS-only clients; obtain a Suki token via login using partner_id , partner_token , and provider_id as documented
- Partner JWTs issued consistently with your JWKS and Suki validation rules
- Secure storage and rotation of credentials in your services


Why it matters: API access is token-driven. Misconfigured login or partner tokens surface as 401s across session and content calls.

Authentication
API Quickstart

#### Endpoints and environments


Requirements

- Correct base URL and API version for stage versus production
- Use of versioned paths (for example, /api/v1/… ) per resource
- Follow our HTTPS guidelines and documented status codes


Why it matters: Environment mix-ups cause subtle failures. Pin URLs per environment in configuration, not in scattered constants.

API Overview
HTTPS Guidelines

#### Ambient operations


Requirements

- REST flows for ambient session lifecycle and ambient content as your integration requires
- Audio or streaming integrations where the API uses WebSockets for real-time transmission
- Webhook or polling patterns if your architecture consumes async completion signals


Why it matters: Ambient features span REST and streaming. Plan both client behavior and server-side orchestration up front.

Ambient Session Management
Ambient Content Retrieval

#### Operational readiness


Requirements

- Retry and error-handling policies aligned with your SLA and the platform’s HTTP semantics
- Logging and monitoring that avoid PHI in unsecured logs
- Load and rate expectations validated with your Suki contact for high-volume workloads


Why it matters: Production APIs need observability and safe handling of transient failures, especially in clinical workflows.

Webhook Notifications

## Critical technical requirements (Headless Web SDK)


Partner authentication and tokens are the same as the Web SDK. Headless differs because you build your own UI and integrate useAuth , ambient hooks, and related APIs instead of pre-built components.


#### Authentication


Requirements


Same partner authentication checklist as the Web SDK tab.

- OAuth 2.0 compliant identity provider or custom JWT generation system
- Publicly accessible JWKS endpoint (HTTPS) for token verification
- JWT tokens signed with RS256 algorithm
- Required claims: exp , iss , aud , and user identifier


Why it matters: It is the same trust model as the Web SDK. In Headless you connect tokens through useAuth and related hooks; auth gaps block ambient APIs until identity is wired correctly.

Partner Authentication Guide
Headless Authentication

#### Installation and runtime


Requirements

- React 18.0 or higher
- Install @suki-sdk/platform-react with npm, pnpm, or yarn
- ES6-compatible browser environment


Why it matters: The package ships React hooks. Version and bundler assumptions must match what we test and support.

Headless Installation

#### Partner configuration


Requirements

- partnerId from Suki during onboarding
- Test and production host URLs allowlisted for your app
- User identifier field in the JWT agreed during onboarding and reflected in tokens


Why it matters: Headless initialization fails fast when hosts or user identity keys do not match what Suki configured for your tenant.

Prerequisites
Partner Onboarding

#### Ambient hooks and browser permissions


Requirements

- Integrate ambient and session hooks per quickstart; handle pending, error, and completion states in your UI
- Microphone permission UX and HTTPS in production
- If you embed in an iframe, set appropriate allow attributes for microphone (and clipboard if needed)


Why it matters: You own the experience. Explicit permission and error paths keep capture reliable for clinicians.

Headless Quickstart
Ambient Hook
⌘
I
$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
