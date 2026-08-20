# Session Status & Retrieve Content - Suki

**Source URL:** https://developer.suki.ai/mobile-sdk/ambient-guides/session-status-and-content-retrieval

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

Quick summary
The Mobile SDK provides methods to check processing status and retrieve generated content after a session ends. Check status using
`status(for:)`
, retrieve clinical notes with
`content(for:)`
, get transcripts with
`transcript(for:)`
, and access structured data with
`getStructuredData(for:)`
.


All methods are asynchronous and require a valid
`recordingId`
. Submit user feedback on AI-generated content using
`submitFeedback(_:for:onCompletion:)`
to help improve future note generation.
Last updated:
March 2026

## ​Overview

The Suki Mobile SDK provides methods to check the processing status and retrieve the generated content of a session. Use these methods to track the progress of your session and retrieve the generated content after it has been completed.

### ​What will you learn?

In this guide, you will learn how to:
- Check the processing status of a session using the status(for:) method.
- Retrieve generated content by calling the content(for:) method to get clinical note suggestions.
- Retrieve the full transcript of the conversation using the transcript(for:) method.
- Get structured data , such as generated diagnoses and entities, using the getStructuredData(for:) method.
- Submit user feedback on AI-generated content using the submitFeedback(_:for:onCompletion:) method, including both quantitative and qualitative data.
- Handle asynchronous results using a completion handler for all retrieval methods.
- Understand and adhere to constraints for submitting feedback, including providing feedback only once per entity type per session.

Before calling any of these methods, you must ensure that the mobile SDK is
**initialized**
and that you are using a valid
`recordingId`
from an active or completed session.

## ​Check status and retrieve content

After you end a session, you can asynchronously check its processing status and retrieve the generated content. You must provide a valid
`recordingId`
for the session you want to query.

---

The diagram below illustrates the process of retrieving the generated content of a session.
$!
/$

---

All retrieval methods are
**asynchronous**
. The result is returned in a
, which provides either the requested content or an error.

### ​Check the processing status

Use the
`status(for:)`
method to get the current content generation status of a session.

```
SukiAmbientCore.shared.status(for: recordingId) { result in
    // The completion handler returns a result type.
    switch result {
    case .success(let status):
        // On success, the status object contains the current state.
        print("Session status: \(status)")
    case .failure(let error):
        // On failure, an error object is returned.
        print("Error fetching status: \(error)")
    }
}
```


### ​Get generated suggestions

To retrieve the main clinical note content, call the
`content(for:)`
method.

```
SukiAmbientCore.shared.content(for: recordingId) { result in
    switch result {
    case .success(let suggestions):
        // The suggestions object contains the generated note content.
        print("Generated Suggestions: \(suggestions)")
    case .failure(let error):
        print("Error fetching content: \(error)")
    }
}
```


### ​Get the audio transcript

Retrieve the full transcript of the conversation using the
`transcript(for:)`
method.

```
SukiAmbientCoreManager.shared.transcript(for: recordingId) { result in
    switch result {
    case .success(let response):
        // The response object contains transcript segments.
        // This example joins them into a single string.
        let transcriptText = (response.finalTranscript ?? []).compactMap { $0.transcript }.joined(separator: " ")
        print(transcriptText)
    case .failure(let error):
        print("Error fetching transcript: \(error)")
    }
}
```


### ​Get structured data

Use the
`getStructuredData(for:)`
method to retrieve structured output, such as diagnoses and other entities generated from the session.

```
SukiAmbientCore.shared.getStructuredData(for: recordingId) { result in
    switch result {
    case .success(let structuredData):
        // The structuredData object contains generated entities.
        print("Structured Data: \(structuredData)")
    case .failure(let error):
        print("Error fetching structured data: \(error)")
    }
}
```


### ​Submit user feedback

`New`
Submit user feedback for the AI-generated content.
Use the
`submitFeedback(_:for:onCompletion:)`
to collect and submit user feedback on AI-generated content by using the
`QuantitativeFeedback`
and
`QualitativeFeedback`
structs.
This allows you to capture both quantitative (ratings) and qualitative (comments) feedback. Your feedback helps Suki
**improve**
the quality of its AI-generated content.

#### ​Function signature


```
public func submitFeedback(
    _ submission: FeedbackSubmission,
    for recordingId: RecordingId,
    onCompletion completionHandler: @escaping ((Result<String, Error>) -> Void)
)
public typealias RecordingId = String
```


#### ​Required data structures

Submitting feedback requires you to construct a
`FeedbackSubmission`
object. This object uses the
`FeedbackEntity`
and
`QuantitativeFeedback`
data structures.

```
public struct FeedbackSubmission {
    public let entity: FeedbackEntity
    public let quantitative: QuantitativeFeedback
    public let comments: String?
    
    public init(entity: FeedbackEntity,
                quantitative: QuantitativeFeedback,
                comments: String? = nil)
}

public enum FeedbackEntity: String {
    case content = "content"
}

public struct QuantitativeFeedback {
    public let minRating: Int
    public let maxRating: Int
    public let rating: Int
    
    public init(minRating: Int, maxRating: Int, rating: Int)
}
```


#### ​Implementation example

To submit feedback, you first create the
`FeedbackSubmission`
object and then pass it to the
`submitFeedback`
method along with the
`recordingId`
.
The method is
**asynchronous**
. The completion handler returns a
`Result`
containing either a success message with the unique feedbackId or an error if the submission failed.

```
// 1. Create the quantitative feedback object.
let quantitativeFeedback = QuantitativeFeedback(minRating: 1, maxRating: 5, rating: 4)

// 2. Create the full feedback submission object.
let submission = FeedbackSubmission(
    entity: .content,
    quantitative: quantitativeFeedback,
    comments: "The patient's history was captured accurately."
)

// 3. Call the submit method with the submission object and recording ID.
SukiAmbientCoreManager.shared.submitFeedback(submission, for: recordingId) { result in
    switch result {
    case .success(let feedbackId):
        print("Feedback submitted successfully with ID: \(feedbackId)")
    case .failure(let error):
        print("Error submitting feedback: \(error)")
    }
}
```

- Provide feedback for each entity type once per session only.
- At present feedback submissions are only supported for the .content entity. This may be expanded in the future.
- Submitting feedback for the same entity type a second time in the same session will be considered invalid.


#### ​Rating system

- The maxRating must be greater than the minRating .
- The rating must be within the inclusive range of minRating and maxRating .
- The comments string is optional and has a maximum length of 2000 characters.

- Configure any integer rating scale. For example, create a 1 to 5 scale by setting minRating to 1 and maxRating to 5, or a binary scale by setting the values to 0 and 1.
- Suki recommends using a scale of 1 to 5 for ratings.


## ​FAQs


## ​Next steps

After you have retrieved the content, you can proceed to the
Clear session
guide to create a new session.
Last modified on
April 1, 2026
Recording ControlsPrevious
Clearing SessionsNext
⌘
I
- Overview
- What will you learn?
- Check status and retrieve content
- Check the processing status
- Get generated suggestions
- Get the audio transcript
- Get structured data
- Submit user feedback
- Function signature
- Required data structures
- Implementation example
- Rating system
- FAQs
- Next steps

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
