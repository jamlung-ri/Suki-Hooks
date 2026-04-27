# Mobile SDK Configuration - Suki

**Source URL:** https://developer.suki.ai/mobile-sdk/configuration

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


## ​Overview

To use the Suki
**mobile SDK**
, you must configure it when your application starts. Follow these steps to
**initialize**
the SDK.

## ​Configure the SDK

Follow these steps to configure the mobileSDK:
1

Import the framework

In the Swift file where you will manage the SDK,
**import**
the framework:

```
import SukiAmbientCore
```

2

Set the SDK environment

Set the SDK environment by assigning a value to the
`SukiAmbientCoreManager.shared.environment`
property. The recommended environments are
`.stage`
and
`.prod`
.

```
// Set the SDK environment (recommended: .stage or .prod)
SukiAmbientCoreManager.shared.environment = .stage
```

3

Initialize the SDK

Call the
`initialize`
method to configure the SDK. You should call this method after a user signs in, or in your application delegate’s
`didFinishLaunchingWithOptions`
method if sign-in sessions persist.

```
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    do {
        let partnerInfo: [String: AnyHashable] = [
            SukiAmbientConstant.kPartnerId: "123",
            SukiAmbientConstant.kProviderInfo: [
                SukiAmbientConstant.kOrgId: "provider_org_id",
                SukiAmbientConstant.kName: "Abhishek Rai",
                SukiAmbientConstant.kId: "providerId",
                SukiAmbientConstant.kSpeciality: "FAMILY_MEDICINE"
            ]
        ]
        try SukiAmbientCore.shared.initialize(
            withPartnerInfo: partnerInfo,
            with: true, // Set to true if your app supports background recording
            onCompletion: { result in
                // Handle initialization result
            },
            withSessionDelegate: self,
            withTokenProvider: self
        )
    } catch {
        print(error)
    }
}
```


### ​Initialization parameters

The
`initialize`
method takes the following parameters:
​
partnerInfo
dictionary
A dictionary containing partner and provider details.
These parameters are not actively used in the current version, as the SDK is designed for a single user with one specialty. The method signature may change in a future release.
​
backgroundRecording
boolean
Set this to
`true`
if your app supports background recording. If
`true`
, recording continues when the app is in the background. Otherwise, recording pauses and you must resume it when the app returns to the foreground.
​
onCompletion
completionHandler
A completion handler that is called with the result of the initialization, indicating success or failure.
​
sessionDelegate
delegateObject
An optional delegate object to receive callbacks for recording-level events.
​
tokenProvider
TokenProvider
An object that conforms to the
`tokenProvider`
protocol. Your application (client application) is responsible for providing a valid token when the SDK requests one through this protocol.
The
`tokenProvider`
is used for authenticating the mobile SDK. You must implement this
`tokenProvider`
protocol to get authentication tokens when needed.

## ​Error handling

The
`initialize`
method can throw a
`SukiAmbientCoreError`
. You should use a
**do-catch**
block, as shown in the example above, to handle any potential errors during initialization.

## ​Next steps

After you configure the SDK, proceed to our
Ambient guides
to start using the mobile SDK features.
Last modified on
April 1, 2026
Mobile SDK InstallationPrevious
Mobile SDK ChangelogNext
⌘
I
- Overview
- Configure the SDK
- Initialization parameters
- Error handling
- Next steps

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
