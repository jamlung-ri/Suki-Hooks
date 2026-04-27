# Suki SDKs executive summary - Suki

**Source URL:** https://developer.suki.ai/documentation/executive-summary

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


Executive summary


# Suki SDKs & APIs


Suki for partners · Enterprise integration


Integrate our Ambient Clinical Intelligence into your healthcare application with our SDKs and APIs in days, not months


## Summary


This executive summary is intended for leaders considering a partnership with Suki. It clearly defines the clinical and business challenges, supports them with real customer outcomes, and shows how Suki’s SDKs and APIs integrate into your product. It also highlights key use cases, the value you can expect, what the partnership includes, and the next steps to get started. Read it in order to understand the full story and how it applies to your organization


Implementation detail (how integration works, what your teams need, critical requirements, and a sample timeline) lives on the Technical execution page for engineering and solutions architects.


## Problem we solve


For clinicians and care teams: Clinicians spend 5-6 hours every day on clinical documentation, time stolen from patient care. This administrative burden fuels provider burnout, reduces patient face-time, delays billing, and drives away the best talent. The system is breaking, and documentation is the bottleneck.


For our partners: Building and maintaining ambient AI in house means constant investment in models, clinical quality, compliance, and infrastructure. Partners should focus on their core product and customers while a dedicated documentation platform stays current, improves the AI, and runs the service at scale.


## Case studies


Real organizations transforming care delivery today.


### Zoom Healthcare Partnership


Zoom recognized that telehealth needs intelligent documentation, not just video calls. By integrating Suki’s AI engine, Zoom delivers a complete virtual care experience that improves both user experience and patient outcomes . This demonstrates how ambient intelligence becomes a competitive differentiator.

[Read Case Study](https://www.suki.ai/news/zoom-and-suki-plan-to-provide-ai-generated-clinical-notes-to-healthcare-institutions/)

### WellSky Integration


WellSky’s Ambient Listening solution is changing the game across behavioral health, long-term acute care, and rehabilitation settings. By streamlining documentation and reducing burnout, they’re helping care teams rediscover why they entered healthcare. The impact extends beyond metrics to clinician satisfaction and patient care quality.

[Read Case Study](https://www.suki.ai/news/wellsky-launches-ai-powered-ambient-listening-for-specialty-care-ehr/)

### athenahealth Partnership


Over 60,000 clinical encounters completed in 3 months , and counting. athenahealth integrated Suki’s ambient technology into their clinical platform. Clinicians report dramatic time savings and quality improvements. What started as a pilot has become a core capability, proving ambient documentation is transformative at scale.

[Read Case Study](https://www.suki.ai/news/suki-and-athenahealth-expand-partnership-with-general-availability-of-ambient-notes-using-sukis-ambient-technology/)

## Solution


The solution: Suki SDKs and platform APIs


Suki is one platform for Ambient capture and structured Clinical notes . Partners choose how to embed it: pre-built browser UI with the Web SDK , custom React with the Headless Web SDK , native iOS with the Mobile SDK , or SDP REST APIs when your backend or a custom client should own orchestration, sessions, and content without our pre-built UI. Technical detail for each path lives in the respective SDK and API documentation .


Clinicians can complete an encounter and leave with a draft note that matches your workflow, often without manual typing. That outcome shows up in partner web apps, native iOS apps (Mobile SDK), or systems you connect over HTTPS, depending on which integration you ship.


The diagram and product example below focus on the Web SDK pre-built experience so executives can visualize ambient listening and note layout in a browser. The same underlying capabilities extend to Headless React, the Mobile SDK on iOS, and API-driven flows.


What this means for partners

- Web, your way: Ship the pre-built UI with @suki-sdk/react or @suki-sdk/js , or own the surface with the Headless Web SDK ( @suki-sdk/platform-react ) and the same ambient and auth patterns in React.
- Native iOS: The Mobile SDK brings ambient documentation into native iOS applications your users already rely on, with patterns aligned to Apple client stacks rather than a generic web wrapper.
- SDP REST APIs: Use OAuth-secured HTTPS to register users, manage ambient sessions, pull transcripts and note content, and integrate with your EHR, data platform, or services when a server-side or custom-client model fits best.
- Faster than building in house: You integrate proven surfaces and contracts instead of standing up models, clinical tuning, compliance scope, and operations for ambient AI from scratch.
- Production-ready at scale: The same clinical quality, specialty coverage, and security posture back Web, Headless, Mobile, and API integrations, with usage across large partner deployments.


## SDKs and SDP REST APIs


Partners integrate through one or more of these surfaces. Each has its own documentation; API contracts for SDP are in the platform API reference .


### Web SDK


Pre-built browser UI: @suki-sdk/react and @suki-sdk/js . Best when you want ambient capture and note UI without building the surface from scratch.

Learn More

### Headless Web SDK


Custom React with platform hooks ( @suki-sdk/platform-react ) when you own the UI and still want browser-based ambient flows.

Learn More

### Mobile SDK


Native iOS for embedded ambient experiences in mobile clinical workflows.

Learn More

### SDP REST APIs


OAuth-secured HTTPS APIs for sessions, notes, ambient content, and related operations when the right fit is server-side orchestration or no embedded Suki UI.

Learn More

## potential use cases


### Clinical and partner workflows


Embed ambient documentation directly into your product so users stay in one workflow. Notes flow into the encounter, chart, or handoff path, formatted for your data model.


### Telehealth platforms


Elevate virtual care beyond video calls. Suki captures every conversation detail during telehealth visits and generates complete documentation automatically. No post-visit documentation marathons.


### Specialty care systems


Every specialty speaks its own language. The SDK adapts to each specialty’s unique requirements, ensuring notes are clinically precise and specialty-appropriate, not generic templates.


### Care management platforms


Empower care coordinators to focus on coordination, not documentation. Every patient interaction gets captured automatically, freeing teams to ensure patients receive the right care at the right time.


## Business benefits

Faster Time-to-Market

Weeks, not months. While competitors spend 6-12 months building AI infrastructure, partner teams integrate production-ready components in 2-4 weeks. That’s 80% less development effort and months of competitive advantage. No AI training. No infrastructure scaling. Just proven components that work from day one.

Cost Savings

When clinicians reclaim 2-3 hours per day from documentation, they see more patients, driving increased revenue. Reduced burnout lowers turnover costs and improves retention. Immediate note completion means faster billing cycles. The ROI compounds across every dimension of the organization.

Competitive Differentiation

In a crowded market, AI-powered documentation isn’t just a feature. It’s a statement. Position the platform as the innovation leader. Attract forward-thinking clinicians. Watch adoption climb as word spreads about a platform that actually makes lives easier. This is future-proofing competitive position.

Improved Quality of Care

When clinicians spend less time documenting and more time with patients, magic happens. Eye contact increases. Empathy deepens. Clinical decision-making improves. Complete, timely notes mean better care continuity. Care teams stay because they feel supported, improving both patient outcomes and organizational stability.

Security & Compliance

HIPAA compliant. SOC 2 Type II certified. End-to-end encryption. Every conversation protected. Every note secure. Suki handles compliance infrastructure, so partners don’t bear the burden. Enterprise-grade security without the complexity.


## What partners get


Partners get one ambient documentation platform with several ways to integrate. Whether you ship pre-built browser UI, custom React, native iOS, or server-side and API-led flows, you receive production-ready SDKs or APIs, shared clinical depth, and documentation matched to the path you choose.


### Web, Headless, Mobile, and APIs


Use the Web SDK ( @suki-sdk/react , @suki-sdk/js ) for ready-made UI, the Headless Web SDK ( @suki-sdk/platform-react ) when you own the browser experience, the Mobile SDK for native iOS, or SDP REST APIs when orchestration, sessions, and content should live in your backend or a custom client.


### Production-Ready SDKs and APIs


Packages and HTTPS APIs built for real clinical workloads and large partner deployments. Same reliability expectations whether you embed UI, use platform hooks, or integrate over OAuth-secured APIs.


### Documentation per surface


Each integration path has its own guides and reference. SDP contracts, endpoints, and auth patterns live in the platform API reference ; SDK behavior and samples live in Web, Headless, and Mobile documentation.


### Specialty optimization


Optimized for 100+ medical specialties across the platform. Cardiology notes look different from behavioral health notes, because they should. Clinical precision applies whichever surface you ship.


### Multilingual support


Supports 80+ languages for conversation capture with automatic English note generation. Patients speak in their native language. Clinicians and care teams receive formatted English documentation, independent of whether the integration is web, mobile, or API-driven.


### UX and branding you control


Customize pre-built Web SDK UI to match your design system, own every screen with Headless or your own client over APIs, or follow native iOS patterns with the Mobile SDK. You decide how much Suki chrome appears in the product.


## Next steps


Transformation starts with a single conversation. Here’s how we work together:

- 1 Schedule a demo See it in action. Watch how Suki SDKs and APIs fit a live clinical workflow. Our team tailors the walkthrough to your organization and systems.
- 2 Technical assessment We’ll map the path. Solutions Engineering reviews your environment and produces a concrete integration plan so you know scope, dependencies, and timeline.
- 3 Pilot program Prove it works. Start with a small group of users, gather feedback, and build proof points before you expand.
- 4 Full deployment Scale with confidence. Roll out broadly with ongoing support so the partnership keeps pace as your product and volume grow.

Technical Execution
[Contact Partnership Team](https://www.suki.ai/suki-partners/)
⌘
I
$
/$
Assistant
Responses are generated using AI and may contain mistakes.

Suggestions
