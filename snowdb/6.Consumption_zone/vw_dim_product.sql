CREATE OR REPLACE VIEW vw_dim_product AS 
SELECT DISTINCT 
    p.Product_ID, 
    s.Product_Name, 
    s.Product_Type, 
    s.Coverage_Type, 
    s.Premium_Amount,
    s.Load_DTS
FROM hub_product p
JOIN sat_product s ON p.Product_HK = s.Product_HK;
