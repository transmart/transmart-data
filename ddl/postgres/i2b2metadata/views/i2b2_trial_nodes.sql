-- NOTE: not in i2b2 schema for i2b2demo data - version 1.7 - 02Dec2014 - Terry Weymouth

--
-- Name: i2b2_trial_nodes; Type: VIEW; Schema: i2b2metadata; Owner: -
--
CREATE VIEW i2b2_trial_nodes AS
    SELECT DISTINCT ON (i2b2.c_comment) i2b2.c_fullname, "substring"(i2b2.c_comment, 7) AS trial FROM i2b2 WHERE (i2b2.c_comment IS NOT NULL) ORDER BY i2b2.c_comment, char_length((i2b2.c_fullname)::text);

