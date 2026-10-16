CREATE OR REPLACE DYNAMIC TABLE dt_active_policies 
TARGET_LAG = '5 minutes'
WAREHOUSE = my_wh 
AS 
SELECT 
    Policy_ID, 
    Policy_Type, 
    Start_Date, 
    End_Date, 
    Policy_Status 
FROM dim_policy 
WHERE Policy_Status = 'Active';
