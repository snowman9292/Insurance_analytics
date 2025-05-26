USE DATABASE Insurance_analytics;
USE SCHEMA RAVAULT_ZONE;

CREATE TABLE  IF NOT EXISTS sat_customer (
    Customer_HK STRING,
    Customer_Name STRING,
    DOB DATE,
    Gender STRING,
    Address STRING,
    Phone STRING,
    Email STRING,
    Hash_Diff STRING,
    Load_DTS TIMESTAMP_NTZ,
    PRIMARY KEY (Customer_HK, Load_DTS)
);