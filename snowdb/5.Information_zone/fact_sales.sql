CREATE TABLE fact_sales (
    Sales_ID STRING NOT NULL PRIMARY KEY,
    Customer_ID STRING NOT NULL,
    Product_ID STRING NOT NULL,
    Policy_ID STRING,
    Sale_Date DATE,
    Premium_Amount DECIMAL(18,2),
    Sales_Channel STRING,
    Agent_ID STRING,
    Load_DTS TIMESTAMP,
    FOREIGN KEY (Customer_ID) REFERENCES dim_customer(Customer_ID),
    FOREIGN KEY (Product_ID) REFERENCES dim_product(Product_ID),
    FOREIGN KEY (Policy_ID) REFERENCES dim_policy(Policy_ID)
);
