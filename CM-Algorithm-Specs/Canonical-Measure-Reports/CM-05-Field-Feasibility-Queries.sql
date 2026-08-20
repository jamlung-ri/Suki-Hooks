-- CM-05 field feasibility / density queries
-- Auto-generated. See the companion CM-XX-Field-Feasibility-Queries.md
-- and the shared Field-Feasibility-Queries-README.md in this directory
-- for what this is, why it's safe to run, and how to report results back.
--
-- HOW TO RUN: execute this entire script top to bottom in one session.
-- It produces exactly ONE result grid, at the very end. Export that grid
-- to CSV and send it back -- that is the entire ask.
--
-- Written for SQL Server T-SQL. On Oracle or in SAS PROC SQL, two swaps:
--   1. Replace `SELECT ... INTO #fc_NNN FROM ...` with
--      `CREATE TABLE fc_NNN AS SELECT ... FROM ...`
--   2. Replace `YEAR(<col>)` with `EXTRACT(YEAR FROM <col>)` (Oracle only --
--      SAS PROC SQL supports YEAR() natively).
-- SQL Server's #-prefixed temp tables are session-scoped and auto-dropped
-- when your connection closes -- nothing persists. On Oracle/SAS, staging
-- tables are ordinary tables and will need the cleanup block at the end of
-- this file (or your own housekeeping) to remove them.
--
-- If any column name collides with a reserved word, quote it per platform
-- ([COL] on SQL Server, "COL" on Oracle) in both Phase 1 and Phase 2.
--
-- For very large tables, consider adding a WHERE clause to the Phase 1
-- block for that table to sample a recent date range first (e.g.
-- WHERE <anchor> >= '2024-01-01') before running the unfiltered version.
--
-- To re-run this script in the same session, run the cleanup block at the
-- end first (SQL Server temp tables from a prior run will otherwise still
-- exist); or simply start a fresh connection.

-- ============================== PHASE 1 ==============================
-- One aggregate pass per candidate table into a session-scoped staging
-- table. Every block below has the identical shape: COUNT(*) plus
-- COUNT(<column>) for each candidate column (NULL-exclusive by standard
-- SQL semantics), grouped by year where the table has a usable date
-- column. No row-level data is read out anywhere in this script; only
-- these aggregate counts. Skim the first two or three blocks and the
-- rest follow the same pattern.

-- ---- fc_001 <- ABN_DOCUMENT_ID ----
-- This table contains information related to a patient's Advance Beneficiary Notice (ABN) documents.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
INTO #fc_001
FROM ABN_DOCUMENT_ID
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_002 <- ABN_NOTE_COMMENTS ----
-- Stores information about the follow-up comments associated with an ABN note.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
INTO #fc_002
FROM ABN_NOTE_COMMENTS
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_003 <- BLOCK_NOTE_COPIES ----
-- Info for note copies to potentially block while blocking parent note.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
INTO #fc_003
FROM BLOCK_NOTE_COPIES
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_004 <- CHILD_NOTE_INFO ----
-- The CHILD_NOTE_INFO table contains information about child notes that are linked to clinical notes. Each row represents one child note and contains information such as the user tha
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(LINK_UTC) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(LINK_UTC) AS LINK_UTC_filled,
    COUNT(LINK_DTTM) AS LINK_DTTM_filled
INTO #fc_004
FROM CHILD_NOTE_INFO
GROUP BY YEAR(LINK_UTC);

-- ---- fc_005 <- CONTACT_POINT_DOCUMENTS ----
-- This table contains Clinical References linked to patient education points.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
INTO #fc_005
FROM CONTACT_POINT_DOCUMENTS
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_006 <- CONTACT_TITLE_DOCUMENTS ----
-- This table contains Clinical References linked to patient education titles.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
INTO #fc_006
FROM CONTACT_TITLE_DOCUMENTS
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_007 <- CONTACT_TOPIC_DOCUMENTS ----
-- This table contains Clinical References linked to patient education topics.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
INTO #fc_007
FROM CONTACT_TOPIC_DOCUMENTS
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_008 <- COVERAGE_NOTE_INFO ----
-- This table contains information about notes attached to coverage records.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(NOTE_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_DATE) AS NOTE_DATE_filled,
    COUNT(NOTE_DTTM) AS NOTE_DTTM_filled
INTO #fc_008
FROM COVERAGE_NOTE_INFO
GROUP BY YEAR(NOTE_DATE);

-- ---- fc_009 <- CP_NOTE_READING_HX ----
-- This table stores the history information for the note's care plan reading.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
INTO #fc_009
FROM CP_NOTE_READING_HX
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_010 <- DOCS_RCVD_ASMT_PLAN_NOTE ----
-- This table extracts the related multiple response item DXR-11048.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
INTO #fc_010
FROM DOCS_RCVD_ASMT_PLAN_NOTE
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_011 <- DOCS_RCVD_CLN_NOTE_SIGNRS ----
-- Clinical note signer information for notes recieved externally.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(NOTE_SIGNED_UTC_DTTM) AS NOTE_SIGNED_UTC_DTTM_filled
INTO #fc_011
FROM DOCS_RCVD_CLN_NOTE_SIGNRS
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_012 <- DOCS_RCVD_INTVN_NOTE ----
-- This table extracts the dispense intervention note associated with a particular dispense.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
INTO #fc_012
FROM DOCS_RCVD_INTVN_NOTE
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_013 <- DOCS_RCVD_NOTE_SECTIONS ----
-- Stores note section data received.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
INTO #fc_013
FROM DOCS_RCVD_NOTE_SECTIONS
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_014 <- DOCS_RCVD_PCCNOTE ----
-- This table stores discrete information for patient care coordination notes received from outside sources.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(PCCNOTE_SIGNED_INST_DTTM) AS PCCNOTE_SIGNED_INST_DTTM_filled,
    COUNT(PCC_LST_UPD_INST_DTTM) AS PCC_LST_UPD_INST_DTTM_filled
INTO #fc_014
FROM DOCS_RCVD_PCCNOTE
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_015 <- DOCS_RCVD_RSLTS_ADDENDUM ----
-- This table stores discrete result addendum information received from outside sources.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(RSLT_ADDEND_INS_UTC_DTTM) AS RSLT_ADDEND_INS_UTC_DTTM_filled
INTO #fc_015
FROM DOCS_RCVD_RSLTS_ADDENDUM
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_016 <- DOCUMENT_SIG_DATA ----
-- Contains data about the signatures collected for an electronic signature document.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(SIG_TIMESTAMP_DTTM) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(SIG_TIMESTAMP_DTTM) AS SIG_TIMESTAMP_DTTM_filled
INTO #fc_016
FROM DOCUMENT_SIG_DATA
GROUP BY YEAR(SIG_TIMESTAMP_DTTM);

-- ---- fc_017 <- DOCUMENT_STAMPS ----
-- This table contains information about stamps added to scanned documents.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(STAMP_ADDED_UTC_DTTM) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(STAMP_ADDED_UTC_DTTM) AS STAMP_ADDED_UTC_DTTM_filled
INTO #fc_017
FROM DOCUMENT_STAMPS
GROUP BY YEAR(STAMP_ADDED_UTC_DTTM);

-- ---- fc_018 <- DP_COMM_MEMO_NOTE ----
-- This table contains the Free Text Note(HNO) IDs of communications sent to a service through the Continued Care and Services Coordination workflow, along with the patient CSN, patie
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
INTO #fc_018
FROM DP_COMM_MEMO_NOTE
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_019 <- DP_SVC_COORD_NOTE ----
-- Coordination notes from the Services to Coordinate section of the current patient encounter--used to leave care coordination notes specific to this patient to a user, or to other u
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
INTO #fc_019
FROM DP_SVC_COORD_NOTE
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_020 <- ENC_DX_ASSOC_AMBIENT_DX ----
-- This table contains the unique IDs of diagnoses provided by Ambient that were finalized to Visit Diagnoses on the encounter.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
INTO #fc_020
FROM ENC_DX_ASSOC_AMBIENT_DX
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_021 <- EPRESCRIBE_ERROR_ACTIONS ----
-- This table holds information about e-prescribing error resolution triggered before the May 23 version. E-prescribing error resolution on or after the upgrade to the May 23 version 
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(RESOLVED_UTC_DTTM) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(RESOLVED_UTC_DTTM) AS RESOLVED_UTC_DTTM_filled
INTO #fc_021
FROM EPRESCRIBE_ERROR_ACTIONS
GROUP BY YEAR(RESOLVED_UTC_DTTM);

-- ---- fc_022 <- FIN_ASST_NOTE ----
-- This table contains information about notes added to financial assistance tracker records.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(ENTRY_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(ENTRY_DATE) AS ENTRY_DATE_filled,
    COUNT(ACCT_NOTE_INSTANT_DTTM) AS ACCT_NOTE_INSTANT_DTTM_filled
INTO #fc_022
FROM FIN_ASST_NOTE
GROUP BY YEAR(ENTRY_DATE);

-- ---- fc_023 <- FLO_INST_COSIGNED ----
-- This table displays times that cosigners cosigned the flowsheet data.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(INSTANT_COSIGNED_TM) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(INSTANT_COSIGNED_TM) AS INSTANT_COSIGNED_TM_filled
INTO #fc_023
FROM FLO_INST_COSIGNED
GROUP BY YEAR(INSTANT_COSIGNED_TM);

-- ---- fc_024 <- HNO_CONSULT_ORD_ID ----
-- This table contains the unique IDs of the consult orders that are attached to a note.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
INTO #fc_024
FROM HNO_CONSULT_ORD_ID
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_025 <- HNO_ECG_DX ----
-- This table contains the diagnosis for Electrocardiograms (ECG/EKG) that have been stored on General Use Notes (HNO) records.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
INTO #fc_025
FROM HNO_ECG_DX
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_026 <- HNO_INFO ----
-- This table contains common information from General Use Notes items. This table focuses on time-insensitive, once-per-record data while other HNO tables (e.g., NOTES_ACCT, CODING_C
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
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
INTO #fc_026
FROM HNO_INFO
GROUP BY YEAR(CREATE_INSTANT_DTTM);

-- ---- fc_027 <- HNO_INFO_2 ----
-- This table contains common information from General Use Notes items. This table focuses on one time only data while other HNO tables (e.g., NOTES_ACCT, CODING_CLA_NOTES) contain th
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(LETTER_FINAL_UTC_DTTM) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(LETTER_FINAL_UTC_DTTM) AS LETTER_FINAL_UTC_DTTM_filled,
    COUNT(NOTE_UPDATE_INST_UTC_DTTM) AS NOTE_UPDATE_INST_UTC_DTTM_filled
INTO #fc_027
FROM HNO_INFO_2
GROUP BY YEAR(LETTER_FINAL_UTC_DTTM);

-- ---- fc_028 <- HNO_MYC_LET_INFO ----
-- This table contains MyChart related information for letters. It includes whether a letter is released to MyChart and the date/time it was released to MyChart.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(LET_REL_MYC_DTTM) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(LET_REL_MYC_DTTM) AS LET_REL_MYC_DTTM_filled
INTO #fc_028
FROM HNO_MYC_LET_INFO
GROUP BY YEAR(LET_REL_MYC_DTTM);

-- ---- fc_029 <- HNO_PLACEHOLDER_CHARGE ----
-- Contains items related to Create Placeholder Charge action.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(CHG_ACTION_UTC_DTTM) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CHG_ACTION_UTC_DTTM) AS CHG_ACTION_UTC_DTTM_filled
INTO #fc_029
FROM HNO_PLACEHOLDER_CHARGE
GROUP BY YEAR(CHG_ACTION_UTC_DTTM);

-- ---- fc_030 <- HNO_SMARTFORM_LINK ----
-- This table contains a list of SmartBlocks and the SmartForms that are linked to those SmartBlocks in a particular note.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
INTO #fc_030
FROM HNO_SMARTFORM_LINK
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_031 <- HNO_SOURCE_LOG_ID ----
-- This table displays the surgical log where a note was edited.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
INTO #fc_031
FROM HNO_SOURCE_LOG_ID
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_032 <- HOLOGRAM_DETAILS ----
-- This table stores workflow-level information about documentation pieces that have been queued up and suspended during an outpatient visit.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(WORKFLOW_INST_UTC_DTTM) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(WORKFLOW_INST_UTC_DTTM) AS WORKFLOW_INST_UTC_DTTM_filled
INTO #fc_032
FROM HOLOGRAM_DETAILS
GROUP BY YEAR(WORKFLOW_INST_UTC_DTTM);

-- ---- fc_033 <- HOLOGRAM_SELECTIONS ----
-- This table stores details about each selection made in a hologram record. Which specific details are stored depends on the type of each row.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
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
INTO #fc_033
FROM HOLOGRAM_SELECTIONS
GROUP BY YEAR(IMMNZTN_DATE);

-- ---- fc_034 <- INCOMPLETE_NOTE_EPT ----
-- Table created for the visit narrative data stored in the patient masterfile. No longer used since we use UCN now since 2010, exporting these items as a formality.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(INC_NOTE_START_DATE_UTC_DTTM) AS INC_NOTE_START_DATE_UTC_DTTM_filled,
    COUNT(INC_NOTE_LAST_EDIT_UTC_DTTM) AS INC_NOTE_LAST_EDIT_UTC_DTTM_filled
INTO #fc_034
FROM INCOMPLETE_NOTE_EPT
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_035 <- INTERV_NOTE_INFO ----
-- This table links a care plan goal note contact to the related intervention note contacts that were filed at the same time.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
INTO #fc_035
FROM INTERV_NOTE_INFO
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_036 <- LAB_COSIGN_INFO ----
-- The LAB_COSIGN_INFO table contains cosign information for lab results.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
INTO #fc_036
FROM LAB_COSIGN_INFO
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_037 <- MAR_COSIGN_INST ----
-- List of instants at which this med administration was cosigned.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(MAR_COSIGN_INSTANT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(MAR_COSIGN_INSTANT) AS MAR_COSIGN_INSTANT_filled
INTO #fc_037
FROM MAR_COSIGN_INST
GROUP BY YEAR(MAR_COSIGN_INSTANT);

-- ---- fc_038 <- MED_DISCONTINUE_NOTE ----
-- This table extracts the multiline discontinue note associated with a medication within a document received.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
INTO #fc_038
FROM MED_DISCONTINUE_NOTE
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_039 <- NOTES_ACCT ----
-- This table contains summary information for billing system account notepad notes attached to accounts.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(NOTE_ENTRY_DTTM) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_ENTRY_DTTM) AS NOTE_ENTRY_DTTM_filled
INTO #fc_039
FROM NOTES_ACCT
GROUP BY YEAR(NOTE_ENTRY_DTTM);

-- ---- fc_040 <- NOTES_HISTORY_LOG ----
-- This table contains the Edit History Information for all Notes (HNO records). Shows information about the type of edit, when the note was edited, and the user who made the edit.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(EDIT_HX_INSTANT) AS EDIT_HX_INSTANT_filled,
    COUNT(EDIT_HX_EXP_DATE) AS EDIT_HX_EXP_DATE_filled
INTO #fc_040
FROM NOTES_HISTORY_LOG
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_041 <- NOTES_MC_NMM ----
-- This table contains the information about notes (HNO) records attached to case (NMM) records.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(NOTE_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_DATE) AS NOTE_DATE_filled,
    COUNT(NOTE_TIME) AS NOTE_TIME_filled
INTO #fc_041
FROM NOTES_MC_NMM
GROUP BY YEAR(NOTE_DATE);

-- ---- fc_042 <- NOTES_TRANS_AUTH ----
-- This table contains transcription authorization info.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(AUTH_DTTM) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(AUTH_DTTM) AS AUTH_DTTM_filled,
    COUNT(DICTATION_TIME) AS DICTATION_TIME_filled,
    COUNT(TRANSCRIPTION_TIME) AS TRANSCRIPTION_TIME_filled,
    COUNT(ACTIVITY_DTTM) AS ACTIVITY_DTTM_filled,
    COUNT(EDIT_DTTM) AS EDIT_DTTM_filled,
    COUNT(CHR_CNT_DTTM) AS CHR_CNT_DTTM_filled
INTO #fc_042
FROM NOTES_TRANS_AUTH
GROUP BY YEAR(AUTH_DTTM);

-- ---- fc_043 <- NOTE_BLOCKING ----
-- This table stores the reasons for blocking the sharing of a note.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
INTO #fc_043
FROM NOTE_BLOCKING
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_044 <- NOTE_CONTENT_INFO ----
-- This table contains discrete information pertaining to the type of content contained within the note text of a clinical note.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
INTO #fc_044
FROM NOTE_CONTENT_INFO
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_045 <- NOTE_COPY_TRACKING ----
-- Track the source note information that this note was copied from.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(NOTE_COPY_INST_DTTM) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_COPY_INST_DTTM) AS NOTE_COPY_INST_DTTM_filled,
    COUNT(NOTE_COPY_LOC_DTTM) AS NOTE_COPY_LOC_DTTM_filled
INTO #fc_045
FROM NOTE_COPY_TRACKING
GROUP BY YEAR(NOTE_COPY_INST_DTTM);

-- ---- fc_046 <- NOTE_EDIT_TRAIL ----
-- This table displays edit trail information for notes (HNO).
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(IP_ACTION_DTTM) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(IP_ACTION_DTTM) AS IP_ACTION_DTTM_filled,
    COUNT(ACT_TAKEN_INST_DTTM) AS ACT_TAKEN_INST_DTTM_filled
INTO #fc_046
FROM NOTE_EDIT_TRAIL
GROUP BY YEAR(IP_ACTION_DTTM);

-- ---- fc_047 <- NOTE_ENC_INFO ----
-- This table contains information from overtime single-response items about General Use Notes (HNO) records. Contact creation logic for clinical notes is as follows: 1. If a note doe
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
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
INTO #fc_047
FROM NOTE_ENC_INFO
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_048 <- NOTE_ENC_INFO_2 ----
-- This table extends HNO_ENC_INFO.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(EXT_LAST_SIGN_UTC_DTTM) AS EXT_LAST_SIGN_UTC_DTTM_filled
INTO #fc_048
FROM NOTE_ENC_INFO_2
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_049 <- NOTE_EXT_REL_ORD ----
-- This table stores information about external orders related to an external note.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
INTO #fc_049
FROM NOTE_EXT_REL_ORD
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_050 <- NOTE_EXT_REL_PREDX ----
-- This table stores information about external pre-procedure diagnoses related to an external note.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
INTO #fc_050
FROM NOTE_EXT_REL_PREDX
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_051 <- NOTE_EXT_REL_PROB ----
-- This table stores information about external problems related to an external note.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
INTO #fc_051
FROM NOTE_EXT_REL_PROB
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_052 <- NOTE_EXT_REL_PROC ----
-- This table stores information about external procedures related to an external note.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
INTO #fc_052
FROM NOTE_EXT_REL_PROC
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_053 <- NOTE_EXT_REL_PSTDX ----
-- This table stores information about external post-procedure diagnoses related to an external note.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
INTO #fc_053
FROM NOTE_EXT_REL_PSTDX
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_054 <- NOTE_EXT_SIGNERS ----
-- Note signer information for auto-reconciled external notes.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(EXT_NOTE_SIGNING_UTC_DTTM) AS EXT_NOTE_SIGNING_UTC_DTTM_filled
INTO #fc_054
FROM NOTE_EXT_SIGNERS
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_055 <- NOTE_EXT_WRN_TYP ----
-- This table stores the external note warning types for a note.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
INTO #fc_055
FROM NOTE_EXT_WRN_TYP
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_056 <- NOTE_RESEARCH_LINK_HX ----
-- This table contains information about how the research study linkage on a note has changed over time.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(HX_STUDY_LINK_UTC_DTTM) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(HX_STUDY_LINK_UTC_DTTM) AS HX_STUDY_LINK_UTC_DTTM_filled
INTO #fc_056
FROM NOTE_RESEARCH_LINK_HX
GROUP BY YEAR(HX_STUDY_LINK_UTC_DTTM);

-- ---- fc_057 <- NOTE_SMARTBLOCK_ATTR ----
-- Store the employee (EMP) ID, the Timestamp, and the SmartBlocks added of the Attribution for SmartBlocks.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(ATTRIBUTION_UTC_DTTM) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(ATTRIBUTION_UTC_DTTM) AS ATTRIBUTION_UTC_DTTM_filled
INTO #fc_057
FROM NOTE_SMARTBLOCK_ATTR
GROUP BY YEAR(ATTRIBUTION_UTC_DTTM);

-- ---- fc_058 <- NOTE_SMARTSECTION_IDS ----
-- Contains the SmartSection IDs used in the note.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
INTO #fc_058
FROM NOTE_SMARTSECTION_IDS
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_059 <- ORDER_DOCUMENTS ----
-- This table contains the DCS records attached to an order on a contact level such as scanned hard copy prescriptions, Lab Scans and Lab Reports.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
INTO #fc_059
FROM ORDER_DOCUMENTS
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_060 <- ORDER_RAD_DICTATE ----
-- This table stores the dictation radiologist & dictating date information for orders performed in radiology.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(DICTATING_DT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(DICTATING_DT) AS DICTATING_DT_filled,
    COUNT(DICTATED_UTC_DTTM) AS DICTATED_UTC_DTTM_filled
INTO #fc_060
FROM ORDER_RAD_DICTATE
GROUP BY YEAR(DICTATING_DT);

-- ---- fc_061 <- ORDER_RESULT_DOCUMENTS ----
-- This tables holds document IDs for documents that contain results for an order.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
INTO #fc_061
FROM ORDER_RESULT_DOCUMENTS
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_062 <- ORDER_SMARTSECTION_DATA ----
-- Data for Order specific SmartSections.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
INTO #fc_062
FROM ORDER_SMARTSECTION_DATA
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_063 <- ORDER_SMARTSECTION_HNO ----
-- Holds the CSN of HNO records that contain the SmartSection text.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
INTO #fc_063
FROM ORDER_SMARTSECTION_HNO
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_064 <- ORDER_SMARTSECTION_TEXT ----
-- Holds the SmartSection text for an Order. Associated key is SMARTSECTION_KEY in ORDER_SMARTSECTION_DATA.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
INTO #fc_064
FROM ORDER_SMARTSECTION_TEXT
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_065 <- OUTREACH_ESIG_DOCUMENTS ----
-- This table stores documents sent to patients for e-signature prior to an outreach.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(ESIG_DOC_SEND_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(ESIG_DOC_SEND_DATE) AS ESIG_DOC_SEND_DATE_filled
INTO #fc_065
FROM OUTREACH_ESIG_DOCUMENTS
GROUP BY YEAR(ESIG_DOC_SEND_DATE);

-- ---- fc_066 <- PAT_ADDENDUM_INFO ----
-- This table contains the encounter addendum information from the Addendum Added Date (I EPT 18123) and Addendum Added User (I EPT 18129) items.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(ADDENDUM_DATE_TIME) AS ADDENDUM_DATE_TIME_filled,
    COUNT(ADDENDUM_STARTED_UTC_DTTM) AS ADDENDUM_STARTED_UTC_DTTM_filled
INTO #fc_066
FROM PAT_ADDENDUM_INFO
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_067 <- PAT_DT_STICKY_NOTE_INFO ----
-- This table contains information regarding a patient's date-specific sticky notes, including the date the note applies to as well as the note ID.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(DT_STICKY_NOTE_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(DT_STICKY_NOTE_DATE) AS DT_STICKY_NOTE_DATE_filled
INTO #fc_067
FROM PAT_DT_STICKY_NOTE_INFO
GROUP BY YEAR(DT_STICKY_NOTE_DATE);

-- ---- fc_068 <- PAT_ENC_AMBIENT_SESSIONS ----
-- Stores ambient session information from a patient's encounter.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
INTO #fc_068
FROM PAT_ENC_AMBIENT_SESSIONS
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_069 <- PAT_ENC_PREPAYNOTE ----
-- User entered notes associated with a prepayment on a patient encounter.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
INTO #fc_069
FROM PAT_ENC_PREPAYNOTE
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_070 <- QRY_EVIDENCE_NOTE_CSN_ID ----
-- This table extracts information related to the contact the evidence came from.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
INTO #fc_070
FROM QRY_EVIDENCE_NOTE_CSN_ID
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_071 <- QRY_EVIDENCE_NOTE_IDS ----
-- This table extracts information related to the note record that the evidence came from.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
INTO #fc_071
FROM QRY_EVIDENCE_NOTE_IDS
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_072 <- SMARTFORMS_ACCESSED ----
-- This table contains information pertaining to how specific users are accessing specific SmartForms, such as how long a user has spent in a given SmartForm.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
INTO #fc_072
FROM SMARTFORMS_ACCESSED
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_073 <- SMARTFORM_METADATA ----
-- This table contains metadata pertaining to specific SmartForms for a visit.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
INTO #fc_073
FROM SMARTFORM_METADATA
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_074 <- SMRTDTA_ELEM_CUST_SERVICE ----
-- This table is a bridge between CRM context SmartData element values and the source customer relationship management records.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(CUR_VALUE_DATETIME) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CUR_VALUE_DATETIME) AS CUR_VALUE_DATETIME_filled
INTO #fc_074
FROM SMRTDTA_ELEM_CUST_SERVICE
GROUP BY YEAR(CUR_VALUE_DATETIME);

-- ---- fc_075 <- SMRTDTA_ELEM_DATA ----
-- The SMRTDTA_ELEM_DATA table stores metadata (context, linked records, time of entry, etc.) concerning SmartData element values entered by users through SmartForms, SmartTools or ot
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(CUR_VALUE_DATETIME) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CUR_VALUE_DATETIME) AS CUR_VALUE_DATETIME_filled,
    COUNT(CUR_VAL_UTC_DTTM) AS CUR_VAL_UTC_DTTM_filled
INTO #fc_075
FROM SMRTDTA_ELEM_DATA
GROUP BY YEAR(CUR_VALUE_DATETIME);

-- ---- fc_076 <- TX_ADDENDUM_NOTES ----
-- Extract Note (HNO) records containing addendum information for the note.
-- Bucket(s): Reused from CM-04 note-timestamp candidates (bucket by hour-of-day/day-of-week)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
INTO #fc_076
FROM TX_ADDENDUM_NOTES
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_077 <- CLARITY_SER ----
-- The CLARITY_SER table contains high-level information about your provider records. These records may be caregivers, resources, classes, devices, and modalities.
-- Bucket(s): Provider record (schedule/FTE -- exploratory, no after-hours-specific field found)
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(PROV_ID_PROV_NAME) AS PROV_ID_PROV_NAME_filled,
    COUNT(PROV_NAME) AS PROV_NAME_filled,
    COUNT(EXTERNAL_NAME) AS EXTERNAL_NAME_filled
INTO #fc_077
FROM CLARITY_SER;

-- ============================== PHASE 2 ==============================
-- The one result set this script returns: every staging table's wide
-- aggregate row, reshaped into long format (one row per table/column/
-- year) and unioned together. Export this grid and send it back.

SELECT table_name, column_name, activity_year, total_rows, filled_count
FROM (
    SELECT 'ABN_DOCUMENT_ID' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_001
    UNION ALL
    SELECT 'ABN_NOTE_COMMENTS' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_002
    UNION ALL
    SELECT 'BLOCK_NOTE_COPIES' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_003
    UNION ALL
    SELECT 'CHILD_NOTE_INFO' AS table_name, 'LINK_UTC' AS column_name, activity_year, total_rows, LINK_UTC_filled AS filled_count FROM #fc_004
    UNION ALL
    SELECT 'CHILD_NOTE_INFO' AS table_name, 'LINK_DTTM' AS column_name, activity_year, total_rows, LINK_DTTM_filled AS filled_count FROM #fc_004
    UNION ALL
    SELECT 'CONTACT_POINT_DOCUMENTS' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_005
    UNION ALL
    SELECT 'CONTACT_TITLE_DOCUMENTS' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_006
    UNION ALL
    SELECT 'CONTACT_TOPIC_DOCUMENTS' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_007
    UNION ALL
    SELECT 'COVERAGE_NOTE_INFO' AS table_name, 'NOTE_DATE' AS column_name, activity_year, total_rows, NOTE_DATE_filled AS filled_count FROM #fc_008
    UNION ALL
    SELECT 'COVERAGE_NOTE_INFO' AS table_name, 'NOTE_DTTM' AS column_name, activity_year, total_rows, NOTE_DTTM_filled AS filled_count FROM #fc_008
    UNION ALL
    SELECT 'CP_NOTE_READING_HX' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_009
    UNION ALL
    SELECT 'DOCS_RCVD_ASMT_PLAN_NOTE' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_010
    UNION ALL
    SELECT 'DOCS_RCVD_CLN_NOTE_SIGNRS' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_011
    UNION ALL
    SELECT 'DOCS_RCVD_CLN_NOTE_SIGNRS' AS table_name, 'NOTE_SIGNED_UTC_DTTM' AS column_name, activity_year, total_rows, NOTE_SIGNED_UTC_DTTM_filled AS filled_count FROM #fc_011
    UNION ALL
    SELECT 'DOCS_RCVD_INTVN_NOTE' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_012
    UNION ALL
    SELECT 'DOCS_RCVD_NOTE_SECTIONS' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_013
    UNION ALL
    SELECT 'DOCS_RCVD_PCCNOTE' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_014
    UNION ALL
    SELECT 'DOCS_RCVD_PCCNOTE' AS table_name, 'PCCNOTE_SIGNED_INST_DTTM' AS column_name, activity_year, total_rows, PCCNOTE_SIGNED_INST_DTTM_filled AS filled_count FROM #fc_014
    UNION ALL
    SELECT 'DOCS_RCVD_PCCNOTE' AS table_name, 'PCC_LST_UPD_INST_DTTM' AS column_name, activity_year, total_rows, PCC_LST_UPD_INST_DTTM_filled AS filled_count FROM #fc_014
    UNION ALL
    SELECT 'DOCS_RCVD_RSLTS_ADDENDUM' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_015
    UNION ALL
    SELECT 'DOCS_RCVD_RSLTS_ADDENDUM' AS table_name, 'RSLT_ADDEND_INS_UTC_DTTM' AS column_name, activity_year, total_rows, RSLT_ADDEND_INS_UTC_DTTM_filled AS filled_count FROM #fc_015
    UNION ALL
    SELECT 'DOCUMENT_SIG_DATA' AS table_name, 'SIG_TIMESTAMP_DTTM' AS column_name, activity_year, total_rows, SIG_TIMESTAMP_DTTM_filled AS filled_count FROM #fc_016
    UNION ALL
    SELECT 'DOCUMENT_STAMPS' AS table_name, 'STAMP_ADDED_UTC_DTTM' AS column_name, activity_year, total_rows, STAMP_ADDED_UTC_DTTM_filled AS filled_count FROM #fc_017
    UNION ALL
    SELECT 'DP_COMM_MEMO_NOTE' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_018
    UNION ALL
    SELECT 'DP_SVC_COORD_NOTE' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_019
    UNION ALL
    SELECT 'ENC_DX_ASSOC_AMBIENT_DX' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_020
    UNION ALL
    SELECT 'EPRESCRIBE_ERROR_ACTIONS' AS table_name, 'RESOLVED_UTC_DTTM' AS column_name, activity_year, total_rows, RESOLVED_UTC_DTTM_filled AS filled_count FROM #fc_021
    UNION ALL
    SELECT 'FIN_ASST_NOTE' AS table_name, 'ENTRY_DATE' AS column_name, activity_year, total_rows, ENTRY_DATE_filled AS filled_count FROM #fc_022
    UNION ALL
    SELECT 'FIN_ASST_NOTE' AS table_name, 'ACCT_NOTE_INSTANT_DTTM' AS column_name, activity_year, total_rows, ACCT_NOTE_INSTANT_DTTM_filled AS filled_count FROM #fc_022
    UNION ALL
    SELECT 'FLO_INST_COSIGNED' AS table_name, 'INSTANT_COSIGNED_TM' AS column_name, activity_year, total_rows, INSTANT_COSIGNED_TM_filled AS filled_count FROM #fc_023
    UNION ALL
    SELECT 'HNO_CONSULT_ORD_ID' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_024
    UNION ALL
    SELECT 'HNO_ECG_DX' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_025
    UNION ALL
    SELECT 'HNO_INFO' AS table_name, 'CREATE_INSTANT_DTTM' AS column_name, activity_year, total_rows, CREATE_INSTANT_DTTM_filled AS filled_count FROM #fc_026
    UNION ALL
    SELECT 'HNO_INFO' AS table_name, 'DELETE_INSTANT_DTTM' AS column_name, activity_year, total_rows, DELETE_INSTANT_DTTM_filled AS filled_count FROM #fc_026
    UNION ALL
    SELECT 'HNO_INFO' AS table_name, 'DATE_OF_SERVIC_DTTM' AS column_name, activity_year, total_rows, DATE_OF_SERVIC_DTTM_filled AS filled_count FROM #fc_026
    UNION ALL
    SELECT 'HNO_INFO' AS table_name, 'LST_FILED_INST_DTTM' AS column_name, activity_year, total_rows, LST_FILED_INST_DTTM_filled AS filled_count FROM #fc_026
    UNION ALL
    SELECT 'HNO_INFO' AS table_name, 'UPDATE_DATE' AS column_name, activity_year, total_rows, UPDATE_DATE_filled AS filled_count FROM #fc_026
    UNION ALL
    SELECT 'HNO_INFO' AS table_name, 'CRT_INST_LOCAL_DTTM' AS column_name, activity_year, total_rows, CRT_INST_LOCAL_DTTM_filled AS filled_count FROM #fc_026
    UNION ALL
    SELECT 'HNO_INFO' AS table_name, 'ACTIVE_FROM_DT' AS column_name, activity_year, total_rows, ACTIVE_FROM_DT_filled AS filled_count FROM #fc_026
    UNION ALL
    SELECT 'HNO_INFO' AS table_name, 'ACTIVE_TO_DT' AS column_name, activity_year, total_rows, ACTIVE_TO_DT_filled AS filled_count FROM #fc_026
    UNION ALL
    SELECT 'HNO_INFO' AS table_name, 'COMMENT_EDIT_INST_DTTM' AS column_name, activity_year, total_rows, COMMENT_EDIT_INST_DTTM_filled AS filled_count FROM #fc_026
    UNION ALL
    SELECT 'HNO_INFO_2' AS table_name, 'LETTER_FINAL_UTC_DTTM' AS column_name, activity_year, total_rows, LETTER_FINAL_UTC_DTTM_filled AS filled_count FROM #fc_027
    UNION ALL
    SELECT 'HNO_INFO_2' AS table_name, 'NOTE_UPDATE_INST_UTC_DTTM' AS column_name, activity_year, total_rows, NOTE_UPDATE_INST_UTC_DTTM_filled AS filled_count FROM #fc_027
    UNION ALL
    SELECT 'HNO_MYC_LET_INFO' AS table_name, 'LET_REL_MYC_DTTM' AS column_name, activity_year, total_rows, LET_REL_MYC_DTTM_filled AS filled_count FROM #fc_028
    UNION ALL
    SELECT 'HNO_PLACEHOLDER_CHARGE' AS table_name, 'CHG_ACTION_UTC_DTTM' AS column_name, activity_year, total_rows, CHG_ACTION_UTC_DTTM_filled AS filled_count FROM #fc_029
    UNION ALL
    SELECT 'HNO_SMARTFORM_LINK' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_030
    UNION ALL
    SELECT 'HNO_SOURCE_LOG_ID' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_031
    UNION ALL
    SELECT 'HOLOGRAM_DETAILS' AS table_name, 'WORKFLOW_INST_UTC_DTTM' AS column_name, activity_year, total_rows, WORKFLOW_INST_UTC_DTTM_filled AS filled_count FROM #fc_032
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'IMMNZTN_DATE' AS column_name, activity_year, total_rows, IMMNZTN_DATE_filled AS filled_count FROM #fc_033
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'IMMNZTN_INSTANT_UTC_DTTM' AS column_name, activity_year, total_rows, IMMNZTN_INSTANT_UTC_DTTM_filled AS filled_count FROM #fc_033
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'IMMNZTN_NEXT_DUE_DATE' AS column_name, activity_year, total_rows, IMMNZTN_NEXT_DUE_DATE_filled AS filled_count FROM #fc_033
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'IMMNZTN_EXPIRATION_DATE' AS column_name, activity_year, total_rows, IMMNZTN_EXPIRATION_DATE_filled AS filled_count FROM #fc_033
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'IMMNZTN_VIS_DATE' AS column_name, activity_year, total_rows, IMMNZTN_VIS_DATE_filled AS filled_count FROM #fc_033
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'LOS_COMPONENT_COUNSEL_TIME' AS column_name, activity_year, total_rows, LOS_COMPONENT_COUNSEL_TIME_filled AS filled_count FROM #fc_033
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'NT_DISP_INSTANT_UTC_DTTM' AS column_name, activity_year, total_rows, NT_DISP_INSTANT_UTC_DTTM_filled AS filled_count FROM #fc_033
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'REASON_FOR_VISIT_ONSET_DATE' AS column_name, activity_year, total_rows, REASON_FOR_VISIT_ONSET_DATE_filled AS filled_count FROM #fc_033
    UNION ALL
    SELECT 'INCOMPLETE_NOTE_EPT' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_034
    UNION ALL
    SELECT 'INCOMPLETE_NOTE_EPT' AS table_name, 'INC_NOTE_START_DATE_UTC_DTTM' AS column_name, activity_year, total_rows, INC_NOTE_START_DATE_UTC_DTTM_filled AS filled_count FROM #fc_034
    UNION ALL
    SELECT 'INCOMPLETE_NOTE_EPT' AS table_name, 'INC_NOTE_LAST_EDIT_UTC_DTTM' AS column_name, activity_year, total_rows, INC_NOTE_LAST_EDIT_UTC_DTTM_filled AS filled_count FROM #fc_034
    UNION ALL
    SELECT 'INTERV_NOTE_INFO' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_035
    UNION ALL
    SELECT 'LAB_COSIGN_INFO' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_036
    UNION ALL
    SELECT 'MAR_COSIGN_INST' AS table_name, 'MAR_COSIGN_INSTANT' AS column_name, activity_year, total_rows, MAR_COSIGN_INSTANT_filled AS filled_count FROM #fc_037
    UNION ALL
    SELECT 'MED_DISCONTINUE_NOTE' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_038
    UNION ALL
    SELECT 'NOTES_ACCT' AS table_name, 'NOTE_ENTRY_DTTM' AS column_name, activity_year, total_rows, NOTE_ENTRY_DTTM_filled AS filled_count FROM #fc_039
    UNION ALL
    SELECT 'NOTES_HISTORY_LOG' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_040
    UNION ALL
    SELECT 'NOTES_HISTORY_LOG' AS table_name, 'EDIT_HX_INSTANT' AS column_name, activity_year, total_rows, EDIT_HX_INSTANT_filled AS filled_count FROM #fc_040
    UNION ALL
    SELECT 'NOTES_HISTORY_LOG' AS table_name, 'EDIT_HX_EXP_DATE' AS column_name, activity_year, total_rows, EDIT_HX_EXP_DATE_filled AS filled_count FROM #fc_040
    UNION ALL
    SELECT 'NOTES_MC_NMM' AS table_name, 'NOTE_DATE' AS column_name, activity_year, total_rows, NOTE_DATE_filled AS filled_count FROM #fc_041
    UNION ALL
    SELECT 'NOTES_MC_NMM' AS table_name, 'NOTE_TIME' AS column_name, activity_year, total_rows, NOTE_TIME_filled AS filled_count FROM #fc_041
    UNION ALL
    SELECT 'NOTES_TRANS_AUTH' AS table_name, 'AUTH_DTTM' AS column_name, activity_year, total_rows, AUTH_DTTM_filled AS filled_count FROM #fc_042
    UNION ALL
    SELECT 'NOTES_TRANS_AUTH' AS table_name, 'DICTATION_TIME' AS column_name, activity_year, total_rows, DICTATION_TIME_filled AS filled_count FROM #fc_042
    UNION ALL
    SELECT 'NOTES_TRANS_AUTH' AS table_name, 'TRANSCRIPTION_TIME' AS column_name, activity_year, total_rows, TRANSCRIPTION_TIME_filled AS filled_count FROM #fc_042
    UNION ALL
    SELECT 'NOTES_TRANS_AUTH' AS table_name, 'ACTIVITY_DTTM' AS column_name, activity_year, total_rows, ACTIVITY_DTTM_filled AS filled_count FROM #fc_042
    UNION ALL
    SELECT 'NOTES_TRANS_AUTH' AS table_name, 'EDIT_DTTM' AS column_name, activity_year, total_rows, EDIT_DTTM_filled AS filled_count FROM #fc_042
    UNION ALL
    SELECT 'NOTES_TRANS_AUTH' AS table_name, 'CHR_CNT_DTTM' AS column_name, activity_year, total_rows, CHR_CNT_DTTM_filled AS filled_count FROM #fc_042
    UNION ALL
    SELECT 'NOTE_BLOCKING' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_043
    UNION ALL
    SELECT 'NOTE_CONTENT_INFO' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_044
    UNION ALL
    SELECT 'NOTE_COPY_TRACKING' AS table_name, 'NOTE_COPY_INST_DTTM' AS column_name, activity_year, total_rows, NOTE_COPY_INST_DTTM_filled AS filled_count FROM #fc_045
    UNION ALL
    SELECT 'NOTE_COPY_TRACKING' AS table_name, 'NOTE_COPY_LOC_DTTM' AS column_name, activity_year, total_rows, NOTE_COPY_LOC_DTTM_filled AS filled_count FROM #fc_045
    UNION ALL
    SELECT 'NOTE_EDIT_TRAIL' AS table_name, 'IP_ACTION_DTTM' AS column_name, activity_year, total_rows, IP_ACTION_DTTM_filled AS filled_count FROM #fc_046
    UNION ALL
    SELECT 'NOTE_EDIT_TRAIL' AS table_name, 'ACT_TAKEN_INST_DTTM' AS column_name, activity_year, total_rows, ACT_TAKEN_INST_DTTM_filled AS filled_count FROM #fc_046
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'COSIGN_INSTANT_DTTM' AS column_name, activity_year, total_rows, COSIGN_INSTANT_DTTM_filled AS filled_count FROM #fc_047
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'ENTRY_INSTANT_DTTM' AS column_name, activity_year, total_rows, ENTRY_INSTANT_DTTM_filled AS filled_count FROM #fc_047
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'UPD_AUTHOR_INS_DTTM' AS column_name, activity_year, total_rows, UPD_AUTHOR_INS_DTTM_filled AS filled_count FROM #fc_047
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'SPEC_NOTE_TIME_DTTM' AS column_name, activity_year, total_rows, SPEC_NOTE_TIME_DTTM_filled AS filled_count FROM #fc_047
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'NOTE_FILE_TIME_DTTM' AS column_name, activity_year, total_rows, NOTE_FILE_TIME_DTTM_filled AS filled_count FROM #fc_047
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_047
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'UPD_BY_AUTH_DTTM' AS column_name, activity_year, total_rows, UPD_BY_AUTH_DTTM_filled AS filled_count FROM #fc_047
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'ACTIVITY_DTTM' AS column_name, activity_year, total_rows, ACTIVITY_DTTM_filled AS filled_count FROM #fc_047
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'UPD_AUT_LOCAL_DTTM' AS column_name, activity_year, total_rows, UPD_AUT_LOCAL_DTTM_filled AS filled_count FROM #fc_047
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'ENT_INST_LOCAL_DTTM' AS column_name, activity_year, total_rows, ENT_INST_LOCAL_DTTM_filled AS filled_count FROM #fc_047
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'SPEC_TIME_LOC_DTTM' AS column_name, activity_year, total_rows, SPEC_TIME_LOC_DTTM_filled AS filled_count FROM #fc_047
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'NOT_FILETM_LOC_DTTM' AS column_name, activity_year, total_rows, NOT_FILETM_LOC_DTTM_filled AS filled_count FROM #fc_047
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'TRANSCRIPTION_DTTM' AS column_name, activity_year, total_rows, TRANSCRIPTION_DTTM_filled AS filled_count FROM #fc_047
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'TREAT_SUMM_PAT_DTTM' AS column_name, activity_year, total_rows, TREAT_SUMM_PAT_DTTM_filled AS filled_count FROM #fc_047
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'TREAT_SUMM_PROV_DTTM' AS column_name, activity_year, total_rows, TREAT_SUMM_PROV_DTTM_filled AS filled_count FROM #fc_047
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'TREAT_SUMM_CPLT_DTTM' AS column_name, activity_year, total_rows, TREAT_SUMM_CPLT_DTTM_filled AS filled_count FROM #fc_047
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'END_OF_TREAT_DATE' AS column_name, activity_year, total_rows, END_OF_TREAT_DATE_filled AS filled_count FROM #fc_047
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'COSIGN_INST_LOCAL_DTTM' AS column_name, activity_year, total_rows, COSIGN_INST_LOCAL_DTTM_filled AS filled_count FROM #fc_047
    UNION ALL
    SELECT 'NOTE_ENC_INFO_2' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_048
    UNION ALL
    SELECT 'NOTE_ENC_INFO_2' AS table_name, 'EXT_LAST_SIGN_UTC_DTTM' AS column_name, activity_year, total_rows, EXT_LAST_SIGN_UTC_DTTM_filled AS filled_count FROM #fc_048
    UNION ALL
    SELECT 'NOTE_EXT_REL_ORD' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_049
    UNION ALL
    SELECT 'NOTE_EXT_REL_PREDX' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_050
    UNION ALL
    SELECT 'NOTE_EXT_REL_PROB' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_051
    UNION ALL
    SELECT 'NOTE_EXT_REL_PROC' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_052
    UNION ALL
    SELECT 'NOTE_EXT_REL_PSTDX' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_053
    UNION ALL
    SELECT 'NOTE_EXT_SIGNERS' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_054
    UNION ALL
    SELECT 'NOTE_EXT_SIGNERS' AS table_name, 'EXT_NOTE_SIGNING_UTC_DTTM' AS column_name, activity_year, total_rows, EXT_NOTE_SIGNING_UTC_DTTM_filled AS filled_count FROM #fc_054
    UNION ALL
    SELECT 'NOTE_EXT_WRN_TYP' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_055
    UNION ALL
    SELECT 'NOTE_RESEARCH_LINK_HX' AS table_name, 'HX_STUDY_LINK_UTC_DTTM' AS column_name, activity_year, total_rows, HX_STUDY_LINK_UTC_DTTM_filled AS filled_count FROM #fc_056
    UNION ALL
    SELECT 'NOTE_SMARTBLOCK_ATTR' AS table_name, 'ATTRIBUTION_UTC_DTTM' AS column_name, activity_year, total_rows, ATTRIBUTION_UTC_DTTM_filled AS filled_count FROM #fc_057
    UNION ALL
    SELECT 'NOTE_SMARTSECTION_IDS' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'ORDER_DOCUMENTS' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_059
    UNION ALL
    SELECT 'ORDER_RAD_DICTATE' AS table_name, 'DICTATING_DT' AS column_name, activity_year, total_rows, DICTATING_DT_filled AS filled_count FROM #fc_060
    UNION ALL
    SELECT 'ORDER_RAD_DICTATE' AS table_name, 'DICTATED_UTC_DTTM' AS column_name, activity_year, total_rows, DICTATED_UTC_DTTM_filled AS filled_count FROM #fc_060
    UNION ALL
    SELECT 'ORDER_RESULT_DOCUMENTS' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_061
    UNION ALL
    SELECT 'ORDER_SMARTSECTION_DATA' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_062
    UNION ALL
    SELECT 'ORDER_SMARTSECTION_HNO' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_063
    UNION ALL
    SELECT 'ORDER_SMARTSECTION_TEXT' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_064
    UNION ALL
    SELECT 'OUTREACH_ESIG_DOCUMENTS' AS table_name, 'ESIG_DOC_SEND_DATE' AS column_name, activity_year, total_rows, ESIG_DOC_SEND_DATE_filled AS filled_count FROM #fc_065
    UNION ALL
    SELECT 'PAT_ADDENDUM_INFO' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_066
    UNION ALL
    SELECT 'PAT_ADDENDUM_INFO' AS table_name, 'ADDENDUM_DATE_TIME' AS column_name, activity_year, total_rows, ADDENDUM_DATE_TIME_filled AS filled_count FROM #fc_066
    UNION ALL
    SELECT 'PAT_ADDENDUM_INFO' AS table_name, 'ADDENDUM_STARTED_UTC_DTTM' AS column_name, activity_year, total_rows, ADDENDUM_STARTED_UTC_DTTM_filled AS filled_count FROM #fc_066
    UNION ALL
    SELECT 'PAT_DT_STICKY_NOTE_INFO' AS table_name, 'DT_STICKY_NOTE_DATE' AS column_name, activity_year, total_rows, DT_STICKY_NOTE_DATE_filled AS filled_count FROM #fc_067
    UNION ALL
    SELECT 'PAT_ENC_AMBIENT_SESSIONS' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_068
    UNION ALL
    SELECT 'PAT_ENC_PREPAYNOTE' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_069
    UNION ALL
    SELECT 'QRY_EVIDENCE_NOTE_CSN_ID' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_070
    UNION ALL
    SELECT 'QRY_EVIDENCE_NOTE_IDS' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_071
    UNION ALL
    SELECT 'SMARTFORMS_ACCESSED' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_072
    UNION ALL
    SELECT 'SMARTFORM_METADATA' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_073
    UNION ALL
    SELECT 'SMRTDTA_ELEM_CUST_SERVICE' AS table_name, 'CUR_VALUE_DATETIME' AS column_name, activity_year, total_rows, CUR_VALUE_DATETIME_filled AS filled_count FROM #fc_074
    UNION ALL
    SELECT 'SMRTDTA_ELEM_DATA' AS table_name, 'CUR_VALUE_DATETIME' AS column_name, activity_year, total_rows, CUR_VALUE_DATETIME_filled AS filled_count FROM #fc_075
    UNION ALL
    SELECT 'SMRTDTA_ELEM_DATA' AS table_name, 'CUR_VAL_UTC_DTTM' AS column_name, activity_year, total_rows, CUR_VAL_UTC_DTTM_filled AS filled_count FROM #fc_075
    UNION ALL
    SELECT 'TX_ADDENDUM_NOTES' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_076
    UNION ALL
    SELECT 'CLARITY_SER' AS table_name, 'PROV_ID_PROV_NAME' AS column_name, activity_year, total_rows, PROV_ID_PROV_NAME_filled AS filled_count FROM #fc_077
    UNION ALL
    SELECT 'CLARITY_SER' AS table_name, 'PROV_NAME' AS column_name, activity_year, total_rows, PROV_NAME_filled AS filled_count FROM #fc_077
    UNION ALL
    SELECT 'CLARITY_SER' AS table_name, 'EXTERNAL_NAME' AS column_name, activity_year, total_rows, EXTERNAL_NAME_filled AS filled_count FROM #fc_077
) all_results
ORDER BY table_name, column_name, activity_year;

-- ============================== CLEANUP (optional) ==============================
-- SQL Server: not required (temp tables auto-drop at session end), but safe
-- to run if you want to remove them immediately. Oracle/SAS: uncomment and
-- run this if you did NOT use true temp tables in Phase 1.
/*
DROP TABLE #fc_001;
DROP TABLE #fc_002;
DROP TABLE #fc_003;
DROP TABLE #fc_004;
DROP TABLE #fc_005;
DROP TABLE #fc_006;
DROP TABLE #fc_007;
DROP TABLE #fc_008;
DROP TABLE #fc_009;
DROP TABLE #fc_010;
DROP TABLE #fc_011;
DROP TABLE #fc_012;
DROP TABLE #fc_013;
DROP TABLE #fc_014;
DROP TABLE #fc_015;
DROP TABLE #fc_016;
DROP TABLE #fc_017;
DROP TABLE #fc_018;
DROP TABLE #fc_019;
DROP TABLE #fc_020;
DROP TABLE #fc_021;
DROP TABLE #fc_022;
DROP TABLE #fc_023;
DROP TABLE #fc_024;
DROP TABLE #fc_025;
DROP TABLE #fc_026;
DROP TABLE #fc_027;
DROP TABLE #fc_028;
DROP TABLE #fc_029;
DROP TABLE #fc_030;
DROP TABLE #fc_031;
DROP TABLE #fc_032;
DROP TABLE #fc_033;
DROP TABLE #fc_034;
DROP TABLE #fc_035;
DROP TABLE #fc_036;
DROP TABLE #fc_037;
DROP TABLE #fc_038;
DROP TABLE #fc_039;
DROP TABLE #fc_040;
DROP TABLE #fc_041;
DROP TABLE #fc_042;
DROP TABLE #fc_043;
DROP TABLE #fc_044;
DROP TABLE #fc_045;
DROP TABLE #fc_046;
DROP TABLE #fc_047;
DROP TABLE #fc_048;
DROP TABLE #fc_049;
DROP TABLE #fc_050;
DROP TABLE #fc_051;
DROP TABLE #fc_052;
DROP TABLE #fc_053;
DROP TABLE #fc_054;
DROP TABLE #fc_055;
DROP TABLE #fc_056;
DROP TABLE #fc_057;
DROP TABLE #fc_058;
DROP TABLE #fc_059;
DROP TABLE #fc_060;
DROP TABLE #fc_061;
DROP TABLE #fc_062;
DROP TABLE #fc_063;
DROP TABLE #fc_064;
DROP TABLE #fc_065;
DROP TABLE #fc_066;
DROP TABLE #fc_067;
DROP TABLE #fc_068;
DROP TABLE #fc_069;
DROP TABLE #fc_070;
DROP TABLE #fc_071;
DROP TABLE #fc_072;
DROP TABLE #fc_073;
DROP TABLE #fc_074;
DROP TABLE #fc_075;
DROP TABLE #fc_076;
DROP TABLE #fc_077;
*/
