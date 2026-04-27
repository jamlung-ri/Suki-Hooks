# Multilingual Support - Suki

**Source URL:** https://developer.suki.ai/api-reference/capabilities/multilingual

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
Multilingual support lets patients and providers speak in their preferred language during clinical conversations, while Suki automatically generates the final clinical note in English.
Last updated:
March 2026
**Multilingual support is supported by:**
APIs, Mobile SDK, Web SDK (v2.1.1+)

## ​Overview

Multilingual support lets patients and
speak in their preferred language during clinical conversations, while Suki automatically generates the final
in English. This removes the need for manual translation and makes healthcare more accessible to diverse patient populations.
When you enable multilingual support for an
, you get the following benefits:
- Patient comfort : Patients can communicate in their native language, leading to more accurate information sharing
- Better care quality : When patients speak in their preferred language, they provide more detailed and accurate information
- No translation needed : Clinicians don’t need to translate conversations manually, Suki handles it automatically
- EHR compatibility : All notes are generated in English, ensuring compatibility with standard EHR systems
- Wider accessibility : Support for 80+ languages makes healthcare more inclusive


## ​How it works

When you enable multilingual support for an ambient session, Suki automatically:
- Detects the language spoken during the conversation
- Transcribes the audio in the detected language
- Translates and processes the conversation content
- Generates the clinical note in English

The
API returns a
`lang_id`
field that identifies which language was detected for each segment of the conversation. This helps you understand what language was spoken during different parts of the session.

## ​How to enable multilingual support

Enable multilingual support when creating an ambient session. The exact method depends on whether you’re using the Mobile SDK or APIs.
**Mobile SDK Example:**
Swift

```
let sessionContext = [
    SukiAmbientConstant.kSessionId: encounterId,
    SukiAmbientConstant.kMultilingual: true // Enable multilingual support
] as [String : AnyHashable]

SukiAmbientCoreManager.shared.createSession(
    with: sessionContext,
    onCompletion: { result in
        switch result {
        case .success(let sessionResponse):
            let sessionId = sessionResponse.sessionId
            // Store sessionId for future use
        case .failure(let error):
            // Handle error
        }
    }
)
```

**API Example:**
Python

```
payload = {
    "ambient_session_id": "123dfg-456dfg-789dfg-012dfg",  # Optional
    "encounter_id": "123dfg-456dfg-789dfg-012dfg",  # Optional
    "multilingual": false  # Deprecated in v1.1.1
}

response = requests.post(
    "https://sdp.suki.ai/api/v1/ambient/session/create",
    json=payload,
    headers={"sdp_suki_token": "<sdp_suki_token>"}
)
```

For complete API documentation, see the
Create ambient session API
.
Multilingual support is
**disabled by default**
.
You must explicitly enable it when creating a session. Once enabled, it applies to the entire session and cannot be changed mid-session.

## ​Supported languages

Suki supports over
**80 languages**
for ambient sessions. The following languages are currently supported:
|  |  |  |  |  |
| --- | --- | --- | --- | --- |
| Spanish | Norwegian | Macedonian | Kazakh | Yoruba |
| Italian | Finnish | Hungarian | Icelandic | Telugu |
| English | Vietnamese | Tamil | Marathi | Khmer |
| Portuguese | Thai | Hindi | Maori | Malayalam |
| German | Slovak | Estonian | Swahili | Lao |
| Japanese | Greek | Urdu | Armenian | Punjabi |
| Polish | Czech | Latvian | Belarusian | Gujarati |
| Russian | Croatian | Slovenian | Nepali | Somali |
| Dutch | Danish | Azerbaijani | Occitan | Bengali |
| Indonesian | Tagalog | Hebrew | Lingala | Georgian |
| Catalan | Korean | Lithuanian | Maltese | Assamese |
| French | Romanian | Persian | Tajik | Mongolian |
| Turkish | Bulgarian | Welsh | Luxembourgish | Myanmar |
| Swedish | Galician | Serbian | Hausa | Shona |
| Ukrainian | Bosnian | Afrikaans | Uzbek | Amharic |
| Malay | Arabic | Kannada | Pashto | Sindhi |
| Chinese (Cantonese) | Chinese (Mandarin) |  |  |  |


## ​Language code reference

Use the following table to map each
`lang_id`
to its corresponding language. This helps you interpret the language codes returned by the Transcript API.
We regularly update this list as we add support for new languages. If a language is not included in this table, it is not yet supported.
**A**
| Language | Language ID ( lang_id ) |
| --- | --- |
| afrikaans | af |
| amharic | am |
| arabic | ar |
| armenian | hy |
| assamese | as |
| azerbaijani | az |

**B**
| Language | Language ID ( lang_id ) |
| --- | --- |
| belarusian | be |
| bengali | bn |
| bosnian | bs |
| bulgarian | bg |

**C**
| Language | Language ID ( lang_id ) |
| --- | --- |
| catalan | ca |
| chinese | zh |
| chinese_cantonese | yue |
| chinese_mandarin | cmn |
| croatian | hr |
| czech | cs |

**D**
| Language | Language ID ( lang_id ) |
| --- | --- |
| danish | da |
| dutch | nl |

**E**
| Language | Language ID ( lang_id ) |
| --- | --- |
| english | en |
| estonian | et |

**F**
| Language | Language ID ( lang_id ) |
| --- | --- |
| finnish | fi |
| french | fr |

**G**
| Language | Language ID ( lang_id ) |
| --- | --- |
| galician | gl |
| georgian | ka |
| german | de |
| greek | el |
| gujarati | gu |

**H**
| Language | Language ID ( lang_id ) |
| --- | --- |
| hausa | ha |
| hebrew | he |
| hindi | hi |
| hungarian | hu |

**I**
| Language | Language ID ( lang_id ) |
| --- | --- |
| icelandic | is |
| indonesian | id |
| italian | it |

**J**
| Language | Language ID ( lang_id ) |
| --- | --- |
| japanese | ja |

**K**
| Language | Language ID ( lang_id ) |
| --- | --- |
| kannada | kn |
| kazakh | kk |
| khmer | km |
| korean | ko |

**L**
| Language | Language ID ( lang_id ) |
| --- | --- |
| lao | lo |
| latvian | lv |
| lingala | ln |
| lithuanian | lt |
| luxembourgish | lb |

**M**
| Language | Language ID ( lang_id ) |
| --- | --- |
| macedonian | mk |
| malay | ms |
| malayalam | ml |
| maltese | mt |
| maori | mi |
| marathi | mr |
| mongolian | mn |
| myanmar | my |

**N**
| Language | Language ID ( lang_id ) |
| --- | --- |
| nepali | ne |
| norwegian | no |

**O**
| Language | Language ID ( lang_id ) |
| --- | --- |
| occitan | oc |

**P**
| Language | Language ID ( lang_id ) |
| --- | --- |
| pashto | ps |
| persian | fa |
| polish | pl |
| portuguese | pt |
| punjabi | pa |

**R**
| Language | Language ID ( lang_id ) |
| --- | --- |
| romanian | ro |
| russian | ru |

**S**
| Language | Language ID ( lang_id ) |
| --- | --- |
| serbian | sr |
| shona | sn |
| sindhi | sd |
| slovak | sk |
| slovenian | sl |
| somali | so |
| spanish | es |
| swahili | sw |
| swedish | sv |

**T**
| Language | Language ID ( lang_id ) |
| --- | --- |
| tagalog | tl |
| tajik | tg |
| tamil | ta |
| telugu | te |
| thai | th |
| turkish | tr |

**U**
| Language | Language ID ( lang_id ) |
| --- | --- |
| ukrainian | uk |
| urdu | ur |
| uzbek | uz |

**V**
| Language | Language ID ( lang_id ) |
| --- | --- |
| vietnamese | vi |

**W**
| Language | Language ID ( lang_id ) |
| --- | --- |
| welsh | cy |

**Y**
| Language | Language ID ( lang_id ) |
| --- | --- |
| yoruba | yo |


## ​Best practices

- Enable when needed : Only enable multilingual support when you expect conversations in multiple languages. This optimizes performance.
- Set patient language preference : If you know the patient’s preferred language, you can display this information in your UI to help providers prepare.
- Monitor language detection : Use the lang_id from transcripts to understand language usage patterns in your application.
- Test with your languages : Verify multilingual support works correctly with the languages your patients commonly use.
- Note language in UI : Consider displaying the detected language in your UI so providers know what language was spoken.


## ​Related APIs

Use these APIs to work with multilingual support:

## Get Session Transcript

Retrieve transcripts with language detection information (
`lang_id`
)

## Create Session

Create ambient sessions with multilingual support enabled
Last modified on
April 1, 2026
Problem-Based ChartingPrevious
PersonalizationNext
⌘
I
- Overview
- How it works
- How to enable multilingual support
- Supported languages
- Language code reference
- Best practices
- Related APIs

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
