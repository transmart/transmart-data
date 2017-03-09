--
-- Type: TABLE; Owner: DEAPP; Name: DE_TWO_REGION_EVENT
--
 CREATE TABLE "DEAPP"."DE_TWO_REGION_EVENT" 
  (	"TWO_REGION_EVENT_ID" NUMBER NOT NULL ENABLE, 
"CGA_TYPE" VARCHAR2(500 BYTE), 
"SOAP_CLASS" VARCHAR2(500 BYTE), 
 CONSTRAINT "TWO_REGION_EVENT_ID" PRIMARY KEY ("TWO_REGION_EVENT_ID")
 USING INDEX
 TABLESPACE "INDX"  ENABLE
  ) SEGMENT CREATION IMMEDIATE
 TABLESPACE "TRANSMART" ;

--
-- Type: SEQUENCE; Owner: DEAPP; Name: DE_TWO_REGION_EVENT_SEQ
--
CREATE SEQUENCE  "DEAPP"."DE_TWO_REGION_EVENT_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 NOCACHE  NOORDER  NOCYCLE ;

--
-- Type: TRIGGER; Owner: DEAPP; Name: TRG_TWO_REGION_EVENT_ID
--
  CREATE OR REPLACE TRIGGER "DEAPP"."TRG_TWO_REGION_EVENT_ID" 
before insert on "DEAPP"."DE_TWO_REGION_EVENT"
for each row begin
       	if inserting then
               	if :NEW."TWO_REGION_EVENT_ID" is null then
                       	select DE_TWO_REGION_EVENT_SEQ.nextval into :NEW."TWO_REGION_EVENT_ID" from dual;
               	end if;
       	end if;
end;
/
ALTER TRIGGER "DEAPP"."TRG_TWO_REGION_EVENT_ID" ENABLE;
 
