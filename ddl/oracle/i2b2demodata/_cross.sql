-- NOTE: not in i2b2 schema for i2b2demo data - version 1.7 - 02Dec2014 - Terry Weymouth

--
-- Type: TRIGGER; Owner: I2B2DEMODATA; Name: TRG_CONCEPT_DIMENSION_CD
--
  CREATE OR REPLACE TRIGGER "I2B2DEMODATA"."TRG_CONCEPT_DIMENSION_CD" 
	 before insert on "CONCEPT_DIMENSION"
	 for each row begin
	 if inserting then
	 if :NEW."CONCEPT_CD" is null then
	 select TM_CZ.CONCEPT_ID.nextval into :NEW."CONCEPT_CD" from dual;
	 end if;
	 end if;
	 end;

/
ALTER TRIGGER "I2B2DEMODATA"."TRG_CONCEPT_DIMENSION_CD" ENABLE;
 
