--
-- Type: TABLE Owner: SEARCHAPP; Name: IMPORT_XNAT_VARIABLE
--
CREATE TABLE "SEARCHAPP"."IMPORT_XNAT_VARIABLE"
 (     "ID" NUMBER(10,0) NOT NULL,
"CONFIGURATION_ID" NUMBER(10,0) NOT NULL,
"NAME" VARCHAR2(255) NOT NULL,
"DATATYPE" VARCHAR2(255) NOT NULL,
"URL" VARCHAR2(255) NOT NULL,
 CONSTRAINT "IMPORT_XNAT_VAR_PK" PRIMARY KEY ("ID")
 USING INDEX
 TABLESPACE "INDX"  ENABLE
 ) SEGMENT CREATION IMMEDIATE
 TABLESPACE "TRANSMART" ;

--
-- Type: REF_CONSTRAINT; Owner: SEARCHAPP; Name: IMPORT_XNAT_VAR_FK
--
ALTER TABLE "SEARCHAPP"."IMPORT_XNAT_VARIABLE" ADD CONSTRAINT "IMPORT_XNAT_VAR_FK" FOREIGN KEY ("CONFIGURATION_ID")
 REFERENCES "SEARCHAPP"."IMPORT_XNAT_CONFIGURATION" ("ID") ENABLE;

--
-- Type: TRIGGER; Owner: SEARCHAPP; Name: TRG_IMPORT_XNAT_VAR_ID
--
  CREATE OR REPLACE TRIGGER "SEARCHAPP"."TRG_IMPORT_XNAT_VAR_ID" 
BEFORE INSERT ON "SEARCHAPP"."IMPORT_XNAT_VARIABLE"
FOR EACH ROW
BEGIN
SELECT SEQ_SEARCH_DATA_ID.nextval
INTO :new.id
FROM dual;
END;
/
ALTER TRIGGER "SEARCHAPP"."TRG_IMPORT_XNAT_VAR_ID" ENABLE;
