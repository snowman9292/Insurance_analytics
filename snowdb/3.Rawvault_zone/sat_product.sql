CREATE TABLE IF NOT EXISTS sat_product (
    Product_HK STRING,
    Product_Name STRING,
    Product_Type STRING,
    Coverage_Type STRING,
    Premium_Amount NUMBER(12,2),
    Hash_Diff STRING,
    Load_DTS TIMESTAMP_NTZ,
    PRIMARY KEY (Product_HK, Load_DTS)
);
