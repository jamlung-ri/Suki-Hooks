# Personalization - Suki

**Source URL:** https://developer.suki.ai/api-reference/capabilities/personalization

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
allows you to customize how Suki generates clinical notes based on each provider’s preferences. Control how much detail (short and concise, balanced, or very detailed) and how it’s formatted (continuous paragraphs or bullet points).
Last updated:
March 2026
**Personalization is supported by:**
APIs, Web SDK, Mobile SDK

## ​Overview

Personalization allows you to help providers customize how Suki generates their clinical notes. Every provider has different preferences, some want short bullet points, others want detailed paragraphs. Personalization ensures each provider gets notes that match their style.
When you use personalization, you can customize two aspects of note generation:
- How much detail : Short and concise, balanced, or very detailed notes
- How it’s formatted : Continuous paragraphs (narrative) or bullet points

Once you set a provider’s preferences, Suki automatically applies them to all future notes for that provider. You set it once, and Suki remembers, no need to send preferences with every request.
Using personalization, you get the following benefits:
- Provider satisfaction : Notes match each provider’s preferred style and level of detail
- Consistent documentation : Once set, preferences apply automatically to all future notes
- Efficiency : Providers don’t need to manually adjust notes; they’re generated according to their preferences
- Flexibility : Different providers can have different preferences based on their specialty and workflow
- Better adoption : When notes match provider preferences, they’re more likely to use and trust the system


## ​How it works

Personalization settings are saved at the user level, not per session. Once you set a provider’s preferences, Suki automatically applies them to all future note generation for that provider.
**The process:**
- Set preferences : Use the Mobile SDK setPersonalizationPreferences method or the User Preferences API to configure a provider’s preferences
- Automatic application : Suki applies these settings to all future notes for that provider
- Update anytime : Update preferences at any time; the most recent settings always take effect

Personalization settings are
**persistent**
and
**user-specific**
. Once set, you don’t need to send preferences with every session request. Suki automatically uses the saved preferences for each provider.

## ​How to set personalization preferences

Set personalization preferences using the Mobile SDK or APIs. The exact method depends on your integration.
**Mobile SDK Example:**
Swift

```
let preferences: [String: AnyHashable] = [
    "verbosity": "CONCISE", // Options: CONCISE, BALANCED, DETAILED
    "section_format": [
        [
            "loinc": "10164-2",
            "style": "NARRATIVE" // Options: NARRATIVE, BULLETED
        ]
    ]
]

SukiAmbientCore.shared.setPersonalizationPreferences(preferences) { result in
    switch result {
    case .success:
        print("Preferences updated successfully")
    case .failure(let error):
        print("Error updating preferences: \(error)")
    }
}
```

**API Example:**
Python

```
import requests

url = "https://sdp.suki-stage.com/api/v1/user/preferences"

payload = { "personalization_preference": {
        "section_format": [
            {
                "loinc": "10164-2",
                "style": "NARRATIVE"
            }
        ],
        "verbosity": "CONCISE"
    } }
headers = {
    "sdp_suki_token": "<sdp_suki_token>",
    "Content-Type": "application/json"
}
```

**When to set preferences:**
- After user registration : Set default preferences when a new provider is added to your system
- When preferences change : Update preferences whenever a provider requests changes
- Before sessions start : For best results, set preferences before audio streaming begins

The
**User Preferences API**
is a
`PATCH`
request, so you only need to send the fields you want to change. Update verbosity and section formats independently.

## ​Personalization options

Customize two aspects of note generation:

### ​Verbosity

Controls how much detail is included in the generated notes. This setting applies to
**all note sections**
.
​
verbosity
string
default:
"BALANCED"
**Applies to:**
All note sections

### ​Section style

Controls the formatting style for specific clinical sections. Set different styles for different sections as needed.
​
section_format
array
**Applies to:**
- History of Present Illness (10164-2)
- Assessment and Plan (51847-2)
- Assessment (51848-0)
- Plan (18776-5)

**Example:**
JSON

```
"section_format": [
  {
    "loinc": "10164-2",
    "style": "NARRATIVE"
  },
  {
    "loinc": "51848-0",
    "style": "BULLETED"
  }
]
```


## ​Best practices

- Set defaults early : Configure preferences when providers are first registered in your system
- Offer a UI : Let providers choose their preferences through your application’s settings page
- Explain options : Help providers understand the difference between verbosity levels and style options
- Update when requested : Make it easy for providers to change their preferences as their needs evolve
- Test with real notes : Verify that preferences produce notes that match provider expectations


## ​Related APIs


## User Preferences API

Set and update personalization preferences for providers
Last modified on
April 1, 2026
Multilingual SupportPrevious
Audio DictationNext
⌘
I
- Overview
- How it works
- How to set personalization preferences
- Personalization options
- Verbosity
- Section style
- Best practices
- Related APIs

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
