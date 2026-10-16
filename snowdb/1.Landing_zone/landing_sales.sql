CREATE OR REPLACE PROCEDURE sp_load_stage_tables()
RETURNS STRING
LANGUAGE SQL
AS
$$
DECLARE landing_table STRING;
 staging_table STRING;
 sql_stmt STRING;
 cur CURSOR FOR 
    SELECT LANDING_TABLE, STAGING_TABLE FROM TABLE_MAPPING
   -- where landing_table in('LANDING_CUSTOMER')
    ;

BEGIN
    -- Open cursor and fetch values
    FOR rec IN cur DO
        -- Assign values to variables
        landing_table := rec.LANDING_TABLE;
        staging_table := rec.STAGING_TABLE;

        -- Construct the dynamic SQL statement
        sql_stmt := 'INSERT INTO STAGING_ZONE.' || staging_table || 
                    ' SELECT * FROM LANDING_ZONE.' || landing_table;

        -- Debugging: Print the SQL statement before execution
        --RETURN 'Executing SQL: ' || sql_stmt;

        -- Execute the dynamic SQL statement
        EXECUTE IMMEDIATE sql_stmt;
    END FOR;

    RETURN 'Data loaded successfully for all mapped tables!';
END;
$$;
