-- NOTE: not in i2b2 schema for i2b2demo data - version 1.7 - 02Dec2014 - Terry Weymouth

--
-- Name: news_updates; Type: TABLE; Schema: i2b2demodata; Owner: -
--
CREATE TABLE news_updates (
    newsid integer,
    ranbyuser character varying(200),
    rowsaffected integer,
    operation character varying(200),
    datasetname character varying(200),
    updatedate timestamp(6) without time zone,
    commentfield character varying(200)
);

