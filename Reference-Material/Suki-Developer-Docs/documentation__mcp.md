# Documentation MCP Integration - Suki

**Source URL:** https://developer.suki.ai/documentation/mcp

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


## ​Overview

The Suki Developer Documentation is available as an
**MCP server**
(Model Context Protocol) that you can connect directly to your AI code editor like (
**Cursor**
,
**VS Code**
) while working on your local development environment.
This connection allows the LLM in your editor to query our documentation and use
**search**
tool to search the Suki knowledge base to quickly find helpful information, code samples, API references, and guides.
For example, if you ask a coding question, the LLM determines that Suki’s API documentation is relevant. It will then search our reference and include the necessary information in the response, without you explicitly having to ask about our documentation.

## ​Key benefits

The MCP integration provides the following benefits:

## Accelerate your development

Use the documentation as an MCP service in your AI code editor to assist your coding and integration tasks.

## Improve your LLM's responses

Retrieve information from the documentation in your AI code editor to improve the accuracy of the responses.

## Reduce the need for manual research

Reduce the need for manual research and documentation lookup.

## Improve your productivity

Improve your productivity as you can focus on the code and let the LLM handle the documentation lookup and response generation.

## Reduce LLM hallucinations

Reduce LLM hallucinations and improve the accuracy of the responses by using the documentation as an MCP service.

## ​How to set up MCP integration

To integrate our developer documentation as an MCP service into your AI code editor, follow the steps for your specific editor. You will use the following URL as the custom connector endpoint:

```
https://developer.suki.ai/mcp
```

You will use this URL to install our MCP server as a custom connector in the following code editors.
- Cursor
- Claude
- Claude Code
- VS Code


Open MCP settings in Cursor

- Use (Command + Shift + P on Mac) or (Ctrl + Shift + P on Windows) to open the command palette.
- Search for Open MCP settings to open the MCP settings.
- Select Add custom MCP . This will open the mcp.json file.
- In mcp.json, configure your server by adding the following JSON object:


```
{
  "servers": [
    {
      "url": "https://developer.suki.ai/mcp"
    }
  ]
}
```


Open MCP settings in Claude Code

- Navigate to the Connectors page in the Claude settings.
- Select Add custom connector .
- Add our MCP server name and URL. For example: Name as: Suki Developer Documentation MCP server . URL as: https://developer.suki.ai/mcp .
- Select Add .
- When using Claude, select the attachments button (the plus icon).
- Select Suki Developer Documentation MCP server .


Run the following command to install our MCP server as a custom connector in Claude Code

Run the following command to install our MCP server as a custom connector using your CLI:

```
claude mcp add --transport http <name> <url>
```

**For example**
:

```
claude mcp add --transport http Suki Developer Documentation MCP server https://developer.suki.ai/mcp
```

This will install our MCP server as a custom connector in Claude Code.

Configure the MCP server in VS Code

- Create a .vscode/mcp.json file in your project root.
- In .vscode/mcp.json , configure your server:


```
{
  "servers": {
    "<your-mcp-server-name>": {
      "type": "http",
      "url": "https://developer.suki.ai/mcp"
    }
  }
}
```

We recommend using the MCP server URL in
**Cursor**
.
Last modified on
March 23, 2026
Notification Webhook for PartnersPrevious
Suki SDKs executive summaryNext
⌘
I
- Overview
- Key benefits
- How to set up MCP integration

$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
