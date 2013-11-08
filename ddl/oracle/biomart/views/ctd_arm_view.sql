--
-- Type: VIEW; Owner: BIOMART; Name: CTD_ARM_VIEW
--
  CREATE OR REPLACE FORCE VIEW "BIOMART"."CTD_ARM_VIEW" ("ID", "REF_ARTICLE_PROTOCOL_ID", "ARM", "ARM_NBR_OF_PATIENTS_STUDIED", "ARM_CLASSIFICATION_TYPE", "ARM_CLASSIFICATION_VALUE", "ARM_ASTHMA_DURATION", "ARM_GEOGRAPHIC_REGION", "ARM_AGE", "ARM_GENDER", "ARM_SMOKERS_PCT", "ARM_FORMER_SMOKERS_PCT", "ARM_NEVER_SMOKERS_PCT", "ARM_PACK_YEARS", "MINORITY_PARTICIPATION", "BASELINE_SYMPTOM_SCORE", "BASELINE_RESCUE_MEDICATION_USE") AS 
  select rownum as ID, v."REF_ARTICLE_PROTOCOL_ID",v."ARM",v."ARM_NBR_OF_PATIENTS_STUDIED",v."ARM_CLASSIFICATION_TYPE",v."ARM_CLASSIFICATION_VALUE",v."ARM_ASTHMA_DURATION",v."ARM_GEOGRAPHIC_REGION",v."ARM_AGE",v."ARM_GENDER",v."ARM_SMOKERS_PCT",v."ARM_FORMER_SMOKERS_PCT",v."ARM_NEVER_SMOKERS_PCT",v."ARM_PACK_YEARS",v."MINORITY_PARTICIPATION",v."BASELINE_SYMPTOM_SCORE",v."BASELINE_RESCUE_MEDICATION_USE"
from 
(
select distinct REF_ARTICLE_PROTOCOL_ID,
			ARM,
			ARM_NBR_OF_PATIENTS_STUDIED,
			ARM_CLASSIFICATION_TYPE,
			ARM_CLASSIFICATION_VALUE,
			ARM_ASTHMA_DURATION,
			ARM_GEOGRAPHIC_REGION,
			ARM_AGE,
			ARM_GENDER,
			ARM_SMOKERS_PCT,
			ARM_FORMER_SMOKERS_PCT,
			ARM_NEVER_SMOKERS_PCT,
			ARM_PACK_YEARS,
			MINORITY_PARTICIPATION,
			BASELINE_SYMPTOM_SCORE,
			BASELINE_RESCUE_MEDICATION_USE
from ctd_full
where ARM is not null
order by REF_ARTICLE_PROTOCOL_ID, ARM, to_number(ARM_NBR_OF_PATIENTS_STUDIED)
) v
 
 
 
 
 
 ;
 