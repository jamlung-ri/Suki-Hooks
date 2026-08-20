-- CM-21 field feasibility / density queries
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
-- Table: ACCUM_CLAIM_DIAGNOSES
-- This table contains diagnoses attached to a claim when an accumulation occurred.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(ACCUMULATION_ID) AS ACCUMULATION_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(CLAIM_DX_ID_DX_NAME) AS CLAIM_DX_ID_DX_NAME_filled
FROM ACCUM_CLAIM_DIAGNOSES;

-- ==========================================================
-- Table: ACCUM_SERVICE_DIAGNOSES
-- This table contains diagnoses associated with a service at the time an accumulation occurred.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(ACCUMULATION_ID) AS ACCUMULATION_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(ASSOCIATED_DX_ID_DX_NAME) AS ASSOCIATED_DX_ID_DX_NAME_filled
FROM ACCUM_SERVICE_DIAGNOSES;

-- ==========================================================
-- Table: ADDITIONAL_EM_CODE
-- This table holds all information related to additional evaluation and management (E/M) codes.
-- Bucket(s): E/M level / CPT coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(EM_CODE_ADDL_ID_PROC_NAME) AS EM_CODE_ADDL_ID_PROC_NAME_filled,
    COUNT(EM_CODE_MOD_ID) AS EM_CODE_MOD_ID_filled,
    COUNT(EM_CODE_BILPROV_ID_PROV_NAME) AS EM_CODE_BILPROV_ID_PROV_NAME_filled,
    COUNT(EM_CODE_UNIQUE_NUM) AS EM_CODE_UNIQUE_NUM_filled,
    COUNT(EM_NO_CHG_REASON_C_NAME) AS EM_NO_CHG_REASON_C_NAME_filled,
    COUNT(AR_EM_CODE_DX) AS AR_EM_CODE_DX_filled
FROM ADDITIONAL_EM_CODE;

-- ==========================================================
-- Table: ALT_PRC_DIAGNOSES
-- Diagnoses that are associated with Drug-Disease alerts.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(ALERT_ID) AS ALERT_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(PRC_DIAGNOSES_ID_DX_NAME) AS PRC_DIAGNOSES_ID_DX_NAME_filled
FROM ALT_PRC_DIAGNOSES
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: ANTICOAG_TRTMNT_DX
-- This table tracks anticoagulation therapy medications taken prior to diagnosis.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(PROBLEM_LIST_ID) AS PROBLEM_LIST_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(ANTICOAG_PRE_DX_C_NAME) AS ANTICOAG_PRE_DX_C_NAME_filled
FROM ANTICOAG_TRTMNT_DX;

-- ==========================================================
-- Table: APPEAL_GRV
-- This table contains information about an individual appeal or grievance.
-- Bucket(s): Claims / Denials
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(APPEAL_GRV_ID) AS APPEAL_GRV_ID_filled,
    COUNT(CM_PHY_OWNER_ID) AS CM_PHY_OWNER_ID_filled,
    COUNT(CM_LOG_OWNER_ID) AS CM_LOG_OWNER_ID_filled,
    COUNT(RECORD_STATUS_C_NAME) AS RECORD_STATUS_C_NAME_filled,
    COUNT(APPEAL_GRV_TYPE_C_NAME) AS APPEAL_GRV_TYPE_C_NAME_filled,
    COUNT(SERIES_IDENTIFIER) AS SERIES_IDENTIFIER_filled,
    COUNT(EXTERNAL_IDENTIFIER) AS EXTERNAL_IDENTIFIER_filled,
    COUNT(INITIATED_BY_TYPE_C_NAME) AS INITIATED_BY_TYPE_C_NAME_filled,
    COUNT(INITIATING_PROV_ID_PROV_NAME) AS INITIATING_PROV_ID_PROV_NAME_filled,
    COUNT(INITIATING_REP_MEM_RESP_GUID) AS INITIATING_REP_MEM_RESP_GUID_filled,
    COUNT(SUBMISSION_METHOD_C_NAME) AS SUBMISSION_METHOD_C_NAME_filled,
    COUNT(REVIEW_LEVEL_C_NAME) AS REVIEW_LEVEL_C_NAME_filled,
    COUNT(PAT_ID) AS PAT_ID_filled,
    COUNT(APPEAL_SUBJECT_TYPE_C_NAME) AS APPEAL_SUBJECT_TYPE_C_NAME_filled,
    COUNT(SUBJECT_AUTH_REQUEST_ID) AS SUBJECT_AUTH_REQUEST_ID_filled,
    COUNT(SUBJECT_CLAIM_ID) AS SUBJECT_CLAIM_ID_filled,
    COUNT(RESULT_AUTH_REQUEST_ID) AS RESULT_AUTH_REQUEST_ID_filled,
    COUNT(RESULT_CLAIM_ID) AS RESULT_CLAIM_ID_filled,
    COUNT(RECORD_CREATE_UTC_DTTM) AS RECORD_CREATE_UTC_DTTM_filled,
    COUNT(RECORD_CREATE_USER_ID) AS RECORD_CREATE_USER_ID_filled,
    COUNT(RECORD_CREATE_USER_ID_NAME) AS RECORD_CREATE_USER_ID_NAME_filled,
    COUNT(URGENCY_C_NAME) AS URGENCY_C_NAME_filled,
    COUNT(SUBMISSION_OVRIDE_UTC_DTTM) AS SUBMISSION_OVRIDE_UTC_DTTM_filled,
    COUNT(DECISION_SYS_UTC_DTTM) AS DECISION_SYS_UTC_DTTM_filled,
    COUNT(DECISION_USER_ID) AS DECISION_USER_ID_filled,
    COUNT(DECISION_USER_ID_NAME) AS DECISION_USER_ID_NAME_filled,
    COUNT(DECISION_OVRIDE_UTC_DTTM) AS DECISION_OVRIDE_UTC_DTTM_filled,
    COUNT(APPEAL_DECISION_C_NAME) AS APPEAL_DECISION_C_NAME_filled,
    COUNT(TIMEFRAME_START_UTC_DTTM) AS TIMEFRAME_START_UTC_DTTM_filled,
    COUNT(SUBMISSION_RPT_UTC_DTTM) AS SUBMISSION_RPT_UTC_DTTM_filled,
    COUNT(SUBMISSION_SYS_UTC_DTTM) AS SUBMISSION_SYS_UTC_DTTM_filled,
    COUNT(EXP_REQ_REC_UTC_DTTM) AS EXP_REQ_REC_UTC_DTTM_filled,
    COUNT(WAS_UPGRADED_TO_EXP_YN) AS WAS_UPGRADED_TO_EXP_YN_filled,
    COUNT(EXP_REQ_DEC_UTC_DTTM) AS EXP_REQ_DEC_UTC_DTTM_filled,
    COUNT(EXT_REQ_REC_UTC_DTTM) AS EXT_REQ_REC_UTC_DTTM_filled,
    COUNT(EXT_DAYS) AS EXT_DAYS_filled,
    COUNT(EXT_REQ_DEC_UTC_DTTM) AS EXT_REQ_DEC_UTC_DTTM_filled,
    COUNT(EXT_MAX_DAYS) AS EXT_MAX_DAYS_filled,
    COUNT(EFFECT_SYS_UTC_DTTM) AS EFFECT_SYS_UTC_DTTM_filled,
    COUNT(EFFECT_OVR_UTC_DTTM) AS EFFECT_OVR_UTC_DTTM_filled,
    COUNT(EFFECT_RPT_UTC_DTTM) AS EFFECT_RPT_UTC_DTTM_filled,
    COUNT(EFFECT_DUE_UTC_DTTM) AS EFFECT_DUE_UTC_DTTM_filled,
    COUNT(OVERALL_DUE_UTC_DTTM) AS OVERALL_DUE_UTC_DTTM_filled,
    COUNT(DECISION_RPT_UTC_DTTM) AS DECISION_RPT_UTC_DTTM_filled,
    COUNT(DECISION_DUE_UTC_DTTM) AS DECISION_DUE_UTC_DTTM_filled,
    COUNT(TAT_SYS_TIME_ZONE_C_NAME) AS TAT_SYS_TIME_ZONE_C_NAME_filled,
    COUNT(TAT_OVR_TIME_ZONE_C_NAME) AS TAT_OVR_TIME_ZONE_C_NAME_filled,
    COUNT(TAT_RPT_TIME_ZONE_C_NAME) AS TAT_RPT_TIME_ZONE_C_NAME_filled,
    COUNT(TIMEFRAME_START_LOCAL_DTTM) AS TIMEFRAME_START_LOCAL_DTTM_filled,
    COUNT(SUBMISSION_SYS_LOCAL_DTTM) AS SUBMISSION_SYS_LOCAL_DTTM_filled,
    COUNT(SUBMISSION_OVR_LOCAL_DTTM) AS SUBMISSION_OVR_LOCAL_DTTM_filled,
    COUNT(SUBMISSION_RPT_LOCAL_DTTM) AS SUBMISSION_RPT_LOCAL_DTTM_filled,
    COUNT(EXP_REQ_REC_LOCAL_DTTM) AS EXP_REQ_REC_LOCAL_DTTM_filled,
    COUNT(EXP_DEC_LOCAL_DTTM) AS EXP_DEC_LOCAL_DTTM_filled,
    COUNT(EXT_REQ_LOCAL_DTTM) AS EXT_REQ_LOCAL_DTTM_filled,
    COUNT(EXT_DEC_LOCAL_DTTM) AS EXT_DEC_LOCAL_DTTM_filled,
    COUNT(EFFECT_SYS_LOCAL_DTTM) AS EFFECT_SYS_LOCAL_DTTM_filled,
    COUNT(EFFECT_OVR_LOCAL_DTTM) AS EFFECT_OVR_LOCAL_DTTM_filled,
    COUNT(EFFECT_RPT_LOCAL_DTTM) AS EFFECT_RPT_LOCAL_DTTM_filled,
    COUNT(EFFECT_DUE_LOCAL_DTTM) AS EFFECT_DUE_LOCAL_DTTM_filled,
    COUNT(OVERALL_DUE_LOCAL_DTTM) AS OVERALL_DUE_LOCAL_DTTM_filled,
    COUNT(DECISION_LOCAL_DTTM) AS DECISION_LOCAL_DTTM_filled,
    COUNT(DECISION_OVR_LOCAL_DTTM) AS DECISION_OVR_LOCAL_DTTM_filled,
    COUNT(DECISION_RPT_LOCAL_DTTM) AS DECISION_RPT_LOCAL_DTTM_filled,
    COUNT(DECISION_DUE_LOCAL_DTTM) AS DECISION_DUE_LOCAL_DTTM_filled,
    COUNT(GRIEVANCE_SUBJECT_TYPE_C_NAME) AS GRIEVANCE_SUBJECT_TYPE_C_NAME_filled,
    COUNT(REASON_FOR_GRIEVANCE_C_NAME) AS REASON_FOR_GRIEVANCE_C_NAME_filled,
    COUNT(SUBJECT_APPEAL_APPEAL_GRV_ID) AS SUBJECT_APPEAL_APPEAL_GRV_ID_filled,
    COUNT(SUBJECT_GRIEVANC_APPEAL_GRV_ID) AS SUBJECT_GRIEVANC_APPEAL_GRV_ID_filled,
    COUNT(SUBJECT_PROV_ID_PROV_NAME) AS SUBJECT_PROV_ID_PROV_NAME_filled,
    COUNT(SUBJECT_FACILITY_ID_LOC_NAME) AS SUBJECT_FACILITY_ID_LOC_NAME_filled,
    COUNT(SUBJECT_EMPLOYEE_USER_ID) AS SUBJECT_EMPLOYEE_USER_ID_filled,
    COUNT(SUBJECT_EMPLOYEE_USER_ID_NAME) AS SUBJECT_EMPLOYEE_USER_ID_NAME_filled,
    COUNT(SUBJECT_RESOURCE_PROV_ID_PROV_NAME) AS SUBJECT_RESOURCE_PROV_ID_PROV_NAME_filled,
    COUNT(SUBJECT_LOC_ID_LOC_NAME) AS SUBJECT_LOC_ID_LOC_NAME_filled,
    COUNT(SUBJECT_POS_ID_LOC_NAME) AS SUBJECT_POS_ID_LOC_NAME_filled,
    COUNT(SUBJECT_BUS_SEG_POS_ID_LOC_NAME) AS SUBJECT_BUS_SEG_POS_ID_LOC_NAME_filled,
    COUNT(SUBJECT_REGION_ID_LOC_NAME) AS SUBJECT_REGION_ID_LOC_NAME_filled,
    COUNT(SUBJECT_GROUP_ID_LOC_NAME) AS SUBJECT_GROUP_ID_LOC_NAME_filled,
    COUNT(SUBJECT_COVERAGE_ID) AS SUBJECT_COVERAGE_ID_filled,
    COUNT(GRIEVANCE_INCIDENT_UTC_DTTM) AS GRIEVANCE_INCIDENT_UTC_DTTM_filled,
    COUNT(GRIEVANCE_INCIDENT_LOCAL_DTTM) AS GRIEVANCE_INCIDENT_LOCAL_DTTM_filled,
    COUNT(EXTENSION_INITIATED_BY_TYPE_C_NAME) AS EXTENSION_INITIATED_BY_TYPE_C_NAME_filled,
    COUNT(DECISION_OVR_USER_ID) AS DECISION_OVR_USER_ID_filled,
    COUNT(DECISION_OVR_USER_ID_NAME) AS DECISION_OVR_USER_ID_NAME_filled,
    COUNT(DECISION_RPT_USER_ID) AS DECISION_RPT_USER_ID_filled,
    COUNT(DECISION_RPT_USER_ID_NAME) AS DECISION_RPT_USER_ID_NAME_filled,
    COUNT(LATE_FILING_RCV_UTC_DTTM) AS LATE_FILING_RCV_UTC_DTTM_filled,
    COUNT(FILED_ON_TIME_C_NAME) AS FILED_ON_TIME_C_NAME_filled,
    COUNT(AG_REVIEW_TYPE_C_NAME) AS AG_REVIEW_TYPE_C_NAME_filled,
    COUNT(REVIEW_AGENCY_ID) AS REVIEW_AGENCY_ID_filled,
    COUNT(REVIEW_AGENCY_ID_AGENCY_NAME) AS REVIEW_AGENCY_ID_AGENCY_NAME_filled,
    COUNT(CASE_SENT_REVW_ENTITY_UTC_DTTM) AS CASE_SENT_REVW_ENTITY_UTC_DTTM_filled,
    COUNT(CASE_SENT_REVW_ENTY_LOCAL_DTTM) AS CASE_SENT_REVW_ENTY_LOCAL_DTTM_filled,
    COUNT(COVERAGE_ID) AS COVERAGE_ID_filled,
    COUNT(PAYER_ID_PAYOR_NAME) AS PAYER_ID_PAYOR_NAME_filled,
    COUNT(BENEFIT_PLAN_ID_BENEFIT_PLAN_NAME) AS BENEFIT_PLAN_ID_BENEFIT_PLAN_NAME_filled,
    COUNT(LOB_ID) AS LOB_ID_filled,
    COUNT(LOB_ID_LOB_NAME) AS LOB_ID_LOB_NAME_filled,
    COUNT(MC_PEER_GROUP_C_NAME) AS MC_PEER_GROUP_C_NAME_filled,
    COUNT(REGION_ID_LOC_NAME) AS REGION_ID_LOC_NAME_filled,
    COUNT(MEDICAL_GROUP_ID_LOC_NAME) AS MEDICAL_GROUP_ID_LOC_NAME_filled,
    COUNT(SUBJECT_FREE_TEXT) AS SUBJECT_FREE_TEXT_filled
FROM APPEAL_GRV;

-- ==========================================================
-- Table: APPEAL_GRV_2
-- This table contains information about an individual appeal or grievance as an extension of APPEAL_GRV.
-- Bucket(s): Claims / Denials
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(APPEAL_GRV_ID) AS APPEAL_GRV_ID_filled,
    COUNT(NEXT_OUTST_DECISION_UTC_DTTM) AS NEXT_OUTST_DECISION_UTC_DTTM_filled,
    COUNT(NEXT_OUTST_DECISION_LOCAL_DTTM) AS NEXT_OUTST_DECISION_LOCAL_DTTM_filled,
    COUNT(NEXT_OUTST_EFFECT_UTC_DTTM) AS NEXT_OUTST_EFFECT_UTC_DTTM_filled,
    COUNT(NEXT_OUTST_EFFECT_LOCAL_DTTM) AS NEXT_OUTST_EFFECT_LOCAL_DTTM_filled,
    COUNT(NEXT_OUTST_NOTIF_UTC_DTTM) AS NEXT_OUTST_NOTIF_UTC_DTTM_filled,
    COUNT(NEXT_OUTST_NOTIF_LOCAL_DTTM) AS NEXT_OUTST_NOTIF_LOCAL_DTTM_filled,
    COUNT(REQUIREMENTS_COMP_UTC_DTTM) AS REQUIREMENTS_COMP_UTC_DTTM_filled,
    COUNT(REQUIREMENTS_COMP_LOCAL_DTTM) AS REQUIREMENTS_COMP_LOCAL_DTTM_filled,
    COUNT(DECISION_ON_TIME_C_NAME) AS DECISION_ON_TIME_C_NAME_filled,
    COUNT(EFFECTUATION_ON_TIME_C_NAME) AS EFFECTUATION_ON_TIME_C_NAME_filled,
    COUNT(NOTIFICATIONS_ON_TIME_C_NAME) AS NOTIFICATIONS_ON_TIME_C_NAME_filled,
    COUNT(OVERALL_ON_TIME_C_NAME) AS OVERALL_ON_TIME_C_NAME_filled,
    COUNT(APPEAL_GRV_WKFL_STEP_C_NAME) AS APPEAL_GRV_WKFL_STEP_C_NAME_filled,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(FILED_LATE_EXCPTNS_ALLOWED_YN) AS FILED_LATE_EXCPTNS_ALLOWED_YN_filled,
    COUNT(FILED_LATE_OVERRIDE_YN) AS FILED_LATE_OVERRIDE_YN_filled,
    COUNT(DISMISSED_YN) AS DISMISSED_YN_filled,
    COUNT(NEXT_OUTST_ACTION_UTC_DTTM) AS NEXT_OUTST_ACTION_UTC_DTTM_filled,
    COUNT(NEXT_OUTST_ACTION_LOCAL_DTTM) AS NEXT_OUTST_ACTION_LOCAL_DTTM_filled,
    COUNT(CURRENT_REQUESTED_URGENCY_C_NAME) AS CURRENT_REQUESTED_URGENCY_C_NAME_filled,
    COUNT(REQUESTED_EXP_PROCESSED_STD_YN) AS REQUESTED_EXP_PROCESSED_STD_YN_filled,
    COUNT(MEM_OUT_ORAL_NOTIF_UTC_DTTM) AS MEM_OUT_ORAL_NOTIF_UTC_DTTM_filled,
    COUNT(MEM_OUT_ORAL_NOTIF_LOCAL_DTTM) AS MEM_OUT_ORAL_NOTIF_LOCAL_DTTM_filled,
    COUNT(MEM_OUT_WRIT_NOTIF_UTC_DTTM) AS MEM_OUT_WRIT_NOTIF_UTC_DTTM_filled,
    COUNT(MEM_OUT_WRIT_NOTIF_LOCAL_DTTM) AS MEM_OUT_WRIT_NOTIF_LOCAL_DTTM_filled,
    COUNT(QUEUED_COMPLETE_USER_ID) AS QUEUED_COMPLETE_USER_ID_filled,
    COUNT(QUEUED_COMPLETE_USER_ID_NAME) AS QUEUED_COMPLETE_USER_ID_NAME_filled,
    COUNT(COMPLETED_UTC_DTTM) AS COMPLETED_UTC_DTTM_filled,
    COUNT(COMPLETED_LOCAL_DTTM) AS COMPLETED_LOCAL_DTTM_filled,
    COUNT(PROCESSING_TYPE_C_NAME) AS PROCESSING_TYPE_C_NAME_filled,
    COUNT(AG_CREATION_METHOD_C_NAME) AS AG_CREATION_METHOD_C_NAME_filled,
    COUNT(REQ_ADDL_REVIEW_C_NAME) AS REQ_ADDL_REVIEW_C_NAME_filled,
    COUNT(SUGGESTED_APPEAL_DECISION_C_NAME) AS SUGGESTED_APPEAL_DECISION_C_NAME_filled,
    COUNT(SUGGESTED_DECISION_USER_ID) AS SUGGESTED_DECISION_USER_ID_filled,
    COUNT(SUGGESTED_DECISION_USER_ID_NAME) AS SUGGESTED_DECISION_USER_ID_NAME_filled,
    COUNT(SUGGESTED_DECISION_UTC_DTTM) AS SUGGESTED_DECISION_UTC_DTTM_filled,
    COUNT(SUGGESTED_DECISION_LOCAL_DTTM) AS SUGGESTED_DECISION_LOCAL_DTTM_filled,
    COUNT(EDITED_AFTER_COMPLETION_YN) AS EDITED_AFTER_COMPLETION_YN_filled,
    COUNT(DECISION_LOGIN_DEPARTMENT_ID_EXTERNAL_NAME) AS DECISION_LOGIN_DEPARTMENT_ID_EXTERNAL_NAME_filled,
    COUNT(SUGGESTED_DECISION_DEPT_ID_EXTERNAL_NAME) AS SUGGESTED_DECISION_DEPT_ID_EXTERNAL_NAME_filled,
    COUNT(MEDICARE_CVG_TYP_C_NAME) AS MEDICARE_CVG_TYP_C_NAME_filled,
    COUNT(IS_PART_B_DRUG_YN) AS IS_PART_B_DRUG_YN_filled,
    COUNT(LATE_FILING_RCV_LOCAL_DTTM) AS LATE_FILING_RCV_LOCAL_DTTM_filled,
    COUNT(REQUESTING_REP_DOCUMENT_REQ_YN) AS REQUESTING_REP_DOCUMENT_REQ_YN_filled,
    COUNT(CASE_FILE_DUE_UTC_DTTM) AS CASE_FILE_DUE_UTC_DTTM_filled,
    COUNT(CASE_FILE_DUE_LOCAL_DTTM) AS CASE_FILE_DUE_LOCAL_DTTM_filled,
    COUNT(APPEAL_ORIG_DENIAL_RSN_C_NAME) AS APPEAL_ORIG_DENIAL_RSN_C_NAME_filled,
    COUNT(NEXT_OUTST_CASE_FWD_UTC_DTTM) AS NEXT_OUTST_CASE_FWD_UTC_DTTM_filled,
    COUNT(NEXT_OUTST_CASE_FWD_LOCAL_DTTM) AS NEXT_OUTST_CASE_FWD_LOCAL_DTTM_filled,
    COUNT(CASE_FILE_ON_TIME_C_NAME) AS CASE_FILE_ON_TIME_C_NAME_filled,
    COUNT(FILED_LATE_REPORTABLE_YN) AS FILED_LATE_REPORTABLE_YN_filled,
    COUNT(RECORD_CREATE_LOCAL_DTTM) AS RECORD_CREATE_LOCAL_DTTM_filled,
    COUNT(PROCESS_AS_FORMAL_GRIEVANCE_YN) AS PROCESS_AS_FORMAL_GRIEVANCE_YN_filled,
    COUNT(UPGRADE_TO_FORMAL_UTC_DTTM) AS UPGRADE_TO_FORMAL_UTC_DTTM_filled,
    COUNT(UPGRADE_TO_FORMAL_LOCAL_DTTM) AS UPGRADE_TO_FORMAL_LOCAL_DTTM_filled,
    COUNT(AG_FORMALITY_C_NAME) AS AG_FORMALITY_C_NAME_filled,
    COUNT(UPGRD_FRML_OCCR_UTC_DTTM) AS UPGRD_FRML_OCCR_UTC_DTTM_filled,
    COUNT(UPGRD_FRML_OCCR_LOC_DTTM) AS UPGRD_FRML_OCCR_LOC_DTTM_filled,
    COUNT(TAG_SOURCE_TYPE_C_NAME) AS TAG_SOURCE_TYPE_C_NAME_filled,
    COUNT(APPEAL_EXCEPTION_TYPE_C_NAME) AS APPEAL_EXCEPTION_TYPE_C_NAME_filled,
    COUNT(INITIATING_POS_ID_LOC_NAME) AS INITIATING_POS_ID_LOC_NAME_filled,
    COUNT(REQUESTING_PROV_ADDRESSID) AS REQUESTING_PROV_ADDRESSID_filled,
    COUNT(SUBJECT_PROV_ADDRESSID) AS SUBJECT_PROV_ADDRESSID_filled
FROM APPEAL_GRV_2;

-- ==========================================================
-- Table: APPEAL_GRV_APPEAL_REASONS
-- The reasons for which an appeal was initiated.
-- Bucket(s): Claims / Denials
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(APPEAL_GRV_ID) AS APPEAL_GRV_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(APPEAL_CREATE_REASONS_C_NAME) AS APPEAL_CREATE_REASONS_C_NAME_filled
FROM APPEAL_GRV_APPEAL_REASONS;

-- ==========================================================
-- Table: APPEAL_GRV_AUDIT_TRAIL
-- This table contains the audit trail of item value changes for an appeal/grievance record.
-- Bucket(s): Claims / Denials
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(APPEAL_GRV_ID) AS APPEAL_GRV_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(AUDIT_TRAIL_TYPE_C_NAME) AS AUDIT_TRAIL_TYPE_C_NAME_filled,
    COUNT(DOCUMENT_ID) AS DOCUMENT_ID_filled
FROM APPEAL_GRV_AUDIT_TRAIL;

-- ==========================================================
-- Table: APPEAL_GRV_CHANGE_URGENCY
-- Stores the change urgency requests for an appeal/grievance. Each row represents a change urgency request.
-- Bucket(s): Claims / Denials
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(APPEAL_GRV_ID) AS APPEAL_GRV_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(REQUESTED_URGENCY_C_NAME) AS REQUESTED_URGENCY_C_NAME_filled,
    COUNT(REQUEST_UTC_DTTM) AS REQUEST_UTC_DTTM_filled,
    COUNT(REQUEST_LOCAL_DTTM) AS REQUEST_LOCAL_DTTM_filled,
    COUNT(INITIATED_BY_TYPE_C_NAME) AS INITIATED_BY_TYPE_C_NAME_filled,
    COUNT(URGENCY_COMMENTS) AS URGENCY_COMMENTS_filled,
    COUNT(URGENCY_DECISION_C_NAME) AS URGENCY_DECISION_C_NAME_filled
FROM APPEAL_GRV_CHANGE_URGENCY;

-- ==========================================================
-- Table: APPEAL_GRV_DSMISS_REASONS
-- Stores the reasons an appeal or grievance was dismissed.
-- Bucket(s): Claims / Denials
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(APPEAL_GRV_ID) AS APPEAL_GRV_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(DISMISS_REASON_C_NAME) AS DISMISS_REASON_C_NAME_filled
FROM APPEAL_GRV_DSMISS_REASONS;

-- ==========================================================
-- Table: APPEAL_GRV_LATE_FILE_RSNS
-- Stores the reasons for late filing for an appeal/grievance.
-- Bucket(s): Claims / Denials
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(APPEAL_GRV_ID) AS APPEAL_GRV_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(LATE_FILING_RSN_C_NAME) AS LATE_FILING_RSN_C_NAME_filled
FROM APPEAL_GRV_LATE_FILE_RSNS;

-- ==========================================================
-- Table: APPEAL_GRV_LETTER
-- Letters that were sent or were attempted to have been sent from an appeal or grievance record.
-- Bucket(s): Claims / Denials
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(APPEAL_GRV_ID) AS APPEAL_GRV_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(CM_PHY_OWNER_ID) AS CM_PHY_OWNER_ID_filled,
    COUNT(LETTER_SENT_DOCUMENT_ID) AS LETTER_SENT_DOCUMENT_ID_filled,
    COUNT(APPEAL_GRV_LETTER_STS_C_NAME) AS APPEAL_GRV_LETTER_STS_C_NAME_filled,
    COUNT(LETTER_GUID) AS LETTER_GUID_filled,
    COUNT(APPEAL_GRV_LETTER_TYPE_C_NAME) AS APPEAL_GRV_LETTER_TYPE_C_NAME_filled,
    COUNT(RECIPIENT_CLASS_EVENT_ID) AS RECIPIENT_CLASS_EVENT_ID_filled,
    COUNT(RECIPIENT_CLASS_EVENT_ID_EVENT_NAME) AS RECIPIENT_CLASS_EVENT_ID_EVENT_NAME_filled,
    COUNT(RESOLVED_FEV_SEND_TO_C_NAME) AS RESOLVED_FEV_SEND_TO_C_NAME_filled,
    COUNT(RESOLVED_RECIPIENT_INI) AS RESOLVED_RECIPIENT_INI_filled,
    COUNT(RESOLVED_RECIPIENT_ID) AS RESOLVED_RECIPIENT_ID_filled,
    COUNT(RESOLVED_RECIPIENT_GUID) AS RESOLVED_RECIPIENT_GUID_filled,
    COUNT(DELIVERY_LOGIC_C_NAME) AS DELIVERY_LOGIC_C_NAME_filled,
    COUNT(RESOLVED_FEV_DLVR_MTHD_C_NAME) AS RESOLVED_FEV_DLVR_MTHD_C_NAME_filled,
    COUNT(BATCH_PRINT_LTR_HX_JOB_TYPE_C_NAME) AS BATCH_PRINT_LTR_HX_JOB_TYPE_C_NAME_filled,
    COUNT(BODY_SMARTTEXT_ID) AS BODY_SMARTTEXT_ID_filled,
    COUNT(BODY_SMARTTEXT_ID_SMARTTEXT_NAME) AS BODY_SMARTTEXT_ID_SMARTTEXT_NAME_filled,
    COUNT(COVER_SMARTTEXT_ID) AS COVER_SMARTTEXT_ID_filled,
    COUNT(COVER_SMARTTEXT_ID_SMARTTEXT_NAME) AS COVER_SMARTTEXT_ID_SMARTTEXT_NAME_filled,
    COUNT(BACK_SMARTTEXT_ID) AS BACK_SMARTTEXT_ID_filled,
    COUNT(BACK_SMARTTEXT_ID_SMARTTEXT_NAME) AS BACK_SMARTTEXT_ID_SMARTTEXT_NAME_filled,
    COUNT(RESOLVED_IB_POOL_ID) AS RESOLVED_IB_POOL_ID_filled,
    COUNT(RESOLVED_IB_POOL_ID_REGISTRY_NAME) AS RESOLVED_IB_POOL_ID_REGISTRY_NAME_filled,
    COUNT(RESOLVED_PROV_ADDR_UNIQUE_ID) AS RESOLVED_PROV_ADDR_UNIQUE_ID_filled,
    COUNT(CITY) AS CITY_filled,
    COUNT(STATE_C_NAME) AS STATE_C_NAME_filled,
    COUNT(ZIP) AS ZIP_filled,
    COUNT(DISTRICT_C_NAME) AS DISTRICT_C_NAME_filled,
    COUNT(COUNTY_C_NAME) AS COUNTY_C_NAME_filled,
    COUNT(COUNTRY_C_NAME) AS COUNTRY_C_NAME_filled,
    COUNT(BUILDING_NUMBER) AS BUILDING_NUMBER_filled,
    COUNT(RECIPIENT_NAME) AS RECIPIENT_NAME_filled,
    COUNT(SENT_SYS_UTC_DTTM) AS SENT_SYS_UTC_DTTM_filled,
    COUNT(SENT_SYS_LOCAL_DTTM) AS SENT_SYS_LOCAL_DTTM_filled,
    COUNT(SENT_OVD_UTC_DTTM) AS SENT_OVD_UTC_DTTM_filled,
    COUNT(SENT_OVD_LOCAL_DTTM) AS SENT_OVD_LOCAL_DTTM_filled,
    COUNT(SENT_RPT_UTC_DTTM) AS SENT_RPT_UTC_DTTM_filled,
    COUNT(SENT_RPT_LOCAL_DTTM) AS SENT_RPT_LOCAL_DTTM_filled,
    COUNT(MAILED_SYS_UTC_DTTM) AS MAILED_SYS_UTC_DTTM_filled,
    COUNT(MAILED_SYS_LOCAL_DTTM) AS MAILED_SYS_LOCAL_DTTM_filled,
    COUNT(MAILED_OVR_UTC_DTTM) AS MAILED_OVR_UTC_DTTM_filled,
    COUNT(MAILED_OVR_LOCAL_DTTM) AS MAILED_OVR_LOCAL_DTTM_filled,
    COUNT(MAILED_RPT_UTC_DTTM) AS MAILED_RPT_UTC_DTTM_filled,
    COUNT(MAILED_RPT_LOCAL_DTTM) AS MAILED_RPT_LOCAL_DTTM_filled,
    COUNT(BODY_NOTE_ID) AS BODY_NOTE_ID_filled,
    COUNT(COVER_SHEET_NOTE_ID) AS COVER_SHEET_NOTE_ID_filled,
    COUNT(BACK_NOTE_ID) AS BACK_NOTE_ID_filled,
    COUNT(FAX_FACE_SHEET_NOTE_ID) AS FAX_FACE_SHEET_NOTE_ID_filled
FROM APPEAL_GRV_LETTER;

-- ==========================================================
-- Table: APPEAL_GRV_LETTER_ADDRESS
-- The address of this letter's recipient. An address may be recorded, even if the letter was not mailed.
-- Bucket(s): Claims / Denials
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(APPEAL_GRV_ID) AS APPEAL_GRV_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(STREET_ADDRESS) AS STREET_ADDRESS_filled
FROM APPEAL_GRV_LETTER_ADDRESS;

-- ==========================================================
-- Table: APPEAL_GRV_LETTER_GEN_HX
-- All successes, failures, and intermediate actions that occurred while generating letters.
-- Bucket(s): Claims / Denials
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(APPEAL_GRV_ID) AS APPEAL_GRV_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(CM_PHY_OWNER_ID) AS CM_PHY_OWNER_ID_filled,
    COUNT(HISTORY_KEY) AS HISTORY_KEY_filled,
    COUNT(LETTER_HX_GUID) AS LETTER_HX_GUID_filled,
    COUNT(APPEAL_GRV_LETTER_ACT_C_NAME) AS APPEAL_GRV_LETTER_ACT_C_NAME_filled,
    COUNT(OCCUR_UTC_DTTM) AS OCCUR_UTC_DTTM_filled,
    COUNT(COMMITTING_USER_ID) AS COMMITTING_USER_ID_filled,
    COUNT(COMMITTING_USER_ID_NAME) AS COMMITTING_USER_ID_NAME_filled,
    COUNT(LETTER_HX_COMMENT) AS LETTER_HX_COMMENT_filled
FROM APPEAL_GRV_LETTER_GEN_HX;

-- ==========================================================
-- Table: APPEAL_GRV_MAX_EXTENSION
-- This table contains information about the maximum extensions that can be taken for an appeal or grievance.
-- Bucket(s): Claims / Denials
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(APPEAL_GRV_ID) AS APPEAL_GRV_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(EXTENSION_TAT_TIME_STANDARD_C_NAME) AS EXTENSION_TAT_TIME_STANDARD_C_NAME_filled,
    COUNT(MAX_EXTENSION_DAYS) AS MAX_EXTENSION_DAYS_filled
FROM APPEAL_GRV_MAX_EXTENSION;

-- ==========================================================
-- Table: APPEAL_GRV_NOTIF_TAT
-- This table holds information about notifications that complete required turnaround time events for appeals and grievances. Each row corresponds to an individual turnaround time requirement and the com
-- Bucket(s): Claims / Denials
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(APPEAL_GRV_ID) AS APPEAL_GRV_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NOTIF_TAT_TIME_STANDARD_C_NAME) AS NOTIF_TAT_TIME_STANDARD_C_NAME_filled,
    COUNT(APPEAL_GRV_LETTER_TYPE_C_NAME) AS APPEAL_GRV_LETTER_TYPE_C_NAME_filled,
    COUNT(NOTIF_TAT_RECIP_CLASS_ID) AS NOTIF_TAT_RECIP_CLASS_ID_filled,
    COUNT(NOTIF_TAT_RECIP_CLASS_ID_EVENT_NAME) AS NOTIF_TAT_RECIP_CLASS_ID_EVENT_NAME_filled,
    COUNT(NOTIF_TAT_METHOD_C_NAME) AS NOTIF_TAT_METHOD_C_NAME_filled,
    COUNT(NOTIF_TAT_DUE_UTC_DTTM) AS NOTIF_TAT_DUE_UTC_DTTM_filled,
    COUNT(NOTIF_TAT_OCCUR_UTC_DTTM) AS NOTIF_TAT_OCCUR_UTC_DTTM_filled,
    COUNT(NOTIF_LETTER) AS NOTIF_LETTER_filled,
    COUNT(NOTIF_CALL_COMM_ID) AS NOTIF_CALL_COMM_ID_filled,
    COUNT(NOTIF_TAT_DUE_LOCAL_DTTM) AS NOTIF_TAT_DUE_LOCAL_DTTM_filled,
    COUNT(NOTIF_TAT_OCCUR_LOCAL_DTTM) AS NOTIF_TAT_OCCUR_LOCAL_DTTM_filled
FROM APPEAL_GRV_NOTIF_TAT;

-- ==========================================================
-- Table: APPEAL_GRV_OUTCOMES
-- This table stores the outcomes of a grievance.
-- Bucket(s): Claims / Denials
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(APPEAL_GRV_ID) AS APPEAL_GRV_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(GRIEVANCE_OUTCOME_C_NAME) AS GRIEVANCE_OUTCOME_C_NAME_filled
FROM APPEAL_GRV_OUTCOMES;

-- ==========================================================
-- Table: APPEAL_GRV_OVRTRN_REASONS
-- Stores the reasons why the original decision was overturned for an appeal.
-- Bucket(s): Claims / Denials
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(APPEAL_GRV_ID) AS APPEAL_GRV_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(OVERTURN_REASON_C_NAME) AS OVERTURN_REASON_C_NAME_filled
FROM APPEAL_GRV_OVRTRN_REASONS;

-- ==========================================================
-- Table: APPEAL_GRV_POST_APL_UPD
-- This table stores the table of updates to authorizations that are the subject of an appeal that has not yet finalized its decision.
-- Bucket(s): Claims / Denials
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(APPEAL_GRV_ID) AS APPEAL_GRV_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(UPDATE_INST_UTC_DTTM) AS UPDATE_INST_UTC_DTTM_filled,
    COUNT(UPDATE_REALTIME_TX_CSN_ID) AS UPDATE_REALTIME_TX_CSN_ID_filled,
    COUNT(UPDATE_ACK_YN) AS UPDATE_ACK_YN_filled
FROM APPEAL_GRV_POST_APL_UPD;

-- ==========================================================
-- Table: APPEAL_GRV_REC_STAT_HX
-- This table contains information about changes to the Chronicles record status/soft-delete flag (SDFL item) of the appeal/grievance record. Only records that have had their record status changed will b
-- Bucket(s): Claims / Denials
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(APPEAL_GRV_ID) AS APPEAL_GRV_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(CM_PHY_OWNER_ID) AS CM_PHY_OWNER_ID_filled,
    COUNT(SDFL_EDIT_INSTANT_DTTM) AS SDFL_EDIT_INSTANT_DTTM_filled,
    COUNT(SDFL_EDIT_USER_ID) AS SDFL_EDIT_USER_ID_filled,
    COUNT(SDFL_EDIT_USER_ID_NAME) AS SDFL_EDIT_USER_ID_NAME_filled,
    COUNT(SDFL_EDIT_ACTI_C_NAME) AS SDFL_EDIT_ACTI_C_NAME_filled
FROM APPEAL_GRV_REC_STAT_HX;

-- ==========================================================
-- Table: APPEAL_GRV_REOPEN_REASONS
-- Stores the reasons for reopening an appeal.
-- Bucket(s): Claims / Denials
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(APPEAL_GRV_ID) AS APPEAL_GRV_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(REOPEN_REASON_C_NAME) AS REOPEN_REASON_C_NAME_filled
FROM APPEAL_GRV_REOPEN_REASONS;

-- ==========================================================
-- Table: APPEAL_GRV_REQ_ATTACHMENT
-- This table holds information about documents that are required to be attached to appeals and grievances. Each row corresponds to an individual document requirement and the document that satisfied the 
-- Bucket(s): Claims / Denials
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(APPEAL_GRV_ID) AS APPEAL_GRV_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(TAT_TIME_STANDARD_C_NAME) AS TAT_TIME_STANDARD_C_NAME_filled,
    COUNT(DOC_INFO_TYPE_C_NAME) AS DOC_INFO_TYPE_C_NAME_filled,
    COUNT(ATTACHMENT_SUBMIT_UTC_DTTM) AS ATTACHMENT_SUBMIT_UTC_DTTM_filled,
    COUNT(APPEAL_GRV_WKFL_STEP_C_NAME) AS APPEAL_GRV_WKFL_STEP_C_NAME_filled,
    COUNT(REQUIRED_FOR_TAT_YN) AS REQUIRED_FOR_TAT_YN_filled,
    COUNT(ATTACHMENT_SUBMIT_LOCAL_DTTM) AS ATTACHMENT_SUBMIT_LOCAL_DTTM_filled
FROM APPEAL_GRV_REQ_ATTACHMENT;

-- ==========================================================
-- Table: APPEAL_GRV_ROOT_CAUSES
-- This table stores the root causes of a grievance.
-- Bucket(s): Claims / Denials
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(APPEAL_GRV_ID) AS APPEAL_GRV_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(GRIEVANCE_ROOT_CAUSE_C_NAME) AS GRIEVANCE_ROOT_CAUSE_C_NAME_filled
FROM APPEAL_GRV_ROOT_CAUSES;

-- ==========================================================
-- Table: APPEAL_GRV_STEP_COMPLETE
-- This table contains information about when workflow steps were completed for a given appeal or grievance.
-- Bucket(s): Claims / Denials
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(APPEAL_GRV_ID) AS APPEAL_GRV_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(APPEAL_GRV_WKFL_STEP_C_NAME) AS APPEAL_GRV_WKFL_STEP_C_NAME_filled,
    COUNT(COMPLETED_USER_ID) AS COMPLETED_USER_ID_filled,
    COUNT(COMPLETED_USER_ID_NAME) AS COMPLETED_USER_ID_NAME_filled,
    COUNT(COMPLETED_UTC_DTTM) AS COMPLETED_UTC_DTTM_filled,
    COUNT(COMPLETED_LOCAL_DTTM) AS COMPLETED_LOCAL_DTTM_filled
FROM APPEAL_GRV_STEP_COMPLETE;

-- ==========================================================
-- Table: APPEAL_GRV_SUBJECT_RESULT
-- This table contains information about the subject and result of an appeal.
-- Bucket(s): Claims / Denials
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(APPEAL_GRV_ID) AS APPEAL_GRV_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(SUBJECT_CLAIM_ID) AS SUBJECT_CLAIM_ID_filled,
    COUNT(RESULT_CLAIM_ID) AS RESULT_CLAIM_ID_filled,
    COUNT(APPEAL_DECISION_C_NAME) AS APPEAL_DECISION_C_NAME_filled,
    COUNT(RESULT_FREE_TEXT) AS RESULT_FREE_TEXT_filled,
    COUNT(SUBJECT_FREE_TEXT) AS SUBJECT_FREE_TEXT_filled,
    COUNT(IND_EFFEC_INST_UTC_DTTM) AS IND_EFFEC_INST_UTC_DTTM_filled,
    COUNT(IND_EFFEC_INST_LOCAL_DTTM) AS IND_EFFEC_INST_LOCAL_DTTM_filled,
    COUNT(PAYMENT_AUTH_UTC_DTTM) AS PAYMENT_AUTH_UTC_DTTM_filled,
    COUNT(PAYMENT_AUTH_LOC_DTTM) AS PAYMENT_AUTH_LOC_DTTM_filled,
    COUNT(PAYMENT_RECIPIENT_C_NAME) AS PAYMENT_RECIPIENT_C_NAME_filled,
    COUNT(NO_PAYMENT_REQ_YN) AS NO_PAYMENT_REQ_YN_filled
FROM APPEAL_GRV_SUBJECT_RESULT;

-- ==========================================================
-- Table: APPEAL_GRV_TAT_MILESTONES
-- This table holds information about turnaround time milestones for appeals and grievances. Each row corresponds to an individual milestone and the date and time associated with the milestone.
-- Bucket(s): Claims / Denials
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(APPEAL_GRV_ID) AS APPEAL_GRV_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(TAT_TIME_STANDARD_C_NAME) AS TAT_TIME_STANDARD_C_NAME_filled,
    COUNT(TAT_MILESTONE_C_NAME) AS TAT_MILESTONE_C_NAME_filled,
    COUNT(TAT_MILE_INST_UTC_DTTM) AS TAT_MILE_INST_UTC_DTTM_filled,
    COUNT(TAT_MILE_DUE_LOCAL_DTTM) AS TAT_MILE_DUE_LOCAL_DTTM_filled
FROM APPEAL_GRV_TAT_MILESTONES;

-- ==========================================================
-- Table: APPEAL_GRV_UPHOLD_REASONS
-- Stores the reasons why the original decision was upheld for an appeal.
-- Bucket(s): Claims / Denials
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(APPEAL_GRV_ID) AS APPEAL_GRV_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(UPHOLD_REASON_C_NAME) AS UPHOLD_REASON_C_NAME_filled
FROM APPEAL_GRV_UPHOLD_REASONS;

-- ==========================================================
-- Table: APPEAL_GRV_VACATE_REASONS
-- Stores the reasons for reviewing the dismissal of an appeal or grievance.
-- Bucket(s): Claims / Denials
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(APPEAL_GRV_ID) AS APPEAL_GRV_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(VACATE_REASON_C_NAME) AS VACATE_REASON_C_NAME_filled
FROM APPEAL_GRV_VACATE_REASONS;

-- ==========================================================
-- Table: AP_CLAIM
-- The AP_CLAIM table contains one record for each claim in the managed care system's AP Claims module.
-- Bucket(s): Claims / Denials
-- ==========================================================
SELECT
    YEAR(DATE_RECEIVED) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CLAIM_ID) AS CLAIM_ID_filled,
    COUNT(ORIG_CLAIM_NUM) AS ORIG_CLAIM_NUM_filled,
    COUNT(STATUS_C_NAME) AS STATUS_C_NAME_filled,
    COUNT(AP_STS_C_NAME) AS AP_STS_C_NAME_filled,
    COUNT(DATE_RECEIVED) AS DATE_RECEIVED_filled,
    COUNT(ADMISSION_DATE) AS ADMISSION_DATE_filled,
    COUNT(ADMISSION_HOUR) AS ADMISSION_HOUR_filled,
    COUNT(ENTRY_DATE) AS ENTRY_DATE_filled,
    COUNT(SERV_AREA_ID_LOC_NAME) AS SERV_AREA_ID_LOC_NAME_filled,
    COUNT(NUM_PROC) AS NUM_PROC_filled,
    COUNT(TOT_BILLED_AMT) AS TOT_BILLED_AMT_filled,
    COUNT(TOT_PAT_PORTION) AS TOT_PAT_PORTION_filled,
    COUNT(TOT_NET_PAYABLE) AS TOT_NET_PAYABLE_filled,
    COUNT(COVERAGE_ID) AS COVERAGE_ID_filled,
    COUNT(SERV_DATE) AS SERV_DATE_filled,
    COUNT(ASSOC_SPEC_C_NAME) AS ASSOC_SPEC_C_NAME_filled,
    COUNT(PAT_STATUS_C_NAME) AS PAT_STATUS_C_NAME_filled,
    COUNT(PROV_ID_PROV_NAME) AS PROV_ID_PROV_NAME_filled,
    COUNT(ADMISSION_SOURCE_C_NAME) AS ADMISSION_SOURCE_C_NAME_filled,
    COUNT(EXTERNAL_CLAIM_ID) AS EXTERNAL_CLAIM_ID_filled,
    COUNT(PAY_BY_DATE) AS PAY_BY_DATE_filled,
    COUNT(NETWORK_ID) AS NETWORK_ID_filled,
    COUNT(NETWORK_ID_NETWORK_NAME) AS NETWORK_ID_NETWORK_NAME_filled,
    COUNT(METH_TO_PAY_CLM_C_NAME) AS METH_TO_PAY_CLM_C_NAME_filled,
    COUNT(TOT_PRIM_INS_AMT) AS TOT_PRIM_INS_AMT_filled,
    COUNT(TOT_PRIM_PAT_PORT) AS TOT_PRIM_PAT_PORT_filled,
    COUNT(TOT_ADJUSTMENT) AS TOT_ADJUSTMENT_filled,
    COUNT(ADMISSION_TYPE_C_NAME) AS ADMISSION_TYPE_C_NAME_filled,
    COUNT(TOT_INSURANCE_AMT) AS TOT_INSURANCE_AMT_filled,
    COUNT(ADMISSION_DX_ID_DX_NAME) AS ADMISSION_DX_ID_DX_NAME_filled,
    COUNT(TOT_NET_INSURANCE) AS TOT_NET_INSURANCE_filled,
    COUNT(E_CODE_ID_DX_NAME) AS E_CODE_ID_DX_NAME_filled,
    COUNT(TYPE_OF_BILL) AS TYPE_OF_BILL_filled,
    COUNT(RCVD_BY_CARRIER_DT) AS RCVD_BY_CARRIER_DT_filled,
    COUNT(HCFA_UNCLEAN_YN) AS HCFA_UNCLEAN_YN_filled,
    COUNT(ORIG_REV_CLM_ID) AS ORIG_REV_CLM_ID_filled,
    COUNT(ADJST_CLM_ID) AS ADJST_CLM_ID_filled,
    COUNT(ORIG_ADJST_CLM_ID) AS ORIG_ADJST_CLM_ID_filled,
    COUNT(REF_PROV_ID_PROV_NAME) AS REF_PROV_ID_PROV_NAME_filled,
    COUNT(TOT_U_AND_C_AMT) AS TOT_U_AND_C_AMT_filled,
    COUNT(TOT_DISALLOW_AMT) AS TOT_DISALLOW_AMT_filled,
    COUNT(TOT_NOT_COVD_AMT) AS TOT_NOT_COVD_AMT_filled,
    COUNT(TOT_DEDUCTIBLE) AS TOT_DEDUCTIBLE_filled,
    COUNT(TOT_COPAY) AS TOT_COPAY_filled,
    COUNT(TOT_COINS) AS TOT_COINS_filled,
    COUNT(TOT_PAT_TOTAL) AS TOT_PAT_TOTAL_filled,
    COUNT(TOT_BBEN_PNLTY) AS TOT_BBEN_PNLTY_filled,
    COUNT(TOT_EXD_BEN_AMT) AS TOT_EXD_BEN_AMT_filled,
    COUNT(IN_OUT_NET_C_NAME) AS IN_OUT_NET_C_NAME_filled,
    COUNT(RKP_ID) AS RKP_ID_filled,
    COUNT(RKP_ID_RISK_PANEL_NAME) AS RKP_ID_RISK_PANEL_NAME_filled,
    COUNT(CLM_LOB_ID) AS CLM_LOB_ID_filled,
    COUNT(CLM_LOB_ID_LOB_NAME) AS CLM_LOB_ID_LOB_NAME_filled,
    COUNT(WORKFLOW_C_NAME) AS WORKFLOW_C_NAME_filled,
    COUNT(SENSITIVITY_C_NAME) AS SENSITIVITY_C_NAME_filled,
    COUNT(SERVICE_START_DATE) AS SERVICE_START_DATE_filled,
    COUNT(SERVICE_END_DATE) AS SERVICE_END_DATE_filled,
    COUNT(TOT_COB_SAVING) AS TOT_COB_SAVING_filled,
    COUNT(TOT_PAT_OUT_PCKT) AS TOT_PAT_OUT_PCKT_filled,
    COUNT(SHADOW_RECON_AMT) AS SHADOW_RECON_AMT_filled,
    COUNT(DRG_ID) AS DRG_ID_filled,
    COUNT(DRG_ID_DRG_NAME) AS DRG_ID_DRG_NAME_filled,
    COUNT(TIF_NUM) AS TIF_NUM_filled,
    COUNT(LIFEMAX_AMT_IN) AS LIFEMAX_AMT_IN_filled,
    COUNT(LIFEMAX_AMT_OUT) AS LIFEMAX_AMT_OUT_filled,
    COUNT(CLAIM_FORMAT_C_NAME) AS CLAIM_FORMAT_C_NAME_filled,
    COUNT(OTHER_PROV_ID_PROV_NAME) AS OTHER_PROV_ID_PROV_NAME_filled,
    COUNT(OPERATING_PROV_ID_PROV_NAME) AS OPERATING_PROV_ID_PROV_NAME_filled,
    COUNT(ADJ_TIME) AS ADJ_TIME_filled,
    COUNT(ATTEND_PROV_ID_PROV_NAME) AS ATTEND_PROV_ID_PROV_NAME_filled,
    COUNT(TOT_COB_SV_PAYOUT) AS TOT_COB_SV_PAYOUT_filled,
    COUNT(LOC_ID_LOC_NAME) AS LOC_ID_LOC_NAME_filled,
    COUNT(TOT_SEC_DIS) AS TOT_SEC_DIS_filled,
    COUNT(TOT_PRIM_FAC) AS TOT_PRIM_FAC_filled,
    COUNT(TOT_CODE_EDIT_SAV) AS TOT_CODE_EDIT_SAV_filled,
    COUNT(INTEREST_AMT_OVRD) AS INTEREST_AMT_OVRD_filled,
    COUNT(RTF_EOB_NOTE_ID) AS RTF_EOB_NOTE_ID_filled,
    COUNT(INFO_CVG_ID) AS INFO_CVG_ID_filled,
    COUNT(CLM_PRIM_INS_AMT) AS CLM_PRIM_INS_AMT_filled,
    COUNT(CLM_PRIM_PAT_AMT) AS CLM_PRIM_PAT_AMT_filled,
    COUNT(STATUS_DATE) AS STATUS_DATE_filled,
    COUNT(PEND_TYPE_C_NAME) AS PEND_TYPE_C_NAME_filled,
    COUNT(CL_DEN_PEND_EXAM_ID) AS CL_DEN_PEND_EXAM_ID_filled,
    COUNT(CL_DEN_PEND_EXAM_ID_NAME) AS CL_DEN_PEND_EXAM_ID_NAME_filled,
    COUNT(CL_DEN_PEND_DTTM) AS CL_DEN_PEND_DTTM_filled,
    COUNT(VOID_EXAMINER_ID) AS VOID_EXAMINER_ID_filled,
    COUNT(VOID_EXAMINER_ID_NAME) AS VOID_EXAMINER_ID_NAME_filled,
    COUNT(VOID_CHNG_DATETIME) AS VOID_CHNG_DATETIME_filled,
    COUNT(ACCIDENT_DT) AS ACCIDENT_DT_filled,
    COUNT(ER_ENTRY_DATETIME) AS ER_ENTRY_DATETIME_filled,
    COUNT(IN_NET_ADJUD_OVRD_C_NAME) AS IN_NET_ADJUD_OVRD_C_NAME_filled,
    COUNT(DRG_PRICING_YN) AS DRG_PRICING_YN_filled,
    COUNT(WORKFLOW_PAYOR_ID_PAYOR_NAME) AS WORKFLOW_PAYOR_ID_PAYOR_NAME_filled,
    COUNT(TOT_BILLED_ENT) AS TOT_BILLED_ENT_filled,
    COUNT(TOT_ALLOWED_AMT) AS TOT_ALLOWED_AMT_filled,
    COUNT(TOT_WITHHOLDING) AS TOT_WITHHOLDING_filled,
    COUNT(TOT_DISCOUNT) AS TOT_DISCOUNT_filled,
    COUNT(ADJ_NET_PAID) AS ADJ_NET_PAID_filled,
    COUNT(ADJ_PAT_PORTION) AS ADJ_PAT_PORTION_filled,
    COUNT(MEM_PRIMARY_NET_ID) AS MEM_PRIMARY_NET_ID_filled,
    COUNT(MEM_PRIMARY_NET_ID_NETWORK_NAME) AS MEM_PRIMARY_NET_ID_NETWORK_NAME_filled,
    COUNT(LIFEMAX_ETR_DATA) AS LIFEMAX_ETR_DATA_filled,
    COUNT(INBASKET_MESSAGE_ID) AS INBASKET_MESSAGE_ID_filled,
    COUNT(STMT_COV_FROM_DATE) AS STMT_COV_FROM_DATE_filled,
    COUNT(STMT_COV_TO_DATE) AS STMT_COV_TO_DATE_filled,
    COUNT(MSP_YN) AS MSP_YN_filled,
    COUNT(CLM_REPRICER_ID) AS CLM_REPRICER_ID_filled,
    COUNT(CLM_REPRICER_ID_RUL_NAME) AS CLM_REPRICER_ID_RUL_NAME_filled,
    COUNT(COVERED_DAYS) AS COVERED_DAYS_filled,
    COUNT(NONCOVERED_DAYS) AS NONCOVERED_DAYS_filled,
    COUNT(COINS_DAYS) AS COINS_DAYS_filled,
    COUNT(LIFETIME_RESRV_DAYS) AS LIFETIME_RESRV_DAYS_filled,
    COUNT(ILL_INJ_LMP_DATE) AS ILL_INJ_LMP_DATE_filled,
    COUNT(INTEREST_TO_DT) AS INTEREST_TO_DT_filled,
    COUNT(DISCHRG_HR_UB92_FMT) AS DISCHRG_HR_UB92_FMT_filled,
    COUNT(ADJUSTMENT_USER_ID) AS ADJUSTMENT_USER_ID_filled,
    COUNT(ADJUSTMENT_USER_ID_NAME) AS ADJUSTMENT_USER_ID_NAME_filled,
    COUNT(ADJST_CREATE_DATE) AS ADJST_CREATE_DATE_filled,
    COUNT(REFUNDED_FLAG_YN) AS REFUNDED_FLAG_YN_filled,
    COUNT(EMPY_RELATED_YN) AS EMPY_RELATED_YN_filled,
    COUNT(AUTO_ACDNT_STATE_C_NAME) AS AUTO_ACDNT_STATE_C_NAME_filled,
    COUNT(DISABILITY_FROM_DT) AS DISABILITY_FROM_DT_filled,
    COUNT(DISABILITY_TO_DT) AS DISABILITY_TO_DT_filled,
    COUNT(DISCHARGE_DATE) AS DISCHARGE_DATE_filled,
    COUNT(OUTSIDE_LAB_YN) AS OUTSIDE_LAB_YN_filled,
    COUNT(OUTSIDE_LAB_CHARGE) AS OUTSIDE_LAB_CHARGE_filled,
    COUNT(RELATED_CONDITION_C_NAME) AS RELATED_CONDITION_C_NAME_filled,
    COUNT(WGT_BED_DAYS) AS WGT_BED_DAYS_filled,
    COUNT(TOT_CONV_DAYS_RFL) AS TOT_CONV_DAYS_RFL_filled,
    COUNT(BENEFIT_PLAN_ID_BENEFIT_PLAN_NAME) AS BENEFIT_PLAN_ID_BENEFIT_PLAN_NAME_filled,
    COUNT(PLAN_GROUP_ID) AS PLAN_GROUP_ID_filled,
    COUNT(PLAN_GROUP_ID_PLAN_GRP_NAME) AS PLAN_GROUP_ID_PLAN_GRP_NAME_filled,
    COUNT(ENTRY_INSTANT_DTTM) AS ENTRY_INSTANT_DTTM_filled
FROM AP_CLAIM
GROUP BY YEAR(DATE_RECEIVED)
ORDER BY activity_year;

-- ==========================================================
-- Table: AP_CLAIM_2
-- The AP_CLAIM_2 table contains one record for each claim in Tapestry's Accounts Payable module.
-- Bucket(s): Claims / Denials
-- ==========================================================
SELECT
    YEAR(APPLIANCE_PLACE_DT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CLAIM_ID) AS CLAIM_ID_filled,
    COUNT(E_CODE_POA_C_NAME) AS E_CODE_POA_C_NAME_filled,
    COUNT(READY_FOR_AP_MGR_ID_MEM_GRP_NAME) AS READY_FOR_AP_MGR_ID_MEM_GRP_NAME_filled,
    COUNT(TOT_REFD_RECVD) AS TOT_REFD_RECVD_filled,
    COUNT(TOTAL_COB_AMOUNT) AS TOTAL_COB_AMOUNT_filled,
    COUNT(EPSDT_YN) AS EPSDT_YN_filled,
    COUNT(RENDERING_PROV_ID_PROV_NAME) AS RENDERING_PROV_ID_PROV_NAME_filled,
    COUNT(TOTAL_MOB_AMOUNT) AS TOTAL_MOB_AMOUNT_filled,
    COUNT(PMT_INFO_MAP_LN) AS PMT_INFO_MAP_LN_filled,
    COUNT(PMT_INFO_GRPR_ID) AS PMT_INFO_GRPR_ID_filled,
    COUNT(PMT_INFO_GRPR_ID_RULE_NAME) AS PMT_INFO_GRPR_ID_RULE_NAME_filled,
    COUNT(PMT_INFO_RULE_ID) AS PMT_INFO_RULE_ID_filled,
    COUNT(PMT_INFO_RULE_ID_RULE_NAME) AS PMT_INFO_RULE_ID_RULE_NAME_filled,
    COUNT(PMT_INFO_SPLIT_ID) AS PMT_INFO_SPLIT_ID_filled,
    COUNT(PMT_INFO_SPLIT_ID_SPLIT_DEF_NAME) AS PMT_INFO_SPLIT_ID_SPLIT_DEF_NAME_filled,
    COUNT(SPECIALTY_SOURCE_C_NAME) AS SPECIALTY_SOURCE_C_NAME_filled,
    COUNT(CASE_MGMT_CREAT_ID) AS CASE_MGMT_CREAT_ID_filled,
    COUNT(CVG_FILTER_EPP_ID_BENEFIT_PLAN_NAME) AS CVG_FILTER_EPP_ID_BENEFIT_PLAN_NAME_filled,
    COUNT(PMT_INFO_STOP_COND) AS PMT_INFO_STOP_COND_filled,
    COUNT(NO_MEM_GRP_YN) AS NO_MEM_GRP_YN_filled,
    COUNT(INTEREST_TOTAL) AS INTEREST_TOTAL_filled,
    COUNT(PROV_ACPT_ASGN_C_NAME) AS PROV_ACPT_ASGN_C_NAME_filled,
    COUNT(BEN_ASGN_IND_C_NAME) AS BEN_ASGN_IND_C_NAME_filled,
    COUNT(OVRD_SUB_POLICY_YN) AS OVRD_SUB_POLICY_YN_filled,
    COUNT(OVRD_SUB_POL_RSN_C_NAME) AS OVRD_SUB_POL_RSN_C_NAME_filled,
    COUNT(CLM_TRAIT_1_C_NAME) AS CLM_TRAIT_1_C_NAME_filled,
    COUNT(CLM_TRAIT_2_C_NAME) AS CLM_TRAIT_2_C_NAME_filled,
    COUNT(CLM_TRAIT_3_C_NAME) AS CLM_TRAIT_3_C_NAME_filled,
    COUNT(CLM_TRAIT_4_C_NAME) AS CLM_TRAIT_4_C_NAME_filled,
    COUNT(CLM_TRAIT_5_C_NAME) AS CLM_TRAIT_5_C_NAME_filled,
    COUNT(TP_INFO_837_SEND_ID) AS TP_INFO_837_SEND_ID_filled,
    COUNT(TP_INFO_837_SEND_ID_TRADING_PARTNR_NAME) AS TP_INFO_837_SEND_ID_TRADING_PARTNR_NAME_filled,
    COUNT(TP_INFO_837_RCVR_ID) AS TP_INFO_837_RCVR_ID_filled,
    COUNT(TP_INFO_837_RCVR_ID_TRADING_PARTNR_NAME) AS TP_INFO_837_RCVR_ID_TRADING_PARTNR_NAME_filled,
    COUNT(APPLIANCE_PLACE_DT) AS APPLIANCE_PLACE_DT_filled,
    COUNT(DNTL_SVC_FROM_DT) AS DNTL_SVC_FROM_DT_filled,
    COUNT(DNTL_SVC_TO_DT) AS DNTL_SVC_TO_DT_filled,
    COUNT(ORTHO_SVCS_YN) AS ORTHO_SVCS_YN_filled,
    COUNT(ORTHO_TOT_MONTHS) AS ORTHO_TOT_MONTHS_filled,
    COUNT(ORTHO_MNTHS_REMAIN) AS ORTHO_MNTHS_REMAIN_filled,
    COUNT(ASSIST_SURGEON_ID_PROV_NAME) AS ASSIST_SURGEON_ID_PROV_NAME_filled,
    COUNT(DENTAL_INFO_YN) AS DENTAL_INFO_YN_filled,
    COUNT(LMP_DATE) AS LMP_DATE_filled,
    COUNT(CHIR_FRST_TRT_DT) AS CHIR_FRST_TRT_DT_filled,
    COUNT(FROM_OCR_YN) AS FROM_OCR_YN_filled,
    COUNT(CLM_PRICER_IDENT_C_NAME) AS CLM_PRICER_IDENT_C_NAME_filled,
    COUNT(TOTAL_HRA_AMOUNT) AS TOTAL_HRA_AMOUNT_filled,
    COUNT(ORIG_ACT_ADJ_CLM_ID) AS ORIG_ACT_ADJ_CLM_ID_filled,
    COUNT(REF_CLM) AS REF_CLM_filled,
    COUNT(MGR_ASSOC_EXT_VAL_C_NAME) AS MGR_ASSOC_EXT_VAL_C_NAME_filled,
    COUNT(AMBU_TRAN_REASON_C_NAME) AS AMBU_TRAN_REASON_C_NAME_filled,
    COUNT(AMBU_TRAN_DIST) AS AMBU_TRAN_DIST_filled,
    COUNT(AMBU_TXPORT_WT) AS AMBU_TXPORT_WT_filled,
    COUNT(AMBU_COND_YN) AS AMBU_COND_YN_filled,
    COUNT(AMBU_PICK_UP_CITY) AS AMBU_PICK_UP_CITY_filled,
    COUNT(AMBU_PICK_UP_ST_C_NAME) AS AMBU_PICK_UP_ST_C_NAME_filled,
    COUNT(AMBU_PICK_UP_ZIP) AS AMBU_PICK_UP_ZIP_filled,
    COUNT(AMBU_DROP_OFF_CITY) AS AMBU_DROP_OFF_CITY_filled,
    COUNT(AMBU_DROP_OFF_ST_C_NAME) AS AMBU_DROP_OFF_ST_C_NAME_filled,
    COUNT(AMBU_DROP_OFF_ZIP) AS AMBU_DROP_OFF_ZIP_filled,
    COUNT(AMBU_DROP_OFF_NM) AS AMBU_DROP_OFF_NM_filled,
    COUNT(PAYEE_C_NAME) AS PAYEE_C_NAME_filled,
    COUNT(ESRD_ONSET_DATE) AS ESRD_ONSET_DATE_filled,
    COUNT(PAYOR_SEQ_NUMBER_C_NAME) AS PAYOR_SEQ_NUMBER_C_NAME_filled,
    COUNT(CLM_FREQ_CODE_C_NAME) AS CLM_FREQ_CODE_C_NAME_filled,
    COUNT(DENY_CLM_SRC_C_NAME) AS DENY_CLM_SRC_C_NAME_filled
FROM AP_CLAIM_2
GROUP BY YEAR(APPLIANCE_PLACE_DT)
ORDER BY activity_year;

-- ==========================================================
-- Table: AP_CLAIM_3
-- The AP_CLAIM_3 table contains one record for each claim in Tapestry's Accounts Payable module.
-- Bucket(s): Claims / Denials
-- ==========================================================
SELECT
    YEAR(SUBMITTER_CREAT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CLAIM_ID) AS CLAIM_ID_filled,
    COUNT(TOT_PRIM_PAT_NOTCOV) AS TOT_PRIM_PAT_NOTCOV_filled,
    COUNT(TOT_PRIM_PAT_DED) AS TOT_PRIM_PAT_DED_filled,
    COUNT(TOT_PRIM_PAT_COPAY) AS TOT_PRIM_PAT_COPAY_filled,
    COUNT(TOT_PRIM_PAT_COINS) AS TOT_PRIM_PAT_COINS_filled,
    COUNT(SUBMITTER_CREAT_DATE) AS SUBMITTER_CREAT_DATE_filled,
    COUNT(INTERCHANGE_DATE) AS INTERCHANGE_DATE_filled,
    COUNT(FUNC_GROUP_DATE) AS FUNC_GROUP_DATE_filled,
    COUNT(TOTAL_RESP_AMOUNT) AS TOTAL_RESP_AMOUNT_filled,
    COUNT(TOTAL_ADJ_PAT_OOP) AS TOTAL_ADJ_PAT_OOP_filled,
    COUNT(TERMED_CVG_YN) AS TERMED_CVG_YN_filled,
    COUNT(IS_INPATIENT_YN) AS IS_INPATIENT_YN_filled,
    COUNT(DRG_CODE) AS DRG_CODE_filled,
    COUNT(DRG_ID_TYPE_ID) AS DRG_ID_TYPE_ID_filled,
    COUNT(DRG_ID_TYPE_ID_ID_TYPE_NAME) AS DRG_ID_TYPE_ID_ID_TYPE_NAME_filled,
    COUNT(PERM_ORIG_OF_REV_CLAIM_ID) AS PERM_ORIG_OF_REV_CLAIM_ID_filled,
    COUNT(PERM_ORIG_OF_CORR_CLAIM_ID) AS PERM_ORIG_OF_CORR_CLAIM_ID_filled,
    COUNT(PERM_ORIG_OF_ADJST_CLAIM_ID) AS PERM_ORIG_OF_ADJST_CLAIM_ID_filled,
    COUNT(INVOICE_AMT_REM) AS INVOICE_AMT_REM_filled,
    COUNT(ADJST_ACTION_TYPE_C_NAME) AS ADJST_ACTION_TYPE_C_NAME_filled,
    COUNT(CLAIM_EFFECTIVE_DATE) AS CLAIM_EFFECTIVE_DATE_filled,
    COUNT(VENDOR_TAXONOMY) AS VENDOR_TAXONOMY_filled,
    COUNT(PROVIDER_TAXONOMY) AS PROVIDER_TAXONOMY_filled,
    COUNT(ADJST_REASON_C_NAME) AS ADJST_REASON_C_NAME_filled,
    COUNT(AMBU_PICK_UP_COUNTY_C_NAME) AS AMBU_PICK_UP_COUNTY_C_NAME_filled,
    COUNT(AMBU_PICK_UP_DISTRICT_C_NAME) AS AMBU_PICK_UP_DISTRICT_C_NAME_filled,
    COUNT(AMBU_PICK_UP_HOUSE_NUM) AS AMBU_PICK_UP_HOUSE_NUM_filled,
    COUNT(AMBU_DROP_OFF_COUNTY_C_NAME) AS AMBU_DROP_OFF_COUNTY_C_NAME_filled,
    COUNT(AMBU_DROP_OFF_DISTRICT_C_NAME) AS AMBU_DROP_OFF_DISTRICT_C_NAME_filled,
    COUNT(AMBU_DROP_OFF_HOUSE_NUM) AS AMBU_DROP_OFF_HOUSE_NUM_filled,
    COUNT(SUPERVISING_PROV_ID_PROV_NAME) AS SUPERVISING_PROV_ID_PROV_NAME_filled,
    COUNT(CLAIM_SVC_CLASS_CTX_C_NAME) AS CLAIM_SVC_CLASS_CTX_C_NAME_filled,
    COUNT(CLAIM_SVC_CLASS_C_NAME) AS CLAIM_SVC_CLASS_C_NAME_filled,
    COUNT(IS_SUBROGATION_DEMAND_CLAIM_YN) AS IS_SUBROGATION_DEMAND_CLAIM_YN_filled,
    COUNT(TOT_SUBROGATION_DEMAND_AMT) AS TOT_SUBROGATION_DEMAND_AMT_filled,
    COUNT(TOT_SUBROGATION_ADJ_AMT) AS TOT_SUBROGATION_ADJ_AMT_filled,
    COUNT(CONTRACT_SEL_MTHD_C_NAME) AS CONTRACT_SEL_MTHD_C_NAME_filled,
    COUNT(IS_CLINICALLY_VALID_YN) AS IS_CLINICALLY_VALID_YN_filled,
    COUNT(PRIM_PAYOR_ID_PAYOR_NAME) AS PRIM_PAYOR_ID_PAYOR_NAME_filled,
    COUNT(BCDA_GROUP_IDENT) AS BCDA_GROUP_IDENT_filled,
    COUNT(CLIA_NUMBER) AS CLIA_NUMBER_filled,
    COUNT(CLIN_FILTER_UTC_DTTM) AS CLIN_FILTER_UTC_DTTM_filled,
    COUNT(CLIN_FILTER_DTTM) AS CLIN_FILTER_DTTM_filled,
    COUNT(TOT_PI_REDUCT_AMT) AS TOT_PI_REDUCT_AMT_filled,
    COUNT(MOST_RECENT_INCOMING_CEV_ID) AS MOST_RECENT_INCOMING_CEV_ID_filled,
    COUNT(PAT_REL_TO_COVERED_MEM_C_NAME) AS PAT_REL_TO_COVERED_MEM_C_NAME_filled,
    COUNT(CLIN_FILTER_TXP_YN) AS CLIN_FILTER_TXP_YN_filled,
    COUNT(KLCTCEV_RECORD_ID) AS KLCTCEV_RECORD_ID_filled,
    COUNT(SOURCE_ORG_ID) AS SOURCE_ORG_ID_filled,
    COUNT(SOURCE_ORG_ID_EXTERNAL_NAME) AS SOURCE_ORG_ID_EXTERNAL_NAME_filled,
    COUNT(LOOP_OR_SPLIT_YN) AS LOOP_OR_SPLIT_YN_filled,
    COUNT(IS_INVLD_ADJ_SEQ_YN) AS IS_INVLD_ADJ_SEQ_YN_filled,
    COUNT(CLAIM_PAID_DATE) AS CLAIM_PAID_DATE_filled,
    COUNT(CLAIM_NAT_KEY_HASH) AS CLAIM_NAT_KEY_HASH_filled,
    COUNT(CLAIM_NAT_KEY_ORDER) AS CLAIM_NAT_KEY_ORDER_filled,
    COUNT(CLM_ADJ_TYPE_C_NAME) AS CLM_ADJ_TYPE_C_NAME_filled,
    COUNT(NAT_KEY_FINAL_YN) AS NAT_KEY_FINAL_YN_filled,
    COUNT(TTL_APL_U_AND_C_AMT) AS TTL_APL_U_AND_C_AMT_filled,
    COUNT(TTL_APL_CNTRCT_AMT) AS TTL_APL_CNTRCT_AMT_filled,
    COUNT(SUBMITTER_C_NAME) AS SUBMITTER_C_NAME_filled,
    COUNT(SUBMITTER_AUTHORIZED_REP_GUID) AS SUBMITTER_AUTHORIZED_REP_GUID_filled,
    COUNT(TOTAL_DENIED_AMOUNT) AS TOTAL_DENIED_AMOUNT_filled,
    COUNT(TOTAL_DENIED_TO_PAT) AS TOTAL_DENIED_TO_PAT_filled,
    COUNT(REC_OWN_BUS_SEGMENT_POS_ID_LOC_NAME) AS REC_OWN_BUS_SEGMENT_POS_ID_LOC_NAME_filled,
    COUNT(REGION_ID_LOC_NAME) AS REGION_ID_LOC_NAME_filled,
    COUNT(MEDICAL_GROUP_ID_LOC_NAME) AS MEDICAL_GROUP_ID_LOC_NAME_filled,
    COUNT(PRICER_MSG_ID) AS PRICER_MSG_ID_filled,
    COUNT(OUT_NET_ADJUD_OV_C_NAME) AS OUT_NET_ADJUD_OV_C_NAME_filled,
    COUNT(RECV_CLAIM_RECON_ID) AS RECV_CLAIM_RECON_ID_filled,
    COUNT(CMS_NATURAL_KEY) AS CMS_NATURAL_KEY_filled
FROM AP_CLAIM_3
GROUP BY YEAR(SUBMITTER_CREAT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: AP_CLAIM_4
-- The AP_CLAIM_4 table contains one record for each claim in the managed care system's AP Claims module.
-- Bucket(s): Claims / Denials
-- ==========================================================
SELECT
    YEAR(CLAIM_CHECK_MAIL_SENT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CLAIM_ID) AS CLAIM_ID_filled,
    COUNT(TOT_ADDL_ADJ) AS TOT_ADDL_ADJ_filled,
    COUNT(AP_CLAIM_IMPORT_SOURCE_C_NAME) AS AP_CLAIM_IMPORT_SOURCE_C_NAME_filled,
    COUNT(SOURCE_GROUP_ID_LOC_NAME) AS SOURCE_GROUP_ID_LOC_NAME_filled,
    COUNT(SERVICE_DATE_FROM_LINE_YN) AS SERVICE_DATE_FROM_LINE_YN_filled,
    COUNT(NCH_CLAIM_TYPE_C_NAME) AS NCH_CLAIM_TYPE_C_NAME_filled,
    COUNT(PAID_CLM_FILE_INTEREST_AMT) AS PAID_CLM_FILE_INTEREST_AMT_filled,
    COUNT(PAID_CLM_FILE_PENALTY_AMT) AS PAID_CLM_FILE_PENALTY_AMT_filled,
    COUNT(BLK_DTA_MESSAGE_ID) AS BLK_DTA_MESSAGE_ID_filled,
    COUNT(REFUND_REASON) AS REFUND_REASON_filled,
    COUNT(PAYER_CLM_IDENT) AS PAYER_CLM_IDENT_filled,
    COUNT(AP_CLM_AR_STATUS_C_NAME) AS AP_CLM_AR_STATUS_C_NAME_filled,
    COUNT(CLAIM_CHECK_MAIL_SENT_DATE) AS CLAIM_CHECK_MAIL_SENT_DATE_filled,
    COUNT(CAPITAL_IME_AMOUNT) AS CAPITAL_IME_AMOUNT_filled,
    COUNT(OPERATING_IME_AMOUNT) AS OPERATING_IME_AMOUNT_filled,
    COUNT(CAPITAL_DSH_AMOUNT) AS CAPITAL_DSH_AMOUNT_filled,
    COUNT(UNCOMPENSATED_CARE_AMOUNT) AS UNCOMPENSATED_CARE_AMOUNT_filled,
    COUNT(OPERATING_DSH_AMOUNT) AS OPERATING_DSH_AMOUNT_filled
FROM AP_CLAIM_4
GROUP BY YEAR(CLAIM_CHECK_MAIL_SENT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: AP_CLAIM_CHANGE_HX
-- The AP_CLAIM_CHANGE_HX table contains the change history of an accounts payable claim.
-- Bucket(s): Claims / Denials
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_ID) AS CLAIM_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(CHANGE_TIME) AS CHANGE_TIME_filled,
    COUNT(ACTION_C_NAME) AS ACTION_C_NAME_filled,
    COUNT(CHANGE_HX_CMT) AS CHANGE_HX_CMT_filled,
    COUNT(CHANGE_HX_USER_ID) AS CHANGE_HX_USER_ID_filled,
    COUNT(CHANGE_HX_USER_ID_NAME) AS CHANGE_HX_USER_ID_NAME_filled,
    COUNT(CHANGE_HX_CODEEDIT) AS CHANGE_HX_CODEEDIT_filled,
    COUNT(CHANGE_HX_TX_ID) AS CHANGE_HX_TX_ID_filled,
    COUNT(CHANGE_HX_PREV_REC_OR_CAT) AS CHANGE_HX_PREV_REC_OR_CAT_filled,
    COUNT(CHANGE_HX_NEW_REC_OR_CAT) AS CHANGE_HX_NEW_REC_OR_CAT_filled
FROM AP_CLAIM_CHANGE_HX;

-- ==========================================================
-- Table: AP_CLAIM_DX
-- The AP_CLAIM_DX table contains one record for each diagnosis on an accounts payable claim.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_ID) AS CLAIM_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(DX_ID_DX_NAME) AS DX_ID_DX_NAME_filled,
    COUNT(AP_DX_NUM) AS AP_DX_NUM_filled,
    COUNT(AP_DX_QUALIFIER_C_NAME) AS AP_DX_QUALIFIER_C_NAME_filled,
    COUNT(AP_DX_POA_C_NAME) AS AP_DX_POA_C_NAME_filled,
    COUNT(AP_DX_RANK) AS AP_DX_RANK_filled,
    COUNT(CLAIM_DX_FROM_HEADER_YN) AS CLAIM_DX_FROM_HEADER_YN_filled
FROM AP_CLAIM_DX;

-- ==========================================================
-- Table: AP_CLAIM_ICD_PROC
-- The AP_CLAIM_ICD_PROC table contains the ICD-9 Procedure information on an accounts payable claim.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
SELECT
    YEAR(ICD_PX_DT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CLAIM_ID) AS CLAIM_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(ICD_PX_ID) AS ICD_PX_ID_filled,
    COUNT(ICD_PX_ID_ICD_PX_NAME) AS ICD_PX_ID_ICD_PX_NAME_filled,
    COUNT(ICD_PX_DT) AS ICD_PX_DT_filled,
    COUNT(ICD_PX_RANK) AS ICD_PX_RANK_filled
FROM AP_CLAIM_ICD_PROC
GROUP BY YEAR(ICD_PX_DT)
ORDER BY activity_year;

-- ==========================================================
-- Table: AP_CLAIM_IF_ACE_DX_DISP
-- This table contains Ambulatory Code Editor (ACE) DX Highest Diagnosis Disposition value returned from the third party interface.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_ID) AS CLAIM_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(HIGHEST_DX_DISP) AS HIGHEST_DX_DISP_filled
FROM AP_CLAIM_IF_ACE_DX_DISP;

-- ==========================================================
-- Table: AP_CLAIM_IF_ACE_DX_ERR
-- This table contains the Ambulatory Code Editor (ACE) DX Diagnosis Errors value returned from the third party interface.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_ID) AS CLAIM_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(ACE_DX_ERR) AS ACE_DX_ERR_filled
FROM AP_CLAIM_IF_ACE_DX_ERR;

-- ==========================================================
-- Table: AP_CLAIM_IF_ACE_DX_NERR
-- This table contains Ambulatory Code Editor (ACE) DX Number of Errors for this Diagnosis value returned from the third party interface.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_ID) AS CLAIM_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(NUM_ERR_THIS_DX) AS NUM_ERR_THIS_DX_filled
FROM AP_CLAIM_IF_ACE_DX_NERR;

-- ==========================================================
-- Table: AP_CLAIM_IF_ADMIT_DX_EDIT
-- Admit diagnosis edits returned from the grouper/pricer.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_ID) AS CLAIM_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(ADMIT_DX_EDIT) AS ADMIT_DX_EDIT_filled
FROM AP_CLAIM_IF_ADMIT_DX_EDIT;

-- ==========================================================
-- Table: AP_CLAIM_IF_ADM_DX_ECODE
-- Admit Diagnosis Ecode/ Manifestation Code.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_ID) AS CLAIM_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(ADM_DX_ECODE) AS ADM_DX_ECODE_filled
FROM AP_CLAIM_IF_ADM_DX_ECODE;

-- ==========================================================
-- Table: AP_CLAIM_IF_AGE_SX_DX_FLG
-- Age/sex diagnosis error flag.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_ID) AS CLAIM_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(AGE_SEX_DX_FLAG) AS AGE_SEX_DX_FLAG_filled
FROM AP_CLAIM_IF_AGE_SX_DX_FLG;

-- ==========================================================
-- Table: AP_CLAIM_IF_DUP_DX_FLAG
-- Duplicate diagnosis error flag.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_ID) AS CLAIM_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(DUP_DX_FLAG) AS DUP_DX_FLAG_filled
FROM AP_CLAIM_IF_DUP_DX_FLAG;

-- ==========================================================
-- Table: AP_CLAIM_IF_DUP_SEC_DX
-- Duplicate secondary diagnosis.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_ID) AS CLAIM_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(DUP_SEC_DX) AS DUP_SEC_DX_filled
FROM AP_CLAIM_IF_DUP_SEC_DX;

-- ==========================================================
-- Table: AP_CLAIM_IF_DX_ADMIT_ROM
-- This table stores diagnosis risk of mortality (ROM) at admission.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_ID) AS CLAIM_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(DX_ADMISSION_ROM) AS DX_ADMISSION_ROM_filled
FROM AP_CLAIM_IF_DX_ADMIT_ROM;

-- ==========================================================
-- Table: AP_CLAIM_IF_DX_ADMIT_SOI
-- This table stores the diagnosis severity of illness (SOI) at admission.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_ID) AS CLAIM_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(DX_ADMISSION_SOI) AS DX_ADMISSION_SOI_filled
FROM AP_CLAIM_IF_DX_ADMIT_SOI;

-- ==========================================================
-- Table: AP_CLAIM_IF_DX_AF_DRG_FLG
-- Flags that indicate whether the diagnosis affects the Diagnosis Related Grouper (DRG) selection.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_ID) AS CLAIM_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(DX_AFFECT_DRG_FLAG) AS DX_AFFECT_DRG_FLAG_filled
FROM AP_CLAIM_IF_DX_AF_DRG_FLG;

-- ==========================================================
-- Table: AP_CLAIM_IF_DX_AF_HAC_DRG
-- This table extracts the related multiple response Interface Info - Grouper Dx - Affect HAC Adjust DRG Flg (I CLM 21846) item.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_ID) AS CLAIM_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(DX_AFF_HAC_ADJ_DRG) AS DX_AFF_HAC_ADJ_DRG_filled
FROM AP_CLAIM_IF_DX_AF_HAC_DRG;

-- ==========================================================
-- Table: AP_CLAIM_IF_DX_AF_HAC_ROM
-- This table extracts the related multiple response Interface Info - Grouper Dx - Affect HAC Adjust ROM Flg (I CLM 21847) item.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_ID) AS CLAIM_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(DX_AFF_HAC_ADJ_ROM) AS DX_AFF_HAC_ADJ_ROM_filled
FROM AP_CLAIM_IF_DX_AF_HAC_ROM;

-- ==========================================================
-- Table: AP_CLAIM_IF_DX_AF_HAC_SOI
-- This table extracts the related multiple response Interface Info - Grouper Dx - Affect HAC Adjust SOI Flg (I CLM 21848) item.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_ID) AS CLAIM_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(DX_AFF_HAC_ADJ_SOI) AS DX_AFF_HAC_ADJ_SOI_filled
FROM AP_CLAIM_IF_DX_AF_HAC_SOI;

-- ==========================================================
-- Table: AP_CLAIM_IF_DX_COMP_IND
-- This table contains a code which indicates if a diagnosis increased the complexity of the visit.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_ID) AS CLAIM_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(COMPLEXITY_INDICATOR) AS COMPLEXITY_INDICATOR_filled
FROM AP_CLAIM_IF_DX_COMP_IND;

-- ==========================================================
-- Table: AP_CLAIM_IF_DX_EDIT
-- Diagnosis edits returned by the grouper/pricer.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_ID) AS CLAIM_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(DX_EDIT) AS DX_EDIT_filled,
    COUNT(DX_EDIT_1) AS DX_EDIT_1_filled,
    COUNT(DX_EDIT_2) AS DX_EDIT_2_filled,
    COUNT(DX_EDIT_3) AS DX_EDIT_3_filled,
    COUNT(DX_EDIT_4) AS DX_EDIT_4_filled,
    COUNT(DX_EDIT_5) AS DX_EDIT_5_filled,
    COUNT(DX_EDIT_6) AS DX_EDIT_6_filled,
    COUNT(DX_EDIT_7) AS DX_EDIT_7_filled,
    COUNT(DX_EDIT_8) AS DX_EDIT_8_filled,
    COUNT(DX_EDIT_9) AS DX_EDIT_9_filled,
    COUNT(DX_EDIT_10) AS DX_EDIT_10_filled
FROM AP_CLAIM_IF_DX_EDIT;

-- ==========================================================
-- Table: AP_CLAIM_IF_DX_EDIT_DESC
-- This table contains description of diagnosis edits returned from the third party interface.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_ID) AS CLAIM_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(CM_PHY_OWNER_ID) AS CM_PHY_OWNER_ID_filled,
    COUNT(DX_EDIT_DESCRIPTION) AS DX_EDIT_DESCRIPTION_filled
FROM AP_CLAIM_IF_DX_EDIT_DESC;

-- ==========================================================
-- Table: AP_CLAIM_IF_DX_EXCL_HAC
-- This table extracts the related multiple response Interface Info - Grouper Dx - Excl Frm HAC Adj Grouping (I CLM 21852) item.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_ID) AS CLAIM_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(DX_EXCL_HAC_GRPING) AS DX_EXCL_HAC_GRPING_filled
FROM AP_CLAIM_IF_DX_EXCL_HAC;

-- ==========================================================
-- Table: AP_CLAIM_IF_DX_HAC_AJ_ROM
-- This table extracts the related multiple response Interface Info - Grouper Dx - HAC Adjusted ROM (I CLM 21853) item.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_ID) AS CLAIM_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(DX_HAC_ADJ_ROM) AS DX_HAC_ADJ_ROM_filled
FROM AP_CLAIM_IF_DX_HAC_AJ_ROM;

-- ==========================================================
-- Table: AP_CLAIM_IF_DX_HAC_AJ_SOI
-- This table extracts the related multiple response Interface Info - Grouper Dx - HAC Adjusted SOI Flag (I CLM 21854) item.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_ID) AS CLAIM_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(DX_HAC_ADJ_SOI) AS DX_HAC_ADJ_SOI_filled
FROM AP_CLAIM_IF_DX_HAC_AJ_SOI;

-- ==========================================================
-- Table: AP_CLAIM_IF_DX_HAC_ASGN
-- This table extracts the related multiple response Interface Info - Grouper Dx - Affect HAC Assignment (I CLM 21849) item.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_ID) AS CLAIM_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(DX_AFF_HAC_ASGN) AS DX_AFF_HAC_ASGN_filled
FROM AP_CLAIM_IF_DX_HAC_ASGN;

-- ==========================================================
-- Table: AP_CLAIM_IF_DX_HAC_CAT
-- The diagnosis hospital-acquired condition (HAC) categories.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_ID) AS CLAIM_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(DX_HAC_CAT) AS DX_HAC_CAT_filled,
    COUNT(DX_HAC_CAT_1) AS DX_HAC_CAT_1_filled,
    COUNT(DX_HAC_CAT_2) AS DX_HAC_CAT_2_filled,
    COUNT(DX_HAC_CAT_3) AS DX_HAC_CAT_3_filled,
    COUNT(DX_HAC_CAT_4) AS DX_HAC_CAT_4_filled,
    COUNT(DX_HAC_CAT_5) AS DX_HAC_CAT_5_filled
FROM AP_CLAIM_IF_DX_HAC_CAT;

-- ==========================================================
-- Table: AP_CLAIM_IF_DX_HAC_IND
-- This table extracts the related multiple response Interface Info - Grouper Dx - HAC Indicator (I CLM 21855) item.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_ID) AS CLAIM_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(DX_HAC_INDICATOR) AS DX_HAC_INDICATOR_filled
FROM AP_CLAIM_IF_DX_HAC_IND;

-- ==========================================================
-- Table: AP_CLAIM_IF_DX_HAC_ROM_FL
-- This table extracts the related multiple response Interface Info - Grouper Dx - Affect ROM Flag (I CLM 21850) item.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_ID) AS CLAIM_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(DX_AFFECT_ROM_FLAG) AS DX_AFFECT_ROM_FLAG_filled
FROM AP_CLAIM_IF_DX_HAC_ROM_FL;

-- ==========================================================
-- Table: AP_CLAIM_IF_DX_HAC_SOI_FL
-- This table extracts the related multiple response Interface Info - Grouper Dx - Affect SOI Flag (I CLM 21851) item.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_ID) AS CLAIM_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(DX_AFFECT_SOI_FLAG) AS DX_AFFECT_SOI_FLAG_filled
FROM AP_CLAIM_IF_DX_HAC_SOI_FL;

-- ==========================================================
-- Table: AP_CLAIM_IF_DX_HAC_USAGE
-- Indicates if the diagnosis code and present on admission (POA) value combination were used in grouper processing.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_ID) AS CLAIM_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(DX_HAC_USAGE) AS DX_HAC_USAGE_filled,
    COUNT(DX_HAC_USAGE_1) AS DX_HAC_USAGE_1_filled,
    COUNT(DX_HAC_USAGE_2) AS DX_HAC_USAGE_2_filled,
    COUNT(DX_HAC_USAGE_3) AS DX_HAC_USAGE_3_filled,
    COUNT(DX_HAC_USAGE_4) AS DX_HAC_USAGE_4_filled,
    COUNT(DX_HAC_USAGE_5) AS DX_HAC_USAGE_5_filled
FROM AP_CLAIM_IF_DX_HAC_USAGE;

-- ==========================================================
-- Table: AP_CLAIM_IF_DX_INVALID
-- This table returns an Optum-defined code indicating why a diagnosis code is considered invalid.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_ID) AS CLAIM_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(DX_INVALID) AS DX_INVALID_filled
FROM AP_CLAIM_IF_DX_INVALID;

-- ==========================================================
-- Table: AP_CLAIM_IF_DX_POA_BYPASS
-- This table extracts data received from PPS pricer for a claim in DX 'Present on Admission Bypassed'.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_ID) AS CLAIM_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(DX_PRSNT_ADM_BYPASS) AS DX_PRSNT_ADM_BYPASS_filled
FROM AP_CLAIM_IF_DX_POA_BYPASS;

-- ==========================================================
-- Table: AP_CLAIM_IF_DX_POA_ERR_CD
-- Indicates how the Present On Admission (POA) values submitted impacted grouper logic.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_ID) AS CLAIM_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(DX_POA_ERROR_CODE) AS DX_POA_ERROR_CODE_filled
FROM AP_CLAIM_IF_DX_POA_ERR_CD;

-- ==========================================================
-- Table: AP_CLAIM_IF_DX_POA_USED
-- The present on admission (POA) value used during processing.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_ID) AS CLAIM_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(DX_POA_USED) AS DX_POA_USED_filled
FROM AP_CLAIM_IF_DX_POA_USED;

-- ==========================================================
-- Table: AP_CLAIM_IF_DX_PSCA
-- This table contains the PSCA (Proportional Standard Cost Allocation) assigned to each diagnosis on the claim, taking into consideration the age and gender of the patient.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_ID) AS CLAIM_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(PSCA) AS PSCA_filled
FROM AP_CLAIM_IF_DX_PSCA;

-- ==========================================================
-- Table: AP_CLAIM_IF_DX_SUG_SURG
-- Diagnosis suggests surgery.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_ID) AS CLAIM_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(DX_SUGGST_SURG) AS DX_SUGGST_SURG_filled
FROM AP_CLAIM_IF_DX_SUG_SURG;

-- ==========================================================
-- Table: AP_CLAIM_IF_DX_USED
-- The diagnosis code(s) that was used during processing; may be the entered or the mapped code.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_ID) AS CLAIM_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(DX_USED) AS DX_USED_filled,
    COUNT(DX_USED_1) AS DX_USED_1_filled,
    COUNT(DX_USED_2) AS DX_USED_2_filled,
    COUNT(DX_USED_3) AS DX_USED_3_filled,
    COUNT(DX_USED_4) AS DX_USED_4_filled,
    COUNT(DX_USED_5) AS DX_USED_5_filled
FROM AP_CLAIM_IF_DX_USED;

-- ==========================================================
-- Table: AP_CLAIM_IF_DX_USED_DESC
-- This table contains description of the diagnosis used for pricing as returned from the third party interface.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_ID) AS CLAIM_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(CM_PHY_OWNER_ID) AS CM_PHY_OWNER_ID_filled,
    COUNT(DX_USED_DESCRIPTION) AS DX_USED_DESCRIPTION_filled
FROM AP_CLAIM_IF_DX_USED_DESC;

-- ==========================================================
-- Table: AP_CLAIM_IF_DX_USED_HAC
-- This table extracts the related multiple response Interface Info - Grouper - Dx Used for HAC Processing (I CLM 21856) item.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_ID) AS CLAIM_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(DX_USED_HAC_PROCESS) AS DX_USED_HAC_PROCESS_filled,
    COUNT(DX_USED_HAC_PROCESS_1) AS DX_USED_HAC_PROCESS_1_filled,
    COUNT(DX_USED_HAC_PROCESS_2) AS DX_USED_HAC_PROCESS_2_filled,
    COUNT(DX_USED_HAC_PROCESS_3) AS DX_USED_HAC_PROCESS_3_filled,
    COUNT(DX_USED_HAC_PROCESS_4) AS DX_USED_HAC_PROCESS_4_filled,
    COUNT(DX_USED_HAC_PROCESS_5) AS DX_USED_HAC_PROCESS_5_filled
FROM AP_CLAIM_IF_DX_USED_HAC;

-- ==========================================================
-- Table: AP_CLAIM_IF_GRP_DX_HAC
-- This table contains hospital-acquired condition diagnosis (DX HAC) Processing Description returned from the third party interface.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_ID) AS CLAIM_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(CM_PHY_OWNER_ID) AS CM_PHY_OWNER_ID_filled,
    COUNT(DX_HAC_PROCESSING_DESC) AS DX_HAC_PROCESSING_DESC_filled
FROM AP_CLAIM_IF_GRP_DX_HAC;

-- ==========================================================
-- Table: AP_CLAIM_IF_OUT_DX
-- This table contains diagnosis code of the claim the system sends out to the third party interface.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_ID) AS CLAIM_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(OUT_DX_CODE) AS OUT_DX_CODE_filled
FROM AP_CLAIM_IF_OUT_DX;

-- ==========================================================
-- Table: AP_CLAIM_IF_OUT_ICDPX_DT
-- This table contains the ICD procedure date of the claim the system sends out to APC interface.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_ID) AS CLAIM_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(OUT_ICDPX_DATE) AS OUT_ICDPX_DATE_filled
FROM AP_CLAIM_IF_OUT_ICDPX_DT;

-- ==========================================================
-- Table: AP_CLAIM_IF_OUT_RFV_DX
-- This table contains reason for visit diagnosis code of the claim the system sends out to the third party interface.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_ID) AS CLAIM_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(OUT_RFV_DX_CODE) AS OUT_RFV_DX_CODE_filled
FROM AP_CLAIM_IF_OUT_RFV_DX;

-- ==========================================================
-- Table: AP_CLAIM_IF_PRC_AD_DX_EDT
-- This table contains the description of the admission diagnosis edit value returned from the third party interface.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_ID) AS CLAIM_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(ADMIT_DX_EDIT_DESCRIPTION) AS ADMIT_DX_EDIT_DESCRIPTION_filled
FROM AP_CLAIM_IF_PRC_AD_DX_EDT;

-- ==========================================================
-- Table: AP_CLAIM_IF_PRIN_DX_ERRS
-- Principal Diagnosis Errors.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_ID) AS CLAIM_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(PRIN_DX_ERRORS) AS PRIN_DX_ERRORS_filled
FROM AP_CLAIM_IF_PRIN_DX_ERRS;

-- ==========================================================
-- Table: AP_CLAIM_IF_SEC_DX_SEQ
-- Numerical values representing the secondary diagnosis codes (submitted and/or mapped); not the actual diagnosis codes themselves.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_ID) AS CLAIM_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(SEC_DX_SEQUENCE) AS SEC_DX_SEQUENCE_filled
FROM AP_CLAIM_IF_SEC_DX_SEQ;

-- ==========================================================
-- Table: AP_CLAIM_REVIEW
-- The AP_CLAIM_REVIEW table contains a row for each review on a claim.
-- Bucket(s): Claims / Denials
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_ID) AS CLAIM_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(AP_CLAIM_REVIEW_TYPE_C_NAME) AS AP_CLAIM_REVIEW_TYPE_C_NAME_filled,
    COUNT(ATTACH_COMMENT) AS ATTACH_COMMENT_filled,
    COUNT(AP_CLAIM_REVIEW_STATUS_C_NAME) AS AP_CLAIM_REVIEW_STATUS_C_NAME_filled,
    COUNT(ATTACH_DTTM) AS ATTACH_DTTM_filled,
    COUNT(COMPLETION_COMMENT) AS COMPLETION_COMMENT_filled,
    COUNT(COMPLETION_DTTM) AS COMPLETION_DTTM_filled,
    COUNT(REJECTION_EOB_CODE_ID_EOB_CODE_NAME) AS REJECTION_EOB_CODE_ID_EOB_CODE_NAME_filled,
    COUNT(ADDED_MANUALLY_YN) AS ADDED_MANUALLY_YN_filled,
    COUNT(REVIEW_STATUS_REASON_C_NAME) AS REVIEW_STATUS_REASON_C_NAME_filled
FROM AP_CLAIM_REVIEW;

-- ==========================================================
-- Table: AP_CLM_IF_MOE_DX_CODE_TYP
-- Diagnosis code types received by prospective payment systems (PPS) pricers that use the Medicaid Outpatient Editor (MOE). This table extracts the related multiple response item CLM-22310.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_ID) AS CLAIM_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(MOE_DX_CODE_TYPE) AS MOE_DX_CODE_TYPE_filled
FROM AP_CLM_IF_MOE_DX_CODE_TYP;

-- ==========================================================
-- Table: AP_CLM_IF_MOE_DX_ERRORS
-- Diagnosis errors received by prospective payment systems (PPS) pricers that use the Medicaid Outpatient Editor (MOE). This table extracts the related multiple response item CLM-22313.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_ID) AS CLAIM_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(MOE_DX_ERRORS) AS MOE_DX_ERRORS_filled
FROM AP_CLM_IF_MOE_DX_ERRORS;

-- ==========================================================
-- Table: AP_CLM_IF_MOE_DX_ERR_NUM
-- The number of diagnosis code errors received by prospective payment systems (PPS) pricers that use the Medicaid Outpatient Editor (MOE). This table extracts the related multiple response item CLM-2231
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_ID) AS CLAIM_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(MOE_PER_DX_ERR_NUM) AS MOE_PER_DX_ERR_NUM_filled
FROM AP_CLM_IF_MOE_DX_ERR_NUM;

-- ==========================================================
-- Table: AP_CLM_IF_MOE_DX_HI_DISP
-- The highest diagnosis dispositions received by prospective payment systems (PPS) pricers that use the Medicaid Outpatient Editor (MOE). This table extracts the related multiple response item CLM-22311
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_ID) AS CLAIM_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(MOE_HIGH_DX_DISP) AS MOE_HIGH_DX_DISP_filled
FROM AP_CLM_IF_MOE_DX_HI_DISP;

-- ==========================================================
-- Table: AP_CLM_VST_RSN_DX
-- This table stores the diagnoses that formed the reason for the patient's visit.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_ID) AS CLAIM_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(VST_RSN_DX_ID_DX_NAME) AS VST_RSN_DX_ID_DX_NAME_filled
FROM AP_CLM_VST_RSN_DX;

-- ==========================================================
-- Table: AP_PROC_ASSOC_DX
-- This table summarizes diagnoses associated with AP claim service lines. To link this table’s service line information back to a claim header, join this table to AP_CLAIM_PROC_IDS on the TX_ID column. 
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(ETR_ID) AS ETR_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(DX_ID_DX_NAME) AS DX_ID_DX_NAME_filled,
    COUNT(DX_QUAL_C_NAME) AS DX_QUAL_C_NAME_filled,
    COUNT(DX_NUM) AS DX_NUM_filled,
    COUNT(DX_RANK) AS DX_RANK_filled
FROM AP_PROC_ASSOC_DX;

-- ==========================================================
-- Table: ARPB_CHG_ENTRY_DX
-- The table lists all diagnoses on a charge entry session in which the charge was posted.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(TX_ID) AS TX_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(DX_ID_DX_NAME) AS DX_ID_DX_NAME_filled,
    COUNT(DX_QUALIFIER_C_NAME) AS DX_QUALIFIER_C_NAME_filled
FROM ARPB_CHG_ENTRY_DX;

-- ==========================================================
-- Table: ARPB_CHG_ENTRY_DX_ALT
-- The table lists all diagnoses entered in a charge entry, from the alternative diagnosis code set.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(TX_ID) AS TX_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(DX_ID_DX_NAME) AS DX_ID_DX_NAME_filled,
    COUNT(DX_QUALIFIER_C_NAME) AS DX_QUALIFIER_C_NAME_filled
FROM ARPB_CHG_ENTRY_DX_ALT;

-- ==========================================================
-- Table: ARPB_PMT_RELATED_DENIALS
-- Denial records associated with this payment for evaluating denial rate metrics.
-- Bucket(s): Claims / Denials
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(TX_ID) AS TX_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(RELATED_BDC_ID) AS RELATED_BDC_ID_filled
FROM ARPB_PMT_RELATED_DENIALS;

-- ==========================================================
-- Table: ASSOCIATED_DX
-- Diagnoses associated with treatment plans.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(TREATMENT_PLAN_ID) AS TREATMENT_PLAN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(DX_ID_DX_NAME) AS DX_ID_DX_NAME_filled,
    COUNT(SPECIFIC_DX_ID_DX_NAME) AS SPECIFIC_DX_ID_DX_NAME_filled,
    COUNT(PROBLEM_LIST_ID) AS PROBLEM_LIST_ID_filled,
    COUNT(PROBLEM_LINKED_TO_PLAN_YN) AS PROBLEM_LINKED_TO_PLAN_YN_filled
FROM ASSOCIATED_DX;

-- ==========================================================
-- Table: ATB_AUTH_DENIAL_RSNS
-- This table contains the reasons for denial when the authorization decision is denied.
-- Bucket(s): Claims / Denials
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(AUTH_BUNDLE_ID) AS AUTH_BUNDLE_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(AUTH_PYR_DENIAL_REASON_C_NAME) AS AUTH_PYR_DENIAL_REASON_C_NAME_filled
FROM ATB_AUTH_DENIAL_RSNS;

-- ==========================================================
-- Table: ATB_AUTH_DIAGNOSES
-- This table contains information pertaining to the diagnosis information for an Auth Bundle.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
SELECT
    YEAR(AUTH_DX_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(AUTH_BUNDLE_ID) AS AUTH_BUNDLE_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(AUTH_DX_REF_ID) AS AUTH_DX_REF_ID_filled,
    COUNT(AUTH_DX_ID_DX_NAME) AS AUTH_DX_ID_DX_NAME_filled,
    COUNT(AUTH_PA_DX_TYPE_C_NAME) AS AUTH_PA_DX_TYPE_C_NAME_filled,
    COUNT(AUTH_DX_DATE) AS AUTH_DX_DATE_filled
FROM ATB_AUTH_DIAGNOSES
GROUP BY YEAR(AUTH_DX_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: AUTHORIZATIONS
-- This table contains information about authorization records. This includes links to the patient, referral, and coverage/payer.
-- Bucket(s): Claims / Denials
-- ==========================================================
SELECT
    YEAR(AUTH_FROM_DT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(AUTH_ID) AS AUTH_ID_filled,
    COUNT(AUTH_FROM_DT) AS AUTH_FROM_DT_filled,
    COUNT(AUTH_TO_DT) AS AUTH_TO_DT_filled,
    COUNT(PAT_ID) AS PAT_ID_filled,
    COUNT(REFERRAL_ID) AS REFERRAL_ID_filled,
    COUNT(AUTH_TYPE_C_NAME) AS AUTH_TYPE_C_NAME_filled,
    COUNT(NUM_SVCS_APPROVED) AS NUM_SVCS_APPROVED_filled,
    COUNT(NUM_SVCS_REQUESTED) AS NUM_SVCS_REQUESTED_filled,
    COUNT(CVG_ID) AS CVG_ID_filled,
    COUNT(AUTH_NUM) AS AUTH_NUM_filled,
    COUNT(AUTH_COMMENTS) AS AUTH_COMMENTS_filled,
    COUNT(RECORD_CREATION_DT) AS RECORD_CREATION_DT_filled,
    COUNT(CHARGE_COUNTS) AS CHARGE_COUNTS_filled,
    COUNT(AUTH_REF_NUMBER) AS AUTH_REF_NUMBER_filled,
    COUNT(AP_CLAIM_COUNT) AS AP_CLAIM_COUNT_filled,
    COUNT(INTER_NUM_SVCS_APRV) AS INTER_NUM_SVCS_APRV_filled,
    COUNT(INTER_NUM_SVCS_REQ) AS INTER_NUM_SVCS_REQ_filled,
    COUNT(INTER_APRV_FREQ_ID) AS INTER_APRV_FREQ_ID_filled,
    COUNT(INTER_APRV_FREQ_ID_FREQ_NAME) AS INTER_APRV_FREQ_ID_FREQ_NAME_filled,
    COUNT(INTER_REQ_FREQ_ID) AS INTER_REQ_FREQ_ID_filled,
    COUNT(INTER_REQ_FREQ_ID_FREQ_NAME) AS INTER_REQ_FREQ_ID_FREQ_NAME_filled,
    COUNT(INTER_NUM_APRV) AS INTER_NUM_APRV_filled,
    COUNT(INTER_NUM_REQ) AS INTER_NUM_REQ_filled,
    COUNT(PARENT_AUTH_ID) AS PARENT_AUTH_ID_filled,
    COUNT(AP_CLAIM_COUNT_METHOD_C_NAME) AS AP_CLAIM_COUNT_METHOD_C_NAME_filled,
    COUNT(UM_STATUS_C_NAME) AS UM_STATUS_C_NAME_filled,
    COUNT(UM_APPROVED_RSN_C_NAME) AS UM_APPROVED_RSN_C_NAME_filled,
    COUNT(UM_PART_APRV_RSN_C_NAME) AS UM_PART_APRV_RSN_C_NAME_filled,
    COUNT(UM_DENIED_RSN_C_NAME) AS UM_DENIED_RSN_C_NAME_filled,
    COUNT(UM_DISMISSED_RSN_C_NAME) AS UM_DISMISSED_RSN_C_NAME_filled,
    COUNT(UM_NOT_REQUIRED_RSN_C_NAME) AS UM_NOT_REQUIRED_RSN_C_NAME_filled,
    COUNT(UM_PENDING_RSN_C_NAME) AS UM_PENDING_RSN_C_NAME_filled,
    COUNT(UM_CANCELED_RSN_C_NAME) AS UM_CANCELED_RSN_C_NAME_filled,
    COUNT(UM_DECISION_DTTM) AS UM_DECISION_DTTM_filled,
    COUNT(NON_UM_AUTH_ID) AS NON_UM_AUTH_ID_filled,
    COUNT(UM_AUTH_REQUEST_ID) AS UM_AUTH_REQUEST_ID_filled,
    COUNT(NON_UM_ORDER_ID) AS NON_UM_ORDER_ID_filled,
    COUNT(ORDER_ENTRY_ORDER_ID) AS ORDER_ENTRY_ORDER_ID_filled,
    COUNT(UM_CLOSED_RSN_C_NAME) AS UM_CLOSED_RSN_C_NAME_filled,
    COUNT(UM_FINALIZE_USER_ID) AS UM_FINALIZE_USER_ID_filled,
    COUNT(UM_FINALIZE_USER_ID_NAME) AS UM_FINALIZE_USER_ID_NAME_filled,
    COUNT(FINAL_UM_STATUS_CHANGE_SRC_C_NAME) AS FINAL_UM_STATUS_CHANGE_SRC_C_NAME_filled,
    COUNT(AUTH_STATUS_C_NAME) AS AUTH_STATUS_C_NAME_filled,
    COUNT(UM_MED_DIR_REV_USER_ID) AS UM_MED_DIR_REV_USER_ID_filled,
    COUNT(UM_MED_DIR_REV_USER_ID_NAME) AS UM_MED_DIR_REV_USER_ID_NAME_filled,
    COUNT(UM_PEND_MED_DIRECTOR_DTTM) AS UM_PEND_MED_DIRECTOR_DTTM_filled,
    COUNT(UM_PEND_MED_DIRECTOR_UTC_DTTM) AS UM_PEND_MED_DIRECTOR_UTC_DTTM_filled,
    COUNT(FIRST_PAT_ENC_CSN_ID) AS FIRST_PAT_ENC_CSN_ID_filled,
    COUNT(LAST_PAT_ENC_CSN_ID) AS LAST_PAT_ENC_CSN_ID_filled,
    COUNT(APPEALED_SERVICE_AUTH_ID) AS APPEALED_SERVICE_AUTH_ID_filled,
    COUNT(LAST_CVG_GUIDANCE_C_NAME) AS LAST_CVG_GUIDANCE_C_NAME_filled,
    COUNT(UM_CVG_GUIDANCE_SOURCE_C_NAME) AS UM_CVG_GUIDANCE_SOURCE_C_NAME_filled,
    COUNT(UM_CVG_GDNC_REALTIME_TX_CSN_ID) AS UM_CVG_GDNC_REALTIME_TX_CSN_ID_filled,
    COUNT(UM_CVG_GUIDANCE_PA_SVC_LN_IDNT) AS UM_CVG_GUIDANCE_PA_SVC_LN_IDNT_filled,
    COUNT(UM_CVG_GUIDANCE_C_NAME) AS UM_CVG_GUIDANCE_C_NAME_filled,
    COUNT(UM_CVG_GUIDANCE_FROM_PROV_ID_PROV_NAME) AS UM_CVG_GUIDANCE_FROM_PROV_ID_PROV_NAME_filled,
    COUNT(UM_CVG_GUIDANCE_REQ_DATE) AS UM_CVG_GUIDANCE_REQ_DATE_filled,
    COUNT(UM_CVG_GUIDANCE_REQ_LOC_ID_LOC_NAME) AS UM_CVG_GUIDANCE_REQ_LOC_ID_LOC_NAME_filled,
    COUNT(UM_CVG_GUIDANCE_REQ_VENDOR_ID_VENDOR_NAME) AS UM_CVG_GUIDANCE_REQ_VENDOR_ID_VENDOR_NAME_filled,
    COUNT(UM_CVG_GUIDANCE_REQ_DEPT_ID_EXTERNAL_NAME) AS UM_CVG_GUIDANCE_REQ_DEPT_ID_EXTERNAL_NAME_filled,
    COUNT(UM_CVG_GUIDANCE_REQUEST_NOTE) AS UM_CVG_GUIDANCE_REQUEST_NOTE_filled,
    COUNT(UM_CVG_GUIDANCE_LOB_ID) AS UM_CVG_GUIDANCE_LOB_ID_filled,
    COUNT(UM_CVG_GUIDANCE_LOB_ID_LOB_NAME) AS UM_CVG_GUIDANCE_LOB_ID_LOB_NAME_filled,
    COUNT(UM_CVG_GUIDANCE_PAYER_ID_PAYOR_NAME) AS UM_CVG_GUIDANCE_PAYER_ID_PAYOR_NAME_filled,
    COUNT(UM_CVG_GUIDANCE_PLAN_ID_BENEFIT_PLAN_NAME) AS UM_CVG_GUIDANCE_PLAN_ID_BENEFIT_PLAN_NAME_filled,
    COUNT(UM_CVG_GUIDANCE_CREATE_USER_ID) AS UM_CVG_GUIDANCE_CREATE_USER_ID_filled,
    COUNT(UM_CVG_GUIDANCE_CREATE_USER_ID_NAME) AS UM_CVG_GUIDANCE_CREATE_USER_ID_NAME_filled,
    COUNT(DENIAL_REASON_C_NAME) AS DENIAL_REASON_C_NAME_filled,
    COUNT(AUTH_BED_DAY_TYPE_ID) AS AUTH_BED_DAY_TYPE_ID_filled,
    COUNT(AUTH_BED_DAY_TYPE_ID_BED_DAY_TYPE_NAME) AS AUTH_BED_DAY_TYPE_ID_BED_DAY_TYPE_NAME_filled,
    COUNT(NUM_DAYS_APPROVED) AS NUM_DAYS_APPROVED_filled,
    COUNT(NUM_NIGHTS_APPROVED) AS NUM_NIGHTS_APPROVED_filled,
    COUNT(EXT_SVC_MSG) AS EXT_SVC_MSG_filled,
    COUNT(EXT_SVC_REF_NUM) AS EXT_SVC_REF_NUM_filled,
    COUNT(EXT_SVC_AUTH_NUM) AS EXT_SVC_AUTH_NUM_filled,
    COUNT(UM_CVG_GUIDANCE_RESP_AGENCY_ID) AS UM_CVG_GUIDANCE_RESP_AGENCY_ID_filled,
    COUNT(UM_CVG_GUIDANCE_RESP_AGENCY_ID_AGENCY_NAME) AS UM_CVG_GUIDANCE_RESP_AGENCY_ID_AGENCY_NAME_filled,
    COUNT(AUTH_BED_DAY_TX_STATUS_C_NAME) AS AUTH_BED_DAY_TX_STATUS_C_NAME_filled,
    COUNT(UM_REQ_RX_QTY) AS UM_REQ_RX_QTY_filled,
    COUNT(UM_REQ_RX_DISP_QTYUNIT_C_NAME) AS UM_REQ_RX_DISP_QTYUNIT_C_NAME_filled,
    COUNT(UM_REQ_RX_DAYS) AS UM_REQ_RX_DAYS_filled,
    COUNT(REQ_UM_MED_TIER_C_NAME) AS REQ_UM_MED_TIER_C_NAME_filled,
    COUNT(UM_MEDICATION_ID_MEDICATION_NAME) AS UM_MEDICATION_ID_MEDICATION_NAME_filled,
    COUNT(UM_NDC_ID) AS UM_NDC_ID_filled,
    COUNT(UM_NDC_ID_NDC_CODE) AS UM_NDC_ID_NDC_CODE_filled,
    COUNT(UM_APRV_RX_QTY) AS UM_APRV_RX_QTY_filled,
    COUNT(UM_APRV_RX_DISP_QTYUNIT_C_NAME) AS UM_APRV_RX_DISP_QTYUNIT_C_NAME_filled,
    COUNT(UM_APRV_RX_DAYS) AS UM_APRV_RX_DAYS_filled,
    COUNT(APRV_UM_MED_TIER_C_NAME) AS APRV_UM_MED_TIER_C_NAME_filled,
    COUNT(UM_CVG_GUIDANCE_POS_TYPE_C_NAME) AS UM_CVG_GUIDANCE_POS_TYPE_C_NAME_filled,
    COUNT(UM_FORMULARY_QL_QUANTITY) AS UM_FORMULARY_QL_QUANTITY_filled,
    COUNT(UM_FORMULARY_QL_DISP_QTYUNIT_C_NAME) AS UM_FORMULARY_QL_DISP_QTYUNIT_C_NAME_filled,
    COUNT(UM_FORMULARY_QL_DAYS) AS UM_FORMULARY_QL_DAYS_filled,
    COUNT(UM_FORMULARY_UM_MED_TIER_C_NAME) AS UM_FORMULARY_UM_MED_TIER_C_NAME_filled,
    COUNT(UM_FINAL_STS_CHANGE_LOCAL_DTTM) AS UM_FINAL_STS_CHANGE_LOCAL_DTTM_filled,
    COUNT(UM_FINAL_STS_CHANGE_UTC_DTTM) AS UM_FINAL_STS_CHANGE_UTC_DTTM_filled,
    COUNT(UM_CVG_GDNC_CVRD_MEM_BENEFIT_C_NAME) AS UM_CVG_GDNC_CVRD_MEM_BENEFIT_C_NAME_filled
FROM AUTHORIZATIONS
GROUP BY YEAR(AUTH_FROM_DT)
ORDER BY activity_year;

-- ==========================================================
-- Table: AUTH_UM_CVG_GUIDANCE_DX
-- This table contains diagnosis information associated with a coverage guidance request.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(AUTH_ID) AS AUTH_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(UM_CVG_GUIDANCE_DX_ID_DX_NAME) AS UM_CVG_GUIDANCE_DX_ID_DX_NAME_filled
FROM AUTH_UM_CVG_GUIDANCE_DX;

-- ==========================================================
-- Table: BDC_ADDL_CLAIM_STS_CSN
-- This table contains information of contributing claim status messages for a claim status follow-up record.
-- Bucket(s): Claims / Denials
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(BDC_ID) AS BDC_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(ADDL_CLAIM_RECON_CSN_ID) AS ADDL_CLAIM_RECON_CSN_ID_filled
FROM BDC_ADDL_CLAIM_STS_CSN;

-- ==========================================================
-- Table: BDC_ASSOC_REMARK_CODES
-- This table lists the remark codes associated with a Denial/Correspondence (BDC) record.
-- Bucket(s): Claims / Denials
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(BDC_ID) AS BDC_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(REMARK_CODE_ID) AS REMARK_CODE_ID_filled,
    COUNT(REMARK_CODE_ID_REMIT_CODE_NAME) AS REMARK_CODE_ID_REMIT_CODE_NAME_filled
FROM BDC_ASSOC_REMARK_CODES;

-- ==========================================================
-- Table: BDC_CLAIM_STATUS
-- This table contains information about the claim status for claim status follow-up (BDC) records, including claim status reason codes and claim status codes.
-- Bucket(s): Claims / Denials
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(BDC_ID) AS BDC_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(CLAIM_STAT_RSN_C_NAME) AS CLAIM_STAT_RSN_C_NAME_filled,
    COUNT(CLM_STATUS_CODE_C_NAME) AS CLM_STATUS_CODE_C_NAME_filled,
    COUNT(CLM_STATUS_DATA) AS CLM_STATUS_DATA_filled
FROM BDC_CLAIM_STATUS;

-- ==========================================================
-- Table: BDC_INFO
-- This table contains Denial/Remark/Correspondence/Variance/Claim Status Follow-Up information from the Denial/Correspondence (BDC) master file. It includes information about the denial/remark code rece
-- Bucket(s): Claims / Denials
-- ==========================================================
SELECT
    YEAR(INV_END_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(BDC_ID) AS BDC_ID_filled,
    COUNT(BDC_NAME) AS BDC_NAME_filled,
    COUNT(RECORD_TYPE_C_NAME) AS RECORD_TYPE_C_NAME_filled,
    COUNT(BUCKET_ID) AS BUCKET_ID_filled,
    COUNT(RECORD_STATUS_C_NAME) AS RECORD_STATUS_C_NAME_filled,
    COUNT(RECORD_SOURCE_C_NAME) AS RECORD_SOURCE_C_NAME_filled,
    COUNT(CLAIM_PRINT_ID) AS CLAIM_PRINT_ID_filled,
    COUNT(INVOICE_NUMBER) AS INVOICE_NUMBER_filled,
    COUNT(GRP_CODE_C_NAME) AS GRP_CODE_C_NAME_filled,
    COUNT(REMIT_CODE_ID) AS REMIT_CODE_ID_filled,
    COUNT(REMIT_CODE_ID_REMIT_CODE_NAME) AS REMIT_CODE_ID_REMIT_CODE_NAME_filled,
    COUNT(EXTERNAL_CODE) AS EXTERNAL_CODE_filled,
    COUNT(INV_END_DATE) AS INV_END_DATE_filled,
    COUNT(SOURCE_PMT_HB_TX_ID) AS SOURCE_PMT_HB_TX_ID_filled,
    COUNT(EXP_ALLOW_AMT) AS EXP_ALLOW_AMT_filled,
    COUNT(RESOLVE_REASON_C_NAME) AS RESOLVE_REASON_C_NAME_filled,
    COUNT(RESOLVE_COMMENTS) AS RESOLVE_COMMENTS_filled,
    COUNT(BDC_RECEIVE_DATE) AS BDC_RECEIVE_DATE_filled,
    COUNT(BDC_COMPLETE_VOID_DATE) AS BDC_COMPLETE_VOID_DATE_filled,
    COUNT(BDC_REOPEN_DATE) AS BDC_REOPEN_DATE_filled,
    COUNT(PB_INVOICE_ID) AS PB_INVOICE_ID_filled,
    COUNT(GUARANTOR_ID) AS GUARANTOR_ID_filled,
    COUNT(DOC_INFO_ID) AS DOC_INFO_ID_filled,
    COUNT(WRITE_OFF_AMT_SYS) AS WRITE_OFF_AMT_SYS_filled,
    COUNT(WRITE_OFF_AMT_CALC) AS WRITE_OFF_AMT_CALC_filled,
    COUNT(DISCREPANCY_AMT_SYS) AS DISCREPANCY_AMT_SYS_filled,
    COUNT(CLM_EXT_VAL_ID) AS CLM_EXT_VAL_ID_filled,
    COUNT(BILLING_DRG) AS BILLING_DRG_filled,
    COUNT(PAYER_RECOMMENDED_DRG) AS PAYER_RECOMMENDED_DRG_filled,
    COUNT(FINAL_RESOLUTION_DRG) AS FINAL_RESOLUTION_DRG_filled,
    COUNT(EXPECTED_RECOVERY_AMT) AS EXPECTED_RECOVERY_AMT_filled,
    COUNT(ACTUAL_RECOVERY_AMT_USER) AS ACTUAL_RECOVERY_AMT_USER_filled,
    COUNT(WRITE_OFF_AMT_USER) AS WRITE_OFF_AMT_USER_filled,
    COUNT(EXT_PAT_NAME) AS EXT_PAT_NAME_filled,
    COUNT(EXT_PAT_MRN) AS EXT_PAT_MRN_filled,
    COUNT(EXT_ADMIT_DATE) AS EXT_ADMIT_DATE_filled,
    COUNT(EXT_DISCHARGE_DATE) AS EXT_DISCHARGE_DATE_filled,
    COUNT(EXT_CLAIM_NUM) AS EXT_CLAIM_NUM_filled,
    COUNT(EXT_PAT_BIRTH_DATE) AS EXT_PAT_BIRTH_DATE_filled,
    COUNT(SOURCE_PMT_PB_TX_ID) AS SOURCE_PMT_PB_TX_ID_filled,
    COUNT(DFLT_CLASS_USES_REMARK_CODE_ID) AS DFLT_CLASS_USES_REMARK_CODE_ID_filled,
    COUNT(DFLT_CLASS_USES_REMARK_CODE_ID_REMIT_CODE_NAME) AS DFLT_CLASS_USES_REMARK_CODE_ID_REMIT_CODE_NAME_filled,
    COUNT(APPEAL_DEADLINE_DATE) AS APPEAL_DEADLINE_DATE_filled,
    COUNT(PAYER_DOWNGRADE_TYPE_C_NAME) AS PAYER_DOWNGRADE_TYPE_C_NAME_filled,
    COUNT(PAYER_DOWNGRADE_OUTCOME_C_NAME) AS PAYER_DOWNGRADE_OUTCOME_C_NAME_filled,
    COUNT(RECONCILE_CLAIM_STATUS_C_NAME) AS RECONCILE_CLAIM_STATUS_C_NAME_filled,
    COUNT(INT_CONTROL_NUMBER) AS INT_CONTROL_NUMBER_filled,
    COUNT(CLAIM_RECON_ID) AS CLAIM_RECON_ID_filled,
    COUNT(CLAIM_RECON_CSN_ID) AS CLAIM_RECON_CSN_ID_filled,
    COUNT(FOLLOW_UP_CONTEXT_C_NAME) AS FOLLOW_UP_CONTEXT_C_NAME_filled,
    COUNT(APPEAL_LLM_TEXT_GENERATED_YN) AS APPEAL_LLM_TEXT_GENERATED_YN_filled
FROM BDC_INFO
GROUP BY YEAR(INV_END_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: BDC_LOINC_CODES
-- This table contains LOINC code and mapping information that will help identify documentations needed from loading a 277 RF(A)I message.
-- Bucket(s): Claims / Denials
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(BDC_ID) AS BDC_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(LOINC_CODE) AS LOINC_CODE_filled
FROM BDC_LOINC_CODES;

-- ==========================================================
-- Table: BDC_PB_CHGS
-- This table stores PB Denial/Correspondence (BDC) denial records and the charge transactions that were denied by that denial record.
-- Bucket(s): Claims / Denials
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(BDC_ID) AS BDC_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(TX_ID) AS TX_ID_filled,
    COUNT(FOL_ID) AS FOL_ID_filled
FROM BDC_PB_CHGS;

-- ==========================================================
-- Table: BUNDLE_CHARGE_DX
-- Clarity table for bundleable charge diagnosis.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(RECORD_ID) AS RECORD_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(DX_ID_DX_NAME) AS DX_ID_DX_NAME_filled,
    COUNT(DX_QUAL_C_NAME) AS DX_QUAL_C_NAME_filled
FROM BUNDLE_CHARGE_DX;

-- ==========================================================
-- Table: CANCER_RISK_SCORE_AGE
-- This table contains the age associated with a risk score.
-- Bucket(s): HCC / Risk adjustment
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(SCORE_AGE) AS SCORE_AGE_filled
FROM CANCER_RISK_SCORE_AGE;

-- ==========================================================
-- Table: CANCER_RISK_SCORE_DX
-- This table contains the diagnoses associated with the risk scores saved to the patient encounter.
-- Bucket(s): ICD-10 / Diagnosis coding;HCC / Risk adjustment
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(SCORE_DX_ID_DX_NAME) AS SCORE_DX_ID_DX_NAME_filled
FROM CANCER_RISK_SCORE_DX;

-- ==========================================================
-- Table: CANCER_RISK_SCORE_TYPE
-- This table contains the types of risk scores saved to the patient encounter.
-- Bucket(s): HCC / Risk adjustment
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(PAT_ENC_DATE_REAL) AS PAT_ENC_DATE_REAL_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(CM_CT_OWNER_ID) AS CM_CT_OWNER_ID_filled,
    COUNT(CANCER_RISK_TYPE_C_NAME) AS CANCER_RISK_TYPE_C_NAME_filled
FROM CANCER_RISK_SCORE_TYPE
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: CASE_DX
-- The CASE_DX table allows you to report on diagnoses associated with case records.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CASE_ID) AS CASE_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(DX_ID_DX_NAME) AS DX_ID_DX_NAME_filled
FROM CASE_DX;

-- ==========================================================
-- Table: CASE_ICD_PROC
-- The CASE_ICD_PROC table contains information about ICD procedures associated with case records.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CASE_ID) AS CASE_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(ICD_PX_ID) AS ICD_PX_ID_filled,
    COUNT(ICD_PX_ID_ICD_PX_NAME) AS ICD_PX_ID_ICD_PX_NAME_filled
FROM CASE_ICD_PROC;

-- ==========================================================
-- Table: CDI_WORKING_DX
-- The CDI_WORKING_DX table contains information related to working diagnoses for a Clinical Documentation Improvement (CDI) review.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CODING_RECORD_ID) AS CODING_RECORD_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(CDI_WKG_DX_ID_DX_NAME) AS CDI_WKG_DX_ID_DX_NAME_filled,
    COUNT(CDI_WKG_DX_POA_C_NAME) AS CDI_WKG_DX_POA_C_NAME_filled,
    COUNT(CONTACT_SERIAL_NUM) AS CONTACT_SERIAL_NUM_filled,
    COUNT(CDI_WKG_DX_CC_C_NAME) AS CDI_WKG_DX_CC_C_NAME_filled,
    COUNT(WKG_DX_HAC_YN) AS WKG_DX_HAC_YN_filled
FROM CDI_WORKING_DX
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: CDI_WORKING_DX_HACS
-- The Hospital Acquired Conditions (HACs) associated with working review diagnoses.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CODING_RECORD_ID) AS CODING_RECORD_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(WKG_DX_HAC_CAT_C_NAME) AS WKG_DX_HAC_CAT_C_NAME_filled
FROM CDI_WORKING_DX_HACS
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: CHG_REVIEW_DX
-- This table contains one row for each diagnosis entered on a temporary accounts receivable (TAR) record that is or has been in a charge review workqueue. This is not the diagnosis associated with indiv
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(TAR_ID) AS TAR_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(DX_QUAL_C_NAME) AS DX_QUAL_C_NAME_filled
FROM CHG_REVIEW_DX;

-- ==========================================================
-- Table: CLAIM_INFO
-- This table contains information from claim info records for Hospital and Professional Billing.
-- Bucket(s): Claims / Denials
-- ==========================================================
SELECT
    YEAR(ENTRY_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CLAIM_ID) AS CLAIM_ID_filled,
    COUNT(CLAIM_NAME) AS CLAIM_NAME_filled,
    COUNT(ACCOUNT_ID) AS ACCOUNT_ID_filled,
    COUNT(CLAIM_TYPE_C_NAME) AS CLAIM_TYPE_C_NAME_filled,
    COUNT(USER_ID) AS USER_ID_filled,
    COUNT(USER_ID_NAME) AS USER_ID_NAME_filled,
    COUNT(ENTRY_DATE) AS ENTRY_DATE_filled,
    COUNT(COVERAGE_ID) AS COVERAGE_ID_filled,
    COUNT(ADMIT_DATETIME) AS ADMIT_DATETIME_filled,
    COUNT(CLM_PAT_STATUS_C_NAME) AS CLM_PAT_STATUS_C_NAME_filled,
    COUNT(PROV_ID_PROV_NAME) AS PROV_ID_PROV_NAME_filled,
    COUNT(ADMISSION_SOURCE_C_NAME) AS ADMISSION_SOURCE_C_NAME_filled,
    COUNT(ADMISSION_TYPE_C_NAME) AS ADMISSION_TYPE_C_NAME_filled,
    COUNT(ADMIT_DX_ID_DX_NAME) AS ADMIT_DX_ID_DX_NAME_filled,
    COUNT(ILL_INJ_LMP_C_NAME) AS ILL_INJ_LMP_C_NAME_filled,
    COUNT(REL_CONDITION_C_NAME) AS REL_CONDITION_C_NAME_filled,
    COUNT(DOC_CTRL_NUM) AS DOC_CTRL_NUM_filled,
    COUNT(INJURY_DATETIME) AS INJURY_DATETIME_filled,
    COUNT(ACCIDENT_TYPE_C_NAME) AS ACCIDENT_TYPE_C_NAME_filled,
    COUNT(IS_EPSDT_YN) AS IS_EPSDT_YN_filled,
    COUNT(EPSDT_CODE_C_NAME) AS EPSDT_CODE_C_NAME_filled,
    COUNT(WC_CLAIM_NUM) AS WC_CLAIM_NUM_filled,
    COUNT(WC_EMPLOYER_ID) AS WC_EMPLOYER_ID_filled,
    COUNT(WC_EMPLOYER_ID_EMPLOYER_NAME) AS WC_EMPLOYER_ID_EMPLOYER_NAME_filled,
    COUNT(TRAN_CODE_C_NAME) AS TRAN_CODE_C_NAME_filled,
    COUNT(TRAN_REASON_C_NAME) AS TRAN_REASON_C_NAME_filled,
    COUNT(TRAN_DIST) AS TRAN_DIST_filled,
    COUNT(CLM_LOGIN_SA_ID_LOC_NAME) AS CLM_LOGIN_SA_ID_LOC_NAME_filled,
    COUNT(ILL_INJ_LMP_DT) AS ILL_INJ_LMP_DT_filled,
    COUNT(AUTO_ACDNT_STATE_C_NAME) AS AUTO_ACDNT_STATE_C_NAME_filled,
    COUNT(EMPY_RELATED_YN) AS EMPY_RELATED_YN_filled,
    COUNT(FIRST_CONSULT_DT) AS FIRST_CONSULT_DT_filled,
    COUNT(PAT_CHIEF_COMPLAINT) AS PAT_CHIEF_COMPLAINT_filled,
    COUNT(EMERG_YN) AS EMERG_YN_filled,
    COUNT(LAST_WORKED_DT) AS LAST_WORKED_DT_filled,
    COUNT(RETURN_TO_WORK_DT) AS RETURN_TO_WORK_DT_filled,
    COUNT(DISCHARGE_DT) AS DISCHARGE_DT_filled,
    COUNT(OUTSIDE_LAB_NAME_C_NAME) AS OUTSIDE_LAB_NAME_C_NAME_filled,
    COUNT(HLTH_APPR_SCRN_YN) AS HLTH_APPR_SCRN_YN_filled,
    COUNT(SIG_ON_FILE_YN) AS SIG_ON_FILE_YN_filled,
    COUNT(WK_COMP_CLAIM_NUM) AS WK_COMP_CLAIM_NUM_filled,
    COUNT(WK_COMP_INJ_DESC) AS WK_COMP_INJ_DESC_filled,
    COUNT(WK_COMP_APRV_CODE) AS WK_COMP_APRV_CODE_filled,
    COUNT(WK_COMP_MED_RLS_DT) AS WK_COMP_MED_RLS_DT_filled,
    COUNT(DF_DELAY_RSN_CODE_C_NAME) AS DF_DELAY_RSN_CODE_C_NAME_filled,
    COUNT(FIRST_NEXT_VISIT_C_NAME) AS FIRST_NEXT_VISIT_C_NAME_filled,
    COUNT(MED_HX_SOC_WORKER) AS MED_HX_SOC_WORKER_filled,
    COUNT(MED_HX_PSYCHOLOGIST) AS MED_HX_PSYCHOLOGIST_filled,
    COUNT(MED_HX_SUP_PROV) AS MED_HX_SUP_PROV_filled,
    COUNT(MED_HX_COUNSELOR) AS MED_HX_COUNSELOR_filled,
    COUNT(HDH_RFL_CODE_C_NAME) AS HDH_RFL_CODE_C_NAME_filled,
    COUNT(PHY_EXAM_CODE_C_NAME) AS PHY_EXAM_CODE_C_NAME_filled,
    COUNT(PHY_EXAM_RFL_CODE_C_NAME) AS PHY_EXAM_RFL_CODE_C_NAME_filled,
    COUNT(VISION_EXAM_CODE_C_NAME) AS VISION_EXAM_CODE_C_NAME_filled,
    COUNT(VISION_RFL_CODE_C_NAME) AS VISION_RFL_CODE_C_NAME_filled,
    COUNT(HEARING_EXAM_CODE_C_NAME) AS HEARING_EXAM_CODE_C_NAME_filled,
    COUNT(HEARING_RFL_CODE_C_NAME) AS HEARING_RFL_CODE_C_NAME_filled,
    COUNT(DEV_EXAM_CODE_C_NAME) AS DEV_EXAM_CODE_C_NAME_filled,
    COUNT(DEV_RFL_CODE_C_NAME) AS DEV_RFL_CODE_C_NAME_filled,
    COUNT(NUTRI_EXAM_CODE_C_NAME) AS NUTRI_EXAM_CODE_C_NAME_filled,
    COUNT(NUTRI_RFL_CODE_C_NAME) AS NUTRI_RFL_CODE_C_NAME_filled,
    COUNT(OTHER_TREATMNT_DT) AS OTHER_TREATMNT_DT_filled,
    COUNT(HOSPITAL_NAME) AS HOSPITAL_NAME_filled,
    COUNT(HOSPITAL_ADDRESS) AS HOSPITAL_ADDRESS_filled,
    COUNT(HOSPITAL_CITY) AS HOSPITAL_CITY_filled,
    COUNT(HOSPITAL_STATE_C_NAME) AS HOSPITAL_STATE_C_NAME_filled,
    COUNT(HOSPITAL_ZIP) AS HOSPITAL_ZIP_filled,
    COUNT(HOSP_REQ_YN) AS HOSP_REQ_YN_filled,
    COUNT(ADV_RET_WORK_YN) AS ADV_RET_WORK_YN_filled,
    COUNT(ADV_RET_WORK_DT) AS ADV_RET_WORK_DT_filled,
    COUNT(REF_PHYS_NAME) AS REF_PHYS_NAME_filled,
    COUNT(REF_PHYS_ADDR) AS REF_PHYS_ADDR_filled,
    COUNT(REF_PHYS_CITY) AS REF_PHYS_CITY_filled,
    COUNT(REF_PHYS_STATE_C_NAME) AS REF_PHYS_STATE_C_NAME_filled,
    COUNT(REF_PHYS_ZIP) AS REF_PHYS_ZIP_filled,
    COUNT(REF_PHYS_SPEC_C_NAME) AS REF_PHYS_SPEC_C_NAME_filled,
    COUNT(REF_PHYS_REASON_C_NAME) AS REF_PHYS_REASON_C_NAME_filled,
    COUNT(FIRST_TREAT_HOUR_TM) AS FIRST_TREAT_HOUR_TM_filled,
    COUNT(PAT_PREV_TREATED_YN) AS PAT_PREV_TREATED_YN_filled,
    COUNT(IDE_NUM) AS IDE_NUM_filled,
    COUNT(EST_DOB_DT) AS EST_DOB_DT_filled,
    COUNT(RESPONSIBLE_IND_YN) AS RESPONSIBLE_IND_YN_filled,
    COUNT(REFERRAL_SOURCE_ID) AS REFERRAL_SOURCE_ID_filled,
    COUNT(REFERRAL_SOURCE_ID_REFERRING_PROV_NAM) AS REFERRAL_SOURCE_ID_REFERRING_PROV_NAM_filled,
    COUNT(EMERGENCY_CODE_C_NAME) AS EMERGENCY_CODE_C_NAME_filled,
    COUNT(DISABILITY_LEVEL_C_NAME) AS DISABILITY_LEVEL_C_NAME_filled,
    COUNT(DISABILITY_FROM_DT) AS DISABILITY_FROM_DT_filled,
    COUNT(DISABILITY_TO_DT) AS DISABILITY_TO_DT_filled,
    COUNT(OUTSIDE_LAB_YN) AS OUTSIDE_LAB_YN_filled,
    COUNT(OUTSIDE_LAB_CHARGE) AS OUTSIDE_LAB_CHARGE_filled,
    COUNT(FAM_PLANNING_YN) AS FAM_PLANNING_YN_filled,
    COUNT(SPECIAL_PROGRAM_C_NAME) AS SPECIAL_PROGRAM_C_NAME_filled,
    COUNT(PGM_FOR_HANDICAP_C_NAME) AS PGM_FOR_HANDICAP_C_NAME_filled,
    COUNT(EMPLOYER_LOB) AS EMPLOYER_LOB_filled,
    COUNT(OTH_INFO) AS OTH_INFO_filled,
    COUNT(AUTH_DT) AS AUTH_DT_filled,
    COUNT(CHIR_FIRST_TREAT_DT) AS CHIR_FIRST_TREAT_DT_filled,
    COUNT(CHIR_X_RAY_DT) AS CHIR_X_RAY_DT_filled,
    COUNT(NAT_OF_COND_C_NAME) AS NAT_OF_COND_C_NAME_filled,
    COUNT(CHIR_ACUTE_MANI_DT) AS CHIR_ACUTE_MANI_DT_filled,
    COUNT(HBG_HCT_TEST_INCL_C_NAME) AS HBG_HCT_TEST_INCL_C_NAME_filled,
    COUNT(URINALYSIS_INCL_C_NAME) AS URINALYSIS_INCL_C_NAME_filled,
    COUNT(TUBERCULOSIS_INCL_C_NAME) AS TUBERCULOSIS_INCL_C_NAME_filled,
    COUNT(LEAD_TEST_INCL_C_NAME) AS LEAD_TEST_INCL_C_NAME_filled,
    COUNT(SICKLE_CELL_INCL_C_NAME) AS SICKLE_CELL_INCL_C_NAME_filled,
    COUNT(IMMNZTN_INCL_C_NAME) AS IMMNZTN_INCL_C_NAME_filled,
    COUNT(CARDIO_EXAM_CODE_C_NAME) AS CARDIO_EXAM_CODE_C_NAME_filled,
    COUNT(CARDIO_RFL_CODE_C_NAME) AS CARDIO_RFL_CODE_C_NAME_filled,
    COUNT(URINARY_EXAM_CODE_C_NAME) AS URINARY_EXAM_CODE_C_NAME_filled,
    COUNT(URINARY_RFL_CODE_C_NAME) AS URINARY_RFL_CODE_C_NAME_filled,
    COUNT(DIABETE_EXAM_CODE_C_NAME) AS DIABETE_EXAM_CODE_C_NAME_filled,
    COUNT(DIABETE_RFL_CODE_C_NAME) AS DIABETE_RFL_CODE_C_NAME_filled,
    COUNT(DENTAL_EXAM_CODE_C_NAME) AS DENTAL_EXAM_CODE_C_NAME_filled,
    COUNT(DENTAL_RFL_CODE_C_NAME) AS DENTAL_RFL_CODE_C_NAME_filled,
    COUNT(IMMNZTN_RFL_CODE_C_NAME) AS IMMNZTN_RFL_CODE_C_NAME_filled,
    COUNT(EDU_EXAM_CODE_C_NAME) AS EDU_EXAM_CODE_C_NAME_filled,
    COUNT(EDU_RFL_CODE_C_NAME) AS EDU_RFL_CODE_C_NAME_filled,
    COUNT(ONLY_CAUSE_YN) AS ONLY_CAUSE_YN_filled,
    COUNT(PAT_BURNED_YN) AS PAT_BURNED_YN_filled,
    COUNT(XRAY_BY_WHOM) AS XRAY_BY_WHOM_filled,
    COUNT(WC_XRAY_DT) AS WC_XRAY_DT_filled,
    COUNT(POLIO_IMMNZTN_C_NAME) AS POLIO_IMMNZTN_C_NAME_filled,
    COUNT(DPT_TD_IMMNZTN_C_NAME) AS DPT_TD_IMMNZTN_C_NAME_filled,
    COUNT(MEASLES_IMMNZTN_C_NAME) AS MEASLES_IMMNZTN_C_NAME_filled,
    COUNT(MUMPS_IMMNZTN_C_NAME) AS MUMPS_IMMNZTN_C_NAME_filled,
    COUNT(RUBELLA_IMMNZTN_C_NAME) AS RUBELLA_IMMNZTN_C_NAME_filled,
    COUNT(HIB_IMMNZTN_C_NAME) AS HIB_IMMNZTN_C_NAME_filled,
    COUNT(CHAMP_NONAVAIL_YN) AS CHAMP_NONAVAIL_YN_filled,
    COUNT(CHAMP_NONAV_STMT_NO) AS CHAMP_NONAV_STMT_NO_filled,
    COUNT(CHAMPUS_ORG) AS CHAMPUS_ORG_filled,
    COUNT(CHAMPUS_STATION) AS CHAMPUS_STATION_filled,
    COUNT(CHAMP_MILIT_ACC_YN) AS CHAMP_MILIT_ACC_YN_filled,
    COUNT(ALTERNATE_CLM_ID) AS ALTERNATE_CLM_ID_filled,
    COUNT(REF_PROVIDER_ID_PROV_NAME) AS REF_PROVIDER_ID_PROV_NAME_filled,
    COUNT(MC_CLAIMS_WKFLOW_C_NAME) AS MC_CLAIMS_WKFLOW_C_NAME_filled,
    COUNT(CLM_SENSITIVITY_C_NAME) AS CLM_SENSITIVITY_C_NAME_filled,
    COUNT(PLACE_OF_SERVICE_ID_LOC_NAME) AS PLACE_OF_SERVICE_ID_LOC_NAME_filled,
    COUNT(LOC_ID_LOC_NAME) AS LOC_ID_LOC_NAME_filled
FROM CLAIM_INFO
GROUP BY YEAR(ENTRY_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: CLM_DIAGNOSIS
-- Claim Information (CLM) diagnosis.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_ID) AS CLAIM_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(DX_ID_DX_NAME) AS DX_ID_DX_NAME_filled
FROM CLM_DIAGNOSIS;

-- ==========================================================
-- Table: CLM_DX
-- All values associated with a claim are stored in the Claim External Value record. The CLM_DX table holds the diagnoses for the claim.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(RECORD_ID) AS RECORD_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(CLM_DX_QUAL) AS CLM_DX_QUAL_filled,
    COUNT(CLM_DX) AS CLM_DX_filled,
    COUNT(CLM_DX_POA) AS CLM_DX_POA_filled,
    COUNT(CLM_DX_CODE_SET_OID) AS CLM_DX_CODE_SET_OID_filled,
    COUNT(CLM_DX_RANK) AS CLM_DX_RANK_filled,
    COUNT(CLM_DX_FROM_HEADER_YN) AS CLM_DX_FROM_HEADER_YN_filled,
    COUNT(RX_DX_QUAL) AS RX_DX_QUAL_filled,
    COUNT(CLM_AP_DX_POA_C_NAME) AS CLM_AP_DX_POA_C_NAME_filled,
    COUNT(DX_TYPE) AS DX_TYPE_filled,
    COUNT(DX_INFO_TYPE) AS DX_INFO_TYPE_filled,
    COUNT(CMS_DX_TYPE) AS CMS_DX_TYPE_filled
FROM CLM_DX;

-- ==========================================================
-- Table: CLM_VALUES
-- All values associated with a claim are stored in the Claim External Value record. The CLM_VALUES table holds claim-level values set by the system during claims processing or by user edits.
-- Bucket(s): Claims / Denials
-- ==========================================================
SELECT
    YEAR(PAT_BIRTH_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(RECORD_ID) AS RECORD_ID_filled,
    COUNT(BIL_PROV_TYP_QUAL) AS BIL_PROV_TYP_QUAL_filled,
    COUNT(BIL_PROV_NAM_LAST) AS BIL_PROV_NAM_LAST_filled,
    COUNT(BIL_PROV_NAM_FIRST) AS BIL_PROV_NAM_FIRST_filled,
    COUNT(BIL_PROV_NAM_MID) AS BIL_PROV_NAM_MID_filled,
    COUNT(BIL_PROV_NAM_SUF) AS BIL_PROV_NAM_SUF_filled,
    COUNT(BIL_PROV_NPI) AS BIL_PROV_NPI_filled,
    COUNT(BIL_PROV_TAXONOMY) AS BIL_PROV_TAXONOMY_filled,
    COUNT(BIL_PROV_TAXID_QUAL) AS BIL_PROV_TAXID_QUAL_filled,
    COUNT(BIL_PROV_TAXID) AS BIL_PROV_TAXID_filled,
    COUNT(BIL_PROV_UPIN) AS BIL_PROV_UPIN_filled,
    COUNT(BIL_PROV_LIC_NUM) AS BIL_PROV_LIC_NUM_filled,
    COUNT(BIL_PROV_ADDR_1) AS BIL_PROV_ADDR_1_filled,
    COUNT(BIL_PROV_ADDR_2) AS BIL_PROV_ADDR_2_filled,
    COUNT(BIL_PROV_CITY) AS BIL_PROV_CITY_filled,
    COUNT(BIL_PROV_STATE) AS BIL_PROV_STATE_filled,
    COUNT(BIL_PROV_ZIP) AS BIL_PROV_ZIP_filled,
    COUNT(BIL_PROV_CNTRY) AS BIL_PROV_CNTRY_filled,
    COUNT(BIL_PROV_CNTRY_SUB) AS BIL_PROV_CNTRY_SUB_filled,
    COUNT(CLM_CVG_SEQ_CD) AS CLM_CVG_SEQ_CD_filled,
    COUNT(CLM_CVG_PYR_NAM) AS CLM_CVG_PYR_NAM_filled,
    COUNT(CLM_CVG_GRP_NUM) AS CLM_CVG_GRP_NUM_filled,
    COUNT(CLM_CVG_GRP_NAM) AS CLM_CVG_GRP_NAM_filled,
    COUNT(CLM_CVG_INS_TYP) AS CLM_CVG_INS_TYP_filled,
    COUNT(CLM_CVG_FILING_IND) AS CLM_CVG_FILING_IND_filled,
    COUNT(CLM_CVG_PYR_ID_TYP) AS CLM_CVG_PYR_ID_TYP_filled,
    COUNT(CLM_CVG_PYR_ID) AS CLM_CVG_PYR_ID_filled,
    COUNT(CLM_CVG_ACPT_ASGN) AS CLM_CVG_ACPT_ASGN_filled,
    COUNT(CLM_CVG_AUTH_PMT) AS CLM_CVG_AUTH_PMT_filled,
    COUNT(CLM_CVG_REL_INFO) AS CLM_CVG_REL_INFO_filled,
    COUNT(PYR_ADDR_1) AS PYR_ADDR_1_filled,
    COUNT(PYR_ADDR_2) AS PYR_ADDR_2_filled,
    COUNT(PYR_CITY) AS PYR_CITY_filled,
    COUNT(PYR_STATE) AS PYR_STATE_filled,
    COUNT(PYR_ZIP) AS PYR_ZIP_filled,
    COUNT(PYR_CNTRY) AS PYR_CNTRY_filled,
    COUNT(PYR_CNTRY_SUB) AS PYR_CNTRY_SUB_filled,
    COUNT(PAT_NAM_LAST) AS PAT_NAM_LAST_filled,
    COUNT(PAT_NAM_FIRST) AS PAT_NAM_FIRST_filled,
    COUNT(PAT_NAM_MID) AS PAT_NAM_MID_filled,
    COUNT(PAT_NAM_SUF) AS PAT_NAM_SUF_filled,
    COUNT(PAT_MRN) AS PAT_MRN_filled,
    COUNT(PAT_CVG_MEM_ID) AS PAT_CVG_MEM_ID_filled,
    COUNT(PAT_REL_TO_INS) AS PAT_REL_TO_INS_filled,
    COUNT(PAT_BIRTH_DATE) AS PAT_BIRTH_DATE_filled,
    COUNT(PAT_SEX) AS PAT_SEX_filled,
    COUNT(PAT_SIG_ON_FILE) AS PAT_SIG_ON_FILE_filled,
    COUNT(PAT_SIG_SRC) AS PAT_SIG_SRC_filled,
    COUNT(PAT_DEATH_DATE) AS PAT_DEATH_DATE_filled,
    COUNT(PAT_WT) AS PAT_WT_filled,
    COUNT(PAT_PREG_IND) AS PAT_PREG_IND_filled,
    COUNT(PAT_WK_COMP_NUM) AS PAT_WK_COMP_NUM_filled,
    COUNT(PAT_MAR_STAT) AS PAT_MAR_STAT_filled,
    COUNT(PAT_EMPY_STAT) AS PAT_EMPY_STAT_filled,
    COUNT(PAT_PH) AS PAT_PH_filled,
    COUNT(PAT_ADDR_1) AS PAT_ADDR_1_filled,
    COUNT(PAT_ADDR_2) AS PAT_ADDR_2_filled,
    COUNT(PAT_CITY) AS PAT_CITY_filled,
    COUNT(PAT_STATE) AS PAT_STATE_filled,
    COUNT(PAT_ZIP) AS PAT_ZIP_filled,
    COUNT(PAT_CNTRY) AS PAT_CNTRY_filled,
    COUNT(PAT_CNTRY_SUB) AS PAT_CNTRY_SUB_filled,
    COUNT(INV_NUM) AS INV_NUM_filled,
    COUNT(ICN) AS ICN_filled,
    COUNT(TTL_CHG_AMT) AS TTL_CHG_AMT_filled,
    COUNT(BILL_TYP_FAC_CD) AS BILL_TYP_FAC_CD_filled,
    COUNT(BILL_TYP_FREQ_CD) AS BILL_TYP_FREQ_CD_filled,
    COUNT(MOMS_MRN) AS MOMS_MRN_filled,
    COUNT(PAYTO_ADDR_TYP_QUAL) AS PAYTO_ADDR_TYP_QUAL_filled
FROM CLM_VALUES
GROUP BY YEAR(PAT_BIRTH_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: CLM_VALUES_2
-- All values associated with a claim are stored in the Claim External Value record. The CLM_VALUES_2 table holds claim-level values set by the system during claims processing or by user edits.
-- Bucket(s): Claims / Denials
-- ==========================================================
SELECT
    YEAR(CLM_FROM_DT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(RECORD_ID) AS RECORD_ID_filled,
    COUNT(ADMSN_TYP) AS ADMSN_TYP_filled,
    COUNT(ADMSN_SRC) AS ADMSN_SRC_filled,
    COUNT(DISCHRG_DISP) AS DISCHRG_DISP_filled,
    COUNT(RFL_NUM) AS RFL_NUM_filled,
    COUNT(AUTH_NUM) AS AUTH_NUM_filled,
    COUNT(SPEC_PROG_IND) AS SPEC_PROG_IND_filled,
    COUNT(CLM_DELAY_RSN) AS CLM_DELAY_RSN_filled,
    COUNT(AUTH_EXCEPT_CD) AS AUTH_EXCEPT_CD_filled,
    COUNT(PAT_AMT_PAID) AS PAT_AMT_PAID_filled,
    COUNT(PAT_AMT_DUE) AS PAT_AMT_DUE_filled,
    COUNT(AUTO_ACDNT_STATE) AS AUTO_ACDNT_STATE_filled,
    COUNT(AUTO_ACDNT_CNTRY) AS AUTO_ACDNT_CNTRY_filled,
    COUNT(MAMM_CERT_NUM) AS MAMM_CERT_NUM_filled,
    COUNT(CLIA_NUM) AS CLIA_NUM_filled,
    COUNT(DEMO_PRJ_ID) AS DEMO_PRJ_ID_filled,
    COUNT(SPINAL_MAN_COND_CD) AS SPINAL_MAN_COND_CD_filled,
    COUNT(EPSDT_CERT_APPLIES) AS EPSDT_CERT_APPLIES_filled,
    COUNT(ORTHO_TOT_MO) AS ORTHO_TOT_MO_filled,
    COUNT(ORTHO_MO_REMAIN) AS ORTHO_MO_REMAIN_filled,
    COUNT(ADMSN_DX_QUAL) AS ADMSN_DX_QUAL_filled,
    COUNT(ADMSN_DX) AS ADMSN_DX_filled,
    COUNT(DRG) AS DRG_filled,
    COUNT(ANES_SURG_PROC) AS ANES_SURG_PROC_filled,
    COUNT(OUTSIDE_LAB) AS OUTSIDE_LAB_filled,
    COUNT(OUTSIDE_LAB_CHG) AS OUTSIDE_LAB_CHG_filled,
    COUNT(CLM_FROM_DT) AS CLM_FROM_DT_filled,
    COUNT(CLM_TO_DT) AS CLM_TO_DT_filled,
    COUNT(ADMSN_DT) AS ADMSN_DT_filled,
    COUNT(ADMSN_TM) AS ADMSN_TM_filled,
    COUNT(DISCHG_DT) AS DISCHG_DT_filled,
    COUNT(DISCHG_TM) AS DISCHG_TM_filled,
    COUNT(ILL_INJ_DT) AS ILL_INJ_DT_filled,
    COUNT(INIT_TREAT_DT) AS INIT_TREAT_DT_filled,
    COUNT(LST_SEEN_DT) AS LST_SEEN_DT_filled,
    COUNT(ACUTE_MANIF_DT) AS ACUTE_MANIF_DT_filled,
    COUNT(ACDNT_DT) AS ACDNT_DT_filled,
    COUNT(LMP_DT) AS LMP_DT_filled,
    COUNT(LST_XRAY_DT) AS LST_XRAY_DT_filled,
    COUNT(HEAR_VIS_RX_DT) AS HEAR_VIS_RX_DT_filled,
    COUNT(DISAB_START_DT) AS DISAB_START_DT_filled,
    COUNT(DISAB_END_DT) AS DISAB_END_DT_filled,
    COUNT(LST_WK_DT) AS LST_WK_DT_filled,
    COUNT(AUTH_RETURN_WK_DT) AS AUTH_RETURN_WK_DT_filled,
    COUNT(ASSUM_CARE_DT) AS ASSUM_CARE_DT_filled,
    COUNT(RELINQ_CARE_DT) AS RELINQ_CARE_DT_filled,
    COUNT(ORTHO_BAND_DT) AS ORTHO_BAND_DT_filled,
    COUNT(DENT_SRV_DT) AS DENT_SRV_DT_filled,
    COUNT(SIMILAR_ILL_DT) AS SIMILAR_ILL_DT_filled,
    COUNT(AMB_PAT_WT) AS AMB_PAT_WT_filled,
    COUNT(AMB_TRANS_RSN_CD) AS AMB_TRANS_RSN_CD_filled,
    COUNT(AMB_TRANS_DIST) AS AMB_TRANS_DIST_filled,
    COUNT(AMB_RND_TRIP_DESC) AS AMB_RND_TRIP_DESC_filled,
    COUNT(AMB_STRETCHER_DESC) AS AMB_STRETCHER_DESC_filled,
    COUNT(CNTRCT_TYP) AS CNTRCT_TYP_filled,
    COUNT(CNTRCT_AMT) AS CNTRCT_AMT_filled,
    COUNT(CNTRCT_PCT) AS CNTRCT_PCT_filled,
    COUNT(CNTRCT_CD) AS CNTRCT_CD_filled,
    COUNT(CNTRCT_DISCNT_PCT) AS CNTRCT_DISCNT_PCT_filled,
    COUNT(CNTRCT_VERS_ID) AS CNTRCT_VERS_ID_filled,
    COUNT(ATT_PROV_NAM_LAST) AS ATT_PROV_NAM_LAST_filled,
    COUNT(ATT_PROV_NAM_FIRST) AS ATT_PROV_NAM_FIRST_filled,
    COUNT(ATT_PROV_NAM_MID) AS ATT_PROV_NAM_MID_filled,
    COUNT(ATT_PROV_NAM_SUF) AS ATT_PROV_NAM_SUF_filled,
    COUNT(ATT_PROV_NPI) AS ATT_PROV_NPI_filled,
    COUNT(ATT_PROV_TAXONOMY) AS ATT_PROV_TAXONOMY_filled,
    COUNT(OPER_PROV_NAM_LAST) AS OPER_PROV_NAM_LAST_filled,
    COUNT(OPER_PROV_NAM_FIRST) AS OPER_PROV_NAM_FIRST_filled,
    COUNT(OPER_PROV_NAM_MID) AS OPER_PROV_NAM_MID_filled,
    COUNT(OPER_PROV_NAM_SUF) AS OPER_PROV_NAM_SUF_filled,
    COUNT(OPER_PROV_NPI) AS OPER_PROV_NPI_filled,
    COUNT(OTH_PROV_NAM_LAST) AS OTH_PROV_NAM_LAST_filled,
    COUNT(OTH_PROV_NAM_FIRST) AS OTH_PROV_NAM_FIRST_filled,
    COUNT(OTH_PROV_NAM_MID) AS OTH_PROV_NAM_MID_filled,
    COUNT(OTH_PROV_NAM_SUF) AS OTH_PROV_NAM_SUF_filled,
    COUNT(OTH_PROV_NPI) AS OTH_PROV_NPI_filled,
    COUNT(REND_PROV_TYP) AS REND_PROV_TYP_filled,
    COUNT(REND_PROV_NAM_LAST) AS REND_PROV_NAM_LAST_filled,
    COUNT(REND_PROV_NAM_FIRST) AS REND_PROV_NAM_FIRST_filled,
    COUNT(REND_PROV_NAM_MID) AS REND_PROV_NAM_MID_filled,
    COUNT(REND_PROV_NAM_SUF) AS REND_PROV_NAM_SUF_filled,
    COUNT(REND_PROV_NPI) AS REND_PROV_NPI_filled,
    COUNT(REND_PROV_TAXONOMY) AS REND_PROV_TAXONOMY_filled,
    COUNT(REF_PROV_NAM_LAST) AS REF_PROV_NAM_LAST_filled,
    COUNT(REF_PROV_NAM_FIRST) AS REF_PROV_NAM_FIRST_filled,
    COUNT(REF_PROV_NAM_MID) AS REF_PROV_NAM_MID_filled,
    COUNT(REF_PROV_NAM_SUF) AS REF_PROV_NAM_SUF_filled,
    COUNT(REF_PROV_NPI) AS REF_PROV_NPI_filled,
    COUNT(REF_PROV_TAXONOMY) AS REF_PROV_TAXONOMY_filled,
    COUNT(SUP_PROV_NAM_LAST) AS SUP_PROV_NAM_LAST_filled,
    COUNT(SUP_PROV_NAM_FIRST) AS SUP_PROV_NAM_FIRST_filled,
    COUNT(SUP_PROV_NAM_MID) AS SUP_PROV_NAM_MID_filled,
    COUNT(SUP_PROV_NAM_SUF) AS SUP_PROV_NAM_SUF_filled,
    COUNT(SUP_PROV_NPI) AS SUP_PROV_NPI_filled,
    COUNT(ASST_SURG_NAM_LAST) AS ASST_SURG_NAM_LAST_filled,
    COUNT(ASST_SURG_NAM_FIRST) AS ASST_SURG_NAM_FIRST_filled,
    COUNT(ASST_SURG_NAM_MID) AS ASST_SURG_NAM_MID_filled
FROM CLM_VALUES_2
GROUP BY YEAR(CLM_FROM_DT)
ORDER BY activity_year;

-- ==========================================================
-- Table: CLM_VALUES_3
-- All values associated with a claim are stored in the Claim External Value record. The CLM_VALUES_3 table holds claim level values set by the system during claims processing or by user edits.
-- Bucket(s): Claims / Denials
-- ==========================================================
SELECT
    YEAR(CREATE_DT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(RECORD_ID) AS RECORD_ID_filled,
    COUNT(ASST_SURG_NAM_SUF) AS ASST_SURG_NAM_SUF_filled,
    COUNT(ASST_SURG_NPI) AS ASST_SURG_NPI_filled,
    COUNT(ASST_SURG_TAXONOMY) AS ASST_SURG_TAXONOMY_filled,
    COUNT(SVC_FAC_NAM) AS SVC_FAC_NAM_filled,
    COUNT(SVC_FAC_NPI) AS SVC_FAC_NPI_filled,
    COUNT(SVC_FAC_CNCT_NAM) AS SVC_FAC_CNCT_NAM_filled,
    COUNT(SVC_FAC_CNCT_PH) AS SVC_FAC_CNCT_PH_filled,
    COUNT(SVC_FAC_CNCT_EXT) AS SVC_FAC_CNCT_EXT_filled,
    COUNT(SVC_FAC_ADDR_1) AS SVC_FAC_ADDR_1_filled,
    COUNT(SVC_FAC_ADDR_2) AS SVC_FAC_ADDR_2_filled,
    COUNT(SVC_FAC_CITY) AS SVC_FAC_CITY_filled,
    COUNT(SVC_FAC_STATE) AS SVC_FAC_STATE_filled,
    COUNT(SVC_FAC_ZIP) AS SVC_FAC_ZIP_filled,
    COUNT(SVC_FAC_CNTRY) AS SVC_FAC_CNTRY_filled,
    COUNT(SVC_FAC_CNTRY_SUB) AS SVC_FAC_CNTRY_SUB_filled,
    COUNT(PICK_UP_ADDR_1) AS PICK_UP_ADDR_1_filled,
    COUNT(PICK_UP_ADDR_2) AS PICK_UP_ADDR_2_filled,
    COUNT(PICK_UP_CITY) AS PICK_UP_CITY_filled,
    COUNT(PICK_UP_STATE) AS PICK_UP_STATE_filled,
    COUNT(PICK_UP_ZIP) AS PICK_UP_ZIP_filled,
    COUNT(PICK_UP_CNTRY) AS PICK_UP_CNTRY_filled,
    COUNT(PICK_UP_CNTRY_SUB) AS PICK_UP_CNTRY_SUB_filled,
    COUNT(DROP_OFF_NAM) AS DROP_OFF_NAM_filled,
    COUNT(DROP_OFF_ADDR_1) AS DROP_OFF_ADDR_1_filled,
    COUNT(DROP_OFF_ADDR_2) AS DROP_OFF_ADDR_2_filled,
    COUNT(DROP_OFF_CITY) AS DROP_OFF_CITY_filled,
    COUNT(DROP_OFF_STATE) AS DROP_OFF_STATE_filled,
    COUNT(DROP_OFF_ZIP) AS DROP_OFF_ZIP_filled,
    COUNT(DROP_OFF_CNTRY) AS DROP_OFF_CNTRY_filled,
    COUNT(DROP_OFF_CNTRY_SUB) AS DROP_OFF_CNTRY_SUB_filled,
    COUNT(CREATE_DT) AS CREATE_DT_filled,
    COUNT(CLM_CVG_AMT_PAID) AS CLM_CVG_AMT_PAID_filled,
    COUNT(PAT_PROP_CAS_ID_TYP) AS PAT_PROP_CAS_ID_TYP_filled,
    COUNT(PAT_PROP_CAS_ID) AS PAT_PROP_CAS_ID_filled,
    COUNT(ADMSN_QUAL) AS ADMSN_QUAL_filled,
    COUNT(REMARK) AS REMARK_filled,
    COUNT(CLM_CVG_AMT_DUE) AS CLM_CVG_AMT_DUE_filled,
    COUNT(CLM_CVG_COMPLMT_ID) AS CLM_CVG_COMPLMT_ID_filled,
    COUNT(CLM_CVG_REL_INFO_DT) AS CLM_CVG_REL_INFO_DT_filled,
    COUNT(LOCAL_USE_CMS) AS LOCAL_USE_CMS_filled,
    COUNT(DISABILITY_QUAL) AS DISABILITY_QUAL_filled,
    COUNT(DISABILITY_TM_QUAL) AS DISABILITY_TM_QUAL_filled,
    COUNT(CAS_SRC_CEV_ID) AS CAS_SRC_CEV_ID_filled,
    COUNT(CAS_LVL_C_NAME) AS CAS_LVL_C_NAME_filled,
    COUNT(CAS_CVG_LN_NUM) AS CAS_CVG_LN_NUM_filled,
    COUNT(CAS_SVC_LN_NUM) AS CAS_SVC_LN_NUM_filled,
    COUNT(NCPDP_RECORD_TYPE) AS NCPDP_RECORD_TYPE_filled,
    COUNT(TXST_TRANSMISSION_ACTION) AS TXST_TRANSMISSION_ACTION_filled,
    COUNT(TXST_SUBMISSION_NUMBER) AS TXST_SUBMISSION_NUMBER_filled
FROM CLM_VALUES_3
GROUP BY YEAR(CREATE_DT)
ORDER BY activity_year;

-- ==========================================================
-- Table: CLM_VALUES_4
-- All values associated with a claim are stored in the Claim External Value record. The CLM_VALUES_4 table holds claim-level values set by the system during claims processing or by user edits.
-- Bucket(s): Claims / Denials
-- ==========================================================
SELECT
    YEAR(FIRST_CNCT_DT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(RECORD_ID) AS RECORD_ID_filled,
    COUNT(REP_CLM_NUM) AS REP_CLM_NUM_filled,
    COUNT(ADJ_REP_CLM_NUM) AS ADJ_REP_CLM_NUM_filled,
    COUNT(CLM_TRANS_INTMD) AS CLM_TRANS_INTMD_filled,
    COUNT(CLM_PRO_APP_NUM) AS CLM_PRO_APP_NUM_filled,
    COUNT(CLM_PRICING_METHDLG) AS CLM_PRICING_METHDLG_filled,
    COUNT(CLM_REP_ALWD_AMT) AS CLM_REP_ALWD_AMT_filled,
    COUNT(CLM_REP_SVNG_AMT) AS CLM_REP_SVNG_AMT_filled,
    COUNT(CLM_REP_ORGID) AS CLM_REP_ORGID_filled,
    COUNT(REP_PDIEM_FLTRT_AMT) AS REP_PDIEM_FLTRT_AMT_filled,
    COUNT(REP_APRVD_DRG_CODE) AS REP_APRVD_DRG_CODE_filled,
    COUNT(REP_APPRVD_AMT) AS REP_APPRVD_AMT_filled,
    COUNT(REP_APRVD_REV_CODE) AS REP_APRVD_REV_CODE_filled,
    COUNT(REP_ASU_MSRMNT_CODE) AS REP_ASU_MSRMNT_CODE_filled,
    COUNT(REP_APR_SERV_CNT) AS REP_APR_SERV_CNT_filled,
    COUNT(PAYTO_PLAN_TAXID) AS PAYTO_PLAN_TAXID_filled,
    COUNT(FIRST_CNCT_DT) AS FIRST_CNCT_DT_filled,
    COUNT(REPRICER_RECVD_DT) AS REPRICER_RECVD_DT_filled,
    COUNT(MCARE_XOVER_IND) AS MCARE_XOVER_IND_filled,
    COUNT(CARE_PLN_NUM) AS CARE_PLN_NUM_filled,
    COUNT(HOMEBOUND_COND_QUAL) AS HOMEBOUND_COND_QUAL_filled,
    COUNT(HOMEBOUND_COND_CD) AS HOMEBOUND_COND_CD_filled,
    COUNT(DENTAL_SVC_FROM_DT) AS DENTAL_SVC_FROM_DT_filled,
    COUNT(DENTAL_SVC_TO_DT) AS DENTAL_SVC_TO_DT_filled,
    COUNT(DENTAL_SVC_DT_QUAL) AS DENTAL_SVC_DT_QUAL_filled,
    COUNT(ORTHO_TREAT_IND) AS ORTHO_TREAT_IND_filled,
    COUNT(DENT_PREDET_CODE) AS DENT_PREDET_CODE_filled,
    COUNT(OTH_ACC_EMER_YN) AS OTH_ACC_EMER_YN_filled,
    COUNT(STER_ABOR_YN) AS STER_ABOR_YN_filled,
    COUNT(PAYEE_NUM) AS PAYEE_NUM_filled,
    COUNT(CLM_LVL_TOS) AS CLM_LVL_TOS_filled,
    COUNT(CLM_LVL_EPSDT_YN) AS CLM_LVL_EPSDT_YN_filled,
    COUNT(CLM_LVL_FAM_PLAN_YN) AS CLM_LVL_FAM_PLAN_YN_filled,
    COUNT(CLM_LVL_EMER_YN) AS CLM_LVL_EMER_YN_filled,
    COUNT(PAT_LOCATION_IDENT) AS PAT_LOCATION_IDENT_filled,
    COUNT(PAT_PERSONAL_IDENT) AS PAT_PERSONAL_IDENT_filled,
    COUNT(DRG_SOI) AS DRG_SOI_filled,
    COUNT(DRG_ROM) AS DRG_ROM_filled,
    COUNT(CAS_SVC_POS_NUM) AS CAS_SVC_POS_NUM_filled,
    COUNT(CLM_RECORD_INDICATOR) AS CLM_RECORD_INDICATOR_filled,
    COUNT(LINE_OF_BUSINESS_CODE) AS LINE_OF_BUSINESS_CODE_filled,
    COUNT(BENEFIT_ID) AS BENEFIT_ID_filled,
    COUNT(PLAN_TYPE) AS PLAN_TYPE_filled,
    COUNT(PRESC_PROV_TAXONOMY) AS PRESC_PROV_TAXONOMY_filled,
    COUNT(ADJUD_DATE) AS ADJUD_DATE_filled,
    COUNT(ADJUD_TM) AS ADJUD_TM_filled,
    COUNT(REJECT_OVERRIDE_CODE) AS REJECT_OVERRIDE_CODE_filled,
    COUNT(CROSS_REF_ICN) AS CROSS_REF_ICN_filled,
    COUNT(PAYMENT_CLARIFICATION_CODE) AS PAYMENT_CLARIFICATION_CODE_filled,
    COUNT(ADJUSTMENT_TYPE) AS ADJUSTMENT_TYPE_filled,
    COUNT(STER_ABOR_CODE) AS STER_ABOR_CODE_filled,
    COUNT(POSSIBLE_DISABILITY_YN) AS POSSIBLE_DISABILITY_YN_filled,
    COUNT(PMT_SRC_MCR_INVOLVE) AS PMT_SRC_MCR_INVOLVE_filled,
    COUNT(PMT_SRC_OTHR_INVOLV) AS PMT_SRC_OTHR_INVOLV_filled,
    COUNT(PMT_SRC_INS_CODE) AS PMT_SRC_INS_CODE_filled,
    COUNT(LOCATOR_CODE) AS LOCATOR_CODE_filled,
    COUNT(MEM_SUBMIT_PMT_RELEASE_DATE) AS MEM_SUBMIT_PMT_RELEASE_DATE_filled,
    COUNT(CHECK_DATE) AS CHECK_DATE_filled,
    COUNT(PAT_DEM_CODE_QUAL) AS PAT_DEM_CODE_QUAL_filled,
    COUNT(PAT_DEM_CODE) AS PAT_DEM_CODE_filled,
    COUNT(DRG_CODE_SET) AS DRG_CODE_SET_filled,
    COUNT(CLM_STATUS) AS CLM_STATUS_filled,
    COUNT(DRG_CODE_VERSION) AS DRG_CODE_VERSION_filled,
    COUNT(IS_CLINICALLY_INVALID_IDENT) AS IS_CLINICALLY_INVALID_IDENT_filled,
    COUNT(DRG_CODE_SET_IDENT) AS DRG_CODE_SET_IDENT_filled,
    COUNT(DRG_CODE_VER_IDENT) AS DRG_CODE_VER_IDENT_filled
FROM CLM_VALUES_4
GROUP BY YEAR(FIRST_CNCT_DT)
ORDER BY activity_year;

-- ==========================================================
-- Table: CLM_VALUES_5
-- All values associated with a claim are stored in the Claim External Value record. The CLM_VALUES_5 table holds claim-level values set by the system during claims processing or by user edits.
-- Bucket(s): Claims / Denials
-- ==========================================================
SELECT
    YEAR(LAST_SRP_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(RECORD_ID) AS RECORD_ID_filled,
    COUNT(FHIR_GROUP_IDENTIFIER) AS FHIR_GROUP_IDENTIFIER_filled,
    COUNT(DEPT_ALT_CODE) AS DEPT_ALT_CODE_filled,
    COUNT(PAYER_ENTERPRISE_IDENTIFIER) AS PAYER_ENTERPRISE_IDENTIFIER_filled,
    COUNT(ATT_PROV_SPECIALTY) AS ATT_PROV_SPECIALTY_filled,
    COUNT(NON_PAYMENT_RSN_DESC) AS NON_PAYMENT_RSN_DESC_filled,
    COUNT(CARRIER_PAYMENT_DNL_CD) AS CARRIER_PAYMENT_DNL_CD_filled,
    COUNT(NON_PAYMENT_RSN_CD) AS NON_PAYMENT_RSN_CD_filled,
    COUNT(CARRIER_PAYMENT_DNL_DESC) AS CARRIER_PAYMENT_DNL_DESC_filled,
    COUNT(BCDA_GROUP_IDENT) AS BCDA_GROUP_IDENT_filled,
    COUNT(PRIMARY_PAYER_CD) AS PRIMARY_PAYER_CD_filled,
    COUNT(BIL_PROV_SPEC_CODE_SET) AS BIL_PROV_SPEC_CODE_SET_filled,
    COUNT(OPER_PROV_TAXONOMY) AS OPER_PROV_TAXONOMY_filled,
    COUNT(PREDETERMIN_IDENT) AS PREDETERMIN_IDENT_filled,
    COUNT(ADJ_TO_CLAIM_ID) AS ADJ_TO_CLAIM_ID_filled,
    COUNT(REV_TO_CLAIM_ID) AS REV_TO_CLAIM_ID_filled,
    COUNT(ADJ_SEQUENCE) AS ADJ_SEQUENCE_filled,
    COUNT(PLAN_NAME) AS PLAN_NAME_filled,
    COUNT(CORPORATION_NAME) AS CORPORATION_NAME_filled,
    COUNT(NETWORK_LEVEL) AS NETWORK_LEVEL_filled,
    COUNT(REGION_NAME) AS REGION_NAME_filled,
    COUNT(LINE_OF_BUSINESS_NAME) AS LINE_OF_BUSINESS_NAME_filled,
    COUNT(SVC_PROV_IN_NETWORK) AS SVC_PROV_IN_NETWORK_filled,
    COUNT(MEDICARE_DRUG_CVG_CODE) AS MEDICARE_DRUG_CVG_CODE_filled,
    COUNT(SVC_FAC_CCN) AS SVC_FAC_CCN_filled,
    COUNT(PCP_REF_PROV_NAM_LAST) AS PCP_REF_PROV_NAM_LAST_filled,
    COUNT(PCP_REF_PROV_NAM_FIRST) AS PCP_REF_PROV_NAM_FIRST_filled,
    COUNT(PCP_REF_PROV_NAM_MID) AS PCP_REF_PROV_NAM_MID_filled,
    COUNT(PCP_REF_PROV_NAM_SUF) AS PCP_REF_PROV_NAM_SUF_filled,
    COUNT(PCP_REF_PROV_NPI) AS PCP_REF_PROV_NPI_filled,
    COUNT(PCP_REF_PROV_TAXONOMY) AS PCP_REF_PROV_TAXONOMY_filled,
    COUNT(REF_PROV_FROM_LINE_YN) AS REF_PROV_FROM_LINE_YN_filled,
    COUNT(REN_PROV_FROM_LINE_YN) AS REN_PROV_FROM_LINE_YN_filled,
    COUNT(OPER_PROV_FROM_LINE_YN) AS OPER_PROV_FROM_LINE_YN_filled,
    COUNT(OTHOP_PROV_FROM_LINE_YN) AS OTHOP_PROV_FROM_LINE_YN_filled,
    COUNT(PAT_RESIDENCE_CODE) AS PAT_RESIDENCE_CODE_filled,
    COUNT(SVC_FAC_CMS_PARTD_FLAG) AS SVC_FAC_CMS_PARTD_FLAG_filled,
    COUNT(BANK_IDENT_NUM) AS BANK_IDENT_NUM_filled,
    COUNT(PROCESSOR_CTL_NUM) AS PROCESSOR_CTL_NUM_filled,
    COUNT(RX_PRIOR_AUTH_TYPE) AS RX_PRIOR_AUTH_TYPE_filled,
    COUNT(PRESCRIBER_LAST_NAME) AS PRESCRIBER_LAST_NAME_filled,
    COUNT(SNAPSHOT_CEV_YN) AS SNAPSHOT_CEV_YN_filled,
    COUNT(SNAPSHOT_CEV_RECORD_ID) AS SNAPSHOT_CEV_RECORD_ID_filled,
    COUNT(PICK_UP_CNTY) AS PICK_UP_CNTY_filled,
    COUNT(DROP_OFF_CNTY) AS DROP_OFF_CNTY_filled,
    COUNT(LAST_SRP_DATE) AS LAST_SRP_DATE_filled,
    COUNT(NCH_CLAIM_TYPE) AS NCH_CLAIM_TYPE_filled,
    COUNT(CMS_ADJSTMT_DLTN_CD) AS CMS_ADJSTMT_DLTN_CD_filled,
    COUNT(CLAIM_TYPE_OUT_IN) AS CLAIM_TYPE_OUT_IN_filled,
    COUNT(COVERAGE_EXPIRY_DATE) AS COVERAGE_EXPIRY_DATE_filled,
    COUNT(DECEASED_INDICATOR) AS DECEASED_INDICATOR_filled,
    COUNT(CLAIM_NET_AMOUNT) AS CLAIM_NET_AMOUNT_filled,
    COUNT(VALUE_ADDED_TAX) AS VALUE_ADDED_TAX_filled,
    COUNT(ENC_TYPE) AS ENC_TYPE_filled,
    COUNT(ENC_TRANSFER_SOURCE) AS ENC_TRANSFER_SOURCE_filled,
    COUNT(ENC_TRANSFER_DEST) AS ENC_TRANSFER_DEST_filled
FROM CLM_VALUES_5
GROUP BY YEAR(LAST_SRP_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: CLM_VALUES_6
-- All values associated with a claim are stored in the Claim External Value record. The CLM_VALUES_6 table holds claim-level values set by the system during claims processing or by user edits.
-- Bucket(s): Claims / Denials
-- ==========================================================
SELECT
    YEAR(ENC_START_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(RECORD_ID) AS RECORD_ID_filled,
    COUNT(RESUBMISSION_COMMENT) AS RESUBMISSION_COMMENT_filled,
    COUNT(SUBSCR_EMPLOYER_PHONE) AS SUBSCR_EMPLOYER_PHONE_filled,
    COUNT(PAT_SEX_ASSIGNED_AT_BIRTH) AS PAT_SEX_ASSIGNED_AT_BIRTH_filled,
    COUNT(ENC_START_DATE) AS ENC_START_DATE_filled,
    COUNT(ENC_START_TIME_TM) AS ENC_START_TIME_TM_filled,
    COUNT(ENC_END_DATE) AS ENC_END_DATE_filled,
    COUNT(ENC_END_TIME_TM) AS ENC_END_TIME_TM_filled,
    COUNT(ENC_END_TYPE) AS ENC_END_TYPE_filled,
    COUNT(SVC_PROV_NAME) AS SVC_PROV_NAME_filled,
    COUNT(CONTRACT_NUMBER) AS CONTRACT_NUMBER_filled
FROM CLM_VALUES_6
GROUP BY YEAR(ENC_START_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: CLM_VALUES_DENT_STAT
-- This table contains information for dental-specific tooth statuses (Missing/To Be Extracted).
-- Bucket(s): Claims / Denials
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(RECORD_ID) AS RECORD_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(TOOTH_NUM) AS TOOTH_NUM_filled,
    COUNT(TOOTH_STAT_CODE) AS TOOTH_STAT_CODE_filled
FROM CLM_VALUES_DENT_STAT;

-- ==========================================================
-- Table: CLM_VALUES_PAT_IDENT
-- This table contains information for patient identifiers.
-- Bucket(s): Claims / Denials
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(RECORD_ID) AS RECORD_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(PAT_IDENT_QUAL) AS PAT_IDENT_QUAL_filled,
    COUNT(PAT_IDENT) AS PAT_IDENT_filled
FROM CLM_VALUES_PAT_IDENT;

-- ==========================================================
-- Table: CLM_VALUES_PRESC_PROV_ID
-- This table contains information for prescribing provider identifiers.
-- Bucket(s): Claims / Denials
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(RECORD_ID) AS RECORD_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(PROV_IDENT_QUAL) AS PROV_IDENT_QUAL_filled,
    COUNT(PROV_IDENT) AS PROV_IDENT_filled
FROM CLM_VALUES_PRESC_PROV_ID;

-- ==========================================================
-- Table: CLM_VALUES_REFERRAL_DX
-- This table stores the referral diagnoses associated with the claim.
-- Bucket(s): ICD-10 / Diagnosis coding;Claims / Denials
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(RECORD_ID) AS RECORD_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(REFERRAL_DX) AS REFERRAL_DX_filled,
    COUNT(REFERRAL_DX_QUAL) AS REFERRAL_DX_QUAL_filled,
    COUNT(REFERRAL_DX_CODE_SET_OID) AS REFERRAL_DX_CODE_SET_OID_filled
FROM CLM_VALUES_REFERRAL_DX;

-- ==========================================================
-- Table: CLM_VALUES_REJECT_CODE
-- This table contains information for pharmacy claim reject codes.
-- Bucket(s): Claims / Denials
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(RECORD_ID) AS RECORD_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(REJECT_CODE) AS REJECT_CODE_filled
FROM CLM_VALUES_REJECT_CODE;

-- ==========================================================
-- Table: CLM_VALUES_SVC_PROV_ID
-- This table contains information for service provider identifiers
-- Bucket(s): Claims / Denials
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(RECORD_ID) AS RECORD_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(SVC_PROV_IDENT_QUAL) AS SVC_PROV_IDENT_QUAL_filled,
    COUNT(SVC_PROV_IDENT) AS SVC_PROV_IDENT_filled,
    COUNT(SVC_PROV_TAXONOMY) AS SVC_PROV_TAXONOMY_filled,
    COUNT(SVC_PROV_FROM_LINE_YN) AS SVC_PROV_FROM_LINE_YN_filled
FROM CLM_VALUES_SVC_PROV_ID;

-- ==========================================================
-- Table: CLM_WC_DIAGNOSIS
-- Worker's comp diagnoses.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_ID) AS CLAIM_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(WK_COMP_DX) AS WK_COMP_DX_filled
FROM CLM_WC_DIAGNOSIS;

-- ==========================================================
-- Table: CL_ICD_PX
-- The CL_ICD_PX table is the master table for ICD procedures.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(ICD_PX_ID) AS ICD_PX_ID_filled,
    COUNT(ICD_PX_ID_ICD_PX_NAME) AS ICD_PX_ID_ICD_PX_NAME_filled,
    COUNT(ICD_PX_NAME) AS ICD_PX_NAME_filled
FROM CL_ICD_PX;

-- ==========================================================
-- Table: COD_ADMISSION_DX
-- Admission diagnoses for the patient.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CODING_RECORD_ID) AS CODING_RECORD_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(ADMISSION_DX_ID_DX_NAME) AS ADMISSION_DX_ID_DX_NAME_filled
FROM COD_ADMISSION_DX
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: COD_ADMISSION_DX_SOURCE
-- Source information about the admission diagonsis value.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CODING_RECORD_ID) AS CODING_RECORD_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
FROM COD_ADMISSION_DX_SOURCE
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: COD_ADMISSION_DX_SRC_REF
-- Source information about the admission diagnosis value. Corresponds to line numbers in the source table.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CODING_RECORD_ID) AS CODING_RECORD_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
FROM COD_ADMISSION_DX_SRC_REF
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: COD_CPT_CODE
-- CPT/HCPCs codes for the patient.
-- Bucket(s): E/M level / CPT coding
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CODING_RECORD_ID) AS CODING_RECORD_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(CPT_CODE) AS CPT_CODE_filled,
    COUNT(CPT_DATE) AS CPT_DATE_filled,
    COUNT(CPT_PROV_ID_PROV_NAME) AS CPT_PROV_ID_PROV_NAME_filled,
    COUNT(CPT_MODIFIERS) AS CPT_MODIFIERS_filled
FROM COD_CPT_CODE
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: COD_CPT_CODE_SOURCE
-- Source information about the CPT/HCPCs values.
-- Bucket(s): E/M level / CPT coding
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CODING_RECORD_ID) AS CODING_RECORD_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
FROM COD_CPT_CODE_SOURCE
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: COD_CPT_CODE_SRC_REFERENC
-- Source information about the CPT/HCPCs values. Corresponds to line numbers in the source table.
-- Bucket(s): E/M level / CPT coding
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CODING_RECORD_ID) AS CODING_RECORD_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
FROM COD_CPT_CODE_SRC_REFERENC
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: COD_ICD_PROC_SOURCE
-- The source of the ICD Procedure.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CODING_RECORD_ID) AS CODING_RECORD_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
FROM COD_ICD_PROC_SOURCE
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: COD_ICD_PROC_SRC_REFERENC
-- Source references for the ICD procedures.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CODING_RECORD_ID) AS CODING_RECORD_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
FROM COD_ICD_PROC_SRC_REFERENC
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: COD_PRIMARY_DX_SOURCE
-- Source information for the primary diagnosis.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CODING_RECORD_ID) AS CODING_RECORD_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
FROM COD_PRIMARY_DX_SOURCE
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: COD_PRIM_DX_SRC_REFERENCE
-- Source references for the primary diagnosis.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CODING_RECORD_ID) AS CODING_RECORD_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
FROM COD_PRIM_DX_SRC_REFERENCE
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: COMPLICATION_DX_MODE
-- The COMPLICATION_DX_MODE table contains the test or technique used to diagnose the patient.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(PROBLEM_LIST_ID) AS PROBLEM_LIST_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(MODE_OF_DX_C_NAME) AS MODE_OF_DX_C_NAME_filled
FROM COMPLICATION_DX_MODE;

-- ==========================================================
-- Table: CRR_SUBMISSION_DX
-- This table contains the list of diagnoses for a chart review record submission.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_RECON_ID) AS CLAIM_RECON_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(CR_SUBMISSION_DX_ID_DX_NAME) AS CR_SUBMISSION_DX_ID_DX_NAME_filled
FROM CRR_SUBMISSION_DX;

-- ==========================================================
-- Table: CUST_SERVICE_TRANS_DX
-- The CUST_SERVICE_TRANS_DX table contains diagnosis-related information collected for a transfer patient in both free text and coded form.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(COMM_ID) AS COMM_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(TRANS_DX_TEXT) AS TRANS_DX_TEXT_filled,
    COUNT(TRANS_DX_ID_DX_NAME) AS TRANS_DX_ID_DX_NAME_filled,
    COUNT(TRANS_DX_CATEGORY_C_NAME) AS TRANS_DX_CATEGORY_C_NAME_filled
FROM CUST_SERVICE_TRANS_DX;

-- ==========================================================
-- Table: CVG_MEM_RISK_ADJ_FACT
-- This table holds member level risk adjustment factor.
-- Bucket(s): HCC / Risk adjustment
-- ==========================================================
SELECT
    YEAR(EFF_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CVG_ID) AS CVG_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(PAT_ID) AS PAT_ID_filled,
    COUNT(EFF_DATE) AS EFF_DATE_filled,
    COUNT(TERM_DATE) AS TERM_DATE_filled,
    COUNT(RISK_ADJ_FACT_MODEL_C_NAME) AS RISK_ADJ_FACT_MODEL_C_NAME_filled,
    COUNT(RISK_ADJ_FACT_TYPE_C_NAME) AS RISK_ADJ_FACT_TYPE_C_NAME_filled,
    COUNT(RISK_ADJ_FACTOR) AS RISK_ADJ_FACTOR_filled
FROM CVG_MEM_RISK_ADJ_FACT
GROUP BY YEAR(EFF_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: CVG_MEM_RISK_ADJ_FACT_HX
-- The historical values of the CVG_MEM_RISK_ADJ_FACT table over time.
-- Bucket(s): HCC / Risk adjustment
-- ==========================================================
SELECT
    YEAR(EFF_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CVG_ID) AS CVG_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(PAT_ID) AS PAT_ID_filled,
    COUNT(EFF_DATE) AS EFF_DATE_filled,
    COUNT(TERM_DATE) AS TERM_DATE_filled,
    COUNT(RISK_ADJ_FACT_MODEL_C_NAME) AS RISK_ADJ_FACT_MODEL_C_NAME_filled,
    COUNT(RISK_ADJ_FACT_TYPE_C_NAME) AS RISK_ADJ_FACT_TYPE_C_NAME_filled,
    COUNT(RSK_ADJ_FACTOR) AS RSK_ADJ_FACTOR_filled,
    COUNT(ITM_HX_START_LOCAL_DTTM) AS ITM_HX_START_LOCAL_DTTM_filled,
    COUNT(ITM_HX_START_UTC_DTTM) AS ITM_HX_START_UTC_DTTM_filled,
    COUNT(ITM_HX_END_LOCAL_DTTM) AS ITM_HX_END_LOCAL_DTTM_filled,
    COUNT(ITM_HX_END_UTC_DTTM) AS ITM_HX_END_UTC_DTTM_filled,
    COUNT(CVG_ITM_HX_REL_ACT_GUID) AS CVG_ITM_HX_REL_ACT_GUID_filled
FROM CVG_MEM_RISK_ADJ_FACT_HX
GROUP BY YEAR(EFF_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: DENTAL_PROC_DIAGNOSES
-- This table contains information about associated diagnoses for a procedure.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(FINDING_ID) AS FINDING_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(DENTAL_DX_ID_DX_NAME) AS DENTAL_DX_ID_DX_NAME_filled
FROM DENTAL_PROC_DIAGNOSES;

-- ==========================================================
-- Table: DENTAL_RES_DX_HX_RM
-- This table extracts the related multiple response Dental: Associated Diagnoses History (I RES 17519) item.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(FINDING_ID) AS FINDING_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(DENTAL_DX_HX_ID_DX_NAME) AS DENTAL_DX_HX_ID_DX_NAME_filled
FROM DENTAL_RES_DX_HX_RM;

-- ==========================================================
-- Table: DIAGNOSIS_REVIEW
-- This table stores the log diagnosis review status.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(LOG_ID) AS LOG_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(DIAGNOSIS_REVIEW_C_NAME) AS DIAGNOSIS_REVIEW_C_NAME_filled
FROM DIAGNOSIS_REVIEW;

-- ==========================================================
-- Table: DIFF_DX_MOD_TYPE
-- This item stores the types of modifiers that have been applied to this diagnosis.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(PAT_ENC_DATE_REAL) AS PAT_ENC_DATE_REAL_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(DDX_MODIFIER_TYPE_C_NAME) AS DDX_MODIFIER_TYPE_C_NAME_filled
FROM DIFF_DX_MOD_TYPE
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: DIFF_DX_MOD_VALUES
-- This item stores the values of the modifiers selected for this diagnosis.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(PAT_ENC_DATE_REAL) AS PAT_ENC_DATE_REAL_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(DDX_MODIFIER_VALS_C_NAME) AS DDX_MODIFIER_VALS_C_NAME_filled
FROM DIFF_DX_MOD_VALUES
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: DOCS_RCVD_DX
-- This table stores discrete diagnosis information received from outside sources.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(DOCUMENT_ID) AS DOCUMENT_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(DX_REF_ID) AS DX_REF_ID_filled,
    COUNT(DX_ENC_ID) AS DX_ENC_ID_filled,
    COUNT(DX_NAME) AS DX_NAME_filled,
    COUNT(DX_CONTEXT_C_NAME) AS DX_CONTEXT_C_NAME_filled,
    COUNT(DX_SRC_CSN) AS DX_SRC_CSN_filled,
    COUNT(DX_START_DTTM) AS DX_START_DTTM_filled,
    COUNT(DX_END_DTTM) AS DX_END_DTTM_filled,
    COUNT(DX_EDG_ID_DX_NAME) AS DX_EDG_ID_DX_NAME_filled,
    COUNT(DX_LST_UPD_INST_DTTM) AS DX_LST_UPD_INST_DTTM_filled,
    COUNT(DX_PRIMARY_YN) AS DX_PRIMARY_YN_filled,
    COUNT(DX_FILTER_RSN_C_NAME) AS DX_FILTER_RSN_C_NAME_filled,
    COUNT(DX_IS_ED_YN) AS DX_IS_ED_YN_filled,
    COUNT(DX_BULK_STAT_C_NAME) AS DX_BULK_STAT_C_NAME_filled,
    COUNT(DX_BULK_INCL_DATE) AS DX_BULK_INCL_DATE_filled,
    COUNT(DX_GENERIC_NAME) AS DX_GENERIC_NAME_filled,
    COUNT(DX_BEST_MATCH_DX_REFID) AS DX_BEST_MATCH_DX_REFID_filled,
    COUNT(DX_CONFIDENCE_RANK) AS DX_CONFIDENCE_RANK_filled,
    COUNT(DX_STATE_HOLOGRAM_ID) AS DX_STATE_HOLOGRAM_ID_filled,
    COUNT(DX_TOPIC_NAME) AS DX_TOPIC_NAME_filled,
    COUNT(DX_NOTED_DATE) AS DX_NOTED_DATE_filled,
    COUNT(DX_DOCUMENTED_INST_UTC_DTTM) AS DX_DOCUMENTED_INST_UTC_DTTM_filled,
    COUNT(DX_POA_C_NAME) AS DX_POA_C_NAME_filled
FROM DOCS_RCVD_DX
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: DOCS_RCVD_DX_CD_CMPLD
-- This table stores the data type, coding system, and code data received for a diagnosis reference ID.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(DOCUMENT_ID) AS DOCUMENT_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(DATA_TYPE_C) AS DATA_TYPE_C_filled,
    COUNT(CODING_SYSTEM) AS CODING_SYSTEM_filled,
    COUNT(CODE) AS CODE_filled
FROM DOCS_RCVD_DX_CD_CMPLD
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: DOCS_RCVD_DX_CD_DISPNM
-- This table stores the display name of all the mapping codes for one diagnosis reference ID.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(DOCUMENT_ID) AS DOCUMENT_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(DISPLAY_NAME) AS DISPLAY_NAME_filled
FROM DOCS_RCVD_DX_CD_DISPNM
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: DOCS_RCVD_DX_CD_NLFLVR
-- This table stores the nullFlavor values of all the mapping codes for one diagnosis reference ID.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(DOCUMENT_ID) AS DOCUMENT_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(CODE_NULLFLAVOR_C_NAME) AS CODE_NULLFLAVOR_C_NAME_filled
FROM DOCS_RCVD_DX_CD_NLFLVR
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: DOCS_RCVD_DX_NOTES
-- This table stores the note elements associated with a diagnosis from an external source.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(DOCUMENT_ID) AS DOCUMENT_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(DX_LINKED_NOTES) AS DX_LINKED_NOTES_filled
FROM DOCS_RCVD_DX_NOTES
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: DOCS_RCVD_ENCOUNTER_DX
-- This table extracts the related multiple response Event Linked Diagnosis (I DXR 8025) item.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(DOCUMENT_ID) AS DOCUMENT_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(EVENT_LINKED_DX_DX_NAME) AS EVENT_LINKED_DX_DX_NAME_filled
FROM DOCS_RCVD_ENCOUNTER_DX
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: DOCS_RCVD_ENDO_DX_INFO
-- Contains information about endoscopy procedure diagnoses extracted from customer systems for use in Cosmos.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(DOCUMENT_ID) AS DOCUMENT_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(ENDO_DX_REF_IDENT) AS ENDO_DX_REF_IDENT_filled,
    COUNT(ENDO_DX_SRC_REFID) AS ENDO_DX_SRC_REFID_filled,
    COUNT(ENDO_DX_DDP_REFID) AS ENDO_DX_DDP_REFID_filled,
    COUNT(ENDO_DX_IND_ID_DX_NAME) AS ENDO_DX_IND_ID_DX_NAME_filled,
    COUNT(ENDO_DX_ID_DX_NAME) AS ENDO_DX_ID_DX_NAME_filled
FROM DOCS_RCVD_ENDO_DX_INFO
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: DOCS_RCVD_GENERIC_ORD_DX
-- This table stores the reference IDs of external diagnosis elements associated with external generic orders.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(DOCUMENT_ID) AS DOCUMENT_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(GENERIC_ORDER_ASSOCIATED_DXS) AS GENERIC_ORDER_ASSOCIATED_DXS_filled
FROM DOCS_RCVD_GENERIC_ORD_DX
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: DOCS_RCVD_MEDS_ASSOC_DX
-- This table stores the reference IDs of diagnoses associated with a medication from an external source.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(DOCUMENT_ID) AS DOCUMENT_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(MEDICATION_ASSOCIATED_DX) AS MEDICATION_ASSOCIATED_DX_filled
FROM DOCS_RCVD_MEDS_ASSOC_DX
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: DOCS_RCVD_MINOR_DENIAL
-- Contains information about minor denials decisions included in a received document.
-- Bucket(s): Claims / Denials
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(DOCUMENT_ID) AS DOCUMENT_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
FROM DOCS_RCVD_MINOR_DENIAL
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: DOCS_RCVD_RISK_ADJ_CAT
-- This table stores risk adjustment categories received from outside sources.
-- Bucket(s): HCC / Risk adjustment
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(DOCUMENT_ID) AS DOCUMENT_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(RAD_REF_IDENT) AS RAD_REF_IDENT_filled,
    COUNT(RAD_CALC_DATE) AS RAD_CALC_DATE_filled,
    COUNT(RAD_START_DATE) AS RAD_START_DATE_filled,
    COUNT(RAD_END_DATE) AS RAD_END_DATE_filled,
    COUNT(RAD_CAT_NAME) AS RAD_CAT_NAME_filled,
    COUNT(RAD_DESCRIPTOR) AS RAD_DESCRIPTOR_filled,
    COUNT(RAD_STATUS_C_NAME) AS RAD_STATUS_C_NAME_filled,
    COUNT(RAD_EVIDENCE_NOTE_ID) AS RAD_EVIDENCE_NOTE_ID_filled,
    COUNT(RAD_DX_ID_DX_NAME) AS RAD_DX_ID_DX_NAME_filled,
    COUNT(RAD_EXT_DATA_FILTER_REASON_C_NAME) AS RAD_EXT_DATA_FILTER_REASON_C_NAME_filled,
    COUNT(RAD_SRC_DOCUMENT_CSN_ID) AS RAD_SRC_DOCUMENT_CSN_ID_filled,
    COUNT(RAD_BULK_STAT_C_NAME) AS RAD_BULK_STAT_C_NAME_filled,
    COUNT(RAD_LAST_UPD_UTC_DTTM) AS RAD_LAST_UPD_UTC_DTTM_filled,
    COUNT(RAD_CODING_STATUS_C_NAME) AS RAD_CODING_STATUS_C_NAME_filled
FROM DOCS_RCVD_RISK_ADJ_CAT
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: DX_MODS_TXT
-- Stores the free text associated with additional diagnoses modifiers (add code).
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(REFERRAL_ID) AS REFERRAL_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(DX_MODIFIER_TEXT) AS DX_MODIFIER_TEXT_filled
FROM DX_MODS_TXT;

-- ==========================================================
-- Table: EM_CODE_CALC
-- Tracks Evaluation and Management (EM) code calculations based on LOS codes. EM codes are used by physicians to report and bill medical services depending on medical history, physical examinations and 
-- Bucket(s): E/M level / CPT coding
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(PAT_ENC_DATE_REAL) AS PAT_ENC_DATE_REAL_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(EM_CODE_SECTION) AS EM_CODE_SECTION_filled,
    COUNT(EM_CODE_ATTRIBUTE) AS EM_CODE_ATTRIBUTE_filled,
    COUNT(EMCODE_ASSO_NOTE_ID) AS EMCODE_ASSO_NOTE_ID_filled,
    COUNT(EMCODE_SDI) AS EMCODE_SDI_filled,
    COUNT(EM_CODE_SOURCE_C_NAME) AS EM_CODE_SOURCE_C_NAME_filled,
    COUNT(EM_CODE) AS EM_CODE_filled
FROM EM_CODE_CALC
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: ENC_DX_ASSOC_AMBIENT_DX
-- This table contains the unique IDs of diagnoses provided by Ambient that were finalized to Visit Diagnoses on the encounter.
-- Bucket(s): ICD-10 / Diagnosis coding
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
-- Table: ENC_DX_ASSOC_DATA
-- This table contains data related to a patient's visit diagnoses. Each row corresponds to a visit diagnosis on an encounter. The data includes linked notes, SmartSections, and Ambient diagnosis data.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(PAT_ID) AS PAT_ID_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(CM_CT_OWNER_ID) AS CM_CT_OWNER_ID_filled
FROM ENC_DX_ASSOC_DATA
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: ENC_DX_ASSOC_NOTES
-- This table contains information about linked notes and SmartSections for visit diagnoses that appear in a Diagnosis-Aware Note.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(PAT_ID) AS PAT_ID_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(CM_CT_OWNER_ID) AS CM_CT_OWNER_ID_filled
FROM ENC_DX_ASSOC_NOTES
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: ENC_DX_EDIT_TRAIL
-- This table stores the audit trail information for encounter diagnosis edits. In order to report on diagnosis edits, this table can be linked with PAT_ENC_DX. This linking can be done using the PAT_ENC
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(DX_EDIT_CHRONIC_YN) AS DX_EDIT_CHRONIC_YN_filled,
    COUNT(DX_EDIT_PRIMDX_YN) AS DX_EDIT_PRIMDX_YN_filled,
    COUNT(DX_EDIT_STATUS_C_NAME) AS DX_EDIT_STATUS_C_NAME_filled,
    COUNT(DX_EDIT_ED_YN) AS DX_EDIT_ED_YN_filled
FROM ENC_DX_EDIT_TRAIL;

-- ==========================================================
-- Table: EXT_CAUSE_INJ_DX
-- All values associated with a claim are stored in the Claim External Value record. The EXT_CAUSE_INJ_DX table holds the diagnoses that document any accidents or other external causes for the patient's 
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(RECORD_ID) AS RECORD_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(EXT_CAUSE_INJ_QUAL) AS EXT_CAUSE_INJ_QUAL_filled,
    COUNT(EXT_CAUSE_INJ_DX) AS EXT_CAUSE_INJ_DX_filled,
    COUNT(EXT_CAUSE_INJ_POA) AS EXT_CAUSE_INJ_POA_filled
FROM EXT_CAUSE_INJ_DX;

-- ==========================================================
-- Table: HEALTH_PLAN_DX_CODING
-- This table contains diagnosis coding from health plan risk adjustment review. Each line represents a diagnosis on the evidence associated with the coding record.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CODING_RECORD_ID) AS CODING_RECORD_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(DX_ID_DX_NAME) AS DX_ID_DX_NAME_filled,
    COUNT(DX_ACTION_C_NAME) AS DX_ACTION_C_NAME_filled,
    COUNT(DX_ACTION_COMMENT) AS DX_ACTION_COMMENT_filled,
    COUNT(DX_REMOVE_RSN_C_NAME) AS DX_REMOVE_RSN_C_NAME_filled,
    COUNT(RA_SOURCE_PAT_ENC_CSN_ID) AS RA_SOURCE_PAT_ENC_CSN_ID_filled,
    COUNT(RA_SOURCE_DOCUMENT_CSN_ID) AS RA_SOURCE_DOCUMENT_CSN_ID_filled,
    COUNT(RA_SOURCE_DOCUMENT_ID) AS RA_SOURCE_DOCUMENT_ID_filled,
    COUNT(HIGH_RISK_DX_YN) AS HIGH_RISK_DX_YN_filled,
    COUNT(HAS_AI_YN) AS HAS_AI_YN_filled
FROM HEALTH_PLAN_DX_CODING
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: HH_OASIS_ICD10_DX
-- This table contains all of the clinical Outcome and Assessment Information Set (OASIS) ICD-10 diagnoses entered by a field nurse and edited in Diagnosis Review. The first diagnosis for a given patient
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(PAT_ENC_DATE_REAL) AS PAT_ENC_DATE_REAL_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(CM_CT_OWNER_ID) AS CM_CT_OWNER_ID_filled,
    COUNT(OASIS_DX_ID_DX_NAME) AS OASIS_DX_ID_DX_NAME_filled,
    COUNT(OASIS_DX_START_DATE) AS OASIS_DX_START_DATE_filled,
    COUNT(OASIS_DX_SCR_C_NAME) AS OASIS_DX_SCR_C_NAME_filled,
    COUNT(OASIS_DX_FLAG_C_NAME) AS OASIS_DX_FLAG_C_NAME_filled,
    COUNT(OASIS_DX_OTHER_1_ID_DX_NAME) AS OASIS_DX_OTHER_1_ID_DX_NAME_filled,
    COUNT(OASIS_DX_OTHER_2_ID_DX_NAME) AS OASIS_DX_OTHER_2_ID_DX_NAME_filled
FROM HH_OASIS_ICD10_DX
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: HH_PAT_CASE_MIX_DX
-- This table contains Primary and Secondary case mix diagnoses information entered for a patient as part of a home health Outcome and Assessment Information Set (OASIS) assessment. The table stores valu
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(PAT_ENC_DATE_REAL) AS PAT_ENC_DATE_REAL_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(CM_CT_OWNER_ID) AS CM_CT_OWNER_ID_filled,
    COUNT(CASE_MIX_DX_ID_DX_NAME) AS CASE_MIX_DX_ID_DX_NAME_filled,
    COUNT(SEC_CASE_DX_ID_DX_NAME) AS SEC_CASE_DX_ID_DX_NAME_filled
FROM HH_PAT_CASE_MIX_DX
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: HH_PAT_CSMX_OTH_DX
-- This table contains case mix diagnoses information entered for a patient as part of a home health Outcome and Assessment Information Set (OASIS) assessment. The table stores values entered for M0246 f
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(PAT_ENC_DATE_REAL) AS PAT_ENC_DATE_REAL_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(CM_CT_OWNER_ID) AS CM_CT_OWNER_ID_filled,
    COUNT(CASE_MIX_DX1_OTH_ID_DX_NAME) AS CASE_MIX_DX1_OTH_ID_DX_NAME_filled,
    COUNT(CASE_MIX_DX2_OTH_ID_DX_NAME) AS CASE_MIX_DX2_OTH_ID_DX_NAME_filled
FROM HH_PAT_CSMX_OTH_DX
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: HH_PAT_IP_DX
-- Contains Home Health inpatient diagnosis information.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(INPATIENT_DX_ID_DX_NAME) AS INPATIENT_DX_ID_DX_NAME_filled,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(CM_CT_OWNER_ID) AS CM_CT_OWNER_ID_filled
FROM HH_PAT_IP_DX
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: HH_PAT_OTHER_DX
-- Contains information from the Home Health Other Diagnoses grid.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(OTHER_DX_ID_DX_NAME) AS OTHER_DX_ID_DX_NAME_filled,
    COUNT(OTHER_DX_START_DT) AS OTHER_DX_START_DT_filled,
    COUNT(OTHER_DX_SEVERITY) AS OTHER_DX_SEVERITY_filled,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(CM_CT_OWNER_ID) AS CM_CT_OWNER_ID_filled,
    COUNT(OTHER_DX_FLAG_C_NAME) AS OTHER_DX_FLAG_C_NAME_filled
FROM HH_PAT_OTHER_DX
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: HH_PAT_PAYMENT_DX
-- Contains information from the Home Health Payment Diagnoses grid.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(PAYMENT_DX_ID_DX_NAME) AS PAYMENT_DX_ID_DX_NAME_filled,
    COUNT(PAYMENT_DX_DATE) AS PAYMENT_DX_DATE_filled,
    COUNT(PAYMNT_DX_SEVERITY) AS PAYMNT_DX_SEVERITY_filled,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(CM_CT_OWNER_ID) AS CM_CT_OWNER_ID_filled
FROM HH_PAT_PAYMENT_DX
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: HH_PAT_REG_CHG_DX
-- Contains Home Health regimen change diagnosis information.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(REGIMEN_CHG_DX_ID_DX_NAME) AS REGIMEN_CHG_DX_ID_DX_NAME_filled,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(CM_CT_OWNER_ID) AS CM_CT_OWNER_ID_filled
FROM HH_PAT_REG_CHG_DX
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: HNO_ECG_DX
-- This table contains the diagnosis for Electrocardiograms (ECG/EKG) that have been stored on General Use Notes (HNO) records.
-- Bucket(s): ICD-10 / Diagnosis coding
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
-- Table: HOLOGRAM_AMBIENT_DX_INFO
-- This table contains information about the Ambient diagnosis choices that were presented to a clinician.
-- Bucket(s): ICD-10 / Diagnosis coding
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
-- Table: HOLO_LEVEL_OF_SERVICE_MOD
-- This table contains level of service modifier information.
-- Bucket(s): E/M level / CPT coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(HOLOGRAM_ID) AS HOLOGRAM_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(LEVEL_OF_SERVICE_MODIFIER_ID) AS LEVEL_OF_SERVICE_MODIFIER_ID_filled,
    COUNT(LEVEL_OF_SERVICE_MODIFIER_ID_MODIFIER_NAME) AS LEVEL_OF_SERVICE_MODIFIER_ID_MODIFIER_NAME_filled
FROM HOLO_LEVEL_OF_SERVICE_MOD;

-- ==========================================================
-- Table: HOSPICE_CODED_DX
-- The table lists coded hospice diagnoses.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(PAT_ENC_DATE_REAL) AS PAT_ENC_DATE_REAL_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(CM_CT_OWNER_ID) AS CM_CT_OWNER_ID_filled,
    COUNT(HOSPICE_CODED_DX_ID_DX_NAME) AS HOSPICE_CODED_DX_ID_DX_NAME_filled,
    COUNT(HOSPICE_RELATED_C_NAME) AS HOSPICE_RELATED_C_NAME_filled
FROM HOSPICE_CODED_DX
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: HOSPICE_DX
-- This table holds Hospice Episode Diagnoses information.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(PAT_ENC_DATE_REAL) AS PAT_ENC_DATE_REAL_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(CM_CT_OWNER_ID) AS CM_CT_OWNER_ID_filled,
    COUNT(HOSPICE_DX_NONCODED) AS HOSPICE_DX_NONCODED_filled
FROM HOSPICE_DX
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: HOSPICE_DX_HX
-- This table contains audit history for a patient's Hospice diagnoses.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(PAT_ID) AS PAT_ID_filled,
    COUNT(ENTRY_USER_ID) AS ENTRY_USER_ID_filled,
    COUNT(ENTRY_UTC_DTTM) AS ENTRY_UTC_DTTM_filled
FROM HOSPICE_DX_HX;

-- ==========================================================
-- Table: HSP_ACCT_ADDL_DX
-- Additional diagnoses for reporting associated with this hospital account.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(ACCT_ID) AS ACCT_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(ADDL_RPT_DX_ID_DX_NAME) AS ADDL_RPT_DX_ID_DX_NAME_filled
FROM HSP_ACCT_ADDL_DX;

-- ==========================================================
-- Table: HSP_ACCT_ADMIT_DX
-- This table contains hospital account admit diagnoses from the Hospital Accounts Receivable (HAR) master file.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(HSP_ACCOUNT_ID) AS HSP_ACCOUNT_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(ADMIT_DX_ID_DX_NAME) AS ADMIT_DX_ID_DX_NAME_filled,
    COUNT(ADMIT_DX_TEXT) AS ADMIT_DX_TEXT_filled
FROM HSP_ACCT_ADMIT_DX;

-- ==========================================================
-- Table: HSP_ACCT_CLM_CPT
-- This table contains hospital account claim CPT codes information from the Hospital Accounts Receivable (HAR) master file.
-- Bucket(s): E/M level / CPT coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(HSP_ACCOUNT_ID) AS HSP_ACCOUNT_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(CLAIM_CODE_QTY) AS CLAIM_CODE_QTY_filled
FROM HSP_ACCT_CLM_CPT;

-- ==========================================================
-- Table: HSP_ACCT_CPT_ASSOC_DX
-- This table stores the diagnoses that are linked to a coded Current Procedural Terminology (CPT)/Healthcare Common Procedure Coding System (HCPCS) code on a hospital account.
-- Bucket(s): ICD-10 / Diagnosis coding;E/M level / CPT coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(ACCT_ID) AS ACCT_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(CPT_LINKED_DX_ID_DX_NAME) AS CPT_LINKED_DX_ID_DX_NAME_filled
FROM HSP_ACCT_CPT_ASSOC_DX;

-- ==========================================================
-- Table: HSP_ACCT_CPT_CODES
-- This table contains hospital account CPT(R) codes from the Hospital Accounts Receivable (HAR) master file.
-- Bucket(s): E/M level / CPT coding
-- ==========================================================
SELECT
    YEAR(CPT_CODE_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(HSP_ACCOUNT_ID) AS HSP_ACCOUNT_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(CPT_CODE) AS CPT_CODE_filled,
    COUNT(CPT_CODE_DATE) AS CPT_CODE_DATE_filled,
    COUNT(CPT_PERF_PROV_ID_PROV_NAME) AS CPT_PERF_PROV_ID_PROV_NAME_filled,
    COUNT(CPT_EVENT_NUMBER) AS CPT_EVENT_NUMBER_filled,
    COUNT(CPT_MODIFIERS) AS CPT_MODIFIERS_filled,
    COUNT(LMRP_CODE) AS LMRP_CODE_filled,
    COUNT(CPT_CODE_DESC) AS CPT_CODE_DESC_filled,
    COUNT(PX_APC_FAC_RMB_AMT) AS PX_APC_FAC_RMB_AMT_filled,
    COUNT(PX_OCE_EDIT_CODE) AS PX_OCE_EDIT_CODE_filled,
    COUNT(PX_APC_CODE) AS PX_APC_CODE_filled,
    COUNT(PX_HCFA_PAYMT_AMT) AS PX_HCFA_PAYMT_AMT_filled,
    COUNT(PX_COPAY_AMT) AS PX_COPAY_AMT_filled,
    COUNT(PX_REV_CODE_ID) AS PX_REV_CODE_ID_filled,
    COUNT(PX_REV_CODE_ID_REVENUE_CODE_NAME) AS PX_REV_CODE_ID_REVENUE_CODE_NAME_filled,
    COUNT(CPT_EXCLD_RPT_YN) AS CPT_EXCLD_RPT_YN_filled,
    COUNT(CPT_QUANTITY) AS CPT_QUANTITY_filled,
    COUNT(CPT_POS_TYPE_C_NAME) AS CPT_POS_TYPE_C_NAME_filled
FROM HSP_ACCT_CPT_CODES
GROUP BY YEAR(CPT_CODE_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: HSP_ACCT_CPT_PRVCM
-- This table contains the other provider comments associated with the hospital account CPT(R)/HCPCS codes list in the Hospital Accounts Receivable (HAR) master file.
-- Bucket(s): E/M level / CPT coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(HSP_ACCOUNT_ID) AS HSP_ACCOUNT_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(CPT_OTHER_PROV_CMNT) AS CPT_OTHER_PROV_CMNT_filled
FROM HSP_ACCT_CPT_PRVCM;

-- ==========================================================
-- Table: HSP_ACCT_CPT_PRVDR
-- This table contains the other providers associated with the hospital account CPT(R)/HCPCS codes list in the Hospital Accounts Receivable (HAR) master file.
-- Bucket(s): E/M level / CPT coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(HSP_ACCOUNT_ID) AS HSP_ACCOUNT_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(CPT_OTHER_PROV_ID_PROV_NAME) AS CPT_OTHER_PROV_ID_PROV_NAME_filled
FROM HSP_ACCT_CPT_PRVDR;

-- ==========================================================
-- Table: HSP_ACCT_CPT_PRVRO
-- This table contains the other provider roles associated with the hospital account CPT(R)/HCPCS codes list in the Hospital Accounts Receivable (HAR) master file.
-- Bucket(s): E/M level / CPT coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(HSP_ACCOUNT_ID) AS HSP_ACCOUNT_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(CPT_OTHER_PROV_RL_C_NAME) AS CPT_OTHER_PROV_RL_C_NAME_filled
FROM HSP_ACCT_CPT_PRVRO;

-- ==========================================================
-- Table: HSP_ACCT_DX_LIST
-- This table contains hospital account final diagnosis list information from the Hospital Accounts Receivable (HAR) master file.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(HSP_ACCOUNT_ID) AS HSP_ACCOUNT_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(DX_ID_DX_NAME) AS DX_ID_DX_NAME_filled,
    COUNT(DX_AFFECTS_DRG_YN) AS DX_AFFECTS_DRG_YN_filled,
    COUNT(DX_COMORBIDITY_YN) AS DX_COMORBIDITY_YN_filled,
    COUNT(FINAL_DX_SOI_C_NAME) AS FINAL_DX_SOI_C_NAME_filled,
    COUNT(FINAL_DX_ROM_C_NAME) AS FINAL_DX_ROM_C_NAME_filled,
    COUNT(FINAL_DX_EXCLD_YN) AS FINAL_DX_EXCLD_YN_filled,
    COUNT(FNL_DX_AFCT_SOI_YN) AS FNL_DX_AFCT_SOI_YN_filled,
    COUNT(FNL_DX_AFCT_ROM_YN) AS FNL_DX_AFCT_ROM_YN_filled,
    COUNT(FINAL_DX_POA_C_NAME) AS FINAL_DX_POA_C_NAME_filled,
    COUNT(DX_COMORBIDITY_C_NAME) AS DX_COMORBIDITY_C_NAME_filled,
    COUNT(DX_HAC_YN) AS DX_HAC_YN_filled,
    COUNT(DX_COF_C_NAME) AS DX_COF_C_NAME_filled,
    COUNT(DX_COMPLEXITY_LVL) AS DX_COMPLEXITY_LVL_filled,
    COUNT(COMPLEX_DX_C_NAME) AS COMPLEX_DX_C_NAME_filled,
    COUNT(DX_CLASS_C_NAME) AS DX_CLASS_C_NAME_filled,
    COUNT(CAUSE_DEATH_YN) AS CAUSE_DEATH_YN_filled,
    COUNT(DX_CLUSTER) AS DX_CLUSTER_filled
FROM HSP_ACCT_DX_LIST;

-- ==========================================================
-- Table: HSP_ACCT_DX_LIST_AU_HACS
-- The Australian Hospital Acquired Complications associated with coded diagnoses.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(HSP_ACCOUNT_ID) AS HSP_ACCOUNT_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(DX_AU_HAC_CAT_C_NAME) AS DX_AU_HAC_CAT_C_NAME_filled
FROM HSP_ACCT_DX_LIST_AU_HACS;

-- ==========================================================
-- Table: HSP_ACCT_DX_LIST_HACS
-- The Hospital Acquired Conditions (HACs) associated with final coded diagnoses.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(HSP_ACCOUNT_ID) AS HSP_ACCOUNT_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(DX_HAC_CAT_C_NAME) AS DX_HAC_CAT_C_NAME_filled
FROM HSP_ACCT_DX_LIST_HACS;

-- ==========================================================
-- Table: HSP_ACCT_ICDPX_ALT
-- This table contains the hospital account alternate ICD procedures from the hospital account (HAR) master file. Alternate ICD procedures will be specified if hospital accounts are coded with two sets o
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
SELECT
    YEAR(ICD_PX_ALT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(ACCT_ID) AS ACCT_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(ICD_PX_ALT_ID) AS ICD_PX_ALT_ID_filled,
    COUNT(ICD_PX_ALT_ID_ICD_PX_NAME) AS ICD_PX_ALT_ID_ICD_PX_NAME_filled,
    COUNT(ICD_PX_ALT_DATE) AS ICD_PX_ALT_DATE_filled,
    COUNT(ICD_PX_ALT_PROV_ID_PROV_NAME) AS ICD_PX_ALT_PROV_ID_PROV_NAME_filled,
    COUNT(ICD_PX_ALT_EVNT_NUM) AS ICD_PX_ALT_EVNT_NUM_filled,
    COUNT(ICD_PX_ALT_EXCLD_YN) AS ICD_PX_ALT_EXCLD_YN_filled,
    COUNT(ICD_PX_ALT_AFSOI_YN) AS ICD_PX_ALT_AFSOI_YN_filled,
    COUNT(ICD_PX_ALT_AFROM_YN) AS ICD_PX_ALT_AFROM_YN_filled
FROM HSP_ACCT_ICDPX_ALT
GROUP BY YEAR(ICD_PX_ALT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: HSP_BDC_APPEAL_DATES
-- This table stores Appealed Days start and end dates.
-- Bucket(s): Claims / Denials
-- ==========================================================
SELECT
    YEAR(APPEAL_START_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(BDC_ID) AS BDC_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(APPEAL_START_DATE) AS APPEAL_START_DATE_filled,
    COUNT(APPEAL_END_DATE) AS APPEAL_END_DATE_filled
FROM HSP_BDC_APPEAL_DATES
GROUP BY YEAR(APPEAL_START_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: HSP_BDC_CHNG_HX
-- Change History for the Denial/Correspondence (BDC) record.
-- Bucket(s): Claims / Denials
-- ==========================================================
SELECT
    YEAR(CHNG_FOLLOW_UP_DT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(BDC_ID) AS BDC_ID_filled,
    COUNT(LINE_COUNT) AS LINE_COUNT_filled,
    COUNT(CHNG_INSTANT) AS CHNG_INSTANT_filled,
    COUNT(CHNG_USER_ID) AS CHNG_USER_ID_filled,
    COUNT(CHNG_USER_ID_NAME) AS CHNG_USER_ID_NAME_filled,
    COUNT(CHNG_TYPE_C_NAME) AS CHNG_TYPE_C_NAME_filled,
    COUNT(CHNG_SOURCE_VAL) AS CHNG_SOURCE_VAL_filled,
    COUNT(CHNG_TARGET_VAL) AS CHNG_TARGET_VAL_filled,
    COUNT(CHNG_FOLLOW_UP_DT) AS CHNG_FOLLOW_UP_DT_filled,
    COUNT(CHNG_COMMENTS) AS CHNG_COMMENTS_filled,
    COUNT(BFH_ID) AS BFH_ID_filled
FROM HSP_BDC_CHNG_HX
GROUP BY YEAR(CHNG_FOLLOW_UP_DT)
ORDER BY activity_year;

-- ==========================================================
-- Table: HSP_BDC_CONTRIB_PMT
-- This table includes a list of payments that contributed to the creation of the follow-up record.
-- Bucket(s): Claims / Denials
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(BDC_ID) AS BDC_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(CONTRIB_PMT_TX_ID) AS CONTRIB_PMT_TX_ID_filled
FROM HSP_BDC_CONTRIB_PMT;

-- ==========================================================
-- Table: HSP_BDC_CPT_CODE
-- This table contains user-entered Current Procedural Terminology (CPT) code overrides for follow-up records (that is, denials).
-- Bucket(s): E/M level / CPT coding;Claims / Denials
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(BDC_ID) AS BDC_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(CPT_CODE) AS CPT_CODE_filled
FROM HSP_BDC_CPT_CODE;

-- ==========================================================
-- Table: HSP_BDC_CRSPNDNCE
-- Correspondence text in a Denial/Correspondence (BDC) record. Stores the lines of correspondence text received.
-- Bucket(s): Claims / Denials
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(BDC_ID) AS BDC_ID_filled,
    COUNT(LINE_COUNT) AS LINE_COUNT_filled,
    COUNT(CRSPNDCE_TEXT) AS CRSPNDCE_TEXT_filled
FROM HSP_BDC_CRSPNDNCE;

-- ==========================================================
-- Table: HSP_BDC_DENIAL_DATA
-- This table contains denial information stored in the Denial/Remark/Correspondence records in the Denial/Correspondence (BDC) master file. There can be multiple lines of data for each record. Each line
-- Bucket(s): Claims / Denials
-- ==========================================================
SELECT
    YEAR(LINE_SERVICE_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(BDC_ID) AS BDC_ID_filled,
    COUNT(LINE_COUNT) AS LINE_COUNT_filled,
    COUNT(LINE_ON_EOB) AS LINE_ON_EOB_filled,
    COUNT(LINE_BILLED_AMOUNT) AS LINE_BILLED_AMOUNT_filled,
    COUNT(LINE_ALLWD_AMT) AS LINE_ALLWD_AMT_filled,
    COUNT(LINE_PAID_AMT) AS LINE_PAID_AMT_filled,
    COUNT(LINE_DENIED_AMT) AS LINE_DENIED_AMT_filled,
    COUNT(LINE_COMMENTS) AS LINE_COMMENTS_filled,
    COUNT(LINE_REVENUE_CODE_ID) AS LINE_REVENUE_CODE_ID_filled,
    COUNT(LINE_REVENUE_CODE_ID_REVENUE_CODE_NAME) AS LINE_REVENUE_CODE_ID_REVENUE_CODE_NAME_filled,
    COUNT(LINE_CPT_CODE) AS LINE_CPT_CODE_filled,
    COUNT(LINE_PRIMARY_CHARGE_TX_ID) AS LINE_PRIMARY_CHARGE_TX_ID_filled,
    COUNT(LINE_SERVICE_DATE) AS LINE_SERVICE_DATE_filled,
    COUNT(LINE_QUANTITY) AS LINE_QUANTITY_filled,
    COUNT(LINE_ON_CLAIM) AS LINE_ON_CLAIM_filled,
    COUNT(LINE_EXPECTED_ALLOWED_AMT) AS LINE_EXPECTED_ALLOWED_AMT_filled
FROM HSP_BDC_DENIAL_DATA
GROUP BY YEAR(LINE_SERVICE_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: HSP_BDC_DENIED_DATES
-- This table stores the Denied Days start and end dates.
-- Bucket(s): Claims / Denials
-- ==========================================================
SELECT
    YEAR(DENIED_START_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(BDC_ID) AS BDC_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(DENIED_START_DATE) AS DENIED_START_DATE_filled,
    COUNT(DENIED_END_DATE) AS DENIED_END_DATE_filled
FROM HSP_BDC_DENIED_DATES
GROUP BY YEAR(DENIED_START_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: HSP_BDC_DENIED_DIAGNOSES
-- This table stores the list of diagnoses on the denial.
-- Bucket(s): ICD-10 / Diagnosis coding;Claims / Denials
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(BDC_ID) AS BDC_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(DENIED_DIAGNOSIS) AS DENIED_DIAGNOSIS_filled
FROM HSP_BDC_DENIED_DIAGNOSES;

-- ==========================================================
-- Table: HSP_BDC_DSC_RSN_CD
-- This table contains discrepancy reason code information for records in the Denial/Correspondence (DBC) master file.
-- Bucket(s): Claims / Denials
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(BDC_ID) AS BDC_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(DISCP_RMC_CODE_ID) AS DISCP_RMC_CODE_ID_filled,
    COUNT(DISCP_RMC_CODE_ID_REMIT_CODE_NAME) AS DISCP_RMC_CODE_ID_REMIT_CODE_NAME_filled,
    COUNT(EXTL_DISCP_RSN_CD) AS EXTL_DISCP_RSN_CD_filled,
    COUNT(DISP_GRP_CODE_C_NAME) AS DISP_GRP_CODE_C_NAME_filled
FROM HSP_BDC_DSC_RSN_CD;

-- ==========================================================
-- Table: HSP_BDC_IMAGING
-- This table contains related imaging information for the Denial/Correspondence (BDC) master file.
-- Bucket(s): Claims / Denials
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(BDC_ID) AS BDC_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(BDC_IMAGE_MNE_C_NAME) AS BDC_IMAGE_MNE_C_NAME_filled,
    COUNT(IMAGE_KEY) AS IMAGE_KEY_filled,
    COUNT(IMAGE_PAGE_NUMBER) AS IMAGE_PAGE_NUMBER_filled,
    COUNT(BDC_PB_IMG_MNE_C_NAME) AS BDC_PB_IMG_MNE_C_NAME_filled
FROM HSP_BDC_IMAGING;

-- ==========================================================
-- Table: HSP_BDC_LINE_MODIFIERS
-- This table extracts the comma-delimited list of modifiers that is stored in the Line Modifier (I BDC 291) item for line-level denials. This table will contain one row for each modifier that exists in 
-- Bucket(s): Claims / Denials
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(BDC_ID) AS BDC_ID_filled,
    COUNT(LINE_COUNT) AS LINE_COUNT_filled,
    COUNT(MOD_LINE) AS MOD_LINE_filled,
    COUNT(EXT_MODIFIER) AS EXT_MODIFIER_filled,
    COUNT(MODIFIER_ID) AS MODIFIER_ID_filled,
    COUNT(MODIFIER_ID_MODIFIER_NAME) AS MODIFIER_ID_MODIFIER_NAME_filled
FROM HSP_BDC_LINE_MODIFIERS;

-- ==========================================================
-- Table: HSP_BDC_PAYOR
-- Table of payors attached to denial/correspondence records. Each denial/correspondence can be associated with multiple payors.
-- Bucket(s): Claims / Denials
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(BDC_ID) AS BDC_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(PAYOR_ID_PAYOR_NAME) AS PAYOR_ID_PAYOR_NAME_filled
FROM HSP_BDC_PAYOR;

-- ==========================================================
-- Table: HSP_BDC_PROF_INV
-- Table of professional invoice numbers attached to correspondence records. Each correspondence record can be associated with multiple professional invoices.
-- Bucket(s): Claims / Denials
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(BDC_ID) AS BDC_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(PROF_INVOICE_NUM) AS PROF_INVOICE_NUM_filled
FROM HSP_BDC_PROF_INV;

-- ==========================================================
-- Table: HSP_BDC_RECV_TX
-- This table contains recovery payment information for Denial/Correspondence (BDC) records.
-- Bucket(s): Claims / Denials
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(BDC_ID) AS BDC_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(RECV_PAYMENT_TX_ID) AS RECV_PAYMENT_TX_ID_filled,
    COUNT(RECV_PAYMENT_TX_AMT) AS RECV_PAYMENT_TX_AMT_filled,
    COUNT(PB_RECV_PMT_TX_ID) AS PB_RECV_PMT_TX_ID_filled
FROM HSP_BDC_RECV_TX;

-- ==========================================================
-- Table: HSP_BDC_REV_CODE
-- This table contains the user-entered revenue code overrides for follow-up records (i.e. denials).
-- Bucket(s): Claims / Denials
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(BDC_ID) AS BDC_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(REVENUE_CODE_ID) AS REVENUE_CODE_ID_filled,
    COUNT(REVENUE_CODE_ID_REVENUE_CODE_NAME) AS REVENUE_CODE_ID_REVENUE_CODE_NAME_filled
FROM HSP_BDC_REV_CODE;

-- ==========================================================
-- Table: HSP_BDC_WO_ADJ_TX
-- This table contains write-off adjustment information for Denial/Correspondence (BDC) records.
-- Bucket(s): Claims / Denials
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(BDC_ID) AS BDC_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(WRITE_OFF_ADJ_TX_ID) AS WRITE_OFF_ADJ_TX_ID_filled,
    COUNT(WRITE_OFF_ADJ_AMT) AS WRITE_OFF_ADJ_AMT_filled,
    COUNT(PB_WRITE_OFF_ADJ_TX_ID) AS PB_WRITE_OFF_ADJ_TX_ID_filled
FROM HSP_BDC_WO_ADJ_TX;

-- ==========================================================
-- Table: HSP_CLAIM_APC_GRP_DISP
-- Table that holds the display data for each grouping and claim line tuple when Ambulatory Payment Classification (APC) grouping is run through Epic for a claim.
-- Bucket(s): Claims / Denials
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_PRINT_ID) AS CLAIM_PRINT_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(APC_DISP_CLAIM_LINE) AS APC_DISP_CLAIM_LINE_filled,
    COUNT(APC_DISP_TEXT) AS APC_DISP_TEXT_filled,
    COUNT(APC_DISP_VALUE) AS APC_DISP_VALUE_filled,
    COUNT(APC_DISP_FORMULA) AS APC_DISP_FORMULA_filled,
    COUNT(APC_DISP_PMT_CLASS_GRP_C_NAME) AS APC_DISP_PMT_CLASS_GRP_C_NAME_filled
FROM HSP_CLAIM_APC_GRP_DISP;

-- ==========================================================
-- Table: HSP_CLAIM_APC_GRP_META
-- Table for Ambulatory Payment Classification (APC) grouping metadata. Holds information such as the instant of grouping, the payment classification method, and, if grouped by Epic, the mapping and loca
-- Bucket(s): Claims / Denials
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_PRINT_ID) AS CLAIM_PRINT_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(AMB_GROUPING_DTTM) AS AMB_GROUPING_DTTM_filled,
    COUNT(APC_EPIC_PMT_CLASS_GRP_C_NAME) AS APC_EPIC_PMT_CLASS_GRP_C_NAME_filled,
    COUNT(APC_EPIC_PCM_ID) AS APC_EPIC_PCM_ID_filled,
    COUNT(APC_EPIC_PCM_ID_PCM_NAME) AS APC_EPIC_PCM_ID_PCM_NAME_filled,
    COUNT(APC_EPIC_PMT_CLASS_RATE_C_NAME) AS APC_EPIC_PMT_CLASS_RATE_C_NAME_filled
FROM HSP_CLAIM_APC_GRP_META;

-- ==========================================================
-- Table: HSP_CLAIM_DETAIL1
-- This table contains claim print record information for claims associated with a given hospital account or liability bucket.
-- Bucket(s): Claims / Denials
-- ==========================================================
SELECT
    YEAR(CONTRACT_USED_DT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CLAIM_PRINT_ID) AS CLAIM_PRINT_ID_filled,
    COUNT(CLAIM_CAT_C_NAME) AS CLAIM_CAT_C_NAME_filled,
    COUNT(MAIL_NAME) AS MAIL_NAME_filled,
    COUNT(MAIL_CITY_STATE_ZIP) AS MAIL_CITY_STATE_ZIP_filled,
    COUNT(MAIL_PHONE) AS MAIL_PHONE_filled,
    COUNT(SRC_OF_ADDR_C_NAME) AS SRC_OF_ADDR_C_NAME_filled,
    COUNT(LINE_SOURCE_CLP_ID) AS LINE_SOURCE_CLP_ID_filled,
    COUNT(PARTIAL_CLAIM_YN) AS PARTIAL_CLAIM_YN_filled,
    COUNT(ORIG_HAR_RES_ACT_ID) AS ORIG_HAR_RES_ACT_ID_filled,
    COUNT(EXPECTED_PYMT) AS EXPECTED_PYMT_filled,
    COUNT(DRG_ID) AS DRG_ID_filled,
    COUNT(DRG_ID_DRG_NAME) AS DRG_ID_DRG_NAME_filled,
    COUNT(CLAIM_BILLED_AMOUNT) AS CLAIM_BILLED_AMOUNT_filled,
    COUNT(CLM_CONTRACTUAL) AS CLM_CONTRACTUAL_filled,
    COUNT(CLM_EXPECTED_PRICE) AS CLM_EXPECTED_PRICE_filled,
    COUNT(CLAIM_PMT_METHOD_C_NAME) AS CLAIM_PMT_METHOD_C_NAME_filled,
    COUNT(CLAIM_PRIM_PMT_RATE) AS CLAIM_PRIM_PMT_RATE_filled,
    COUNT(CLM_PRIMARY_CVD_QTY) AS CLM_PRIMARY_CVD_QTY_filled,
    COUNT(CLM_ADDL_PMT_MTHDS) AS CLM_ADDL_PMT_MTHDS_filled,
    COUNT(CLM_ADDL_PMT_RATES) AS CLM_ADDL_PMT_RATES_filled,
    COUNT(CLM_ADDL_CVD_QTY) AS CLM_ADDL_CVD_QTY_filled,
    COUNT(CLM_LINE_PNLTY_PER) AS CLM_LINE_PNLTY_PER_filled,
    COUNT(CLAIM_LATE_DAYS) AS CLAIM_LATE_DAYS_filled,
    COUNT(CLM_SUB_PNLTY_PER) AS CLM_SUB_PNLTY_PER_filled,
    COUNT(CLM_U_AND_C_AMT) AS CLM_U_AND_C_AMT_filled,
    COUNT(CLAIM_INS_PORTION) AS CLAIM_INS_PORTION_filled,
    COUNT(CLM_PATIENT_PORTION) AS CLM_PATIENT_PORTION_filled,
    COUNT(CLAIM_MTHD_DESC) AS CLAIM_MTHD_DESC_filled,
    COUNT(CLAIM_TERM_DESC) AS CLAIM_TERM_DESC_filled,
    COUNT(OPERATING_PROV_ID_PROV_NAME) AS OPERATING_PROV_ID_PROV_NAME_filled,
    COUNT(CONTRACT_ID) AS CONTRACT_ID_filled,
    COUNT(CONTRACT_ID_CONTRACT_NAME) AS CONTRACT_ID_CONTRACT_NAME_filled,
    COUNT(CONTRACT_DATE_REAL) AS CONTRACT_DATE_REAL_filled,
    COUNT(CONTRACT_USED_DT) AS CONTRACT_USED_DT_filled,
    COUNT(CONTRACT_NOT_USED) AS CONTRACT_NOT_USED_filled,
    COUNT(EDITED_TOB) AS EDITED_TOB_filled,
    COUNT(EDITED_EOB) AS EDITED_EOB_filled,
    COUNT(MAIL_ADDR1) AS MAIL_ADDR1_filled,
    COUNT(MAIL_ADDR2) AS MAIL_ADDR2_filled,
    COUNT(REIMB_COST_THRESH) AS REIMB_COST_THRESH_filled,
    COUNT(REIMB_COST_OUT) AS REIMB_COST_OUT_filled,
    COUNT(REIMB_DAY_THRESH) AS REIMB_DAY_THRESH_filled,
    COUNT(REIMB_DAY_OUT) AS REIMB_DAY_OUT_filled,
    COUNT(REIMB_OTH_THRESH) AS REIMB_OTH_THRESH_filled,
    COUNT(REIMB_OTH_OUT) AS REIMB_OTH_OUT_filled,
    COUNT(MAIL_COUNTRY_C_NAME) AS MAIL_COUNTRY_C_NAME_filled,
    COUNT(EXPECT_PAT_RESP_AMT) AS EXPECT_PAT_RESP_AMT_filled,
    COUNT(CLM_CAP_XR_REDUCT) AS CLM_CAP_XR_REDUCT_filled
FROM HSP_CLAIM_DETAIL1
GROUP BY YEAR(CONTRACT_USED_DT)
ORDER BY activity_year;

-- ==========================================================
-- Table: HSP_CLAIM_DETAIL2
-- This table contains detailed claim print record information for claims associated with the hospital liability bucket.
-- Bucket(s): Claims / Denials
-- ==========================================================
SELECT
    YEAR(MIN_SERVICE_DT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CLAIM_PRINT_ID) AS CLAIM_PRINT_ID_filled,
    COUNT(SA_ID_LOC_NAME) AS SA_ID_LOC_NAME_filled,
    COUNT(INACTV_CLP_YN) AS INACTV_CLP_YN_filled,
    COUNT(CLAIM_ACCEPT_DTTM) AS CLAIM_ACCEPT_DTTM_filled,
    COUNT(SG_PAYOR_ID_PAYOR_NAME) AS SG_PAYOR_ID_PAYOR_NAME_filled,
    COUNT(SG_PLAN_ID_BENEFIT_PLAN_NAME) AS SG_PLAN_ID_BENEFIT_PLAN_NAME_filled,
    COUNT(SG_CVG_ID) AS SG_CVG_ID_filled,
    COUNT(INVOICE_NUM) AS INVOICE_NUM_filled,
    COUNT(SG_PAT_ID) AS SG_PAT_ID_filled,
    COUNT(SG_GR_ACCT_ID) AS SG_GR_ACCT_ID_filled,
    COUNT(HOSPITAL_ACCT_ID) AS HOSPITAL_ACCT_ID_filled,
    COUNT(HLB_ID) AS HLB_ID_filled,
    COUNT(SG_PROV_ID_PROV_NAME) AS SG_PROV_ID_PROV_NAME_filled,
    COUNT(SG_REF_SRC_ID) AS SG_REF_SRC_ID_filled,
    COUNT(SG_REF_SRC_ID_REFERRING_PROV_NAM) AS SG_REF_SRC_ID_REFERRING_PROV_NAM_filled,
    COUNT(SG_LOC_ID_LOC_NAME) AS SG_LOC_ID_LOC_NAME_filled,
    COUNT(SG_DEP_ID_EXTERNAL_NAME) AS SG_DEP_ID_EXTERNAL_NAME_filled,
    COUNT(SG_POS_ID_LOC_NAME) AS SG_POS_ID_LOC_NAME_filled,
    COUNT(SG_CLM_ID) AS SG_CLM_ID_filled,
    COUNT(SG_RQG_ID) AS SG_RQG_ID_filled,
    COUNT(CLAIM_CLASS_C_NAME) AS CLAIM_CLASS_C_NAME_filled,
    COUNT(CLAIM_BASE_CLASS_C_NAME) AS CLAIM_BASE_CLASS_C_NAME_filled,
    COUNT(MIN_SERVICE_DT) AS MIN_SERVICE_DT_filled,
    COUNT(MAX_SERVICE_DT) AS MAX_SERVICE_DT_filled,
    COUNT(UB_FROM_DT) AS UB_FROM_DT_filled,
    COUNT(UB_THROUGH_DT) AS UB_THROUGH_DT_filled,
    COUNT(CLAIM_TYPE_C_NAME) AS CLAIM_TYPE_C_NAME_filled,
    COUNT(CLAIM_FRM_TYPE_C_NAME) AS CLAIM_FRM_TYPE_C_NAME_filled,
    COUNT(TTL_CHRGS_AMT) AS TTL_CHRGS_AMT_filled,
    COUNT(TTL_DUE_AMT) AS TTL_DUE_AMT_filled,
    COUNT(TTL_NONCVD_AMT) AS TTL_NONCVD_AMT_filled,
    COUNT(TTL_PMT_AMT) AS TTL_PMT_AMT_filled,
    COUNT(TTL_ADJ_AMT) AS TTL_ADJ_AMT_filled,
    COUNT(UB_BILL_TYPE) AS UB_BILL_TYPE_filled,
    COUNT(HM_HLTH_BILL_TYP_C_NAME) AS HM_HLTH_BILL_TYP_C_NAME_filled,
    COUNT(UB_SG_GRP_NUM) AS UB_SG_GRP_NUM_filled,
    COUNT(CNCL_CLAIM) AS CNCL_CLAIM_filled,
    COUNT(REPL_CLAIM) AS REPL_CLAIM_filled,
    COUNT(UB_CVD_DAYS) AS UB_CVD_DAYS_filled,
    COUNT(UB_COINS_DAYS) AS UB_COINS_DAYS_filled,
    COUNT(UB_NON_CVD_DAYS) AS UB_NON_CVD_DAYS_filled,
    COUNT(UB_PRINC_DX_ID_DX_NAME) AS UB_PRINC_DX_ID_DX_NAME_filled,
    COUNT(CNCL_CLAIM_CODE) AS CNCL_CLAIM_CODE_filled,
    COUNT(REPL_CLAIM_CODE) AS REPL_CLAIM_CODE_filled,
    COUNT(SG_ALTPYR_CLM_YN) AS SG_ALTPYR_CLM_YN_filled,
    COUNT(FILING_ORDER_C_NAME) AS FILING_ORDER_C_NAME_filled,
    COUNT(CLM_EXT_VAL_ID) AS CLM_EXT_VAL_ID_filled,
    COUNT(SG_TREAT_PLAN_ID) AS SG_TREAT_PLAN_ID_filled,
    COUNT(UB_COMB_CLM_TYP_C_NAME) AS UB_COMB_CLM_TYP_C_NAME_filled,
    COUNT(REND_PROV_ID_PROV_NAME) AS REND_PROV_ID_PROV_NAME_filled,
    COUNT(RESEARCH_ID_RESEARCH_STUDY_NAME) AS RESEARCH_ID_RESEARCH_STUDY_NAME_filled,
    COUNT(SRC_INV_NUM) AS SRC_INV_NUM_filled,
    COUNT(CLAIM_TAX_AMOUNT) AS CLAIM_TAX_AMOUNT_filled,
    COUNT(DRG_XR_AMOUNT) AS DRG_XR_AMOUNT_filled,
    COUNT(DRG_TAX_AMOUNT) AS DRG_TAX_AMOUNT_filled,
    COUNT(CLAIM_APEC_OUTLIER) AS CLAIM_APEC_OUTLIER_filled,
    COUNT(SNF_CLAIM_TYPE_C_NAME) AS SNF_CLAIM_TYPE_C_NAME_filled,
    COUNT(DEPT_TYPE_C_NAME) AS DEPT_TYPE_C_NAME_filled,
    COUNT(CLM_REBILL_REASON_C_NAME) AS CLM_REBILL_REASON_C_NAME_filled,
    COUNT(CLM_REBILL_USER_ID) AS CLM_REBILL_USER_ID_filled,
    COUNT(CLM_REBILL_USER_ID_NAME) AS CLM_REBILL_USER_ID_NAME_filled,
    COUNT(FAC_ACTOR_TYPE_C_NAME) AS FAC_ACTOR_TYPE_C_NAME_filled,
    COUNT(BENEFIT_RECORD_ID) AS BENEFIT_RECORD_ID_filled,
    COUNT(PREDICTED_PAY_DATE) AS PREDICTED_PAY_DATE_filled,
    COUNT(SUGGESTED_FOL_UP_DATE) AS SUGGESTED_FOL_UP_DATE_filled,
    COUNT(CLM_CLOSED_TIMELY_YN) AS CLM_CLOSED_TIMELY_YN_filled,
    COUNT(REIMB_DRG_SOI) AS REIMB_DRG_SOI_filled
FROM HSP_CLAIM_DETAIL2
GROUP BY YEAR(MIN_SERVICE_DT)
ORDER BY activity_year;

-- ==========================================================
-- Table: HSP_CLAIM_DETAIL3
-- This table contains detailed claim print record information for claims associated with the hospital liability bucket.
-- Bucket(s): Claims / Denials
-- ==========================================================
SELECT
    YEAR(CH_SENT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CLAIM_PRINT_ID) AS CLAIM_PRINT_ID_filled,
    COUNT(CH_SENT_DATE) AS CH_SENT_DATE_filled,
    COUNT(PAYER_RECEIVED_DATE) AS PAYER_RECEIVED_DATE_filled
FROM HSP_CLAIM_DETAIL3
GROUP BY YEAR(CH_SENT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: HSP_CLAIM_PAT_RESP
-- This table contains information about how the patient responsibility for the claim was calculated.
-- Bucket(s): Claims / Denials
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_PRINT_ID) AS CLAIM_PRINT_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(CLAIM_PX_LINE_NUM) AS CLAIM_PX_LINE_NUM_filled,
    COUNT(SERVICE_TYPE_ID) AS SERVICE_TYPE_ID_filled,
    COUNT(SERVICE_TYPE_ID_SERVICE_TYPE_NAME) AS SERVICE_TYPE_ID_SERVICE_TYPE_NAME_filled,
    COUNT(SERVICE_TYPE_SOURCE_DESC) AS SERVICE_TYPE_SOURCE_DESC_filled,
    COUNT(DEDUCTIBLE_AMOUNT) AS DEDUCTIBLE_AMOUNT_filled,
    COUNT(COPAY_AMOUNT) AS COPAY_AMOUNT_filled,
    COUNT(COINSURANCE_AMOUNT) AS COINSURANCE_AMOUNT_filled,
    COUNT(NON_COVERED_AMOUNT) AS NON_COVERED_AMOUNT_filled,
    COUNT(NON_COVERED_RSN_C_NAME) AS NON_COVERED_RSN_C_NAME_filled,
    COUNT(ANNUAL_MOOP_CONTRIB_AMOUNT) AS ANNUAL_MOOP_CONTRIB_AMOUNT_filled,
    COUNT(VISIT_MOOP_CONTRIB_AMOUNT) AS VISIT_MOOP_CONTRIB_AMOUNT_filled,
    COUNT(OUT_OF_POCKET_LMT_RSN_C_NAME) AS OUT_OF_POCKET_LMT_RSN_C_NAME_filled
FROM HSP_CLAIM_PAT_RESP;

-- ==========================================================
-- Table: HSP_CLAIM_PRINT
-- This table contains claim print record information for claims associated with a given hospital account or liability bucket.
-- Bucket(s): Claims / Denials
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_PRINT_ID) AS CLAIM_PRINT_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(HSP_ACCOUNT_ID) AS HSP_ACCOUNT_ID_filled,
    COUNT(CM_PHY_OWN_ID) AS CM_PHY_OWN_ID_filled
FROM HSP_CLAIM_PRINT;

-- ==========================================================
-- Table: HSP_CLAIM_XR_DISP
-- This table contains the information used to display the details of calculations performed by contract pricing extensions when calculating expected reimbursement.
-- Bucket(s): Claims / Denials
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_PRINT_ID) AS CLAIM_PRINT_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(XR_DISP_LINE_NUM) AS XR_DISP_LINE_NUM_filled,
    COUNT(XR_DISP_DESCRIPTION) AS XR_DISP_DESCRIPTION_filled,
    COUNT(XR_DISP_AMT) AS XR_DISP_AMT_filled
FROM HSP_CLAIM_XR_DISP;

-- ==========================================================
-- Table: HSP_CLAIM_XR_VARS
-- This table contains the values used by contract pricing extensions for calculating expected reimbursement.
-- Bucket(s): Claims / Denials
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_PRINT_ID) AS CLAIM_PRINT_ID_filled,
    COUNT(COST_OUT_PMT_TOTAL) AS COST_OUT_PMT_TOTAL_filled,
    COUNT(COST_OUT_PMT_CAND) AS COST_OUT_PMT_CAND_filled,
    COUNT(IMPLANT_PMT_TOTAL) AS IMPLANT_PMT_TOTAL_filled,
    COUNT(PHY_TRANS_PMT_TOTAL) AS PHY_TRANS_PMT_TOTAL_filled,
    COUNT(COST_OUT_TAX_TOTAL) AS COST_OUT_TAX_TOTAL_filled,
    COUNT(ADD_ON_TAX_TOTAL) AS ADD_ON_TAX_TOTAL_filled,
    COUNT(SUPPLY_ADD_ON_PMT_TOTAL) AS SUPPLY_ADD_ON_PMT_TOTAL_filled,
    COUNT(DRUG_ADD_ON_PMT_TOTAL) AS DRUG_ADD_ON_PMT_TOTAL_filled
FROM HSP_CLAIM_XR_VARS;

-- ==========================================================
-- Table: HSP_CLP_CMS_LINE_DX
-- This table contains linkages between service lines and diagnoses for Hospital Billing claims.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_PRINT_ID) AS CLAIM_PRINT_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(LINE_DX_SVC_LINE) AS LINE_DX_SVC_LINE_filled,
    COUNT(LINE_DX_PIECE) AS LINE_DX_PIECE_filled,
    COUNT(LINE_DX_POINTER) AS LINE_DX_POINTER_filled
FROM HSP_CLP_CMS_LINE_DX;

-- ==========================================================
-- Table: HSP_CLP_DIAGNOSIS
-- This table contains diagnosis related information for claim print records associated with the hospital account/liability bucket.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CLAIM_PRINT_ID) AS CLAIM_PRINT_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(DX_ID_DX_NAME) AS DX_ID_DX_NAME_filled,
    COUNT(DX_POA_C_NAME) AS DX_POA_C_NAME_filled
FROM HSP_CLP_DIAGNOSIS;

-- ==========================================================
-- Table: HSP_PRE_AR_DX
-- This table contains diagnosis related information for Hospital Billing temporary transactions. This table is limited to charge temporary transactions that have not yet been posted to the account.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(HTT_ID) AS HTT_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(DX_ID_DX_NAME) AS DX_ID_DX_NAME_filled,
    COUNT(DX_QUAL_HA_C_NAME) AS DX_QUAL_HA_C_NAME_filled
FROM HSP_PRE_AR_DX;

-- ==========================================================
-- Table: ICD_EVNT_INTRP_CMT
-- Table for event interpretation comment item.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(IMPLANT_ID) AS IMPLANT_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(ICD_EVENT_INTERPRET) AS ICD_EVENT_INTERPRET_filled
FROM ICD_EVNT_INTRP_CMT
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: ICD_POCKET_CMT
-- Table for implantable cardioverter-defibrillator (ICD) Pocket Comment item.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(IMPLANT_ID) AS IMPLANT_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(ICD_POCKET_CMT) AS ICD_POCKET_CMT_filled
FROM ICD_POCKET_CMT
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: INV_DX_INFO
-- Stores claim-level diagnosis information sent on Resolute Professional Billing claims. Diagnosis information is coming from the INV 350 related group. The Group 100 column corresponds to claims that w
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(INVOICE_ID) AS INVOICE_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(DX_ID_DX_NAME) AS DX_ID_DX_NAME_filled,
    COUNT(INV_NUM) AS INV_NUM_filled,
    COUNT(INV_NUM_100_GRP_LN) AS INV_NUM_100_GRP_LN_filled
FROM INV_DX_INFO;

-- ==========================================================
-- Table: LAB_CASE_RESULT_DX
-- This table contains result diagnosis information for anatomic pathology cases.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CASE_ID) AS CASE_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(RESULT_DX_ID_DX_NAME) AS RESULT_DX_ID_DX_NAME_filled
FROM LAB_CASE_RESULT_DX;

-- ==========================================================
-- Table: MED_ALL_DX_CODES
-- This item stores all unmapped diagnosis codes associated with medications for incoming e-prescribing messages. This table is replacing columns PRIMARY_DX_CODE and SECONDARY_DX_CODE in table DOCS_RCVD_
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(DOCUMENT_ID) AS DOCUMENT_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
FROM MED_ALL_DX_CODES
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: MED_ALL_DX_CODE_SYSTEMS
-- This item stores the coding systems used for all diagnoses (for example, ICD-9) for incoming e-prescribing messages. This table is replacing columns PRIMARY_DX_CODE_SYSTEM and SECONDARY_DX_CODE_SYSTEM
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(DOCUMENT_ID) AS DOCUMENT_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled
FROM MED_ALL_DX_CODE_SYSTEMS
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: MED_ALL_DX_IDS
-- All diagnoses for the medication specified within the incoming electronic prescription. This table is replacing columns MED_PRIM_DX_ID and MED_SEC_DX_ID in table DOCS_RCVD_MEDS.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(DOCUMENT_ID) AS DOCUMENT_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(MED_ALL_DX_ID_DX_NAME) AS MED_ALL_DX_ID_DX_NAME_filled
FROM MED_ALL_DX_IDS
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: MED_CVG_DX_VALUE
-- This table extracts the diagnosis codes associated with a medication estimate.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(MED_ESTIMATE_ID) AS MED_ESTIMATE_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(DX_ID_DX_NAME) AS DX_ID_DX_NAME_filled
FROM MED_CVG_DX_VALUE
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: MED_DISPENSE_DX
-- This table holds information about diagnoses associated with medication dispenses.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(DOCUMENT_ID) AS DOCUMENT_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(DX_ID_DX_NAME) AS DX_ID_DX_NAME_filled
FROM MED_DISPENSE_DX
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: MED_DISP_ALL_DX_CODES
-- All diagnosis codes for the medication in the medication dispensed segment of the external e-prescription, received through the incoming e-prescribing interface. This table is replacing columns MED_DI
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(DOCUMENT_ID) AS DOCUMENT_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(MED_DISP_ALL_DX) AS MED_DISP_ALL_DX_filled
FROM MED_DISP_ALL_DX_CODES;

-- ==========================================================
-- Table: MED_DISP_ALL_DX_CODE_SYS
-- The coding system used for all diagnosis codes for the medication in the medication dispensed segment of the external e-prescription, received through the incoming e-prescribing interface. This table 
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(DOCUMENT_ID) AS DOCUMENT_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(MED_DIS_ALL_DX_SYS) AS MED_DIS_ALL_DX_SYS_filled
FROM MED_DISP_ALL_DX_CODE_SYS;

-- ==========================================================
-- Table: MED_DISP_ALL_DX_IDS
-- All diagnoses for the medication in the medication dispensed segment of the external e-prescription, received through the incoming e-prescribing interface. This table is replacing columns MED_DISP_PRI
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(DOCUMENT_ID) AS DOCUMENT_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(MED_DISP_ALL_DX_ID_DX_NAME) AS MED_DISP_ALL_DX_ID_DX_NAME_filled
FROM MED_DISP_ALL_DX_IDS;

-- ==========================================================
-- Table: MED_THERAPY_PROB_DX
-- Contains diagnosis information for the medication therapy problem.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(PROBLEM_ID) AS PROBLEM_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(PROBLEM_DX_ID_DX_NAME) AS PROBLEM_DX_ID_DX_NAME_filled,
    COUNT(PROB_DIAG_SOURCE_C_NAME) AS PROB_DIAG_SOURCE_C_NAME_filled
FROM MED_THERAPY_PROB_DX;

-- ==========================================================
-- Table: MTP_AUTO_EVAL_DIAGNOSES
-- The diagnosis information obtained from the Medication Therapy Opportunities Engine.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
SELECT
    YEAR(DX_DATE_FILED_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(PROBLEM_ID) AS PROBLEM_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(AUTO_EVAL_DX_ID_DX_NAME) AS AUTO_EVAL_DX_ID_DX_NAME_filled,
    COUNT(PROB_DIAG_SOURCE_C_NAME) AS PROB_DIAG_SOURCE_C_NAME_filled,
    COUNT(PROBLEM_LIST_ID) AS PROBLEM_LIST_ID_filled,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(INVOICE_ID) AS INVOICE_ID_filled,
    COUNT(SURGICAL_LOG_ID) AS SURGICAL_LOG_ID_filled,
    COUNT(SURGICAL_CASE_ID) AS SURGICAL_CASE_ID_filled,
    COUNT(DX_DATE_FILED_DATE) AS DX_DATE_FILED_DATE_filled
FROM MTP_AUTO_EVAL_DIAGNOSES
GROUP BY YEAR(DX_DATE_FILED_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: MTP_AUTO_EVAL_DX_EXT_REF
-- The external data reference identifiers associated with the diagnosis identified by the medication therapy opportunities engine evaluation.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(PROBLEM_ID) AS PROBLEM_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(DX_EXT_REF_IDENT) AS DX_EXT_REF_IDENT_filled
FROM MTP_AUTO_EVAL_DX_EXT_REF;

-- ==========================================================
-- Table: MTP_AUTO_EVAL_DX_SRC_ORG
-- The source organizations that filed the information.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(PROBLEM_ID) AS PROBLEM_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(DX_SOURCE_ORG_ID) AS DX_SOURCE_ORG_ID_filled,
    COUNT(DX_SOURCE_ORG_ID_EXTERNAL_NAME) AS DX_SOURCE_ORG_ID_EXTERNAL_NAME_filled
FROM MTP_AUTO_EVAL_DX_SRC_ORG;

-- ==========================================================
-- Table: MULT_DISC_DX
-- This table contains information on the defined multidisciplinary diagnoses/problems.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(PROBLEM_ID_NAME) AS PROBLEM_ID_NAME_filled,
    COUNT(NAME) AS NAME_filled,
    COUNT(DISPLAY_NAME) AS DISPLAY_NAME_filled
FROM MULT_DISC_DX;

-- ==========================================================
-- Table: NOTES_PROC_PRE_DX
-- This table contains a list of preoperative diagnoses for ambulatory procedure notes.
-- Bucket(s): ICD-10 / Diagnosis coding
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
-- Table: NOTES_PROC_PST_DX
-- This table contains a list of postoperative diagnoses for ambulatory procedure notes.
-- Bucket(s): ICD-10 / Diagnosis coding
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
-- Table: NSQIP_FIRST_REOP_CPT
-- This table contains CPT® and procedure description related to the first reoperation.
-- Bucket(s): E/M level / CPT coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(REGISTRY_DATA_ID) AS REGISTRY_DATA_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NSQIP_FST_REOP_INF_SRC_C_NAME) AS NSQIP_FST_REOP_INF_SRC_C_NAME_filled,
    COUNT(NSQIP_FST_REOP_CPT) AS NSQIP_FST_REOP_CPT_filled,
    COUNT(NSQIP_FST_REOP_PROC_DESC) AS NSQIP_FST_REOP_PROC_DESC_filled
FROM NSQIP_FIRST_REOP_CPT;

-- ==========================================================
-- Table: NSQIP_FIRST_REOP_ICD10
-- This table contains ICD-10 code and diagnosis description related to the first reoperation.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(REGISTRY_DATA_ID) AS REGISTRY_DATA_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NSQIP_FST_REOP_ICD10) AS NSQIP_FST_REOP_ICD10_filled,
    COUNT(NSQIP_FST_REOP_ICD10_DX_DESC) AS NSQIP_FST_REOP_ICD10_DX_DESC_filled
FROM NSQIP_FIRST_REOP_ICD10;

-- ==========================================================
-- Table: NSQIP_FIRST_REOP_ICD9
-- This table contains ICD-9 code and diagnosis description related to the first reoperation.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(REGISTRY_DATA_ID) AS REGISTRY_DATA_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NSQIP_FST_REOP_ICD9) AS NSQIP_FST_REOP_ICD9_filled,
    COUNT(NSQIP_FST_REOP_DX_DESC) AS NSQIP_FST_REOP_DX_DESC_filled
FROM NSQIP_FIRST_REOP_ICD9;

-- ==========================================================
-- Table: NSQIP_RETURN_DX_COMMENTS
-- This table contains diagnosis comments associated with unplanned returns to the OR.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(REGISTRY_DATA_ID) AS REGISTRY_DATA_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NSQIP_RETURN_DX_COMMENTS) AS NSQIP_RETURN_DX_COMMENTS_filled
FROM NSQIP_RETURN_DX_COMMENTS;

-- ==========================================================
-- Table: NSQIP_RETURN_ICD10_CODES
-- This table contains ICD-10 codes associated with unplanned returns to the OR.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(REGISTRY_DATA_ID) AS REGISTRY_DATA_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NSQIP_RETURN_ICD10_CODES) AS NSQIP_RETURN_ICD10_CODES_filled
FROM NSQIP_RETURN_ICD10_CODES;

-- ==========================================================
-- Table: NSQIP_SECOND_REOP_CPT
-- This table contains CPT® and procedure description related to the second reoperation.
-- Bucket(s): E/M level / CPT coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(REGISTRY_DATA_ID) AS REGISTRY_DATA_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NSQIP_SEC_REOP_INF_SRC_C_NAME) AS NSQIP_SEC_REOP_INF_SRC_C_NAME_filled,
    COUNT(NSQIP_SEC_REOP_CPT) AS NSQIP_SEC_REOP_CPT_filled,
    COUNT(NSQIP_SEC_REOP_PROC_DESC) AS NSQIP_SEC_REOP_PROC_DESC_filled
FROM NSQIP_SECOND_REOP_CPT;

-- ==========================================================
-- Table: NSQIP_SECOND_REOP_ICD10
-- This table contains ICD-10 code and diagnosis description related to the second reoperation.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(REGISTRY_DATA_ID) AS REGISTRY_DATA_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NSQIP_SEC_REOP_ICD10) AS NSQIP_SEC_REOP_ICD10_filled,
    COUNT(NSQIP_SEC_REOP_ICD10_DX_DESC) AS NSQIP_SEC_REOP_ICD10_DX_DESC_filled
FROM NSQIP_SECOND_REOP_ICD10;

-- ==========================================================
-- Table: NSQIP_SECOND_REOP_ICD9
-- This table contains ICD-9 code and diagnosis description related to the second reoperation.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(REGISTRY_DATA_ID) AS REGISTRY_DATA_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(NSQIP_SEC_REOP_ICD9) AS NSQIP_SEC_REOP_ICD9_filled,
    COUNT(NSQIP_SEC_REOP_DX_DESC) AS NSQIP_SEC_REOP_DX_DESC_filled
FROM NSQIP_SECOND_REOP_ICD9;

-- ==========================================================
-- Table: ORDER_DX_MED
-- The ORDER_DX_MED table enables you to report on the diagnoses associated with medications ordered in clinical system (prescriptions). Since one medication order may be associated with multiple diagnos
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(ORDER_MED_ID) AS ORDER_MED_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(PAT_ENC_DATE_REAL) AS PAT_ENC_DATE_REAL_filled,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(DX_ID_DX_NAME) AS DX_ID_DX_NAME_filled,
    COUNT(DX_QUALIFIER_C_NAME) AS DX_QUALIFIER_C_NAME_filled,
    COUNT(DX_CHRONIC_YN) AS DX_CHRONIC_YN_filled,
    COUNT(COMMENTS) AS COMMENTS_filled
FROM ORDER_DX_MED;

-- ==========================================================
-- Table: ORDER_DX_PROC
-- The ORDER_DX_PROC table enables you to report on the diagnoses associated with procedures ordered in clinical system. Since one procedure order may be associated with multiple diagnoses, each row in t
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(ORDER_PROC_ID) AS ORDER_PROC_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(PAT_ENC_DATE_REAL) AS PAT_ENC_DATE_REAL_filled,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(DX_ID_DX_NAME) AS DX_ID_DX_NAME_filled,
    COUNT(DX_QUALIFIER_C_NAME) AS DX_QUALIFIER_C_NAME_filled,
    COUNT(COMMENTS) AS COMMENTS_filled,
    COUNT(DX_CHRONIC_YN) AS DX_CHRONIC_YN_filled,
    COUNT(ASSOC_DX_DESC) AS ASSOC_DX_DESC_filled,
    COUNT(ASSOC_REQ_DX_ID_DX_NAME) AS ASSOC_REQ_DX_ID_DX_NAME_filled
FROM ORDER_DX_PROC;

-- ==========================================================
-- Table: ORDER_ORIG_RX_DX
-- For orders representing electronic refill requests received via an interface, this item contains the diagnoses that were received in the interface message.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(ORDER_ID) AS ORDER_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(ORIG_DX_ID_DX_NAME) AS ORIG_DX_ID_DX_NAME_filled
FROM ORDER_ORIG_RX_DX;

-- ==========================================================
-- Table: ORDER_RAD_DX
-- This table contains diagnoses attached to an imaging order by the reading physician. The diagnoses are used by billing to drop charges.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(ORDER_ID) AS ORDER_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(RIS_DIAGNOSES_ID_DX_NAME) AS RIS_DIAGNOSES_ID_DX_NAME_filled
FROM ORDER_RAD_DX;

-- ==========================================================
-- Table: OR_CASE_CPT_TXT
-- The OR_CASE_CPT_TXT table contains the list of free-text CPT(R) codes entered for a case record.
-- Bucket(s): E/M level / CPT coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CASE_ID) AS CASE_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(CPT_CODE_TXT) AS CPT_CODE_TXT_filled
FROM OR_CASE_CPT_TXT;

-- ==========================================================
-- Table: OR_CASE_DIAGNOSTIC_PROC
-- This table contains the diagnostic procedures performed for a case.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(CASE_ID) AS CASE_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(DIAGNOSTIC_PROC_C_NAME) AS DIAGNOSTIC_PROC_C_NAME_filled
FROM OR_CASE_DIAGNOSTIC_PROC;

-- ==========================================================
-- Table: OR_CASE_DX_CODE
-- The OR_CASE_DX_CODE table contains OR management system case diagnosis codes.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(OR_CASE_ID) AS OR_CASE_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(DX_ID_DX_NAME) AS DX_ID_DX_NAME_filled
FROM OR_CASE_DX_CODE;

-- ==========================================================
-- Table: OR_IMP_DIAGNOSIS
-- This table contains information about implant diagnoses.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(IMPLANT_ID) AS IMPLANT_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(IMPLANT_DIAGNOSIS_C_NAME) AS IMPLANT_DIAGNOSIS_C_NAME_filled
FROM OR_IMP_DIAGNOSIS
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: OR_IMP_ICD_PACEMAKER_RATE
-- This table stores the rate type for implantable cardioverter-defibrillator (ICD)/Pacemaker implants.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(IMPLANT_ID) AS IMPLANT_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(ICD_PACEMAKER_RATE_TYPE_C_NAME) AS ICD_PACEMAKER_RATE_TYPE_C_NAME_filled
FROM OR_IMP_ICD_PACEMAKER_RATE;

-- ==========================================================
-- Table: OR_LNLG_ANINF_CPT
-- This table contains the Anesthesia Info CPT codes for the Surgical Log (ORL).
-- Bucket(s): E/M level / CPT coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(RECORD_ID) AS RECORD_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(ANES_INFO_CPTM_ID_PROC_NAME) AS ANES_INFO_CPTM_ID_PROC_NAME_filled
FROM OR_LNLG_ANINF_CPT;

-- ==========================================================
-- Table: OR_LNLG_DIAGNOSIS
-- This table contains the Diagnosis information for the Surgical Log (ORL).
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(RECORD_ID) AS RECORD_ID_filled,
    COUNT(DX_ORP_ID) AS DX_ORP_ID_filled,
    COUNT(DX_ORP_ID_PROC_NAME) AS DX_ORP_ID_PROC_NAME_filled,
    COUNT(DX_LATERALITY_C_NAME) AS DX_LATERALITY_C_NAME_filled,
    COUNT(DX_PRIMARY_DX_ID_DX_NAME) AS DX_PRIMARY_DX_ID_DX_NAME_filled,
    COUNT(DX_PROC_PANEL) AS DX_PROC_PANEL_filled,
    COUNT(DX_CPT_CODE_2_ID_PROC_NAME) AS DX_CPT_CODE_2_ID_PROC_NAME_filled,
    COUNT(DX_CPT_CODE_3_ID_PROC_NAME) AS DX_CPT_CODE_3_ID_PROC_NAME_filled,
    COUNT(DX_QTY) AS DX_QTY_filled,
    COUNT(DX_PROC_TYPE_C_NAME) AS DX_PROC_TYPE_C_NAME_filled
FROM OR_LNLG_DIAGNOSIS;

-- ==========================================================
-- Table: OR_LNLG_DIAG_CPTS
-- This table contains the Diagnosis CPT codes for the Surgical Log (ORL).
-- Bucket(s): E/M level / CPT coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(RECORD_ID) AS RECORD_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(DX_CPT_CODE_1_ID_PROC_NAME) AS DX_CPT_CODE_1_ID_PROC_NAME_filled
FROM OR_LNLG_DIAG_CPTS;

-- ==========================================================
-- Table: OR_LOG_DIAGNOSTIC_PROC
-- This table stores additional diagnostic/therapeutic procedures performed.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(LOG_ID) AS LOG_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(DIAGNOSTIC_PROCEDURES_C_NAME) AS DIAGNOSTIC_PROCEDURES_C_NAME_filled
FROM OR_LOG_DIAGNOSTIC_PROC;

-- ==========================================================
-- Table: OR_LOG_DIAGNOSTIC_PROC_FT
-- This table stores free-text comments about additional diagnostic/therapeutic procedures performed.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(LOG_ID) AS LOG_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(DIAGNOSTIC_PROCEDURES_FT) AS DIAGNOSTIC_PROCEDURES_FT_filled
FROM OR_LOG_DIAGNOSTIC_PROC_FT;

-- ==========================================================
-- Table: OR_LOG_LN_DIAGNOS
-- This table contains the line IDs (ORM) for the Diagnosis Information of the Surgical Log (ORL).
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(LOG_ID) AS LOG_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(DX_PROC_INFO_ID) AS DX_PROC_INFO_ID_filled
FROM OR_LOG_LN_DIAGNOS;

-- ==========================================================
-- Table: OR_OPE_CODE_DIAGNOSIS
-- This table contains the diagnoses associated with procedure codes.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(OPE_ID) AS OPE_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(PROC_CODE_DX_ID_DX_NAME) AS PROC_CODE_DX_ID_DX_NAME_filled
FROM OR_OPE_CODE_DIAGNOSIS;

-- ==========================================================
-- Table: OTP_DX_ASSOC
-- The diagnoses associated with an order template. Note that if an order template is unreleased and it has no diagnoses then it will use the plan diagnoses stored in the ASSOCIATED_DX table.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(OTP_ID) AS OTP_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(ASSOC_DX_ID_DX_NAME) AS ASSOC_DX_ID_DX_NAME_filled,
    COUNT(ASSOC_DX_DESC) AS ASSOC_DX_DESC_filled,
    COUNT(ASSOC_DX_COMMENT) AS ASSOC_DX_COMMENT_filled
FROM OTP_DX_ASSOC;

-- ==========================================================
-- Table: PAS_TRIAGE_DX_HX
-- This table extracts the related multiple response Triage History - Diagnoses (I RFL 971) item.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(REFERRAL_ID) AS REFERRAL_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(PAS_TRI_HX_DX_ID_DX_NAME) AS PAS_TRI_HX_DX_ID_DX_NAME_filled
FROM PAS_TRIAGE_DX_HX;

-- ==========================================================
-- Table: PAT_DIFF_DX
-- This table will contain all of the differential diagnosis entries for a particular encounter.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(PAT_ENC_DATE_REAL) AS PAT_ENC_DATE_REAL_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(DIFF_DX_ID_DX_NAME) AS DIFF_DX_ID_DX_NAME_filled,
    COUNT(DIFF_DX_DESC) AS DIFF_DX_DESC_filled,
    COUNT(DIFF_DX_QUALIFIER_C_NAME) AS DIFF_DX_QUALIFIER_C_NAME_filled,
    COUNT(DIFF_DX_STATUS_C_NAME) AS DIFF_DX_STATUS_C_NAME_filled,
    COUNT(DIFF_DX_COMMENT) AS DIFF_DX_COMMENT_filled,
    COUNT(DIFF_DX_UNIQUE) AS DIFF_DX_UNIQUE_filled,
    COUNT(DIFF_CHRONIC_YN) AS DIFF_CHRONIC_YN_filled,
    COUNT(DDX_LINK_PROB_ID) AS DDX_LINK_PROB_ID_filled
FROM PAT_DIFF_DX
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: PAT_ENC_ADMIT_DX_AUDIT
-- This tables stores previous instances in which the admission diagnosis was populated or deleted for an encounter.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(ADMISSION_DX_EDIT_UTC_DTTM) AS ADMISSION_DX_EDIT_UTC_DTTM_filled
FROM PAT_ENC_ADMIT_DX_AUDIT;

-- ==========================================================
-- Table: PAT_ENC_APPT_DX
-- The PAT_ENC_APPT_DX table contains a list of diagnoses associated with appointments that were manually entered by a user on the "Clinical Information" form, which can appear in Advantage Activities in
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(PAT_ID) AS PAT_ID_filled,
    COUNT(PAT_ENC_DATE_REAL) AS PAT_ENC_DATE_REAL_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(DX_ID_DX_NAME) AS DX_ID_DX_NAME_filled
FROM PAT_ENC_APPT_DX
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: PAT_ENC_DX
-- The patient encounter diagnosis table contains one record for each diagnosis associated with each encounter level of service. This table will contain all diagnoses specified on the Order Summary scree
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(PAT_ENC_DATE_REAL) AS PAT_ENC_DATE_REAL_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(DX_ID_DX_NAME) AS DX_ID_DX_NAME_filled,
    COUNT(ANNOTATION) AS ANNOTATION_filled,
    COUNT(DX_QUALIFIER_C_NAME) AS DX_QUALIFIER_C_NAME_filled,
    COUNT(PRIMARY_DX_YN) AS PRIMARY_DX_YN_filled,
    COUNT(COMMENTS) AS COMMENTS_filled,
    COUNT(DX_CHRONIC_YN) AS DX_CHRONIC_YN_filled,
    COUNT(DX_STAGE_ID) AS DX_STAGE_ID_filled,
    COUNT(DX_UNIQUE) AS DX_UNIQUE_filled,
    COUNT(DX_ED_YN) AS DX_ED_YN_filled,
    COUNT(DX_LINK_PROB_ID) AS DX_LINK_PROB_ID_filled
FROM PAT_ENC_DX
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: PAT_ENC_EM_CODE_DX
-- The PAT_ENC_EM_CODE_DX table enables you to report on the diagnoses associated with evaluation and management (E/M) codes entered for a patient encounter. Since one E/M code may be associated with mul
-- Bucket(s): ICD-10 / Diagnosis coding;E/M level / CPT coding
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(PAT_ENC_DATE_REAL) AS PAT_ENC_DATE_REAL_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(EM_CODE_LINE) AS EM_CODE_LINE_filled,
    COUNT(DX_UNIQUE) AS DX_UNIQUE_filled
FROM PAT_ENC_EM_CODE_DX
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: PAT_ENC_LOS_DX
-- The PAT_ENC_LOS_DX table enables you to report on the diagnoses associated with the level of service (LOS) entered for a patient encounter. This table contains only information for those diagnoses tha
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(DX_UNIQUE) AS DX_UNIQUE_filled
FROM PAT_ENC_LOS_DX
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: PAT_RSN_VISIT_DX
-- All values associated with a claim are stored in the Claim External Value record. The PAT_RSN_VISIT_DX table holds the diagnoses that document the patient's reason for an outpatient visit.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(RECORD_ID) AS RECORD_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(PAT_RSN_VISIT_QUAL) AS PAT_RSN_VISIT_QUAL_filled,
    COUNT(PAT_RSN_VISIT_DX) AS PAT_RSN_VISIT_DX_filled
FROM PAT_RSN_VISIT_DX;

-- ==========================================================
-- Table: POC_HSPC_DX
-- Contains information concerning the hospice diagnoses corresponding to the plan of care.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(POC_ID) AS POC_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(POC_HSPC_DX_ID_DX_NAME) AS POC_HSPC_DX_ID_DX_NAME_filled
FROM POC_HSPC_DX;

-- ==========================================================
-- Table: POC_HSPC_DX_RELATED
-- This table indicates whether the hospice diagnoses at the time of the completed plan of care were hospice related.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(POC_ID) AS POC_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(HOSPICE_RELATED_C_NAME) AS HOSPICE_RELATED_C_NAME_filled
FROM POC_HSPC_DX_RELATED;

-- ==========================================================
-- Table: PRE_AR_ORG_DX
-- This table contains the original diagnosis information of the transaction. Note: temporary accounts receivable (TAR) records in Chronicles are purged periodically depending on your system setting. Be 
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(TAR_ID) AS TAR_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(ORG_DX_ID_DX_NAME) AS ORG_DX_ID_DX_NAME_filled,
    COUNT(ORG_DX_QUAL_C_NAME) AS ORG_DX_QUAL_C_NAME_filled
FROM PRE_AR_ORG_DX;

-- ==========================================================
-- Table: RECONCILE_MA_RA_DX_INFO
-- This table contains reconciliation information regarding statuses of diagnoses from Medicare Advantage Risk Adjustment files.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(CLAIM_RECON_ID) AS CLAIM_RECON_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(MA_RA_DX_ID_DX_NAME) AS MA_RA_DX_ID_DX_NAME_filled,
    COUNT(MA_RA_DX_FLAG_C_NAME) AS MA_RA_DX_FLAG_C_NAME_filled
FROM RECONCILE_MA_RA_DX_INFO
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: REFERRAL_CE_DX_TXT
-- This audit table stores the Care Everywhere Diagnoses Free Text.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(REFERRAL_ID) AS REFERRAL_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(AUDIT_DIAGNOSIS_TXT) AS AUDIT_DIAGNOSIS_TXT_filled
FROM REFERRAL_CE_DX_TXT;

-- ==========================================================
-- Table: REFERRAL_DX
-- The REFERRAL_DX table contains diagnosis information stored with referrals.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(REFERRAL_ID) AS REFERRAL_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(DX_ID_DX_NAME) AS DX_ID_DX_NAME_filled,
    COUNT(DX_TEXT) AS DX_TEXT_filled,
    COUNT(DX_CODE_TYPE_C_NAME) AS DX_CODE_TYPE_C_NAME_filled
FROM REFERRAL_DX;

-- ==========================================================
-- Table: REFERRAL_DX_MODIFIERS
-- This table extracts the related multiple response Diagnosis Modifiers (I RFL 1001) item.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(REFERRAL_ID) AS REFERRAL_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(DX_MODIFIER_ID) AS DX_MODIFIER_ID_filled,
    COUNT(DX_MODIFIER_ID_MODIFIER_NAME) AS DX_MODIFIER_ID_MODIFIER_NAME_filled
FROM REFERRAL_DX_MODIFIERS;

-- ==========================================================
-- Table: REFERRAL_DX_NOTES
-- Referral free text diagnosis notes as entered on the Procedures and Diagnoses (Px/Dx) form during referral entry.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(REFERRAL_ID) AS REFERRAL_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(REFERRAL_DX_NOTES) AS REFERRAL_DX_NOTES_filled
FROM REFERRAL_DX_NOTES;

-- ==========================================================
-- Table: REMOVED_CLAIM_DX
-- This table contains information about removed diagnoses from a claim adjustment.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(RECORD_ID) AS RECORD_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(REMOVED_CLAIM_DX) AS REMOVED_CLAIM_DX_filled
FROM REMOVED_CLAIM_DX;

-- ==========================================================
-- Table: REQ_DIAGNOSIS
-- This table contains the associated diagnoses on requisitions.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(REQUISITION_ID) AS REQUISITION_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(ASSOCIATED_DX_ID_DX_NAME) AS ASSOCIATED_DX_ID_DX_NAME_filled
FROM REQ_DIAGNOSIS;

-- ==========================================================
-- Table: RFL_DX_PRIM_MODS_TXT
-- A table to hold primary diagnosis modifier text.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(REFERRAL_ID) AS REFERRAL_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(PRIMARY_DX_MOD_TXT) AS PRIMARY_DX_MOD_TXT_filled
FROM RFL_DX_PRIM_MODS_TXT;

-- ==========================================================
-- Table: RFL_DX_TXT
-- This table holds the primary diagnosis free text that is associated with a referral.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(REFERRAL_ID) AS REFERRAL_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(RFL_DX_TEXT) AS RFL_DX_TEXT_filled
FROM RFL_DX_TXT;

-- ==========================================================
-- Table: RFL_PRI_DX_MOD
-- RFL_PRI_DX_MOD contains information about modifiers associated with the primary referral diagnosis.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(REFERRAL_ID) AS REFERRAL_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(PRIMARY_DX_MOD_ID) AS PRIMARY_DX_MOD_ID_filled,
    COUNT(PRIMARY_DX_MOD_ID_MODIFIER_NAME) AS PRIMARY_DX_MOD_ID_MODIFIER_NAME_filled
FROM RFL_PRI_DX_MOD;

-- ==========================================================
-- Table: RISK_ADJ_EVAL_VERS_INFO
-- Stores contact specific identification information for risk adjustment data.
-- Bucket(s): HCC / Risk adjustment
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(SUMMARY_DATA_ID) AS SUMMARY_DATA_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled
FROM RISK_ADJ_EVAL_VERS_INFO;

-- ==========================================================
-- Table: RXA_DX_INFO
-- This table holds the diagnosis-related National Council for Prescription Drug Programs (NCPDP) items used in prescription adjudication.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(RECORD_ID) AS RECORD_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(DX_CODE_QUALIFIER_C_NAME) AS DX_CODE_QUALIFIER_C_NAME_filled,
    COUNT(DX_CODE) AS DX_CODE_filled
FROM RXA_DX_INFO
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: RXA_DX_OUT
-- Clarity extract of the outgoing diagnosis information.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(RECORD_ID) AS RECORD_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(O_DX_CODE_QUAL_ID) AS O_DX_CODE_QUAL_ID_filled,
    COUNT(O_DX_CODE_QUAL_ID_EXT_CODE_LST_NAME) AS O_DX_CODE_QUAL_ID_EXT_CODE_LST_NAME_filled,
    COUNT(O_DX_CODE) AS O_DX_CODE_filled,
    COUNT(CM_CT_OWNER_ID) AS CM_CT_OWNER_ID_filled
FROM RXA_DX_OUT
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: RXFILL_DIAGNOSES
-- Table for the RxFill diagnoses.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(MED_PRBLM_LIST_ID) AS MED_PRBLM_LIST_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(RXFILL_DIAGNOSES_ID_DX_NAME) AS RXFILL_DIAGNOSES_ID_DX_NAME_filled
FROM RXFILL_DIAGNOSES;

-- ==========================================================
-- Table: RX_DISPENSE_DX
-- This table holds the diagnoses associated with a prescription fill.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(ORDER_ID) AS ORDER_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(RX_DISPENSE_DX_ID_DX_NAME) AS RX_DISPENSE_DX_ID_DX_NAME_filled
FROM RX_DISPENSE_DX
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: RX_TRANSFER_DENIAL_REASON
-- Electronic prescription transfer denial reason.
-- Bucket(s): Claims / Denials
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(DOCUMENT_ID) AS DOCUMENT_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(EXFER_DENIAL_REASON) AS EXFER_DENIAL_REASON_filled
FROM RX_TRANSFER_DENIAL_REASON;

-- ==========================================================
-- Table: RX_XFER_DENIAL_RSN_CODES
-- Electronic prescription transfer denial reason codes.
-- Bucket(s): Claims / Denials
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(DOCUMENT_ID) AS DOCUMENT_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(RXTRANS_DENIAL_ID) AS RXTRANS_DENIAL_ID_filled,
    COUNT(RXTRANS_DENIAL_ID_EXT_CODE_LST_NAME) AS RXTRANS_DENIAL_ID_EXT_CODE_LST_NAME_filled
FROM RX_XFER_DENIAL_RSN_CODES;

-- ==========================================================
-- Table: RYAN_WHITE_DX
-- This table contains diagnosis information from Ryan White abstractions.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
SELECT
    YEAR(RYN_WHT_DX_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(REGISTRY_DATA_ID) AS REGISTRY_DATA_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(RYN_WHT_DX_ID_DX_NAME) AS RYN_WHT_DX_ID_DX_NAME_filled,
    COUNT(RYN_WHT_DX_DATE) AS RYN_WHT_DX_DATE_filled,
    COUNT(RYN_WHT_DX_RESOLVED_DATE) AS RYN_WHT_DX_RESOLVED_DATE_filled,
    COUNT(RYN_WHT_DX_ASSESSMENT_C_NAME) AS RYN_WHT_DX_ASSESSMENT_C_NAME_filled,
    COUNT(RYN_WHT_DX_COMMENT) AS RYN_WHT_DX_COMMENT_filled,
    COUNT(RYN_WHT_DX_PROBLEM) AS RYN_WHT_DX_PROBLEM_filled,
    COUNT(RYN_WHT_DX_STATUS_C_NAME) AS RYN_WHT_DX_STATUS_C_NAME_filled
FROM RYAN_WHITE_DX
GROUP BY YEAR(RYN_WHT_DX_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: SAR_INFO_DX
-- This table extracts the diagnoses associated with the general/administrative information pertaining to a SAR (Service Authorization Request) case.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(REFERRAL_ID) AS REFERRAL_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(CCS_DX_ID_DX_NAME) AS CCS_DX_ID_DX_NAME_filled
FROM SAR_INFO_DX;

-- ==========================================================
-- Table: SPEC_ARCH_DX_CMT
-- This table extracts the related multiple response Archived Order Associated Diagnosis Comment (I OVS 33009) item, which contains the diagnosis comment for diagnoses associated with an archived order.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(SPECIMEN_ID) AS SPECIMEN_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(ARCH_ORD_DX_CMT) AS ARCH_ORD_DX_CMT_filled
FROM SPEC_ARCH_DX_CMT;

-- ==========================================================
-- Table: SPEC_ARCH_ORD_DX
-- This table extracts the related multiple response item Archived Order Associated Diagnoses (I OVS 33008), which contains the list of diagnoses associated with an archived order.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(SPECIMEN_ID) AS SPECIMEN_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(ARCH_ORD_DX_ID_DX_NAME) AS ARCH_ORD_DX_ID_DX_NAME_filled
FROM SPEC_ARCH_ORD_DX;

-- ==========================================================
-- Table: SPEC_DX_CODES
-- This table contains diagnosis codes (EDG records) for a specimen documented in Specimens navigator section.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(RECORD_ID) AS RECORD_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(SPEC_DX_CODE_ID_DX_NAME) AS SPEC_DX_CODE_ID_DX_NAME_filled
FROM SPEC_DX_CODES;

-- ==========================================================
-- Table: SPEC_SECTION_DX_CODES
-- This table contains diagnosis codes (EDG records) for all the specimens documented in Specimens navigator section.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(RECORD_ID) AS RECORD_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(SPEC_SECTION_DX_CODE_ID_DX_NAME) AS SPEC_SECTION_DX_CODE_ID_DX_NAME_filled
FROM SPEC_SECTION_DX_CODES;

-- ==========================================================
-- Table: TIMEOUT_POST_OP_DX
-- This table holds whether a discussion took place regarding the post-op diagnosis.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(RECORD_ID) AS RECORD_ID_filled,
    COUNT(CONTACT_DATE_REAL) AS CONTACT_DATE_REAL_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(POST_OP_DX_REVIEW_C_NAME) AS POST_OP_DX_REVIEW_C_NAME_filled
FROM TIMEOUT_POST_OP_DX
GROUP BY YEAR(CONTACT_DATE)
ORDER BY activity_year;

-- ==========================================================
-- Table: TRIAGE_HX_DX_CODE_TYPE
-- History item to track changes made to diagnosis description code type.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(REFERRAL_ID) AS REFERRAL_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(TRI_HX_DX_TYPE_C_NAME) AS TRI_HX_DX_TYPE_C_NAME_filled
FROM TRIAGE_HX_DX_CODE_TYPE;

-- ==========================================================
-- Table: TRIAGE_HX_DX_TXT
-- History item to track changes made to free text associated with diagnosis.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(REFERRAL_ID) AS REFERRAL_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(TRI_HX_DX_TXT) AS TRI_HX_DX_TXT_filled
FROM TRIAGE_HX_DX_TXT;

-- ==========================================================
-- Table: TRIAGE_HX_RFL_DX_MOD
-- This table extracts the related multiple response History - Primary Referral Diagnosis Modifiers (I RFL 992) item.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(REFERRAL_ID) AS REFERRAL_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(TRIAGE_HX_DX_MOD_ID) AS TRIAGE_HX_DX_MOD_ID_filled,
    COUNT(TRIAGE_HX_DX_MOD_ID_MODIFIER_NAME) AS TRIAGE_HX_DX_MOD_ID_MODIFIER_NAME_filled
FROM TRIAGE_HX_RFL_DX_MOD;

-- ==========================================================
-- Table: TXP_RETRANSPLANT_DX
-- UNOS retransplant diagnosis information.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(SUMMARY_BLOCK_ID) AS SUMMARY_BLOCK_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(RETXP_DX_ORGAN_C_NAME) AS RETXP_DX_ORGAN_C_NAME_filled,
    COUNT(RETXP_PRIMARY_DX_C_NAME) AS RETXP_PRIMARY_DX_C_NAME_filled,
    COUNT(RETXP_PRIMARY_DX_OTHR) AS RETXP_PRIMARY_DX_OTHR_filled,
    COUNT(RETXP_SEC_DX_OTHR) AS RETXP_SEC_DX_OTHR_filled
FROM TXP_RETRANSPLANT_DX;

-- ==========================================================
-- Table: TXP_RETRANSPLANT_DX_RM
-- This table extracts the related multiple-response Secondary Re-transplant Diagnosis (I HSB 30553) item.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(SUMMARY_BLOCK_ID) AS SUMMARY_BLOCK_ID_filled,
    COUNT(GROUP_LINE) AS GROUP_LINE_filled,
    COUNT(VALUE_LINE) AS VALUE_LINE_filled,
    COUNT(RETXP_SEC_DX_C_NAME) AS RETXP_SEC_DX_C_NAME_filled
FROM TXP_RETRANSPLANT_DX_RM;

-- ==========================================================
-- Table: UNIV_CHG_LN_DX
-- This table contains diagnosis information for one charge in the Universal Charge Line (UCL) masterfile.
-- Bucket(s): ICD-10 / Diagnosis coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(UCL_ID) AS UCL_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(DIAGNOSIS_ID_DX_NAME) AS DIAGNOSIS_ID_DX_NAME_filled,
    COUNT(DIAGNOSIS_QUAL_C_NAME) AS DIAGNOSIS_QUAL_C_NAME_filled
FROM UNIV_CHG_LN_DX;

-- ==========================================================
-- Table: URIN_BLADDER_CPTR
-- Stores single response data for College of American Pathologists (CAP) form 76061-URINARY BLADDER: Cystectomy, Partial, Total, or Radical.
-- Bucket(s): E/M level / CPT coding
-- ==========================================================
-- no date/datetime-typed column found on this table; flat total only
-- (no temporal-cutover read possible from this table alone)
SELECT
    COUNT(*) AS total_rows,
    COUNT(RESULT_ID) AS RESULT_ID_filled,
    COUNT(TUMOR_SITE_SPECIFY) AS TUMOR_SITE_SPECIFY_filled,
    COUNT(CAP_COMMENTS) AS CAP_COMMENTS_filled,
    COUNT(SPEC_PROC_SPECIFY) AS SPEC_PROC_SPECIFY_filled,
    COUNT(TUMOR_SIZE_GREAT) AS TUMOR_SIZE_GREAT_filled,
    COUNT(TUMOR_SIZE_ADDL) AS TUMOR_SIZE_ADDL_filled,
    COUNT(TUMOR_SIZE_ADDL2) AS TUMOR_SIZE_ADDL2_filled,
    COUNT(TUMOR_SIZE_SPECIFY) AS TUMOR_SIZE_SPECIFY_filled,
    COUNT(MICRO_TMR_EXT_SPFY) AS MICRO_TMR_EXT_SPFY_filled,
    COUNT(SPECIMEN_OTHER_SPFY) AS SPECIMEN_OTHER_SPFY_filled,
    COUNT(REGIONL_LYMPH_ND_C_NAME) AS REGIONL_LYMPH_ND_C_NAME_filled,
    COUNT(REG_LN_NUM_EXM) AS REG_LN_NUM_EXM_filled,
    COUNT(REG_LN_NUM_INV) AS REG_LN_NUM_INV_filled,
    COUNT(PRIMARY_TUMOR_C_NAME) AS PRIMARY_TUMOR_C_NAME_filled,
    COUNT(DISTNT_METASTASIS_C_NAME) AS DISTNT_METASTASIS_C_NAME_filled,
    COUNT(DSTNT_METASTATIS_ST) AS DSTNT_METASTATIS_ST_filled,
    COUNT(ADDL_PATH_FIND_SPFY) AS ADDL_PATH_FIND_SPFY_filled,
    COUNT(SPEC_MG_IVLV_INV_CC) AS SPEC_MG_IVLV_INV_CC_filled,
    COUNT(OTHER_TM_CONFIG_S) AS OTHER_TM_CONFIG_S_filled,
    COUNT(HIST_TYP_NONCL_SPFY) AS HIST_TYP_NONCL_SPFY_filled,
    COUNT(HG_URTL_CCNM_C_NAME) AS HG_URTL_CCNM_C_NAME_filled,
    COUNT(HG_URTL_CCNM_S) AS HG_URTL_CCNM_S_filled,
    COUNT(HG_ADEN_SQUA_CC_C_NAME) AS HG_ADEN_SQUA_CC_C_NAME_filled,
    COUNT(ADEN_SQUA_CCS) AS ADEN_SQUA_CCS_filled,
    COUNT(UROT_CCM_W_VAR_HIST) AS UROT_CCM_W_VAR_HIST_filled,
    COUNT(SQM_C_CCNM_VAR_HIST) AS SQM_C_CCNM_VAR_HIST_filled,
    COUNT(ADNCCNM_VAR_HIST) AS ADNCCNM_VAR_HIST_filled,
    COUNT(UNDIFF_CCNM) AS UNDIFF_CCNM_filled,
    COUNT(HIST_TP_MIX_CT) AS HIST_TP_MIX_CT_filled,
    COUNT(MG_IVLV_INV_CCNM_C_NAME) AS MG_IVLV_INV_CCNM_C_NAME_filled,
    COUNT(MG_UVLV_IC_DSTNC_IC) AS MG_UVLV_IC_DSTNC_IC_filled,
    COUNT(MG_UVLV_IC_SM) AS MG_UVLV_IC_SM_filled,
    COUNT(MG_IVLV_CCNM_SS) AS MG_IVLV_CCNM_SS_filled,
    COUNT(MG_IVLV_CCNM_ST_C_NAME) AS MG_IVLV_CCNM_ST_C_NAME_filled
FROM URIN_BLADDER_CPTR;
