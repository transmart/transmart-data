--
-- Type: TABLE; Owner: DEAPP; Name: DE_METABOLITE_SUB_PATHWAYS
--
 CREATE TABLE "DEAPP"."DE_METABOLITE_SUB_PATHWAYS" 
  (	"ID" NUMBER(*,0) NOT NULL ENABLE, 
"GPL_ID" VARCHAR2(50 BYTE) NOT NULL ENABLE, 
"SUB_PATHWAY_NAME" VARCHAR2(200 BYTE) NOT NULL ENABLE, 
"SUPER_PATHWAY_ID" NUMBER(*,0), 
 CONSTRAINT "DE_METABOLITE_SUB_PATHWAY_PK" PRIMARY KEY ("ID")
 USING INDEX
 TABLESPACE "DEAPP"  ENABLE
  ) SEGMENT CREATION IMMEDIATE
 TABLESPACE "DEAPP" ;

--
-- Type: REF_CONSTRAINT; Owner: DEAPP; Name: SYS_C0018368
--
ALTER TABLE "DEAPP"."DE_METABOLITE_SUB_PATHWAYS" ADD FOREIGN KEY ("SUPER_PATHWAY_ID")
 REFERENCES "DEAPP"."DE_METABOLITE_SUPER_PATHWAYS" ("ID") ENABLE;
