# Choose Your Integration - Suki

**Source URL:** https://developer.suki.ai/documentation/integration-decision-guide

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


## ​Overview

The Suki for partners offers four integration paths. Choose based on your application type, stack, and how much user interface you want to own.

## ​Integration options


## Direct APIs

**Recommended for:**
• Backend systems and server integrations


• Custom user interfaces on any stack


• Multi-platform applications
**What you build:**
• Complete user interface


• Authentication flow


• Audio handling and API/WebSocket usage

## Web SDK

**Recommended for:**
• Web-based healthcare applications


• Browser-based EHR integrations


• Teams that want pre-built clinical UI
**What’s provided:**
• Pre-built UI components


• Authentication handling


• Audio processing

## Headless Web SDK

**Recommended for:**
• React web applications (React 18+)


• Custom UI that matches your design system


• Full control over recording controls, status, and layout
**What’s provided:**
• React hooks for auth and ambient sessions


• Core ambient, streaming, and session behavior


• No pre-built clinical UI (you build the interface)

## Mobile SDK

**Recommended for:**
• Native iOS applications


• Mobile healthcare apps


• Apps requiring native device features
**Platform support:**
• iOS (available now)


• Android (in development)

## ​How to choose

- By Project Type
- By Team Skills
- By Requirements


## Frontend/React Experience

**Recommended: Web SDK or Headless Web SDK**
Use
**Web SDK**
for pre-built UI and speed. Use
**Headless Web SDK**
when you will build custom UI in React with hooks.

## Backend/API Experience

**Recommended: Direct APIs**
Full control and leverages existing API development skills

## iOS/Swift Experience

**Recommended: Mobile SDK**
Native iOS functionality with SDK support and familiar development patterns

## Limited Development Resources

**Recommended: Web SDK**
Requires minimal custom UI work with ready-to-use components
| Your Need | Recommended Choice | Why |
| --- | --- | --- |
| Quick integration in the browser | Web SDK | Ready-to-use components, minimal setup |
| Custom web UI in React | Headless Web SDK | Hooks for platform behavior; you own layout and components |
| Custom UI/UX without React on the web | Direct APIs | Use your stack and patterns against the API |
| Native mobile features (iOS) | Mobile SDK | Native device integration and performance |
| Multi-platform support | Direct APIs | Same API surface across web, mobile, and backend |
| Complete UX control (any client) | Direct APIs | Build exactly what you need at the protocol level |
| Proven clinical workflows in the browser | Web SDK | Pre-built healthcare interface patterns |

**HIPAA Compliance**
: All integration methods can be implemented in a HIPAA-compliant manner. Compliance depends on your implementation practices and security measures.

## ​Prerequisites

Before integrating with any Suki Platform method, you must complete the partner onboarding process:

### ​Required for all integration methods

**Partner Registration:**
- Complete the Partner onboarding process
- Receive your unique partner_id from Suki
- Provide your JWKS endpoint URL to Suki for token validation

**Authentication System:**
- OAuth 2.0 compliant authentication system
- JWT token generation with consistent user identifier
- Publicly accessible JWKS endpoint for token verification


### ​Additional requirements by method

**Web SDK:**
- ES6+ compatible browsers
- Host URLs whitelisted with Suki for SDK embedding

**Headless Web SDK:**
- React 18.0 or higher
- ES6+ compatible browsers
- Host URLs for your test and production apps provided to Suki for allowlisting (see Headless Web SDK prerequisites )

**Mobile SDK (iOS):**
- iOS 14.0 or later
- Xcode development environment
- Audio recording permissions in your app

**Direct APIs:**
- WebSocket client implementation capability
- HTTPS/TLS support for secure API communication


## ​Integration scenarios

- Web Applications
- Mobile Applications
- Backend Systems


## ​Next steps

To begin your integration, review the documentation for your chosen approach:

## Web SDK Quickstart

Get started with pre-built components and fast integration

## Headless Web SDK Quickstart

React hooks, custom UI, and ambient sessions in your application

## API Overview

Build custom integrations with maximum flexibility

## Mobile SDK Overview

Native iOS integration for mobile applications

## Partner Onboarding

Start your integration journey with Suki

## ​Get personalized integration guidance

If your use case doesn’t clearly match the scenarios above, or you need specific technical advice for your healthcare application, our customer success team provides personalized consultation.
**Before contacting support or sales, please prepare:**
- Description of your healthcare application and clinical workflows
- Target platform (web with React or not, iOS, Android, backend system)
- Development timeline and resource constraints
- Specific technical requirements or compliance needs

**Contact options:**
- Technical consultation : Schedule a call with our integration team
- Development support : support@suki.ai
- Community discussions : Contact us for community access

Last modified on
April 1, 2026
Developer Learning PathPrevious
Partner OnboardingNext
⌘
I
- Overview
- Integration options
- How to choose
- Prerequisites
- Required for all integration methods
- Additional requirements by method
- Integration scenarios
- Next steps
- Get personalized integration guidance

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
