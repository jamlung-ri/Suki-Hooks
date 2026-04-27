# Ambient API Overview - Suki

**Source URL:** https://developer.suki.ai/api-reference/overview

---

Sukihome page
Documentation
APIs
Release Notes
Sukihome page

- API Overview Quickstart User Authentication Security & Best Practices HTTPS Guidelines API Reference Guidelines FAQs Changelog


##### API References

- Authentication
- Ambient Session Management
- Dictation
- Ambient Content Retrieval
- User Preferences
- User Feedback
- Send Notifications
- Info


# Suki Ambient APIs


The Suki Ambient APIs generate clinical notes from real-time conversations between providers and patients. Most operations use standard REST endpoints and return HTTP status codes . For streaming audio, the APIs use WebSocket endpoints for real-time transmission and event notifications.


## Try our APIs

Quickstart
Authentication
[Postman Collection](https://drive.google.com/file/d/18QoB6lyMBqWSdCFF8PHFb2BQh7tA1ZQf/view?usp=sharing)
Login API
Session Context API
Get Transcript API
Webhook
- cURL
- Python
- TypeScript


```
curl -X POST https://sdp.suki.ai/api/v1/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "partner_id": "your-partner-id",
    "partner_token": "your-jwt-token",
    "provider_id": "provider-123"
  }'
```


```
import requests

response = requests.post(
    "https://sdp.suki.ai/api/v1/auth/login",
    json={
        "partner_id": "your-partner-id",
        "partner_token": "your-jwt-token",
        "provider_id": "provider-123",
    },
)
response.raise_for_status()
data = response.json()
print(data.get("suki_token"))
```


```
const res = await fetch("https://sdp.suki.ai/api/v1/auth/login", {
  method: "POST",
  headers: { "Content-Type": "application/json" },
  body: JSON.stringify({
    partner_id: "your-partner-id",
    partner_token: "your-jwt-token",
    provider_id: "provider-123",
  }),
});
const data = await res.json();
console.log(data.suki_token);
```

- cURL
- Python
- TypeScript


```
curl -X POST "https://sdp.suki.ai/api/v1/ambient/session/YOUR_SESSION_ID/context" \
  -H "sdp_suki_token: YOUR_SUKI_TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "provider": {
      "specialty": "CARDIOLOGY",
      "provider_role": "ATTENDING"
    },
    "patient": { "dob": "2000-01-01", "sex": "male" },
    "visit": {
      "chief_complaint": "Headache",
      "encounter_type": "AMBULATORY",
      "reason_for_visit": "Follow-up for migraines",
      "visit_type": "ESTABLISHED_PATIENT"
    },
    "sections": [
      { "loinc": "10164-2" },
      { "loinc": "48765-2" }
    ]
  }'
```


```
import requests

ambient_session_id = "123dfg-456dfg-789dfg-012dfg"
url = f"https://sdp.suki.ai/api/v1/ambient/session/{ambient_session_id}/context"
headers = {
    "sdp_suki_token": "YOUR_SUKI_TOKEN",
    "Content-Type": "application/json",
}
payload = {
    "provider": {"specialty": "CARDIOLOGY", "provider_role": "ATTENDING"},
    "patient": {"dob": "2000-01-01", "sex": "male"},
    "visit": {
        "chief_complaint": "Headache",
        "encounter_type": "AMBULATORY",
        "reason_for_visit": "Follow-up for migraines",
        "visit_type": "ESTABLISHED_PATIENT",
    },
    "sections": [{"loinc": "10164-2"}, {"loinc": "48765-2"}],
}
response = requests.post(url, json=payload, headers=headers)
response.raise_for_status()
print(response.json())
```


```
const ambientSessionId = "123dfg-456dfg-789dfg-012dfg";
const res = await fetch(
  `https://sdp.suki.ai/api/v1/ambient/session/${ambientSessionId}/context`,
  {
    method: "POST",
    headers: {
      sdp_suki_token: "YOUR_SUKI_TOKEN",
      "Content-Type": "application/json",
    },
    body: JSON.stringify({
      provider: { specialty: "CARDIOLOGY", provider_role: "ATTENDING" },
      patient: { dob: "2000-01-01", sex: "male" },
      visit: {
        chief_complaint: "Headache",
        encounter_type: "AMBULATORY",
        reason_for_visit: "Follow-up for migraines",
        visit_type: "ESTABLISHED_PATIENT",
      },
      sections: [{ loinc: "10164-2" }, { loinc: "48765-2" }],
    }),
  }
);
console.log(await res.json());
```

- cURL
- Python
- TypeScript


```
curl -X GET "https://sdp.suki.ai/api/v1/ambient/session/YOUR_SESSION_ID/transcript" \
  -H "sdp_suki_token: YOUR_SUKI_TOKEN"
```


```
import requests

session_id = "YOUR_SESSION_ID"
response = requests.get(
    f"https://sdp.suki.ai/api/v1/ambient/session/{session_id}/transcript",
    headers={"sdp_suki_token": "YOUR_SUKI_TOKEN"},
)
response.raise_for_status()
print(response.json())
```


```
const sessionId = "YOUR_SESSION_ID";
const res = await fetch(
  `https://sdp.suki.ai/api/v1/ambient/session/${sessionId}/transcript`,
  {
    headers: { sdp_suki_token: "YOUR_SUKI_TOKEN" },
  }
);
console.log(await res.json());
```

- cURL
- Python
- TypeScript


```
# Sample payload posted to your HTTPS webhook (test against a local listener)
curl -X POST http://localhost:3000/webhooks/notification \
  -H "Content-Type: application/json" \
  -d '{
    "status": "success",
    "session_id": "123dfg-456dfg-789dfg-012dfg",
    "encounter_id": "visit-abc-001",
    "sessions": [],
    "_links": {
      "contents": [
        {
          "method": "GET",
          "href": "https://sdp.suki.ai/api/v1/ambient/session/123dfg-456dfg-789dfg-012dfg/content",
          "name": "content"
        }
      ]
    }
  }'
```


```
from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route("/webhooks/notification", methods=["POST"])
def handle_suki_webhook():
    data = request.get_json(silent=True) or {}
    if data.get("status") == "success":
        return jsonify({"message": "Notification received"}), 200
    if data.get("status") == "failure":
        return jsonify({"message": "Failure recorded"}), 200
    return jsonify({"error": "Unknown status"}), 400

if __name__ == "__main__":
    app.run(port=3000)
```


```
import express from "express";

const app = express();
app.use(express.json());

app.post("/webhooks/notification", (req, res) => {
  const data = req.body;
  if (!data) {
    return res.status(400).json({ error: "Invalid request" });
  }
  if (data.status === "success") {
    console.log("session_id:", data.session_id);
    return res.status(200).json({ message: "Notification received" });
  }
  if (data.status === "failure") {
    return res.status(200).json({ message: "Failure notification received" });
  }
  return res.status(400).json({ error: "Unknown status" });
});

app.listen(3000, () => {
  console.log("Webhook server listening on port 3000");
});
```


## What you can do with the Suki Ambient APIs


With the Suki Ambient APIs, you can create an ambient session, stream audio for the visit, and when processing finishes retrieve the Clinical note or Transcript . Start with the Create session API and explore the other endpoints to build your own ambient session workflow.


For more advanced features related to note quality and structure, refer to Multilingual support , Personalization , and Problem-Based Charting (PBC) guides. Learn how to use those advanced features while integrating the Suki Ambient APIs into your application.

The Ambient APIs are currently in
**Early Access**
. To request access, contact our
[partnership team](https://www.suki.ai/suki-partners/)
.
Choose Ambient APIs if you want to build your own ambient session workflow with full control over the user experience.

## API versioning


All endpoints use the /api/v1/ prefix. v1 is the stable version; non-breaking changes may ship without a major version bump. Some features are in Early Access and may change. For policies and migration, refer to the API reference guidelines .


## New APIs


Recently added endpoints you can adopt alongside the core Ambient workflow.


### Get Session Recording

New

Use this API to stream or download the original audio from an ambient session.

View Endpoint →

### Create Dictation Session

New

Use this API to initialize a dictation session for real-time audio transcription.

View Endpoint →

### Stream Audio To Dictation Session

New

Use this API to send audio to the dictation service over a WebSocket connection.

View Endpoint →

### End Dictation Session

New

Use this API to complete a dictation session and trigger transcript generation.

View Endpoint →
⌘
I
$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
