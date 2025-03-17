CREATE TABLE dim_customer (
    Customer_ID STRING NOT NULL PRIMARY KEY,
    Customer_Name STRING,
    DOB DATE,
    Gender STRING,
    Address STRING,
    Phone STRING,
    Email STRING,
    Load_DTS TIMESTAMP
);
