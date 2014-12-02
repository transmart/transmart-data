-- NOTE: not in i2b2 schema for i2b2demo data - version 1.7 - 02Dec2014 - Terry Weymouth

--
-- Name: async_job_seq; Type: SEQUENCE; Schema: i2b2demodata; Owner: -
--
CREATE SEQUENCE async_job_seq
    START WITH 0
    INCREMENT BY 1
    MINVALUE 0
    NO MAXVALUE
    CACHE 1;

--
-- Name: protocol_id_seq; Type: SEQUENCE; Schema: i2b2demodata; Owner: -
--
CREATE SEQUENCE protocol_id_seq
    START WITH 215
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--
-- Name: seq_subject_reference; Type: SEQUENCE; Schema: i2b2demodata; Owner: -
--
CREATE SEQUENCE seq_subject_reference
    START WITH 743
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

--
-- Name: sq_up_encdim_encounternum; Type: SEQUENCE; Schema: i2b2demodata; Owner: -
--
CREATE SEQUENCE sq_up_encdim_encounternum
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

