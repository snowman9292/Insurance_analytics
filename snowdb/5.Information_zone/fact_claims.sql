USE DATABASE Insurance_analytics;
USE SCHEMA INFORMATION_ZONE;

CREATE TABLE  IF NOT EXISTS  fact_claims (
    Claim_ID STRING NOT NULL PRIMARY KEY,
    Policy_ID STRING NOT NULL,
    Customer_ID STRING NOT NULL,
    Product_ID STRING,
    Claim_Date DATE,
    Claim_Amount DECIMAL(18,2),
    Claim_Status STRING,
    Settlement_Amount DECIMAL(18,2),
    Settlement_Date DATE,
    Load_DTS TIMESTAMP,
    FOREIGN KEY (Policy_ID) REFERENCES dim_policy(Policy_ID),
    FOREIGN KEY (Customer_ID) REFERENCES dim_customer(Customer_ID),
    FOREIGN KEY (Product_ID) REFERENCES dim_product(Product_ID)
);
