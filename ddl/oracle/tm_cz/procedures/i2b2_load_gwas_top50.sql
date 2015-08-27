--
-- Type: PROCEDURE; Owner: TM_CZ; Name: I2B2_LOAD_GWAS_TOP50
--
  CREATE OR REPLACE PROCEDURE "TM_CZ"."I2B2_LOAD_GWAS_TOP50" AS
BEGIN

INSERT INTO TM_CZ.tmp_analysis_gwas_top500 -- temporary table
select a.*
from (
select
bio_asy_analysis_gwas_id,
bio_assay_analysis_id,
rs_id,
p_value,
log_p_value,
etl_id,
ext_data,
p_value_char,
row_number () over (partition by bio_assay_analysis_id order by p_value asc, rs_id asc) as rnum
from BIOMART.bio_assay_analysis_gwas
) a
where
a.rnum <=500;

execute immediate('TRUNCATE TABLE BIOMART.bio_asy_analysis_gwas_top50');

INSERT INTO BIOMART.BIO_ASY_ANALYSIS_GWAS_TOP50
SELECT baa.bio_assay_analysis_id,
baa.analysis_name AS analysis, info.chrom AS chrom, info.pos AS pos,
gmap.gene_name AS rsgene, DATA.rs_id AS rsid,
DATA.p_value AS pvalue, DATA.log_p_value AS logpvalue,
DATA.ext_data AS extdata , DATA.rnum,
info.exon_intron as intronexon, info.recombination_rate as recombinationrate, info.regulome_score as regulome
FROM tmp_analysis_gwas_top500 DATA
JOIN biomart.bio_assay_analysis baa
ON baa.bio_assay_analysis_id = DATA.bio_assay_analysis_id
JOIN deapp.de_rc_snp_info info ON DATA.rs_id = info.rs_id and (hg_version='19')
LEFT JOIN deapp.de_snp_gene_map gmap ON  gmap.snp_name =info.rs_id;

execute immediate('ALTER index BIOMART.B_ASY_GWAS_T50_IDX1 REBUILD parallel tablespace "INDX" UNRECOVERABLE');

execute immediate('ALTER index BIOMART.B_ASY_GWAS_T50_IDX2 REBUILD parallel tablespace "INDX" UNRECOVERABLE');

END I2B2_LOAD_GWAS_TOP50;
/

