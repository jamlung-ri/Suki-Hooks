-- CM-04 field feasibility / density queries
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
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(PAT_ENC_DATE_REAL) AS PAT_ENC_DATE_REAL_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(ABN_DOCUMENT_ID) AS ABN_DOCUMENT_ID_filled
FROM ABN_DOCUMENT_ID
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: ABN_NOTE_COMMENTS
-- Stores information about the follow-up comments associated with an ABN note.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_CSN_ID) AS NOTE_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(ABN_FOLUP_COMMENTS) AS ABN_FOLUP_COMMENTS_filled
FROM ABN_NOTE_COMMENTS
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: ABN_NOTE_CONTACT_SERVICE
-- This extract table contains information for items in the General Use Notes (HNO) ABN Procedures (HNO 2310) related group. These items are populated with information from the Advanced Beneficiary Notic
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
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
FROM ABN_NOTE_CONTACT_SERVICE;

-- ==========================================================
-- Table: ABN_NOTE_PROC
-- Store information about the ABN procedure note for EHI reporting.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(ABN_PROC_FREQ_DUR) AS ABN_PROC_FREQ_DUR_filled
FROM ABN_NOTE_PROC;

-- ==========================================================
-- Table: ACCESSIBLE_DOCUMENTS_PREF
-- Stores a patient's preferences for receiving accessible documents.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(PAT_ID) AS PAT_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(ACCESSIBLE_DOCUMENTS_PREF_C_NAME) AS ACCESSIBLE_DOCUMENTS_PREF_C_NAME_filled
FROM ACCESSIBLE_DOCUMENTS_PREF;

-- ==========================================================
-- Table: ACCT_HB_BNOTE
-- This table contains Hospital Billing billing notes for guarantor accounts.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(ACCT_ID) AS ACCT_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(HB_BILLING_NOTE) AS HB_BILLING_NOTE_filled
FROM ACCT_HB_BNOTE;

-- ==========================================================
-- Table: ACCT_PB_BILL_NOTE
-- This table stores billing note on the account.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(ACCT_ID) AS ACCT_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(BILLING_NOTE) AS BILLING_NOTE_filled
FROM ACCT_PB_BILL_NOTE;

-- ==========================================================
-- Table: ADDENDUM_VERSIONS
-- The ADDENDUM_VERSIONS table contains information about imaging result text addenda. The rows in this table can be used to link the version of the addendum text with other order information at the time
-- Bucket(s): addendum
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(ORDER_ID) AS ORDER_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(ADDENDUM_CONTACT) AS ADDENDUM_CONTACT_filled
FROM ADDENDUM_VERSIONS;

-- ==========================================================
-- Table: AUTH_REQUEST_HX_UNS_NOTE
-- This table contains the snapshot of unsigned notes associated with the authorization request.
-- Bucket(s): other note/document-adjacent
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(AUTH_REQUEST_ID) AS AUTH_REQUEST_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(UNSIGNED_NOTE_ID) AS UNSIGNED_NOTE_ID_filled
FROM AUTH_REQUEST_HX_UNS_NOTE;

-- ==========================================================
-- Table: BLOCK_NOTE_COPIES
-- Info for note copies to potentially block while blocking parent note.
-- Bucket(s): other note/document-adjacent
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_CSN_ID) AS NOTE_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(BLOCK_CPY_NOTE_ID) AS BLOCK_CPY_NOTE_ID_filled,
    COUNT(BLOCK_CPY_YN) AS BLOCK_CPY_YN_filled
FROM BLOCK_NOTE_COPIES
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: CAREPLAN_PROG_NOTE
-- This table contains information about the list of progress notes filed from Care Plans activity for each Care Plan record.
-- Bucket(s): other note/document-adjacent
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CARE_INTG_ID) AS CARE_INTG_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(CP_PROG_NOTES_ID) AS CP_PROG_NOTES_ID_filled
FROM CAREPLAN_PROG_NOTE;

-- ==========================================================
-- Table: CHILD_NOTE_INFO
-- The CHILD_NOTE_INFO table contains information about child notes that are linked to clinical notes. Each row represents one child note and contains information such as the user that created the link, 
-- Bucket(s): other note/document-adjacent
-- ==========================================================
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
FROM CHILD_NOTE_INFO
GROUP BY YEAR(LINK_UTC)
ORDER BY activity_year;

-- ==========================================================
-- Table: CLM_NOTE
-- All values associated with a claim are stored in the Claim External Value record. The CLM_NOTE table holds claim level notes or remarks.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(RECORD_ID) AS RECORD_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(CLM_NOTE) AS CLM_NOTE_filled
FROM CLM_NOTE;

-- ==========================================================
-- Table: CONTACT_POINT_DOCUMENTS
-- This table contains Clinical References linked to patient education points.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(EDUCATION_RECORD_ID) AS EDUCATION_RECORD_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(CONTACT_POINT_DCS_ID) AS CONTACT_POINT_DCS_ID_filled
FROM CONTACT_POINT_DOCUMENTS
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: CONTACT_TITLE_DOCUMENTS
-- This table contains Clinical References linked to patient education titles.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(EDUCATION_RECORD_ID) AS EDUCATION_RECORD_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(CONTACT_TITLE_DCS_ID) AS CONTACT_TITLE_DCS_ID_filled
FROM CONTACT_TITLE_DOCUMENTS
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: CONTACT_TOPIC_DOCUMENTS
-- This table contains Clinical References linked to patient education topics.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(EDUCATION_RECORD_ID) AS EDUCATION_RECORD_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(CONTACT_TOPIC_DCS_ID) AS CONTACT_TOPIC_DCS_ID_filled
FROM CONTACT_TOPIC_DOCUMENTS
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: COVERAGE_NOTE_INFO
-- This table contains information about notes attached to coverage records.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- ==========================================================
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
FROM COVERAGE_NOTE_INFO
GROUP BY YEAR(NOTE_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: CP_NOTE_READING_HX
-- This table stores the history information for the note's care plan reading.
-- Bucket(s): other note/document-adjacent
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_CSN_ID) AS NOTE_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(CARE_PLAN_HX_CSN_ID) AS CARE_PLAN_HX_CSN_ID_filled
FROM CP_NOTE_READING_HX
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: DOCS_RCVD_ASMT_PLAN_NOTE
-- This table extracts the related multiple response item DXR-11048.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(DOCUMENT_ID) AS DOCUMENT_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(ASMT_PLAN_NOTE_ID) AS ASMT_PLAN_NOTE_ID_filled
FROM DOCS_RCVD_ASMT_PLAN_NOTE
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: DOCS_RCVD_CLN_NOTE_SIGNRS
-- Clinical note signer information for notes recieved externally.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- ==========================================================
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
FROM DOCS_RCVD_CLN_NOTE_SIGNRS
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: DOCS_RCVD_INTVN_NOTE
-- This table extracts the dispense intervention note associated with a particular dispense.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(DOCUMENT_ID) AS DOCUMENT_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
FROM DOCS_RCVD_INTVN_NOTE
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: DOCS_RCVD_NOTE_SECTIONS
-- Stores note section data received.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- ==========================================================
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
FROM DOCS_RCVD_NOTE_SECTIONS
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: DOCS_RCVD_PCCNOTE
-- This table stores discrete information for patient care coordination notes received from outside sources.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- ==========================================================
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
FROM DOCS_RCVD_PCCNOTE
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: DOCS_RCVD_RSLTS_ADDENDUM
-- This table stores discrete result addendum information received from outside sources.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- ==========================================================
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
FROM DOCS_RCVD_RSLTS_ADDENDUM
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: DOCUMENT_SIG_DATA
-- Contains data about the signatures collected for an electronic signature document.
-- Bucket(s): other note/document-adjacent
-- ==========================================================
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
FROM DOCUMENT_SIG_DATA
GROUP BY YEAR(SIG_TIMESTAMP_DTTM)
ORDER BY activity_year;

-- ==========================================================
-- Table: DOCUMENT_SMARTFORM_LIST
-- Contains the SmartForm records for a given document.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(DOCUMENT_ID) AS DOCUMENT_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(DOCUMENT_SMARTFORM) AS DOCUMENT_SMARTFORM_filled
FROM DOCUMENT_SMARTFORM_LIST;

-- ==========================================================
-- Table: DOCUMENT_STAMPS
-- This table contains information about stamps added to scanned documents.
-- Bucket(s): other note/document-adjacent
-- ==========================================================
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
FROM DOCUMENT_STAMPS
GROUP BY YEAR(STAMP_ADDED_UTC_DTTM)
ORDER BY activity_year;

-- ==========================================================
-- Table: DP_COMM_MEMO_NOTE
-- This table contains the Free Text Note(HNO) IDs of communications sent to a service through the Continued Care and Services Coordination workflow, along with the patient CSN, patient ID, and contact d
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- ==========================================================
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
FROM DP_COMM_MEMO_NOTE
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: DP_SVC_COORD_NOTE
-- Coordination notes from the Services to Coordinate section of the current patient encounter--used to leave care coordination notes specific to this patient to a user, or to other users coordinating ca
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- ==========================================================
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
FROM DP_SVC_COORD_NOTE
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: EMBRYOLOGY_DOCUMENTS
-- Table for the documents associated with embryology results.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(RESULT_ID) AS RESULT_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(EMBRYOLOGY_DOCUMENT_ID) AS EMBRYOLOGY_DOCUMENT_ID_filled
FROM EMBRYOLOGY_DOCUMENTS;

-- ==========================================================
-- Table: ENC_DX_ASSOC_AMBIENT_DX
-- This table contains the unique IDs of diagnoses provided by Ambient that were finalized to Visit Diagnoses on the encounter.
-- Bucket(s): ambient/AI-scribe (Epic-native — directly Suki-comparable)
-- ==========================================================
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
FROM ENC_DX_ASSOC_AMBIENT_DX
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: EPRESCRIBE_ERROR_ACTIONS
-- This table holds information about e-prescribing error resolution triggered before the May 23 version. E-prescribing error resolution on or after the upgrade to the May 23 version will be stored to ER
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- ==========================================================
SELECT
    YEAR(RESOLVED_UTC_DTTM) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(ORDER_ID) AS ORDER_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(RESOLVING_ACTION_C_NAME) AS RESOLVING_ACTION_C_NAME_filled,
    COUNT(RESOLVING_USER_ID) AS RESOLVING_USER_ID_filled,
    COUNT(RESOLVING_USER_ID_NAME) AS RESOLVING_USER_ID_NAME_filled,
    COUNT(RESOLVED_UTC_DTTM) AS RESOLVED_UTC_DTTM_filled
FROM EPRESCRIBE_ERROR_ACTIONS
GROUP BY YEAR(RESOLVED_UTC_DTTM)
ORDER BY activity_year;

-- ==========================================================
-- Table: FIN_ASST_CASE_DOCUMENTS
-- The documents associated with a Financial Assistance Case.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(FIN_ASST_CASE_ID) AS FIN_ASST_CASE_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(DOCUMENT_ID) AS DOCUMENT_ID_filled
FROM FIN_ASST_CASE_DOCUMENTS;

-- ==========================================================
-- Table: FIN_ASST_CASE_SMARTFORM
-- This table stores the SmartForm used in a financial assistance case record.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(FIN_ASST_CASE_ID) AS FIN_ASST_CASE_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(SMARTFORM_ID) AS SMARTFORM_ID_filled,
    COUNT(SMARTFORM_VER) AS SMARTFORM_VER_filled
FROM FIN_ASST_CASE_SMARTFORM;

-- ==========================================================
-- Table: FIN_ASST_NOTE
-- This table contains information about notes added to financial assistance tracker records.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- ==========================================================
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
FROM FIN_ASST_NOTE
GROUP BY YEAR(ENTRY_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: FLOWSHT_NOTE_AUDIT
-- The audit trail of the notes that are linked to flowsheet data.
-- Bucket(s): other note/document-adjacent
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(FSD_ID) AS FSD_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(AUDIT_LINKD_NOTE_ID) AS AUDIT_LINKD_NOTE_ID_filled
FROM FLOWSHT_NOTE_AUDIT;

-- ==========================================================
-- Table: FLO_INST_COSIGNED
-- This table displays times that cosigners cosigned the flowsheet data.
-- Bucket(s): signature/cosign/attestation
-- ==========================================================
SELECT
    YEAR(INSTANT_COSIGNED_TM) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(FSD_ID) AS FSD_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(INSTANT_COSIGNED_TM) AS INSTANT_COSIGNED_TM_filled
FROM FLO_INST_COSIGNED
GROUP BY YEAR(INSTANT_COSIGNED_TM)
ORDER BY activity_year;

-- ==========================================================
-- Table: FLO_USER_COSIGNED
-- Users that were either requested to cosign the data or did cosign the data.
-- Bucket(s): signature/cosign/attestation
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(FSD_ID) AS FSD_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(USER_COSIGNED_ID) AS USER_COSIGNED_ID_filled,
    COUNT(USER_COSIGNED_ID_NAME) AS USER_COSIGNED_ID_NAME_filled
FROM FLO_USER_COSIGNED;

-- ==========================================================
-- Table: HNO_ABN_ORD_REASON
-- The order reasons on the Advance Beneficiary Notice (ABN) form for why the order failed medical necessity checks.
-- Bucket(s): core note lifecycle
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(ABN_ORD_REASONS) AS ABN_ORD_REASONS_filled
FROM HNO_ABN_ORD_REASON;

-- ==========================================================
-- Table: HNO_ABN_PROCEDURES
-- This table contains the procedures listed on the Advance Beneficiary Notice (ABN) form.
-- Bucket(s): core note lifecycle
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(ABN_PROCEDURE_ID_PROC_NAME) AS ABN_PROCEDURE_ID_PROC_NAME_filled
FROM HNO_ABN_PROCEDURES;

-- ==========================================================
-- Table: HNO_CONSULT_ORD_ID
-- This table contains the unique IDs of the consult orders that are attached to a note.
-- Bucket(s): core note lifecycle
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_CSN_ID) AS NOTE_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(CONSULT_ORDER_ID) AS CONSULT_ORDER_ID_filled
FROM HNO_CONSULT_ORD_ID
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: HNO_ECG_DX
-- This table contains the diagnosis for Electrocardiograms (ECG/EKG) that have been stored on General Use Notes (HNO) records.
-- Bucket(s): core note lifecycle
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_CSN_ID) AS NOTE_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(ECG_DX) AS ECG_DX_filled
FROM HNO_ECG_DX
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: HNO_INFO
-- This table contains common information from General Use Notes items. This table focuses on time-insensitive, once-per-record data while other HNO tables (e.g., NOTES_ACCT, CODING_CLA_NOTES) contain th
-- Bucket(s): core note lifecycle
-- ==========================================================
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
FROM HNO_INFO
GROUP BY YEAR(CREATE_INSTANT_DTTM)
ORDER BY activity_year;

-- ==========================================================
-- Table: HNO_INFO_2
-- This table contains common information from General Use Notes items. This table focuses on one time only data while other HNO tables (e.g., NOTES_ACCT, CODING_CLA_NOTES) contain the data for different
-- Bucket(s): core note lifecycle
-- ==========================================================
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
FROM HNO_INFO_2
GROUP BY YEAR(LETTER_FINAL_UTC_DTTM)
ORDER BY activity_year;

-- ==========================================================
-- Table: HNO_LET_DICTN
-- This table contains the items associated with letter dictations.
-- Bucket(s): dictation/transcription
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(NOTE_CSN_ID) AS NOTE_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(LET_DICTN_USER_ID) AS LET_DICTN_USER_ID_filled,
    COUNT(LET_DICTN_USER_ID_NAME) AS LET_DICTN_USER_ID_NAME_filled
FROM HNO_LET_DICTN;

-- ==========================================================
-- Table: HNO_LINKED_PATS
-- Linked patients for EHI Export.
-- Bucket(s): core note lifecycle
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(LINKED_PAT_ID) AS LINKED_PAT_ID_filled
FROM HNO_LINKED_PATS;

-- ==========================================================
-- Table: HNO_LINKED_RQGS
-- This table stores the list of requisition groupers associated with a note.
-- Bucket(s): core note lifecycle
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(RQG_GROUPER_ID) AS RQG_GROUPER_ID_filled
FROM HNO_LINKED_RQGS;

-- ==========================================================
-- Table: HNO_MYC_LET_INFO
-- This table contains MyChart related information for letters. It includes whether a letter is released to MyChart and the date/time it was released to MyChart.
-- Bucket(s): core note lifecycle
-- ==========================================================
SELECT
    YEAR(LET_REL_MYC_DTTM) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(LET_REL_MYC_DTTM) AS LET_REL_MYC_DTTM_filled,
    COUNT(LET_REL_TO_MYC_YN) AS LET_REL_TO_MYC_YN_filled
FROM HNO_MYC_LET_INFO
GROUP BY YEAR(LET_REL_MYC_DTTM)
ORDER BY activity_year;

-- ==========================================================
-- Table: HNO_ORDERS
-- Orders that are associated to the note.
-- Bucket(s): core note lifecycle
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(ORDER_ID) AS ORDER_ID_filled,
    COUNT(ORDER_DAT) AS ORDER_DAT_filled
FROM HNO_ORDERS;

-- ==========================================================
-- Table: HNO_PLACEHOLDER_CHARGE
-- Contains items related to Create Placeholder Charge action.
-- Bucket(s): core note lifecycle
-- ==========================================================
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
FROM HNO_PLACEHOLDER_CHARGE
GROUP BY YEAR(CHG_ACTION_UTC_DTTM)
ORDER BY activity_year;

-- ==========================================================
-- Table: HNO_PLAIN_TEXT
-- This table extracts notes that are stored only in plain text. This table does not contain any notes that are stored in rich text. HNO_NOTE_TEXT should still be used for reporting purposes.
-- Bucket(s): core note lifecycle
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(NOTE_CSN_ID) AS NOTE_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(NOTE_TEXT) AS NOTE_TEXT_filled
FROM HNO_PLAIN_TEXT;

-- ==========================================================
-- Table: HNO_SCREENING_PROGRAM
-- Screening program associated with the radiology letter.
-- Bucket(s): core note lifecycle
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(SCREENING_PROGRAM_C_NAME) AS SCREENING_PROGRAM_C_NAME_filled
FROM HNO_SCREENING_PROGRAM;

-- ==========================================================
-- Table: HNO_SMARTFORM_LINK
-- This table contains a list of SmartBlocks and the SmartForms that are linked to those SmartBlocks in a particular note.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- ==========================================================
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
FROM HNO_SMARTFORM_LINK
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: HNO_SOURCE_LOG_ID
-- This table displays the surgical log where a note was edited.
-- Bucket(s): core note lifecycle
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_CSN_ID) AS NOTE_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(SOURCE_LOG_ID) AS SOURCE_LOG_ID_filled
FROM HNO_SOURCE_LOG_ID
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: HOLOGRAM_AMBIENT_DX_INFO
-- This table contains information about the Ambient diagnosis choices that were presented to a clinician.
-- Bucket(s): ambient/AI-scribe (Epic-native — directly Suki-comparable)
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
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
FROM HOLOGRAM_AMBIENT_DX_INFO;

-- ==========================================================
-- Table: HOLOGRAM_AMBIENT_FAM_HX
-- This table contains information about the Ambient family history choices that were presented to a clinician.
-- Bucket(s): ambient/AI-scribe (Epic-native — directly Suki-comparable)
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
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
FROM HOLOGRAM_AMBIENT_FAM_HX;

-- ==========================================================
-- Table: HOLOGRAM_DETAILS
-- This table stores workflow-level information about documentation pieces that have been queued up and suspended during an outpatient visit.
-- Bucket(s): ambient/AI-scribe (Epic-native — directly Suki-comparable)
-- ==========================================================
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
FROM HOLOGRAM_DETAILS
GROUP BY YEAR(WORKFLOW_INST_UTC_DTTM)
ORDER BY activity_year;

-- ==========================================================
-- Table: HOLOGRAM_SELECTIONS
-- This table stores details about each selection made in a hologram record. Which specific details are stored depends on the type of each row.
-- Bucket(s): ambient/AI-scribe (Epic-native — directly Suki-comparable)
-- ==========================================================
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
FROM HOLOGRAM_SELECTIONS
GROUP BY YEAR(IMMNZTN_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: HOLOGRAM_SELECTIONS_2
-- This table stores details about each selection made in a hologram record. Which specific details are stored depends on the type of each row. Extends HOLOGRAM_SELECTIONS.
-- Bucket(s): ambient/AI-scribe (Epic-native — directly Suki-comparable)
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(HOLOGRAM_ID) AS HOLOGRAM_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(HOL_IS_SELECTED_YN) AS HOL_IS_SELECTED_YN_filled
FROM HOLOGRAM_SELECTIONS_2;

-- ==========================================================
-- Table: HOLO_SMARTTEXT_NOTE_TXT
-- This table contains note text temporarily stored in a hologram record.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(HOLOGRAM_ID) AS HOLOGRAM_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(SMARTTEXT_NOTE_TEXT) AS SMARTTEXT_NOTE_TEXT_filled
FROM HOLO_SMARTTEXT_NOTE_TXT;

-- ==========================================================
-- Table: HSP_ACCT_BILL_NOTE
-- This table contains hospital account billing notes from the Hospital Accounts Receivable (HAR) master file.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(HSP_ACCOUNT_ID) AS HSP_ACCOUNT_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(BILLING_NOTE) AS BILLING_NOTE_filled
FROM HSP_ACCT_BILL_NOTE;

-- ==========================================================
-- Table: INCOMPLETE_NOTE_EPT
-- Table created for the visit narrative data stored in the patient masterfile. No longer used since we use UCN now since 2010, exporting these items as a formality.
-- Bucket(s): other note/document-adjacent
-- ==========================================================
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
FROM INCOMPLETE_NOTE_EPT
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: INTERV_NOTE_INFO
-- This table links a care plan goal note contact to the related intervention note contacts that were filed at the same time.
-- Bucket(s): other note/document-adjacent
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_CSN_ID) AS NOTE_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(INTERV_NOTE_CSN_ID) AS INTERV_NOTE_CSN_ID_filled
FROM INTERV_NOTE_INFO
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: INTERV_SMARTTEXT
-- This table displays the SmartTexts that are associated with intervention (LPI) records.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(INTERVENTION_ID) AS INTERVENTION_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(SMARTTEXTS_ID) AS SMARTTEXTS_ID_filled,
    COUNT(SMARTTEXTS_ID_SMARTTEXT_NAME) AS SMARTTEXTS_ID_SMARTTEXT_NAME_filled,
    COUNT(IP_INV_LDS_ID) AS IP_INV_LDS_ID_filled,
    COUNT(IP_INV_LDS_ID_DISC_NAME) AS IP_INV_LDS_ID_DISC_NAME_filled,
    COUNT(HH_INT_DISC_C_NAME) AS HH_INT_DISC_C_NAME_filled
FROM INTERV_SMARTTEXT;

-- ==========================================================
-- Table: IP_NOTE_TYPE
-- This table displays the note type for notes associated with Inpatient (INP) records.
-- Bucket(s): other note/document-adjacent
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(INPATIENT_DATA_ID) AS INPATIENT_DATA_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(TYPE_IP_C_NAME) AS TYPE_IP_C_NAME_filled
FROM IP_NOTE_TYPE;

-- ==========================================================
-- Table: LAB_COSIGN_INFO
-- The LAB_COSIGN_INFO table contains cosign information for lab results.
-- Bucket(s): signature/cosign/attestation
-- ==========================================================
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
FROM LAB_COSIGN_INFO
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: LN_REPRICING_NOTE_TPO
-- The LN_REPRICING_NOTE_TPO table contains the line level third party organization notes populated for Tapestry's generic external repricing interface.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(RECORD_ID) AS RECORD_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(LN_REPRICING_NOTE_TPO) AS LN_REPRICING_NOTE_TPO_filled
FROM LN_REPRICING_NOTE_TPO;

-- ==========================================================
-- Table: MAR_COSIGN_INST
-- List of instants at which this med administration was cosigned.
-- Bucket(s): signature/cosign/attestation
-- ==========================================================
SELECT
    YEAR(MAR_COSIGN_INSTANT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(ORDER_ID) AS ORDER_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(MAR_COSIGN_INSTANT) AS MAR_COSIGN_INSTANT_filled
FROM MAR_COSIGN_INST
GROUP BY YEAR(MAR_COSIGN_INSTANT)
ORDER BY activity_year;

-- ==========================================================
-- Table: MAR_COSIGN_USER
-- List of users who actually cosigned this med administration.
-- Bucket(s): signature/cosign/attestation
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(ORDER_ID) AS ORDER_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(MAR_COSIGN_USER_ID) AS MAR_COSIGN_USER_ID_filled,
    COUNT(MAR_COSIGN_USER_ID_NAME) AS MAR_COSIGN_USER_ID_NAME_filled
FROM MAR_COSIGN_USER;

-- ==========================================================
-- Table: MED_AUTH_DET_NOTE
-- This table extracts the note associated with a prior authorization.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(REFERRAL_ID) AS REFERRAL_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(PA_DETAIL_NOTE) AS PA_DETAIL_NOTE_filled
FROM MED_AUTH_DET_NOTE;

-- ==========================================================
-- Table: MED_DISCONTINUE_NOTE
-- This table extracts the multiline discontinue note associated with a medication within a document received.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(DOCUMENT_ID) AS DOCUMENT_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
FROM MED_DISCONTINUE_NOTE
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: MED_PA_NOTE_FROM_PAYER
-- This table holds the note received from the payer for an electronic prior authorization action.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(REFERRAL_ID) AS REFERRAL_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(PA_NOTE_FROM_PAYER) AS PA_NOTE_FROM_PAYER_filled
FROM MED_PA_NOTE_FROM_PAYER;

-- ==========================================================
-- Table: MED_PA_NOTE_TO_PAYER
-- This table holds the note sent to the payer for an electronic prior authorization action.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(REFERRAL_ID) AS REFERRAL_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(PA_NOTE_TO_PAYER) AS PA_NOTE_TO_PAYER_filled
FROM MED_PA_NOTE_TO_PAYER;

-- ==========================================================
-- Table: NOTES_ACCT
-- This table contains summary information for billing system account notepad notes attached to accounts.
-- Bucket(s): core note lifecycle
-- ==========================================================
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
FROM NOTES_ACCT
GROUP BY YEAR(NOTE_ENTRY_DTTM)
ORDER BY activity_year;

-- ==========================================================
-- Table: NOTES_HISTORY_LOG
-- This table contains the Edit History Information for all Notes (HNO records). Shows information about the type of edit, when the note was edited, and the user who made the edit.
-- Bucket(s): core note lifecycle
-- ==========================================================
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
FROM NOTES_HISTORY_LOG
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: NOTES_LAB
-- Contains lab-specific information about notes. Only notes associated with labs, which are notes (HNOs) with a Note Type (I HNO 50) value of 81-Lab, are included.
-- Bucket(s): core note lifecycle
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(LAB_NOTE_SUB_TYPE_C_NAME) AS LAB_NOTE_SUB_TYPE_C_NAME_filled
FROM NOTES_LAB;

-- ==========================================================
-- Table: NOTES_LINK_ORD_TXN
-- Orders linked to/from the HNO (notes) master file by order based transcriptions.
-- Bucket(s): core note lifecycle
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(LINKED_ORD_ID) AS LINKED_ORD_ID_filled
FROM NOTES_LINK_ORD_TXN;

-- ==========================================================
-- Table: NOTES_MC_NMM
-- This table contains the information about notes (HNO) records attached to case (NMM) records.
-- Bucket(s): core note lifecycle
-- ==========================================================
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
FROM NOTES_MC_NMM
GROUP BY YEAR(NOTE_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: NOTES_PROC_ORDERS
-- This table contains a list of procedure orders linked to ambulatory procedure notes.
-- Bucket(s): core note lifecycle
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(ASC_PROC_ORDERS_ID) AS ASC_PROC_ORDERS_ID_filled
FROM NOTES_PROC_ORDERS;

-- ==========================================================
-- Table: NOTES_PROC_PRE_DX
-- This table contains a list of preoperative diagnoses for ambulatory procedure notes.
-- Bucket(s): core note lifecycle
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(PROC_NOTE_PRE_DX_DX_NAME) AS PROC_NOTE_PRE_DX_DX_NAME_filled
FROM NOTES_PROC_PRE_DX;

-- ==========================================================
-- Table: NOTES_PROC_PROCS
-- This table contains a list of procedures for ambulatory procedure notes.
-- Bucket(s): core note lifecycle
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(PROC_NOTE_PROCEDUR_PROC_NAME) AS PROC_NOTE_PROCEDUR_PROC_NAME_filled
FROM NOTES_PROC_PROCS;

-- ==========================================================
-- Table: NOTES_PROC_PST_DX
-- This table contains a list of postoperative diagnoses for ambulatory procedure notes.
-- Bucket(s): core note lifecycle
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(PROC_NOTE_PST_DX_DX_NAME) AS PROC_NOTE_PST_DX_DX_NAME_filled
FROM NOTES_PROC_PST_DX;

-- ==========================================================
-- Table: NOTES_TRANS_AUTH
-- This table contains transcription authorization info.
-- Bucket(s): core note lifecycle
-- ==========================================================
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
FROM NOTES_TRANS_AUTH
GROUP BY YEAR(AUTH_DTTM)
ORDER BY activity_year;

-- ==========================================================
-- Table: NOTES_TRANS_IB
-- This table contains information about the transcription In Basket notes.
-- Bucket(s): core note lifecycle
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(NOTE_CSN_ID) AS NOTE_CSN_ID_filled,
    COUNT(IB_PRIORITY_C_NAME) AS IB_PRIORITY_C_NAME_filled
FROM NOTES_TRANS_IB;

-- ==========================================================
-- Table: NOTE_AMBIENT_SECTIONS
-- Stores ambient note section information.
-- Bucket(s): ambient/AI-scribe (Epic-native — directly Suki-comparable)
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(AMBIENT_SESSION_SECTION_IDENT) AS AMBIENT_SESSION_SECTION_IDENT_filled,
    COUNT(AMBIENT_SESSION_IDENT) AS AMBIENT_SESSION_IDENT_filled
FROM NOTE_AMBIENT_SECTIONS;

-- ==========================================================
-- Table: NOTE_ATTACHED_IMG
-- Stores the document IDs of images attached to the note from Canto.
-- Bucket(s): core note lifecycle
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NOTE_IMG_DOC_ID) AS NOTE_IMG_DOC_ID_filled
FROM NOTE_ATTACHED_IMG;

-- ==========================================================
-- Table: NOTE_BLOCKING
-- This table stores the reasons for blocking the sharing of a note.
-- Bucket(s): core note lifecycle
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_CSN_ID) AS NOTE_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(MULT_BLOCK_REASON_C_NAME) AS MULT_BLOCK_REASON_C_NAME_filled
FROM NOTE_BLOCKING
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: NOTE_CONTENT_INFO
-- This table contains discrete information pertaining to the type of content contained within the note text of a clinical note.
-- Bucket(s): core note lifecycle
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_CSN_ID) AS NOTE_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
FROM NOTE_CONTENT_INFO
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: NOTE_COPY_TRACKING
-- Track the source note information that this note was copied from.
-- Bucket(s): core note lifecycle
-- ==========================================================
SELECT
    YEAR(NOTE_COPY_INST_DTTM) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NOTE_COPY_INST_DTTM) AS NOTE_COPY_INST_DTTM_filled,
    COUNT(NOTE_COPY_LOC_DTTM) AS NOTE_COPY_LOC_DTTM_filled
FROM NOTE_COPY_TRACKING
GROUP BY YEAR(NOTE_COPY_INST_DTTM)
ORDER BY activity_year;

-- ==========================================================
-- Table: NOTE_DENT_PROCS
-- Dental procedures linked to this dental procedure note.
-- Bucket(s): core note lifecycle
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(DENT_PROC_FINDING_ID) AS DENT_PROC_FINDING_ID_filled
FROM NOTE_DENT_PROCS;

-- ==========================================================
-- Table: NOTE_EDIT_TRAIL
-- This table displays edit trail information for notes (HNO).
-- Bucket(s): core note lifecycle
-- ==========================================================
SELECT
    YEAR(IP_ACTION_DTTM) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(IP_ACTION_DTTM) AS IP_ACTION_DTTM_filled,
    COUNT(ACT_TAKEN_INST_DTTM) AS ACT_TAKEN_INST_DTTM_filled
FROM NOTE_EDIT_TRAIL
GROUP BY YEAR(IP_ACTION_DTTM)
ORDER BY activity_year;

-- ==========================================================
-- Table: NOTE_ENC_INFO
-- This table contains information from overtime single-response items about General Use Notes (HNO) records. Contact creation logic for clinical notes is as follows: 1. If a note doesn't exist, a new no
-- Bucket(s): core note lifecycle
-- ==========================================================
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
FROM NOTE_ENC_INFO
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: NOTE_ENC_INFO_2
-- This table extends HNO_ENC_INFO.
-- Bucket(s): core note lifecycle
-- ==========================================================
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
FROM NOTE_ENC_INFO_2
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: NOTE_ENC_SUMMARY
-- This table contains the summary text for a general use note.
-- Bucket(s): core note lifecycle
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(NOTE_CSN_ID) AS NOTE_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(SUMMARY_TEXT) AS SUMMARY_TEXT_filled
FROM NOTE_ENC_SUMMARY;

-- ==========================================================
-- Table: NOTE_EXT_REL_ORD
-- This table stores information about external orders related to an external note.
-- Bucket(s): core note lifecycle
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_CSN_ID) AS NOTE_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(EXT_REL_ORD_NAME) AS EXT_REL_ORD_NAME_filled
FROM NOTE_EXT_REL_ORD
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: NOTE_EXT_REL_PREDX
-- This table stores information about external pre-procedure diagnoses related to an external note.
-- Bucket(s): core note lifecycle
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_CSN_ID) AS NOTE_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(EXT_REL_PREDX_NAME) AS EXT_REL_PREDX_NAME_filled
FROM NOTE_EXT_REL_PREDX
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: NOTE_EXT_REL_PROB
-- This table stores information about external problems related to an external note.
-- Bucket(s): core note lifecycle
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_CSN_ID) AS NOTE_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(EXT_REL_PROB_NAME) AS EXT_REL_PROB_NAME_filled
FROM NOTE_EXT_REL_PROB
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: NOTE_EXT_REL_PROC
-- This table stores information about external procedures related to an external note.
-- Bucket(s): core note lifecycle
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_CSN_ID) AS NOTE_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(EXT_REL_PROC_NAME) AS EXT_REL_PROC_NAME_filled
FROM NOTE_EXT_REL_PROC
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: NOTE_EXT_REL_PSTDX
-- This table stores information about external post-procedure diagnoses related to an external note.
-- Bucket(s): core note lifecycle
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_CSN_ID) AS NOTE_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(EXT_REL_PSTDX_NAME) AS EXT_REL_PSTDX_NAME_filled
FROM NOTE_EXT_REL_PSTDX
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: NOTE_EXT_SIGNERS
-- Note signer information for auto-reconciled external notes.
-- Bucket(s): core note lifecycle
-- ==========================================================
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
FROM NOTE_EXT_SIGNERS
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: NOTE_EXT_WRN_TYP
-- This table stores the external note warning types for a note.
-- Bucket(s): core note lifecycle
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_CSN_ID) AS NOTE_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(EXT_NOTE_WRN_C_NAME) AS EXT_NOTE_WRN_C_NAME_filled
FROM NOTE_EXT_WRN_TYP
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: NOTE_FREE_TEXT
-- The NOTE_FREE_TEXT table contains free text notes.
-- Bucket(s): core note lifecycle
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NOTE_FREE_TEXT) AS NOTE_FREE_TEXT_filled
FROM NOTE_FREE_TEXT;

-- ==========================================================
-- Table: NOTE_IMG_SECT
-- This table contains information about imaging orders resulted using the Imaging SmartSection.
-- Bucket(s): core note lifecycle
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(IMG_SECT_RESULT_NOTE_CSN_ID) AS IMG_SECT_RESULT_NOTE_CSN_ID_filled,
    COUNT(IMG_SECT_ORDER_ID) AS IMG_SECT_ORDER_ID_filled
FROM NOTE_IMG_SECT;

-- ==========================================================
-- Table: NOTE_PARENT_NOTE
-- Table to hold HNO parent note information.
-- Bucket(s): core note lifecycle
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(SS_PARENT_NOTE_ID) AS SS_PARENT_NOTE_ID_filled
FROM NOTE_PARENT_NOTE;

-- ==========================================================
-- Table: NOTE_RESEARCH_LINK
-- This table contains information about the current research link for notes.
-- Bucket(s): core note lifecycle
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(RESEARCH_ID_RESEARCH_STUDY_NAME) AS RESEARCH_ID_RESEARCH_STUDY_NAME_filled,
    COUNT(ENROLL_ID) AS ENROLL_ID_filled
FROM NOTE_RESEARCH_LINK;

-- ==========================================================
-- Table: NOTE_RESEARCH_LINK_HX
-- This table contains information about how the research study linkage on a note has changed over time.
-- Bucket(s): core note lifecycle
-- ==========================================================
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
FROM NOTE_RESEARCH_LINK_HX
GROUP BY YEAR(HX_STUDY_LINK_UTC_DTTM)
ORDER BY activity_year;

-- ==========================================================
-- Table: NOTE_SMARTBLOCK_ATTR
-- Store the employee (EMP) ID, the Timestamp, and the SmartBlocks added of the Attribution for SmartBlocks.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- ==========================================================
SELECT
    YEAR(ATTRIBUTION_UTC_DTTM) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(USER_ID) AS USER_ID_filled,
    COUNT(USER_ID_NAME) AS USER_ID_NAME_filled,
    COUNT(ATTRIBUTION_UTC_DTTM) AS ATTRIBUTION_UTC_DTTM_filled,
    COUNT(SB_COPY_CSN) AS SB_COPY_CSN_filled
FROM NOTE_SMARTBLOCK_ATTR
GROUP BY YEAR(ATTRIBUTION_UTC_DTTM)
ORDER BY activity_year;

-- ==========================================================
-- Table: NOTE_SMARTSECTION_IDS
-- Contains the SmartSection IDs used in the note.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_CSN_ID) AS NOTE_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
FROM NOTE_SMARTSECTION_IDS
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: ORDER_ADDENDUM_NOTE
-- The table contains the note that stores addendum for the order.
-- Bucket(s): addendum
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(ORDER_ID) AS ORDER_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(ADDENDUM_NOTE_ID) AS ADDENDUM_NOTE_ID_filled
FROM ORDER_ADDENDUM_NOTE;

-- ==========================================================
-- Table: ORDER_DOCUMENTS
-- This table contains the DCS records attached to an order on a contact level such as scanned hard copy prescriptions, Lab Scans and Lab Reports.
-- Bucket(s): other note/document-adjacent
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(ORDER_ID) AS ORDER_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
FROM ORDER_DOCUMENTS
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: ORDER_RAD_DICTATE
-- This table stores the dictation radiologist & dictating date information for orders performed in radiology.
-- Bucket(s): dictation/transcription
-- ==========================================================
SELECT
    YEAR(DICTATING_DT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(ORDER_PROC_ID) AS ORDER_PROC_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(PROV_ID_PROV_NAME) AS PROV_ID_PROV_NAME_filled,
    COUNT(DICTATING_DT) AS DICTATING_DT_filled,
    COUNT(DICTATED_UTC_DTTM) AS DICTATED_UTC_DTTM_filled
FROM ORDER_RAD_DICTATE
GROUP BY YEAR(DICTATING_DT)
ORDER BY activity_year;

-- ==========================================================
-- Table: ORDER_RESULT_DOCUMENTS
-- This tables holds document IDs for documents that contain results for an order.
-- Bucket(s): other note/document-adjacent
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(ORDER_ID) AS ORDER_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(RESULT_DOCUMENT_ID) AS RESULT_DOCUMENT_ID_filled
FROM ORDER_RESULT_DOCUMENTS
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: ORDER_SMARTSECTION_DATA
-- Data for Order specific SmartSections.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(ORDER_ID) AS ORDER_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(ORDER_SMARTSECTION_C_NAME) AS ORDER_SMARTSECTION_C_NAME_filled
FROM ORDER_SMARTSECTION_DATA
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: ORDER_SMARTSECTION_HNO
-- Holds the CSN of HNO records that contain the SmartSection text.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(ORDER_ID) AS ORDER_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
FROM ORDER_SMARTSECTION_HNO
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: ORDER_SMARTSECTION_TEXT
-- Holds the SmartSection text for an Order. Associated key is SMARTSECTION_KEY in ORDER_SMARTSECTION_DATA.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(ORDER_ID) AS ORDER_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(SMARTSECTION_TEXT) AS SMARTSECTION_TEXT_filled
FROM ORDER_SMARTSECTION_TEXT
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: ORD_LAST_ADDENDUM_INFO
-- This table contains information about the most recent addendum.
-- Bucket(s): addendum
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(ORDER_ID) AS ORDER_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(LAST_ADD_PROV_ID_PROV_NAME) AS LAST_ADD_PROV_ID_PROV_NAME_filled
FROM ORD_LAST_ADDENDUM_INFO;

-- ==========================================================
-- Table: ORTHO_TREAT_NOTE
-- The ORTHO_TREAT_NOTE table contains information about orthodontics treatment note.
-- Bucket(s): other note/document-adjacent
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(TREATMENT_PLAN_ID) AS TREATMENT_PLAN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NOTE) AS NOTE_filled
FROM ORTHO_TREAT_NOTE;

-- ==========================================================
-- Table: OR_LOG_POSTOP_NOTE
-- The OR_LOG_POSTOP_NOTE table contains post-op notes from the log record.
-- Bucket(s): other note/document-adjacent
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(LOG_ID) AS LOG_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(POSTOP_NOTES_ID) AS POSTOP_NOTES_ID_filled
FROM OR_LOG_POSTOP_NOTE;

-- ==========================================================
-- Table: OUTREACH_ESIG_DOCUMENTS
-- This table stores documents sent to patients for e-signature prior to an outreach.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- ==========================================================
SELECT
    YEAR(ESIG_DOC_SEND_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(ACTIVITY_ID) AS ACTIVITY_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(ESIG_DOCUMENT_ID) AS ESIG_DOCUMENT_ID_filled,
    COUNT(ESIG_REL_ORDER_ID) AS ESIG_REL_ORDER_ID_filled,
    COUNT(ESIG_DOC_SEND_DATE) AS ESIG_DOC_SEND_DATE_filled
FROM OUTREACH_ESIG_DOCUMENTS
GROUP BY YEAR(ESIG_DOC_SEND_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: PAT_ADDENDUM_INFO
-- This table contains the encounter addendum information from the Addendum Added Date (I EPT 18123) and Addendum Added User (I EPT 18129) items.
-- Bucket(s): addendum
-- ==========================================================
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
FROM PAT_ADDENDUM_INFO
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: PAT_DT_STICKY_NOTE_INFO
-- This table contains information regarding a patient's date-specific sticky notes, including the date the note applies to as well as the note ID.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- ==========================================================
SELECT
    YEAR(DT_STICKY_NOTE_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(PAT_ID) AS PAT_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(DT_STICKY_NOTE_DATE) AS DT_STICKY_NOTE_DATE_filled,
    COUNT(DT_STICKY_NOTE_ID) AS DT_STICKY_NOTE_ID_filled
FROM PAT_DT_STICKY_NOTE_INFO
GROUP BY YEAR(DT_STICKY_NOTE_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: PAT_ENC_AMBIENT_SESSIONS
-- Stores ambient session information from a patient's encounter.
-- Bucket(s): ambient/AI-scribe (Epic-native — directly Suki-comparable)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(PAT_ID) AS PAT_ID_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(CM_CT_OWNER_ID) AS CM_CT_OWNER_ID_filled,
    COUNT(AMBIENT_SESSION_IDENT) AS AMBIENT_SESSION_IDENT_filled
FROM PAT_ENC_AMBIENT_SESSIONS
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: PAT_ENC_CHKOUT_NOTE
-- Stores the checkout note entered by the provider for the follow-up of a given encounter.
-- Bucket(s): other note/document-adjacent
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(CHKOUT_NOTE) AS CHKOUT_NOTE_filled
FROM PAT_ENC_CHKOUT_NOTE;

-- ==========================================================
-- Table: PAT_ENC_PREPAYNOTE
-- User entered notes associated with a prepayment on a patient encounter.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(PAT_ENC_DATE_REAL) AS PAT_ENC_DATE_REAL_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(PREPAY_NOTES) AS PREPAY_NOTES_filled
FROM PAT_ENC_PREPAYNOTE
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: PB_COLL_HX_NOTE_TBL
-- The table of notes, letters, etc. attached to a collections process as it moves through an organization's steps of collections.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(PB_ACCT_ID) AS PB_ACCT_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(PB_COLL_NOTE_ID) AS PB_COLL_NOTE_ID_filled
FROM PB_COLL_HX_NOTE_TBL;

-- ==========================================================
-- Table: PROBLEM_DIS_STAT_NOTE_HX
-- This table extracts a list of notes (HNOs) indicating the note in which clinicians have edited the disease status for a problem on a patient's problem list.
-- Bucket(s): other note/document-adjacent
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(PROBLEM_LIST_ID) AS PROBLEM_LIST_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(HX_DISEASE_STATUS_NOTE_ID) AS HX_DISEASE_STATUS_NOTE_ID_filled
FROM PROBLEM_DIS_STAT_NOTE_HX;

-- ==========================================================
-- Table: PROBLEM_NOTE_PROPS
-- Contains all related properties to assessment & plan notes which are stored in the PROBLEM_NOTES clarity extract.
-- Bucket(s): other note/document-adjacent
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(PROBLEM_LIST_ID) AS PROBLEM_LIST_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(GENERATED_NOTE_ID) AS GENERATED_NOTE_ID_filled,
    COUNT(AP_NOTE_SERVICE_C_NAME) AS AP_NOTE_SERVICE_C_NAME_filled
FROM PROBLEM_NOTE_PROPS;

-- ==========================================================
-- Table: QRY_EVIDENCE_NOTE_CSN_ID
-- This table extracts information related to the contact the evidence came from.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(QUERY_ID) AS QUERY_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(EVIDENCE_NOTE_CSN_ID) AS EVIDENCE_NOTE_CSN_ID_filled,
    COUNT(QUERY_CSN_ID) AS QUERY_CSN_ID_filled
FROM QRY_EVIDENCE_NOTE_CSN_ID
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: QRY_EVIDENCE_NOTE_IDS
-- This table extracts information related to the note record that the evidence came from.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(QUERY_ID) AS QUERY_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(EVIDENCE_NOTE_ID) AS EVIDENCE_NOTE_ID_filled,
    COUNT(QUERY_CSN_ID) AS QUERY_CSN_ID_filled
FROM QRY_EVIDENCE_NOTE_IDS
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: QRY_RESP_NOTE_HX
-- This table displays historical notes used in response to queries (are not current responses).
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(QRY_RESP_HX_NOTE_ID) AS QRY_RESP_HX_NOTE_ID_filled
FROM QRY_RESP_NOTE_HX;

-- ==========================================================
-- Table: REFERRAL_BED_DAY_UNS_NOTE
-- The unsigned notes linked with a bed day line.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(REFERRAL_ID) AS REFERRAL_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(BED_DAY_UNSIGNED_NOTE_ID) AS BED_DAY_UNSIGNED_NOTE_ID_filled
FROM REFERRAL_BED_DAY_UNS_NOTE;

-- ==========================================================
-- Table: REFERRAL_UM_UNSIGNED_NOTE
-- This table contains the unsigned UM notes.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(REFERRAL_ID) AS REFERRAL_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(UM_UNSIGNED_UCN_NOTE_ID) AS UM_UNSIGNED_UCN_NOTE_ID_filled
FROM REFERRAL_UM_UNSIGNED_NOTE;

-- ==========================================================
-- Table: RES_COSIGNERS
-- Contains a list of users who have cosigned results.
-- Bucket(s): signature/cosign/attestation
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(RESULT_ID) AS RESULT_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(COSIGNER_ID) AS COSIGNER_ID_filled,
    COUNT(COSIGNER_ID_NAME) AS COSIGNER_ID_NAME_filled
FROM RES_COSIGNERS;

-- ==========================================================
-- Table: RES_SMARTTEXT_RSLT
-- Displays multi-line string results.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(RESULT_ID) AS RESULT_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(MULTI_LN_STR_RESULT) AS MULTI_LN_STR_RESULT_filled
FROM RES_SMARTTEXT_RSLT;

-- ==========================================================
-- Table: RXFILL_NOTE
-- Table for the RxFill pharmacy note.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(MED_PRBLM_LIST_ID) AS MED_PRBLM_LIST_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(RXFILL_NOTE) AS RXFILL_NOTE_filled
FROM RXFILL_NOTE;

-- ==========================================================
-- Table: SMARTFORMS_ACCESSED
-- This table contains information pertaining to how specific users are accessing specific SmartForms, such as how long a user has spent in a given SmartForm.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(PAT_ID) AS PAT_ID_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(CM_CT_OWNER_ID) AS CM_CT_OWNER_ID_filled
FROM SMARTFORMS_ACCESSED
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: SMARTFORM_METADATA
-- This table contains metadata pertaining to specific SmartForms for a visit.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(PAT_ID) AS PAT_ID_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(CM_CT_OWNER_ID) AS CM_CT_OWNER_ID_filled
FROM SMARTFORM_METADATA
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: SMARTTEXT
-- This table contains information relating to SmartText records. SmartTexts are blocks of text which may be used in a variety of ways, including documenting on clinical encounters, and for letters sent 
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(SMARTTEXT_ID) AS SMARTTEXT_ID_filled,
    COUNT(SMARTTEXT_NAME) AS SMARTTEXT_NAME_filled
FROM SMARTTEXT;

-- ==========================================================
-- Table: SMRTDTA_ELEM_AIEXTRACTED
-- This table is a bridge between AI Extracted Fact context SmartData element values and the source interaction records.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(HLV_ID) AS HLV_ID_filled,
    COUNT(ELEMENT_ID) AS ELEMENT_ID_filled,
    COUNT(AI_INTRCT_ID) AS AI_INTRCT_ID_filled
FROM SMRTDTA_ELEM_AIEXTRACTED;

-- ==========================================================
-- Table: SMRTDTA_ELEM_AUTH
-- This table is a bridge between authorization context SmartData element values and the source authorization records.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(HLV_ID) AS HLV_ID_filled,
    COUNT(AUTH_ID) AS AUTH_ID_filled,
    COUNT(ELEMENT_ID) AS ELEMENT_ID_filled
FROM SMRTDTA_ELEM_AUTH;

-- ==========================================================
-- Table: SMRTDTA_ELEM_BEREAVE
-- This table is a bridge between bereavement contact context SmartData element values and the source bereavement records.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(HLV_ID) AS HLV_ID_filled,
    COUNT(BEREAVEMENT_ID) AS BEREAVEMENT_ID_filled,
    COUNT(ELEMENT_ID) AS ELEMENT_ID_filled
FROM SMRTDTA_ELEM_BEREAVE;

-- ==========================================================
-- Table: SMRTDTA_ELEM_CONCEPT
-- This table is a bridge between concept context SmartData element values and the source SmartData element value records.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(HLV_ID) AS HLV_ID_filled,
    COUNT(PARENT_HLV_ID) AS PARENT_HLV_ID_filled,
    COUNT(PAT_ID) AS PAT_ID_filled,
    COUNT(ELEMENT_ID) AS ELEMENT_ID_filled
FROM SMRTDTA_ELEM_CONCEPT;

-- ==========================================================
-- Table: SMRTDTA_ELEM_CUST_SERVICE
-- This table is a bridge between CRM context SmartData element values and the source customer relationship management records.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- ==========================================================
SELECT
    YEAR(CUR_VALUE_DATETIME) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(HLV_ID) AS HLV_ID_filled,
    COUNT(COMM_ID) AS COMM_ID_filled,
    COUNT(ELEMENT_ID) AS ELEMENT_ID_filled,
    COUNT(CUR_VALUE_DATETIME) AS CUR_VALUE_DATETIME_filled
FROM SMRTDTA_ELEM_CUST_SERVICE
GROUP BY YEAR(CUR_VALUE_DATETIME)
ORDER BY activity_year;

-- ==========================================================
-- Table: SMRTDTA_ELEM_DATA
-- The SMRTDTA_ELEM_DATA table stores metadata (context, linked records, time of entry, etc.) concerning SmartData element values entered by users through SmartForms, SmartTools or other documentation to
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- ==========================================================
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
FROM SMRTDTA_ELEM_DATA
GROUP BY YEAR(CUR_VALUE_DATETIME)
ORDER BY activity_year;

-- ==========================================================
-- Table: SMRTDTA_ELEM_DATASET
-- This table is a bridge between data set context SmartData element values and the source data set records.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(HLV_ID) AS HLV_ID_filled,
    COUNT(DATASET_ID) AS DATASET_ID_filled,
    COUNT(ELEMENT_ID) AS ELEMENT_ID_filled
FROM SMRTDTA_ELEM_DATASET;

-- ==========================================================
-- Table: SMRTDTA_ELEM_DEFICIENCY
-- This table is a bridge between problem context SmartData element values and the source deficiency records.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(HLV_ID) AS HLV_ID_filled,
    COUNT(ELEMENT_ID) AS ELEMENT_ID_filled,
    COUNT(DFI_ID) AS DFI_ID_filled
FROM SMRTDTA_ELEM_DEFICIENCY;

-- ==========================================================
-- Table: SMRTDTA_ELEM_DOCUMENT
-- This table is a bridge between document context SmartData element values and the source document records.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(HLV_ID) AS HLV_ID_filled,
    COUNT(DOCUMENT_ID) AS DOCUMENT_ID_filled,
    COUNT(ELEMENT_ID) AS ELEMENT_ID_filled
FROM SMRTDTA_ELEM_DOCUMENT;

-- ==========================================================
-- Table: SMRTDTA_ELEM_DONOR
-- This table is a bridge between donor context SmartData element values and the source donor records.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(HLV_ID) AS HLV_ID_filled,
    COUNT(DONOR_RECORD_ID) AS DONOR_RECORD_ID_filled,
    COUNT(ELEMENT_ID) AS ELEMENT_ID_filled
FROM SMRTDTA_ELEM_DONOR;

-- ==========================================================
-- Table: SMRTDTA_ELEM_ENCOUNTER
-- This table is a bridge between encounter context SmartData element values and the source patient encounter contacts.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(HLV_ID) AS HLV_ID_filled,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(PAT_ID) AS PAT_ID_filled,
    COUNT(ELEMENT_ID) AS ELEMENT_ID_filled
FROM SMRTDTA_ELEM_ENCOUNTER;

-- ==========================================================
-- Table: SMRTDTA_ELEM_EPISODE
-- This table is a bridge between episode context SmartData element values and the source episode records.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(HLV_ID) AS HLV_ID_filled,
    COUNT(EPISODE_ID) AS EPISODE_ID_filled,
    COUNT(ELEMENT_ID) AS ELEMENT_ID_filled
FROM SMRTDTA_ELEM_EPISODE;

-- ==========================================================
-- Table: SMRTDTA_ELEM_EPISODE_GRP
-- This table is a bridge between episode group context SmartData element values and the source episode records.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(HLV_ID) AS HLV_ID_filled,
    COUNT(EPISODE_ID) AS EPISODE_ID_filled,
    COUNT(ELEMENT_ID) AS ELEMENT_ID_filled
FROM SMRTDTA_ELEM_EPISODE_GRP;

-- ==========================================================
-- Table: SMRTDTA_ELEM_FIN_ASST_CAS
-- This table is a bridge between finacial assistance case context SmartData element values and the source case records.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(HLV_ID) AS HLV_ID_filled,
    COUNT(FIN_ASST_CASE_ID) AS FIN_ASST_CASE_ID_filled,
    COUNT(ELEMENT_ID) AS ELEMENT_ID_filled
FROM SMRTDTA_ELEM_FIN_ASST_CAS;

-- ==========================================================
-- Table: SMRTDTA_ELEM_HISTORY
-- This table is a bridge between history context SmartData element values and the source patient history contacts.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(HLV_ID) AS HLV_ID_filled,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(PAT_ID) AS PAT_ID_filled,
    COUNT(ELEMENT_ID) AS ELEMENT_ID_filled
FROM SMRTDTA_ELEM_HISTORY;

-- ==========================================================
-- Table: SMRTDTA_ELEM_INFERT_CYCLE
-- This table is a bridge between infertility cycle context SmartData element values and the source cycle records.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(HLV_ID) AS HLV_ID_filled,
    COUNT(CYCLE_ID) AS CYCLE_ID_filled,
    COUNT(ELEMENT_ID) AS ELEMENT_ID_filled
FROM SMRTDTA_ELEM_INFERT_CYCLE;

-- ==========================================================
-- Table: SMRTDTA_ELEM_LAB_RESULT
-- This table is a bridge between SmartData element values and the source result records. Currently only being used for Fertility purposes.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(HLV_ID) AS HLV_ID_filled,
    COUNT(ELEMENT_ID) AS ELEMENT_ID_filled,
    COUNT(RESULT_ID) AS RESULT_ID_filled
FROM SMRTDTA_ELEM_LAB_RESULT;

-- ==========================================================
-- Table: SMRTDTA_ELEM_NOTE
-- This table is a bridge between note context SmartData element values and the source note records.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(HLV_ID) AS HLV_ID_filled,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(ELEMENT_ID) AS ELEMENT_ID_filled
FROM SMRTDTA_ELEM_NOTE;

-- ==========================================================
-- Table: SMRTDTA_ELEM_ORDER
-- This table is a bridge between order context SmartData element values and the source order records.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(HLV_ID) AS HLV_ID_filled,
    COUNT(ORDER_ID) AS ORDER_ID_filled,
    COUNT(ELEMENT_ID) AS ELEMENT_ID_filled
FROM SMRTDTA_ELEM_ORDER;

-- ==========================================================
-- Table: SMRTDTA_ELEM_ORGAN
-- This table is a bridge between organ context SmartData element values and the source organ records.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(HLV_ID) AS HLV_ID_filled,
    COUNT(ORG_RECORD_ID) AS ORG_RECORD_ID_filled,
    COUNT(ELEMENT_ID) AS ELEMENT_ID_filled
FROM SMRTDTA_ELEM_ORGAN;

-- ==========================================================
-- Table: SMRTDTA_ELEM_PATIENT
-- This table is a bridge between patient context SmartData element values and the source patient records.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(HLV_ID) AS HLV_ID_filled,
    COUNT(PAT_ID) AS PAT_ID_filled,
    COUNT(ELEMENT_ID) AS ELEMENT_ID_filled
FROM SMRTDTA_ELEM_PATIENT;

-- ==========================================================
-- Table: SMRTDTA_ELEM_PAT_ENTERED
-- This table is a bridge between patient entered context SmartData element values and the source patient records.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(HLV_ID) AS HLV_ID_filled,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(PAT_ID) AS PAT_ID_filled,
    COUNT(ELEMENT_ID) AS ELEMENT_ID_filled
FROM SMRTDTA_ELEM_PAT_ENTERED;

-- ==========================================================
-- Table: SMRTDTA_ELEM_PROBLEM
-- This table is a bridge between problem context SmartData element values and the source problem list records.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(HLV_ID) AS HLV_ID_filled,
    COUNT(PROBLEM_LIST_ID) AS PROBLEM_LIST_ID_filled,
    COUNT(ELEMENT_ID) AS ELEMENT_ID_filled
FROM SMRTDTA_ELEM_PROBLEM;

-- ==========================================================
-- Table: SMRTDTA_ELEM_REGISTRY
-- This table is a bridge between registry context SmartData element values and the source registry data records.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(HLV_ID) AS HLV_ID_filled,
    COUNT(REGISTRY_DATA_ID) AS REGISTRY_DATA_ID_filled,
    COUNT(ELEMENT_ID) AS ELEMENT_ID_filled
FROM SMRTDTA_ELEM_REGISTRY;

-- ==========================================================
-- Table: SMRTDTA_ELEM_RESULT
-- This table is a bridge between result context SmartData element values and the source result records.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(HLV_ID) AS HLV_ID_filled,
    COUNT(FINDING_ID) AS FINDING_ID_filled,
    COUNT(ELEMENT_ID) AS ELEMENT_ID_filled
FROM SMRTDTA_ELEM_RESULT;

-- ==========================================================
-- Table: SMRTDTA_ELEM_RESULT_CNCT
-- This table is a bridge between result contact context SmartData element values and the source result record contacts.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(HLV_ID) AS HLV_ID_filled,
    COUNT(FINDING_CSN_ID) AS FINDING_CSN_ID_filled,
    COUNT(FINDING_ID) AS FINDING_ID_filled,
    COUNT(ELEMENT_ID) AS ELEMENT_ID_filled
FROM SMRTDTA_ELEM_RESULT_CNCT;

-- ==========================================================
-- Table: SMRTDTA_ELEM_STAGE
-- This table is a bridge between stage context SmartData element values and the source stage records.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(HLV_ID) AS HLV_ID_filled,
    COUNT(STAGE_ID) AS STAGE_ID_filled,
    COUNT(ELEMENT_ID) AS ELEMENT_ID_filled
FROM SMRTDTA_ELEM_STAGE;

-- ==========================================================
-- Table: SMRTDTA_ELEM_SYNOPTIC
-- This table is a bridge between synoptic context SmartData element values and the source synoptic records.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(HLV_ID) AS HLV_ID_filled,
    COUNT(SYNOPTIC_ID) AS SYNOPTIC_ID_filled,
    COUNT(ELEMENT_ID) AS ELEMENT_ID_filled
FROM SMRTDTA_ELEM_SYNOPTIC;

-- ==========================================================
-- Table: SMRTDTA_ELEM_WAITING_LST
-- This table is a bridge between Waiting List context SmartData element values and the source Waiting List records.
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(HLV_ID) AS HLV_ID_filled,
    COUNT(WAITING_LIST_ID) AS WAITING_LIST_ID_filled,
    COUNT(ELEMENT_ID) AS ELEMENT_ID_filled
FROM SMRTDTA_ELEM_WAITING_LST;

-- ==========================================================
-- Table: SUBSCRIBER_ADDR_MSG
-- This table contains the address validation messages for the subscriber address.
-- Bucket(s): administrative/non-clinical (comment fields, billing/coverage/referral/etc.)
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(COVERAGE_ID) AS COVERAGE_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(ADDR_VALIDATION_MESSAGE) AS ADDR_VALIDATION_MESSAGE_filled
FROM SUBSCRIBER_ADDR_MSG;

-- ==========================================================
-- Table: TX_ADDENDUM_NOTES
-- Extract Note (HNO) records containing addendum information for the note.
-- Bucket(s): addendum
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(NOTE_CSN_ID) AS NOTE_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NOTE_ID) AS NOTE_ID_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(TX_ADDENDUM_NOTE_ID) AS TX_ADDENDUM_NOTE_ID_filled
FROM TX_ADDENDUM_NOTES
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: V_EHI_SMRTDTA_ELEM_VAL_EXT
-- This view contains current values for SmartData elements, includes an external formatted value column, and an Electronic Health Information column descriptor column for values that reference records w
-- Bucket(s): smart-tool usage (SmartText/SmartForm/SmartBlock)
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(HLV_ID) AS HLV_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(SMRTDTA_ELEM_VALUE) AS SMRTDTA_ELEM_VALUE_filled,
    COUNT(SMRTDTA_ELEM_VALUE_EXTERNAL) AS SMRTDTA_ELEM_VALUE_EXTERNAL_filled,
    COUNT(COLUMN_DESCRIPTOR) AS COLUMN_DESCRIPTOR_filled
FROM V_EHI_SMRTDTA_ELEM_VAL_EXT;
