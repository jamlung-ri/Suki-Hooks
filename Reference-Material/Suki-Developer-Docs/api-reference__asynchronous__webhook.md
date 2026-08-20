# Asynchronous Notifications - Suki

**Source URL:** https://developer.suki.ai/api-reference/asynchronous/webhook

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
- Ambient Content Retrieval
- User Preferences
- User Feedback
- Send Notifications POST Asynchronous Notifications WEBHOOK
- Info

POST
/
webhooks
/
notification
Spec of webhook to be hosted by External Partners.

```
curl --request POST \
  --url https://sdp.suki-stage.com/webhooks/notification \
  --header 'Content-Type: application/json' \
  --data '
{
  "encounter_id": "29de56bc-960a-4cd5-b18f-79a798d62874",
  "error_code": "ERROR_CODE_TRANSCRIPTION",
  "error_detail": "Error in transcription",
  "session_id": "20965414-929a-4f71-a3e5-b92bec07d086",
  "status": "failure"
}
'
```


```
This response has no body data.
```

Use this endpoint specification to implement a
endpoint in your application that receives notifications from the Suki platform.
This endpoint should be hosted by your application to receive notifications about
completion or failure.
Learn more about how webhook work and how to implement your own webhook endpoint to receive them in the
Notification webhook for partners
documentation.

## ​Code examples

- Python
- TypeScript


```
from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route('/webhooks/notification', methods=['POST'])
def handle_webhook():
    """
    Webhook endpoint to receive notifications from Suki platform.
    This endpoint should be hosted by your application.
    """
    # The payload is received in the request body from Suki
    data = request.get_json()  # This is the payload sent by Suki
    
    if not data:
        return jsonify({"error": "Invalid request"}), 400
    
    status = data.get("status")
    
    if status == "success":
        # Handle success notification
        session_id = data.get("session_id")
        encounter_id = data.get("encounter_id")
        sessions = data.get("sessions", [])
        additional_info = data.get("additional_info")
        
        print(f"Session {session_id} completed successfully")
        print(f"Encounter ID: {encounter_id}")
        print(f"Total sessions: {len(sessions)}")
        if additional_info:
            print(f"Additional info: {additional_info}")
        
        # Access links to retrieve content
        if "_links" in data:
            links = data["_links"]
            print("Available links:")
            
            # contents is an array of Link objects
            if "contents" in links:
                print("  Session contents:")
                for link in links["contents"]:
                    print(f"    {link.get('method')} {link.get('href')} - {link.get('name')}")
            
            # encounter_content is an array of Link objects
            if "encounter_content" in links:
                print("  Encounter content:")
                for link in links["encounter_content"]:
                    print(f"    {link.get('method')} {link.get('href')} - {link.get('name')}")
            
            # transcripts is an array of Link objects
            if "transcripts" in links:
                print("  Transcripts:")
                for link in links["transcripts"]:
                    print(f"    {link.get('method')} {link.get('href')} - {link.get('name')}")
            
            # status is an array of Link objects
            if "status" in links:
                print("  Status:")
                for link in links["status"]:
                    print(f"    {link.get('method')} {link.get('href')} - {link.get('name')}")
        
        return jsonify({"message": "Notification received"}), 200
    
    elif status == "failure":
        # Handle failure notification
        session_id = data.get("session_id")
        encounter_id = data.get("encounter_id")
        error_code = data.get("error_code")
        error_detail = data.get("error_detail")
        
        print(f"Session {session_id} failed")
        print(f"Encounter ID: {encounter_id}")
        print(f"Error Code: {error_code}")
        print(f"Error Detail: {error_detail}")
        
        return jsonify({"message": "Failure notification received"}), 200
    
    else:
        return jsonify({"error": "Unknown status"}), 400

if __name__ == '__main__':
    app.run(port=3000)
```


```
import express from 'express';

const app = express();
app.use(express.json());

app.post('/webhooks/notification', (req, res) => {
  /**
   * Webhook endpoint to receive notifications from Suki platform.
   * This endpoint should be hosted by your application.
   */
  // The payload is received in the request body from Suki
  const data = req.body;  // This is the payload sent by Suki
  
  if (!data) {
    return res.status(400).json({ error: 'Invalid request' });
  }
  
  const status = data.status;
  
  if (status === 'success') {
    // Handle success notification
    const sessionId = data.session_id;
    const encounterId = data.encounter_id;
    const sessions = data.sessions || [];
    const additionalInfo = data.additional_info;
    
    console.log(`Session ${sessionId} completed successfully`);
    console.log(`Encounter ID: ${encounterId}`);
    console.log(`Total sessions: ${sessions.length}`);
    if (additionalInfo) {
      console.log(`Additional info:`, additionalInfo);
    }
    
    // Access links to retrieve content
    if (data._links) {
      const links = data._links;
      console.log('Available links:');
      
      // contents is an array of Link objects
      if (links.contents) {
        console.log('  Session contents:');
        links.contents.forEach((link: any) => {
          console.log(`    ${link.method} ${link.href} - ${link.name}`);
        });
      }
      
      // encounter_content is an array of Link objects
      if (links.encounter_content) {
        console.log('  Encounter content:');
        links.encounter_content.forEach((link: any) => {
          console.log(`    ${link.method} ${link.href} - ${link.name}`);
        });
      }
      
      // transcripts is an array of Link objects
      if (links.transcripts) {
        console.log('  Transcripts:');
        links.transcripts.forEach((link: any) => {
          console.log(`    ${link.method} ${link.href} - ${link.name}`);
        });
      }
      
      // status is an array of Link objects
      if (links.status) {
        console.log('  Status:');
        links.status.forEach((link: any) => {
          console.log(`    ${link.method} ${link.href} - ${link.name}`);
        });
      }
    }
    
    return res.status(200).json({ message: 'Notification received' });
  } else if (status === 'failure') {
    // Handle failure notification
    const sessionId = data.session_id;
    const encounterId = data.encounter_id;
    const errorCode = data.error_code;
    const errorDetail = data.error_detail;
    
    console.log(`Session ${sessionId} failed`);
    console.log(`Encounter ID: ${encounterId}`);
    console.log(`Error Code: ${errorCode}`);
    console.log(`Error Detail: ${errorDetail}`);
    
    return res.status(200).json({ message: 'Failure notification received' });
  } else {
    return res.status(400).json({ error: 'Unknown status' });
  }
});

app.listen(3000, () => {
  console.log('Webhook server listening on port 3000');
});
```


#### Body

application/json

FailureNotification

​
encounter_id
string

Id of the encounter to which the payload belongs.

Example
:

"29de56bc-960a-4cd5-b18f-79a798d62874"

​
error_code
string

Error code.

Example
:

"ERROR_CODE_TRANSCRIPTION"

​
error_detail
string

Details of the error, if any.

Example
:

"Error in transcription"

​
session_id
string

Id of the session that failed.

Example
:

"20965414-929a-4f71-a3e5-b92bec07d086"

​
status
string
Example
:

"failure"


#### Response

Last modified on
March 23, 2026
Send Notifications APIPrevious
Info APINext
⌘
I
Spec of webhook to be hosted by External Partners.

```
curl --request POST \
  --url https://sdp.suki-stage.com/webhooks/notification \
  --header 'Content-Type: application/json' \
  --data '
{
  "encounter_id": "29de56bc-960a-4cd5-b18f-79a798d62874",
  "error_code": "ERROR_CODE_TRANSCRIPTION",
  "error_detail": "Error in transcription",
  "session_id": "20965414-929a-4f71-a3e5-b92bec07d086",
  "status": "failure"
}
'
```


```
This response has no body data.
```

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
