# Home Page - Suki

**Source URL:** https://developer.suki.ai/documentation/home

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


# Start buildingwith Suki for Partners


Welcome to Suki developer documentation


Find everything you need to ship ambient clinical intelligence into your healthcare application with Suki’s SDKs and APIs in days, not months


### Overview


Suki for Partners overview and capabilities

Explore Documentation →

### Integration Guide


Choose the right integration method

Explore Documentation →

### Developer Journey


Step-by-step guides from setup to deployment

Explore Documentation →

### Support


Common FAQs, and how to reach the Suki team for help

Explore Documentation →

```
import requests

url = "https://sdp.suki.ai/api/v1/auth/register"

payload = {
  "partner_id": "your-partner-id",
  "partner_token": "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9...",
  "provider_name": "Dr. John Smith",
  "provider_org_id": "org-123",
  "provider_id": "provider-123",  # Optional
  "provider_specialty": "CARDIOLOGY"  # Optional, defaults to FAMILY_MEDICINE
}

response = requests.post(url, json=payload)

if response.status_code == 201:
  print("Provider registered successfully")
elif response.status_code == 409:
  print("Provider already linked to this partner")
else:
  print(f"Registration failed: {response.status_code}")
  print(response.json())
```

Quickstart
[Get Partner Access](https://www.suki.ai/contact-us)

## Choose your integration

- SDP REST APIs
- Mobile SDK
- Web SDK
- Headless Web SDK

REST
WebSocket
Webhooks

Best for custom implementations on any stack


```
curl --request GET \
  --url https://sdp.suki-stage.com/api/v1/ambient/session/{ambient_session_id}/status \
  --header 'sdp_suki_token: <sdp_suki_token>'
```

View API Reference →
iOS
Swift

Best for native iOS applications


```
// Add SukiAmbientCore.framework to your Xcode project
import SukiSDK
```

View Mobile SDK Docs →
React
JavaScript

Best for web-based healthcare applications


```
npm install @suki-sdk/react
```

View Web SDK Docs →
React
Headless

Best for web applications with a custom UI


```
npm install @suki-sdk/platform-react
```

View Headless SDK Docs →
What’s new
NewAudio Streaming & Download API- Stream or download original audio recordings from ambient sessions
NewAudio Dictation REST APIs- Dictation APIs to transcribe audio in real-time
BetaHeadless Web SDK- New beta headless web SDK for building custom integrations
View Release Notes →
⌘
I
$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
