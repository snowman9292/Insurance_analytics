CREATE OR REPLACE VIEW vw_dim_customer AS 
SELECT DISTINCT 
    c.Customer_ID, 
    s.Customer_Name, 
    s.DOB, 
    s.Gender, 
    s.Address, 
    s.Phone, 
    s.Email,
    s.Load_DTS
FROM hub_customer c
JOIN sat_customer s ON c.Customer_HK = s.Customer_HK;
