USE DATABASE Insurance_analytics;
USE SCHEMA INFORMATION_ZONE;

CREATE TABLE  IF NOT EXISTS  dim_product (
    Product_ID STRING NOT NULL PRIMARY KEY,
    Product_Name STRING,
    Product_Type STRING,
    Coverage_Type STRING,
    Premium_Amount DECIMAL(18,2),
    Load_DTS TIMESTAMP
);
