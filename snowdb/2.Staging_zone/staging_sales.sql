USE DATABASE Insurance_analytics;
USE SCHEMA STAGING_ZONE;
CREATE TABLE staging_sales ( 
    Sales_ID STRING, 
    Customer_ID STRING, 
    Product_ID STRING, 
    Sales_Channel STRING, 
    Sales_Amount NUMBER(12,2), 
    Load_DTS TIMESTAMP_NTZ 
); 
