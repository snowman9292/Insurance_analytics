USE DATABASE Insurance_analytics;
USE SCHEMA RAVAULT_ZONE;


CREATE TABLE   IF NOT EXISTS sat_policy (
    Policy_HK STRING,
    Policy_Type STRING,
    Start_Date DATE,
    End_Date DATE,
    Policy_Status STRING,
    Hash_Diff STRING,
    Load_DTS TIMESTAMP_NTZ,
    PRIMARY KEY (Policy_HK, Load_DTS)
);