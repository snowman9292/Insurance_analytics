CREATE OR REPLACE VIEW vw_dim_policy AS 
SELECT DISTINCT 
    p.Policy_ID, 
    s.Policy_Type, 
    s.Start_Date, 
    s.End_Date, 
    s.Policy_Status,
    s.Load_DTS
FROM hub_policy p
JOIN sat_policy s ON p.Policy_HK = s.Policy_HK;
