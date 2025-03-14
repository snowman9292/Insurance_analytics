CREATE OR REPLACE MATERIALIZED VIEW mv_active_policies AS 
SELECT 
    DATE_TRUNC('MONTH', p.Start_Date) AS Policy_Start_Month, 
    COUNT(p.Policy_ID) AS Active_Policies
FROM dim_policy p
WHERE p.Policy_Status = 'Active'
GROUP BY 1;
