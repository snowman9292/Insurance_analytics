USE DATABASE Insurance_analytics;
USE SCHEMA INFORMATION_ZONE;

CREATE TABLE  IF NOT EXISTS  dim_customer (
    Customer_ID STRING NOT NULL PRIMARY KEY,
    Customer_Name STRING,
    DOB DATE,
    Gender STRING,
    Address STRING,
    Phone STRING,
    Email STRING,
    Load_DTS TIMESTAMP
);
