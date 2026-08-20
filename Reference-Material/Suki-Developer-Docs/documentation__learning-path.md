# Developer Learning Path - Suki

**Source URL:** https://developer.suki.ai/documentation/learning-path

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


## ​Your journey to Suki integration

Follow this structured path to successfully integrate Suki’s AI-powered healthcare capabilities. Each step builds on the previous one, ensuring you have a solid foundation before moving forward.
**Estimated Total Time**
: 4-6 weeks from start to production deployment

## ​Foundation setup


### ​Step 1: Partner onboarding

**Goal**
: Get registered with Suki and receive your

## What You'll Do

- Contact Suki partnership team
- Provide business information and authentication method
- Receive your unique partner_id

**Prerequisites**
: Business information, chosen authentication method
**Time**
: 3-5 business days
**Next Step**
: Once you have your
`partner_id`
, move to Step 2
Start Partner Onboarding

### ​Step 2: Authentication setup

**Goal**
: Configure secure authentication between your system and Suki

## What You'll Do

- Choose authentication method ( JWKS , Okta, JWT Assertion)
- Set up your identity provider integration
- Test token generation and validation

**Prerequisites**
:
from Step 1, access to your identity provider
**Time**
: 2-3 days
**Next Step**
: With authentication working, choose your integration path
Setup Authentication

---


## ​Integration choice


### ​Step 3: Choose your integration path

**Goal**
: Select the best integration method for your application

## Web SDK

**Best for**
: React/JavaScript web apps that want Suki UI
- Pre-built clinical UI components
- Automatic state management
- Fastest browser implementation


## Headless Web SDK

**Best for**
: React 18+ web apps with a custom UI
- Hooks for auth, sessions, and recording
- You build all interface and layout
- Same core ambient behavior as the Web SDK


## Mobile SDK

**Best for**
: Native iOS applications
- Optimized for mobile audio
- Native performance
- Offline capabilities


## Direct APIs

**Best for**
: Custom implementations on any stack
- Maximum flexibility
- Any programming language
- Full control at the API/WebSocket level

**Time**
: 1-2 hours to evaluate options
Decision Guide

---


## ​Implementation

- Web SDK path
- Headless Web SDK path
- Mobile SDK path
- API path


### ​Step 4a: Web SDK setup

**Goal**
: Install and configure the Suki Web SDK
1

Install package (15 min)

Install the Suki Web SDK in your React application

```
npm install @suki/web-sdk
```

**Next**
: Configure your environment variables
2

Basic configuration (30 min)

Set up the SDK provider and basic configuration

```
import { SukiProvider } from '@suki/web-sdk';

function App() {
  return (
    <SukiProvider partnerId="your-partner-id">
      {/* Your app components */}
    </SukiProvider>
  );
}
```

**Next**
: Create your first ambient session
3

First ambient session (45 min)

Implement a basic ambient documentation session
**What you’ll build**
: A simple page that can start recording, capture audio, and generate a clinical note
**Next**
: Test with sample audio and verify note generation
Web SDK quickstart →

### ​Step 4b: Headless Web SDK setup

**Goal**
: Install the Headless Web SDK and wire authentication and ambient hooks in React
1

Install package (15 min)

Install the Headless Web SDK in a
**React 18+**
project

```
npm install @suki-sdk/platform-react
```

Confirm your test and production
**host URLs**
are on the Suki allowlist (see
Headless Web SDK prerequisites
).
**Next**
: Authenticate with
`useAuth`
2

Authentication hooks (45 min)

Add the
`useAuth`
hook with your
`partnerId`
and
`partnerToken`
(the user token from your EHR or backend, as described in the
Authentication hook
guide)

```
import { useAuth } from '@suki-sdk/platform-react';

function App() {
  const { isLoggedIn, isPending, error, login } = useAuth({
    partnerId: 'your-partner-id',
    partnerToken: 'your-partner-token',
    // See Authentication hook guide for full options
  });
  // Render your own sign-in UI and loading states
}
```

**Next**
: Create an ambient session with
`useAmbient`
3

Session and recording (60 to 90 min)

Create a session with
`useAmbient`
, then use
`useAmbientSession`
for recording lifecycle and status
**What you’ll build**
: Your own controls and layout (start, pause, submit) backed by hook state, plus retrieval of note content when processing completes
**Next**
: Follow the quickstart through your first end-to-end recording, then harden error handling
For step-by-step code, use the quickstart and
Authentication hook
,
Ambient hook
, and
Ambient session hook
guides.
Headless Web SDK quickstart →

### ​Step 4c: Mobile SDK setup

**Goal**
: Install and configure the Suki Mobile SDK
1

Install framework (20 min)

Add the Suki Mobile SDK to your iOS project
**Methods**
: SPM, CocoaPods, or manual installation
**Next**
: Configure permissions and capabilities
2

Basic configuration (45 min)

Initialize the SDK and set up basic configuration

```
import SukiSDK

SukiSDK.configure(
    partnerId: "your-partner-id",
    environment: .staging
)
```

**Next**
: Implement session management
3

First ambient session (60 min)

Create a basic ambient session with recording capabilities
**What you’ll build**
: A view controller that can create sessions, record audio, and retrieve generated notes
**Next**
: Test with device microphone and verify functionality
Mobile SDK installation →

### ​Step 4d: Direct API integration

**Goal**
: Implement Suki’s APIs directly in your application
1

Authentication implementation (60 min)

Implement the authentication flow to get Suki tokens
**Key endpoints**
:
`/auth/register`
,
`/auth/login`
**Next**
: Test token generation and validation
2

Session management (90 min)

Implement ambient session creation and management
**Key endpoints**
:
- POST /ambient-sessions - Create session
- POST /ambient-sessions/{id}/context - Set context
- GET WebSocket - Audio streaming

**Next**
: Implement audio streaming
3

Content retrieval (45 min)

Implement note generation monitoring and content retrieval
**Key endpoints**
:
- GET /ambient-content/{id}/status - Check status
- GET /ambient-content/{id}/content - Get generated note

**Next**
: Test end-to-end workflow
API overview →

---


## ​Advanced features

*Estimated Time: 1-2 weeks*

### ​Step 5: Add advanced capabilities

**Goal**
: Enhance your integration with Suki’s advanced features

## Multilingual Support

**Time**
: 2-3 hours
Enable support for 80+ languages with automatic English note generation
**Key Features**
:
- Automatic language detection
- Multi-language conversations
- English output standardization


## Problem-Based Charting

**Time**
: 4-6 hours
Implement diagnosis-focused documentation structure
**Key Features**
:
- Problem-oriented notes
- Diagnosis tracking
- Enhanced clinical workflows


## Custom Note Sections

**Time**
: 2-4 hours
Configure custom clinical note sections using LOINC codes
**Key Features**
:
- 26+ standard sections
- Custom section ordering
- EHR integration ready


## User Preferences

**Time**
: 3-5 hours
Allow providers to customize their documentation preferences
**Key Features**
:
- Personal note styling
- Section preferences
- Workflow customization


---


## ​Production readiness

*Estimated Time: 1 week*

### ​Step 6: Testing & optimization

**Goal**
: Ensure your integration is production-ready

## What you'll do

- Comprehensive testing with real clinical scenarios
- Performance optimization and error handling
- Security review and compliance verification
- User acceptance testing with healthcare providers

**Key areas**
:
- Audio quality and streaming reliability
- Note generation accuracy and speed
- Error handling and recovery
- HIPAA compliance verification

**Time**
: 3-5 days

### ​Step 7: Go live

**Goal**
: Deploy your Suki-powered application to production

## Production deployment

- Switch to production environment
- Monitor initial usage and performance
- Gather user feedback and iterate
- Scale based on usage patterns

**Support resources**
:
- 24/7 technical support during launch
- Performance monitoring and alerts
- Regular check-ins with Suki team

Get Support

## ​Next steps

If you have all the required information and
`partner_id`
, start with the
Getting started guide
to get oriented. Then open the quickstart or overview for your path:
Web SDK
,
Headless Web SDK
,
Mobile SDK
, or
API overview
.
Last modified on
April 1, 2026
Quickstart GuidePrevious
Choose Your IntegrationNext
⌘
I
- Your journey to Suki integration
- Foundation setup
- Step 1: Partner onboarding
- Step 2: Authentication setup
- Integration choice
- Step 3: Choose your integration path
- Implementation
- Advanced features
- Step 5: Add advanced capabilities
- Production readiness
- Step 6: Testing & optimization
- Step 7: Go live
- Next steps

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
