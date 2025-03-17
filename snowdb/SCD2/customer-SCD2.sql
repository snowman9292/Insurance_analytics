CREATE OR REPLACE STREAM stg_customer_stream 
ON TABLE stg_customer;



MERGE INTO hub_customer h
USING (
    SELECT DISTINCT Customer_ID, 
           HASH(Customer_ID) AS Customer_HK, 
           Load_DTS
    FROM stg_customer_stream
) s
ON h.Customer_HK = s.Customer_HK
WHEN NOT MATCHED THEN 
    INSERT (Customer_HK, Customer_ID, Load_DTS)
    VALUES (s.Customer_HK, s.Customer_ID, s.Load_DTS);


MERGE INTO sat_customer s
USING (
    SELECT Customer_HK, 
           Customer_Name, 
           DOB, 
           Gender, 
           Address, 
           Phone, 
           Email, 
           Load_DTS,
           HASH(Customer_Name, DOB, Gender, Address, Phone, Email) AS Hash_Diff
    FROM stg_customer_stream
) stg
ON s.Customer_HK = stg.Customer_HK 
AND s.Hash_Diff = stg.Hash_Diff -- Check if data has changed
WHEN NOT MATCHED THEN 
    INSERT (Customer_HK, Customer_Name, DOB, Gender, Address, Phone, Email, Hash_Diff, Load_DTS)
    VALUES (stg.Customer_HK, stg.Customer_Name, stg.DOB, stg.Gender, stg.Address, stg.Phone, stg.Email, stg.Hash_Diff, stg.Load_DTS);
