CREATE TABLE IF NOT EXISTS link_customer_sales (
    Customer_HK STRING,
    Sales_HK STRING,
    Load_DTS TIMESTAMP_NTZ,
    PRIMARY KEY (Customer_HK, Sales_HK, Load_DTS)
);