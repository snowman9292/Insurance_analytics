CREATE TABLE  IF NOT EXISTS sat_sales (
    Sales_HK STRING,
    Sales_Channel STRING,
    Sales_Amount NUMBER(12,2),
    Hash_Diff STRING,
    Load_DTS TIMESTAMP_NTZ,
    PRIMARY KEY (Sales_HK, Load_DTS)
);