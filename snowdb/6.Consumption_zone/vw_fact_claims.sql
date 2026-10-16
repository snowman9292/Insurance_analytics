CREATE OR REPLACE VIEW vw_fact_claims AS 
SELECT 
    f.Claim_ID, 
    f.Policy_ID, 
    f.Customer_ID, 
    f.Product_ID, 
    f.Claim_Date, 
    f.Claim_Amount, 
    f.Claim_Status, 
    f.Load_DTS
FROM fact_claims f;
