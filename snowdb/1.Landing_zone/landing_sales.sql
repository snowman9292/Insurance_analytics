
USE DATABASE Insurance_analytics;
USE SCHEMA LANDING_ZONE;



CREATE TABLE  IF NOT EXISTS landing_sales ( 
    Sales_ID STRING, 
    Customer_ID STRING, 
    Product_ID STRING, 
    Sales_Channel STRING, 
    Sales_Amount NUMBER(12,2), 
    Load_DTS TIMESTAMP_NTZ 
); 
