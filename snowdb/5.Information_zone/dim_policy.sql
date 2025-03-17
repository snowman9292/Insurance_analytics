CREATE TABLE dim_policy (
    Policy_ID STRING NOT NULL PRIMARY KEY,
    Policy_Type STRING,
    Start_Date DATE,
    End_Date DATE,
    Policy_Status STRING,
    Load_DTS TIMESTAMP
);
