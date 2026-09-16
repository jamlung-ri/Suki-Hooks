-- CM-22 field feasibility / density queries
-- Auto-generated. See the companion CM-XX-Field-Feasibility-Queries.md
-- and the shared README.md in this directory
-- for what this is, why it's safe to run, and how to report results back.
--
-- HOW TO RUN: execute this entire script top to bottom in one session.
-- It produces exactly ONE result grid, at the very end. Export that grid
-- to CSV and send it back -- that is the entire ask.
--
-- ERROR HANDLING: each Phase 1 block first CREATE TABLEs its own
-- staging table, then attempts the real query inside BEGIN TRY / BEGIN
-- CATCH as an INSERT INTO that same table. If a candidate table or
-- column doesn't exist in your build, the CATCH branch inserts NULL
-- counts and a query_error message (e.g. "Invalid object name 'X'.")
-- instead. A missing table never stops the script or requires you to
-- debug or fix anything -- it just shows up as an extra column on that
-- table's rows in the final grid. Please don't spend time
-- troubleshooting individual failures; just run the whole thing top to
-- bottom and send back whatever comes out the other end. (Earlier
-- versions of this script used `SELECT ... INTO` for both the TRY and
-- CATCH branches, which SQL Server rejects at compile time -- you can't
-- target the same temp table from two SELECT INTOs in one batch, even
-- in mutually exclusive branches. The explicit CREATE TABLE + INSERT
-- INTO structure below avoids that.)
--
-- Written for SQL Server T-SQL. On Oracle or in SAS PROC SQL, two swaps:
--   1. Drop the `#` prefix on every `#fc_NNN` (Oracle has no session-temp-
--      table shorthand; use an ordinary table, or a global temporary
--      table, and see the cleanup block at the end of this file).
--   2. Replace `YEAR(<col>)` with `EXTRACT(YEAR FROM <col>)` (Oracle only --
--      SAS PROC SQL supports YEAR() natively).
-- BEGIN TRY/BEGIN CATCH (see ERROR HANDLING note above) is SQL Server
-- syntax and does not translate mechanically. On Oracle, the equivalent
-- is a PL/SQL block per table (BEGIN ... EXCEPTION WHEN OTHERS THEN ...
-- END;) wrapped around the same INSERT INTO. SAS PROC SQL has no per-
-- statement equivalent at all -- if you're on SAS, run this through a
-- native SQL Server/Oracle client instead of PROC SQL, or ask us for a
-- PROC SQL-safe variant before running it.
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

-- ---- fc_001 <- APPT_CSN_COUNTS ----
-- This table contains the appointment contact serial numbers (CSNs) linked to an authorization as well as the counts used for each CSN.
-- Bucket(s): Appointment / scheduling status
-- no date/datetime-typed column found on this table; flat total only
CREATE TABLE #fc_001 (
    activity_year INT,
    total_rows INT,
    AUTH_ID_filled INT,
    LINE_filled INT,
    LINKED_APPT_CSNS_filled INT,
    LINKED_APPT_COUNTS_filled INT,
    USR_OVR_VST_COUNT_YN_filled INT,
    query_error NVARCHAR(400)
);
BEGIN TRY
INSERT INTO #fc_001 (activity_year, total_rows, AUTH_ID_filled, LINE_filled, LINKED_APPT_CSNS_filled, LINKED_APPT_COUNTS_filled, USR_OVR_VST_COUNT_YN_filled, query_error)
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(AUTH_ID) AS AUTH_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(LINKED_APPT_CSNS) AS LINKED_APPT_CSNS_filled,
    COUNT(LINKED_APPT_COUNTS) AS LINKED_APPT_COUNTS_filled,
    COUNT(USR_OVR_VST_COUNT_YN) AS USR_OVR_VST_COUNT_YN_filled,
    CAST(NULL AS NVARCHAR(400)) AS query_error
FROM APPT_CSN_COUNTS;
END TRY
BEGIN CATCH
INSERT INTO #fc_001 (activity_year, total_rows, AUTH_ID_filled, LINE_filled, LINKED_APPT_CSNS_filled, LINKED_APPT_COUNTS_filled, USR_OVR_VST_COUNT_YN_filled, query_error)
SELECT
    CAST(NULL AS INT) AS activity_year,
    CAST(NULL AS INT) AS total_rows,
    CAST(NULL AS INT) AS AUTH_ID_filled,
    CAST(NULL AS INT) AS LINE_filled,
    CAST(NULL AS INT) AS LINKED_APPT_CSNS_filled,
    CAST(NULL AS INT) AS LINKED_APPT_COUNTS_filled,
    CAST(NULL AS INT) AS USR_OVR_VST_COUNT_YN_filled,
    CAST(ERROR_MESSAGE() AS NVARCHAR(400)) AS query_error;
END CATCH;

-- ---- fc_002 <- CANCELED_APPTS_EDI ----
-- This table contains the list of visit IDs of appointments that used to be linked to an order, but were cancelled due to the order being cancelled. This item is used by the incoming
-- Bucket(s): Appointment / scheduling status
-- no date/datetime-typed column found on this table; flat total only
CREATE TABLE #fc_002 (
    activity_year INT,
    total_rows INT,
    ORDER_ID_filled INT,
    LINE_filled INT,
    CANCEL_APPTS_EDI_filled INT,
    CANC_APPT_PREV_STAT_filled INT,
    query_error NVARCHAR(400)
);
BEGIN TRY
INSERT INTO #fc_002 (activity_year, total_rows, ORDER_ID_filled, LINE_filled, CANCEL_APPTS_EDI_filled, CANC_APPT_PREV_STAT_filled, query_error)
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(ORDER_ID) AS ORDER_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(CANCEL_APPTS_EDI) AS CANCEL_APPTS_EDI_filled,
    COUNT(CANC_APPT_PREV_STAT) AS CANC_APPT_PREV_STAT_filled,
    CAST(NULL AS NVARCHAR(400)) AS query_error
FROM CANCELED_APPTS_EDI;
END TRY
BEGIN CATCH
INSERT INTO #fc_002 (activity_year, total_rows, ORDER_ID_filled, LINE_filled, CANCEL_APPTS_EDI_filled, CANC_APPT_PREV_STAT_filled, query_error)
SELECT
    CAST(NULL AS INT) AS activity_year,
    CAST(NULL AS INT) AS total_rows,
    CAST(NULL AS INT) AS ORDER_ID_filled,
    CAST(NULL AS INT) AS LINE_filled,
    CAST(NULL AS INT) AS CANCEL_APPTS_EDI_filled,
    CAST(NULL AS INT) AS CANC_APPT_PREV_STAT_filled,
    CAST(ERROR_MESSAGE() AS NVARCHAR(400)) AS query_error;
END CATCH;

-- ---- fc_003 <- CLARITY_SER ----
-- The CLARITY_SER table contains high-level information about your provider records. These records may be caregivers, resources, classes, devices, and modalities.
-- Bucket(s): Provider record (FTE / schedule — exploratory)
-- no date/datetime-typed column found on this table; flat total only
CREATE TABLE #fc_003 (
    activity_year INT,
    total_rows INT,
    PROV_ID_PROV_NAME_filled INT,
    PROV_NAME_filled INT,
    EXTERNAL_NAME_filled INT,
    query_error NVARCHAR(400)
);
BEGIN TRY
INSERT INTO #fc_003 (activity_year, total_rows, PROV_ID_PROV_NAME_filled, PROV_NAME_filled, EXTERNAL_NAME_filled, query_error)
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(PROV_ID_PROV_NAME) AS PROV_ID_PROV_NAME_filled,
    COUNT(PROV_NAME) AS PROV_NAME_filled,
    COUNT(EXTERNAL_NAME) AS EXTERNAL_NAME_filled,
    CAST(NULL AS NVARCHAR(400)) AS query_error
FROM CLARITY_SER;
END TRY
BEGIN CATCH
INSERT INTO #fc_003 (activity_year, total_rows, PROV_ID_PROV_NAME_filled, PROV_NAME_filled, EXTERNAL_NAME_filled, query_error)
SELECT
    CAST(NULL AS INT) AS activity_year,
    CAST(NULL AS INT) AS total_rows,
    CAST(NULL AS INT) AS PROV_ID_PROV_NAME_filled,
    CAST(NULL AS INT) AS PROV_NAME_filled,
    CAST(NULL AS INT) AS EXTERNAL_NAME_filled,
    CAST(ERROR_MESSAGE() AS NVARCHAR(400)) AS query_error;
END CATCH;

-- ---- fc_004 <- ORD_AUD_APPT_INFO ----
-- This table contains audit information about the appointment-level info for imaging studies.
-- Bucket(s): Appointment / scheduling status
-- no date/datetime-typed column found on this table; flat total only
CREATE TABLE #fc_004 (
    activity_year INT,
    total_rows INT,
    ORDER_ID_filled INT,
    LINE_filled INT,
    APPT_STUDY_STATUES_filled INT,
    APPT_STUDY_STAUES_EXT_VALS_filled INT,
    query_error NVARCHAR(400)
);
BEGIN TRY
INSERT INTO #fc_004 (activity_year, total_rows, ORDER_ID_filled, LINE_filled, APPT_STUDY_STATUES_filled, APPT_STUDY_STAUES_EXT_VALS_filled, query_error)
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(ORDER_ID) AS ORDER_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(APPT_STUDY_STATUES) AS APPT_STUDY_STATUES_filled,
    COUNT(APPT_STUDY_STAUES_EXT_VALS) AS APPT_STUDY_STAUES_EXT_VALS_filled,
    CAST(NULL AS NVARCHAR(400)) AS query_error
FROM ORD_AUD_APPT_INFO;
END TRY
BEGIN CATCH
INSERT INTO #fc_004 (activity_year, total_rows, ORDER_ID_filled, LINE_filled, APPT_STUDY_STATUES_filled, APPT_STUDY_STAUES_EXT_VALS_filled, query_error)
SELECT
    CAST(NULL AS INT) AS activity_year,
    CAST(NULL AS INT) AS total_rows,
    CAST(NULL AS INT) AS ORDER_ID_filled,
    CAST(NULL AS INT) AS LINE_filled,
    CAST(NULL AS INT) AS APPT_STUDY_STATUES_filled,
    CAST(NULL AS INT) AS APPT_STUDY_STAUES_EXT_VALS_filled,
    CAST(ERROR_MESSAGE() AS NVARCHAR(400)) AS query_error;
END CATCH;

-- ---- fc_005 <- PAT_ENC ----
-- The patient encounter table contains one record for each patient encounter in your system. By default, this table does not contain Registration or PCP/Clinic Change contacts (encou
-- Bucket(s): Encounter / visit record
CREATE TABLE #fc_005 (
    activity_year INT,
    total_rows INT,
    PAT_ID_filled INT,
    PAT_ENC_DATE_REAL_filled INT,
    PAT_ENC_CSN_ID_filled INT,
    CONTACT_DATE_filled INT,
    PCP_PROV_ID_PROV_NAME_filled INT,
    FIN_CLASS_C_NAME_filled INT,
    VISIT_PROV_ID_PROV_NAME_filled INT,
    VISIT_PROV_TITLE_NAME_filled INT,
    DEPARTMENT_ID_EXTERNAL_NAME_filled INT,
    LMP_DATE_filled INT,
    ENC_CLOSED_YN_filled INT,
    ENC_CLOSED_USER_ID_filled INT,
    ENC_CLOSED_USER_ID_NAME_filled INT,
    ENC_CLOSE_DATE_filled INT,
    LOS_MODIFIER1_ID_filled INT,
    LOS_MODIFIER1_ID_MODIFIER_NAME_filled INT,
    LOS_MODIFIER2_ID_filled INT,
    LOS_MODIFIER2_ID_MODIFIER_NAME_filled INT,
    LOS_MODIFIER3_ID_filled INT,
    LOS_MODIFIER3_ID_MODIFIER_NAME_filled INT,
    LOS_MODIFIER4_ID_filled INT,
    LOS_MODIFIER4_ID_MODIFIER_NAME_filled INT,
    APPT_STATUS_C_NAME_filled INT,
    APPT_CANC_USER_ID_filled INT,
    APPT_CANC_USER_ID_NAME_filled INT,
    CHECKIN_USER_ID_filled INT,
    CHECKIN_USER_ID_NAME_filled INT,
    HOSP_ADMSN_TIME_filled INT,
    HOSP_DISCHRG_TIME_filled INT,
    HOSP_ADMSN_TYPE_C_NAME_filled INT,
    NONCVRED_SERVICE_YN_filled INT,
    REFERRAL_REQ_YN_filled INT,
    REFERRAL_ID_filled INT,
    ACCOUNT_ID_filled INT,
    COVERAGE_ID_filled INT,
    CLAIM_ID_filled INT,
    PRIMARY_LOC_ID_LOC_NAME_filled INT,
    CHARGE_SLIP_NUMBER_filled INT,
    COPAY_DUE_filled INT,
    UPDATE_DATE_filled INT,
    HSP_ACCOUNT_ID_filled INT,
    ADM_FOR_SURG_YN_filled INT,
    SURGICAL_SVC_C_NAME_filled INT,
    INPATIENT_DATA_ID_filled INT,
    IP_EPISODE_ID_filled INT,
    EXTERNAL_VISIT_ID_filled INT,
    CONTACT_COMMENT_filled INT,
    OUTGOING_CALL_YN_filled INT,
    DATA_ENTRY_PERSON_filled INT,
    REFERRAL_SOURCE_ID_filled INT,
    REFERRAL_SOURCE_ID_REFERRING_PROV_NAM_filled INT,
    WC_TPL_VISIT_C_NAME_filled INT,
    CONSENT_TYPE_C_NAME_filled INT,
    BMI_filled INT,
    BSA_filled INT,
    AVS_PRINT_TM_filled INT,
    AVS_FIRST_USER_ID_filled INT,
    AVS_FIRST_USER_ID_NAME_filled INT,
    ENC_MED_FRZ_RSN_C_NAME_filled INT,
    EFFECTIVE_DATE_DT_filled INT,
    DISCHARGE_DATE_DT_filled INT,
    COPAY_PD_THRU_NAME_filled INT,
    INTERPRETER_NEED_YN_filled INT,
    VST_SPECIAL_NEEDS_C_NAME_filled INT,
    BEN_ENG_SP_AMT_filled INT,
    BEN_ADJ_COPAY_AMT_filled INT,
    BEN_ADJ_METHOD_C_NAME_filled INT,
    ENC_CREATE_USER_ID_filled INT,
    ENC_CREATE_USER_ID_NAME_filled INT,
    ENC_INSTANT_filled INT,
    EFFECTIVE_DATE_DTTM_filled INT,
    CALCULATED_ENC_STAT_C_NAME_filled INT,
    query_error NVARCHAR(400)
);
BEGIN TRY
INSERT INTO #fc_005 (activity_year, total_rows, PAT_ID_filled, PAT_ENC_DATE_REAL_filled, PAT_ENC_CSN_ID_filled, CONTACT_DATE_filled, PCP_PROV_ID_PROV_NAME_filled, FIN_CLASS_C_NAME_filled, VISIT_PROV_ID_PROV_NAME_filled, VISIT_PROV_TITLE_NAME_filled, DEPARTMENT_ID_EXTERNAL_NAME_filled, LMP_DATE_filled, ENC_CLOSED_YN_filled, ENC_CLOSED_USER_ID_filled, ENC_CLOSED_USER_ID_NAME_filled, ENC_CLOSE_DATE_filled, LOS_MODIFIER1_ID_filled, LOS_MODIFIER1_ID_MODIFIER_NAME_filled, LOS_MODIFIER2_ID_filled, LOS_MODIFIER2_ID_MODIFIER_NAME_filled, LOS_MODIFIER3_ID_filled, LOS_MODIFIER3_ID_MODIFIER_NAME_filled, LOS_MODIFIER4_ID_filled, LOS_MODIFIER4_ID_MODIFIER_NAME_filled, APPT_STATUS_C_NAME_filled, APPT_CANC_USER_ID_filled, APPT_CANC_USER_ID_NAME_filled, CHECKIN_USER_ID_filled, CHECKIN_USER_ID_NAME_filled, HOSP_ADMSN_TIME_filled, HOSP_DISCHRG_TIME_filled, HOSP_ADMSN_TYPE_C_NAME_filled, NONCVRED_SERVICE_YN_filled, REFERRAL_REQ_YN_filled, REFERRAL_ID_filled, ACCOUNT_ID_filled, COVERAGE_ID_filled, CLAIM_ID_filled, PRIMARY_LOC_ID_LOC_NAME_filled, CHARGE_SLIP_NUMBER_filled, COPAY_DUE_filled, UPDATE_DATE_filled, HSP_ACCOUNT_ID_filled, ADM_FOR_SURG_YN_filled, SURGICAL_SVC_C_NAME_filled, INPATIENT_DATA_ID_filled, IP_EPISODE_ID_filled, EXTERNAL_VISIT_ID_filled, CONTACT_COMMENT_filled, OUTGOING_CALL_YN_filled, DATA_ENTRY_PERSON_filled, REFERRAL_SOURCE_ID_filled, REFERRAL_SOURCE_ID_REFERRING_PROV_NAM_filled, WC_TPL_VISIT_C_NAME_filled, CONSENT_TYPE_C_NAME_filled, BMI_filled, BSA_filled, AVS_PRINT_TM_filled, AVS_FIRST_USER_ID_filled, AVS_FIRST_USER_ID_NAME_filled, ENC_MED_FRZ_RSN_C_NAME_filled, EFFECTIVE_DATE_DT_filled, DISCHARGE_DATE_DT_filled, COPAY_PD_THRU_NAME_filled, INTERPRETER_NEED_YN_filled, VST_SPECIAL_NEEDS_C_NAME_filled, BEN_ENG_SP_AMT_filled, BEN_ADJ_COPAY_AMT_filled, BEN_ADJ_METHOD_C_NAME_filled, ENC_CREATE_USER_ID_filled, ENC_CREATE_USER_ID_NAME_filled, ENC_INSTANT_filled, EFFECTIVE_DATE_DTTM_filled, CALCULATED_ENC_STAT_C_NAME_filled, query_error)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(PAT_ID) AS PAT_ID_filled,
    COUNT(PAT_ENC_DATE_REAL) AS PAT_ENC_DATE_REAL_filled,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(PCP_PROV_ID_PROV_NAME) AS PCP_PROV_ID_PROV_NAME_filled,
    COUNT(FIN_CLASS_C_NAME) AS FIN_CLASS_C_NAME_filled,
    COUNT(VISIT_PROV_ID_PROV_NAME) AS VISIT_PROV_ID_PROV_NAME_filled,
    COUNT(VISIT_PROV_TITLE_NAME) AS VISIT_PROV_TITLE_NAME_filled,
    COUNT(DEPARTMENT_ID_EXTERNAL_NAME) AS DEPARTMENT_ID_EXTERNAL_NAME_filled,
    COUNT(LMP_DATE) AS LMP_DATE_filled,
    COUNT(ENC_CLOSED_YN) AS ENC_CLOSED_YN_filled,
    COUNT(ENC_CLOSED_USER_ID) AS ENC_CLOSED_USER_ID_filled,
    COUNT(ENC_CLOSED_USER_ID_NAME) AS ENC_CLOSED_USER_ID_NAME_filled,
    COUNT(ENC_CLOSE_DATE) AS ENC_CLOSE_DATE_filled,
    COUNT(LOS_MODIFIER1_ID) AS LOS_MODIFIER1_ID_filled,
    COUNT(LOS_MODIFIER1_ID_MODIFIER_NAME) AS LOS_MODIFIER1_ID_MODIFIER_NAME_filled,
    COUNT(LOS_MODIFIER2_ID) AS LOS_MODIFIER2_ID_filled,
    COUNT(LOS_MODIFIER2_ID_MODIFIER_NAME) AS LOS_MODIFIER2_ID_MODIFIER_NAME_filled,
    COUNT(LOS_MODIFIER3_ID) AS LOS_MODIFIER3_ID_filled,
    COUNT(LOS_MODIFIER3_ID_MODIFIER_NAME) AS LOS_MODIFIER3_ID_MODIFIER_NAME_filled,
    COUNT(LOS_MODIFIER4_ID) AS LOS_MODIFIER4_ID_filled,
    COUNT(LOS_MODIFIER4_ID_MODIFIER_NAME) AS LOS_MODIFIER4_ID_MODIFIER_NAME_filled,
    COUNT(APPT_STATUS_C_NAME) AS APPT_STATUS_C_NAME_filled,
    COUNT(APPT_CANC_USER_ID) AS APPT_CANC_USER_ID_filled,
    COUNT(APPT_CANC_USER_ID_NAME) AS APPT_CANC_USER_ID_NAME_filled,
    COUNT(CHECKIN_USER_ID) AS CHECKIN_USER_ID_filled,
    COUNT(CHECKIN_USER_ID_NAME) AS CHECKIN_USER_ID_NAME_filled,
    COUNT(HOSP_ADMSN_TIME) AS HOSP_ADMSN_TIME_filled,
    COUNT(HOSP_DISCHRG_TIME) AS HOSP_DISCHRG_TIME_filled,
    COUNT(HOSP_ADMSN_TYPE_C_NAME) AS HOSP_ADMSN_TYPE_C_NAME_filled,
    COUNT(NONCVRED_SERVICE_YN) AS NONCVRED_SERVICE_YN_filled,
    COUNT(REFERRAL_REQ_YN) AS REFERRAL_REQ_YN_filled,
    COUNT(REFERRAL_ID) AS REFERRAL_ID_filled,
    COUNT(ACCOUNT_ID) AS ACCOUNT_ID_filled,
    COUNT(COVERAGE_ID) AS COVERAGE_ID_filled,
    COUNT(CLAIM_ID) AS CLAIM_ID_filled,
    COUNT(PRIMARY_LOC_ID_LOC_NAME) AS PRIMARY_LOC_ID_LOC_NAME_filled,
    COUNT(CHARGE_SLIP_NUMBER) AS CHARGE_SLIP_NUMBER_filled,
    COUNT(COPAY_DUE) AS COPAY_DUE_filled,
    COUNT(UPDATE_DATE) AS UPDATE_DATE_filled,
    COUNT(HSP_ACCOUNT_ID) AS HSP_ACCOUNT_ID_filled,
    COUNT(ADM_FOR_SURG_YN) AS ADM_FOR_SURG_YN_filled,
    COUNT(SURGICAL_SVC_C_NAME) AS SURGICAL_SVC_C_NAME_filled,
    COUNT(INPATIENT_DATA_ID) AS INPATIENT_DATA_ID_filled,
    COUNT(IP_EPISODE_ID) AS IP_EPISODE_ID_filled,
    COUNT(EXTERNAL_VISIT_ID) AS EXTERNAL_VISIT_ID_filled,
    COUNT(CONTACT_COMMENT) AS CONTACT_COMMENT_filled,
    COUNT(OUTGOING_CALL_YN) AS OUTGOING_CALL_YN_filled,
    COUNT(DATA_ENTRY_PERSON) AS DATA_ENTRY_PERSON_filled,
    COUNT(REFERRAL_SOURCE_ID) AS REFERRAL_SOURCE_ID_filled,
    COUNT(REFERRAL_SOURCE_ID_REFERRING_PROV_NAM) AS REFERRAL_SOURCE_ID_REFERRING_PROV_NAM_filled,
    COUNT(WC_TPL_VISIT_C_NAME) AS WC_TPL_VISIT_C_NAME_filled,
    COUNT(CONSENT_TYPE_C_NAME) AS CONSENT_TYPE_C_NAME_filled,
    COUNT(BMI) AS BMI_filled,
    COUNT(BSA) AS BSA_filled,
    COUNT(AVS_PRINT_TM) AS AVS_PRINT_TM_filled,
    COUNT(AVS_FIRST_USER_ID) AS AVS_FIRST_USER_ID_filled,
    COUNT(AVS_FIRST_USER_ID_NAME) AS AVS_FIRST_USER_ID_NAME_filled,
    COUNT(ENC_MED_FRZ_RSN_C_NAME) AS ENC_MED_FRZ_RSN_C_NAME_filled,
    COUNT(EFFECTIVE_DATE_DT) AS EFFECTIVE_DATE_DT_filled,
    COUNT(DISCHARGE_DATE_DT) AS DISCHARGE_DATE_DT_filled,
    COUNT(COPAY_PD_THRU_NAME) AS COPAY_PD_THRU_NAME_filled,
    COUNT(INTERPRETER_NEED_YN) AS INTERPRETER_NEED_YN_filled,
    COUNT(VST_SPECIAL_NEEDS_C_NAME) AS VST_SPECIAL_NEEDS_C_NAME_filled,
    COUNT(BEN_ENG_SP_AMT) AS BEN_ENG_SP_AMT_filled,
    COUNT(BEN_ADJ_COPAY_AMT) AS BEN_ADJ_COPAY_AMT_filled,
    COUNT(BEN_ADJ_METHOD_C_NAME) AS BEN_ADJ_METHOD_C_NAME_filled,
    COUNT(ENC_CREATE_USER_ID) AS ENC_CREATE_USER_ID_filled,
    COUNT(ENC_CREATE_USER_ID_NAME) AS ENC_CREATE_USER_ID_NAME_filled,
    COUNT(ENC_INSTANT) AS ENC_INSTANT_filled,
    COUNT(EFFECTIVE_DATE_DTTM) AS EFFECTIVE_DATE_DTTM_filled,
    COUNT(CALCULATED_ENC_STAT_C_NAME) AS CALCULATED_ENC_STAT_C_NAME_filled,
    CAST(NULL AS NVARCHAR(400)) AS query_error
FROM PAT_ENC
GROUP BY YEAR(CONTACT_DATE);
END TRY
BEGIN CATCH
INSERT INTO #fc_005 (activity_year, total_rows, PAT_ID_filled, PAT_ENC_DATE_REAL_filled, PAT_ENC_CSN_ID_filled, CONTACT_DATE_filled, PCP_PROV_ID_PROV_NAME_filled, FIN_CLASS_C_NAME_filled, VISIT_PROV_ID_PROV_NAME_filled, VISIT_PROV_TITLE_NAME_filled, DEPARTMENT_ID_EXTERNAL_NAME_filled, LMP_DATE_filled, ENC_CLOSED_YN_filled, ENC_CLOSED_USER_ID_filled, ENC_CLOSED_USER_ID_NAME_filled, ENC_CLOSE_DATE_filled, LOS_MODIFIER1_ID_filled, LOS_MODIFIER1_ID_MODIFIER_NAME_filled, LOS_MODIFIER2_ID_filled, LOS_MODIFIER2_ID_MODIFIER_NAME_filled, LOS_MODIFIER3_ID_filled, LOS_MODIFIER3_ID_MODIFIER_NAME_filled, LOS_MODIFIER4_ID_filled, LOS_MODIFIER4_ID_MODIFIER_NAME_filled, APPT_STATUS_C_NAME_filled, APPT_CANC_USER_ID_filled, APPT_CANC_USER_ID_NAME_filled, CHECKIN_USER_ID_filled, CHECKIN_USER_ID_NAME_filled, HOSP_ADMSN_TIME_filled, HOSP_DISCHRG_TIME_filled, HOSP_ADMSN_TYPE_C_NAME_filled, NONCVRED_SERVICE_YN_filled, REFERRAL_REQ_YN_filled, REFERRAL_ID_filled, ACCOUNT_ID_filled, COVERAGE_ID_filled, CLAIM_ID_filled, PRIMARY_LOC_ID_LOC_NAME_filled, CHARGE_SLIP_NUMBER_filled, COPAY_DUE_filled, UPDATE_DATE_filled, HSP_ACCOUNT_ID_filled, ADM_FOR_SURG_YN_filled, SURGICAL_SVC_C_NAME_filled, INPATIENT_DATA_ID_filled, IP_EPISODE_ID_filled, EXTERNAL_VISIT_ID_filled, CONTACT_COMMENT_filled, OUTGOING_CALL_YN_filled, DATA_ENTRY_PERSON_filled, REFERRAL_SOURCE_ID_filled, REFERRAL_SOURCE_ID_REFERRING_PROV_NAM_filled, WC_TPL_VISIT_C_NAME_filled, CONSENT_TYPE_C_NAME_filled, BMI_filled, BSA_filled, AVS_PRINT_TM_filled, AVS_FIRST_USER_ID_filled, AVS_FIRST_USER_ID_NAME_filled, ENC_MED_FRZ_RSN_C_NAME_filled, EFFECTIVE_DATE_DT_filled, DISCHARGE_DATE_DT_filled, COPAY_PD_THRU_NAME_filled, INTERPRETER_NEED_YN_filled, VST_SPECIAL_NEEDS_C_NAME_filled, BEN_ENG_SP_AMT_filled, BEN_ADJ_COPAY_AMT_filled, BEN_ADJ_METHOD_C_NAME_filled, ENC_CREATE_USER_ID_filled, ENC_CREATE_USER_ID_NAME_filled, ENC_INSTANT_filled, EFFECTIVE_DATE_DTTM_filled, CALCULATED_ENC_STAT_C_NAME_filled, query_error)
SELECT
    CAST(NULL AS INT) AS activity_year,
    CAST(NULL AS INT) AS total_rows,
    CAST(NULL AS INT) AS PAT_ID_filled,
    CAST(NULL AS INT) AS PAT_ENC_DATE_REAL_filled,
    CAST(NULL AS INT) AS PAT_ENC_CSN_ID_filled,
    CAST(NULL AS INT) AS CONTACT_DATE_filled,
    CAST(NULL AS INT) AS PCP_PROV_ID_PROV_NAME_filled,
    CAST(NULL AS INT) AS FIN_CLASS_C_NAME_filled,
    CAST(NULL AS INT) AS VISIT_PROV_ID_PROV_NAME_filled,
    CAST(NULL AS INT) AS VISIT_PROV_TITLE_NAME_filled,
    CAST(NULL AS INT) AS DEPARTMENT_ID_EXTERNAL_NAME_filled,
    CAST(NULL AS INT) AS LMP_DATE_filled,
    CAST(NULL AS INT) AS ENC_CLOSED_YN_filled,
    CAST(NULL AS INT) AS ENC_CLOSED_USER_ID_filled,
    CAST(NULL AS INT) AS ENC_CLOSED_USER_ID_NAME_filled,
    CAST(NULL AS INT) AS ENC_CLOSE_DATE_filled,
    CAST(NULL AS INT) AS LOS_MODIFIER1_ID_filled,
    CAST(NULL AS INT) AS LOS_MODIFIER1_ID_MODIFIER_NAME_filled,
    CAST(NULL AS INT) AS LOS_MODIFIER2_ID_filled,
    CAST(NULL AS INT) AS LOS_MODIFIER2_ID_MODIFIER_NAME_filled,
    CAST(NULL AS INT) AS LOS_MODIFIER3_ID_filled,
    CAST(NULL AS INT) AS LOS_MODIFIER3_ID_MODIFIER_NAME_filled,
    CAST(NULL AS INT) AS LOS_MODIFIER4_ID_filled,
    CAST(NULL AS INT) AS LOS_MODIFIER4_ID_MODIFIER_NAME_filled,
    CAST(NULL AS INT) AS APPT_STATUS_C_NAME_filled,
    CAST(NULL AS INT) AS APPT_CANC_USER_ID_filled,
    CAST(NULL AS INT) AS APPT_CANC_USER_ID_NAME_filled,
    CAST(NULL AS INT) AS CHECKIN_USER_ID_filled,
    CAST(NULL AS INT) AS CHECKIN_USER_ID_NAME_filled,
    CAST(NULL AS INT) AS HOSP_ADMSN_TIME_filled,
    CAST(NULL AS INT) AS HOSP_DISCHRG_TIME_filled,
    CAST(NULL AS INT) AS HOSP_ADMSN_TYPE_C_NAME_filled,
    CAST(NULL AS INT) AS NONCVRED_SERVICE_YN_filled,
    CAST(NULL AS INT) AS REFERRAL_REQ_YN_filled,
    CAST(NULL AS INT) AS REFERRAL_ID_filled,
    CAST(NULL AS INT) AS ACCOUNT_ID_filled,
    CAST(NULL AS INT) AS COVERAGE_ID_filled,
    CAST(NULL AS INT) AS CLAIM_ID_filled,
    CAST(NULL AS INT) AS PRIMARY_LOC_ID_LOC_NAME_filled,
    CAST(NULL AS INT) AS CHARGE_SLIP_NUMBER_filled,
    CAST(NULL AS INT) AS COPAY_DUE_filled,
    CAST(NULL AS INT) AS UPDATE_DATE_filled,
    CAST(NULL AS INT) AS HSP_ACCOUNT_ID_filled,
    CAST(NULL AS INT) AS ADM_FOR_SURG_YN_filled,
    CAST(NULL AS INT) AS SURGICAL_SVC_C_NAME_filled,
    CAST(NULL AS INT) AS INPATIENT_DATA_ID_filled,
    CAST(NULL AS INT) AS IP_EPISODE_ID_filled,
    CAST(NULL AS INT) AS EXTERNAL_VISIT_ID_filled,
    CAST(NULL AS INT) AS CONTACT_COMMENT_filled,
    CAST(NULL AS INT) AS OUTGOING_CALL_YN_filled,
    CAST(NULL AS INT) AS DATA_ENTRY_PERSON_filled,
    CAST(NULL AS INT) AS REFERRAL_SOURCE_ID_filled,
    CAST(NULL AS INT) AS REFERRAL_SOURCE_ID_REFERRING_PROV_NAM_filled,
    CAST(NULL AS INT) AS WC_TPL_VISIT_C_NAME_filled,
    CAST(NULL AS INT) AS CONSENT_TYPE_C_NAME_filled,
    CAST(NULL AS INT) AS BMI_filled,
    CAST(NULL AS INT) AS BSA_filled,
    CAST(NULL AS INT) AS AVS_PRINT_TM_filled,
    CAST(NULL AS INT) AS AVS_FIRST_USER_ID_filled,
    CAST(NULL AS INT) AS AVS_FIRST_USER_ID_NAME_filled,
    CAST(NULL AS INT) AS ENC_MED_FRZ_RSN_C_NAME_filled,
    CAST(NULL AS INT) AS EFFECTIVE_DATE_DT_filled,
    CAST(NULL AS INT) AS DISCHARGE_DATE_DT_filled,
    CAST(NULL AS INT) AS COPAY_PD_THRU_NAME_filled,
    CAST(NULL AS INT) AS INTERPRETER_NEED_YN_filled,
    CAST(NULL AS INT) AS VST_SPECIAL_NEEDS_C_NAME_filled,
    CAST(NULL AS INT) AS BEN_ENG_SP_AMT_filled,
    CAST(NULL AS INT) AS BEN_ADJ_COPAY_AMT_filled,
    CAST(NULL AS INT) AS BEN_ADJ_METHOD_C_NAME_filled,
    CAST(NULL AS INT) AS ENC_CREATE_USER_ID_filled,
    CAST(NULL AS INT) AS ENC_CREATE_USER_ID_NAME_filled,
    CAST(NULL AS INT) AS ENC_INSTANT_filled,
    CAST(NULL AS INT) AS EFFECTIVE_DATE_DTTM_filled,
    CAST(NULL AS INT) AS CALCULATED_ENC_STAT_C_NAME_filled,
    CAST(ERROR_MESSAGE() AS NVARCHAR(400)) AS query_error;
END CATCH;

-- ---- fc_006 <- PAT_ENC_2 ----
-- This table supplements the PAT_ENC table. It contains additional information related to patient encounters or appointments.
-- Bucket(s): Encounter / visit record
CREATE TABLE #fc_006 (
    activity_year INT,
    total_rows INT,
    PAT_ENC_CSN_ID_filled INT,
    CONTACT_DATE_filled INT,
    COPAY_COINS_FLAG_filled INT,
    CAN_LET_C_NAME_filled INT,
    SUP_PROV_ID_PROV_NAME_filled INT,
    SUP_PROV_C_NAME_filled INT,
    SUP_PROV_REV_TM_filled INT,
    MEDS_REQUEST_PHR_ID_filled INT,
    MEDS_REQUEST_PHR_ID_PHARMACY_NAME_filled INT,
    MEDS_REQUEST_OP_C_NAME_filled INT,
    PHYS_BP_filled INT,
    VITALS_TAKEN_TM_filled INT,
    PHYS_TEMP_SRC_C_NAME_filled INT,
    PAT_PAIN_SCORE_C_NAME_filled INT,
    PAT_PAIN_LOC_C_NAME_filled INT,
    PAT_PAIN_EDU_YN_filled INT,
    PAT_PAIN_CMT_filled INT,
    PAT_PAIN_SCALE_CAT_filled INT,
    SMOKING_STATUS_C_NAME_filled INT,
    PHYS_SPO2_filled INT,
    SYS_GEN_LOS_ID_PROC_NAME_filled INT,
    DOC_HX_SOURCE_C_NAME_filled INT,
    APPT_LET_C_NAME_filled INT,
    PARENT_ENC_CSN_ID_filled INT,
    SYNC_IP_DATA_C_NAME_filled INT,
    APPTMT_LET_INST_filled INT,
    RESULT_LET_INST_filled INT,
    RESCHED_LET_INST_filled INT,
    FOLLOW_LET_INST_filled INT,
    PHYS_PEAK_FLOW_filled INT,
    ENC_SPEC_C_NAME_filled INT,
    LD_STATUS_YN_filled INT,
    ADT_PAT_CLASS_C_NAME_filled INT,
    OTHER_BLOCK_ID_filled INT,
    OTHER_BLOCK_TYPE_C_NAME_filled INT,
    BILL_NUM_filled INT,
    IP_DOC_CONTACT_CSN_filled INT,
    TEMP_PT_HIS_C_NAME_filled INT,
    PRIMARY_PROCONT_ID_PROV_NAME_filled INT,
    PRIMARY_TEAM_ID_filled INT,
    PRIMARY_TEAM_ID_RECORD_NAME_filled INT,
    MCIR_VACCINE_CODE_C_NAME_filled INT,
    VISIT_POS_ID_LOC_NAME_filled INT,
    NO_INTERP_RSN_C_NAME_filled INT,
    CVG_ADD_DT_filled INT,
    FARM_WORKER_C_NAME_filled INT,
    KIOSK_HH_QUEST_ID_filled INT,
    KIOSK_HH_QUEST_ID_RECORD_NAME_filled INT,
    HSP_ACCT_ADV_DTTM_filled INT,
    VISIT_VERIFIED_YN_filled INT,
    VERIF_VISIT_DT_filled INT,
    VERIF_DATE_INIT_DT_filled INT,
    VERIF_USER_ID_filled INT,
    ENC_LACT_STAT_C_NAME_filled INT,
    PAT_LACT_CMNT_filled INT,
    COSIGNER_USER_ID_filled INT,
    COSIGNER_USER_ID_NAME_filled INT,
    COSIGN_REV_INS_DTTM_filled INT,
    PAR_DICT_COUNTER_filled INT,
    IS_LOS_UPDATE_C_NAME_filled INT,
    FORM_ID_COUNTER_filled INT,
    CONSNT_REV_USER_ID_filled INT,
    CONSNT_REV_USER_ID_NAME_filled INT,
    VISIT_PAYOR_ID_PAYOR_NAME_filled INT,
    VISIT_PLAN_ID_BENEFIT_PLAN_NAME_filled INT,
    SOCIO_SRC_C_NAME_filled INT,
    TEL_ENC_MSG_RGRDING_filled INT,
    MSG_PRIORITY_C_NAME_filled INT,
    RESEARCH_ENC_FLG_C_NAME_filled INT,
    FAM_SPOUSE_NAME_filled INT,
    MSG_CALLER_NAME_filled INT,
    CONSENT_EXP_DATE_filled INT,
    CV_ACC4_PAT_RESP_YN_filled INT,
    FAMILY_MEM_PREFIX_C_NAME_filled INT,
    AVS_REFUSED_DTTM_filled INT,
    AVS_LAST_PRINT_DTTM_filled INT,
    MED_LIST_UPDATE_DTTM_filled INT,
    query_error NVARCHAR(400)
);
BEGIN TRY
INSERT INTO #fc_006 (activity_year, total_rows, PAT_ENC_CSN_ID_filled, CONTACT_DATE_filled, COPAY_COINS_FLAG_filled, CAN_LET_C_NAME_filled, SUP_PROV_ID_PROV_NAME_filled, SUP_PROV_C_NAME_filled, SUP_PROV_REV_TM_filled, MEDS_REQUEST_PHR_ID_filled, MEDS_REQUEST_PHR_ID_PHARMACY_NAME_filled, MEDS_REQUEST_OP_C_NAME_filled, PHYS_BP_filled, VITALS_TAKEN_TM_filled, PHYS_TEMP_SRC_C_NAME_filled, PAT_PAIN_SCORE_C_NAME_filled, PAT_PAIN_LOC_C_NAME_filled, PAT_PAIN_EDU_YN_filled, PAT_PAIN_CMT_filled, PAT_PAIN_SCALE_CAT_filled, SMOKING_STATUS_C_NAME_filled, PHYS_SPO2_filled, SYS_GEN_LOS_ID_PROC_NAME_filled, DOC_HX_SOURCE_C_NAME_filled, APPT_LET_C_NAME_filled, PARENT_ENC_CSN_ID_filled, SYNC_IP_DATA_C_NAME_filled, APPTMT_LET_INST_filled, RESULT_LET_INST_filled, RESCHED_LET_INST_filled, FOLLOW_LET_INST_filled, PHYS_PEAK_FLOW_filled, ENC_SPEC_C_NAME_filled, LD_STATUS_YN_filled, ADT_PAT_CLASS_C_NAME_filled, OTHER_BLOCK_ID_filled, OTHER_BLOCK_TYPE_C_NAME_filled, BILL_NUM_filled, IP_DOC_CONTACT_CSN_filled, TEMP_PT_HIS_C_NAME_filled, PRIMARY_PROCONT_ID_PROV_NAME_filled, PRIMARY_TEAM_ID_filled, PRIMARY_TEAM_ID_RECORD_NAME_filled, MCIR_VACCINE_CODE_C_NAME_filled, VISIT_POS_ID_LOC_NAME_filled, NO_INTERP_RSN_C_NAME_filled, CVG_ADD_DT_filled, FARM_WORKER_C_NAME_filled, KIOSK_HH_QUEST_ID_filled, KIOSK_HH_QUEST_ID_RECORD_NAME_filled, HSP_ACCT_ADV_DTTM_filled, VISIT_VERIFIED_YN_filled, VERIF_VISIT_DT_filled, VERIF_DATE_INIT_DT_filled, VERIF_USER_ID_filled, ENC_LACT_STAT_C_NAME_filled, PAT_LACT_CMNT_filled, COSIGNER_USER_ID_filled, COSIGNER_USER_ID_NAME_filled, COSIGN_REV_INS_DTTM_filled, PAR_DICT_COUNTER_filled, IS_LOS_UPDATE_C_NAME_filled, FORM_ID_COUNTER_filled, CONSNT_REV_USER_ID_filled, CONSNT_REV_USER_ID_NAME_filled, VISIT_PAYOR_ID_PAYOR_NAME_filled, VISIT_PLAN_ID_BENEFIT_PLAN_NAME_filled, SOCIO_SRC_C_NAME_filled, TEL_ENC_MSG_RGRDING_filled, MSG_PRIORITY_C_NAME_filled, RESEARCH_ENC_FLG_C_NAME_filled, FAM_SPOUSE_NAME_filled, MSG_CALLER_NAME_filled, CONSENT_EXP_DATE_filled, CV_ACC4_PAT_RESP_YN_filled, FAMILY_MEM_PREFIX_C_NAME_filled, AVS_REFUSED_DTTM_filled, AVS_LAST_PRINT_DTTM_filled, MED_LIST_UPDATE_DTTM_filled, query_error)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(COPAY_COINS_FLAG) AS COPAY_COINS_FLAG_filled,
    COUNT(CAN_LET_C_NAME) AS CAN_LET_C_NAME_filled,
    COUNT(SUP_PROV_ID_PROV_NAME) AS SUP_PROV_ID_PROV_NAME_filled,
    COUNT(SUP_PROV_C_NAME) AS SUP_PROV_C_NAME_filled,
    COUNT(SUP_PROV_REV_TM) AS SUP_PROV_REV_TM_filled,
    COUNT(MEDS_REQUEST_PHR_ID) AS MEDS_REQUEST_PHR_ID_filled,
    COUNT(MEDS_REQUEST_PHR_ID_PHARMACY_NAME) AS MEDS_REQUEST_PHR_ID_PHARMACY_NAME_filled,
    COUNT(MEDS_REQUEST_OP_C_NAME) AS MEDS_REQUEST_OP_C_NAME_filled,
    COUNT(PHYS_BP) AS PHYS_BP_filled,
    COUNT(VITALS_TAKEN_TM) AS VITALS_TAKEN_TM_filled,
    COUNT(PHYS_TEMP_SRC_C_NAME) AS PHYS_TEMP_SRC_C_NAME_filled,
    COUNT(PAT_PAIN_SCORE_C_NAME) AS PAT_PAIN_SCORE_C_NAME_filled,
    COUNT(PAT_PAIN_LOC_C_NAME) AS PAT_PAIN_LOC_C_NAME_filled,
    COUNT(PAT_PAIN_EDU_YN) AS PAT_PAIN_EDU_YN_filled,
    COUNT(PAT_PAIN_CMT) AS PAT_PAIN_CMT_filled,
    COUNT(PAT_PAIN_SCALE_CAT) AS PAT_PAIN_SCALE_CAT_filled,
    COUNT(SMOKING_STATUS_C_NAME) AS SMOKING_STATUS_C_NAME_filled,
    COUNT(PHYS_SPO2) AS PHYS_SPO2_filled,
    COUNT(SYS_GEN_LOS_ID_PROC_NAME) AS SYS_GEN_LOS_ID_PROC_NAME_filled,
    COUNT(DOC_HX_SOURCE_C_NAME) AS DOC_HX_SOURCE_C_NAME_filled,
    COUNT(APPT_LET_C_NAME) AS APPT_LET_C_NAME_filled,
    COUNT(PARENT_ENC_CSN_ID) AS PARENT_ENC_CSN_ID_filled,
    COUNT(SYNC_IP_DATA_C_NAME) AS SYNC_IP_DATA_C_NAME_filled,
    COUNT(APPTMT_LET_INST) AS APPTMT_LET_INST_filled,
    COUNT(RESULT_LET_INST) AS RESULT_LET_INST_filled,
    COUNT(RESCHED_LET_INST) AS RESCHED_LET_INST_filled,
    COUNT(FOLLOW_LET_INST) AS FOLLOW_LET_INST_filled,
    COUNT(PHYS_PEAK_FLOW) AS PHYS_PEAK_FLOW_filled,
    COUNT(ENC_SPEC_C_NAME) AS ENC_SPEC_C_NAME_filled,
    COUNT(LD_STATUS_YN) AS LD_STATUS_YN_filled,
    COUNT(ADT_PAT_CLASS_C_NAME) AS ADT_PAT_CLASS_C_NAME_filled,
    COUNT(OTHER_BLOCK_ID) AS OTHER_BLOCK_ID_filled,
    COUNT(OTHER_BLOCK_TYPE_C_NAME) AS OTHER_BLOCK_TYPE_C_NAME_filled,
    COUNT(BILL_NUM) AS BILL_NUM_filled,
    COUNT(IP_DOC_CONTACT_CSN) AS IP_DOC_CONTACT_CSN_filled,
    COUNT(TEMP_PT_HIS_C_NAME) AS TEMP_PT_HIS_C_NAME_filled,
    COUNT(PRIMARY_PROCONT_ID_PROV_NAME) AS PRIMARY_PROCONT_ID_PROV_NAME_filled,
    COUNT(PRIMARY_TEAM_ID) AS PRIMARY_TEAM_ID_filled,
    COUNT(PRIMARY_TEAM_ID_RECORD_NAME) AS PRIMARY_TEAM_ID_RECORD_NAME_filled,
    COUNT(MCIR_VACCINE_CODE_C_NAME) AS MCIR_VACCINE_CODE_C_NAME_filled,
    COUNT(VISIT_POS_ID_LOC_NAME) AS VISIT_POS_ID_LOC_NAME_filled,
    COUNT(NO_INTERP_RSN_C_NAME) AS NO_INTERP_RSN_C_NAME_filled,
    COUNT(CVG_ADD_DT) AS CVG_ADD_DT_filled,
    COUNT(FARM_WORKER_C_NAME) AS FARM_WORKER_C_NAME_filled,
    COUNT(KIOSK_HH_QUEST_ID) AS KIOSK_HH_QUEST_ID_filled,
    COUNT(KIOSK_HH_QUEST_ID_RECORD_NAME) AS KIOSK_HH_QUEST_ID_RECORD_NAME_filled,
    COUNT(HSP_ACCT_ADV_DTTM) AS HSP_ACCT_ADV_DTTM_filled,
    COUNT(VISIT_VERIFIED_YN) AS VISIT_VERIFIED_YN_filled,
    COUNT(VERIF_VISIT_DT) AS VERIF_VISIT_DT_filled,
    COUNT(VERIF_DATE_INIT_DT) AS VERIF_DATE_INIT_DT_filled,
    COUNT(VERIF_USER_ID) AS VERIF_USER_ID_filled,
    COUNT(ENC_LACT_STAT_C_NAME) AS ENC_LACT_STAT_C_NAME_filled,
    COUNT(PAT_LACT_CMNT) AS PAT_LACT_CMNT_filled,
    COUNT(COSIGNER_USER_ID) AS COSIGNER_USER_ID_filled,
    COUNT(COSIGNER_USER_ID_NAME) AS COSIGNER_USER_ID_NAME_filled,
    COUNT(COSIGN_REV_INS_DTTM) AS COSIGN_REV_INS_DTTM_filled,
    COUNT(PAR_DICT_COUNTER) AS PAR_DICT_COUNTER_filled,
    COUNT(IS_LOS_UPDATE_C_NAME) AS IS_LOS_UPDATE_C_NAME_filled,
    COUNT(FORM_ID_COUNTER) AS FORM_ID_COUNTER_filled,
    COUNT(CONSNT_REV_USER_ID) AS CONSNT_REV_USER_ID_filled,
    COUNT(CONSNT_REV_USER_ID_NAME) AS CONSNT_REV_USER_ID_NAME_filled,
    COUNT(VISIT_PAYOR_ID_PAYOR_NAME) AS VISIT_PAYOR_ID_PAYOR_NAME_filled,
    COUNT(VISIT_PLAN_ID_BENEFIT_PLAN_NAME) AS VISIT_PLAN_ID_BENEFIT_PLAN_NAME_filled,
    COUNT(SOCIO_SRC_C_NAME) AS SOCIO_SRC_C_NAME_filled,
    COUNT(TEL_ENC_MSG_RGRDING) AS TEL_ENC_MSG_RGRDING_filled,
    COUNT(MSG_PRIORITY_C_NAME) AS MSG_PRIORITY_C_NAME_filled,
    COUNT(RESEARCH_ENC_FLG_C_NAME) AS RESEARCH_ENC_FLG_C_NAME_filled,
    COUNT(FAM_SPOUSE_NAME) AS FAM_SPOUSE_NAME_filled,
    COUNT(MSG_CALLER_NAME) AS MSG_CALLER_NAME_filled,
    COUNT(CONSENT_EXP_DATE) AS CONSENT_EXP_DATE_filled,
    COUNT(CV_ACC4_PAT_RESP_YN) AS CV_ACC4_PAT_RESP_YN_filled,
    COUNT(FAMILY_MEM_PREFIX_C_NAME) AS FAMILY_MEM_PREFIX_C_NAME_filled,
    COUNT(AVS_REFUSED_DTTM) AS AVS_REFUSED_DTTM_filled,
    COUNT(AVS_LAST_PRINT_DTTM) AS AVS_LAST_PRINT_DTTM_filled,
    COUNT(MED_LIST_UPDATE_DTTM) AS MED_LIST_UPDATE_DTTM_filled,
    CAST(NULL AS NVARCHAR(400)) AS query_error
FROM PAT_ENC_2
GROUP BY YEAR(CONTACT_DATE);
END TRY
BEGIN CATCH
INSERT INTO #fc_006 (activity_year, total_rows, PAT_ENC_CSN_ID_filled, CONTACT_DATE_filled, COPAY_COINS_FLAG_filled, CAN_LET_C_NAME_filled, SUP_PROV_ID_PROV_NAME_filled, SUP_PROV_C_NAME_filled, SUP_PROV_REV_TM_filled, MEDS_REQUEST_PHR_ID_filled, MEDS_REQUEST_PHR_ID_PHARMACY_NAME_filled, MEDS_REQUEST_OP_C_NAME_filled, PHYS_BP_filled, VITALS_TAKEN_TM_filled, PHYS_TEMP_SRC_C_NAME_filled, PAT_PAIN_SCORE_C_NAME_filled, PAT_PAIN_LOC_C_NAME_filled, PAT_PAIN_EDU_YN_filled, PAT_PAIN_CMT_filled, PAT_PAIN_SCALE_CAT_filled, SMOKING_STATUS_C_NAME_filled, PHYS_SPO2_filled, SYS_GEN_LOS_ID_PROC_NAME_filled, DOC_HX_SOURCE_C_NAME_filled, APPT_LET_C_NAME_filled, PARENT_ENC_CSN_ID_filled, SYNC_IP_DATA_C_NAME_filled, APPTMT_LET_INST_filled, RESULT_LET_INST_filled, RESCHED_LET_INST_filled, FOLLOW_LET_INST_filled, PHYS_PEAK_FLOW_filled, ENC_SPEC_C_NAME_filled, LD_STATUS_YN_filled, ADT_PAT_CLASS_C_NAME_filled, OTHER_BLOCK_ID_filled, OTHER_BLOCK_TYPE_C_NAME_filled, BILL_NUM_filled, IP_DOC_CONTACT_CSN_filled, TEMP_PT_HIS_C_NAME_filled, PRIMARY_PROCONT_ID_PROV_NAME_filled, PRIMARY_TEAM_ID_filled, PRIMARY_TEAM_ID_RECORD_NAME_filled, MCIR_VACCINE_CODE_C_NAME_filled, VISIT_POS_ID_LOC_NAME_filled, NO_INTERP_RSN_C_NAME_filled, CVG_ADD_DT_filled, FARM_WORKER_C_NAME_filled, KIOSK_HH_QUEST_ID_filled, KIOSK_HH_QUEST_ID_RECORD_NAME_filled, HSP_ACCT_ADV_DTTM_filled, VISIT_VERIFIED_YN_filled, VERIF_VISIT_DT_filled, VERIF_DATE_INIT_DT_filled, VERIF_USER_ID_filled, ENC_LACT_STAT_C_NAME_filled, PAT_LACT_CMNT_filled, COSIGNER_USER_ID_filled, COSIGNER_USER_ID_NAME_filled, COSIGN_REV_INS_DTTM_filled, PAR_DICT_COUNTER_filled, IS_LOS_UPDATE_C_NAME_filled, FORM_ID_COUNTER_filled, CONSNT_REV_USER_ID_filled, CONSNT_REV_USER_ID_NAME_filled, VISIT_PAYOR_ID_PAYOR_NAME_filled, VISIT_PLAN_ID_BENEFIT_PLAN_NAME_filled, SOCIO_SRC_C_NAME_filled, TEL_ENC_MSG_RGRDING_filled, MSG_PRIORITY_C_NAME_filled, RESEARCH_ENC_FLG_C_NAME_filled, FAM_SPOUSE_NAME_filled, MSG_CALLER_NAME_filled, CONSENT_EXP_DATE_filled, CV_ACC4_PAT_RESP_YN_filled, FAMILY_MEM_PREFIX_C_NAME_filled, AVS_REFUSED_DTTM_filled, AVS_LAST_PRINT_DTTM_filled, MED_LIST_UPDATE_DTTM_filled, query_error)
SELECT
    CAST(NULL AS INT) AS activity_year,
    CAST(NULL AS INT) AS total_rows,
    CAST(NULL AS INT) AS PAT_ENC_CSN_ID_filled,
    CAST(NULL AS INT) AS CONTACT_DATE_filled,
    CAST(NULL AS INT) AS COPAY_COINS_FLAG_filled,
    CAST(NULL AS INT) AS CAN_LET_C_NAME_filled,
    CAST(NULL AS INT) AS SUP_PROV_ID_PROV_NAME_filled,
    CAST(NULL AS INT) AS SUP_PROV_C_NAME_filled,
    CAST(NULL AS INT) AS SUP_PROV_REV_TM_filled,
    CAST(NULL AS INT) AS MEDS_REQUEST_PHR_ID_filled,
    CAST(NULL AS INT) AS MEDS_REQUEST_PHR_ID_PHARMACY_NAME_filled,
    CAST(NULL AS INT) AS MEDS_REQUEST_OP_C_NAME_filled,
    CAST(NULL AS INT) AS PHYS_BP_filled,
    CAST(NULL AS INT) AS VITALS_TAKEN_TM_filled,
    CAST(NULL AS INT) AS PHYS_TEMP_SRC_C_NAME_filled,
    CAST(NULL AS INT) AS PAT_PAIN_SCORE_C_NAME_filled,
    CAST(NULL AS INT) AS PAT_PAIN_LOC_C_NAME_filled,
    CAST(NULL AS INT) AS PAT_PAIN_EDU_YN_filled,
    CAST(NULL AS INT) AS PAT_PAIN_CMT_filled,
    CAST(NULL AS INT) AS PAT_PAIN_SCALE_CAT_filled,
    CAST(NULL AS INT) AS SMOKING_STATUS_C_NAME_filled,
    CAST(NULL AS INT) AS PHYS_SPO2_filled,
    CAST(NULL AS INT) AS SYS_GEN_LOS_ID_PROC_NAME_filled,
    CAST(NULL AS INT) AS DOC_HX_SOURCE_C_NAME_filled,
    CAST(NULL AS INT) AS APPT_LET_C_NAME_filled,
    CAST(NULL AS INT) AS PARENT_ENC_CSN_ID_filled,
    CAST(NULL AS INT) AS SYNC_IP_DATA_C_NAME_filled,
    CAST(NULL AS INT) AS APPTMT_LET_INST_filled,
    CAST(NULL AS INT) AS RESULT_LET_INST_filled,
    CAST(NULL AS INT) AS RESCHED_LET_INST_filled,
    CAST(NULL AS INT) AS FOLLOW_LET_INST_filled,
    CAST(NULL AS INT) AS PHYS_PEAK_FLOW_filled,
    CAST(NULL AS INT) AS ENC_SPEC_C_NAME_filled,
    CAST(NULL AS INT) AS LD_STATUS_YN_filled,
    CAST(NULL AS INT) AS ADT_PAT_CLASS_C_NAME_filled,
    CAST(NULL AS INT) AS OTHER_BLOCK_ID_filled,
    CAST(NULL AS INT) AS OTHER_BLOCK_TYPE_C_NAME_filled,
    CAST(NULL AS INT) AS BILL_NUM_filled,
    CAST(NULL AS INT) AS IP_DOC_CONTACT_CSN_filled,
    CAST(NULL AS INT) AS TEMP_PT_HIS_C_NAME_filled,
    CAST(NULL AS INT) AS PRIMARY_PROCONT_ID_PROV_NAME_filled,
    CAST(NULL AS INT) AS PRIMARY_TEAM_ID_filled,
    CAST(NULL AS INT) AS PRIMARY_TEAM_ID_RECORD_NAME_filled,
    CAST(NULL AS INT) AS MCIR_VACCINE_CODE_C_NAME_filled,
    CAST(NULL AS INT) AS VISIT_POS_ID_LOC_NAME_filled,
    CAST(NULL AS INT) AS NO_INTERP_RSN_C_NAME_filled,
    CAST(NULL AS INT) AS CVG_ADD_DT_filled,
    CAST(NULL AS INT) AS FARM_WORKER_C_NAME_filled,
    CAST(NULL AS INT) AS KIOSK_HH_QUEST_ID_filled,
    CAST(NULL AS INT) AS KIOSK_HH_QUEST_ID_RECORD_NAME_filled,
    CAST(NULL AS INT) AS HSP_ACCT_ADV_DTTM_filled,
    CAST(NULL AS INT) AS VISIT_VERIFIED_YN_filled,
    CAST(NULL AS INT) AS VERIF_VISIT_DT_filled,
    CAST(NULL AS INT) AS VERIF_DATE_INIT_DT_filled,
    CAST(NULL AS INT) AS VERIF_USER_ID_filled,
    CAST(NULL AS INT) AS ENC_LACT_STAT_C_NAME_filled,
    CAST(NULL AS INT) AS PAT_LACT_CMNT_filled,
    CAST(NULL AS INT) AS COSIGNER_USER_ID_filled,
    CAST(NULL AS INT) AS COSIGNER_USER_ID_NAME_filled,
    CAST(NULL AS INT) AS COSIGN_REV_INS_DTTM_filled,
    CAST(NULL AS INT) AS PAR_DICT_COUNTER_filled,
    CAST(NULL AS INT) AS IS_LOS_UPDATE_C_NAME_filled,
    CAST(NULL AS INT) AS FORM_ID_COUNTER_filled,
    CAST(NULL AS INT) AS CONSNT_REV_USER_ID_filled,
    CAST(NULL AS INT) AS CONSNT_REV_USER_ID_NAME_filled,
    CAST(NULL AS INT) AS VISIT_PAYOR_ID_PAYOR_NAME_filled,
    CAST(NULL AS INT) AS VISIT_PLAN_ID_BENEFIT_PLAN_NAME_filled,
    CAST(NULL AS INT) AS SOCIO_SRC_C_NAME_filled,
    CAST(NULL AS INT) AS TEL_ENC_MSG_RGRDING_filled,
    CAST(NULL AS INT) AS MSG_PRIORITY_C_NAME_filled,
    CAST(NULL AS INT) AS RESEARCH_ENC_FLG_C_NAME_filled,
    CAST(NULL AS INT) AS FAM_SPOUSE_NAME_filled,
    CAST(NULL AS INT) AS MSG_CALLER_NAME_filled,
    CAST(NULL AS INT) AS CONSENT_EXP_DATE_filled,
    CAST(NULL AS INT) AS CV_ACC4_PAT_RESP_YN_filled,
    CAST(NULL AS INT) AS FAMILY_MEM_PREFIX_C_NAME_filled,
    CAST(NULL AS INT) AS AVS_REFUSED_DTTM_filled,
    CAST(NULL AS INT) AS AVS_LAST_PRINT_DTTM_filled,
    CAST(NULL AS INT) AS MED_LIST_UPDATE_DTTM_filled,
    CAST(ERROR_MESSAGE() AS NVARCHAR(400)) AS query_error;
END CATCH;

-- ---- fc_007 <- PAT_ENC_3 ----
-- This table supplements the PAT_ENC and PAT_ENC_2 tables. It contains additional information related to patient encounters or appointments.
-- Bucket(s): Encounter / visit record
CREATE TABLE #fc_007 (
    activity_year INT,
    total_rows INT,
    PAT_ENC_CSN_filled INT,
    PAT_ENC_DATE_REAL_filled INT,
    CHKOUT_USER_ID_filled INT,
    CHKOUT_USER_ID_NAME_filled INT,
    ENC_BILL_AREA_ID_filled INT,
    ENC_BILL_AREA_ID_BILL_AREA_NAME_filled INT,
    RX_CHG_ADMIT_FLG_C_NAME_filled INT,
    DX_UNIQUE_COUNTER_filled INT,
    HP_DEFAULTED_YN_filled INT,
    IP_CP_LAST_VAR_DTTM_filled INT,
    READY_QUT_SMOKING_C_NAME_filled INT,
    COUNSELING_GIVEN_C_NAME_filled INT,
    COMMAUTO_SENDER_ID_filled INT,
    COMMAUTO_SENDER_ID_NAME_filled INT,
    BENEFIT_ID_filled INT,
    PREPAY_DUE_AMT_filled INT,
    PREPAY_AMT_FROM_C_NAME_filled INT,
    PREPAY_PAID_AMT_filled INT,
    PREADMSN_TESTING_DT_filled INT,
    SMK_CESS_USER_ID_filled INT,
    SMK_CESS_USER_ID_NAME_filled INT,
    SMK_CESS_DTTM_filled INT,
    DO_NOT_BILL_INS_YN_filled INT,
    SELF_PAY_VISIT_YN_filled INT,
    REFERRAL_TYPE_C_NAME_filled INT,
    SCHOOL_filled INT,
    COPAY_NUM_UNITS_filled INT,
    COPAY_AMT_PER_UNIT_filled INT,
    COPAY_LASTCALC_DT_filled INT,
    COPAY_OVERRIDDEN_YN_filled INT,
    OB_TOTAL_WT_GAIN_filled INT,
    MEDICAID_GROUP_NAME_filled INT,
    STUDENT_STATUS_C_NAME_filled INT,
    MEDICAID_GROUP_ID_filled INT,
    EXTERNAL_REF_ID_filled INT,
    OUTCOME_C_NAME_filled INT,
    HSPC_NO_ADM_C_NAME_filled INT,
    query_error NVARCHAR(400)
);
BEGIN TRY
INSERT INTO #fc_007 (activity_year, total_rows, PAT_ENC_CSN_filled, PAT_ENC_DATE_REAL_filled, CHKOUT_USER_ID_filled, CHKOUT_USER_ID_NAME_filled, ENC_BILL_AREA_ID_filled, ENC_BILL_AREA_ID_BILL_AREA_NAME_filled, RX_CHG_ADMIT_FLG_C_NAME_filled, DX_UNIQUE_COUNTER_filled, HP_DEFAULTED_YN_filled, IP_CP_LAST_VAR_DTTM_filled, READY_QUT_SMOKING_C_NAME_filled, COUNSELING_GIVEN_C_NAME_filled, COMMAUTO_SENDER_ID_filled, COMMAUTO_SENDER_ID_NAME_filled, BENEFIT_ID_filled, PREPAY_DUE_AMT_filled, PREPAY_AMT_FROM_C_NAME_filled, PREPAY_PAID_AMT_filled, PREADMSN_TESTING_DT_filled, SMK_CESS_USER_ID_filled, SMK_CESS_USER_ID_NAME_filled, SMK_CESS_DTTM_filled, DO_NOT_BILL_INS_YN_filled, SELF_PAY_VISIT_YN_filled, REFERRAL_TYPE_C_NAME_filled, SCHOOL_filled, COPAY_NUM_UNITS_filled, COPAY_AMT_PER_UNIT_filled, COPAY_LASTCALC_DT_filled, COPAY_OVERRIDDEN_YN_filled, OB_TOTAL_WT_GAIN_filled, MEDICAID_GROUP_NAME_filled, STUDENT_STATUS_C_NAME_filled, MEDICAID_GROUP_ID_filled, EXTERNAL_REF_ID_filled, OUTCOME_C_NAME_filled, HSPC_NO_ADM_C_NAME_filled, query_error)
SELECT
    YEAR(PREADMSN_TESTING_DT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(PAT_ENC_CSN) AS PAT_ENC_CSN_filled,
    COUNT(PAT_ENC_DATE_REAL) AS PAT_ENC_DATE_REAL_filled,
    COUNT(CHKOUT_USER_ID) AS CHKOUT_USER_ID_filled,
    COUNT(CHKOUT_USER_ID_NAME) AS CHKOUT_USER_ID_NAME_filled,
    COUNT(ENC_BILL_AREA_ID) AS ENC_BILL_AREA_ID_filled,
    COUNT(ENC_BILL_AREA_ID_BILL_AREA_NAME) AS ENC_BILL_AREA_ID_BILL_AREA_NAME_filled,
    COUNT(RX_CHG_ADMIT_FLG_C_NAME) AS RX_CHG_ADMIT_FLG_C_NAME_filled,
    COUNT(DX_UNIQUE_COUNTER) AS DX_UNIQUE_COUNTER_filled,
    COUNT(HP_DEFAULTED_YN) AS HP_DEFAULTED_YN_filled,
    COUNT(IP_CP_LAST_VAR_DTTM) AS IP_CP_LAST_VAR_DTTM_filled,
    COUNT(READY_QUT_SMOKING_C_NAME) AS READY_QUT_SMOKING_C_NAME_filled,
    COUNT(COUNSELING_GIVEN_C_NAME) AS COUNSELING_GIVEN_C_NAME_filled,
    COUNT(COMMAUTO_SENDER_ID) AS COMMAUTO_SENDER_ID_filled,
    COUNT(COMMAUTO_SENDER_ID_NAME) AS COMMAUTO_SENDER_ID_NAME_filled,
    COUNT(BENEFIT_ID) AS BENEFIT_ID_filled,
    COUNT(PREPAY_DUE_AMT) AS PREPAY_DUE_AMT_filled,
    COUNT(PREPAY_AMT_FROM_C_NAME) AS PREPAY_AMT_FROM_C_NAME_filled,
    COUNT(PREPAY_PAID_AMT) AS PREPAY_PAID_AMT_filled,
    COUNT(PREADMSN_TESTING_DT) AS PREADMSN_TESTING_DT_filled,
    COUNT(SMK_CESS_USER_ID) AS SMK_CESS_USER_ID_filled,
    COUNT(SMK_CESS_USER_ID_NAME) AS SMK_CESS_USER_ID_NAME_filled,
    COUNT(SMK_CESS_DTTM) AS SMK_CESS_DTTM_filled,
    COUNT(DO_NOT_BILL_INS_YN) AS DO_NOT_BILL_INS_YN_filled,
    COUNT(SELF_PAY_VISIT_YN) AS SELF_PAY_VISIT_YN_filled,
    COUNT(REFERRAL_TYPE_C_NAME) AS REFERRAL_TYPE_C_NAME_filled,
    COUNT(SCHOOL) AS SCHOOL_filled,
    COUNT(COPAY_NUM_UNITS) AS COPAY_NUM_UNITS_filled,
    COUNT(COPAY_AMT_PER_UNIT) AS COPAY_AMT_PER_UNIT_filled,
    COUNT(COPAY_LASTCALC_DT) AS COPAY_LASTCALC_DT_filled,
    COUNT(COPAY_OVERRIDDEN_YN) AS COPAY_OVERRIDDEN_YN_filled,
    COUNT(OB_TOTAL_WT_GAIN) AS OB_TOTAL_WT_GAIN_filled,
    COUNT(MEDICAID_GROUP_NAME) AS MEDICAID_GROUP_NAME_filled,
    COUNT(STUDENT_STATUS_C_NAME) AS STUDENT_STATUS_C_NAME_filled,
    COUNT(MEDICAID_GROUP_ID) AS MEDICAID_GROUP_ID_filled,
    COUNT(EXTERNAL_REF_ID) AS EXTERNAL_REF_ID_filled,
    COUNT(OUTCOME_C_NAME) AS OUTCOME_C_NAME_filled,
    COUNT(HSPC_NO_ADM_C_NAME) AS HSPC_NO_ADM_C_NAME_filled,
    CAST(NULL AS NVARCHAR(400)) AS query_error
FROM PAT_ENC_3
GROUP BY YEAR(PREADMSN_TESTING_DT);
END TRY
BEGIN CATCH
INSERT INTO #fc_007 (activity_year, total_rows, PAT_ENC_CSN_filled, PAT_ENC_DATE_REAL_filled, CHKOUT_USER_ID_filled, CHKOUT_USER_ID_NAME_filled, ENC_BILL_AREA_ID_filled, ENC_BILL_AREA_ID_BILL_AREA_NAME_filled, RX_CHG_ADMIT_FLG_C_NAME_filled, DX_UNIQUE_COUNTER_filled, HP_DEFAULTED_YN_filled, IP_CP_LAST_VAR_DTTM_filled, READY_QUT_SMOKING_C_NAME_filled, COUNSELING_GIVEN_C_NAME_filled, COMMAUTO_SENDER_ID_filled, COMMAUTO_SENDER_ID_NAME_filled, BENEFIT_ID_filled, PREPAY_DUE_AMT_filled, PREPAY_AMT_FROM_C_NAME_filled, PREPAY_PAID_AMT_filled, PREADMSN_TESTING_DT_filled, SMK_CESS_USER_ID_filled, SMK_CESS_USER_ID_NAME_filled, SMK_CESS_DTTM_filled, DO_NOT_BILL_INS_YN_filled, SELF_PAY_VISIT_YN_filled, REFERRAL_TYPE_C_NAME_filled, SCHOOL_filled, COPAY_NUM_UNITS_filled, COPAY_AMT_PER_UNIT_filled, COPAY_LASTCALC_DT_filled, COPAY_OVERRIDDEN_YN_filled, OB_TOTAL_WT_GAIN_filled, MEDICAID_GROUP_NAME_filled, STUDENT_STATUS_C_NAME_filled, MEDICAID_GROUP_ID_filled, EXTERNAL_REF_ID_filled, OUTCOME_C_NAME_filled, HSPC_NO_ADM_C_NAME_filled, query_error)
SELECT
    CAST(NULL AS INT) AS activity_year,
    CAST(NULL AS INT) AS total_rows,
    CAST(NULL AS INT) AS PAT_ENC_CSN_filled,
    CAST(NULL AS INT) AS PAT_ENC_DATE_REAL_filled,
    CAST(NULL AS INT) AS CHKOUT_USER_ID_filled,
    CAST(NULL AS INT) AS CHKOUT_USER_ID_NAME_filled,
    CAST(NULL AS INT) AS ENC_BILL_AREA_ID_filled,
    CAST(NULL AS INT) AS ENC_BILL_AREA_ID_BILL_AREA_NAME_filled,
    CAST(NULL AS INT) AS RX_CHG_ADMIT_FLG_C_NAME_filled,
    CAST(NULL AS INT) AS DX_UNIQUE_COUNTER_filled,
    CAST(NULL AS INT) AS HP_DEFAULTED_YN_filled,
    CAST(NULL AS INT) AS IP_CP_LAST_VAR_DTTM_filled,
    CAST(NULL AS INT) AS READY_QUT_SMOKING_C_NAME_filled,
    CAST(NULL AS INT) AS COUNSELING_GIVEN_C_NAME_filled,
    CAST(NULL AS INT) AS COMMAUTO_SENDER_ID_filled,
    CAST(NULL AS INT) AS COMMAUTO_SENDER_ID_NAME_filled,
    CAST(NULL AS INT) AS BENEFIT_ID_filled,
    CAST(NULL AS INT) AS PREPAY_DUE_AMT_filled,
    CAST(NULL AS INT) AS PREPAY_AMT_FROM_C_NAME_filled,
    CAST(NULL AS INT) AS PREPAY_PAID_AMT_filled,
    CAST(NULL AS INT) AS PREADMSN_TESTING_DT_filled,
    CAST(NULL AS INT) AS SMK_CESS_USER_ID_filled,
    CAST(NULL AS INT) AS SMK_CESS_USER_ID_NAME_filled,
    CAST(NULL AS INT) AS SMK_CESS_DTTM_filled,
    CAST(NULL AS INT) AS DO_NOT_BILL_INS_YN_filled,
    CAST(NULL AS INT) AS SELF_PAY_VISIT_YN_filled,
    CAST(NULL AS INT) AS REFERRAL_TYPE_C_NAME_filled,
    CAST(NULL AS INT) AS SCHOOL_filled,
    CAST(NULL AS INT) AS COPAY_NUM_UNITS_filled,
    CAST(NULL AS INT) AS COPAY_AMT_PER_UNIT_filled,
    CAST(NULL AS INT) AS COPAY_LASTCALC_DT_filled,
    CAST(NULL AS INT) AS COPAY_OVERRIDDEN_YN_filled,
    CAST(NULL AS INT) AS OB_TOTAL_WT_GAIN_filled,
    CAST(NULL AS INT) AS MEDICAID_GROUP_NAME_filled,
    CAST(NULL AS INT) AS STUDENT_STATUS_C_NAME_filled,
    CAST(NULL AS INT) AS MEDICAID_GROUP_ID_filled,
    CAST(NULL AS INT) AS EXTERNAL_REF_ID_filled,
    CAST(NULL AS INT) AS OUTCOME_C_NAME_filled,
    CAST(NULL AS INT) AS HSPC_NO_ADM_C_NAME_filled,
    CAST(ERROR_MESSAGE() AS NVARCHAR(400)) AS query_error;
END CATCH;

-- ---- fc_008 <- PAT_ENC_4 ----
-- This table supplements the PAT_ENC, PAT_ENC_2, and PAT_ENC_3 tables. It contains additional information related to patient encounters or appointments.
-- Bucket(s): Encounter / visit record
CREATE TABLE #fc_008 (
    activity_year INT,
    total_rows INT,
    PAT_ENC_CSN_ID_filled INT,
    FAMILY_SIZE_filled INT,
    VISIT_NUMBER_filled INT,
    PAT_CNCT_IND_C_NAME_filled INT,
    DENTAL_STUDENT_ID_PROV_NAME_filled INT,
    LOC_VISIT_ID_LOC_NAME_filled INT,
    COPAY_NOT_COVERED_C_NAME_filled INT,
    COPAY_COLL_FLAG_YN_filled INT,
    COPAY_COLL_PERSON_filled INT,
    COPAY_WAIVE_RSN_C_NAME_filled INT,
    COPAY_MIN_VALUE_filled INT,
    COPAY_RECEIPT_NUM_filled INT,
    BEN_ADJ_COINS_AMT_filled INT,
    BEN_ADJ_DEDUCT_AMT_filled INT,
    PAT_HOMELESS_YN_filled INT,
    PAT_HOMELESS_TYP_C_NAME_filled INT,
    PERCENTAGE_OF_FPL_filled INT,
    MSG_RECEIVED_DTTM_filled INT,
    TOBACCO_USE_VRFY_YN_filled INT,
    CR_TX_TYPE_C_NAME_filled INT,
    ORIG_ENC_CSN_filled INT,
    PHYS_BP_COMMENTS_filled INT,
    PHYS_TEMP_COMMENTS_filled INT,
    PHYS_TEMPSRC_COMNTS_filled INT,
    PHYS_PULSE_COMMENTS_filled INT,
    PHYS_WEIGHT_COMNTS_filled INT,
    PHYS_HEIGHT_COMNTS_filled INT,
    PHYS_RESP_COMMENTS_filled INT,
    PHYS_SPO2_COMMENTS_filled INT,
    PHYS_PF_COMMENTS_filled INT,
    INTERPRT_ASGN_CMT_filled INT,
    PAT_HOUSING_STAT_C_NAME_filled INT,
    BCRA_AGE_filled INT,
    BCRA_MENARCHE_AGE_C_NAME_filled INT,
    BCRA_FST_LIVBIRTH_C_NAME_filled INT,
    BCRA_FST_DEG_REL_C_NAME_filled INT,
    BCRA_NUM_BIOPSY_C_NAME_filled INT,
    BCRA_ATYP_HYPLSA_C_NAME_filled INT,
    BCRA_RACE_C_NAME_filled INT,
    LB_ENC_START_DT_filled INT,
    LB_ENC_END_DT_filled INT,
    WAITING_LIST_ID_filled INT,
    SUBMITTER_ID_filled INT,
    SUBMITTER_ID_RECORD_NAME_filled INT,
    BILL_TO_SUBMITTER_C_NAME_filled INT,
    SUBMITTER_ACCT_ID_filled INT,
    LB_BLNG_ENC_SRVC_DT_filled INT,
    ECHKIN_STATUS_C_NAME_filled INT,
    PB_VISIT_HAR_ID_filled INT,
    TECHNICAL_REFERRAL_ID_filled INT,
    CR_CLIENT_REF_IDNT_filled INT,
    CR_BENEFIT_REF_IDNT_filled INT,
    CR_MESSAGE_ENGLISH_filled INT,
    CR_MESSAGE_SPANISH_filled INT,
    CR_QUERY_SENT_UTC_DTTM_filled INT,
    CR_RESP_RECVD_UTC_DTTM_filled INT,
    CR_QUERY_ERROR_filled INT,
    COPAY_REDUCTION_AMT_filled INT,
    query_error NVARCHAR(400)
);
BEGIN TRY
INSERT INTO #fc_008 (activity_year, total_rows, PAT_ENC_CSN_ID_filled, FAMILY_SIZE_filled, VISIT_NUMBER_filled, PAT_CNCT_IND_C_NAME_filled, DENTAL_STUDENT_ID_PROV_NAME_filled, LOC_VISIT_ID_LOC_NAME_filled, COPAY_NOT_COVERED_C_NAME_filled, COPAY_COLL_FLAG_YN_filled, COPAY_COLL_PERSON_filled, COPAY_WAIVE_RSN_C_NAME_filled, COPAY_MIN_VALUE_filled, COPAY_RECEIPT_NUM_filled, BEN_ADJ_COINS_AMT_filled, BEN_ADJ_DEDUCT_AMT_filled, PAT_HOMELESS_YN_filled, PAT_HOMELESS_TYP_C_NAME_filled, PERCENTAGE_OF_FPL_filled, MSG_RECEIVED_DTTM_filled, TOBACCO_USE_VRFY_YN_filled, CR_TX_TYPE_C_NAME_filled, ORIG_ENC_CSN_filled, PHYS_BP_COMMENTS_filled, PHYS_TEMP_COMMENTS_filled, PHYS_TEMPSRC_COMNTS_filled, PHYS_PULSE_COMMENTS_filled, PHYS_WEIGHT_COMNTS_filled, PHYS_HEIGHT_COMNTS_filled, PHYS_RESP_COMMENTS_filled, PHYS_SPO2_COMMENTS_filled, PHYS_PF_COMMENTS_filled, INTERPRT_ASGN_CMT_filled, PAT_HOUSING_STAT_C_NAME_filled, BCRA_AGE_filled, BCRA_MENARCHE_AGE_C_NAME_filled, BCRA_FST_LIVBIRTH_C_NAME_filled, BCRA_FST_DEG_REL_C_NAME_filled, BCRA_NUM_BIOPSY_C_NAME_filled, BCRA_ATYP_HYPLSA_C_NAME_filled, BCRA_RACE_C_NAME_filled, LB_ENC_START_DT_filled, LB_ENC_END_DT_filled, WAITING_LIST_ID_filled, SUBMITTER_ID_filled, SUBMITTER_ID_RECORD_NAME_filled, BILL_TO_SUBMITTER_C_NAME_filled, SUBMITTER_ACCT_ID_filled, LB_BLNG_ENC_SRVC_DT_filled, ECHKIN_STATUS_C_NAME_filled, PB_VISIT_HAR_ID_filled, TECHNICAL_REFERRAL_ID_filled, CR_CLIENT_REF_IDNT_filled, CR_BENEFIT_REF_IDNT_filled, CR_MESSAGE_ENGLISH_filled, CR_MESSAGE_SPANISH_filled, CR_QUERY_SENT_UTC_DTTM_filled, CR_RESP_RECVD_UTC_DTTM_filled, CR_QUERY_ERROR_filled, COPAY_REDUCTION_AMT_filled, query_error)
SELECT
    YEAR(LB_ENC_START_DT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(FAMILY_SIZE) AS FAMILY_SIZE_filled,
    COUNT(VISIT_NUMBER) AS VISIT_NUMBER_filled,
    COUNT(PAT_CNCT_IND_C_NAME) AS PAT_CNCT_IND_C_NAME_filled,
    COUNT(DENTAL_STUDENT_ID_PROV_NAME) AS DENTAL_STUDENT_ID_PROV_NAME_filled,
    COUNT(LOC_VISIT_ID_LOC_NAME) AS LOC_VISIT_ID_LOC_NAME_filled,
    COUNT(COPAY_NOT_COVERED_C_NAME) AS COPAY_NOT_COVERED_C_NAME_filled,
    COUNT(COPAY_COLL_FLAG_YN) AS COPAY_COLL_FLAG_YN_filled,
    COUNT(COPAY_COLL_PERSON) AS COPAY_COLL_PERSON_filled,
    COUNT(COPAY_WAIVE_RSN_C_NAME) AS COPAY_WAIVE_RSN_C_NAME_filled,
    COUNT(COPAY_MIN_VALUE) AS COPAY_MIN_VALUE_filled,
    COUNT(COPAY_RECEIPT_NUM) AS COPAY_RECEIPT_NUM_filled,
    COUNT(BEN_ADJ_COINS_AMT) AS BEN_ADJ_COINS_AMT_filled,
    COUNT(BEN_ADJ_DEDUCT_AMT) AS BEN_ADJ_DEDUCT_AMT_filled,
    COUNT(PAT_HOMELESS_YN) AS PAT_HOMELESS_YN_filled,
    COUNT(PAT_HOMELESS_TYP_C_NAME) AS PAT_HOMELESS_TYP_C_NAME_filled,
    COUNT(PERCENTAGE_OF_FPL) AS PERCENTAGE_OF_FPL_filled,
    COUNT(MSG_RECEIVED_DTTM) AS MSG_RECEIVED_DTTM_filled,
    COUNT(TOBACCO_USE_VRFY_YN) AS TOBACCO_USE_VRFY_YN_filled,
    COUNT(CR_TX_TYPE_C_NAME) AS CR_TX_TYPE_C_NAME_filled,
    COUNT(ORIG_ENC_CSN) AS ORIG_ENC_CSN_filled,
    COUNT(PHYS_BP_COMMENTS) AS PHYS_BP_COMMENTS_filled,
    COUNT(PHYS_TEMP_COMMENTS) AS PHYS_TEMP_COMMENTS_filled,
    COUNT(PHYS_TEMPSRC_COMNTS) AS PHYS_TEMPSRC_COMNTS_filled,
    COUNT(PHYS_PULSE_COMMENTS) AS PHYS_PULSE_COMMENTS_filled,
    COUNT(PHYS_WEIGHT_COMNTS) AS PHYS_WEIGHT_COMNTS_filled,
    COUNT(PHYS_HEIGHT_COMNTS) AS PHYS_HEIGHT_COMNTS_filled,
    COUNT(PHYS_RESP_COMMENTS) AS PHYS_RESP_COMMENTS_filled,
    COUNT(PHYS_SPO2_COMMENTS) AS PHYS_SPO2_COMMENTS_filled,
    COUNT(PHYS_PF_COMMENTS) AS PHYS_PF_COMMENTS_filled,
    COUNT(INTERPRT_ASGN_CMT) AS INTERPRT_ASGN_CMT_filled,
    COUNT(PAT_HOUSING_STAT_C_NAME) AS PAT_HOUSING_STAT_C_NAME_filled,
    COUNT(BCRA_AGE) AS BCRA_AGE_filled,
    COUNT(BCRA_MENARCHE_AGE_C_NAME) AS BCRA_MENARCHE_AGE_C_NAME_filled,
    COUNT(BCRA_FST_LIVBIRTH_C_NAME) AS BCRA_FST_LIVBIRTH_C_NAME_filled,
    COUNT(BCRA_FST_DEG_REL_C_NAME) AS BCRA_FST_DEG_REL_C_NAME_filled,
    COUNT(BCRA_NUM_BIOPSY_C_NAME) AS BCRA_NUM_BIOPSY_C_NAME_filled,
    COUNT(BCRA_ATYP_HYPLSA_C_NAME) AS BCRA_ATYP_HYPLSA_C_NAME_filled,
    COUNT(BCRA_RACE_C_NAME) AS BCRA_RACE_C_NAME_filled,
    COUNT(LB_ENC_START_DT) AS LB_ENC_START_DT_filled,
    COUNT(LB_ENC_END_DT) AS LB_ENC_END_DT_filled,
    COUNT(WAITING_LIST_ID) AS WAITING_LIST_ID_filled,
    COUNT(SUBMITTER_ID) AS SUBMITTER_ID_filled,
    COUNT(SUBMITTER_ID_RECORD_NAME) AS SUBMITTER_ID_RECORD_NAME_filled,
    COUNT(BILL_TO_SUBMITTER_C_NAME) AS BILL_TO_SUBMITTER_C_NAME_filled,
    COUNT(SUBMITTER_ACCT_ID) AS SUBMITTER_ACCT_ID_filled,
    COUNT(LB_BLNG_ENC_SRVC_DT) AS LB_BLNG_ENC_SRVC_DT_filled,
    COUNT(ECHKIN_STATUS_C_NAME) AS ECHKIN_STATUS_C_NAME_filled,
    COUNT(PB_VISIT_HAR_ID) AS PB_VISIT_HAR_ID_filled,
    COUNT(TECHNICAL_REFERRAL_ID) AS TECHNICAL_REFERRAL_ID_filled,
    COUNT(CR_CLIENT_REF_IDNT) AS CR_CLIENT_REF_IDNT_filled,
    COUNT(CR_BENEFIT_REF_IDNT) AS CR_BENEFIT_REF_IDNT_filled,
    COUNT(CR_MESSAGE_ENGLISH) AS CR_MESSAGE_ENGLISH_filled,
    COUNT(CR_MESSAGE_SPANISH) AS CR_MESSAGE_SPANISH_filled,
    COUNT(CR_QUERY_SENT_UTC_DTTM) AS CR_QUERY_SENT_UTC_DTTM_filled,
    COUNT(CR_RESP_RECVD_UTC_DTTM) AS CR_RESP_RECVD_UTC_DTTM_filled,
    COUNT(CR_QUERY_ERROR) AS CR_QUERY_ERROR_filled,
    COUNT(COPAY_REDUCTION_AMT) AS COPAY_REDUCTION_AMT_filled,
    CAST(NULL AS NVARCHAR(400)) AS query_error
FROM PAT_ENC_4
GROUP BY YEAR(LB_ENC_START_DT);
END TRY
BEGIN CATCH
INSERT INTO #fc_008 (activity_year, total_rows, PAT_ENC_CSN_ID_filled, FAMILY_SIZE_filled, VISIT_NUMBER_filled, PAT_CNCT_IND_C_NAME_filled, DENTAL_STUDENT_ID_PROV_NAME_filled, LOC_VISIT_ID_LOC_NAME_filled, COPAY_NOT_COVERED_C_NAME_filled, COPAY_COLL_FLAG_YN_filled, COPAY_COLL_PERSON_filled, COPAY_WAIVE_RSN_C_NAME_filled, COPAY_MIN_VALUE_filled, COPAY_RECEIPT_NUM_filled, BEN_ADJ_COINS_AMT_filled, BEN_ADJ_DEDUCT_AMT_filled, PAT_HOMELESS_YN_filled, PAT_HOMELESS_TYP_C_NAME_filled, PERCENTAGE_OF_FPL_filled, MSG_RECEIVED_DTTM_filled, TOBACCO_USE_VRFY_YN_filled, CR_TX_TYPE_C_NAME_filled, ORIG_ENC_CSN_filled, PHYS_BP_COMMENTS_filled, PHYS_TEMP_COMMENTS_filled, PHYS_TEMPSRC_COMNTS_filled, PHYS_PULSE_COMMENTS_filled, PHYS_WEIGHT_COMNTS_filled, PHYS_HEIGHT_COMNTS_filled, PHYS_RESP_COMMENTS_filled, PHYS_SPO2_COMMENTS_filled, PHYS_PF_COMMENTS_filled, INTERPRT_ASGN_CMT_filled, PAT_HOUSING_STAT_C_NAME_filled, BCRA_AGE_filled, BCRA_MENARCHE_AGE_C_NAME_filled, BCRA_FST_LIVBIRTH_C_NAME_filled, BCRA_FST_DEG_REL_C_NAME_filled, BCRA_NUM_BIOPSY_C_NAME_filled, BCRA_ATYP_HYPLSA_C_NAME_filled, BCRA_RACE_C_NAME_filled, LB_ENC_START_DT_filled, LB_ENC_END_DT_filled, WAITING_LIST_ID_filled, SUBMITTER_ID_filled, SUBMITTER_ID_RECORD_NAME_filled, BILL_TO_SUBMITTER_C_NAME_filled, SUBMITTER_ACCT_ID_filled, LB_BLNG_ENC_SRVC_DT_filled, ECHKIN_STATUS_C_NAME_filled, PB_VISIT_HAR_ID_filled, TECHNICAL_REFERRAL_ID_filled, CR_CLIENT_REF_IDNT_filled, CR_BENEFIT_REF_IDNT_filled, CR_MESSAGE_ENGLISH_filled, CR_MESSAGE_SPANISH_filled, CR_QUERY_SENT_UTC_DTTM_filled, CR_RESP_RECVD_UTC_DTTM_filled, CR_QUERY_ERROR_filled, COPAY_REDUCTION_AMT_filled, query_error)
SELECT
    CAST(NULL AS INT) AS activity_year,
    CAST(NULL AS INT) AS total_rows,
    CAST(NULL AS INT) AS PAT_ENC_CSN_ID_filled,
    CAST(NULL AS INT) AS FAMILY_SIZE_filled,
    CAST(NULL AS INT) AS VISIT_NUMBER_filled,
    CAST(NULL AS INT) AS PAT_CNCT_IND_C_NAME_filled,
    CAST(NULL AS INT) AS DENTAL_STUDENT_ID_PROV_NAME_filled,
    CAST(NULL AS INT) AS LOC_VISIT_ID_LOC_NAME_filled,
    CAST(NULL AS INT) AS COPAY_NOT_COVERED_C_NAME_filled,
    CAST(NULL AS INT) AS COPAY_COLL_FLAG_YN_filled,
    CAST(NULL AS INT) AS COPAY_COLL_PERSON_filled,
    CAST(NULL AS INT) AS COPAY_WAIVE_RSN_C_NAME_filled,
    CAST(NULL AS INT) AS COPAY_MIN_VALUE_filled,
    CAST(NULL AS INT) AS COPAY_RECEIPT_NUM_filled,
    CAST(NULL AS INT) AS BEN_ADJ_COINS_AMT_filled,
    CAST(NULL AS INT) AS BEN_ADJ_DEDUCT_AMT_filled,
    CAST(NULL AS INT) AS PAT_HOMELESS_YN_filled,
    CAST(NULL AS INT) AS PAT_HOMELESS_TYP_C_NAME_filled,
    CAST(NULL AS INT) AS PERCENTAGE_OF_FPL_filled,
    CAST(NULL AS INT) AS MSG_RECEIVED_DTTM_filled,
    CAST(NULL AS INT) AS TOBACCO_USE_VRFY_YN_filled,
    CAST(NULL AS INT) AS CR_TX_TYPE_C_NAME_filled,
    CAST(NULL AS INT) AS ORIG_ENC_CSN_filled,
    CAST(NULL AS INT) AS PHYS_BP_COMMENTS_filled,
    CAST(NULL AS INT) AS PHYS_TEMP_COMMENTS_filled,
    CAST(NULL AS INT) AS PHYS_TEMPSRC_COMNTS_filled,
    CAST(NULL AS INT) AS PHYS_PULSE_COMMENTS_filled,
    CAST(NULL AS INT) AS PHYS_WEIGHT_COMNTS_filled,
    CAST(NULL AS INT) AS PHYS_HEIGHT_COMNTS_filled,
    CAST(NULL AS INT) AS PHYS_RESP_COMMENTS_filled,
    CAST(NULL AS INT) AS PHYS_SPO2_COMMENTS_filled,
    CAST(NULL AS INT) AS PHYS_PF_COMMENTS_filled,
    CAST(NULL AS INT) AS INTERPRT_ASGN_CMT_filled,
    CAST(NULL AS INT) AS PAT_HOUSING_STAT_C_NAME_filled,
    CAST(NULL AS INT) AS BCRA_AGE_filled,
    CAST(NULL AS INT) AS BCRA_MENARCHE_AGE_C_NAME_filled,
    CAST(NULL AS INT) AS BCRA_FST_LIVBIRTH_C_NAME_filled,
    CAST(NULL AS INT) AS BCRA_FST_DEG_REL_C_NAME_filled,
    CAST(NULL AS INT) AS BCRA_NUM_BIOPSY_C_NAME_filled,
    CAST(NULL AS INT) AS BCRA_ATYP_HYPLSA_C_NAME_filled,
    CAST(NULL AS INT) AS BCRA_RACE_C_NAME_filled,
    CAST(NULL AS INT) AS LB_ENC_START_DT_filled,
    CAST(NULL AS INT) AS LB_ENC_END_DT_filled,
    CAST(NULL AS INT) AS WAITING_LIST_ID_filled,
    CAST(NULL AS INT) AS SUBMITTER_ID_filled,
    CAST(NULL AS INT) AS SUBMITTER_ID_RECORD_NAME_filled,
    CAST(NULL AS INT) AS BILL_TO_SUBMITTER_C_NAME_filled,
    CAST(NULL AS INT) AS SUBMITTER_ACCT_ID_filled,
    CAST(NULL AS INT) AS LB_BLNG_ENC_SRVC_DT_filled,
    CAST(NULL AS INT) AS ECHKIN_STATUS_C_NAME_filled,
    CAST(NULL AS INT) AS PB_VISIT_HAR_ID_filled,
    CAST(NULL AS INT) AS TECHNICAL_REFERRAL_ID_filled,
    CAST(NULL AS INT) AS CR_CLIENT_REF_IDNT_filled,
    CAST(NULL AS INT) AS CR_BENEFIT_REF_IDNT_filled,
    CAST(NULL AS INT) AS CR_MESSAGE_ENGLISH_filled,
    CAST(NULL AS INT) AS CR_MESSAGE_SPANISH_filled,
    CAST(NULL AS INT) AS CR_QUERY_SENT_UTC_DTTM_filled,
    CAST(NULL AS INT) AS CR_RESP_RECVD_UTC_DTTM_filled,
    CAST(NULL AS INT) AS CR_QUERY_ERROR_filled,
    CAST(NULL AS INT) AS COPAY_REDUCTION_AMT_filled,
    CAST(ERROR_MESSAGE() AS NVARCHAR(400)) AS query_error;
END CATCH;

-- ---- fc_009 <- PAT_ENC_5 ----
-- This table supplements the PAT_ENC, PAT_ENC_2, PAT_ENC_3, and PAT_ENC_4 tables. It contains additional information related to patient encounters or appointments.
-- Bucket(s): Encounter / visit record
CREATE TABLE #fc_009 (
    activity_year INT,
    total_rows INT,
    PAT_ENC_CSN_ID_filled INT,
    CONTACT_DATE_filled INT,
    PUBLIC_HOUSING_YN_filled INT,
    PVT_HOSP_ENC_C_NAME_filled INT,
    LINK_INS_TYPE_C_NAME_filled INT,
    PAT_VER_HCA_C_NAME_filled INT,
    EXT_GRP_IDNT_filled INT,
    EXT_GRP_SRC_C_NAME_filled INT,
    PREPAY_SET_BY_USER_YN_filled INT,
    PREPAY_UPDATE_USER_ID_filled INT,
    PREPAY_UPDATE_USER_ID_NAME_filled INT,
    PREPAY_UPDATE_INST_DTTM_filled INT,
    PREPAY_CALC_SCENARIO_filled INT,
    AUTHCERT_ID_filled INT,
    ED_REF_CALLBAK_YN_filled INT,
    ED_REF_CALLBAK_P_ID_PROV_NAME_filled INT,
    ED_REF_CALLBAK_C_ID_LOC_NAME_filled INT,
    ED_REF_CALLBAK_NUM_filled INT,
    IS_ON_DEMAND_VV_YN_filled INT,
    ATTR_DEPARTMENT_ID_EXTERNAL_NAME_filled INT,
    PAT_DTREE_ANSWER_ID_filled INT,
    PREPAY_DISCNT_AMT_filled INT,
    PREPAY_DISCNT_PCT_filled INT,
    PREPAY_PROPOSED_DISCNT_AMT_filled INT,
    PREPAY_DISCNT_CALC_RULE_ID_filled INT,
    PREPAY_DISCNT_CALC_RULE_ID_RULE_NAME_filled INT,
    PREPAY_DISCNT_CALC_PCT_filled INT,
    PREPAY_DISCNT_OVRIDE_AMT_filled INT,
    PREPAY_DISCNT_OVRIDE_PCT_filled INT,
    PREPAY_DISCNT_OVRIDE_USER_ID_filled INT,
    PREPAY_DISCNT_OVRIDE_USER_ID_NAME_filled INT,
    PREPAY_DISCNT_OVRIDE_CMT_filled INT,
    PREPAY_DISCNT_OVRIDE_DTTM_filled INT,
    EVISIT_STATUS_C_NAME_filled INT,
    query_error NVARCHAR(400)
);
BEGIN TRY
INSERT INTO #fc_009 (activity_year, total_rows, PAT_ENC_CSN_ID_filled, CONTACT_DATE_filled, PUBLIC_HOUSING_YN_filled, PVT_HOSP_ENC_C_NAME_filled, LINK_INS_TYPE_C_NAME_filled, PAT_VER_HCA_C_NAME_filled, EXT_GRP_IDNT_filled, EXT_GRP_SRC_C_NAME_filled, PREPAY_SET_BY_USER_YN_filled, PREPAY_UPDATE_USER_ID_filled, PREPAY_UPDATE_USER_ID_NAME_filled, PREPAY_UPDATE_INST_DTTM_filled, PREPAY_CALC_SCENARIO_filled, AUTHCERT_ID_filled, ED_REF_CALLBAK_YN_filled, ED_REF_CALLBAK_P_ID_PROV_NAME_filled, ED_REF_CALLBAK_C_ID_LOC_NAME_filled, ED_REF_CALLBAK_NUM_filled, IS_ON_DEMAND_VV_YN_filled, ATTR_DEPARTMENT_ID_EXTERNAL_NAME_filled, PAT_DTREE_ANSWER_ID_filled, PREPAY_DISCNT_AMT_filled, PREPAY_DISCNT_PCT_filled, PREPAY_PROPOSED_DISCNT_AMT_filled, PREPAY_DISCNT_CALC_RULE_ID_filled, PREPAY_DISCNT_CALC_RULE_ID_RULE_NAME_filled, PREPAY_DISCNT_CALC_PCT_filled, PREPAY_DISCNT_OVRIDE_AMT_filled, PREPAY_DISCNT_OVRIDE_PCT_filled, PREPAY_DISCNT_OVRIDE_USER_ID_filled, PREPAY_DISCNT_OVRIDE_USER_ID_NAME_filled, PREPAY_DISCNT_OVRIDE_CMT_filled, PREPAY_DISCNT_OVRIDE_DTTM_filled, EVISIT_STATUS_C_NAME_filled, query_error)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(PUBLIC_HOUSING_YN) AS PUBLIC_HOUSING_YN_filled,
    COUNT(PVT_HOSP_ENC_C_NAME) AS PVT_HOSP_ENC_C_NAME_filled,
    COUNT(LINK_INS_TYPE_C_NAME) AS LINK_INS_TYPE_C_NAME_filled,
    COUNT(PAT_VER_HCA_C_NAME) AS PAT_VER_HCA_C_NAME_filled,
    COUNT(EXT_GRP_IDNT) AS EXT_GRP_IDNT_filled,
    COUNT(EXT_GRP_SRC_C_NAME) AS EXT_GRP_SRC_C_NAME_filled,
    COUNT(PREPAY_SET_BY_USER_YN) AS PREPAY_SET_BY_USER_YN_filled,
    COUNT(PREPAY_UPDATE_USER_ID) AS PREPAY_UPDATE_USER_ID_filled,
    COUNT(PREPAY_UPDATE_USER_ID_NAME) AS PREPAY_UPDATE_USER_ID_NAME_filled,
    COUNT(PREPAY_UPDATE_INST_DTTM) AS PREPAY_UPDATE_INST_DTTM_filled,
    COUNT(PREPAY_CALC_SCENARIO) AS PREPAY_CALC_SCENARIO_filled,
    COUNT(AUTHCERT_ID) AS AUTHCERT_ID_filled,
    COUNT(ED_REF_CALLBAK_YN) AS ED_REF_CALLBAK_YN_filled,
    COUNT(ED_REF_CALLBAK_P_ID_PROV_NAME) AS ED_REF_CALLBAK_P_ID_PROV_NAME_filled,
    COUNT(ED_REF_CALLBAK_C_ID_LOC_NAME) AS ED_REF_CALLBAK_C_ID_LOC_NAME_filled,
    COUNT(ED_REF_CALLBAK_NUM) AS ED_REF_CALLBAK_NUM_filled,
    COUNT(IS_ON_DEMAND_VV_YN) AS IS_ON_DEMAND_VV_YN_filled,
    COUNT(ATTR_DEPARTMENT_ID_EXTERNAL_NAME) AS ATTR_DEPARTMENT_ID_EXTERNAL_NAME_filled,
    COUNT(PAT_DTREE_ANSWER_ID) AS PAT_DTREE_ANSWER_ID_filled,
    COUNT(PREPAY_DISCNT_AMT) AS PREPAY_DISCNT_AMT_filled,
    COUNT(PREPAY_DISCNT_PCT) AS PREPAY_DISCNT_PCT_filled,
    COUNT(PREPAY_PROPOSED_DISCNT_AMT) AS PREPAY_PROPOSED_DISCNT_AMT_filled,
    COUNT(PREPAY_DISCNT_CALC_RULE_ID) AS PREPAY_DISCNT_CALC_RULE_ID_filled,
    COUNT(PREPAY_DISCNT_CALC_RULE_ID_RULE_NAME) AS PREPAY_DISCNT_CALC_RULE_ID_RULE_NAME_filled,
    COUNT(PREPAY_DISCNT_CALC_PCT) AS PREPAY_DISCNT_CALC_PCT_filled,
    COUNT(PREPAY_DISCNT_OVRIDE_AMT) AS PREPAY_DISCNT_OVRIDE_AMT_filled,
    COUNT(PREPAY_DISCNT_OVRIDE_PCT) AS PREPAY_DISCNT_OVRIDE_PCT_filled,
    COUNT(PREPAY_DISCNT_OVRIDE_USER_ID) AS PREPAY_DISCNT_OVRIDE_USER_ID_filled,
    COUNT(PREPAY_DISCNT_OVRIDE_USER_ID_NAME) AS PREPAY_DISCNT_OVRIDE_USER_ID_NAME_filled,
    COUNT(PREPAY_DISCNT_OVRIDE_CMT) AS PREPAY_DISCNT_OVRIDE_CMT_filled,
    COUNT(PREPAY_DISCNT_OVRIDE_DTTM) AS PREPAY_DISCNT_OVRIDE_DTTM_filled,
    COUNT(EVISIT_STATUS_C_NAME) AS EVISIT_STATUS_C_NAME_filled,
    CAST(NULL AS NVARCHAR(400)) AS query_error
FROM PAT_ENC_5
GROUP BY YEAR(CONTACT_DATE);
END TRY
BEGIN CATCH
INSERT INTO #fc_009 (activity_year, total_rows, PAT_ENC_CSN_ID_filled, CONTACT_DATE_filled, PUBLIC_HOUSING_YN_filled, PVT_HOSP_ENC_C_NAME_filled, LINK_INS_TYPE_C_NAME_filled, PAT_VER_HCA_C_NAME_filled, EXT_GRP_IDNT_filled, EXT_GRP_SRC_C_NAME_filled, PREPAY_SET_BY_USER_YN_filled, PREPAY_UPDATE_USER_ID_filled, PREPAY_UPDATE_USER_ID_NAME_filled, PREPAY_UPDATE_INST_DTTM_filled, PREPAY_CALC_SCENARIO_filled, AUTHCERT_ID_filled, ED_REF_CALLBAK_YN_filled, ED_REF_CALLBAK_P_ID_PROV_NAME_filled, ED_REF_CALLBAK_C_ID_LOC_NAME_filled, ED_REF_CALLBAK_NUM_filled, IS_ON_DEMAND_VV_YN_filled, ATTR_DEPARTMENT_ID_EXTERNAL_NAME_filled, PAT_DTREE_ANSWER_ID_filled, PREPAY_DISCNT_AMT_filled, PREPAY_DISCNT_PCT_filled, PREPAY_PROPOSED_DISCNT_AMT_filled, PREPAY_DISCNT_CALC_RULE_ID_filled, PREPAY_DISCNT_CALC_RULE_ID_RULE_NAME_filled, PREPAY_DISCNT_CALC_PCT_filled, PREPAY_DISCNT_OVRIDE_AMT_filled, PREPAY_DISCNT_OVRIDE_PCT_filled, PREPAY_DISCNT_OVRIDE_USER_ID_filled, PREPAY_DISCNT_OVRIDE_USER_ID_NAME_filled, PREPAY_DISCNT_OVRIDE_CMT_filled, PREPAY_DISCNT_OVRIDE_DTTM_filled, EVISIT_STATUS_C_NAME_filled, query_error)
SELECT
    CAST(NULL AS INT) AS activity_year,
    CAST(NULL AS INT) AS total_rows,
    CAST(NULL AS INT) AS PAT_ENC_CSN_ID_filled,
    CAST(NULL AS INT) AS CONTACT_DATE_filled,
    CAST(NULL AS INT) AS PUBLIC_HOUSING_YN_filled,
    CAST(NULL AS INT) AS PVT_HOSP_ENC_C_NAME_filled,
    CAST(NULL AS INT) AS LINK_INS_TYPE_C_NAME_filled,
    CAST(NULL AS INT) AS PAT_VER_HCA_C_NAME_filled,
    CAST(NULL AS INT) AS EXT_GRP_IDNT_filled,
    CAST(NULL AS INT) AS EXT_GRP_SRC_C_NAME_filled,
    CAST(NULL AS INT) AS PREPAY_SET_BY_USER_YN_filled,
    CAST(NULL AS INT) AS PREPAY_UPDATE_USER_ID_filled,
    CAST(NULL AS INT) AS PREPAY_UPDATE_USER_ID_NAME_filled,
    CAST(NULL AS INT) AS PREPAY_UPDATE_INST_DTTM_filled,
    CAST(NULL AS INT) AS PREPAY_CALC_SCENARIO_filled,
    CAST(NULL AS INT) AS AUTHCERT_ID_filled,
    CAST(NULL AS INT) AS ED_REF_CALLBAK_YN_filled,
    CAST(NULL AS INT) AS ED_REF_CALLBAK_P_ID_PROV_NAME_filled,
    CAST(NULL AS INT) AS ED_REF_CALLBAK_C_ID_LOC_NAME_filled,
    CAST(NULL AS INT) AS ED_REF_CALLBAK_NUM_filled,
    CAST(NULL AS INT) AS IS_ON_DEMAND_VV_YN_filled,
    CAST(NULL AS INT) AS ATTR_DEPARTMENT_ID_EXTERNAL_NAME_filled,
    CAST(NULL AS INT) AS PAT_DTREE_ANSWER_ID_filled,
    CAST(NULL AS INT) AS PREPAY_DISCNT_AMT_filled,
    CAST(NULL AS INT) AS PREPAY_DISCNT_PCT_filled,
    CAST(NULL AS INT) AS PREPAY_PROPOSED_DISCNT_AMT_filled,
    CAST(NULL AS INT) AS PREPAY_DISCNT_CALC_RULE_ID_filled,
    CAST(NULL AS INT) AS PREPAY_DISCNT_CALC_RULE_ID_RULE_NAME_filled,
    CAST(NULL AS INT) AS PREPAY_DISCNT_CALC_PCT_filled,
    CAST(NULL AS INT) AS PREPAY_DISCNT_OVRIDE_AMT_filled,
    CAST(NULL AS INT) AS PREPAY_DISCNT_OVRIDE_PCT_filled,
    CAST(NULL AS INT) AS PREPAY_DISCNT_OVRIDE_USER_ID_filled,
    CAST(NULL AS INT) AS PREPAY_DISCNT_OVRIDE_USER_ID_NAME_filled,
    CAST(NULL AS INT) AS PREPAY_DISCNT_OVRIDE_CMT_filled,
    CAST(NULL AS INT) AS PREPAY_DISCNT_OVRIDE_DTTM_filled,
    CAST(NULL AS INT) AS EVISIT_STATUS_C_NAME_filled,
    CAST(ERROR_MESSAGE() AS NVARCHAR(400)) AS query_error;
END CATCH;

-- ---- fc_010 <- PAT_ENC_6 ----
-- This table supplements the PAT_ENC, PAT_ENC_2, PAT_ENC_3, PAT_ENC_4, and PAT_ENC_5 tables. It contains additional information related to patient encounters or appointments.
-- Bucket(s): Encounter / visit record
CREATE TABLE #fc_010 (
    activity_year INT,
    total_rows INT,
    PAT_ENC_CSN_ID_filled INT,
    PAT_ENC_DATE_REAL_filled INT,
    CONTACT_DATE_filled INT,
    LINKED_ENC_CSN_filled INT,
    LMP_PRECISION_C_NAME_filled INT,
    PLANNED_BILL_AREA_ID_filled INT,
    PLANNED_BILL_AREA_ID_BILL_AREA_NAME_filled INT,
    BCRA_BRCA_GENE_MUT_C_NAME_filled INT,
    SVC_TARGET_EFFORT_YN_filled INT,
    OUTPAT_VISIT_GRP_C_NAME_filled INT,
    PSYCH_ARRIVAL_C_NAME_filled INT,
    PLAN_RECUR_TREAT_YN_filled INT,
    HUS_VISIT_TYPE_C_NAME_filled INT,
    SOCIAL_SRVC_AREA_C_NAME_filled INT,
    EXT_LTC_PAT_YN_filled INT,
    VETERAN_ENC_MED_CVG_C_NAME_filled INT,
    VETERAN_BILLING_CODE_C_NAME_filled INT,
    ED_REF_CALLBAK_D_ID_EXTERNAL_NAME_filled INT,
    RFV_USED_TO_SCHED_C_NAME_filled INT,
    BMI_PERCENTILE_filled INT,
    CREATION_ORD_ID_filled INT,
    EXT_TX_STATUS_C_NAME_filled INT,
    EXT_TX_STATUS_CMT_filled INT,
    EXT_ACCM_STATUS_C_NAME_filled INT,
    EXT_ACCM_STATUS_CMT_filled INT,
    SG_AT_RISK_IND_C_NAME_filled INT,
    SG_FC_STATUS_C_NAME_filled INT,
    ELIG_PLAN_SELECT_YN_filled INT,
    SG_MOH_URGENCY_C_NAME_filled INT,
    SG_NAMED_REFERRAL_YN_filled INT,
    SG_PAT_REQUEST_YN_filled INT,
    SG_TREATMENT_PROG_C_NAME_filled INT,
    SG_APPT_RATIONALE_C_NAME_filled INT,
    EVISIT_RFV_C_NAME_filled INT,
    EVISIT_YN_filled INT,
    EVISIT_TLH_ALLOWED_SUBLOC_C_NAME_filled INT,
    EVISIT_TLH_ALLOWED_LOC_C_NAME_filled INT,
    APPT_AUTH_STATUS_C_NAME_filled INT,
    EVISIT_NEW_STATUS_C_NAME_filled INT,
    LAB_RESP_USER_ID_filled INT,
    LAB_RESP_USER_ID_NAME_filled INT,
    EXT_MEDS_UPD_INST_UTC_DTTM_filled INT,
    INTF_PRIMARY_PAT_ENC_CSN_ID_filled INT,
    OVERRIDE_BCRA_NUM_BIOPSY_C_NAME_filled INT,
    OVERRIDE_BCRA_RACE_C_NAME_filled INT,
    OVERRIDE_GAIL_FACTOR_USER_ID_filled INT,
    OVERRIDE_GAIL_FACTOR_USER_ID_NAME_filled INT,
    OVERRIDE_GAIL_FACTOR_DTTM_filled INT,
    VETERAN_COVERAGE_ENC_YN_filled INT,
    ADJUD_TO_PHARMACY_COVERAGE_YN_filled INT,
    TLH_APRV_SUBLOC_C_NAME_filled INT,
    TLH_APRV_LOC_C_NAME_filled INT,
    ENC_CLOSE_UTC_DTTM_filled INT,
    SPLIT_FILING_ORDER_YN_filled INT,
    query_error NVARCHAR(400)
);
BEGIN TRY
INSERT INTO #fc_010 (activity_year, total_rows, PAT_ENC_CSN_ID_filled, PAT_ENC_DATE_REAL_filled, CONTACT_DATE_filled, LINKED_ENC_CSN_filled, LMP_PRECISION_C_NAME_filled, PLANNED_BILL_AREA_ID_filled, PLANNED_BILL_AREA_ID_BILL_AREA_NAME_filled, BCRA_BRCA_GENE_MUT_C_NAME_filled, SVC_TARGET_EFFORT_YN_filled, OUTPAT_VISIT_GRP_C_NAME_filled, PSYCH_ARRIVAL_C_NAME_filled, PLAN_RECUR_TREAT_YN_filled, HUS_VISIT_TYPE_C_NAME_filled, SOCIAL_SRVC_AREA_C_NAME_filled, EXT_LTC_PAT_YN_filled, VETERAN_ENC_MED_CVG_C_NAME_filled, VETERAN_BILLING_CODE_C_NAME_filled, ED_REF_CALLBAK_D_ID_EXTERNAL_NAME_filled, RFV_USED_TO_SCHED_C_NAME_filled, BMI_PERCENTILE_filled, CREATION_ORD_ID_filled, EXT_TX_STATUS_C_NAME_filled, EXT_TX_STATUS_CMT_filled, EXT_ACCM_STATUS_C_NAME_filled, EXT_ACCM_STATUS_CMT_filled, SG_AT_RISK_IND_C_NAME_filled, SG_FC_STATUS_C_NAME_filled, ELIG_PLAN_SELECT_YN_filled, SG_MOH_URGENCY_C_NAME_filled, SG_NAMED_REFERRAL_YN_filled, SG_PAT_REQUEST_YN_filled, SG_TREATMENT_PROG_C_NAME_filled, SG_APPT_RATIONALE_C_NAME_filled, EVISIT_RFV_C_NAME_filled, EVISIT_YN_filled, EVISIT_TLH_ALLOWED_SUBLOC_C_NAME_filled, EVISIT_TLH_ALLOWED_LOC_C_NAME_filled, APPT_AUTH_STATUS_C_NAME_filled, EVISIT_NEW_STATUS_C_NAME_filled, LAB_RESP_USER_ID_filled, LAB_RESP_USER_ID_NAME_filled, EXT_MEDS_UPD_INST_UTC_DTTM_filled, INTF_PRIMARY_PAT_ENC_CSN_ID_filled, OVERRIDE_BCRA_NUM_BIOPSY_C_NAME_filled, OVERRIDE_BCRA_RACE_C_NAME_filled, OVERRIDE_GAIL_FACTOR_USER_ID_filled, OVERRIDE_GAIL_FACTOR_USER_ID_NAME_filled, OVERRIDE_GAIL_FACTOR_DTTM_filled, VETERAN_COVERAGE_ENC_YN_filled, ADJUD_TO_PHARMACY_COVERAGE_YN_filled, TLH_APRV_SUBLOC_C_NAME_filled, TLH_APRV_LOC_C_NAME_filled, ENC_CLOSE_UTC_DTTM_filled, SPLIT_FILING_ORDER_YN_filled, query_error)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(PAT_ENC_DATE_REAL) AS PAT_ENC_DATE_REAL_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(LINKED_ENC_CSN) AS LINKED_ENC_CSN_filled,
    COUNT(LMP_PRECISION_C_NAME) AS LMP_PRECISION_C_NAME_filled,
    COUNT(PLANNED_BILL_AREA_ID) AS PLANNED_BILL_AREA_ID_filled,
    COUNT(PLANNED_BILL_AREA_ID_BILL_AREA_NAME) AS PLANNED_BILL_AREA_ID_BILL_AREA_NAME_filled,
    COUNT(BCRA_BRCA_GENE_MUT_C_NAME) AS BCRA_BRCA_GENE_MUT_C_NAME_filled,
    COUNT(SVC_TARGET_EFFORT_YN) AS SVC_TARGET_EFFORT_YN_filled,
    COUNT(OUTPAT_VISIT_GRP_C_NAME) AS OUTPAT_VISIT_GRP_C_NAME_filled,
    COUNT(PSYCH_ARRIVAL_C_NAME) AS PSYCH_ARRIVAL_C_NAME_filled,
    COUNT(PLAN_RECUR_TREAT_YN) AS PLAN_RECUR_TREAT_YN_filled,
    COUNT(HUS_VISIT_TYPE_C_NAME) AS HUS_VISIT_TYPE_C_NAME_filled,
    COUNT(SOCIAL_SRVC_AREA_C_NAME) AS SOCIAL_SRVC_AREA_C_NAME_filled,
    COUNT(EXT_LTC_PAT_YN) AS EXT_LTC_PAT_YN_filled,
    COUNT(VETERAN_ENC_MED_CVG_C_NAME) AS VETERAN_ENC_MED_CVG_C_NAME_filled,
    COUNT(VETERAN_BILLING_CODE_C_NAME) AS VETERAN_BILLING_CODE_C_NAME_filled,
    COUNT(ED_REF_CALLBAK_D_ID_EXTERNAL_NAME) AS ED_REF_CALLBAK_D_ID_EXTERNAL_NAME_filled,
    COUNT(RFV_USED_TO_SCHED_C_NAME) AS RFV_USED_TO_SCHED_C_NAME_filled,
    COUNT(BMI_PERCENTILE) AS BMI_PERCENTILE_filled,
    COUNT(CREATION_ORD_ID) AS CREATION_ORD_ID_filled,
    COUNT(EXT_TX_STATUS_C_NAME) AS EXT_TX_STATUS_C_NAME_filled,
    COUNT(EXT_TX_STATUS_CMT) AS EXT_TX_STATUS_CMT_filled,
    COUNT(EXT_ACCM_STATUS_C_NAME) AS EXT_ACCM_STATUS_C_NAME_filled,
    COUNT(EXT_ACCM_STATUS_CMT) AS EXT_ACCM_STATUS_CMT_filled,
    COUNT(SG_AT_RISK_IND_C_NAME) AS SG_AT_RISK_IND_C_NAME_filled,
    COUNT(SG_FC_STATUS_C_NAME) AS SG_FC_STATUS_C_NAME_filled,
    COUNT(ELIG_PLAN_SELECT_YN) AS ELIG_PLAN_SELECT_YN_filled,
    COUNT(SG_MOH_URGENCY_C_NAME) AS SG_MOH_URGENCY_C_NAME_filled,
    COUNT(SG_NAMED_REFERRAL_YN) AS SG_NAMED_REFERRAL_YN_filled,
    COUNT(SG_PAT_REQUEST_YN) AS SG_PAT_REQUEST_YN_filled,
    COUNT(SG_TREATMENT_PROG_C_NAME) AS SG_TREATMENT_PROG_C_NAME_filled,
    COUNT(SG_APPT_RATIONALE_C_NAME) AS SG_APPT_RATIONALE_C_NAME_filled,
    COUNT(EVISIT_RFV_C_NAME) AS EVISIT_RFV_C_NAME_filled,
    COUNT(EVISIT_YN) AS EVISIT_YN_filled,
    COUNT(EVISIT_TLH_ALLOWED_SUBLOC_C_NAME) AS EVISIT_TLH_ALLOWED_SUBLOC_C_NAME_filled,
    COUNT(EVISIT_TLH_ALLOWED_LOC_C_NAME) AS EVISIT_TLH_ALLOWED_LOC_C_NAME_filled,
    COUNT(APPT_AUTH_STATUS_C_NAME) AS APPT_AUTH_STATUS_C_NAME_filled,
    COUNT(EVISIT_NEW_STATUS_C_NAME) AS EVISIT_NEW_STATUS_C_NAME_filled,
    COUNT(LAB_RESP_USER_ID) AS LAB_RESP_USER_ID_filled,
    COUNT(LAB_RESP_USER_ID_NAME) AS LAB_RESP_USER_ID_NAME_filled,
    COUNT(EXT_MEDS_UPD_INST_UTC_DTTM) AS EXT_MEDS_UPD_INST_UTC_DTTM_filled,
    COUNT(INTF_PRIMARY_PAT_ENC_CSN_ID) AS INTF_PRIMARY_PAT_ENC_CSN_ID_filled,
    COUNT(OVERRIDE_BCRA_NUM_BIOPSY_C_NAME) AS OVERRIDE_BCRA_NUM_BIOPSY_C_NAME_filled,
    COUNT(OVERRIDE_BCRA_RACE_C_NAME) AS OVERRIDE_BCRA_RACE_C_NAME_filled,
    COUNT(OVERRIDE_GAIL_FACTOR_USER_ID) AS OVERRIDE_GAIL_FACTOR_USER_ID_filled,
    COUNT(OVERRIDE_GAIL_FACTOR_USER_ID_NAME) AS OVERRIDE_GAIL_FACTOR_USER_ID_NAME_filled,
    COUNT(OVERRIDE_GAIL_FACTOR_DTTM) AS OVERRIDE_GAIL_FACTOR_DTTM_filled,
    COUNT(VETERAN_COVERAGE_ENC_YN) AS VETERAN_COVERAGE_ENC_YN_filled,
    COUNT(ADJUD_TO_PHARMACY_COVERAGE_YN) AS ADJUD_TO_PHARMACY_COVERAGE_YN_filled,
    COUNT(TLH_APRV_SUBLOC_C_NAME) AS TLH_APRV_SUBLOC_C_NAME_filled,
    COUNT(TLH_APRV_LOC_C_NAME) AS TLH_APRV_LOC_C_NAME_filled,
    COUNT(ENC_CLOSE_UTC_DTTM) AS ENC_CLOSE_UTC_DTTM_filled,
    COUNT(SPLIT_FILING_ORDER_YN) AS SPLIT_FILING_ORDER_YN_filled,
    CAST(NULL AS NVARCHAR(400)) AS query_error
FROM PAT_ENC_6
GROUP BY YEAR(CONTACT_DATE);
END TRY
BEGIN CATCH
INSERT INTO #fc_010 (activity_year, total_rows, PAT_ENC_CSN_ID_filled, PAT_ENC_DATE_REAL_filled, CONTACT_DATE_filled, LINKED_ENC_CSN_filled, LMP_PRECISION_C_NAME_filled, PLANNED_BILL_AREA_ID_filled, PLANNED_BILL_AREA_ID_BILL_AREA_NAME_filled, BCRA_BRCA_GENE_MUT_C_NAME_filled, SVC_TARGET_EFFORT_YN_filled, OUTPAT_VISIT_GRP_C_NAME_filled, PSYCH_ARRIVAL_C_NAME_filled, PLAN_RECUR_TREAT_YN_filled, HUS_VISIT_TYPE_C_NAME_filled, SOCIAL_SRVC_AREA_C_NAME_filled, EXT_LTC_PAT_YN_filled, VETERAN_ENC_MED_CVG_C_NAME_filled, VETERAN_BILLING_CODE_C_NAME_filled, ED_REF_CALLBAK_D_ID_EXTERNAL_NAME_filled, RFV_USED_TO_SCHED_C_NAME_filled, BMI_PERCENTILE_filled, CREATION_ORD_ID_filled, EXT_TX_STATUS_C_NAME_filled, EXT_TX_STATUS_CMT_filled, EXT_ACCM_STATUS_C_NAME_filled, EXT_ACCM_STATUS_CMT_filled, SG_AT_RISK_IND_C_NAME_filled, SG_FC_STATUS_C_NAME_filled, ELIG_PLAN_SELECT_YN_filled, SG_MOH_URGENCY_C_NAME_filled, SG_NAMED_REFERRAL_YN_filled, SG_PAT_REQUEST_YN_filled, SG_TREATMENT_PROG_C_NAME_filled, SG_APPT_RATIONALE_C_NAME_filled, EVISIT_RFV_C_NAME_filled, EVISIT_YN_filled, EVISIT_TLH_ALLOWED_SUBLOC_C_NAME_filled, EVISIT_TLH_ALLOWED_LOC_C_NAME_filled, APPT_AUTH_STATUS_C_NAME_filled, EVISIT_NEW_STATUS_C_NAME_filled, LAB_RESP_USER_ID_filled, LAB_RESP_USER_ID_NAME_filled, EXT_MEDS_UPD_INST_UTC_DTTM_filled, INTF_PRIMARY_PAT_ENC_CSN_ID_filled, OVERRIDE_BCRA_NUM_BIOPSY_C_NAME_filled, OVERRIDE_BCRA_RACE_C_NAME_filled, OVERRIDE_GAIL_FACTOR_USER_ID_filled, OVERRIDE_GAIL_FACTOR_USER_ID_NAME_filled, OVERRIDE_GAIL_FACTOR_DTTM_filled, VETERAN_COVERAGE_ENC_YN_filled, ADJUD_TO_PHARMACY_COVERAGE_YN_filled, TLH_APRV_SUBLOC_C_NAME_filled, TLH_APRV_LOC_C_NAME_filled, ENC_CLOSE_UTC_DTTM_filled, SPLIT_FILING_ORDER_YN_filled, query_error)
SELECT
    CAST(NULL AS INT) AS activity_year,
    CAST(NULL AS INT) AS total_rows,
    CAST(NULL AS INT) AS PAT_ENC_CSN_ID_filled,
    CAST(NULL AS INT) AS PAT_ENC_DATE_REAL_filled,
    CAST(NULL AS INT) AS CONTACT_DATE_filled,
    CAST(NULL AS INT) AS LINKED_ENC_CSN_filled,
    CAST(NULL AS INT) AS LMP_PRECISION_C_NAME_filled,
    CAST(NULL AS INT) AS PLANNED_BILL_AREA_ID_filled,
    CAST(NULL AS INT) AS PLANNED_BILL_AREA_ID_BILL_AREA_NAME_filled,
    CAST(NULL AS INT) AS BCRA_BRCA_GENE_MUT_C_NAME_filled,
    CAST(NULL AS INT) AS SVC_TARGET_EFFORT_YN_filled,
    CAST(NULL AS INT) AS OUTPAT_VISIT_GRP_C_NAME_filled,
    CAST(NULL AS INT) AS PSYCH_ARRIVAL_C_NAME_filled,
    CAST(NULL AS INT) AS PLAN_RECUR_TREAT_YN_filled,
    CAST(NULL AS INT) AS HUS_VISIT_TYPE_C_NAME_filled,
    CAST(NULL AS INT) AS SOCIAL_SRVC_AREA_C_NAME_filled,
    CAST(NULL AS INT) AS EXT_LTC_PAT_YN_filled,
    CAST(NULL AS INT) AS VETERAN_ENC_MED_CVG_C_NAME_filled,
    CAST(NULL AS INT) AS VETERAN_BILLING_CODE_C_NAME_filled,
    CAST(NULL AS INT) AS ED_REF_CALLBAK_D_ID_EXTERNAL_NAME_filled,
    CAST(NULL AS INT) AS RFV_USED_TO_SCHED_C_NAME_filled,
    CAST(NULL AS INT) AS BMI_PERCENTILE_filled,
    CAST(NULL AS INT) AS CREATION_ORD_ID_filled,
    CAST(NULL AS INT) AS EXT_TX_STATUS_C_NAME_filled,
    CAST(NULL AS INT) AS EXT_TX_STATUS_CMT_filled,
    CAST(NULL AS INT) AS EXT_ACCM_STATUS_C_NAME_filled,
    CAST(NULL AS INT) AS EXT_ACCM_STATUS_CMT_filled,
    CAST(NULL AS INT) AS SG_AT_RISK_IND_C_NAME_filled,
    CAST(NULL AS INT) AS SG_FC_STATUS_C_NAME_filled,
    CAST(NULL AS INT) AS ELIG_PLAN_SELECT_YN_filled,
    CAST(NULL AS INT) AS SG_MOH_URGENCY_C_NAME_filled,
    CAST(NULL AS INT) AS SG_NAMED_REFERRAL_YN_filled,
    CAST(NULL AS INT) AS SG_PAT_REQUEST_YN_filled,
    CAST(NULL AS INT) AS SG_TREATMENT_PROG_C_NAME_filled,
    CAST(NULL AS INT) AS SG_APPT_RATIONALE_C_NAME_filled,
    CAST(NULL AS INT) AS EVISIT_RFV_C_NAME_filled,
    CAST(NULL AS INT) AS EVISIT_YN_filled,
    CAST(NULL AS INT) AS EVISIT_TLH_ALLOWED_SUBLOC_C_NAME_filled,
    CAST(NULL AS INT) AS EVISIT_TLH_ALLOWED_LOC_C_NAME_filled,
    CAST(NULL AS INT) AS APPT_AUTH_STATUS_C_NAME_filled,
    CAST(NULL AS INT) AS EVISIT_NEW_STATUS_C_NAME_filled,
    CAST(NULL AS INT) AS LAB_RESP_USER_ID_filled,
    CAST(NULL AS INT) AS LAB_RESP_USER_ID_NAME_filled,
    CAST(NULL AS INT) AS EXT_MEDS_UPD_INST_UTC_DTTM_filled,
    CAST(NULL AS INT) AS INTF_PRIMARY_PAT_ENC_CSN_ID_filled,
    CAST(NULL AS INT) AS OVERRIDE_BCRA_NUM_BIOPSY_C_NAME_filled,
    CAST(NULL AS INT) AS OVERRIDE_BCRA_RACE_C_NAME_filled,
    CAST(NULL AS INT) AS OVERRIDE_GAIL_FACTOR_USER_ID_filled,
    CAST(NULL AS INT) AS OVERRIDE_GAIL_FACTOR_USER_ID_NAME_filled,
    CAST(NULL AS INT) AS OVERRIDE_GAIL_FACTOR_DTTM_filled,
    CAST(NULL AS INT) AS VETERAN_COVERAGE_ENC_YN_filled,
    CAST(NULL AS INT) AS ADJUD_TO_PHARMACY_COVERAGE_YN_filled,
    CAST(NULL AS INT) AS TLH_APRV_SUBLOC_C_NAME_filled,
    CAST(NULL AS INT) AS TLH_APRV_LOC_C_NAME_filled,
    CAST(NULL AS INT) AS ENC_CLOSE_UTC_DTTM_filled,
    CAST(NULL AS INT) AS SPLIT_FILING_ORDER_YN_filled,
    CAST(ERROR_MESSAGE() AS NVARCHAR(400)) AS query_error;
END CATCH;

-- ---- fc_011 <- PAT_ENC_7 ----
-- This table supplements the PAT_ENC, PAT_ENC_2, PAT_ENC_3, PAT_ENC_4, PAT_ENC_5, and PAT_ENC_6 tables. It contains additional information related to patient encounters or appointmen
-- Bucket(s): Encounter / visit record
CREATE TABLE #fc_011 (
    activity_year INT,
    total_rows INT,
    PAT_ENC_CSN_ID_filled INT,
    PAT_ENC_DATE_REAL_filled INT,
    CONTACT_DATE_filled INT,
    NOTIFY_REP_ADMSN_C_NAME_filled INT,
    REP_NOTIFIED_C_NAME_filled INT,
    NOTIFY_REP_COMMENTS_filled INT,
    NOTIFY_PCP_ADMSN_C_NAME_filled INT,
    PCP_NOTIFIED_C_NAME_filled INT,
    NOTIFY_PCP_COMMENTS_filled INT,
    ROC_PLANNING_PAT_ENC_CSN_ID_filled INT,
    NUM_PREV_EPSD_C_NAME_filled INT,
    SPEC_ORD_RSLT_NOT_AUTO_RLS_YN_filled INT,
    RECENTLY_AT_SCHOOL_C_NAME_filled INT,
    LMP_COMMENT_filled INT,
    CONTACT_NUM_filled INT,
    ABN_REQUIRED_YN_filled INT,
    IS_ABN_SIGNED_C_NAME_filled INT,
    MSP_IS_MEDICARE_HMO_C_NAME_filled INT,
    REG_COMMENTS_DATE_filled INT,
    AUTO_MSG_DISABLED_YN_filled INT,
    DONT_AUTO_LINK_YN_filled INT,
    RSN_FOR_NO_INC_MSG_C_NAME_filled INT,
    HAS_HORMONE_DATA_YN_filled INT,
    MEDS_REQUEST_LWS_ID_WORKSTATION_NAME_filled INT,
    EVISIT_SUBMITTED_DTTM_filled INT,
    EVISIT_TURNAROUND_IN_MINUTES_filled INT,
    PREGNANCY_INTENTION_C_NAME_filled INT,
    PREGNANCY_COUNSELED_YN_filled INT,
    BIRTH_CONTROL_COUNSELED_YN_filled INT,
    RSN_NO_BCM_COUNSELING_C_NAME_filled INT,
    INTAKE_RSN_NO_CONTRACEPTIVE_C_NAME_filled INT,
    CONTRACEPTIVE_DELIVERY_C_NAME_filled INT,
    EXIT_RSN_NO_CONTRACEPTIVE_C_NAME_filled INT,
    IS_VAP_DECLINED_YN_filled INT,
    EPISODE_UPDATE_EFF_DATE_filled INT,
    EPISODE_UPD_CREAT_RSN_C_NAME_filled INT,
    VISIT_MSG_DECLINE_YN_filled INT,
    BILL_FOR_DENIAL_YN_filled INT,
    query_error NVARCHAR(400)
);
BEGIN TRY
INSERT INTO #fc_011 (activity_year, total_rows, PAT_ENC_CSN_ID_filled, PAT_ENC_DATE_REAL_filled, CONTACT_DATE_filled, NOTIFY_REP_ADMSN_C_NAME_filled, REP_NOTIFIED_C_NAME_filled, NOTIFY_REP_COMMENTS_filled, NOTIFY_PCP_ADMSN_C_NAME_filled, PCP_NOTIFIED_C_NAME_filled, NOTIFY_PCP_COMMENTS_filled, ROC_PLANNING_PAT_ENC_CSN_ID_filled, NUM_PREV_EPSD_C_NAME_filled, SPEC_ORD_RSLT_NOT_AUTO_RLS_YN_filled, RECENTLY_AT_SCHOOL_C_NAME_filled, LMP_COMMENT_filled, CONTACT_NUM_filled, ABN_REQUIRED_YN_filled, IS_ABN_SIGNED_C_NAME_filled, MSP_IS_MEDICARE_HMO_C_NAME_filled, REG_COMMENTS_DATE_filled, AUTO_MSG_DISABLED_YN_filled, DONT_AUTO_LINK_YN_filled, RSN_FOR_NO_INC_MSG_C_NAME_filled, HAS_HORMONE_DATA_YN_filled, MEDS_REQUEST_LWS_ID_WORKSTATION_NAME_filled, EVISIT_SUBMITTED_DTTM_filled, EVISIT_TURNAROUND_IN_MINUTES_filled, PREGNANCY_INTENTION_C_NAME_filled, PREGNANCY_COUNSELED_YN_filled, BIRTH_CONTROL_COUNSELED_YN_filled, RSN_NO_BCM_COUNSELING_C_NAME_filled, INTAKE_RSN_NO_CONTRACEPTIVE_C_NAME_filled, CONTRACEPTIVE_DELIVERY_C_NAME_filled, EXIT_RSN_NO_CONTRACEPTIVE_C_NAME_filled, IS_VAP_DECLINED_YN_filled, EPISODE_UPDATE_EFF_DATE_filled, EPISODE_UPD_CREAT_RSN_C_NAME_filled, VISIT_MSG_DECLINE_YN_filled, BILL_FOR_DENIAL_YN_filled, query_error)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(PAT_ENC_DATE_REAL) AS PAT_ENC_DATE_REAL_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(NOTIFY_REP_ADMSN_C_NAME) AS NOTIFY_REP_ADMSN_C_NAME_filled,
    COUNT(REP_NOTIFIED_C_NAME) AS REP_NOTIFIED_C_NAME_filled,
    COUNT(NOTIFY_REP_COMMENTS) AS NOTIFY_REP_COMMENTS_filled,
    COUNT(NOTIFY_PCP_ADMSN_C_NAME) AS NOTIFY_PCP_ADMSN_C_NAME_filled,
    COUNT(PCP_NOTIFIED_C_NAME) AS PCP_NOTIFIED_C_NAME_filled,
    COUNT(NOTIFY_PCP_COMMENTS) AS NOTIFY_PCP_COMMENTS_filled,
    COUNT(ROC_PLANNING_PAT_ENC_CSN_ID) AS ROC_PLANNING_PAT_ENC_CSN_ID_filled,
    COUNT(NUM_PREV_EPSD_C_NAME) AS NUM_PREV_EPSD_C_NAME_filled,
    COUNT(SPEC_ORD_RSLT_NOT_AUTO_RLS_YN) AS SPEC_ORD_RSLT_NOT_AUTO_RLS_YN_filled,
    COUNT(RECENTLY_AT_SCHOOL_C_NAME) AS RECENTLY_AT_SCHOOL_C_NAME_filled,
    COUNT(LMP_COMMENT) AS LMP_COMMENT_filled,
    COUNT(CONTACT_NUM) AS CONTACT_NUM_filled,
    COUNT(ABN_REQUIRED_YN) AS ABN_REQUIRED_YN_filled,
    COUNT(IS_ABN_SIGNED_C_NAME) AS IS_ABN_SIGNED_C_NAME_filled,
    COUNT(MSP_IS_MEDICARE_HMO_C_NAME) AS MSP_IS_MEDICARE_HMO_C_NAME_filled,
    COUNT(REG_COMMENTS_DATE) AS REG_COMMENTS_DATE_filled,
    COUNT(AUTO_MSG_DISABLED_YN) AS AUTO_MSG_DISABLED_YN_filled,
    COUNT(DONT_AUTO_LINK_YN) AS DONT_AUTO_LINK_YN_filled,
    COUNT(RSN_FOR_NO_INC_MSG_C_NAME) AS RSN_FOR_NO_INC_MSG_C_NAME_filled,
    COUNT(HAS_HORMONE_DATA_YN) AS HAS_HORMONE_DATA_YN_filled,
    COUNT(MEDS_REQUEST_LWS_ID_WORKSTATION_NAME) AS MEDS_REQUEST_LWS_ID_WORKSTATION_NAME_filled,
    COUNT(EVISIT_SUBMITTED_DTTM) AS EVISIT_SUBMITTED_DTTM_filled,
    COUNT(EVISIT_TURNAROUND_IN_MINUTES) AS EVISIT_TURNAROUND_IN_MINUTES_filled,
    COUNT(PREGNANCY_INTENTION_C_NAME) AS PREGNANCY_INTENTION_C_NAME_filled,
    COUNT(PREGNANCY_COUNSELED_YN) AS PREGNANCY_COUNSELED_YN_filled,
    COUNT(BIRTH_CONTROL_COUNSELED_YN) AS BIRTH_CONTROL_COUNSELED_YN_filled,
    COUNT(RSN_NO_BCM_COUNSELING_C_NAME) AS RSN_NO_BCM_COUNSELING_C_NAME_filled,
    COUNT(INTAKE_RSN_NO_CONTRACEPTIVE_C_NAME) AS INTAKE_RSN_NO_CONTRACEPTIVE_C_NAME_filled,
    COUNT(CONTRACEPTIVE_DELIVERY_C_NAME) AS CONTRACEPTIVE_DELIVERY_C_NAME_filled,
    COUNT(EXIT_RSN_NO_CONTRACEPTIVE_C_NAME) AS EXIT_RSN_NO_CONTRACEPTIVE_C_NAME_filled,
    COUNT(IS_VAP_DECLINED_YN) AS IS_VAP_DECLINED_YN_filled,
    COUNT(EPISODE_UPDATE_EFF_DATE) AS EPISODE_UPDATE_EFF_DATE_filled,
    COUNT(EPISODE_UPD_CREAT_RSN_C_NAME) AS EPISODE_UPD_CREAT_RSN_C_NAME_filled,
    COUNT(VISIT_MSG_DECLINE_YN) AS VISIT_MSG_DECLINE_YN_filled,
    COUNT(BILL_FOR_DENIAL_YN) AS BILL_FOR_DENIAL_YN_filled,
    CAST(NULL AS NVARCHAR(400)) AS query_error
FROM PAT_ENC_7
GROUP BY YEAR(CONTACT_DATE);
END TRY
BEGIN CATCH
INSERT INTO #fc_011 (activity_year, total_rows, PAT_ENC_CSN_ID_filled, PAT_ENC_DATE_REAL_filled, CONTACT_DATE_filled, NOTIFY_REP_ADMSN_C_NAME_filled, REP_NOTIFIED_C_NAME_filled, NOTIFY_REP_COMMENTS_filled, NOTIFY_PCP_ADMSN_C_NAME_filled, PCP_NOTIFIED_C_NAME_filled, NOTIFY_PCP_COMMENTS_filled, ROC_PLANNING_PAT_ENC_CSN_ID_filled, NUM_PREV_EPSD_C_NAME_filled, SPEC_ORD_RSLT_NOT_AUTO_RLS_YN_filled, RECENTLY_AT_SCHOOL_C_NAME_filled, LMP_COMMENT_filled, CONTACT_NUM_filled, ABN_REQUIRED_YN_filled, IS_ABN_SIGNED_C_NAME_filled, MSP_IS_MEDICARE_HMO_C_NAME_filled, REG_COMMENTS_DATE_filled, AUTO_MSG_DISABLED_YN_filled, DONT_AUTO_LINK_YN_filled, RSN_FOR_NO_INC_MSG_C_NAME_filled, HAS_HORMONE_DATA_YN_filled, MEDS_REQUEST_LWS_ID_WORKSTATION_NAME_filled, EVISIT_SUBMITTED_DTTM_filled, EVISIT_TURNAROUND_IN_MINUTES_filled, PREGNANCY_INTENTION_C_NAME_filled, PREGNANCY_COUNSELED_YN_filled, BIRTH_CONTROL_COUNSELED_YN_filled, RSN_NO_BCM_COUNSELING_C_NAME_filled, INTAKE_RSN_NO_CONTRACEPTIVE_C_NAME_filled, CONTRACEPTIVE_DELIVERY_C_NAME_filled, EXIT_RSN_NO_CONTRACEPTIVE_C_NAME_filled, IS_VAP_DECLINED_YN_filled, EPISODE_UPDATE_EFF_DATE_filled, EPISODE_UPD_CREAT_RSN_C_NAME_filled, VISIT_MSG_DECLINE_YN_filled, BILL_FOR_DENIAL_YN_filled, query_error)
SELECT
    CAST(NULL AS INT) AS activity_year,
    CAST(NULL AS INT) AS total_rows,
    CAST(NULL AS INT) AS PAT_ENC_CSN_ID_filled,
    CAST(NULL AS INT) AS PAT_ENC_DATE_REAL_filled,
    CAST(NULL AS INT) AS CONTACT_DATE_filled,
    CAST(NULL AS INT) AS NOTIFY_REP_ADMSN_C_NAME_filled,
    CAST(NULL AS INT) AS REP_NOTIFIED_C_NAME_filled,
    CAST(NULL AS INT) AS NOTIFY_REP_COMMENTS_filled,
    CAST(NULL AS INT) AS NOTIFY_PCP_ADMSN_C_NAME_filled,
    CAST(NULL AS INT) AS PCP_NOTIFIED_C_NAME_filled,
    CAST(NULL AS INT) AS NOTIFY_PCP_COMMENTS_filled,
    CAST(NULL AS INT) AS ROC_PLANNING_PAT_ENC_CSN_ID_filled,
    CAST(NULL AS INT) AS NUM_PREV_EPSD_C_NAME_filled,
    CAST(NULL AS INT) AS SPEC_ORD_RSLT_NOT_AUTO_RLS_YN_filled,
    CAST(NULL AS INT) AS RECENTLY_AT_SCHOOL_C_NAME_filled,
    CAST(NULL AS INT) AS LMP_COMMENT_filled,
    CAST(NULL AS INT) AS CONTACT_NUM_filled,
    CAST(NULL AS INT) AS ABN_REQUIRED_YN_filled,
    CAST(NULL AS INT) AS IS_ABN_SIGNED_C_NAME_filled,
    CAST(NULL AS INT) AS MSP_IS_MEDICARE_HMO_C_NAME_filled,
    CAST(NULL AS INT) AS REG_COMMENTS_DATE_filled,
    CAST(NULL AS INT) AS AUTO_MSG_DISABLED_YN_filled,
    CAST(NULL AS INT) AS DONT_AUTO_LINK_YN_filled,
    CAST(NULL AS INT) AS RSN_FOR_NO_INC_MSG_C_NAME_filled,
    CAST(NULL AS INT) AS HAS_HORMONE_DATA_YN_filled,
    CAST(NULL AS INT) AS MEDS_REQUEST_LWS_ID_WORKSTATION_NAME_filled,
    CAST(NULL AS INT) AS EVISIT_SUBMITTED_DTTM_filled,
    CAST(NULL AS INT) AS EVISIT_TURNAROUND_IN_MINUTES_filled,
    CAST(NULL AS INT) AS PREGNANCY_INTENTION_C_NAME_filled,
    CAST(NULL AS INT) AS PREGNANCY_COUNSELED_YN_filled,
    CAST(NULL AS INT) AS BIRTH_CONTROL_COUNSELED_YN_filled,
    CAST(NULL AS INT) AS RSN_NO_BCM_COUNSELING_C_NAME_filled,
    CAST(NULL AS INT) AS INTAKE_RSN_NO_CONTRACEPTIVE_C_NAME_filled,
    CAST(NULL AS INT) AS CONTRACEPTIVE_DELIVERY_C_NAME_filled,
    CAST(NULL AS INT) AS EXIT_RSN_NO_CONTRACEPTIVE_C_NAME_filled,
    CAST(NULL AS INT) AS IS_VAP_DECLINED_YN_filled,
    CAST(NULL AS INT) AS EPISODE_UPDATE_EFF_DATE_filled,
    CAST(NULL AS INT) AS EPISODE_UPD_CREAT_RSN_C_NAME_filled,
    CAST(NULL AS INT) AS VISIT_MSG_DECLINE_YN_filled,
    CAST(NULL AS INT) AS BILL_FOR_DENIAL_YN_filled,
    CAST(ERROR_MESSAGE() AS NVARCHAR(400)) AS query_error;
END CATCH;

-- ---- fc_012 <- PAT_ENC_8 ----
-- This table supplements the PAT_ENC, PAT_ENC_2, PAT_ENC_3, PAT_ENC_4, PAT_ENC_5, PAT_ENC_6, and PAT_ENC_7 tables. It contains additional information related to patient encounters or
-- Bucket(s): Encounter / visit record
CREATE TABLE #fc_012 (
    activity_year INT,
    total_rows INT,
    PAT_ENC_CSN_ID_filled INT,
    PAT_ID_filled INT,
    CONTACT_DATE_filled INT,
    CM_CT_OWNER_ID_filled INT,
    EST_PREPAY_CALC_PP_PROPOSED_YN_filled INT,
    EST_PREPAY_CALC_ELIG_C_NAME_filled INT,
    PMT_PLAN_AGRMT_SCHED_PMT_ID_filled INT,
    RSLT_FOL_UP_CREAT_SRC_C_NAME_filled INT,
    BILL_DECIS_FIN_ASST_TRACKER_ID_filled INT,
    NO_FOLLOW_UP_YN_filled INT,
    MCAID_INCARCERATION_BILL_CODE_filled INT,
    MCAID_INCAR_BILL_START_DATE_filled INT,
    MEDICARE_CHANGE_C_NAME_filled INT,
    MSP_RTE_VERI_STAT_C_NAME_filled INT,
    MSP_COMP_REALTIME_TX_CSN_ID_filled INT,
    MSP_RTE_COMP_PAT_ENC_CSN_ID_filled INT,
    TAKING_PULL_REJECTED_YN_filled INT,
    HOSP_SERV_C_NAME_filled INT,
    LEVEL_OF_CARE_C_NAME_filled INT,
    ACCOMMODATION_C_NAME_filled INT,
    ACCOM_REASON_C_NAME_filled INT,
    APPT_NEEDS_BED_C_NAME_filled INT,
    APPT_BED_PREDEPT_ID_EXTERNAL_NAME_filled INT,
    APPT_BED_HOSP_SERV_C_NAME_filled INT,
    APPT_BED_POST_LEVEL_OF_CARE_C_NAME_filled INT,
    APPT_BED_CMT_S_filled INT,
    SEPARATED_GROUP_YN_filled INT,
    query_error NVARCHAR(400)
);
BEGIN TRY
INSERT INTO #fc_012 (activity_year, total_rows, PAT_ENC_CSN_ID_filled, PAT_ID_filled, CONTACT_DATE_filled, CM_CT_OWNER_ID_filled, EST_PREPAY_CALC_PP_PROPOSED_YN_filled, EST_PREPAY_CALC_ELIG_C_NAME_filled, PMT_PLAN_AGRMT_SCHED_PMT_ID_filled, RSLT_FOL_UP_CREAT_SRC_C_NAME_filled, BILL_DECIS_FIN_ASST_TRACKER_ID_filled, NO_FOLLOW_UP_YN_filled, MCAID_INCARCERATION_BILL_CODE_filled, MCAID_INCAR_BILL_START_DATE_filled, MEDICARE_CHANGE_C_NAME_filled, MSP_RTE_VERI_STAT_C_NAME_filled, MSP_COMP_REALTIME_TX_CSN_ID_filled, MSP_RTE_COMP_PAT_ENC_CSN_ID_filled, TAKING_PULL_REJECTED_YN_filled, HOSP_SERV_C_NAME_filled, LEVEL_OF_CARE_C_NAME_filled, ACCOMMODATION_C_NAME_filled, ACCOM_REASON_C_NAME_filled, APPT_NEEDS_BED_C_NAME_filled, APPT_BED_PREDEPT_ID_EXTERNAL_NAME_filled, APPT_BED_HOSP_SERV_C_NAME_filled, APPT_BED_POST_LEVEL_OF_CARE_C_NAME_filled, APPT_BED_CMT_S_filled, SEPARATED_GROUP_YN_filled, query_error)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(PAT_ID) AS PAT_ID_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(CM_CT_OWNER_ID) AS CM_CT_OWNER_ID_filled,
    COUNT(EST_PREPAY_CALC_PP_PROPOSED_YN) AS EST_PREPAY_CALC_PP_PROPOSED_YN_filled,
    COUNT(EST_PREPAY_CALC_ELIG_C_NAME) AS EST_PREPAY_CALC_ELIG_C_NAME_filled,
    COUNT(PMT_PLAN_AGRMT_SCHED_PMT_ID) AS PMT_PLAN_AGRMT_SCHED_PMT_ID_filled,
    COUNT(RSLT_FOL_UP_CREAT_SRC_C_NAME) AS RSLT_FOL_UP_CREAT_SRC_C_NAME_filled,
    COUNT(BILL_DECIS_FIN_ASST_TRACKER_ID) AS BILL_DECIS_FIN_ASST_TRACKER_ID_filled,
    COUNT(NO_FOLLOW_UP_YN) AS NO_FOLLOW_UP_YN_filled,
    COUNT(MCAID_INCARCERATION_BILL_CODE) AS MCAID_INCARCERATION_BILL_CODE_filled,
    COUNT(MCAID_INCAR_BILL_START_DATE) AS MCAID_INCAR_BILL_START_DATE_filled,
    COUNT(MEDICARE_CHANGE_C_NAME) AS MEDICARE_CHANGE_C_NAME_filled,
    COUNT(MSP_RTE_VERI_STAT_C_NAME) AS MSP_RTE_VERI_STAT_C_NAME_filled,
    COUNT(MSP_COMP_REALTIME_TX_CSN_ID) AS MSP_COMP_REALTIME_TX_CSN_ID_filled,
    COUNT(MSP_RTE_COMP_PAT_ENC_CSN_ID) AS MSP_RTE_COMP_PAT_ENC_CSN_ID_filled,
    COUNT(TAKING_PULL_REJECTED_YN) AS TAKING_PULL_REJECTED_YN_filled,
    COUNT(HOSP_SERV_C_NAME) AS HOSP_SERV_C_NAME_filled,
    COUNT(LEVEL_OF_CARE_C_NAME) AS LEVEL_OF_CARE_C_NAME_filled,
    COUNT(ACCOMMODATION_C_NAME) AS ACCOMMODATION_C_NAME_filled,
    COUNT(ACCOM_REASON_C_NAME) AS ACCOM_REASON_C_NAME_filled,
    COUNT(APPT_NEEDS_BED_C_NAME) AS APPT_NEEDS_BED_C_NAME_filled,
    COUNT(APPT_BED_PREDEPT_ID_EXTERNAL_NAME) AS APPT_BED_PREDEPT_ID_EXTERNAL_NAME_filled,
    COUNT(APPT_BED_HOSP_SERV_C_NAME) AS APPT_BED_HOSP_SERV_C_NAME_filled,
    COUNT(APPT_BED_POST_LEVEL_OF_CARE_C_NAME) AS APPT_BED_POST_LEVEL_OF_CARE_C_NAME_filled,
    COUNT(APPT_BED_CMT_S) AS APPT_BED_CMT_S_filled,
    COUNT(SEPARATED_GROUP_YN) AS SEPARATED_GROUP_YN_filled,
    CAST(NULL AS NVARCHAR(400)) AS query_error
FROM PAT_ENC_8
GROUP BY YEAR(CONTACT_DATE);
END TRY
BEGIN CATCH
INSERT INTO #fc_012 (activity_year, total_rows, PAT_ENC_CSN_ID_filled, PAT_ID_filled, CONTACT_DATE_filled, CM_CT_OWNER_ID_filled, EST_PREPAY_CALC_PP_PROPOSED_YN_filled, EST_PREPAY_CALC_ELIG_C_NAME_filled, PMT_PLAN_AGRMT_SCHED_PMT_ID_filled, RSLT_FOL_UP_CREAT_SRC_C_NAME_filled, BILL_DECIS_FIN_ASST_TRACKER_ID_filled, NO_FOLLOW_UP_YN_filled, MCAID_INCARCERATION_BILL_CODE_filled, MCAID_INCAR_BILL_START_DATE_filled, MEDICARE_CHANGE_C_NAME_filled, MSP_RTE_VERI_STAT_C_NAME_filled, MSP_COMP_REALTIME_TX_CSN_ID_filled, MSP_RTE_COMP_PAT_ENC_CSN_ID_filled, TAKING_PULL_REJECTED_YN_filled, HOSP_SERV_C_NAME_filled, LEVEL_OF_CARE_C_NAME_filled, ACCOMMODATION_C_NAME_filled, ACCOM_REASON_C_NAME_filled, APPT_NEEDS_BED_C_NAME_filled, APPT_BED_PREDEPT_ID_EXTERNAL_NAME_filled, APPT_BED_HOSP_SERV_C_NAME_filled, APPT_BED_POST_LEVEL_OF_CARE_C_NAME_filled, APPT_BED_CMT_S_filled, SEPARATED_GROUP_YN_filled, query_error)
SELECT
    CAST(NULL AS INT) AS activity_year,
    CAST(NULL AS INT) AS total_rows,
    CAST(NULL AS INT) AS PAT_ENC_CSN_ID_filled,
    CAST(NULL AS INT) AS PAT_ID_filled,
    CAST(NULL AS INT) AS CONTACT_DATE_filled,
    CAST(NULL AS INT) AS CM_CT_OWNER_ID_filled,
    CAST(NULL AS INT) AS EST_PREPAY_CALC_PP_PROPOSED_YN_filled,
    CAST(NULL AS INT) AS EST_PREPAY_CALC_ELIG_C_NAME_filled,
    CAST(NULL AS INT) AS PMT_PLAN_AGRMT_SCHED_PMT_ID_filled,
    CAST(NULL AS INT) AS RSLT_FOL_UP_CREAT_SRC_C_NAME_filled,
    CAST(NULL AS INT) AS BILL_DECIS_FIN_ASST_TRACKER_ID_filled,
    CAST(NULL AS INT) AS NO_FOLLOW_UP_YN_filled,
    CAST(NULL AS INT) AS MCAID_INCARCERATION_BILL_CODE_filled,
    CAST(NULL AS INT) AS MCAID_INCAR_BILL_START_DATE_filled,
    CAST(NULL AS INT) AS MEDICARE_CHANGE_C_NAME_filled,
    CAST(NULL AS INT) AS MSP_RTE_VERI_STAT_C_NAME_filled,
    CAST(NULL AS INT) AS MSP_COMP_REALTIME_TX_CSN_ID_filled,
    CAST(NULL AS INT) AS MSP_RTE_COMP_PAT_ENC_CSN_ID_filled,
    CAST(NULL AS INT) AS TAKING_PULL_REJECTED_YN_filled,
    CAST(NULL AS INT) AS HOSP_SERV_C_NAME_filled,
    CAST(NULL AS INT) AS LEVEL_OF_CARE_C_NAME_filled,
    CAST(NULL AS INT) AS ACCOMMODATION_C_NAME_filled,
    CAST(NULL AS INT) AS ACCOM_REASON_C_NAME_filled,
    CAST(NULL AS INT) AS APPT_NEEDS_BED_C_NAME_filled,
    CAST(NULL AS INT) AS APPT_BED_PREDEPT_ID_EXTERNAL_NAME_filled,
    CAST(NULL AS INT) AS APPT_BED_HOSP_SERV_C_NAME_filled,
    CAST(NULL AS INT) AS APPT_BED_POST_LEVEL_OF_CARE_C_NAME_filled,
    CAST(NULL AS INT) AS APPT_BED_CMT_S_filled,
    CAST(NULL AS INT) AS SEPARATED_GROUP_YN_filled,
    CAST(ERROR_MESSAGE() AS NVARCHAR(400)) AS query_error;
END CATCH;

-- ---- fc_013 <- PAT_ENC_APPT ----
-- The PAT_ENC_APPT table contains basic information about the appointment records in your system. Since one patient encounter can be an appointment with multiple providers and resour
-- Bucket(s): Appointment / scheduling status
CREATE TABLE #fc_013 (
    activity_year INT,
    total_rows INT,
    PAT_ENC_CSN_ID_filled INT,
    LINE_filled INT,
    CONTACT_DATE_filled INT,
    DEPARTMENT_ID_EXTERNAL_NAME_filled INT,
    PROV_START_TIME_filled INT,
    APPT_PROV_PRIMARY_SPECIALTY_C_NAME_filled INT,
    query_error NVARCHAR(400)
);
BEGIN TRY
INSERT INTO #fc_013 (activity_year, total_rows, PAT_ENC_CSN_ID_filled, LINE_filled, CONTACT_DATE_filled, DEPARTMENT_ID_EXTERNAL_NAME_filled, PROV_START_TIME_filled, APPT_PROV_PRIMARY_SPECIALTY_C_NAME_filled, query_error)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(DEPARTMENT_ID_EXTERNAL_NAME) AS DEPARTMENT_ID_EXTERNAL_NAME_filled,
    COUNT(PROV_START_TIME) AS PROV_START_TIME_filled,
    COUNT(APPT_PROV_PRIMARY_SPECIALTY_C_NAME) AS APPT_PROV_PRIMARY_SPECIALTY_C_NAME_filled,
    CAST(NULL AS NVARCHAR(400)) AS query_error
FROM PAT_ENC_APPT
GROUP BY YEAR(CONTACT_DATE);
END TRY
BEGIN CATCH
INSERT INTO #fc_013 (activity_year, total_rows, PAT_ENC_CSN_ID_filled, LINE_filled, CONTACT_DATE_filled, DEPARTMENT_ID_EXTERNAL_NAME_filled, PROV_START_TIME_filled, APPT_PROV_PRIMARY_SPECIALTY_C_NAME_filled, query_error)
SELECT
    CAST(NULL AS INT) AS activity_year,
    CAST(NULL AS INT) AS total_rows,
    CAST(NULL AS INT) AS PAT_ENC_CSN_ID_filled,
    CAST(NULL AS INT) AS LINE_filled,
    CAST(NULL AS INT) AS CONTACT_DATE_filled,
    CAST(NULL AS INT) AS DEPARTMENT_ID_EXTERNAL_NAME_filled,
    CAST(NULL AS INT) AS PROV_START_TIME_filled,
    CAST(NULL AS INT) AS APPT_PROV_PRIMARY_SPECIALTY_C_NAME_filled,
    CAST(ERROR_MESSAGE() AS NVARCHAR(400)) AS query_error;
END CATCH;

-- ---- fc_014 <- PAT_ENC_HSP ----
-- This table is the primary table for hospital encounter information. A hospital encounter is a contact in the patient record created through an ADT workflow such as preadmission, ad
-- Bucket(s): Encounter / visit record
CREATE TABLE #fc_014 (
    activity_year INT,
    total_rows INT,
    PAT_ENC_CSN_ID_filled INT,
    ADT_PAT_CLASS_C_NAME_filled INT,
    ADT_PATIENT_STAT_C_NAME_filled INT,
    LEVEL_OF_CARE_C_NAME_filled INT,
    PENDING_DISCH_TIME_filled INT,
    DISCH_CODE_C_NAME_filled INT,
    ADT_ATHCRT_STAT_C_NAME_filled INT,
    PREADM_UNDO_RSN_C_NAME_filled INT,
    EXP_ADMISSION_TIME_filled INT,
    EXP_LEN_OF_STAY_filled INT,
    EXP_DISCHARGE_DATE_filled INT,
    ADMIT_CATEGORY_C_NAME_filled INT,
    ADMIT_SOURCE_C_NAME_filled INT,
    TYPE_OF_ROOM_C_NAME_filled INT,
    TYPE_OF_BED_C_NAME_filled INT,
    RSN_FOR_BED_C_NAME_filled INT,
    DELIVERY_TYPE_C_NAME_filled INT,
    LABOR_STATUS_C_NAME_filled INT,
    ER_INJURY_filled INT,
    ADT_ARRIVAL_TIME_filled INT,
    ADT_ARRIVAL_STS_C_NAME_filled INT,
    HOSP_ADMSN_TIME_filled INT,
    ADMIT_CONF_STAT_C_NAME_filled INT,
    HOSP_DISCH_TIME_filled INT,
    HOSP_ADMSN_TYPE_C_NAME_filled INT,
    ROOM_ID_ROOM_NAME_filled INT,
    HOSP_SERV_C_NAME_filled INT,
    MEANS_OF_DEPART_C_NAME_filled INT,
    DISCH_DISP_C_NAME_filled INT,
    DISCH_DEST_C_NAME_filled INT,
    TRANSFER_FROM_C_NAME_filled INT,
    MEANS_OF_ARRV_C_NAME_filled INT,
    ACUITY_LEVEL_C_NAME_filled INT,
    HOSPIST_NEEDED_YN_filled INT,
    ACCOMMODATION_C_NAME_filled INT,
    ACCOM_REASON_C_NAME_filled INT,
    INPATIENT_DATA_ID_filled INT,
    PVT_HSP_ENC_C_NAME_filled INT,
    ED_EPISODE_ID_filled INT,
    ED_DISPOSITION_C_NAME_filled INT,
    ED_DISP_TIME_filled INT,
    FOLLOWUP_PROV_ID_PROV_NAME_filled INT,
    PROV_CONT_INFO_filled INT,
    OSHPD_ADMSN_SRC_C_NAME_filled INT,
    OSHPD_LICENSURE_C_NAME_filled INT,
    OSHPD_ROUTE_C_NAME_filled INT,
    INP_ADM_DATE_filled INT,
    COPY_TO_PCP_YN_filled INT,
    ADOPTION_CASE_YN_filled INT,
    PREOP_TEACHING_C_NAME_filled INT,
    PREOP_PRN_EVAL_C_NAME_filled INT,
    PREOP_PH_SCREEN_C_NAME_filled INT,
    LABOR_ACT_BIRTH_C_NAME_filled INT,
    LABOR_FEED_TYPE_C_NAME_filled INT,
    PROC_SERV_C_NAME_filled INT,
    ED_DEPARTURE_TIME_filled INT,
    TRIAGE_DATETIME_filled INT,
    TRIAGE_STATUS_C_NAME_filled INT,
    INP_ADM_EVENT_ID_filled INT,
    INP_ADM_EVENT_DATE_filled INT,
    INP_DWNGRD_EVNT_ID_filled INT,
    INP_DWNGRD_DATE_filled INT,
    INP_DWNGRD_EVNT_DT_filled INT,
    OP_ADM_DATE_filled INT,
    EMER_ADM_DATE_filled INT,
    OP_ADM_EVENT_ID_filled INT,
    EMER_ADM_EVENT_ID_filled INT,
    PREREG_SOURCE_C_NAME_filled INT,
    HOV_CONF_STATUS_C_NAME_filled INT,
    RELIG_NEEDS_VISIT_C_NAME_filled INT,
    DISCHARGE_CAT_C_NAME_filled INT,
    EXP_DISCHARGE_TIME_filled INT,
    BILL_ATTEND_PROV_ID_PROV_NAME_filled INT,
    OB_LD_LABORING_YN_filled INT,
    OB_LD_LABOR_TM_filled INT,
    TRIAGE_ID_TAG_filled INT,
    TRIAGE_ID_TAG_CMT_filled INT,
    TPLNT_BILL_STAT_C_NAME_filled INT,
    ACTL_DELIVRY_METH_C_NAME_filled INT,
    PRENATAL_CARE_C_NAME_filled INT,
    AMBULANCE_CODE_C_NAME_filled INT,
    MSE_DATE_filled INT,
    ADMIT_PROV_TEXT_filled INT,
    ATTEND_PROV_TEXT_filled INT,
    PROV_PRIM_TEXT_filled INT,
    PROV_PRIM_TEXT_PHON_filled INT,
    HOSPITAL_AREA_ID_LOC_NAME_filled INT,
    CHIEF_COMPLAINT_C_NAME_filled INT,
    NEED_FIN_CLR_YN_filled INT,
    query_error NVARCHAR(400)
);
BEGIN TRY
INSERT INTO #fc_014 (activity_year, total_rows, PAT_ENC_CSN_ID_filled, ADT_PAT_CLASS_C_NAME_filled, ADT_PATIENT_STAT_C_NAME_filled, LEVEL_OF_CARE_C_NAME_filled, PENDING_DISCH_TIME_filled, DISCH_CODE_C_NAME_filled, ADT_ATHCRT_STAT_C_NAME_filled, PREADM_UNDO_RSN_C_NAME_filled, EXP_ADMISSION_TIME_filled, EXP_LEN_OF_STAY_filled, EXP_DISCHARGE_DATE_filled, ADMIT_CATEGORY_C_NAME_filled, ADMIT_SOURCE_C_NAME_filled, TYPE_OF_ROOM_C_NAME_filled, TYPE_OF_BED_C_NAME_filled, RSN_FOR_BED_C_NAME_filled, DELIVERY_TYPE_C_NAME_filled, LABOR_STATUS_C_NAME_filled, ER_INJURY_filled, ADT_ARRIVAL_TIME_filled, ADT_ARRIVAL_STS_C_NAME_filled, HOSP_ADMSN_TIME_filled, ADMIT_CONF_STAT_C_NAME_filled, HOSP_DISCH_TIME_filled, HOSP_ADMSN_TYPE_C_NAME_filled, ROOM_ID_ROOM_NAME_filled, HOSP_SERV_C_NAME_filled, MEANS_OF_DEPART_C_NAME_filled, DISCH_DISP_C_NAME_filled, DISCH_DEST_C_NAME_filled, TRANSFER_FROM_C_NAME_filled, MEANS_OF_ARRV_C_NAME_filled, ACUITY_LEVEL_C_NAME_filled, HOSPIST_NEEDED_YN_filled, ACCOMMODATION_C_NAME_filled, ACCOM_REASON_C_NAME_filled, INPATIENT_DATA_ID_filled, PVT_HSP_ENC_C_NAME_filled, ED_EPISODE_ID_filled, ED_DISPOSITION_C_NAME_filled, ED_DISP_TIME_filled, FOLLOWUP_PROV_ID_PROV_NAME_filled, PROV_CONT_INFO_filled, OSHPD_ADMSN_SRC_C_NAME_filled, OSHPD_LICENSURE_C_NAME_filled, OSHPD_ROUTE_C_NAME_filled, INP_ADM_DATE_filled, COPY_TO_PCP_YN_filled, ADOPTION_CASE_YN_filled, PREOP_TEACHING_C_NAME_filled, PREOP_PRN_EVAL_C_NAME_filled, PREOP_PH_SCREEN_C_NAME_filled, LABOR_ACT_BIRTH_C_NAME_filled, LABOR_FEED_TYPE_C_NAME_filled, PROC_SERV_C_NAME_filled, ED_DEPARTURE_TIME_filled, TRIAGE_DATETIME_filled, TRIAGE_STATUS_C_NAME_filled, INP_ADM_EVENT_ID_filled, INP_ADM_EVENT_DATE_filled, INP_DWNGRD_EVNT_ID_filled, INP_DWNGRD_DATE_filled, INP_DWNGRD_EVNT_DT_filled, OP_ADM_DATE_filled, EMER_ADM_DATE_filled, OP_ADM_EVENT_ID_filled, EMER_ADM_EVENT_ID_filled, PREREG_SOURCE_C_NAME_filled, HOV_CONF_STATUS_C_NAME_filled, RELIG_NEEDS_VISIT_C_NAME_filled, DISCHARGE_CAT_C_NAME_filled, EXP_DISCHARGE_TIME_filled, BILL_ATTEND_PROV_ID_PROV_NAME_filled, OB_LD_LABORING_YN_filled, OB_LD_LABOR_TM_filled, TRIAGE_ID_TAG_filled, TRIAGE_ID_TAG_CMT_filled, TPLNT_BILL_STAT_C_NAME_filled, ACTL_DELIVRY_METH_C_NAME_filled, PRENATAL_CARE_C_NAME_filled, AMBULANCE_CODE_C_NAME_filled, MSE_DATE_filled, ADMIT_PROV_TEXT_filled, ATTEND_PROV_TEXT_filled, PROV_PRIM_TEXT_filled, PROV_PRIM_TEXT_PHON_filled, HOSPITAL_AREA_ID_LOC_NAME_filled, CHIEF_COMPLAINT_C_NAME_filled, NEED_FIN_CLR_YN_filled, query_error)
SELECT
    YEAR(EXP_DISCHARGE_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(ADT_PAT_CLASS_C_NAME) AS ADT_PAT_CLASS_C_NAME_filled,
    COUNT(ADT_PATIENT_STAT_C_NAME) AS ADT_PATIENT_STAT_C_NAME_filled,
    COUNT(LEVEL_OF_CARE_C_NAME) AS LEVEL_OF_CARE_C_NAME_filled,
    COUNT(PENDING_DISCH_TIME) AS PENDING_DISCH_TIME_filled,
    COUNT(DISCH_CODE_C_NAME) AS DISCH_CODE_C_NAME_filled,
    COUNT(ADT_ATHCRT_STAT_C_NAME) AS ADT_ATHCRT_STAT_C_NAME_filled,
    COUNT(PREADM_UNDO_RSN_C_NAME) AS PREADM_UNDO_RSN_C_NAME_filled,
    COUNT(EXP_ADMISSION_TIME) AS EXP_ADMISSION_TIME_filled,
    COUNT(EXP_LEN_OF_STAY) AS EXP_LEN_OF_STAY_filled,
    COUNT(EXP_DISCHARGE_DATE) AS EXP_DISCHARGE_DATE_filled,
    COUNT(ADMIT_CATEGORY_C_NAME) AS ADMIT_CATEGORY_C_NAME_filled,
    COUNT(ADMIT_SOURCE_C_NAME) AS ADMIT_SOURCE_C_NAME_filled,
    COUNT(TYPE_OF_ROOM_C_NAME) AS TYPE_OF_ROOM_C_NAME_filled,
    COUNT(TYPE_OF_BED_C_NAME) AS TYPE_OF_BED_C_NAME_filled,
    COUNT(RSN_FOR_BED_C_NAME) AS RSN_FOR_BED_C_NAME_filled,
    COUNT(DELIVERY_TYPE_C_NAME) AS DELIVERY_TYPE_C_NAME_filled,
    COUNT(LABOR_STATUS_C_NAME) AS LABOR_STATUS_C_NAME_filled,
    COUNT(ER_INJURY) AS ER_INJURY_filled,
    COUNT(ADT_ARRIVAL_TIME) AS ADT_ARRIVAL_TIME_filled,
    COUNT(ADT_ARRIVAL_STS_C_NAME) AS ADT_ARRIVAL_STS_C_NAME_filled,
    COUNT(HOSP_ADMSN_TIME) AS HOSP_ADMSN_TIME_filled,
    COUNT(ADMIT_CONF_STAT_C_NAME) AS ADMIT_CONF_STAT_C_NAME_filled,
    COUNT(HOSP_DISCH_TIME) AS HOSP_DISCH_TIME_filled,
    COUNT(HOSP_ADMSN_TYPE_C_NAME) AS HOSP_ADMSN_TYPE_C_NAME_filled,
    COUNT(ROOM_ID_ROOM_NAME) AS ROOM_ID_ROOM_NAME_filled,
    COUNT(HOSP_SERV_C_NAME) AS HOSP_SERV_C_NAME_filled,
    COUNT(MEANS_OF_DEPART_C_NAME) AS MEANS_OF_DEPART_C_NAME_filled,
    COUNT(DISCH_DISP_C_NAME) AS DISCH_DISP_C_NAME_filled,
    COUNT(DISCH_DEST_C_NAME) AS DISCH_DEST_C_NAME_filled,
    COUNT(TRANSFER_FROM_C_NAME) AS TRANSFER_FROM_C_NAME_filled,
    COUNT(MEANS_OF_ARRV_C_NAME) AS MEANS_OF_ARRV_C_NAME_filled,
    COUNT(ACUITY_LEVEL_C_NAME) AS ACUITY_LEVEL_C_NAME_filled,
    COUNT(HOSPIST_NEEDED_YN) AS HOSPIST_NEEDED_YN_filled,
    COUNT(ACCOMMODATION_C_NAME) AS ACCOMMODATION_C_NAME_filled,
    COUNT(ACCOM_REASON_C_NAME) AS ACCOM_REASON_C_NAME_filled,
    COUNT(INPATIENT_DATA_ID) AS INPATIENT_DATA_ID_filled,
    COUNT(PVT_HSP_ENC_C_NAME) AS PVT_HSP_ENC_C_NAME_filled,
    COUNT(ED_EPISODE_ID) AS ED_EPISODE_ID_filled,
    COUNT(ED_DISPOSITION_C_NAME) AS ED_DISPOSITION_C_NAME_filled,
    COUNT(ED_DISP_TIME) AS ED_DISP_TIME_filled,
    COUNT(FOLLOWUP_PROV_ID_PROV_NAME) AS FOLLOWUP_PROV_ID_PROV_NAME_filled,
    COUNT(PROV_CONT_INFO) AS PROV_CONT_INFO_filled,
    COUNT(OSHPD_ADMSN_SRC_C_NAME) AS OSHPD_ADMSN_SRC_C_NAME_filled,
    COUNT(OSHPD_LICENSURE_C_NAME) AS OSHPD_LICENSURE_C_NAME_filled,
    COUNT(OSHPD_ROUTE_C_NAME) AS OSHPD_ROUTE_C_NAME_filled,
    COUNT(INP_ADM_DATE) AS INP_ADM_DATE_filled,
    COUNT(COPY_TO_PCP_YN) AS COPY_TO_PCP_YN_filled,
    COUNT(ADOPTION_CASE_YN) AS ADOPTION_CASE_YN_filled,
    COUNT(PREOP_TEACHING_C_NAME) AS PREOP_TEACHING_C_NAME_filled,
    COUNT(PREOP_PRN_EVAL_C_NAME) AS PREOP_PRN_EVAL_C_NAME_filled,
    COUNT(PREOP_PH_SCREEN_C_NAME) AS PREOP_PH_SCREEN_C_NAME_filled,
    COUNT(LABOR_ACT_BIRTH_C_NAME) AS LABOR_ACT_BIRTH_C_NAME_filled,
    COUNT(LABOR_FEED_TYPE_C_NAME) AS LABOR_FEED_TYPE_C_NAME_filled,
    COUNT(PROC_SERV_C_NAME) AS PROC_SERV_C_NAME_filled,
    COUNT(ED_DEPARTURE_TIME) AS ED_DEPARTURE_TIME_filled,
    COUNT(TRIAGE_DATETIME) AS TRIAGE_DATETIME_filled,
    COUNT(TRIAGE_STATUS_C_NAME) AS TRIAGE_STATUS_C_NAME_filled,
    COUNT(INP_ADM_EVENT_ID) AS INP_ADM_EVENT_ID_filled,
    COUNT(INP_ADM_EVENT_DATE) AS INP_ADM_EVENT_DATE_filled,
    COUNT(INP_DWNGRD_EVNT_ID) AS INP_DWNGRD_EVNT_ID_filled,
    COUNT(INP_DWNGRD_DATE) AS INP_DWNGRD_DATE_filled,
    COUNT(INP_DWNGRD_EVNT_DT) AS INP_DWNGRD_EVNT_DT_filled,
    COUNT(OP_ADM_DATE) AS OP_ADM_DATE_filled,
    COUNT(EMER_ADM_DATE) AS EMER_ADM_DATE_filled,
    COUNT(OP_ADM_EVENT_ID) AS OP_ADM_EVENT_ID_filled,
    COUNT(EMER_ADM_EVENT_ID) AS EMER_ADM_EVENT_ID_filled,
    COUNT(PREREG_SOURCE_C_NAME) AS PREREG_SOURCE_C_NAME_filled,
    COUNT(HOV_CONF_STATUS_C_NAME) AS HOV_CONF_STATUS_C_NAME_filled,
    COUNT(RELIG_NEEDS_VISIT_C_NAME) AS RELIG_NEEDS_VISIT_C_NAME_filled,
    COUNT(DISCHARGE_CAT_C_NAME) AS DISCHARGE_CAT_C_NAME_filled,
    COUNT(EXP_DISCHARGE_TIME) AS EXP_DISCHARGE_TIME_filled,
    COUNT(BILL_ATTEND_PROV_ID_PROV_NAME) AS BILL_ATTEND_PROV_ID_PROV_NAME_filled,
    COUNT(OB_LD_LABORING_YN) AS OB_LD_LABORING_YN_filled,
    COUNT(OB_LD_LABOR_TM) AS OB_LD_LABOR_TM_filled,
    COUNT(TRIAGE_ID_TAG) AS TRIAGE_ID_TAG_filled,
    COUNT(TRIAGE_ID_TAG_CMT) AS TRIAGE_ID_TAG_CMT_filled,
    COUNT(TPLNT_BILL_STAT_C_NAME) AS TPLNT_BILL_STAT_C_NAME_filled,
    COUNT(ACTL_DELIVRY_METH_C_NAME) AS ACTL_DELIVRY_METH_C_NAME_filled,
    COUNT(PRENATAL_CARE_C_NAME) AS PRENATAL_CARE_C_NAME_filled,
    COUNT(AMBULANCE_CODE_C_NAME) AS AMBULANCE_CODE_C_NAME_filled,
    COUNT(MSE_DATE) AS MSE_DATE_filled,
    COUNT(ADMIT_PROV_TEXT) AS ADMIT_PROV_TEXT_filled,
    COUNT(ATTEND_PROV_TEXT) AS ATTEND_PROV_TEXT_filled,
    COUNT(PROV_PRIM_TEXT) AS PROV_PRIM_TEXT_filled,
    COUNT(PROV_PRIM_TEXT_PHON) AS PROV_PRIM_TEXT_PHON_filled,
    COUNT(HOSPITAL_AREA_ID_LOC_NAME) AS HOSPITAL_AREA_ID_LOC_NAME_filled,
    COUNT(CHIEF_COMPLAINT_C_NAME) AS CHIEF_COMPLAINT_C_NAME_filled,
    COUNT(NEED_FIN_CLR_YN) AS NEED_FIN_CLR_YN_filled,
    CAST(NULL AS NVARCHAR(400)) AS query_error
FROM PAT_ENC_HSP
GROUP BY YEAR(EXP_DISCHARGE_DATE);
END TRY
BEGIN CATCH
INSERT INTO #fc_014 (activity_year, total_rows, PAT_ENC_CSN_ID_filled, ADT_PAT_CLASS_C_NAME_filled, ADT_PATIENT_STAT_C_NAME_filled, LEVEL_OF_CARE_C_NAME_filled, PENDING_DISCH_TIME_filled, DISCH_CODE_C_NAME_filled, ADT_ATHCRT_STAT_C_NAME_filled, PREADM_UNDO_RSN_C_NAME_filled, EXP_ADMISSION_TIME_filled, EXP_LEN_OF_STAY_filled, EXP_DISCHARGE_DATE_filled, ADMIT_CATEGORY_C_NAME_filled, ADMIT_SOURCE_C_NAME_filled, TYPE_OF_ROOM_C_NAME_filled, TYPE_OF_BED_C_NAME_filled, RSN_FOR_BED_C_NAME_filled, DELIVERY_TYPE_C_NAME_filled, LABOR_STATUS_C_NAME_filled, ER_INJURY_filled, ADT_ARRIVAL_TIME_filled, ADT_ARRIVAL_STS_C_NAME_filled, HOSP_ADMSN_TIME_filled, ADMIT_CONF_STAT_C_NAME_filled, HOSP_DISCH_TIME_filled, HOSP_ADMSN_TYPE_C_NAME_filled, ROOM_ID_ROOM_NAME_filled, HOSP_SERV_C_NAME_filled, MEANS_OF_DEPART_C_NAME_filled, DISCH_DISP_C_NAME_filled, DISCH_DEST_C_NAME_filled, TRANSFER_FROM_C_NAME_filled, MEANS_OF_ARRV_C_NAME_filled, ACUITY_LEVEL_C_NAME_filled, HOSPIST_NEEDED_YN_filled, ACCOMMODATION_C_NAME_filled, ACCOM_REASON_C_NAME_filled, INPATIENT_DATA_ID_filled, PVT_HSP_ENC_C_NAME_filled, ED_EPISODE_ID_filled, ED_DISPOSITION_C_NAME_filled, ED_DISP_TIME_filled, FOLLOWUP_PROV_ID_PROV_NAME_filled, PROV_CONT_INFO_filled, OSHPD_ADMSN_SRC_C_NAME_filled, OSHPD_LICENSURE_C_NAME_filled, OSHPD_ROUTE_C_NAME_filled, INP_ADM_DATE_filled, COPY_TO_PCP_YN_filled, ADOPTION_CASE_YN_filled, PREOP_TEACHING_C_NAME_filled, PREOP_PRN_EVAL_C_NAME_filled, PREOP_PH_SCREEN_C_NAME_filled, LABOR_ACT_BIRTH_C_NAME_filled, LABOR_FEED_TYPE_C_NAME_filled, PROC_SERV_C_NAME_filled, ED_DEPARTURE_TIME_filled, TRIAGE_DATETIME_filled, TRIAGE_STATUS_C_NAME_filled, INP_ADM_EVENT_ID_filled, INP_ADM_EVENT_DATE_filled, INP_DWNGRD_EVNT_ID_filled, INP_DWNGRD_DATE_filled, INP_DWNGRD_EVNT_DT_filled, OP_ADM_DATE_filled, EMER_ADM_DATE_filled, OP_ADM_EVENT_ID_filled, EMER_ADM_EVENT_ID_filled, PREREG_SOURCE_C_NAME_filled, HOV_CONF_STATUS_C_NAME_filled, RELIG_NEEDS_VISIT_C_NAME_filled, DISCHARGE_CAT_C_NAME_filled, EXP_DISCHARGE_TIME_filled, BILL_ATTEND_PROV_ID_PROV_NAME_filled, OB_LD_LABORING_YN_filled, OB_LD_LABOR_TM_filled, TRIAGE_ID_TAG_filled, TRIAGE_ID_TAG_CMT_filled, TPLNT_BILL_STAT_C_NAME_filled, ACTL_DELIVRY_METH_C_NAME_filled, PRENATAL_CARE_C_NAME_filled, AMBULANCE_CODE_C_NAME_filled, MSE_DATE_filled, ADMIT_PROV_TEXT_filled, ATTEND_PROV_TEXT_filled, PROV_PRIM_TEXT_filled, PROV_PRIM_TEXT_PHON_filled, HOSPITAL_AREA_ID_LOC_NAME_filled, CHIEF_COMPLAINT_C_NAME_filled, NEED_FIN_CLR_YN_filled, query_error)
SELECT
    CAST(NULL AS INT) AS activity_year,
    CAST(NULL AS INT) AS total_rows,
    CAST(NULL AS INT) AS PAT_ENC_CSN_ID_filled,
    CAST(NULL AS INT) AS ADT_PAT_CLASS_C_NAME_filled,
    CAST(NULL AS INT) AS ADT_PATIENT_STAT_C_NAME_filled,
    CAST(NULL AS INT) AS LEVEL_OF_CARE_C_NAME_filled,
    CAST(NULL AS INT) AS PENDING_DISCH_TIME_filled,
    CAST(NULL AS INT) AS DISCH_CODE_C_NAME_filled,
    CAST(NULL AS INT) AS ADT_ATHCRT_STAT_C_NAME_filled,
    CAST(NULL AS INT) AS PREADM_UNDO_RSN_C_NAME_filled,
    CAST(NULL AS INT) AS EXP_ADMISSION_TIME_filled,
    CAST(NULL AS INT) AS EXP_LEN_OF_STAY_filled,
    CAST(NULL AS INT) AS EXP_DISCHARGE_DATE_filled,
    CAST(NULL AS INT) AS ADMIT_CATEGORY_C_NAME_filled,
    CAST(NULL AS INT) AS ADMIT_SOURCE_C_NAME_filled,
    CAST(NULL AS INT) AS TYPE_OF_ROOM_C_NAME_filled,
    CAST(NULL AS INT) AS TYPE_OF_BED_C_NAME_filled,
    CAST(NULL AS INT) AS RSN_FOR_BED_C_NAME_filled,
    CAST(NULL AS INT) AS DELIVERY_TYPE_C_NAME_filled,
    CAST(NULL AS INT) AS LABOR_STATUS_C_NAME_filled,
    CAST(NULL AS INT) AS ER_INJURY_filled,
    CAST(NULL AS INT) AS ADT_ARRIVAL_TIME_filled,
    CAST(NULL AS INT) AS ADT_ARRIVAL_STS_C_NAME_filled,
    CAST(NULL AS INT) AS HOSP_ADMSN_TIME_filled,
    CAST(NULL AS INT) AS ADMIT_CONF_STAT_C_NAME_filled,
    CAST(NULL AS INT) AS HOSP_DISCH_TIME_filled,
    CAST(NULL AS INT) AS HOSP_ADMSN_TYPE_C_NAME_filled,
    CAST(NULL AS INT) AS ROOM_ID_ROOM_NAME_filled,
    CAST(NULL AS INT) AS HOSP_SERV_C_NAME_filled,
    CAST(NULL AS INT) AS MEANS_OF_DEPART_C_NAME_filled,
    CAST(NULL AS INT) AS DISCH_DISP_C_NAME_filled,
    CAST(NULL AS INT) AS DISCH_DEST_C_NAME_filled,
    CAST(NULL AS INT) AS TRANSFER_FROM_C_NAME_filled,
    CAST(NULL AS INT) AS MEANS_OF_ARRV_C_NAME_filled,
    CAST(NULL AS INT) AS ACUITY_LEVEL_C_NAME_filled,
    CAST(NULL AS INT) AS HOSPIST_NEEDED_YN_filled,
    CAST(NULL AS INT) AS ACCOMMODATION_C_NAME_filled,
    CAST(NULL AS INT) AS ACCOM_REASON_C_NAME_filled,
    CAST(NULL AS INT) AS INPATIENT_DATA_ID_filled,
    CAST(NULL AS INT) AS PVT_HSP_ENC_C_NAME_filled,
    CAST(NULL AS INT) AS ED_EPISODE_ID_filled,
    CAST(NULL AS INT) AS ED_DISPOSITION_C_NAME_filled,
    CAST(NULL AS INT) AS ED_DISP_TIME_filled,
    CAST(NULL AS INT) AS FOLLOWUP_PROV_ID_PROV_NAME_filled,
    CAST(NULL AS INT) AS PROV_CONT_INFO_filled,
    CAST(NULL AS INT) AS OSHPD_ADMSN_SRC_C_NAME_filled,
    CAST(NULL AS INT) AS OSHPD_LICENSURE_C_NAME_filled,
    CAST(NULL AS INT) AS OSHPD_ROUTE_C_NAME_filled,
    CAST(NULL AS INT) AS INP_ADM_DATE_filled,
    CAST(NULL AS INT) AS COPY_TO_PCP_YN_filled,
    CAST(NULL AS INT) AS ADOPTION_CASE_YN_filled,
    CAST(NULL AS INT) AS PREOP_TEACHING_C_NAME_filled,
    CAST(NULL AS INT) AS PREOP_PRN_EVAL_C_NAME_filled,
    CAST(NULL AS INT) AS PREOP_PH_SCREEN_C_NAME_filled,
    CAST(NULL AS INT) AS LABOR_ACT_BIRTH_C_NAME_filled,
    CAST(NULL AS INT) AS LABOR_FEED_TYPE_C_NAME_filled,
    CAST(NULL AS INT) AS PROC_SERV_C_NAME_filled,
    CAST(NULL AS INT) AS ED_DEPARTURE_TIME_filled,
    CAST(NULL AS INT) AS TRIAGE_DATETIME_filled,
    CAST(NULL AS INT) AS TRIAGE_STATUS_C_NAME_filled,
    CAST(NULL AS INT) AS INP_ADM_EVENT_ID_filled,
    CAST(NULL AS INT) AS INP_ADM_EVENT_DATE_filled,
    CAST(NULL AS INT) AS INP_DWNGRD_EVNT_ID_filled,
    CAST(NULL AS INT) AS INP_DWNGRD_DATE_filled,
    CAST(NULL AS INT) AS INP_DWNGRD_EVNT_DT_filled,
    CAST(NULL AS INT) AS OP_ADM_DATE_filled,
    CAST(NULL AS INT) AS EMER_ADM_DATE_filled,
    CAST(NULL AS INT) AS OP_ADM_EVENT_ID_filled,
    CAST(NULL AS INT) AS EMER_ADM_EVENT_ID_filled,
    CAST(NULL AS INT) AS PREREG_SOURCE_C_NAME_filled,
    CAST(NULL AS INT) AS HOV_CONF_STATUS_C_NAME_filled,
    CAST(NULL AS INT) AS RELIG_NEEDS_VISIT_C_NAME_filled,
    CAST(NULL AS INT) AS DISCHARGE_CAT_C_NAME_filled,
    CAST(NULL AS INT) AS EXP_DISCHARGE_TIME_filled,
    CAST(NULL AS INT) AS BILL_ATTEND_PROV_ID_PROV_NAME_filled,
    CAST(NULL AS INT) AS OB_LD_LABORING_YN_filled,
    CAST(NULL AS INT) AS OB_LD_LABOR_TM_filled,
    CAST(NULL AS INT) AS TRIAGE_ID_TAG_filled,
    CAST(NULL AS INT) AS TRIAGE_ID_TAG_CMT_filled,
    CAST(NULL AS INT) AS TPLNT_BILL_STAT_C_NAME_filled,
    CAST(NULL AS INT) AS ACTL_DELIVRY_METH_C_NAME_filled,
    CAST(NULL AS INT) AS PRENATAL_CARE_C_NAME_filled,
    CAST(NULL AS INT) AS AMBULANCE_CODE_C_NAME_filled,
    CAST(NULL AS INT) AS MSE_DATE_filled,
    CAST(NULL AS INT) AS ADMIT_PROV_TEXT_filled,
    CAST(NULL AS INT) AS ATTEND_PROV_TEXT_filled,
    CAST(NULL AS INT) AS PROV_PRIM_TEXT_filled,
    CAST(NULL AS INT) AS PROV_PRIM_TEXT_PHON_filled,
    CAST(NULL AS INT) AS HOSPITAL_AREA_ID_LOC_NAME_filled,
    CAST(NULL AS INT) AS CHIEF_COMPLAINT_C_NAME_filled,
    CAST(NULL AS INT) AS NEED_FIN_CLR_YN_filled,
    CAST(ERROR_MESSAGE() AS NVARCHAR(400)) AS query_error;
END CATCH;

-- ---- fc_015 <- PAT_ENC_HSP_2 ----
-- The PAT_ENC_HSP_2 table is the subsequent table for the PAT_ENC_HSP table, which is the primary table for hospital encounter information. Each record in this table is based on a pa
-- Bucket(s): Encounter / visit record
CREATE TABLE #fc_015 (
    activity_year INT,
    total_rows INT,
    PAT_ENC_CSN_ID_filled INT,
    PAT_ENC_DATE_REAL_filled INT,
    CONTACT_DATE_filled INT,
    EX_DIS_DT_ENTR_DTTM_filled INT,
    EX_DIS_TM_ENTR_DTTM_filled INT,
    CONTRACT_REG_FLAG_filled INT,
    CONTRACT_CODE_C_NAME_filled INT,
    ACCEPTS_BLOOD_C_NAME_filled INT,
    ED_ARRIVAL_DETAILS_filled INT,
    CONS_SEDATION_C_NAME_filled INT,
    RESTRAINT_SECLUS_C_NAME_filled INT,
    MULTI_PREG_YN_filled INT,
    DISASTER_NUM_filled INT,
    SRC_PATTERN_CSN_ID_filled INT,
    ENC_CLOSED_OR_COMPLETED_DATE_filled INT,
    ED_DISPO_PAT_COND_C_NAME_filled INT,
    ADOPTION_TYPE_C_NAME_filled INT,
    PRI_PROBLEM_ID_filled INT,
    EXPECTED_DISCHRG_APPROX_TIME_C_NAME_filled INT,
    DISCH_MILEST_KICKOFF_UTC_DTTM_filled INT,
    DISCH_MILEST_AUTO_MANAGED_YN_filled INT,
    PREDICTED_LOS_filled INT,
    EXP_LOS_UPD_SRC_C_NAME_filled INT,
    ED_ENC_SRC_C_NAME_filled INT,
    ED_DEPART_UTC_DTTM_filled INT,
    ADT_ARRIVAL_UTC_DTTM_filled INT,
    HOSP_DISCH_UTC_DTTM_filled INT,
    HOSP_ADMSN_UTC_DTTM_filled INT,
    INP_ADMSN_UTC_DTTM_filled INT,
    ED_HISTORICAL_YN_filled INT,
    PATIENT_TASK_COMPLETION_RATE_filled INT,
    START_MED_REM_DISCHG_YN_filled INT,
    EXPECTED_DISCHARGE_UNKNOWN_YN_filled INT,
    DUAL_ADMISSION_CSN_filled INT,
    LOA_PAT_ENC_CSN_ID_filled INT,
    INITIAL_ADT_PAT_STAT_C_NAME_filled INT,
    NOTIFICATION_SENT_FIRST_IP_YN_filled INT,
    NOTIFICATION_SENT_OBS_ADMSN_YN_filled INT,
    IB_ALERT_LENGTH_OF_STAY_MSG_ID_filled INT,
    INITIAL_ADMIT_CONF_STAT_C_NAME_filled INT,
    TRANSFER_COMMENTS_filled INT,
    MED_READINESS_DTTM_filled INT,
    MED_READINESS_TIMEFRAM_C_NAME_filled INT,
    MED_READINESS_YN_filled INT,
    MED_READINESS_INST_ENTRY_DTTM_filled INT,
    MED_READINESS_USER_ID_filled INT,
    MED_READINESS_USER_ID_NAME_filled INT,
    MED_READINESS_SOURCE_C_NAME_filled INT,
    EXPECTED_DISCH_DISP_C_NAME_filled INT,
    EXP_DISCH_DISP_USER_ID_filled INT,
    EXP_DISCH_DISP_USER_ID_NAME_filled INT,
    EXP_DISCH_DISP_ENTRY_UTC_DTTM_filled INT,
    PRIMARY_LINKED_PAT_ENC_CSN_ID_filled INT,
    TODO_ADM_DISCLAIMER_ACTIVE_YN_filled INT,
    query_error NVARCHAR(400)
);
BEGIN TRY
INSERT INTO #fc_015 (activity_year, total_rows, PAT_ENC_CSN_ID_filled, PAT_ENC_DATE_REAL_filled, CONTACT_DATE_filled, EX_DIS_DT_ENTR_DTTM_filled, EX_DIS_TM_ENTR_DTTM_filled, CONTRACT_REG_FLAG_filled, CONTRACT_CODE_C_NAME_filled, ACCEPTS_BLOOD_C_NAME_filled, ED_ARRIVAL_DETAILS_filled, CONS_SEDATION_C_NAME_filled, RESTRAINT_SECLUS_C_NAME_filled, MULTI_PREG_YN_filled, DISASTER_NUM_filled, SRC_PATTERN_CSN_ID_filled, ENC_CLOSED_OR_COMPLETED_DATE_filled, ED_DISPO_PAT_COND_C_NAME_filled, ADOPTION_TYPE_C_NAME_filled, PRI_PROBLEM_ID_filled, EXPECTED_DISCHRG_APPROX_TIME_C_NAME_filled, DISCH_MILEST_KICKOFF_UTC_DTTM_filled, DISCH_MILEST_AUTO_MANAGED_YN_filled, PREDICTED_LOS_filled, EXP_LOS_UPD_SRC_C_NAME_filled, ED_ENC_SRC_C_NAME_filled, ED_DEPART_UTC_DTTM_filled, ADT_ARRIVAL_UTC_DTTM_filled, HOSP_DISCH_UTC_DTTM_filled, HOSP_ADMSN_UTC_DTTM_filled, INP_ADMSN_UTC_DTTM_filled, ED_HISTORICAL_YN_filled, PATIENT_TASK_COMPLETION_RATE_filled, START_MED_REM_DISCHG_YN_filled, EXPECTED_DISCHARGE_UNKNOWN_YN_filled, DUAL_ADMISSION_CSN_filled, LOA_PAT_ENC_CSN_ID_filled, INITIAL_ADT_PAT_STAT_C_NAME_filled, NOTIFICATION_SENT_FIRST_IP_YN_filled, NOTIFICATION_SENT_OBS_ADMSN_YN_filled, IB_ALERT_LENGTH_OF_STAY_MSG_ID_filled, INITIAL_ADMIT_CONF_STAT_C_NAME_filled, TRANSFER_COMMENTS_filled, MED_READINESS_DTTM_filled, MED_READINESS_TIMEFRAM_C_NAME_filled, MED_READINESS_YN_filled, MED_READINESS_INST_ENTRY_DTTM_filled, MED_READINESS_USER_ID_filled, MED_READINESS_USER_ID_NAME_filled, MED_READINESS_SOURCE_C_NAME_filled, EXPECTED_DISCH_DISP_C_NAME_filled, EXP_DISCH_DISP_USER_ID_filled, EXP_DISCH_DISP_USER_ID_NAME_filled, EXP_DISCH_DISP_ENTRY_UTC_DTTM_filled, PRIMARY_LINKED_PAT_ENC_CSN_ID_filled, TODO_ADM_DISCLAIMER_ACTIVE_YN_filled, query_error)
SELECT
    YEAR(CONTACT_DATE) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(PAT_ENC_DATE_REAL) AS PAT_ENC_DATE_REAL_filled,
    COUNT(CONTACT_DATE) AS CONTACT_DATE_filled,
    COUNT(EX_DIS_DT_ENTR_DTTM) AS EX_DIS_DT_ENTR_DTTM_filled,
    COUNT(EX_DIS_TM_ENTR_DTTM) AS EX_DIS_TM_ENTR_DTTM_filled,
    COUNT(CONTRACT_REG_FLAG) AS CONTRACT_REG_FLAG_filled,
    COUNT(CONTRACT_CODE_C_NAME) AS CONTRACT_CODE_C_NAME_filled,
    COUNT(ACCEPTS_BLOOD_C_NAME) AS ACCEPTS_BLOOD_C_NAME_filled,
    COUNT(ED_ARRIVAL_DETAILS) AS ED_ARRIVAL_DETAILS_filled,
    COUNT(CONS_SEDATION_C_NAME) AS CONS_SEDATION_C_NAME_filled,
    COUNT(RESTRAINT_SECLUS_C_NAME) AS RESTRAINT_SECLUS_C_NAME_filled,
    COUNT(MULTI_PREG_YN) AS MULTI_PREG_YN_filled,
    COUNT(DISASTER_NUM) AS DISASTER_NUM_filled,
    COUNT(SRC_PATTERN_CSN_ID) AS SRC_PATTERN_CSN_ID_filled,
    COUNT(ENC_CLOSED_OR_COMPLETED_DATE) AS ENC_CLOSED_OR_COMPLETED_DATE_filled,
    COUNT(ED_DISPO_PAT_COND_C_NAME) AS ED_DISPO_PAT_COND_C_NAME_filled,
    COUNT(ADOPTION_TYPE_C_NAME) AS ADOPTION_TYPE_C_NAME_filled,
    COUNT(PRI_PROBLEM_ID) AS PRI_PROBLEM_ID_filled,
    COUNT(EXPECTED_DISCHRG_APPROX_TIME_C_NAME) AS EXPECTED_DISCHRG_APPROX_TIME_C_NAME_filled,
    COUNT(DISCH_MILEST_KICKOFF_UTC_DTTM) AS DISCH_MILEST_KICKOFF_UTC_DTTM_filled,
    COUNT(DISCH_MILEST_AUTO_MANAGED_YN) AS DISCH_MILEST_AUTO_MANAGED_YN_filled,
    COUNT(PREDICTED_LOS) AS PREDICTED_LOS_filled,
    COUNT(EXP_LOS_UPD_SRC_C_NAME) AS EXP_LOS_UPD_SRC_C_NAME_filled,
    COUNT(ED_ENC_SRC_C_NAME) AS ED_ENC_SRC_C_NAME_filled,
    COUNT(ED_DEPART_UTC_DTTM) AS ED_DEPART_UTC_DTTM_filled,
    COUNT(ADT_ARRIVAL_UTC_DTTM) AS ADT_ARRIVAL_UTC_DTTM_filled,
    COUNT(HOSP_DISCH_UTC_DTTM) AS HOSP_DISCH_UTC_DTTM_filled,
    COUNT(HOSP_ADMSN_UTC_DTTM) AS HOSP_ADMSN_UTC_DTTM_filled,
    COUNT(INP_ADMSN_UTC_DTTM) AS INP_ADMSN_UTC_DTTM_filled,
    COUNT(ED_HISTORICAL_YN) AS ED_HISTORICAL_YN_filled,
    COUNT(PATIENT_TASK_COMPLETION_RATE) AS PATIENT_TASK_COMPLETION_RATE_filled,
    COUNT(START_MED_REM_DISCHG_YN) AS START_MED_REM_DISCHG_YN_filled,
    COUNT(EXPECTED_DISCHARGE_UNKNOWN_YN) AS EXPECTED_DISCHARGE_UNKNOWN_YN_filled,
    COUNT(DUAL_ADMISSION_CSN) AS DUAL_ADMISSION_CSN_filled,
    COUNT(LOA_PAT_ENC_CSN_ID) AS LOA_PAT_ENC_CSN_ID_filled,
    COUNT(INITIAL_ADT_PAT_STAT_C_NAME) AS INITIAL_ADT_PAT_STAT_C_NAME_filled,
    COUNT(NOTIFICATION_SENT_FIRST_IP_YN) AS NOTIFICATION_SENT_FIRST_IP_YN_filled,
    COUNT(NOTIFICATION_SENT_OBS_ADMSN_YN) AS NOTIFICATION_SENT_OBS_ADMSN_YN_filled,
    COUNT(IB_ALERT_LENGTH_OF_STAY_MSG_ID) AS IB_ALERT_LENGTH_OF_STAY_MSG_ID_filled,
    COUNT(INITIAL_ADMIT_CONF_STAT_C_NAME) AS INITIAL_ADMIT_CONF_STAT_C_NAME_filled,
    COUNT(TRANSFER_COMMENTS) AS TRANSFER_COMMENTS_filled,
    COUNT(MED_READINESS_DTTM) AS MED_READINESS_DTTM_filled,
    COUNT(MED_READINESS_TIMEFRAM_C_NAME) AS MED_READINESS_TIMEFRAM_C_NAME_filled,
    COUNT(MED_READINESS_YN) AS MED_READINESS_YN_filled,
    COUNT(MED_READINESS_INST_ENTRY_DTTM) AS MED_READINESS_INST_ENTRY_DTTM_filled,
    COUNT(MED_READINESS_USER_ID) AS MED_READINESS_USER_ID_filled,
    COUNT(MED_READINESS_USER_ID_NAME) AS MED_READINESS_USER_ID_NAME_filled,
    COUNT(MED_READINESS_SOURCE_C_NAME) AS MED_READINESS_SOURCE_C_NAME_filled,
    COUNT(EXPECTED_DISCH_DISP_C_NAME) AS EXPECTED_DISCH_DISP_C_NAME_filled,
    COUNT(EXP_DISCH_DISP_USER_ID) AS EXP_DISCH_DISP_USER_ID_filled,
    COUNT(EXP_DISCH_DISP_USER_ID_NAME) AS EXP_DISCH_DISP_USER_ID_NAME_filled,
    COUNT(EXP_DISCH_DISP_ENTRY_UTC_DTTM) AS EXP_DISCH_DISP_ENTRY_UTC_DTTM_filled,
    COUNT(PRIMARY_LINKED_PAT_ENC_CSN_ID) AS PRIMARY_LINKED_PAT_ENC_CSN_ID_filled,
    COUNT(TODO_ADM_DISCLAIMER_ACTIVE_YN) AS TODO_ADM_DISCLAIMER_ACTIVE_YN_filled,
    CAST(NULL AS NVARCHAR(400)) AS query_error
FROM PAT_ENC_HSP_2
GROUP BY YEAR(CONTACT_DATE);
END TRY
BEGIN CATCH
INSERT INTO #fc_015 (activity_year, total_rows, PAT_ENC_CSN_ID_filled, PAT_ENC_DATE_REAL_filled, CONTACT_DATE_filled, EX_DIS_DT_ENTR_DTTM_filled, EX_DIS_TM_ENTR_DTTM_filled, CONTRACT_REG_FLAG_filled, CONTRACT_CODE_C_NAME_filled, ACCEPTS_BLOOD_C_NAME_filled, ED_ARRIVAL_DETAILS_filled, CONS_SEDATION_C_NAME_filled, RESTRAINT_SECLUS_C_NAME_filled, MULTI_PREG_YN_filled, DISASTER_NUM_filled, SRC_PATTERN_CSN_ID_filled, ENC_CLOSED_OR_COMPLETED_DATE_filled, ED_DISPO_PAT_COND_C_NAME_filled, ADOPTION_TYPE_C_NAME_filled, PRI_PROBLEM_ID_filled, EXPECTED_DISCHRG_APPROX_TIME_C_NAME_filled, DISCH_MILEST_KICKOFF_UTC_DTTM_filled, DISCH_MILEST_AUTO_MANAGED_YN_filled, PREDICTED_LOS_filled, EXP_LOS_UPD_SRC_C_NAME_filled, ED_ENC_SRC_C_NAME_filled, ED_DEPART_UTC_DTTM_filled, ADT_ARRIVAL_UTC_DTTM_filled, HOSP_DISCH_UTC_DTTM_filled, HOSP_ADMSN_UTC_DTTM_filled, INP_ADMSN_UTC_DTTM_filled, ED_HISTORICAL_YN_filled, PATIENT_TASK_COMPLETION_RATE_filled, START_MED_REM_DISCHG_YN_filled, EXPECTED_DISCHARGE_UNKNOWN_YN_filled, DUAL_ADMISSION_CSN_filled, LOA_PAT_ENC_CSN_ID_filled, INITIAL_ADT_PAT_STAT_C_NAME_filled, NOTIFICATION_SENT_FIRST_IP_YN_filled, NOTIFICATION_SENT_OBS_ADMSN_YN_filled, IB_ALERT_LENGTH_OF_STAY_MSG_ID_filled, INITIAL_ADMIT_CONF_STAT_C_NAME_filled, TRANSFER_COMMENTS_filled, MED_READINESS_DTTM_filled, MED_READINESS_TIMEFRAM_C_NAME_filled, MED_READINESS_YN_filled, MED_READINESS_INST_ENTRY_DTTM_filled, MED_READINESS_USER_ID_filled, MED_READINESS_USER_ID_NAME_filled, MED_READINESS_SOURCE_C_NAME_filled, EXPECTED_DISCH_DISP_C_NAME_filled, EXP_DISCH_DISP_USER_ID_filled, EXP_DISCH_DISP_USER_ID_NAME_filled, EXP_DISCH_DISP_ENTRY_UTC_DTTM_filled, PRIMARY_LINKED_PAT_ENC_CSN_ID_filled, TODO_ADM_DISCLAIMER_ACTIVE_YN_filled, query_error)
SELECT
    CAST(NULL AS INT) AS activity_year,
    CAST(NULL AS INT) AS total_rows,
    CAST(NULL AS INT) AS PAT_ENC_CSN_ID_filled,
    CAST(NULL AS INT) AS PAT_ENC_DATE_REAL_filled,
    CAST(NULL AS INT) AS CONTACT_DATE_filled,
    CAST(NULL AS INT) AS EX_DIS_DT_ENTR_DTTM_filled,
    CAST(NULL AS INT) AS EX_DIS_TM_ENTR_DTTM_filled,
    CAST(NULL AS INT) AS CONTRACT_REG_FLAG_filled,
    CAST(NULL AS INT) AS CONTRACT_CODE_C_NAME_filled,
    CAST(NULL AS INT) AS ACCEPTS_BLOOD_C_NAME_filled,
    CAST(NULL AS INT) AS ED_ARRIVAL_DETAILS_filled,
    CAST(NULL AS INT) AS CONS_SEDATION_C_NAME_filled,
    CAST(NULL AS INT) AS RESTRAINT_SECLUS_C_NAME_filled,
    CAST(NULL AS INT) AS MULTI_PREG_YN_filled,
    CAST(NULL AS INT) AS DISASTER_NUM_filled,
    CAST(NULL AS INT) AS SRC_PATTERN_CSN_ID_filled,
    CAST(NULL AS INT) AS ENC_CLOSED_OR_COMPLETED_DATE_filled,
    CAST(NULL AS INT) AS ED_DISPO_PAT_COND_C_NAME_filled,
    CAST(NULL AS INT) AS ADOPTION_TYPE_C_NAME_filled,
    CAST(NULL AS INT) AS PRI_PROBLEM_ID_filled,
    CAST(NULL AS INT) AS EXPECTED_DISCHRG_APPROX_TIME_C_NAME_filled,
    CAST(NULL AS INT) AS DISCH_MILEST_KICKOFF_UTC_DTTM_filled,
    CAST(NULL AS INT) AS DISCH_MILEST_AUTO_MANAGED_YN_filled,
    CAST(NULL AS INT) AS PREDICTED_LOS_filled,
    CAST(NULL AS INT) AS EXP_LOS_UPD_SRC_C_NAME_filled,
    CAST(NULL AS INT) AS ED_ENC_SRC_C_NAME_filled,
    CAST(NULL AS INT) AS ED_DEPART_UTC_DTTM_filled,
    CAST(NULL AS INT) AS ADT_ARRIVAL_UTC_DTTM_filled,
    CAST(NULL AS INT) AS HOSP_DISCH_UTC_DTTM_filled,
    CAST(NULL AS INT) AS HOSP_ADMSN_UTC_DTTM_filled,
    CAST(NULL AS INT) AS INP_ADMSN_UTC_DTTM_filled,
    CAST(NULL AS INT) AS ED_HISTORICAL_YN_filled,
    CAST(NULL AS INT) AS PATIENT_TASK_COMPLETION_RATE_filled,
    CAST(NULL AS INT) AS START_MED_REM_DISCHG_YN_filled,
    CAST(NULL AS INT) AS EXPECTED_DISCHARGE_UNKNOWN_YN_filled,
    CAST(NULL AS INT) AS DUAL_ADMISSION_CSN_filled,
    CAST(NULL AS INT) AS LOA_PAT_ENC_CSN_ID_filled,
    CAST(NULL AS INT) AS INITIAL_ADT_PAT_STAT_C_NAME_filled,
    CAST(NULL AS INT) AS NOTIFICATION_SENT_FIRST_IP_YN_filled,
    CAST(NULL AS INT) AS NOTIFICATION_SENT_OBS_ADMSN_YN_filled,
    CAST(NULL AS INT) AS IB_ALERT_LENGTH_OF_STAY_MSG_ID_filled,
    CAST(NULL AS INT) AS INITIAL_ADMIT_CONF_STAT_C_NAME_filled,
    CAST(NULL AS INT) AS TRANSFER_COMMENTS_filled,
    CAST(NULL AS INT) AS MED_READINESS_DTTM_filled,
    CAST(NULL AS INT) AS MED_READINESS_TIMEFRAM_C_NAME_filled,
    CAST(NULL AS INT) AS MED_READINESS_YN_filled,
    CAST(NULL AS INT) AS MED_READINESS_INST_ENTRY_DTTM_filled,
    CAST(NULL AS INT) AS MED_READINESS_USER_ID_filled,
    CAST(NULL AS INT) AS MED_READINESS_USER_ID_NAME_filled,
    CAST(NULL AS INT) AS MED_READINESS_SOURCE_C_NAME_filled,
    CAST(NULL AS INT) AS EXPECTED_DISCH_DISP_C_NAME_filled,
    CAST(NULL AS INT) AS EXP_DISCH_DISP_USER_ID_filled,
    CAST(NULL AS INT) AS EXP_DISCH_DISP_USER_ID_NAME_filled,
    CAST(NULL AS INT) AS EXP_DISCH_DISP_ENTRY_UTC_DTTM_filled,
    CAST(NULL AS INT) AS PRIMARY_LINKED_PAT_ENC_CSN_ID_filled,
    CAST(NULL AS INT) AS TODO_ADM_DISCLAIMER_ACTIVE_YN_filled,
    CAST(ERROR_MESSAGE() AS NVARCHAR(400)) AS query_error;
END CATCH;

-- ---- fc_016 <- PAT_ENC_NO_SHOW ----
-- This table contains no-show documentation. When patients do not arrive for an appointment, they are marked as a no-show. Each no-show can have an associated action, outcome and com
-- Bucket(s): Appointment / scheduling status
-- no date/datetime-typed column found on this table; flat total only
CREATE TABLE #fc_016 (
    activity_year INT,
    total_rows INT,
    PAT_ENC_CSN_ID_filled INT,
    LINE_filled INT,
    PAT_ID_filled INT,
    NO_SHOW_COMMENT_filled INT,
    query_error NVARCHAR(400)
);
BEGIN TRY
INSERT INTO #fc_016 (activity_year, total_rows, PAT_ENC_CSN_ID_filled, LINE_filled, PAT_ID_filled, NO_SHOW_COMMENT_filled, query_error)
SELECT
    CAST(NULL AS INT) AS activity_year,
    COUNT(*) AS total_rows,
    COUNT(PAT_ENC_CSN_ID) AS PAT_ENC_CSN_ID_filled,
    COUNT(LINE) AS LINE_filled,
    COUNT(PAT_ID) AS PAT_ID_filled,
    COUNT(NO_SHOW_COMMENT) AS NO_SHOW_COMMENT_filled,
    CAST(NULL AS NVARCHAR(400)) AS query_error
FROM PAT_ENC_NO_SHOW;
END TRY
BEGIN CATCH
INSERT INTO #fc_016 (activity_year, total_rows, PAT_ENC_CSN_ID_filled, LINE_filled, PAT_ID_filled, NO_SHOW_COMMENT_filled, query_error)
SELECT
    CAST(NULL AS INT) AS activity_year,
    CAST(NULL AS INT) AS total_rows,
    CAST(NULL AS INT) AS PAT_ENC_CSN_ID_filled,
    CAST(NULL AS INT) AS LINE_filled,
    CAST(NULL AS INT) AS PAT_ID_filled,
    CAST(NULL AS INT) AS NO_SHOW_COMMENT_filled,
    CAST(ERROR_MESSAGE() AS NVARCHAR(400)) AS query_error;
END CATCH;

-- ============================== PHASE 2 ==============================
-- The one result set this script returns: every staging table's wide
-- aggregate row, reshaped into long format (one row per table/column/
-- year) and unioned together. Export this grid and send it back.

SELECT table_name, column_name, activity_year, total_rows, filled_count, query_error
FROM (
    SELECT 'APPT_CSN_COUNTS' AS table_name, 'AUTH_ID' AS column_name, activity_year, total_rows, AUTH_ID_filled AS filled_count, query_error FROM #fc_001
    UNION ALL
    SELECT 'APPT_CSN_COUNTS' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count, query_error FROM #fc_001
    UNION ALL
    SELECT 'APPT_CSN_COUNTS' AS table_name, 'LINKED_APPT_CSNS' AS column_name, activity_year, total_rows, LINKED_APPT_CSNS_filled AS filled_count, query_error FROM #fc_001
    UNION ALL
    SELECT 'APPT_CSN_COUNTS' AS table_name, 'LINKED_APPT_COUNTS' AS column_name, activity_year, total_rows, LINKED_APPT_COUNTS_filled AS filled_count, query_error FROM #fc_001
    UNION ALL
    SELECT 'APPT_CSN_COUNTS' AS table_name, 'USR_OVR_VST_COUNT_YN' AS column_name, activity_year, total_rows, USR_OVR_VST_COUNT_YN_filled AS filled_count, query_error FROM #fc_001
    UNION ALL
    SELECT 'CANCELED_APPTS_EDI' AS table_name, 'ORDER_ID' AS column_name, activity_year, total_rows, ORDER_ID_filled AS filled_count, query_error FROM #fc_002
    UNION ALL
    SELECT 'CANCELED_APPTS_EDI' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count, query_error FROM #fc_002
    UNION ALL
    SELECT 'CANCELED_APPTS_EDI' AS table_name, 'CANCEL_APPTS_EDI' AS column_name, activity_year, total_rows, CANCEL_APPTS_EDI_filled AS filled_count, query_error FROM #fc_002
    UNION ALL
    SELECT 'CANCELED_APPTS_EDI' AS table_name, 'CANC_APPT_PREV_STAT' AS column_name, activity_year, total_rows, CANC_APPT_PREV_STAT_filled AS filled_count, query_error FROM #fc_002
    UNION ALL
    SELECT 'CLARITY_SER' AS table_name, 'PROV_ID_PROV_NAME' AS column_name, activity_year, total_rows, PROV_ID_PROV_NAME_filled AS filled_count, query_error FROM #fc_003
    UNION ALL
    SELECT 'CLARITY_SER' AS table_name, 'PROV_NAME' AS column_name, activity_year, total_rows, PROV_NAME_filled AS filled_count, query_error FROM #fc_003
    UNION ALL
    SELECT 'CLARITY_SER' AS table_name, 'EXTERNAL_NAME' AS column_name, activity_year, total_rows, EXTERNAL_NAME_filled AS filled_count, query_error FROM #fc_003
    UNION ALL
    SELECT 'ORD_AUD_APPT_INFO' AS table_name, 'ORDER_ID' AS column_name, activity_year, total_rows, ORDER_ID_filled AS filled_count, query_error FROM #fc_004
    UNION ALL
    SELECT 'ORD_AUD_APPT_INFO' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count, query_error FROM #fc_004
    UNION ALL
    SELECT 'ORD_AUD_APPT_INFO' AS table_name, 'APPT_STUDY_STATUES' AS column_name, activity_year, total_rows, APPT_STUDY_STATUES_filled AS filled_count, query_error FROM #fc_004
    UNION ALL
    SELECT 'ORD_AUD_APPT_INFO' AS table_name, 'APPT_STUDY_STAUES_EXT_VALS' AS column_name, activity_year, total_rows, APPT_STUDY_STAUES_EXT_VALS_filled AS filled_count, query_error FROM #fc_004
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'PAT_ID' AS column_name, activity_year, total_rows, PAT_ID_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'PAT_ENC_DATE_REAL' AS column_name, activity_year, total_rows, PAT_ENC_DATE_REAL_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'PAT_ENC_CSN_ID' AS column_name, activity_year, total_rows, PAT_ENC_CSN_ID_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'PCP_PROV_ID_PROV_NAME' AS column_name, activity_year, total_rows, PCP_PROV_ID_PROV_NAME_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'FIN_CLASS_C_NAME' AS column_name, activity_year, total_rows, FIN_CLASS_C_NAME_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'VISIT_PROV_ID_PROV_NAME' AS column_name, activity_year, total_rows, VISIT_PROV_ID_PROV_NAME_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'VISIT_PROV_TITLE_NAME' AS column_name, activity_year, total_rows, VISIT_PROV_TITLE_NAME_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'DEPARTMENT_ID_EXTERNAL_NAME' AS column_name, activity_year, total_rows, DEPARTMENT_ID_EXTERNAL_NAME_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'LMP_DATE' AS column_name, activity_year, total_rows, LMP_DATE_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'ENC_CLOSED_YN' AS column_name, activity_year, total_rows, ENC_CLOSED_YN_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'ENC_CLOSED_USER_ID' AS column_name, activity_year, total_rows, ENC_CLOSED_USER_ID_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'ENC_CLOSED_USER_ID_NAME' AS column_name, activity_year, total_rows, ENC_CLOSED_USER_ID_NAME_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'ENC_CLOSE_DATE' AS column_name, activity_year, total_rows, ENC_CLOSE_DATE_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'LOS_MODIFIER1_ID' AS column_name, activity_year, total_rows, LOS_MODIFIER1_ID_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'LOS_MODIFIER1_ID_MODIFIER_NAME' AS column_name, activity_year, total_rows, LOS_MODIFIER1_ID_MODIFIER_NAME_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'LOS_MODIFIER2_ID' AS column_name, activity_year, total_rows, LOS_MODIFIER2_ID_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'LOS_MODIFIER2_ID_MODIFIER_NAME' AS column_name, activity_year, total_rows, LOS_MODIFIER2_ID_MODIFIER_NAME_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'LOS_MODIFIER3_ID' AS column_name, activity_year, total_rows, LOS_MODIFIER3_ID_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'LOS_MODIFIER3_ID_MODIFIER_NAME' AS column_name, activity_year, total_rows, LOS_MODIFIER3_ID_MODIFIER_NAME_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'LOS_MODIFIER4_ID' AS column_name, activity_year, total_rows, LOS_MODIFIER4_ID_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'LOS_MODIFIER4_ID_MODIFIER_NAME' AS column_name, activity_year, total_rows, LOS_MODIFIER4_ID_MODIFIER_NAME_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'APPT_STATUS_C_NAME' AS column_name, activity_year, total_rows, APPT_STATUS_C_NAME_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'APPT_CANC_USER_ID' AS column_name, activity_year, total_rows, APPT_CANC_USER_ID_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'APPT_CANC_USER_ID_NAME' AS column_name, activity_year, total_rows, APPT_CANC_USER_ID_NAME_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'CHECKIN_USER_ID' AS column_name, activity_year, total_rows, CHECKIN_USER_ID_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'CHECKIN_USER_ID_NAME' AS column_name, activity_year, total_rows, CHECKIN_USER_ID_NAME_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'HOSP_ADMSN_TIME' AS column_name, activity_year, total_rows, HOSP_ADMSN_TIME_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'HOSP_DISCHRG_TIME' AS column_name, activity_year, total_rows, HOSP_DISCHRG_TIME_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'HOSP_ADMSN_TYPE_C_NAME' AS column_name, activity_year, total_rows, HOSP_ADMSN_TYPE_C_NAME_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'NONCVRED_SERVICE_YN' AS column_name, activity_year, total_rows, NONCVRED_SERVICE_YN_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'REFERRAL_REQ_YN' AS column_name, activity_year, total_rows, REFERRAL_REQ_YN_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'REFERRAL_ID' AS column_name, activity_year, total_rows, REFERRAL_ID_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'ACCOUNT_ID' AS column_name, activity_year, total_rows, ACCOUNT_ID_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'COVERAGE_ID' AS column_name, activity_year, total_rows, COVERAGE_ID_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'CLAIM_ID' AS column_name, activity_year, total_rows, CLAIM_ID_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'PRIMARY_LOC_ID_LOC_NAME' AS column_name, activity_year, total_rows, PRIMARY_LOC_ID_LOC_NAME_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'CHARGE_SLIP_NUMBER' AS column_name, activity_year, total_rows, CHARGE_SLIP_NUMBER_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'COPAY_DUE' AS column_name, activity_year, total_rows, COPAY_DUE_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'UPDATE_DATE' AS column_name, activity_year, total_rows, UPDATE_DATE_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'HSP_ACCOUNT_ID' AS column_name, activity_year, total_rows, HSP_ACCOUNT_ID_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'ADM_FOR_SURG_YN' AS column_name, activity_year, total_rows, ADM_FOR_SURG_YN_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'SURGICAL_SVC_C_NAME' AS column_name, activity_year, total_rows, SURGICAL_SVC_C_NAME_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'INPATIENT_DATA_ID' AS column_name, activity_year, total_rows, INPATIENT_DATA_ID_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'IP_EPISODE_ID' AS column_name, activity_year, total_rows, IP_EPISODE_ID_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'EXTERNAL_VISIT_ID' AS column_name, activity_year, total_rows, EXTERNAL_VISIT_ID_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'CONTACT_COMMENT' AS column_name, activity_year, total_rows, CONTACT_COMMENT_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'OUTGOING_CALL_YN' AS column_name, activity_year, total_rows, OUTGOING_CALL_YN_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'DATA_ENTRY_PERSON' AS column_name, activity_year, total_rows, DATA_ENTRY_PERSON_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'REFERRAL_SOURCE_ID' AS column_name, activity_year, total_rows, REFERRAL_SOURCE_ID_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'REFERRAL_SOURCE_ID_REFERRING_PROV_NAM' AS column_name, activity_year, total_rows, REFERRAL_SOURCE_ID_REFERRING_PROV_NAM_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'WC_TPL_VISIT_C_NAME' AS column_name, activity_year, total_rows, WC_TPL_VISIT_C_NAME_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'CONSENT_TYPE_C_NAME' AS column_name, activity_year, total_rows, CONSENT_TYPE_C_NAME_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'BMI' AS column_name, activity_year, total_rows, BMI_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'BSA' AS column_name, activity_year, total_rows, BSA_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'AVS_PRINT_TM' AS column_name, activity_year, total_rows, AVS_PRINT_TM_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'AVS_FIRST_USER_ID' AS column_name, activity_year, total_rows, AVS_FIRST_USER_ID_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'AVS_FIRST_USER_ID_NAME' AS column_name, activity_year, total_rows, AVS_FIRST_USER_ID_NAME_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'ENC_MED_FRZ_RSN_C_NAME' AS column_name, activity_year, total_rows, ENC_MED_FRZ_RSN_C_NAME_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'EFFECTIVE_DATE_DT' AS column_name, activity_year, total_rows, EFFECTIVE_DATE_DT_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'DISCHARGE_DATE_DT' AS column_name, activity_year, total_rows, DISCHARGE_DATE_DT_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'COPAY_PD_THRU_NAME' AS column_name, activity_year, total_rows, COPAY_PD_THRU_NAME_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'INTERPRETER_NEED_YN' AS column_name, activity_year, total_rows, INTERPRETER_NEED_YN_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'VST_SPECIAL_NEEDS_C_NAME' AS column_name, activity_year, total_rows, VST_SPECIAL_NEEDS_C_NAME_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'BEN_ENG_SP_AMT' AS column_name, activity_year, total_rows, BEN_ENG_SP_AMT_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'BEN_ADJ_COPAY_AMT' AS column_name, activity_year, total_rows, BEN_ADJ_COPAY_AMT_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'BEN_ADJ_METHOD_C_NAME' AS column_name, activity_year, total_rows, BEN_ADJ_METHOD_C_NAME_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'ENC_CREATE_USER_ID' AS column_name, activity_year, total_rows, ENC_CREATE_USER_ID_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'ENC_CREATE_USER_ID_NAME' AS column_name, activity_year, total_rows, ENC_CREATE_USER_ID_NAME_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'ENC_INSTANT' AS column_name, activity_year, total_rows, ENC_INSTANT_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'EFFECTIVE_DATE_DTTM' AS column_name, activity_year, total_rows, EFFECTIVE_DATE_DTTM_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC' AS table_name, 'CALCULATED_ENC_STAT_C_NAME' AS column_name, activity_year, total_rows, CALCULATED_ENC_STAT_C_NAME_filled AS filled_count, query_error FROM #fc_005
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'PAT_ENC_CSN_ID' AS column_name, activity_year, total_rows, PAT_ENC_CSN_ID_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'COPAY_COINS_FLAG' AS column_name, activity_year, total_rows, COPAY_COINS_FLAG_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'CAN_LET_C_NAME' AS column_name, activity_year, total_rows, CAN_LET_C_NAME_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'SUP_PROV_ID_PROV_NAME' AS column_name, activity_year, total_rows, SUP_PROV_ID_PROV_NAME_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'SUP_PROV_C_NAME' AS column_name, activity_year, total_rows, SUP_PROV_C_NAME_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'SUP_PROV_REV_TM' AS column_name, activity_year, total_rows, SUP_PROV_REV_TM_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'MEDS_REQUEST_PHR_ID' AS column_name, activity_year, total_rows, MEDS_REQUEST_PHR_ID_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'MEDS_REQUEST_PHR_ID_PHARMACY_NAME' AS column_name, activity_year, total_rows, MEDS_REQUEST_PHR_ID_PHARMACY_NAME_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'MEDS_REQUEST_OP_C_NAME' AS column_name, activity_year, total_rows, MEDS_REQUEST_OP_C_NAME_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'PHYS_BP' AS column_name, activity_year, total_rows, PHYS_BP_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'VITALS_TAKEN_TM' AS column_name, activity_year, total_rows, VITALS_TAKEN_TM_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'PHYS_TEMP_SRC_C_NAME' AS column_name, activity_year, total_rows, PHYS_TEMP_SRC_C_NAME_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'PAT_PAIN_SCORE_C_NAME' AS column_name, activity_year, total_rows, PAT_PAIN_SCORE_C_NAME_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'PAT_PAIN_LOC_C_NAME' AS column_name, activity_year, total_rows, PAT_PAIN_LOC_C_NAME_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'PAT_PAIN_EDU_YN' AS column_name, activity_year, total_rows, PAT_PAIN_EDU_YN_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'PAT_PAIN_CMT' AS column_name, activity_year, total_rows, PAT_PAIN_CMT_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'PAT_PAIN_SCALE_CAT' AS column_name, activity_year, total_rows, PAT_PAIN_SCALE_CAT_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'SMOKING_STATUS_C_NAME' AS column_name, activity_year, total_rows, SMOKING_STATUS_C_NAME_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'PHYS_SPO2' AS column_name, activity_year, total_rows, PHYS_SPO2_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'SYS_GEN_LOS_ID_PROC_NAME' AS column_name, activity_year, total_rows, SYS_GEN_LOS_ID_PROC_NAME_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'DOC_HX_SOURCE_C_NAME' AS column_name, activity_year, total_rows, DOC_HX_SOURCE_C_NAME_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'APPT_LET_C_NAME' AS column_name, activity_year, total_rows, APPT_LET_C_NAME_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'PARENT_ENC_CSN_ID' AS column_name, activity_year, total_rows, PARENT_ENC_CSN_ID_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'SYNC_IP_DATA_C_NAME' AS column_name, activity_year, total_rows, SYNC_IP_DATA_C_NAME_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'APPTMT_LET_INST' AS column_name, activity_year, total_rows, APPTMT_LET_INST_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'RESULT_LET_INST' AS column_name, activity_year, total_rows, RESULT_LET_INST_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'RESCHED_LET_INST' AS column_name, activity_year, total_rows, RESCHED_LET_INST_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'FOLLOW_LET_INST' AS column_name, activity_year, total_rows, FOLLOW_LET_INST_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'PHYS_PEAK_FLOW' AS column_name, activity_year, total_rows, PHYS_PEAK_FLOW_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'ENC_SPEC_C_NAME' AS column_name, activity_year, total_rows, ENC_SPEC_C_NAME_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'LD_STATUS_YN' AS column_name, activity_year, total_rows, LD_STATUS_YN_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'ADT_PAT_CLASS_C_NAME' AS column_name, activity_year, total_rows, ADT_PAT_CLASS_C_NAME_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'OTHER_BLOCK_ID' AS column_name, activity_year, total_rows, OTHER_BLOCK_ID_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'OTHER_BLOCK_TYPE_C_NAME' AS column_name, activity_year, total_rows, OTHER_BLOCK_TYPE_C_NAME_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'BILL_NUM' AS column_name, activity_year, total_rows, BILL_NUM_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'IP_DOC_CONTACT_CSN' AS column_name, activity_year, total_rows, IP_DOC_CONTACT_CSN_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'TEMP_PT_HIS_C_NAME' AS column_name, activity_year, total_rows, TEMP_PT_HIS_C_NAME_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'PRIMARY_PROCONT_ID_PROV_NAME' AS column_name, activity_year, total_rows, PRIMARY_PROCONT_ID_PROV_NAME_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'PRIMARY_TEAM_ID' AS column_name, activity_year, total_rows, PRIMARY_TEAM_ID_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'PRIMARY_TEAM_ID_RECORD_NAME' AS column_name, activity_year, total_rows, PRIMARY_TEAM_ID_RECORD_NAME_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'MCIR_VACCINE_CODE_C_NAME' AS column_name, activity_year, total_rows, MCIR_VACCINE_CODE_C_NAME_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'VISIT_POS_ID_LOC_NAME' AS column_name, activity_year, total_rows, VISIT_POS_ID_LOC_NAME_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'NO_INTERP_RSN_C_NAME' AS column_name, activity_year, total_rows, NO_INTERP_RSN_C_NAME_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'CVG_ADD_DT' AS column_name, activity_year, total_rows, CVG_ADD_DT_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'FARM_WORKER_C_NAME' AS column_name, activity_year, total_rows, FARM_WORKER_C_NAME_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'KIOSK_HH_QUEST_ID' AS column_name, activity_year, total_rows, KIOSK_HH_QUEST_ID_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'KIOSK_HH_QUEST_ID_RECORD_NAME' AS column_name, activity_year, total_rows, KIOSK_HH_QUEST_ID_RECORD_NAME_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'HSP_ACCT_ADV_DTTM' AS column_name, activity_year, total_rows, HSP_ACCT_ADV_DTTM_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'VISIT_VERIFIED_YN' AS column_name, activity_year, total_rows, VISIT_VERIFIED_YN_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'VERIF_VISIT_DT' AS column_name, activity_year, total_rows, VERIF_VISIT_DT_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'VERIF_DATE_INIT_DT' AS column_name, activity_year, total_rows, VERIF_DATE_INIT_DT_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'VERIF_USER_ID' AS column_name, activity_year, total_rows, VERIF_USER_ID_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'ENC_LACT_STAT_C_NAME' AS column_name, activity_year, total_rows, ENC_LACT_STAT_C_NAME_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'PAT_LACT_CMNT' AS column_name, activity_year, total_rows, PAT_LACT_CMNT_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'COSIGNER_USER_ID' AS column_name, activity_year, total_rows, COSIGNER_USER_ID_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'COSIGNER_USER_ID_NAME' AS column_name, activity_year, total_rows, COSIGNER_USER_ID_NAME_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'COSIGN_REV_INS_DTTM' AS column_name, activity_year, total_rows, COSIGN_REV_INS_DTTM_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'PAR_DICT_COUNTER' AS column_name, activity_year, total_rows, PAR_DICT_COUNTER_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'IS_LOS_UPDATE_C_NAME' AS column_name, activity_year, total_rows, IS_LOS_UPDATE_C_NAME_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'FORM_ID_COUNTER' AS column_name, activity_year, total_rows, FORM_ID_COUNTER_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'CONSNT_REV_USER_ID' AS column_name, activity_year, total_rows, CONSNT_REV_USER_ID_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'CONSNT_REV_USER_ID_NAME' AS column_name, activity_year, total_rows, CONSNT_REV_USER_ID_NAME_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'VISIT_PAYOR_ID_PAYOR_NAME' AS column_name, activity_year, total_rows, VISIT_PAYOR_ID_PAYOR_NAME_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'VISIT_PLAN_ID_BENEFIT_PLAN_NAME' AS column_name, activity_year, total_rows, VISIT_PLAN_ID_BENEFIT_PLAN_NAME_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'SOCIO_SRC_C_NAME' AS column_name, activity_year, total_rows, SOCIO_SRC_C_NAME_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'TEL_ENC_MSG_RGRDING' AS column_name, activity_year, total_rows, TEL_ENC_MSG_RGRDING_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'MSG_PRIORITY_C_NAME' AS column_name, activity_year, total_rows, MSG_PRIORITY_C_NAME_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'RESEARCH_ENC_FLG_C_NAME' AS column_name, activity_year, total_rows, RESEARCH_ENC_FLG_C_NAME_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'FAM_SPOUSE_NAME' AS column_name, activity_year, total_rows, FAM_SPOUSE_NAME_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'MSG_CALLER_NAME' AS column_name, activity_year, total_rows, MSG_CALLER_NAME_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'CONSENT_EXP_DATE' AS column_name, activity_year, total_rows, CONSENT_EXP_DATE_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'CV_ACC4_PAT_RESP_YN' AS column_name, activity_year, total_rows, CV_ACC4_PAT_RESP_YN_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'FAMILY_MEM_PREFIX_C_NAME' AS column_name, activity_year, total_rows, FAMILY_MEM_PREFIX_C_NAME_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'AVS_REFUSED_DTTM' AS column_name, activity_year, total_rows, AVS_REFUSED_DTTM_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'AVS_LAST_PRINT_DTTM' AS column_name, activity_year, total_rows, AVS_LAST_PRINT_DTTM_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_2' AS table_name, 'MED_LIST_UPDATE_DTTM' AS column_name, activity_year, total_rows, MED_LIST_UPDATE_DTTM_filled AS filled_count, query_error FROM #fc_006
    UNION ALL
    SELECT 'PAT_ENC_3' AS table_name, 'PAT_ENC_CSN' AS column_name, activity_year, total_rows, PAT_ENC_CSN_filled AS filled_count, query_error FROM #fc_007
    UNION ALL
    SELECT 'PAT_ENC_3' AS table_name, 'PAT_ENC_DATE_REAL' AS column_name, activity_year, total_rows, PAT_ENC_DATE_REAL_filled AS filled_count, query_error FROM #fc_007
    UNION ALL
    SELECT 'PAT_ENC_3' AS table_name, 'CHKOUT_USER_ID' AS column_name, activity_year, total_rows, CHKOUT_USER_ID_filled AS filled_count, query_error FROM #fc_007
    UNION ALL
    SELECT 'PAT_ENC_3' AS table_name, 'CHKOUT_USER_ID_NAME' AS column_name, activity_year, total_rows, CHKOUT_USER_ID_NAME_filled AS filled_count, query_error FROM #fc_007
    UNION ALL
    SELECT 'PAT_ENC_3' AS table_name, 'ENC_BILL_AREA_ID' AS column_name, activity_year, total_rows, ENC_BILL_AREA_ID_filled AS filled_count, query_error FROM #fc_007
    UNION ALL
    SELECT 'PAT_ENC_3' AS table_name, 'ENC_BILL_AREA_ID_BILL_AREA_NAME' AS column_name, activity_year, total_rows, ENC_BILL_AREA_ID_BILL_AREA_NAME_filled AS filled_count, query_error FROM #fc_007
    UNION ALL
    SELECT 'PAT_ENC_3' AS table_name, 'RX_CHG_ADMIT_FLG_C_NAME' AS column_name, activity_year, total_rows, RX_CHG_ADMIT_FLG_C_NAME_filled AS filled_count, query_error FROM #fc_007
    UNION ALL
    SELECT 'PAT_ENC_3' AS table_name, 'DX_UNIQUE_COUNTER' AS column_name, activity_year, total_rows, DX_UNIQUE_COUNTER_filled AS filled_count, query_error FROM #fc_007
    UNION ALL
    SELECT 'PAT_ENC_3' AS table_name, 'HP_DEFAULTED_YN' AS column_name, activity_year, total_rows, HP_DEFAULTED_YN_filled AS filled_count, query_error FROM #fc_007
    UNION ALL
    SELECT 'PAT_ENC_3' AS table_name, 'IP_CP_LAST_VAR_DTTM' AS column_name, activity_year, total_rows, IP_CP_LAST_VAR_DTTM_filled AS filled_count, query_error FROM #fc_007
    UNION ALL
    SELECT 'PAT_ENC_3' AS table_name, 'READY_QUT_SMOKING_C_NAME' AS column_name, activity_year, total_rows, READY_QUT_SMOKING_C_NAME_filled AS filled_count, query_error FROM #fc_007
    UNION ALL
    SELECT 'PAT_ENC_3' AS table_name, 'COUNSELING_GIVEN_C_NAME' AS column_name, activity_year, total_rows, COUNSELING_GIVEN_C_NAME_filled AS filled_count, query_error FROM #fc_007
    UNION ALL
    SELECT 'PAT_ENC_3' AS table_name, 'COMMAUTO_SENDER_ID' AS column_name, activity_year, total_rows, COMMAUTO_SENDER_ID_filled AS filled_count, query_error FROM #fc_007
    UNION ALL
    SELECT 'PAT_ENC_3' AS table_name, 'COMMAUTO_SENDER_ID_NAME' AS column_name, activity_year, total_rows, COMMAUTO_SENDER_ID_NAME_filled AS filled_count, query_error FROM #fc_007
    UNION ALL
    SELECT 'PAT_ENC_3' AS table_name, 'BENEFIT_ID' AS column_name, activity_year, total_rows, BENEFIT_ID_filled AS filled_count, query_error FROM #fc_007
    UNION ALL
    SELECT 'PAT_ENC_3' AS table_name, 'PREPAY_DUE_AMT' AS column_name, activity_year, total_rows, PREPAY_DUE_AMT_filled AS filled_count, query_error FROM #fc_007
    UNION ALL
    SELECT 'PAT_ENC_3' AS table_name, 'PREPAY_AMT_FROM_C_NAME' AS column_name, activity_year, total_rows, PREPAY_AMT_FROM_C_NAME_filled AS filled_count, query_error FROM #fc_007
    UNION ALL
    SELECT 'PAT_ENC_3' AS table_name, 'PREPAY_PAID_AMT' AS column_name, activity_year, total_rows, PREPAY_PAID_AMT_filled AS filled_count, query_error FROM #fc_007
    UNION ALL
    SELECT 'PAT_ENC_3' AS table_name, 'PREADMSN_TESTING_DT' AS column_name, activity_year, total_rows, PREADMSN_TESTING_DT_filled AS filled_count, query_error FROM #fc_007
    UNION ALL
    SELECT 'PAT_ENC_3' AS table_name, 'SMK_CESS_USER_ID' AS column_name, activity_year, total_rows, SMK_CESS_USER_ID_filled AS filled_count, query_error FROM #fc_007
    UNION ALL
    SELECT 'PAT_ENC_3' AS table_name, 'SMK_CESS_USER_ID_NAME' AS column_name, activity_year, total_rows, SMK_CESS_USER_ID_NAME_filled AS filled_count, query_error FROM #fc_007
    UNION ALL
    SELECT 'PAT_ENC_3' AS table_name, 'SMK_CESS_DTTM' AS column_name, activity_year, total_rows, SMK_CESS_DTTM_filled AS filled_count, query_error FROM #fc_007
    UNION ALL
    SELECT 'PAT_ENC_3' AS table_name, 'DO_NOT_BILL_INS_YN' AS column_name, activity_year, total_rows, DO_NOT_BILL_INS_YN_filled AS filled_count, query_error FROM #fc_007
    UNION ALL
    SELECT 'PAT_ENC_3' AS table_name, 'SELF_PAY_VISIT_YN' AS column_name, activity_year, total_rows, SELF_PAY_VISIT_YN_filled AS filled_count, query_error FROM #fc_007
    UNION ALL
    SELECT 'PAT_ENC_3' AS table_name, 'REFERRAL_TYPE_C_NAME' AS column_name, activity_year, total_rows, REFERRAL_TYPE_C_NAME_filled AS filled_count, query_error FROM #fc_007
    UNION ALL
    SELECT 'PAT_ENC_3' AS table_name, 'SCHOOL' AS column_name, activity_year, total_rows, SCHOOL_filled AS filled_count, query_error FROM #fc_007
    UNION ALL
    SELECT 'PAT_ENC_3' AS table_name, 'COPAY_NUM_UNITS' AS column_name, activity_year, total_rows, COPAY_NUM_UNITS_filled AS filled_count, query_error FROM #fc_007
    UNION ALL
    SELECT 'PAT_ENC_3' AS table_name, 'COPAY_AMT_PER_UNIT' AS column_name, activity_year, total_rows, COPAY_AMT_PER_UNIT_filled AS filled_count, query_error FROM #fc_007
    UNION ALL
    SELECT 'PAT_ENC_3' AS table_name, 'COPAY_LASTCALC_DT' AS column_name, activity_year, total_rows, COPAY_LASTCALC_DT_filled AS filled_count, query_error FROM #fc_007
    UNION ALL
    SELECT 'PAT_ENC_3' AS table_name, 'COPAY_OVERRIDDEN_YN' AS column_name, activity_year, total_rows, COPAY_OVERRIDDEN_YN_filled AS filled_count, query_error FROM #fc_007
    UNION ALL
    SELECT 'PAT_ENC_3' AS table_name, 'OB_TOTAL_WT_GAIN' AS column_name, activity_year, total_rows, OB_TOTAL_WT_GAIN_filled AS filled_count, query_error FROM #fc_007
    UNION ALL
    SELECT 'PAT_ENC_3' AS table_name, 'MEDICAID_GROUP_NAME' AS column_name, activity_year, total_rows, MEDICAID_GROUP_NAME_filled AS filled_count, query_error FROM #fc_007
    UNION ALL
    SELECT 'PAT_ENC_3' AS table_name, 'STUDENT_STATUS_C_NAME' AS column_name, activity_year, total_rows, STUDENT_STATUS_C_NAME_filled AS filled_count, query_error FROM #fc_007
    UNION ALL
    SELECT 'PAT_ENC_3' AS table_name, 'MEDICAID_GROUP_ID' AS column_name, activity_year, total_rows, MEDICAID_GROUP_ID_filled AS filled_count, query_error FROM #fc_007
    UNION ALL
    SELECT 'PAT_ENC_3' AS table_name, 'EXTERNAL_REF_ID' AS column_name, activity_year, total_rows, EXTERNAL_REF_ID_filled AS filled_count, query_error FROM #fc_007
    UNION ALL
    SELECT 'PAT_ENC_3' AS table_name, 'OUTCOME_C_NAME' AS column_name, activity_year, total_rows, OUTCOME_C_NAME_filled AS filled_count, query_error FROM #fc_007
    UNION ALL
    SELECT 'PAT_ENC_3' AS table_name, 'HSPC_NO_ADM_C_NAME' AS column_name, activity_year, total_rows, HSPC_NO_ADM_C_NAME_filled AS filled_count, query_error FROM #fc_007
    UNION ALL
    SELECT 'PAT_ENC_4' AS table_name, 'PAT_ENC_CSN_ID' AS column_name, activity_year, total_rows, PAT_ENC_CSN_ID_filled AS filled_count, query_error FROM #fc_008
    UNION ALL
    SELECT 'PAT_ENC_4' AS table_name, 'FAMILY_SIZE' AS column_name, activity_year, total_rows, FAMILY_SIZE_filled AS filled_count, query_error FROM #fc_008
    UNION ALL
    SELECT 'PAT_ENC_4' AS table_name, 'VISIT_NUMBER' AS column_name, activity_year, total_rows, VISIT_NUMBER_filled AS filled_count, query_error FROM #fc_008
    UNION ALL
    SELECT 'PAT_ENC_4' AS table_name, 'PAT_CNCT_IND_C_NAME' AS column_name, activity_year, total_rows, PAT_CNCT_IND_C_NAME_filled AS filled_count, query_error FROM #fc_008
    UNION ALL
    SELECT 'PAT_ENC_4' AS table_name, 'DENTAL_STUDENT_ID_PROV_NAME' AS column_name, activity_year, total_rows, DENTAL_STUDENT_ID_PROV_NAME_filled AS filled_count, query_error FROM #fc_008
    UNION ALL
    SELECT 'PAT_ENC_4' AS table_name, 'LOC_VISIT_ID_LOC_NAME' AS column_name, activity_year, total_rows, LOC_VISIT_ID_LOC_NAME_filled AS filled_count, query_error FROM #fc_008
    UNION ALL
    SELECT 'PAT_ENC_4' AS table_name, 'COPAY_NOT_COVERED_C_NAME' AS column_name, activity_year, total_rows, COPAY_NOT_COVERED_C_NAME_filled AS filled_count, query_error FROM #fc_008
    UNION ALL
    SELECT 'PAT_ENC_4' AS table_name, 'COPAY_COLL_FLAG_YN' AS column_name, activity_year, total_rows, COPAY_COLL_FLAG_YN_filled AS filled_count, query_error FROM #fc_008
    UNION ALL
    SELECT 'PAT_ENC_4' AS table_name, 'COPAY_COLL_PERSON' AS column_name, activity_year, total_rows, COPAY_COLL_PERSON_filled AS filled_count, query_error FROM #fc_008
    UNION ALL
    SELECT 'PAT_ENC_4' AS table_name, 'COPAY_WAIVE_RSN_C_NAME' AS column_name, activity_year, total_rows, COPAY_WAIVE_RSN_C_NAME_filled AS filled_count, query_error FROM #fc_008
    UNION ALL
    SELECT 'PAT_ENC_4' AS table_name, 'COPAY_MIN_VALUE' AS column_name, activity_year, total_rows, COPAY_MIN_VALUE_filled AS filled_count, query_error FROM #fc_008
    UNION ALL
    SELECT 'PAT_ENC_4' AS table_name, 'COPAY_RECEIPT_NUM' AS column_name, activity_year, total_rows, COPAY_RECEIPT_NUM_filled AS filled_count, query_error FROM #fc_008
    UNION ALL
    SELECT 'PAT_ENC_4' AS table_name, 'BEN_ADJ_COINS_AMT' AS column_name, activity_year, total_rows, BEN_ADJ_COINS_AMT_filled AS filled_count, query_error FROM #fc_008
    UNION ALL
    SELECT 'PAT_ENC_4' AS table_name, 'BEN_ADJ_DEDUCT_AMT' AS column_name, activity_year, total_rows, BEN_ADJ_DEDUCT_AMT_filled AS filled_count, query_error FROM #fc_008
    UNION ALL
    SELECT 'PAT_ENC_4' AS table_name, 'PAT_HOMELESS_YN' AS column_name, activity_year, total_rows, PAT_HOMELESS_YN_filled AS filled_count, query_error FROM #fc_008
    UNION ALL
    SELECT 'PAT_ENC_4' AS table_name, 'PAT_HOMELESS_TYP_C_NAME' AS column_name, activity_year, total_rows, PAT_HOMELESS_TYP_C_NAME_filled AS filled_count, query_error FROM #fc_008
    UNION ALL
    SELECT 'PAT_ENC_4' AS table_name, 'PERCENTAGE_OF_FPL' AS column_name, activity_year, total_rows, PERCENTAGE_OF_FPL_filled AS filled_count, query_error FROM #fc_008
    UNION ALL
    SELECT 'PAT_ENC_4' AS table_name, 'MSG_RECEIVED_DTTM' AS column_name, activity_year, total_rows, MSG_RECEIVED_DTTM_filled AS filled_count, query_error FROM #fc_008
    UNION ALL
    SELECT 'PAT_ENC_4' AS table_name, 'TOBACCO_USE_VRFY_YN' AS column_name, activity_year, total_rows, TOBACCO_USE_VRFY_YN_filled AS filled_count, query_error FROM #fc_008
    UNION ALL
    SELECT 'PAT_ENC_4' AS table_name, 'CR_TX_TYPE_C_NAME' AS column_name, activity_year, total_rows, CR_TX_TYPE_C_NAME_filled AS filled_count, query_error FROM #fc_008
    UNION ALL
    SELECT 'PAT_ENC_4' AS table_name, 'ORIG_ENC_CSN' AS column_name, activity_year, total_rows, ORIG_ENC_CSN_filled AS filled_count, query_error FROM #fc_008
    UNION ALL
    SELECT 'PAT_ENC_4' AS table_name, 'PHYS_BP_COMMENTS' AS column_name, activity_year, total_rows, PHYS_BP_COMMENTS_filled AS filled_count, query_error FROM #fc_008
    UNION ALL
    SELECT 'PAT_ENC_4' AS table_name, 'PHYS_TEMP_COMMENTS' AS column_name, activity_year, total_rows, PHYS_TEMP_COMMENTS_filled AS filled_count, query_error FROM #fc_008
    UNION ALL
    SELECT 'PAT_ENC_4' AS table_name, 'PHYS_TEMPSRC_COMNTS' AS column_name, activity_year, total_rows, PHYS_TEMPSRC_COMNTS_filled AS filled_count, query_error FROM #fc_008
    UNION ALL
    SELECT 'PAT_ENC_4' AS table_name, 'PHYS_PULSE_COMMENTS' AS column_name, activity_year, total_rows, PHYS_PULSE_COMMENTS_filled AS filled_count, query_error FROM #fc_008
    UNION ALL
    SELECT 'PAT_ENC_4' AS table_name, 'PHYS_WEIGHT_COMNTS' AS column_name, activity_year, total_rows, PHYS_WEIGHT_COMNTS_filled AS filled_count, query_error FROM #fc_008
    UNION ALL
    SELECT 'PAT_ENC_4' AS table_name, 'PHYS_HEIGHT_COMNTS' AS column_name, activity_year, total_rows, PHYS_HEIGHT_COMNTS_filled AS filled_count, query_error FROM #fc_008
    UNION ALL
    SELECT 'PAT_ENC_4' AS table_name, 'PHYS_RESP_COMMENTS' AS column_name, activity_year, total_rows, PHYS_RESP_COMMENTS_filled AS filled_count, query_error FROM #fc_008
    UNION ALL
    SELECT 'PAT_ENC_4' AS table_name, 'PHYS_SPO2_COMMENTS' AS column_name, activity_year, total_rows, PHYS_SPO2_COMMENTS_filled AS filled_count, query_error FROM #fc_008
    UNION ALL
    SELECT 'PAT_ENC_4' AS table_name, 'PHYS_PF_COMMENTS' AS column_name, activity_year, total_rows, PHYS_PF_COMMENTS_filled AS filled_count, query_error FROM #fc_008
    UNION ALL
    SELECT 'PAT_ENC_4' AS table_name, 'INTERPRT_ASGN_CMT' AS column_name, activity_year, total_rows, INTERPRT_ASGN_CMT_filled AS filled_count, query_error FROM #fc_008
    UNION ALL
    SELECT 'PAT_ENC_4' AS table_name, 'PAT_HOUSING_STAT_C_NAME' AS column_name, activity_year, total_rows, PAT_HOUSING_STAT_C_NAME_filled AS filled_count, query_error FROM #fc_008
    UNION ALL
    SELECT 'PAT_ENC_4' AS table_name, 'BCRA_AGE' AS column_name, activity_year, total_rows, BCRA_AGE_filled AS filled_count, query_error FROM #fc_008
    UNION ALL
    SELECT 'PAT_ENC_4' AS table_name, 'BCRA_MENARCHE_AGE_C_NAME' AS column_name, activity_year, total_rows, BCRA_MENARCHE_AGE_C_NAME_filled AS filled_count, query_error FROM #fc_008
    UNION ALL
    SELECT 'PAT_ENC_4' AS table_name, 'BCRA_FST_LIVBIRTH_C_NAME' AS column_name, activity_year, total_rows, BCRA_FST_LIVBIRTH_C_NAME_filled AS filled_count, query_error FROM #fc_008
    UNION ALL
    SELECT 'PAT_ENC_4' AS table_name, 'BCRA_FST_DEG_REL_C_NAME' AS column_name, activity_year, total_rows, BCRA_FST_DEG_REL_C_NAME_filled AS filled_count, query_error FROM #fc_008
    UNION ALL
    SELECT 'PAT_ENC_4' AS table_name, 'BCRA_NUM_BIOPSY_C_NAME' AS column_name, activity_year, total_rows, BCRA_NUM_BIOPSY_C_NAME_filled AS filled_count, query_error FROM #fc_008
    UNION ALL
    SELECT 'PAT_ENC_4' AS table_name, 'BCRA_ATYP_HYPLSA_C_NAME' AS column_name, activity_year, total_rows, BCRA_ATYP_HYPLSA_C_NAME_filled AS filled_count, query_error FROM #fc_008
    UNION ALL
    SELECT 'PAT_ENC_4' AS table_name, 'BCRA_RACE_C_NAME' AS column_name, activity_year, total_rows, BCRA_RACE_C_NAME_filled AS filled_count, query_error FROM #fc_008
    UNION ALL
    SELECT 'PAT_ENC_4' AS table_name, 'LB_ENC_START_DT' AS column_name, activity_year, total_rows, LB_ENC_START_DT_filled AS filled_count, query_error FROM #fc_008
    UNION ALL
    SELECT 'PAT_ENC_4' AS table_name, 'LB_ENC_END_DT' AS column_name, activity_year, total_rows, LB_ENC_END_DT_filled AS filled_count, query_error FROM #fc_008
    UNION ALL
    SELECT 'PAT_ENC_4' AS table_name, 'WAITING_LIST_ID' AS column_name, activity_year, total_rows, WAITING_LIST_ID_filled AS filled_count, query_error FROM #fc_008
    UNION ALL
    SELECT 'PAT_ENC_4' AS table_name, 'SUBMITTER_ID' AS column_name, activity_year, total_rows, SUBMITTER_ID_filled AS filled_count, query_error FROM #fc_008
    UNION ALL
    SELECT 'PAT_ENC_4' AS table_name, 'SUBMITTER_ID_RECORD_NAME' AS column_name, activity_year, total_rows, SUBMITTER_ID_RECORD_NAME_filled AS filled_count, query_error FROM #fc_008
    UNION ALL
    SELECT 'PAT_ENC_4' AS table_name, 'BILL_TO_SUBMITTER_C_NAME' AS column_name, activity_year, total_rows, BILL_TO_SUBMITTER_C_NAME_filled AS filled_count, query_error FROM #fc_008
    UNION ALL
    SELECT 'PAT_ENC_4' AS table_name, 'SUBMITTER_ACCT_ID' AS column_name, activity_year, total_rows, SUBMITTER_ACCT_ID_filled AS filled_count, query_error FROM #fc_008
    UNION ALL
    SELECT 'PAT_ENC_4' AS table_name, 'LB_BLNG_ENC_SRVC_DT' AS column_name, activity_year, total_rows, LB_BLNG_ENC_SRVC_DT_filled AS filled_count, query_error FROM #fc_008
    UNION ALL
    SELECT 'PAT_ENC_4' AS table_name, 'ECHKIN_STATUS_C_NAME' AS column_name, activity_year, total_rows, ECHKIN_STATUS_C_NAME_filled AS filled_count, query_error FROM #fc_008
    UNION ALL
    SELECT 'PAT_ENC_4' AS table_name, 'PB_VISIT_HAR_ID' AS column_name, activity_year, total_rows, PB_VISIT_HAR_ID_filled AS filled_count, query_error FROM #fc_008
    UNION ALL
    SELECT 'PAT_ENC_4' AS table_name, 'TECHNICAL_REFERRAL_ID' AS column_name, activity_year, total_rows, TECHNICAL_REFERRAL_ID_filled AS filled_count, query_error FROM #fc_008
    UNION ALL
    SELECT 'PAT_ENC_4' AS table_name, 'CR_CLIENT_REF_IDNT' AS column_name, activity_year, total_rows, CR_CLIENT_REF_IDNT_filled AS filled_count, query_error FROM #fc_008
    UNION ALL
    SELECT 'PAT_ENC_4' AS table_name, 'CR_BENEFIT_REF_IDNT' AS column_name, activity_year, total_rows, CR_BENEFIT_REF_IDNT_filled AS filled_count, query_error FROM #fc_008
    UNION ALL
    SELECT 'PAT_ENC_4' AS table_name, 'CR_MESSAGE_ENGLISH' AS column_name, activity_year, total_rows, CR_MESSAGE_ENGLISH_filled AS filled_count, query_error FROM #fc_008
    UNION ALL
    SELECT 'PAT_ENC_4' AS table_name, 'CR_MESSAGE_SPANISH' AS column_name, activity_year, total_rows, CR_MESSAGE_SPANISH_filled AS filled_count, query_error FROM #fc_008
    UNION ALL
    SELECT 'PAT_ENC_4' AS table_name, 'CR_QUERY_SENT_UTC_DTTM' AS column_name, activity_year, total_rows, CR_QUERY_SENT_UTC_DTTM_filled AS filled_count, query_error FROM #fc_008
    UNION ALL
    SELECT 'PAT_ENC_4' AS table_name, 'CR_RESP_RECVD_UTC_DTTM' AS column_name, activity_year, total_rows, CR_RESP_RECVD_UTC_DTTM_filled AS filled_count, query_error FROM #fc_008
    UNION ALL
    SELECT 'PAT_ENC_4' AS table_name, 'CR_QUERY_ERROR' AS column_name, activity_year, total_rows, CR_QUERY_ERROR_filled AS filled_count, query_error FROM #fc_008
    UNION ALL
    SELECT 'PAT_ENC_4' AS table_name, 'COPAY_REDUCTION_AMT' AS column_name, activity_year, total_rows, COPAY_REDUCTION_AMT_filled AS filled_count, query_error FROM #fc_008
    UNION ALL
    SELECT 'PAT_ENC_5' AS table_name, 'PAT_ENC_CSN_ID' AS column_name, activity_year, total_rows, PAT_ENC_CSN_ID_filled AS filled_count, query_error FROM #fc_009
    UNION ALL
    SELECT 'PAT_ENC_5' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count, query_error FROM #fc_009
    UNION ALL
    SELECT 'PAT_ENC_5' AS table_name, 'PUBLIC_HOUSING_YN' AS column_name, activity_year, total_rows, PUBLIC_HOUSING_YN_filled AS filled_count, query_error FROM #fc_009
    UNION ALL
    SELECT 'PAT_ENC_5' AS table_name, 'PVT_HOSP_ENC_C_NAME' AS column_name, activity_year, total_rows, PVT_HOSP_ENC_C_NAME_filled AS filled_count, query_error FROM #fc_009
    UNION ALL
    SELECT 'PAT_ENC_5' AS table_name, 'LINK_INS_TYPE_C_NAME' AS column_name, activity_year, total_rows, LINK_INS_TYPE_C_NAME_filled AS filled_count, query_error FROM #fc_009
    UNION ALL
    SELECT 'PAT_ENC_5' AS table_name, 'PAT_VER_HCA_C_NAME' AS column_name, activity_year, total_rows, PAT_VER_HCA_C_NAME_filled AS filled_count, query_error FROM #fc_009
    UNION ALL
    SELECT 'PAT_ENC_5' AS table_name, 'EXT_GRP_IDNT' AS column_name, activity_year, total_rows, EXT_GRP_IDNT_filled AS filled_count, query_error FROM #fc_009
    UNION ALL
    SELECT 'PAT_ENC_5' AS table_name, 'EXT_GRP_SRC_C_NAME' AS column_name, activity_year, total_rows, EXT_GRP_SRC_C_NAME_filled AS filled_count, query_error FROM #fc_009
    UNION ALL
    SELECT 'PAT_ENC_5' AS table_name, 'PREPAY_SET_BY_USER_YN' AS column_name, activity_year, total_rows, PREPAY_SET_BY_USER_YN_filled AS filled_count, query_error FROM #fc_009
    UNION ALL
    SELECT 'PAT_ENC_5' AS table_name, 'PREPAY_UPDATE_USER_ID' AS column_name, activity_year, total_rows, PREPAY_UPDATE_USER_ID_filled AS filled_count, query_error FROM #fc_009
    UNION ALL
    SELECT 'PAT_ENC_5' AS table_name, 'PREPAY_UPDATE_USER_ID_NAME' AS column_name, activity_year, total_rows, PREPAY_UPDATE_USER_ID_NAME_filled AS filled_count, query_error FROM #fc_009
    UNION ALL
    SELECT 'PAT_ENC_5' AS table_name, 'PREPAY_UPDATE_INST_DTTM' AS column_name, activity_year, total_rows, PREPAY_UPDATE_INST_DTTM_filled AS filled_count, query_error FROM #fc_009
    UNION ALL
    SELECT 'PAT_ENC_5' AS table_name, 'PREPAY_CALC_SCENARIO' AS column_name, activity_year, total_rows, PREPAY_CALC_SCENARIO_filled AS filled_count, query_error FROM #fc_009
    UNION ALL
    SELECT 'PAT_ENC_5' AS table_name, 'AUTHCERT_ID' AS column_name, activity_year, total_rows, AUTHCERT_ID_filled AS filled_count, query_error FROM #fc_009
    UNION ALL
    SELECT 'PAT_ENC_5' AS table_name, 'ED_REF_CALLBAK_YN' AS column_name, activity_year, total_rows, ED_REF_CALLBAK_YN_filled AS filled_count, query_error FROM #fc_009
    UNION ALL
    SELECT 'PAT_ENC_5' AS table_name, 'ED_REF_CALLBAK_P_ID_PROV_NAME' AS column_name, activity_year, total_rows, ED_REF_CALLBAK_P_ID_PROV_NAME_filled AS filled_count, query_error FROM #fc_009
    UNION ALL
    SELECT 'PAT_ENC_5' AS table_name, 'ED_REF_CALLBAK_C_ID_LOC_NAME' AS column_name, activity_year, total_rows, ED_REF_CALLBAK_C_ID_LOC_NAME_filled AS filled_count, query_error FROM #fc_009
    UNION ALL
    SELECT 'PAT_ENC_5' AS table_name, 'ED_REF_CALLBAK_NUM' AS column_name, activity_year, total_rows, ED_REF_CALLBAK_NUM_filled AS filled_count, query_error FROM #fc_009
    UNION ALL
    SELECT 'PAT_ENC_5' AS table_name, 'IS_ON_DEMAND_VV_YN' AS column_name, activity_year, total_rows, IS_ON_DEMAND_VV_YN_filled AS filled_count, query_error FROM #fc_009
    UNION ALL
    SELECT 'PAT_ENC_5' AS table_name, 'ATTR_DEPARTMENT_ID_EXTERNAL_NAME' AS column_name, activity_year, total_rows, ATTR_DEPARTMENT_ID_EXTERNAL_NAME_filled AS filled_count, query_error FROM #fc_009
    UNION ALL
    SELECT 'PAT_ENC_5' AS table_name, 'PAT_DTREE_ANSWER_ID' AS column_name, activity_year, total_rows, PAT_DTREE_ANSWER_ID_filled AS filled_count, query_error FROM #fc_009
    UNION ALL
    SELECT 'PAT_ENC_5' AS table_name, 'PREPAY_DISCNT_AMT' AS column_name, activity_year, total_rows, PREPAY_DISCNT_AMT_filled AS filled_count, query_error FROM #fc_009
    UNION ALL
    SELECT 'PAT_ENC_5' AS table_name, 'PREPAY_DISCNT_PCT' AS column_name, activity_year, total_rows, PREPAY_DISCNT_PCT_filled AS filled_count, query_error FROM #fc_009
    UNION ALL
    SELECT 'PAT_ENC_5' AS table_name, 'PREPAY_PROPOSED_DISCNT_AMT' AS column_name, activity_year, total_rows, PREPAY_PROPOSED_DISCNT_AMT_filled AS filled_count, query_error FROM #fc_009
    UNION ALL
    SELECT 'PAT_ENC_5' AS table_name, 'PREPAY_DISCNT_CALC_RULE_ID' AS column_name, activity_year, total_rows, PREPAY_DISCNT_CALC_RULE_ID_filled AS filled_count, query_error FROM #fc_009
    UNION ALL
    SELECT 'PAT_ENC_5' AS table_name, 'PREPAY_DISCNT_CALC_RULE_ID_RULE_NAME' AS column_name, activity_year, total_rows, PREPAY_DISCNT_CALC_RULE_ID_RULE_NAME_filled AS filled_count, query_error FROM #fc_009
    UNION ALL
    SELECT 'PAT_ENC_5' AS table_name, 'PREPAY_DISCNT_CALC_PCT' AS column_name, activity_year, total_rows, PREPAY_DISCNT_CALC_PCT_filled AS filled_count, query_error FROM #fc_009
    UNION ALL
    SELECT 'PAT_ENC_5' AS table_name, 'PREPAY_DISCNT_OVRIDE_AMT' AS column_name, activity_year, total_rows, PREPAY_DISCNT_OVRIDE_AMT_filled AS filled_count, query_error FROM #fc_009
    UNION ALL
    SELECT 'PAT_ENC_5' AS table_name, 'PREPAY_DISCNT_OVRIDE_PCT' AS column_name, activity_year, total_rows, PREPAY_DISCNT_OVRIDE_PCT_filled AS filled_count, query_error FROM #fc_009
    UNION ALL
    SELECT 'PAT_ENC_5' AS table_name, 'PREPAY_DISCNT_OVRIDE_USER_ID' AS column_name, activity_year, total_rows, PREPAY_DISCNT_OVRIDE_USER_ID_filled AS filled_count, query_error FROM #fc_009
    UNION ALL
    SELECT 'PAT_ENC_5' AS table_name, 'PREPAY_DISCNT_OVRIDE_USER_ID_NAME' AS column_name, activity_year, total_rows, PREPAY_DISCNT_OVRIDE_USER_ID_NAME_filled AS filled_count, query_error FROM #fc_009
    UNION ALL
    SELECT 'PAT_ENC_5' AS table_name, 'PREPAY_DISCNT_OVRIDE_CMT' AS column_name, activity_year, total_rows, PREPAY_DISCNT_OVRIDE_CMT_filled AS filled_count, query_error FROM #fc_009
    UNION ALL
    SELECT 'PAT_ENC_5' AS table_name, 'PREPAY_DISCNT_OVRIDE_DTTM' AS column_name, activity_year, total_rows, PREPAY_DISCNT_OVRIDE_DTTM_filled AS filled_count, query_error FROM #fc_009
    UNION ALL
    SELECT 'PAT_ENC_5' AS table_name, 'EVISIT_STATUS_C_NAME' AS column_name, activity_year, total_rows, EVISIT_STATUS_C_NAME_filled AS filled_count, query_error FROM #fc_009
    UNION ALL
    SELECT 'PAT_ENC_6' AS table_name, 'PAT_ENC_CSN_ID' AS column_name, activity_year, total_rows, PAT_ENC_CSN_ID_filled AS filled_count, query_error FROM #fc_010
    UNION ALL
    SELECT 'PAT_ENC_6' AS table_name, 'PAT_ENC_DATE_REAL' AS column_name, activity_year, total_rows, PAT_ENC_DATE_REAL_filled AS filled_count, query_error FROM #fc_010
    UNION ALL
    SELECT 'PAT_ENC_6' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count, query_error FROM #fc_010
    UNION ALL
    SELECT 'PAT_ENC_6' AS table_name, 'LINKED_ENC_CSN' AS column_name, activity_year, total_rows, LINKED_ENC_CSN_filled AS filled_count, query_error FROM #fc_010
    UNION ALL
    SELECT 'PAT_ENC_6' AS table_name, 'LMP_PRECISION_C_NAME' AS column_name, activity_year, total_rows, LMP_PRECISION_C_NAME_filled AS filled_count, query_error FROM #fc_010
    UNION ALL
    SELECT 'PAT_ENC_6' AS table_name, 'PLANNED_BILL_AREA_ID' AS column_name, activity_year, total_rows, PLANNED_BILL_AREA_ID_filled AS filled_count, query_error FROM #fc_010
    UNION ALL
    SELECT 'PAT_ENC_6' AS table_name, 'PLANNED_BILL_AREA_ID_BILL_AREA_NAME' AS column_name, activity_year, total_rows, PLANNED_BILL_AREA_ID_BILL_AREA_NAME_filled AS filled_count, query_error FROM #fc_010
    UNION ALL
    SELECT 'PAT_ENC_6' AS table_name, 'BCRA_BRCA_GENE_MUT_C_NAME' AS column_name, activity_year, total_rows, BCRA_BRCA_GENE_MUT_C_NAME_filled AS filled_count, query_error FROM #fc_010
    UNION ALL
    SELECT 'PAT_ENC_6' AS table_name, 'SVC_TARGET_EFFORT_YN' AS column_name, activity_year, total_rows, SVC_TARGET_EFFORT_YN_filled AS filled_count, query_error FROM #fc_010
    UNION ALL
    SELECT 'PAT_ENC_6' AS table_name, 'OUTPAT_VISIT_GRP_C_NAME' AS column_name, activity_year, total_rows, OUTPAT_VISIT_GRP_C_NAME_filled AS filled_count, query_error FROM #fc_010
    UNION ALL
    SELECT 'PAT_ENC_6' AS table_name, 'PSYCH_ARRIVAL_C_NAME' AS column_name, activity_year, total_rows, PSYCH_ARRIVAL_C_NAME_filled AS filled_count, query_error FROM #fc_010
    UNION ALL
    SELECT 'PAT_ENC_6' AS table_name, 'PLAN_RECUR_TREAT_YN' AS column_name, activity_year, total_rows, PLAN_RECUR_TREAT_YN_filled AS filled_count, query_error FROM #fc_010
    UNION ALL
    SELECT 'PAT_ENC_6' AS table_name, 'HUS_VISIT_TYPE_C_NAME' AS column_name, activity_year, total_rows, HUS_VISIT_TYPE_C_NAME_filled AS filled_count, query_error FROM #fc_010
    UNION ALL
    SELECT 'PAT_ENC_6' AS table_name, 'SOCIAL_SRVC_AREA_C_NAME' AS column_name, activity_year, total_rows, SOCIAL_SRVC_AREA_C_NAME_filled AS filled_count, query_error FROM #fc_010
    UNION ALL
    SELECT 'PAT_ENC_6' AS table_name, 'EXT_LTC_PAT_YN' AS column_name, activity_year, total_rows, EXT_LTC_PAT_YN_filled AS filled_count, query_error FROM #fc_010
    UNION ALL
    SELECT 'PAT_ENC_6' AS table_name, 'VETERAN_ENC_MED_CVG_C_NAME' AS column_name, activity_year, total_rows, VETERAN_ENC_MED_CVG_C_NAME_filled AS filled_count, query_error FROM #fc_010
    UNION ALL
    SELECT 'PAT_ENC_6' AS table_name, 'VETERAN_BILLING_CODE_C_NAME' AS column_name, activity_year, total_rows, VETERAN_BILLING_CODE_C_NAME_filled AS filled_count, query_error FROM #fc_010
    UNION ALL
    SELECT 'PAT_ENC_6' AS table_name, 'ED_REF_CALLBAK_D_ID_EXTERNAL_NAME' AS column_name, activity_year, total_rows, ED_REF_CALLBAK_D_ID_EXTERNAL_NAME_filled AS filled_count, query_error FROM #fc_010
    UNION ALL
    SELECT 'PAT_ENC_6' AS table_name, 'RFV_USED_TO_SCHED_C_NAME' AS column_name, activity_year, total_rows, RFV_USED_TO_SCHED_C_NAME_filled AS filled_count, query_error FROM #fc_010
    UNION ALL
    SELECT 'PAT_ENC_6' AS table_name, 'BMI_PERCENTILE' AS column_name, activity_year, total_rows, BMI_PERCENTILE_filled AS filled_count, query_error FROM #fc_010
    UNION ALL
    SELECT 'PAT_ENC_6' AS table_name, 'CREATION_ORD_ID' AS column_name, activity_year, total_rows, CREATION_ORD_ID_filled AS filled_count, query_error FROM #fc_010
    UNION ALL
    SELECT 'PAT_ENC_6' AS table_name, 'EXT_TX_STATUS_C_NAME' AS column_name, activity_year, total_rows, EXT_TX_STATUS_C_NAME_filled AS filled_count, query_error FROM #fc_010
    UNION ALL
    SELECT 'PAT_ENC_6' AS table_name, 'EXT_TX_STATUS_CMT' AS column_name, activity_year, total_rows, EXT_TX_STATUS_CMT_filled AS filled_count, query_error FROM #fc_010
    UNION ALL
    SELECT 'PAT_ENC_6' AS table_name, 'EXT_ACCM_STATUS_C_NAME' AS column_name, activity_year, total_rows, EXT_ACCM_STATUS_C_NAME_filled AS filled_count, query_error FROM #fc_010
    UNION ALL
    SELECT 'PAT_ENC_6' AS table_name, 'EXT_ACCM_STATUS_CMT' AS column_name, activity_year, total_rows, EXT_ACCM_STATUS_CMT_filled AS filled_count, query_error FROM #fc_010
    UNION ALL
    SELECT 'PAT_ENC_6' AS table_name, 'SG_AT_RISK_IND_C_NAME' AS column_name, activity_year, total_rows, SG_AT_RISK_IND_C_NAME_filled AS filled_count, query_error FROM #fc_010
    UNION ALL
    SELECT 'PAT_ENC_6' AS table_name, 'SG_FC_STATUS_C_NAME' AS column_name, activity_year, total_rows, SG_FC_STATUS_C_NAME_filled AS filled_count, query_error FROM #fc_010
    UNION ALL
    SELECT 'PAT_ENC_6' AS table_name, 'ELIG_PLAN_SELECT_YN' AS column_name, activity_year, total_rows, ELIG_PLAN_SELECT_YN_filled AS filled_count, query_error FROM #fc_010
    UNION ALL
    SELECT 'PAT_ENC_6' AS table_name, 'SG_MOH_URGENCY_C_NAME' AS column_name, activity_year, total_rows, SG_MOH_URGENCY_C_NAME_filled AS filled_count, query_error FROM #fc_010
    UNION ALL
    SELECT 'PAT_ENC_6' AS table_name, 'SG_NAMED_REFERRAL_YN' AS column_name, activity_year, total_rows, SG_NAMED_REFERRAL_YN_filled AS filled_count, query_error FROM #fc_010
    UNION ALL
    SELECT 'PAT_ENC_6' AS table_name, 'SG_PAT_REQUEST_YN' AS column_name, activity_year, total_rows, SG_PAT_REQUEST_YN_filled AS filled_count, query_error FROM #fc_010
    UNION ALL
    SELECT 'PAT_ENC_6' AS table_name, 'SG_TREATMENT_PROG_C_NAME' AS column_name, activity_year, total_rows, SG_TREATMENT_PROG_C_NAME_filled AS filled_count, query_error FROM #fc_010
    UNION ALL
    SELECT 'PAT_ENC_6' AS table_name, 'SG_APPT_RATIONALE_C_NAME' AS column_name, activity_year, total_rows, SG_APPT_RATIONALE_C_NAME_filled AS filled_count, query_error FROM #fc_010
    UNION ALL
    SELECT 'PAT_ENC_6' AS table_name, 'EVISIT_RFV_C_NAME' AS column_name, activity_year, total_rows, EVISIT_RFV_C_NAME_filled AS filled_count, query_error FROM #fc_010
    UNION ALL
    SELECT 'PAT_ENC_6' AS table_name, 'EVISIT_YN' AS column_name, activity_year, total_rows, EVISIT_YN_filled AS filled_count, query_error FROM #fc_010
    UNION ALL
    SELECT 'PAT_ENC_6' AS table_name, 'EVISIT_TLH_ALLOWED_SUBLOC_C_NAME' AS column_name, activity_year, total_rows, EVISIT_TLH_ALLOWED_SUBLOC_C_NAME_filled AS filled_count, query_error FROM #fc_010
    UNION ALL
    SELECT 'PAT_ENC_6' AS table_name, 'EVISIT_TLH_ALLOWED_LOC_C_NAME' AS column_name, activity_year, total_rows, EVISIT_TLH_ALLOWED_LOC_C_NAME_filled AS filled_count, query_error FROM #fc_010
    UNION ALL
    SELECT 'PAT_ENC_6' AS table_name, 'APPT_AUTH_STATUS_C_NAME' AS column_name, activity_year, total_rows, APPT_AUTH_STATUS_C_NAME_filled AS filled_count, query_error FROM #fc_010
    UNION ALL
    SELECT 'PAT_ENC_6' AS table_name, 'EVISIT_NEW_STATUS_C_NAME' AS column_name, activity_year, total_rows, EVISIT_NEW_STATUS_C_NAME_filled AS filled_count, query_error FROM #fc_010
    UNION ALL
    SELECT 'PAT_ENC_6' AS table_name, 'LAB_RESP_USER_ID' AS column_name, activity_year, total_rows, LAB_RESP_USER_ID_filled AS filled_count, query_error FROM #fc_010
    UNION ALL
    SELECT 'PAT_ENC_6' AS table_name, 'LAB_RESP_USER_ID_NAME' AS column_name, activity_year, total_rows, LAB_RESP_USER_ID_NAME_filled AS filled_count, query_error FROM #fc_010
    UNION ALL
    SELECT 'PAT_ENC_6' AS table_name, 'EXT_MEDS_UPD_INST_UTC_DTTM' AS column_name, activity_year, total_rows, EXT_MEDS_UPD_INST_UTC_DTTM_filled AS filled_count, query_error FROM #fc_010
    UNION ALL
    SELECT 'PAT_ENC_6' AS table_name, 'INTF_PRIMARY_PAT_ENC_CSN_ID' AS column_name, activity_year, total_rows, INTF_PRIMARY_PAT_ENC_CSN_ID_filled AS filled_count, query_error FROM #fc_010
    UNION ALL
    SELECT 'PAT_ENC_6' AS table_name, 'OVERRIDE_BCRA_NUM_BIOPSY_C_NAME' AS column_name, activity_year, total_rows, OVERRIDE_BCRA_NUM_BIOPSY_C_NAME_filled AS filled_count, query_error FROM #fc_010
    UNION ALL
    SELECT 'PAT_ENC_6' AS table_name, 'OVERRIDE_BCRA_RACE_C_NAME' AS column_name, activity_year, total_rows, OVERRIDE_BCRA_RACE_C_NAME_filled AS filled_count, query_error FROM #fc_010
    UNION ALL
    SELECT 'PAT_ENC_6' AS table_name, 'OVERRIDE_GAIL_FACTOR_USER_ID' AS column_name, activity_year, total_rows, OVERRIDE_GAIL_FACTOR_USER_ID_filled AS filled_count, query_error FROM #fc_010
    UNION ALL
    SELECT 'PAT_ENC_6' AS table_name, 'OVERRIDE_GAIL_FACTOR_USER_ID_NAME' AS column_name, activity_year, total_rows, OVERRIDE_GAIL_FACTOR_USER_ID_NAME_filled AS filled_count, query_error FROM #fc_010
    UNION ALL
    SELECT 'PAT_ENC_6' AS table_name, 'OVERRIDE_GAIL_FACTOR_DTTM' AS column_name, activity_year, total_rows, OVERRIDE_GAIL_FACTOR_DTTM_filled AS filled_count, query_error FROM #fc_010
    UNION ALL
    SELECT 'PAT_ENC_6' AS table_name, 'VETERAN_COVERAGE_ENC_YN' AS column_name, activity_year, total_rows, VETERAN_COVERAGE_ENC_YN_filled AS filled_count, query_error FROM #fc_010
    UNION ALL
    SELECT 'PAT_ENC_6' AS table_name, 'ADJUD_TO_PHARMACY_COVERAGE_YN' AS column_name, activity_year, total_rows, ADJUD_TO_PHARMACY_COVERAGE_YN_filled AS filled_count, query_error FROM #fc_010
    UNION ALL
    SELECT 'PAT_ENC_6' AS table_name, 'TLH_APRV_SUBLOC_C_NAME' AS column_name, activity_year, total_rows, TLH_APRV_SUBLOC_C_NAME_filled AS filled_count, query_error FROM #fc_010
    UNION ALL
    SELECT 'PAT_ENC_6' AS table_name, 'TLH_APRV_LOC_C_NAME' AS column_name, activity_year, total_rows, TLH_APRV_LOC_C_NAME_filled AS filled_count, query_error FROM #fc_010
    UNION ALL
    SELECT 'PAT_ENC_6' AS table_name, 'ENC_CLOSE_UTC_DTTM' AS column_name, activity_year, total_rows, ENC_CLOSE_UTC_DTTM_filled AS filled_count, query_error FROM #fc_010
    UNION ALL
    SELECT 'PAT_ENC_6' AS table_name, 'SPLIT_FILING_ORDER_YN' AS column_name, activity_year, total_rows, SPLIT_FILING_ORDER_YN_filled AS filled_count, query_error FROM #fc_010
    UNION ALL
    SELECT 'PAT_ENC_7' AS table_name, 'PAT_ENC_CSN_ID' AS column_name, activity_year, total_rows, PAT_ENC_CSN_ID_filled AS filled_count, query_error FROM #fc_011
    UNION ALL
    SELECT 'PAT_ENC_7' AS table_name, 'PAT_ENC_DATE_REAL' AS column_name, activity_year, total_rows, PAT_ENC_DATE_REAL_filled AS filled_count, query_error FROM #fc_011
    UNION ALL
    SELECT 'PAT_ENC_7' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count, query_error FROM #fc_011
    UNION ALL
    SELECT 'PAT_ENC_7' AS table_name, 'NOTIFY_REP_ADMSN_C_NAME' AS column_name, activity_year, total_rows, NOTIFY_REP_ADMSN_C_NAME_filled AS filled_count, query_error FROM #fc_011
    UNION ALL
    SELECT 'PAT_ENC_7' AS table_name, 'REP_NOTIFIED_C_NAME' AS column_name, activity_year, total_rows, REP_NOTIFIED_C_NAME_filled AS filled_count, query_error FROM #fc_011
    UNION ALL
    SELECT 'PAT_ENC_7' AS table_name, 'NOTIFY_REP_COMMENTS' AS column_name, activity_year, total_rows, NOTIFY_REP_COMMENTS_filled AS filled_count, query_error FROM #fc_011
    UNION ALL
    SELECT 'PAT_ENC_7' AS table_name, 'NOTIFY_PCP_ADMSN_C_NAME' AS column_name, activity_year, total_rows, NOTIFY_PCP_ADMSN_C_NAME_filled AS filled_count, query_error FROM #fc_011
    UNION ALL
    SELECT 'PAT_ENC_7' AS table_name, 'PCP_NOTIFIED_C_NAME' AS column_name, activity_year, total_rows, PCP_NOTIFIED_C_NAME_filled AS filled_count, query_error FROM #fc_011
    UNION ALL
    SELECT 'PAT_ENC_7' AS table_name, 'NOTIFY_PCP_COMMENTS' AS column_name, activity_year, total_rows, NOTIFY_PCP_COMMENTS_filled AS filled_count, query_error FROM #fc_011
    UNION ALL
    SELECT 'PAT_ENC_7' AS table_name, 'ROC_PLANNING_PAT_ENC_CSN_ID' AS column_name, activity_year, total_rows, ROC_PLANNING_PAT_ENC_CSN_ID_filled AS filled_count, query_error FROM #fc_011
    UNION ALL
    SELECT 'PAT_ENC_7' AS table_name, 'NUM_PREV_EPSD_C_NAME' AS column_name, activity_year, total_rows, NUM_PREV_EPSD_C_NAME_filled AS filled_count, query_error FROM #fc_011
    UNION ALL
    SELECT 'PAT_ENC_7' AS table_name, 'SPEC_ORD_RSLT_NOT_AUTO_RLS_YN' AS column_name, activity_year, total_rows, SPEC_ORD_RSLT_NOT_AUTO_RLS_YN_filled AS filled_count, query_error FROM #fc_011
    UNION ALL
    SELECT 'PAT_ENC_7' AS table_name, 'RECENTLY_AT_SCHOOL_C_NAME' AS column_name, activity_year, total_rows, RECENTLY_AT_SCHOOL_C_NAME_filled AS filled_count, query_error FROM #fc_011
    UNION ALL
    SELECT 'PAT_ENC_7' AS table_name, 'LMP_COMMENT' AS column_name, activity_year, total_rows, LMP_COMMENT_filled AS filled_count, query_error FROM #fc_011
    UNION ALL
    SELECT 'PAT_ENC_7' AS table_name, 'CONTACT_NUM' AS column_name, activity_year, total_rows, CONTACT_NUM_filled AS filled_count, query_error FROM #fc_011
    UNION ALL
    SELECT 'PAT_ENC_7' AS table_name, 'ABN_REQUIRED_YN' AS column_name, activity_year, total_rows, ABN_REQUIRED_YN_filled AS filled_count, query_error FROM #fc_011
    UNION ALL
    SELECT 'PAT_ENC_7' AS table_name, 'IS_ABN_SIGNED_C_NAME' AS column_name, activity_year, total_rows, IS_ABN_SIGNED_C_NAME_filled AS filled_count, query_error FROM #fc_011
    UNION ALL
    SELECT 'PAT_ENC_7' AS table_name, 'MSP_IS_MEDICARE_HMO_C_NAME' AS column_name, activity_year, total_rows, MSP_IS_MEDICARE_HMO_C_NAME_filled AS filled_count, query_error FROM #fc_011
    UNION ALL
    SELECT 'PAT_ENC_7' AS table_name, 'REG_COMMENTS_DATE' AS column_name, activity_year, total_rows, REG_COMMENTS_DATE_filled AS filled_count, query_error FROM #fc_011
    UNION ALL
    SELECT 'PAT_ENC_7' AS table_name, 'AUTO_MSG_DISABLED_YN' AS column_name, activity_year, total_rows, AUTO_MSG_DISABLED_YN_filled AS filled_count, query_error FROM #fc_011
    UNION ALL
    SELECT 'PAT_ENC_7' AS table_name, 'DONT_AUTO_LINK_YN' AS column_name, activity_year, total_rows, DONT_AUTO_LINK_YN_filled AS filled_count, query_error FROM #fc_011
    UNION ALL
    SELECT 'PAT_ENC_7' AS table_name, 'RSN_FOR_NO_INC_MSG_C_NAME' AS column_name, activity_year, total_rows, RSN_FOR_NO_INC_MSG_C_NAME_filled AS filled_count, query_error FROM #fc_011
    UNION ALL
    SELECT 'PAT_ENC_7' AS table_name, 'HAS_HORMONE_DATA_YN' AS column_name, activity_year, total_rows, HAS_HORMONE_DATA_YN_filled AS filled_count, query_error FROM #fc_011
    UNION ALL
    SELECT 'PAT_ENC_7' AS table_name, 'MEDS_REQUEST_LWS_ID_WORKSTATION_NAME' AS column_name, activity_year, total_rows, MEDS_REQUEST_LWS_ID_WORKSTATION_NAME_filled AS filled_count, query_error FROM #fc_011
    UNION ALL
    SELECT 'PAT_ENC_7' AS table_name, 'EVISIT_SUBMITTED_DTTM' AS column_name, activity_year, total_rows, EVISIT_SUBMITTED_DTTM_filled AS filled_count, query_error FROM #fc_011
    UNION ALL
    SELECT 'PAT_ENC_7' AS table_name, 'EVISIT_TURNAROUND_IN_MINUTES' AS column_name, activity_year, total_rows, EVISIT_TURNAROUND_IN_MINUTES_filled AS filled_count, query_error FROM #fc_011
    UNION ALL
    SELECT 'PAT_ENC_7' AS table_name, 'PREGNANCY_INTENTION_C_NAME' AS column_name, activity_year, total_rows, PREGNANCY_INTENTION_C_NAME_filled AS filled_count, query_error FROM #fc_011
    UNION ALL
    SELECT 'PAT_ENC_7' AS table_name, 'PREGNANCY_COUNSELED_YN' AS column_name, activity_year, total_rows, PREGNANCY_COUNSELED_YN_filled AS filled_count, query_error FROM #fc_011
    UNION ALL
    SELECT 'PAT_ENC_7' AS table_name, 'BIRTH_CONTROL_COUNSELED_YN' AS column_name, activity_year, total_rows, BIRTH_CONTROL_COUNSELED_YN_filled AS filled_count, query_error FROM #fc_011
    UNION ALL
    SELECT 'PAT_ENC_7' AS table_name, 'RSN_NO_BCM_COUNSELING_C_NAME' AS column_name, activity_year, total_rows, RSN_NO_BCM_COUNSELING_C_NAME_filled AS filled_count, query_error FROM #fc_011
    UNION ALL
    SELECT 'PAT_ENC_7' AS table_name, 'INTAKE_RSN_NO_CONTRACEPTIVE_C_NAME' AS column_name, activity_year, total_rows, INTAKE_RSN_NO_CONTRACEPTIVE_C_NAME_filled AS filled_count, query_error FROM #fc_011
    UNION ALL
    SELECT 'PAT_ENC_7' AS table_name, 'CONTRACEPTIVE_DELIVERY_C_NAME' AS column_name, activity_year, total_rows, CONTRACEPTIVE_DELIVERY_C_NAME_filled AS filled_count, query_error FROM #fc_011
    UNION ALL
    SELECT 'PAT_ENC_7' AS table_name, 'EXIT_RSN_NO_CONTRACEPTIVE_C_NAME' AS column_name, activity_year, total_rows, EXIT_RSN_NO_CONTRACEPTIVE_C_NAME_filled AS filled_count, query_error FROM #fc_011
    UNION ALL
    SELECT 'PAT_ENC_7' AS table_name, 'IS_VAP_DECLINED_YN' AS column_name, activity_year, total_rows, IS_VAP_DECLINED_YN_filled AS filled_count, query_error FROM #fc_011
    UNION ALL
    SELECT 'PAT_ENC_7' AS table_name, 'EPISODE_UPDATE_EFF_DATE' AS column_name, activity_year, total_rows, EPISODE_UPDATE_EFF_DATE_filled AS filled_count, query_error FROM #fc_011
    UNION ALL
    SELECT 'PAT_ENC_7' AS table_name, 'EPISODE_UPD_CREAT_RSN_C_NAME' AS column_name, activity_year, total_rows, EPISODE_UPD_CREAT_RSN_C_NAME_filled AS filled_count, query_error FROM #fc_011
    UNION ALL
    SELECT 'PAT_ENC_7' AS table_name, 'VISIT_MSG_DECLINE_YN' AS column_name, activity_year, total_rows, VISIT_MSG_DECLINE_YN_filled AS filled_count, query_error FROM #fc_011
    UNION ALL
    SELECT 'PAT_ENC_7' AS table_name, 'BILL_FOR_DENIAL_YN' AS column_name, activity_year, total_rows, BILL_FOR_DENIAL_YN_filled AS filled_count, query_error FROM #fc_011
    UNION ALL
    SELECT 'PAT_ENC_8' AS table_name, 'PAT_ENC_CSN_ID' AS column_name, activity_year, total_rows, PAT_ENC_CSN_ID_filled AS filled_count, query_error FROM #fc_012
    UNION ALL
    SELECT 'PAT_ENC_8' AS table_name, 'PAT_ID' AS column_name, activity_year, total_rows, PAT_ID_filled AS filled_count, query_error FROM #fc_012
    UNION ALL
    SELECT 'PAT_ENC_8' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count, query_error FROM #fc_012
    UNION ALL
    SELECT 'PAT_ENC_8' AS table_name, 'CM_CT_OWNER_ID' AS column_name, activity_year, total_rows, CM_CT_OWNER_ID_filled AS filled_count, query_error FROM #fc_012
    UNION ALL
    SELECT 'PAT_ENC_8' AS table_name, 'EST_PREPAY_CALC_PP_PROPOSED_YN' AS column_name, activity_year, total_rows, EST_PREPAY_CALC_PP_PROPOSED_YN_filled AS filled_count, query_error FROM #fc_012
    UNION ALL
    SELECT 'PAT_ENC_8' AS table_name, 'EST_PREPAY_CALC_ELIG_C_NAME' AS column_name, activity_year, total_rows, EST_PREPAY_CALC_ELIG_C_NAME_filled AS filled_count, query_error FROM #fc_012
    UNION ALL
    SELECT 'PAT_ENC_8' AS table_name, 'PMT_PLAN_AGRMT_SCHED_PMT_ID' AS column_name, activity_year, total_rows, PMT_PLAN_AGRMT_SCHED_PMT_ID_filled AS filled_count, query_error FROM #fc_012
    UNION ALL
    SELECT 'PAT_ENC_8' AS table_name, 'RSLT_FOL_UP_CREAT_SRC_C_NAME' AS column_name, activity_year, total_rows, RSLT_FOL_UP_CREAT_SRC_C_NAME_filled AS filled_count, query_error FROM #fc_012
    UNION ALL
    SELECT 'PAT_ENC_8' AS table_name, 'BILL_DECIS_FIN_ASST_TRACKER_ID' AS column_name, activity_year, total_rows, BILL_DECIS_FIN_ASST_TRACKER_ID_filled AS filled_count, query_error FROM #fc_012
    UNION ALL
    SELECT 'PAT_ENC_8' AS table_name, 'NO_FOLLOW_UP_YN' AS column_name, activity_year, total_rows, NO_FOLLOW_UP_YN_filled AS filled_count, query_error FROM #fc_012
    UNION ALL
    SELECT 'PAT_ENC_8' AS table_name, 'MCAID_INCARCERATION_BILL_CODE' AS column_name, activity_year, total_rows, MCAID_INCARCERATION_BILL_CODE_filled AS filled_count, query_error FROM #fc_012
    UNION ALL
    SELECT 'PAT_ENC_8' AS table_name, 'MCAID_INCAR_BILL_START_DATE' AS column_name, activity_year, total_rows, MCAID_INCAR_BILL_START_DATE_filled AS filled_count, query_error FROM #fc_012
    UNION ALL
    SELECT 'PAT_ENC_8' AS table_name, 'MEDICARE_CHANGE_C_NAME' AS column_name, activity_year, total_rows, MEDICARE_CHANGE_C_NAME_filled AS filled_count, query_error FROM #fc_012
    UNION ALL
    SELECT 'PAT_ENC_8' AS table_name, 'MSP_RTE_VERI_STAT_C_NAME' AS column_name, activity_year, total_rows, MSP_RTE_VERI_STAT_C_NAME_filled AS filled_count, query_error FROM #fc_012
    UNION ALL
    SELECT 'PAT_ENC_8' AS table_name, 'MSP_COMP_REALTIME_TX_CSN_ID' AS column_name, activity_year, total_rows, MSP_COMP_REALTIME_TX_CSN_ID_filled AS filled_count, query_error FROM #fc_012
    UNION ALL
    SELECT 'PAT_ENC_8' AS table_name, 'MSP_RTE_COMP_PAT_ENC_CSN_ID' AS column_name, activity_year, total_rows, MSP_RTE_COMP_PAT_ENC_CSN_ID_filled AS filled_count, query_error FROM #fc_012
    UNION ALL
    SELECT 'PAT_ENC_8' AS table_name, 'TAKING_PULL_REJECTED_YN' AS column_name, activity_year, total_rows, TAKING_PULL_REJECTED_YN_filled AS filled_count, query_error FROM #fc_012
    UNION ALL
    SELECT 'PAT_ENC_8' AS table_name, 'HOSP_SERV_C_NAME' AS column_name, activity_year, total_rows, HOSP_SERV_C_NAME_filled AS filled_count, query_error FROM #fc_012
    UNION ALL
    SELECT 'PAT_ENC_8' AS table_name, 'LEVEL_OF_CARE_C_NAME' AS column_name, activity_year, total_rows, LEVEL_OF_CARE_C_NAME_filled AS filled_count, query_error FROM #fc_012
    UNION ALL
    SELECT 'PAT_ENC_8' AS table_name, 'ACCOMMODATION_C_NAME' AS column_name, activity_year, total_rows, ACCOMMODATION_C_NAME_filled AS filled_count, query_error FROM #fc_012
    UNION ALL
    SELECT 'PAT_ENC_8' AS table_name, 'ACCOM_REASON_C_NAME' AS column_name, activity_year, total_rows, ACCOM_REASON_C_NAME_filled AS filled_count, query_error FROM #fc_012
    UNION ALL
    SELECT 'PAT_ENC_8' AS table_name, 'APPT_NEEDS_BED_C_NAME' AS column_name, activity_year, total_rows, APPT_NEEDS_BED_C_NAME_filled AS filled_count, query_error FROM #fc_012
    UNION ALL
    SELECT 'PAT_ENC_8' AS table_name, 'APPT_BED_PREDEPT_ID_EXTERNAL_NAME' AS column_name, activity_year, total_rows, APPT_BED_PREDEPT_ID_EXTERNAL_NAME_filled AS filled_count, query_error FROM #fc_012
    UNION ALL
    SELECT 'PAT_ENC_8' AS table_name, 'APPT_BED_HOSP_SERV_C_NAME' AS column_name, activity_year, total_rows, APPT_BED_HOSP_SERV_C_NAME_filled AS filled_count, query_error FROM #fc_012
    UNION ALL
    SELECT 'PAT_ENC_8' AS table_name, 'APPT_BED_POST_LEVEL_OF_CARE_C_NAME' AS column_name, activity_year, total_rows, APPT_BED_POST_LEVEL_OF_CARE_C_NAME_filled AS filled_count, query_error FROM #fc_012
    UNION ALL
    SELECT 'PAT_ENC_8' AS table_name, 'APPT_BED_CMT_S' AS column_name, activity_year, total_rows, APPT_BED_CMT_S_filled AS filled_count, query_error FROM #fc_012
    UNION ALL
    SELECT 'PAT_ENC_8' AS table_name, 'SEPARATED_GROUP_YN' AS column_name, activity_year, total_rows, SEPARATED_GROUP_YN_filled AS filled_count, query_error FROM #fc_012
    UNION ALL
    SELECT 'PAT_ENC_APPT' AS table_name, 'PAT_ENC_CSN_ID' AS column_name, activity_year, total_rows, PAT_ENC_CSN_ID_filled AS filled_count, query_error FROM #fc_013
    UNION ALL
    SELECT 'PAT_ENC_APPT' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count, query_error FROM #fc_013
    UNION ALL
    SELECT 'PAT_ENC_APPT' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count, query_error FROM #fc_013
    UNION ALL
    SELECT 'PAT_ENC_APPT' AS table_name, 'DEPARTMENT_ID_EXTERNAL_NAME' AS column_name, activity_year, total_rows, DEPARTMENT_ID_EXTERNAL_NAME_filled AS filled_count, query_error FROM #fc_013
    UNION ALL
    SELECT 'PAT_ENC_APPT' AS table_name, 'PROV_START_TIME' AS column_name, activity_year, total_rows, PROV_START_TIME_filled AS filled_count, query_error FROM #fc_013
    UNION ALL
    SELECT 'PAT_ENC_APPT' AS table_name, 'APPT_PROV_PRIMARY_SPECIALTY_C_NAME' AS column_name, activity_year, total_rows, APPT_PROV_PRIMARY_SPECIALTY_C_NAME_filled AS filled_count, query_error FROM #fc_013
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'PAT_ENC_CSN_ID' AS column_name, activity_year, total_rows, PAT_ENC_CSN_ID_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'ADT_PAT_CLASS_C_NAME' AS column_name, activity_year, total_rows, ADT_PAT_CLASS_C_NAME_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'ADT_PATIENT_STAT_C_NAME' AS column_name, activity_year, total_rows, ADT_PATIENT_STAT_C_NAME_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'LEVEL_OF_CARE_C_NAME' AS column_name, activity_year, total_rows, LEVEL_OF_CARE_C_NAME_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'PENDING_DISCH_TIME' AS column_name, activity_year, total_rows, PENDING_DISCH_TIME_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'DISCH_CODE_C_NAME' AS column_name, activity_year, total_rows, DISCH_CODE_C_NAME_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'ADT_ATHCRT_STAT_C_NAME' AS column_name, activity_year, total_rows, ADT_ATHCRT_STAT_C_NAME_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'PREADM_UNDO_RSN_C_NAME' AS column_name, activity_year, total_rows, PREADM_UNDO_RSN_C_NAME_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'EXP_ADMISSION_TIME' AS column_name, activity_year, total_rows, EXP_ADMISSION_TIME_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'EXP_LEN_OF_STAY' AS column_name, activity_year, total_rows, EXP_LEN_OF_STAY_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'EXP_DISCHARGE_DATE' AS column_name, activity_year, total_rows, EXP_DISCHARGE_DATE_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'ADMIT_CATEGORY_C_NAME' AS column_name, activity_year, total_rows, ADMIT_CATEGORY_C_NAME_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'ADMIT_SOURCE_C_NAME' AS column_name, activity_year, total_rows, ADMIT_SOURCE_C_NAME_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'TYPE_OF_ROOM_C_NAME' AS column_name, activity_year, total_rows, TYPE_OF_ROOM_C_NAME_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'TYPE_OF_BED_C_NAME' AS column_name, activity_year, total_rows, TYPE_OF_BED_C_NAME_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'RSN_FOR_BED_C_NAME' AS column_name, activity_year, total_rows, RSN_FOR_BED_C_NAME_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'DELIVERY_TYPE_C_NAME' AS column_name, activity_year, total_rows, DELIVERY_TYPE_C_NAME_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'LABOR_STATUS_C_NAME' AS column_name, activity_year, total_rows, LABOR_STATUS_C_NAME_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'ER_INJURY' AS column_name, activity_year, total_rows, ER_INJURY_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'ADT_ARRIVAL_TIME' AS column_name, activity_year, total_rows, ADT_ARRIVAL_TIME_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'ADT_ARRIVAL_STS_C_NAME' AS column_name, activity_year, total_rows, ADT_ARRIVAL_STS_C_NAME_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'HOSP_ADMSN_TIME' AS column_name, activity_year, total_rows, HOSP_ADMSN_TIME_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'ADMIT_CONF_STAT_C_NAME' AS column_name, activity_year, total_rows, ADMIT_CONF_STAT_C_NAME_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'HOSP_DISCH_TIME' AS column_name, activity_year, total_rows, HOSP_DISCH_TIME_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'HOSP_ADMSN_TYPE_C_NAME' AS column_name, activity_year, total_rows, HOSP_ADMSN_TYPE_C_NAME_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'ROOM_ID_ROOM_NAME' AS column_name, activity_year, total_rows, ROOM_ID_ROOM_NAME_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'HOSP_SERV_C_NAME' AS column_name, activity_year, total_rows, HOSP_SERV_C_NAME_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'MEANS_OF_DEPART_C_NAME' AS column_name, activity_year, total_rows, MEANS_OF_DEPART_C_NAME_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'DISCH_DISP_C_NAME' AS column_name, activity_year, total_rows, DISCH_DISP_C_NAME_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'DISCH_DEST_C_NAME' AS column_name, activity_year, total_rows, DISCH_DEST_C_NAME_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'TRANSFER_FROM_C_NAME' AS column_name, activity_year, total_rows, TRANSFER_FROM_C_NAME_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'MEANS_OF_ARRV_C_NAME' AS column_name, activity_year, total_rows, MEANS_OF_ARRV_C_NAME_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'ACUITY_LEVEL_C_NAME' AS column_name, activity_year, total_rows, ACUITY_LEVEL_C_NAME_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'HOSPIST_NEEDED_YN' AS column_name, activity_year, total_rows, HOSPIST_NEEDED_YN_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'ACCOMMODATION_C_NAME' AS column_name, activity_year, total_rows, ACCOMMODATION_C_NAME_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'ACCOM_REASON_C_NAME' AS column_name, activity_year, total_rows, ACCOM_REASON_C_NAME_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'INPATIENT_DATA_ID' AS column_name, activity_year, total_rows, INPATIENT_DATA_ID_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'PVT_HSP_ENC_C_NAME' AS column_name, activity_year, total_rows, PVT_HSP_ENC_C_NAME_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'ED_EPISODE_ID' AS column_name, activity_year, total_rows, ED_EPISODE_ID_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'ED_DISPOSITION_C_NAME' AS column_name, activity_year, total_rows, ED_DISPOSITION_C_NAME_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'ED_DISP_TIME' AS column_name, activity_year, total_rows, ED_DISP_TIME_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'FOLLOWUP_PROV_ID_PROV_NAME' AS column_name, activity_year, total_rows, FOLLOWUP_PROV_ID_PROV_NAME_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'PROV_CONT_INFO' AS column_name, activity_year, total_rows, PROV_CONT_INFO_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'OSHPD_ADMSN_SRC_C_NAME' AS column_name, activity_year, total_rows, OSHPD_ADMSN_SRC_C_NAME_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'OSHPD_LICENSURE_C_NAME' AS column_name, activity_year, total_rows, OSHPD_LICENSURE_C_NAME_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'OSHPD_ROUTE_C_NAME' AS column_name, activity_year, total_rows, OSHPD_ROUTE_C_NAME_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'INP_ADM_DATE' AS column_name, activity_year, total_rows, INP_ADM_DATE_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'COPY_TO_PCP_YN' AS column_name, activity_year, total_rows, COPY_TO_PCP_YN_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'ADOPTION_CASE_YN' AS column_name, activity_year, total_rows, ADOPTION_CASE_YN_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'PREOP_TEACHING_C_NAME' AS column_name, activity_year, total_rows, PREOP_TEACHING_C_NAME_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'PREOP_PRN_EVAL_C_NAME' AS column_name, activity_year, total_rows, PREOP_PRN_EVAL_C_NAME_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'PREOP_PH_SCREEN_C_NAME' AS column_name, activity_year, total_rows, PREOP_PH_SCREEN_C_NAME_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'LABOR_ACT_BIRTH_C_NAME' AS column_name, activity_year, total_rows, LABOR_ACT_BIRTH_C_NAME_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'LABOR_FEED_TYPE_C_NAME' AS column_name, activity_year, total_rows, LABOR_FEED_TYPE_C_NAME_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'PROC_SERV_C_NAME' AS column_name, activity_year, total_rows, PROC_SERV_C_NAME_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'ED_DEPARTURE_TIME' AS column_name, activity_year, total_rows, ED_DEPARTURE_TIME_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'TRIAGE_DATETIME' AS column_name, activity_year, total_rows, TRIAGE_DATETIME_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'TRIAGE_STATUS_C_NAME' AS column_name, activity_year, total_rows, TRIAGE_STATUS_C_NAME_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'INP_ADM_EVENT_ID' AS column_name, activity_year, total_rows, INP_ADM_EVENT_ID_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'INP_ADM_EVENT_DATE' AS column_name, activity_year, total_rows, INP_ADM_EVENT_DATE_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'INP_DWNGRD_EVNT_ID' AS column_name, activity_year, total_rows, INP_DWNGRD_EVNT_ID_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'INP_DWNGRD_DATE' AS column_name, activity_year, total_rows, INP_DWNGRD_DATE_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'INP_DWNGRD_EVNT_DT' AS column_name, activity_year, total_rows, INP_DWNGRD_EVNT_DT_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'OP_ADM_DATE' AS column_name, activity_year, total_rows, OP_ADM_DATE_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'EMER_ADM_DATE' AS column_name, activity_year, total_rows, EMER_ADM_DATE_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'OP_ADM_EVENT_ID' AS column_name, activity_year, total_rows, OP_ADM_EVENT_ID_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'EMER_ADM_EVENT_ID' AS column_name, activity_year, total_rows, EMER_ADM_EVENT_ID_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'PREREG_SOURCE_C_NAME' AS column_name, activity_year, total_rows, PREREG_SOURCE_C_NAME_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'HOV_CONF_STATUS_C_NAME' AS column_name, activity_year, total_rows, HOV_CONF_STATUS_C_NAME_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'RELIG_NEEDS_VISIT_C_NAME' AS column_name, activity_year, total_rows, RELIG_NEEDS_VISIT_C_NAME_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'DISCHARGE_CAT_C_NAME' AS column_name, activity_year, total_rows, DISCHARGE_CAT_C_NAME_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'EXP_DISCHARGE_TIME' AS column_name, activity_year, total_rows, EXP_DISCHARGE_TIME_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'BILL_ATTEND_PROV_ID_PROV_NAME' AS column_name, activity_year, total_rows, BILL_ATTEND_PROV_ID_PROV_NAME_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'OB_LD_LABORING_YN' AS column_name, activity_year, total_rows, OB_LD_LABORING_YN_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'OB_LD_LABOR_TM' AS column_name, activity_year, total_rows, OB_LD_LABOR_TM_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'TRIAGE_ID_TAG' AS column_name, activity_year, total_rows, TRIAGE_ID_TAG_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'TRIAGE_ID_TAG_CMT' AS column_name, activity_year, total_rows, TRIAGE_ID_TAG_CMT_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'TPLNT_BILL_STAT_C_NAME' AS column_name, activity_year, total_rows, TPLNT_BILL_STAT_C_NAME_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'ACTL_DELIVRY_METH_C_NAME' AS column_name, activity_year, total_rows, ACTL_DELIVRY_METH_C_NAME_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'PRENATAL_CARE_C_NAME' AS column_name, activity_year, total_rows, PRENATAL_CARE_C_NAME_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'AMBULANCE_CODE_C_NAME' AS column_name, activity_year, total_rows, AMBULANCE_CODE_C_NAME_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'MSE_DATE' AS column_name, activity_year, total_rows, MSE_DATE_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'ADMIT_PROV_TEXT' AS column_name, activity_year, total_rows, ADMIT_PROV_TEXT_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'ATTEND_PROV_TEXT' AS column_name, activity_year, total_rows, ATTEND_PROV_TEXT_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'PROV_PRIM_TEXT' AS column_name, activity_year, total_rows, PROV_PRIM_TEXT_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'PROV_PRIM_TEXT_PHON' AS column_name, activity_year, total_rows, PROV_PRIM_TEXT_PHON_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'HOSPITAL_AREA_ID_LOC_NAME' AS column_name, activity_year, total_rows, HOSPITAL_AREA_ID_LOC_NAME_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'CHIEF_COMPLAINT_C_NAME' AS column_name, activity_year, total_rows, CHIEF_COMPLAINT_C_NAME_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP' AS table_name, 'NEED_FIN_CLR_YN' AS column_name, activity_year, total_rows, NEED_FIN_CLR_YN_filled AS filled_count, query_error FROM #fc_014
    UNION ALL
    SELECT 'PAT_ENC_HSP_2' AS table_name, 'PAT_ENC_CSN_ID' AS column_name, activity_year, total_rows, PAT_ENC_CSN_ID_filled AS filled_count, query_error FROM #fc_015
    UNION ALL
    SELECT 'PAT_ENC_HSP_2' AS table_name, 'PAT_ENC_DATE_REAL' AS column_name, activity_year, total_rows, PAT_ENC_DATE_REAL_filled AS filled_count, query_error FROM #fc_015
    UNION ALL
    SELECT 'PAT_ENC_HSP_2' AS table_name, 'CONTACT_DATE' AS column_name, activity_year, total_rows, CONTACT_DATE_filled AS filled_count, query_error FROM #fc_015
    UNION ALL
    SELECT 'PAT_ENC_HSP_2' AS table_name, 'EX_DIS_DT_ENTR_DTTM' AS column_name, activity_year, total_rows, EX_DIS_DT_ENTR_DTTM_filled AS filled_count, query_error FROM #fc_015
    UNION ALL
    SELECT 'PAT_ENC_HSP_2' AS table_name, 'EX_DIS_TM_ENTR_DTTM' AS column_name, activity_year, total_rows, EX_DIS_TM_ENTR_DTTM_filled AS filled_count, query_error FROM #fc_015
    UNION ALL
    SELECT 'PAT_ENC_HSP_2' AS table_name, 'CONTRACT_REG_FLAG' AS column_name, activity_year, total_rows, CONTRACT_REG_FLAG_filled AS filled_count, query_error FROM #fc_015
    UNION ALL
    SELECT 'PAT_ENC_HSP_2' AS table_name, 'CONTRACT_CODE_C_NAME' AS column_name, activity_year, total_rows, CONTRACT_CODE_C_NAME_filled AS filled_count, query_error FROM #fc_015
    UNION ALL
    SELECT 'PAT_ENC_HSP_2' AS table_name, 'ACCEPTS_BLOOD_C_NAME' AS column_name, activity_year, total_rows, ACCEPTS_BLOOD_C_NAME_filled AS filled_count, query_error FROM #fc_015
    UNION ALL
    SELECT 'PAT_ENC_HSP_2' AS table_name, 'ED_ARRIVAL_DETAILS' AS column_name, activity_year, total_rows, ED_ARRIVAL_DETAILS_filled AS filled_count, query_error FROM #fc_015
    UNION ALL
    SELECT 'PAT_ENC_HSP_2' AS table_name, 'CONS_SEDATION_C_NAME' AS column_name, activity_year, total_rows, CONS_SEDATION_C_NAME_filled AS filled_count, query_error FROM #fc_015
    UNION ALL
    SELECT 'PAT_ENC_HSP_2' AS table_name, 'RESTRAINT_SECLUS_C_NAME' AS column_name, activity_year, total_rows, RESTRAINT_SECLUS_C_NAME_filled AS filled_count, query_error FROM #fc_015
    UNION ALL
    SELECT 'PAT_ENC_HSP_2' AS table_name, 'MULTI_PREG_YN' AS column_name, activity_year, total_rows, MULTI_PREG_YN_filled AS filled_count, query_error FROM #fc_015
    UNION ALL
    SELECT 'PAT_ENC_HSP_2' AS table_name, 'DISASTER_NUM' AS column_name, activity_year, total_rows, DISASTER_NUM_filled AS filled_count, query_error FROM #fc_015
    UNION ALL
    SELECT 'PAT_ENC_HSP_2' AS table_name, 'SRC_PATTERN_CSN_ID' AS column_name, activity_year, total_rows, SRC_PATTERN_CSN_ID_filled AS filled_count, query_error FROM #fc_015
    UNION ALL
    SELECT 'PAT_ENC_HSP_2' AS table_name, 'ENC_CLOSED_OR_COMPLETED_DATE' AS column_name, activity_year, total_rows, ENC_CLOSED_OR_COMPLETED_DATE_filled AS filled_count, query_error FROM #fc_015
    UNION ALL
    SELECT 'PAT_ENC_HSP_2' AS table_name, 'ED_DISPO_PAT_COND_C_NAME' AS column_name, activity_year, total_rows, ED_DISPO_PAT_COND_C_NAME_filled AS filled_count, query_error FROM #fc_015
    UNION ALL
    SELECT 'PAT_ENC_HSP_2' AS table_name, 'ADOPTION_TYPE_C_NAME' AS column_name, activity_year, total_rows, ADOPTION_TYPE_C_NAME_filled AS filled_count, query_error FROM #fc_015
    UNION ALL
    SELECT 'PAT_ENC_HSP_2' AS table_name, 'PRI_PROBLEM_ID' AS column_name, activity_year, total_rows, PRI_PROBLEM_ID_filled AS filled_count, query_error FROM #fc_015
    UNION ALL
    SELECT 'PAT_ENC_HSP_2' AS table_name, 'EXPECTED_DISCHRG_APPROX_TIME_C_NAME' AS column_name, activity_year, total_rows, EXPECTED_DISCHRG_APPROX_TIME_C_NAME_filled AS filled_count, query_error FROM #fc_015
    UNION ALL
    SELECT 'PAT_ENC_HSP_2' AS table_name, 'DISCH_MILEST_KICKOFF_UTC_DTTM' AS column_name, activity_year, total_rows, DISCH_MILEST_KICKOFF_UTC_DTTM_filled AS filled_count, query_error FROM #fc_015
    UNION ALL
    SELECT 'PAT_ENC_HSP_2' AS table_name, 'DISCH_MILEST_AUTO_MANAGED_YN' AS column_name, activity_year, total_rows, DISCH_MILEST_AUTO_MANAGED_YN_filled AS filled_count, query_error FROM #fc_015
    UNION ALL
    SELECT 'PAT_ENC_HSP_2' AS table_name, 'PREDICTED_LOS' AS column_name, activity_year, total_rows, PREDICTED_LOS_filled AS filled_count, query_error FROM #fc_015
    UNION ALL
    SELECT 'PAT_ENC_HSP_2' AS table_name, 'EXP_LOS_UPD_SRC_C_NAME' AS column_name, activity_year, total_rows, EXP_LOS_UPD_SRC_C_NAME_filled AS filled_count, query_error FROM #fc_015
    UNION ALL
    SELECT 'PAT_ENC_HSP_2' AS table_name, 'ED_ENC_SRC_C_NAME' AS column_name, activity_year, total_rows, ED_ENC_SRC_C_NAME_filled AS filled_count, query_error FROM #fc_015
    UNION ALL
    SELECT 'PAT_ENC_HSP_2' AS table_name, 'ED_DEPART_UTC_DTTM' AS column_name, activity_year, total_rows, ED_DEPART_UTC_DTTM_filled AS filled_count, query_error FROM #fc_015
    UNION ALL
    SELECT 'PAT_ENC_HSP_2' AS table_name, 'ADT_ARRIVAL_UTC_DTTM' AS column_name, activity_year, total_rows, ADT_ARRIVAL_UTC_DTTM_filled AS filled_count, query_error FROM #fc_015
    UNION ALL
    SELECT 'PAT_ENC_HSP_2' AS table_name, 'HOSP_DISCH_UTC_DTTM' AS column_name, activity_year, total_rows, HOSP_DISCH_UTC_DTTM_filled AS filled_count, query_error FROM #fc_015
    UNION ALL
    SELECT 'PAT_ENC_HSP_2' AS table_name, 'HOSP_ADMSN_UTC_DTTM' AS column_name, activity_year, total_rows, HOSP_ADMSN_UTC_DTTM_filled AS filled_count, query_error FROM #fc_015
    UNION ALL
    SELECT 'PAT_ENC_HSP_2' AS table_name, 'INP_ADMSN_UTC_DTTM' AS column_name, activity_year, total_rows, INP_ADMSN_UTC_DTTM_filled AS filled_count, query_error FROM #fc_015
    UNION ALL
    SELECT 'PAT_ENC_HSP_2' AS table_name, 'ED_HISTORICAL_YN' AS column_name, activity_year, total_rows, ED_HISTORICAL_YN_filled AS filled_count, query_error FROM #fc_015
    UNION ALL
    SELECT 'PAT_ENC_HSP_2' AS table_name, 'PATIENT_TASK_COMPLETION_RATE' AS column_name, activity_year, total_rows, PATIENT_TASK_COMPLETION_RATE_filled AS filled_count, query_error FROM #fc_015
    UNION ALL
    SELECT 'PAT_ENC_HSP_2' AS table_name, 'START_MED_REM_DISCHG_YN' AS column_name, activity_year, total_rows, START_MED_REM_DISCHG_YN_filled AS filled_count, query_error FROM #fc_015
    UNION ALL
    SELECT 'PAT_ENC_HSP_2' AS table_name, 'EXPECTED_DISCHARGE_UNKNOWN_YN' AS column_name, activity_year, total_rows, EXPECTED_DISCHARGE_UNKNOWN_YN_filled AS filled_count, query_error FROM #fc_015
    UNION ALL
    SELECT 'PAT_ENC_HSP_2' AS table_name, 'DUAL_ADMISSION_CSN' AS column_name, activity_year, total_rows, DUAL_ADMISSION_CSN_filled AS filled_count, query_error FROM #fc_015
    UNION ALL
    SELECT 'PAT_ENC_HSP_2' AS table_name, 'LOA_PAT_ENC_CSN_ID' AS column_name, activity_year, total_rows, LOA_PAT_ENC_CSN_ID_filled AS filled_count, query_error FROM #fc_015
    UNION ALL
    SELECT 'PAT_ENC_HSP_2' AS table_name, 'INITIAL_ADT_PAT_STAT_C_NAME' AS column_name, activity_year, total_rows, INITIAL_ADT_PAT_STAT_C_NAME_filled AS filled_count, query_error FROM #fc_015
    UNION ALL
    SELECT 'PAT_ENC_HSP_2' AS table_name, 'NOTIFICATION_SENT_FIRST_IP_YN' AS column_name, activity_year, total_rows, NOTIFICATION_SENT_FIRST_IP_YN_filled AS filled_count, query_error FROM #fc_015
    UNION ALL
    SELECT 'PAT_ENC_HSP_2' AS table_name, 'NOTIFICATION_SENT_OBS_ADMSN_YN' AS column_name, activity_year, total_rows, NOTIFICATION_SENT_OBS_ADMSN_YN_filled AS filled_count, query_error FROM #fc_015
    UNION ALL
    SELECT 'PAT_ENC_HSP_2' AS table_name, 'IB_ALERT_LENGTH_OF_STAY_MSG_ID' AS column_name, activity_year, total_rows, IB_ALERT_LENGTH_OF_STAY_MSG_ID_filled AS filled_count, query_error FROM #fc_015
    UNION ALL
    SELECT 'PAT_ENC_HSP_2' AS table_name, 'INITIAL_ADMIT_CONF_STAT_C_NAME' AS column_name, activity_year, total_rows, INITIAL_ADMIT_CONF_STAT_C_NAME_filled AS filled_count, query_error FROM #fc_015
    UNION ALL
    SELECT 'PAT_ENC_HSP_2' AS table_name, 'TRANSFER_COMMENTS' AS column_name, activity_year, total_rows, TRANSFER_COMMENTS_filled AS filled_count, query_error FROM #fc_015
    UNION ALL
    SELECT 'PAT_ENC_HSP_2' AS table_name, 'MED_READINESS_DTTM' AS column_name, activity_year, total_rows, MED_READINESS_DTTM_filled AS filled_count, query_error FROM #fc_015
    UNION ALL
    SELECT 'PAT_ENC_HSP_2' AS table_name, 'MED_READINESS_TIMEFRAM_C_NAME' AS column_name, activity_year, total_rows, MED_READINESS_TIMEFRAM_C_NAME_filled AS filled_count, query_error FROM #fc_015
    UNION ALL
    SELECT 'PAT_ENC_HSP_2' AS table_name, 'MED_READINESS_YN' AS column_name, activity_year, total_rows, MED_READINESS_YN_filled AS filled_count, query_error FROM #fc_015
    UNION ALL
    SELECT 'PAT_ENC_HSP_2' AS table_name, 'MED_READINESS_INST_ENTRY_DTTM' AS column_name, activity_year, total_rows, MED_READINESS_INST_ENTRY_DTTM_filled AS filled_count, query_error FROM #fc_015
    UNION ALL
    SELECT 'PAT_ENC_HSP_2' AS table_name, 'MED_READINESS_USER_ID' AS column_name, activity_year, total_rows, MED_READINESS_USER_ID_filled AS filled_count, query_error FROM #fc_015
    UNION ALL
    SELECT 'PAT_ENC_HSP_2' AS table_name, 'MED_READINESS_USER_ID_NAME' AS column_name, activity_year, total_rows, MED_READINESS_USER_ID_NAME_filled AS filled_count, query_error FROM #fc_015
    UNION ALL
    SELECT 'PAT_ENC_HSP_2' AS table_name, 'MED_READINESS_SOURCE_C_NAME' AS column_name, activity_year, total_rows, MED_READINESS_SOURCE_C_NAME_filled AS filled_count, query_error FROM #fc_015
    UNION ALL
    SELECT 'PAT_ENC_HSP_2' AS table_name, 'EXPECTED_DISCH_DISP_C_NAME' AS column_name, activity_year, total_rows, EXPECTED_DISCH_DISP_C_NAME_filled AS filled_count, query_error FROM #fc_015
    UNION ALL
    SELECT 'PAT_ENC_HSP_2' AS table_name, 'EXP_DISCH_DISP_USER_ID' AS column_name, activity_year, total_rows, EXP_DISCH_DISP_USER_ID_filled AS filled_count, query_error FROM #fc_015
    UNION ALL
    SELECT 'PAT_ENC_HSP_2' AS table_name, 'EXP_DISCH_DISP_USER_ID_NAME' AS column_name, activity_year, total_rows, EXP_DISCH_DISP_USER_ID_NAME_filled AS filled_count, query_error FROM #fc_015
    UNION ALL
    SELECT 'PAT_ENC_HSP_2' AS table_name, 'EXP_DISCH_DISP_ENTRY_UTC_DTTM' AS column_name, activity_year, total_rows, EXP_DISCH_DISP_ENTRY_UTC_DTTM_filled AS filled_count, query_error FROM #fc_015
    UNION ALL
    SELECT 'PAT_ENC_HSP_2' AS table_name, 'PRIMARY_LINKED_PAT_ENC_CSN_ID' AS column_name, activity_year, total_rows, PRIMARY_LINKED_PAT_ENC_CSN_ID_filled AS filled_count, query_error FROM #fc_015
    UNION ALL
    SELECT 'PAT_ENC_HSP_2' AS table_name, 'TODO_ADM_DISCLAIMER_ACTIVE_YN' AS column_name, activity_year, total_rows, TODO_ADM_DISCLAIMER_ACTIVE_YN_filled AS filled_count, query_error FROM #fc_015
    UNION ALL
    SELECT 'PAT_ENC_NO_SHOW' AS table_name, 'PAT_ENC_CSN_ID' AS column_name, activity_year, total_rows, PAT_ENC_CSN_ID_filled AS filled_count, query_error FROM #fc_016
    UNION ALL
    SELECT 'PAT_ENC_NO_SHOW' AS table_name, 'LINE' AS column_name, activity_year, total_rows, LINE_filled AS filled_count, query_error FROM #fc_016
    UNION ALL
    SELECT 'PAT_ENC_NO_SHOW' AS table_name, 'PAT_ID' AS column_name, activity_year, total_rows, PAT_ID_filled AS filled_count, query_error FROM #fc_016
    UNION ALL
    SELECT 'PAT_ENC_NO_SHOW' AS table_name, 'NO_SHOW_COMMENT' AS column_name, activity_year, total_rows, NO_SHOW_COMMENT_filled AS filled_count, query_error FROM #fc_016
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
*/
