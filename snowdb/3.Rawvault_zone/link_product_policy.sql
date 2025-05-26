USE DATABASE Insurance_analytics;
USE SCHEMA RAVAULT_ZONE;


CREATE TABLE IF NOT EXISTS link_product_policy (
    Product_HK STRING,
    Policy_HK STRING,
    Load_DTS TIMESTAMP_NTZ,
    PRIMARY KEY (Product_HK, Policy_HK, Load_DTS)
);
