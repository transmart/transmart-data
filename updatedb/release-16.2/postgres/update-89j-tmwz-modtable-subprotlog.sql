--
-- extend subject_id
--

ALTER TABLE IF EXISTS tm_wz.wt_subject_proteomics_logs ALTER COLUMN subject_id TYPE character varying(100);

