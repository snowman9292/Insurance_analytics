USE DATABASE Insurance_analytics;
USE SCHEMA INFORMATION_ZONE;

CREATE TABLE  IF NOT EXISTS dim_policy (
    Policy_ID STRING NOT NULL PRIMARY KEY,
    Policy_Type STRING,
    Start_Date DATE,
    End_Date DATE,
    Policy_Status STRING,
    Load_DTS TIMESTAMP
);
