--
-- Type: TABLE; Owner: DEAPP; Name: DE_SNP_GENE_MAP
--
 CREATE TABLE "DEAPP"."DE_SNP_GENE_MAP"
  (	"SNP_ID" NUMBER(22,0),
"SNP_NAME" VARCHAR2(255 BYTE),
"ENTREZ_GENE_ID" NUMBER,
"GENE_NAME" VARCHAR2(255 BYTE)
  ) SEGMENT CREATION IMMEDIATE
 TABLESPACE "TRANSMART" ;

