CREATE OR REPLACE PROCEDURE sp_load_landing_to_staging()
RETURNS INTEGER
LANGUAGE SQL
AS
$$
DECLARE
    landing_staging_c CURSOR FOR
    SELECT LANDING_TABLE,STAGING_TABLE,LANDING_SCHEMA,STAGING_SCHEMA
    FROM INSURANCE_ANALYTICS.LANDING_ZONE.landing_to_staging;
    v_lnd_cnt RESULTSET;
    v_lnd_cnt1 INTEGER;
    landing_cols_cnt INTEGER;
    
    v_stg_cnt RESULTSET;
    v_stg_cnt1 INTEGER;
    staging_cols_cnt INTEGER;
    l_tabLe   STRING;
    l_schema  STRING; 
    
    V_LANDING_TABLE STRING;
    V_STAGING_TABLE STRING;
    V_LANDING_SCHEMA STRING;
    V_STAGING_SCHEMA STRING;
    V_SQL STRING;  
    V_SQL_INSERT STRING;
    V_RESULT STRING;
       
BEGIN
   FOR  REC IN landing_staging_c
    DO
       v_landing_table := REC.LANDING_TABLE;
       v_landing_schema := REC.LANDING_SCHEMA;
       v_staging_table := REC.STAGING_TABLE;
       v_staging_schema := REC.STAGING_SCHEMA; 
       V_SQL:='SELECT  COUNT(COLUMN_NAME) 
        FROM INFORMATION_SCHEMA.COLUMNS 
        WHERE TABLE_NAME=''' ||  :v_landing_table || ''''||
       'AND TABLE_SCHEMA =''' || :v_landing_schema|| ''''  ;  
        v_lnd_cnt:=( EXECUTE IMMEDIATE :V_SQL);
        let c1 cursor for v_lnd_cnt;
        open c1;
        fetch c1 into v_lnd_cnt1;  
        let landing_cols_cnt:=CAST(v_lnd_cnt1 AS INTEGER);
        
         V_SQL:='SELECT  COUNT(COLUMN_NAME) 
        FROM INFORMATION_SCHEMA.COLUMNS 
        WHERE TABLE_NAME=''' ||  :v_staging_table || ''''||
        'AND TABLE_SCHEMA =''' || :v_staging_schema|| ''''  ;  
        v_stg_cnt:=( EXECUTE IMMEDIATE :V_SQL);
        let c2 cursor for v_stg_cnt;
        open c2;
        fetch c2 into v_stg_cnt1;  
        let staging_cols_cnt:=CAST(v_stg_cnt1 AS INTEGER);
        IF (landing_cols_cnT=staging_cols_cnt) THEN
    
        SYSTEM$LOG('info', 'COUNT IS EQUAL FOR '||:v_landing_table||' and               
                  '||:v_staging_table            );
        SYSTEM$LOG('info', 'LOADING DATA  FROM  '||:v_landing_table||' to 
                   '||:v_staging_table            ); 
       V_SQL_INSERT:='INSERT INTO '||:v_staging_schema||'.'|| :v_staging_table||' SELECT * FROM '||:v_landing_schema||'.'||:v_landing_table  ; 
         SYSTEM$LOG('info', V_SQL_INSERT);
         BEGIN 
            EXECUTE IMMEDIATE (V_SQL_INSERT);
            V_RESULT:='iNSERT SUCCESSFULL';
            SYSTEM$LOG('info', V_RESULT);

         EXCEPTION 
            WHEN OTHER THEN 
                V_RESULT:='iNSERT Failed';            
        SYSTEM$LOG('info', V_RESULT);
         END;         
         ELSE 
        SYSTEM$LOG('info', 'COUNT IS NOT EQUAL FOR '||:v_landing_table||' and '||:v_staging_table            );
        --find the difference and alter the table to add new column
        --Then insert the data 

        END IF;    
   END FOR;
   -- RETURN  v_landing_table||'-'||v_lnd_cnt; 

END;
$$;

