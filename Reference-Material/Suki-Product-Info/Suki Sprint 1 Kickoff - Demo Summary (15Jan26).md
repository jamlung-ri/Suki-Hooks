What was demonstrated

The demo focused on outpatient documentation and coding workflows using Suki's ambient listening platform.

**Core functionality includes:**

- Ambient capture of the clinician-patient conversation.
    
- Automated note generation.
    
- ICD-10 and E/M coding suggestions.
    
- Personalization at the clinician level.
    

The demo showcased both mobile and non-integrated workflows, reflecting real-world variation in EHR integration across different customers.

---

Current product scope

While the demo emphasized outpatient documentation, Suki is actively expanding its capabilities into:

- **Outpatient orders:** Including medications, labs, and imaging.
    
- **Inpatient services:** Notes, coding, and orders.
    

The long-term aim is to provide cross-department and cross-setting functionality so that health systems do not need multiple AI tools for different clinical environments.

---

Data artifacts and persistence

Key system outputs identified include:

- Draft and finalized notes.
    
- Coding outputs (E/M levels and ICD-10 suggestions).
    
- Timing metadata related to documentation.
    

Integration depth varies by customer, and some workflows remain partially decoupled from the EHR. Questions remain regarding:

- What audit logs and metadata are persistently stored.
    
- How transcripts and intermediate artifacts are retained.
    
- What data can be accessed for aggregate analysis versus what stays ephemeral.
    

---

Value framing (per Sudha)

Sudha emphasized that value must be evaluated across three distinct levels:

1. **Clinician level:** Focused on efficiency and burnout (the easiest to measure, though heterogeneity is unknown).
    
2. **Patient level:** Focused on satisfaction and impact on vulnerable populations (largely unexplored).
    
3. **Health system level:** Focused on documentation accuracy, coding integrity, and implications for population health and payors.
    

**Key observations:**

- Underdocumentation and undercoding are common baseline problems.
    
- Ambient AI may increase billing per visit, but payor scrutiny is also increasing.
    
- The real value lies in "higher-order effects" once documentation and coding are reliable, such as decision support and system-level efficiency.
    

---

Implications for Sprint 1

- Sprint 1 should focus on what can be credibly measured now using existing Suki data.
    
- The immediate opportunity is aggregate, descriptive evidence (e.g., time, coding patterns) rather than causal claims.
    
- A structured value framework is needed to guide both near-term analysis and longer-term evaluation.