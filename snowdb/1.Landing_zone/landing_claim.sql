
USE DATABASE Insurance_analytics;
USE SCHEMA LANDING_ZONE;


CREATE TABLE IF NOT EXISTS landing_claim ( 
    Claim_ID STRING, 
    Policy_ID STRING, 
    Claim_Date DATE, 
    Claim_Amount NUMBER(12,3), 
    Claim_Status STRING, 
    Load_DTS TIMESTAMP_NTZ 
); 
