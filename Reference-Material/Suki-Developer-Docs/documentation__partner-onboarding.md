# Partner Onboarding - Suki

**Source URL:** https://developer.suki.ai/documentation/partner-onboarding

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

Before you can use Suki’s APIs and SDKs, you must complete a
**one-time**
onboarding process. This guide walks you through getting started as a Suki partner.
Once onboarded, you’ll receive a
(
`partner_id`
) that identifies your organization. Then register users and start integrating Suki’s AI capabilities into your application.

## ​Key concepts


## Partner

An organization that integrates with Suki to use our services. A partner can contain multiple organizations.

## Organization

A group of users within a partner, such as a hospital or a clinic.

## Provider

A user within an organization, such as a doctor or a nurse, who uses Suki’s services.

## ​Partner ID

A Partner ID is a unique identifier that Suki assigns to your organization during onboarding. You’ll use this ID in all API calls and SDK initializations.
**What it’s used for:**
- Links your application to its configuration in the Suki Developer Platform
- Determines which authentication endpoint to use for token validation
- Maps your user roles to Suki’s capabilities

You’ll receive your Partner ID after completing onboarding. Include it in all API requests and when initializing SDKs.

## ​How authentication works

Suki uses your existing identity provider to authenticate users. You don’t need to create separate user accounts in Suki.
**The authentication flow:**
- A provider signs in to your application using your identity provider (like Okta, Azure AD, or Auth0)
- Your identity provider issues a token for that user
- You send this token to Suki in your API requests
- Suki verifies the token to confirm the user’s identity and grant access

**Identity Provider**
: A service that authenticates users and issues identity tokens. Examples include Okta, Auth0, and Azure AD. You’ll use your existing identity provider (no need to set up a new one for Suki).

## ​Onboarding process

Follow these steps to get started:

### ​Onboarding flow

$!
/$

Contact Suki

Reach out to the Suki Customer Success team to begin onboarding. Have this information ready:
- Business details : Official business name, email address, and phone number
- Use case : Description of your business and how you plan to use Suki
- Contact person : Name of the person managing the integration
- Authentication method : How you’ll authenticate users (see options below)

**Supported Authentication Methods**
Suki supports these authentication methods. You’ll use your existing identity provider:
- Stored Secret - Share your public key with Suki, stored securely in our database
- JWKS URL - Host your public keys at a public endpoint; Suki fetches them automatically
- Okta - Use Okta as your identity provider; Suki gets keys from your Okta issuer URL
- JWT Assertion - Share your public key as a signed JWT following RFC 7523

Learn more in the
Partner authentication
guide.

Suki reviews your information

The Suki team reviews your information and sets up your account. This typically takes a few business days.

Receive your Partner ID

Once approved, you’ll receive your unique Partner ID. Use this ID in all API calls and SDK initializations to identify your organization.

## ​Getting support

Need help? Reach out through any of these channels:
Last modified on
April 1, 2026
Choose Your IntegrationPrevious
Partner AuthenticationNext
⌘
I
- Overview
- Key concepts
- Partner ID
- How authentication works
- Onboarding process
- Onboarding flow
- Getting support

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
