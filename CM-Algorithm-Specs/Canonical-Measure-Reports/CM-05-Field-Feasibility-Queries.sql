-- CM-05 field feasibility / density queries
-- Auto-generated, one query per candidate table. See the companion
-- CM-XX-Field-Feasibility-Queries.md in this directory for how to run
-- and report these back.
--
-- Dialect note: written for SQL Server / SAS PROC SQL syntax
-- (YEAR(col), COUNT(col) excludes NULLs by standard SQL semantics).
-- On Oracle, replace YEAR(<col>) with EXTRACT(YEAR FROM <col>).
-- If any column name collides with a reserved word, quote it per
-- platform ([COL] on SQL Server, "COL" on Oracle).
--
-- For very large tables, consider adding a WHERE clause to sample a
-- recent date range first (e.g. WHERE <anchor> >= '2024-01-01') to get
-- a fast initial read before running the full unfiltered query.

-- ==========================================================
-- Table: ABN_DOCUMENT_ID
-- This table contains information related to a patient's Advance Beneficiary Notice (ABN) documents.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
FROM ABN_DOCUMENT_ID
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: ABN_NOTE_COMMENTS
-- Stores information about the follow-up comments associated with an ABN note.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
FROM ABN_NOTE_COMMENTS
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: BLOCK_NOTE_COPIES
-- Info for note copies to potentially block while blocking parent note.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
FROM BLOCK_NOTE_COPIES
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: CHILD_NOTE_INFO
-- The CHILD_NOTE_INFO table contains information about child notes that are linked to clinical notes. Each row represents one child note and contains information such as the user that created the link, 
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(LINK_UTC) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(LINK_UTC) AS LINK_UTC_filled,
    COUNT(LINK_DTTM) AS LINK_DTTM_filled
FROM CHILD_NOTE_INFO
GROUP BY YEAR(LINK_UTC)
ORDER BY activity_year;

-- ==========================================================
-- Table: CONTACT_POINT_DOCUMENTS
-- This table contains Clinical References linked to patient education points.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
FROM CONTACT_POINT_DOCUMENTS
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: CONTACT_TITLE_DOCUMENTS
-- This table contains Clinical References linked to patient education titles.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
FROM CONTACT_TITLE_DOCUMENTS
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: CONTACT_TOPIC_DOCUMENTS
-- This table contains Clinical References linked to patient education topics.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
FROM CONTACT_TOPIC_DOCUMENTS
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: COVERAGE_NOTE_INFO
-- This table contains information about notes attached to coverage records.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(NOTE_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_DATE) AS NOTE_DATE_filled,
    COUNT(NOTE_DTTM) AS NOTE_DTTM_filled
FROM COVERAGE_NOTE_INFO
GROUP BY YEAR(NOTE_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: CP_NOTE_READING_HX
-- This table stores the history information for the note's care plan reading.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
FROM CP_NOTE_READING_HX
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: DOCS_RCVD_ASMT_PLAN_NOTE
-- This table extracts the related multiple response item DXR-11048.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
FROM DOCS_RCVD_ASMT_PLAN_NOTE
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: DOCS_RCVD_CLN_NOTE_SIGNRS
-- Clinical note signer information for notes recieved externally.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(NOTE_SIGNED_UTC_DTTM) AS NOTE_SIGNED_UTC_DTTM_filled
FROM DOCS_RCVD_CLN_NOTE_SIGNRS
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: DOCS_RCVD_INTVN_NOTE
-- This table extracts the dispense intervention note associated with a particular dispense.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
FROM DOCS_RCVD_INTVN_NOTE
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: DOCS_RCVD_NOTE_SECTIONS
-- Stores note section data received.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
FROM DOCS_RCVD_NOTE_SECTIONS
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: DOCS_RCVD_PCCNOTE
-- This table stores discrete information for patient care coordination notes received from outside sources.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(PCCNOTE_SIGNED_INST_DTTM) AS PCCNOTE_SIGNED_INST_DTTM_filled,
    COUNT(PCC_LST_UPD_INST_DTTM) AS PCC_LST_UPD_INST_DTTM_filled
FROM DOCS_RCVD_PCCNOTE
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: DOCS_RCVD_RSLTS_ADDENDUM
-- This table stores discrete result addendum information received from outside sources.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(RSLT_ADDEND_INS_UTC_DTTM) AS RSLT_ADDEND_INS_UTC_DTTM_filled
FROM DOCS_RCVD_RSLTS_ADDENDUM
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: DOCUMENT_SIG_DATA
-- Contains data about the signatures collected for an electronic signature document.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(SIG_TIMESTAMP_DTTM) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(SIG_TIMESTAMP_DTTM) AS SIG_TIMESTAMP_DTTM_filled
FROM DOCUMENT_SIG_DATA
GROUP BY YEAR(SIG_TIMESTAMP_DTTM)
ORDER BY activity_year;

-- ==========================================================
-- Table: DOCUMENT_STAMPS
-- This table contains information about stamps added to scanned documents.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(STAMP_ADDED_UTC_DTTM) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(STAMP_ADDED_UTC_DTTM) AS STAMP_ADDED_UTC_DTTM_filled
FROM DOCUMENT_STAMPS
GROUP BY YEAR(STAMP_ADDED_UTC_DTTM)
ORDER BY activity_year;

-- ==========================================================
-- Table: DP_COMM_MEMO_NOTE
-- This table contains the Free Text Note(HNO) IDs of communications sent to a service through the Continued Care and Services Coordination workflow, along with the patient CSN, patient ID, and contact d
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
FROM DP_COMM_MEMO_NOTE
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: DP_SVC_COORD_NOTE
-- Coordination notes from the Services to Coordinate section of the current patient encounter--used to leave care coordination notes specific to this patient to a user, or to other users coordinating ca
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
FROM DP_SVC_COORD_NOTE
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: ENC_DX_ASSOC_AMBIENT_DX
-- This table contains the unique IDs of diagnoses provided by Ambient that were finalized to Visit Diagnoses on the encounter.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
FROM ENC_DX_ASSOC_AMBIENT_DX
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: EPRESCRIBE_ERROR_ACTIONS
-- This table holds information about e-prescribing error resolution triggered before the May 23 version. E-prescribing error resolution on or after the upgrade to the May 23 version will be stored to ER
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(RESOLVED_UTC_DTTM) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(RESOLVED_UTC_DTTM) AS RESOLVED_UTC_DTTM_filled
FROM EPRESCRIBE_ERROR_ACTIONS
GROUP BY YEAR(RESOLVED_UTC_DTTM)
ORDER BY activity_year;

-- ==========================================================
-- Table: FIN_ASST_NOTE
-- This table contains information about notes added to financial assistance tracker records.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(ENTRY_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(ENTRY_DATE) AS ENTRY_DATE_filled,
    COUNT(ACCT_NOTE_INSTANT_DTTM) AS ACCT_NOTE_INSTANT_DTTM_filled
FROM FIN_ASST_NOTE
GROUP BY YEAR(ENTRY_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: FLO_INST_COSIGNED
-- This table displays times that cosigners cosigned the flowsheet data.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(INSTANT_COSIGNED_TM) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(INSTANT_COSIGNED_TM) AS INSTANT_COSIGNED_TM_filled
FROM FLO_INST_COSIGNED
GROUP BY YEAR(INSTANT_COSIGNED_TM)
ORDER BY activity_year;

-- ==========================================================
-- Table: HNO_CONSULT_ORD_ID
-- This table contains the unique IDs of the consult orders that are attached to a note.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
FROM HNO_CONSULT_ORD_ID
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: HNO_ECG_DX
-- This table contains the diagnosis for Electrocardiograms (ECG/EKG) that have been stored on General Use Notes (HNO) records.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
FROM HNO_ECG_DX
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: HNO_INFO
-- This table contains common information from General Use Notes items. This table focuses on time-insensitive, once-per-record data while other HNO tables (e.g., NOTES_ACCT, CODING_CLA_NOTES) contain th
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(CREATE_INSTANT_DTTM) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CREATE_INSTANT_DTTM) AS CREATE_INSTANT_DTTM_filled,
    COUNT(DELETE_INSTANT_DTTM) AS DELETE_INSTANT_DTTM_filled,
    COUNT(DATE_OF_SERVIC_DTTM) AS DATE_OF_SERVIC_DTTM_filled,
    COUNT(LST_FILED_INST_DTTM) AS LST_FILED_INST_DTTM_filled,
    COUNT(UPDATE_DATE) AS UPDATE_DATE_filled,
    COUNT(CRT_INST_LOCAL_DTTM) AS CRT_INST_LOCAL_DTTM_filled,
    COUNT(ACTIVE_FROM_DT) AS ACTIVE_FROM_DT_filled,
    COUNT(ACTIVE_TO_DT) AS ACTIVE_TO_DT_filled,
    COUNT(COMMENT_EDIT_INST_DTTM) AS COMMENT_EDIT_INST_DTTM_filled
FROM HNO_INFO
GROUP BY YEAR(CREATE_INSTANT_DTTM)
ORDER BY activity_year;

-- ==========================================================
-- Table: HNO_INFO_2
-- This table contains common information from General Use Notes items. This table focuses on one time only data while other HNO tables (e.g., NOTES_ACCT, CODING_CLA_NOTES) contain the data for different
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(LETTER_FINAL_UTC_DTTM) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(LETTER_FINAL_UTC_DTTM) AS LETTER_FINAL_UTC_DTTM_filled,
    COUNT(NOTE_UPDATE_INST_UTC_DTTM) AS NOTE_UPDATE_INST_UTC_DTTM_filled
FROM HNO_INFO_2
GROUP BY YEAR(LETTER_FINAL_UTC_DTTM)
ORDER BY activity_year;

-- ==========================================================
-- Table: HNO_MYC_LET_INFO
-- This table contains MyChart related information for letters. It includes whether a letter is released to MyChart and the date/time it was released to MyChart.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(LET_REL_MYC_DTTM) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(LET_REL_MYC_DTTM) AS LET_REL_MYC_DTTM_filled
FROM HNO_MYC_LET_INFO
GROUP BY YEAR(LET_REL_MYC_DTTM)
ORDER BY activity_year;

-- ==========================================================
-- Table: HNO_PLACEHOLDER_CHARGE
-- Contains items related to Create Placeholder Charge action.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(CHG_ACTION_UTC_DTTM) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CHG_ACTION_UTC_DTTM) AS CHG_ACTION_UTC_DTTM_filled
FROM HNO_PLACEHOLDER_CHARGE
GROUP BY YEAR(CHG_ACTION_UTC_DTTM)
ORDER BY activity_year;

-- ==========================================================
-- Table: HNO_SMARTFORM_LINK
-- This table contains a list of SmartBlocks and the SmartForms that are linked to those SmartBlocks in a particular note.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
FROM HNO_SMARTFORM_LINK
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: HNO_SOURCE_LOG_ID
-- This table displays the surgical log where a note was edited.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
FROM HNO_SOURCE_LOG_ID
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: HOLOGRAM_DETAILS
-- This table stores workflow-level information about documentation pieces that have been queued up and suspended during an outpatient visit.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(WORKFLOW_INST_UTC_DTTM) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(WORKFLOW_INST_UTC_DTTM) AS WORKFLOW_INST_UTC_DTTM_filled
FROM HOLOGRAM_DETAILS
GROUP BY YEAR(WORKFLOW_INST_UTC_DTTM)
ORDER BY activity_year;

-- ==========================================================
-- Table: HOLOGRAM_SELECTIONS
-- This table stores details about each selection made in a hologram record. Which specific details are stored depends on the type of each row.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(IMMNZTN_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(IMMNZTN_DATE) AS IMMNZTN_DATE_filled,
    COUNT(IMMNZTN_INSTANT_UTC_DTTM) AS IMMNZTN_INSTANT_UTC_DTTM_filled,
    COUNT(IMMNZTN_NEXT_DUE_DATE) AS IMMNZTN_NEXT_DUE_DATE_filled,
    COUNT(IMMNZTN_EXPIRATION_DATE) AS IMMNZTN_EXPIRATION_DATE_filled,
    COUNT(IMMNZTN_VIS_DATE) AS IMMNZTN_VIS_DATE_filled,
    COUNT(LOS_COMPONENT_COUNSEL_TIME) AS LOS_COMPONENT_COUNSEL_TIME_filled,
    COUNT(NT_DISP_INSTANT_UTC_DTTM) AS NT_DISP_INSTANT_UTC_DTTM_filled,
    COUNT(REASON_FOR_VISIT_ONSET_DATE) AS REASON_FOR_VISIT_ONSET_DATE_filled
FROM HOLOGRAM_SELECTIONS
GROUP BY YEAR(IMMNZTN_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: INCOMPLETE_NOTE_EPT
-- Table created for the visit narrative data stored in the patient masterfile. No longer used since we use UCN now since 2010, exporting these items as a formality.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(INC_NOTE_START_DATE_UTC_DTTM) AS INC_NOTE_START_DATE_UTC_DTTM_filled,
    COUNT(INC_NOTE_LAST_EDIT_UTC_DTTM) AS INC_NOTE_LAST_EDIT_UTC_DTTM_filled
FROM INCOMPLETE_NOTE_EPT
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: INTERV_NOTE_INFO
-- This table links a care plan goal note contact to the related intervention note contacts that were filed at the same time.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
FROM INTERV_NOTE_INFO
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: LAB_COSIGN_INFO
-- The LAB_COSIGN_INFO table contains cosign information for lab results.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
FROM LAB_COSIGN_INFO
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: MAR_COSIGN_INST
-- List of instants at which this med administration was cosigned.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(MAR_COSIGN_INSTANT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(MAR_COSIGN_INSTANT) AS MAR_COSIGN_INSTANT_filled
FROM MAR_COSIGN_INST
GROUP BY YEAR(MAR_COSIGN_INSTANT)
ORDER BY activity_year;

-- ==========================================================
-- Table: MED_DISCONTINUE_NOTE
-- This table extracts the multiline discontinue note associated with a medication within a document received.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
FROM MED_DISCONTINUE_NOTE
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: NOTES_ACCT
-- This table contains summary information for billing system account notepad notes attached to accounts.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(NOTE_ENTRY_DTTM) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_ENTRY_DTTM) AS NOTE_ENTRY_DTTM_filled
FROM NOTES_ACCT
GROUP BY YEAR(NOTE_ENTRY_DTTM)
ORDER BY activity_year;

-- ==========================================================
-- Table: NOTES_HISTORY_LOG
-- This table contains the Edit History Information for all Notes (HNO records). Shows information about the type of edit, when the note was edited, and the user who made the edit.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(EDIT_HX_INSTANT) AS EDIT_HX_INSTANT_filled,
    COUNT(EDIT_HX_EXP_DATE) AS EDIT_HX_EXP_DATE_filled
FROM NOTES_HISTORY_LOG
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: NOTES_MC_NMM
-- This table contains the information about notes (HNO) records attached to case (NMM) records.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(NOTE_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_DATE) AS NOTE_DATE_filled,
    COUNT(NOTE_TIME) AS NOTE_TIME_filled
FROM NOTES_MC_NMM
GROUP BY YEAR(NOTE_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: NOTES_TRANS_AUTH
-- This table contains transcription authorization info.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(AUTH_DTTM) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(AUTH_DTTM) AS AUTH_DTTM_filled,
    COUNT(DICTATION_TIME) AS DICTATION_TIME_filled,
    COUNT(TRANSCRIPTION_TIME) AS TRANSCRIPTION_TIME_filled,
    COUNT(ACTIVITY_DTTM) AS ACTIVITY_DTTM_filled,
    COUNT(EDIT_DTTM) AS EDIT_DTTM_filled,
    COUNT(CHR_CNT_DTTM) AS CHR_CNT_DTTM_filled
FROM NOTES_TRANS_AUTH
GROUP BY YEAR(AUTH_DTTM)
ORDER BY activity_year;

-- ==========================================================
-- Table: NOTE_BLOCKING
-- This table stores the reasons for blocking the sharing of a note.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
FROM NOTE_BLOCKING
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: NOTE_CONTENT_INFO
-- This table contains discrete information pertaining to the type of content contained within the note text of a clinical note.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
FROM NOTE_CONTENT_INFO
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: NOTE_COPY_TRACKING
-- Track the source note information that this note was copied from.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(NOTE_COPY_INST_DTTM) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_COPY_INST_DTTM) AS NOTE_COPY_INST_DTTM_filled,
    COUNT(NOTE_COPY_LOC_DTTM) AS NOTE_COPY_LOC_DTTM_filled
FROM NOTE_COPY_TRACKING
GROUP BY YEAR(NOTE_COPY_INST_DTTM)
ORDER BY activity_year;

-- ==========================================================
-- Table: NOTE_EDIT_TRAIL
-- This table displays edit trail information for notes (HNO).
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(IP_ACTION_DTTM) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(IP_ACTION_DTTM) AS IP_ACTION_DTTM_filled,
    COUNT(ACT_TAKEN_INST_DTTM) AS ACT_TAKEN_INST_DTTM_filled
FROM NOTE_EDIT_TRAIL
GROUP BY YEAR(IP_ACTION_DTTM)
ORDER BY activity_year;

-- ==========================================================
-- Table: NOTE_ENC_INFO
-- This table contains information from overtime single-response items about General Use Notes (HNO) records. Contact creation logic for clinical notes is as follows: 1. If a note doesn't exist, a new no
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(COSIGN_INSTANT_DTTM) AS COSIGN_INSTANT_DTTM_filled,
    COUNT(ENTRY_INSTANT_DTTM) AS ENTRY_INSTANT_DTTM_filled,
    COUNT(UPD_AUTHOR_INS_DTTM) AS UPD_AUTHOR_INS_DTTM_filled,
    COUNT(SPEC_NOTE_TIME_DTTM) AS SPEC_NOTE_TIME_DTTM_filled,
    COUNT(NOTE_FILE_TIME_DTTM) AS NOTE_FILE_TIME_DTTM_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(UPD_BY_AUTH_DTTM) AS UPD_BY_AUTH_DTTM_filled,
    COUNT(ACTIVITY_DTTM) AS ACTIVITY_DTTM_filled,
    COUNT(UPD_AUT_LOCAL_DTTM) AS UPD_AUT_LOCAL_DTTM_filled,
    COUNT(ENT_INST_LOCAL_DTTM) AS ENT_INST_LOCAL_DTTM_filled,
    COUNT(SPEC_TIME_LOC_DTTM) AS SPEC_TIME_LOC_DTTM_filled,
    COUNT(NOT_FILETM_LOC_DTTM) AS NOT_FILETM_LOC_DTTM_filled,
    COUNT(TRANSCRIPTION_DTTM) AS TRANSCRIPTION_DTTM_filled,
    COUNT(TREAT_SUMM_PAT_DTTM) AS TREAT_SUMM_PAT_DTTM_filled,
    COUNT(TREAT_SUMM_PROV_DTTM) AS TREAT_SUMM_PROV_DTTM_filled,
    COUNT(TREAT_SUMM_CPLT_DTTM) AS TREAT_SUMM_CPLT_DTTM_filled,
    COUNT(END_OF_TREAT_DATE) AS END_OF_TREAT_DATE_filled,
    COUNT(COSIGN_INST_LOCAL_DTTM) AS COSIGN_INST_LOCAL_DTTM_filled
FROM NOTE_ENC_INFO
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: NOTE_ENC_INFO_2
-- This table extends HNO_ENC_INFO.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(EXT_LAST_SIGN_UTC_DTTM) AS EXT_LAST_SIGN_UTC_DTTM_filled
FROM NOTE_ENC_INFO_2
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: NOTE_EXT_REL_ORD
-- This table stores information about external orders related to an external note.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
FROM NOTE_EXT_REL_ORD
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: NOTE_EXT_REL_PREDX
-- This table stores information about external pre-procedure diagnoses related to an external note.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
FROM NOTE_EXT_REL_PREDX
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: NOTE_EXT_REL_PROB
-- This table stores information about external problems related to an external note.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
FROM NOTE_EXT_REL_PROB
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: NOTE_EXT_REL_PROC
-- This table stores information about external procedures related to an external note.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
FROM NOTE_EXT_REL_PROC
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: NOTE_EXT_REL_PSTDX
-- This table stores information about external post-procedure diagnoses related to an external note.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
FROM NOTE_EXT_REL_PSTDX
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: NOTE_EXT_SIGNERS
-- Note signer information for auto-reconciled external notes.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(EXT_NOTE_SIGNING_UTC_DTTM) AS EXT_NOTE_SIGNING_UTC_DTTM_filled
FROM NOTE_EXT_SIGNERS
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: NOTE_EXT_WRN_TYP
-- This table stores the external note warning types for a note.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
FROM NOTE_EXT_WRN_TYP
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: NOTE_RESEARCH_LINK_HX
-- This table contains information about how the research study linkage on a note has changed over time.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(HX_STUDY_LINK_UTC_DTTM) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(HX_STUDY_LINK_UTC_DTTM) AS HX_STUDY_LINK_UTC_DTTM_filled
FROM NOTE_RESEARCH_LINK_HX
GROUP BY YEAR(HX_STUDY_LINK_UTC_DTTM)
ORDER BY activity_year;

-- ==========================================================
-- Table: NOTE_SMARTBLOCK_ATTR
-- Store the employee (EMP) ID, the Timestamp, and the SmartBlocks added of the Attribution for SmartBlocks.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(ATTRIBUTION_UTC_DTTM) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(ATTRIBUTION_UTC_DTTM) AS ATTRIBUTION_UTC_DTTM_filled
FROM NOTE_SMARTBLOCK_ATTR
GROUP BY YEAR(ATTRIBUTION_UTC_DTTM)
ORDER BY activity_year;

-- ==========================================================
-- Table: NOTE_SMARTSECTION_IDS
-- Contains the SmartSection IDs used in the note.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
FROM NOTE_SMARTSECTION_IDS
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: ORDER_DOCUMENTS
-- This table contains the DCS records attached to an order on a contact level such as scanned hard copy prescriptions, Lab Scans and Lab Reports.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
FROM ORDER_DOCUMENTS
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: ORDER_RAD_DICTATE
-- This table stores the dictation radiologist & dictating date information for orders performed in radiology.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(DICTATING_DT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(DICTATING_DT) AS DICTATING_DT_filled,
    COUNT(DICTATED_UTC_DTTM) AS DICTATED_UTC_DTTM_filled
FROM ORDER_RAD_DICTATE
GROUP BY YEAR(DICTATING_DT)
ORDER BY activity_year;

-- ==========================================================
-- Table: ORDER_RESULT_DOCUMENTS
-- This tables holds document IDs for documents that contain results for an order.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
FROM ORDER_RESULT_DOCUMENTS
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: ORDER_SMARTSECTION_DATA
-- Data for Order specific SmartSections.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
FROM ORDER_SMARTSECTION_DATA
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: ORDER_SMARTSECTION_HNO
-- Holds the CSN of HNO records that contain the SmartSection text.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
FROM ORDER_SMARTSECTION_HNO
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: ORDER_SMARTSECTION_TEXT
-- Holds the SmartSection text for an Order. Associated key is SMARTSECTION_KEY in ORDER_SMARTSECTION_DATA.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
FROM ORDER_SMARTSECTION_TEXT
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: OUTREACH_ESIG_DOCUMENTS
-- This table stores documents sent to patients for e-signature prior to an outreach.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(ESIG_DOC_SEND_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(ESIG_DOC_SEND_DATE) AS ESIG_DOC_SEND_DATE_filled
FROM OUTREACH_ESIG_DOCUMENTS
GROUP BY YEAR(ESIG_DOC_SEND_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: PAT_ADDENDUM_INFO
-- This table contains the encounter addendum information from the Addendum Added Date (I EPT 18123) and Addendum Added User (I EPT 18129) items.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(ADDENDUM_DATE_TIME) AS ADDENDUM_DATE_TIME_filled,
    COUNT(ADDENDUM_STARTED_UTC_DTTM) AS ADDENDUM_STARTED_UTC_DTTM_filled
FROM PAT_ADDENDUM_INFO
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: PAT_DT_STICKY_NOTE_INFO
-- This table contains information regarding a patient's date-specific sticky notes, including the date the note applies to as well as the note ID.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(DT_STICKY_NOTE_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(DT_STICKY_NOTE_DATE) AS DT_STICKY_NOTE_DATE_filled
FROM PAT_DT_STICKY_NOTE_INFO
GROUP BY YEAR(DT_STICKY_NOTE_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: PAT_ENC_AMBIENT_SESSIONS
-- Stores ambient session information from a patient's encounter.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
FROM PAT_ENC_AMBIENT_SESSIONS
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: PAT_ENC_PREPAYNOTE
-- User entered notes associated with a prepayment on a patient encounter.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
FROM PAT_ENC_PREPAYNOTE
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: QRY_EVIDENCE_NOTE_CSN_ID
-- This table extracts information related to the contact the evidence came from.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
FROM QRY_EVIDENCE_NOTE_CSN_ID
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: QRY_EVIDENCE_NOTE_IDS
-- This table extracts information related to the note record that the evidence came from.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
FROM QRY_EVIDENCE_NOTE_IDS
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: SMARTFORMS_ACCESSED
-- This table contains information pertaining to how specific users are accessing specific SmartForms, such as how long a user has spent in a given SmartForm.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
FROM SMARTFORMS_ACCESSED
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: SMARTFORM_METADATA
-- This table contains metadata pertaining to specific SmartForms for a visit.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
FROM SMARTFORM_METADATA
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: SMRTDTA_ELEM_CUST_SERVICE
-- This table is a bridge between CRM context SmartData element values and the source customer relationship management records.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(CUR_VALUE_DATETIME) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CUR_VALUE_DATETIME) AS CUR_VALUE_DATETIME_filled
FROM SMRTDTA_ELEM_CUST_SERVICE
GROUP BY YEAR(CUR_VALUE_DATETIME)
ORDER BY activity_year;

-- ==========================================================
-- Table: SMRTDTA_ELEM_DATA
-- The SMRTDTA_ELEM_DATA table stores metadata (context, linked records, time of entry, etc.) concerning SmartData element values entered by users through SmartForms, SmartTools or other documentation to
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(CUR_VALUE_DATETIME) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CUR_VALUE_DATETIME) AS CUR_VALUE_DATETIME_filled,
    COUNT(CUR_VAL_UTC_DTTM) AS CUR_VAL_UTC_DTTM_filled
FROM SMRTDTA_ELEM_DATA
GROUP BY YEAR(CUR_VALUE_DATETIME)
ORDER BY activity_year;

-- ==========================================================
-- Table: TX_ADDENDUM_NOTES
-- Extract Note (HNO) records containing addendum information for the note.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
FROM TX_ADDENDUM_NOTES
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: CLARITY_SER
-- The CLARITY_SER table contains high-level information about your provider records. These records may be caregivers, resources, classes, devices, and modalities.
-- Bucket(s): Provider record (schedule/FTE -- exploratory, no after-hours-specific field found)
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(PROV_ID_PROV_NAME) AS PROV_ID_PROV_NAME_filled,
    COUNT(PROV_NAME) AS PROV_NAME_filled,
    COUNT(EXTERNAL_NAME) AS EXTERNAL_NAME_filled
FROM CLARITY_SER;
