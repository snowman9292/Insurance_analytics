USE DATABASE Insurance_analytics;
USE SCHEMA STAGING_ZONE;

CREATE TABLE IF NOT EXISTS staging_policy ( 
    Policy_ID STRING, 
    Customer_ID STRING, 
    Product_ID STRING, 
    Policy_Type STRING, 
    Start_Date DATE, 
    End_Date DATE, 
    Policy_Status STRING, 
    Load_DTS TIMESTAMP_NTZ 
); 
