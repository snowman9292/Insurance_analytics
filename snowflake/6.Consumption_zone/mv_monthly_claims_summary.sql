CREATE OR REPLACE MATERIALIZED VIEW mv_monthly_claims_summary AS 
SELECT 
    DATE_TRUNC('MONTH', c.Claim_Date) AS Claim_Month, 
    p.Policy_Type, 
    COUNT(c.Claim_ID) AS Total_Claims, 
    SUM(c.Claim_Amount) AS Total_Claim_Amount
FROM fact_claims c
JOIN dim_policy p ON c.Policy_ID = p.Policy_ID
GROUP BY 1, 2;
