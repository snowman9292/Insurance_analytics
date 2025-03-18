USE DATABASE Insurance_analytics;
USE SCHEMA STAGING_ZONE; 

CREATE TABLE IF NOT EXISTS staging_customer (    Customer_ID STRING, 
    Customer_Name STRING, 
    DOB DATE, 
    Gender STRING, 
    Address STRING, 
    Phone STRING, 
    Email STRING, 
    Load_DTS TIMESTAMP_NTZ 
);