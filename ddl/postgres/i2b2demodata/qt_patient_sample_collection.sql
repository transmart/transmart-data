-- NOTE: not in i2b2 schema for i2b2demo data - version 1.7 - 02Dec2014 - Terry Weymouth

--
-- Name: qt_patient_set_collection; Type: TABLE; Schema: i2b2demodata; Owner: -
--
CREATE TABLE qt_patient_sample_collection (
    sample_id bigint,
    patient_id bigint,
    result_instance_id bigint
);
