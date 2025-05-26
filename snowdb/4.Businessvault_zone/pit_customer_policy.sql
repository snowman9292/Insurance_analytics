USE DATABASE Insurance_analytics;
USE SCHEMA BUSINESSVAULT_ZONE;

CREATE TABLE IF NOT EXISTS pit_customer_policy (
    Customer_HK STRING NOT NULL,
    Policy_HK STRING NOT NULL,
    Policy_Status STRING,
    Start_Date DATE,
    End_Date DATE,
    Load_DTS TIMESTAMP NOT NULL
);