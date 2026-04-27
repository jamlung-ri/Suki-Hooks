# Master List of Questions for Suki

> **💬 Comment — Joseph Amlung** *(2026-01-23)*
> My initial review and attempt at answering questions was supported by a Gemini Deep Research query. The results of that are saved here: https://docs.google.com/document/d/1jFFpCFrzXvdFEtY6bR8qAE3tFrBNLVssmEopN4c1Kxs/edit?usp=sharing

---

## 1. DATA LIFECYCLE & ARTIFACT MANAGEMENT

**Focus:** Understanding data capture, processing, retention, and institutional custody requirements.

---

**1. Artifact Creation Scope:** Can clinicians create audio/transcript artifacts outside formal clinical encounters, and can they generate multiple artifacts per patient?

Yes to both. - VERIFIED

> **💬 Comment — Joseph Amlung** *(2026-01-23)*
> This seems to be answered here: https://www.suki.ai/clinicians/
> This page contains multiple functional descriptions that are outside of the clinical encounter e.g. Patient Summaries and Multilingual patient instructions

> **💬 Comment — Joseph Amlung** *(2026-01-23)*
> "Suki for Nurses" also seems to highlight versatility and doing things on the fly.

---

**2. Patient Identification:** What identifiers bind audio/transcript artifacts to patients — are these generated internally by Suki or sourced from the EHR?

Detailed description in the AI analysis... in short, there's no unique patient ID, only encounters, and there can be 1 to many artifacts per encounter... each encounter leverages patient identifiers from source EHRs or internal identifiers linked to the encounter. Able to search via a patient identifier to get all encounters and get the raw data and audio within the first 30 days. Obviously integrated vs non-integrated would be different also.

FOLLOW UP QUESTION: What percentage of customers integrate?

> **💬 Comment — Joseph Amlung** *(2026-01-23)*
> This code indicates that Suki gets informed by encounter details from the EHR:
> ```javascript
> // replace this with your actual encounter data
> const encounterDetails = {
>   identifier: "6ec3920f-b0b1-499d-a4e9-889bf788e5ab",
>   patient: {
>     identifier: "905c2521-25eb-4324-9978-724636df3436",
>     name: {
>       use: "official",
>       family: "Doe",
>       given: ["John"],
>       suffix: ["MD"],
>     },
>     birthDate: "1990-01-01",
>     gender: "Male",
>   },
> };
> ```
> Source: https://developer.suki.ai/web-sdk/quickstart#mount-the-sdk-ui

---

**3. Data Pipeline & Fidelity Loss:** Walk us through the complete pipeline (raw audio → transcript → note). At what points can information fidelity be lost, particularly when verbosity settings are applied?

16-bit 16khz mono audio, captured in 100ms chunks ---> full raw transcript -clinical knowledge graph-> summary note. Knowledge graphing team member to share end to end. DeID and ReID both occur and then integration w/ EHR data. Query previous Suki notes plus EHR data for new encounter.

> **💬 Comment — Jamie Thomas** *(2026-01-30)*
> Chetan shared a visual of Suki's Quality Infrastructure during the 1/30/26 team call ~20 min in.

---

**4. Retention Policy Details:** Confirm what is retained for 30 days (audio only, or audio + transcript?), and what specific regulatory or contractual requirements drive this policy? After the 30-day deletion period, what artifacts (if any) remain on your platform for a given encounter? Summaries, coding suggestions, etc.

Again, detailed answer on the AI analysis:

- Permanent deletion of audio and transcript 30 days following encounter date
- The above are deleted for medico-legal reasons
- Clinical note persisted for contract length

> **💬 Comment — Joseph Amlung** *(2026-01-23)*
> Suki retains and deletes your data according to the following schedule:
> - **Audio Input:** The original audio recording is permanently deleted after 30 days.
> - **Transcript:** The transcript generated from the audio is permanently deleted after 30 days.
> - **Clinical Note:** The final clinical note is retained for the duration of your service contract.
>
> Source: https://developer.suki.ai/documentation/faqs/security#how-long-will-you-maintain-the-data-related-to-ambient-session-id

---

**5. Academic Medical Center Data Custody:** For institutions wanting to retain raw artifacts for research, can Suki transfer custody of audio/transcript files to the institution rather than deleting them? In what format would these be provided?

Yes, provided it's within the 30-day window, audio and raw transcript available via API calls.

Suki legal team may have more information. Suki deletes everything after 30 days.

> **💬 Comment — Joseph Amlung** *(2026-01-23)*
> AI suggests: "While Suki's default is deletion, the platform's API architecture allows institutions to retrieve the `final_transcript` and associated metadata via GET requests before the 30-day window expires. This effectively allows an institution to transfer custody of the artifacts to their own internal data lakes for research purposes, provided they have established the necessary internal governance and patient consent protocols."
>
> AI citation: https://developer.suki.ai/documentation/getting-started

---

## 2. DATA INGESTION, STORAGE & PROCESSING

**Focus:** Understanding what Suki extracts from EHRs, what gets stored long-term, and shadow EHR risk.

---

**6. EHR Data Extraction:** When reading from source EHRs (for context or pre-visit summaries), what specific data elements do you extract and how much is persistently stored versus temporarily cached?

Configurable by partner, but typically include:

- Demographics
- Active problem lists, and other high level clinical history
- Meds and lab results
- Vital signs

Only stored inside temporary cache for the specific session to drive the Clinical Knowledge Graph.

Patient summary or QA side could best answer on what FHIR resources are being pulled in. Visit summaries are pulled overnight if patient scheduled for the next day, and refreshed up to 15 minutes before visit. Ask integration team about format.

> **💬 Comment — Joseph Amlung** *(2026-01-23)*
> While the exact list of extracted elements is configurable by the partner, the primary data points typically include:
> - Patient Demographics (Name, Age, Sex) for identification.
> - Clinical History, including active problem lists and past surgical history.
> - Current Medications and recent lab results (e.g., A1c values) for clinical reasoning.
> - Vital Signs (BP, Heart Rate, Temp) to populate objective sections of the note.
>
> The online documentation suggests that temporary caching is the primary approach, apart from the 30-day artifacts, but I do think that asking the question about persistent storage in any form would be good.

---

**7. Secondary Outputs & Storage:** Beyond clinical notes, what other outputs does Suki generate (quality metrics, registry reports, coding suggestions)? Where are these stored, and are they universally generated or enabled per-customer? What are the exact coded outputs?

- Automated coding suggestions (CPT, E/M, etc.)
- Patient instructions?
- Order Staging
- Quality Driver Metrics

Stored inside Suki platform and exported to EHR based upon configuration.

Suki creates patient instructions and with certain patients creates coding suggestions.

> **💬 Comment — Jamie Thomas** *(2026-01-30)*
> Sudha mentioned this because different because not integrated. Do we care? What percentage of customers integrate?

---

**8. Customer Data Control:** If a customer declines specific outputs or doesn't want data stored long-term, can processing occur in real-time only without persistence on your platform?

Yes. SKIPPED

---

**9. Shadow EHR Risk Mitigation:** Given persisted identifiers, ingested EHR data, and generated outputs, what safeguards prevent Suki from inadvertently operating as a "shadow EHR" with duplicative longitudinal patient records?

Integration without duplication is the core philosophy. SKIPPED

> **💬 Comment — Joseph Amlung** *(2026-01-23)*
> Suki's position seems to be the following (per AI): "Integration without Duplication: By utilizing bi-directional integrations (Epic Haiku, Haiku, or web-optimized tablets), Suki pushes data back into the EHR as first-class clinical documents rather than keeping it isolated in a proprietary silo."

---

**10. Data Format & Structure:** In what format and structure is ingested EHR data stored? Is it normalized to a standard data model or preserved in EHR-specific formats?

Evidence of use of LOINC, ICD, and CPT online... but what input formats are accepted from EHRs? SKIPPED

---

## 3. PLATFORM CAPABILITIES & ROADMAP

**Focus:** Current feature status and development priorities for advanced capabilities.

---

**11. Real-Time Clinical Decision Support:** What is the current status and deployment timeline for "real-time nudges" (e.g., prompting questions during encounters to achieve higher E&M coding levels or clinical decision support)?

Revenue cycle capabilities for determining level of service following encounter.

In-encounter reminders/nudges are in beta?

> **💬 Comment — Joseph Amlung** *(2026-01-23)*
> Seems to be in pilot/beta phase, based on its UpToDate integration: https://www.wolterskluwer.com/en/news/wolters-kluwer-and-suki-to-integrate-uptodates-trusted-physicianauthored-content-into-suki-assistant

---

**12. Pre-Visit EHR Summarization:** What is the status of the "pre-patient summary" capability? Is it in production, beta testing, or still notional? Is it automated or query-based?

This is in production?

> **💬 Comment — Joseph Amlung** *(2026-01-23)*
> "Patient summaries are now available on athenahealth. In the coming months, we will be rolling this capability out to additional EHRs, including Epic, Cerner, and MEDITECH, in the coming months."
>
> Source: https://www.suki.ai/blog/sukis-patient-summaries-enhancing-clinical-reasoning-at-point-of-care/

---

**13. Voice-Based Chart Querying:** What is the development status and timeline for natural language querying of patient records (e.g., "What were the last three A1c values?")? Will this cover structured data only, or also unstructured notes?

This is in advanced development, but not deployed?

> **💬 Comment — Joseph Amlung** *(2026-01-23)*
> Seems like there are multiple answers to this. Structured Data Querying is further along (Production/Early Access) than Unstructured Note Querying and Clinical Q&A.

---

## 4. EHR INTEGRATION & INTEROPERABILITY

**Focus:** Integration breadth, depth, and technical approach.

---

**14. Integration Landscape:** Which EHR systems do you have production integrations with, and what specific capabilities does each enable (read demographics, read history, write notes, write codes)? Which EHR serves as your primary innovation/testing environment?

- Athenahealth is production and native
- Epic is via Deep API and Haiku (Epic's mobile access app)
- Oracle / Cerner via CommunityWorks
- MEDITECH via direct integration inside Expanse (their web-based EHR)

> **💬 Comment — Joseph Amlung** *(2026-01-23)*
> See here: https://www.suki.ai/ehr-integrations/
> Includes Epic, Athena, Oracle Health, and Meditech.

---

**15. Integration Standards:** Are your EHR integrations built on open standards (FHIR, HL7) or proprietary APIs? For new EHR integrations, what is the typical timeline and effort required?

FHIR / HL7 import and export?

- Athena integration is within a week
- Epic / Cerner / MEDITECH is 8–12 weeks

> **💬 Comment — Joseph Amlung** *(2026-01-23)*
> Seems to use FHIR? Worth asking though, I think. "Suki AI: A voice-powered clinical assistant that uses FHIR to retrieve and document patient data."
>
> Source: https://medium.com/@Ramkyiyer/conversational-ai-meets-ehr-the-fhir-advantage-1d954d408e86

---

## 5. COMPETITIVE POSITIONING & RISK MANAGEMENT

**Focus:** Strategic differentiation and compliance safeguards.

---

**16. Competitive Positioning vs. EHR-Native Solutions:** With major EHRs like Epic building in-house ambient AI, how do you position Suki — as a direct competitor with superior technology, a complementary "bolt-on" offering better UX and interoperability, or targeting different market segments?

- Complementary not competitive
- Cross-EHR consistency
- Mobile first
- Clinical rigor

---

**17. Unique Value Proposition:** Where do you see Suki's most defensible unique value — what capabilities can you provide that EHR-native solutions fundamentally cannot or will not pursue?

> **💬 Comment — Joseph Amlung** *(2026-01-23)*
> AI says: "Key defensive differentiators include:
> - **Cross-EHR Consistency:** Large health systems often use multiple EHRs across different service lines. Suki provides a unified interface and 'clinical voice' for the clinician regardless of the underlying EHR.
> - **Mobile-First Design:** Suki is highly optimized for clinicians who move between rooms and sites, providing a superior UX on mobile devices (iOS/Android) compared to many tethered or desktop-heavy native solutions.
> - **Techno-Clinical Integrity:** Suki emphasizes its clinical rigor, utilizing a network of clinicians to generate 'gold notes' that serve as the standard for model training, ensuring that the AI understands specialty-specific nuances (e.g., psychiatry vs. orthopedics)."

---

**18. Compliance & Risk Management:** How do you address two key compliance risks:

**a. Up-coding audit risk:** What safeguards prevent coding suggestions from triggering payer audits?

Suggestions are supported with rationale... "evidence-based links."

> **💬 Comment — Joseph Amlung** *(2026-01-23)*
> AI says: "Suki's 'evidence-based linking' ensures that every code is tied to the visit narrative, creating a compliant audit trail that helps justify the medical necessity to payers. While Suki provides code suggestions with rationales (e.g., for E/M codes), the clinician is ultimately responsible for reviewing, editing, and accepting the documentation before it is finalized in the EHR."

**b. Legal liability risk:** How do you manage the legal risk of retaining clinical data that could contradict finalized documentation?

30-day deletion policy lol

---

## Appendix: Transcript-Derived Questions

> Below: Transcript evaluations done via AI to help generate questions

**Prompt Used:**
> I have provided you with a transcription. Your task is to extract:
>
> 1. **All explicit questions** — any sentences that clearly end with or function as a direct question.
> 2. **All implicit questions** — statements that imply a question, request, or inquiry even if not phrased as a question (e.g., "I wonder if...", "We need to know why...", "It would help to understand...").
>
> For each question:
> - Rewrite it in a clear, standalone form.
> - Label it as either **Explicit** or **Implicit**.
> - Keep the original meaning intact.
> - Present the final output as a bullet-point list.
>
> Do not summarize or answer the questions — only extract them.
>
> THEN... Pull only the questions directed to the vendor
> THEN... Group these questions into themes for vendor distribution

---

### Copilot Results

Below are the questions grouped into logical categories that align with how a technical vendor like Suki would likely route them internally (engineering, product, compliance, integrations, etc.).

---

#### 🟦 1. Data Capture & Artifact Management

**Focus:** What Suki captures, stores, transforms, and deletes — and under what constraints.

- Do you only capture the audio and transcript during a clinical encounter, or can clinicians create additional recordings for a patient outside encounters?
- Can clinicians generate more than one audio/transcript artifact per patient, and can these be created independently of a visit?
- What identifiers are used to bind audio/transcript artifacts to patients, and how are those IDs sourced or generated?
- Do you persist both the audio and the transcript for 30 days, or only the audio?
- Is the transcript ever permanently retained, and at what point does content loss occur if verbosity-controlled notes replace full transcripts?
- Can you clarify the complete audio → transcript → note pipeline so we understand where fidelity may be lost?

---

#### 🟩 2. Real-Time Functionality & Workflow Support

**Focus:** Maturity of real-time features and how they affect clinical workflow.

- Are you currently supporting real-time clinical decision support or nudges, and if not, what is the planned timeline?
- What is the development status of pre-visit EHR summarization?
- Is the pre-visit summary generated automatically, or does it require an explicit query?

---

#### 🟧 3. EHR Integrations & Technology Partnerships

**Focus:** Breadth and depth of interoperability.

- Which EHR systems are you fully integrated with today beyond Athena?
- Which systems function as your primary innovation/testing environments (e.g., Athena)?
- What is your roadmap for expanding integrations with major EHRs such as Epic?

---

#### 🟨 4. Data Ingestion, EHR Use, and Storage Boundaries

**Focus:** How Suki handles data it ingests from the EHR and what persists.

- What data do you retain from EHR ingestion, and what persists on your system?
- Do you store generated outputs such as summaries, registry flags, coding suggestions, or are those computed and discarded?
- Where are processed artifacts stored, and under what conditions are they deleted or retained?
- Are you persisting enough structured or unstructured data that a shadow EHR could unintentionally emerge within your platform?

---

#### 🟥 5. Compliance, Regulatory Boundaries & Risk Mitigation

**Focus:** Contractual, regulatory, and legal constraints on data handling.

- What regulatory or contractual requirements determine the 30-day limit for audio artifact retention?
- How do you mitigate legal risk associated with retaining transcripts, audio, or derived artifacts?

---

#### 🟪 6. Ambient AI Functionality & Product Direction

**Focus:** Advanced capabilities and the broader product vision.

- What is the status of the voice-based chart-querying function (e.g., asking for lab trends or clinical histories)?
- Which components of your roadmap are internal prototypes versus customer-ready features?
- How do you envision expanding beyond note-generation toward more comprehensive clinical cognition support?

---

#### 🟫 7. Competitive Landscape & Differentiation

**Focus:** Positioning against Epic, Optum, and other ambient AI vendors.

- How do you differentiate Suki from EHR-native ambient AI solutions, particularly Epic's growing ecosystem?
- Where do you see opportunities for unique value that competitors may not pursue?

---

#### ⚪ 8. Engagement Logistics & Research Support

**Focus:** What Suki needs to ensure the right people and information are available.

- Are there specific authors, frameworks, or publications you consider foundational to understanding this space?
- What questions should we prioritize so that the appropriate subject-matter experts can attend Friday's meeting?

---

### Gemini Results

#### Theme 1: Technical Roadmap & Product Maturity

- **Explicit:** Where does the "pre-patient summary" capability (reading the EHR in advance to provide a visit summary) currently stand in the development queue?
- **Explicit:** Does the pre-patient summary capability currently exist in production, or is it totally notional at this point?
- **Implicit:** We need to clarify if real-time clinical decision support and "real-time nudges" for clinicians are currently active features or items of future interest.

#### Theme 2: Data Persistence & Lifecycle

- **Implicit:** We need to understand the full data pipeline: does the raw audio and raw transcript persist, or is data lost once a clinician selects a specific verbosity setting for the final note?
- **Implicit:** It is necessary to confirm exactly which artifacts are persisted for 30 days — is it only the raw audio, or does this include the processed transcript as well?
- **Implicit:** We need to understand the point at which a transcript or note becomes final and "unable to be changed."

#### Theme 3: EHR Integration & Interoperability

- **Explicit:** Do the clinical codes used by Suki vary by facility, or does the system use a common, standard set (e.g., ICD, CPT, SNOMED)?
- **Implicit:** We need to determine how Suki binds data to a patient ID — is that ID generated internally by Suki, or is it pulled from a source EHR?
- **Implicit:** It is important to know how Suki plans to maneuver around the "walled garden" competitive threat posed by EHRs like Epic.

#### Theme 4: Data Sovereignty & Storage

- **Implicit:** We need to know what Suki extracts and keeps when ingesting data from an EHR.
- **Implicit:** What is the specific form of the data kept on Suki's side, and what does it look like?
- **Implicit:** If a client company does not want their data stored, does Suki have the ability to bypass the storage process entirely?
- **Implicit:** We need to investigate what identifiers are being persisted and address the risk of Suki essentially running a "shadow EHR" on their platform.

#### Theme 5: Clinical Workflow & Flexibility

- **Explicit:** Does the system only capture audio/transcripts within the context of a clinical encounter, or can a clinician create these artifacts around a patient at any time?
- **Implicit:** We need to understand if a user can link multiple audio/transcript artifacts to a single person independent of a formal clinical encounter.
- **Implicit:** It should be determined if data storage and algorithmic processing are standard for all users or if these functions are only activated for specific customers.
