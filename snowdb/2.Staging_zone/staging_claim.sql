USE DATABASE Insurance_analytics;
USE SCHEMA STAGING_ZONE;


CREATE TABLE staging_claim ( 
    Claim_ID STRING, 
    Policy_ID STRING, 
    Claim_Date DATE, 
    Claim_Amount NUMBER(12,2), 
    Claim_Status STRING, 
    Load_DTS TIMESTAMP_NTZ 
); 
