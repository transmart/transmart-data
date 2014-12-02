-- NOTE: not in i2b2 schema for i2b2demo data - version 1.7 - 02Dec2014 - Terry Weymouth

--
-- Name: cd; Type: TABLE; Schema: i2b2demodata; Owner: -
--
CREATE TABLE cd (
    concept_path character varying(500),
    parent_concept_path character varying(500),
    patient_count bigint
);

