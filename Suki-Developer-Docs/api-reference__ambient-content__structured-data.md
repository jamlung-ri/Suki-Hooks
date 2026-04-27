# Get Structured Data - Suki

**Source URL:** https://developer.suki.ai/api-reference/ambient-content/structured-data

---

Sukihome page
Documentation
APIs
Release Notes
Sukihome page

- API Overview


##### API References

- Authentication
- Ambient Session Management
- Dictation
- Ambient Content Retrieval GET Get Session Status GET Get Session Transcript GET Get Session Recording NEW GET Get Session Content GET Get Encounter Content GET Get Structured Data GET Get Encounter Structured Data
- User Preferences
- User Feedback
- Send Notifications
- Info

GET
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
structured-data
Gets the structured data for the ambient session.

```
curl --request GET \
  --url https://sdp.suki-stage.com/api/v1/ambient/session/{ambient_session_id}/structured-data \
  --header 'sdp_suki_token: <sdp_suki_token>'
```


```
{
  "structured_data": {
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
          "diagnosis_note": "The management of essential hypertension remains unchanged from previous plans, as it was not the focus of today's visit.",
          "laterality_indicator": 4,
          "post_coord_lex_flag": 1
        }
      ]
    }
  }
}
```

Use this endpoint to get the cumulative
associated with the specified
.

## ​Code examples

- Python
- TypeScript


```
import requests

ambient_session_id = "123dfg-456dfg-789dfg-012dfg"
url = f"https://sdp.suki.ai/api/v1/ambient/session/{ambient_session_id}/structured-data"

headers = {
    "sdp_suki_token": "<sdp_suki_token>"
}

response = requests.get(url, headers=headers)

if response.status_code == 200:
    structured_data = response.json()
    print("Structured Data:")
    if "structured_data" in structured_data:
        diagnoses = structured_data["structured_data"].get("diagnoses", {})
        if "values" in diagnoses:
            for diagnosis in diagnoses["values"]:
                print(f"Diagnosis Note: {diagnosis.get('diagnosis_note')}")
                
                # Additional diagnosis fields
                if diagnosis.get('laterality_indicator') is not None:
                    print(f"Laterality Indicator: {diagnosis.get('laterality_indicator')}")
                if diagnosis.get('post_coord_lex_flag') is not None:
                    print(f"Post-coordination Lexical Flag: {diagnosis.get('post_coord_lex_flag')}")
                
                # Diagnosis codes
                for code in diagnosis.get("codes", []):
                    print(f"  Code: {code.get('code')}")
                    print(f"    Description: {code.get('description')}")
                    print(f"    Type: {code.get('type')}")
                print("---")
else:
    print(f"Failed to get structured data: {response.status_code}")
    print(response.json())
```


```
const ambientSessionId = '123dfg-456dfg-789dfg-012dfg';
const response = await fetch(
  `https://sdp.suki.ai/api/v1/ambient/session/${ambientSessionId}/structured-data`,
  {
    headers: {
      'sdp_suki_token': '<sdp_suki_token>'
    }
  }
);

if (response.ok) {
  const structuredData = await response.json();
  console.log('Structured Data:');
  if (structuredData.structured_data) {
    const diagnoses = structuredData.structured_data.diagnoses || {};
    if (diagnoses.values) {
      diagnoses.values.forEach((diagnosis: any) => {
        console.log(`Diagnosis Note: ${diagnosis.diagnosis_note}`);
        
        // Additional diagnosis fields
        if (diagnosis.laterality_indicator !== undefined && diagnosis.laterality_indicator !== null) {
          console.log(`Laterality Indicator: ${diagnosis.laterality_indicator}`);
        }
        if (diagnosis.post_coord_lex_flag !== undefined && diagnosis.post_coord_lex_flag !== null) {
          console.log(`Post-coordination Lexical Flag: ${diagnosis.post_coord_lex_flag}`);
        }
        
        // Diagnosis codes
        diagnosis.codes?.forEach((code: any) => {
          console.log(`  Code: ${code.code}`);
          console.log(`    Description: ${code.description}`);
          console.log(`    Type: ${code.type}`);
        });
        console.log('---');
      });
    }
  }
} else {
  const error = await response.json();
  console.error(`Failed to get structured data: ${response.status}`, error);
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


#### Response


Success Response


Response body for the /session/{ambient_session_id}/structured-data endpoint

​
structured_data
object
Last modified on
March 23, 2026
Get Encounter ContentPrevious
Get Encounter Structured DataNext
⌘
I
Gets the structured data for the ambient session.

```
curl --request GET \
  --url https://sdp.suki-stage.com/api/v1/ambient/session/{ambient_session_id}/structured-data \
  --header 'sdp_suki_token: <sdp_suki_token>'
```


```
{
  "structured_data": {
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
          "diagnosis_note": "The management of essential hypertension remains unchanged from previous plans, as it was not the focus of today's visit.",
          "laterality_indicator": 4,
          "post_coord_lex_flag": 1
        }
      ]
    }
  }
}
```

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
