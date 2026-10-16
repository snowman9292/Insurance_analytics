CREATE OR REPLACE VIEW vw_fact_sales AS 
SELECT 
    f.Sale_ID, 
    f.Customer_ID, 
    f.Product_ID, 
    f.Policy_ID, 
    f.Sale_Date, 
    f.Premium_Amount, 
    f.Payment_Status,
    f.Load_DTS
FROM fact_sales f;
