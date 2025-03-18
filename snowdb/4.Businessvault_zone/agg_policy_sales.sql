USE DATABASE Insurance_analytics;
USE SCHEMA BUSINESSVAULT_ZONE;

CREATE OR REPLACE VIEW  agg_policy_sales AS
SELECT 
    pr.Product_HK,
    COUNT(DISTINCT po.Policy_HK) AS Total_Policies_Sold,
    SUM(po.Premium_Amount) AS Total_Premium_Collected,
    COUNT(DISTINCT CASE WHEN po.Policy_Status = 'Active' THEN po.Policy_HK END) AS Active_Policies,
    MAX(po.Load_DTS) AS Last_Policy_Load_DTS
FROM rawvault_zone.sat_policy po
JOIN rawvault_zone.link_product_policy pr ON po.Policy_HK = pr.Policy_HK
GROUP BY pr.Product_HK;
