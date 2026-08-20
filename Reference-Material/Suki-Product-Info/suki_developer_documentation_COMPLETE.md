# Suki Developer Platform — Complete Technical Documentation
**Source:** https://developer.suki.ai  
**Retrieved:** April 2026  
**Pages captured:** 16 of ~20+ available pages

---

## TABLE OF CONTENTS

**Get Started**
1. Overview — Suki For Partners
2. Quickstart Guide
3. Learning Path
4. Choose Your Integration

**Onboarding & Authentication**
5. Partner Onboarding
6. Partner Authentication

**Product Capabilities**
7. Ambient Documentation
8. Note Sections (LOINC Codes)
9. Supported Medical Specialties
10. Audio Dictation
11. Audio Streaming & Download

**Guides**
12. Notification Webhook
13. MCP Integration
14. Executive Summary
15. Technical Execution Guide

**API Reference**
16. Ambient API Overview
17. Ambient API Quickstart
18. Security & Best Practices

---
---

# 1. OVERVIEW — SUKI FOR PARTNERS
**URL:** https://developer.suki.ai/documentation/overview

Clinicians entered medicine to focus on people, but technology forced them to focus on screens instead. Constant clicks, typing, and note creation stole their most valuable asset: **attention**. This daily administrative burden forced doctors to manage paperwork instead of their patients.

Suki for Partners changes this. Our ambient intelligence APIs and SDKs make technology invisible and assistive. Suki captures conversations and automatically transforms them into clinical documentation in the background. Clinicians can now focus entirely on their patients. Documentation is automated, clerical work disappears, and attention returns to what matters most: **patient care**.

## What Is Suki For Partners?

Suki for Partners is a developer platform that lets you integrate AI-powered clinical intelligence into your healthcare applications. Use our SDKs and APIs to add:

- **Ambient clinical documentation** — Automatically generate clinical notes from conversations
- **Natural language voice interaction** — Voice-powered healthcare workflows
- **Medically-tuned dictation** — Accurate medical speech recognition

## Why Choose Suki For Partners?

Building AI capabilities in-house is complex and time-consuming. Suki for Partners gives you a faster way to add AI-powered healthcare features without building and maintaining your own AI infrastructure.

**Key benefits:**
- **Purpose-Built for Healthcare** — Built specifically for healthcare, enabling you to quickly deploy clinical workflows and documentation features.
- **AI Differentiation** — Use the latest AI technology to differentiate your solutions.
- **Customizable** — Customize the look and feel with our web SDK.
- **Higher User Adoption** — Drive stronger adoption by reducing clinician burnout.
- **Secure & Compliant** — Compliant with HIPAA guidelines with secure and private data handling.
- **Fast Integration** — Integration takes weeks, not months.

## What Can You Build?

- **Ambient Clinical Documentation** — Automatically generate clinical notes from doctor-patient conversations
- **Voice-Powered Workflows** — Add natural language interaction to healthcare apps
- **EHR Integration** — Seamlessly connect with existing electronic health records
- **Mobile Healthcare Apps** — Build iOS and Android apps with AI documentation features

## Core Capabilities

- **Multilingual Support** — 80+ languages with automatic English note generation
- **Personalization** — Customize note generation based on provider preferences
- **Problem-Based Charting (PBC)** — Organize notes by patient problems and diagnoses
- **Note Sections** — Configure custom sections using standard LOINC codes
- **Ambient Documentation** — Automatically generate clinical notes from conversations
- **Specialties** — Optimize note generation for specific medical specialties
- **Transcription / Dictation** — Real-time audio transcription service

## Integration Methods

### REST APIs
Use our APIs for direct access to Suki's AI features:
- Build a completely custom user interface
- Integrate specific functions into an existing system
- Have full control over the user experience

> The Ambient Clinician Note Generation API is in **Early Access**. Contact the partnership team to request access.

### Web SDK
Pre-built UI components for web-based healthcare applications using React or JavaScript. A **Headless Web SDK** (Beta) provides React hooks with complete UI control.

### Mobile SDK
A headless SDK for native mobile applications. Currently supports **iOS**; Android support is coming soon.

---
---

# 2. QUICKSTART GUIDE
**URL:** https://developer.suki.ai/documentation/getting-started  
**Estimated Time:** 30–45 minutes

## What You'll Accomplish

- Set up authentication with Suki Platform
- Choose and integrate your preferred SDK or API
- Create your first ambient session with patient information
- Record and stream audio for at least 1 minute
- Retrieve a fully structured clinical note with transcript

## Prerequisites

- OAuth-compliant authentication system
- JWT tokens with consistent user identifiers
- Publicly accessible JWKS endpoint
- ES6 compatible browser (for Web SDK)
- **Partner ID** — provided by Suki

## Authentication Methods

- **Stored Secret** — Provide your public key to Suki; stored securely as an encrypted file
- **JWKS URL** — Host public keys at a public JSON Web Key Set endpoint
- **Okta** — Use Okta as your IDP; Suki obtains the public key from your Okta issuer URL
- **JWT Assertion** — Share your public key as a signed JWT following RFC 7523

## Step 1: Choose Integration Path

- **Web SDK** — Best for React/JavaScript web apps. Pre-built UI, automatic state management.
- **Mobile SDK** — Best for native iOS. Optimized for mobile audio capture.
- **Direct APIs** — Best for custom implementations. Maximum flexibility.

## Step 2: Integration Setup

### Web SDK

```bash
npm install @suki-sdk/js
# or for React:
npm install @suki-sdk/react
```

**Initialize:**
```javascript
import { initialize } from "@suki-sdk/js";

const sdkClient = initialize({
  partnerId: "YOUR_PARTNER_ID",
  partnerToken: "YOUR_PARTNER_JWT_TOKEN",
  providerName: "John Doe",
  providerOrgId: "1234",
});
```

**Mount with encounter data:**
```javascript
const encounterDetails = {
  identifier: "6ec3920f-b0b1-499d-a4e9-889bf788e5ab",
  patient: {
    identifier: "905c2521-25eb-4324-9978-724636df3436",
    name: { use: "official", family: "Doe", given: ["John"] },
    birthDate: "1990-01-01",
    gender: "Male",
  },
};

const unsubscribeInit = sdkClient.on("init:change", (isInitialized) => {
  if (isInitialized) {
    sdkClient.mount({
      rootElement: document.getElementById("suki-root"),
      encounter: encounterDetails,
    });
  }
});
```

Record at least 1 minute → click stop → note appears automatically.

---

### Mobile SDK (iOS / Swift)

```swift
import SukiAmbientCore

SukiAmbientCoreManager.shared.environment = .stage

let partnerInfo: [String: AnyHashable] = [
    SukiAmbientConstant.kPartnerId: "your-partner-id",
    SukiAmbientConstant.kProviderInfo: [
        SukiAmbientConstant.kOrgId: "provider_org_id",
        SukiAmbientConstant.kName: "Dr. Jane Smith",
        SukiAmbientConstant.kId: "providerId",
        SukiAmbientConstant.kSpeciality: "FAMILY_MEDICINE"
    ]
]

try SukiAmbientCore.shared.initialize(
    withPartnerInfo: partnerInfo, with: true,
    onCompletion: { result in }, withSessionDelegate: self, withTokenProvider: self
)
```

**Create session:**
```swift
SukiAmbientCoreManager.shared.createSession(with: [
    SukiAmbientConstant.kSessionId: "<encounter-id>",
    SukiAmbientConstant.kIsMultilingual: false
] as [String: AnyHashable], onCompletion: { result in })
```

**Record and retrieve:**
```swift
try SukiAmbientCore.shared.start()   // Start
try SukiAmbientCore.shared.end()     // End

SukiAmbientCore.shared.content(for: recordingId) { result in
    // result contains the generated note
}
```

---

### Direct API

**Authenticate:**
```bash
curl -X POST https://sdp.suki.ai/api/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{"partner_id":"your-id","partner_token":"your-jwt","provider_id":"provider-123"}'
```
→ Save `suki_token`. Valid 1 hour. Use as `sdp_suki_token` header.

**Create session:**
```bash
curl -X POST https://sdp.suki.ai/api/v1/ambient/session/create \
  -H "sdp_suki_token: YOUR_SUKI_TOKEN" -H "Content-Type: application/json" \
  -d '{"ambient_session_id":"uuid","encounter_id":"uuid"}'
```

**Stream audio via WebSocket:**
- URL: `wss://sdp.suki.ai/ws/stream`
- Browser header: `Sec-WebSocket-Protocol: SukiAmbientAuth,<session_id>,<token>`
- Non-browser: use `sdp_suki_token` and `ambient_session_id` as HTTP headers

**End session:**
```bash
curl -X POST "https://sdp.suki.ai/api/v1/ambient/session/SESSION_ID/end" \
  -H "sdp_suki_token: YOUR_SUKI_TOKEN"
```

**Retrieve content:**
```bash
curl -X GET "https://sdp.suki.ai/api/v1/ambient/session/SESSION_ID/content?cumulative=false" \
  -H "sdp_suki_token: YOUR_SUKI_TOKEN"
```

> **Session Duration Requirement:** Sessions must be **at least 1 minute long**. Shorter sessions get `SKIPPED` status.

## Session Status Values

| Status | Meaning |
|--------|---------|
| `created` | Session initialized |
| `ready` | Session ready to record |
| `running` | Recording in progress |
| `completed` | Note generated successfully |
| `skipped` | Session too short (<1 min) |
| `aborted` | Session cancelled |
| `failed` | Error occurred |

## Troubleshooting

| Problem | Fix |
|---------|-----|
| 401 Unauthorized | Verify partner_id and JWT; check JWKS endpoint is public |
| Session creation failed | Use `sdp_suki_token` header (not `Authorization: Bearer`) |
| WebSocket fails | URL: `wss://sdp.suki.ai/ws/stream`; check token expiry (1 hour) |
| Status SKIPPED | Session must be ≥1 min with actual speech |
| Empty transcript | Audio format: PCM, 16-bit, 16kHz mono; check EOF message sent |
| Empty content | Wait 5–10s after ending; verify status is COMPLETED, not PROCESSING |

---
---

# 3. LEARNING PATH
**URL:** https://developer.suki.ai/documentation/learning-path  
**Estimated Total Time:** 4–6 weeks from start to production deployment

## Foundation Setup

**Step 1 — Partner Onboarding** (3–5 business days)
- Contact Suki partnership team
- Provide business information and authentication method
- Receive your unique `partner_id`

**Step 2 — Authentication Setup** (2–3 days)
- Choose authentication method (JWKS, Okta, JWT Assertion)
- Set up your identity provider integration
- Test token generation and validation

## Integration Choice

**Step 3 — Choose Your Integration Path** (1–2 hours)

| Path | Best For |
|------|----------|
| Web SDK | React/JavaScript web apps — pre-built UI, fastest implementation |
| Mobile SDK | Native iOS — optimized for mobile audio, native performance |
| Direct APIs | Custom/backend — maximum flexibility, any language |

## Implementation

**Step 4a — Web SDK Setup**
1. Install `@suki/web-sdk` (15 min)
2. Configure `SukiProvider` (30 min)
3. Implement first ambient session (45 min)

**Step 4b — Mobile SDK Setup**
1. Install framework via SPM, CocoaPods, or manual (20 min)
2. Configure SDK and permissions (45 min)
3. Implement first ambient session (60 min)

**Step 4c — Direct API Integration**
1. Implement authentication (`/auth/register`, `/auth/login`) (60 min)
2. Implement session management + WebSocket audio (90 min)
3. Implement content retrieval (45 min)

## Advanced Features (1–2 weeks)

- **Multilingual Support** (2–3 hrs) — 80+ languages, automatic English output
- **Problem-Based Charting** (4–6 hrs) — Problem-oriented notes, diagnosis tracking
- **Custom Note Sections** (2–4 hrs) — Configure LOINC codes
- **User Preferences** (3–5 hrs) — Allow providers to customize documentation preferences

## Production Readiness (1 week)

**Step 6 — Testing & Optimization** (3–5 days)
- Comprehensive testing with real clinical scenarios
- Performance optimization and error handling
- Security review and HIPAA compliance verification
- User acceptance testing with healthcare providers

**Step 7 — Go Live**
- Switch to production environment
- Monitor initial usage and performance
- Gather feedback and iterate

---
---

# 4. CHOOSE YOUR INTEGRATION
**URL:** https://developer.suki.ai/documentation/integration-decision-guide

## Integration Options Comparison

| Option | Recommended For | What You Build | What's Provided |
|--------|-----------------|----------------|-----------------|
| **Direct APIs** | Backend systems, custom UIs, multi-platform | Complete UI, auth flow, audio handling | API endpoints |
| **Web SDK** | Web-based healthcare apps, browser EHR | Nothing (pre-built) | UI components, auth, audio processing |
| **Mobile SDK** | Native iOS apps, mobile healthcare | Your own UI | Native iOS SDK |

## How To Choose

| Your Need | Recommended | Why |
|-----------|-------------|-----|
| Quick integration | Web SDK | Ready-to-use components, minimal setup |
| Custom UI/UX design | Direct APIs | Complete design freedom |
| Native mobile (iOS) | Mobile SDK | Native device integration |
| Multi-platform support | Direct APIs | Works across web, mobile, backend |
| React/JS experience | Web SDK | Familiar patterns |
| iOS/Swift experience | Mobile SDK | Native iOS patterns |
| Limited dev resources | Web SDK | Minimal custom work required |

**Note:** For Android, use Direct APIs — the Mobile SDK for Android is in development.

## Prerequisites (All Methods)

- Completed partner onboarding + `partner_id`
- OAuth 2.0 compliant authentication system
- JWT token generation with consistent user identifier
- Publicly accessible JWKS endpoint

**Additional by method:**
- **Web SDK**: ES6+ browsers; host URLs whitelisted with Suki
- **Mobile SDK (iOS)**: iOS 14.0+; Xcode; microphone permissions
- **Direct APIs**: WebSocket client capability; HTTPS/TLS

## Common Scenarios

| Scenario | Recommendation |
|----------|---------------|
| Web-based EHR needing ambient docs | Web SDK |
| Healthcare patient portal / telehealth | Web SDK |
| Native iOS app for remote consultations | Mobile SDK |
| Native Android app | Direct APIs |
| Batch processing clinical audio | Direct APIs |
| Multi-platform healthcare suite | Direct APIs |

---
---

# 5. PARTNER ONBOARDING
**URL:** https://developer.suki.ai/documentation/partner-onboarding

## Overview

Before using Suki's APIs and SDKs, you must complete a **one-time** onboarding process. You'll receive a `partner_id` that identifies your organization.

## Key Concepts

- **Partner** — An organization integrating with Suki. Can contain multiple organizations.
- **Organization** — A group of users, such as a hospital or clinic.
- **Provider** — A user within an organization (e.g., doctor, nurse) who uses Suki's services.

## Partner ID

A unique identifier Suki assigns to your organization:
- Links your application to its configuration in the Suki Developer Platform
- Determines which authentication endpoint to use for token validation
- Maps your user roles to Suki's capabilities

## How Authentication Works

1. Provider signs in to your application via your identity provider (Okta, Azure AD, Auth0, etc.)
2. IDP issues a token for that user
3. You send this token to Suki in API requests
4. Suki verifies the token and grants access

## Onboarding Process

**Step 1 — Contact Suki**
Contact the Suki Customer Success team with:
- Business details (official name, email, phone)
- Use case description
- Contact person managing the integration
- Authentication method preference:
  - **Stored Secret** — Share your public key with Suki
  - **JWKS URL** — Host public keys at a public endpoint
  - **Okta** — Use Okta as your IDP
  - **JWT Assertion** — Share public key as a signed JWT (RFC 7523)

**Step 2 — Suki Reviews**
Typically takes a few business days.

**Step 3 — Receive Partner ID**
Use this ID in all API calls and SDK initializations.

## Getting Support

- Contact your Suki Customer Success or Program Manager
- Use the dedicated Slack channel for your integration team
- Submit a support ticket: https://forms.suki.ai/SukiSupport/form/SukiSDKSupport/

---
---

# 6. PARTNER AUTHENTICATION
**URL:** https://developer.suki.ai/documentation/partner-authentication

## Overview: Token Exchange Model

Suki uses a federated authentication model called **token exchange**. You use your existing authentication system — Suki never handles user passwords.

**The process:**
1. User signs in to your app via your identity provider
2. Your system generates a JWT (`partnerToken`) for that user
3. You send this token to Suki when initializing APIs or SDKs
4. Suki verifies the token using your public keys and grants access

## Partner Token (JWT) Requirements

- Signed using **RS256 algorithm** (RSA Signature with SHA-256)
- Issued by your identity provider after user authentication
- Includes user identifier claims Suki can verify

## Required JWT Claims

| Claim | Description |
|-------|-------------|
| `exp` | Token expiration (Unix timestamp). Must not be expired. |
| `iss` | Token issuer (your IDP's URL or identifier) |
| `aud` | Token audience |
| `sub` / `email` / custom | A unique user identifier claim |

During onboarding, tell Suki which identifier field your tokens use.

## Public Key Sharing Methods

| Method | Description |
|--------|-------------|
| **JWKS_URL** (Recommended) | Host public keys at a public HTTPS endpoint |
| **STORED_SECRET** | Share your public key with Suki for secure storage |
| **OKTA** | Use Okta as IDP; share your Okta issuer URL |
| **JWTASSERTION** | Share public key as a JWT signed by Suki's private key |

### JWKS URL Details

Suki fetches your public keys dynamically to verify token signatures.

**Example JWKS response:**
```json
{
  "keys": [{
    "kty": "RSA",
    "kid": "sdp-pub",
    "use": "sig",
    "alg": "RS256",
    "n": "base64url-encoded-modulus",
    "e": "base64url-encoded-exponent"
  }]
}
```

**Finding your JWKS URL:**
- Check your IDP's developer console → application settings → JWKS or OpenID Connect config
- Often at: `https://your-idp-domain/.well-known/openid-configuration`
- Supported IDPs: Okta, Auth0, AWS Cognito, Azure AD, Google Identity

## Authentication Flow Steps

1. **User Signs In** → IDP issues JWT (`partnerToken`)
2. **Initialize SDK** → Pass `partnerToken` + `partnerId` to Suki
3. **Token Validation** → Suki fetches JWKS, verifies signature, expiry, and claims
4. **Receive Suki Token** → SDK stores and auto-refreshes it
5. **Ready to Use** → All Suki APIs and SDKs are accessible

## Troubleshooting

| Error | Fix |
|-------|-----|
| 400 "Missing required identifier claim" | JWT missing the user identifier claim specified during onboarding |
| 401 "Token validation failed" | JWT expired, malformed, or missing claims. Use jwt.io to inspect |
| 502 / timeout on JWKS | JWKS endpoint not publicly accessible over HTTPS |
| 400 "Unknown partner identifier" | `partnerId` doesn't match what Suki provided |
| 400 "Malformed token" | Token format must be `header.payload.signature` in Base64URL; alg = RS256 |
| Auth fails after key rotation | Update JWKS endpoint; ensure `kid` in JWT header matches JWKS; keep old keys during transition |

---
---

# 7. AMBIENT DOCUMENTATION
**URL:** https://developer.suki.ai/documentation/ambient-documentation  
**Supported by:** APIs, Web SDK, Mobile SDK, Headless Web SDK  
**Last updated:** February 2026

## Overview

Ambient Documentation automatically creates clinical notes from patient-provider conversations. Providers focus entirely on the patient while Suki listens, transcribes, and organizes the conversation into structured clinical documentation.

**Benefits:**
- **Save time** — No more typing notes during or after visits
- **Better patient care** — Providers focus on patients, not screens
- **Accurate documentation** — AI captures details that might be missed
- **Consistent format** — Notes follow standard clinical structures
- **EHR ready** — Generated notes integrate directly with EHR systems

## How It Works (4 Steps)

**Step 1: Create Session**
Provide patient details, desired note sections, and provider information. Suki returns a session ID. Sessions must be ≥1 minute.

**Step 2: Record Conversation**
Audio streams to Suki in real-time → speech-to-text → speaker identification (doctor vs. patient)

**Step 3: AI Processing**
Suki's AI analyzes the transcript:
- Identifies clinically important information
- Organizes content into requested sections
- Structures it like a professional clinical note

Example: "chest pain for 3 days" → placed in "History of Present Illness" section

**Step 4: Get Generated Clinical Note**
The note includes:
- **Structured sections** — Content organized by LOINC codes
- **Structured data** — Diagnoses, medications, coded information
- **Full transcript** — Complete conversation transcript with speaker identification

## Key Features

- **Accurate Speech Recognition** — Handles complex medical terminology; identifies speakers
- **Multilingual Support** — 80+ languages; patients speak natively, notes generated in English
- **Customizable Note Sections** — Choose sections via LOINC codes
- **Works in Background** — Handles interruptions gracefully
- **Secure and HIPAA-Compliant** — All audio and data encrypted
- **Speaker Identification** — Automatic attribution of who said what

---
---

# 8. NOTE SECTIONS (LOINC CODES)
**URL:** https://developer.suki.ai/documentation/note-sections  
**Supported by:** APIs, Web SDK, Mobile SDK, Headless Web SDK  
**Last updated:** March 2026

## Overview

Note sections divide clinical notes into standard parts. Suki uses LOINC codes (Logical Observation Identifiers Names and Codes) to identify each section, ensuring interoperability with EHR systems.

## How It Works

Specify LOINC codes when starting an ambient session → Suki automatically organizes conversation content into those sections.

## All Supported Note Sections

| SR No. | LOINC CODE | Section Common Name |
|--------|------------|---------------------|
| 1 | 39238-1 | Anticipatory Guidance |
| 2 | 42348-3 | Advanced Directives |
| 3 | 48765-2 | Allergies |
| 4 | 51848-0 | Assessment |
| 5 | 51847-2 | Assessment and Plan |
| 6 | 10154-3 | Chief Complaint |
| 7 | 61144-2 | Diet |
| 8 | 55128-3 | Disposition |
| 9 | 46239-0 | Discussion Notes |
| 10 | 10157-6 | Family History |
| 11 | 47420-5 | Functional Status |
| 12 | 8648-8 | Hospital Course |
| 13 | 10164-2 | History of Present Illness |
| 14 | 11369-6 | Immunizations |
| 15 | 61150-9 | Interval History |
| 16 | 10160-0 | Medications |
| 17 | 10190-7 | Mental Status Exam |
| 18 | 11348-0 | Past Medical History |
| 19 | 11358-9 | Past Psychiatric History |
| 20 | 10167-5 | Past Surgical History |
| 21 | 69730-0 | Patient Instructions |
| 22 | 29545-1 | Physical Exam |
| 23 | 18776-5 | Plan |
| 24 | 11450-4 | Problem List |
| 25 | 47519-4 | Procedure |
| 26 | 56822-0 | Response to Therapy |
| 27 | 30954-2 | Results |
| 28 | 78486-8 | Risk Assessment |
| 29 | 10187-3 | Review of Systems |
| 30 | 29299-5 | Reason for Visit |
| 31 | 29762-2 | Social History |
| 32 | 75325-1 | Symptoms and Stressors |
| 33 | 61146-7 | Therapy Goals |
| 34 | 8716-3 | Vitals |
| 35 | 11334-0 | Development History |

## Common Configurations

| Configuration | LOINC Codes |
|---------------|-------------|
| **Basic SOAP Note** | Chief Complaint (10154-3), HPI (10164-2), Physical Exam (29545-1), A&P (51847-2) |
| **Comprehensive Visit** | Add Medications (10160-0), Allergies (48765-2), Problem List (11450-4), ROS (10187-3) |
| **Psychiatry** | Mental Status Exam (10190-7), Past Psychiatric History (11358-9) |
| **Primary Care** | Vitals (8716-3), Immunizations (11369-6) |

## Implementation

```javascript
ambientOptions: {
  sections: [
    { loinc: "10154-3" }, // Chief Complaint
    { loinc: "10164-2" }, // History of Present Illness
    { loinc: "29545-1" }, // Physical Exam
    { loinc: "51847-2" }  // Assessment and Plan
  ]
}
```

---
---

# 9. SUPPORTED MEDICAL SPECIALTIES
**URL:** https://developer.suki.ai/documentation/specialties  
**Supported by:** APIs, Web SDK, Mobile SDK, Headless Web SDK  
**Last updated:** March 2026

## Overview

Specify a provider's specialty so Suki generates notes using the right terminology, abbreviations, and structure for that specialty.

If not specified, Suki defaults to `FAMILY_MEDICINE`.

## Implementation

```javascript
// Web SDK
const sdkClient = initialize({
  partnerId: "your-partner-id",
  partnerToken: "your-partner-token",
  providerName: "John Doe",
  providerOrgId: "1234",
  providerSpecialty: "CARDIOLOGY"
});
```

```swift
// Mobile SDK (Swift)
let contextDetail: [String: AnyHashable] = [
    SukiAmbientConstant.kProviderContext: [
        SukiAmbientConstant.kSpeciality: "CARDIOLOGY"
    ]
]
try SukiAmbientCore.shared.setSessionContext(with: contextDetail) { result in }
```

## All 120 Supported Specialties

| Value | Description |
|-------|-------------|
| NA | N/A - No Specialty |
| ALLERGY_AND_IMMUNOLOGY | Allergy and Immunology |
| ANESTHESIOLOGY | Anesthesiology |
| CARDIOLOGY | Cardiology |
| CRITICAL_CARE | Critical Care |
| DERMATOLOGY | Dermatology |
| EMERGENCY_MEDICINE | Emergency Medicine |
| ENDOCRINOLOGY | Endocrinology |
| FAMILY_MEDICINE | Family Medicine (default) |
| GASTROENTEROLOGY | Gastroenterology |
| GENETICS | Genetics |
| HEMATOLOGY | Hematology |
| INFECTIOUS_DISEASE | Infectious Disease |
| INTERNAL_MEDICINE | Internal Medicine |
| MEDICAL_ONCOLOGY | Medical Oncology |
| NEPHROLOGY | Nephrology |
| NEUROLOGY | Neurology |
| NEUROSURGERY | Neurosurgery |
| NUCLEAR_MEDICINE | Nuclear Medicine |
| OBSTETRICS_GYNECOLOGY | Obstetrics and Gynecology |
| OPHTHALMOLOGY | Ophthalmology |
| ORTHOPEDIC_SURGERY | Orthopedic Surgery |
| OTOLARYNGOLOGY_HEAD_AND_NECK | Otolaryngology - Head and Neck Surgery |
| PALLIATIVE_MEDICINE | Palliative Medicine |
| PAIN_MANAGEMENT | Pain Management |
| PATHOLOGY | Pathology |
| PEDIATRICS | Pediatrics |
| PHYSICAL_MEDICINE_AND_REHABILITATION | Physical Medicine and Rehabilitation |
| PLASTIC_SURGERY | Plastic Surgery |
| PODIATRY | Podiatry |
| PREVENTATIVE_MEDICINE | Preventative Medicine |
| PSYCHIATRY | Psychiatry |
| PULMONOLOGY | Pulmonology |
| RADIATION_ONCOLOGY | Radiation Oncology |
| RADIOLOGY_DIAGNOSTIC | Radiology - Diagnostic |
| RADIOLOGY_INTERVENTIONAL | Radiology - Interventional |
| RHEUMATOLOGY | Rheumatology |
| SPORTS_MEDICINE | Sports Medicine |
| SURGERY_CARDIAC_AND_THORACIC | Surgery - Cardiac and Thoracic |
| SURGERY_COLON_AND_RECTAL | Surgery - Colon and Rectal |
| SURGERY_GENERAL | Surgery - General |
| SURGERY_PEDIATRIC | Surgery - Pediatric |
| SURGERY_VASCULAR | Surgery - Vascular |
| UROLOGY | Urology |
| UNLISTED_MEDICAL | Unlisted - Medical |
| UNLISTED_SURGICAL | Unlisted - Surgical |
| LACTATION | Lactation |
| NUTRITION | Nutrition |
| VETERINARIAN | Veterinarian |
| GERIATRICS | Geriatrics |
| HOSPITAL_MEDICINE | Hospital Medicine |
| SLEEP_MEDICINE | Sleep Medicine |
| FUNCTIONAL_MEDICINE | Functional Medicine |
| INTEGRATIVE_MEDICINE | Integrative Medicine |
| HEPATOLOGY | Hepatology |
| PEDIATRIC_ALLERGY_AND_IMMUNOLOGY | Pediatric Allergy and Immunology |
| PEDIATRIC_CARDIOLOGY | Pediatric Cardiology |
| PEDIATRIC_ENDOCRINOLOGY | Pediatric Endocrinology |
| PEDIATRIC_CRITICAL_CARE | Pediatric Critical Care |
| DEVELOPMENTAL_AND_BEHAVIORAL_PEDIATRICS | Developmental and Behavioral Pediatrics |
| PEDIATRIC_HOSPITAL_MEDICINE | Pediatric Hospital Medicine |
| PEDIATRIC_NEPHROLOGY | Pediatric Nephrology |
| PEDIATRIC_RHEUMATOLOGY | Pediatric Rheumatology |
| PEDIATRIC_GASTROENTEROLOGY | Pediatric Gastroenterology |
| PEDIATRIC_PSYCHIATRY | Pediatric Psychiatry |
| GYN_ONCOLOGY | Gyn-Oncology |
| REPRODUCTIVE_ENDOCRINOLOGY_AND_INFERTILITY | Reproductive Endocrinology and Infertility (REI) |
| UROGYNECOLOGY | Urogynecology |
| SPINE_SURGERY | Spine Surgery |
| INTERVENTIONAL_CARDIOLOGY | Interventional Cardiology |
| CARDIOLOGY_AND_ELECTROPHYSIOLOGY | Cardiology and Electrophysiology |
| HEART_FAILURE_AND_TRANSPLANT_CARDIOLOGY | Heart Failure and Transplant Cardiology |
| ADULT_CONGENITAL_HEART_DISEASE | Adult Congenital Heart Disease |
| GASTROENTEROLOGY_ONCOLOGY | Gastroenterology Oncology |
| SURGERY_ONCOLOGY | Surgery Oncology |
| SURGERY_BARIATRICS | Surgery Bariatrics |
| INVASIVE_CARDIOLOGY | Invasive Cardiology |
| SURGERY_THORACIC | Surgery Thoracic |
| SURGERY_CARDIOVASCULAR | Surgery Cardiovascular |
| PEDIATRIC_PULMONOLOGY | Pediatric Pulmonology |
| PEDIATRIC_ADOLESCENT | Pediatric Adolescent |
| TRANSPLANT_NEPHROLOGY | Transplant Nephrology |
| HEMATOLOGY_AND_ONCOLOGY | Hematology and Oncology |
| MEDICINE_BARIATRIC | Medicine Bariatric |
| SURGERY_TRAUMA | Surgery Trauma |
| BEHAVIORAL_HEALTH | Behavioral Health |
| URGENT_CARE | Urgent Care |
| COMPREHENSIVE_CARE | Comprehensive Care |
| OCCUPATIONAL_MEDICINE | Occupational Medicine |
| ADDICTION_MEDICINE | Addiction Medicine |
| CARDIAC_IMAGING | Cardiac Imaging |
| TRANSPLANT_HEPATOLOGY | Transplant Hepatology |
| SPINAL_ONCOLOGY_AND_SPINE_TUMOR_SURGERY | Spinal Oncology and Spine Tumor Surgery |
| CONCIERGE_MEDICINE | Concierge Medicine |
| DRUG_AND_ALCOHOL_REHAB | Drug and Alcohol Rehab |
| TRANSPLANT_PANCREAS | Transplant Pancreas |
| TRANSPLANT_INTESTINE | Transplant Intestine |
| BONE_MARROW_TRANSPLANT | Bone Marrow Transplant |
| VETERINARY_URGENT_CARE | Veterinary Urgent Care |
| VETERINARY_EMERGENCY_AND_CRITICAL_CARE | Veterinary Emergency and Critical Care |
| INPATIENT_PSYCHIATRY | Inpatient Psychiatry |
| NEUROMUSCULOSKELETAL_MANIPULATIVE_MEDICINE | Neuromusculoskeletal Manipulative Medicine |
| EPILEPSY | Epilepsy |
| NEUROIMMUNOLOGY | Neuroimmunology |
| HEADACHE | Headache |
| VASCULAR_NEUROLOGY | Vascular Neurology |
| SURGERY_BREAST | Surgery Breast |
| ACCIDENT_AND_INJURY | Accident and Injury |
| CANCER_GENETICS | Cancer Genetics |
| ONCOLOGY_BREAST | Oncology Breast |
| ONCOLOGY_CUTANEOUS | Oncology Cutaneous |
| ONCOLOGY_GENITOURINARY | Oncology Genitourinary |
| ONCOLOGY_HEAD_AND_NECK | Oncology Head and Neck |
| INTERVENTIONAL_PAIN | Interventional Pain |
| ONCOLOGY_ORTHOPEDIC | Oncology Orthopedic |
| ONCOLOGY_THORACIC | Oncology Thoracic |
| ONCOLOGY | Oncology |
| ONCOLOGY_WOMENS | Oncology Womens |
| ORTHOPEDICS_HAND | Orthopedics Hand |
| WOUND_CARE | Wound Care |

## Best Practices

- Always specify the specialty — improves note quality significantly
- Use the most specific code available (e.g., `PEDIATRIC_CARDIOLOGY` over `CARDIOLOGY`)
- Match the specialty to what's in your EHR for consistency
- Update specialty in session context if a provider changes specialties

---
---

# 10. AUDIO DICTATION
**URL:** https://developer.suki.ai/documentation/dictation  
**Supported by:** APIs only (SDKs include dictation as part of ambient note generation)  
**Last updated:** March 2026

## Overview

Audio Dictation converts spoken conversations into text in real-time. Unlike Ambient Documentation (which generates full structured clinical notes), Dictation provides speech-to-text transcription only — with formatting (punctuation, capitalization, filler words removed).

## Key Features

- **Real-time Transcription** — See text appear as people speak
- **Multiple Sessions** — Run multiple dictation sessions under one parent session
- **WebSocket Streaming** — Low-latency audio streaming
- **Clean Transcripts** — Automatic punctuation, capitalization, filler word removal
- **Intermediate and Final Texts** — Receive partial transcripts during processing and final when complete

## Dictation vs. Ambient Documentation

| Feature | Dictation | Ambient Documentation |
|---------|-----------|----------------------|
| Output | Raw transcript (formatted) | Structured clinical notes + transcript |
| LOINC sections | No | Yes |
| Structured data | No | Yes (diagnoses, medications, etc.) |
| Note generation | No | Yes |

## How To Use Dictation (3 Steps)

**Step 1 — Create parent dictation session:**
```bash
POST https://sdp.suki.ai/api/v1/transcription/session/create
```
Optional audio config:
```json
{
  "audio_config": {
    "audio_encoding": "LINEAR16",
    "audio_language": "en-US",
    "sample_rate_hertz": 16000
  }
}
```
Returns `transcription_session_id`. Currently only `en-US` is supported for dictation.

**Step 2 — Stream audio via WebSocket:**
- Endpoint: `GET /ws/transcribe`
- Browser: `Sec-WebSocket-Protocol: SukiTranscriptionAuth,<sdp_suki_token>,<transcription_session_id>`
- Non-browser: `sdp_suki_token` and `transcription_session_id` as HTTP headers
- Multiple WebSocket connections can stream to the same session

**Step 3 — Receive real-time transcripts**
Suki processes audio and returns transcribed text immediately. Transcripts are automatically formatted.

**Step 4 — End session:**
```bash
curl -X POST https://sdp.suki.ai/api/v1/transcription/session/{transcription_session_id}/end \
  -H "sdp_suki_token: {sdp_suki_token}"
```

## Best Practices

- Stream audio in chunks (not all at once) for better performance
- Implement reconnection logic — WebSocket connections can drop
- Always call the end session API when finished to free resources
- Match audio encoding and sample rate to your source
- Test audio quality before deploying — bad audio = bad transcripts

---
---

# 11. AUDIO STREAMING & DOWNLOAD
**URL:** https://developer.suki.ai/documentation/audio-streaming-download  
**Supported by:** APIs, Headless Web SDK  
**Last updated:** March 2026 (NEW feature)

## Overview

The Audio Streaming & Download API provides secure, temporary access to the original raw audio recording from an ambient session. Use it to:

- **Let physicians listen back** — Add a playback feature so providers can review the conversation
- **Verify AI output** — Let providers compare a note to the actual conversation
- **Meet compliance needs** — Save audio files for legal or regulatory requirements

## Key Facts

| Detail | Value |
|--------|-------|
| Audio format | WAV |
| Streaming URL duration | 15 min (short sessions) or session length + 10 min |
| Download URL duration | 1 hour |
| Recording availability | 7 days after session |
| Access logging | Yes — all access is logged |

## How It Works

1. **Finish an ambient session** — Create session, stream/upload audio, end it
2. **Request recording URL** — Call recording API with `session_id`; choose `download=false` (stream) or `download=true` (download)
3. **Use the URL** — Stream or download audio in WAV format
4. **Refresh when expired** — Request a new URL if it expires during playback

## Response Structure

```json
{
  "recordings": [
    {
      "recording_id": "string",
      "presigned_url": "https://...",
      "expires_at": 1234567890,
      "sequence_number": 1,
      "is_streamable": true
    }
  ]
}
```

- `sequence_number` — Use to order multiple recording chunks in the correct order
- `is_streamable` — If `false`, use `download=true` mode instead

## HTTP Status Codes

| Code | Meaning |
|------|---------|
| 200 | OK |
| 400 | Bad Request |
| 401 | Unauthorized / invalid token |
| 404 | Recording still processing (for uploaded sessions) — wait and retry |
| 410 | Recording permanently unavailable (>7 days old) — do NOT retry |
| 500 | Internal Server Error |

## Best Practices

- Use streaming for playback (supports seeking/scrubbing)
- Use download for archival/compliance storage
- Handle 404 by waiting and retrying (uploaded sessions may still be processing)
- Do NOT retry on 410 — recording is permanently gone
- All access is logged; ensure use meets your compliance requirements
- Download within the 7-day window if you need longer retention

---
---

# 12. NOTIFICATION WEBHOOK
**URL:** https://developer.suki.ai/documentation/webhook  
**Supported by:** APIs, Web SDK, Mobile SDK, Headless Web SDK  
**Last updated:** March 2026

## Overview

Suki supports **push** and **pull** notification mechanisms:

- **Pull** — Your app polls the session status endpoint repeatedly
- **Push (Webhook)** — Suki sends a POST to your callback URL when an event occurs

With push webhooks, you host the callback URL. Suki sends notifications immediately and does not store or queue them.

## Events Your Webhook Receives

| Event | Payload Includes |
|-------|-----------------|
| Session completion | session_id, encounter_id, `_links` to fetch content |
| Session failure | session_id, encounter_id, error_code, error_detail |
| Session timeout | session_id, encounter_id |
| Session cancellation | session_id, encounter_id |

## Configuration

- Configured **once per partner** during onboarding (not self-service)
- One webhook URL receives all notifications for your organization (all integration methods)
- Contact Suki to register or change your callback URL

## Endpoint Requirements

Your webhook endpoint must:
- Accept **POST** requests
- Use **HTTPS only** (no HTTP)
- Respond with **2xx** on receipt (do heavy work asynchronously after returning 200)
- Be reachable from the internet (no localhost or private IPs in production)

## Payload Structure

**Success payload:**
```json
{
  "_links": {
    "contents": [{ "href": "/path/to/content", "method": "GET" }],
    "encounter_content": [{ "href": "/path/to/encounter", "method": "GET" }],
    "status": [{ "href": "/path/to/status", "method": "GET" }],
    "transcripts": [{ "href": "/path/to/transcript", "method": "GET" }]
  },
  "encounter_id": "4d753ce1-bbff-43e1-950a-82dea2d86873",
  "session_id": "a953839a-ddcd-407d-b9b0-3ed4b6be4be2",
  "sessions": ["20965414-...", "29de56bc-..."],
  "status": "success"
}
```

**Failure payload:**
```json
{
  "encounter_id": "29de56bc-960a-4cd5-b18f-79a798d62874",
  "error_code": "ERROR_CODE_TRANSCRIPTION",
  "error_detail": "Error in transcription",
  "session_id": "20965414-929a-4f71-a3e5-b92bec07d086",
  "status": "failure"
}
```

## Webhook Response Codes from Suki

| Code | Meaning |
|------|---------|
| 200 | OK |
| 400 | Bad Request |
| 401 | Unauthorized / invalid token |
| 500 | Internal Server Error |

Handle 401 by re-authenticating. Retry on 5xx with backoff.

## Implementation Tips

- Return **200 OK** immediately; do heavy work (DB updates, API calls) in a background job
- Use `session_id` to detect and deduplicate repeated deliveries (idempotent handler)
- Keep the endpoint highly available (load balancer or redundant instances)
- Log `session_id`, `encounter_id`, and `status` but avoid logging full bodies if they contain PHI

## Security Best Practices

- Use **HTTPS only** for your callback URL
- Implement **HMAC** (Hash-based Message Authentication Code) verification to confirm requests come from Suki
- Validate payload structure AND HMAC signature before processing
- Reject malformed or unverified requests with 4xx

---
---

# 13. MCP INTEGRATION
**URL:** https://developer.suki.ai/documentation/mcp  
**Last updated:** March 2026

## Overview

The Suki Developer Documentation is available as an **MCP server** (Model Context Protocol) that you can connect directly to AI code editors like Cursor or VS Code. The LLM in your editor can then query Suki's knowledge base for API references, code samples, and guides automatically.

**MCP Server URL:** `https://developer.suki.ai/mcp`

## Benefits

- Accelerate development — use docs as an MCP service while coding
- Improve LLM response accuracy with up-to-date Suki documentation
- Reduce manual research and documentation lookup
- Reduce LLM hallucinations about Suki's API behavior

## Setup Instructions

### Cursor

1. Open command palette: `Cmd+Shift+P` (Mac) or `Ctrl+Shift+P` (Windows)
2. Search for "Open MCP settings"
3. Select "Add custom MCP" → opens `mcp.json`
4. Add:
```json
{
  "servers": [{ "url": "https://developer.suki.ai/mcp" }]
}
```

### Claude / Claude Code

**In Claude.ai:**
1. Navigate to Connectors page in settings
2. Select "Add custom connector"
3. Name: `Suki Developer Documentation MCP server`
4. URL: `https://developer.suki.ai/mcp`
5. Select Add

**Via CLI:**
```bash
claude mcp add --transport http "Suki Developer Documentation MCP server" https://developer.suki.ai/mcp
```

### VS Code

1. Create `.vscode/mcp.json` in project root:
```json
{
  "servers": {
    "suki-docs": {
      "type": "http",
      "url": "https://developer.suki.ai/mcp"
    }
  }
}
```

---
---

# 14. EXECUTIVE SUMMARY
**URL:** https://developer.suki.ai/documentation/executive-summary

## Problem We Solve

**For clinicians:** Clinicians spend **5-6 hours every day** on clinical documentation. This fuels provider burnout, reduces patient face-time, delays billing, and drives away talent.

**For partners:** Building and maintaining ambient AI in-house requires constant investment in models, clinical quality, compliance, and infrastructure.

## Case Studies

**Zoom Healthcare Partnership**
Zoom integrated Suki's AI engine to deliver a complete virtual care experience that improves both user experience and patient outcomes. Demonstrates ambient intelligence as a competitive differentiator.

**WellSky Integration**
WellSky's Ambient Listening solution is active across behavioral health, long-term acute care, and rehabilitation settings, streamlining documentation and reducing burnout.

**athenahealth Partnership**
Over **60,000 clinical encounters completed in 3 months** after integrating Suki's ambient technology. Started as a pilot; became a core capability at scale.

## Integration Paths

| SDK | Package | Best For |
|-----|---------|----------|
| **Web SDK** | `@suki-sdk/react` / `@suki-sdk/js` | Pre-built browser UI |
| **Headless Web SDK** | `@suki-sdk/platform-react` | Custom React UI |
| **Mobile SDK** | Native iOS | Embedded mobile experiences |
| **SDP REST APIs** | HTTPS/OAuth | Server-side or custom client |

## Business Benefits

| Benefit | Detail |
|---------|--------|
| Faster Time-to-Market | 2-4 weeks vs. 6-12 months building in-house |
| Cost Savings | Clinicians reclaim 2-3 hours/day; faster billing cycles |
| Competitive Differentiation | Position as AI innovation leader |
| Improved Quality of Care | More time with patients; complete, timely notes |
| Security & Compliance | HIPAA compliant, SOC 2 Type II certified, end-to-end encryption |

## What Partners Get

- Production-ready SDKs and APIs
- 120+ medical specialty optimization
- 80+ language support
- UX and branding control (customize or fully own the UI)
- Documentation per integration surface

## Next Steps

1. **Schedule a demo** — See Suki in a live clinical workflow
2. **Technical assessment** — Solutions Engineering maps your environment + integration plan
3. **Pilot program** — Start with a small group; build proof points
4. **Full deployment** — Scale with ongoing support

---
---

# 15. TECHNICAL EXECUTION GUIDE
**URL:** https://developer.suki.ai/documentation/technical-execution

## Integration At A Glance

**4 phases apply to all integration methods:**

1. **Setup and configuration** — Partner ID, JWKS security, environment setup
2. **Authentication** — Connect IdP, issue partner tokens, validate access
3. **Ambient session and AI** — Run sessions, stream audio, receive transcript and note
4. **Note delivery** — Receive structured JSON payloads; map to your EHR/systems

**Timeline: 2–4 weeks** from start to production (vs. 6–12 months building in-house)

## What Partners Need

- OAuth 2.0 (or similar) identity system
- Development environment with React/JS or Xcode
- Clinical knowledge for configuring specialties and LOINC sections
- Ability to receive structured JSON payloads and route to downstream systems
- Standard browser microphone permissions and HTTPS

## Critical Technical Requirements

### Web SDK

| Area | Requirements |
|------|-------------|
| **Authentication** | OAuth 2.0 IDP, JWKS endpoint (HTTPS), RS256-signed JWTs, required claims: exp/iss/aud/identifier |
| **Installation** | React or JS dev environment; Node.js; ES6 browser; use `@suki-sdk/react` or `@suki-sdk/js` |
| **Specialties** | List of supported specialties; LOINC code mapping for your encounter types |
| **Note output** | Infrastructure to receive note submission events; LOINC JSON parsing logic |
| **Microphone** | Microphone permission UX; HTTPS in production; if in iframe: `allow="microphone; clipboard-write; clipboard-read"` |

### Mobile SDK (iOS)

| Area | Requirements |
|------|-------------|
| **Authentication** | Implement `tokenProvider` protocol; pass `PartnerID`, `ProviderInfo` to `initialize` |
| **Installation** | iOS 13.0+; Xcode; `SukiAmbientCore.framework` added as Embed & Sign; `NSMicrophoneUsageDescription` in Info.plist |
| **Session lifecycle** | Implement session delegate; handle start/pause/resume/end/cancel; background recording flag if needed |
| **Content** | Logic to poll/receive content on completion; mapping to EHR; offline mode awareness |

### SDP REST APIs

| Area | Requirements |
|------|-------------|
| **Authentication** | HTTPS-only clients; login via `/api/v1/auth/login`; secure credential storage/rotation |
| **Environments** | Stage: `https://sdp.suki-stage.com`; Production: `https://sdp.suki.ai`; use `/api/v1/` paths |
| **Ambient operations** | REST session lifecycle; WebSocket for real-time audio; webhook or polling for async completion |
| **Operational readiness** | Retry/error-handling; no PHI in unsecured logs; rate expectations validated with Suki |

### Headless Web SDK

| Area | Requirements |
|------|-------------|
| **Authentication** | Same as Web SDK; connect tokens through `useAuth` hook |
| **Installation** | React 18.0+; install `@suki-sdk/platform-react`; ES6 browser |
| **Configuration** | `partnerId` from Suki; test/prod host URLs allowlisted; user identifier field agreed during onboarding |
| **Ambient hooks** | Integrate ambient/session hooks; handle pending/error/completion states; microphone UX; HTTPS |

---
---

# 16. AMBIENT API OVERVIEW
**URL:** https://developer.suki.ai/api-reference/overview

## Overview

The Suki Ambient APIs generate clinical notes from real-time conversations between providers and patients. Most operations use standard REST endpoints. For streaming audio, the APIs use WebSocket endpoints.

> The Ambient APIs are in **Early Access**. Contact the partnership team to request access.

## API Versioning

All endpoints use the `/api/v1/` prefix. v1 is the stable version; non-breaking changes may ship without a major version bump.

## Base URLs

- **Production:** `https://sdp.suki.ai`
- **Staging:** `https://sdp.suki-stage.com`

## API Reference Categories

- Authentication
- Ambient Session Management
- Dictation
- Ambient Content Retrieval
- User Preferences
- User Feedback
- Send Notifications
- Info

## Recently Added Endpoints

- **Get Session Recording** — Stream or download original audio from an ambient session
- **Create Dictation Session** — Initialize a dictation session for real-time audio transcription
- **Stream Audio To Dictation Session** — Send audio to dictation service over WebSocket
- **End Dictation Session** — Complete a dictation session and trigger transcript generation

## Code Samples (Python / TypeScript / cURL)

**Login:**
```python
import requests
response = requests.post(
    "https://sdp.suki.ai/api/v1/auth/login",
    json={"partner_id": "your-id", "partner_token": "your-jwt", "provider_id": "provider-123"}
)
data = response.json()
print(data.get("suki_token"))
```

**Session Context:**
```python
import requests
url = f"https://sdp.suki.ai/api/v1/ambient/session/{ambient_session_id}/context"
payload = {
    "provider": {"specialty": "CARDIOLOGY", "provider_role": "ATTENDING"},
    "patient": {"dob": "2000-01-01", "sex": "male"},
    "visit": {
        "chief_complaint": "Headache",
        "encounter_type": "AMBULATORY",
        "reason_for_visit": "Follow-up for migraines",
        "visit_type": "ESTABLISHED_PATIENT"
    },
    "sections": [{"loinc": "10164-2"}, {"loinc": "48765-2"}]
}
response = requests.post(url, json=payload, headers={"sdp_suki_token": "YOUR_TOKEN"})
```

**Get Transcript:**
```typescript
const res = await fetch(
  `https://sdp.suki.ai/api/v1/ambient/session/${sessionId}/transcript`,
  { headers: { sdp_suki_token: "YOUR_SUKI_TOKEN" } }
);
console.log(await res.json());
```

---
---

# 17. AMBIENT API QUICKSTART
**URL:** https://developer.suki.ai/api-reference/quickstart  
**Last updated:** March 2026

## Prerequisites

- OAuth-compliant authentication system
- JWT tokens with consistent user identifiers
- Publicly accessible JWKS endpoint (or Okta authorization server)

## Environments

- **Production:** `https://sdp.suki.ai`
- **Staging:** `https://sdp.suki-stage.com`

## Step-by-Step Workflow

### Step 1: Authenticate and Get Token

```bash
curl -X POST https://sdp.suki.ai/api/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{"partner_id":"your-id","partner_token":"your-jwt","provider_id":"provider-123"}'
```

- Returns `suki_token` — valid for **1 hour**
- Use as `sdp_suki_token` header in all subsequent calls
- If user isn't registered yet, call `/api/v1/auth/register` first (only needed once per user)

### Step 2: Create Ambient Session

```bash
curl -X POST https://sdp.suki.ai/api/v1/ambient/session/create \
  -H "sdp_suki_token: YOUR_SUKI_TOKEN" -H "Content-Type: application/json" \
  -d '{"ambient_session_id":"123dfg-456dfg-789dfg","encounter_id":"123dfg-456dfg-789dfg"}'
```

> **Note:** `multilingual` parameter is deprecated — multilingual support is now **true by default** for all partners.

### Step 3: Seed Context (optional but recommended)

```bash
curl -X POST "https://sdp.suki.ai/api/v1/ambient/session/SESSION_ID/context" \
  -H "sdp_suki_token: YOUR_SUKI_TOKEN" -H "Content-Type: application/json" \
  -d '{
    "provider": {"specialty": "cardiology"},
    "sections": [{"loinc": "51847-2"}, {"loinc": "10164-2"}],
    "patient_info": {"date_of_birth": "1980-05-15", "sex": "MALE"}
  }'
```

Providing context significantly improves clinical note accuracy.

### Step 4: Stream Audio via WebSocket

**Endpoint:** `wss://sdp.suki.ai/ws/stream`

**Authentication:**
- Browser: `Sec-WebSocket-Protocol: SukiAmbientAuth,<ambient_session_id>,<sdp_suki_token>`
- Non-browser: `sdp_suki_token` and `ambient_session_id` as HTTP headers

**Audio format requirements:**
- Encoding: LINEAR16
- Sample rate: 16kHz
- Channel: Mono
- Recommended chunk size: 100ms packets

**WebSocket message types:**
| Message | Description |
|---------|-------------|
| AUDIO | Raw audio data in required format |
| RESUME | Resume a paused stream |
| CANCEL | Cancel session — no note generated |
| ABORT | End stream but keep session active; note generated from audio so far |
| KEEP_ALIVE | Ping to keep connection alive (required every ≤5 sec when paused) |
| EOF | Indicates end of file/stream |

**Timeouts:**
- No audio sent for **25 seconds** → Suki disconnects the stream
- Paused stream with KEEP_ALIVE → disconnects after **30 minutes**

### Step 5: End Session

```bash
curl -X POST "https://sdp.suki.ai/api/v1/ambient/session/SESSION_ID/end" \
  -H "sdp_suki_token: YOUR_SUKI_TOKEN"
```

### Step 6: Retrieve Generated Content

**Via webhook** (recommended): Suki sends `session_summary_generated` event to your callback URL.

**Via polling:**
```bash
# Check status
curl -X GET "https://sdp.suki.ai/api/v1/ambient/session/SESSION_ID/status" \
  -H "sdp_suki_token: YOUR_SUKI_TOKEN"

# Get clinical note
curl -X GET "https://sdp.suki.ai/api/v1/ambient/session/SESSION_ID/content?cumulative=false" \
  -H "sdp_suki_token: YOUR_SUKI_TOKEN"

# Get transcript
curl -X GET "https://sdp.suki.ai/api/v1/ambient/session/SESSION_ID/transcript" \
  -H "sdp_suki_token: YOUR_SUKI_TOKEN"
```

---
---

# 18. SECURITY & BEST PRACTICES
**URL:** https://developer.suki.ai/api-reference/security-best-practices  
**Last updated:** April 2026

## Overview

All API requests must use **HTTPS** (TLS 1.2 or higher). Never send requests over unencrypted HTTP.

## Token Management

| Practice | Details |
|----------|---------|
| **Store tokens securely** | Never expose `sdp_suki_token` in client-side code, logs, or version control |
| **Handle token expiration** | Implement token refresh logic; call `/login` with a valid partner token |
| **Validate JWTs** | Verify signature using public keys from JWKS endpoint (`/api/auth/.well-known/jwks-pub.json`) |
| **Use secure partner tokens** | RS256-signed JWTs; JWKS endpoint must be publicly accessible |

## Webhook Security

- Use **HMAC** (Hash-based Message Authentication Code) verification to confirm webhook requests come from Suki
- Your callback URL must use **HTTPS only**
- Always validate payload structure AND HMAC signature before processing

## Data Protection

- All data transmitted to/from Suki is encrypted via TLS 1.2
- Maintain encryption standards for data at rest
- Follow HIPAA requirements; obtain patient consent before sending personal data
- Send only the minimum required data for each API call

## Error Handling

| Scenario | Action |
|----------|--------|
| 401 Unauthorized / 403 Forbidden | Verify `sdp_suki_token` is valid, not expired; re-authenticate |
| 5xx errors (transient) | Implement exponential backoff retry logic |
| 4xx client errors | Do NOT retry; fix the request |
| Logging errors | Never include tokens, passwords, or sensitive patient data in logs |

---
---

## PAGES NOT YET FETCHED

The following pages exist in the Suki developer docs and contain additional detail. Visit them directly at developer.suki.ai:

**Documentation:**
- `/documentation/support` — Support page
- `/documentation/faqs/general` — General FAQs
- `/documentation/faqs/authentication` — Authentication FAQs
- `/documentation/faqs/security` — Security FAQs
- `/Glossary/glossary` — Glossary of terms

**SDK Documentation (separate SDK section):**
- `/web-sdk/overview` — Web SDK overview
- `/web-sdk/installation` — Web SDK installation
- `/web-sdk/quickstart` — Web SDK quickstart
- `/web-sdk/guides/note-management` — Note submission & retrieval
- `/headless-web-sdk/introduction` — Headless Web SDK intro
- `/headless-web-sdk/authentication` — Headless SDK auth
- `/headless-web-sdk/quickstart` — Headless SDK quickstart
- `/headless-web-sdk/guides/ambient-hook` — Ambient hook guide
- `/mobile-sdk/overview` — Mobile SDK overview
- `/mobile-sdk/installation` — Mobile SDK installation
- `/mobile-sdk/configuration` — Mobile SDK configuration
- `/mobile-sdk/ambient-guides/create-session` — Mobile session creation
- `/mobile-sdk/ambient-guides/recording` — Mobile recording controls
- `/mobile-sdk/ambient-guides/session-status-and-content-retrieval` — Mobile content retrieval

**API Reference (individual endpoints):**
- `/api-reference/provider-authentication` — User authentication endpoint
- `/api-reference/https-guidelines` — HTTPS guidelines
- `/api-reference/api-guidelines` — API reference guidelines
- `/api-reference/authentication/login` — Login endpoint spec
- `/api-reference/authentication/register` — Register endpoint spec
- `/api-reference/authentication/JWKS` — JWKS endpoint spec
- `/api-reference/ambient-sessions/create` — Create session endpoint
- `/api-reference/ambient-sessions/context` — Session context endpoint
- `/api-reference/ambient-sessions/audio-stream` — Audio streaming endpoint
- `/api-reference/ambient-sessions/end` — End session endpoint
- `/api-reference/ambient-content/status` — Session status endpoint
- `/api-reference/ambient-content/content` — Clinical note content endpoint
- `/api-reference/ambient-content/transcript` — Transcript endpoint
- `/api-reference/ambient-content/recording` — Recording download endpoint
- `/api-reference/audio-transcription/create-session` — Create dictation session
- `/api-reference/audio-transcription/stream-transcription` — Stream to dictation
- `/api-reference/audio-transcription/end-session` — End dictation session
- `/api-reference/capabilities/problem-based-charting` — PBC guide
- `/api-reference/capabilities/multilingual` — Multilingual support guide
- `/api-reference/capabilities/personalization` — Note personalization guide
- `/api-reference/asynchronous/webhook` — Webhook payload reference
- `/api-reference/product-updates/changelog` — API changelog
- `/updates/release-notes` — Release notes

---

*End of document. Retrieved from https://developer.suki.ai — April 2026.*
