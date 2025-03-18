USE DATABASE Insurance_analytics;
USE SCHEMA BUSINESSVAULT_ZONE;

CREATE OR REPLACE VIEW agg_claim_summary AS
SELECT 
    c.Customer_HK,
    COUNT(DISTINCT cl.Claim_HK) AS Total_Claims,
    SUM(cl.Claim_Amount) AS Total_Claim_Amount,
    COUNT(DISTINCT CASE WHEN cl.Claim_Status = 'Approved' THEN cl.Claim_HK END) AS Approved_Claims,
    COUNT(DISTINCT CASE WHEN cl.Claim_Status = 'Rejected' THEN cl.Claim_HK END) AS Rejected_Claims,
    MAX(cl.Load_DTS) AS Last_Claim_Load_DTS
FROM ravault_zone.link_customer_policy cp
JOIN ravault_zone.link_policy_claim pc ON cp.Policy_HK = pc.Policy_HK
JOIN ravault_zone.sat_claim cl ON pc.Claim_HK = cl.Claim_HK
GROUP BY c.Customer_HK;
