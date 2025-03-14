CREATE TABLE link_product_policy (
    Product_HK STRING,
    Policy_HK STRING,
    Load_DTS TIMESTAMP_NTZ,
    PRIMARY KEY (Product_HK, Policy_HK, Load_DTS)
);
