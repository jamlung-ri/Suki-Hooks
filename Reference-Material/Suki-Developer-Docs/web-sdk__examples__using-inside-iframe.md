# Use Suki SDK Inside an Iframe - Suki

**Source URL:** https://developer.suki.ai/web-sdk/examples/using-inside-iframe

---

Sukihome page
Documentation
APIs
Release Notes
Sukihome page


##### Web SDK Overview

- Introduction
- Quickstart
- Prerequisites
- Installation
- Migration to v2 v2
- Changelog


##### Web SDK Guides

- Ambient Session
- Note Management
- Error Handling
- Token Refresh
- Telehealth
- Branding


##### API Reference

- Types
- Classes
- Functions
- Hooks
- Providers
- Components


##### Examples

- Basic Usage
- Control Visibility
- Dynamic Encounter
- Ambient Events
- Test Mode
- Using the SDK Inside an Iframe
- Advanced Configuration
- Theming and Customization


##### FAQs

- Automatic User Onboarding
- General
- Technical
- Implementation


## ​Overview

Embed the Suki Assistant in your web application by using an iframe. For the SDK to function correctly, grant the iframe specific permissions to access the microphone and clipboard.

### ​Granting required permissions

- Microphone access is required for ambient note capture and dictation.
- Clipboard access is required for the copy-to-clipboard functionality in note sections.

To enable these features, add the
`allow`
attribute to your
`<iframe>`
element with the necessary permission values.
Modern browsers restrict access to sensitive APIs like the microphone from within an iframe for security reasons. If you do not explicitly grant permission, core SDK features will fail.

```
<iframe
  src="https://your-app-url.com"
  allow="microphone; clipboard-write; clipboard-read"
>
  <!-- Your application with the Suki SDK is rendered here -->
</iframe>
```


## ​Next steps

Read the
Advanced configuration
example to learn how to configure the Suki SDK.
Last modified on
April 1, 2026
Test ModePrevious
Advanced ConfigurationNext
⌘
I
- Overview
- Granting required permissions
- Next steps

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
