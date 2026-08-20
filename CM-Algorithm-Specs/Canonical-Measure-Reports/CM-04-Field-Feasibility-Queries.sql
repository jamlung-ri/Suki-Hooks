-- CM-04 field feasibility / density queries
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
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(PAT_ENC_DATE_REAL) AS PAT_ENC_DATE_REAL_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(ABN_DOCUMENT_ID) AS ABN_DOCUMENT_ID_filled
INTO #fc_001
FROM ABN_DOCUMENT_ID
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_002 <- ABN_NOTE_COMMENTS ----
-- Stores information about the follow-up comments associated with an ABN note.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_CSN_ID) AS NOTE_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(ABN_FOLUP_COMMENTS) AS ABN_FOLUP_COMMENTS_filled
INTO #fc_002
FROM ABN_NOTE_COMMENTS
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_003 <- ABN_NOTE_CONTACT_SERVICE ----
-- This extract table contains information for items in the General Use Notes (HNO) ABN Procedures (HNO 2310) related group. These items are populated with information from the Advanc
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(ABN_PROC_ID_PROC_NAME) AS ABN_PROC_ID_PROC_NAME_filled,
    COUNT(ABN_REASON_FOR_NONCOVERAGE) AS ABN_REASON_FOR_NONCOVERAGE_filled,
    COUNT(ABN_TRIGGERING_REASON) AS ABN_TRIGGERING_REASON_filled,
    COUNT(ABN_PRICE_PER_SERVICE) AS ABN_PRICE_PER_SERVICE_filled,
    COUNT(ABN_MODIFIER_USED) AS ABN_MODIFIER_USED_filled,
    COUNT(ABN_ORIGINAL_PRICE_PER_SERVICE) AS ABN_ORIGINAL_PRICE_PER_SERVICE_filled,
    COUNT(ABN_MEDICATION_ID_MEDICATION_NAME) AS ABN_MEDICATION_ID_MEDICATION_NAME_filled,
    COUNT(ABN_FAILED_LCD_C) AS ABN_FAILED_LCD_C_filled,
    COUNT(ABN_SERVICE_DUR) AS ABN_SERVICE_DUR_filled
INTO #fc_003
FROM ABN_NOTE_CONTACT_SERVICE;

-- ---- fc_004 <- ABN_NOTE_PROC ----
-- Store information about the ABN procedure note for EHI reporting.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(ABN_PROC_FREQ_DUR) AS ABN_PROC_FREQ_DUR_filled
INTO #fc_004
FROM ABN_NOTE_PROC;

-- ---- fc_005 <- ACCESSIBLE_DOCUMENTS_PREF ----
-- Stores a patient's preferences for receiving accessible documents.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(PAT_ID) AS PAT_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(ACCESSIBLE_DOCUMENTS_PREF_C_NAME) AS ACCESSIBLE_DOCUMENTS_PREF_C_NAME_filled
INTO #fc_005
FROM ACCESSIBLE_DOCUMENTS_PREF;

-- ---- fc_006 <- ACCT_HB_BNOTE ----
-- This table contains Hospital Billing billing notes for guarantor accounts.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(ACCT_ID) AS ACCT_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(HB_BILLING_NOTE) AS HB_BILLING_NOTE_filled
INTO #fc_006
FROM ACCT_HB_BNOTE;

-- ---- fc_007 <- ACCT_PB_BILL_NOTE ----
-- This table stores billing note on the account.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(ACCT_ID) AS ACCT_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(BILLING_NOTE) AS BILLING_NOTE_filled
INTO #fc_007
FROM ACCT_PB_BILL_NOTE;

-- ---- fc_008 <- ADDENDUM_VERSIONS ----
-- The ADDENDUM_VERSIONS table contains information about imaging result text addenda. The rows in this table can be used to link the version of the addendum text with other order inf
-- Bucket(s): addendum
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(ORDER_ID) AS ORDER_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(ADDENDUM_CONTACT) AS ADDENDUM_CONTACT_filled
INTO #fc_008
FROM ADDENDUM_VERSIONS;

-- ---- fc_009 <- AUTH_REQUEST_HX_UNS_NOTE ----
-- This table contains the snapshot of unsigned notes associated with the authorization request.
-- Bucket(s): other note/document-adjacent
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(AUTH_REQUEST_ID) AS AUTH_REQUEST_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(UNSIGNED_NOTE_ID) AS UNSIGNED_NOTE_ID_filled
INTO #fc_009
FROM AUTH_REQUEST_HX_UNS_NOTE;

-- ---- fc_010 <- BLOCK_NOTE_COPIES ----
-- Info for note copies to potentially block while blocking parent note.
-- Bucket(s): other note/document-adjacent
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_CSN_ID) AS NOTE_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(BLOCK_CPY_NOTE_ID) AS BLOCK_CPY_NOTE_ID_filled,
    COUNT(BLOCK_CPY_YN) AS BLOCK_CPY_YN_filled
INTO #fc_010
FROM BLOCK_NOTE_COPIES
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_011 <- CAREPLAN_PROG_NOTE ----
-- This table contains information about the list of progress notes filed from Care Plans activity for each Care Plan record.
-- Bucket(s): other note/document-adjacent
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CARE_INTG_ID) AS CARE_INTG_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(CP_PROG_NOTES_ID) AS CP_PROG_NOTES_ID_filled
INTO #fc_011
FROM CAREPLAN_PROG_NOTE;

-- ---- fc_012 <- CHILD_NOTE_INFO ----
-- The CHILD_NOTE_INFO table contains information about child notes that are linked to clinical notes. Each row represents one child note and contains information such as the user tha
-- Bucket(s): other note/document-adjacent
SELECT
    YEAR(LINK_UTC) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(TEXT_NOTE_CSN_ID) AS TEXT_NOTE_CSN_ID_filled,
    COUNT(LINK_TYPE_C_NAME) AS LINK_TYPE_C_NAME_filled,
    COUNT(LINK_USER_ID) AS LINK_USER_ID_filled,
    COUNT(LINK_USER_ID_NAME) AS LINK_USER_ID_NAME_filled,
    COUNT(LINK_UTC) AS LINK_UTC_filled,
    COUNT(SOURCE_NOTE_CSN_ID) AS SOURCE_NOTE_CSN_ID_filled,
    COUNT(LINK_DTTM) AS LINK_DTTM_filled
INTO #fc_012
FROM CHILD_NOTE_INFO
GROUP BY YEAR(LINK_UTC);

-- ---- fc_013 <- CLM_NOTE ----
-- All values associated with a claim are stored in the Claim External Value record. The CLM_NOTE table holds claim level notes or remarks.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(RECORD_ID) AS RECORD_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(CLM_NOTE) AS CLM_NOTE_filled
INTO #fc_013
FROM CLM_NOTE;

-- ---- fc_014 <- CONTACT_POINT_DOCUMENTS ----
-- This table contains Clinical References linked to patient education points.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(EDUCATION_RECORD_ID) AS EDUCATION_RECORD_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(CONTACT_POINT_DCS_ID) AS CONTACT_POINT_DCS_ID_filled
INTO #fc_014
FROM CONTACT_POINT_DOCUMENTS
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_015 <- CONTACT_TITLE_DOCUMENTS ----
-- This table contains Clinical References linked to patient education titles.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(EDUCATION_RECORD_ID) AS EDUCATION_RECORD_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(CONTACT_TITLE_DCS_ID) AS CONTACT_TITLE_DCS_ID_filled
INTO #fc_015
FROM CONTACT_TITLE_DOCUMENTS
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_016 <- CONTACT_TOPIC_DOCUMENTS ----
-- This table contains Clinical References linked to patient education topics.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(EDUCATION_RECORD_ID) AS EDUCATION_RECORD_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(CONTACT_TOPIC_DCS_ID) AS CONTACT_TOPIC_DCS_ID_filled
INTO #fc_016
FROM CONTACT_TOPIC_DOCUMENTS
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_017 <- COVERAGE_NOTE_INFO ----
-- This table contains information about notes attached to coverage records.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
SELECT
    YEAR(NOTE_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(COVERAGE_ID) AS COVERAGE_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(NOTE_DATE) AS NOTE_DATE_filled,
    COUNT(NOTE_DTTM) AS NOTE_DTTM_filled,
    COUNT(NOTE_USER_ID) AS NOTE_USER_ID_filled,
    COUNT(NOTE_USER_ID_NAME) AS NOTE_USER_ID_NAME_filled
INTO #fc_017
FROM COVERAGE_NOTE_INFO
GROUP BY YEAR(NOTE_DATE);

-- ---- fc_018 <- CP_NOTE_READING_HX ----
-- This table stores the history information for the note's care plan reading.
-- Bucket(s): other note/document-adjacent
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_CSN_ID) AS NOTE_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(CARE_PLAN_HX_CSN_ID) AS CARE_PLAN_HX_CSN_ID_filled
INTO #fc_018
FROM CP_NOTE_READING_HX
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_019 <- DOCS_RCVD_ASMT_PLAN_NOTE ----
-- This table extracts the related multiple response item DXR-11048.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(DOCUMENT_ID) AS DOCUMENT_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(ASMT_PLAN_NOTE_ID) AS ASMT_PLAN_NOTE_ID_filled
INTO #fc_019
FROM DOCS_RCVD_ASMT_PLAN_NOTE
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_020 <- DOCS_RCVD_CLN_NOTE_SIGNRS ----
-- Clinical note signer information for notes recieved externally.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(DOCUMENT_ID) AS DOCUMENT_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(NOTE_REFERENCE_IDENT) AS NOTE_REFERENCE_IDENT_filled,
    COUNT(NOTE_LOCAL_UNIQUE_IDENT) AS NOTE_LOCAL_UNIQUE_IDENT_filled,
    COUNT(NOTE_SIGNER_NAME) AS NOTE_SIGNER_NAME_filled,
    COUNT(NOTE_SIGNED_UTC_DTTM) AS NOTE_SIGNED_UTC_DTTM_filled,
    COUNT(NOTE_SIGNER_ROLE_C_NAME) AS NOTE_SIGNER_ROLE_C_NAME_filled,
    COUNT(NOTE_SIGNER_NPI) AS NOTE_SIGNER_NPI_filled
INTO #fc_020
FROM DOCS_RCVD_CLN_NOTE_SIGNRS
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_021 <- DOCS_RCVD_INTVN_NOTE ----
-- This table extracts the dispense intervention note associated with a particular dispense.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(DOCUMENT_ID) AS DOCUMENT_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
INTO #fc_021
FROM DOCS_RCVD_INTVN_NOTE
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_022 <- DOCS_RCVD_NOTE_SECTIONS ----
-- Stores note section data received.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(DOCUMENT_ID) AS DOCUMENT_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(NOTE_SECTION_IDENTIFIER) AS NOTE_SECTION_IDENTIFIER_filled,
    COUNT(NOTE_SECTION_TYPE) AS NOTE_SECTION_TYPE_filled,
    COUNT(NOTE_SECTION_NOTE_ID) AS NOTE_SECTION_NOTE_ID_filled,
    COUNT(CONTACT_SERIAL_NUM) AS CONTACT_SERIAL_NUM_filled,
    COUNT(NOTE_SECTION_LENGTH) AS NOTE_SECTION_LENGTH_filled,
    COUNT(HUMAN_REVIEWED_YN) AS HUMAN_REVIEWED_YN_filled
INTO #fc_022
FROM DOCS_RCVD_NOTE_SECTIONS
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_023 <- DOCS_RCVD_PCCNOTE ----
-- This table stores discrete information for patient care coordination notes received from outside sources.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(DOCUMENT_ID) AS DOCUMENT_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(PCCNOTE_REF_ID) AS PCCNOTE_REF_ID_filled,
    COUNT(PCCNOTE_SIGNED_INST_DTTM) AS PCCNOTE_SIGNED_INST_DTTM_filled,
    COUNT(PCCNOTE_AUTHOR) AS PCCNOTE_AUTHOR_filled,
    COUNT(PCCNOTE_ID) AS PCCNOTE_ID_filled,
    COUNT(PCCNOTE_SRC_CSN) AS PCCNOTE_SRC_CSN_filled,
    COUNT(PCC_LST_UPD_INST_DTTM) AS PCC_LST_UPD_INST_DTTM_filled
INTO #fc_023
FROM DOCS_RCVD_PCCNOTE
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_024 <- DOCS_RCVD_RSLTS_ADDENDUM ----
-- This table stores discrete result addendum information received from outside sources.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(DOCUMENT_ID) AS DOCUMENT_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(RSLT_ADDEND_REFID) AS RSLT_ADDEND_REFID_filled,
    COUNT(RSLT_ADDEND_NOTE_ID) AS RSLT_ADDEND_NOTE_ID_filled,
    COUNT(RSLT_ADDEND_INS_UTC_DTTM) AS RSLT_ADDEND_INS_UTC_DTTM_filled
INTO #fc_024
FROM DOCS_RCVD_RSLTS_ADDENDUM
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_025 <- DOCUMENT_SIG_DATA ----
-- Contains data about the signatures collected for an electronic signature document.
-- Bucket(s): other note/document-adjacent
SELECT
    YEAR(SIG_TIMESTAMP_DTTM) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(DOCUMENT_ID) AS DOCUMENT_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(SIG_IMAGE_FILE) AS SIG_IMAGE_FILE_filled,
    COUNT(SIGNATURE_NAME) AS SIGNATURE_NAME_filled,
    COUNT(SIG_TIMESTAMP_DTTM) AS SIG_TIMESTAMP_DTTM_filled,
    COUNT(AUTH_USER_ID) AS AUTH_USER_ID_filled,
    COUNT(AUTH_USER_ID_NAME) AS AUTH_USER_ID_NAME_filled,
    COUNT(AUTH_MYPT_ID) AS AUTH_MYPT_ID_filled,
    COUNT(SIGNATURE_HIDDEN_YN) AS SIGNATURE_HIDDEN_YN_filled
INTO #fc_025
FROM DOCUMENT_SIG_DATA
GROUP BY YEAR(SIG_TIMESTAMP_DTTM);

-- ---- fc_026 <- DOCUMENT_SMARTFORM_LIST ----
-- Contains the SmartForm records for a given document.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(DOCUMENT_ID) AS DOCUMENT_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(DOCUMENT_SMARTFORM) AS DOCUMENT_SMARTFORM_filled
INTO #fc_026
FROM DOCUMENT_SMARTFORM_LIST;

-- ---- fc_027 <- DOCUMENT_STAMPS ----
-- This table contains information about stamps added to scanned documents.
-- Bucket(s): other note/document-adjacent
SELECT
    YEAR(STAMP_ADDED_UTC_DTTM) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(DOCUMENT_ID) AS DOCUMENT_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(STAMP_TEXT) AS STAMP_TEXT_filled,
    COUNT(STAMP_TYPE_C_NAME) AS STAMP_TYPE_C_NAME_filled,
    COUNT(STAMP_ADD_USER_ID) AS STAMP_ADD_USER_ID_filled,
    COUNT(STAMP_ADD_USER_ID_NAME) AS STAMP_ADD_USER_ID_NAME_filled,
    COUNT(STAMP_ADDED_UTC_DTTM) AS STAMP_ADDED_UTC_DTTM_filled
INTO #fc_027
FROM DOCUMENT_STAMPS
GROUP BY YEAR(STAMP_ADDED_UTC_DTTM);

-- ---- fc_028 <- DP_COMM_MEMO_NOTE ----
-- This table contains the Free Text Note(HNO) IDs of communications sent to a service through the Continued Care and Services Coordination workflow, along with the patient CSN, patie
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(PAT_ID) AS PAT_ID_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(CM_CT_OWNER_ID) AS CM_CT_OWNER_ID_filled,
    COUNT(COMM_MEMO_NOTE_ID) AS COMM_MEMO_NOTE_ID_filled
INTO #fc_028
FROM DP_COMM_MEMO_NOTE
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_029 <- DP_SVC_COORD_NOTE ----
-- Coordination notes from the Services to Coordinate section of the current patient encounter--used to leave care coordination notes specific to this patient to a user, or to other u
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(PAT_ID) AS PAT_ID_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(CM_CT_OWNER_ID) AS CM_CT_OWNER_ID_filled,
    COUNT(COORD_NOTE_ID) AS COORD_NOTE_ID_filled,
    COUNT(NOTE_IS_PINNED_YN) AS NOTE_IS_PINNED_YN_filled
INTO #fc_029
FROM DP_SVC_COORD_NOTE
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_030 <- EMBRYOLOGY_DOCUMENTS ----
-- Table for the documents associated with embryology results.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(RESULT_ID) AS RESULT_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(EMBRYOLOGY_DOCUMENT_ID) AS EMBRYOLOGY_DOCUMENT_ID_filled
INTO #fc_030
FROM EMBRYOLOGY_DOCUMENTS;

-- ---- fc_031 <- ENC_DX_ASSOC_AMBIENT_DX ----
-- This table contains the unique IDs of diagnoses provided by Ambient that were finalized to Visit Diagnoses on the encounter.
-- Bucket(s): ambient/AI-scribe (Epic-native — directly Suki-comparable)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(PAT_ID) AS PAT_ID_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(CM_CT_OWNER_ID) AS CM_CT_OWNER_ID_filled,
    COUNT(DX_ASSOC_AMBIENT_DX) AS DX_ASSOC_AMBIENT_DX_filled
INTO #fc_031
FROM ENC_DX_ASSOC_AMBIENT_DX
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_032 <- EPRESCRIBE_ERROR_ACTIONS ----
-- This table holds information about e-prescribing error resolution triggered before the May 23 version. E-prescribing error resolution on or after the upgrade to the May 23 version 
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
SELECT
    YEAR(RESOLVED_UTC_DTTM) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(ORDER_ID) AS ORDER_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(RESOLVING_ACTION_C_NAME) AS RESOLVING_ACTION_C_NAME_filled,
    COUNT(RESOLVING_USER_ID) AS RESOLVING_USER_ID_filled,
    COUNT(RESOLVING_USER_ID_NAME) AS RESOLVING_USER_ID_NAME_filled,
    COUNT(RESOLVED_UTC_DTTM) AS RESOLVED_UTC_DTTM_filled
INTO #fc_032
FROM EPRESCRIBE_ERROR_ACTIONS
GROUP BY YEAR(RESOLVED_UTC_DTTM);

-- ---- fc_033 <- FIN_ASST_CASE_DOCUMENTS ----
-- The documents associated with a Financial Assistance Case.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(FIN_ASST_CASE_ID) AS FIN_ASST_CASE_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(DOCUMENT_ID) AS DOCUMENT_ID_filled
INTO #fc_033
FROM FIN_ASST_CASE_DOCUMENTS;

-- ---- fc_034 <- FIN_ASST_CASE_SMARTFORM ----
-- This table stores the SmartForm used in a financial assistance case record.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(FIN_ASST_CASE_ID) AS FIN_ASST_CASE_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(SMARTFORM_ID) AS SMARTFORM_ID_filled,
    COUNT(SMARTFORM_VER) AS SMARTFORM_VER_filled
INTO #fc_034
FROM FIN_ASST_CASE_SMARTFORM;

-- ---- fc_035 <- FIN_ASST_NOTE ----
-- This table contains information about notes added to financial assistance tracker records.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
SELECT
    YEAR(ENTRY_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(HNO_RECORD_TYPE_C_NAME) AS HNO_RECORD_TYPE_C_NAME_filled,
    COUNT(ENTRY_PERSON_USER_ID) AS ENTRY_PERSON_USER_ID_filled,
    COUNT(ENTRY_PERSON_USER_ID_NAME) AS ENTRY_PERSON_USER_ID_NAME_filled,
    COUNT(ENTRY_DATE) AS ENTRY_DATE_filled,
    COUNT(ACCT_NOTE_INSTANT_DTTM) AS ACCT_NOTE_INSTANT_DTTM_filled,
    COUNT(ACCT_NOTE_SUMMARY) AS ACCT_NOTE_SUMMARY_filled,
    COUNT(SYSTEM_GEN_YN) AS SYSTEM_GEN_YN_filled,
    COUNT(FIN_ASST_CASE_ID) AS FIN_ASST_CASE_ID_filled
INTO #fc_035
FROM FIN_ASST_NOTE
GROUP BY YEAR(ENTRY_DATE);

-- ---- fc_036 <- FLOWSHT_NOTE_AUDIT ----
-- The audit trail of the notes that are linked to flowsheet data.
-- Bucket(s): other note/document-adjacent
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(FSD_ID) AS FSD_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(AUDIT_LINKD_NOTE_ID) AS AUDIT_LINKD_NOTE_ID_filled
INTO #fc_036
FROM FLOWSHT_NOTE_AUDIT;

-- ---- fc_037 <- FLO_INST_COSIGNED ----
-- This table displays times that cosigners cosigned the flowsheet data.
-- Bucket(s): signature/cosign/attestation
SELECT
    YEAR(INSTANT_COSIGNED_TM) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(FSD_ID) AS FSD_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(INSTANT_COSIGNED_TM) AS INSTANT_COSIGNED_TM_filled
INTO #fc_037
FROM FLO_INST_COSIGNED
GROUP BY YEAR(INSTANT_COSIGNED_TM);

-- ---- fc_038 <- FLO_USER_COSIGNED ----
-- Users that were either requested to cosign the data or did cosign the data.
-- Bucket(s): signature/cosign/attestation
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(FSD_ID) AS FSD_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(USER_COSIGNED_ID) AS USER_COSIGNED_ID_filled,
    COUNT(USER_COSIGNED_ID_NAME) AS USER_COSIGNED_ID_NAME_filled
INTO #fc_038
FROM FLO_USER_COSIGNED;

-- ---- fc_039 <- HNO_ABN_ORD_REASON ----
-- The order reasons on the Advance Beneficiary Notice (ABN) form for why the order failed medical necessity checks.
-- Bucket(s): core note lifecycle
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(ABN_ORD_REASONS) AS ABN_ORD_REASONS_filled
INTO #fc_039
FROM HNO_ABN_ORD_REASON;

-- ---- fc_040 <- HNO_ABN_PROCEDURES ----
-- This table contains the procedures listed on the Advance Beneficiary Notice (ABN) form.
-- Bucket(s): core note lifecycle
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(ABN_PROCEDURE_ID_PROC_NAME) AS ABN_PROCEDURE_ID_PROC_NAME_filled
INTO #fc_040
FROM HNO_ABN_PROCEDURES;

-- ---- fc_041 <- HNO_CONSULT_ORD_ID ----
-- This table contains the unique IDs of the consult orders that are attached to a note.
-- Bucket(s): core note lifecycle
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_CSN_ID) AS NOTE_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(CONSULT_ORDER_ID) AS CONSULT_ORDER_ID_filled
INTO #fc_041
FROM HNO_CONSULT_ORD_ID
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_042 <- HNO_ECG_DX ----
-- This table contains the diagnosis for Electrocardiograms (ECG/EKG) that have been stored on General Use Notes (HNO) records.
-- Bucket(s): core note lifecycle
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_CSN_ID) AS NOTE_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(ECG_DX) AS ECG_DX_filled
INTO #fc_042
FROM HNO_ECG_DX
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_043 <- HNO_INFO ----
-- This table contains common information from General Use Notes items. This table focuses on time-insensitive, once-per-record data while other HNO tables (e.g., NOTES_ACCT, CODING_C
-- Bucket(s): core note lifecycle
SELECT
    YEAR(CREATE_INSTANT_DTTM) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(NOTE_TYPE_NOADD_C_NAME) AS NOTE_TYPE_NOADD_C_NAME_filled,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(ENTRY_USER_ID) AS ENTRY_USER_ID_filled,
    COUNT(ENTRY_USER_ID_NAME) AS ENTRY_USER_ID_NAME_filled,
    COUNT(NOTE_DESC) AS NOTE_DESC_filled,
    COUNT(IP_NOTE_TYPE_C_NAME) AS IP_NOTE_TYPE_C_NAME_filled,
    COUNT(ORIGINAL_HP_ID) AS ORIGINAL_HP_ID_filled,
    COUNT(ORIG_HP_DATE_REAL) AS ORIG_HP_DATE_REAL_filled,
    COUNT(SOURCE_HP_ID) AS SOURCE_HP_ID_filled,
    COUNT(SOURCE_HP_DATE_REAL) AS SOURCE_HP_DATE_REAL_filled,
    COUNT(ECG_TECHNICIAN_ID) AS ECG_TECHNICIAN_ID_filled,
    COUNT(PAT_LINK_ID) AS PAT_LINK_ID_filled,
    COUNT(LETTER_SUMMARY) AS LETTER_SUMMARY_filled,
    COUNT(TX_IB_FOLDER_C_NAME) AS TX_IB_FOLDER_C_NAME_filled,
    COUNT(CREATE_INSTANT_DTTM) AS CREATE_INSTANT_DTTM_filled,
    COUNT(UNSIGNED_YN) AS UNSIGNED_YN_filled,
    COUNT(DELETE_INSTANT_DTTM) AS DELETE_INSTANT_DTTM_filled,
    COUNT(DELETE_USER_ID) AS DELETE_USER_ID_filled,
    COUNT(DELETE_USER_ID_NAME) AS DELETE_USER_ID_NAME_filled,
    COUNT(COSIGNED_NOTE_LINK) AS COSIGNED_NOTE_LINK_filled,
    COUNT(DATE_OF_SERVIC_DTTM) AS DATE_OF_SERVIC_DTTM_filled,
    COUNT(SIGNED_NOTE_ID) AS SIGNED_NOTE_ID_filled,
    COUNT(LST_FILED_INST_DTTM) AS LST_FILED_INST_DTTM_filled,
    COUNT(UPDATE_DATE) AS UPDATE_DATE_filled,
    COUNT(CURRENT_AUTHOR_ID) AS CURRENT_AUTHOR_ID_filled,
    COUNT(CURRENT_AUTHOR_ID_NAME) AS CURRENT_AUTHOR_ID_NAME_filled,
    COUNT(LETTER_TYPE_C_NAME) AS LETTER_TYPE_C_NAME_filled,
    COUNT(VISIT_NUM) AS VISIT_NUM_filled,
    COUNT(CRT_INST_LOCAL_DTTM) AS CRT_INST_LOCAL_DTTM_filled,
    COUNT(PRIORITY_YN) AS PRIORITY_YN_filled,
    COUNT(ACTIVE_FROM_DT) AS ACTIVE_FROM_DT_filled,
    COUNT(ACTIVE_TO_DT) AS ACTIVE_TO_DT_filled,
    COUNT(TREAT_SUM_RLS_TO_MYC_YN) AS TREAT_SUM_RLS_TO_MYC_YN_filled,
    COUNT(TREAT_SUM_RLS_TO_MYC_CSN) AS TREAT_SUM_RLS_TO_MYC_CSN_filled,
    COUNT(COMMENT_USER_ID) AS COMMENT_USER_ID_filled,
    COUNT(COMMENT_USER_ID_NAME) AS COMMENT_USER_ID_NAME_filled,
    COUNT(COMMENT_EDIT_INST_DTTM) AS COMMENT_EDIT_INST_DTTM_filled,
    COUNT(CONVERSATION_MSG_ID) AS CONVERSATION_MSG_ID_filled
INTO #fc_043
FROM HNO_INFO
GROUP BY YEAR(CREATE_INSTANT_DTTM);

-- ---- fc_044 <- HNO_INFO_2 ----
-- This table contains common information from General Use Notes items. This table focuses on one time only data while other HNO tables (e.g., NOTES_ACCT, CODING_CLA_NOTES) contain th
-- Bucket(s): core note lifecycle
SELECT
    YEAR(LETTER_FINAL_UTC_DTTM) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(RELEVANT_REC_EVENT_ID) AS RELEVANT_REC_EVENT_ID_filled,
    COUNT(GROUP_NOTE_ID) AS GROUP_NOTE_ID_filled,
    COUNT(LETTER_DEST_C_NAME) AS LETTER_DEST_C_NAME_filled,
    COUNT(LETTER_FINAL_UTC_DTTM) AS LETTER_FINAL_UTC_DTTM_filled,
    COUNT(HNO_RECORD_TYPE_C_NAME) AS HNO_RECORD_TYPE_C_NAME_filled,
    COUNT(RFL_LETTER_ENC_CSN) AS RFL_LETTER_ENC_CSN_filled,
    COUNT(CONV_MSG_CID) AS CONV_MSG_CID_filled,
    COUNT(OUTREACH_TEMPLATE_ID) AS OUTREACH_TEMPLATE_ID_filled,
    COUNT(SOURCE_EDITS_CSN) AS SOURCE_EDITS_CSN_filled,
    COUNT(EXT_DOC_EVNT_ID) AS EXT_DOC_EVNT_ID_filled,
    COUNT(EXT_NOTE_TYPE) AS EXT_NOTE_TYPE_filled,
    COUNT(EXT_DUP_NOTE_ID) AS EXT_DUP_NOTE_ID_filled,
    COUNT(EXT_DUP_NOTE_C_NAME) AS EXT_DUP_NOTE_C_NAME_filled,
    COUNT(PARENT_NOTE_ID) AS PARENT_NOTE_ID_filled,
    COUNT(ACTIVE_C_NAME) AS ACTIVE_C_NAME_filled,
    COUNT(EXT_AUTHOR) AS EXT_AUTHOR_filled,
    COUNT(NOTE_UPDATE_INST_UTC_DTTM) AS NOTE_UPDATE_INST_UTC_DTTM_filled,
    COUNT(ROUT_RECPNT_COMMUNICATION_ID) AS ROUT_RECPNT_COMMUNICATION_ID_filled,
    COUNT(EXTERNAL_SOURCE_IDENT) AS EXTERNAL_SOURCE_IDENT_filled,
    COUNT(EXTERNAL_PROBLEM_IDENT) AS EXTERNAL_PROBLEM_IDENT_filled,
    COUNT(TRANSLATION_IDENTIFIER) AS TRANSLATION_IDENTIFIER_filled,
    COUNT(TRANSLATION_LANGUAGE_ID) AS TRANSLATION_LANGUAGE_ID_filled,
    COUNT(TRANSLATION_LANGUAGE_ID_LANGUAGE_NAME) AS TRANSLATION_LANGUAGE_ID_LANGUAGE_NAME_filled,
    COUNT(NOT_RESEARCH_RELATED_YN) AS NOT_RESEARCH_RELATED_YN_filled,
    COUNT(PRIVATE_YN) AS PRIVATE_YN_filled
INTO #fc_044
FROM HNO_INFO_2
GROUP BY YEAR(LETTER_FINAL_UTC_DTTM);

-- ---- fc_045 <- HNO_LET_DICTN ----
-- This table contains the items associated with letter dictations.
-- Bucket(s): dictation/transcription
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_CSN_ID) AS NOTE_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(LET_DICTN_USER_ID) AS LET_DICTN_USER_ID_filled,
    COUNT(LET_DICTN_USER_ID_NAME) AS LET_DICTN_USER_ID_NAME_filled
INTO #fc_045
FROM HNO_LET_DICTN;

-- ---- fc_046 <- HNO_LINKED_PATS ----
-- Linked patients for EHI Export.
-- Bucket(s): core note lifecycle
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(LINKED_PAT_ID) AS LINKED_PAT_ID_filled
INTO #fc_046
FROM HNO_LINKED_PATS;

-- ---- fc_047 <- HNO_LINKED_RQGS ----
-- This table stores the list of requisition groupers associated with a note.
-- Bucket(s): core note lifecycle
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(RQG_GROUPER_ID) AS RQG_GROUPER_ID_filled
INTO #fc_047
FROM HNO_LINKED_RQGS;

-- ---- fc_048 <- HNO_MYC_LET_INFO ----
-- This table contains MyChart related information for letters. It includes whether a letter is released to MyChart and the date/time it was released to MyChart.
-- Bucket(s): core note lifecycle
SELECT
    YEAR(LET_REL_MYC_DTTM) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(LET_REL_MYC_DTTM) AS LET_REL_MYC_DTTM_filled,
    COUNT(LET_REL_TO_MYC_YN) AS LET_REL_TO_MYC_YN_filled
INTO #fc_048
FROM HNO_MYC_LET_INFO
GROUP BY YEAR(LET_REL_MYC_DTTM);

-- ---- fc_049 <- HNO_ORDERS ----
-- Orders that are associated to the note.
-- Bucket(s): core note lifecycle
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(ORDER_ID) AS ORDER_ID_filled,
    COUNT(ORDER_DAT) AS ORDER_DAT_filled
INTO #fc_049
FROM HNO_ORDERS;

-- ---- fc_050 <- HNO_PLACEHOLDER_CHARGE ----
-- Contains items related to Create Placeholder Charge action.
-- Bucket(s): core note lifecycle
SELECT
    YEAR(CHG_ACTION_UTC_DTTM) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(CHG_CREATED_YN) AS CHG_CREATED_YN_filled,
    COUNT(CHG_ACTION_USER_ID) AS CHG_ACTION_USER_ID_filled,
    COUNT(CHG_ACTION_USER_ID_NAME) AS CHG_ACTION_USER_ID_NAME_filled,
    COUNT(CHG_ACTION_UTC_DTTM) AS CHG_ACTION_UTC_DTTM_filled,
    COUNT(CHG_PROC_ID_PROC_NAME) AS CHG_PROC_ID_PROC_NAME_filled,
    COUNT(CHG_FAIL_REASON_C_NAME) AS CHG_FAIL_REASON_C_NAME_filled
INTO #fc_050
FROM HNO_PLACEHOLDER_CHARGE
GROUP BY YEAR(CHG_ACTION_UTC_DTTM);

-- ---- fc_051 <- HNO_PLAIN_TEXT ----
-- This table extracts notes that are stored only in plain text. This table does not contain any notes that are stored in rich text. HNO_NOTE_TEXT should still be used for reporting p
-- Bucket(s): core note lifecycle
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_CSN_ID) AS NOTE_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(NOTE_TEXT) AS NOTE_TEXT_filled
INTO #fc_051
FROM HNO_PLAIN_TEXT;

-- ---- fc_052 <- HNO_SCREENING_PROGRAM ----
-- Screening program associated with the radiology letter.
-- Bucket(s): core note lifecycle
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(SCREENING_PROGRAM_C_NAME) AS SCREENING_PROGRAM_C_NAME_filled
INTO #fc_052
FROM HNO_SCREENING_PROGRAM;

-- ---- fc_053 <- HNO_SMARTFORM_LINK ----
-- This table contains a list of SmartBlocks and the SmartForms that are linked to those SmartBlocks in a particular note.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_CSN_ID) AS NOTE_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(SMARTFORM_ID) AS SMARTFORM_ID_filled,
    COUNT(SMARTFORM_ID_FORM_NAME) AS SMARTFORM_ID_FORM_NAME_filled,
    COUNT(SMARTFORM_DAT) AS SMARTFORM_DAT_filled,
    COUNT(LINKED_ORDER_ID) AS LINKED_ORDER_ID_filled,
    COUNT(SMARTDATA_ID) AS SMARTDATA_ID_filled
INTO #fc_053
FROM HNO_SMARTFORM_LINK
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_054 <- HNO_SOURCE_LOG_ID ----
-- This table displays the surgical log where a note was edited.
-- Bucket(s): core note lifecycle
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_CSN_ID) AS NOTE_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(SOURCE_LOG_ID) AS SOURCE_LOG_ID_filled
INTO #fc_054
FROM HNO_SOURCE_LOG_ID
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_055 <- HOLOGRAM_AMBIENT_DX_INFO ----
-- This table contains information about the Ambient diagnosis choices that were presented to a clinician.
-- Bucket(s): ambient/AI-scribe (Epic-native — directly Suki-comparable)
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(HOLOGRAM_ID) AS HOLOGRAM_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(AMBIENT_DX_SOURCE_C_NAME) AS AMBIENT_DX_SOURCE_C_NAME_filled,
    COUNT(AMBIENT_DX_LNK_PROB_LST_ID) AS AMBIENT_DX_LNK_PROB_LST_ID_filled,
    COUNT(AMBIENT_DX_LINKED_VDX) AS AMBIENT_DX_LINKED_VDX_filled,
    COUNT(AMBIENT_DX_AUTO_MATCH_YN) AS AMBIENT_DX_AUTO_MATCH_YN_filled,
    COUNT(ADD_DX_TO_PROBLIST_YN) AS ADD_DX_TO_PROBLIST_YN_filled,
    COUNT(INITIAL_DX_ID_DX_NAME) AS INITIAL_DX_ID_DX_NAME_filled,
    COUNT(AMBIENT_PAST_DX_CSN) AS AMBIENT_PAST_DX_CSN_filled
INTO #fc_055
FROM HOLOGRAM_AMBIENT_DX_INFO;

-- ---- fc_056 <- HOLOGRAM_AMBIENT_FAM_HX ----
-- This table contains information about the Ambient family history choices that were presented to a clinician.
-- Bucket(s): ambient/AI-scribe (Epic-native — directly Suki-comparable)
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(HOLOGRAM_ID) AS HOLOGRAM_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(FAM_STAT_REL_C_NAME) AS FAM_STAT_REL_C_NAME_filled,
    COUNT(FAM_STAT_ID) AS FAM_STAT_ID_filled,
    COUNT(FAM_STT_NAM) AS FAM_STT_NAM_filled,
    COUNT(FAM_STAT_STATUS_C_NAME) AS FAM_STAT_STATUS_C_NAME_filled,
    COUNT(FAM_MEDICAL_HX_C_NAME) AS FAM_MEDICAL_HX_C_NAME_filled,
    COUNT(FAM_MEDICAL_DX_ID_DX_NAME) AS FAM_MEDICAL_DX_ID_DX_NAME_filled,
    COUNT(AGE_OF_ONSET) AS AGE_OF_ONSET_filled,
    COUNT(AGE_OF_ONSET_END) AS AGE_OF_ONSET_END_filled
INTO #fc_056
FROM HOLOGRAM_AMBIENT_FAM_HX;

-- ---- fc_057 <- HOLOGRAM_DETAILS ----
-- This table stores workflow-level information about documentation pieces that have been queued up and suspended during an outpatient visit.
-- Bucket(s): ambient/AI-scribe (Epic-native — directly Suki-comparable)
SELECT
    YEAR(WORKFLOW_INST_UTC_DTTM) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(HOLOGRAM_ID) AS HOLOGRAM_ID_filled,
    COUNT(PAT_ID) AS PAT_ID_filled,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(HOLOGRAM_STATUS_C_NAME) AS HOLOGRAM_STATUS_C_NAME_filled,
    COUNT(WORKFLOW_USER_ID) AS WORKFLOW_USER_ID_filled,
    COUNT(WORKFLOW_USER_ID_NAME) AS WORKFLOW_USER_ID_NAME_filled,
    COUNT(WORKFLOW_PROV_ID_PROV_NAME) AS WORKFLOW_PROV_ID_PROV_NAME_filled,
    COUNT(WORKFLOW_INST_UTC_DTTM) AS WORKFLOW_INST_UTC_DTTM_filled
INTO #fc_057
FROM HOLOGRAM_DETAILS
GROUP BY YEAR(WORKFLOW_INST_UTC_DTTM);

-- ---- fc_058 <- HOLOGRAM_SELECTIONS ----
-- This table stores details about each selection made in a hologram record. Which specific details are stored depends on the type of each row.
-- Bucket(s): ambient/AI-scribe (Epic-native — directly Suki-comparable)
SELECT
    YEAR(IMMNZTN_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(HOLOGRAM_ID) AS HOLOGRAM_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(DISPLAY_NAME) AS DISPLAY_NAME_filled,
    COUNT(LEVEL_OF_SERVICE_PROC_ID_PROC_NAME) AS LEVEL_OF_SERVICE_PROC_ID_PROC_NAME_filled,
    COUNT(SMARTTEXT_TYPE_C_NAME) AS SMARTTEXT_TYPE_C_NAME_filled,
    COUNT(SMARTTEXT_NOTE_TYPE_IP_C_NAME) AS SMARTTEXT_NOTE_TYPE_IP_C_NAME_filled,
    COUNT(SMARTTEXT_ADDED_NOW_YN) AS SMARTTEXT_ADDED_NOW_YN_filled,
    COUNT(SMARTTEXT_MAKE_SENSITIVE_YN) AS SMARTTEXT_MAKE_SENSITIVE_YN_filled,
    COUNT(DX_ID_DX_NAME) AS DX_ID_DX_NAME_filled,
    COUNT(DX_DESCRIPTION) AS DX_DESCRIPTION_filled,
    COUNT(DX_QUAL_2_C_NAME) AS DX_QUAL_2_C_NAME_filled,
    COUNT(DX_COMMENT) AS DX_COMMENT_filled,
    COUNT(DX_PRIMARY_YN) AS DX_PRIMARY_YN_filled,
    COUNT(DX_CHRONIC_YN) AS DX_CHRONIC_YN_filled,
    COUNT(IMMUN_ID) AS IMMUN_ID_filled,
    COUNT(IMMUN_ID_NAME) AS IMMUN_ID_NAME_filled,
    COUNT(IMMNZTN_DOSE) AS IMMNZTN_DOSE_filled,
    COUNT(IMMNZTN_DOSE_AMOUNT) AS IMMNZTN_DOSE_AMOUNT_filled,
    COUNT(IMMNZTN_DISP_QTYUNIT_C_NAME) AS IMMNZTN_DISP_QTYUNIT_C_NAME_filled,
    COUNT(IMMNZTN_ROUTE_C_NAME) AS IMMNZTN_ROUTE_C_NAME_filled,
    COUNT(IMMNZTN_SITE_C_NAME) AS IMMNZTN_SITE_C_NAME_filled,
    COUNT(IMMNZTN_MANUFACTURER_MFG_C_NAME) AS IMMNZTN_MANUFACTURER_MFG_C_NAME_filled,
    COUNT(IMMNZTN_LOT_NUMBER) AS IMMNZTN_LOT_NUMBER_filled,
    COUNT(IMMNZTN_PRODUCT) AS IMMNZTN_PRODUCT_filled,
    COUNT(IMMNZTN_NDC_ID) AS IMMNZTN_NDC_ID_filled,
    COUNT(IMMNZTN_NDC_ID_NDC_CODE) AS IMMNZTN_NDC_ID_NDC_CODE_filled,
    COUNT(IMMNZTN_IMM_PRODUCT_C_NAME) AS IMMNZTN_IMM_PRODUCT_C_NAME_filled,
    COUNT(IMMNZTN_DATE) AS IMMNZTN_DATE_filled,
    COUNT(IMMNZTN_INSTANT_UTC_DTTM) AS IMMNZTN_INSTANT_UTC_DTTM_filled,
    COUNT(IMMNZTN_INVENTORY_CLASS_C_NAME) AS IMMNZTN_INVENTORY_CLASS_C_NAME_filled,
    COUNT(IMMNZTN_LOT_NUM_ID_LOT_NUM) AS IMMNZTN_LOT_NUM_ID_LOT_NUM_filled,
    COUNT(IMMNZTN_NEXT_DUE_DATE) AS IMMNZTN_NEXT_DUE_DATE_filled,
    COUNT(IMMNZTN_EXPIRATION_DATE) AS IMMNZTN_EXPIRATION_DATE_filled,
    COUNT(IMMNZTN_IMM_DEFER_DUR_C_NAME) AS IMMNZTN_IMM_DEFER_DUR_C_NAME_filled,
    COUNT(IMMNZTN_GIVEN_BY_USER_ID) AS IMMNZTN_GIVEN_BY_USER_ID_filled,
    COUNT(IMMNZTN_GIVEN_BY_USER_ID_NAME) AS IMMNZTN_GIVEN_BY_USER_ID_NAME_filled,
    COUNT(IMMNZTN_EXTERNAL_ADMIN_C_NAME) AS IMMNZTN_EXTERNAL_ADMIN_C_NAME_filled,
    COUNT(IMMNZTN_VIS_DATE) AS IMMNZTN_VIS_DATE_filled,
    COUNT(IMMNZTN_DEFER_REASON_C_NAME) AS IMMNZTN_DEFER_REASON_C_NAME_filled,
    COUNT(IMMNZTN_ADMIN_COMMENT) AS IMMNZTN_ADMIN_COMMENT_filled,
    COUNT(IMMNZTN_ADMIN_LOCATION) AS IMMNZTN_ADMIN_LOCATION_filled,
    COUNT(IMMNZTN_STATUS_C_NAME) AS IMMNZTN_STATUS_C_NAME_filled,
    COUNT(LOS_COMPONENT_PROC_ID_PROC_NAME) AS LOS_COMPONENT_PROC_ID_PROC_NAME_filled,
    COUNT(COMPONENT_LOS_NEW_OR_EST_C_NAME) AS COMPONENT_LOS_NEW_OR_EST_C_NAME_filled,
    COUNT(LOS_COMPONENT_COUNSEL_TIME) AS LOS_COMPONENT_COUNSEL_TIME_filled,
    COUNT(COMPONENT_LOS_HX_LEVEL_C_NAME) AS COMPONENT_LOS_HX_LEVEL_C_NAME_filled,
    COUNT(COMPONENT_LOS_EXAM_LEVEL_C_NAME) AS COMPONENT_LOS_EXAM_LEVEL_C_NAME_filled,
    COUNT(COMPONENT_LOS_MDM_LEVEL_C_NAME) AS COMPONENT_LOS_MDM_LEVEL_C_NAME_filled,
    COUNT(LOS_COMPONENT_PROC_CALC_YN) AS LOS_COMPONENT_PROC_CALC_YN_filled,
    COUNT(FUP_NUMBER_OF_UNITS) AS FUP_NUMBER_OF_UNITS_filled,
    COUNT(FUP_TYPE_OF_UNIT_C_NAME) AS FUP_TYPE_OF_UNIT_C_NAME_filled,
    COUNT(FUP_APPROX_YN) AS FUP_APPROX_YN_filled,
    COUNT(FUP_PRN_YN) AS FUP_PRN_YN_filled,
    COUNT(FUP_RETURN_FOR_TEXT) AS FUP_RETURN_FOR_TEXT_filled,
    COUNT(FUP_CODIFIED_C_NAME) AS FUP_CODIFIED_C_NAME_filled,
    COUNT(FUP_INSTRUCTIONS_CODIFIED_C_NAME) AS FUP_INSTRUCTIONS_CODIFIED_C_NAME_filled,
    COUNT(FUP_COPY_TO_PCP_YN) AS FUP_COPY_TO_PCP_YN_filled,
    COUNT(FUP_SEND_REMINDER_YN) AS FUP_SEND_REMINDER_YN_filled,
    COUNT(FUP_REMINDER_DAYS) AS FUP_REMINDER_DAYS_filled,
    COUNT(FUP_PRN_TEXT) AS FUP_PRN_TEXT_filled,
    COUNT(FUP_REMINDER_MESSAGE) AS FUP_REMINDER_MESSAGE_filled,
    COUNT(FUP_ROUTING_PRIORITY_C_NAME) AS FUP_ROUTING_PRIORITY_C_NAME_filled,
    COUNT(FUP_ROUTING_COMMENT) AS FUP_ROUTING_COMMENT_filled,
    COUNT(FUP_USER_ACCEPTED_YN) AS FUP_USER_ACCEPTED_YN_filled,
    COUNT(NT_DISPOSITION_PHONE_DISP_C_NAME) AS NT_DISPOSITION_PHONE_DISP_C_NAME_filled,
    COUNT(NT_DISPOSITION_LOC_ID_LOC_NAME) AS NT_DISPOSITION_LOC_ID_LOC_NAME_filled,
    COUNT(NT_DISPOSITION_COMMENT) AS NT_DISPOSITION_COMMENT_filled,
    COUNT(NT_DISPOSITION_DEPARTMENT_ID_EXTERNAL_NAME) AS NT_DISPOSITION_DEPARTMENT_ID_EXTERNAL_NAME_filled,
    COUNT(NT_DISP_INSTANT_UTC_DTTM) AS NT_DISP_INSTANT_UTC_DTTM_filled,
    COUNT(REASON_FOR_VISIT_RFV_ID_REASON_VISIT_NAME) AS REASON_FOR_VISIT_RFV_ID_REASON_VISIT_NAME_filled,
    COUNT(REASON_FOR_VISIT_COMMENT) AS REASON_FOR_VISIT_COMMENT_filled,
    COUNT(REASON_FOR_VISIT_ONSET_DATE) AS REASON_FOR_VISIT_ONSET_DATE_filled
INTO #fc_058
FROM HOLOGRAM_SELECTIONS
GROUP BY YEAR(IMMNZTN_DATE);

-- ---- fc_059 <- HOLOGRAM_SELECTIONS_2 ----
-- This table stores details about each selection made in a hologram record. Which specific details are stored depends on the type of each row. Extends HOLOGRAM_SELECTIONS.
-- Bucket(s): ambient/AI-scribe (Epic-native — directly Suki-comparable)
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(HOLOGRAM_ID) AS HOLOGRAM_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(HOL_IS_SELECTED_YN) AS HOL_IS_SELECTED_YN_filled
INTO #fc_059
FROM HOLOGRAM_SELECTIONS_2;

-- ---- fc_060 <- HOLO_SMARTTEXT_NOTE_TXT ----
-- This table contains note text temporarily stored in a hologram record.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(HOLOGRAM_ID) AS HOLOGRAM_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(SMARTTEXT_NOTE_TEXT) AS SMARTTEXT_NOTE_TEXT_filled
INTO #fc_060
FROM HOLO_SMARTTEXT_NOTE_TXT;

-- ---- fc_061 <- HSP_ACCT_BILL_NOTE ----
-- This table contains hospital account billing notes from the Hospital Accounts Receivable (HAR) master file.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(HSP_ACCOUNT_ID) AS HSP_ACCOUNT_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(BILLING_NOTE) AS BILLING_NOTE_filled
INTO #fc_061
FROM HSP_ACCT_BILL_NOTE;

-- ---- fc_062 <- INCOMPLETE_NOTE_EPT ----
-- Table created for the visit narrative data stored in the patient masterfile. No longer used since we use UCN now since 2010, exporting these items as a formality.
-- Bucket(s): other note/document-adjacent
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(PAT_ID) AS PAT_ID_filled,
    COUNT(PAT_ENC_DATE_REAL) AS PAT_ENC_DATE_REAL_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(INC_NOTE_USER_ID) AS INC_NOTE_USER_ID_filled,
    COUNT(INC_NOTE_USER_ID_NAME) AS INC_NOTE_USER_ID_NAME_filled,
    COUNT(INC_NOTE_NOTE_ID) AS INC_NOTE_NOTE_ID_filled,
    COUNT(INC_NOTE_TYPE_C_NAME) AS INC_NOTE_TYPE_C_NAME_filled,
    COUNT(INC_NOTE_MSG_ID) AS INC_NOTE_MSG_ID_filled,
    COUNT(INC_NOTE_START_DATE_UTC_DTTM) AS INC_NOTE_START_DATE_UTC_DTTM_filled,
    COUNT(INC_NOTE_LAST_EDIT_UTC_DTTM) AS INC_NOTE_LAST_EDIT_UTC_DTTM_filled
INTO #fc_062
FROM INCOMPLETE_NOTE_EPT
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_063 <- INTERV_NOTE_INFO ----
-- This table links a care plan goal note contact to the related intervention note contacts that were filed at the same time.
-- Bucket(s): other note/document-adjacent
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_CSN_ID) AS NOTE_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(INTERV_NOTE_CSN_ID) AS INTERV_NOTE_CSN_ID_filled
INTO #fc_063
FROM INTERV_NOTE_INFO
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_064 <- INTERV_SMARTTEXT ----
-- This table displays the SmartTexts that are associated with intervention (LPI) records.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(INTERVENTION_ID) AS INTERVENTION_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(SMARTTEXTS_ID) AS SMARTTEXTS_ID_filled,
    COUNT(SMARTTEXTS_ID_SMARTTEXT_NAME) AS SMARTTEXTS_ID_SMARTTEXT_NAME_filled,
    COUNT(IP_INV_LDS_ID) AS IP_INV_LDS_ID_filled,
    COUNT(IP_INV_LDS_ID_DISC_NAME) AS IP_INV_LDS_ID_DISC_NAME_filled,
    COUNT(HH_INT_DISC_C_NAME) AS HH_INT_DISC_C_NAME_filled
INTO #fc_064
FROM INTERV_SMARTTEXT;

-- ---- fc_065 <- IP_NOTE_TYPE ----
-- This table displays the note type for notes associated with Inpatient (INP) records.
-- Bucket(s): other note/document-adjacent
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(INPATIENT_DATA_ID) AS INPATIENT_DATA_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(TYPE_IP_C_NAME) AS TYPE_IP_C_NAME_filled
INTO #fc_065
FROM IP_NOTE_TYPE;

-- ---- fc_066 <- LAB_COSIGN_INFO ----
-- The LAB_COSIGN_INFO table contains cosign information for lab results.
-- Bucket(s): signature/cosign/attestation
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(ORDER_ID) AS ORDER_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(COSINGER_ID) AS COSINGER_ID_filled,
    COUNT(COSINGER_ID_NAME) AS COSINGER_ID_NAME_filled,
    COUNT(AP_BILLABLE_YN) AS AP_BILLABLE_YN_filled
INTO #fc_066
FROM LAB_COSIGN_INFO
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_067 <- LN_REPRICING_NOTE_TPO ----
-- The LN_REPRICING_NOTE_TPO table contains the line level third party organization notes populated for Tapestry's generic external repricing interface.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(RECORD_ID) AS RECORD_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(LN_REPRICING_NOTE_TPO) AS LN_REPRICING_NOTE_TPO_filled
INTO #fc_067
FROM LN_REPRICING_NOTE_TPO;

-- ---- fc_068 <- MAR_COSIGN_INST ----
-- List of instants at which this med administration was cosigned.
-- Bucket(s): signature/cosign/attestation
SELECT
    YEAR(MAR_COSIGN_INSTANT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(ORDER_ID) AS ORDER_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(MAR_COSIGN_INSTANT) AS MAR_COSIGN_INSTANT_filled
INTO #fc_068
FROM MAR_COSIGN_INST
GROUP BY YEAR(MAR_COSIGN_INSTANT);

-- ---- fc_069 <- MAR_COSIGN_USER ----
-- List of users who actually cosigned this med administration.
-- Bucket(s): signature/cosign/attestation
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(ORDER_ID) AS ORDER_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(MAR_COSIGN_USER_ID) AS MAR_COSIGN_USER_ID_filled,
    COUNT(MAR_COSIGN_USER_ID_NAME) AS MAR_COSIGN_USER_ID_NAME_filled
INTO #fc_069
FROM MAR_COSIGN_USER;

-- ---- fc_070 <- MED_AUTH_DET_NOTE ----
-- This table extracts the note associated with a prior authorization.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(REFERRAL_ID) AS REFERRAL_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(PA_DETAIL_NOTE) AS PA_DETAIL_NOTE_filled
INTO #fc_070
FROM MED_AUTH_DET_NOTE;

-- ---- fc_071 <- MED_DISCONTINUE_NOTE ----
-- This table extracts the multiline discontinue note associated with a medication within a document received.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(DOCUMENT_ID) AS DOCUMENT_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
INTO #fc_071
FROM MED_DISCONTINUE_NOTE
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_072 <- MED_PA_NOTE_FROM_PAYER ----
-- This table holds the note received from the payer for an electronic prior authorization action.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(REFERRAL_ID) AS REFERRAL_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(PA_NOTE_FROM_PAYER) AS PA_NOTE_FROM_PAYER_filled
INTO #fc_072
FROM MED_PA_NOTE_FROM_PAYER;

-- ---- fc_073 <- MED_PA_NOTE_TO_PAYER ----
-- This table holds the note sent to the payer for an electronic prior authorization action.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(REFERRAL_ID) AS REFERRAL_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(PA_NOTE_TO_PAYER) AS PA_NOTE_TO_PAYER_filled
INTO #fc_073
FROM MED_PA_NOTE_TO_PAYER;

-- ---- fc_074 <- NOTES_ACCT ----
-- This table contains summary information for billing system account notepad notes attached to accounts.
-- Bucket(s): core note lifecycle
SELECT
    YEAR(NOTE_ENTRY_DTTM) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(ACCOUNT_ID) AS ACCOUNT_ID_filled,
    COUNT(ACTIVE_STATUS) AS ACTIVE_STATUS_filled,
    COUNT(ENTRY_USER_ID) AS ENTRY_USER_ID_filled,
    COUNT(ENTRY_USER_ID_NAME) AS ENTRY_USER_ID_NAME_filled,
    COUNT(INVOICE_NUMBER) AS INVOICE_NUMBER_filled,
    COUNT(NOTE_ENTRY_DTTM) AS NOTE_ENTRY_DTTM_filled
INTO #fc_074
FROM NOTES_ACCT
GROUP BY YEAR(NOTE_ENTRY_DTTM);

-- ---- fc_075 <- NOTES_HISTORY_LOG ----
-- This table contains the Edit History Information for all Notes (HNO records). Shows information about the type of edit, when the note was edited, and the user who made the edit.
-- Bucket(s): core note lifecycle
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_CSN_ID) AS NOTE_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(EDIT_HX_INSTANT) AS EDIT_HX_INSTANT_filled,
    COUNT(EDIT_HX_ACTION_C_NAME) AS EDIT_HX_ACTION_C_NAME_filled,
    COUNT(EDIT_HX_INFO) AS EDIT_HX_INFO_filled,
    COUNT(EDIT_HX_EXP_DATE) AS EDIT_HX_EXP_DATE_filled
INTO #fc_075
FROM NOTES_HISTORY_LOG
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_076 <- NOTES_LAB ----
-- Contains lab-specific information about notes. Only notes associated with labs, which are notes (HNOs) with a Note Type (I HNO 50) value of 81-Lab, are included.
-- Bucket(s): core note lifecycle
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(LAB_NOTE_SUB_TYPE_C_NAME) AS LAB_NOTE_SUB_TYPE_C_NAME_filled
INTO #fc_076
FROM NOTES_LAB;

-- ---- fc_077 <- NOTES_LINK_ORD_TXN ----
-- Orders linked to/from the HNO (notes) master file by order based transcriptions.
-- Bucket(s): core note lifecycle
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(LINKED_ORD_ID) AS LINKED_ORD_ID_filled
INTO #fc_077
FROM NOTES_LINK_ORD_TXN;

-- ---- fc_078 <- NOTES_MC_NMM ----
-- This table contains the information about notes (HNO) records attached to case (NMM) records.
-- Bucket(s): core note lifecycle
SELECT
    YEAR(NOTE_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CASE_ID) AS CASE_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(NOTE_DATE) AS NOTE_DATE_filled,
    COUNT(NOTE_TIME) AS NOTE_TIME_filled,
    COUNT(NOTE_USER_ID) AS NOTE_USER_ID_filled,
    COUNT(NOTE_USER_ID_NAME) AS NOTE_USER_ID_NAME_filled
INTO #fc_078
FROM NOTES_MC_NMM
GROUP BY YEAR(NOTE_DATE);

-- ---- fc_079 <- NOTES_PROC_ORDERS ----
-- This table contains a list of procedure orders linked to ambulatory procedure notes.
-- Bucket(s): core note lifecycle
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(ASC_PROC_ORDERS_ID) AS ASC_PROC_ORDERS_ID_filled
INTO #fc_079
FROM NOTES_PROC_ORDERS;

-- ---- fc_080 <- NOTES_PROC_PRE_DX ----
-- This table contains a list of preoperative diagnoses for ambulatory procedure notes.
-- Bucket(s): core note lifecycle
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(PROC_NOTE_PRE_DX_DX_NAME) AS PROC_NOTE_PRE_DX_DX_NAME_filled
INTO #fc_080
FROM NOTES_PROC_PRE_DX;

-- ---- fc_081 <- NOTES_PROC_PROCS ----
-- This table contains a list of procedures for ambulatory procedure notes.
-- Bucket(s): core note lifecycle
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(PROC_NOTE_PROCEDUR_PROC_NAME) AS PROC_NOTE_PROCEDUR_PROC_NAME_filled
INTO #fc_081
FROM NOTES_PROC_PROCS;

-- ---- fc_082 <- NOTES_PROC_PST_DX ----
-- This table contains a list of postoperative diagnoses for ambulatory procedure notes.
-- Bucket(s): core note lifecycle
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(PROC_NOTE_PST_DX_DX_NAME) AS PROC_NOTE_PST_DX_DX_NAME_filled
INTO #fc_082
FROM NOTES_PROC_PST_DX;

-- ---- fc_083 <- NOTES_TRANS_AUTH ----
-- This table contains transcription authorization info.
-- Bucket(s): core note lifecycle
SELECT
    YEAR(AUTH_DTTM) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_CSN_ID) AS NOTE_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(AUTH_PROV_ID_PROV_NAME) AS AUTH_PROV_ID_PROV_NAME_filled,
    COUNT(AUTH_DTTM) AS AUTH_DTTM_filled,
    COUNT(AUTH_USER_ID) AS AUTH_USER_ID_filled,
    COUNT(AUTH_USER_ID_NAME) AS AUTH_USER_ID_NAME_filled,
    COUNT(DICTATION_TIME) AS DICTATION_TIME_filled,
    COUNT(TRANSCRIPTION_TIME) AS TRANSCRIPTION_TIME_filled,
    COUNT(ACTIVITY_DTTM) AS ACTIVITY_DTTM_filled,
    COUNT(ORIGINATOR_ID_PROV_NAME) AS ORIGINATOR_ID_PROV_NAME_filled,
    COUNT(EDIT_DTTM) AS EDIT_DTTM_filled,
    COUNT(CHR_CNT_DTTM) AS CHR_CNT_DTTM_filled,
    COUNT(CHR_CNT_MET) AS CHR_CNT_MET_filled,
    COUNT(DICT_PRIORITY_C_NAME) AS DICT_PRIORITY_C_NAME_filled
INTO #fc_083
FROM NOTES_TRANS_AUTH
GROUP BY YEAR(AUTH_DTTM);

-- ---- fc_084 <- NOTES_TRANS_IB ----
-- This table contains information about the transcription In Basket notes.
-- Bucket(s): core note lifecycle
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_CSN_ID) AS NOTE_CSN_ID_filled,
    COUNT(IB_PRIORITY_C_NAME) AS IB_PRIORITY_C_NAME_filled
INTO #fc_084
FROM NOTES_TRANS_IB;

-- ---- fc_085 <- NOTE_AMBIENT_SECTIONS ----
-- Stores ambient note section information.
-- Bucket(s): ambient/AI-scribe (Epic-native — directly Suki-comparable)
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(AMBIENT_SESSION_SECTION_IDENT) AS AMBIENT_SESSION_SECTION_IDENT_filled,
    COUNT(AMBIENT_SESSION_IDENT) AS AMBIENT_SESSION_IDENT_filled
INTO #fc_085
FROM NOTE_AMBIENT_SECTIONS;

-- ---- fc_086 <- NOTE_ATTACHED_IMG ----
-- Stores the document IDs of images attached to the note from Canto.
-- Bucket(s): core note lifecycle
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NOTE_IMG_DOC_ID) AS NOTE_IMG_DOC_ID_filled
INTO #fc_086
FROM NOTE_ATTACHED_IMG;

-- ---- fc_087 <- NOTE_BLOCKING ----
-- This table stores the reasons for blocking the sharing of a note.
-- Bucket(s): core note lifecycle
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_CSN_ID) AS NOTE_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(MULT_BLOCK_REASON_C_NAME) AS MULT_BLOCK_REASON_C_NAME_filled
INTO #fc_087
FROM NOTE_BLOCKING
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_088 <- NOTE_CONTENT_INFO ----
-- This table contains discrete information pertaining to the type of content contained within the note text of a clinical note.
-- Bucket(s): core note lifecycle
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_CSN_ID) AS NOTE_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
INTO #fc_088
FROM NOTE_CONTENT_INFO
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_089 <- NOTE_COPY_TRACKING ----
-- Track the source note information that this note was copied from.
-- Bucket(s): core note lifecycle
SELECT
    YEAR(NOTE_COPY_INST_DTTM) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NOTE_COPY_INST_DTTM) AS NOTE_COPY_INST_DTTM_filled,
    COUNT(NOTE_COPY_LOC_DTTM) AS NOTE_COPY_LOC_DTTM_filled
INTO #fc_089
FROM NOTE_COPY_TRACKING
GROUP BY YEAR(NOTE_COPY_INST_DTTM);

-- ---- fc_090 <- NOTE_DENT_PROCS ----
-- Dental procedures linked to this dental procedure note.
-- Bucket(s): core note lifecycle
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(DENT_PROC_FINDING_ID) AS DENT_PROC_FINDING_ID_filled
INTO #fc_090
FROM NOTE_DENT_PROCS;

-- ---- fc_091 <- NOTE_EDIT_TRAIL ----
-- This table displays edit trail information for notes (HNO).
-- Bucket(s): core note lifecycle
SELECT
    YEAR(IP_ACTION_DTTM) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(IP_ACTION_DTTM) AS IP_ACTION_DTTM_filled,
    COUNT(ACT_TAKEN_INST_DTTM) AS ACT_TAKEN_INST_DTTM_filled
INTO #fc_091
FROM NOTE_EDIT_TRAIL
GROUP BY YEAR(IP_ACTION_DTTM);

-- ---- fc_092 <- NOTE_ENC_INFO ----
-- This table contains information from overtime single-response items about General Use Notes (HNO) records. Contact creation logic for clinical notes is as follows: 1. If a note doe
-- Bucket(s): core note lifecycle
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(CONTACT_SERIAL_NUM) AS CONTACT_SERIAL_NUM_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(COSIGN_INSTANT_DTTM) AS COSIGN_INSTANT_DTTM_filled,
    COUNT(COSIGNUSER_ID) AS COSIGNUSER_ID_filled,
    COUNT(COSIGNUSER_ID_NAME) AS COSIGNUSER_ID_NAME_filled,
    COUNT(COSIGN_NOTE_LINK) AS COSIGN_NOTE_LINK_filled,
    COUNT(COSIGN_REQUIRED_C_NAME) AS COSIGN_REQUIRED_C_NAME_filled,
    COUNT(AUTH_LNKED_PROV_ID_PROV_NAME) AS AUTH_LNKED_PROV_ID_PROV_NAME_filled,
    COUNT(AUTHOR_SERVICE_C_NAME) AS AUTHOR_SERVICE_C_NAME_filled,
    COUNT(ENTRY_INSTANT_DTTM) AS ENTRY_INSTANT_DTTM_filled,
    COUNT(UPD_AUTHOR_INS_DTTM) AS UPD_AUTHOR_INS_DTTM_filled,
    COUNT(SPEC_NOTE_TIME_DTTM) AS SPEC_NOTE_TIME_DTTM_filled,
    COUNT(NOTE_FILE_TIME_DTTM) AS NOTE_FILE_TIME_DTTM_filled,
    COUNT(AUTHOR_PRVD_TYPE_C_NAME) AS AUTHOR_PRVD_TYPE_C_NAME_filled,
    COUNT(NOTE_STATUS_C_NAME) AS NOTE_STATUS_C_NAME_filled,
    COUNT(UPDATE_USER_ID) AS UPDATE_USER_ID_filled,
    COUNT(UPDATE_USER_ID_NAME) AS UPDATE_USER_ID_NAME_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(TRN_DOC_AVAIL_STA_C_NAME) AS TRN_DOC_AVAIL_STA_C_NAME_filled,
    COUNT(TRN_DOC_TYPE_C_NAME) AS TRN_DOC_TYPE_C_NAME_filled,
    COUNT(SENSITIVE_STAT_C_NAME) AS SENSITIVE_STAT_C_NAME_filled,
    COUNT(AUTHOR_USER_ID) AS AUTHOR_USER_ID_filled,
    COUNT(AUTHOR_USER_ID_NAME) AS AUTHOR_USER_ID_NAME_filled,
    COUNT(NOTE_FORMAT_C_NAME) AS NOTE_FORMAT_C_NAME_filled,
    COUNT(UPD_BY_AUTH_DTTM) AS UPD_BY_AUTH_DTTM_filled,
    COUNT(ACTIVITY_DTTM) AS ACTIVITY_DTTM_filled,
    COUNT(AUTH_STAT_C_NAME) AS AUTH_STAT_C_NAME_filled,
    COUNT(CONTACT_NUM) AS CONTACT_NUM_filled,
    COUNT(UPD_AUT_LOCAL_DTTM) AS UPD_AUT_LOCAL_DTTM_filled,
    COUNT(ENT_INST_LOCAL_DTTM) AS ENT_INST_LOCAL_DTTM_filled,
    COUNT(SPEC_TIME_LOC_DTTM) AS SPEC_TIME_LOC_DTTM_filled,
    COUNT(NOT_FILETM_LOC_DTTM) AS NOT_FILETM_LOC_DTTM_filled,
    COUNT(EDIT_USER_ID) AS EDIT_USER_ID_filled,
    COUNT(EDIT_USER_ID_NAME) AS EDIT_USER_ID_NAME_filled,
    COUNT(DOCUMENT_NAME) AS DOCUMENT_NAME_filled,
    COUNT(UMRG_SRC_MEDPROB_ID) AS UMRG_SRC_MEDPROB_ID_filled,
    COUNT(ECG_COMMENTS) AS ECG_COMMENTS_filled,
    COUNT(ECG_EDITED_USER_ID) AS ECG_EDITED_USER_ID_filled,
    COUNT(ECG_DIASTOLIC_BP) AS ECG_DIASTOLIC_BP_filled,
    COUNT(ECG_SYSTOLIC_BP) AS ECG_SYSTOLIC_BP_filled,
    COUNT(ECG_HEARTRATE) AS ECG_HEARTRATE_filled,
    COUNT(ECG_PR_INTERVAL) AS ECG_PR_INTERVAL_filled,
    COUNT(ECG_PWAVEAXIS) AS ECG_PWAVEAXIS_filled,
    COUNT(ECG_QRS_DURATION) AS ECG_QRS_DURATION_filled,
    COUNT(ECG_QRS_WAVEAXIS) AS ECG_QRS_WAVEAXIS_filled,
    COUNT(ECG_QT_INTERVAL) AS ECG_QT_INTERVAL_filled,
    COUNT(ECG_QTC_INTERVAL) AS ECG_QTC_INTERVAL_filled,
    COUNT(ECG_T_WAVEAXIS) AS ECG_T_WAVEAXIS_filled,
    COUNT(SPIRO_BRON) AS SPIRO_BRON_filled,
    COUNT(CARE_PLAN_CSN_ID) AS CARE_PLAN_CSN_ID_filled,
    COUNT(PROGRESS_NOTE_ID) AS PROGRESS_NOTE_ID_filled,
    COUNT(TRANSCRIPTION_DTTM) AS TRANSCRIPTION_DTTM_filled,
    COUNT(CSGN_RECPNT_USER_ID) AS CSGN_RECPNT_USER_ID_filled,
    COUNT(CSGN_RECPNT_USER_ID_NAME) AS CSGN_RECPNT_USER_ID_NAME_filled,
    COUNT(TREAT_SUMM_PAT_DTTM) AS TREAT_SUMM_PAT_DTTM_filled,
    COUNT(TREAT_SUMM_PROV_DTTM) AS TREAT_SUMM_PROV_DTTM_filled,
    COUNT(TREAT_SUMM_CPLT_DTTM) AS TREAT_SUMM_CPLT_DTTM_filled,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(END_OF_TREAT_DATE) AS END_OF_TREAT_DATE_filled,
    COUNT(UNMERGE_SRC_NOTE_ID) AS UNMERGE_SRC_NOTE_ID_filled,
    COUNT(NOTE_SHARED_W_PAT_HX_YN) AS NOTE_SHARED_W_PAT_HX_YN_filled,
    COUNT(NOTE_TYPE_C_NAME) AS NOTE_TYPE_C_NAME_filled,
    COUNT(POC_NOTE_DISC_C_NAME) AS POC_NOTE_DISC_C_NAME_filled,
    COUNT(COSIGN_INST_LOCAL_DTTM) AS COSIGN_INST_LOCAL_DTTM_filled,
    COUNT(IS_PRECHARTED_YN) AS IS_PRECHARTED_YN_filled,
    COUNT(LINK_DXR_CSN_ID) AS LINK_DXR_CSN_ID_filled,
    COUNT(CLINICAL_NOTE_SUMMARY) AS CLINICAL_NOTE_SUMMARY_filled,
    COUNT(BLOCK_REASON_C_NAME) AS BLOCK_REASON_C_NAME_filled,
    COUNT(BLOCK_REASON_TXT) AS BLOCK_REASON_TXT_filled
INTO #fc_092
FROM NOTE_ENC_INFO
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_093 <- NOTE_ENC_INFO_2 ----
-- This table extends HNO_ENC_INFO.
-- Bucket(s): core note lifecycle
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_CSN_ID) AS NOTE_CSN_ID_filled,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(CONTACT_NUM) AS CONTACT_NUM_filled,
    COUNT(CM_CT_OWNER_ID) AS CM_CT_OWNER_ID_filled,
    COUNT(EXT_SHARED_W_PT_YN) AS EXT_SHARED_W_PT_YN_filled,
    COUNT(EXT_AUTH_NAME) AS EXT_AUTH_NAME_filled,
    COUNT(EXT_AUTH_SPEC_C_NAME) AS EXT_AUTH_SPEC_C_NAME_filled,
    COUNT(EXT_AUTH_TYPE) AS EXT_AUTH_TYPE_filled,
    COUNT(EXT_AUTH_SERV) AS EXT_AUTH_SERV_filled,
    COUNT(EXT_LAST_SIGNER) AS EXT_LAST_SIGNER_filled,
    COUNT(EXT_LAST_SIGN_UTC_DTTM) AS EXT_LAST_SIGN_UTC_DTTM_filled,
    COUNT(NOTE_AUTHOR_TYPE_C_NAME) AS NOTE_AUTHOR_TYPE_C_NAME_filled
INTO #fc_093
FROM NOTE_ENC_INFO_2
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_094 <- NOTE_ENC_SUMMARY ----
-- This table contains the summary text for a general use note.
-- Bucket(s): core note lifecycle
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_CSN_ID) AS NOTE_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(SUMMARY_TEXT) AS SUMMARY_TEXT_filled
INTO #fc_094
FROM NOTE_ENC_SUMMARY;

-- ---- fc_095 <- NOTE_EXT_REL_ORD ----
-- This table stores information about external orders related to an external note.
-- Bucket(s): core note lifecycle
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_CSN_ID) AS NOTE_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(EXT_REL_ORD_NAME) AS EXT_REL_ORD_NAME_filled
INTO #fc_095
FROM NOTE_EXT_REL_ORD
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_096 <- NOTE_EXT_REL_PREDX ----
-- This table stores information about external pre-procedure diagnoses related to an external note.
-- Bucket(s): core note lifecycle
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_CSN_ID) AS NOTE_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(EXT_REL_PREDX_NAME) AS EXT_REL_PREDX_NAME_filled
INTO #fc_096
FROM NOTE_EXT_REL_PREDX
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_097 <- NOTE_EXT_REL_PROB ----
-- This table stores information about external problems related to an external note.
-- Bucket(s): core note lifecycle
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_CSN_ID) AS NOTE_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(EXT_REL_PROB_NAME) AS EXT_REL_PROB_NAME_filled
INTO #fc_097
FROM NOTE_EXT_REL_PROB
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_098 <- NOTE_EXT_REL_PROC ----
-- This table stores information about external procedures related to an external note.
-- Bucket(s): core note lifecycle
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_CSN_ID) AS NOTE_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(EXT_REL_PROC_NAME) AS EXT_REL_PROC_NAME_filled
INTO #fc_098
FROM NOTE_EXT_REL_PROC
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_099 <- NOTE_EXT_REL_PSTDX ----
-- This table stores information about external post-procedure diagnoses related to an external note.
-- Bucket(s): core note lifecycle
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_CSN_ID) AS NOTE_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(EXT_REL_PSTDX_NAME) AS EXT_REL_PSTDX_NAME_filled
INTO #fc_099
FROM NOTE_EXT_REL_PSTDX
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_100 <- NOTE_EXT_SIGNERS ----
-- Note signer information for auto-reconciled external notes.
-- Bucket(s): core note lifecycle
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_CSN_ID) AS NOTE_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(EXT_NOTE_SIGNER_NAME) AS EXT_NOTE_SIGNER_NAME_filled,
    COUNT(EXT_NOTE_SIGNING_UTC_DTTM) AS EXT_NOTE_SIGNING_UTC_DTTM_filled,
    COUNT(EXT_NOTE_SIGNER_ROLE_C_NAME) AS EXT_NOTE_SIGNER_ROLE_C_NAME_filled
INTO #fc_100
FROM NOTE_EXT_SIGNERS
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_101 <- NOTE_EXT_WRN_TYP ----
-- This table stores the external note warning types for a note.
-- Bucket(s): core note lifecycle
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_CSN_ID) AS NOTE_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(EXT_NOTE_WRN_C_NAME) AS EXT_NOTE_WRN_C_NAME_filled
INTO #fc_101
FROM NOTE_EXT_WRN_TYP
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_102 <- NOTE_FREE_TEXT ----
-- The NOTE_FREE_TEXT table contains free text notes.
-- Bucket(s): core note lifecycle
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NOTE_FREE_TEXT) AS NOTE_FREE_TEXT_filled
INTO #fc_102
FROM NOTE_FREE_TEXT;

-- ---- fc_103 <- NOTE_IMG_SECT ----
-- This table contains information about imaging orders resulted using the Imaging SmartSection.
-- Bucket(s): core note lifecycle
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(IMG_SECT_RESULT_NOTE_CSN_ID) AS IMG_SECT_RESULT_NOTE_CSN_ID_filled,
    COUNT(IMG_SECT_ORDER_ID) AS IMG_SECT_ORDER_ID_filled
INTO #fc_103
FROM NOTE_IMG_SECT;

-- ---- fc_104 <- NOTE_PARENT_NOTE ----
-- Table to hold HNO parent note information.
-- Bucket(s): core note lifecycle
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(SS_PARENT_NOTE_ID) AS SS_PARENT_NOTE_ID_filled
INTO #fc_104
FROM NOTE_PARENT_NOTE;

-- ---- fc_105 <- NOTE_RESEARCH_LINK ----
-- This table contains information about the current research link for notes.
-- Bucket(s): core note lifecycle
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(RESEARCH_ID_RESEARCH_STUDY_NAME) AS RESEARCH_ID_RESEARCH_STUDY_NAME_filled,
    COUNT(ENROLL_ID) AS ENROLL_ID_filled
INTO #fc_105
FROM NOTE_RESEARCH_LINK;

-- ---- fc_106 <- NOTE_RESEARCH_LINK_HX ----
-- This table contains information about how the research study linkage on a note has changed over time.
-- Bucket(s): core note lifecycle
SELECT
    YEAR(HX_STUDY_LINK_UTC_DTTM) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(HX_RESEARCH_ID_RESEARCH_STUDY_NAME) AS HX_RESEARCH_ID_RESEARCH_STUDY_NAME_filled,
    COUNT(HX_ENROLL_ID) AS HX_ENROLL_ID_filled,
    COUNT(HX_STUDY_LINK_UTC_DTTM) AS HX_STUDY_LINK_UTC_DTTM_filled,
    COUNT(HX_STUDY_USER_ID) AS HX_STUDY_USER_ID_filled,
    COUNT(HX_STUDY_USER_ID_NAME) AS HX_STUDY_USER_ID_NAME_filled
INTO #fc_106
FROM NOTE_RESEARCH_LINK_HX
GROUP BY YEAR(HX_STUDY_LINK_UTC_DTTM);

-- ---- fc_107 <- NOTE_SMARTBLOCK_ATTR ----
-- Store the employee (EMP) ID, the Timestamp, and the SmartBlocks added of the Attribution for SmartBlocks.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
SELECT
    YEAR(ATTRIBUTION_UTC_DTTM) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(USER_ID) AS USER_ID_filled,
    COUNT(USER_ID_NAME) AS USER_ID_NAME_filled,
    COUNT(ATTRIBUTION_UTC_DTTM) AS ATTRIBUTION_UTC_DTTM_filled,
    COUNT(SB_COPY_CSN) AS SB_COPY_CSN_filled
INTO #fc_107
FROM NOTE_SMARTBLOCK_ATTR
GROUP BY YEAR(ATTRIBUTION_UTC_DTTM);

-- ---- fc_108 <- NOTE_SMARTSECTION_IDS ----
-- Contains the SmartSection IDs used in the note.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_CSN_ID) AS NOTE_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
INTO #fc_108
FROM NOTE_SMARTSECTION_IDS
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_109 <- ORDER_ADDENDUM_NOTE ----
-- The table contains the note that stores addendum for the order.
-- Bucket(s): addendum
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(ORDER_ID) AS ORDER_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(ADDENDUM_NOTE_ID) AS ADDENDUM_NOTE_ID_filled
INTO #fc_109
FROM ORDER_ADDENDUM_NOTE;

-- ---- fc_110 <- ORDER_DOCUMENTS ----
-- This table contains the DCS records attached to an order on a contact level such as scanned hard copy prescriptions, Lab Scans and Lab Reports.
-- Bucket(s): other note/document-adjacent
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(ORDER_ID) AS ORDER_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
INTO #fc_110
FROM ORDER_DOCUMENTS
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_111 <- ORDER_RAD_DICTATE ----
-- This table stores the dictation radiologist & dictating date information for orders performed in radiology.
-- Bucket(s): dictation/transcription
SELECT
    YEAR(DICTATING_DT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(ORDER_PROC_ID) AS ORDER_PROC_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(PROV_ID_PROV_NAME) AS PROV_ID_PROV_NAME_filled,
    COUNT(DICTATING_DT) AS DICTATING_DT_filled,
    COUNT(DICTATED_UTC_DTTM) AS DICTATED_UTC_DTTM_filled
INTO #fc_111
FROM ORDER_RAD_DICTATE
GROUP BY YEAR(DICTATING_DT);

-- ---- fc_112 <- ORDER_RESULT_DOCUMENTS ----
-- This tables holds document IDs for documents that contain results for an order.
-- Bucket(s): other note/document-adjacent
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(ORDER_ID) AS ORDER_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(RESULT_DOCUMENT_ID) AS RESULT_DOCUMENT_ID_filled
INTO #fc_112
FROM ORDER_RESULT_DOCUMENTS
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_113 <- ORDER_SMARTSECTION_DATA ----
-- Data for Order specific SmartSections.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(ORDER_ID) AS ORDER_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(ORDER_SMARTSECTION_C_NAME) AS ORDER_SMARTSECTION_C_NAME_filled
INTO #fc_113
FROM ORDER_SMARTSECTION_DATA
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_114 <- ORDER_SMARTSECTION_HNO ----
-- Holds the CSN of HNO records that contain the SmartSection text.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(ORDER_ID) AS ORDER_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
INTO #fc_114
FROM ORDER_SMARTSECTION_HNO
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_115 <- ORDER_SMARTSECTION_TEXT ----
-- Holds the SmartSection text for an Order. Associated key is SMARTSECTION_KEY in ORDER_SMARTSECTION_DATA.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(ORDER_ID) AS ORDER_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(SMARTSECTION_TEXT) AS SMARTSECTION_TEXT_filled
INTO #fc_115
FROM ORDER_SMARTSECTION_TEXT
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_116 <- ORD_LAST_ADDENDUM_INFO ----
-- This table contains information about the most recent addendum.
-- Bucket(s): addendum
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(ORDER_ID) AS ORDER_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(LAST_ADD_PROV_ID_PROV_NAME) AS LAST_ADD_PROV_ID_PROV_NAME_filled
INTO #fc_116
FROM ORD_LAST_ADDENDUM_INFO;

-- ---- fc_117 <- ORTHO_TREAT_NOTE ----
-- The ORTHO_TREAT_NOTE table contains information about orthodontics treatment note.
-- Bucket(s): other note/document-adjacent
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(TREATMENT_PLAN_ID) AS TREATMENT_PLAN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NOTE) AS NOTE_filled
INTO #fc_117
FROM ORTHO_TREAT_NOTE;

-- ---- fc_118 <- OR_LOG_POSTOP_NOTE ----
-- The OR_LOG_POSTOP_NOTE table contains post-op notes from the log record.
-- Bucket(s): other note/document-adjacent
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(LOG_ID) AS LOG_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(POSTOP_NOTES_ID) AS POSTOP_NOTES_ID_filled
INTO #fc_118
FROM OR_LOG_POSTOP_NOTE;

-- ---- fc_119 <- OUTREACH_ESIG_DOCUMENTS ----
-- This table stores documents sent to patients for e-signature prior to an outreach.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
SELECT
    YEAR(ESIG_DOC_SEND_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(ACTIVITY_ID) AS ACTIVITY_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(ESIG_DOCUMENT_ID) AS ESIG_DOCUMENT_ID_filled,
    COUNT(ESIG_REL_ORDER_ID) AS ESIG_REL_ORDER_ID_filled,
    COUNT(ESIG_DOC_SEND_DATE) AS ESIG_DOC_SEND_DATE_filled
INTO #fc_119
FROM OUTREACH_ESIG_DOCUMENTS
GROUP BY YEAR(ESIG_DOC_SEND_DATE);

-- ---- fc_120 <- PAT_ADDENDUM_INFO ----
-- This table contains the encounter addendum information from the Addendum Added Date (I EPT 18123) and Addendum Added User (I EPT 18129) items.
-- Bucket(s): addendum
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(PAT_ENC_DATE_REAL) AS PAT_ENC_DATE_REAL_filled,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(ADDENDUM_DATE_TIME) AS ADDENDUM_DATE_TIME_filled,
    COUNT(ADDENDUM_USER_ID) AS ADDENDUM_USER_ID_filled,
    COUNT(ADDENDUM_USER_ID_NAME) AS ADDENDUM_USER_ID_NAME_filled,
    COUNT(ADDENDUM_STARTED_UTC_DTTM) AS ADDENDUM_STARTED_UTC_DTTM_filled,
    COUNT(ADDENDUM_STARTED_USER_ID) AS ADDENDUM_STARTED_USER_ID_filled,
    COUNT(ADDENDUM_STARTED_USER_ID_NAME) AS ADDENDUM_STARTED_USER_ID_NAME_filled,
    COUNT(SOURCE_WORKFLOW_C_NAME) AS SOURCE_WORKFLOW_C_NAME_filled,
    COUNT(ADDENDUM_OPEN_YN) AS ADDENDUM_OPEN_YN_filled
INTO #fc_120
FROM PAT_ADDENDUM_INFO
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_121 <- PAT_DT_STICKY_NOTE_INFO ----
-- This table contains information regarding a patient's date-specific sticky notes, including the date the note applies to as well as the note ID.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
SELECT
    YEAR(DT_STICKY_NOTE_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(PAT_ID) AS PAT_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(DT_STICKY_NOTE_DATE) AS DT_STICKY_NOTE_DATE_filled,
    COUNT(DT_STICKY_NOTE_ID) AS DT_STICKY_NOTE_ID_filled
INTO #fc_121
FROM PAT_DT_STICKY_NOTE_INFO
GROUP BY YEAR(DT_STICKY_NOTE_DATE);

-- ---- fc_122 <- PAT_ENC_AMBIENT_SESSIONS ----
-- Stores ambient session information from a patient's encounter.
-- Bucket(s): ambient/AI-scribe (Epic-native — directly Suki-comparable)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(PAT_ID) AS PAT_ID_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(CM_CT_OWNER_ID) AS CM_CT_OWNER_ID_filled,
    COUNT(AMBIENT_SESSION_IDENT) AS AMBIENT_SESSION_IDENT_filled
INTO #fc_122
FROM PAT_ENC_AMBIENT_SESSIONS
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_123 <- PAT_ENC_CHKOUT_NOTE ----
-- Stores the checkout note entered by the provider for the follow-up of a given encounter.
-- Bucket(s): other note/document-adjacent
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(CHKOUT_NOTE) AS CHKOUT_NOTE_filled
INTO #fc_123
FROM PAT_ENC_CHKOUT_NOTE;

-- ---- fc_124 <- PAT_ENC_PREPAYNOTE ----
-- User entered notes associated with a prepayment on a patient encounter.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(PAT_ENC_DATE_REAL) AS PAT_ENC_DATE_REAL_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(PREPAY_NOTES) AS PREPAY_NOTES_filled
INTO #fc_124
FROM PAT_ENC_PREPAYNOTE
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_125 <- PB_COLL_HX_NOTE_TBL ----
-- The table of notes, letters, etc. attached to a collections process as it moves through an organization's steps of collections.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(PB_ACCT_ID) AS PB_ACCT_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(PB_COLL_NOTE_ID) AS PB_COLL_NOTE_ID_filled
INTO #fc_125
FROM PB_COLL_HX_NOTE_TBL;

-- ---- fc_126 <- PROBLEM_DIS_STAT_NOTE_HX ----
-- This table extracts a list of notes (HNOs) indicating the note in which clinicians have edited the disease status for a problem on a patient's problem list.
-- Bucket(s): other note/document-adjacent
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(PROBLEM_LIST_ID) AS PROBLEM_LIST_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(HX_DISEASE_STATUS_NOTE_ID) AS HX_DISEASE_STATUS_NOTE_ID_filled
INTO #fc_126
FROM PROBLEM_DIS_STAT_NOTE_HX;

-- ---- fc_127 <- PROBLEM_NOTE_PROPS ----
-- Contains all related properties to assessment & plan notes which are stored in the PROBLEM_NOTES clarity extract.
-- Bucket(s): other note/document-adjacent
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(PROBLEM_LIST_ID) AS PROBLEM_LIST_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(GENERATED_NOTE_ID) AS GENERATED_NOTE_ID_filled,
    COUNT(AP_NOTE_SERVICE_C_NAME) AS AP_NOTE_SERVICE_C_NAME_filled
INTO #fc_127
FROM PROBLEM_NOTE_PROPS;

-- ---- fc_128 <- QRY_EVIDENCE_NOTE_CSN_ID ----
-- This table extracts information related to the contact the evidence came from.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(QUERY_ID) AS QUERY_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(EVIDENCE_NOTE_CSN_ID) AS EVIDENCE_NOTE_CSN_ID_filled,
    COUNT(QUERY_CSN_ID) AS QUERY_CSN_ID_filled
INTO #fc_128
FROM QRY_EVIDENCE_NOTE_CSN_ID
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_129 <- QRY_EVIDENCE_NOTE_IDS ----
-- This table extracts information related to the note record that the evidence came from.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(QUERY_ID) AS QUERY_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(EVIDENCE_NOTE_ID) AS EVIDENCE_NOTE_ID_filled,
    COUNT(QUERY_CSN_ID) AS QUERY_CSN_ID_filled
INTO #fc_129
FROM QRY_EVIDENCE_NOTE_IDS
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_130 <- QRY_RESP_NOTE_HX ----
-- This table displays historical notes used in response to queries (are not current responses).
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(QRY_RESP_HX_NOTE_ID) AS QRY_RESP_HX_NOTE_ID_filled
INTO #fc_130
FROM QRY_RESP_NOTE_HX;

-- ---- fc_131 <- REFERRAL_BED_DAY_UNS_NOTE ----
-- The unsigned notes linked with a bed day line.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(REFERRAL_ID) AS REFERRAL_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(BED_DAY_UNSIGNED_NOTE_ID) AS BED_DAY_UNSIGNED_NOTE_ID_filled
INTO #fc_131
FROM REFERRAL_BED_DAY_UNS_NOTE;

-- ---- fc_132 <- REFERRAL_UM_UNSIGNED_NOTE ----
-- This table contains the unsigned UM notes.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(REFERRAL_ID) AS REFERRAL_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(UM_UNSIGNED_UCN_NOTE_ID) AS UM_UNSIGNED_UCN_NOTE_ID_filled
INTO #fc_132
FROM REFERRAL_UM_UNSIGNED_NOTE;

-- ---- fc_133 <- RES_COSIGNERS ----
-- Contains a list of users who have cosigned results.
-- Bucket(s): signature/cosign/attestation
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(RESULT_ID) AS RESULT_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(COSIGNER_ID) AS COSIGNER_ID_filled,
    COUNT(COSIGNER_ID_NAME) AS COSIGNER_ID_NAME_filled
INTO #fc_133
FROM RES_COSIGNERS;

-- ---- fc_134 <- RES_SMARTTEXT_RSLT ----
-- Displays multi-line string results.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(RESULT_ID) AS RESULT_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(MULTI_LN_STR_RESULT) AS MULTI_LN_STR_RESULT_filled
INTO #fc_134
FROM RES_SMARTTEXT_RSLT;

-- ---- fc_135 <- RXFILL_NOTE ----
-- Table for the RxFill pharmacy note.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(MED_PRBLM_LIST_ID) AS MED_PRBLM_LIST_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(RXFILL_NOTE) AS RXFILL_NOTE_filled
INTO #fc_135
FROM RXFILL_NOTE;

-- ---- fc_136 <- SMARTFORMS_ACCESSED ----
-- This table contains information pertaining to how specific users are accessing specific SmartForms, such as how long a user has spent in a given SmartForm.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(PAT_ID) AS PAT_ID_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(CM_CT_OWNER_ID) AS CM_CT_OWNER_ID_filled
INTO #fc_136
FROM SMARTFORMS_ACCESSED
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_137 <- SMARTFORM_METADATA ----
-- This table contains metadata pertaining to specific SmartForms for a visit.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(PAT_ID) AS PAT_ID_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(CM_CT_OWNER_ID) AS CM_CT_OWNER_ID_filled
INTO #fc_137
FROM SMARTFORM_METADATA
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_138 <- SMARTTEXT ----
-- This table contains information relating to SmartText records. SmartTexts are blocks of text which may be used in a variety of ways, including documenting on clinical encounters, a
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(SMARTTEXT_ID) AS SMARTTEXT_ID_filled,
    COUNT(SMARTTEXT_NAME) AS SMARTTEXT_NAME_filled
INTO #fc_138
FROM SMARTTEXT;

-- ---- fc_139 <- SMRTDTA_ELEM_AIEXTRACTED ----
-- This table is a bridge between AI Extracted Fact context SmartData element values and the source interaction records.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(HLV_ID) AS HLV_ID_filled,
    COUNT(ELEMENT_ID) AS ELEMENT_ID_filled,
    COUNT(AI_INTRCT_ID) AS AI_INTRCT_ID_filled
INTO #fc_139
FROM SMRTDTA_ELEM_AIEXTRACTED;

-- ---- fc_140 <- SMRTDTA_ELEM_AUTH ----
-- This table is a bridge between authorization context SmartData element values and the source authorization records.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(HLV_ID) AS HLV_ID_filled,
    COUNT(AUTH_ID) AS AUTH_ID_filled,
    COUNT(ELEMENT_ID) AS ELEMENT_ID_filled
INTO #fc_140
FROM SMRTDTA_ELEM_AUTH;

-- ---- fc_141 <- SMRTDTA_ELEM_BEREAVE ----
-- This table is a bridge between bereavement contact context SmartData element values and the source bereavement records.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(HLV_ID) AS HLV_ID_filled,
    COUNT(BEREAVEMENT_ID) AS BEREAVEMENT_ID_filled,
    COUNT(ELEMENT_ID) AS ELEMENT_ID_filled
INTO #fc_141
FROM SMRTDTA_ELEM_BEREAVE;

-- ---- fc_142 <- SMRTDTA_ELEM_CONCEPT ----
-- This table is a bridge between concept context SmartData element values and the source SmartData element value records.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(HLV_ID) AS HLV_ID_filled,
    COUNT(PARENT_HLV_ID) AS PARENT_HLV_ID_filled,
    COUNT(PAT_ID) AS PAT_ID_filled,
    COUNT(ELEMENT_ID) AS ELEMENT_ID_filled
INTO #fc_142
FROM SMRTDTA_ELEM_CONCEPT;

-- ---- fc_143 <- SMRTDTA_ELEM_CUST_SERVICE ----
-- This table is a bridge between CRM context SmartData element values and the source customer relationship management records.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
SELECT
    YEAR(CUR_VALUE_DATETIME) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(HLV_ID) AS HLV_ID_filled,
    COUNT(COMM_ID) AS COMM_ID_filled,
    COUNT(ELEMENT_ID) AS ELEMENT_ID_filled,
    COUNT(CUR_VALUE_DATETIME) AS CUR_VALUE_DATETIME_filled
INTO #fc_143
FROM SMRTDTA_ELEM_CUST_SERVICE
GROUP BY YEAR(CUR_VALUE_DATETIME);

-- ---- fc_144 <- SMRTDTA_ELEM_DATA ----
-- The SMRTDTA_ELEM_DATA table stores metadata (context, linked records, time of entry, etc.) concerning SmartData element values entered by users through SmartForms, SmartTools or ot
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
SELECT
    YEAR(CUR_VALUE_DATETIME) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(HLV_ID) AS HLV_ID_filled,
    COUNT(ELEMENT_ID) AS ELEMENT_ID_filled,
    COUNT(CUR_VALUE_DATETIME) AS CUR_VALUE_DATETIME_filled,
    COUNT(CUR_VALUE_USER_ID) AS CUR_VALUE_USER_ID_filled,
    COUNT(CUR_VALUE_USER_ID_NAME) AS CUR_VALUE_USER_ID_NAME_filled,
    COUNT(CONTEXT_NAME) AS CONTEXT_NAME_filled,
    COUNT(CONTACT_SERIAL_NUM) AS CONTACT_SERIAL_NUM_filled,
    COUNT(RECORD_ID_VARCHAR) AS RECORD_ID_VARCHAR_filled,
    COUNT(PAT_LINK_ID) AS PAT_LINK_ID_filled,
    COUNT(SRC_NOTE_ID) AS SRC_NOTE_ID_filled,
    COUNT(SRC_NOTE_STATUS_C_NAME) AS SRC_NOTE_STATUS_C_NAME_filled,
    COUNT(CUR_VAL_UTC_DTTM) AS CUR_VAL_UTC_DTTM_filled,
    COUNT(SET_BY_C_NAME) AS SET_BY_C_NAME_filled,
    COUNT(SET_BY_USER_ID) AS SET_BY_USER_ID_filled,
    COUNT(SET_BY_USER_ID_NAME) AS SET_BY_USER_ID_NAME_filled
INTO #fc_144
FROM SMRTDTA_ELEM_DATA
GROUP BY YEAR(CUR_VALUE_DATETIME);

-- ---- fc_145 <- SMRTDTA_ELEM_DATASET ----
-- This table is a bridge between data set context SmartData element values and the source data set records.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(HLV_ID) AS HLV_ID_filled,
    COUNT(DATASET_ID) AS DATASET_ID_filled,
    COUNT(ELEMENT_ID) AS ELEMENT_ID_filled
INTO #fc_145
FROM SMRTDTA_ELEM_DATASET;

-- ---- fc_146 <- SMRTDTA_ELEM_DEFICIENCY ----
-- This table is a bridge between problem context SmartData element values and the source deficiency records.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(HLV_ID) AS HLV_ID_filled,
    COUNT(ELEMENT_ID) AS ELEMENT_ID_filled,
    COUNT(DFI_ID) AS DFI_ID_filled
INTO #fc_146
FROM SMRTDTA_ELEM_DEFICIENCY;

-- ---- fc_147 <- SMRTDTA_ELEM_DOCUMENT ----
-- This table is a bridge between document context SmartData element values and the source document records.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(HLV_ID) AS HLV_ID_filled,
    COUNT(DOCUMENT_ID) AS DOCUMENT_ID_filled,
    COUNT(ELEMENT_ID) AS ELEMENT_ID_filled
INTO #fc_147
FROM SMRTDTA_ELEM_DOCUMENT;

-- ---- fc_148 <- SMRTDTA_ELEM_DONOR ----
-- This table is a bridge between donor context SmartData element values and the source donor records.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(HLV_ID) AS HLV_ID_filled,
    COUNT(DONOR_RECORD_ID) AS DONOR_RECORD_ID_filled,
    COUNT(ELEMENT_ID) AS ELEMENT_ID_filled
INTO #fc_148
FROM SMRTDTA_ELEM_DONOR;

-- ---- fc_149 <- SMRTDTA_ELEM_ENCOUNTER ----
-- This table is a bridge between encounter context SmartData element values and the source patient encounter contacts.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(HLV_ID) AS HLV_ID_filled,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(PAT_ID) AS PAT_ID_filled,
    COUNT(ELEMENT_ID) AS ELEMENT_ID_filled
INTO #fc_149
FROM SMRTDTA_ELEM_ENCOUNTER;

-- ---- fc_150 <- SMRTDTA_ELEM_EPISODE ----
-- This table is a bridge between episode context SmartData element values and the source episode records.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(HLV_ID) AS HLV_ID_filled,
    COUNT(EPISODE_ID) AS EPISODE_ID_filled,
    COUNT(ELEMENT_ID) AS ELEMENT_ID_filled
INTO #fc_150
FROM SMRTDTA_ELEM_EPISODE;

-- ---- fc_151 <- SMRTDTA_ELEM_EPISODE_GRP ----
-- This table is a bridge between episode group context SmartData element values and the source episode records.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(HLV_ID) AS HLV_ID_filled,
    COUNT(EPISODE_ID) AS EPISODE_ID_filled,
    COUNT(ELEMENT_ID) AS ELEMENT_ID_filled
INTO #fc_151
FROM SMRTDTA_ELEM_EPISODE_GRP;

-- ---- fc_152 <- SMRTDTA_ELEM_FIN_ASST_CAS ----
-- This table is a bridge between finacial assistance case context SmartData element values and the source case records.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(HLV_ID) AS HLV_ID_filled,
    COUNT(FIN_ASST_CASE_ID) AS FIN_ASST_CASE_ID_filled,
    COUNT(ELEMENT_ID) AS ELEMENT_ID_filled
INTO #fc_152
FROM SMRTDTA_ELEM_FIN_ASST_CAS;

-- ---- fc_153 <- SMRTDTA_ELEM_HISTORY ----
-- This table is a bridge between history context SmartData element values and the source patient history contacts.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(HLV_ID) AS HLV_ID_filled,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(PAT_ID) AS PAT_ID_filled,
    COUNT(ELEMENT_ID) AS ELEMENT_ID_filled
INTO #fc_153
FROM SMRTDTA_ELEM_HISTORY;

-- ---- fc_154 <- SMRTDTA_ELEM_INFERT_CYCLE ----
-- This table is a bridge between infertility cycle context SmartData element values and the source cycle records.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(HLV_ID) AS HLV_ID_filled,
    COUNT(CYCLE_ID) AS CYCLE_ID_filled,
    COUNT(ELEMENT_ID) AS ELEMENT_ID_filled
INTO #fc_154
FROM SMRTDTA_ELEM_INFERT_CYCLE;

-- ---- fc_155 <- SMRTDTA_ELEM_LAB_RESULT ----
-- This table is a bridge between SmartData element values and the source result records. Currently only being used for Fertility purposes.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(HLV_ID) AS HLV_ID_filled,
    COUNT(ELEMENT_ID) AS ELEMENT_ID_filled,
    COUNT(RESULT_ID) AS RESULT_ID_filled
INTO #fc_155
FROM SMRTDTA_ELEM_LAB_RESULT;

-- ---- fc_156 <- SMRTDTA_ELEM_NOTE ----
-- This table is a bridge between note context SmartData element values and the source note records.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(HLV_ID) AS HLV_ID_filled,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(ELEMENT_ID) AS ELEMENT_ID_filled
INTO #fc_156
FROM SMRTDTA_ELEM_NOTE;

-- ---- fc_157 <- SMRTDTA_ELEM_ORDER ----
-- This table is a bridge between order context SmartData element values and the source order records.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(HLV_ID) AS HLV_ID_filled,
    COUNT(ORDER_ID) AS ORDER_ID_filled,
    COUNT(ELEMENT_ID) AS ELEMENT_ID_filled
INTO #fc_157
FROM SMRTDTA_ELEM_ORDER;

-- ---- fc_158 <- SMRTDTA_ELEM_ORGAN ----
-- This table is a bridge between organ context SmartData element values and the source organ records.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(HLV_ID) AS HLV_ID_filled,
    COUNT(ORG_RECORD_ID) AS ORG_RECORD_ID_filled,
    COUNT(ELEMENT_ID) AS ELEMENT_ID_filled
INTO #fc_158
FROM SMRTDTA_ELEM_ORGAN;

-- ---- fc_159 <- SMRTDTA_ELEM_PATIENT ----
-- This table is a bridge between patient context SmartData element values and the source patient records.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(HLV_ID) AS HLV_ID_filled,
    COUNT(PAT_ID) AS PAT_ID_filled,
    COUNT(ELEMENT_ID) AS ELEMENT_ID_filled
INTO #fc_159
FROM SMRTDTA_ELEM_PATIENT;

-- ---- fc_160 <- SMRTDTA_ELEM_PAT_ENTERED ----
-- This table is a bridge between patient entered context SmartData element values and the source patient records.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(HLV_ID) AS HLV_ID_filled,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(PAT_ID) AS PAT_ID_filled,
    COUNT(ELEMENT_ID) AS ELEMENT_ID_filled
INTO #fc_160
FROM SMRTDTA_ELEM_PAT_ENTERED;

-- ---- fc_161 <- SMRTDTA_ELEM_PROBLEM ----
-- This table is a bridge between problem context SmartData element values and the source problem list records.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(HLV_ID) AS HLV_ID_filled,
    COUNT(PROBLEM_LIST_ID) AS PROBLEM_LIST_ID_filled,
    COUNT(ELEMENT_ID) AS ELEMENT_ID_filled
INTO #fc_161
FROM SMRTDTA_ELEM_PROBLEM;

-- ---- fc_162 <- SMRTDTA_ELEM_REGISTRY ----
-- This table is a bridge between registry context SmartData element values and the source registry data records.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(HLV_ID) AS HLV_ID_filled,
    COUNT(REGISTRY_DATA_ID) AS REGISTRY_DATA_ID_filled,
    COUNT(ELEMENT_ID) AS ELEMENT_ID_filled
INTO #fc_162
FROM SMRTDTA_ELEM_REGISTRY;

-- ---- fc_163 <- SMRTDTA_ELEM_RESULT ----
-- This table is a bridge between result context SmartData element values and the source result records.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(HLV_ID) AS HLV_ID_filled,
    COUNT(FINDING_ID) AS FINDING_ID_filled,
    COUNT(ELEMENT_ID) AS ELEMENT_ID_filled
INTO #fc_163
FROM SMRTDTA_ELEM_RESULT;

-- ---- fc_164 <- SMRTDTA_ELEM_RESULT_CNCT ----
-- This table is a bridge between result contact context SmartData element values and the source result record contacts.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(HLV_ID) AS HLV_ID_filled,
    COUNT(FINDING_CSN_ID) AS FINDING_CSN_ID_filled,
    COUNT(FINDING_ID) AS FINDING_ID_filled,
    COUNT(ELEMENT_ID) AS ELEMENT_ID_filled
INTO #fc_164
FROM SMRTDTA_ELEM_RESULT_CNCT;

-- ---- fc_165 <- SMRTDTA_ELEM_STAGE ----
-- This table is a bridge between stage context SmartData element values and the source stage records.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(HLV_ID) AS HLV_ID_filled,
    COUNT(STAGE_ID) AS STAGE_ID_filled,
    COUNT(ELEMENT_ID) AS ELEMENT_ID_filled
INTO #fc_165
FROM SMRTDTA_ELEM_STAGE;

-- ---- fc_166 <- SMRTDTA_ELEM_SYNOPTIC ----
-- This table is a bridge between synoptic context SmartData element values and the source synoptic records.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(HLV_ID) AS HLV_ID_filled,
    COUNT(SYNOPTIC_ID) AS SYNOPTIC_ID_filled,
    COUNT(ELEMENT_ID) AS ELEMENT_ID_filled
INTO #fc_166
FROM SMRTDTA_ELEM_SYNOPTIC;

-- ---- fc_167 <- SMRTDTA_ELEM_WAITING_LST ----
-- This table is a bridge between Waiting List context SmartData element values and the source Waiting List records.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(HLV_ID) AS HLV_ID_filled,
    COUNT(WAITING_LIST_ID) AS WAITING_LIST_ID_filled,
    COUNT(ELEMENT_ID) AS ELEMENT_ID_filled
INTO #fc_167
FROM SMRTDTA_ELEM_WAITING_LST;

-- ---- fc_168 <- SUBSCRIBER_ADDR_MSG ----
-- This table contains the address validation messages for the subscriber address.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(COVERAGE_ID) AS COVERAGE_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(ADDR_VALIDATION_MESSAGE) AS ADDR_VALIDATION_MESSAGE_filled
INTO #fc_168
FROM SUBSCRIBER_ADDR_MSG;

-- ---- fc_169 <- TX_ADDENDUM_NOTES ----
-- Extract Note (HNO) records containing addendum information for the note.
-- Bucket(s): addendum
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_CSN_ID) AS NOTE_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(TX_ADDENDUM_NOTE_ID) AS TX_ADDENDUM_NOTE_ID_filled
INTO #fc_169
FROM TX_ADDENDUM_NOTES
GROUP BY YEAR(CONTACT_DATE);

-- ---- fc_170 <- V_EHI_SMRTDTA_ELEM_VAL_EXT ----
-- This view contains current values for SmartData elements, includes an external formatted value column, and an Electronic Health Information column descriptor column for values that
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- no date/datetime-typed column found on this table; flat total only
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(HLV_ID) AS HLV_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(SMRTDTA_ELEM_VALUE) AS SMRTDTA_ELEM_VALUE_filled,
    COUNT(SMRTDTA_ELEM_VALUE_EXTERNAL) AS SMRTDTA_ELEM_VALUE_EXTERNAL_filled,
    COUNT(COLUMN_DESCRIPTOR) AS COLUMN_DESCRIPTOR_filled
INTO #fc_170
FROM V_EHI_SMRTDTA_ELEM_VAL_EXT;

-- ============================== PHASE 2 ==============================
-- The one result set this script returns: every staging table's wide
-- aggregate row, reshaped into long format (one row per table/column/
-- year) and unioned together. Export this grid and send it back.

SELECT table_name, column_name, activity_year, total_rows, filled_count
FROM (
    SELECT 'ABN_DOCUMENT_ID' AS table_name, 'PAT_ENC_CSN_ID' AS column_name, activity_year, total_rows, PAT_ENC_CSN_ID_filled AS filled_count FROM #fc_001
    UNION ALL
    SELECT 'ABN_DOCUMENT_ID' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_001
    UNION ALL
    SELECT 'ABN_DOCUMENT_ID' AS table_name, 'PAT_ENC_DATE_REAL' AS column_name, activity_year, total_rows, PAT_ENC_DATE_REAL_filled AS filled_count FROM #fc_001
    UNION ALL
    SELECT 'ABN_DOCUMENT_ID' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_001
    UNION ALL
    SELECT 'ABN_DOCUMENT_ID' AS table_name, 'ABN_DOCUMENT_ID' AS column_name, activity_year, total_rows, ABN_DOCUMENT_ID_filled AS filled_count FROM #fc_001
    UNION ALL
    SELECT 'ABN_NOTE_COMMENTS' AS table_name, 'NOTE_CSN_ID' AS column_name, activity_year, total_rows, NOTE_CSN_ID_filled AS filled_count FROM #fc_002
    UNION ALL
    SELECT 'ABN_NOTE_COMMENTS' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_002
    UNION ALL
    SELECT 'ABN_NOTE_COMMENTS' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_002
    UNION ALL
    SELECT 'ABN_NOTE_COMMENTS' AS table_name, 'CONTACT_DATE_REAL' AS column_name, activity_year, total_rows, CONTACT_DATE_REAL_filled AS filled_count FROM #fc_002
    UNION ALL
    SELECT 'ABN_NOTE_COMMENTS' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_002
    UNION ALL
    SELECT 'ABN_NOTE_COMMENTS' AS table_name, 'ABN_FOLUP_COMMENTS' AS column_name, activity_year, total_rows, ABN_FOLUP_COMMENTS_filled AS filled_count FROM #fc_002
    UNION ALL
    SELECT 'ABN_NOTE_CONTACT_SERVICE' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_003
    UNION ALL
    SELECT 'ABN_NOTE_CONTACT_SERVICE' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_003
    UNION ALL
    SELECT 'ABN_NOTE_CONTACT_SERVICE' AS table_name, 'ABN_PROC_ID_PROC_NAME' AS column_name, activity_year, total_rows, ABN_PROC_ID_PROC_NAME_filled AS filled_count FROM #fc_003
    UNION ALL
    SELECT 'ABN_NOTE_CONTACT_SERVICE' AS table_name, 'ABN_REASON_FOR_NONCOVERAGE' AS column_name, activity_year, total_rows, ABN_REASON_FOR_NONCOVERAGE_filled AS filled_count FROM #fc_003
    UNION ALL
    SELECT 'ABN_NOTE_CONTACT_SERVICE' AS table_name, 'ABN_TRIGGERING_REASON' AS column_name, activity_year, total_rows, ABN_TRIGGERING_REASON_filled AS filled_count FROM #fc_003
    UNION ALL
    SELECT 'ABN_NOTE_CONTACT_SERVICE' AS table_name, 'ABN_PRICE_PER_SERVICE' AS column_name, activity_year, total_rows, ABN_PRICE_PER_SERVICE_filled AS filled_count FROM #fc_003
    UNION ALL
    SELECT 'ABN_NOTE_CONTACT_SERVICE' AS table_name, 'ABN_MODIFIER_USED' AS column_name, activity_year, total_rows, ABN_MODIFIER_USED_filled AS filled_count FROM #fc_003
    UNION ALL
    SELECT 'ABN_NOTE_CONTACT_SERVICE' AS table_name, 'ABN_ORIGINAL_PRICE_PER_SERVICE' AS column_name, activity_year, total_rows, ABN_ORIGINAL_PRICE_PER_SERVICE_filled AS filled_count FROM #fc_003
    UNION ALL
    SELECT 'ABN_NOTE_CONTACT_SERVICE' AS table_name, 'ABN_MEDICATION_ID_MEDICATION_NAME' AS column_name, activity_year, total_rows, ABN_MEDICATION_ID_MEDICATION_NAME_filled AS filled_count FROM #fc_003
    UNION ALL
    SELECT 'ABN_NOTE_CONTACT_SERVICE' AS table_name, 'ABN_FAILED_LCD_C' AS column_name, activity_year, total_rows, ABN_FAILED_LCD_C_filled AS filled_count FROM #fc_003
    UNION ALL
    SELECT 'ABN_NOTE_CONTACT_SERVICE' AS table_name, 'ABN_SERVICE_DUR' AS column_name, activity_year, total_rows, ABN_SERVICE_DUR_filled AS filled_count FROM #fc_003
    UNION ALL
    SELECT 'ABN_NOTE_PROC' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_004
    UNION ALL
    SELECT 'ABN_NOTE_PROC' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_004
    UNION ALL
    SELECT 'ABN_NOTE_PROC' AS table_name, 'ABN_PROC_FREQ_DUR' AS column_name, activity_year, total_rows, ABN_PROC_FREQ_DUR_filled AS filled_count FROM #fc_004
    UNION ALL
    SELECT 'ACCESSIBLE_DOCUMENTS_PREF' AS table_name, 'PAT_ID' AS column_name, activity_year, total_rows, PAT_ID_filled AS filled_count FROM #fc_005
    UNION ALL
    SELECT 'ACCESSIBLE_DOCUMENTS_PREF' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_005
    UNION ALL
    SELECT 'ACCESSIBLE_DOCUMENTS_PREF' AS table_name, 'ACCESSIBLE_DOCUMENTS_PREF_C_NAME' AS column_name, activity_year, total_rows, ACCESSIBLE_DOCUMENTS_PREF_C_NAME_filled AS filled_count FROM #fc_005
    UNION ALL
    SELECT 'ACCT_HB_BNOTE' AS table_name, 'ACCT_ID' AS column_name, activity_year, total_rows, ACCT_ID_filled AS filled_count FROM #fc_006
    UNION ALL
    SELECT 'ACCT_HB_BNOTE' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_006
    UNION ALL
    SELECT 'ACCT_HB_BNOTE' AS table_name, 'HB_BILLING_NOTE' AS column_name, activity_year, total_rows, HB_BILLING_NOTE_filled AS filled_count FROM #fc_006
    UNION ALL
    SELECT 'ACCT_PB_BILL_NOTE' AS table_name, 'ACCT_ID' AS column_name, activity_year, total_rows, ACCT_ID_filled AS filled_count FROM #fc_007
    UNION ALL
    SELECT 'ACCT_PB_BILL_NOTE' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_007
    UNION ALL
    SELECT 'ACCT_PB_BILL_NOTE' AS table_name, 'BILLING_NOTE' AS column_name, activity_year, total_rows, BILLING_NOTE_filled AS filled_count FROM #fc_007
    UNION ALL
    SELECT 'ADDENDUM_VERSIONS' AS table_name, 'ORDER_ID' AS column_name, activity_year, total_rows, ORDER_ID_filled AS filled_count FROM #fc_008
    UNION ALL
    SELECT 'ADDENDUM_VERSIONS' AS table_name, 'CONTACT_DATE_REAL' AS column_name, activity_year, total_rows, CONTACT_DATE_REAL_filled AS filled_count FROM #fc_008
    UNION ALL
    SELECT 'ADDENDUM_VERSIONS' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_008
    UNION ALL
    SELECT 'ADDENDUM_VERSIONS' AS table_name, 'ADDENDUM_CONTACT' AS column_name, activity_year, total_rows, ADDENDUM_CONTACT_filled AS filled_count FROM #fc_008
    UNION ALL
    SELECT 'AUTH_REQUEST_HX_UNS_NOTE' AS table_name, 'AUTH_REQUEST_ID' AS column_name, activity_year, total_rows, AUTH_REQUEST_ID_filled AS filled_count FROM #fc_009
    UNION ALL
    SELECT 'AUTH_REQUEST_HX_UNS_NOTE' AS table_name, 'CONTACT_DATE_REAL' AS column_name, activity_year, total_rows, CONTACT_DATE_REAL_filled AS filled_count FROM #fc_009
    UNION ALL
    SELECT 'AUTH_REQUEST_HX_UNS_NOTE' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_009
    UNION ALL
    SELECT 'AUTH_REQUEST_HX_UNS_NOTE' AS table_name, 'UNSIGNED_NOTE_ID' AS column_name, activity_year, total_rows, UNSIGNED_NOTE_ID_filled AS filled_count FROM #fc_009
    UNION ALL
    SELECT 'BLOCK_NOTE_COPIES' AS table_name, 'NOTE_CSN_ID' AS column_name, activity_year, total_rows, NOTE_CSN_ID_filled AS filled_count FROM #fc_010
    UNION ALL
    SELECT 'BLOCK_NOTE_COPIES' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_010
    UNION ALL
    SELECT 'BLOCK_NOTE_COPIES' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_010
    UNION ALL
    SELECT 'BLOCK_NOTE_COPIES' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_010
    UNION ALL
    SELECT 'BLOCK_NOTE_COPIES' AS table_name, 'BLOCK_CPY_NOTE_ID' AS column_name, activity_year, total_rows, BLOCK_CPY_NOTE_ID_filled AS filled_count FROM #fc_010
    UNION ALL
    SELECT 'BLOCK_NOTE_COPIES' AS table_name, 'BLOCK_CPY_YN' AS column_name, activity_year, total_rows, BLOCK_CPY_YN_filled AS filled_count FROM #fc_010
    UNION ALL
    SELECT 'CAREPLAN_PROG_NOTE' AS table_name, 'CARE_INTG_ID' AS column_name, activity_year, total_rows, CARE_INTG_ID_filled AS filled_count FROM #fc_011
    UNION ALL
    SELECT 'CAREPLAN_PROG_NOTE' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_011
    UNION ALL
    SELECT 'CAREPLAN_PROG_NOTE' AS table_name, 'CP_PROG_NOTES_ID' AS column_name, activity_year, total_rows, CP_PROG_NOTES_ID_filled AS filled_count FROM #fc_011
    UNION ALL
    SELECT 'CHILD_NOTE_INFO' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_012
    UNION ALL
    SELECT 'CHILD_NOTE_INFO' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_012
    UNION ALL
    SELECT 'CHILD_NOTE_INFO' AS table_name, 'TEXT_NOTE_CSN_ID' AS column_name, activity_year, total_rows, TEXT_NOTE_CSN_ID_filled AS filled_count FROM #fc_012
    UNION ALL
    SELECT 'CHILD_NOTE_INFO' AS table_name, 'LINK_TYPE_C_NAME' AS column_name, activity_year, total_rows, LINK_TYPE_C_NAME_filled AS filled_count FROM #fc_012
    UNION ALL
    SELECT 'CHILD_NOTE_INFO' AS table_name, 'LINK_USER_ID' AS column_name, activity_year, total_rows, LINK_USER_ID_filled AS filled_count FROM #fc_012
    UNION ALL
    SELECT 'CHILD_NOTE_INFO' AS table_name, 'LINK_USER_ID_NAME' AS column_name, activity_year, total_rows, LINK_USER_ID_NAME_filled AS filled_count FROM #fc_012
    UNION ALL
    SELECT 'CHILD_NOTE_INFO' AS table_name, 'LINK_UTC' AS column_name, activity_year, total_rows, LINK_UTC_filled AS filled_count FROM #fc_012
    UNION ALL
    SELECT 'CHILD_NOTE_INFO' AS table_name, 'SOURCE_NOTE_CSN_ID' AS column_name, activity_year, total_rows, SOURCE_NOTE_CSN_ID_filled AS filled_count FROM #fc_012
    UNION ALL
    SELECT 'CHILD_NOTE_INFO' AS table_name, 'LINK_DTTM' AS column_name, activity_year, total_rows, LINK_DTTM_filled AS filled_count FROM #fc_012
    UNION ALL
    SELECT 'CLM_NOTE' AS table_name, 'RECORD_ID' AS column_name, activity_year, total_rows, RECORD_ID_filled AS filled_count FROM #fc_013
    UNION ALL
    SELECT 'CLM_NOTE' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_013
    UNION ALL
    SELECT 'CLM_NOTE' AS table_name, 'CLM_NOTE' AS column_name, activity_year, total_rows, CLM_NOTE_filled AS filled_count FROM #fc_013
    UNION ALL
    SELECT 'CONTACT_POINT_DOCUMENTS' AS table_name, 'EDUCATION_RECORD_ID' AS column_name, activity_year, total_rows, EDUCATION_RECORD_ID_filled AS filled_count FROM #fc_014
    UNION ALL
    SELECT 'CONTACT_POINT_DOCUMENTS' AS table_name, 'CONTACT_DATE_REAL' AS column_name, activity_year, total_rows, CONTACT_DATE_REAL_filled AS filled_count FROM #fc_014
    UNION ALL
    SELECT 'CONTACT_POINT_DOCUMENTS' AS table_name, 'GROUP_LINE' AS column_name, activity_year, total_rows, GROUP_LINE_filled AS filled_count FROM #fc_014
    UNION ALL
    SELECT 'CONTACT_POINT_DOCUMENTS' AS table_name, 'VALUE_LINE' AS column_name, activity_year, total_rows, VALUE_LINE_filled AS filled_count FROM #fc_014
    UNION ALL
    SELECT 'CONTACT_POINT_DOCUMENTS' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_014
    UNION ALL
    SELECT 'CONTACT_POINT_DOCUMENTS' AS table_name, 'CONTACT_POINT_DCS_ID' AS column_name, activity_year, total_rows, CONTACT_POINT_DCS_ID_filled AS filled_count FROM #fc_014
    UNION ALL
    SELECT 'CONTACT_TITLE_DOCUMENTS' AS table_name, 'EDUCATION_RECORD_ID' AS column_name, activity_year, total_rows, EDUCATION_RECORD_ID_filled AS filled_count FROM #fc_015
    UNION ALL
    SELECT 'CONTACT_TITLE_DOCUMENTS' AS table_name, 'CONTACT_DATE_REAL' AS column_name, activity_year, total_rows, CONTACT_DATE_REAL_filled AS filled_count FROM #fc_015
    UNION ALL
    SELECT 'CONTACT_TITLE_DOCUMENTS' AS table_name, 'GROUP_LINE' AS column_name, activity_year, total_rows, GROUP_LINE_filled AS filled_count FROM #fc_015
    UNION ALL
    SELECT 'CONTACT_TITLE_DOCUMENTS' AS table_name, 'VALUE_LINE' AS column_name, activity_year, total_rows, VALUE_LINE_filled AS filled_count FROM #fc_015
    UNION ALL
    SELECT 'CONTACT_TITLE_DOCUMENTS' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_015
    UNION ALL
    SELECT 'CONTACT_TITLE_DOCUMENTS' AS table_name, 'CONTACT_TITLE_DCS_ID' AS column_name, activity_year, total_rows, CONTACT_TITLE_DCS_ID_filled AS filled_count FROM #fc_015
    UNION ALL
    SELECT 'CONTACT_TOPIC_DOCUMENTS' AS table_name, 'EDUCATION_RECORD_ID' AS column_name, activity_year, total_rows, EDUCATION_RECORD_ID_filled AS filled_count FROM #fc_016
    UNION ALL
    SELECT 'CONTACT_TOPIC_DOCUMENTS' AS table_name, 'CONTACT_DATE_REAL' AS column_name, activity_year, total_rows, CONTACT_DATE_REAL_filled AS filled_count FROM #fc_016
    UNION ALL
    SELECT 'CONTACT_TOPIC_DOCUMENTS' AS table_name, 'GROUP_LINE' AS column_name, activity_year, total_rows, GROUP_LINE_filled AS filled_count FROM #fc_016
    UNION ALL
    SELECT 'CONTACT_TOPIC_DOCUMENTS' AS table_name, 'VALUE_LINE' AS column_name, activity_year, total_rows, VALUE_LINE_filled AS filled_count FROM #fc_016
    UNION ALL
    SELECT 'CONTACT_TOPIC_DOCUMENTS' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_016
    UNION ALL
    SELECT 'CONTACT_TOPIC_DOCUMENTS' AS table_name, 'CONTACT_TOPIC_DCS_ID' AS column_name, activity_year, total_rows, CONTACT_TOPIC_DCS_ID_filled AS filled_count FROM #fc_016
    UNION ALL
    SELECT 'COVERAGE_NOTE_INFO' AS table_name, 'COVERAGE_ID' AS column_name, activity_year, total_rows, COVERAGE_ID_filled AS filled_count FROM #fc_017
    UNION ALL
    SELECT 'COVERAGE_NOTE_INFO' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_017
    UNION ALL
    SELECT 'COVERAGE_NOTE_INFO' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_017
    UNION ALL
    SELECT 'COVERAGE_NOTE_INFO' AS table_name, 'NOTE_DATE' AS column_name, activity_year, total_rows, NOTE_DATE_filled AS filled_count FROM #fc_017
    UNION ALL
    SELECT 'COVERAGE_NOTE_INFO' AS table_name, 'NOTE_DTTM' AS column_name, activity_year, total_rows, NOTE_DTTM_filled AS filled_count FROM #fc_017
    UNION ALL
    SELECT 'COVERAGE_NOTE_INFO' AS table_name, 'NOTE_USER_ID' AS column_name, activity_year, total_rows, NOTE_USER_ID_filled AS filled_count FROM #fc_017
    UNION ALL
    SELECT 'COVERAGE_NOTE_INFO' AS table_name, 'NOTE_USER_ID_NAME' AS column_name, activity_year, total_rows, NOTE_USER_ID_NAME_filled AS filled_count FROM #fc_017
    UNION ALL
    SELECT 'CP_NOTE_READING_HX' AS table_name, 'NOTE_CSN_ID' AS column_name, activity_year, total_rows, NOTE_CSN_ID_filled AS filled_count FROM #fc_018
    UNION ALL
    SELECT 'CP_NOTE_READING_HX' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_018
    UNION ALL
    SELECT 'CP_NOTE_READING_HX' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_018
    UNION ALL
    SELECT 'CP_NOTE_READING_HX' AS table_name, 'CONTACT_DATE_REAL' AS column_name, activity_year, total_rows, CONTACT_DATE_REAL_filled AS filled_count FROM #fc_018
    UNION ALL
    SELECT 'CP_NOTE_READING_HX' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_018
    UNION ALL
    SELECT 'CP_NOTE_READING_HX' AS table_name, 'CARE_PLAN_HX_CSN_ID' AS column_name, activity_year, total_rows, CARE_PLAN_HX_CSN_ID_filled AS filled_count FROM #fc_018
    UNION ALL
    SELECT 'DOCS_RCVD_ASMT_PLAN_NOTE' AS table_name, 'DOCUMENT_ID' AS column_name, activity_year, total_rows, DOCUMENT_ID_filled AS filled_count FROM #fc_019
    UNION ALL
    SELECT 'DOCS_RCVD_ASMT_PLAN_NOTE' AS table_name, 'CONTACT_DATE_REAL' AS column_name, activity_year, total_rows, CONTACT_DATE_REAL_filled AS filled_count FROM #fc_019
    UNION ALL
    SELECT 'DOCS_RCVD_ASMT_PLAN_NOTE' AS table_name, 'GROUP_LINE' AS column_name, activity_year, total_rows, GROUP_LINE_filled AS filled_count FROM #fc_019
    UNION ALL
    SELECT 'DOCS_RCVD_ASMT_PLAN_NOTE' AS table_name, 'VALUE_LINE' AS column_name, activity_year, total_rows, VALUE_LINE_filled AS filled_count FROM #fc_019
    UNION ALL
    SELECT 'DOCS_RCVD_ASMT_PLAN_NOTE' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_019
    UNION ALL
    SELECT 'DOCS_RCVD_ASMT_PLAN_NOTE' AS table_name, 'ASMT_PLAN_NOTE_ID' AS column_name, activity_year, total_rows, ASMT_PLAN_NOTE_ID_filled AS filled_count FROM #fc_019
    UNION ALL
    SELECT 'DOCS_RCVD_CLN_NOTE_SIGNRS' AS table_name, 'DOCUMENT_ID' AS column_name, activity_year, total_rows, DOCUMENT_ID_filled AS filled_count FROM #fc_020
    UNION ALL
    SELECT 'DOCS_RCVD_CLN_NOTE_SIGNRS' AS table_name, 'CONTACT_DATE_REAL' AS column_name, activity_year, total_rows, CONTACT_DATE_REAL_filled AS filled_count FROM #fc_020
    UNION ALL
    SELECT 'DOCS_RCVD_CLN_NOTE_SIGNRS' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_020
    UNION ALL
    SELECT 'DOCS_RCVD_CLN_NOTE_SIGNRS' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_020
    UNION ALL
    SELECT 'DOCS_RCVD_CLN_NOTE_SIGNRS' AS table_name, 'NOTE_REFERENCE_IDENT' AS column_name, activity_year, total_rows, NOTE_REFERENCE_IDENT_filled AS filled_count FROM #fc_020
    UNION ALL
    SELECT 'DOCS_RCVD_CLN_NOTE_SIGNRS' AS table_name, 'NOTE_LOCAL_UNIQUE_IDENT' AS column_name, activity_year, total_rows, NOTE_LOCAL_UNIQUE_IDENT_filled AS filled_count FROM #fc_020
    UNION ALL
    SELECT 'DOCS_RCVD_CLN_NOTE_SIGNRS' AS table_name, 'NOTE_SIGNER_NAME' AS column_name, activity_year, total_rows, NOTE_SIGNER_NAME_filled AS filled_count FROM #fc_020
    UNION ALL
    SELECT 'DOCS_RCVD_CLN_NOTE_SIGNRS' AS table_name, 'NOTE_SIGNED_UTC_DTTM' AS column_name, activity_year, total_rows, NOTE_SIGNED_UTC_DTTM_filled AS filled_count FROM #fc_020
    UNION ALL
    SELECT 'DOCS_RCVD_CLN_NOTE_SIGNRS' AS table_name, 'NOTE_SIGNER_ROLE_C_NAME' AS column_name, activity_year, total_rows, NOTE_SIGNER_ROLE_C_NAME_filled AS filled_count FROM #fc_020
    UNION ALL
    SELECT 'DOCS_RCVD_CLN_NOTE_SIGNRS' AS table_name, 'NOTE_SIGNER_NPI' AS column_name, activity_year, total_rows, NOTE_SIGNER_NPI_filled AS filled_count FROM #fc_020
    UNION ALL
    SELECT 'DOCS_RCVD_INTVN_NOTE' AS table_name, 'DOCUMENT_ID' AS column_name, activity_year, total_rows, DOCUMENT_ID_filled AS filled_count FROM #fc_021
    UNION ALL
    SELECT 'DOCS_RCVD_INTVN_NOTE' AS table_name, 'CONTACT_DATE_REAL' AS column_name, activity_year, total_rows, CONTACT_DATE_REAL_filled AS filled_count FROM #fc_021
    UNION ALL
    SELECT 'DOCS_RCVD_INTVN_NOTE' AS table_name, 'GROUP_LINE' AS column_name, activity_year, total_rows, GROUP_LINE_filled AS filled_count FROM #fc_021
    UNION ALL
    SELECT 'DOCS_RCVD_INTVN_NOTE' AS table_name, 'VALUE_LINE' AS column_name, activity_year, total_rows, VALUE_LINE_filled AS filled_count FROM #fc_021
    UNION ALL
    SELECT 'DOCS_RCVD_INTVN_NOTE' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_021
    UNION ALL
    SELECT 'DOCS_RCVD_NOTE_SECTIONS' AS table_name, 'DOCUMENT_ID' AS column_name, activity_year, total_rows, DOCUMENT_ID_filled AS filled_count FROM #fc_022
    UNION ALL
    SELECT 'DOCS_RCVD_NOTE_SECTIONS' AS table_name, 'CONTACT_DATE_REAL' AS column_name, activity_year, total_rows, CONTACT_DATE_REAL_filled AS filled_count FROM #fc_022
    UNION ALL
    SELECT 'DOCS_RCVD_NOTE_SECTIONS' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_022
    UNION ALL
    SELECT 'DOCS_RCVD_NOTE_SECTIONS' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_022
    UNION ALL
    SELECT 'DOCS_RCVD_NOTE_SECTIONS' AS table_name, 'NOTE_SECTION_IDENTIFIER' AS column_name, activity_year, total_rows, NOTE_SECTION_IDENTIFIER_filled AS filled_count FROM #fc_022
    UNION ALL
    SELECT 'DOCS_RCVD_NOTE_SECTIONS' AS table_name, 'NOTE_SECTION_TYPE' AS column_name, activity_year, total_rows, NOTE_SECTION_TYPE_filled AS filled_count FROM #fc_022
    UNION ALL
    SELECT 'DOCS_RCVD_NOTE_SECTIONS' AS table_name, 'NOTE_SECTION_NOTE_ID' AS column_name, activity_year, total_rows, NOTE_SECTION_NOTE_ID_filled AS filled_count FROM #fc_022
    UNION ALL
    SELECT 'DOCS_RCVD_NOTE_SECTIONS' AS table_name, 'CONTACT_SERIAL_NUM' AS column_name, activity_year, total_rows, CONTACT_SERIAL_NUM_filled AS filled_count FROM #fc_022
    UNION ALL
    SELECT 'DOCS_RCVD_NOTE_SECTIONS' AS table_name, 'NOTE_SECTION_LENGTH' AS column_name, activity_year, total_rows, NOTE_SECTION_LENGTH_filled AS filled_count FROM #fc_022
    UNION ALL
    SELECT 'DOCS_RCVD_NOTE_SECTIONS' AS table_name, 'HUMAN_REVIEWED_YN' AS column_name, activity_year, total_rows, HUMAN_REVIEWED_YN_filled AS filled_count FROM #fc_022
    UNION ALL
    SELECT 'DOCS_RCVD_PCCNOTE' AS table_name, 'DOCUMENT_ID' AS column_name, activity_year, total_rows, DOCUMENT_ID_filled AS filled_count FROM #fc_023
    UNION ALL
    SELECT 'DOCS_RCVD_PCCNOTE' AS table_name, 'CONTACT_DATE_REAL' AS column_name, activity_year, total_rows, CONTACT_DATE_REAL_filled AS filled_count FROM #fc_023
    UNION ALL
    SELECT 'DOCS_RCVD_PCCNOTE' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_023
    UNION ALL
    SELECT 'DOCS_RCVD_PCCNOTE' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_023
    UNION ALL
    SELECT 'DOCS_RCVD_PCCNOTE' AS table_name, 'PCCNOTE_REF_ID' AS column_name, activity_year, total_rows, PCCNOTE_REF_ID_filled AS filled_count FROM #fc_023
    UNION ALL
    SELECT 'DOCS_RCVD_PCCNOTE' AS table_name, 'PCCNOTE_SIGNED_INST_DTTM' AS column_name, activity_year, total_rows, PCCNOTE_SIGNED_INST_DTTM_filled AS filled_count FROM #fc_023
    UNION ALL
    SELECT 'DOCS_RCVD_PCCNOTE' AS table_name, 'PCCNOTE_AUTHOR' AS column_name, activity_year, total_rows, PCCNOTE_AUTHOR_filled AS filled_count FROM #fc_023
    UNION ALL
    SELECT 'DOCS_RCVD_PCCNOTE' AS table_name, 'PCCNOTE_ID' AS column_name, activity_year, total_rows, PCCNOTE_ID_filled AS filled_count FROM #fc_023
    UNION ALL
    SELECT 'DOCS_RCVD_PCCNOTE' AS table_name, 'PCCNOTE_SRC_CSN' AS column_name, activity_year, total_rows, PCCNOTE_SRC_CSN_filled AS filled_count FROM #fc_023
    UNION ALL
    SELECT 'DOCS_RCVD_PCCNOTE' AS table_name, 'PCC_LST_UPD_INST_DTTM' AS column_name, activity_year, total_rows, PCC_LST_UPD_INST_DTTM_filled AS filled_count FROM #fc_023
    UNION ALL
    SELECT 'DOCS_RCVD_RSLTS_ADDENDUM' AS table_name, 'DOCUMENT_ID' AS column_name, activity_year, total_rows, DOCUMENT_ID_filled AS filled_count FROM #fc_024
    UNION ALL
    SELECT 'DOCS_RCVD_RSLTS_ADDENDUM' AS table_name, 'CONTACT_DATE_REAL' AS column_name, activity_year, total_rows, CONTACT_DATE_REAL_filled AS filled_count FROM #fc_024
    UNION ALL
    SELECT 'DOCS_RCVD_RSLTS_ADDENDUM' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_024
    UNION ALL
    SELECT 'DOCS_RCVD_RSLTS_ADDENDUM' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_024
    UNION ALL
    SELECT 'DOCS_RCVD_RSLTS_ADDENDUM' AS table_name, 'RSLT_ADDEND_REFID' AS column_name, activity_year, total_rows, RSLT_ADDEND_REFID_filled AS filled_count FROM #fc_024
    UNION ALL
    SELECT 'DOCS_RCVD_RSLTS_ADDENDUM' AS table_name, 'RSLT_ADDEND_NOTE_ID' AS column_name, activity_year, total_rows, RSLT_ADDEND_NOTE_ID_filled AS filled_count FROM #fc_024
    UNION ALL
    SELECT 'DOCS_RCVD_RSLTS_ADDENDUM' AS table_name, 'RSLT_ADDEND_INS_UTC_DTTM' AS column_name, activity_year, total_rows, RSLT_ADDEND_INS_UTC_DTTM_filled AS filled_count FROM #fc_024
    UNION ALL
    SELECT 'DOCUMENT_SIG_DATA' AS table_name, 'DOCUMENT_ID' AS column_name, activity_year, total_rows, DOCUMENT_ID_filled AS filled_count FROM #fc_025
    UNION ALL
    SELECT 'DOCUMENT_SIG_DATA' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_025
    UNION ALL
    SELECT 'DOCUMENT_SIG_DATA' AS table_name, 'SIG_IMAGE_FILE' AS column_name, activity_year, total_rows, SIG_IMAGE_FILE_filled AS filled_count FROM #fc_025
    UNION ALL
    SELECT 'DOCUMENT_SIG_DATA' AS table_name, 'SIGNATURE_NAME' AS column_name, activity_year, total_rows, SIGNATURE_NAME_filled AS filled_count FROM #fc_025
    UNION ALL
    SELECT 'DOCUMENT_SIG_DATA' AS table_name, 'SIG_TIMESTAMP_DTTM' AS column_name, activity_year, total_rows, SIG_TIMESTAMP_DTTM_filled AS filled_count FROM #fc_025
    UNION ALL
    SELECT 'DOCUMENT_SIG_DATA' AS table_name, 'AUTH_USER_ID' AS column_name, activity_year, total_rows, AUTH_USER_ID_filled AS filled_count FROM #fc_025
    UNION ALL
    SELECT 'DOCUMENT_SIG_DATA' AS table_name, 'AUTH_USER_ID_NAME' AS column_name, activity_year, total_rows, AUTH_USER_ID_NAME_filled AS filled_count FROM #fc_025
    UNION ALL
    SELECT 'DOCUMENT_SIG_DATA' AS table_name, 'AUTH_MYPT_ID' AS column_name, activity_year, total_rows, AUTH_MYPT_ID_filled AS filled_count FROM #fc_025
    UNION ALL
    SELECT 'DOCUMENT_SIG_DATA' AS table_name, 'SIGNATURE_HIDDEN_YN' AS column_name, activity_year, total_rows, SIGNATURE_HIDDEN_YN_filled AS filled_count FROM #fc_025
    UNION ALL
    SELECT 'DOCUMENT_SMARTFORM_LIST' AS table_name, 'DOCUMENT_ID' AS column_name, activity_year, total_rows, DOCUMENT_ID_filled AS filled_count FROM #fc_026
    UNION ALL
    SELECT 'DOCUMENT_SMARTFORM_LIST' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_026
    UNION ALL
    SELECT 'DOCUMENT_SMARTFORM_LIST' AS table_name, 'DOCUMENT_SMARTFORM' AS column_name, activity_year, total_rows, DOCUMENT_SMARTFORM_filled AS filled_count FROM #fc_026
    UNION ALL
    SELECT 'DOCUMENT_STAMPS' AS table_name, 'DOCUMENT_ID' AS column_name, activity_year, total_rows, DOCUMENT_ID_filled AS filled_count FROM #fc_027
    UNION ALL
    SELECT 'DOCUMENT_STAMPS' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_027
    UNION ALL
    SELECT 'DOCUMENT_STAMPS' AS table_name, 'STAMP_TEXT' AS column_name, activity_year, total_rows, STAMP_TEXT_filled AS filled_count FROM #fc_027
    UNION ALL
    SELECT 'DOCUMENT_STAMPS' AS table_name, 'STAMP_TYPE_C_NAME' AS column_name, activity_year, total_rows, STAMP_TYPE_C_NAME_filled AS filled_count FROM #fc_027
    UNION ALL
    SELECT 'DOCUMENT_STAMPS' AS table_name, 'STAMP_ADD_USER_ID' AS column_name, activity_year, total_rows, STAMP_ADD_USER_ID_filled AS filled_count FROM #fc_027
    UNION ALL
    SELECT 'DOCUMENT_STAMPS' AS table_name, 'STAMP_ADD_USER_ID_NAME' AS column_name, activity_year, total_rows, STAMP_ADD_USER_ID_NAME_filled AS filled_count FROM #fc_027
    UNION ALL
    SELECT 'DOCUMENT_STAMPS' AS table_name, 'STAMP_ADDED_UTC_DTTM' AS column_name, activity_year, total_rows, STAMP_ADDED_UTC_DTTM_filled AS filled_count FROM #fc_027
    UNION ALL
    SELECT 'DP_COMM_MEMO_NOTE' AS table_name, 'PAT_ENC_CSN_ID' AS column_name, activity_year, total_rows, PAT_ENC_CSN_ID_filled AS filled_count FROM #fc_028
    UNION ALL
    SELECT 'DP_COMM_MEMO_NOTE' AS table_name, 'GROUP_LINE' AS column_name, activity_year, total_rows, GROUP_LINE_filled AS filled_count FROM #fc_028
    UNION ALL
    SELECT 'DP_COMM_MEMO_NOTE' AS table_name, 'VALUE_LINE' AS column_name, activity_year, total_rows, VALUE_LINE_filled AS filled_count FROM #fc_028
    UNION ALL
    SELECT 'DP_COMM_MEMO_NOTE' AS table_name, 'PAT_ID' AS column_name, activity_year, total_rows, PAT_ID_filled AS filled_count FROM #fc_028
    UNION ALL
    SELECT 'DP_COMM_MEMO_NOTE' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_028
    UNION ALL
    SELECT 'DP_COMM_MEMO_NOTE' AS table_name, 'CM_CT_OWNER_ID' AS column_name, activity_year, total_rows, CM_CT_OWNER_ID_filled AS filled_count FROM #fc_028
    UNION ALL
    SELECT 'DP_COMM_MEMO_NOTE' AS table_name, 'COMM_MEMO_NOTE_ID' AS column_name, activity_year, total_rows, COMM_MEMO_NOTE_ID_filled AS filled_count FROM #fc_028
    UNION ALL
    SELECT 'DP_SVC_COORD_NOTE' AS table_name, 'PAT_ENC_CSN_ID' AS column_name, activity_year, total_rows, PAT_ENC_CSN_ID_filled AS filled_count FROM #fc_029
    UNION ALL
    SELECT 'DP_SVC_COORD_NOTE' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_029
    UNION ALL
    SELECT 'DP_SVC_COORD_NOTE' AS table_name, 'PAT_ID' AS column_name, activity_year, total_rows, PAT_ID_filled AS filled_count FROM #fc_029
    UNION ALL
    SELECT 'DP_SVC_COORD_NOTE' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_029
    UNION ALL
    SELECT 'DP_SVC_COORD_NOTE' AS table_name, 'CM_CT_OWNER_ID' AS column_name, activity_year, total_rows, CM_CT_OWNER_ID_filled AS filled_count FROM #fc_029
    UNION ALL
    SELECT 'DP_SVC_COORD_NOTE' AS table_name, 'COORD_NOTE_ID' AS column_name, activity_year, total_rows, COORD_NOTE_ID_filled AS filled_count FROM #fc_029
    UNION ALL
    SELECT 'DP_SVC_COORD_NOTE' AS table_name, 'NOTE_IS_PINNED_YN' AS column_name, activity_year, total_rows, NOTE_IS_PINNED_YN_filled AS filled_count FROM #fc_029
    UNION ALL
    SELECT 'EMBRYOLOGY_DOCUMENTS' AS table_name, 'RESULT_ID' AS column_name, activity_year, total_rows, RESULT_ID_filled AS filled_count FROM #fc_030
    UNION ALL
    SELECT 'EMBRYOLOGY_DOCUMENTS' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_030
    UNION ALL
    SELECT 'EMBRYOLOGY_DOCUMENTS' AS table_name, 'EMBRYOLOGY_DOCUMENT_ID' AS column_name, activity_year, total_rows, EMBRYOLOGY_DOCUMENT_ID_filled AS filled_count FROM #fc_030
    UNION ALL
    SELECT 'ENC_DX_ASSOC_AMBIENT_DX' AS table_name, 'PAT_ENC_CSN_ID' AS column_name, activity_year, total_rows, PAT_ENC_CSN_ID_filled AS filled_count FROM #fc_031
    UNION ALL
    SELECT 'ENC_DX_ASSOC_AMBIENT_DX' AS table_name, 'GROUP_LINE' AS column_name, activity_year, total_rows, GROUP_LINE_filled AS filled_count FROM #fc_031
    UNION ALL
    SELECT 'ENC_DX_ASSOC_AMBIENT_DX' AS table_name, 'VALUE_LINE' AS column_name, activity_year, total_rows, VALUE_LINE_filled AS filled_count FROM #fc_031
    UNION ALL
    SELECT 'ENC_DX_ASSOC_AMBIENT_DX' AS table_name, 'PAT_ID' AS column_name, activity_year, total_rows, PAT_ID_filled AS filled_count FROM #fc_031
    UNION ALL
    SELECT 'ENC_DX_ASSOC_AMBIENT_DX' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_031
    UNION ALL
    SELECT 'ENC_DX_ASSOC_AMBIENT_DX' AS table_name, 'CM_CT_OWNER_ID' AS column_name, activity_year, total_rows, CM_CT_OWNER_ID_filled AS filled_count FROM #fc_031
    UNION ALL
    SELECT 'ENC_DX_ASSOC_AMBIENT_DX' AS table_name, 'DX_ASSOC_AMBIENT_DX' AS column_name, activity_year, total_rows, DX_ASSOC_AMBIENT_DX_filled AS filled_count FROM #fc_031
    UNION ALL
    SELECT 'EPRESCRIBE_ERROR_ACTIONS' AS table_name, 'ORDER_ID' AS column_name, activity_year, total_rows, ORDER_ID_filled AS filled_count FROM #fc_032
    UNION ALL
    SELECT 'EPRESCRIBE_ERROR_ACTIONS' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_032
    UNION ALL
    SELECT 'EPRESCRIBE_ERROR_ACTIONS' AS table_name, 'RESOLVING_ACTION_C_NAME' AS column_name, activity_year, total_rows, RESOLVING_ACTION_C_NAME_filled AS filled_count FROM #fc_032
    UNION ALL
    SELECT 'EPRESCRIBE_ERROR_ACTIONS' AS table_name, 'RESOLVING_USER_ID' AS column_name, activity_year, total_rows, RESOLVING_USER_ID_filled AS filled_count FROM #fc_032
    UNION ALL
    SELECT 'EPRESCRIBE_ERROR_ACTIONS' AS table_name, 'RESOLVING_USER_ID_NAME' AS column_name, activity_year, total_rows, RESOLVING_USER_ID_NAME_filled AS filled_count FROM #fc_032
    UNION ALL
    SELECT 'EPRESCRIBE_ERROR_ACTIONS' AS table_name, 'RESOLVED_UTC_DTTM' AS column_name, activity_year, total_rows, RESOLVED_UTC_DTTM_filled AS filled_count FROM #fc_032
    UNION ALL
    SELECT 'FIN_ASST_CASE_DOCUMENTS' AS table_name, 'FIN_ASST_CASE_ID' AS column_name, activity_year, total_rows, FIN_ASST_CASE_ID_filled AS filled_count FROM #fc_033
    UNION ALL
    SELECT 'FIN_ASST_CASE_DOCUMENTS' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_033
    UNION ALL
    SELECT 'FIN_ASST_CASE_DOCUMENTS' AS table_name, 'DOCUMENT_ID' AS column_name, activity_year, total_rows, DOCUMENT_ID_filled AS filled_count FROM #fc_033
    UNION ALL
    SELECT 'FIN_ASST_CASE_SMARTFORM' AS table_name, 'FIN_ASST_CASE_ID' AS column_name, activity_year, total_rows, FIN_ASST_CASE_ID_filled AS filled_count FROM #fc_034
    UNION ALL
    SELECT 'FIN_ASST_CASE_SMARTFORM' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_034
    UNION ALL
    SELECT 'FIN_ASST_CASE_SMARTFORM' AS table_name, 'SMARTFORM_ID' AS column_name, activity_year, total_rows, SMARTFORM_ID_filled AS filled_count FROM #fc_034
    UNION ALL
    SELECT 'FIN_ASST_CASE_SMARTFORM' AS table_name, 'SMARTFORM_VER' AS column_name, activity_year, total_rows, SMARTFORM_VER_filled AS filled_count FROM #fc_034
    UNION ALL
    SELECT 'FIN_ASST_NOTE' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_035
    UNION ALL
    SELECT 'FIN_ASST_NOTE' AS table_name, 'HNO_RECORD_TYPE_C_NAME' AS column_name, activity_year, total_rows, HNO_RECORD_TYPE_C_NAME_filled AS filled_count FROM #fc_035
    UNION ALL
    SELECT 'FIN_ASST_NOTE' AS table_name, 'ENTRY_PERSON_USER_ID' AS column_name, activity_year, total_rows, ENTRY_PERSON_USER_ID_filled AS filled_count FROM #fc_035
    UNION ALL
    SELECT 'FIN_ASST_NOTE' AS table_name, 'ENTRY_PERSON_USER_ID_NAME' AS column_name, activity_year, total_rows, ENTRY_PERSON_USER_ID_NAME_filled AS filled_count FROM #fc_035
    UNION ALL
    SELECT 'FIN_ASST_NOTE' AS table_name, 'ENTRY_DATE' AS column_name, activity_year, total_rows, ENTRY_DATE_filled AS filled_count FROM #fc_035
    UNION ALL
    SELECT 'FIN_ASST_NOTE' AS table_name, 'ACCT_NOTE_INSTANT_DTTM' AS column_name, activity_year, total_rows, ACCT_NOTE_INSTANT_DTTM_filled AS filled_count FROM #fc_035
    UNION ALL
    SELECT 'FIN_ASST_NOTE' AS table_name, 'ACCT_NOTE_SUMMARY' AS column_name, activity_year, total_rows, ACCT_NOTE_SUMMARY_filled AS filled_count FROM #fc_035
    UNION ALL
    SELECT 'FIN_ASST_NOTE' AS table_name, 'SYSTEM_GEN_YN' AS column_name, activity_year, total_rows, SYSTEM_GEN_YN_filled AS filled_count FROM #fc_035
    UNION ALL
    SELECT 'FIN_ASST_NOTE' AS table_name, 'FIN_ASST_CASE_ID' AS column_name, activity_year, total_rows, FIN_ASST_CASE_ID_filled AS filled_count FROM #fc_035
    UNION ALL
    SELECT 'FLOWSHT_NOTE_AUDIT' AS table_name, 'FSD_ID' AS column_name, activity_year, total_rows, FSD_ID_filled AS filled_count FROM #fc_036
    UNION ALL
    SELECT 'FLOWSHT_NOTE_AUDIT' AS table_name, 'GROUP_LINE' AS column_name, activity_year, total_rows, GROUP_LINE_filled AS filled_count FROM #fc_036
    UNION ALL
    SELECT 'FLOWSHT_NOTE_AUDIT' AS table_name, 'VALUE_LINE' AS column_name, activity_year, total_rows, VALUE_LINE_filled AS filled_count FROM #fc_036
    UNION ALL
    SELECT 'FLOWSHT_NOTE_AUDIT' AS table_name, 'AUDIT_LINKD_NOTE_ID' AS column_name, activity_year, total_rows, AUDIT_LINKD_NOTE_ID_filled AS filled_count FROM #fc_036
    UNION ALL
    SELECT 'FLO_INST_COSIGNED' AS table_name, 'FSD_ID' AS column_name, activity_year, total_rows, FSD_ID_filled AS filled_count FROM #fc_037
    UNION ALL
    SELECT 'FLO_INST_COSIGNED' AS table_name, 'GROUP_LINE' AS column_name, activity_year, total_rows, GROUP_LINE_filled AS filled_count FROM #fc_037
    UNION ALL
    SELECT 'FLO_INST_COSIGNED' AS table_name, 'VALUE_LINE' AS column_name, activity_year, total_rows, VALUE_LINE_filled AS filled_count FROM #fc_037
    UNION ALL
    SELECT 'FLO_INST_COSIGNED' AS table_name, 'INSTANT_COSIGNED_TM' AS column_name, activity_year, total_rows, INSTANT_COSIGNED_TM_filled AS filled_count FROM #fc_037
    UNION ALL
    SELECT 'FLO_USER_COSIGNED' AS table_name, 'FSD_ID' AS column_name, activity_year, total_rows, FSD_ID_filled AS filled_count FROM #fc_038
    UNION ALL
    SELECT 'FLO_USER_COSIGNED' AS table_name, 'GROUP_LINE' AS column_name, activity_year, total_rows, GROUP_LINE_filled AS filled_count FROM #fc_038
    UNION ALL
    SELECT 'FLO_USER_COSIGNED' AS table_name, 'VALUE_LINE' AS column_name, activity_year, total_rows, VALUE_LINE_filled AS filled_count FROM #fc_038
    UNION ALL
    SELECT 'FLO_USER_COSIGNED' AS table_name, 'USER_COSIGNED_ID' AS column_name, activity_year, total_rows, USER_COSIGNED_ID_filled AS filled_count FROM #fc_038
    UNION ALL
    SELECT 'FLO_USER_COSIGNED' AS table_name, 'USER_COSIGNED_ID_NAME' AS column_name, activity_year, total_rows, USER_COSIGNED_ID_NAME_filled AS filled_count FROM #fc_038
    UNION ALL
    SELECT 'HNO_ABN_ORD_REASON' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_039
    UNION ALL
    SELECT 'HNO_ABN_ORD_REASON' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_039
    UNION ALL
    SELECT 'HNO_ABN_ORD_REASON' AS table_name, 'ABN_ORD_REASONS' AS column_name, activity_year, total_rows, ABN_ORD_REASONS_filled AS filled_count FROM #fc_039
    UNION ALL
    SELECT 'HNO_ABN_PROCEDURES' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_040
    UNION ALL
    SELECT 'HNO_ABN_PROCEDURES' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_040
    UNION ALL
    SELECT 'HNO_ABN_PROCEDURES' AS table_name, 'ABN_PROCEDURE_ID_PROC_NAME' AS column_name, activity_year, total_rows, ABN_PROCEDURE_ID_PROC_NAME_filled AS filled_count FROM #fc_040
    UNION ALL
    SELECT 'HNO_CONSULT_ORD_ID' AS table_name, 'NOTE_CSN_ID' AS column_name, activity_year, total_rows, NOTE_CSN_ID_filled AS filled_count FROM #fc_041
    UNION ALL
    SELECT 'HNO_CONSULT_ORD_ID' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_041
    UNION ALL
    SELECT 'HNO_CONSULT_ORD_ID' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_041
    UNION ALL
    SELECT 'HNO_CONSULT_ORD_ID' AS table_name, 'CONTACT_DATE_REAL' AS column_name, activity_year, total_rows, CONTACT_DATE_REAL_filled AS filled_count FROM #fc_041
    UNION ALL
    SELECT 'HNO_CONSULT_ORD_ID' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_041
    UNION ALL
    SELECT 'HNO_CONSULT_ORD_ID' AS table_name, 'CONSULT_ORDER_ID' AS column_name, activity_year, total_rows, CONSULT_ORDER_ID_filled AS filled_count FROM #fc_041
    UNION ALL
    SELECT 'HNO_ECG_DX' AS table_name, 'NOTE_CSN_ID' AS column_name, activity_year, total_rows, NOTE_CSN_ID_filled AS filled_count FROM #fc_042
    UNION ALL
    SELECT 'HNO_ECG_DX' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_042
    UNION ALL
    SELECT 'HNO_ECG_DX' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_042
    UNION ALL
    SELECT 'HNO_ECG_DX' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_042
    UNION ALL
    SELECT 'HNO_ECG_DX' AS table_name, 'ECG_DX' AS column_name, activity_year, total_rows, ECG_DX_filled AS filled_count FROM #fc_042
    UNION ALL
    SELECT 'HNO_INFO' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_043
    UNION ALL
    SELECT 'HNO_INFO' AS table_name, 'NOTE_TYPE_NOADD_C_NAME' AS column_name, activity_year, total_rows, NOTE_TYPE_NOADD_C_NAME_filled AS filled_count FROM #fc_043
    UNION ALL
    SELECT 'HNO_INFO' AS table_name, 'PAT_ENC_CSN_ID' AS column_name, activity_year, total_rows, PAT_ENC_CSN_ID_filled AS filled_count FROM #fc_043
    UNION ALL
    SELECT 'HNO_INFO' AS table_name, 'ENTRY_USER_ID' AS column_name, activity_year, total_rows, ENTRY_USER_ID_filled AS filled_count FROM #fc_043
    UNION ALL
    SELECT 'HNO_INFO' AS table_name, 'ENTRY_USER_ID_NAME' AS column_name, activity_year, total_rows, ENTRY_USER_ID_NAME_filled AS filled_count FROM #fc_043
    UNION ALL
    SELECT 'HNO_INFO' AS table_name, 'NOTE_DESC' AS column_name, activity_year, total_rows, NOTE_DESC_filled AS filled_count FROM #fc_043
    UNION ALL
    SELECT 'HNO_INFO' AS table_name, 'IP_NOTE_TYPE_C_NAME' AS column_name, activity_year, total_rows, IP_NOTE_TYPE_C_NAME_filled AS filled_count FROM #fc_043
    UNION ALL
    SELECT 'HNO_INFO' AS table_name, 'ORIGINAL_HP_ID' AS column_name, activity_year, total_rows, ORIGINAL_HP_ID_filled AS filled_count FROM #fc_043
    UNION ALL
    SELECT 'HNO_INFO' AS table_name, 'ORIG_HP_DATE_REAL' AS column_name, activity_year, total_rows, ORIG_HP_DATE_REAL_filled AS filled_count FROM #fc_043
    UNION ALL
    SELECT 'HNO_INFO' AS table_name, 'SOURCE_HP_ID' AS column_name, activity_year, total_rows, SOURCE_HP_ID_filled AS filled_count FROM #fc_043
    UNION ALL
    SELECT 'HNO_INFO' AS table_name, 'SOURCE_HP_DATE_REAL' AS column_name, activity_year, total_rows, SOURCE_HP_DATE_REAL_filled AS filled_count FROM #fc_043
    UNION ALL
    SELECT 'HNO_INFO' AS table_name, 'ECG_TECHNICIAN_ID' AS column_name, activity_year, total_rows, ECG_TECHNICIAN_ID_filled AS filled_count FROM #fc_043
    UNION ALL
    SELECT 'HNO_INFO' AS table_name, 'PAT_LINK_ID' AS column_name, activity_year, total_rows, PAT_LINK_ID_filled AS filled_count FROM #fc_043
    UNION ALL
    SELECT 'HNO_INFO' AS table_name, 'LETTER_SUMMARY' AS column_name, activity_year, total_rows, LETTER_SUMMARY_filled AS filled_count FROM #fc_043
    UNION ALL
    SELECT 'HNO_INFO' AS table_name, 'TX_IB_FOLDER_C_NAME' AS column_name, activity_year, total_rows, TX_IB_FOLDER_C_NAME_filled AS filled_count FROM #fc_043
    UNION ALL
    SELECT 'HNO_INFO' AS table_name, 'CREATE_INSTANT_DTTM' AS column_name, activity_year, total_rows, CREATE_INSTANT_DTTM_filled AS filled_count FROM #fc_043
    UNION ALL
    SELECT 'HNO_INFO' AS table_name, 'UNSIGNED_YN' AS column_name, activity_year, total_rows, UNSIGNED_YN_filled AS filled_count FROM #fc_043
    UNION ALL
    SELECT 'HNO_INFO' AS table_name, 'DELETE_INSTANT_DTTM' AS column_name, activity_year, total_rows, DELETE_INSTANT_DTTM_filled AS filled_count FROM #fc_043
    UNION ALL
    SELECT 'HNO_INFO' AS table_name, 'DELETE_USER_ID' AS column_name, activity_year, total_rows, DELETE_USER_ID_filled AS filled_count FROM #fc_043
    UNION ALL
    SELECT 'HNO_INFO' AS table_name, 'DELETE_USER_ID_NAME' AS column_name, activity_year, total_rows, DELETE_USER_ID_NAME_filled AS filled_count FROM #fc_043
    UNION ALL
    SELECT 'HNO_INFO' AS table_name, 'COSIGNED_NOTE_LINK' AS column_name, activity_year, total_rows, COSIGNED_NOTE_LINK_filled AS filled_count FROM #fc_043
    UNION ALL
    SELECT 'HNO_INFO' AS table_name, 'DATE_OF_SERVIC_DTTM' AS column_name, activity_year, total_rows, DATE_OF_SERVIC_DTTM_filled AS filled_count FROM #fc_043
    UNION ALL
    SELECT 'HNO_INFO' AS table_name, 'SIGNED_NOTE_ID' AS column_name, activity_year, total_rows, SIGNED_NOTE_ID_filled AS filled_count FROM #fc_043
    UNION ALL
    SELECT 'HNO_INFO' AS table_name, 'LST_FILED_INST_DTTM' AS column_name, activity_year, total_rows, LST_FILED_INST_DTTM_filled AS filled_count FROM #fc_043
    UNION ALL
    SELECT 'HNO_INFO' AS table_name, 'UPDATE_DATE' AS column_name, activity_year, total_rows, UPDATE_DATE_filled AS filled_count FROM #fc_043
    UNION ALL
    SELECT 'HNO_INFO' AS table_name, 'CURRENT_AUTHOR_ID' AS column_name, activity_year, total_rows, CURRENT_AUTHOR_ID_filled AS filled_count FROM #fc_043
    UNION ALL
    SELECT 'HNO_INFO' AS table_name, 'CURRENT_AUTHOR_ID_NAME' AS column_name, activity_year, total_rows, CURRENT_AUTHOR_ID_NAME_filled AS filled_count FROM #fc_043
    UNION ALL
    SELECT 'HNO_INFO' AS table_name, 'LETTER_TYPE_C_NAME' AS column_name, activity_year, total_rows, LETTER_TYPE_C_NAME_filled AS filled_count FROM #fc_043
    UNION ALL
    SELECT 'HNO_INFO' AS table_name, 'VISIT_NUM' AS column_name, activity_year, total_rows, VISIT_NUM_filled AS filled_count FROM #fc_043
    UNION ALL
    SELECT 'HNO_INFO' AS table_name, 'CRT_INST_LOCAL_DTTM' AS column_name, activity_year, total_rows, CRT_INST_LOCAL_DTTM_filled AS filled_count FROM #fc_043
    UNION ALL
    SELECT 'HNO_INFO' AS table_name, 'PRIORITY_YN' AS column_name, activity_year, total_rows, PRIORITY_YN_filled AS filled_count FROM #fc_043
    UNION ALL
    SELECT 'HNO_INFO' AS table_name, 'ACTIVE_FROM_DT' AS column_name, activity_year, total_rows, ACTIVE_FROM_DT_filled AS filled_count FROM #fc_043
    UNION ALL
    SELECT 'HNO_INFO' AS table_name, 'ACTIVE_TO_DT' AS column_name, activity_year, total_rows, ACTIVE_TO_DT_filled AS filled_count FROM #fc_043
    UNION ALL
    SELECT 'HNO_INFO' AS table_name, 'TREAT_SUM_RLS_TO_MYC_YN' AS column_name, activity_year, total_rows, TREAT_SUM_RLS_TO_MYC_YN_filled AS filled_count FROM #fc_043
    UNION ALL
    SELECT 'HNO_INFO' AS table_name, 'TREAT_SUM_RLS_TO_MYC_CSN' AS column_name, activity_year, total_rows, TREAT_SUM_RLS_TO_MYC_CSN_filled AS filled_count FROM #fc_043
    UNION ALL
    SELECT 'HNO_INFO' AS table_name, 'COMMENT_USER_ID' AS column_name, activity_year, total_rows, COMMENT_USER_ID_filled AS filled_count FROM #fc_043
    UNION ALL
    SELECT 'HNO_INFO' AS table_name, 'COMMENT_USER_ID_NAME' AS column_name, activity_year, total_rows, COMMENT_USER_ID_NAME_filled AS filled_count FROM #fc_043
    UNION ALL
    SELECT 'HNO_INFO' AS table_name, 'COMMENT_EDIT_INST_DTTM' AS column_name, activity_year, total_rows, COMMENT_EDIT_INST_DTTM_filled AS filled_count FROM #fc_043
    UNION ALL
    SELECT 'HNO_INFO' AS table_name, 'CONVERSATION_MSG_ID' AS column_name, activity_year, total_rows, CONVERSATION_MSG_ID_filled AS filled_count FROM #fc_043
    UNION ALL
    SELECT 'HNO_INFO_2' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_044
    UNION ALL
    SELECT 'HNO_INFO_2' AS table_name, 'RELEVANT_REC_EVENT_ID' AS column_name, activity_year, total_rows, RELEVANT_REC_EVENT_ID_filled AS filled_count FROM #fc_044
    UNION ALL
    SELECT 'HNO_INFO_2' AS table_name, 'GROUP_NOTE_ID' AS column_name, activity_year, total_rows, GROUP_NOTE_ID_filled AS filled_count FROM #fc_044
    UNION ALL
    SELECT 'HNO_INFO_2' AS table_name, 'LETTER_DEST_C_NAME' AS column_name, activity_year, total_rows, LETTER_DEST_C_NAME_filled AS filled_count FROM #fc_044
    UNION ALL
    SELECT 'HNO_INFO_2' AS table_name, 'LETTER_FINAL_UTC_DTTM' AS column_name, activity_year, total_rows, LETTER_FINAL_UTC_DTTM_filled AS filled_count FROM #fc_044
    UNION ALL
    SELECT 'HNO_INFO_2' AS table_name, 'HNO_RECORD_TYPE_C_NAME' AS column_name, activity_year, total_rows, HNO_RECORD_TYPE_C_NAME_filled AS filled_count FROM #fc_044
    UNION ALL
    SELECT 'HNO_INFO_2' AS table_name, 'RFL_LETTER_ENC_CSN' AS column_name, activity_year, total_rows, RFL_LETTER_ENC_CSN_filled AS filled_count FROM #fc_044
    UNION ALL
    SELECT 'HNO_INFO_2' AS table_name, 'CONV_MSG_CID' AS column_name, activity_year, total_rows, CONV_MSG_CID_filled AS filled_count FROM #fc_044
    UNION ALL
    SELECT 'HNO_INFO_2' AS table_name, 'OUTREACH_TEMPLATE_ID' AS column_name, activity_year, total_rows, OUTREACH_TEMPLATE_ID_filled AS filled_count FROM #fc_044
    UNION ALL
    SELECT 'HNO_INFO_2' AS table_name, 'SOURCE_EDITS_CSN' AS column_name, activity_year, total_rows, SOURCE_EDITS_CSN_filled AS filled_count FROM #fc_044
    UNION ALL
    SELECT 'HNO_INFO_2' AS table_name, 'EXT_DOC_EVNT_ID' AS column_name, activity_year, total_rows, EXT_DOC_EVNT_ID_filled AS filled_count FROM #fc_044
    UNION ALL
    SELECT 'HNO_INFO_2' AS table_name, 'EXT_NOTE_TYPE' AS column_name, activity_year, total_rows, EXT_NOTE_TYPE_filled AS filled_count FROM #fc_044
    UNION ALL
    SELECT 'HNO_INFO_2' AS table_name, 'EXT_DUP_NOTE_ID' AS column_name, activity_year, total_rows, EXT_DUP_NOTE_ID_filled AS filled_count FROM #fc_044
    UNION ALL
    SELECT 'HNO_INFO_2' AS table_name, 'EXT_DUP_NOTE_C_NAME' AS column_name, activity_year, total_rows, EXT_DUP_NOTE_C_NAME_filled AS filled_count FROM #fc_044
    UNION ALL
    SELECT 'HNO_INFO_2' AS table_name, 'PARENT_NOTE_ID' AS column_name, activity_year, total_rows, PARENT_NOTE_ID_filled AS filled_count FROM #fc_044
    UNION ALL
    SELECT 'HNO_INFO_2' AS table_name, 'ACTIVE_C_NAME' AS column_name, activity_year, total_rows, ACTIVE_C_NAME_filled AS filled_count FROM #fc_044
    UNION ALL
    SELECT 'HNO_INFO_2' AS table_name, 'EXT_AUTHOR' AS column_name, activity_year, total_rows, EXT_AUTHOR_filled AS filled_count FROM #fc_044
    UNION ALL
    SELECT 'HNO_INFO_2' AS table_name, 'NOTE_UPDATE_INST_UTC_DTTM' AS column_name, activity_year, total_rows, NOTE_UPDATE_INST_UTC_DTTM_filled AS filled_count FROM #fc_044
    UNION ALL
    SELECT 'HNO_INFO_2' AS table_name, 'ROUT_RECPNT_COMMUNICATION_ID' AS column_name, activity_year, total_rows, ROUT_RECPNT_COMMUNICATION_ID_filled AS filled_count FROM #fc_044
    UNION ALL
    SELECT 'HNO_INFO_2' AS table_name, 'EXTERNAL_SOURCE_IDENT' AS column_name, activity_year, total_rows, EXTERNAL_SOURCE_IDENT_filled AS filled_count FROM #fc_044
    UNION ALL
    SELECT 'HNO_INFO_2' AS table_name, 'EXTERNAL_PROBLEM_IDENT' AS column_name, activity_year, total_rows, EXTERNAL_PROBLEM_IDENT_filled AS filled_count FROM #fc_044
    UNION ALL
    SELECT 'HNO_INFO_2' AS table_name, 'TRANSLATION_IDENTIFIER' AS column_name, activity_year, total_rows, TRANSLATION_IDENTIFIER_filled AS filled_count FROM #fc_044
    UNION ALL
    SELECT 'HNO_INFO_2' AS table_name, 'TRANSLATION_LANGUAGE_ID' AS column_name, activity_year, total_rows, TRANSLATION_LANGUAGE_ID_filled AS filled_count FROM #fc_044
    UNION ALL
    SELECT 'HNO_INFO_2' AS table_name, 'TRANSLATION_LANGUAGE_ID_LANGUAGE_NAME' AS column_name, activity_year, total_rows, TRANSLATION_LANGUAGE_ID_LANGUAGE_NAME_filled AS filled_count FROM #fc_044
    UNION ALL
    SELECT 'HNO_INFO_2' AS table_name, 'NOT_RESEARCH_RELATED_YN' AS column_name, activity_year, total_rows, NOT_RESEARCH_RELATED_YN_filled AS filled_count FROM #fc_044
    UNION ALL
    SELECT 'HNO_INFO_2' AS table_name, 'PRIVATE_YN' AS column_name, activity_year, total_rows, PRIVATE_YN_filled AS filled_count FROM #fc_044
    UNION ALL
    SELECT 'HNO_LET_DICTN' AS table_name, 'NOTE_CSN_ID' AS column_name, activity_year, total_rows, NOTE_CSN_ID_filled AS filled_count FROM #fc_045
    UNION ALL
    SELECT 'HNO_LET_DICTN' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_045
    UNION ALL
    SELECT 'HNO_LET_DICTN' AS table_name, 'LET_DICTN_USER_ID' AS column_name, activity_year, total_rows, LET_DICTN_USER_ID_filled AS filled_count FROM #fc_045
    UNION ALL
    SELECT 'HNO_LET_DICTN' AS table_name, 'LET_DICTN_USER_ID_NAME' AS column_name, activity_year, total_rows, LET_DICTN_USER_ID_NAME_filled AS filled_count FROM #fc_045
    UNION ALL
    SELECT 'HNO_LINKED_PATS' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_046
    UNION ALL
    SELECT 'HNO_LINKED_PATS' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_046
    UNION ALL
    SELECT 'HNO_LINKED_PATS' AS table_name, 'LINKED_PAT_ID' AS column_name, activity_year, total_rows, LINKED_PAT_ID_filled AS filled_count FROM #fc_046
    UNION ALL
    SELECT 'HNO_LINKED_RQGS' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_047
    UNION ALL
    SELECT 'HNO_LINKED_RQGS' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_047
    UNION ALL
    SELECT 'HNO_LINKED_RQGS' AS table_name, 'RQG_GROUPER_ID' AS column_name, activity_year, total_rows, RQG_GROUPER_ID_filled AS filled_count FROM #fc_047
    UNION ALL
    SELECT 'HNO_MYC_LET_INFO' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_048
    UNION ALL
    SELECT 'HNO_MYC_LET_INFO' AS table_name, 'LET_REL_MYC_DTTM' AS column_name, activity_year, total_rows, LET_REL_MYC_DTTM_filled AS filled_count FROM #fc_048
    UNION ALL
    SELECT 'HNO_MYC_LET_INFO' AS table_name, 'LET_REL_TO_MYC_YN' AS column_name, activity_year, total_rows, LET_REL_TO_MYC_YN_filled AS filled_count FROM #fc_048
    UNION ALL
    SELECT 'HNO_ORDERS' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_049
    UNION ALL
    SELECT 'HNO_ORDERS' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_049
    UNION ALL
    SELECT 'HNO_ORDERS' AS table_name, 'ORDER_ID' AS column_name, activity_year, total_rows, ORDER_ID_filled AS filled_count FROM #fc_049
    UNION ALL
    SELECT 'HNO_ORDERS' AS table_name, 'ORDER_DAT' AS column_name, activity_year, total_rows, ORDER_DAT_filled AS filled_count FROM #fc_049
    UNION ALL
    SELECT 'HNO_PLACEHOLDER_CHARGE' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_050
    UNION ALL
    SELECT 'HNO_PLACEHOLDER_CHARGE' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_050
    UNION ALL
    SELECT 'HNO_PLACEHOLDER_CHARGE' AS table_name, 'CHG_CREATED_YN' AS column_name, activity_year, total_rows, CHG_CREATED_YN_filled AS filled_count FROM #fc_050
    UNION ALL
    SELECT 'HNO_PLACEHOLDER_CHARGE' AS table_name, 'CHG_ACTION_USER_ID' AS column_name, activity_year, total_rows, CHG_ACTION_USER_ID_filled AS filled_count FROM #fc_050
    UNION ALL
    SELECT 'HNO_PLACEHOLDER_CHARGE' AS table_name, 'CHG_ACTION_USER_ID_NAME' AS column_name, activity_year, total_rows, CHG_ACTION_USER_ID_NAME_filled AS filled_count FROM #fc_050
    UNION ALL
    SELECT 'HNO_PLACEHOLDER_CHARGE' AS table_name, 'CHG_ACTION_UTC_DTTM' AS column_name, activity_year, total_rows, CHG_ACTION_UTC_DTTM_filled AS filled_count FROM #fc_050
    UNION ALL
    SELECT 'HNO_PLACEHOLDER_CHARGE' AS table_name, 'CHG_PROC_ID_PROC_NAME' AS column_name, activity_year, total_rows, CHG_PROC_ID_PROC_NAME_filled AS filled_count FROM #fc_050
    UNION ALL
    SELECT 'HNO_PLACEHOLDER_CHARGE' AS table_name, 'CHG_FAIL_REASON_C_NAME' AS column_name, activity_year, total_rows, CHG_FAIL_REASON_C_NAME_filled AS filled_count FROM #fc_050
    UNION ALL
    SELECT 'HNO_PLAIN_TEXT' AS table_name, 'NOTE_CSN_ID' AS column_name, activity_year, total_rows, NOTE_CSN_ID_filled AS filled_count FROM #fc_051
    UNION ALL
    SELECT 'HNO_PLAIN_TEXT' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_051
    UNION ALL
    SELECT 'HNO_PLAIN_TEXT' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_051
    UNION ALL
    SELECT 'HNO_PLAIN_TEXT' AS table_name, 'NOTE_TEXT' AS column_name, activity_year, total_rows, NOTE_TEXT_filled AS filled_count FROM #fc_051
    UNION ALL
    SELECT 'HNO_SCREENING_PROGRAM' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_052
    UNION ALL
    SELECT 'HNO_SCREENING_PROGRAM' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_052
    UNION ALL
    SELECT 'HNO_SCREENING_PROGRAM' AS table_name, 'SCREENING_PROGRAM_C_NAME' AS column_name, activity_year, total_rows, SCREENING_PROGRAM_C_NAME_filled AS filled_count FROM #fc_052
    UNION ALL
    SELECT 'HNO_SMARTFORM_LINK' AS table_name, 'NOTE_CSN_ID' AS column_name, activity_year, total_rows, NOTE_CSN_ID_filled AS filled_count FROM #fc_053
    UNION ALL
    SELECT 'HNO_SMARTFORM_LINK' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_053
    UNION ALL
    SELECT 'HNO_SMARTFORM_LINK' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_053
    UNION ALL
    SELECT 'HNO_SMARTFORM_LINK' AS table_name, 'CONTACT_DATE_REAL' AS column_name, activity_year, total_rows, CONTACT_DATE_REAL_filled AS filled_count FROM #fc_053
    UNION ALL
    SELECT 'HNO_SMARTFORM_LINK' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_053
    UNION ALL
    SELECT 'HNO_SMARTFORM_LINK' AS table_name, 'SMARTFORM_ID' AS column_name, activity_year, total_rows, SMARTFORM_ID_filled AS filled_count FROM #fc_053
    UNION ALL
    SELECT 'HNO_SMARTFORM_LINK' AS table_name, 'SMARTFORM_ID_FORM_NAME' AS column_name, activity_year, total_rows, SMARTFORM_ID_FORM_NAME_filled AS filled_count FROM #fc_053
    UNION ALL
    SELECT 'HNO_SMARTFORM_LINK' AS table_name, 'SMARTFORM_DAT' AS column_name, activity_year, total_rows, SMARTFORM_DAT_filled AS filled_count FROM #fc_053
    UNION ALL
    SELECT 'HNO_SMARTFORM_LINK' AS table_name, 'LINKED_ORDER_ID' AS column_name, activity_year, total_rows, LINKED_ORDER_ID_filled AS filled_count FROM #fc_053
    UNION ALL
    SELECT 'HNO_SMARTFORM_LINK' AS table_name, 'SMARTDATA_ID' AS column_name, activity_year, total_rows, SMARTDATA_ID_filled AS filled_count FROM #fc_053
    UNION ALL
    SELECT 'HNO_SOURCE_LOG_ID' AS table_name, 'NOTE_CSN_ID' AS column_name, activity_year, total_rows, NOTE_CSN_ID_filled AS filled_count FROM #fc_054
    UNION ALL
    SELECT 'HNO_SOURCE_LOG_ID' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_054
    UNION ALL
    SELECT 'HNO_SOURCE_LOG_ID' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_054
    UNION ALL
    SELECT 'HNO_SOURCE_LOG_ID' AS table_name, 'CONTACT_DATE_REAL' AS column_name, activity_year, total_rows, CONTACT_DATE_REAL_filled AS filled_count FROM #fc_054
    UNION ALL
    SELECT 'HNO_SOURCE_LOG_ID' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_054
    UNION ALL
    SELECT 'HNO_SOURCE_LOG_ID' AS table_name, 'SOURCE_LOG_ID' AS column_name, activity_year, total_rows, SOURCE_LOG_ID_filled AS filled_count FROM #fc_054
    UNION ALL
    SELECT 'HOLOGRAM_AMBIENT_DX_INFO' AS table_name, 'HOLOGRAM_ID' AS column_name, activity_year, total_rows, HOLOGRAM_ID_filled AS filled_count FROM #fc_055
    UNION ALL
    SELECT 'HOLOGRAM_AMBIENT_DX_INFO' AS table_name, 'CONTACT_DATE_REAL' AS column_name, activity_year, total_rows, CONTACT_DATE_REAL_filled AS filled_count FROM #fc_055
    UNION ALL
    SELECT 'HOLOGRAM_AMBIENT_DX_INFO' AS table_name, 'AMBIENT_DX_SOURCE_C_NAME' AS column_name, activity_year, total_rows, AMBIENT_DX_SOURCE_C_NAME_filled AS filled_count FROM #fc_055
    UNION ALL
    SELECT 'HOLOGRAM_AMBIENT_DX_INFO' AS table_name, 'AMBIENT_DX_LNK_PROB_LST_ID' AS column_name, activity_year, total_rows, AMBIENT_DX_LNK_PROB_LST_ID_filled AS filled_count FROM #fc_055
    UNION ALL
    SELECT 'HOLOGRAM_AMBIENT_DX_INFO' AS table_name, 'AMBIENT_DX_LINKED_VDX' AS column_name, activity_year, total_rows, AMBIENT_DX_LINKED_VDX_filled AS filled_count FROM #fc_055
    UNION ALL
    SELECT 'HOLOGRAM_AMBIENT_DX_INFO' AS table_name, 'AMBIENT_DX_AUTO_MATCH_YN' AS column_name, activity_year, total_rows, AMBIENT_DX_AUTO_MATCH_YN_filled AS filled_count FROM #fc_055
    UNION ALL
    SELECT 'HOLOGRAM_AMBIENT_DX_INFO' AS table_name, 'ADD_DX_TO_PROBLIST_YN' AS column_name, activity_year, total_rows, ADD_DX_TO_PROBLIST_YN_filled AS filled_count FROM #fc_055
    UNION ALL
    SELECT 'HOLOGRAM_AMBIENT_DX_INFO' AS table_name, 'INITIAL_DX_ID_DX_NAME' AS column_name, activity_year, total_rows, INITIAL_DX_ID_DX_NAME_filled AS filled_count FROM #fc_055
    UNION ALL
    SELECT 'HOLOGRAM_AMBIENT_DX_INFO' AS table_name, 'AMBIENT_PAST_DX_CSN' AS column_name, activity_year, total_rows, AMBIENT_PAST_DX_CSN_filled AS filled_count FROM #fc_055
    UNION ALL
    SELECT 'HOLOGRAM_AMBIENT_FAM_HX' AS table_name, 'HOLOGRAM_ID' AS column_name, activity_year, total_rows, HOLOGRAM_ID_filled AS filled_count FROM #fc_056
    UNION ALL
    SELECT 'HOLOGRAM_AMBIENT_FAM_HX' AS table_name, 'CONTACT_DATE_REAL' AS column_name, activity_year, total_rows, CONTACT_DATE_REAL_filled AS filled_count FROM #fc_056
    UNION ALL
    SELECT 'HOLOGRAM_AMBIENT_FAM_HX' AS table_name, 'FAM_STAT_REL_C_NAME' AS column_name, activity_year, total_rows, FAM_STAT_REL_C_NAME_filled AS filled_count FROM #fc_056
    UNION ALL
    SELECT 'HOLOGRAM_AMBIENT_FAM_HX' AS table_name, 'FAM_STAT_ID' AS column_name, activity_year, total_rows, FAM_STAT_ID_filled AS filled_count FROM #fc_056
    UNION ALL
    SELECT 'HOLOGRAM_AMBIENT_FAM_HX' AS table_name, 'FAM_STT_NAM' AS column_name, activity_year, total_rows, FAM_STT_NAM_filled AS filled_count FROM #fc_056
    UNION ALL
    SELECT 'HOLOGRAM_AMBIENT_FAM_HX' AS table_name, 'FAM_STAT_STATUS_C_NAME' AS column_name, activity_year, total_rows, FAM_STAT_STATUS_C_NAME_filled AS filled_count FROM #fc_056
    UNION ALL
    SELECT 'HOLOGRAM_AMBIENT_FAM_HX' AS table_name, 'FAM_MEDICAL_HX_C_NAME' AS column_name, activity_year, total_rows, FAM_MEDICAL_HX_C_NAME_filled AS filled_count FROM #fc_056
    UNION ALL
    SELECT 'HOLOGRAM_AMBIENT_FAM_HX' AS table_name, 'FAM_MEDICAL_DX_ID_DX_NAME' AS column_name, activity_year, total_rows, FAM_MEDICAL_DX_ID_DX_NAME_filled AS filled_count FROM #fc_056
    UNION ALL
    SELECT 'HOLOGRAM_AMBIENT_FAM_HX' AS table_name, 'AGE_OF_ONSET' AS column_name, activity_year, total_rows, AGE_OF_ONSET_filled AS filled_count FROM #fc_056
    UNION ALL
    SELECT 'HOLOGRAM_AMBIENT_FAM_HX' AS table_name, 'AGE_OF_ONSET_END' AS column_name, activity_year, total_rows, AGE_OF_ONSET_END_filled AS filled_count FROM #fc_056
    UNION ALL
    SELECT 'HOLOGRAM_DETAILS' AS table_name, 'HOLOGRAM_ID' AS column_name, activity_year, total_rows, HOLOGRAM_ID_filled AS filled_count FROM #fc_057
    UNION ALL
    SELECT 'HOLOGRAM_DETAILS' AS table_name, 'PAT_ID' AS column_name, activity_year, total_rows, PAT_ID_filled AS filled_count FROM #fc_057
    UNION ALL
    SELECT 'HOLOGRAM_DETAILS' AS table_name, 'PAT_ENC_CSN_ID' AS column_name, activity_year, total_rows, PAT_ENC_CSN_ID_filled AS filled_count FROM #fc_057
    UNION ALL
    SELECT 'HOLOGRAM_DETAILS' AS table_name, 'HOLOGRAM_STATUS_C_NAME' AS column_name, activity_year, total_rows, HOLOGRAM_STATUS_C_NAME_filled AS filled_count FROM #fc_057
    UNION ALL
    SELECT 'HOLOGRAM_DETAILS' AS table_name, 'WORKFLOW_USER_ID' AS column_name, activity_year, total_rows, WORKFLOW_USER_ID_filled AS filled_count FROM #fc_057
    UNION ALL
    SELECT 'HOLOGRAM_DETAILS' AS table_name, 'WORKFLOW_USER_ID_NAME' AS column_name, activity_year, total_rows, WORKFLOW_USER_ID_NAME_filled AS filled_count FROM #fc_057
    UNION ALL
    SELECT 'HOLOGRAM_DETAILS' AS table_name, 'WORKFLOW_PROV_ID_PROV_NAME' AS column_name, activity_year, total_rows, WORKFLOW_PROV_ID_PROV_NAME_filled AS filled_count FROM #fc_057
    UNION ALL
    SELECT 'HOLOGRAM_DETAILS' AS table_name, 'WORKFLOW_INST_UTC_DTTM' AS column_name, activity_year, total_rows, WORKFLOW_INST_UTC_DTTM_filled AS filled_count FROM #fc_057
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'HOLOGRAM_ID' AS column_name, activity_year, total_rows, HOLOGRAM_ID_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'CONTACT_DATE_REAL' AS column_name, activity_year, total_rows, CONTACT_DATE_REAL_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'DISPLAY_NAME' AS column_name, activity_year, total_rows, DISPLAY_NAME_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'LEVEL_OF_SERVICE_PROC_ID_PROC_NAME' AS column_name, activity_year, total_rows, LEVEL_OF_SERVICE_PROC_ID_PROC_NAME_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'SMARTTEXT_TYPE_C_NAME' AS column_name, activity_year, total_rows, SMARTTEXT_TYPE_C_NAME_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'SMARTTEXT_NOTE_TYPE_IP_C_NAME' AS column_name, activity_year, total_rows, SMARTTEXT_NOTE_TYPE_IP_C_NAME_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'SMARTTEXT_ADDED_NOW_YN' AS column_name, activity_year, total_rows, SMARTTEXT_ADDED_NOW_YN_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'SMARTTEXT_MAKE_SENSITIVE_YN' AS column_name, activity_year, total_rows, SMARTTEXT_MAKE_SENSITIVE_YN_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'DX_ID_DX_NAME' AS column_name, activity_year, total_rows, DX_ID_DX_NAME_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'DX_DESCRIPTION' AS column_name, activity_year, total_rows, DX_DESCRIPTION_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'DX_QUAL_2_C_NAME' AS column_name, activity_year, total_rows, DX_QUAL_2_C_NAME_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'DX_COMMENT' AS column_name, activity_year, total_rows, DX_COMMENT_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'DX_PRIMARY_YN' AS column_name, activity_year, total_rows, DX_PRIMARY_YN_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'DX_CHRONIC_YN' AS column_name, activity_year, total_rows, DX_CHRONIC_YN_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'IMMUN_ID' AS column_name, activity_year, total_rows, IMMUN_ID_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'IMMUN_ID_NAME' AS column_name, activity_year, total_rows, IMMUN_ID_NAME_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'IMMNZTN_DOSE' AS column_name, activity_year, total_rows, IMMNZTN_DOSE_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'IMMNZTN_DOSE_AMOUNT' AS column_name, activity_year, total_rows, IMMNZTN_DOSE_AMOUNT_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'IMMNZTN_DISP_QTYUNIT_C_NAME' AS column_name, activity_year, total_rows, IMMNZTN_DISP_QTYUNIT_C_NAME_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'IMMNZTN_ROUTE_C_NAME' AS column_name, activity_year, total_rows, IMMNZTN_ROUTE_C_NAME_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'IMMNZTN_SITE_C_NAME' AS column_name, activity_year, total_rows, IMMNZTN_SITE_C_NAME_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'IMMNZTN_MANUFACTURER_MFG_C_NAME' AS column_name, activity_year, total_rows, IMMNZTN_MANUFACTURER_MFG_C_NAME_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'IMMNZTN_LOT_NUMBER' AS column_name, activity_year, total_rows, IMMNZTN_LOT_NUMBER_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'IMMNZTN_PRODUCT' AS column_name, activity_year, total_rows, IMMNZTN_PRODUCT_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'IMMNZTN_NDC_ID' AS column_name, activity_year, total_rows, IMMNZTN_NDC_ID_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'IMMNZTN_NDC_ID_NDC_CODE' AS column_name, activity_year, total_rows, IMMNZTN_NDC_ID_NDC_CODE_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'IMMNZTN_IMM_PRODUCT_C_NAME' AS column_name, activity_year, total_rows, IMMNZTN_IMM_PRODUCT_C_NAME_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'IMMNZTN_DATE' AS column_name, activity_year, total_rows, IMMNZTN_DATE_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'IMMNZTN_INSTANT_UTC_DTTM' AS column_name, activity_year, total_rows, IMMNZTN_INSTANT_UTC_DTTM_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'IMMNZTN_INVENTORY_CLASS_C_NAME' AS column_name, activity_year, total_rows, IMMNZTN_INVENTORY_CLASS_C_NAME_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'IMMNZTN_LOT_NUM_ID_LOT_NUM' AS column_name, activity_year, total_rows, IMMNZTN_LOT_NUM_ID_LOT_NUM_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'IMMNZTN_NEXT_DUE_DATE' AS column_name, activity_year, total_rows, IMMNZTN_NEXT_DUE_DATE_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'IMMNZTN_EXPIRATION_DATE' AS column_name, activity_year, total_rows, IMMNZTN_EXPIRATION_DATE_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'IMMNZTN_IMM_DEFER_DUR_C_NAME' AS column_name, activity_year, total_rows, IMMNZTN_IMM_DEFER_DUR_C_NAME_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'IMMNZTN_GIVEN_BY_USER_ID' AS column_name, activity_year, total_rows, IMMNZTN_GIVEN_BY_USER_ID_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'IMMNZTN_GIVEN_BY_USER_ID_NAME' AS column_name, activity_year, total_rows, IMMNZTN_GIVEN_BY_USER_ID_NAME_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'IMMNZTN_EXTERNAL_ADMIN_C_NAME' AS column_name, activity_year, total_rows, IMMNZTN_EXTERNAL_ADMIN_C_NAME_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'IMMNZTN_VIS_DATE' AS column_name, activity_year, total_rows, IMMNZTN_VIS_DATE_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'IMMNZTN_DEFER_REASON_C_NAME' AS column_name, activity_year, total_rows, IMMNZTN_DEFER_REASON_C_NAME_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'IMMNZTN_ADMIN_COMMENT' AS column_name, activity_year, total_rows, IMMNZTN_ADMIN_COMMENT_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'IMMNZTN_ADMIN_LOCATION' AS column_name, activity_year, total_rows, IMMNZTN_ADMIN_LOCATION_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'IMMNZTN_STATUS_C_NAME' AS column_name, activity_year, total_rows, IMMNZTN_STATUS_C_NAME_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'LOS_COMPONENT_PROC_ID_PROC_NAME' AS column_name, activity_year, total_rows, LOS_COMPONENT_PROC_ID_PROC_NAME_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'COMPONENT_LOS_NEW_OR_EST_C_NAME' AS column_name, activity_year, total_rows, COMPONENT_LOS_NEW_OR_EST_C_NAME_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'LOS_COMPONENT_COUNSEL_TIME' AS column_name, activity_year, total_rows, LOS_COMPONENT_COUNSEL_TIME_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'COMPONENT_LOS_HX_LEVEL_C_NAME' AS column_name, activity_year, total_rows, COMPONENT_LOS_HX_LEVEL_C_NAME_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'COMPONENT_LOS_EXAM_LEVEL_C_NAME' AS column_name, activity_year, total_rows, COMPONENT_LOS_EXAM_LEVEL_C_NAME_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'COMPONENT_LOS_MDM_LEVEL_C_NAME' AS column_name, activity_year, total_rows, COMPONENT_LOS_MDM_LEVEL_C_NAME_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'LOS_COMPONENT_PROC_CALC_YN' AS column_name, activity_year, total_rows, LOS_COMPONENT_PROC_CALC_YN_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'FUP_NUMBER_OF_UNITS' AS column_name, activity_year, total_rows, FUP_NUMBER_OF_UNITS_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'FUP_TYPE_OF_UNIT_C_NAME' AS column_name, activity_year, total_rows, FUP_TYPE_OF_UNIT_C_NAME_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'FUP_APPROX_YN' AS column_name, activity_year, total_rows, FUP_APPROX_YN_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'FUP_PRN_YN' AS column_name, activity_year, total_rows, FUP_PRN_YN_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'FUP_RETURN_FOR_TEXT' AS column_name, activity_year, total_rows, FUP_RETURN_FOR_TEXT_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'FUP_CODIFIED_C_NAME' AS column_name, activity_year, total_rows, FUP_CODIFIED_C_NAME_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'FUP_INSTRUCTIONS_CODIFIED_C_NAME' AS column_name, activity_year, total_rows, FUP_INSTRUCTIONS_CODIFIED_C_NAME_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'FUP_COPY_TO_PCP_YN' AS column_name, activity_year, total_rows, FUP_COPY_TO_PCP_YN_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'FUP_SEND_REMINDER_YN' AS column_name, activity_year, total_rows, FUP_SEND_REMINDER_YN_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'FUP_REMINDER_DAYS' AS column_name, activity_year, total_rows, FUP_REMINDER_DAYS_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'FUP_PRN_TEXT' AS column_name, activity_year, total_rows, FUP_PRN_TEXT_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'FUP_REMINDER_MESSAGE' AS column_name, activity_year, total_rows, FUP_REMINDER_MESSAGE_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'FUP_ROUTING_PRIORITY_C_NAME' AS column_name, activity_year, total_rows, FUP_ROUTING_PRIORITY_C_NAME_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'FUP_ROUTING_COMMENT' AS column_name, activity_year, total_rows, FUP_ROUTING_COMMENT_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'FUP_USER_ACCEPTED_YN' AS column_name, activity_year, total_rows, FUP_USER_ACCEPTED_YN_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'NT_DISPOSITION_PHONE_DISP_C_NAME' AS column_name, activity_year, total_rows, NT_DISPOSITION_PHONE_DISP_C_NAME_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'NT_DISPOSITION_LOC_ID_LOC_NAME' AS column_name, activity_year, total_rows, NT_DISPOSITION_LOC_ID_LOC_NAME_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'NT_DISPOSITION_COMMENT' AS column_name, activity_year, total_rows, NT_DISPOSITION_COMMENT_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'NT_DISPOSITION_DEPARTMENT_ID_EXTERNAL_NAME' AS column_name, activity_year, total_rows, NT_DISPOSITION_DEPARTMENT_ID_EXTERNAL_NAME_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'NT_DISP_INSTANT_UTC_DTTM' AS column_name, activity_year, total_rows, NT_DISP_INSTANT_UTC_DTTM_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'REASON_FOR_VISIT_RFV_ID_REASON_VISIT_NAME' AS column_name, activity_year, total_rows, REASON_FOR_VISIT_RFV_ID_REASON_VISIT_NAME_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'REASON_FOR_VISIT_COMMENT' AS column_name, activity_year, total_rows, REASON_FOR_VISIT_COMMENT_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS' AS table_name, 'REASON_FOR_VISIT_ONSET_DATE' AS column_name, activity_year, total_rows, REASON_FOR_VISIT_ONSET_DATE_filled AS filled_count FROM #fc_058
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS_2' AS table_name, 'HOLOGRAM_ID' AS column_name, activity_year, total_rows, HOLOGRAM_ID_filled AS filled_count FROM #fc_059
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS_2' AS table_name, 'CONTACT_DATE_REAL' AS column_name, activity_year, total_rows, CONTACT_DATE_REAL_filled AS filled_count FROM #fc_059
    UNION ALL
    SELECT 'HOLOGRAM_SELECTIONS_2' AS table_name, 'HOL_IS_SELECTED_YN' AS column_name, activity_year, total_rows, HOL_IS_SELECTED_YN_filled AS filled_count FROM #fc_059
    UNION ALL
    SELECT 'HOLO_SMARTTEXT_NOTE_TXT' AS table_name, 'HOLOGRAM_ID' AS column_name, activity_year, total_rows, HOLOGRAM_ID_filled AS filled_count FROM #fc_060
    UNION ALL
    SELECT 'HOLO_SMARTTEXT_NOTE_TXT' AS table_name, 'CONTACT_DATE_REAL' AS column_name, activity_year, total_rows, CONTACT_DATE_REAL_filled AS filled_count FROM #fc_060
    UNION ALL
    SELECT 'HOLO_SMARTTEXT_NOTE_TXT' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_060
    UNION ALL
    SELECT 'HOLO_SMARTTEXT_NOTE_TXT' AS table_name, 'SMARTTEXT_NOTE_TEXT' AS column_name, activity_year, total_rows, SMARTTEXT_NOTE_TEXT_filled AS filled_count FROM #fc_060
    UNION ALL
    SELECT 'HSP_ACCT_BILL_NOTE' AS table_name, 'HSP_ACCOUNT_ID' AS column_name, activity_year, total_rows, HSP_ACCOUNT_ID_filled AS filled_count FROM #fc_061
    UNION ALL
    SELECT 'HSP_ACCT_BILL_NOTE' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_061
    UNION ALL
    SELECT 'HSP_ACCT_BILL_NOTE' AS table_name, 'BILLING_NOTE' AS column_name, activity_year, total_rows, BILLING_NOTE_filled AS filled_count FROM #fc_061
    UNION ALL
    SELECT 'INCOMPLETE_NOTE_EPT' AS table_name, 'PAT_ENC_CSN_ID' AS column_name, activity_year, total_rows, PAT_ENC_CSN_ID_filled AS filled_count FROM #fc_062
    UNION ALL
    SELECT 'INCOMPLETE_NOTE_EPT' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_062
    UNION ALL
    SELECT 'INCOMPLETE_NOTE_EPT' AS table_name, 'PAT_ID' AS column_name, activity_year, total_rows, PAT_ID_filled AS filled_count FROM #fc_062
    UNION ALL
    SELECT 'INCOMPLETE_NOTE_EPT' AS table_name, 'PAT_ENC_DATE_REAL' AS column_name, activity_year, total_rows, PAT_ENC_DATE_REAL_filled AS filled_count FROM #fc_062
    UNION ALL
    SELECT 'INCOMPLETE_NOTE_EPT' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_062
    UNION ALL
    SELECT 'INCOMPLETE_NOTE_EPT' AS table_name, 'INC_NOTE_USER_ID' AS column_name, activity_year, total_rows, INC_NOTE_USER_ID_filled AS filled_count FROM #fc_062
    UNION ALL
    SELECT 'INCOMPLETE_NOTE_EPT' AS table_name, 'INC_NOTE_USER_ID_NAME' AS column_name, activity_year, total_rows, INC_NOTE_USER_ID_NAME_filled AS filled_count FROM #fc_062
    UNION ALL
    SELECT 'INCOMPLETE_NOTE_EPT' AS table_name, 'INC_NOTE_NOTE_ID' AS column_name, activity_year, total_rows, INC_NOTE_NOTE_ID_filled AS filled_count FROM #fc_062
    UNION ALL
    SELECT 'INCOMPLETE_NOTE_EPT' AS table_name, 'INC_NOTE_TYPE_C_NAME' AS column_name, activity_year, total_rows, INC_NOTE_TYPE_C_NAME_filled AS filled_count FROM #fc_062
    UNION ALL
    SELECT 'INCOMPLETE_NOTE_EPT' AS table_name, 'INC_NOTE_MSG_ID' AS column_name, activity_year, total_rows, INC_NOTE_MSG_ID_filled AS filled_count FROM #fc_062
    UNION ALL
    SELECT 'INCOMPLETE_NOTE_EPT' AS table_name, 'INC_NOTE_START_DATE_UTC_DTTM' AS column_name, activity_year, total_rows, INC_NOTE_START_DATE_UTC_DTTM_filled AS filled_count FROM #fc_062
    UNION ALL
    SELECT 'INCOMPLETE_NOTE_EPT' AS table_name, 'INC_NOTE_LAST_EDIT_UTC_DTTM' AS column_name, activity_year, total_rows, INC_NOTE_LAST_EDIT_UTC_DTTM_filled AS filled_count FROM #fc_062
    UNION ALL
    SELECT 'INTERV_NOTE_INFO' AS table_name, 'NOTE_CSN_ID' AS column_name, activity_year, total_rows, NOTE_CSN_ID_filled AS filled_count FROM #fc_063
    UNION ALL
    SELECT 'INTERV_NOTE_INFO' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_063
    UNION ALL
    SELECT 'INTERV_NOTE_INFO' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_063
    UNION ALL
    SELECT 'INTERV_NOTE_INFO' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_063
    UNION ALL
    SELECT 'INTERV_NOTE_INFO' AS table_name, 'INTERV_NOTE_CSN_ID' AS column_name, activity_year, total_rows, INTERV_NOTE_CSN_ID_filled AS filled_count FROM #fc_063
    UNION ALL
    SELECT 'INTERV_SMARTTEXT' AS table_name, 'INTERVENTION_ID' AS column_name, activity_year, total_rows, INTERVENTION_ID_filled AS filled_count FROM #fc_064
    UNION ALL
    SELECT 'INTERV_SMARTTEXT' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_064
    UNION ALL
    SELECT 'INTERV_SMARTTEXT' AS table_name, 'SMARTTEXTS_ID' AS column_name, activity_year, total_rows, SMARTTEXTS_ID_filled AS filled_count FROM #fc_064
    UNION ALL
    SELECT 'INTERV_SMARTTEXT' AS table_name, 'SMARTTEXTS_ID_SMARTTEXT_NAME' AS column_name, activity_year, total_rows, SMARTTEXTS_ID_SMARTTEXT_NAME_filled AS filled_count FROM #fc_064
    UNION ALL
    SELECT 'INTERV_SMARTTEXT' AS table_name, 'IP_INV_LDS_ID' AS column_name, activity_year, total_rows, IP_INV_LDS_ID_filled AS filled_count FROM #fc_064
    UNION ALL
    SELECT 'INTERV_SMARTTEXT' AS table_name, 'IP_INV_LDS_ID_DISC_NAME' AS column_name, activity_year, total_rows, IP_INV_LDS_ID_DISC_NAME_filled AS filled_count FROM #fc_064
    UNION ALL
    SELECT 'INTERV_SMARTTEXT' AS table_name, 'HH_INT_DISC_C_NAME' AS column_name, activity_year, total_rows, HH_INT_DISC_C_NAME_filled AS filled_count FROM #fc_064
    UNION ALL
    SELECT 'IP_NOTE_TYPE' AS table_name, 'INPATIENT_DATA_ID' AS column_name, activity_year, total_rows, INPATIENT_DATA_ID_filled AS filled_count FROM #fc_065
    UNION ALL
    SELECT 'IP_NOTE_TYPE' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_065
    UNION ALL
    SELECT 'IP_NOTE_TYPE' AS table_name, 'TYPE_IP_C_NAME' AS column_name, activity_year, total_rows, TYPE_IP_C_NAME_filled AS filled_count FROM #fc_065
    UNION ALL
    SELECT 'LAB_COSIGN_INFO' AS table_name, 'ORDER_ID' AS column_name, activity_year, total_rows, ORDER_ID_filled AS filled_count FROM #fc_066
    UNION ALL
    SELECT 'LAB_COSIGN_INFO' AS table_name, 'CONTACT_DATE_REAL' AS column_name, activity_year, total_rows, CONTACT_DATE_REAL_filled AS filled_count FROM #fc_066
    UNION ALL
    SELECT 'LAB_COSIGN_INFO' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_066
    UNION ALL
    SELECT 'LAB_COSIGN_INFO' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_066
    UNION ALL
    SELECT 'LAB_COSIGN_INFO' AS table_name, 'COSINGER_ID' AS column_name, activity_year, total_rows, COSINGER_ID_filled AS filled_count FROM #fc_066
    UNION ALL
    SELECT 'LAB_COSIGN_INFO' AS table_name, 'COSINGER_ID_NAME' AS column_name, activity_year, total_rows, COSINGER_ID_NAME_filled AS filled_count FROM #fc_066
    UNION ALL
    SELECT 'LAB_COSIGN_INFO' AS table_name, 'AP_BILLABLE_YN' AS column_name, activity_year, total_rows, AP_BILLABLE_YN_filled AS filled_count FROM #fc_066
    UNION ALL
    SELECT 'LN_REPRICING_NOTE_TPO' AS table_name, 'RECORD_ID' AS column_name, activity_year, total_rows, RECORD_ID_filled AS filled_count FROM #fc_067
    UNION ALL
    SELECT 'LN_REPRICING_NOTE_TPO' AS table_name, 'GROUP_LINE' AS column_name, activity_year, total_rows, GROUP_LINE_filled AS filled_count FROM #fc_067
    UNION ALL
    SELECT 'LN_REPRICING_NOTE_TPO' AS table_name, 'VALUE_LINE' AS column_name, activity_year, total_rows, VALUE_LINE_filled AS filled_count FROM #fc_067
    UNION ALL
    SELECT 'LN_REPRICING_NOTE_TPO' AS table_name, 'LN_REPRICING_NOTE_TPO' AS column_name, activity_year, total_rows, LN_REPRICING_NOTE_TPO_filled AS filled_count FROM #fc_067
    UNION ALL
    SELECT 'MAR_COSIGN_INST' AS table_name, 'ORDER_ID' AS column_name, activity_year, total_rows, ORDER_ID_filled AS filled_count FROM #fc_068
    UNION ALL
    SELECT 'MAR_COSIGN_INST' AS table_name, 'GROUP_LINE' AS column_name, activity_year, total_rows, GROUP_LINE_filled AS filled_count FROM #fc_068
    UNION ALL
    SELECT 'MAR_COSIGN_INST' AS table_name, 'VALUE_LINE' AS column_name, activity_year, total_rows, VALUE_LINE_filled AS filled_count FROM #fc_068
    UNION ALL
    SELECT 'MAR_COSIGN_INST' AS table_name, 'MAR_COSIGN_INSTANT' AS column_name, activity_year, total_rows, MAR_COSIGN_INSTANT_filled AS filled_count FROM #fc_068
    UNION ALL
    SELECT 'MAR_COSIGN_USER' AS table_name, 'ORDER_ID' AS column_name, activity_year, total_rows, ORDER_ID_filled AS filled_count FROM #fc_069
    UNION ALL
    SELECT 'MAR_COSIGN_USER' AS table_name, 'GROUP_LINE' AS column_name, activity_year, total_rows, GROUP_LINE_filled AS filled_count FROM #fc_069
    UNION ALL
    SELECT 'MAR_COSIGN_USER' AS table_name, 'VALUE_LINE' AS column_name, activity_year, total_rows, VALUE_LINE_filled AS filled_count FROM #fc_069
    UNION ALL
    SELECT 'MAR_COSIGN_USER' AS table_name, 'MAR_COSIGN_USER_ID' AS column_name, activity_year, total_rows, MAR_COSIGN_USER_ID_filled AS filled_count FROM #fc_069
    UNION ALL
    SELECT 'MAR_COSIGN_USER' AS table_name, 'MAR_COSIGN_USER_ID_NAME' AS column_name, activity_year, total_rows, MAR_COSIGN_USER_ID_NAME_filled AS filled_count FROM #fc_069
    UNION ALL
    SELECT 'MED_AUTH_DET_NOTE' AS table_name, 'REFERRAL_ID' AS column_name, activity_year, total_rows, REFERRAL_ID_filled AS filled_count FROM #fc_070
    UNION ALL
    SELECT 'MED_AUTH_DET_NOTE' AS table_name, 'GROUP_LINE' AS column_name, activity_year, total_rows, GROUP_LINE_filled AS filled_count FROM #fc_070
    UNION ALL
    SELECT 'MED_AUTH_DET_NOTE' AS table_name, 'VALUE_LINE' AS column_name, activity_year, total_rows, VALUE_LINE_filled AS filled_count FROM #fc_070
    UNION ALL
    SELECT 'MED_AUTH_DET_NOTE' AS table_name, 'PA_DETAIL_NOTE' AS column_name, activity_year, total_rows, PA_DETAIL_NOTE_filled AS filled_count FROM #fc_070
    UNION ALL
    SELECT 'MED_DISCONTINUE_NOTE' AS table_name, 'DOCUMENT_ID' AS column_name, activity_year, total_rows, DOCUMENT_ID_filled AS filled_count FROM #fc_071
    UNION ALL
    SELECT 'MED_DISCONTINUE_NOTE' AS table_name, 'CONTACT_DATE_REAL' AS column_name, activity_year, total_rows, CONTACT_DATE_REAL_filled AS filled_count FROM #fc_071
    UNION ALL
    SELECT 'MED_DISCONTINUE_NOTE' AS table_name, 'GROUP_LINE' AS column_name, activity_year, total_rows, GROUP_LINE_filled AS filled_count FROM #fc_071
    UNION ALL
    SELECT 'MED_DISCONTINUE_NOTE' AS table_name, 'VALUE_LINE' AS column_name, activity_year, total_rows, VALUE_LINE_filled AS filled_count FROM #fc_071
    UNION ALL
    SELECT 'MED_DISCONTINUE_NOTE' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_071
    UNION ALL
    SELECT 'MED_PA_NOTE_FROM_PAYER' AS table_name, 'REFERRAL_ID' AS column_name, activity_year, total_rows, REFERRAL_ID_filled AS filled_count FROM #fc_072
    UNION ALL
    SELECT 'MED_PA_NOTE_FROM_PAYER' AS table_name, 'GROUP_LINE' AS column_name, activity_year, total_rows, GROUP_LINE_filled AS filled_count FROM #fc_072
    UNION ALL
    SELECT 'MED_PA_NOTE_FROM_PAYER' AS table_name, 'VALUE_LINE' AS column_name, activity_year, total_rows, VALUE_LINE_filled AS filled_count FROM #fc_072
    UNION ALL
    SELECT 'MED_PA_NOTE_FROM_PAYER' AS table_name, 'PA_NOTE_FROM_PAYER' AS column_name, activity_year, total_rows, PA_NOTE_FROM_PAYER_filled AS filled_count FROM #fc_072
    UNION ALL
    SELECT 'MED_PA_NOTE_TO_PAYER' AS table_name, 'REFERRAL_ID' AS column_name, activity_year, total_rows, REFERRAL_ID_filled AS filled_count FROM #fc_073
    UNION ALL
    SELECT 'MED_PA_NOTE_TO_PAYER' AS table_name, 'GROUP_LINE' AS column_name, activity_year, total_rows, GROUP_LINE_filled AS filled_count FROM #fc_073
    UNION ALL
    SELECT 'MED_PA_NOTE_TO_PAYER' AS table_name, 'VALUE_LINE' AS column_name, activity_year, total_rows, VALUE_LINE_filled AS filled_count FROM #fc_073
    UNION ALL
    SELECT 'MED_PA_NOTE_TO_PAYER' AS table_name, 'PA_NOTE_TO_PAYER' AS column_name, activity_year, total_rows, PA_NOTE_TO_PAYER_filled AS filled_count FROM #fc_073
    UNION ALL
    SELECT 'NOTES_ACCT' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_074
    UNION ALL
    SELECT 'NOTES_ACCT' AS table_name, 'ACCOUNT_ID' AS column_name, activity_year, total_rows, ACCOUNT_ID_filled AS filled_count FROM #fc_074
    UNION ALL
    SELECT 'NOTES_ACCT' AS table_name, 'ACTIVE_STATUS' AS column_name, activity_year, total_rows, ACTIVE_STATUS_filled AS filled_count FROM #fc_074
    UNION ALL
    SELECT 'NOTES_ACCT' AS table_name, 'ENTRY_USER_ID' AS column_name, activity_year, total_rows, ENTRY_USER_ID_filled AS filled_count FROM #fc_074
    UNION ALL
    SELECT 'NOTES_ACCT' AS table_name, 'ENTRY_USER_ID_NAME' AS column_name, activity_year, total_rows, ENTRY_USER_ID_NAME_filled AS filled_count FROM #fc_074
    UNION ALL
    SELECT 'NOTES_ACCT' AS table_name, 'INVOICE_NUMBER' AS column_name, activity_year, total_rows, INVOICE_NUMBER_filled AS filled_count FROM #fc_074
    UNION ALL
    SELECT 'NOTES_ACCT' AS table_name, 'NOTE_ENTRY_DTTM' AS column_name, activity_year, total_rows, NOTE_ENTRY_DTTM_filled AS filled_count FROM #fc_074
    UNION ALL
    SELECT 'NOTES_HISTORY_LOG' AS table_name, 'NOTE_CSN_ID' AS column_name, activity_year, total_rows, NOTE_CSN_ID_filled AS filled_count FROM #fc_075
    UNION ALL
    SELECT 'NOTES_HISTORY_LOG' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_075
    UNION ALL
    SELECT 'NOTES_HISTORY_LOG' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_075
    UNION ALL
    SELECT 'NOTES_HISTORY_LOG' AS table_name, 'CONTACT_DATE_REAL' AS column_name, activity_year, total_rows, CONTACT_DATE_REAL_filled AS filled_count FROM #fc_075
    UNION ALL
    SELECT 'NOTES_HISTORY_LOG' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_075
    UNION ALL
    SELECT 'NOTES_HISTORY_LOG' AS table_name, 'EDIT_HX_INSTANT' AS column_name, activity_year, total_rows, EDIT_HX_INSTANT_filled AS filled_count FROM #fc_075
    UNION ALL
    SELECT 'NOTES_HISTORY_LOG' AS table_name, 'EDIT_HX_ACTION_C_NAME' AS column_name, activity_year, total_rows, EDIT_HX_ACTION_C_NAME_filled AS filled_count FROM #fc_075
    UNION ALL
    SELECT 'NOTES_HISTORY_LOG' AS table_name, 'EDIT_HX_INFO' AS column_name, activity_year, total_rows, EDIT_HX_INFO_filled AS filled_count FROM #fc_075
    UNION ALL
    SELECT 'NOTES_HISTORY_LOG' AS table_name, 'EDIT_HX_EXP_DATE' AS column_name, activity_year, total_rows, EDIT_HX_EXP_DATE_filled AS filled_count FROM #fc_075
    UNION ALL
    SELECT 'NOTES_LAB' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_076
    UNION ALL
    SELECT 'NOTES_LAB' AS table_name, 'LAB_NOTE_SUB_TYPE_C_NAME' AS column_name, activity_year, total_rows, LAB_NOTE_SUB_TYPE_C_NAME_filled AS filled_count FROM #fc_076
    UNION ALL
    SELECT 'NOTES_LINK_ORD_TXN' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_077
    UNION ALL
    SELECT 'NOTES_LINK_ORD_TXN' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_077
    UNION ALL
    SELECT 'NOTES_LINK_ORD_TXN' AS table_name, 'LINKED_ORD_ID' AS column_name, activity_year, total_rows, LINKED_ORD_ID_filled AS filled_count FROM #fc_077
    UNION ALL
    SELECT 'NOTES_MC_NMM' AS table_name, 'CASE_ID' AS column_name, activity_year, total_rows, CASE_ID_filled AS filled_count FROM #fc_078
    UNION ALL
    SELECT 'NOTES_MC_NMM' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_078
    UNION ALL
    SELECT 'NOTES_MC_NMM' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_078
    UNION ALL
    SELECT 'NOTES_MC_NMM' AS table_name, 'NOTE_DATE' AS column_name, activity_year, total_rows, NOTE_DATE_filled AS filled_count FROM #fc_078
    UNION ALL
    SELECT 'NOTES_MC_NMM' AS table_name, 'NOTE_TIME' AS column_name, activity_year, total_rows, NOTE_TIME_filled AS filled_count FROM #fc_078
    UNION ALL
    SELECT 'NOTES_MC_NMM' AS table_name, 'NOTE_USER_ID' AS column_name, activity_year, total_rows, NOTE_USER_ID_filled AS filled_count FROM #fc_078
    UNION ALL
    SELECT 'NOTES_MC_NMM' AS table_name, 'NOTE_USER_ID_NAME' AS column_name, activity_year, total_rows, NOTE_USER_ID_NAME_filled AS filled_count FROM #fc_078
    UNION ALL
    SELECT 'NOTES_PROC_ORDERS' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_079
    UNION ALL
    SELECT 'NOTES_PROC_ORDERS' AS table_name, 'CONTACT_DATE_REAL' AS column_name, activity_year, total_rows, CONTACT_DATE_REAL_filled AS filled_count FROM #fc_079
    UNION ALL
    SELECT 'NOTES_PROC_ORDERS' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_079
    UNION ALL
    SELECT 'NOTES_PROC_ORDERS' AS table_name, 'ASC_PROC_ORDERS_ID' AS column_name, activity_year, total_rows, ASC_PROC_ORDERS_ID_filled AS filled_count FROM #fc_079
    UNION ALL
    SELECT 'NOTES_PROC_PRE_DX' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_080
    UNION ALL
    SELECT 'NOTES_PROC_PRE_DX' AS table_name, 'CONTACT_DATE_REAL' AS column_name, activity_year, total_rows, CONTACT_DATE_REAL_filled AS filled_count FROM #fc_080
    UNION ALL
    SELECT 'NOTES_PROC_PRE_DX' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_080
    UNION ALL
    SELECT 'NOTES_PROC_PRE_DX' AS table_name, 'PROC_NOTE_PRE_DX_DX_NAME' AS column_name, activity_year, total_rows, PROC_NOTE_PRE_DX_DX_NAME_filled AS filled_count FROM #fc_080
    UNION ALL
    SELECT 'NOTES_PROC_PROCS' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_081
    UNION ALL
    SELECT 'NOTES_PROC_PROCS' AS table_name, 'CONTACT_DATE_REAL' AS column_name, activity_year, total_rows, CONTACT_DATE_REAL_filled AS filled_count FROM #fc_081
    UNION ALL
    SELECT 'NOTES_PROC_PROCS' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_081
    UNION ALL
    SELECT 'NOTES_PROC_PROCS' AS table_name, 'PROC_NOTE_PROCEDUR_PROC_NAME' AS column_name, activity_year, total_rows, PROC_NOTE_PROCEDUR_PROC_NAME_filled AS filled_count FROM #fc_081
    UNION ALL
    SELECT 'NOTES_PROC_PST_DX' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_082
    UNION ALL
    SELECT 'NOTES_PROC_PST_DX' AS table_name, 'CONTACT_DATE_REAL' AS column_name, activity_year, total_rows, CONTACT_DATE_REAL_filled AS filled_count FROM #fc_082
    UNION ALL
    SELECT 'NOTES_PROC_PST_DX' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_082
    UNION ALL
    SELECT 'NOTES_PROC_PST_DX' AS table_name, 'PROC_NOTE_PST_DX_DX_NAME' AS column_name, activity_year, total_rows, PROC_NOTE_PST_DX_DX_NAME_filled AS filled_count FROM #fc_082
    UNION ALL
    SELECT 'NOTES_TRANS_AUTH' AS table_name, 'NOTE_CSN_ID' AS column_name, activity_year, total_rows, NOTE_CSN_ID_filled AS filled_count FROM #fc_083
    UNION ALL
    SELECT 'NOTES_TRANS_AUTH' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_083
    UNION ALL
    SELECT 'NOTES_TRANS_AUTH' AS table_name, 'AUTH_PROV_ID_PROV_NAME' AS column_name, activity_year, total_rows, AUTH_PROV_ID_PROV_NAME_filled AS filled_count FROM #fc_083
    UNION ALL
    SELECT 'NOTES_TRANS_AUTH' AS table_name, 'AUTH_DTTM' AS column_name, activity_year, total_rows, AUTH_DTTM_filled AS filled_count FROM #fc_083
    UNION ALL
    SELECT 'NOTES_TRANS_AUTH' AS table_name, 'AUTH_USER_ID' AS column_name, activity_year, total_rows, AUTH_USER_ID_filled AS filled_count FROM #fc_083
    UNION ALL
    SELECT 'NOTES_TRANS_AUTH' AS table_name, 'AUTH_USER_ID_NAME' AS column_name, activity_year, total_rows, AUTH_USER_ID_NAME_filled AS filled_count FROM #fc_083
    UNION ALL
    SELECT 'NOTES_TRANS_AUTH' AS table_name, 'DICTATION_TIME' AS column_name, activity_year, total_rows, DICTATION_TIME_filled AS filled_count FROM #fc_083
    UNION ALL
    SELECT 'NOTES_TRANS_AUTH' AS table_name, 'TRANSCRIPTION_TIME' AS column_name, activity_year, total_rows, TRANSCRIPTION_TIME_filled AS filled_count FROM #fc_083
    UNION ALL
    SELECT 'NOTES_TRANS_AUTH' AS table_name, 'ACTIVITY_DTTM' AS column_name, activity_year, total_rows, ACTIVITY_DTTM_filled AS filled_count FROM #fc_083
    UNION ALL
    SELECT 'NOTES_TRANS_AUTH' AS table_name, 'ORIGINATOR_ID_PROV_NAME' AS column_name, activity_year, total_rows, ORIGINATOR_ID_PROV_NAME_filled AS filled_count FROM #fc_083
    UNION ALL
    SELECT 'NOTES_TRANS_AUTH' AS table_name, 'EDIT_DTTM' AS column_name, activity_year, total_rows, EDIT_DTTM_filled AS filled_count FROM #fc_083
    UNION ALL
    SELECT 'NOTES_TRANS_AUTH' AS table_name, 'CHR_CNT_DTTM' AS column_name, activity_year, total_rows, CHR_CNT_DTTM_filled AS filled_count FROM #fc_083
    UNION ALL
    SELECT 'NOTES_TRANS_AUTH' AS table_name, 'CHR_CNT_MET' AS column_name, activity_year, total_rows, CHR_CNT_MET_filled AS filled_count FROM #fc_083
    UNION ALL
    SELECT 'NOTES_TRANS_AUTH' AS table_name, 'DICT_PRIORITY_C_NAME' AS column_name, activity_year, total_rows, DICT_PRIORITY_C_NAME_filled AS filled_count FROM #fc_083
    UNION ALL
    SELECT 'NOTES_TRANS_IB' AS table_name, 'NOTE_CSN_ID' AS column_name, activity_year, total_rows, NOTE_CSN_ID_filled AS filled_count FROM #fc_084
    UNION ALL
    SELECT 'NOTES_TRANS_IB' AS table_name, 'IB_PRIORITY_C_NAME' AS column_name, activity_year, total_rows, IB_PRIORITY_C_NAME_filled AS filled_count FROM #fc_084
    UNION ALL
    SELECT 'NOTE_AMBIENT_SECTIONS' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_085
    UNION ALL
    SELECT 'NOTE_AMBIENT_SECTIONS' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_085
    UNION ALL
    SELECT 'NOTE_AMBIENT_SECTIONS' AS table_name, 'AMBIENT_SESSION_SECTION_IDENT' AS column_name, activity_year, total_rows, AMBIENT_SESSION_SECTION_IDENT_filled AS filled_count FROM #fc_085
    UNION ALL
    SELECT 'NOTE_AMBIENT_SECTIONS' AS table_name, 'AMBIENT_SESSION_IDENT' AS column_name, activity_year, total_rows, AMBIENT_SESSION_IDENT_filled AS filled_count FROM #fc_085
    UNION ALL
    SELECT 'NOTE_ATTACHED_IMG' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_086
    UNION ALL
    SELECT 'NOTE_ATTACHED_IMG' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_086
    UNION ALL
    SELECT 'NOTE_ATTACHED_IMG' AS table_name, 'NOTE_IMG_DOC_ID' AS column_name, activity_year, total_rows, NOTE_IMG_DOC_ID_filled AS filled_count FROM #fc_086
    UNION ALL
    SELECT 'NOTE_BLOCKING' AS table_name, 'NOTE_CSN_ID' AS column_name, activity_year, total_rows, NOTE_CSN_ID_filled AS filled_count FROM #fc_087
    UNION ALL
    SELECT 'NOTE_BLOCKING' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_087
    UNION ALL
    SELECT 'NOTE_BLOCKING' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_087
    UNION ALL
    SELECT 'NOTE_BLOCKING' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_087
    UNION ALL
    SELECT 'NOTE_BLOCKING' AS table_name, 'MULT_BLOCK_REASON_C_NAME' AS column_name, activity_year, total_rows, MULT_BLOCK_REASON_C_NAME_filled AS filled_count FROM #fc_087
    UNION ALL
    SELECT 'NOTE_CONTENT_INFO' AS table_name, 'NOTE_CSN_ID' AS column_name, activity_year, total_rows, NOTE_CSN_ID_filled AS filled_count FROM #fc_088
    UNION ALL
    SELECT 'NOTE_CONTENT_INFO' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_088
    UNION ALL
    SELECT 'NOTE_CONTENT_INFO' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_088
    UNION ALL
    SELECT 'NOTE_CONTENT_INFO' AS table_name, 'CONTACT_DATE_REAL' AS column_name, activity_year, total_rows, CONTACT_DATE_REAL_filled AS filled_count FROM #fc_088
    UNION ALL
    SELECT 'NOTE_CONTENT_INFO' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_088
    UNION ALL
    SELECT 'NOTE_COPY_TRACKING' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_089
    UNION ALL
    SELECT 'NOTE_COPY_TRACKING' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_089
    UNION ALL
    SELECT 'NOTE_COPY_TRACKING' AS table_name, 'NOTE_COPY_INST_DTTM' AS column_name, activity_year, total_rows, NOTE_COPY_INST_DTTM_filled AS filled_count FROM #fc_089
    UNION ALL
    SELECT 'NOTE_COPY_TRACKING' AS table_name, 'NOTE_COPY_LOC_DTTM' AS column_name, activity_year, total_rows, NOTE_COPY_LOC_DTTM_filled AS filled_count FROM #fc_089
    UNION ALL
    SELECT 'NOTE_DENT_PROCS' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_090
    UNION ALL
    SELECT 'NOTE_DENT_PROCS' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_090
    UNION ALL
    SELECT 'NOTE_DENT_PROCS' AS table_name, 'DENT_PROC_FINDING_ID' AS column_name, activity_year, total_rows, DENT_PROC_FINDING_ID_filled AS filled_count FROM #fc_090
    UNION ALL
    SELECT 'NOTE_EDIT_TRAIL' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_091
    UNION ALL
    SELECT 'NOTE_EDIT_TRAIL' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_091
    UNION ALL
    SELECT 'NOTE_EDIT_TRAIL' AS table_name, 'IP_ACTION_DTTM' AS column_name, activity_year, total_rows, IP_ACTION_DTTM_filled AS filled_count FROM #fc_091
    UNION ALL
    SELECT 'NOTE_EDIT_TRAIL' AS table_name, 'ACT_TAKEN_INST_DTTM' AS column_name, activity_year, total_rows, ACT_TAKEN_INST_DTTM_filled AS filled_count FROM #fc_091
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'CONTACT_SERIAL_NUM' AS column_name, activity_year, total_rows, CONTACT_SERIAL_NUM_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'CONTACT_DATE_REAL' AS column_name, activity_year, total_rows, CONTACT_DATE_REAL_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'COSIGN_INSTANT_DTTM' AS column_name, activity_year, total_rows, COSIGN_INSTANT_DTTM_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'COSIGNUSER_ID' AS column_name, activity_year, total_rows, COSIGNUSER_ID_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'COSIGNUSER_ID_NAME' AS column_name, activity_year, total_rows, COSIGNUSER_ID_NAME_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'COSIGN_NOTE_LINK' AS column_name, activity_year, total_rows, COSIGN_NOTE_LINK_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'COSIGN_REQUIRED_C_NAME' AS column_name, activity_year, total_rows, COSIGN_REQUIRED_C_NAME_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'AUTH_LNKED_PROV_ID_PROV_NAME' AS column_name, activity_year, total_rows, AUTH_LNKED_PROV_ID_PROV_NAME_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'AUTHOR_SERVICE_C_NAME' AS column_name, activity_year, total_rows, AUTHOR_SERVICE_C_NAME_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'ENTRY_INSTANT_DTTM' AS column_name, activity_year, total_rows, ENTRY_INSTANT_DTTM_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'UPD_AUTHOR_INS_DTTM' AS column_name, activity_year, total_rows, UPD_AUTHOR_INS_DTTM_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'SPEC_NOTE_TIME_DTTM' AS column_name, activity_year, total_rows, SPEC_NOTE_TIME_DTTM_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'NOTE_FILE_TIME_DTTM' AS column_name, activity_year, total_rows, NOTE_FILE_TIME_DTTM_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'AUTHOR_PRVD_TYPE_C_NAME' AS column_name, activity_year, total_rows, AUTHOR_PRVD_TYPE_C_NAME_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'NOTE_STATUS_C_NAME' AS column_name, activity_year, total_rows, NOTE_STATUS_C_NAME_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'UPDATE_USER_ID' AS column_name, activity_year, total_rows, UPDATE_USER_ID_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'UPDATE_USER_ID_NAME' AS column_name, activity_year, total_rows, UPDATE_USER_ID_NAME_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'TRN_DOC_AVAIL_STA_C_NAME' AS column_name, activity_year, total_rows, TRN_DOC_AVAIL_STA_C_NAME_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'TRN_DOC_TYPE_C_NAME' AS column_name, activity_year, total_rows, TRN_DOC_TYPE_C_NAME_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'SENSITIVE_STAT_C_NAME' AS column_name, activity_year, total_rows, SENSITIVE_STAT_C_NAME_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'AUTHOR_USER_ID' AS column_name, activity_year, total_rows, AUTHOR_USER_ID_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'AUTHOR_USER_ID_NAME' AS column_name, activity_year, total_rows, AUTHOR_USER_ID_NAME_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'NOTE_FORMAT_C_NAME' AS column_name, activity_year, total_rows, NOTE_FORMAT_C_NAME_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'UPD_BY_AUTH_DTTM' AS column_name, activity_year, total_rows, UPD_BY_AUTH_DTTM_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'ACTIVITY_DTTM' AS column_name, activity_year, total_rows, ACTIVITY_DTTM_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'AUTH_STAT_C_NAME' AS column_name, activity_year, total_rows, AUTH_STAT_C_NAME_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'CONTACT_NUM' AS column_name, activity_year, total_rows, CONTACT_NUM_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'UPD_AUT_LOCAL_DTTM' AS column_name, activity_year, total_rows, UPD_AUT_LOCAL_DTTM_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'ENT_INST_LOCAL_DTTM' AS column_name, activity_year, total_rows, ENT_INST_LOCAL_DTTM_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'SPEC_TIME_LOC_DTTM' AS column_name, activity_year, total_rows, SPEC_TIME_LOC_DTTM_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'NOT_FILETM_LOC_DTTM' AS column_name, activity_year, total_rows, NOT_FILETM_LOC_DTTM_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'EDIT_USER_ID' AS column_name, activity_year, total_rows, EDIT_USER_ID_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'EDIT_USER_ID_NAME' AS column_name, activity_year, total_rows, EDIT_USER_ID_NAME_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'DOCUMENT_NAME' AS column_name, activity_year, total_rows, DOCUMENT_NAME_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'UMRG_SRC_MEDPROB_ID' AS column_name, activity_year, total_rows, UMRG_SRC_MEDPROB_ID_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'ECG_COMMENTS' AS column_name, activity_year, total_rows, ECG_COMMENTS_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'ECG_EDITED_USER_ID' AS column_name, activity_year, total_rows, ECG_EDITED_USER_ID_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'ECG_DIASTOLIC_BP' AS column_name, activity_year, total_rows, ECG_DIASTOLIC_BP_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'ECG_SYSTOLIC_BP' AS column_name, activity_year, total_rows, ECG_SYSTOLIC_BP_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'ECG_HEARTRATE' AS column_name, activity_year, total_rows, ECG_HEARTRATE_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'ECG_PR_INTERVAL' AS column_name, activity_year, total_rows, ECG_PR_INTERVAL_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'ECG_PWAVEAXIS' AS column_name, activity_year, total_rows, ECG_PWAVEAXIS_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'ECG_QRS_DURATION' AS column_name, activity_year, total_rows, ECG_QRS_DURATION_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'ECG_QRS_WAVEAXIS' AS column_name, activity_year, total_rows, ECG_QRS_WAVEAXIS_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'ECG_QT_INTERVAL' AS column_name, activity_year, total_rows, ECG_QT_INTERVAL_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'ECG_QTC_INTERVAL' AS column_name, activity_year, total_rows, ECG_QTC_INTERVAL_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'ECG_T_WAVEAXIS' AS column_name, activity_year, total_rows, ECG_T_WAVEAXIS_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'SPIRO_BRON' AS column_name, activity_year, total_rows, SPIRO_BRON_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'CARE_PLAN_CSN_ID' AS column_name, activity_year, total_rows, CARE_PLAN_CSN_ID_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'PROGRESS_NOTE_ID' AS column_name, activity_year, total_rows, PROGRESS_NOTE_ID_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'TRANSCRIPTION_DTTM' AS column_name, activity_year, total_rows, TRANSCRIPTION_DTTM_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'CSGN_RECPNT_USER_ID' AS column_name, activity_year, total_rows, CSGN_RECPNT_USER_ID_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'CSGN_RECPNT_USER_ID_NAME' AS column_name, activity_year, total_rows, CSGN_RECPNT_USER_ID_NAME_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'TREAT_SUMM_PAT_DTTM' AS column_name, activity_year, total_rows, TREAT_SUMM_PAT_DTTM_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'TREAT_SUMM_PROV_DTTM' AS column_name, activity_year, total_rows, TREAT_SUMM_PROV_DTTM_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'TREAT_SUMM_CPLT_DTTM' AS column_name, activity_year, total_rows, TREAT_SUMM_CPLT_DTTM_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'PAT_ENC_CSN_ID' AS column_name, activity_year, total_rows, PAT_ENC_CSN_ID_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'END_OF_TREAT_DATE' AS column_name, activity_year, total_rows, END_OF_TREAT_DATE_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'UNMERGE_SRC_NOTE_ID' AS column_name, activity_year, total_rows, UNMERGE_SRC_NOTE_ID_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'NOTE_SHARED_W_PAT_HX_YN' AS column_name, activity_year, total_rows, NOTE_SHARED_W_PAT_HX_YN_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'NOTE_TYPE_C_NAME' AS column_name, activity_year, total_rows, NOTE_TYPE_C_NAME_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'POC_NOTE_DISC_C_NAME' AS column_name, activity_year, total_rows, POC_NOTE_DISC_C_NAME_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'COSIGN_INST_LOCAL_DTTM' AS column_name, activity_year, total_rows, COSIGN_INST_LOCAL_DTTM_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'IS_PRECHARTED_YN' AS column_name, activity_year, total_rows, IS_PRECHARTED_YN_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'LINK_DXR_CSN_ID' AS column_name, activity_year, total_rows, LINK_DXR_CSN_ID_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'CLINICAL_NOTE_SUMMARY' AS column_name, activity_year, total_rows, CLINICAL_NOTE_SUMMARY_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'BLOCK_REASON_C_NAME' AS column_name, activity_year, total_rows, BLOCK_REASON_C_NAME_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO' AS table_name, 'BLOCK_REASON_TXT' AS column_name, activity_year, total_rows, BLOCK_REASON_TXT_filled AS filled_count FROM #fc_092
    UNION ALL
    SELECT 'NOTE_ENC_INFO_2' AS table_name, 'NOTE_CSN_ID' AS column_name, activity_year, total_rows, NOTE_CSN_ID_filled AS filled_count FROM #fc_093
    UNION ALL
    SELECT 'NOTE_ENC_INFO_2' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_093
    UNION ALL
    SELECT 'NOTE_ENC_INFO_2' AS table_name, 'CONTACT_DATE_REAL' AS column_name, activity_year, total_rows, CONTACT_DATE_REAL_filled AS filled_count FROM #fc_093
    UNION ALL
    SELECT 'NOTE_ENC_INFO_2' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_093
    UNION ALL
    SELECT 'NOTE_ENC_INFO_2' AS table_name, 'CONTACT_NUM' AS column_name, activity_year, total_rows, CONTACT_NUM_filled AS filled_count FROM #fc_093
    UNION ALL
    SELECT 'NOTE_ENC_INFO_2' AS table_name, 'CM_CT_OWNER_ID' AS column_name, activity_year, total_rows, CM_CT_OWNER_ID_filled AS filled_count FROM #fc_093
    UNION ALL
    SELECT 'NOTE_ENC_INFO_2' AS table_name, 'EXT_SHARED_W_PT_YN' AS column_name, activity_year, total_rows, EXT_SHARED_W_PT_YN_filled AS filled_count FROM #fc_093
    UNION ALL
    SELECT 'NOTE_ENC_INFO_2' AS table_name, 'EXT_AUTH_NAME' AS column_name, activity_year, total_rows, EXT_AUTH_NAME_filled AS filled_count FROM #fc_093
    UNION ALL
    SELECT 'NOTE_ENC_INFO_2' AS table_name, 'EXT_AUTH_SPEC_C_NAME' AS column_name, activity_year, total_rows, EXT_AUTH_SPEC_C_NAME_filled AS filled_count FROM #fc_093
    UNION ALL
    SELECT 'NOTE_ENC_INFO_2' AS table_name, 'EXT_AUTH_TYPE' AS column_name, activity_year, total_rows, EXT_AUTH_TYPE_filled AS filled_count FROM #fc_093
    UNION ALL
    SELECT 'NOTE_ENC_INFO_2' AS table_name, 'EXT_AUTH_SERV' AS column_name, activity_year, total_rows, EXT_AUTH_SERV_filled AS filled_count FROM #fc_093
    UNION ALL
    SELECT 'NOTE_ENC_INFO_2' AS table_name, 'EXT_LAST_SIGNER' AS column_name, activity_year, total_rows, EXT_LAST_SIGNER_filled AS filled_count FROM #fc_093
    UNION ALL
    SELECT 'NOTE_ENC_INFO_2' AS table_name, 'EXT_LAST_SIGN_UTC_DTTM' AS column_name, activity_year, total_rows, EXT_LAST_SIGN_UTC_DTTM_filled AS filled_count FROM #fc_093
    UNION ALL
    SELECT 'NOTE_ENC_INFO_2' AS table_name, 'NOTE_AUTHOR_TYPE_C_NAME' AS column_name, activity_year, total_rows, NOTE_AUTHOR_TYPE_C_NAME_filled AS filled_count FROM #fc_093
    UNION ALL
    SELECT 'NOTE_ENC_SUMMARY' AS table_name, 'NOTE_CSN_ID' AS column_name, activity_year, total_rows, NOTE_CSN_ID_filled AS filled_count FROM #fc_094
    UNION ALL
    SELECT 'NOTE_ENC_SUMMARY' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_094
    UNION ALL
    SELECT 'NOTE_ENC_SUMMARY' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_094
    UNION ALL
    SELECT 'NOTE_ENC_SUMMARY' AS table_name, 'SUMMARY_TEXT' AS column_name, activity_year, total_rows, SUMMARY_TEXT_filled AS filled_count FROM #fc_094
    UNION ALL
    SELECT 'NOTE_EXT_REL_ORD' AS table_name, 'NOTE_CSN_ID' AS column_name, activity_year, total_rows, NOTE_CSN_ID_filled AS filled_count FROM #fc_095
    UNION ALL
    SELECT 'NOTE_EXT_REL_ORD' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_095
    UNION ALL
    SELECT 'NOTE_EXT_REL_ORD' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_095
    UNION ALL
    SELECT 'NOTE_EXT_REL_ORD' AS table_name, 'CONTACT_DATE_REAL' AS column_name, activity_year, total_rows, CONTACT_DATE_REAL_filled AS filled_count FROM #fc_095
    UNION ALL
    SELECT 'NOTE_EXT_REL_ORD' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_095
    UNION ALL
    SELECT 'NOTE_EXT_REL_ORD' AS table_name, 'EXT_REL_ORD_NAME' AS column_name, activity_year, total_rows, EXT_REL_ORD_NAME_filled AS filled_count FROM #fc_095
    UNION ALL
    SELECT 'NOTE_EXT_REL_PREDX' AS table_name, 'NOTE_CSN_ID' AS column_name, activity_year, total_rows, NOTE_CSN_ID_filled AS filled_count FROM #fc_096
    UNION ALL
    SELECT 'NOTE_EXT_REL_PREDX' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_096
    UNION ALL
    SELECT 'NOTE_EXT_REL_PREDX' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_096
    UNION ALL
    SELECT 'NOTE_EXT_REL_PREDX' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_096
    UNION ALL
    SELECT 'NOTE_EXT_REL_PREDX' AS table_name, 'EXT_REL_PREDX_NAME' AS column_name, activity_year, total_rows, EXT_REL_PREDX_NAME_filled AS filled_count FROM #fc_096
    UNION ALL
    SELECT 'NOTE_EXT_REL_PROB' AS table_name, 'NOTE_CSN_ID' AS column_name, activity_year, total_rows, NOTE_CSN_ID_filled AS filled_count FROM #fc_097
    UNION ALL
    SELECT 'NOTE_EXT_REL_PROB' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_097
    UNION ALL
    SELECT 'NOTE_EXT_REL_PROB' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_097
    UNION ALL
    SELECT 'NOTE_EXT_REL_PROB' AS table_name, 'CONTACT_DATE_REAL' AS column_name, activity_year, total_rows, CONTACT_DATE_REAL_filled AS filled_count FROM #fc_097
    UNION ALL
    SELECT 'NOTE_EXT_REL_PROB' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_097
    UNION ALL
    SELECT 'NOTE_EXT_REL_PROB' AS table_name, 'EXT_REL_PROB_NAME' AS column_name, activity_year, total_rows, EXT_REL_PROB_NAME_filled AS filled_count FROM #fc_097
    UNION ALL
    SELECT 'NOTE_EXT_REL_PROC' AS table_name, 'NOTE_CSN_ID' AS column_name, activity_year, total_rows, NOTE_CSN_ID_filled AS filled_count FROM #fc_098
    UNION ALL
    SELECT 'NOTE_EXT_REL_PROC' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_098
    UNION ALL
    SELECT 'NOTE_EXT_REL_PROC' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_098
    UNION ALL
    SELECT 'NOTE_EXT_REL_PROC' AS table_name, 'CONTACT_DATE_REAL' AS column_name, activity_year, total_rows, CONTACT_DATE_REAL_filled AS filled_count FROM #fc_098
    UNION ALL
    SELECT 'NOTE_EXT_REL_PROC' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_098
    UNION ALL
    SELECT 'NOTE_EXT_REL_PROC' AS table_name, 'EXT_REL_PROC_NAME' AS column_name, activity_year, total_rows, EXT_REL_PROC_NAME_filled AS filled_count FROM #fc_098
    UNION ALL
    SELECT 'NOTE_EXT_REL_PSTDX' AS table_name, 'NOTE_CSN_ID' AS column_name, activity_year, total_rows, NOTE_CSN_ID_filled AS filled_count FROM #fc_099
    UNION ALL
    SELECT 'NOTE_EXT_REL_PSTDX' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_099
    UNION ALL
    SELECT 'NOTE_EXT_REL_PSTDX' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_099
    UNION ALL
    SELECT 'NOTE_EXT_REL_PSTDX' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_099
    UNION ALL
    SELECT 'NOTE_EXT_REL_PSTDX' AS table_name, 'EXT_REL_PSTDX_NAME' AS column_name, activity_year, total_rows, EXT_REL_PSTDX_NAME_filled AS filled_count FROM #fc_099
    UNION ALL
    SELECT 'NOTE_EXT_SIGNERS' AS table_name, 'NOTE_CSN_ID' AS column_name, activity_year, total_rows, NOTE_CSN_ID_filled AS filled_count FROM #fc_100
    UNION ALL
    SELECT 'NOTE_EXT_SIGNERS' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_100
    UNION ALL
    SELECT 'NOTE_EXT_SIGNERS' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_100
    UNION ALL
    SELECT 'NOTE_EXT_SIGNERS' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_100
    UNION ALL
    SELECT 'NOTE_EXT_SIGNERS' AS table_name, 'EXT_NOTE_SIGNER_NAME' AS column_name, activity_year, total_rows, EXT_NOTE_SIGNER_NAME_filled AS filled_count FROM #fc_100
    UNION ALL
    SELECT 'NOTE_EXT_SIGNERS' AS table_name, 'EXT_NOTE_SIGNING_UTC_DTTM' AS column_name, activity_year, total_rows, EXT_NOTE_SIGNING_UTC_DTTM_filled AS filled_count FROM #fc_100
    UNION ALL
    SELECT 'NOTE_EXT_SIGNERS' AS table_name, 'EXT_NOTE_SIGNER_ROLE_C_NAME' AS column_name, activity_year, total_rows, EXT_NOTE_SIGNER_ROLE_C_NAME_filled AS filled_count FROM #fc_100
    UNION ALL
    SELECT 'NOTE_EXT_WRN_TYP' AS table_name, 'NOTE_CSN_ID' AS column_name, activity_year, total_rows, NOTE_CSN_ID_filled AS filled_count FROM #fc_101
    UNION ALL
    SELECT 'NOTE_EXT_WRN_TYP' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_101
    UNION ALL
    SELECT 'NOTE_EXT_WRN_TYP' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_101
    UNION ALL
    SELECT 'NOTE_EXT_WRN_TYP' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_101
    UNION ALL
    SELECT 'NOTE_EXT_WRN_TYP' AS table_name, 'EXT_NOTE_WRN_C_NAME' AS column_name, activity_year, total_rows, EXT_NOTE_WRN_C_NAME_filled AS filled_count FROM #fc_101
    UNION ALL
    SELECT 'NOTE_FREE_TEXT' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_102
    UNION ALL
    SELECT 'NOTE_FREE_TEXT' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_102
    UNION ALL
    SELECT 'NOTE_FREE_TEXT' AS table_name, 'NOTE_FREE_TEXT' AS column_name, activity_year, total_rows, NOTE_FREE_TEXT_filled AS filled_count FROM #fc_102
    UNION ALL
    SELECT 'NOTE_IMG_SECT' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_103
    UNION ALL
    SELECT 'NOTE_IMG_SECT' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_103
    UNION ALL
    SELECT 'NOTE_IMG_SECT' AS table_name, 'IMG_SECT_RESULT_NOTE_CSN_ID' AS column_name, activity_year, total_rows, IMG_SECT_RESULT_NOTE_CSN_ID_filled AS filled_count FROM #fc_103
    UNION ALL
    SELECT 'NOTE_IMG_SECT' AS table_name, 'IMG_SECT_ORDER_ID' AS column_name, activity_year, total_rows, IMG_SECT_ORDER_ID_filled AS filled_count FROM #fc_103
    UNION ALL
    SELECT 'NOTE_PARENT_NOTE' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_104
    UNION ALL
    SELECT 'NOTE_PARENT_NOTE' AS table_name, 'SS_PARENT_NOTE_ID' AS column_name, activity_year, total_rows, SS_PARENT_NOTE_ID_filled AS filled_count FROM #fc_104
    UNION ALL
    SELECT 'NOTE_RESEARCH_LINK' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_105
    UNION ALL
    SELECT 'NOTE_RESEARCH_LINK' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_105
    UNION ALL
    SELECT 'NOTE_RESEARCH_LINK' AS table_name, 'RESEARCH_ID_RESEARCH_STUDY_NAME' AS column_name, activity_year, total_rows, RESEARCH_ID_RESEARCH_STUDY_NAME_filled AS filled_count FROM #fc_105
    UNION ALL
    SELECT 'NOTE_RESEARCH_LINK' AS table_name, 'ENROLL_ID' AS column_name, activity_year, total_rows, ENROLL_ID_filled AS filled_count FROM #fc_105
    UNION ALL
    SELECT 'NOTE_RESEARCH_LINK_HX' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_106
    UNION ALL
    SELECT 'NOTE_RESEARCH_LINK_HX' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_106
    UNION ALL
    SELECT 'NOTE_RESEARCH_LINK_HX' AS table_name, 'HX_RESEARCH_ID_RESEARCH_STUDY_NAME' AS column_name, activity_year, total_rows, HX_RESEARCH_ID_RESEARCH_STUDY_NAME_filled AS filled_count FROM #fc_106
    UNION ALL
    SELECT 'NOTE_RESEARCH_LINK_HX' AS table_name, 'HX_ENROLL_ID' AS column_name, activity_year, total_rows, HX_ENROLL_ID_filled AS filled_count FROM #fc_106
    UNION ALL
    SELECT 'NOTE_RESEARCH_LINK_HX' AS table_name, 'HX_STUDY_LINK_UTC_DTTM' AS column_name, activity_year, total_rows, HX_STUDY_LINK_UTC_DTTM_filled AS filled_count FROM #fc_106
    UNION ALL
    SELECT 'NOTE_RESEARCH_LINK_HX' AS table_name, 'HX_STUDY_USER_ID' AS column_name, activity_year, total_rows, HX_STUDY_USER_ID_filled AS filled_count FROM #fc_106
    UNION ALL
    SELECT 'NOTE_RESEARCH_LINK_HX' AS table_name, 'HX_STUDY_USER_ID_NAME' AS column_name, activity_year, total_rows, HX_STUDY_USER_ID_NAME_filled AS filled_count FROM #fc_106
    UNION ALL
    SELECT 'NOTE_SMARTBLOCK_ATTR' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_107
    UNION ALL
    SELECT 'NOTE_SMARTBLOCK_ATTR' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_107
    UNION ALL
    SELECT 'NOTE_SMARTBLOCK_ATTR' AS table_name, 'USER_ID' AS column_name, activity_year, total_rows, USER_ID_filled AS filled_count FROM #fc_107
    UNION ALL
    SELECT 'NOTE_SMARTBLOCK_ATTR' AS table_name, 'USER_ID_NAME' AS column_name, activity_year, total_rows, USER_ID_NAME_filled AS filled_count FROM #fc_107
    UNION ALL
    SELECT 'NOTE_SMARTBLOCK_ATTR' AS table_name, 'ATTRIBUTION_UTC_DTTM' AS column_name, activity_year, total_rows, ATTRIBUTION_UTC_DTTM_filled AS filled_count FROM #fc_107
    UNION ALL
    SELECT 'NOTE_SMARTBLOCK_ATTR' AS table_name, 'SB_COPY_CSN' AS column_name, activity_year, total_rows, SB_COPY_CSN_filled AS filled_count FROM #fc_107
    UNION ALL
    SELECT 'NOTE_SMARTSECTION_IDS' AS table_name, 'NOTE_CSN_ID' AS column_name, activity_year, total_rows, NOTE_CSN_ID_filled AS filled_count FROM #fc_108
    UNION ALL
    SELECT 'NOTE_SMARTSECTION_IDS' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_108
    UNION ALL
    SELECT 'NOTE_SMARTSECTION_IDS' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_108
    UNION ALL
    SELECT 'NOTE_SMARTSECTION_IDS' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_108
    UNION ALL
    SELECT 'ORDER_ADDENDUM_NOTE' AS table_name, 'ORDER_ID' AS column_name, activity_year, total_rows, ORDER_ID_filled AS filled_count FROM #fc_109
    UNION ALL
    SELECT 'ORDER_ADDENDUM_NOTE' AS table_name, 'CONTACT_DATE_REAL' AS column_name, activity_year, total_rows, CONTACT_DATE_REAL_filled AS filled_count FROM #fc_109
    UNION ALL
    SELECT 'ORDER_ADDENDUM_NOTE' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_109
    UNION ALL
    SELECT 'ORDER_ADDENDUM_NOTE' AS table_name, 'ADDENDUM_NOTE_ID' AS column_name, activity_year, total_rows, ADDENDUM_NOTE_ID_filled AS filled_count FROM #fc_109
    UNION ALL
    SELECT 'ORDER_DOCUMENTS' AS table_name, 'ORDER_ID' AS column_name, activity_year, total_rows, ORDER_ID_filled AS filled_count FROM #fc_110
    UNION ALL
    SELECT 'ORDER_DOCUMENTS' AS table_name, 'CONTACT_DATE_REAL' AS column_name, activity_year, total_rows, CONTACT_DATE_REAL_filled AS filled_count FROM #fc_110
    UNION ALL
    SELECT 'ORDER_DOCUMENTS' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_110
    UNION ALL
    SELECT 'ORDER_DOCUMENTS' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_110
    UNION ALL
    SELECT 'ORDER_RAD_DICTATE' AS table_name, 'ORDER_PROC_ID' AS column_name, activity_year, total_rows, ORDER_PROC_ID_filled AS filled_count FROM #fc_111
    UNION ALL
    SELECT 'ORDER_RAD_DICTATE' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_111
    UNION ALL
    SELECT 'ORDER_RAD_DICTATE' AS table_name, 'PROV_ID_PROV_NAME' AS column_name, activity_year, total_rows, PROV_ID_PROV_NAME_filled AS filled_count FROM #fc_111
    UNION ALL
    SELECT 'ORDER_RAD_DICTATE' AS table_name, 'DICTATING_DT' AS column_name, activity_year, total_rows, DICTATING_DT_filled AS filled_count FROM #fc_111
    UNION ALL
    SELECT 'ORDER_RAD_DICTATE' AS table_name, 'DICTATED_UTC_DTTM' AS column_name, activity_year, total_rows, DICTATED_UTC_DTTM_filled AS filled_count FROM #fc_111
    UNION ALL
    SELECT 'ORDER_RESULT_DOCUMENTS' AS table_name, 'ORDER_ID' AS column_name, activity_year, total_rows, ORDER_ID_filled AS filled_count FROM #fc_112
    UNION ALL
    SELECT 'ORDER_RESULT_DOCUMENTS' AS table_name, 'CONTACT_DATE_REAL' AS column_name, activity_year, total_rows, CONTACT_DATE_REAL_filled AS filled_count FROM #fc_112
    UNION ALL
    SELECT 'ORDER_RESULT_DOCUMENTS' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_112
    UNION ALL
    SELECT 'ORDER_RESULT_DOCUMENTS' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_112
    UNION ALL
    SELECT 'ORDER_RESULT_DOCUMENTS' AS table_name, 'RESULT_DOCUMENT_ID' AS column_name, activity_year, total_rows, RESULT_DOCUMENT_ID_filled AS filled_count FROM #fc_112
    UNION ALL
    SELECT 'ORDER_SMARTSECTION_DATA' AS table_name, 'ORDER_ID' AS column_name, activity_year, total_rows, ORDER_ID_filled AS filled_count FROM #fc_113
    UNION ALL
    SELECT 'ORDER_SMARTSECTION_DATA' AS table_name, 'CONTACT_DATE_REAL' AS column_name, activity_year, total_rows, CONTACT_DATE_REAL_filled AS filled_count FROM #fc_113
    UNION ALL
    SELECT 'ORDER_SMARTSECTION_DATA' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_113
    UNION ALL
    SELECT 'ORDER_SMARTSECTION_DATA' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_113
    UNION ALL
    SELECT 'ORDER_SMARTSECTION_DATA' AS table_name, 'ORDER_SMARTSECTION_C_NAME' AS column_name, activity_year, total_rows, ORDER_SMARTSECTION_C_NAME_filled AS filled_count FROM #fc_113
    UNION ALL
    SELECT 'ORDER_SMARTSECTION_HNO' AS table_name, 'ORDER_ID' AS column_name, activity_year, total_rows, ORDER_ID_filled AS filled_count FROM #fc_114
    UNION ALL
    SELECT 'ORDER_SMARTSECTION_HNO' AS table_name, 'CONTACT_DATE_REAL' AS column_name, activity_year, total_rows, CONTACT_DATE_REAL_filled AS filled_count FROM #fc_114
    UNION ALL
    SELECT 'ORDER_SMARTSECTION_HNO' AS table_name, 'GROUP_LINE' AS column_name, activity_year, total_rows, GROUP_LINE_filled AS filled_count FROM #fc_114
    UNION ALL
    SELECT 'ORDER_SMARTSECTION_HNO' AS table_name, 'VALUE_LINE' AS column_name, activity_year, total_rows, VALUE_LINE_filled AS filled_count FROM #fc_114
    UNION ALL
    SELECT 'ORDER_SMARTSECTION_HNO' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_114
    UNION ALL
    SELECT 'ORDER_SMARTSECTION_TEXT' AS table_name, 'ORDER_ID' AS column_name, activity_year, total_rows, ORDER_ID_filled AS filled_count FROM #fc_115
    UNION ALL
    SELECT 'ORDER_SMARTSECTION_TEXT' AS table_name, 'CONTACT_DATE_REAL' AS column_name, activity_year, total_rows, CONTACT_DATE_REAL_filled AS filled_count FROM #fc_115
    UNION ALL
    SELECT 'ORDER_SMARTSECTION_TEXT' AS table_name, 'GROUP_LINE' AS column_name, activity_year, total_rows, GROUP_LINE_filled AS filled_count FROM #fc_115
    UNION ALL
    SELECT 'ORDER_SMARTSECTION_TEXT' AS table_name, 'VALUE_LINE' AS column_name, activity_year, total_rows, VALUE_LINE_filled AS filled_count FROM #fc_115
    UNION ALL
    SELECT 'ORDER_SMARTSECTION_TEXT' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_115
    UNION ALL
    SELECT 'ORDER_SMARTSECTION_TEXT' AS table_name, 'SMARTSECTION_TEXT' AS column_name, activity_year, total_rows, SMARTSECTION_TEXT_filled AS filled_count FROM #fc_115
    UNION ALL
    SELECT 'ORD_LAST_ADDENDUM_INFO' AS table_name, 'ORDER_ID' AS column_name, activity_year, total_rows, ORDER_ID_filled AS filled_count FROM #fc_116
    UNION ALL
    SELECT 'ORD_LAST_ADDENDUM_INFO' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_116
    UNION ALL
    SELECT 'ORD_LAST_ADDENDUM_INFO' AS table_name, 'LAST_ADD_PROV_ID_PROV_NAME' AS column_name, activity_year, total_rows, LAST_ADD_PROV_ID_PROV_NAME_filled AS filled_count FROM #fc_116
    UNION ALL
    SELECT 'ORTHO_TREAT_NOTE' AS table_name, 'TREATMENT_PLAN_ID' AS column_name, activity_year, total_rows, TREATMENT_PLAN_ID_filled AS filled_count FROM #fc_117
    UNION ALL
    SELECT 'ORTHO_TREAT_NOTE' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_117
    UNION ALL
    SELECT 'ORTHO_TREAT_NOTE' AS table_name, 'NOTE' AS column_name, activity_year, total_rows, NOTE_filled AS filled_count FROM #fc_117
    UNION ALL
    SELECT 'OR_LOG_POSTOP_NOTE' AS table_name, 'LOG_ID' AS column_name, activity_year, total_rows, LOG_ID_filled AS filled_count FROM #fc_118
    UNION ALL
    SELECT 'OR_LOG_POSTOP_NOTE' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_118
    UNION ALL
    SELECT 'OR_LOG_POSTOP_NOTE' AS table_name, 'POSTOP_NOTES_ID' AS column_name, activity_year, total_rows, POSTOP_NOTES_ID_filled AS filled_count FROM #fc_118
    UNION ALL
    SELECT 'OUTREACH_ESIG_DOCUMENTS' AS table_name, 'ACTIVITY_ID' AS column_name, activity_year, total_rows, ACTIVITY_ID_filled AS filled_count FROM #fc_119
    UNION ALL
    SELECT 'OUTREACH_ESIG_DOCUMENTS' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_119
    UNION ALL
    SELECT 'OUTREACH_ESIG_DOCUMENTS' AS table_name, 'ESIG_DOCUMENT_ID' AS column_name, activity_year, total_rows, ESIG_DOCUMENT_ID_filled AS filled_count FROM #fc_119
    UNION ALL
    SELECT 'OUTREACH_ESIG_DOCUMENTS' AS table_name, 'ESIG_REL_ORDER_ID' AS column_name, activity_year, total_rows, ESIG_REL_ORDER_ID_filled AS filled_count FROM #fc_119
    UNION ALL
    SELECT 'OUTREACH_ESIG_DOCUMENTS' AS table_name, 'ESIG_DOC_SEND_DATE' AS column_name, activity_year, total_rows, ESIG_DOC_SEND_DATE_filled AS filled_count FROM #fc_119
    UNION ALL
    SELECT 'PAT_ADDENDUM_INFO' AS table_name, 'PAT_ENC_DATE_REAL' AS column_name, activity_year, total_rows, PAT_ENC_DATE_REAL_filled AS filled_count FROM #fc_120
    UNION ALL
    SELECT 'PAT_ADDENDUM_INFO' AS table_name, 'PAT_ENC_CSN_ID' AS column_name, activity_year, total_rows, PAT_ENC_CSN_ID_filled AS filled_count FROM #fc_120
    UNION ALL
    SELECT 'PAT_ADDENDUM_INFO' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_120
    UNION ALL
    SELECT 'PAT_ADDENDUM_INFO' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_120
    UNION ALL
    SELECT 'PAT_ADDENDUM_INFO' AS table_name, 'ADDENDUM_DATE_TIME' AS column_name, activity_year, total_rows, ADDENDUM_DATE_TIME_filled AS filled_count FROM #fc_120
    UNION ALL
    SELECT 'PAT_ADDENDUM_INFO' AS table_name, 'ADDENDUM_USER_ID' AS column_name, activity_year, total_rows, ADDENDUM_USER_ID_filled AS filled_count FROM #fc_120
    UNION ALL
    SELECT 'PAT_ADDENDUM_INFO' AS table_name, 'ADDENDUM_USER_ID_NAME' AS column_name, activity_year, total_rows, ADDENDUM_USER_ID_NAME_filled AS filled_count FROM #fc_120
    UNION ALL
    SELECT 'PAT_ADDENDUM_INFO' AS table_name, 'ADDENDUM_STARTED_UTC_DTTM' AS column_name, activity_year, total_rows, ADDENDUM_STARTED_UTC_DTTM_filled AS filled_count FROM #fc_120
    UNION ALL
    SELECT 'PAT_ADDENDUM_INFO' AS table_name, 'ADDENDUM_STARTED_USER_ID' AS column_name, activity_year, total_rows, ADDENDUM_STARTED_USER_ID_filled AS filled_count FROM #fc_120
    UNION ALL
    SELECT 'PAT_ADDENDUM_INFO' AS table_name, 'ADDENDUM_STARTED_USER_ID_NAME' AS column_name, activity_year, total_rows, ADDENDUM_STARTED_USER_ID_NAME_filled AS filled_count FROM #fc_120
    UNION ALL
    SELECT 'PAT_ADDENDUM_INFO' AS table_name, 'SOURCE_WORKFLOW_C_NAME' AS column_name, activity_year, total_rows, SOURCE_WORKFLOW_C_NAME_filled AS filled_count FROM #fc_120
    UNION ALL
    SELECT 'PAT_ADDENDUM_INFO' AS table_name, 'ADDENDUM_OPEN_YN' AS column_name, activity_year, total_rows, ADDENDUM_OPEN_YN_filled AS filled_count FROM #fc_120
    UNION ALL
    SELECT 'PAT_DT_STICKY_NOTE_INFO' AS table_name, 'PAT_ID' AS column_name, activity_year, total_rows, PAT_ID_filled AS filled_count FROM #fc_121
    UNION ALL
    SELECT 'PAT_DT_STICKY_NOTE_INFO' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_121
    UNION ALL
    SELECT 'PAT_DT_STICKY_NOTE_INFO' AS table_name, 'DT_STICKY_NOTE_DATE' AS column_name, activity_year, total_rows, DT_STICKY_NOTE_DATE_filled AS filled_count FROM #fc_121
    UNION ALL
    SELECT 'PAT_DT_STICKY_NOTE_INFO' AS table_name, 'DT_STICKY_NOTE_ID' AS column_name, activity_year, total_rows, DT_STICKY_NOTE_ID_filled AS filled_count FROM #fc_121
    UNION ALL
    SELECT 'PAT_ENC_AMBIENT_SESSIONS' AS table_name, 'PAT_ENC_CSN_ID' AS column_name, activity_year, total_rows, PAT_ENC_CSN_ID_filled AS filled_count FROM #fc_122
    UNION ALL
    SELECT 'PAT_ENC_AMBIENT_SESSIONS' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_122
    UNION ALL
    SELECT 'PAT_ENC_AMBIENT_SESSIONS' AS table_name, 'PAT_ID' AS column_name, activity_year, total_rows, PAT_ID_filled AS filled_count FROM #fc_122
    UNION ALL
    SELECT 'PAT_ENC_AMBIENT_SESSIONS' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_122
    UNION ALL
    SELECT 'PAT_ENC_AMBIENT_SESSIONS' AS table_name, 'CM_CT_OWNER_ID' AS column_name, activity_year, total_rows, CM_CT_OWNER_ID_filled AS filled_count FROM #fc_122
    UNION ALL
    SELECT 'PAT_ENC_AMBIENT_SESSIONS' AS table_name, 'AMBIENT_SESSION_IDENT' AS column_name, activity_year, total_rows, AMBIENT_SESSION_IDENT_filled AS filled_count FROM #fc_122
    UNION ALL
    SELECT 'PAT_ENC_CHKOUT_NOTE' AS table_name, 'PAT_ENC_CSN_ID' AS column_name, activity_year, total_rows, PAT_ENC_CSN_ID_filled AS filled_count FROM #fc_123
    UNION ALL
    SELECT 'PAT_ENC_CHKOUT_NOTE' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_123
    UNION ALL
    SELECT 'PAT_ENC_CHKOUT_NOTE' AS table_name, 'CHKOUT_NOTE' AS column_name, activity_year, total_rows, CHKOUT_NOTE_filled AS filled_count FROM #fc_123
    UNION ALL
    SELECT 'PAT_ENC_PREPAYNOTE' AS table_name, 'PAT_ENC_CSN_ID' AS column_name, activity_year, total_rows, PAT_ENC_CSN_ID_filled AS filled_count FROM #fc_124
    UNION ALL
    SELECT 'PAT_ENC_PREPAYNOTE' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_124
    UNION ALL
    SELECT 'PAT_ENC_PREPAYNOTE' AS table_name, 'PAT_ENC_DATE_REAL' AS column_name, activity_year, total_rows, PAT_ENC_DATE_REAL_filled AS filled_count FROM #fc_124
    UNION ALL
    SELECT 'PAT_ENC_PREPAYNOTE' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_124
    UNION ALL
    SELECT 'PAT_ENC_PREPAYNOTE' AS table_name, 'PREPAY_NOTES' AS column_name, activity_year, total_rows, PREPAY_NOTES_filled AS filled_count FROM #fc_124
    UNION ALL
    SELECT 'PB_COLL_HX_NOTE_TBL' AS table_name, 'PB_ACCT_ID' AS column_name, activity_year, total_rows, PB_ACCT_ID_filled AS filled_count FROM #fc_125
    UNION ALL
    SELECT 'PB_COLL_HX_NOTE_TBL' AS table_name, 'GROUP_LINE' AS column_name, activity_year, total_rows, GROUP_LINE_filled AS filled_count FROM #fc_125
    UNION ALL
    SELECT 'PB_COLL_HX_NOTE_TBL' AS table_name, 'VALUE_LINE' AS column_name, activity_year, total_rows, VALUE_LINE_filled AS filled_count FROM #fc_125
    UNION ALL
    SELECT 'PB_COLL_HX_NOTE_TBL' AS table_name, 'PB_COLL_NOTE_ID' AS column_name, activity_year, total_rows, PB_COLL_NOTE_ID_filled AS filled_count FROM #fc_125
    UNION ALL
    SELECT 'PROBLEM_DIS_STAT_NOTE_HX' AS table_name, 'PROBLEM_LIST_ID' AS column_name, activity_year, total_rows, PROBLEM_LIST_ID_filled AS filled_count FROM #fc_126
    UNION ALL
    SELECT 'PROBLEM_DIS_STAT_NOTE_HX' AS table_name, 'GROUP_LINE' AS column_name, activity_year, total_rows, GROUP_LINE_filled AS filled_count FROM #fc_126
    UNION ALL
    SELECT 'PROBLEM_DIS_STAT_NOTE_HX' AS table_name, 'VALUE_LINE' AS column_name, activity_year, total_rows, VALUE_LINE_filled AS filled_count FROM #fc_126
    UNION ALL
    SELECT 'PROBLEM_DIS_STAT_NOTE_HX' AS table_name, 'HX_DISEASE_STATUS_NOTE_ID' AS column_name, activity_year, total_rows, HX_DISEASE_STATUS_NOTE_ID_filled AS filled_count FROM #fc_126
    UNION ALL
    SELECT 'PROBLEM_NOTE_PROPS' AS table_name, 'PROBLEM_LIST_ID' AS column_name, activity_year, total_rows, PROBLEM_LIST_ID_filled AS filled_count FROM #fc_127
    UNION ALL
    SELECT 'PROBLEM_NOTE_PROPS' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_127
    UNION ALL
    SELECT 'PROBLEM_NOTE_PROPS' AS table_name, 'GENERATED_NOTE_ID' AS column_name, activity_year, total_rows, GENERATED_NOTE_ID_filled AS filled_count FROM #fc_127
    UNION ALL
    SELECT 'PROBLEM_NOTE_PROPS' AS table_name, 'AP_NOTE_SERVICE_C_NAME' AS column_name, activity_year, total_rows, AP_NOTE_SERVICE_C_NAME_filled AS filled_count FROM #fc_127
    UNION ALL
    SELECT 'QRY_EVIDENCE_NOTE_CSN_ID' AS table_name, 'QUERY_ID' AS column_name, activity_year, total_rows, QUERY_ID_filled AS filled_count FROM #fc_128
    UNION ALL
    SELECT 'QRY_EVIDENCE_NOTE_CSN_ID' AS table_name, 'GROUP_LINE' AS column_name, activity_year, total_rows, GROUP_LINE_filled AS filled_count FROM #fc_128
    UNION ALL
    SELECT 'QRY_EVIDENCE_NOTE_CSN_ID' AS table_name, 'VALUE_LINE' AS column_name, activity_year, total_rows, VALUE_LINE_filled AS filled_count FROM #fc_128
    UNION ALL
    SELECT 'QRY_EVIDENCE_NOTE_CSN_ID' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_128
    UNION ALL
    SELECT 'QRY_EVIDENCE_NOTE_CSN_ID' AS table_name, 'EVIDENCE_NOTE_CSN_ID' AS column_name, activity_year, total_rows, EVIDENCE_NOTE_CSN_ID_filled AS filled_count FROM #fc_128
    UNION ALL
    SELECT 'QRY_EVIDENCE_NOTE_CSN_ID' AS table_name, 'QUERY_CSN_ID' AS column_name, activity_year, total_rows, QUERY_CSN_ID_filled AS filled_count FROM #fc_128
    UNION ALL
    SELECT 'QRY_EVIDENCE_NOTE_IDS' AS table_name, 'QUERY_ID' AS column_name, activity_year, total_rows, QUERY_ID_filled AS filled_count FROM #fc_129
    UNION ALL
    SELECT 'QRY_EVIDENCE_NOTE_IDS' AS table_name, 'GROUP_LINE' AS column_name, activity_year, total_rows, GROUP_LINE_filled AS filled_count FROM #fc_129
    UNION ALL
    SELECT 'QRY_EVIDENCE_NOTE_IDS' AS table_name, 'VALUE_LINE' AS column_name, activity_year, total_rows, VALUE_LINE_filled AS filled_count FROM #fc_129
    UNION ALL
    SELECT 'QRY_EVIDENCE_NOTE_IDS' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_129
    UNION ALL
    SELECT 'QRY_EVIDENCE_NOTE_IDS' AS table_name, 'EVIDENCE_NOTE_ID' AS column_name, activity_year, total_rows, EVIDENCE_NOTE_ID_filled AS filled_count FROM #fc_129
    UNION ALL
    SELECT 'QRY_EVIDENCE_NOTE_IDS' AS table_name, 'QUERY_CSN_ID' AS column_name, activity_year, total_rows, QUERY_CSN_ID_filled AS filled_count FROM #fc_129
    UNION ALL
    SELECT 'QRY_RESP_NOTE_HX' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_130
    UNION ALL
    SELECT 'QRY_RESP_NOTE_HX' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_130
    UNION ALL
    SELECT 'QRY_RESP_NOTE_HX' AS table_name, 'QRY_RESP_HX_NOTE_ID' AS column_name, activity_year, total_rows, QRY_RESP_HX_NOTE_ID_filled AS filled_count FROM #fc_130
    UNION ALL
    SELECT 'REFERRAL_BED_DAY_UNS_NOTE' AS table_name, 'REFERRAL_ID' AS column_name, activity_year, total_rows, REFERRAL_ID_filled AS filled_count FROM #fc_131
    UNION ALL
    SELECT 'REFERRAL_BED_DAY_UNS_NOTE' AS table_name, 'GROUP_LINE' AS column_name, activity_year, total_rows, GROUP_LINE_filled AS filled_count FROM #fc_131
    UNION ALL
    SELECT 'REFERRAL_BED_DAY_UNS_NOTE' AS table_name, 'VALUE_LINE' AS column_name, activity_year, total_rows, VALUE_LINE_filled AS filled_count FROM #fc_131
    UNION ALL
    SELECT 'REFERRAL_BED_DAY_UNS_NOTE' AS table_name, 'BED_DAY_UNSIGNED_NOTE_ID' AS column_name, activity_year, total_rows, BED_DAY_UNSIGNED_NOTE_ID_filled AS filled_count FROM #fc_131
    UNION ALL
    SELECT 'REFERRAL_UM_UNSIGNED_NOTE' AS table_name, 'REFERRAL_ID' AS column_name, activity_year, total_rows, REFERRAL_ID_filled AS filled_count FROM #fc_132
    UNION ALL
    SELECT 'REFERRAL_UM_UNSIGNED_NOTE' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_132
    UNION ALL
    SELECT 'REFERRAL_UM_UNSIGNED_NOTE' AS table_name, 'UM_UNSIGNED_UCN_NOTE_ID' AS column_name, activity_year, total_rows, UM_UNSIGNED_UCN_NOTE_ID_filled AS filled_count FROM #fc_132
    UNION ALL
    SELECT 'RES_COSIGNERS' AS table_name, 'RESULT_ID' AS column_name, activity_year, total_rows, RESULT_ID_filled AS filled_count FROM #fc_133
    UNION ALL
    SELECT 'RES_COSIGNERS' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_133
    UNION ALL
    SELECT 'RES_COSIGNERS' AS table_name, 'COSIGNER_ID' AS column_name, activity_year, total_rows, COSIGNER_ID_filled AS filled_count FROM #fc_133
    UNION ALL
    SELECT 'RES_COSIGNERS' AS table_name, 'COSIGNER_ID_NAME' AS column_name, activity_year, total_rows, COSIGNER_ID_NAME_filled AS filled_count FROM #fc_133
    UNION ALL
    SELECT 'RES_SMARTTEXT_RSLT' AS table_name, 'RESULT_ID' AS column_name, activity_year, total_rows, RESULT_ID_filled AS filled_count FROM #fc_134
    UNION ALL
    SELECT 'RES_SMARTTEXT_RSLT' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_134
    UNION ALL
    SELECT 'RES_SMARTTEXT_RSLT' AS table_name, 'MULTI_LN_STR_RESULT' AS column_name, activity_year, total_rows, MULTI_LN_STR_RESULT_filled AS filled_count FROM #fc_134
    UNION ALL
    SELECT 'RXFILL_NOTE' AS table_name, 'MED_PRBLM_LIST_ID' AS column_name, activity_year, total_rows, MED_PRBLM_LIST_ID_filled AS filled_count FROM #fc_135
    UNION ALL
    SELECT 'RXFILL_NOTE' AS table_name, 'GROUP_LINE' AS column_name, activity_year, total_rows, GROUP_LINE_filled AS filled_count FROM #fc_135
    UNION ALL
    SELECT 'RXFILL_NOTE' AS table_name, 'VALUE_LINE' AS column_name, activity_year, total_rows, VALUE_LINE_filled AS filled_count FROM #fc_135
    UNION ALL
    SELECT 'RXFILL_NOTE' AS table_name, 'RXFILL_NOTE' AS column_name, activity_year, total_rows, RXFILL_NOTE_filled AS filled_count FROM #fc_135
    UNION ALL
    SELECT 'SMARTFORMS_ACCESSED' AS table_name, 'PAT_ENC_CSN_ID' AS column_name, activity_year, total_rows, PAT_ENC_CSN_ID_filled AS filled_count FROM #fc_136
    UNION ALL
    SELECT 'SMARTFORMS_ACCESSED' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_136
    UNION ALL
    SELECT 'SMARTFORMS_ACCESSED' AS table_name, 'PAT_ID' AS column_name, activity_year, total_rows, PAT_ID_filled AS filled_count FROM #fc_136
    UNION ALL
    SELECT 'SMARTFORMS_ACCESSED' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_136
    UNION ALL
    SELECT 'SMARTFORMS_ACCESSED' AS table_name, 'CM_CT_OWNER_ID' AS column_name, activity_year, total_rows, CM_CT_OWNER_ID_filled AS filled_count FROM #fc_136
    UNION ALL
    SELECT 'SMARTFORM_METADATA' AS table_name, 'PAT_ENC_CSN_ID' AS column_name, activity_year, total_rows, PAT_ENC_CSN_ID_filled AS filled_count FROM #fc_137
    UNION ALL
    SELECT 'SMARTFORM_METADATA' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_137
    UNION ALL
    SELECT 'SMARTFORM_METADATA' AS table_name, 'PAT_ID' AS column_name, activity_year, total_rows, PAT_ID_filled AS filled_count FROM #fc_137
    UNION ALL
    SELECT 'SMARTFORM_METADATA' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_137
    UNION ALL
    SELECT 'SMARTFORM_METADATA' AS table_name, 'CM_CT_OWNER_ID' AS column_name, activity_year, total_rows, CM_CT_OWNER_ID_filled AS filled_count FROM #fc_137
    UNION ALL
    SELECT 'SMARTTEXT' AS table_name, 'SMARTTEXT_ID' AS column_name, activity_year, total_rows, SMARTTEXT_ID_filled AS filled_count FROM #fc_138
    UNION ALL
    SELECT 'SMARTTEXT' AS table_name, 'SMARTTEXT_NAME' AS column_name, activity_year, total_rows, SMARTTEXT_NAME_filled AS filled_count FROM #fc_138
    UNION ALL
    SELECT 'SMRTDTA_ELEM_AIEXTRACTED' AS table_name, 'HLV_ID' AS column_name, activity_year, total_rows, HLV_ID_filled AS filled_count FROM #fc_139
    UNION ALL
    SELECT 'SMRTDTA_ELEM_AIEXTRACTED' AS table_name, 'ELEMENT_ID' AS column_name, activity_year, total_rows, ELEMENT_ID_filled AS filled_count FROM #fc_139
    UNION ALL
    SELECT 'SMRTDTA_ELEM_AIEXTRACTED' AS table_name, 'AI_INTRCT_ID' AS column_name, activity_year, total_rows, AI_INTRCT_ID_filled AS filled_count FROM #fc_139
    UNION ALL
    SELECT 'SMRTDTA_ELEM_AUTH' AS table_name, 'HLV_ID' AS column_name, activity_year, total_rows, HLV_ID_filled AS filled_count FROM #fc_140
    UNION ALL
    SELECT 'SMRTDTA_ELEM_AUTH' AS table_name, 'AUTH_ID' AS column_name, activity_year, total_rows, AUTH_ID_filled AS filled_count FROM #fc_140
    UNION ALL
    SELECT 'SMRTDTA_ELEM_AUTH' AS table_name, 'ELEMENT_ID' AS column_name, activity_year, total_rows, ELEMENT_ID_filled AS filled_count FROM #fc_140
    UNION ALL
    SELECT 'SMRTDTA_ELEM_BEREAVE' AS table_name, 'HLV_ID' AS column_name, activity_year, total_rows, HLV_ID_filled AS filled_count FROM #fc_141
    UNION ALL
    SELECT 'SMRTDTA_ELEM_BEREAVE' AS table_name, 'BEREAVEMENT_ID' AS column_name, activity_year, total_rows, BEREAVEMENT_ID_filled AS filled_count FROM #fc_141
    UNION ALL
    SELECT 'SMRTDTA_ELEM_BEREAVE' AS table_name, 'ELEMENT_ID' AS column_name, activity_year, total_rows, ELEMENT_ID_filled AS filled_count FROM #fc_141
    UNION ALL
    SELECT 'SMRTDTA_ELEM_CONCEPT' AS table_name, 'HLV_ID' AS column_name, activity_year, total_rows, HLV_ID_filled AS filled_count FROM #fc_142
    UNION ALL
    SELECT 'SMRTDTA_ELEM_CONCEPT' AS table_name, 'PARENT_HLV_ID' AS column_name, activity_year, total_rows, PARENT_HLV_ID_filled AS filled_count FROM #fc_142
    UNION ALL
    SELECT 'SMRTDTA_ELEM_CONCEPT' AS table_name, 'PAT_ID' AS column_name, activity_year, total_rows, PAT_ID_filled AS filled_count FROM #fc_142
    UNION ALL
    SELECT 'SMRTDTA_ELEM_CONCEPT' AS table_name, 'ELEMENT_ID' AS column_name, activity_year, total_rows, ELEMENT_ID_filled AS filled_count FROM #fc_142
    UNION ALL
    SELECT 'SMRTDTA_ELEM_CUST_SERVICE' AS table_name, 'HLV_ID' AS column_name, activity_year, total_rows, HLV_ID_filled AS filled_count FROM #fc_143
    UNION ALL
    SELECT 'SMRTDTA_ELEM_CUST_SERVICE' AS table_name, 'COMM_ID' AS column_name, activity_year, total_rows, COMM_ID_filled AS filled_count FROM #fc_143
    UNION ALL
    SELECT 'SMRTDTA_ELEM_CUST_SERVICE' AS table_name, 'ELEMENT_ID' AS column_name, activity_year, total_rows, ELEMENT_ID_filled AS filled_count FROM #fc_143
    UNION ALL
    SELECT 'SMRTDTA_ELEM_CUST_SERVICE' AS table_name, 'CUR_VALUE_DATETIME' AS column_name, activity_year, total_rows, CUR_VALUE_DATETIME_filled AS filled_count FROM #fc_143
    UNION ALL
    SELECT 'SMRTDTA_ELEM_DATA' AS table_name, 'HLV_ID' AS column_name, activity_year, total_rows, HLV_ID_filled AS filled_count FROM #fc_144
    UNION ALL
    SELECT 'SMRTDTA_ELEM_DATA' AS table_name, 'ELEMENT_ID' AS column_name, activity_year, total_rows, ELEMENT_ID_filled AS filled_count FROM #fc_144
    UNION ALL
    SELECT 'SMRTDTA_ELEM_DATA' AS table_name, 'CUR_VALUE_DATETIME' AS column_name, activity_year, total_rows, CUR_VALUE_DATETIME_filled AS filled_count FROM #fc_144
    UNION ALL
    SELECT 'SMRTDTA_ELEM_DATA' AS table_name, 'CUR_VALUE_USER_ID' AS column_name, activity_year, total_rows, CUR_VALUE_USER_ID_filled AS filled_count FROM #fc_144
    UNION ALL
    SELECT 'SMRTDTA_ELEM_DATA' AS table_name, 'CUR_VALUE_USER_ID_NAME' AS column_name, activity_year, total_rows, CUR_VALUE_USER_ID_NAME_filled AS filled_count FROM #fc_144
    UNION ALL
    SELECT 'SMRTDTA_ELEM_DATA' AS table_name, 'CONTEXT_NAME' AS column_name, activity_year, total_rows, CONTEXT_NAME_filled AS filled_count FROM #fc_144
    UNION ALL
    SELECT 'SMRTDTA_ELEM_DATA' AS table_name, 'CONTACT_SERIAL_NUM' AS column_name, activity_year, total_rows, CONTACT_SERIAL_NUM_filled AS filled_count FROM #fc_144
    UNION ALL
    SELECT 'SMRTDTA_ELEM_DATA' AS table_name, 'RECORD_ID_VARCHAR' AS column_name, activity_year, total_rows, RECORD_ID_VARCHAR_filled AS filled_count FROM #fc_144
    UNION ALL
    SELECT 'SMRTDTA_ELEM_DATA' AS table_name, 'PAT_LINK_ID' AS column_name, activity_year, total_rows, PAT_LINK_ID_filled AS filled_count FROM #fc_144
    UNION ALL
    SELECT 'SMRTDTA_ELEM_DATA' AS table_name, 'SRC_NOTE_ID' AS column_name, activity_year, total_rows, SRC_NOTE_ID_filled AS filled_count FROM #fc_144
    UNION ALL
    SELECT 'SMRTDTA_ELEM_DATA' AS table_name, 'SRC_NOTE_STATUS_C_NAME' AS column_name, activity_year, total_rows, SRC_NOTE_STATUS_C_NAME_filled AS filled_count FROM #fc_144
    UNION ALL
    SELECT 'SMRTDTA_ELEM_DATA' AS table_name, 'CUR_VAL_UTC_DTTM' AS column_name, activity_year, total_rows, CUR_VAL_UTC_DTTM_filled AS filled_count FROM #fc_144
    UNION ALL
    SELECT 'SMRTDTA_ELEM_DATA' AS table_name, 'SET_BY_C_NAME' AS column_name, activity_year, total_rows, SET_BY_C_NAME_filled AS filled_count FROM #fc_144
    UNION ALL
    SELECT 'SMRTDTA_ELEM_DATA' AS table_name, 'SET_BY_USER_ID' AS column_name, activity_year, total_rows, SET_BY_USER_ID_filled AS filled_count FROM #fc_144
    UNION ALL
    SELECT 'SMRTDTA_ELEM_DATA' AS table_name, 'SET_BY_USER_ID_NAME' AS column_name, activity_year, total_rows, SET_BY_USER_ID_NAME_filled AS filled_count FROM #fc_144
    UNION ALL
    SELECT 'SMRTDTA_ELEM_DATASET' AS table_name, 'HLV_ID' AS column_name, activity_year, total_rows, HLV_ID_filled AS filled_count FROM #fc_145
    UNION ALL
    SELECT 'SMRTDTA_ELEM_DATASET' AS table_name, 'DATASET_ID' AS column_name, activity_year, total_rows, DATASET_ID_filled AS filled_count FROM #fc_145
    UNION ALL
    SELECT 'SMRTDTA_ELEM_DATASET' AS table_name, 'ELEMENT_ID' AS column_name, activity_year, total_rows, ELEMENT_ID_filled AS filled_count FROM #fc_145
    UNION ALL
    SELECT 'SMRTDTA_ELEM_DEFICIENCY' AS table_name, 'HLV_ID' AS column_name, activity_year, total_rows, HLV_ID_filled AS filled_count FROM #fc_146
    UNION ALL
    SELECT 'SMRTDTA_ELEM_DEFICIENCY' AS table_name, 'ELEMENT_ID' AS column_name, activity_year, total_rows, ELEMENT_ID_filled AS filled_count FROM #fc_146
    UNION ALL
    SELECT 'SMRTDTA_ELEM_DEFICIENCY' AS table_name, 'DFI_ID' AS column_name, activity_year, total_rows, DFI_ID_filled AS filled_count FROM #fc_146
    UNION ALL
    SELECT 'SMRTDTA_ELEM_DOCUMENT' AS table_name, 'HLV_ID' AS column_name, activity_year, total_rows, HLV_ID_filled AS filled_count FROM #fc_147
    UNION ALL
    SELECT 'SMRTDTA_ELEM_DOCUMENT' AS table_name, 'DOCUMENT_ID' AS column_name, activity_year, total_rows, DOCUMENT_ID_filled AS filled_count FROM #fc_147
    UNION ALL
    SELECT 'SMRTDTA_ELEM_DOCUMENT' AS table_name, 'ELEMENT_ID' AS column_name, activity_year, total_rows, ELEMENT_ID_filled AS filled_count FROM #fc_147
    UNION ALL
    SELECT 'SMRTDTA_ELEM_DONOR' AS table_name, 'HLV_ID' AS column_name, activity_year, total_rows, HLV_ID_filled AS filled_count FROM #fc_148
    UNION ALL
    SELECT 'SMRTDTA_ELEM_DONOR' AS table_name, 'DONOR_RECORD_ID' AS column_name, activity_year, total_rows, DONOR_RECORD_ID_filled AS filled_count FROM #fc_148
    UNION ALL
    SELECT 'SMRTDTA_ELEM_DONOR' AS table_name, 'ELEMENT_ID' AS column_name, activity_year, total_rows, ELEMENT_ID_filled AS filled_count FROM #fc_148
    UNION ALL
    SELECT 'SMRTDTA_ELEM_ENCOUNTER' AS table_name, 'HLV_ID' AS column_name, activity_year, total_rows, HLV_ID_filled AS filled_count FROM #fc_149
    UNION ALL
    SELECT 'SMRTDTA_ELEM_ENCOUNTER' AS table_name, 'PAT_ENC_CSN_ID' AS column_name, activity_year, total_rows, PAT_ENC_CSN_ID_filled AS filled_count FROM #fc_149
    UNION ALL
    SELECT 'SMRTDTA_ELEM_ENCOUNTER' AS table_name, 'PAT_ID' AS column_name, activity_year, total_rows, PAT_ID_filled AS filled_count FROM #fc_149
    UNION ALL
    SELECT 'SMRTDTA_ELEM_ENCOUNTER' AS table_name, 'ELEMENT_ID' AS column_name, activity_year, total_rows, ELEMENT_ID_filled AS filled_count FROM #fc_149
    UNION ALL
    SELECT 'SMRTDTA_ELEM_EPISODE' AS table_name, 'HLV_ID' AS column_name, activity_year, total_rows, HLV_ID_filled AS filled_count FROM #fc_150
    UNION ALL
    SELECT 'SMRTDTA_ELEM_EPISODE' AS table_name, 'EPISODE_ID' AS column_name, activity_year, total_rows, EPISODE_ID_filled AS filled_count FROM #fc_150
    UNION ALL
    SELECT 'SMRTDTA_ELEM_EPISODE' AS table_name, 'ELEMENT_ID' AS column_name, activity_year, total_rows, ELEMENT_ID_filled AS filled_count FROM #fc_150
    UNION ALL
    SELECT 'SMRTDTA_ELEM_EPISODE_GRP' AS table_name, 'HLV_ID' AS column_name, activity_year, total_rows, HLV_ID_filled AS filled_count FROM #fc_151
    UNION ALL
    SELECT 'SMRTDTA_ELEM_EPISODE_GRP' AS table_name, 'EPISODE_ID' AS column_name, activity_year, total_rows, EPISODE_ID_filled AS filled_count FROM #fc_151
    UNION ALL
    SELECT 'SMRTDTA_ELEM_EPISODE_GRP' AS table_name, 'ELEMENT_ID' AS column_name, activity_year, total_rows, ELEMENT_ID_filled AS filled_count FROM #fc_151
    UNION ALL
    SELECT 'SMRTDTA_ELEM_FIN_ASST_CAS' AS table_name, 'HLV_ID' AS column_name, activity_year, total_rows, HLV_ID_filled AS filled_count FROM #fc_152
    UNION ALL
    SELECT 'SMRTDTA_ELEM_FIN_ASST_CAS' AS table_name, 'FIN_ASST_CASE_ID' AS column_name, activity_year, total_rows, FIN_ASST_CASE_ID_filled AS filled_count FROM #fc_152
    UNION ALL
    SELECT 'SMRTDTA_ELEM_FIN_ASST_CAS' AS table_name, 'ELEMENT_ID' AS column_name, activity_year, total_rows, ELEMENT_ID_filled AS filled_count FROM #fc_152
    UNION ALL
    SELECT 'SMRTDTA_ELEM_HISTORY' AS table_name, 'HLV_ID' AS column_name, activity_year, total_rows, HLV_ID_filled AS filled_count FROM #fc_153
    UNION ALL
    SELECT 'SMRTDTA_ELEM_HISTORY' AS table_name, 'PAT_ENC_CSN_ID' AS column_name, activity_year, total_rows, PAT_ENC_CSN_ID_filled AS filled_count FROM #fc_153
    UNION ALL
    SELECT 'SMRTDTA_ELEM_HISTORY' AS table_name, 'PAT_ID' AS column_name, activity_year, total_rows, PAT_ID_filled AS filled_count FROM #fc_153
    UNION ALL
    SELECT 'SMRTDTA_ELEM_HISTORY' AS table_name, 'ELEMENT_ID' AS column_name, activity_year, total_rows, ELEMENT_ID_filled AS filled_count FROM #fc_153
    UNION ALL
    SELECT 'SMRTDTA_ELEM_INFERT_CYCLE' AS table_name, 'HLV_ID' AS column_name, activity_year, total_rows, HLV_ID_filled AS filled_count FROM #fc_154
    UNION ALL
    SELECT 'SMRTDTA_ELEM_INFERT_CYCLE' AS table_name, 'CYCLE_ID' AS column_name, activity_year, total_rows, CYCLE_ID_filled AS filled_count FROM #fc_154
    UNION ALL
    SELECT 'SMRTDTA_ELEM_INFERT_CYCLE' AS table_name, 'ELEMENT_ID' AS column_name, activity_year, total_rows, ELEMENT_ID_filled AS filled_count FROM #fc_154
    UNION ALL
    SELECT 'SMRTDTA_ELEM_LAB_RESULT' AS table_name, 'HLV_ID' AS column_name, activity_year, total_rows, HLV_ID_filled AS filled_count FROM #fc_155
    UNION ALL
    SELECT 'SMRTDTA_ELEM_LAB_RESULT' AS table_name, 'ELEMENT_ID' AS column_name, activity_year, total_rows, ELEMENT_ID_filled AS filled_count FROM #fc_155
    UNION ALL
    SELECT 'SMRTDTA_ELEM_LAB_RESULT' AS table_name, 'RESULT_ID' AS column_name, activity_year, total_rows, RESULT_ID_filled AS filled_count FROM #fc_155
    UNION ALL
    SELECT 'SMRTDTA_ELEM_NOTE' AS table_name, 'HLV_ID' AS column_name, activity_year, total_rows, HLV_ID_filled AS filled_count FROM #fc_156
    UNION ALL
    SELECT 'SMRTDTA_ELEM_NOTE' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_156
    UNION ALL
    SELECT 'SMRTDTA_ELEM_NOTE' AS table_name, 'ELEMENT_ID' AS column_name, activity_year, total_rows, ELEMENT_ID_filled AS filled_count FROM #fc_156
    UNION ALL
    SELECT 'SMRTDTA_ELEM_ORDER' AS table_name, 'HLV_ID' AS column_name, activity_year, total_rows, HLV_ID_filled AS filled_count FROM #fc_157
    UNION ALL
    SELECT 'SMRTDTA_ELEM_ORDER' AS table_name, 'ORDER_ID' AS column_name, activity_year, total_rows, ORDER_ID_filled AS filled_count FROM #fc_157
    UNION ALL
    SELECT 'SMRTDTA_ELEM_ORDER' AS table_name, 'ELEMENT_ID' AS column_name, activity_year, total_rows, ELEMENT_ID_filled AS filled_count FROM #fc_157
    UNION ALL
    SELECT 'SMRTDTA_ELEM_ORGAN' AS table_name, 'HLV_ID' AS column_name, activity_year, total_rows, HLV_ID_filled AS filled_count FROM #fc_158
    UNION ALL
    SELECT 'SMRTDTA_ELEM_ORGAN' AS table_name, 'ORG_RECORD_ID' AS column_name, activity_year, total_rows, ORG_RECORD_ID_filled AS filled_count FROM #fc_158
    UNION ALL
    SELECT 'SMRTDTA_ELEM_ORGAN' AS table_name, 'ELEMENT_ID' AS column_name, activity_year, total_rows, ELEMENT_ID_filled AS filled_count FROM #fc_158
    UNION ALL
    SELECT 'SMRTDTA_ELEM_PATIENT' AS table_name, 'HLV_ID' AS column_name, activity_year, total_rows, HLV_ID_filled AS filled_count FROM #fc_159
    UNION ALL
    SELECT 'SMRTDTA_ELEM_PATIENT' AS table_name, 'PAT_ID' AS column_name, activity_year, total_rows, PAT_ID_filled AS filled_count FROM #fc_159
    UNION ALL
    SELECT 'SMRTDTA_ELEM_PATIENT' AS table_name, 'ELEMENT_ID' AS column_name, activity_year, total_rows, ELEMENT_ID_filled AS filled_count FROM #fc_159
    UNION ALL
    SELECT 'SMRTDTA_ELEM_PAT_ENTERED' AS table_name, 'HLV_ID' AS column_name, activity_year, total_rows, HLV_ID_filled AS filled_count FROM #fc_160
    UNION ALL
    SELECT 'SMRTDTA_ELEM_PAT_ENTERED' AS table_name, 'PAT_ENC_CSN_ID' AS column_name, activity_year, total_rows, PAT_ENC_CSN_ID_filled AS filled_count FROM #fc_160
    UNION ALL
    SELECT 'SMRTDTA_ELEM_PAT_ENTERED' AS table_name, 'PAT_ID' AS column_name, activity_year, total_rows, PAT_ID_filled AS filled_count FROM #fc_160
    UNION ALL
    SELECT 'SMRTDTA_ELEM_PAT_ENTERED' AS table_name, 'ELEMENT_ID' AS column_name, activity_year, total_rows, ELEMENT_ID_filled AS filled_count FROM #fc_160
    UNION ALL
    SELECT 'SMRTDTA_ELEM_PROBLEM' AS table_name, 'HLV_ID' AS column_name, activity_year, total_rows, HLV_ID_filled AS filled_count FROM #fc_161
    UNION ALL
    SELECT 'SMRTDTA_ELEM_PROBLEM' AS table_name, 'PROBLEM_LIST_ID' AS column_name, activity_year, total_rows, PROBLEM_LIST_ID_filled AS filled_count FROM #fc_161
    UNION ALL
    SELECT 'SMRTDTA_ELEM_PROBLEM' AS table_name, 'ELEMENT_ID' AS column_name, activity_year, total_rows, ELEMENT_ID_filled AS filled_count FROM #fc_161
    UNION ALL
    SELECT 'SMRTDTA_ELEM_REGISTRY' AS table_name, 'HLV_ID' AS column_name, activity_year, total_rows, HLV_ID_filled AS filled_count FROM #fc_162
    UNION ALL
    SELECT 'SMRTDTA_ELEM_REGISTRY' AS table_name, 'REGISTRY_DATA_ID' AS column_name, activity_year, total_rows, REGISTRY_DATA_ID_filled AS filled_count FROM #fc_162
    UNION ALL
    SELECT 'SMRTDTA_ELEM_REGISTRY' AS table_name, 'ELEMENT_ID' AS column_name, activity_year, total_rows, ELEMENT_ID_filled AS filled_count FROM #fc_162
    UNION ALL
    SELECT 'SMRTDTA_ELEM_RESULT' AS table_name, 'HLV_ID' AS column_name, activity_year, total_rows, HLV_ID_filled AS filled_count FROM #fc_163
    UNION ALL
    SELECT 'SMRTDTA_ELEM_RESULT' AS table_name, 'FINDING_ID' AS column_name, activity_year, total_rows, FINDING_ID_filled AS filled_count FROM #fc_163
    UNION ALL
    SELECT 'SMRTDTA_ELEM_RESULT' AS table_name, 'ELEMENT_ID' AS column_name, activity_year, total_rows, ELEMENT_ID_filled AS filled_count FROM #fc_163
    UNION ALL
    SELECT 'SMRTDTA_ELEM_RESULT_CNCT' AS table_name, 'HLV_ID' AS column_name, activity_year, total_rows, HLV_ID_filled AS filled_count FROM #fc_164
    UNION ALL
    SELECT 'SMRTDTA_ELEM_RESULT_CNCT' AS table_name, 'FINDING_CSN_ID' AS column_name, activity_year, total_rows, FINDING_CSN_ID_filled AS filled_count FROM #fc_164
    UNION ALL
    SELECT 'SMRTDTA_ELEM_RESULT_CNCT' AS table_name, 'FINDING_ID' AS column_name, activity_year, total_rows, FINDING_ID_filled AS filled_count FROM #fc_164
    UNION ALL
    SELECT 'SMRTDTA_ELEM_RESULT_CNCT' AS table_name, 'ELEMENT_ID' AS column_name, activity_year, total_rows, ELEMENT_ID_filled AS filled_count FROM #fc_164
    UNION ALL
    SELECT 'SMRTDTA_ELEM_STAGE' AS table_name, 'HLV_ID' AS column_name, activity_year, total_rows, HLV_ID_filled AS filled_count FROM #fc_165
    UNION ALL
    SELECT 'SMRTDTA_ELEM_STAGE' AS table_name, 'STAGE_ID' AS column_name, activity_year, total_rows, STAGE_ID_filled AS filled_count FROM #fc_165
    UNION ALL
    SELECT 'SMRTDTA_ELEM_STAGE' AS table_name, 'ELEMENT_ID' AS column_name, activity_year, total_rows, ELEMENT_ID_filled AS filled_count FROM #fc_165
    UNION ALL
    SELECT 'SMRTDTA_ELEM_SYNOPTIC' AS table_name, 'HLV_ID' AS column_name, activity_year, total_rows, HLV_ID_filled AS filled_count FROM #fc_166
    UNION ALL
    SELECT 'SMRTDTA_ELEM_SYNOPTIC' AS table_name, 'SYNOPTIC_ID' AS column_name, activity_year, total_rows, SYNOPTIC_ID_filled AS filled_count FROM #fc_166
    UNION ALL
    SELECT 'SMRTDTA_ELEM_SYNOPTIC' AS table_name, 'ELEMENT_ID' AS column_name, activity_year, total_rows, ELEMENT_ID_filled AS filled_count FROM #fc_166
    UNION ALL
    SELECT 'SMRTDTA_ELEM_WAITING_LST' AS table_name, 'HLV_ID' AS column_name, activity_year, total_rows, HLV_ID_filled AS filled_count FROM #fc_167
    UNION ALL
    SELECT 'SMRTDTA_ELEM_WAITING_LST' AS table_name, 'WAITING_LIST_ID' AS column_name, activity_year, total_rows, WAITING_LIST_ID_filled AS filled_count FROM #fc_167
    UNION ALL
    SELECT 'SMRTDTA_ELEM_WAITING_LST' AS table_name, 'ELEMENT_ID' AS column_name, activity_year, total_rows, ELEMENT_ID_filled AS filled_count FROM #fc_167
    UNION ALL
    SELECT 'SUBSCRIBER_ADDR_MSG' AS table_name, 'COVERAGE_ID' AS column_name, activity_year, total_rows, COVERAGE_ID_filled AS filled_count FROM #fc_168
    UNION ALL
    SELECT 'SUBSCRIBER_ADDR_MSG' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_168
    UNION ALL
    SELECT 'SUBSCRIBER_ADDR_MSG' AS table_name, 'ADDR_VALIDATION_MESSAGE' AS column_name, activity_year, total_rows, ADDR_VALIDATION_MESSAGE_filled AS filled_count FROM #fc_168
    UNION ALL
    SELECT 'TX_ADDENDUM_NOTES' AS table_name, 'NOTE_CSN_ID' AS column_name, activity_year, total_rows, NOTE_CSN_ID_filled AS filled_count FROM #fc_169
    UNION ALL
    SELECT 'TX_ADDENDUM_NOTES' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_169
    UNION ALL
    SELECT 'TX_ADDENDUM_NOTES' AS table_name, 'NOTE_ID' AS column_name, activity_year, total_rows, NOTE_ID_filled AS filled_count FROM #fc_169
    UNION ALL
    SELECT 'TX_ADDENDUM_NOTES' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count FROM #fc_169
    UNION ALL
    SELECT 'TX_ADDENDUM_NOTES' AS table_name, 'TX_ADDENDUM_NOTE_ID' AS column_name, activity_year, total_rows, TX_ADDENDUM_NOTE_ID_filled AS filled_count FROM #fc_169
    UNION ALL
    SELECT 'V_EHI_SMRTDTA_ELEM_VAL_EXT' AS table_name, 'HLV_ID' AS column_name, activity_year, total_rows, HLV_ID_filled AS filled_count FROM #fc_170
    UNION ALL
    SELECT 'V_EHI_SMRTDTA_ELEM_VAL_EXT' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count FROM #fc_170
    UNION ALL
    SELECT 'V_EHI_SMRTDTA_ELEM_VAL_EXT' AS table_name, 'SMRTDTA_ELEM_VALUE' AS column_name, activity_year, total_rows, SMRTDTA_ELEM_VALUE_filled AS filled_count FROM #fc_170
    UNION ALL
    SELECT 'V_EHI_SMRTDTA_ELEM_VAL_EXT' AS table_name, 'SMRTDTA_ELEM_VALUE_EXTERNAL' AS column_name, activity_year, total_rows, SMRTDTA_ELEM_VALUE_EXTERNAL_filled AS filled_count FROM #fc_170
    UNION ALL
    SELECT 'V_EHI_SMRTDTA_ELEM_VAL_EXT' AS table_name, 'COLUMN_DESCRIPTOR' AS column_name, activity_year, total_rows, COLUMN_DESCRIPTOR_filled AS filled_count FROM #fc_170
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
DROP TABLE #fc_078;
DROP TABLE #fc_079;
DROP TABLE #fc_080;
DROP TABLE #fc_081;
DROP TABLE #fc_082;
DROP TABLE #fc_083;
DROP TABLE #fc_084;
DROP TABLE #fc_085;
DROP TABLE #fc_086;
DROP TABLE #fc_087;
DROP TABLE #fc_088;
DROP TABLE #fc_089;
DROP TABLE #fc_090;
DROP TABLE #fc_091;
DROP TABLE #fc_092;
DROP TABLE #fc_093;
DROP TABLE #fc_094;
DROP TABLE #fc_095;
DROP TABLE #fc_096;
DROP TABLE #fc_097;
DROP TABLE #fc_098;
DROP TABLE #fc_099;
DROP TABLE #fc_100;
DROP TABLE #fc_101;
DROP TABLE #fc_102;
DROP TABLE #fc_103;
DROP TABLE #fc_104;
DROP TABLE #fc_105;
DROP TABLE #fc_106;
DROP TABLE #fc_107;
DROP TABLE #fc_108;
DROP TABLE #fc_109;
DROP TABLE #fc_110;
DROP TABLE #fc_111;
DROP TABLE #fc_112;
DROP TABLE #fc_113;
DROP TABLE #fc_114;
DROP TABLE #fc_115;
DROP TABLE #fc_116;
DROP TABLE #fc_117;
DROP TABLE #fc_118;
DROP TABLE #fc_119;
DROP TABLE #fc_120;
DROP TABLE #fc_121;
DROP TABLE #fc_122;
DROP TABLE #fc_123;
DROP TABLE #fc_124;
DROP TABLE #fc_125;
DROP TABLE #fc_126;
DROP TABLE #fc_127;
DROP TABLE #fc_128;
DROP TABLE #fc_129;
DROP TABLE #fc_130;
DROP TABLE #fc_131;
DROP TABLE #fc_132;
DROP TABLE #fc_133;
DROP TABLE #fc_134;
DROP TABLE #fc_135;
DROP TABLE #fc_136;
DROP TABLE #fc_137;
DROP TABLE #fc_138;
DROP TABLE #fc_139;
DROP TABLE #fc_140;
DROP TABLE #fc_141;
DROP TABLE #fc_142;
DROP TABLE #fc_143;
DROP TABLE #fc_144;
DROP TABLE #fc_145;
DROP TABLE #fc_146;
DROP TABLE #fc_147;
DROP TABLE #fc_148;
DROP TABLE #fc_149;
DROP TABLE #fc_150;
DROP TABLE #fc_151;
DROP TABLE #fc_152;
DROP TABLE #fc_153;
DROP TABLE #fc_154;
DROP TABLE #fc_155;
DROP TABLE #fc_156;
DROP TABLE #fc_157;
DROP TABLE #fc_158;
DROP TABLE #fc_159;
DROP TABLE #fc_160;
DROP TABLE #fc_161;
DROP TABLE #fc_162;
DROP TABLE #fc_163;
DROP TABLE #fc_164;
DROP TABLE #fc_165;
DROP TABLE #fc_166;
DROP TABLE #fc_167;
DROP TABLE #fc_168;
DROP TABLE #fc_169;
DROP TABLE #fc_170;
*/
