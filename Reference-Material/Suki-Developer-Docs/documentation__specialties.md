# Supported Medical Specialties - Suki

**Source URL:** https://developer.suki.ai/documentation/specialties

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
A Medical Specialty is the type of care a provider(doctor) practices, like Cardiology, Pediatrics, or Emergency Medicine. When you tell Suki what specialty a provider(doctor) has, Suki generates notes that match how that specialty works.
Last updated:
March 2026
**Specialties is supported by:**
APIs, Web SDK, Mobile SDK, Headless Web SDK

## ​Overview

A Medical Specialty is the type of care a
(doctor) practices, like Cardiology, Pediatrics, or Emergency Medicine. When you tell Suki what specialty a provider has, Suki generates notes that match how that specialty works.
For example, a
**Cardiologist**
and a
**Pediatrician**
have different specialties, and the notes that Suki needs to generate for them will be different.
- Cardiologist : Uses terms like “ejection fraction,” “stent placement,” “cardiac catheterization”
- Pediatrician : Uses terms like “growth percentile,” “vaccination schedule,” “developmental milestones”

When you specify the specialty, Suki:
- Uses the right medical terms for that specialty
- Recognizes specialty-specific abbreviations correctly
- Structures notes the way that specialty typically documents
- Provides relevant suggestions that match that specialty’s workflow

In result, providers get more accurate notes that match how that specialty actually works in practice.

## ​How it works

When you start an
, specify the provider’s specialty. Suki uses this information throughout the session to generate notes that match the specialty’s documentation standards and terminology.
Suki supports 120+ medical specialties. We regularly add new specialties as they become available. If you need a specialty that’s not listed, contact support.

## ​How to use specialties

Specify a specialty when initializing the SDK or providing session context. Use the specialty code (like
`CARDIOLOGY`
or
`PEDIATRICS`
) from the list below.
- Web SDK
- Headless Web SDK
- Mobile SDK

**Web SDK Example:**
JavaScript

```
import { initialize } from "@suki-sdk/js";

const sdkClient = initialize({
  partnerId: "your-partner-id",
  partnerToken: "your-partner-token",
  providerName: "John Doe",
  providerOrgId: "1234",
  providerSpecialty: "CARDIOLOGY" // Optional, defaults to FAMILY_MEDICINE
});
```

**Headless Web SDK Example:**
TypeScript

```
import { useAmbientSession } from "@suki-sdk/react-headless";

const { setSessionContext } = useAmbientSession();

// Set specialty in session context
await setSessionContext({
  provider: {
    specialty: "CARDIOLOGY"
  }
});
```

**Mobile SDK Example:**
Swift

```
let contextDetail: [String: AnyHashable] = [
    SukiAmbientConstant.kProviderContext: [
        SukiAmbientConstant.kSpeciality: "CARDIOLOGY"
    ]
]

try SukiAmbientCore.shared.setSessionContext(with: contextDetail) { result in
    // Handle result
}
```

If you don’t specify a specialty, Suki defaults to
`FAMILY_MEDICINE`
. For best results, always specify the provider’s actual specialty.

## ​Supported specialties

Suki supports the following medical specialties. Use the
**Value**
column when specifying a specialty in your code:
| S.No | Value | Description |
| --- | --- | --- |
| 1 | NA | N/A - No Specialty |
| 2 | ALLERGY_AND_IMMUNOLOGY | Allergy and Immunology |
| 3 | ANESTHESIOLOGY | Anesthesiology |
| 4 | CARDIOLOGY | Cardiology |
| 5 | CRITICAL_CARE | Critical Care |
| 6 | DERMATOLOGY | Dermatology |
| 7 | EMERGENCY_MEDICINE | Emergency Medicine |
| 8 | ENDOCRINOLOGY | Endocrinology |
| 9 | FAMILY_MEDICINE | Family Medicine |
| 10 | GASTROENTEROLOGY | Gastroenterology |
| 11 | GENETICS | Genetics |
| 12 | HEMATOLOGY | Hematology |
| 13 | INFECTIOUS_DISEASE | Infectious Disease |
| 14 | INTERNAL_MEDICINE | Internal Medicine |
| 15 | MEDICAL_ONCOLOGY | Medical Oncology |
| 16 | NEPHROLOGY | Nephrology |
| 17 | NEUROLOGY | Neurology |
| 18 | NEUROSURGERY | Neurosurgery |
| 19 | NUCLEAR_MEDICINE | Nuclear Medicine |
| 20 | OBSTETRICS_GYNECOLOGY | Obstetrics and Gynecology |
| 21 | OPHTHALMOLOGY | Ophthalmology |
| 22 | ORTHOPEDIC_SURGERY | Orthopedic Surgery |
| 23 | OTOLARYNGOLOGY_HEAD_AND_NECK | Otolaryngology - Head and Neck Surgery |
| 24 | PALLIATIVE_MEDICINE | Palliative Medicine |
| 25 | PAIN_MANAGEMENT | Pain Management |
| 26 | PATHOLOGY | Pathology |
| 27 | PEDIATRICS | Pediatrics |
| 28 | PHYSICAL_MEDICINE_AND_REHABILITATION | Physical Medicine and Rehabilitation |
| 29 | PLASTIC_SURGERY | Plastic Surgery |
| 30 | PODIATRY | Podiatry |
| 31 | PREVENTATIVE_MEDICINE | Preventative Medicine |
| 32 | PSYCHIATRY | Psychiatry |
| 33 | PULMONOLOGY | Pulmonology |
| 34 | RADIATION_ONCOLOGY | Radiation Oncology |
| 35 | RADIOLOGY_DIAGNOSTIC | Radiology - Diagnostic |
| 36 | RADIOLOGY_INTERVENTIONAL | Radiology - Interventional |
| 37 | RHEUMATOLOGY | Rheumatology |
| 38 | SPORTS_MEDICINE | Sports Medicine |
| 39 | SURGERY_CARDIAC_AND_THORACIC | Surgery - Cardiac and Thoracic |
| 40 | SURGERY_COLON_AND_RECTAL | Surgery - Colon and Rectal |
| 41 | SURGERY_GENERAL | Surgery - General |
| 42 | SURGERY_PEDIATRIC | Surgery - Pediatric |
| 43 | SURGERY_VASCULAR | Surgery - Vascular |
| 44 | UROLOGY | Urology |
| 45 | UNLISTED_MEDICAL | Unlisted - Medical |
| 46 | UNLISTED_SURGICAL | Unlisted - Surgical |
| 47 | LACTATION | Lactation |
| 48 | NUTRITION | Nutrition |
| 49 | VETERINARIAN | Veterinarian |
| 50 | GERIATRICS | Geriatrics |
| 51 | HOSPITAL_MEDICINE | Hospital Medicine |
| 52 | SLEEP_MEDICINE | Sleep Medicine |
| 53 | FUNCTIONAL_MEDICINE | Functional Medicine |
| 54 | INTEGRATIVE_MEDICINE | Integrative Medicine |
| 55 | HEPATOLOGY | Hepatology |
| 56 | PEDIATRIC_ALLERGY_AND_IMMUNOLOGY | Pediatric Allergy and Immunology |
| 57 | PEDIATRIC_CARDIOLOGY | Pediatric Cardiology |
| 58 | PEDIATRIC_ENDOCRINOLOGY | Pediatric Endocrinology |
| 59 | PEDIATRIC_CRITICAL_CARE | Pediatric Critical Care |
| 60 | DEVELOPMENTAL_AND_BEHAVIORAL_PEDIATRICS | Developmental and Behavioral Pediatrics |
| 61 | PEDIATRIC_HOSPITAL_MEDICINE | Pediatric Hospital Medicine |
| 62 | PEDIATRIC_NEPHROLOGY | Pediatric Nephrology |
| 63 | PEDIATRIC_RHEUMATOLOGY | Pediatric Rheumatology |
| 64 | PEDIATRIC_GASTROENTEROLOGY | Pediatric Gastroenterology |
| 65 | PEDIATRIC_PSYCHIATRY | Pediatric Psychiatry |
| 66 | GYN_ONCOLOGY | Gyn-Oncology |
| 67 | REPRODUCTIVE_ENDOCRINOLOGY_AND_INFERTILITY | Reproductive Endocrinology and Infertility (REI) |
| 68 | UROGYNECOLOGY | Urogynecology |
| 69 | SPINE_SURGERY | Spine Surgery |
| 70 | INTERVENTIONAL_CARDIOLOGY | Interventional Cardiology |
| 71 | CARDIOLOGY_AND_ELECTROPHYSIOLOGY | Cardiology and Electrophysiology |
| 72 | HEART_FAILURE_AND_TRANSPLANT_CARDIOLOGY | Heart Failure and Transplant Cardiology |
| 73 | ADULT_CONGENITAL_HEART_DISEASE | Adult Congenital Heart Disease |
| 74 | GASTROENTEROLOGY_ONCOLOGY | Gastroenterology Oncology |
| 75 | SURGERY_ONCOLOGY | Surgery Oncology |
| 76 | SURGERY_BARIATRICS | Surgery Bariatrics |
| 77 | INVASIVE_CARDIOLOGY | Invasive Cardiology |
| 78 | SURGERY_THORACIC | Surgery Thoracic |
| 79 | SURGERY_CARDIOVASCULAR | Surgery Cardiovascular |
| 80 | PEDIATRIC_PULMONOLOGY | Pediatric Pulmonology |
| 81 | PEDIATRIC_ADOLESCENT | Pediatric Adolescent |
| 82 | TRANSPLANT_NEPHROLOGY | Transplant Nephrology |
| 83 | HEMATOLOGY_AND_ONCOLOGY | Hematology and Oncology |
| 84 | MEDICINE_BARIATRIC | Medicine Bariatric |
| 85 | SURGERY_TRAUMA | Surgery Trauma |
| 86 | BEHAVIORAL_HEALTH | Behavioral Health |
| 87 | URGENT_CARE | Urgent Care |
| 88 | COMPREHENSIVE_CARE | Comprehensive Care |
| 89 | OCCUPATIONAL_MEDICINE | Occupational Medicine |
| 90 | ADDICTION_MEDICINE | Addiction Medicine |
| 91 | CARDIAC_IMAGING | Cardiac Imaging |
| 92 | TRANSPLANT_HEPATOLOGY | Transplant Hepatology |
| 93 | SPINAL_ONCOLOGY_AND_SPINE_TUMOR_SURGERY | Spinal Oncology and Spine Tumor Surgery |
| 94 | CONCIERGE_MEDICINE | Concierge Medicine |
| 95 | DRUG_AND_ALCOHOL_REHAB | Drug and Alcohol Rehab |
| 96 | TRANSPLANT_PANCREAS | Transplant Pancreas |
| 97 | TRANSPLANT_INTESTINE | Transplant Intestine |
| 98 | BONE_MARROW_TRANSPLANT | Bone Marrow Transplant |
| 99 | VETERINARY_URGENT_CARE | Veterinary Urgent Care |
| 100 | VETERINARY_EMERGENCY_AND_CRITICAL_CARE | Veterinary Emergency and Critical Care |
| 101 | INPATIENT_PSYCHIATRY | Inpatient Psychiatry |
| 102 | NEUROMUSCULOSKELETAL_MANIPULATIVE_MEDICINE | Neuromusculoskeletal Manipulative Medicine |
| 103 | EPILEPSY | Epilepsy |
| 104 | NEUROIMMUNOLOGY | Neuroimmunology |
| 105 | HEADACHE | Headache |
| 106 | VASCULAR_NEUROLOGY | Vascular Neurology |
| 107 | SURGERY_BREAST | Surgery Breast |
| 108 | ACCIDENT_AND_INJURY | Accident and Injury |
| 109 | CANCER_GENETICS | Cancer Genetics |
| 110 | ONCOLOGY_BREAST | Oncology Breast |
| 111 | ONCOLOGY_CUTANEOUS | Oncology Cutaneous |
| 112 | ONCOLOGY_GENITOURINARY | Oncology Genitourinary |
| 113 | ONCOLOGY_HEAD_AND_NECK | Oncology Head and Neck |
| 114 | INTERVENTIONAL_PAIN | Interventional Pain |
| 115 | ONCOLOGY_ORTHOPEDIC | Oncology Orthopedic |
| 116 | ONCOLOGY_THORACIC | Oncology Thoracic |
| 117 | ONCOLOGY | Oncology |
| 118 | ONCOLOGY_WOMENS | Oncology Womens |
| 119 | ORTHOPEDICS_HAND | Orthopedics Hand |
| 120 | WOUND_CARE | Wound Care |


## ​Getting the list via API

Fetch the list of supported specialties at runtime using the Specialties API:

## Specialties API

Get the list of supported medical specialties via API
This is useful if you want to:
- Display specialty options in a dropdown menu
- Validate specialty codes before sending them to Suki
- Keep your application in sync with Suki’s latest specialty additions


## ​Best practices

- Always specify the specialty : Don’t rely on the default. Providing the correct specialty improves note quality.
- Match your EHR : Use the specialty that matches what’s in your EHR system for consistency.
- Update when needed : If a provider changes specialties, update the specialty in your session context.
- Use specific codes : Choose the most specific specialty available (e.g., PEDIATRIC_CARDIOLOGY instead of CARDIOLOGY if applicable).

Last modified on
March 23, 2026
Note Sections (LOINC Codes)Previous
Problem-Based ChartingNext
⌘
I
- Overview
- How it works
- How to use specialties
- Supported specialties
- Getting the list via API
- Best practices

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
