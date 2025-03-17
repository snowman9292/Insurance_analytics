USE DATABASE Insurance_analytics;
USE SCHEMA STAGING_ZONE;

CREATE TABLE staging_product ( 
    Product_ID STRING, 
    Product_Name STRING, 
    Product_Type STRING, 
    Coverage_Type STRING, 
    Premium_Amount NUMBER(12,2), 
    Load_DTS TIMESTAMP_NTZ 
); 
