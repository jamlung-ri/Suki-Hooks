# Seed Ambient Session Context - Suki

**Source URL:** https://developer.suki.ai/api-reference/ambient-sessions/context

---

Sukihome page
Documentation
APIs
Release Notes
Sukihome page

- API Overview


##### API References

- Authentication
- Ambient Session Management POST Create Ambient Session POST Seed Ambient Session Context PATCH Update Session Context POST Session Metadata DEPRECATED GET Audio Streaming WS POST End Ambient Session
- Dictation
- Ambient Content Retrieval
- User Preferences
- User Feedback
- Send Notifications
- Info

POST
/
api
/
v1
/
ambient
/
session
/
{ambient_session_id}
/
context
Seeds context for the ambient session.

```
curl --request POST \
  --url https://sdp.suki-stage.com/api/v1/ambient/session/{ambient_session_id}/context \
  --header 'Content-Type: application/json' \
  --header 'sdp_suki_token: <sdp_suki_token>' \
  --data @- <<EOF
{
  "diagnoses": {
    "values": [
      {
        "codes": [
          {
            "code": "30422",
            "description": "Essential hypertension",
            "type": "IMO"
          }
        ],
        "diagnosis_note": "Hypertension"
      }
    ]
  },
  "patient": {
    "dob": "2000-01-01",
    "sex": "male"
  },
  "provider": {
    "provider_role": "ATTENDING",
    "specialty": "CARDIOLOGY"
  },
  "sections": [
    {
      "loinc": "10164-2"
    }
  ],
  "visit": {
    "chief_complaint": "Headache (Patient's primary symptom or problem stated in their own words)",
    "encounter_type": "AMBULATORY",
    "reason_for_visit": "Follow-up for migraines",
    "visit_type": "ESTABLISHED_PATIENT"
  }
}
EOF
```


```
This response has no body data.
```

Use this endpoint to provide or update the
for an
. Providing detailed context helps Suki generate a more accurate and relevant
.
For example, you can provide:
- Provider details (e.g., specialty and role).
- Patient and visit information.
- A list of LOINC codes for the clinical sections you want to generate.
- Existing diagnoses with their associated medical codes.
For more information about the context, refer to the PBC and Specialty section.

You can use the
`Codes`
section to provide additional context for a session, such as
**medical codes**
for a
**diagnosis**
.
The
`type`
field in the
`Codes`
section can have one of the following values:
- ICD10 (Recommended)
- IMO

To avoid request failures, you must ensure the data you send adheres to the following validation rules:
- The chief_complaint and reason_for_visit fields must not exceed 255 characters .
- The visit_type , encounter_type , and provider_role fields function as enums and only accept a specific set of predefined string values. You must use one of the allowed values for these fields, as any other string will cause the request to fail.


## ​Code examples

- Python
- TypeScript


```
import requests

ambient_session_id = "123dfg-456dfg-789dfg-012dfg"
url = f"https://sdp.suki.ai/api/v1/ambient/session/{ambient_session_id}/context"

headers = {
    "sdp_suki_token": "<sdp_suki_token>",
    "Content-Type": "application/json"
}

payload = {
    "provider": {
        "specialty": "CARDIOLOGY",
        "provider_role": "ATTENDING"
    },
    "patient": {
        "dob": "2000-01-01",
        "sex": "male"
    },
    "visit": {
        "chief_complaint": "Headache",
        "encounter_type": "AMBULATORY",
        "reason_for_visit": "Follow-up for migraines",
        "visit_type": "ESTABLISHED_PATIENT"
    },
    "sections": [
        {"loinc": "10164-2"},
        {"loinc": "48765-2"}
    ],
    "diagnoses": {
        "values": [
            {
                "codes": [
                    {
                        "code": "30422",
                        "description": "Essential hypertension",
                        "type": "ICD10"
                    }
                ],
                "diagnosis_note": "Hypertension"
            }
        ]
    }
}

response = requests.post(url, json=payload, headers=headers)

if response.status_code == 200:
    print("Context seeded successfully")
else:
    print(f"Failed to seed context: {response.status_code}")
    print(response.json())
```


```
const ambientSessionId = '123dfg-456dfg-789dfg-012dfg';
const response = await fetch(
  `https://sdp.suki.ai/api/v1/ambient/session/${ambientSessionId}/context`,
  {
    method: 'POST',
    headers: {
      'sdp_suki_token': '<sdp_suki_token>',
      'Content-Type': 'application/json'
    },
    body: JSON.stringify({
      provider: {
        specialty: 'CARDIOLOGY',
        provider_role: 'ATTENDING'
      },
      patient: {
        dob: '2000-01-01',
        sex: 'male'
      },
      visit: {
        chief_complaint: 'Headache',
        encounter_type: 'AMBULATORY',
        reason_for_visit: 'Follow-up for migraines',
        visit_type: 'ESTABLISHED_PATIENT'
      },
      sections: [
        { loinc: '10164-2' },
        { loinc: '48765-2' }
      ],
      diagnoses: {
        values: [
          {
            codes: [
              {
                code: '30422',
                description: 'Essential hypertension',
                type: 'ICD10'
              }
            ],
            diagnosis_note: 'Hypertension'
          }
        ]
      }
    })
  }
);

if (response.ok) {
  console.log('Context seeded successfully');
} else {
  const error = await response.json();
  console.error(`Failed to seed context: ${response.status}`, error);
}
```


#### Headers

​
sdp_suki_token
string
required

sdp_suki_token


#### Path Parameters

​
ambient_session_id
string
required

ambient_session_id


#### Body

application/json

Context

​
diagnoses
object

Optional - Information about the diagnoses

​
patient
object

Optional - Information about the patient

​
provider
object

Optional - Information about the provider

​
sections
object[]

Optional - Information about the sections to be generated.
If not provided, all supported note-sections will be generated.

​
visit
object

Optional - Information about the visit


#### Response

Last modified on
April 1, 2026
Create Ambient SessionPrevious
Update Session ContextNext
⌘
I
Seeds context for the ambient session.

```
curl --request POST \
  --url https://sdp.suki-stage.com/api/v1/ambient/session/{ambient_session_id}/context \
  --header 'Content-Type: application/json' \
  --header 'sdp_suki_token: <sdp_suki_token>' \
  --data @- <<EOF
{
  "diagnoses": {
    "values": [
      {
        "codes": [
          {
            "code": "30422",
            "description": "Essential hypertension",
            "type": "IMO"
          }
        ],
        "diagnosis_note": "Hypertension"
      }
    ]
  },
  "patient": {
    "dob": "2000-01-01",
    "sex": "male"
  },
  "provider": {
    "provider_role": "ATTENDING",
    "specialty": "CARDIOLOGY"
  },
  "sections": [
    {
      "loinc": "10164-2"
    }
  ],
  "visit": {
    "chief_complaint": "Headache (Patient's primary symptom or problem stated in their own words)",
    "encounter_type": "AMBULATORY",
    "reason_for_visit": "Follow-up for migraines",
    "visit_type": "ESTABLISHED_PATIENT"
  }
}
EOF
```


```
This response has no body data.
```

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
