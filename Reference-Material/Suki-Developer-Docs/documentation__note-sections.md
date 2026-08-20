# Note Sections (LOINC Codes) - Suki

**Source URL:** https://developer.suki.ai/documentation/note-sections

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
Note sections divide
into standard parts such as “Chief Complaint,” “Physical Exam,” and “Assessment and Plan.” Suki uses
codes to identify each section, which ensures seamless integration with your EHR system.
Last updated:
March 2026
**Note sections is supported by:**
APIs, Web SDK, Mobile SDK, Headless Web SDK

## ​Overview

Note sections divide clinical notes into standard parts such as “Chief Complaint,” “Physical Exam,” and “Assessment and Plan.” This organized structure makes notes easier to read and ensures seamless integration with your EHR system.
Suki uses
codes (Logical Observation Identifiers Names and Codes) to identify each section. LOINC is a widely adopted healthcare standard, which means your notes will work consistently across different EHR systems and applications.
When you specify the note sections, you get the following benefits:
- Better organization : Content is automatically sorted into the right sections
- EHR ready : Notes match the format your EHR expects
- Industry standard : LOINC codes are recognized across healthcare systems
- Customizable : Choose only the sections you need for your workflow


## ​How it works

When you start an
, you specify which sections you want in your note by providing their LOINC codes. Suki listens to the conversation and automatically organizes what’s discussed into those sections.
$!
/$
**Example:**
If you specify “Chief Complaint” (10154-3), “History of Present Illness” (10164-2), and “Physical Exam” (29545-1), Suki will:
- Put information about why the patient is visiting into the Chief Complaint section
- Organize the patient’s story into the History of Present Illness section
- Capture exam findings into the Physical Exam section

The generated note includes each section with its LOINC code, making it easy to map directly to your EHR’s structure.

## ​Supported note sections

Suki supports the following clinical note sections using LOINC codes:
| SR No. | LOINC CODE | Section Common Name |
| --- | --- | --- |
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


## ​Choosing your sections

Select sections that match your clinical workflow and EHR requirements. Here are some common configurations:
| Configuration | Description |
| --- | --- |
| Basic SOAP Note | Chief Complaint (10154-3), History of Present Illness (10164-2), Physical Exam (29545-1), and Assessment and Plan (51847-2) |
| Comprehensive Visit | Add Medications (10160-0), Allergies (48765-2), Problem List (11450-4), and Review of Systems (10187-3) |
| Specialty-Specific | Choose sections relevant to your specialty (e.g., Mental Status Exam (10190-7) for psychiatry, Vitals (8716-3) for primary care) |

Start with a few essential sections and add more as needed. Adjust your configuration anytime based on what works best for your workflow.

## ​How to use note sections

Specify which sections you want when creating an ambient session by providing their LOINC codes.
**Example:**
JavaScript

```
ambientOptions: {
  sections: [
    { loinc: "10154-3" }, // Chief Complaint
    { loinc: "10164-2" }, // History of Present Illness
    { loinc: "29545-1" }, // Physical Exam
    { loinc: "51847-2" }  // Assessment and Plan
  ]
}
```

Suki automatically organizes the conversation content into these sections. Each generated section includes:
- Section name : The readable title (e.g., “Chief Complaint”)
- Content : Relevant text extracted from the conversation
- LOINC code : The standard identifier for EHR integration

This structured format makes it easy to map sections directly to your EHR’s note template.
Last modified on
March 23, 2026
Ambient DocumentationPrevious
Supported Medical SpecialtiesNext
⌘
I
- Overview
- How it works
- Supported note sections
- Choosing your sections
- How to use note sections

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
