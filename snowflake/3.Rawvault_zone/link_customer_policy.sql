CREATE TABLE link_customer_policy (
    Customer_HK STRING,
    Policy_HK STRING,
    Load_DTS TIMESTAMP_NTZ,
    PRIMARY KEY (Customer_HK, Policy_HK, Load_DTS)
);
