CREATE OR REPLACE DYNAMIC TABLE dt_monthly_claims_summary
TARGET_LAG = '1 hour'
WAREHOUSE = my_wh
AS 
SELECT 
    DATE_TRUNC('MONTH', c.Claim_Date) AS Claim_Month, 
    COUNT(c.Claim_ID) AS Total_Claims, 
    SUM(c.Claim_Amount) AS Total_Claim_Amount
FROM fact_claims c
GROUP BY 1;
