--
-- Type: PROCEDURE; Owner: TM_CZ; Name: I2B2_LOAD_EQTL_TOP50
--
  CREATE OR REPLACE PROCEDURE "TM_CZ"."I2B2_LOAD_EQTL_TOP50" AS
BEGIN

INSERT INTO tm_cz.tmp_analysis_count_eqtl -- temporary table
select count(*) as total, bio_assay_analysis_id
from biomart.bio_assay_analysis_eqtl
group by bio_assay_analysis_id;


update biomart.bio_assay_analysis b
set b.data_count = (select a.total from tm_cz.tmp_analysis_count_eqtl  a where a.bio_assay_analysis_id =  b.bio_assay_analysis_id)
where exists(
select 1 from tm_cz.tmp_analysis_count_eqtl  a where a.bio_assay_analysis_id =  b.bio_assay_analysis_id
);

execute immediate ('TRUNCATE TABLE biomart.tmp_analysis_eqtl_top500');

INSERT INTO biomart.tmp_analysis_eqtl_top500
select a.*
from (
select
bio_asy_analysis_eqtl_id,
bio_assay_analysis_id,
rs_id,
p_value,
log_p_value,
etl_id,
ext_data,
p_value_char,
gene,
cis_trans,
distance_from_gene,
row_number () over (partition by bio_assay_analysis_id order by p_value asc, rs_id asc) as rnum
from biomart.bio_assay_analysis_eqtl
) a
where
a.rnum <=500;

execute immediate ('ALTER index BIOMART.t_a_ge_t500_idx REBUILD UNRECOVERABLE');
execute immediate ('ALTER index BIOMART.t_a_gae_t500_idx REBUILD UNRECOVERABLE');

execute immediate ('TRUNCATE TABLE biomart.bio_asy_analysis_eqtl_top50');

INSERT INTO biomart.BIO_ASY_ANALYSIS_eqtl_TOP50
SELECT baa.bio_assay_analysis_id,
baa.analysis_name AS analysis, info.chrom AS chrom, info.pos AS pos,
gmap.gene_name AS rsgene, DATA.rs_id AS rsid,
DATA.p_value AS pvalue, DATA.log_p_value AS logpvalue, data.gene as gene,
DATA.ext_data AS extdata, DATA.rnum,
info.exon_intron as intronexon, info.recombination_rate as recombinationrate, info.regulome_score as regulome
FROM tm_cz.tmp_analysis_eqtl_top500 DATA
JOIN biomart.bio_assay_analysis baa
ON baa.bio_assay_analysis_id = DATA.bio_assay_analysis_id
JOIN deapp.de_rc_snp_info info ON DATA.rs_id = info.rs_id and (hg_version='19')
LEFT JOIN deapp.de_snp_gene_map gmap ON  gmap.snp_name =info.rs_id;

execute immediate ('ALTER index BIOMART.B_ASY_eqtl_T50_IDX1 parallel REBUILD UNRECOVERABLE');

execute immediate ('ALTER index BIOMART.B_ASY_eqtl_T50_IDX2 parallel REBUILD UNRECOVERABLE');

END I2B2_LOAD_EQTL_TOP50;
/

