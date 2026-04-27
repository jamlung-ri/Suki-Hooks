# Create Session - Suki

**Source URL:** https://developer.suki.ai/mobile-sdk/ambient-guides/create-session

---

Sukihome page
Documentation
APIs
Release Notes
Sukihome page


##### Mobile SDK Overview

- Introduction
- Capabilities
- Installation
- Configuration
- Changelog


##### Mobile SDK Guides

- Create Ambient Session UPDATED
- Recording Controls
- Session Status & Content Retrieval
- Clearing Sessions
- Session Events & Delegates
- Offline Mode


##### FAQs

- General
- Installation & Setup
- Session Management
- Content retrieval
- Offline and networking
- Troubleshooting

**Updated**
The
`setSessionContext`
method in the mobile SDK now accepts new
**optional**
parameters like:
- visitType
- encounterType
- providerRole
- reasonForVisit
- chiefComplaint

Provide these parameters to help improve note generation accuracy.
Quick summary
The
`createSession(withSessionInfo:)`
method creates a new ambient session and returns a
`sessionId`
that you use for all subsequent operations. Optionally provide session context like patient information, provider specialty, and note sections to improve note quality.


The method handles the session creation asynchronously and returns a result that you can use to track success or handle errors. Store the
`sessionId`
securely as you’ll need it for recording controls and content retrieval.
Last updated:
March 2026

## ​Overview

Before you can start recording audio and generating clinical notes, you must create an ambient session. This guide shows you how to create a session and provide clinical context that helps Suki generate more accurate notes.

## ​What will you learn?

In this guide, you will learn how to:
- Create an ambient session using the createSession(withSessionInfo:) method
- Store the session ID returned from session creation for future operations
- Provide clinical context using the setSessionContext(with:) method to improve note quality
- Understand what information to provide and when to provide it


## ​Create an ambient session

To start capturing audio and generating notes, you must first create a session. The session acts as a container that holds all the audio data and context for a single patient encounter.

---

$!
/$

---

Call the
`createSession(withSessionInfo:)`
method to create a new session. When successful, this method returns a
`sessionId`
that you
**must store**
to use for recording and retrieving content later.

```
let sessionContext = [
    SukiAmbientConstant.kSessionId: <encounter-id>,
    SukiAmbientConstant.kIsMultilingual: isMultilingual
] as [String : AnyHashable]

SukiAmbientCoreManager.shared.createSession(with: sessionContext, onCompletion: { result in
    switch result {
    case .success(let sessionResponse):
        // Store the sessionId from sessionResponse for future use
        let sessionId = sessionResponse.sessionId
        print("Session created successfully: \(sessionId)")
    case .failure(let error):
        print("Error creating session: \(error)")
    }
})
```


### ​Session info parameters

The
`withSessionInfo`
dictionary accepts the following optional parameters:
​
SukiAmbientConstant.kSessionId
string
An optional unique identifier for the session. If you don’t provide this, the SDK automatically generates a session ID for you. Use this if you want to use your own encounter ID or session identifier.
​
SukiAmbientConstant.kMultilingual
boolean
default:
"false"
Enables multilingual processing for the session. Set this to
`true`
if the conversation will be in languages other than English. The default value is
`false`
(English only). Once set, this cannot be changed for the session.
**Important**
: Always store the
`sessionId`
returned from
`createSession`
. You’ll need it to:
- Start recording
- Check session status
- Retrieve generated content
- Update session context


## ​Provide clinical context (optional but recommended)

After creating a session, you can provide additional clinical information using the
`setSessionContext(with:)`
method. This context helps Suki’s AI generate more accurate and relevant clinical notes.
**Why provide context?**
- Better note quality : More accurate sections and diagnoses
- Specialty-specific formatting : Notes match your medical specialty
- Structured organization : Notes organized by the sections you need
- Diagnosis accuracy : Better identification of conditions discussed

Call
`setSessionContext(with:)`
multiple times. Each call updates or adds to the existing context. This allows you to provide information as it becomes available in your app.

```
do {
    let contextDetail: [String: AnyHashable] = [
        SukiAmbientConstant.kPatientInfo: [
            SukiAmbientConstant.kBirthdate: Date(), // Use yyyy-mm-dd format
            SukiAmbientConstant.kGender: "MALE"
        ],
        SukiAmbientConstant.kProviderContext: [
            SukiAmbientConstant.kSpeciality: "FAMILY_MEDICINE",
            SukiAmbientConstant.kProviderRole: "Primary/Attending" // New in v2.5.0: Optional provider role (Primary/Attending or Consulting)
        ],
        SukiAmbientConstant.kVisitContext: [ 
          // New in v2.5.0: Visit context parameters for improved note generation
            SukiAmbientConstant.kVisitType: "Established patient", // Optional: New Patient / Intake, Established patient, Wellness, ED
            SukiAmbientConstant.kEncounterType: "ambulatory", // Optional: ambulatory, inpatient, ED
            SukiAmbientConstant.kReasonForVisit: "Annual checkup", // Optional: String, max 255 characters
            SukiAmbientConstant.kChiefComplaint: "Routine follow-up" // Optional: String, max 255 characters
        ],
        SukiAmbientConstant.kSections: [
            [SukiAmbientConstant.kCode: "51848-0", SukiAmbientConstant.kCodeType: "loinc"],
            [SukiAmbientConstant.kCode: "11450-4", SukiAmbientConstant.kCodeType: "loinc"]
        ],
        SukiAmbientConstant.kDiagnosisInfo: [
            [
                SukiAmbientConstant.kDiagnosisNote: "Patient presents with chest pain",
                SukiAmbientConstant.kCodes: [
                    [
                        SukiAmbientConstant.kCodeType: "ICD-10",
                        SukiAmbientConstant.kCode: "R06.02",
                        SukiAmbientConstant.kCodeDescription: "Shortness of breath"
                    ]
                ]
            ]
        ]
    ]
    
    try SukiAmbientCore.shared.setSessionContext(with: contextDetail) { result in
        switch result {
        case .success:
            print("Context updated successfully")
        case .failure(let error):
            print("Error updating context: \(error)")
        }
    }
} catch {
    print(error)
}
```

Call
`setSessionContext(with:)`
only
**after**
a session has been successfully created. Call
`createSession`
first and wait for it to succeed before calling
`setSessionContext`
.

### ​Context parameters

All context parameters are
**optional**
. Provide only the information that is available in your application. The absence of any parameter will not break existing functionality.
​
SukiAmbientConstant.kPatientInfo
dictionary
Patient demographic information that helps personalize the note generation.
​
SukiAmbientConstant.kProviderContext
dictionary
Information about the healthcare provider to tailor note generation to your specialty and role.
​
SukiAmbientConstant.kVisitContext
dictionary
Visit-related metadata that provides context about the type and purpose of the encounter.
​
SukiAmbientConstant.kSections
array of dictionaries
An array of LOINC codes that specify which clinical note sections you want in the generated note. Each dictionary contains a LOINC code.
You only need to provide LOINC codes. The SDK automatically generates the appropriate clinical section titles based on the codes you provide.
**Code example**
:
Swift

```
SukiAmbientConstant.kSections: [
    [SukiAmbientConstant.kCode: "51848-0", SukiAmbientConstant.kCodeType: "loinc"],
    [SukiAmbientConstant.kCode: "11450-4", SukiAmbientConstant.kCodeType: "loinc"]
]
```

​
SukiAmbientConstant.kDiagnosisInfo
array of dictionaries
Structured diagnosis information that helps the AI identify and code conditions discussed during the encounter. Each dictionary represents one diagnosis.

## ​Best practices

Follow these practices to ensure reliable session management:
- Always initialize the SDK first : Make sure SukiAmbientCore.shared.initialize() has been called successfully before creating a session.
- Store the session ID : Save the sessionId returned from createSession immediately. You’ll need it for all subsequent operations.
- Handle errors properly : Use the completion handler’s result to check for success or failure. Display appropriate error messages to users.
- Provide context when available : Call setSessionContext with any clinical information you have. Even partial context improves note quality.
- Call setSessionContext after createSession : Wait for createSession to succeed before calling setSessionContext .
- Handle background limitations : On iOS, you cannot start a recording while the app is in the background. Ensure your app is active before starting recording.


## ​FAQs


## ​Next steps

After you create a session and optionally set context, proceed to the
Recording controls
guide to learn how to start recording and manage the recording lifecycle.
Last modified on
April 1, 2026
Mobile SDK ChangelogPrevious
Recording ControlsNext
⌘
I
- Overview
- What will you learn?
- Create an ambient session
- Session info parameters
- Provide clinical context (optional but recommended)
- Context parameters
- Best practices
- FAQs
- Next steps

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
