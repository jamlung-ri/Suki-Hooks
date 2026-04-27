# Ambient Documentation - Suki

**Source URL:** https://developer.suki.ai/documentation/ambient-documentation

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

Quick summary
Ambient documentation automatically creates clinical notes from patient-provider conversations. Instead of typing notes during or after a visit, providers can focus entirely on the patient while Suki listens, transcribes, and organizes the conversation into structured clinical documentation.
Last updated:
March 2026
**Ambient documentation is supported by:**
APIs, Web SDK, Mobile SDK, Headless Web SDK

## ​Overview

Ambient documentation automatically creates
from patient-provider conversations.
Instead of typing notes during or after a visit of a patient,
can focus entirely on the patient while Suki listens, transcribes, and organizes the conversation into structured clinical documentation.
Ambient documentation helps providers to:
- Save time : No more typing notes during or after visits
- Better patient care : Providers focus on patients, not screens
- Accurate documentation : AI captures details that might be missed
- Consistent format : Notes follow standard clinical structures
- EHR ready : Generated notes integrate directly with EHR systems


## ​How it works

Ambient documentation works in four main steps:
1

Create session

Start a new
for a patient visit. Provide basic information like:
- Patient details (name, date of birth, etc.)
- Which note sections you want (e.g., History, Physical Exam, Assessment)
- Provider information

Suki returns a session ID that tracks everything for this visit.
Sessions should be at least 1 minute long. Very short sessions may be skipped.
2

Record conversation

Start recording when the visit begins. Audio streams to Suki in real-time, where it’s automatically converted to text using speech recognition.
**What happens:**
- Audio is captured from the conversation
- Speech is converted to text automatically
- Different speakers are identified (doctor vs. patient)
- Everything happens in real-time

3

AI processing

After the conversation ends, Suki’s AI analyzes the
:
- Identifies clinically important information
- Organizes content into the sections you requested
- Structures it like a professional clinical note

**Example:**
The AI might extract “chest pain for 3 days” and put it in the “History of Present Illness” section.
4

Get generated clinical note

Once processing is complete, retrieve the finished clinical note. The note includes:
- Structured sections : Content organized by LOINC codes (e.g., History, Assessment, Plan)
- Structured data : Diagnoses, medications, and other coded information
- Full transcript : Complete conversation transcript if needed

The note is ready to integrate directly into your EHR system.

## ​Key features


## Accurate Speech Recognition

Converts speech to text accurately, even with complex medical terminology. Automatically identifies who’s speaking (doctor vs. patient).

## Multilingual Support

Works with over 80 languages. Patients can speak in their preferred language, and notes are generated in English.

## Customizable Note Sections

Choose which sections to include in your notes using standard LOINC codes. Match your EHR’s expected format.

## Works in Background

Processes everything automatically. Handles interruptions gracefully so providers can focus on patients.

## Secure and HIPAA-Compliant

All audio and data are encrypted. Built to meet healthcare privacy and security requirements.

## Speaker Identification

Automatically distinguishes between different speakers, ensuring accurate attribution of who said what.

## ​Getting started

To use Ambient documentation in your application:

Get access

Contact our
Partnership team
to get onboarded and receive your credentials.

Choose integration method

Select how you want to integrate:
- APIs : Direct API integration for maximum control
- Web SDK : Pre-built components for web applications
- Mobile SDK : Native iOS integration for mobile apps
- Headless Web SDK : React hooks for custom UI integration

Refer to the
Quickstart guide
to get started quickly.

Test and deploy

Test your integration thoroughly before deploying to production. Start with development or staging environments.
Last modified on
April 1, 2026
Partner AuthenticationPrevious
Note Sections (LOINC Codes)Next
⌘
I
- Overview
- How it works
- Key features
- Getting started

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
