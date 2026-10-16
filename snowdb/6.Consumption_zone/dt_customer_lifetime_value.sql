CREATE OR REPLACE DYNAMIC TABLE dt_customer_lifetime_value
TARGET_LAG = '30 minutes'
WAREHOUSE = my_wh
AS 
SELECT 
    c.Customer_ID, 
    SUM(s.Premium_Amount) AS Total_Premium_Paid, 
    COUNT(s.Policy_ID) AS Total_Policies
FROM dim_customer c
JOIN fact_sales s ON c.Customer_ID = s.Customer_ID
GROUP BY c.Customer_ID;
